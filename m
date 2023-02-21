Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B4A69DE54
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 11:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjBUK70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 05:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjBUK7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:59:24 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11D223309
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 02:59:20 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7ACF61EC059E;
        Tue, 21 Feb 2023 11:59:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676977159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TavcRcl/kRTKeC9VXC4W9v7RpEpVVdkhjkzjnC+VOuI=;
        b=km7g8je+G8/wJmsgdvwB5brAZ6LJG3WAXz+Pwjwln0ku+mpMVrGfv+hZ5uZ+HzgbhNcsAG
        xp0eGZIAWpgQY+3gozkIgZ5APLXVuPBStWeP6OqpJc96wRS6wF8grOxI/NNdVLNcTUy66+
        1AUSfFNtQOiux7tyUZdijvpabQ87Q88=
Date:   Tue, 21 Feb 2023 11:59:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     KP Singh <kpsingh@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, pjt@google.com, evn@google.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
        pawan.kumar.gupta@linux.intel.com, kim.phillips@amd.com,
        alexandre.chartre@oracle.com, daniel.sneddon@linux.intel.com,
        =?utf-8?B?Sm9zw6k=?= Oliveira <joseloliveira11@gmail.com>,
        Rodrigo Branco <rodrigo@kernelhacking.com>,
        Alexandra Sandulescu <aesa@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH RESEND] x86/speculation: Fix user-mode spectre-v2
 protection with KERNEL_IBRS
Message-ID: <Y/SkAqvl8YCZXAnB@zn.tnic>
References: <20230220120127.1975241-1-kpsingh@kernel.org>
 <20230220121350.aidsipw3kd4rsyss@treble>
 <CACYkzJ5L9MLuE5Jz+z5-NJCCrUqTbgKQkXSqnQnCfTD_WNA7_Q@mail.gmail.com>
 <CACYkzJ6n=-tobhX0ONQhjHSgmnNjWnNe_dZnEOGtD8Y6S3RHbA@mail.gmail.com>
 <Y/OETPFTJbGtCADM@zn.tnic>
 <3a65d18f-b218-60e7-4748-f1609eb76fd5@citrix.com>
 <Y/PhxDIVsa4WU5gu@zn.tnic>
 <50231372-2d6d-e4af-be88-5fe45e0c210d@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50231372-2d6d-e4af-be88-5fe45e0c210d@citrix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 11:30:46PM +0000, Andrew Cooper wrote:
> 1) Intel's legacy IBRS
> 2) AMD's regular IBRS

Yeah, we don't do that in the kernel.

> 3) AMD's AutoIBRS
> 
> which all have different relevant behaviours for userspace.  Just so
> it's written out coherently in at least one place...
> 
> When SEV-SNP is enabled in firmware, whether or not it's being used by
> software, AutoIBRS keeps indirect predictions inhibited in all of
> ASID0.  That's all host userspace to the non-hypervisor devs reading
> this thread.

Yap.

> For any AMD configuration setting STIBP, there must be an IBPB after
> having set STIBP.   Setting STIBP alone does not evict previously
> created shared predictions.  This one can go subtly wrong for anyone who
> assumes that Intel STIBP and AMD STIBP have the same behaviour.

We will IBPB eventually... on the next context switch.

> Furthermore, extra care needs taking on vmexit because transitioning
> from the guest STIBP setting to the host STIBP setting can leave shared
> predictions intact.

From what I can tell from looking at the SVM code, we don't do anything
special there when restoring SPEC_CTRL.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
