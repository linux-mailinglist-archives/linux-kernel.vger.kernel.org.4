Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1EC6A025B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 06:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjBWF0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 00:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjBWF0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 00:26:20 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4D542BE5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 21:26:18 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id u14so12876760vsp.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 21:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXEnUJIuw3DsBBpeEas97UQaCI4+fKGVwu8RQPcIlxs=;
        b=ebfMrTiO8jVZApxkACFGkW19OKcseaGjzh5HjIfu8MAU62l8YkK9wYnBFkU6I+6zuE
         AUDCEHsZSZ9mbCKKWNPTplXuqS87aYdUMgEd5/HJTFPzZF9uHLGfh+f//SGkFgG2WUUC
         VMrPZXwgvdZQ0a9Rdfoin9rPnC9lwtXHaGCdiIAVtUZ+zDzePE60bEA2n80H6qz2mPub
         YZRSOEb//hMVhNQrFI5fjyJOTZ5EPIveLNi+6mlZv8sUqb9Y6C+ziwSJjuW7/BuocHT5
         ypJ99wrjoFqAACPuG1lbl4B3N9wqDvRcpL/jBCfwY1kMxbLPNuarGmvnmO4vjdaXxv4a
         SkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXEnUJIuw3DsBBpeEas97UQaCI4+fKGVwu8RQPcIlxs=;
        b=xi6ml5kxB8KaQ7SKnXqmfsygh8DoIS2Sw5IDXp1X6k4XuCla56EPjM/ostBLI5fgWr
         2VisUdXha8OSAUD/EB5pvxqTSTdcPtzjzGcpdsY45VfHa8PavjnvFSxy0cIvg8MH/g6Z
         SQVAEAwbxiep2I14/MU0lWaXy9EZBaZVJ5Zls6sjytpOblpc+GtrJesO2jA8wKio6zCx
         NThdt6OzfEJD91arqW183bXzDq16DGdHySm3caWSDBLSbriYfjS5Bi3llecKrIkmiwrK
         QAkPW5ZVS9aQn82oYgzZmatnzMPsZLqHp+uUFnr3zUB1rhO3Y0VIMzJ8ACLuUxg37TZb
         5RWA==
X-Gm-Message-State: AO0yUKXdZeH1iuOF1igs7WJAZnDCFev1NgxXedWv7Cg5ah1xSerflAKB
        eEgFVGT8ZnQA92/Zn3KQMhr7AxdlCcJgFx12mbDQvA==
X-Google-Smtp-Source: AK7set/r/f8pGhkIjYGiLVLtcsnWRFxpAmGZdfZxTguMU1aVP5zVqu1WLV5ZRnN+vLq9szVFT6NHenS4YuDGWsM46AY=
X-Received: by 2002:a05:6102:108f:b0:41e:d8b5:ee40 with SMTP id
 s15-20020a056102108f00b0041ed8b5ee40mr553492vsr.26.1677129977589; Wed, 22 Feb
 2023 21:26:17 -0800 (PST)
MIME-Version: 1.0
References: <20230217041230.2417228-1-yuzhao@google.com> <20230217041230.2417228-4-yuzhao@google.com>
 <Y+9EUeUIS/ZUe2vw@linux.dev> <Y++kiJwUIh55jkvl@google.com>
In-Reply-To: <Y++kiJwUIh55jkvl@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 22 Feb 2023 22:25:41 -0700
Message-ID: <CAOUHufYVWvEG=EMBEffnurQhJSb5WN75NVVXPhWghWFR9Aa94A@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 3/5] kvm/arm64: add kvm_arch_test_clear_young()
To:     Sean Christopherson <seanjc@google.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Larabel <michael@michaellarabel.com>,
        kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-mm@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Feb 17, 2023 at 9:00=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Feb 17, 2023, Oliver Upton wrote:
