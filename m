Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AB26B2DEC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 20:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCITtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 14:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCITtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 14:49:43 -0500
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6019DF6392
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 11:49:41 -0800 (PST)
Received: from vla3-f7c67ae63b5f.qloud-c.yandex.net (vla3-f7c67ae63b5f.qloud-c.yandex.net [IPv6:2a02:6b8:c15:2583:0:640:f7c6:7ae6])
        by forward500a.mail.yandex.net (Yandex) with ESMTP id 141555EBB1;
        Thu,  9 Mar 2023 22:49:39 +0300 (MSK)
Received: by vla3-f7c67ae63b5f.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id Wnj3f66b2Cg1-BvIXeRj2;
        Thu, 09 Mar 2023 22:49:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1678391378;
        bh=Pc/rk4dcKZuCiuBSehiRiUFiAH3zsXSmR08iASFQff0=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=FA3TySb8yQQ7pgn0uuDJ9y420gBsz3A2kgWM7YwRXTK5pO6A3uFtHkupIIeDNyudq
         oQEu63hR8C/O87djMe4Et+Re8z8XxT8m1LwKJ21r2hOulnZC4F0Qz7qMsp47BGU/lR
         lqDbR7xCpcsGB0gKgwlfE/WnucAyzNdoouE5GAqo=
Authentication-Results: vla3-f7c67ae63b5f.qloud-c.yandex.net; dkim=pass header.i=@ya.ru
Message-ID: <14d66c0d-b436-7ac8-9e4b-21cfdf9631e6@ya.ru>
Date:   Thu, 9 Mar 2023 22:49:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 8/8] mm: shrinkers: convert shrinker_rwsem to mutex
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, shakeelb@google.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com,
        shy828301@gmail.com, rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
 <20230307065605.58209-9-zhengqi.arch@bytedance.com>
From:   Kirill Tkhai <tkhai@ya.ru>
In-Reply-To: <20230307065605.58209-9-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.2023 09:56, Qi Zheng wrote:
> Now there are no readers of shrinker_rwsem, so we
> can simply replace it with mutex lock.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Kirill Tkhai <tkhai@ya.ru>

