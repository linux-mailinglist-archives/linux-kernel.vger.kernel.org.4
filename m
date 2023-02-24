Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21806A17CE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 09:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjBXIUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 03:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBXIUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 03:20:18 -0500
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E796C14E83
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 00:20:16 -0800 (PST)
Received: by mail-pj1-f52.google.com with SMTP id nw10-20020a17090b254a00b00233d7314c1cso1982480pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 00:20:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSPxndrx+ztdRUQfIIoj5xs34XMHs7tigbiGxN/UUsQ=;
        b=Ol5kgUASl4bqMws73aRE+eRLQTBBpkgAObQQd1macc79QXlmj3syYzKceq4UiA8Vbm
         L3sLsMiBkyPvc2EZ3XwGwylhCyTXojRO0oN783EXhI/1xznTNBI91SV7kNeL2t0Mmrxb
         YO3bKFxlYLwMAd5NPqUTcBhH+JQ9OunOGdjWPg7huP/JDYc6RyH4I+MKz5ZfcqayFQuf
         g2nKekFjVFoZA3gS+eeRbF4a3f3MJTtWpCij0yZ6t2v/0A5AEuGqfzikuhCVumR55F2d
         +SxAN6jqwLiaHFOyVNbg9RP1MUqkdeWf9GNeLCpLNeMbL9RAWjKaGjvRrk8mEhxlkuNe
         +fpw==
X-Gm-Message-State: AO0yUKVC0M1QjCjf6pmg7zUlKRdTD9QjveXbIqDcRHSVW4wf5SKIPI7T
        deJ8SdaGkrR0mQ/frXAJ85w=
X-Google-Smtp-Source: AK7set8LCY6i9yowASOkkSDw1hKpSBcBDDhgMNWgaB9BdUQgt2Ur4tAlUfixKnWsMbYI/vbsR/de3Q==
X-Received: by 2002:a05:6a20:244c:b0:cb:c276:589a with SMTP id t12-20020a056a20244c00b000cbc276589amr11020625pzc.0.1677226816198;
        Fri, 24 Feb 2023 00:20:16 -0800 (PST)
Received: from sultan-box.localdomain ([142.147.89.230])
        by smtp.gmail.com with ESMTPSA id m9-20020aa78a09000000b005a8ba70315bsm7614312pfa.6.2023.02.24.00.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 00:20:15 -0800 (PST)
Date:   Fri, 24 Feb 2023 00:20:12 -0800
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com,
        dave@stgolabs.net, penguin-kernel@i-love.sakura.ne.jp,
        paulmck@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] mm: vmscan: make global slab shrink lockless
Message-ID: <Y/hzPP0G5AFhOmsY@sultan-box.localdomain>
References: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
 <20230223132725.11685-3-zhengqi.arch@bytedance.com>
 <Y/evb+PBeaahx9Os@sultan-box.localdomain>
 <8049b6ed-435f-b518-f947-5516a514aec2@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8049b6ed-435f-b518-f947-5516a514aec2@bytedance.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 12:00:21PM +0800, Qi Zheng wrote:
