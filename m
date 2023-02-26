Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B20F6A31D5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 16:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjBZPHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 10:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjBZPGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 10:06:30 -0500
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0E6206BF
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:56:54 -0800 (PST)
Received: by mail-pl1-f173.google.com with SMTP id i3so4217150plg.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ym+ZCFFhyz2OKDbObxBs76oK8kUbnOHW3yp4MOyvAK0=;
        b=VnciP26Phw2gzoyflvmtNAAixrJj/Dq3kwo61wChdOe1akIh3zxPsxBgQQtVKjQouQ
         YIHLIUqEihDSSd+znrEJNdpKTtZrWUjSD/FSSm0GoY4m/TBrN9+T59Pbg7nh6hJY9W7O
         Tr1X3KWS9DbE6vijlR+A4Bsn2+zWstqxliNsgArY9yPs1kOz7zSljY4pkQd4HdE3j33I
         xjVYgzSjF96ppA8d8mVj3spN7cWhhS1Osl7aC+eX80L3YDCZnmY7HWYU+aNzLQp9wERD
         b3sEtdiXqByShkJS0XWQdPvOE4fXCkQJYmeHSn1U+BIvd+njLbdqnlpxF/OXqJTvyHF4
         DPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ym+ZCFFhyz2OKDbObxBs76oK8kUbnOHW3yp4MOyvAK0=;
        b=D1o69nulyuKZvDYs3HDuxkaZe2Nl87e77Yyduyk88wpICVpn+N9tg+VqQb9LEeY0AG
         hvrBmLVkVFe85055JR2lrUnoIYtvx3IF1KOn5Dj+xwkRFuL7niXK7cxg1iuD50zTXBQ2
         PJEAWmcxYnmzuW0m+vGG4tTJ1mq/i/YwzAPDaB6eDB8SITZF0I/cKIM1MtiFB1lfaR9l
         /7maEWrl+gtyyj3qqNMT9wUiqwF7xAMWFbYO23zdcYGW+RjR4KrME1NpPdALP59aigZ6
         nPOXPcCi6ecacHoZ60nXe4BJzIqYggCxh50R3wqbnmBjjzOcjsg9C9qiYI9+DpmCQO93
         sYMQ==
X-Gm-Message-State: AO0yUKU5J3f4Q4HiUre9rf5yLUtAlii//ajr2JHd75YEZwjp81Wg6yyI
        GGzT3yqVJMIoNb+LBR8zE8tgoQ==
X-Google-Smtp-Source: AK7set/ZUeH+SuUyppg97YjNUA5G2loUoVgjwib6nXLN0qRJC3HyTHjarQvnqK5qcI74nyeUePMX2w==
X-Received: by 2002:a17:902:a3cd:b0:19a:f556:e386 with SMTP id q13-20020a170902a3cd00b0019af556e386mr21191328plb.0.1677423261091;
        Sun, 26 Feb 2023 06:54:21 -0800 (PST)
Received: from [10.200.9.56] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902f7c300b0019aafc422fcsm2743516plw.240.2023.02.26.06.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 06:54:20 -0800 (PST)
Message-ID: <a86a5b2b-bb6d-64bd-c969-ed7c8c4ff32b@bytedance.com>
Date:   Sun, 26 Feb 2023 22:54:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v3 1/8] mm: vmscan: add a map_nr_max field to
 shrinker_info
Content-Language: en-US
To:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230226144655.79778-1-zhengqi.arch@bytedance.com>
 <20230226144655.79778-2-zhengqi.arch@bytedance.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230226144655.79778-2-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/26 22:46, Qi Zheng wrote:
