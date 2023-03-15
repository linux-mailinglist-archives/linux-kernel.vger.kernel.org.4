Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270076BB84D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjCOPoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjCOPoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:44:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CC555528
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 08:43:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b20-20020a253414000000b00b305140e33cso16595826yba.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 08:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678895035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3yOC9GAxlzabl02b1RPWrLKpddDwW/XjKQVoaxOI5Fs=;
        b=irQd1i8q+ogxqHs1vTXLJdSkvIHIEjzr7qUucu06Sgiu0iqFVDzwkLGWwE/5+BJi3u
         6x81/zfQBxCitIQAf3coqjNffjMF2giXqZqeQ3fUEzvbnC8ZZOaaGRa//Lv7hWE/T0lm
         uXIg/SVhvpzL2sLnGaz9nq/6dVVCLsP/geOkOjiBXmLThQVBDWJZ6kVyOkAy1zxLyrN9
         4BdD7rV4Ga3aqZoQmq41NA9S1kX9L2axC6+613IdBeT6Pu9LjrduwTelFtHof8kLxpU8
         fG/JWVzp6PxwsZA82T79bPMPUjMk8rJPnVs8W+Z3FrrIfL/q8W1VVzIoYtiFjr8k4i8Z
         1UGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678895035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3yOC9GAxlzabl02b1RPWrLKpddDwW/XjKQVoaxOI5Fs=;
        b=OYqtyoUEl2MHCay2uQ8g/DkQGgNxXO6PPK3LHKXPhLYOcKVGqLh3ziVhqpE2Fkpnrm
         UV1JkemGDP2x1GUwunnPNra7zKR7UHwf8UigfkpTXhIEjLc9kMTYppjnpkTVrhSO/rMQ
         xoIGbdoYMdYfoiydBAF7hSQuqUte9T1+NG94CU++5ACr4cKLEzBAaGCNrrYpPWfFrYqj
         ByeERcM5on/vNT2x9oz5Um1MtQVzHSXbYvkwX0N5L91HRD1J4SREF6duuybf9ibSx4cc
         EWOF7oRSL8pq6a5xjM+1mz6vEn5Jpzyn9na9T49hCfYsnmuHa+BLPj5ojU0Z1ndBZaSU
         h9Mg==
X-Gm-Message-State: AO0yUKV0K3OImk/Q0hde2obXhl2LDJ/2GMWnTfqCOl0YcwGMD8uygfCi
        uabL39EV0Egv/LJORb+EjN6hG+tJxz8=
X-Google-Smtp-Source: AK7set/m8ThOIuQfxnThk6YIlQaIAC0QfTqKlvtfDwDkFgfpYMWOGBpJSb01Yl38Gvzl13a7oAZAuDELZsQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:d302:0:b0:541:359c:103a with SMTP id
 y2-20020a81d302000000b00541359c103amr192124ywi.8.1678895035645; Wed, 15 Mar
 2023 08:43:55 -0700 (PDT)
Date:   Wed, 15 Mar 2023 08:43:54 -0700
In-Reply-To: <ZBF72+flVlEbfg70@yzhao56-desk.sh.intel.com>
Mime-Version: 1.0
References: <20230311002258.852397-1-seanjc@google.com> <20230311002258.852397-15-seanjc@google.com>
 <ZBF72+flVlEbfg70@yzhao56-desk.sh.intel.com>
Message-ID: <ZBHnugUe0SSmQKGI@google.com>
Subject: Re: [PATCH v2 14/27] KVM: x86: Reject memslot MOVE operations if
 KVMGT is attached
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
> On Fri, Mar 10, 2023 at 04:22:45PM -0800, Sean Christopherson wrote:
> > Disallow moving memslots if the VM has external page-track users, i.e. if
> > KVMGT is being used to expose a virtual GPU to the guest, as KVM doesn't
> > correctly handle moving memory regions.
> > 
> > Note, this is potential ABI breakage!  E.g. userspace could move regions
> > that aren't shadowed by KVMGT without harming the guest.  However, the
> > only known user of KVMGT is QEMU, and QEMU doesn't move generic memory
> > regions.  KVM's own support for moving memory regions was also broken for
> > multiple years (albeit for an edge case, but arguably moving RAM is
> > itself an edge case), e.g. see commit edd4fa37baa6 ("KVM: x86: Allocate
> > new rmap and large page tracking when moving memslot").
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> ...
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 29dd6c97d145..47ac9291cd43 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -12484,6 +12484,13 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm,
> >  				   struct kvm_memory_slot *new,
> >  				   enum kvm_mr_change change)
> >  {
> > +	/*
> > +	 * KVM doesn't support moving memslots when there are external page
> > +	 * trackers attached to the VM, i.e. if KVMGT is in use.
> > +	 */
> > +	if (change == KVM_MR_MOVE && kvm_page_track_has_external_user(kvm))
> > +		return -EINVAL;
> Hmm, will page track work correctly on moving memslots when there's no
> external users?
> 
> in case of KVM_MR_MOVE,
> kvm_prepare_memory_region(kvm, old, new, change)
>   |->kvm_arch_prepare_memory_region(kvm, old, new, change)
>        |->kvm_alloc_memslot_metadata(kvm, new)
>             |->memset(&slot->arch, 0, sizeof(slot->arch));
>             |->kvm_page_track_create_memslot(kvm, slot, npages)
> The new->arch.arch.gfn_write_track will be fresh empty.
> 
> 
> kvm_arch_commit_memory_region(kvm, old, new, change);
>   |->kvm_arch_free_memslot(kvm, old);
>        |->kvm_page_track_free_memslot(slot);
> The old->arch.gfn_write_track is freed afterwards.
> 
> So, in theory, the new GFNs are not write tracked though the old ones are.
> 
> Is that acceptable for the internal page-track user?

It works because KVM zaps all SPTEs when a memslot is moved, i.e. the fact that
KVM loses the write-tracking counts is benign.  I suspect no VMM actually does
does KVM_MR_MOVE in conjunction with shadow paging, but the ongoing maintenance
cost of supporting KVM_MR_MOVE is quite low at this point, so trying to rip it
out isn't worth the pain of having to deal with potential ABI breakage.

Though in hindsight I wish I had tried disallowed moving memslots instead of
fixing the various bugs a few years back. :-(
