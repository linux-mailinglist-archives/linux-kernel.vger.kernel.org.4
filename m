Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B38265CD66
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 07:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbjADG5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 01:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjADG5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 01:57:22 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51469DFD0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 22:57:20 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id v126so35564845ybv.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 22:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JrOb/+s3r+zlsGduhB3GCsaM7z9sKOgI+S8HyVYdG8k=;
        b=bPIJqMcJ4omq4vYMHrI5jlkxFmVa/T8WuhJZP9Z7nPwv42QkAt/7mku0hD353bGqoY
         ytJVRmWRE15StmSciFx++ZdO2tsIaffqxTvaJM7QAXFVTDHAeLM8090iZQF1VTJiHSTk
         R9AfLdW5tpq1Ui74e0gWd5w9ivljaPWbBAPWziLqTVOjpNo+ZuUMcEMlaYKTV+8hjj+/
         HFRHYIUSqHvybDmRgDbluMtlPpvI6bwfb3wy3bvgiJq3t2haozKWJdbJghulddTXL3FJ
         VqUHuF0BtO6DLW1yDRAANe/Ia7iikO26x6OJai8BBb14E0T8kzcR6lMHPaUV+39Ij0sz
         zbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrOb/+s3r+zlsGduhB3GCsaM7z9sKOgI+S8HyVYdG8k=;
        b=5n5Z0T02otEod/q8DbGR8FMvw1eEoqv1O9T2v5jdPulL0LfG9sy6OBlFI/qXiz0EAH
         8kbznJtHgbV95XjQhP6y9uBYTOCcdSO/MGcglFX4WSb2u3+ENk/YAUZbUNhKtV5+n684
         aWuwoa+4tJiy+/QT22Ds9zz7T+dnKfYTcKSn8BycFUwLyVHjlB5IP+eIL9Svyp35ZEe9
         PgIVAvhR6iXhLS9LqntoQx4AuTiutboqwfAAf+1F6mb1CMcVCdGOIOtiTaz0AY9e4D6v
         LWn0ZhSKKIVzRb0nYxMDXKdxU6ua1HXZFA36RizTEoSOeU64+9SsEGc1PF1oPnNalbnZ
         38BA==
X-Gm-Message-State: AFqh2kooS/CebaaJMujyMLHTYPGg/EIXGIR7I83P4pco4Bm9KQj7PSj6
        qCNivomWSgaPPut13REHDLTBQPbcUCKKXnecZAlvOQ==
X-Google-Smtp-Source: AMrXdXsFPRJjTvrqeybgV/6ejFAc4Qo8JIzUtp3pI9Vngx56jcf7EKi9VxiGT0vAQHbi7YzwbR2j5loDgb8YsaTOqPs=
X-Received: by 2002:a25:d249:0:b0:6ed:37d7:451 with SMTP id
 j70-20020a25d249000000b006ed37d70451mr6508676ybg.499.1672815439417; Tue, 03
 Jan 2023 22:57:19 -0800 (PST)
MIME-Version: 1.0
References: <20221222023457.1764-1-vipinsh@google.com> <20221222023457.1764-2-vipinsh@google.com>
 <CAL715WKT_WbaUHT++tvnKr9fhGObiJpyKdD-zMmmcZnt4Bc=Gg@mail.gmail.com>
 <CAHVum0f9kxHBBR8mBQrA3FrNHvPvqkGE8qXxKJhrnKoE6XkySg@mail.gmail.com> <CAL715W+UjRqqs4aJHoGDf+1c1OMHp8LhhSNgtjkGD5TbFVW_ng@mail.gmail.com>
In-Reply-To: <CAL715W+UjRqqs4aJHoGDf+1c1OMHp8LhhSNgtjkGD5TbFVW_ng@mail.gmail.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Tue, 3 Jan 2023 22:57:08 -0800
Message-ID: <CAL715W+G4vVHOZj+D47vMqiQNCtqD4vp5F+wTCbOoW0XcT2hZw@mail.gmail.com>
Subject: Re: [Patch v3 1/9] KVM: x86/mmu: Repurpose KVM MMU shrinker to purge
 shadow page caches
To:     Vipin Sharma <vipinsh@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        dmatlack@google.com, kvm@vger.kernel.org,
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

On Tue, Jan 3, 2023 at 10:29 PM Mingwei Zhang <mizhang@google.com> wrote:
>
> On Tue, Jan 3, 2023 at 5:00 PM Vipin Sharma <vipinsh@google.com> wrote:
> >
> > On Tue, Jan 3, 2023 at 11:32 AM Mingwei Zhang <mizhang@google.com> wrote:
> > >
> > > On Wed, Dec 21, 2022 at 6:35 PM Vipin Sharma <vipinsh@google.com> wrote:
> > > >
> > > > +static void mmu_free_sp_memory_cache(struct kvm_mmu_memory_cache *cache,
> > > > +                                    spinlock_t *cache_lock)
> > > > +{
> > > > +       int orig_nobjs;
> > > > +
> > > > +       spin_lock(cache_lock);
> > > > +       orig_nobjs = cache->nobjs;
> > > > +       kvm_mmu_free_memory_cache(cache);
> > > > +       if (orig_nobjs)
> > > > +               percpu_counter_sub(&kvm_total_unused_mmu_pages, orig_nobjs);
> > > > +
> > > > +       spin_unlock(cache_lock);
> > > > +}
> > >
> > > I think the mmu_cache allocation and deallocation may cause the usage
> > > of GFP_ATOMIC (as observed by other reviewers as well). Adding a new
> > > lock would definitely sound like a plan, but I think it might affect
> > > the performance. Alternatively, I am wondering if we could use a
> > > mmu_cache_sequence similar to mmu_notifier_seq to help avoid the
> > > concurrency?
> > >
> >
> > Can you explain more about the performance impact? Each vcpu will have
> > its own mutex. So, only contention will be with the mmu_shrinker. This
> > shrinker will use mutex_try_lock() which will not block to wait for
> > the lock, it will just pass on to the next vcpu. While shrinker is
> > holding the lock, vcpu will be blocked in the page fault path but I
> > think it should not have a huge impact considering it will execute
> > rarely and for a small time.
> >
> > > Similar to mmu_notifier_seq, mmu_cache_sequence should be protected by
> > > mmu write lock. In the page fault path, each vcpu has to collect a
> > > snapshot of  mmu_cache_sequence before calling into
> > > mmu_topup_memory_caches() and check the value again when holding the
> > > mmu lock. If the value is different, that means the mmu_shrinker has
> > > removed the cache objects and because of that, the vcpu should retry.
> > >
> >
> > Yeah, this can be one approach. I think it will come down to the
> > performance impact of using mutex which I don't think should be a
> > concern.
>
> hmm, I think you are right that there is no performance overhead by
> adding a mutex and letting the shrinker using mutex_trylock(). The
> point of using a sequence counter is to avoid the new lock, since
> introducing a new lock will increase management burden. So unless it
> is necessary, we probably should choose a simple solution first.
>
> In this case, I think we do have such a choice and since a similar
> mechanism has already been used by mmu_notifiers.
>

Let me take it back. The per-vcpu sequence number in this case has to
be protected by a VM level mmu write lock. I think this might be less
performant than using a per-vcpu mutex.
