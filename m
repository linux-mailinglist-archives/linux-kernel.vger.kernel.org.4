Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACECA64ABFF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbiLMAKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbiLMAJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:09:58 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEB41C105
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:09:55 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3c090251d59so170664887b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h//U1P26Q/GbgdDfd7npnXyzvnrUCmDZBLLM2h5i8dQ=;
        b=gpXQ7GcWnIWicMxrdl18IrxARO4W9z99cly0rZMtgszw+A6mzBnuepYcZ33NW3QCO/
         3u/MKIylRh8lpUiOYAGXDP7DYMF2CNiPtEuE6wgFezOdTNKYeotkavtJtX6ETrjiGM6v
         j5lx9n72HotfhD+7iVDyLjyq/wR1F3v3nTbUS5rObyenVdsZ+A3MmiNmWNkxtBsdSjcc
         g/2EH9wfqwoesaON/tgf1kjuiCoKXzoRmt3wGYFMg4xfam0r84c7+DuJPMFGn/fmgJen
         Nq7oXVdFQWyaW06vqhuDIIaRR2F21NgmVtlas14PprYeag2lcQXmkAU4EAjJg+b///ca
         t7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h//U1P26Q/GbgdDfd7npnXyzvnrUCmDZBLLM2h5i8dQ=;
        b=EhGdFna2Z2NoRG/amgfvtisA0r2e/8k4+3XPTIyQ2nfHKCmsMs1Uha1J7noi2mRgNc
         n/BwJD1lh1P6NGc10XxKx/Vz2N3fDyGltbegwc0isLQ/VE7pKNor+3ebcli1SXRm04fK
         0hFPWj1nD7/UlM+u0BgHuLttvfrcimTWe6V51uA75dOUxLqGBvVAgq6mY7bcmKNQUaXy
         uWSNqFVUQW+fpkC/AcAKb/c6Wrig46JMbUqR7PCRGZyCLUHMeTFfCRAkBuxKE6Dz8mPK
         08AosD0cHlwoHGsZIcXq5n12AqDQm8z6oorUcavA/FydCUexrOiTRePPvZKfu2sHol6P
         Ui5w==
X-Gm-Message-State: ANoB5pkYcgFmpWhen3WnZz4rx3LYlvLO1Uw4uSh3cNXWyRMBq9CdFLNH
        yxXZZN4oUYeuGximXFBkHuwIxFa/dsgjYTr+oqhhMQ==
X-Google-Smtp-Source: AA0mqf5l9HXAT+IUtuN+jKG3RgoTLQT/3d9spzn1Vu1DQb5YEA7Tgxew/pbK5Lo2xb5A0ptbPlfv7Kw+AdG08s0G+Ss=
X-Received: by 2002:a81:8453:0:b0:3e3:87ec:f862 with SMTP id
 u80-20020a818453000000b003e387ecf862mr25312745ywf.15.1670890194208; Mon, 12
 Dec 2022 16:09:54 -0800 (PST)
MIME-Version: 1.0
References: <20221129191237.31447-1-mizhang@google.com> <Y5Oob6mSJKGoDBnt@google.com>
 <Y5avm5VXpRt263wQ@google.com> <Y5dax8XJV0F5adUw@google.com>
In-Reply-To: <Y5dax8XJV0F5adUw@google.com>
From:   David Matlack <dmatlack@google.com>
Date:   Mon, 12 Dec 2022 16:09:28 -0800
Message-ID: <CALzav=f2k9dPYkeW2D0ZvkDuDhA8Wmu+zV8W4isMFfd-HAQjrA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/2] Deprecate BUG() in pte_list_remove() in shadow mmu
To:     Sean Christopherson <seanjc@google.com>
Cc:     Mingwei Zhang <mizhang@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nagareddy Reddy <nspreddy@google.com>,
        Jim Mattson <jmattson@google.com>
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

On Mon, Dec 12, 2022 at 8:46 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Dec 12, 2022, Mingwei Zhang wrote:
> > On Fri, Dec 09, 2022, David Matlack wrote:
> > > On Tue, Nov 29, 2022 at 07:12:35PM +0000, Mingwei Zhang wrote:
> > > > Deprecate BUG() in pte_list_remove() in shadow mmu to avoid crashing a
> > > > physical machine. There are several reasons and motivations to do so:
> > > >
> > > > MMU bug is difficult to discover due to various racing conditions and
> > > > corner cases and thus it extremely hard to debug. The situation gets much
> > > > worse when it triggers the shutdown of a host. Host machine crash might
> > > > eliminates everything including the potential clues for debugging.
> > > >
> > > > From cloud computing service perspective, BUG() or BUG_ON() is probably no
> > > > longer appropriate as the host reliability is top priority. Crashing the
> > > > physical machine is almost never a good option as it eliminates innocent
> > > > VMs and cause service outage in a larger scope. Even worse, if attacker can
> > > > reliably triggers this code by diverting the control flow or corrupting the
> > > > memory, then this becomes vm-of-death attack. This is a huge attack vector
> > > > to cloud providers, as the death of one single host machine is not the end
> > > > of the story. Without manual interferences, a failed cloud job may be
> > > > dispatched to other hosts and continue host crashes until all of them are
> > > > dead.
> > >
> > > My only concern with using KVM_BUG() is whether the machine can keep
> > > running correctly after this warning has been hit. In other words, are
> > > we sure the damage is contained to just this VM?
>
> Hmm, good point.  The counter-argument is that KVM doesn't BUG() in get_mmio_spte()
> when a non-MMIO SPTE has reserved bits set, and as we've seen internally in multiple
> splats where the reserved bits appear to be set by stack overflow, that has a much,
> much higher probability of being a symptom of data corruption.
>
> That said, that's more of a reason to change get_mmio_spte() than it is to ignore
> potential data corruption in this case.  KVM arguably should kill the VM if
> get_mmio_spte() fails too.
>
> What about explicitly treating both get_mmio_spte() and this as potential data
> corruption?  E.g. something like this, and then use the DATA_CORRUPTION variant
> in pte_list_remove()?
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 2055e04b8f89..1cb69c6d186b 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4075,6 +4075,7 @@ static bool get_mmio_spte(struct kvm_vcpu *vcpu, u64 addr, u64 *sptep)
>                         pr_err("------ spte = 0x%llx level = %d, rsvd bits = 0x%llx",
>                                sptes[level], level,
>                                get_rsvd_bits(rsvd_check, sptes[level], level));
> +               KVM_BUG_ON_DATA_CORRUPTION(reserved, vcpu->kvm);
>         }
>
>         return reserved;
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index f16c4689322b..5c4a06f66f46 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -863,6 +863,17 @@ static inline void kvm_vm_bugged(struct kvm *kvm)
>         unlikely(__ret);                                        \
>  })
>
> +#define KVM_BUG_ON_DATA_CORRUPTION(cond, kvm)                  \
> +({                                                             \
> +       int __ret = (cond);                                     \
> +                                                               \
> +       if (IS_ENABLED(CONFIG_BUG_ON_DATA_CORRUPTION))          \
> +               BUG_ON(__ret);                                  \
> +       else if (WARN_ON_ONCE(__ret && !(kvm)->vm_bugged))      \
> +               kvm_vm_bugged(kvm);                             \
> +       unlikely(__ret);                                        \
> +})
> +
>  static inline void kvm_vcpu_srcu_read_lock(struct kvm_vcpu *vcpu)
>  {
>  #ifdef CONFIG_PROVE_RCU

That sounds reasonable to me.
