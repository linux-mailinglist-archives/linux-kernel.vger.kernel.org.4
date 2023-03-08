Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2006B1506
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjCHWYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjCHWYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:24:03 -0500
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E3B9FBFF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:24:00 -0800 (PST)
Received: from vla5-91e5293da019.qloud-c.yandex.net (vla5-91e5293da019.qloud-c.yandex.net [IPv6:2a02:6b8:c18:3e1f:0:640:91e5:293d])
        by forward502a.mail.yandex.net (Yandex) with ESMTP id E25895EB20;
        Thu,  9 Mar 2023 01:23:58 +0300 (MSK)
Received: by vla5-91e5293da019.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id tNlKRrCi8Sw1-yeAXX8E7;
        Thu, 09 Mar 2023 01:23:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1678314238;
        bh=7rTQWy13nXbp1SNgDOJhpntEMW/bnfg1ejIlIn2Fn/E=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=WWqcbqPjqBUu0BVkGoTVi5+kGYeVuXAQrfu+Ui0HevmJDisIuJxuuoU6m/IHGK3MO
         VLiv6xz7oS+GuLAVyTzgUVEopty2nCZ8hpsU0UpDUbMn9yMmTVtBZqaaDJc0FYHZsb
         h2ykAz9jLbPgMdajeLC80SNVnPPFOoR67NZbKKkU=
Authentication-Results: vla5-91e5293da019.qloud-c.yandex.net; dkim=pass header.i=@ya.ru
Message-ID: <a79f38c0-e337-723f-7b9f-21d03f714881@ya.ru>
Date:   Thu, 9 Mar 2023 01:23:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 3/8] mm: vmscan: make memcg slab shrink lockless
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, shakeelb@google.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com,
        shy828301@gmail.com, rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
 <20230307065605.58209-4-zhengqi.arch@bytedance.com>
From:   Kirill Tkhai <tkhai@ya.ru>
In-Reply-To: <20230307065605.58209-4-zhengqi.arch@bytedance.com>
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

On 07.03.2023 09:56, Qi Zheng wrote:
> Like global slab shrink, this commit also uses SRCU to make
> memcg slab shrink lockless.
> 
> We can reproduce the down_read_trylock() hotspot through the
> following script:
> 
> ```
> 
> DIR="/root/shrinker/memcg/mnt"
> 
> do_create()
> {
>     mkdir -p /sys/fs/cgroup/memory/test
>     mkdir -p /sys/fs/cgroup/perf_event/test
>     echo 4G > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
>     for i in `seq 0 $1`;
>     do
>         mkdir -p /sys/fs/cgroup/memory/test/$i;
>         echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
>         echo $$ > /sys/fs/cgroup/perf_event/test/cgroup.procs;
>         mkdir -p $DIR/$i;
>     done
> }
> 
> do_mount()
> {
>     for i in `seq $1 $2`;
>     do
>         mount -t tmpfs $i $DIR/$i;
>     done
> }
> 
> do_touch()
> {
>     for i in `seq $1 $2`;
>     do
>         echo $$ > /sys/fs/cgroup/memory/test/$i/cgroup.procs;
>         echo $$ > /sys/fs/cgroup/perf_event/test/cgroup.procs;
>             dd if=/dev/zero of=$DIR/$i/file$i bs=1M count=1 &
>     done
> }
> 
> case "$1" in
>   touch)
>     do_touch $2 $3
>     ;;
>   test)
>       do_create 4000
>     do_mount 0 4000
>     do_touch 0 3000
>     ;;
>   *)
>     exit 1
>     ;;
> esac
> ```
> 
> Save the above script, then run test and touch commands.
> Then we can use the following perf command to view hotspots:
> 
> perf top -U -F 999
> 
> 1) Before applying this patchset:
> 
>   32.31%  [kernel]           [k] down_read_trylock
>   19.40%  [kernel]           [k] pv_native_safe_halt
>   16.24%  [kernel]           [k] up_read
>   15.70%  [kernel]           [k] shrink_slab
>    4.69%  [kernel]           [k] _find_next_bit
>    2.62%  [kernel]           [k] shrink_node
>    1.78%  [kernel]           [k] shrink_lruvec
>    0.76%  [kernel]           [k] do_shrink_slab
> 
> 2) After applying this patchset:
> 
>   27.83%  [kernel]           [k] _find_next_bit
>   16.97%  [kernel]           [k] shrink_slab
>   15.82%  [kernel]           [k] pv_native_safe_halt
>    9.58%  [kernel]           [k] shrink_node
>    8.31%  [kernel]           [k] shrink_lruvec
>    5.64%  [kernel]           [k] do_shrink_slab
>    3.88%  [kernel]           [k] mem_cgroup_iter
> 
> At the same time, we use the following perf command to capture
> IPC information:
> 
> perf stat -e cycles,instructions -G test -a --repeat 5 -- sleep 10
> 
> 1) Before applying this patchset:
> 
>  Performance counter stats for 'system wide' (5 runs):
> 
>       454187219766      cycles                    test                    ( +-  1.84% )
>        78896433101      instructions              test #    0.17  insn per cycle           ( +-  0.44% )
> 
>         10.0020430 +- 0.0000366 seconds time elapsed  ( +-  0.00% )
> 
> 2) After applying this patchset:
> 
>  Performance counter stats for 'system wide' (5 runs):
> 
>       841954709443      cycles                    test                    ( +- 15.80% )  (98.69%)
>       527258677936      instructions              test #    0.63  insn per cycle           ( +- 15.11% )  (98.68%)
> 
>           10.01064 +- 0.00831 seconds time elapsed  ( +-  0.08% )
> 
> We can see that IPC drops very seriously when calling
> down_read_trylock() at high frequency. After using SRCU,
> the IPC is at a normal level.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Kirill Tkhai <tkhai@ya.ru>

