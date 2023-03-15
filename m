Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438786BB7E3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjCOPc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjCOPcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:32:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CFB1EBE3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 08:32:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o130-20020a257388000000b00b3a7d06fd2eso11776933ybc.22
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678894371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3TNqbTHQHmb2xkVyzid8TSYw/6ySfy0Rm3ZyMjb8K6Q=;
        b=OndTXsXmttnpBFbJTuj797Wr6Hb4uuRGsMxUUd4ZPEwngST2tq9jgqAbWGLkyoc3UF
         RUhNZhfsUQkTDYDwqU0/dV6JxWw+2ynyRmSEyI9Bwl+jseJfVeeW8gwLYFAhBZkUi1BZ
         Rjj2jXSvFfBsYnidGAkG4GJa5P/xduE4cZra/84msBr8gC3W7KhT495aCnKxRRdA4IIK
         43oHM+cyZfvAjiOrOoUR5FIcSA7otu9nwtxqBXBgNK3Oo5TKpFRdN2xa7qP1kSKnHJFw
         Z1bOTZoSAkx8hsqeuessy3+j2lwr6e+TM98ortsV9xdt+nOgsmHrWRNygXFqTvbbzcTi
         wdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678894371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3TNqbTHQHmb2xkVyzid8TSYw/6ySfy0Rm3ZyMjb8K6Q=;
        b=wHs5GpOSd2qu6AKk6mgFRPWDRSjDarP7074a2VN8UI2pvjqYEU5EpqMRVbxJjNpO4i
         9AzvYGAhSstAROWxailZz+0Pn4vu5Wl7r5jipSNugKN2Y+yFSBY+OaWcsGUzE1yPDYOG
         IamBZsmHQi/67FxfrTUA2H0TjBEbsGvMGRAeq144ufJkpZOA2SvgCNZBsiyFtPzfnsLW
         5aMZAgvvP2yWS0m8jcxRCeyE2AAZ3KYRsr/UGwlmaSNEWRlXTOokQvYheB40kZIr0wJI
         o2fdUNGp14X/9kp+1+7M3bO1kLKjU4nWZuKss7zKJHMSRVjl4jcByZdzo40uwpK0bFiq
         iFmQ==
X-Gm-Message-State: AO0yUKULR2x8CGaeptZ21atGqD0Z7zM46/ARufwb6uNCWoubdTVbPprQ
        Tkm56rarQDlBlw40tntT18LTHkzXVcg=
X-Google-Smtp-Source: AK7set/iYt7e9mDhQyRut6LZI+RQO0U18hEgJBTShOBJit1b59iuVZXxUV2vD+RNR86XdMZiKEiV0PP1XPI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1205:b0:b3e:c715:c313 with SMTP id
 s5-20020a056902120500b00b3ec715c313mr2265866ybu.6.1678894371838; Wed, 15 Mar
 2023 08:32:51 -0700 (PDT)
Date:   Wed, 15 Mar 2023 08:32:50 -0700
In-Reply-To: <ZBEanQaJTCkjcDOn@yzhao56-desk.sh.intel.com>
Mime-Version: 1.0
References: <20230311002258.852397-1-seanjc@google.com> <20230311002258.852397-12-seanjc@google.com>
 <ZBEanQaJTCkjcDOn@yzhao56-desk.sh.intel.com>
Message-ID: <ZBHlIuhED8y3JIu1@google.com>
Subject: Re: [PATCH v2 11/27] KVM: x86/mmu: Don't rely on page-track mechanism
 to flush on memslot change
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, kvm@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023, Yan Zhao wrote:
> On Fri, Mar 10, 2023 at 04:22:42PM -0800, Sean Christopherson wrote:
> ...
> > -static void kvm_mmu_invalidate_zap_pages_in_memslot(struct kvm *kvm,
> > -			struct kvm_memory_slot *slot,
> > -			struct kvm_page_track_notifier_node *node)
> > -{
> > -	kvm_mmu_zap_all_fast(kvm);
> > -}
> > -
> >  int kvm_mmu_init_vm(struct kvm *kvm)
> >  {
> >  	struct kvm_page_track_notifier_node *node = &kvm->arch.mmu_sp_tracker;
> > @@ -6110,7 +6103,6 @@ int kvm_mmu_init_vm(struct kvm *kvm)
> >  	}
> >  
> >  	node->track_write = kvm_mmu_pte_write;
> > -	node->track_flush_slot = kvm_mmu_invalidate_zap_pages_in_memslot;
> >  	kvm_page_track_register_notifier(kvm, node);
> >  
> >  	kvm->arch.split_page_header_cache.kmem_cache = mmu_page_header_cache;
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index f706621c35b8..29dd6c97d145 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -12662,6 +12662,8 @@ void kvm_arch_flush_shadow_all(struct kvm *kvm)
> >  void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
> >  				   struct kvm_memory_slot *slot)
> >  {
> > +	kvm_mmu_zap_all_fast(kvm);
> Could we still call kvm_mmu_invalidate_zap_pages_in_memslot() here?
> As I know, for TDX, its version of
> kvm_mmu_invalidate_zap_pages_in_memslot() is like
> 
> static void kvm_mmu_invalidate_zap_pages_in_memslot(struct kvm *kvm,
>                         struct kvm_memory_slot *slot,
>                         struct kvm_page_track_notifier_node *node)
> {
>         if (kvm_gfn_shared_mask(kvm))
>                 kvm_mmu_zap_memslot(kvm, slot);
>         else
>                 kvm_mmu_zap_all_fast(kvm);
> }
> 
> Maybe this kind of judegment is better to be confined in mmu.c?

Hmm, yeah, I agree.  The only reason I exposed kvm_mmu_zap_all_fast() is because
kvm_mmu_zap_all() is already exposed for kvm_arch_flush_shadow_all() and it felt
weird/wrong to split those.  But that's the only usage of kvm_mmu_zap_all(), so
a better approach to maintain consistency would be to move
kvm_arch_flush_shadow_{all,memslot}() into mmu.c.  I'll do that in the next version.
