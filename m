Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555AB6A1079
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjBWTTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjBWTT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:19:28 -0500
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD4B7AB6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:19:03 -0800 (PST)
Received: by mail-pl1-f179.google.com with SMTP id e5so15301353plg.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrDbc2k6dHq49jd/0bWQFvbkM3baJVJZ0ywNA18okhQ=;
        b=4UEe4IldPE4vP66UR3ho72lCNjibXsEPTlYebkDbzqiQgdmg2RLJtUFAQ2IRrEk35v
         XPSPDVHRY9rd/fBWtN3Y9SmC4Fadt6RoXHnO1lnM9aglYFfQxi9IXzgUTGnPl1EPsTpC
         7TBBLIzpNONK93rrY/nqS3K/MZ4540LClvB6gdhuFX7UkoxnxihnDtaxFUSIaZFUzyWB
         tBwQWXJjOF6yWbjKjOc5rlRif8dQ5U6g8pVXOHYAyCErYOvcw6ZNX/6iX+FX89jzLZmq
         kCTFC/2dz55JwxX+D/ukRDQcEEvG6yqMU77otJv6Ncg35E/BASGaXl92UDmZg2+87U+k
         xUOg==
X-Gm-Message-State: AO0yUKVf7V2tO+JnImcH6YkFp7Fq+SSvGfo3gOUiCEHLacdy/tIAIVSZ
        zjy8AUOtSyCtOiGfW/iC0KkxLKEiz9s=
X-Google-Smtp-Source: AK7set+NSX1qvM24M8xjtEb054woZ0M+5yNfXTY2mTog6ZuAXdT+VlTWwD+5yI1fuGP6Z+tgqbuGAQ==
X-Received: by 2002:a17:902:c406:b0:19a:8fb9:5af1 with SMTP id k6-20020a170902c40600b0019a8fb95af1mr17347708plk.36.1677179893763;
        Thu, 23 Feb 2023 11:18:13 -0800 (PST)
Received: from sultan-box.localdomain ([142.147.89.230])
        by smtp.gmail.com with ESMTPSA id ja4-20020a170902efc400b001948ff5cc32sm13544226plb.215.2023.02.23.11.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 11:18:13 -0800 (PST)
Date:   Thu, 23 Feb 2023 11:18:10 -0800
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tkhai@ya.ru, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com, dave@stgolabs.net,
        penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] mm: vmscan: make global slab shrink lockless
Message-ID: <Y/e78vGspH9KsuIp@sultan-box.localdomain>
References: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
 <20230223132725.11685-3-zhengqi.arch@bytedance.com>
 <Y/evb+PBeaahx9Os@sultan-box.localdomain>
 <20230223183917.GG2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223183917.GG2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 10:39:17AM -0800, Paul E. McKenney wrote:
