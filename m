Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FFA68DF13
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjBGRhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjBGRhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:37:36 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4C9CDF2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 09:37:35 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id a1so19427207ybj.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 09:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=adlYRDbst09nC8apj5bbFfvdjr6JdO6HJ9SMhiS3Xgo=;
        b=bG9lxqfqs5cUwIiTFihJY8ktvBmy2TL5Q8fweKI6pKPiwTq3u8Ymowr3ZWw6oe+UhE
         KyKlgc5xzLONXKyo/kIAP/jY4iyiq/oBbjC3w/vi6LtsQ+DasJyMAP49WRrUbvjEgExo
         Qozb8N2gCjm6epASJpoJpWBQBv5GO0nTuwWtOWkTICmIR/S3belPUPmdlnSnup0hct2J
         irE03NX0MUer3y1JtcMU4T428ymLKHDtKpx0NTgeq3ZM/kAdvvZFEJ1LveU682oMjFAb
         ceZN7WMfJ9ERq5nV+rhuyI1bTFxhahBebJ00RuVHwgd9qUCDVLCoX03ga9UczlflEyBv
         o8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=adlYRDbst09nC8apj5bbFfvdjr6JdO6HJ9SMhiS3Xgo=;
        b=3dquW3rWbZDBtYv5kZWr9ct+r/iGdusY5DIaLmHyZPhA0MdSMlVnJm0mIsbnQhUGdi
         TqdvdwLMq5BxA4OYqSW+8vUkuOEXbitipxtf77F1ZXqgbt3HZyozrzVVoZIgA8f7Mw7i
         8jnBsTNk68tXbgrrIsRs4YKMtdvWZ+dTS60ejtTFRKcVqx3Kcp3m6moK6GmT04hz7uSn
         e4u2RZQKP7VGO/ofl/pC+Ho0w3xAJvNdSn9XQEG8ONxtJMuIP+qevqM41PxEkP83deBG
         ZdIyHJ9wa4+QbCim7MkUzyMUfhkmVI/5i+PVWRzpXKafllFyPCqMkkIROhiHnAv9DwMw
         DVVA==
X-Gm-Message-State: AO0yUKV6Uo8JMJJT9KvHjYmS+cBugkLjB2G9q8qrnGr/6PTwA+TxAEjy
        n3AmUReUjZ+eRSSiuBf/fAl9EIi5jTQTeN/BOoFs8Q==
X-Google-Smtp-Source: AK7set8B979pZvKpTq9FfmtwVgpZSHrm907YAyIRwnDmqapDxV4NJoyXpJWakWdhEHahGCabqP8NGLzum/8cNLVJkwU=
X-Received: by 2002:a25:e907:0:b0:801:33b9:d9ac with SMTP id
 n7-20020a25e907000000b0080133b9d9acmr287756ybd.2.1675791454409; Tue, 07 Feb
 2023 09:37:34 -0800 (PST)
MIME-Version: 1.0
References: <20230203192822.106773-1-vipinsh@google.com> <20230203192822.106773-3-vipinsh@google.com>
 <Y+GQNXDlNbJNvDd2@google.com>
In-Reply-To: <Y+GQNXDlNbJNvDd2@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Tue, 7 Feb 2023 09:36:58 -0800
Message-ID: <CAHVum0d2dRvNaS+AMqdbF35D05dDQrtZ4TBQ1QOYx6he-Cy6YA@mail.gmail.com>
Subject: Re: [Patch v2 2/5] KVM: x86/mmu: Optimize SPTE change flow for clear-dirty-log
To:     David Matlack <dmatlack@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Feb 6, 2023 at 3:41 PM David Matlack <dmatlack@google.com> wrote:
>
> On Fri, Feb 03, 2023 at 11:28:19AM -0800, Vipin Sharma wrote:
> > No need to check all of the conditions in __handle_changed_spte() as
> > clearing dirty log only involves resetting dirty or writable bit.
>
> Channelling Sean: State what the patch does first.
>
> >
> > Make atomic change to dirty or writable bit and mark pfn dirty.
>
> This is way too vague. And the old code already did both of these
> things. What's changed is that the bits are being cleared with an atomic
> AND and taking advantage of the fact that that avoids needing to deal
> with changes to volatile bits.
>
> Please also explain what effect this has on @record_dirty_log and why it
> can be opportunistically cleaned up in this commit.
>

Okay, I will try to be better in the next one.

> > Iteration 3 clear dirty log time: 1.881043086s
> > Disabling dirty logging time: 2.930387523s
> > Get dirty log over 3 iterations took 0.006191681s.
> > (Avg 0.002063893s/iteration)
> > Clear dirty log over 3 iterations took 6.148156531s. (Avg 2.049385510s/iteration)
>
> Can you trim these results to just show the clear times? (assuming none
> of the rest are relevant)

I was not sure if just showing clear dirty times will be acceptable or
not. I will update the message to only show clear dirty log time and
average.

>
> >
> > +static inline u64 kvm_tdp_mmu_clear_spte_bit(struct tdp_iter *iter, u64 mask)
> > +{
>
> Make "bit" plural as long as the parameter is a raw mask.
>
> Also drop "kvm_" since this is not intended to be called outside the TDP
> MMU. (It'd be nice to make the same cleanup to the read/write
> functions if you feel like it.)
>

Sounds good.

> > @@ -1678,7 +1665,7 @@ static void clear_dirty_pt_masked(struct kvm *kvm, struct kvm_mmu_page *root,
> >                                 gfn_t gfn, unsigned long mask, bool wrprot)
> >  {
> >       struct tdp_iter iter;
> > -     u64 new_spte;
> > +     u64 clear_bits;
>
> nit: clear_bit since it's always a single bit?

Yes.

>
> >
> >       rcu_read_lock();
> >
> > @@ -1694,18 +1681,22 @@ static void clear_dirty_pt_masked(struct kvm *kvm, struct kvm_mmu_page *root,
> >               mask &= ~(1UL << (iter.gfn - gfn));
> >
> >               if (wrprot || spte_ad_need_write_protect(iter.old_spte)) {
> > -                     if (is_writable_pte(iter.old_spte))
> > -                             new_spte = iter.old_spte & ~PT_WRITABLE_MASK;
> > -                     else
> > +                     if (!is_writable_pte(iter.old_spte))
> >                               continue;
> > +
> > +                     clear_bits = PT_WRITABLE_MASK;
> >               } else {
> > -                     if (iter.old_spte & shadow_dirty_mask)
> > -                             new_spte = iter.old_spte & ~shadow_dirty_mask;
> > -                     else
> > +                     if (!(iter.old_spte & shadow_dirty_mask))
> >                               continue;
>
> You can factor out the continue check now that you have clear_bits. e.g.
>
>         if (wrprot || spte_ad_need_write_protect(iter.old_spte))
>                 clear_bits = PT_WRITABLE_MASK;
>         else
>                 clear_bits = shadow_dirty_mask;
>
>         if (!(iter->old_spte & clear_bits))
>                 continue;
>
>         iter.old_spte = kvm_tdp_mmu_clear_spte_bit(&iter, clear_bits);
>

Yeah, this is better. Even better if I just initialize like:

u64 clear_bits = shadow_dirty_mask;

This will also get rid of the else part.
