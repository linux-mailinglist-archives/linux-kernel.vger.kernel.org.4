Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFD75BF608
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIUGDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiIUGDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:03:05 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3659A5AC5E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:03:03 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id m16so2599607iln.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=sOA+/TKyOIxErphM8ulICJKXcjYIe3Hnn+mK8Vn1QTM=;
        b=oLVCAIE0kI6LAeFqewe/GIlHsASV142Awdg1+e71ZG84q8Ma76uAIJvH/MEwFLRfFa
         iGSksuK0U3DQU0eb6JX0VwDQlgwebwCoPTu9HzT/rewK7/EK2csGVlB6MGoKakc3mpV1
         dPFjIWM89c9ry42h771FIhOkGDovVrNKmsIK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sOA+/TKyOIxErphM8ulICJKXcjYIe3Hnn+mK8Vn1QTM=;
        b=e1dp/wi88dpdFqHgIEJ+V/aq0oz/X6DAE67kuUC0aCBJrkLaPjeXJuBb4DonS1VbAm
         63rX4ZcVlaC0tasI9QsktOx7YLKaTv6PIXCTqXtQD2QNJm8tD8KPtJ0XF2hfESc17XQp
         B1oykOEPrnAjFR3z3KaziJtnSuEoT0MAr186YC6k/NLn6sQYtIXOsfvZHXt1Ykpek6vt
         8NprQjJtRDvMbZsSL+SA7qXEpcwhGxGMEOgseKJ6HYuDAuP6BZZxKwDAS/7br9+RnieB
         yBILQn6R5L/rI5P4987gRg8NlJFmBozOnmHjsJ/c9S5JK1iphmqCS0aUWx/EmGruAsZ6
         uNQQ==
X-Gm-Message-State: ACrzQf1ZodbaCNhoQKTG82YRdGPuQBnE1XP7XNHdec/cUuhjvlt6fVkY
        rsT9xEWjtr5FWJ1AGWRbOz1U8JAu+uhT7ARfutDGRQ==
X-Google-Smtp-Source: AMsMyM72Uvd/+DyXlH3OoMGGh3CieEQrwrdTmZ9CZcO59IYmsDVk3q5CWFMYa/8qCcALFckXM8rJ41Y2C/851tvaA7g=
X-Received: by 2002:a05:6e02:1a48:b0:2f3:2e91:b78 with SMTP id
 u8-20020a056e021a4800b002f32e910b78mr11808724ilv.96.1663740182612; Tue, 20
 Sep 2022 23:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220920082005.2459826-1-denik@chromium.org> <877d1yl797.wl-maz@kernel.org>
 <CAOYpmdHMbDdssEJJwXktEj1SDLncHTeL7x7aKxVe6j1vzSMgtw@mail.gmail.com>
In-Reply-To: <CAOYpmdHMbDdssEJJwXktEj1SDLncHTeL7x7aKxVe6j1vzSMgtw@mail.gmail.com>
From:   Denis Nikitin <denik@chromium.org>
Date:   Tue, 20 Sep 2022 23:02:50 -0700
Message-ID: <CADDJ8CW5MV3vUPdm4iwjwS4VyeV9rCAMZZpJbNFtNLFD-wThVA@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: nvhe: Disable profile optimization
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Denis Nikitin <denik@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a few more comments...

On Tue, Sep 20, 2022 at 5:08 PM Denis Nikitin <denik@google.com> wrote:
>
> Hi Mark,
>
> Thank you for a quick response.
>
> On Tue, Sep 20, 2022 at 2:34 AM Marc Zyngier <maz@kernel.org> wrote:
> >
> > Hi Denis,
> >
> > On Tue, 20 Sep 2022 09:20:05 +0100,
> > Denis Nikitin <denik@chromium.org> wrote:
> > >
> > > Kernel build with -fprofile-sample-use raises the following failure:
> > >
> > > error: arch/arm64/kvm/hyp/nvhe/kvm_nvhe.tmp.o: Unexpected SHT_REL
> > > section ".rel.llvm.call-graph-profile"
> >
> > How is this flag provided? I don't see any occurrence of it in the
> > kernel so far.
>
> On ChromeOS we build the kernel with sample profiles by adding
> -fprofile-sample-use=/path/to/gcov.profile to KCFLAGS.
>
> >
> > >
> > > SHT_REL is generated by the latest lld, see
> > > https://reviews.llvm.org/rGca3bdb57fa1ac98b711a735de048c12b5fdd8086.
> >
> > Is this part of a released toolchain? If so, can you spell out the
> > first version where this occurs?
>
> Yes, it was added in llvm-13. I will update the patch.
>
> >
> > > Disable profile optimization in kvm/nvhe to fix the build with
> > > AutoFDO.
> >
> > It'd be good to at least mention how AutoFDO and -fprofile-sample-use
> > relate to each other.
>
> Good point. AutoFDO is an example of sample profiles.
> It's not actually relevant for the bug. I will better remove it.
>
> >
> > >
> > > Signed-off-by: Denis Nikitin <denik@chromium.org>
> > > ---
> > >  arch/arm64/kvm/hyp/nvhe/Makefile | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
> > > index b5c5119c7396..6a6188374a52 100644
> > > --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> > > +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> > > @@ -89,6 +89,9 @@ quiet_cmd_hypcopy = HYPCOPY $@
> > >  # Remove ftrace, Shadow Call Stack, and CFI CFLAGS.
> > >  # This is equivalent to the 'notrace', '__noscs', and '__nocfi' annotations.
> > >  KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_CFI), $(KBUILD_CFLAGS))
> > > +# Profile optimization creates SHT_REL section '.llvm.call-graph-profile' for
> > > +# the hot code. SHT_REL is currently not supported by the KVM tools.
> >
> > 'KVM tools' seems vague. Maybe call out the actual helper that
> > processes the relocations?
>
> Agreed.
>
> >
> > > +KBUILD_CFLAGS += $(call cc-option,-fno-profile-sample-use,-fno-profile-use)
> >
> > Why adding these options instead of filtering out the offending option
> > as it is done just above?
>
> That was actually the alternative solution and it worked as well.
> Let me double check if profile optimization doesn't mess up with other
> sections and if it doesn't I will remove the '.llvm.call-graph-profile'
> section instead.

When I remove the '.llvm.call-graph-profile' section the layout of other
sections slightly changes (offsets and sizes) compared to
`-fno-profile-sample-use`. But the list of sections remains the same.

>
> >
> > Also, is this the only place the kernel fails to compile? The EFI stub
> > does similar things AFAIR, and could potentially fail the same way.
>
> This was the only place in 5.15 where we tested it.
> Let me see if EFI has this section.

EFI code is not marked as hot in the profile.

Regarding "could potentially fail", I don't see any explicit manipulations
with code sections in EFI.
The hardcoded EFI stub entries should not be affected.

>
> >
> > Thanks,
> >
> >         M.
> >
> > --
> > Without deviation from the norm, progress is not possible.
>
> Thanks,
> Denis

- Denis
