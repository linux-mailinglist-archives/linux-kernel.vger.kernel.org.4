Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE53069E9A9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjBUVnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBUVnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:43:15 -0500
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5792E13531
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 13:43:14 -0800 (PST)
Received: from iva8-4b0477eb80e1.qloud-c.yandex.net (iva8-4b0477eb80e1.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:77a0:0:640:4b04:77eb])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id 4AF535F21B;
        Wed, 22 Feb 2023 00:43:12 +0300 (MSK)
Received: by iva8-4b0477eb80e1.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 8h0Gn7qZT0U1-T0guPg09;
        Wed, 22 Feb 2023 00:43:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1677015791;
        bh=M5n7hxG8rqSZzlJ5gYoNsEFwQqw42nKDSzu3D5Gerus=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=LQlaA59p0RbFCQ+olIIBiXGZIDresS0uWxVGYxPN8SOMdc7xn9U2SqSdmwz1bqoYi
         gcMeS4VQergPZHp8RW1jmdmom6w04Wkt42k22EVanarpVQuTUuyQ5o4jgPs0NJiAwM
         TgktLjqxlpKXX04FelV9QUZRz8YNlyUqpqK3rDSI=
Authentication-Results: iva8-4b0477eb80e1.qloud-c.yandex.net; dkim=pass header.i=@ya.ru
Message-ID: <dc279728-4cd4-0453-1a28-fe076f254641@ya.ru>
Date:   Wed, 22 Feb 2023 00:43:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/5] mm: vmscan: make memcg slab shrink lockless
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, shakeelb@google.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com,
        shy828301@gmail.com
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230220091637.64865-1-zhengqi.arch@bytedance.com>
 <20230220091637.64865-3-zhengqi.arch@bytedance.com>
