Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A7F709AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 17:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjESPD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 11:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjESPD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 11:03:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494F6121
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 08:03:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684508604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=33LUfnvcBk5FJKdYxdHSvEMGUXklwU9JErgqA7bqDJ8=;
        b=BULDGCz+pHDYEffJS7qJztU2tfavRGbe3pvfFYMm3MrdqhTqpfs2TOFO38tn6qcymA+p5C
        1Ja36SbVAISU5Q+HjRN3EIGwpIwvMroO37uLoUUcEPnWcuKvpVBXravxxVc5hDoFSfc5MK
        FxVLTA7eSOuXBIQuWqS5KmgFuJfmKSiFritnDKcOab5kmWThqpHCeOsnOPylviJchMZdXm
        18u1Vwe/HoCV9Jgd7kUMh1voW9YPZpMe1dUXnwO/3FaSDVmJgT5D857yqj9/517FHBV+E9
        GO2m9z9xJmsYkK8x5Tqx61M3VWNqYlHnIT9XU/O/Kb0X22k4c1zvd7GdgBsKBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684508604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=33LUfnvcBk5FJKdYxdHSvEMGUXklwU9JErgqA7bqDJ8=;
        b=bEJ0YDdfhjKEuNxmuJSTb7dtJlosFCgokxKWlbJE08kxOa98ydSQ6tJ0YqOmxhj1v/U8xB
        +S9Q5rry41cK+WCg==
To:     Adamos Ttofari <attofari@amazon.de>, chang.seok.bae@intel.com
Cc:     attofari@amazon.de, abusse@amazon.de,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Kyle Huey <me@kylehuey.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86: fpu: Keep xfd_state always in sync with
 MSR_IA32_XFD
In-Reply-To: <20230519112315.30616-1-attofari@amazon.de>
References: <87y1ltbtkh.ffs@tglx> <20230519112315.30616-1-attofari@amazon.de>
Date:   Fri, 19 May 2023 17:03:23 +0200
Message-ID: <87ilco4b44.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19 2023 at 11:23, Adamos Ttofari wrote:
> Commit 672365477ae8 ("x86/fpu: Update XFD state where required") and
> commit 8bf26758ca96 ("x86/fpu: Add XFD state to fpstate") introduced a
> per CPU variable xfd_state to keep the MSR_IA32_XFD value cached. In
> order to avoid unnecessary writes to the MSR.
>
> On CPU hotplug MSR_IA32_XFD is reset to the init_fpstate.xfd, which
> wipes out any stale state. But the per CPU cached xfd value is not
> reset, which brings them out of sync.
>
> As a consequence a subsequent xfd_update_state() might fail to update
> the MSR which in turn can result in XRSTOR raising a #NM in kernel
> space, which crashes the kernel.
>
> To address the issue mentioned, initialize xfd_state together with
> MSR_IA32_XFD.
>
> Fixes: 672365477ae8 ("x86/fpu: Update XFD state where required")
>
> Signed-off-by: Adamos Ttofari <attofari@amazon.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
