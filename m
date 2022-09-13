Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF8E5B6EB3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 15:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiIMN61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 09:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiIMN6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 09:58:24 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A334DB3D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 06:58:23 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s10so13851313ljp.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 06:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Xz00WUlNoMcvuGzmZoT3YtH17wlzSyS0xFHNgt419Gk=;
        b=lUsjBgilev82eRTIjXeALpddVB70OObeUL+rQ+CVv5Xz7/Q4E6xSSEMA+oNJJAKPOe
         BncPJ1pDrE40RjDYbevpdqqCaVYprSiklIRR89m40RyyKzVkl3z7N0t8REFBPPqGoGf3
         IHb2qmPtSxCyptLqs0Y/1OZkm+P71HV8Bpd0JUYGUu7zThDlDWgL+wa488uVapxjXXhs
         JRzlTL8byDtmXAo5+YgYLRG8qxnYBxI4zfCHdjT5RiCro07MjRhcjw2JSZIJfbQcmIJB
         2hd0sWlXmFAFEkUjEhBsFE4Os15LDehHDOpBkXbsZ1aHdUWwySLa8Wf6YH/gWZEN9XOV
         WScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Xz00WUlNoMcvuGzmZoT3YtH17wlzSyS0xFHNgt419Gk=;
        b=gzTJg5h4yebNFtN1+td4hGeCcsi6FVj1209Ljq0G6yTt6/74d5YsqflDSfCjxtssnx
         CdkT2CG9Ve33s/QK9O7/xQG9zdPePf4co56eREhiib81h36cYVD3p0i38eW262/F7N8k
         o9CFx8fYDtpNKKS2zs8t8WmD4v0Rc8f4YT1DfekEJFCwE6VASOq0TXEgC199ywl59l1J
         201olz7A5U2aAmIHix0csKZyII3MinEyZHL2NfP28JOl0G7tjy3qQarn9yMF7iPF+QXb
         V7wrTdO4aTqcjTVE+MLiaAR0XA3Z1F5DZXLKAglSCoz9Ri6DpD8gtbSPf2iRe7nLtLdC
         EcnA==
X-Gm-Message-State: ACgBeo28X/Zr7j8lLviuE8jRDUSLQymj+GkBM1kBw9qbTG8i37ipI9z1
        LbGZWqQw8Snd5jD/fhEYWjNezKTrwqhTOosaBpNVzQ==
X-Google-Smtp-Source: AA6agR5QWnwHv7/mI5PgNzDnxLBkRSTaL9iTSsGQerlCdhGRn6rLQMQIjHYb/thVv6YxaFXuuAIQWCUykN5+EICUUB4=
X-Received: by 2002:a2e:87d9:0:b0:26a:ceee:c77b with SMTP id
 v25-20020a2e87d9000000b0026aceeec77bmr9716521ljj.275.1663077502029; Tue, 13
 Sep 2022 06:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1661331396.git.houwenlong.hwl@antgroup.com>
 <8baa40dad8496abb2adb1096e0cf50dcc5f66802.1661331396.git.houwenlong.hwl@antgroup.com>
 <YxjXgERSNIk4ZaN+@google.com> <20220913125833.GC113257@k08j02272.eu95sqa>
In-Reply-To: <20220913125833.GC113257@k08j02272.eu95sqa>
From:   David Matlack <dmatlack@google.com>
Date:   Tue, 13 Sep 2022 06:57:55 -0700
Message-ID: <CALzav=c7Y_Do0vk_AtezYMBss6eRDGzyHovMYArXQ4JfmfKoOw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] KVM: x86/mmu: Use 1 as the size of gfn range for
 tlb flushing in FNAME(invlpg)()
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 5:58 AM Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
>
> On Thu, Sep 08, 2022 at 01:40:16AM +0800, David Matlack wrote:
> > On Wed, Aug 24, 2022 at 05:29:23PM +0800, Hou Wenlong wrote:
> > > Only SP with PG_LEVLE_4K level could be unsync, so the size of gfn range
> > > must be 1.
> > >
> > > Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> > > ---
> > >  arch/x86/kvm/mmu/paging_tmpl.h | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
> > > index 04149c704d5b..486a3163b1e4 100644
> > > --- a/arch/x86/kvm/mmu/paging_tmpl.h
> > > +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> > > @@ -937,7 +937,8 @@ static void FNAME(invlpg)(struct kvm_vcpu *vcpu, gva_t gva, hpa_t root_hpa)
> > >
> > >                     mmu_page_zap_pte(vcpu->kvm, sp, sptep, NULL);
> > >                     if (is_shadow_present_pte(old_spte))
> > > -                           kvm_flush_remote_tlbs_sptep(vcpu->kvm, sptep);
> > > +                           kvm_flush_remote_tlbs_gfn(vcpu->kvm,
> > > +                                   kvm_mmu_page_get_gfn(sp, sptep - sp->spt), 1);
> >
> > The third argument to kvm_flush_remote_tlbs_gfn() is the level, not the
> > number of pages. But that aside, I don't understand why this patch is
> > necessary. kvm_flush_remote_tlbs_sptep() should already do the right
> > thing.
> >
> Since only SP with PG_LEVEL_4K level could be unsync, so the level must
> be PG_LEVEL_4K, then sp->role.level access could be dropped. However,
> I'm not sure whether it is useful. I can drop it if it is useless.

Ah, I see. I would be surprised if avoiding the read of sp->role.level
has any noticeable impact on VM performance so I vote to drop this patch.


>
> > >
> > >                     if (!rmap_can_add(vcpu))
> > >                             break;
> > > --
> > > 2.31.1
> > >
