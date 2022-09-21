Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35B45BF1B8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 02:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiIUAIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 20:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiIUAI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 20:08:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DF66113E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:08:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t3so4024556ply.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=P+2TPNWdXXOCWAvqTb/n3Y3lh5Lh38PVwp86QKZPW/U=;
        b=l79CvKW56MUCcXospEUz9HzLbq84Cfb4nvfiZqwlGWLuDvqwo4gFUQugO1KgXZ9Feg
         F5QakQ/sjeAhCMC9RQW4hR6FDddJHvpXKeOgn212CjqVjQ8lXWaQka6F+KDFmCtzUUFp
         886SmNU7eIDMwzOpAT29RFKvf+9dHNdY++bxzgSoE325sin8U4JmiBfqbOLUOgsuN+IB
         r5UKnDBMDxzngTWqQF8pu8lKhOXBWgwmc0yJdTx9JnyvITwzRwBJ0eYao/RNdCt6Xi5y
         jiathpY5irAfSmUkcV7YbeQT23gXpZ35jag3sLF87/vV36PSAfyOFfr0EVFCrePSB/vu
         7WFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=P+2TPNWdXXOCWAvqTb/n3Y3lh5Lh38PVwp86QKZPW/U=;
        b=aLTgN7P7MSyMvOcIHj4d5/PzDsTdRkI68z1hTQzZ37AR4VoxSmQ9g8Z6u7X244Tn8L
         1kCYXvVA9jPyTPGutkIVgZVtkxEdGYs2wTW+X98zl2Dv0aX8OfMsTDaJfPJXMJDjCwt7
         T3GolObuBdmpZaSBPhd6HYW5E5pZsAWNNRmgYKKq8XqRBFUhC6exjczG/Jfn9bfFFZtO
         2NMv0YNBmh+OoYeJcmTZrNNfsnXlk2bQzsbbOYMZPqV1fgYCkYx+NjAeesutAx+E27Si
         7AySKAZc4f0sJMwxWLje2n0RuNh7YK0PPmjnQ5zQG7qlMKlsfHTgJ7HU16VAdHKNBI5W
         BPEw==
X-Gm-Message-State: ACrzQf25V0shKCAdOTFxqKekUd/Ht25POUdVXkAo+0w2v+GbJTuuxqi9
        1xV+MXKCZV2tPS3eTaW6HArMylAItKls4TrDGQyatA==
X-Google-Smtp-Source: AMsMyM7Hq+eK82DO64bRlQggpPM3rRQhxkz+7K4Da9DMNHl9amBFdTiPYROgJVmKyMQhJXyZ+2seMh8dbNV5Qz4qacQ=
X-Received: by 2002:a17:902:d2c4:b0:178:32c4:6648 with SMTP id
 n4-20020a170902d2c400b0017832c46648mr2115146plc.88.1663718905205; Tue, 20 Sep
 2022 17:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220920082005.2459826-1-denik@chromium.org> <877d1yl797.wl-maz@kernel.org>
In-Reply-To: <877d1yl797.wl-maz@kernel.org>
From:   Denis Nikitin <denik@google.com>
Date:   Tue, 20 Sep 2022 17:08:09 -0700
Message-ID: <CAOYpmdHMbDdssEJJwXktEj1SDLncHTeL7x7aKxVe6j1vzSMgtw@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: nvhe: Disable profile optimization
To:     Marc Zyngier <maz@kernel.org>
Cc:     Denis Nikitin <denik@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thank you for a quick response.

On Tue, Sep 20, 2022 at 2:34 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Denis,
>
> On Tue, 20 Sep 2022 09:20:05 +0100,
> Denis Nikitin <denik@chromium.org> wrote:
> >
> > Kernel build with -fprofile-sample-use raises the following failure:
> >
> > error: arch/arm64/kvm/hyp/nvhe/kvm_nvhe.tmp.o: Unexpected SHT_REL
> > section ".rel.llvm.call-graph-profile"
>
> How is this flag provided? I don't see any occurrence of it in the
> kernel so far.

On ChromeOS we build the kernel with sample profiles by adding
-fprofile-sample-use=/path/to/gcov.profile to KCFLAGS.

>
> >
> > SHT_REL is generated by the latest lld, see
> > https://reviews.llvm.org/rGca3bdb57fa1ac98b711a735de048c12b5fdd8086.
>
> Is this part of a released toolchain? If so, can you spell out the
> first version where this occurs?

Yes, it was added in llvm-13. I will update the patch.

>
> > Disable profile optimization in kvm/nvhe to fix the build with
> > AutoFDO.
>
> It'd be good to at least mention how AutoFDO and -fprofile-sample-use
> relate to each other.

Good point. AutoFDO is an example of sample profiles.
It's not actually relevant for the bug. I will better remove it.

>
> >
> > Signed-off-by: Denis Nikitin <denik@chromium.org>
> > ---
> >  arch/arm64/kvm/hyp/nvhe/Makefile | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
> > index b5c5119c7396..6a6188374a52 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> > +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> > @@ -89,6 +89,9 @@ quiet_cmd_hypcopy = HYPCOPY $@
> >  # Remove ftrace, Shadow Call Stack, and CFI CFLAGS.
> >  # This is equivalent to the 'notrace', '__noscs', and '__nocfi' annotations.
> >  KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_CFI), $(KBUILD_CFLAGS))
> > +# Profile optimization creates SHT_REL section '.llvm.call-graph-profile' for
> > +# the hot code. SHT_REL is currently not supported by the KVM tools.
>
> 'KVM tools' seems vague. Maybe call out the actual helper that
> processes the relocations?

Agreed.

>
> > +KBUILD_CFLAGS += $(call cc-option,-fno-profile-sample-use,-fno-profile-use)
>
> Why adding these options instead of filtering out the offending option
> as it is done just above?

That was actually the alternative solution and it worked as well.
Let me double check if profile optimization doesn't mess up with other
sections and if it doesn't I will remove the '.llvm.call-graph-profile'
section instead.

>
> Also, is this the only place the kernel fails to compile? The EFI stub
> does similar things AFAIR, and could potentially fail the same way.

This was the only place in 5.15 where we tested it.
Let me see if EFI has this section.

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

Thanks,
Denis