> > Hi Yu,
> >
> > scripts/get_maintainers.pl is your friend for getting the right set of
> > emails for a series :) Don't know about others, but generally I would
> > prefer to be Cc'ed on an entire series (to gather context) than just an
> > individual patch.
>
> +1
>
> >
> > On Thu, Feb 16, 2023 at 09:12:28PM -0700, Yu Zhao wrote:
> > > This patch adds kvm_arch_test_clear_young() for the vast majority of
> > > VMs that are not pKVM and run on hardware that sets the accessed bit
> > > in KVM page tables.
>
> At least for the x86 changes, please read Documentation/process/maintaine=
r-tip.rst
> and rewrite the changelogs.

I see -- will remove "this patch".

> > > It relies on two techniques, RCU and cmpxchg, to safely test and clea=
r
> > > the accessed bit without taking the MMU lock. The former protects KVM
> > > page tables from being freed while the latter clears the accessed bit
> > > atomically against both the hardware and other software page table
> > > walkers.
> > >
> > > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > > ---
> > >  arch/arm64/include/asm/kvm_host.h       |  7 +++
> > >  arch/arm64/include/asm/kvm_pgtable.h    |  8 +++
> > >  arch/arm64/include/asm/stage2_pgtable.h | 43 ++++++++++++++
> > >  arch/arm64/kvm/arm.c                    |  1 +
> > >  arch/arm64/kvm/hyp/pgtable.c            | 51 ++--------------
> > >  arch/arm64/kvm/mmu.c                    | 77 +++++++++++++++++++++++=
+-
> > >  6 files changed, 141 insertions(+), 46 deletions(-)
> > >
> > > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/a=
sm/kvm_host.h
> > > index 35a159d131b5..572bcd321586 100644
> > > --- a/arch/arm64/include/asm/kvm_host.h
> > > +++ b/arch/arm64/include/asm/kvm_host.h
> > > @@ -1031,4 +1031,11 @@ static inline void kvm_hyp_reserve(void) { }
> > >  void kvm_arm_vcpu_power_off(struct kvm_vcpu *vcpu);
> > >  bool kvm_arm_vcpu_stopped(struct kvm_vcpu *vcpu);
> > >
> > > +/* see the comments on the generic kvm_arch_has_test_clear_young() *=
/
>
> Please eliminate all of these "see the comments on blah", in every case t=
hey do
> nothing more than redirect the reader to something they're likely already=
 aware of.
>
> > > +#define kvm_arch_has_test_clear_young kvm_arch_has_test_clear_young
> > > +static inline bool kvm_arch_has_test_clear_young(void)
> > > +{
> > > +   return IS_ENABLED(CONFIG_KVM) && cpu_has_hw_af() && !is_protected=
_kvm_enabled();
> > > +}
>
> ...
>
> > Also, I'm at a loss for why we'd need to test if CONFIG_KVM is enabled.
> > My expectation is that we should provide an implementation that returns
> > false if !CONFIG_KVM, avoiding the need to repeat that bit in every
> > single implementation of the function.
>
> mm/vmscan.c uses kvm_arch_has_test_clear_young().  I have opinions on tha=
t, but
> I'll hold off on expressing them until there's actual justification prese=
nted
> somewhere.
>
> Yu, this series and each patch needs a big pile of "why".  I get that the=
 goal
> is to optimize memory oversubscribe, but there needs to be justification =
for
> why this is KVM only, why nested VMs and !A/D hardware are out of scope, =
why yet
> another mmu_notifier hook is being added, etc.

I totally agree.

This is an optimization, not a bug fix. It can't be justified without
performance numbers from some common use cases. That burden of proof
clearly rests on me -- I will follow up on that.

For now, I want to make sure the methodical part is clear:
1. We only have limited resources and we need to prioritize major use cases=
.
2. We can only improve one thing at a time and we can't cover
everything at the same time.
3. We need to focus on the return on investment and the future.

I hope everyone by now agrees with my "the vast majority of VMs ..."
assertion. If not, I'm happy to revisit that [1]. If so, the next step
would be whether we want to focus on the vast majority first. I think
this naturally answers why the nested VMs and !AD h/w are out of
scope, at the moment (I didn't spell this out; probably I should in
v2). After we have taken the first step, we probably can decide
whether there is enough resource and demand to cover the low return on
investment part (but complexity but less common use cases).

[1] https://lore.kernel.org/linux-mm/20230217041230.2417228-1-yuzhao@google=
.com/
