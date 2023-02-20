Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1317C69D6E6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 00:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjBTXCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 18:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjBTXCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 18:02:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90A0CDD6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 15:02:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EF2560F43
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57CCC433A0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676934120;
        bh=lmBpu8YRlK5vRJQ57boJKHTzS7qNAHUxjGLladFUnqA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rrBNJ5O4BhJa5zHmD0eYphT2aCBug6gC8QfrspqBfhcnxNmCfxZKKnWDPFNPLiQyV
         JZyNQt9BbSsbm+2hQMpEaoMsUmIaHSVJ+pSb9Sh1KAoTyLwqqQQbY6rARUcfJqPzlU
         Wdtl6fAOxhODzvt/zxrRGJMbYlK+hpgBHwuCZ1+eRzbtzUh4RN9Q+rqZxzAKiMYXrj
         JJH5fqyT9cf1xlcp0f0nh2oOtNsP7II7K3Mffx6kRQjfqbkttMnuJpdH3x/4dTQ98a
         aqw85N8kgF+eEJvQrauBKc8fPQD5S/Oy1pvOkTJSQt6dKfyusCz9HZIAoufwCAh8+w
         BLGYRqa4lnaCg==
Received: by mail-ed1-f42.google.com with SMTP id h16so10394113edz.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 15:02:00 -0800 (PST)
X-Gm-Message-State: AO0yUKVKTlSJyq0BYiwW3VbafIqO98SVeZMqs6oblBxDTwVEn2q0t1na
        iM2iBEet92qfWxdHutIriAIh6n2ORsZrsbD4qTrlDA==
X-Google-Smtp-Source: AK7set9C6O+owPfdeylmUnOdhb+tf7qc+WkYwCECxKA4JkYg7to4tRPqtl/RvgA3QMw6cjDCfko1dyxm6WUPaz5jE5A=
X-Received: by 2002:a17:906:9499:b0:8b1:79ef:6923 with SMTP id
 t25-20020a170906949900b008b179ef6923mr5935263ejx.15.1676934119084; Mon, 20
 Feb 2023 15:01:59 -0800 (PST)
MIME-Version: 1.0
References: <20230220120127.1975241-1-kpsingh@kernel.org> <20230220121350.aidsipw3kd4rsyss@treble>
 <CACYkzJ5L9MLuE5Jz+z5-NJCCrUqTbgKQkXSqnQnCfTD_WNA7_Q@mail.gmail.com>
 <CACYkzJ6n=-tobhX0ONQhjHSgmnNjWnNe_dZnEOGtD8Y6S3RHbA@mail.gmail.com>
 <Y/OETPFTJbGtCADM@zn.tnic> <3a65d18f-b218-60e7-4748-f1609eb76fd5@citrix.com> <Y/PhxDIVsa4WU5gu@zn.tnic>
In-Reply-To: <Y/PhxDIVsa4WU5gu@zn.tnic>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 20 Feb 2023 15:01:47 -0800
X-Gmail-Original-Message-ID: <CACYkzJ6K77T8aFNC0oxcq8-huGZSX8spLpvNDiJQbyYsx5HwNg@mail.gmail.com>
Message-ID: <CACYkzJ6K77T8aFNC0oxcq8-huGZSX8spLpvNDiJQbyYsx5HwNg@mail.gmail.com>
Subject: Re: [PATCH RESEND] x86/speculation: Fix user-mode spectre-v2
 protection with KERNEL_IBRS
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, pjt@google.com, evn@google.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, peterz@infradead.org,
        pawan.kumar.gupta@linux.intel.com, kim.phillips@amd.com,
        alexandre.chartre@oracle.com, daniel.sneddon@linux.intel.com,
        =?UTF-8?Q?Jos=C3=A9_Oliveira?= <joseloliveira11@gmail.com>,
        Rodrigo Branco <rodrigo@kernelhacking.com>,
        Alexandra Sandulescu <aesa@google.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 1:10 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Feb 20, 2023 at 07:57:25PM +0000, Andrew Cooper wrote:
> > "When IBRS or enhanced IBRS is enabled, STIBP is not needed."
> >
> > This is misleading, if not strictly wrong.  The IBRS bit being set
> > implies STIBP, which reads differently to "not needed".
> >
> >
> > Now - eIBRS is "set once at start of day" which ends up becoming a
> > global implicit STIBP.
>
> Right.
>
> > I think we're discussing the legacy IBRS case here.  i.e. what was
> > retrofitted in microcode for existing parts?
>
> Any IBRS actually. The one which is *not* the automatic, fire'n'forget
> thing.
>
> > The reason why it is "write 1 on each privilege increase, 0 on privilege
> > decrease" is because on some CPUs its an inhibit control, and on some
> > CPUs is a flush (i.e. its actually IBPB).
> >
> > But these same CPUs don't actually have an ability to thread-tag the
> > indirect predictor nicely so STIBP is also horribly expensive under the
> > hood - so much so that we were firmly recommended to clear STIBP/IBRS
> > when going idle so as to reduce the impact on the sibling.
>
> Yap, we do that. And we do the write to 0 for IBRS on exit to
> luserspace, probably for very similar reasons.
>
> > IMO the proper way to do this is to set STIBP uniformly depending on
> > whether you want it in userspace or not, and treat it logically
> > separately to IBRS.  It doesn't hurt (any more) to have both bits set.
>
> So we have this thing:
>
>         /*
>          * If no STIBP, IBRS or enhanced IBRS is enabled, or SMT impossible,
>          * STIBP is not required.
>          */
>         if (!boot_cpu_has(X86_FEATURE_STIBP) ||
>             !smt_possible ||
>             spectre_v2_in_ibrs_mode(spectre_v2_enabled))
>                 return;
>
> What you propose sounds cleaner but would definitely need more massaging
> of this madness code. So I guess we could do only the
> enable-STIBP-when-IBRS-enabled thing first and do more cleanups later.
>

I do like the idea of decoupling, but yeah this is a bit tangled and
abstracted away from the user. The user currently just selects one of
(note the absence of STIBP in the choices here).

SPECTRE_V2_USER_CMD_NONE,
SPECTRE_V2_USER_CMD_AUTO,
SPECTRE_V2_USER_CMD_FORCE,
SPECTRE_V2_USER_CMD_PRCTL,
SPECTRE_V2_USER_CMD_PRCTL_IBPB,
SPECTRE_V2_USER_CMD_SECCOMP,
SPECTRE_V2_USER_CMD_SECCOMP_IBPB,

and the STIBP mode is selected implicitly based on the kernel's choice
of spectre v2 mitigations. I will fix the default case and we can
eventually decouple STIBP from the v2 kernel mitigation choice.

> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