> On Thu, Feb 23, 2023 at 10:24:47AM -0800, Sultan Alsawaf wrote:
> > On Thu, Feb 23, 2023 at 09:27:20PM +0800, Qi Zheng wrote:
> > > The shrinker_rwsem is a global lock in shrinkers subsystem,
> > > it is easy to cause blocking in the following cases:
> > > 
> > > a. the write lock of shrinker_rwsem was held for too long.
> > >    For example, there are many memcgs in the system, which
> > >    causes some paths to hold locks and traverse it for too
> > >    long. (e.g. expand_shrinker_info())
> > > b. the read lock of shrinker_rwsem was held for too long,
> > >    and a writer came at this time. Then this writer will be
> > >    forced to wait and block all subsequent readers.
> > >    For example:
> > >    - be scheduled when the read lock of shrinker_rwsem is
> > >      held in do_shrink_slab()
> > >    - some shrinker are blocked for too long. Like the case
> > >      mentioned in the patchset[1].
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
> > >  mm/vmscan.c | 27 +++++++++++----------------
> > >  1 file changed, 11 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index 9f895ca6216c..02987a6f95d1 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -202,6 +202,7 @@ static void set_task_reclaim_state(struct task_struct *task,
> > >  
> > >  LIST_HEAD(shrinker_list);
> > >  DECLARE_RWSEM(shrinker_rwsem);
> > > +DEFINE_SRCU(shrinker_srcu);
> > >  
> > >  #ifdef CONFIG_MEMCG
> > >  static int shrinker_nr_max;
> > > @@ -706,7 +707,7 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
> > >  void register_shrinker_prepared(struct shrinker *shrinker)
> > >  {
> > >  	down_write(&shrinker_rwsem);
> > > -	list_add_tail(&shrinker->list, &shrinker_list);
> > > +	list_add_tail_rcu(&shrinker->list, &shrinker_list);
> > >  	shrinker->flags |= SHRINKER_REGISTERED;
> > >  	shrinker_debugfs_add(shrinker);
> > >  	up_write(&shrinker_rwsem);
> > > @@ -760,13 +761,15 @@ void unregister_shrinker(struct shrinker *shrinker)
> > >  		return;
> > >  
> > >  	down_write(&shrinker_rwsem);
> > > -	list_del(&shrinker->list);
> > > +	list_del_rcu(&shrinker->list);
> > >  	shrinker->flags &= ~SHRINKER_REGISTERED;
> > >  	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> > >  		unregister_memcg_shrinker(shrinker);
> > >  	debugfs_entry = shrinker_debugfs_remove(shrinker);
> > >  	up_write(&shrinker_rwsem);
> > >  
> > > +	synchronize_srcu(&shrinker_srcu);
> > > +
> > >  	debugfs_remove_recursive(debugfs_entry);
> > >  
> > >  	kfree(shrinker->nr_deferred);
> > > @@ -786,6 +789,7 @@ void synchronize_shrinkers(void)
> > >  {
> > >  	down_write(&shrinker_rwsem);
> > >  	up_write(&shrinker_rwsem);
> > > +	synchronize_srcu(&shrinker_srcu);
> > >  }
> > >  EXPORT_SYMBOL(synchronize_shrinkers);
> > >  
> > > @@ -996,6 +1000,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
> > >  {
> > >  	unsigned long ret, freed = 0;
> > >  	struct shrinker *shrinker;
> > > +	int srcu_idx;
> > >  
> > >  	/*
> > >  	 * The root memcg might be allocated even though memcg is disabled
> > > @@ -1007,10 +1012,10 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
> > >  	if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
> > >  		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
> > >  
> > > -	if (!down_read_trylock(&shrinker_rwsem))
> > > -		goto out;
> > > +	srcu_idx = srcu_read_lock(&shrinker_srcu);
> > >  
> > > -	list_for_each_entry(shrinker, &shrinker_list, list) {
> > > +	list_for_each_entry_srcu(shrinker, &shrinker_list, list,
> > > +				 srcu_read_lock_held(&shrinker_srcu)) {
> > >  		struct shrink_control sc = {
> > >  			.gfp_mask = gfp_mask,
> > >  			.nid = nid,
> > > @@ -1021,19 +1026,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
> > >  		if (ret == SHRINK_EMPTY)
> > >  			ret = 0;
> > >  		freed += ret;
> > > -		/*
> > > -		 * Bail out if someone want to register a new shrinker to
> > > -		 * prevent the registration from being stalled for long periods
> > > -		 * by parallel ongoing shrinking.
> > > -		 */
> > > -		if (rwsem_is_contended(&shrinker_rwsem)) {
> > > -			freed = freed ? : 1;
> > > -			break;
> > > -		}
> > >  	}
> > >  
> > > -	up_read(&shrinker_rwsem);
> > > -out:
> > > +	srcu_read_unlock(&shrinker_srcu, srcu_idx);
> > >  	cond_resched();
> > >  	return freed;
> > >  }
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
> > 
> > Although I never got around to submitting it, I made a non-SRCU solution [1]
> > that uses fine-grained locking instead, which is fair to both the register path
> > and unregister path. (The patch I've linked is a version of this adapted to an
> > older 4.14 kernel FYI, but it can be reworked for the current kernel.)
> > 
> > What do you think about the fine-grained locking approach?
> 
> Another approach is to use synchronize_srcu_expedited(), which avoids
> the sleeps that are otherwise used to encourage sharing of grace periods
> among concurrent requests.  It might be possible to use call_srcu(),
> but I don't claim to know the shrinker code well enough to say for sure.

Hi Paul,

I don't believe call_srcu() can be used since shrinker users need to be
guaranteed that their shrinkers aren't in use after unregister_shrinker().

Using synchronize_srcu_expedited() sounds like it'd definitely help, though
unregistering a single shrinker would ultimately still require waiting for all
shrinkers to finish running before the grace period can elapse. There can be
many shrinkers and they're not very fast I think.

Thanks,
Sultan

> 
> 							Thanx, Paul
> 
> > Thanks,
> > Sultan
> > 
> > [1] https://github.com/kerneltoast/android_kernel_google_floral/commit/012378f3173a82d2333d3ae7326691544301e76a
> 