> ---
>  mm/vmscan.c | 46 +++++++++++++++++++++++++++-------------------
>  1 file changed, 27 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 8515ac40bcaf..1de9bc3e5aa2 100644
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
>  static inline bool need_expand(int new_nr_max, int old_nr_max)
> @@ -269,7 +283,7 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>  		       defer_size - old_defer_size);
>  
>  		rcu_assign_pointer(pn->shrinker_info, new);
> -		kvfree_rcu(old, rcu);
> +		call_srcu(&shrinker_srcu, &old->rcu, free_shrinker_info_rcu);
>  	}
>  
>  	return 0;
> @@ -355,15 +369,16 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
>  {
>  	if (shrinker_id >= 0 && memcg && !mem_cgroup_is_root(memcg)) {
>  		struct shrinker_info *info;
> +		int srcu_idx;
>  
> -		rcu_read_lock();
> -		info = rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
> +		srcu_idx = srcu_read_lock(&shrinker_srcu);
> +		info = shrinker_info_srcu(memcg, nid);
>  		if (!WARN_ON_ONCE(shrinker_id >= info->map_nr_max)) {
>  			/* Pairs with smp mb in shrink_slab() */
>  			smp_mb__before_atomic();
>  			set_bit(shrinker_id, info->map);
>  		}
> -		rcu_read_unlock();
> +		srcu_read_unlock(&shrinker_srcu, srcu_idx);
>  	}
>  }
>  
> @@ -377,7 +392,6 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  		return -ENOSYS;
>  
>  	down_write(&shrinker_rwsem);
> -	/* This may call shrinker, so it must use down_read_trylock() */
>  	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
>  	if (id < 0)
>  		goto unlock;
> @@ -411,7 +425,7 @@ static long xchg_nr_deferred_memcg(int nid, struct shrinker *shrinker,
>  {
>  	struct shrinker_info *info;
>  
> -	info = shrinker_info_protected(memcg, nid);
> +	info = shrinker_info_srcu(memcg, nid);
>  	return atomic_long_xchg(&info->nr_deferred[shrinker->id], 0);
>  }
>  
> @@ -420,7 +434,7 @@ static long add_nr_deferred_memcg(long nr, int nid, struct shrinker *shrinker,
>  {
>  	struct shrinker_info *info;
>  
> -	info = shrinker_info_protected(memcg, nid);
> +	info = shrinker_info_srcu(memcg, nid);
>  	return atomic_long_add_return(nr, &info->nr_deferred[shrinker->id]);
>  }
>  
> @@ -898,15 +912,14 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
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
>  
> @@ -956,14 +969,9 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
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

