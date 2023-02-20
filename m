Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46DF69CF73
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjBTObt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjBTObr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:31:47 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59B210AB2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 06:31:46 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7C2CE1EC0513;
        Mon, 20 Feb 2023 15:31:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676903504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5J3o5R3PqQB6KLMaHxk4Qt6yDcsmQmr+P6dBgnSv7qo=;
        b=hwxpXQXpZVQWHTll6aTwAtTMYkTwbvjnMsKETCTussZX3oRxYIhao65ZRg+2nliGQ5uxiH
        abbfHO8gNK2IQs8niiULEoVKsKHrLFwLi09O/L5Wlt6PmKwpXLF1QcRavu8q6meaMKNcRU
        XEAiu+30cJ9+12obPYjRAG5emKnUqbE=
Date:   Mon, 20 Feb 2023 15:31:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     KP Singh <kpsingh@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org,
        pjt@google.com, evn@google.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, peterz@infradead.org,
        pawan.kumar.gupta@linux.intel.com, kim.phillips@amd.com,
        alexandre.chartre@oracle.com, daniel.sneddon@linux.intel.com,
        =?utf-8?B?Sm9zw6k=?= Oliveira <joseloliveira11@gmail.com>,
        Rodrigo Branco <rodrigo@kernelhacking.com>,
        Alexandra Sandulescu <aesa@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH RESEND] x86/speculation: Fix user-mode spectre-v2
 protection with KERNEL_IBRS
Message-ID: <Y/OETPFTJbGtCADM@zn.tnic>
References: <20230220120127.1975241-1-kpsingh@kernel.org>
 <20230220121350.aidsipw3kd4rsyss@treble>
 <CACYkzJ5L9MLuE5Jz+z5-NJCCrUqTbgKQkXSqnQnCfTD_WNA7_Q@mail.gmail.com>
 <CACYkzJ6n=-tobhX0ONQhjHSgmnNjWnNe_dZnEOGtD8Y6S3RHbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACYkzJ6n=-tobhX0ONQhjHSgmnNjWnNe_dZnEOGtD8Y6S3RHbA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop stable@.

On Mon, Feb 20, 2023 at 04:34:02AM -0800, KP Singh wrote:
> > > On Mon, Feb 20, 2023 at 01:01:27PM +0100, KP Singh wrote:
> > > > +static inline bool spectre_v2_user_no_stibp(enum spectre_v2_mitigation mode)
> > > > +{
> > > > +     /* When IBRS or enhanced IBRS is enabled, STIBP is not needed.
> > > > +      *
> > > > +      * However, With KERNEL_IBRS, the IBRS bit is cleared on return
> > > > +      * to user and the user-mode code needs to be able to enable protection
> > > > +      * from cross-thread training, either by always enabling STIBP or
> > > > +      * by enabling it via prctl.
> > > > +      */
> > > > +     return (spectre_v2_in_ibrs_mode(mode) &&
> > > > +             !cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS));
> > > > +}
> > >
> > > The comments and code confused me, they both seem to imply some
> > > distinction between IBRS and KERNEL_IBRS, but in the kernel those are
> > > functionally the same thing.  e.g., the kernel doesn't have a user IBRS
> > > mode.
> > >
> > > And, unless I'm missing some subtlety here, it seems to be a convoluted
> > > way of saying that eIBRS doesn't need STIBP in user space.
> 
> Actually, there is a subtlety, STIBP is not needed in IBRS and eIBRS
> however, with KERNEL_IBRS we only enable IBRS (by setting and
> unsetting the IBRS bit of SPEC_CTL) in the kernel context and this is
> why we need to allow STIBP in userspace. If it were for pure IBRS, we
> would not need it either (based on my reading). Now, with
> spectre_v2_in_ibrs_mode, as per the current implementation implies
> that KERNEL_IBRS is chosen, but this may change. Also, I would also
> prefer to have it more readable in the sense that:
> 
> "If the kernel decides to write 0 to the IBRS bit on returning to the
> user, STIBP needs to to be allowed in user space"

From:

https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/indirect-branch-restricted-speculation.html

"If IA32_SPEC_CTRL.IBRS is already 1 before a transition to a more
privileged predictor mode, some processors may allow the predicted
targets of indirect branches executed in that predictor mode to be
controlled by software that executed before the transition. Software can
avoid this by using WRMSR on the IA32_SPEC_CTRL MSR to set the IBRS bit
to 1 after any such transition, regardless of the bit’s previous value.
It is not necessary to clear the bit first; writing it with a value of
1 after the transition suffices, regardless of the bit’s original
value."

I'd love it if we could simplify our code by not caring of the IBRS bit
when returning to user but I'm afraid that it ain't that simple.

This above probably wants to say that you need to write 1 on CPL change
because it has a flushing behavior of killing user prediction entries.

Lemme add Andy and dhansen for clarification.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
