Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2305767BFE1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 23:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbjAYWZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 17:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbjAYWZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:25:15 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387AC29E38
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 14:25:14 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ud5so454613ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 14:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fouNgrd0OKQeC+pIMdzUwggtCDnHBRiDvt1I4Bkdq8E=;
        b=YwZ2K4uhYT+KYYsps0yJosojpE0Fpe1lNPelKdEdn95+2AXac59kA6eJJM5QR3H0hX
         r6yyhavLlmlj19RHhzVSVWSGV4Oeu22/n06EvrvEuFCAaeH512IQbzk739q+pQyI4uno
         C1zcxamhbdfe9YdDkJ5dhpL1hgR5uzu/Bes5O7fQsGIHfguE4iJZNminA8XmK+lATy6q
         /MsxTZ8DXgVyroy2eI0zTjWKmHVxT3EIev38O7emgLKv/WIURiSW0jQz4cICoKSuQiGo
         9xiXSV2PbkJ8OGTwWBvJpTAhJfEKEwJJQLc9AHANGqY6AFiSScxegmcwduywSUYobQmD
         UdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fouNgrd0OKQeC+pIMdzUwggtCDnHBRiDvt1I4Bkdq8E=;
        b=cgwgJkQzUNoJiVZzdkCbsB4RLhRxnk17Xxmyt6G6ZovoJpO0JTwDBalt40f6QVZ5ug
         sfM5fgj/cu1vDVSq9krEu7D3aU/kktw8xaFapVZTlcofn4ayX+vMqD8sxG6POgIeC9uS
         7Spkaf0uBe5eREkFjeVuAIkiMDXGnY2Z5ODvE6GOt/vVhuKD3yQV8kLeG4bw/RT/LkhA
         4Z1E/DgYzrR/R+IwxY93HFAIigBZxLWR+ahKu4zW9KsFIdMcgY/LBTEjdGYC/Oq3P4jI
         lHfnrZnKrwwHsN5lyF8nZx8Mrw6A82EMeUHXKyz0Mev4xE7GElycuj6HMqcFoT7AVWlJ
         SBcA==
X-Gm-Message-State: AFqh2kpylzQx/COoFyF/sOlZsrW/WVf/pdajvj8hl9aFnPtQbHrMglU4
        9gH8aLdny0VT9HVfriznHg9gZWrPgLhYlpVN/X4C1A==
X-Google-Smtp-Source: AMrXdXshrAUSzLnYbd4vccIcvxalj402oNODEKdPSLzMPLpJ8KsronHIlk6JuTCwERI2cQ/wzVd3HsCAl0Jox9pEmVE=
X-Received: by 2002:a17:906:718e:b0:86f:5b87:8b06 with SMTP id
 h14-20020a170906718e00b0086f5b878b06mr2113857ejk.5.1674685512612; Wed, 25 Jan
 2023 14:25:12 -0800 (PST)
MIME-Version: 1.0
References: <20230125213857.824959-1-vipinsh@google.com> <Y9GmiyRQ6sULCjEG@google.com>
In-Reply-To: <Y9GmiyRQ6sULCjEG@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 25 Jan 2023 14:25:00 -0800
Message-ID: <CANgfPd9T7jdh1Cjjo4y6DcxC2poTaGhQ7wNLf6OgGtStg-yKJg@mail.gmail.com>
Subject: Re: [Patch] KVM: x86/mmu: Make optimized __handle_changed_spte() for
 clear dirty log
To:     David Matlack <dmatlack@google.com>
Cc:     Vipin Sharma <vipinsh@google.com>, seanjc@google.com,
        pbonzini@redhat.com, kvm@vger.kernel.org,
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

On Wed, Jan 25, 2023 at 2:00 PM David Matlack <dmatlack@google.com> wrote:
>
> On Wed, Jan 25, 2023 at 01:38:57PM -0800, Vipin Sharma wrote:
> > Use a tone down version of __handle_changed_spte() when clearing dirty
> > log. Remove checks which will not be needed when dirty logs are cleared.
> >
> > This change shows ~13% improvement in clear dirty log calls in
> > dirty_log_perf_test
> >
> > Before tone down version:
> > Clear dirty log over 3 iterations took 10.006764203s. (Avg 3.335588067s/iteration)
> >
> > After tone down version:
> > Clear dirty log over 3 iterations took 8.686433554s. (Avg 2.895477851s/iteration)
> >
> > Signed-off-by: Vipin Sharma <vipinsh@google.com>
> > ---
> >  arch/x86/kvm/mmu/tdp_mmu.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> > index bba33aea0fb0..ca21b33c4386 100644
> > --- a/arch/x86/kvm/mmu/tdp_mmu.c
> > +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> > @@ -504,6 +504,19 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
> >       call_rcu(&sp->rcu_head, tdp_mmu_free_sp_rcu_callback);
> >  }
> >
> > +static void handle_changed_spte_clear_dirty_log(int as_id, gfn_t gfn,
> > +                                             u64 old_spte, u64 new_spte,
> > +                                             int level)
> > +{
> > +     if (old_spte == new_spte)
> > +             return;
> > +
> > +     trace_kvm_tdp_mmu_spte_changed(as_id, gfn, level, old_spte, new_spte);
> > +
> > +     if (is_dirty_spte(old_spte) &&  !is_dirty_spte(new_spte))
> > +             kvm_set_pfn_dirty(spte_to_pfn(old_spte));
> > +}
> > +
> >  /**
> >   * __handle_changed_spte - handle bookkeeping associated with an SPTE change
> >   * @kvm: kvm instance
> > @@ -736,7 +749,12 @@ static u64 __tdp_mmu_set_spte(struct kvm *kvm, int as_id, tdp_ptep_t sptep,
> >
> >       old_spte = kvm_tdp_mmu_write_spte(sptep, old_spte, new_spte, level);
> >
> > -     __handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte, level, false);
> > +     if (record_dirty_log)
> > +             __handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte,
> > +                                   level, false);
> > +     else
> > +             handle_changed_spte_clear_dirty_log(as_id, gfn, old_spte,
> > +                                                 new_spte, level);
>
> I find it very non-intuitive to tie this behavior to !record_dirty_log,
> even though it happens to work. It's also risky if any future calls are
> added that pass record_dirty_log=false but change other bits in the
> SPTE.
>
> I wonder if we could get the same effect by optimizing
> __handle_changed_spte() to check for a cleared D-bit *first* and if
> that's the only diff between the old and new SPTE, bail immediately
> rather than doing all the other checks.

I would also prefer that course. One big lesson I took when building
the TDP MMU was the value of having all the changed PTE handling go
through one function. That's not always the right choice but the
Shadow MMU has a crazy spaghetti code of different functions which
handle different parts of responding to a PTE change and it makes the
code very hard to read. I agree this path is worth optimizing, but the
more we can keep the code together, the better.