> To prepare for the subsequent lockless memcg slab shrink,
> add a map_nr_max field to struct shrinker_info to records
> its own real shrinker_nr_max.
> 
> Suggested-by: Kirill Tkhai <tkhai@ya.ru>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   include/linux/memcontrol.h |  1 +
>   mm/vmscan.c                | 41 ++++++++++++++++++++++----------------
>   2 files changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index b6eda2ab205d..aa69ea98e2d8 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -97,6 +97,7 @@ struct shrinker_info {
>   	struct rcu_head rcu;
>   	atomic_long_t *nr_deferred;
>   	unsigned long *map;
> +	int map_nr_max;
>   };
>   
>   struct lruvec_stats_percpu {
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9c1c5e8b24b8..546c07ccb3bc 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -224,9 +224,16 @@ static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
>   					 lockdep_is_held(&shrinker_rwsem));
>   }
>   
> +static inline bool need_expand(int new_nr_max, int old_nr_max)
> +{
> +	return round_up(new_nr_max, BITS_PER_LONG) >
> +	       round_up(old_nr_max, BITS_PER_LONG);
> +}
> +
>   static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>   				    int map_size, int defer_size,
> -				    int old_map_size, int old_defer_size)
> +				    int old_map_size, int old_defer_size,
> +				    int new_nr_max)
>   {
>   	struct shrinker_info *new, *old;
>   	struct mem_cgroup_per_node *pn;
> @@ -240,12 +247,17 @@ static int expand_one_shrinker_info(struct mem_cgroup *memcg,
>   		if (!old)
>   			return 0;
>   
> +		/* Already expanded this shrinker_info */
> +		if (!need_expand(new_nr_max, old->map_nr_max))
> +			return 0;

Oops, need to continue here.

> +
>   		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
>   		if (!new)
>   			return -ENOMEM;
>   
>   		new->nr_deferred = (atomic_long_t *)(new + 1);
>   		new->map = (void *)new->nr_deferred + defer_size;
> +		new->map_nr_max = new_nr_max;
>   
>   		/* map: set all old bits, clear all new bits */
>   		memset(new->map, (int)0xff, old_map_size);
> @@ -295,6 +307,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>   		}
>   		info->nr_deferred = (atomic_long_t *)(info + 1);
>   		info->map = (void *)info->nr_deferred + defer_size;
> +		info->map_nr_max = shrinker_nr_max;
>   		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
>   	}
>   	up_write(&shrinker_rwsem);
> @@ -302,23 +315,14 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
>   	return ret;
>   }
>   
> -static inline bool need_expand(int nr_max)
> -{
> -	return round_up(nr_max, BITS_PER_LONG) >
> -	       round_up(shrinker_nr_max, BITS_PER_LONG);
> -}
> -
>   static int expand_shrinker_info(int new_id)
>   {
>   	int ret = 0;
> -	int new_nr_max = new_id + 1;
> +	int new_nr_max = round_up(new_id + 1, BITS_PER_LONG);
>   	int map_size, defer_size = 0;
>   	int old_map_size, old_defer_size = 0;
>   	struct mem_cgroup *memcg;
>   
> -	if (!need_expand(new_nr_max))
> -		goto out;
> -
>   	if (!root_mem_cgroup)
>   		goto out;
>   
> @@ -332,7 +336,8 @@ static int expand_shrinker_info(int new_id)
>   	memcg = mem_cgroup_iter(NULL, NULL, NULL);
>   	do {
>   		ret = expand_one_shrinker_info(memcg, map_size, defer_size,
> -					       old_map_size, old_defer_size);
> +					       old_map_size, old_defer_size,
> +					       new_nr_max);
>   		if (ret) {
>   			mem_cgroup_iter_break(NULL, memcg);
>   			goto out;
> @@ -352,9 +357,11 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id)
>   
>   		rcu_read_lock();
>   		info = rcu_dereference(memcg->nodeinfo[nid]->shrinker_info);
> -		/* Pairs with smp mb in shrink_slab() */
> -		smp_mb__before_atomic();
> -		set_bit(shrinker_id, info->map);
> +		if (!WARN_ON_ONCE(shrinker_id >= info->map_nr_max)) {
> +			/* Pairs with smp mb in shrink_slab() */
> +			smp_mb__before_atomic();
> +			set_bit(shrinker_id, info->map);
> +		}
>   		rcu_read_unlock();
>   	}
>   }
> @@ -432,7 +439,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
>   	for_each_node(nid) {
>   		child_info = shrinker_info_protected(memcg, nid);
>   		parent_info = shrinker_info_protected(parent, nid);
> -		for (i = 0; i < shrinker_nr_max; i++) {
> +		for (i = 0; i < child_info->map_nr_max; i++) {
>   			nr = atomic_long_read(&child_info->nr_deferred[i]);
>   			atomic_long_add(nr, &parent_info->nr_deferred[i]);
>   		}
> @@ -899,7 +906,7 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>   	if (unlikely(!info))
>   		goto unlock;
>   
> -	for_each_set_bit(i, info->map, shrinker_nr_max) {
> +	for_each_set_bit(i, info->map, info->map_nr_max) {
>   		struct shrink_control sc = {
>   			.gfp_mask = gfp_mask,
>   			.nid = nid,

-- 
Thanks,
Qi