> ---
>  drivers/md/dm-cache-metadata.c |  2 +-
>  drivers/md/dm-thin-metadata.c  |  2 +-
>  fs/super.c                     |  2 +-
>  mm/shrinker_debug.c            | 14 +++++++-------
>  mm/vmscan.c                    | 34 +++++++++++++++++-----------------
>  5 files changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/md/dm-cache-metadata.c b/drivers/md/dm-cache-metadata.c
> index acffed750e3e..9e0c69958587 100644
> --- a/drivers/md/dm-cache-metadata.c
> +++ b/drivers/md/dm-cache-metadata.c
> @@ -1828,7 +1828,7 @@ int dm_cache_metadata_abort(struct dm_cache_metadata *cmd)
>  	 * Replacement block manager (new_bm) is created and old_bm destroyed outside of
>  	 * cmd root_lock to avoid ABBA deadlock that would result (due to life-cycle of
>  	 * shrinker associated with the block manager's bufio client vs cmd root_lock).
> -	 * - must take shrinker_rwsem without holding cmd->root_lock
> +	 * - must take shrinker_mutex without holding cmd->root_lock
>  	 */
>  	new_bm = dm_block_manager_create(cmd->bdev, DM_CACHE_METADATA_BLOCK_SIZE << SECTOR_SHIFT,
>  					 CACHE_MAX_CONCURRENT_LOCKS);
> diff --git a/drivers/md/dm-thin-metadata.c b/drivers/md/dm-thin-metadata.c
> index fd464fb024c3..9f5cb52c5763 100644
> --- a/drivers/md/dm-thin-metadata.c
> +++ b/drivers/md/dm-thin-metadata.c
> @@ -1887,7 +1887,7 @@ int dm_pool_abort_metadata(struct dm_pool_metadata *pmd)
>  	 * Replacement block manager (new_bm) is created and old_bm destroyed outside of
>  	 * pmd root_lock to avoid ABBA deadlock that would result (due to life-cycle of
>  	 * shrinker associated with the block manager's bufio client vs pmd root_lock).
> -	 * - must take shrinker_rwsem without holding pmd->root_lock
> +	 * - must take shrinker_mutex without holding pmd->root_lock
>  	 */
>  	new_bm = dm_block_manager_create(pmd->bdev, THIN_METADATA_BLOCK_SIZE << SECTOR_SHIFT,
>  					 THIN_MAX_CONCURRENT_LOCKS);
> diff --git a/fs/super.c b/fs/super.c
> index 84332d5cb817..91a4037b1d95 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -54,7 +54,7 @@ static char *sb_writers_name[SB_FREEZE_LEVELS] = {
>   * One thing we have to be careful of with a per-sb shrinker is that we don't
>   * drop the last active reference to the superblock from within the shrinker.
>   * If that happens we could trigger unregistering the shrinker from within the
> - * shrinker path and that leads to deadlock on the shrinker_rwsem. Hence we
> + * shrinker path and that leads to deadlock on the shrinker_mutex. Hence we
>   * take a passive reference to the superblock to avoid this from occurring.
>   */
>  static unsigned long super_cache_scan(struct shrinker *shrink,
> diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
> index 6aa7a7ec69da..b0f6aff372df 100644
> --- a/mm/shrinker_debug.c
> +++ b/mm/shrinker_debug.c
> @@ -7,7 +7,7 @@
>  #include <linux/memcontrol.h>
>  
>  /* defined in vmscan.c */
> -extern struct rw_semaphore shrinker_rwsem;
> +extern struct mutex shrinker_mutex;
>  extern struct list_head shrinker_list;
>  extern struct srcu_struct shrinker_srcu;
>  
> @@ -167,7 +167,7 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
>  	char buf[128];
>  	int id;
>  
> -	lockdep_assert_held(&shrinker_rwsem);
> +	lockdep_assert_held(&shrinker_mutex);
>  
>  	/* debugfs isn't initialized yet, add debugfs entries later. */
>  	if (!shrinker_debugfs_root)
> @@ -210,7 +210,7 @@ int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
>  	if (!new)
>  		return -ENOMEM;
>  
> -	down_write(&shrinker_rwsem);
> +	mutex_lock(&shrinker_mutex);
>  
>  	old = shrinker->name;
>  	shrinker->name = new;
> @@ -228,7 +228,7 @@ int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
>  			shrinker->debugfs_entry = entry;
>  	}
>  
> -	up_write(&shrinker_rwsem);
> +	mutex_unlock(&shrinker_mutex);
>  
>  	kfree_const(old);
>  
> @@ -240,7 +240,7 @@ struct dentry *shrinker_debugfs_remove(struct shrinker *shrinker)
>  {
>  	struct dentry *entry = shrinker->debugfs_entry;
>  
> -	lockdep_assert_held(&shrinker_rwsem);
> +	lockdep_assert_held(&shrinker_mutex);
>  
>  	kfree_const(shrinker->name);
>  	shrinker->name = NULL;
> @@ -265,14 +265,14 @@ static int __init shrinker_debugfs_init(void)
>  	shrinker_debugfs_root = dentry;
>  
>  	/* Create debugfs entries for shrinkers registered at boot */
> -	down_write(&shrinker_rwsem);
> +	mutex_lock(&shrinker_mutex);
>  	list_for_each_entry(shrinker, &shrinker_list, list)
>  		if (!shrinker->debugfs_entry) {
>  			ret = shrinker_debugfs_add(shrinker);
>  			if (ret)
>  				break;
>  		}
> -	up_write(&shrinker_rwsem);
> +	mutex_unlock(&shrinker_mutex);
>  
>  	return ret;
>  }
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index ac7ab4aa344f..c00302fabc3d 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -35,7 +35,7 @@
>  #include <linux/cpuset.h>
>  #include <linux/compaction.h>
>  #include <linux/notifier.h>
> -#include <linux/rwsem.h>
> +#include <linux/mutex.h>
>  #include <linux/delay.h>
>  #include <linux/kthread.h>
>  #include <linux/freezer.h>
> @@ -202,7 +202,7 @@ static void set_task_reclaim_state(struct task_struct *task,
>  }
>  
>  LIST_HEAD(shrinker_list);
> -DECLARE_RWSEM(shrinker_rwsem);
> +DEFINE_MUTEX(shrinker_mutex);
>  DEFINE_SRCU(shrinker_srcu);
>  static atomic_t shrinker_srcu_generation = ATOMIC_INIT(0);
>  
> @@ -225,7 +225,7 @@ static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
>  {
>  	return srcu_dereference_check(memcg->nodeinfo[nid]->shrinker_info,
>  				      &shrinker_srcu,
> -				      lockdep_is_held(&shrinker_rwsem));
> +				      lockdep_is_held(&shrinker_mutex));
>  }
>  
>  static struct shrinker_info *shrinker_info_srcu(struct mem_cgroup *memcg,
> @@ -310,7 +310,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>  	int nid, size, ret = 0;
>  	int map_size, defer_size = 0;
>  
> -	down_write(&shrinker_rwsem);
> +	mutex_lock(&shrinker_mutex);
>  	map_size = shrinker_map_size(shrinker_nr_max);
>  	defer_size = shrinker_defer_size(shrinker_nr_max);
>  	size = map_size + defer_size;
> @@ -326,7 +326,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>  		info->map_nr_max = shrinker_nr_max;
>  		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>  	}
> -	up_write(&shrinker_rwsem);
> +	mutex_unlock(&shrinker_mutex);
>  
>  	return ret;
>  }
> @@ -342,7 +342,7 @@ static int expand_shrinker_info(int new_id)
>  	if (!root_mem_cgroup)
>  		goto out;
>  
> -	lockdep_assert_held(&shrinker_rwsem);
> +	lockdep_assert_held(&shrinker_mutex);
>  
>  	map_size = shrinker_map_size(new_nr_max);
>  	defer_size = shrinker_defer_size(new_nr_max);
> @@ -392,7 +392,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  	if (mem_cgroup_disabled())
>  		return -ENOSYS;
>  
> -	down_write(&shrinker_rwsem);
> +	mutex_lock(&shrinker_mutex);
>  	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
>  	if (id < 0)
>  		goto unlock;
> @@ -406,7 +406,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  	shrinker->id = id;
>  	ret = 0;
>  unlock:
> -	up_write(&shrinker_rwsem);
> +	mutex_unlock(&shrinker_mutex);
>  	return ret;
>  }
>  
> @@ -416,7 +416,7 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
>  
>  	BUG_ON(id < 0);
>  
> -	lockdep_assert_held(&shrinker_rwsem);
> +	lockdep_assert_held(&shrinker_mutex);
>  
>  	idr_remove(&shrinker_idr, id);
>  }
> @@ -451,7 +451,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>  		parent = root_mem_cgroup;
>  
>  	/* Prevent from concurrent shrinker_info expand */
> -	down_write(&shrinker_rwsem);
> +	mutex_lock(&shrinker_mutex);
>  	for_each_node(nid) {
>  		child_info = shrinker_info_protected(memcg, nid);
>  		parent_info = shrinker_info_protected(parent, nid);
> @@ -460,7 +460,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>  			atomic_long_add(nr, &parent_info->nr_deferred[i]);
>  		}
>  	}
> -	up_write(&shrinker_rwsem);
> +	mutex_unlock(&shrinker_mutex);
>  }
>  
>  static bool cgroup_reclaim(struct scan_control *sc)
> @@ -709,9 +709,9 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
>  	shrinker->name = NULL;
>  #endif
>  	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> -		down_write(&shrinker_rwsem);
> +		mutex_lock(&shrinker_mutex);
>  		unregister_memcg_shrinker(shrinker);
> -		up_write(&shrinker_rwsem);
> +		mutex_unlock(&shrinker_mutex);
>  		return;
>  	}
>  
> @@ -721,11 +721,11 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
>  
>  void register_shrinker_prepared(struct shrinker *shrinker)
>  {
> -	down_write(&shrinker_rwsem);
> +	mutex_lock(&shrinker_mutex);
>  	list_add_tail_rcu(&shrinker->list, &shrinker_list);
>  	shrinker->flags |= SHRINKER_REGISTERED;
>  	shrinker_debugfs_add(shrinker);
> -	up_write(&shrinker_rwsem);
> +	mutex_unlock(&shrinker_mutex);
>  }
>  
>  static int __register_shrinker(struct shrinker *shrinker)
> @@ -775,13 +775,13 @@ void unregister_shrinker(struct shrinker *shrinker)
>  	if (!(shrinker->flags & SHRINKER_REGISTERED))
>  		return;
>  
> -	down_write(&shrinker_rwsem);
> +	mutex_lock(&shrinker_mutex);
>  	list_del_rcu(&shrinker->list);
>  	shrinker->flags &= ~SHRINKER_REGISTERED;
>  	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
>  		unregister_memcg_shrinker(shrinker);
>  	debugfs_entry = shrinker_debugfs_remove(shrinker);
> -	up_write(&shrinker_rwsem);
> +	mutex_unlock(&shrinker_mutex);
>  
>  	atomic_inc(&shrinker_srcu_generation);
>  	synchronize_srcu(&shrinker_srcu);

