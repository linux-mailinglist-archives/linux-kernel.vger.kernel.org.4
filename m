Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7625D69D586
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 22:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjBTVKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 16:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjBTVKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 16:10:31 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FD21C7D3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 13:10:30 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B76611EC0513;
        Mon, 20 Feb 2023 22:10:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676927428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iMsnv8ol6LqVov+pPDOx7XODkmuXEYKWBO1couQq79M=;
        b=qJehvKIw5eQISCpcgwrA+76Ru9VNrKZhH/oPo7rQNxSsT28JG92Zl9eSgOgjc947+bpjHe
        lPL7YLY14K6kZHEzkqEP5gj0Cg87Q0l/bZgxIju6y8QR3tgNW8wgOfxnV7cHoZvwjRAjSw
        Y+zJJ0+rP/R8vOWvPGthVdhPzvRdj0E=
Date:   Mon, 20 Feb 2023 22:10:28 +0100
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
Message-ID: <Y/PhxDIVsa4WU5gu@zn.tnic>
References: <20230220120127.1975241-1-kpsingh@kernel.org>
 <20230220121350.aidsipw3kd4rsyss@treble>
 <CACYkzJ5L9MLuE5Jz+z5-NJCCrUqTbgKQkXSqnQnCfTD_WNA7_Q@mail.gmail.com>
 <CACYkzJ6n=-tobhX0ONQhjHSgmnNjWnNe_dZnEOGtD8Y6S3RHbA@mail.gmail.com>
 <Y/OETPFTJbGtCADM@zn.tnic>
 <3a65d18f-b218-60e7-4748-f1609eb76fd5@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a65d18f-b218-60e7-4748-f1609eb76fd5@citrix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 07:57:25PM +0000, Andrew Cooper wrote:
> "When IBRS or enhanced IBRS is enabled, STIBP is not needed."
> 
> This is misleading, if not strictly wrong.  The IBRS bit being set
> implies STIBP, which reads differently to "not needed".
> 
> 
> Now - eIBRS is "set once at start of day" which ends up becoming a
> global implicit STIBP.

Right.

> I think we're discussing the legacy IBRS case here.  i.e. what was
> retrofitted in microcode for existing parts?

Any IBRS actually. The one which is *not* the automatic, fire'n'forget
thing.

> The reason why it is "write 1 on each privilege increase, 0 on privilege
> decrease" is because on some CPUs its an inhibit control, and on some
> CPUs is a flush (i.e. its actually IBPB).
> 
> But these same CPUs don't actually have an ability to thread-tag the
> indirect predictor nicely so STIBP is also horribly expensive under the
> hood - so much so that we were firmly recommended to clear STIBP/IBRS
> when going idle so as to reduce the impact on the sibling.

Yap, we do that. And we do the write to 0 for IBRS on exit to
luserspace, probably for very similar reasons.

> IMO the proper way to do this is to set STIBP uniformly depending on
> whether you want it in userspace or not, and treat it logically
> separately to IBRS.  It doesn't hurt (any more) to have both bits set.

So we have this thing:

        /*
         * If no STIBP, IBRS or enhanced IBRS is enabled, or SMT impossible,
         * STIBP is not required.
         */
        if (!boot_cpu_has(X86_FEATURE_STIBP) ||
            !smt_possible ||
            spectre_v2_in_ibrs_mode(spectre_v2_enabled))
                return;

What you propose sounds cleaner but would definitely need more massaging
of this madness code. So I guess we could do only the
enable-STIBP-when-IBRS-enabled thing first and do more cleanups later.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