> 
> 
> On 2023/2/24 02:24, Sultan Alsawaf wrote:
> > On Thu, Feb 23, 2023 at 09:27:20PM +0800, Qi Zheng wrote:
> > > The shrinker_rwsem is a global lock in shrinkers subsystem,
> > > it is easy to cause blocking in the following cases:
> > > 
> > > a. the write lock of shrinker_rwsem was held for too long.
> > >     For example, there are many memcgs in the system, which
> > >     causes some paths to hold locks and traverse it for too
> > >     long. (e.g. expand_shrinker_info())
> > > b. the read lock of shrinker_rwsem was held for too long,
> > >     and a writer came at this time. Then this writer will be
> > >     forced to wait and block all subsequent readers.
> > >     For example:
> > >     - be scheduled when the read lock of shrinker_rwsem is
> > >       held in do_shrink_slab()
> > >     - some shrinker are blocked for too long. Like the case
> > >       mentioned in the patchset[1].
> > > 
> > > Therefore, many times in history ([2],[3],[4],[5]), some
> > > people wanted to replace shrinker_rwsem reader with SRCU,
> > > but they all gave up because SRCU was not unconditionally
> > > enabled.
> > > 
> > > But now, since commit 1cd0bd06093c ("rcu: Remove CONFIG_SRCU"),
> > > the SRCU is unconditionally enabled. So it's time to use
> > > SRCU to protect readers who previously held shrinker_rwsem.
> > > 
> > > [1]. https://lore.kernel.org/lkml/20191129214541.3110-1-ptikhomirov@virtuozzo.com/
> > > [2]. https://lore.kernel.org/all/1437080113.3596.2.camel@stgolabs.net/
> > > [3]. https://lore.kernel.org/lkml/1510609063-3327-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/
> > > [4]. https://lore.kernel.org/lkml/153365347929.19074.12509495712735843805.stgit@localhost.localdomain/
> > > [5]. https://lore.kernel.org/lkml/20210927074823.5825-1-sultan@kerneltoast.com/
> > > 
> > > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > > ---
> > >   mm/vmscan.c | 27 +++++++++++----------------
> > >   1 file changed, 11 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index 9f895ca6216c..02987a6f95d1 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -202,6 +202,7 @@ static void set_task_reclaim_state(struct task_struct *task,
> > >   LIST_HEAD(shrinker_list);
> > >   DECLARE_RWSEM(shrinker_rwsem);
> > > +DEFINE_SRCU(shrinker_srcu);
> > >   #ifdef CONFIG_MEMCG
> > >   static int shrinker_nr_max;
> > > @@ -706,7 +707,7 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
> > >   void register_shrinker_prepared(struct shrinker *shrinker)
> > >   {
> > >   	down_write(&shrinker_rwsem);
> > > -	list_add_tail(&shrinker->list, &shrinker_list);
> > > +	list_add_tail_rcu(&shrinker->list, &shrinker_list);
> > >   	shrinker->flags |= SHRINKER_REGISTERED;
> > >   	shrinker_debugfs_add(shrinker);
> > >   	up_write(&shrinker_rwsem);
> > > @@ -760,13 +761,15 @@ void unregister_shrinker(struct shrinker *shrinker)
> > >   		return;
> > >   	down_write(&shrinker_rwsem);
> > > -	list_del(&shrinker->list);
> > > +	list_del_rcu(&shrinker->list);
> > >   	shrinker->flags &= ~SHRINKER_REGISTERED;
> > >   	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> > >   		unregister_memcg_shrinker(shrinker);
> > >   	debugfs_entry = shrinker_debugfs_remove(shrinker);
> > >   	up_write(&shrinker_rwsem);
> > > +	synchronize_srcu(&shrinker_srcu);
> > > +
> > >   	debugfs_remove_recursive(debugfs_entry);
> > >   	kfree(shrinker->nr_deferred);
> > > @@ -786,6 +789,7 @@ void synchronize_shrinkers(void)
> > >   {
> > >   	down_write(&shrinker_rwsem);
> > >   	up_write(&shrinker_rwsem);
> > > +	synchronize_srcu(&shrinker_srcu);
> > >   }
> > >   EXPORT_SYMBOL(synchronize_shrinkers);
> > > @@ -996,6 +1000,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
> > >   {
> > >   	unsigned long ret, freed = 0;
> > >   	struct shrinker *shrinker;
> > > +	int srcu_idx;
> > >   	/*
> > >   	 * The root memcg might be allocated even though memcg is disabled
> > > @@ -1007,10 +1012,10 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
> > >   	if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
> > >   		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
> > > -	if (!down_read_trylock(&shrinker_rwsem))
> > > -		goto out;
> > > +	srcu_idx = srcu_read_lock(&shrinker_srcu);
> > > -	list_for_each_entry(shrinker, &shrinker_list, list) {
> > > +	list_for_each_entry_srcu(shrinker, &shrinker_list, list,
> > > +				 srcu_read_lock_held(&shrinker_srcu)) {
> > >   		struct shrink_control sc = {
> > >   			.gfp_mask = gfp_mask,
> > >   			.nid = nid,
> > > @@ -1021,19 +1026,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
> > >   		if (ret == SHRINK_EMPTY)
> > >   			ret = 0;
> > >   		freed += ret;
> > > -		/*
> > > -		 * Bail out if someone want to register a new shrinker to
> > > -		 * prevent the registration from being stalled for long periods
> > > -		 * by parallel ongoing shrinking.
> > > -		 */
> > > -		if (rwsem_is_contended(&shrinker_rwsem)) {
> > > -			freed = freed ? : 1;
> > > -			break;
> > > -		}
> > >   	}
> > > -	up_read(&shrinker_rwsem);
> > > -out:
> > > +	srcu_read_unlock(&shrinker_srcu, srcu_idx);
> > >   	cond_resched();
> > >   	return freed;
> > >   }
> > > -- 
> > > 2.20.1
> > > 
> > > 
> > 
> > Hi Qi,
> > 
> > A different problem I realized after my old attempt to use SRCU was that the
> > unregister_shrinker() path became quite slow due to the heavy synchronize_srcu()
> > call. Both register_shrinker() *and* unregister_shrinker() are called frequently
> > these days, and SRCU is too unfair to the unregister path IMO.
> 
> Hi Sultan,
> 
> IIUC, for unregister_shrinker(), the wait time is hardly longer with
> SRCU than with shrinker_rwsem before.

The wait time can be quite different because with shrinker_rwsem, the
rwsem_is_contended() bailout would cause unregister_shrinker() to wait for only
one random shrinker to finish at worst rather than waiting for *all* shrinkers
to finish.

> And I just did a simple test. After using the script in cover letter to
> increase the shrink_slab hotspot, I did umount 1k times at the same
> time, and then I used bpftrace to measure the time consumption of
> unregister_shrinker() as follows:
> 
> bpftrace -e 'kprobe:unregister_shrinker { @start[tid] = nsecs; }
> kretprobe:unregister_shrinker /@start[tid]/ { @ns[comm] = hist(nsecs -
> @start[tid]); delete(@start[tid]); }'
> 
> @ns[umount]:
> [16K, 32K)             3 |      |
> [32K, 64K)            66 |@@@@@@@@@@      |
> [64K, 128K)           32 |@@@@@      |
> [128K, 256K)          22 |@@@      |
> [256K, 512K)          48 |@@@@@@@      |
> [512K, 1M)            19 |@@@      |
> [1M, 2M)             131 |@@@@@@@@@@@@@@@@@@@@@      |
> [2M, 4M)             313
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [4M, 8M)             302 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
> |
> [8M, 16M)             55 |@@@@@@@@@
> 
> I see that the highest time-consuming of unregister_shrinker() is between
> 8ms and 16ms, which feels tolerable?

If you've got a fast x86 machine then I'd say that's a bit slow. :)

This depends a lot on which shrinkers are active on your system and how much
work each one does upon running. If a driver's shrinker doesn't have much to do
because there's nothing it can shrink further, then it'll run fast. Conversely,
if a driver is stressed in a way that constantly creates a lot of potential work
for its shrinker, then the shrinker will run longer.

Since shrinkers are allowed to sleep, the delays can really add up when waiting
for all of them to finish running. In the past, I recall observing delays of
100ms+ in unregister_shrinker() on slower arm64 hardware when I stress tested
the SRCU approach.

If your GPU driver has a shrinker (such as i915), I suggest testing again under
heavy GPU load. The GPU shrinkers can be pretty heavy IIRC.

Thanks,
Sultan

> Thanks,
> Qi
> 
> > 
> > Although I never got around to submitting it, I made a non-SRCU solution [1]
> > that uses fine-grained locking instead, which is fair to both the register path
> > and unregister path. (The patch I've linked is a version of this adapted to an
> > older 4.14 kernel FYI, but it can be reworked for the current kernel.)
> > 
> > What do you think about the fine-grained locking approach?
> > 
> > Thanks,
> > Sultan
> > 
> > [1] https://github.com/kerneltoast/android_kernel_google_floral/commit/012378f3173a82d2333d3ae7326691544301e76a
> > 
> 
> -- 
> Thanks,
> Qi
