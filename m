Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110CA6B14E2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCHWTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjCHWTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:19:07 -0500
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C90770423
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:19:05 -0800 (PST)
Received: from vla3-fd3176e90be6.qloud-c.yandex.net (vla3-fd3176e90be6.qloud-c.yandex.net [IPv6:2a02:6b8:c15:2584:0:640:fd31:76e9])
        by forward501a.mail.yandex.net (Yandex) with ESMTP id DF7285EF80;
        Thu,  9 Mar 2023 01:19:00 +0300 (MSK)
Received: by vla3-fd3176e90be6.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id vIlinqCbCOs1-PIRG8Uyy;
        Thu, 09 Mar 2023 01:18:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1678313939;
        bh=hY99/afLxsURtdLVxU9Hkmxvw2HCLwOpsC5xj/gX3VY=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=eBn4qYnAxKfGPFSTX0WfauAGTJQtkJby3kq2cBzTrDFbA3OQ+6NZ8eeDEuxtJ64SU
         j9FSIaISHaI7pUo+cVLKmm86gul7G3rLVf7H/v4jwVvCPMMkt8EdY/pVr3aDCcmWK/
         8zKJLIl3nsSNRcPuZOgfctBNRRvmSLz78E4AfaxE=
Authentication-Results: vla3-fd3176e90be6.qloud-c.yandex.net; dkim=pass header.i=@ya.ru
Message-ID: <37c59b18-b853-b299-88d0-c9222de39af9@ya.ru>
Date:   Thu, 9 Mar 2023 01:18:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 2/8] mm: vmscan: make global slab shrink lockless
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, shakeelb@google.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com,
        shy828301@gmail.com, rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
 <20230307065605.58209-3-zhengqi.arch@bytedance.com>
