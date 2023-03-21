Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3966C2F08
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 11:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjCUKci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 06:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjCUKcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 06:32:33 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9751B337
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 03:31:51 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8D0901EC0373;
        Tue, 21 Mar 2023 11:31:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679394663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Bzkobx7d/Z8nlCfKl8NGmq6rk0y5qHtJxs9ObaxEaZY=;
        b=D1uwvlyFtbtfaZ0a8hVThiJgQ4/9WLLZQdgLl3TmzflqExLiYEeGd6sAbU20OM/4nMCWQx
        mXkMS/BhxXP3e08v/6WKyZjuKjofkfe+zj9VNTLeDGFGv7FtHNYX+gUxg0hh7yv3ybvXbE
        eS1AJhI4y4YoMVWu3A8ZSDD4esjo9Mc=
Date:   Tue, 21 Mar 2023 11:30:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 03/12] x86/mtrr: support setting MTRR state for
 software defined MTRRs
Message-ID: <20230321103058.GAZBmHYmhs4s7J+giU@fat_crate.local>
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-4-jgross@suse.com>
 <20230320190543.GFZBiuh2lImP8LEW3D@fat_crate.local>
 <01ec6ce2-7639-2e4f-3433-c77c29fa7984@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01ec6ce2-7639-2e4f-3433-c77c29fa7984@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 07:00:58AM +0100, Juergen Gross wrote:
> I guess you are asking because the next test seems to catch the same case?
> 
> I think it doesn't, e.g. for the case of unknown hypervisors (which shows that
> X86_HYPER_NATIVE in theory should be named X86_HYPER_NATIVE_OR_UNKNOWN, or it
> should be split into X86_HYPER_NATIVE and X86_HYPER_UNKNOWN).

Yeah, we don't care about unknown hypervisors. They'll crash'n'burn
anyway.

My intent is to have every case properly documented with a comment above it
instead of one huge compound conditional.

> It basically doesn't matter.

It doesn't matter now. Until someone decides to "redefine" how MTRRs
should be done again because the next representative from the virt zoo
decided to do magic pink ponies.

I'm not taking any chances anymore judging by the amount of crap that
gets sent into arch/x86/ to support some weird guest contraption.

> The only possibility of mtrr_state.enabled to be set at this point is a
> previous call of mtrr_overwrite_state().

Sure, pls make it explicit and defensive so that it is perfectly clear
what's going on.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