From:   Kirill Tkhai <tkhai@ya.ru>
In-Reply-To: <20230220091637.64865-3-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.02.2023 12:16, Qi Zheng wrote:
> Like global slab shrink, since commit 1cd0bd06093c
> ("rcu: Remove CONFIG_SRCU"), it's time to use SRCU
> to protect readers who previously held shrinker_rwsem.
> 
> We can test with the following script:
> 
> ```
> DIR="/root/shrinker/memcg/mnt"
> 
> do_create()
> {
>         mkdir /sys/fs/cgroup/memory/test
>         echo 200M > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
>         for i in `seq 0 $1`;
>         do
>                 mkdir /sys/fs/cgroup/memory/test/$i;
>                 echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
>                 mkdir -p $DIR/$i;
>         done
> }
> 
> do_mount()
> {
>         for i in `seq $1 $2`;
>         do
>                 mount -t tmpfs $i $DIR/$i;
>         done
> }
> 
> do_touch()
> {
>         for i in `seq $1 $2`;
>         do
>                 echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
>                 dd if=/dev/zero of=$DIR/$i/file$i bs=1M count=1 &
>         done
> }
> 
> do_create 2000
> do_mount 0 2000
> do_touch 0 1000
> ```
> 
> Before applying:
> 
>   46.60%  [kernel]  [k] down_read_trylock
>   18.70%  [kernel]  [k] up_read
>   15.44%  [kernel]  [k] shrink_slab
>    4.37%  [kernel]  [k] _find_next_bit
>    2.75%  [kernel]  [k] xa_load
>    2.07%  [kernel]  [k] idr_find
>    1.73%  [kernel]  [k] do_shrink_slab
>    1.42%  [kernel]  [k] shrink_lruvec
>    0.74%  [kernel]  [k] shrink_node
>    0.60%  [kernel]  [k] list_lru_count_one
> 
> After applying:
> 
>   19.53%  [kernel]  [k] _find_next_bit
>   14.63%  [kernel]  [k] do_shrink_slab
>   14.58%  [kernel]  [k] shrink_slab
>   11.83%  [kernel]  [k] shrink_lruvec
>    9.33%  [kernel]  [k] __blk_flush_plug
>    6.67%  [kernel]  [k] mem_cgroup_iter
>    3.73%  [kernel]  [k] list_lru_count_one
>    2.43%  [kernel]  [k] shrink_node
>    1.96%  [kernel]  [k] super_cache_count
>    1.78%  [kernel]  [k] __rcu_read_unlock
>    1.38%  [kernel]  [k] __srcu_read_lock
>    1.30%  [kernel]  [k] xas_descend
> 
> We can see that the readers is no longer blocked.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  mm/vmscan.c | 56 ++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 32 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 95a3d6ddc6c1..dc47396ecd0e 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -57,6 +57,7 @@
>  #include <linux/khugepaged.h>
>  #include <linux/rculist_nulls.h>
>  #include <linux/random.h>
> +#include <linux/srcu.h>
>  
>  #include <asm/tlbflush.h>
>  #include <asm/div64.h>
> @@ -221,8 +222,21 @@ static inline int shrinker_defer_size(int nr_items)
>  static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
>  						     int nid)
>  {
> -	return rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_info,
> -					 lockdep_is_held(&shrinker_rwsem));
> +	return srcu_dereference_check(memcg->nodeinfo[nid]->shrinker_info,
> +				      &shrinker_srcu,
> +				      lockdep_is_held(&shrinker_rwsem));
> +}
> +
> +static struct shrinker_info *shrinker_info_srcu(struct mem_cgroup *memcg,
> +						     int nid)
> +{
> +	return srcu_dereference(memcg->nodeinfo[nid]->shrinker_info,
> +				&shrinker_srcu);
> +}
> +
> +static void free_shrinker_info_rcu(struct rcu_head *head)
> +{
> +	kvfree(container_of(head, struct shrinker_info, rcu));
>  }
>  
>  static int expand_one_shrinker_info(struct mem_cgroup *memcg,
> @@ -257,7 +271,7 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>  		       defer_size - old_defer_size);
>  
>  		rcu_assign_pointer(pn->shrinker_info, new);
> -		kvfree_rcu(old, rcu);
> +		call_srcu(&shrinker_srcu, &old->rcu, free_shrinker_info_rcu);
>  	}
>  
>  	return 0;
> @@ -350,13 +364,14 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
>  {
>  	if (shrinker_id >= 0 && memcg && !mem_cgroup_is_root(memcg)) {
>  		struct shrinker_info *info;
> +		int srcu_idx;
>  
> -		rcu_read_lock();
> -		info = rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
> +		srcu_idx = srcu_read_lock(&shrinker_srcu);
> +		info = shrinker_info_srcu(memcg, nid);
>  		/* Pairs with smp mb in shrink_slab() */
>  		smp_mb__before_atomic();
>  		set_bit(shrinker_id, info->map);
> -		rcu_read_unlock();
> +		srcu_read_unlock(&shrinker_srcu, srcu_idx);
>  	}
>  }
>  
> @@ -370,7 +385,6 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  		return -ENOSYS;
>  
>  	down_write(&shrinker_rwsem);
> -	/* This may call shrinker, so it must use down_read_trylock() */
>  	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
>  	if (id < 0)
>  		goto unlock;
> @@ -404,7 +418,7 @@ static long xchg_nr_deferred_memcg(int nid, struct shrinker *shrinker,
>  {
>  	struct shrinker_info *info;
>  
> -	info = shrinker_info_protected(memcg, nid);
> +	info = shrinker_info_srcu(memcg, nid);
>  	return atomic_long_xchg(&info->nr_deferred[shrinker->id], 0);
>  }
>  
> @@ -413,13 +427,13 @@ static long add_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
>  {
>  	struct shrinker_info *info;
>  
> -	info = shrinker_info_protected(memcg, nid);
> +	info = shrinker_info_srcu(memcg, nid);
>  	return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
>  }
>  
>  void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>  {
> -	int i, nid;
> +	int i, nid, srcu_idx;
>  	long nr;
>  	struct mem_cgroup *parent;
>  	struct shrinker_info *child_info, *parent_info;
> @@ -429,16 +443,16 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>  		parent = root_mem_cgroup;
>  
>  	/* Prevent from concurrent shrinker_info expand */
> -	down_read(&shrinker_rwsem);
> +	srcu_idx = srcu_read_lock(&shrinker_srcu);
>  	for_each_node(nid) {
> -		child_info = shrinker_info_protected(memcg, nid);
> -		parent_info = shrinker_info_protected(parent, nid);
> +		child_info = shrinker_info_srcu(memcg, nid);
> +		parent_info = shrinker_info_srcu(parent, nid);
>  		for (i = 0; i < shrinker_nr_max; i++) {
>  			nr = atomic_long_read(&child_info->nr_deferred[i]);
>  			atomic_long_add(nr, &parent_info->nr_deferred[i]);
>  		}
>  	}
> -	up_read(&shrinker_rwsem);
> +	srcu_read_unlock(&shrinker_srcu, srcu_idx);
>  }
>  
>  static bool cgroup_reclaim(struct scan_control *sc)
> @@ -891,15 +905,14 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  {
>  	struct shrinker_info *info;
>  	unsigned long ret, freed = 0;
> +	int srcu_idx;
>  	int i;
>  
>  	if (!mem_cgroup_online(memcg))
>  		return 0;
>  
> -	if (!down_read_trylock(&shrinker_rwsem))
> -		return 0;
> -
> -	info = shrinker_info_protected(memcg, nid);
> +	srcu_idx = srcu_read_lock(&shrinker_srcu);
> +	info = shrinker_info_srcu(memcg, nid);
>  	if (unlikely(!info))
>  		goto unlock;

There is shrinker_nr_max dereference under this hunk. It's not in the patch:

        for_each_set_bit(i, info->map, shrinker_nr_max) {

Since shrinker_nr_max may grow in parallel, this leads to access beyond allocated memory :(

It looks like we should save size of info->map as a new member of struct shrinker_info.

>  
> @@ -949,14 +962,9 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  				set_shrinker_bit(memcg, nid, i);
>  		}
>  		freed += ret;
> -
> -		if (rwsem_is_contended(&shrinker_rwsem)) {
> -			freed = freed ? : 1;
> -			break;
> -		}
>  	}
>  unlock:
> -	up_read(&shrinker_rwsem);
> +	srcu_read_unlock(&shrinker_srcu, srcu_idx);
>  	return freed;
>  }
>  #else /* CONFIG_MEMCG */

