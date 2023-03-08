Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2377A6B0BA5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjCHOm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjCHOmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:42:02 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378315AB56
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:40:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E67291FE3D;
        Wed,  8 Mar 2023 14:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678286408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=60iRe+TO5hl2RaReJQOAW22fyZFUmHKlK8uZfBodZLk=;
        b=cBTk++KU6MuNwDMUwESpQjyELZV3QU4NsunM7u2I6Eqa705TCjbMYECbCWOJ81bkYsgVR+
        bufJdvnrZ/dmhQ8QJNkySiekXnHRA6MzhSFE0QBa2U/m4PFTZ3V9fdCxMH7H6GNJOCP8Wp
        h2PmnvOZSfIE/kQPlpB+6cdecJnQHYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678286408;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=60iRe+TO5hl2RaReJQOAW22fyZFUmHKlK8uZfBodZLk=;
        b=bPKI0frWKZ7jX8pglWGUDRR5BsdmWozH1mOlXPzHehHq8/9ZJJlD8Hvv2uK9IOg449G9Bq
        A9hbeHFqCPbiVWAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FED11391B;
        Wed,  8 Mar 2023 14:40:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DWbvIUieCGSVdAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 08 Mar 2023 14:40:08 +0000
Message-ID: <edd3400f-6614-357a-e775-fe1e6a6dd6bb@suse.cz>
Date:   Wed, 8 Mar 2023 15:40:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 1/8] mm: vmscan: add a map_nr_max field to
 shrinker_info
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tkhai@ya.ru, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com, rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
 <20230307065605.58209-2-zhengqi.arch@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230307065605.58209-2-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/23 07:55, Qi Zheng wrote:
> To prepare for the subsequent lockless memcg slab shrink,
> add a map_nr_max field to struct shrinker_info to records
> its own real shrinker_nr_max.
> 
> Suggested-by: Kirill Tkhai <tkhai@ya.ru>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/memcontrol.h |  1 +
>  mm/vmscan.c                | 41 ++++++++++++++++++++++----------------
>  2 files changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index b6eda2ab205d..aa69ea98e2d8 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -97,6 +97,7 @@ struct shrinker_info {
>  	struct rcu_head rcu;
>  	atomic_long_t *nr_deferred;
>  	unsigned long *map;
> +	int map_nr_max;
>  };
>  
>  struct lruvec_stats_percpu {
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9414226218f0..2dcc01682026 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -224,9 +224,16 @@ static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
>  					 lockdep_is_held(&shrinker_rwsem));
>  }
>  
> +static inline bool need_expand(int new_nr_max, int old_nr_max)
> +{
> +	return round_up(new_nr_max, BITS_PER_LONG) >
> +	       round_up(old_nr_max, BITS_PER_LONG);
> +}
> +
>  static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>  				    int map_size, int defer_size,
> -				    int old_map_size, int old_defer_size)
> +				    int old_map_size, int old_defer_size,
> +				    int new_nr_max)
>  {
>  	struct shrinker_info *new, *old;
>  	struct mem_cgroup_per_node *pn;
> @@ -240,12 +247,17 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>  		if (!old)
>  			return 0;
>  
> +		/* Already expanded this shrinker_info */
> +		if (!need_expand(new_nr_max, old->map_nr_max))
> +			continue;
> +
>  		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
>  		if (!new)
>  			return -ENOMEM;
>  
>  		new->nr_deferred = (atomic_long_t *)(new + 1);
>  		new->map = (void *)new->nr_deferred + defer_size;
> +		new->map_nr_max = new_nr_max;
>  
>  		/* map: set all old bits, clear all new bits */
>  		memset(new->map, (int)0xff, old_map_size);
> @@ -295,6 +307,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>  		}
>  		info->nr_deferred = (atomic_long_t *)(info + 1);
>  		info->map = (void *)info->nr_deferred + defer_size;
> +		info->map_nr_max = shrinker_nr_max;
>  		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>  	}
>  	up_write(&shrinker_rwsem);
> @@ -302,23 +315,14 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>  	return ret;
>  }
>  
> -static inline bool need_expand(int nr_max)
> -{
> -	return round_up(nr_max, BITS_PER_LONG) >
> -	       round_up(shrinker_nr_max, BITS_PER_LONG);
> -}
> -
>  static int expand_shrinker_info(int new_id)
>  {
>  	int ret = 0;
> -	int new_nr_max = new_id + 1;
> +	int new_nr_max = round_up(new_id + 1, BITS_PER_LONG);
>  	int map_size, defer_size = 0;
>  	int old_map_size, old_defer_size = 0;
>  	struct mem_cgroup *memcg;
>  
> -	if (!need_expand(new_nr_max))
> -		goto out;
> -
>  	if (!root_mem_cgroup)
>  		goto out;
>  
> @@ -332,7 +336,8 @@ static int expand_shrinker_info(int new_id)
>  	memcg = mem_cgroup_iter(NULL, NULL, NULL);
>  	do {
>  		ret = expand_one_shrinker_info(memcg, map_size, defer_size,
> -					       old_map_size, old_defer_size);
> +					       old_map_size, old_defer_size,
> +					       new_nr_max);
>  		if (ret) {
>  			mem_cgroup_iter_break(NULL, memcg);
>  			goto out;
> @@ -352,9 +357,11 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
>  
>  		rcu_read_lock();
>  		info = rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
> -		/* Pairs with smp mb in shrink_slab() */
> -		smp_mb__before_atomic();
> -		set_bit(shrinker_id, info->map);
> +		if (!WARN_ON_ONCE(shrinker_id >= info->map_nr_max)) {
> +			/* Pairs with smp mb in shrink_slab() */
> +			smp_mb__before_atomic();
> +			set_bit(shrinker_id, info->map);
> +		}
>  		rcu_read_unlock();
>  	}
>  }
> @@ -432,7 +439,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>  	for_each_node(nid) {
>  		child_info = shrinker_info_protected(memcg, nid);
>  		parent_info = shrinker_info_protected(parent, nid);
> -		for (i = 0; i < shrinker_nr_max; i++) {
> +		for (i = 0; i < child_info->map_nr_max; i++) {
>  			nr = atomic_long_read(&child_info->nr_deferred[i]);
>  			atomic_long_add(nr, &parent_info->nr_deferred[i]);
>  		}
> @@ -899,7 +906,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>  	if (unlikely(!info))
>  		goto unlock;
>  
> -	for_each_set_bit(i, info->map, shrinker_nr_max) {
> +	for_each_set_bit(i, info->map, info->map_nr_max) {
>  		struct shrink_control sc = {
>  			.gfp_mask = gfp_mask,
>  			.nid = nid,