From:   Kirill Tkhai <tkhai@ya.ru>
In-Reply-To: <20230307065605.58209-3-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.2023 09:55, Qi Zheng wrote:
> The shrinker_rwsem is a global read-write lock in
> shrinkers subsystem, which protects most operations
> such as slab shrink, registration and unregistration
> of shrinkers, etc. This can easily cause problems in
> the following cases.
> 
> 1) When the memory pressure is high and there are many
>    filesystems mounted or unmounted at the same time,
>    slab shrink will be affected (down_read_trylock()
>    failed).
> 
>    Such as the real workload mentioned by Kirill Tkhai:
> 
>    ```
>    One of the real workloads from my experience is start
>    of an overcommitted node containing many starting
>    containers after node crash (or many resuming containers
>    after reboot for kernel update). In these cases memory
>    pressure is huge, and the node goes round in long reclaim.
>    ```
> 
> 2) If a shrinker is blocked (such as the case mentioned
>    in [1]) and a writer comes in (such as mount a fs),
>    then this writer will be blocked and cause all
>    subsequent shrinker-related operations to be blocked.
> 
> Even if there is no competitor when shrinking slab, there
> may still be a problem. If we have a long shrinker list
> and we do not reclaim enough memory with each shrinker,
> then the down_read_trylock() may be called with high
> frequency. Because of the poor multicore scalability of
> atomic operations, this can lead to a significant drop
> in IPC (instructions per cycle).
> 
> So many times in history ([2],[3],[4],[5]), some people
> wanted to replace shrinker_rwsem trylock with SRCU in
> the slab shrink, but all these patches were abandoned
> because SRCU was not unconditionally enabled.
> 
> But now, since commit 1cd0bd06093c ("rcu: Remove CONFIG_SRCU"),
> the SRCU is unconditionally enabled. So it's time to use
> SRCU to protect readers who previously held shrinker_rwsem.
> 
> This commit uses SRCU to make global slab shrink lockless,
> the memcg slab shrink is handled in the subsequent patch.
> 
> [1]. https://lore.kernel.org/lkml/20191129214541.3110-1-ptikhomirov@virtuozzo.com/
> [2]. https://lore.kernel.org/all/1437080113.3596.2.camel@stgolabs.net/
> [3]. https://lore.kernel.org/lkml/1510609063-3327-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/
> [4]. https://lore.kernel.org/lkml/153365347929.19074.12509495712735843805.stgit@localhost.localdomain/
> [5]. https://lore.kernel.org/lkml/20210927074823.5825-1-sultan@kerneltoast.com/
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Kirill Tkhai <tkhai@ya.ru>
> ---
>  mm/vmscan.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 2dcc01682026..8515ac40bcaf 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -202,6 +202,7 @@ static void set_task_reclaim_state(struct task_struct *task,
>  
>  LIST_HEAD(shrinker_list);
>  DECLARE_RWSEM(shrinker_rwsem);
> +DEFINE_SRCU(shrinker_srcu);
>  
>  #ifdef CONFIG_MEMCG
>  static int shrinker_nr_max;
> @@ -706,7 +707,7 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
>  void register_shrinker_prepared(struct shrinker *shrinker)
>  {
>  	down_write(&shrinker_rwsem);
> -	list_add_tail(&shrinker->list, &shrinker_list);
> +	list_add_tail_rcu(&shrinker->list, &shrinker_list);
>  	shrinker->flags |= SHRINKER_REGISTERED;
>  	shrinker_debugfs_add(shrinker);
>  	up_write(&shrinker_rwsem);
> @@ -760,13 +761,15 @@ void unregister_shrinker(struct shrinker *shrinker)
>  		return;
>  
>  	down_write(&shrinker_rwsem);
> -	list_del(&shrinker->list);
> +	list_del_rcu(&shrinker->list);
>  	shrinker->flags &= ~SHRINKER_REGISTERED;
>  	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>  		unregister_memcg_shrinker(shrinker);
>  	debugfs_entry = shrinker_debugfs_remove(shrinker);
>  	up_write(&shrinker_rwsem);
>  
> +	synchronize_srcu(&shrinker_srcu);
> +
>  	debugfs_remove_recursive(debugfs_entry);
>  
>  	kfree(shrinker->nr_deferred);
> @@ -786,6 +789,7 @@ void synchronize_shrinkers(void)
>  {
>  	down_write(&shrinker_rwsem);
>  	up_write(&shrinker_rwsem);
> +	synchronize_srcu(&shrinker_srcu);
>  }
>  EXPORT_SYMBOL(synchronize_shrinkers);
>  
> @@ -996,6 +1000,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>  {
>  	unsigned long ret, freed = 0;
>  	struct shrinker *shrinker;
> +	int srcu_idx;
>  
>  	/*
>  	 * The root memcg might be allocated even though memcg is disabled
> @@ -1007,10 +1012,10 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>  	if (!mem_cgroup_disabled() && !mem_cgroup_is_root(memcg))
>  		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
>  
> -	if (!down_read_trylock(&shrinker_rwsem))
> -		goto out;
> +	srcu_idx = srcu_read_lock(&shrinker_srcu);
>  
> -	list_for_each_entry(shrinker, &shrinker_list, list) {
> +	list_for_each_entry_srcu(shrinker, &shrinker_list, list,
> +				 srcu_read_lock_held(&shrinker_srcu)) {
>  		struct shrink_control sc = {
>  			.gfp_mask = gfp_mask,
>  			.nid = nid,
> @@ -1021,19 +1026,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>  		if (ret == SHRINK_EMPTY)
>  			ret = 0;
>  		freed += ret;
> -		/*
> -		 * Bail out if someone want to register a new shrinker to
> -		 * prevent the registration from being stalled for long periods
> -		 * by parallel ongoing shrinking.
> -		 */
> -		if (rwsem_is_contended(&shrinker_rwsem)) {
> -			freed = freed ? : 1;
> -			break;
> -		}
>  	}
>  
> -	up_read(&shrinker_rwsem);
> -out:
> +	srcu_read_unlock(&shrinker_srcu, srcu_idx);
>  	cond_resched();
>  	return freed;
>  }

