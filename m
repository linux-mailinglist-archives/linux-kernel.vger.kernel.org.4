Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3998654095
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbiLVMA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235822AbiLVMAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:00:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F792A505
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671709923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l41aH0WBriZBVAcbCCI1ziH5/SVn64wwNEilAzNOnCQ=;
        b=bd2D8eye2Ubdl9i8BulU+sFZnBsaFyk97zIiARpDXMW3eZRz/MDQWStpVjQaTr+WhsP8iY
        jMUwPqaYkway4j8q5G7cWVi9sj9mEXlg1e/JiUB2p0jyvQrnYKEw/k0/bwkfeZH/ZqTUeQ
        wY+go9xpLf5h/3MGc0Q9B6y3kUmq7Lo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-517-L4rtulmzPtCIEUcHG-ZXpA-1; Thu, 22 Dec 2022 06:52:02 -0500
X-MC-Unique: L4rtulmzPtCIEUcHG-ZXpA-1
Received: by mail-qv1-f70.google.com with SMTP id c10-20020a05621401ea00b004c72d0e92bcso852115qvu.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:52:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l41aH0WBriZBVAcbCCI1ziH5/SVn64wwNEilAzNOnCQ=;
        b=GQLZSEWMFGg/YXZQ+gZgRHtjTIBmxJE52sT2dyqBT0GvulxgEE3RFJFU5Msnd9eN9C
         GPhA5neDrVfWclerXX+YY2yJqwa1mHYYmUUkNUP5OqaD+FPeu6dPJnVM1NneXwicSa6H
         TnotKeEYtz6cobTeX/ZrBWB9kxqcifZ6x8GMRumg+/O6Da7QBQVn7sxOmx/298FKAzpc
         X0RGifjTobbk2ZSSwBTKowHskju4qZRcmUOCrilHDi5m2QXUgu4d3AG4fhBJgsiJa1mJ
         pQ0KAZsL/qpdd/ftugLHuyQrRTYQPhYm8ygJNCYnBnHnT4vhW5mF5HzWm0O5egY703tq
         uh7A==
X-Gm-Message-State: AFqh2kpT0WI/Wykvb0oTQlxbAqWDjjKmT/cDfap6VwDT9RH1KVeRfK18
        qLVf0lZ5501WeJHS3alrjoPiC42ywoL2aHUF1U0txNol0sSHf+rJlt1YfSfPEXylcQ9CStgVsug
        GlovpN4LC6HAzKGkuz6ta/ntZ
X-Received: by 2002:a05:6214:3b06:b0:4c7:935f:c888 with SMTP id nm6-20020a0562143b0600b004c7935fc888mr6321918qvb.42.1671709920167;
        Thu, 22 Dec 2022 03:52:00 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs23jUJN+k7IRFIRjwWmG4sFROD8uJ34MtfszUJtLdIDz+Vkjv8IDoC4F/m0B1brfNm2REWQg==
X-Received: by 2002:a05:6214:3b06:b0:4c7:935f:c888 with SMTP id nm6-20020a0562143b0600b004c7935fc888mr6321899qvb.42.1671709919793;
        Thu, 22 Dec 2022 03:51:59 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id s4-20020a05620a254400b006feb158e5e7sm154139qko.70.2022.12.22.03.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 03:51:58 -0800 (PST)
Date:   Thu, 22 Dec 2022 06:52:06 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Sven Luther <Sven.Luther@windriver.com>
Subject: Re: [PATCH RFC] ipc/mqueue: introduce msg cache
Message-ID: <Y6RE5iUHSinUJxDt@bfoster>
References: <20221220184813.1908318-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220184813.1908318-1-roman.gushchin@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 10:48:13AM -0800, Roman Gushchin wrote:
> Sven Luther reported a regression in the posix message queues
> performance caused by switching to the per-object tracking of
> slab objects introduced by patch series ending with the
> commit 10befea91b61 ("mm: memcg/slab: use a single set of kmem_caches for all
> allocations").
> 
> To mitigate the regression cache allocated mqueue messages on a small
> percpu cache instead of releasing and re-allocating them every time.
> 
> This change brings the performance measured by a benchmark kindly
> provided by Sven [1] almost back to the original (or even better)
> numbers. Measurements results are also provided by Sven.
> 
> +------------+---------------------------------+--------------------------------+
> | kernel     | mqueue_rcv (ns)     variation   | mqueue_send (ns)   variation   |
> | version    | min avg  max      min      avg  | min avg max       min     avg  |
> +------------+--------------------------+---------------------------------------+
> | 4.18.45    | 351 382 17533    base     base  | 383 410 13178     base    base |
> | 5.8-good   | 380 392  7156   -7,63%  -2,55%  | 376 384  6225    1,86%   6,77% |
> | 5.8-bad    | 524 530  5310  -33,02% -27,92%  | 512 519  8775  -25,20% -21,00% |
> | 5.10       | 520 533  4078  -32,20% -28,33%  | 518 534  8108  -26,06% -23,22% |
> | 5.15       | 431 444  8440  -18,56% -13,96%  | 425 437  6170   -9,88%  -6,18% |
> | 6.0.3      | 474 614  3881  -25,95% -37,79%  | 482 693   931  -20,54% -40,84% |
> | 6.1-rc8    | 496 509  8804  -29,23% -24,95%  | 493 512  5748  -22,31% -19,92% |
> | 6.1-rc8+p  | 392 397  5479  -10,46%  -3,78%  | 364 369 10776    5,22%  11,11% |
> +------------+---------------------------------+--------------------------------+
> 
> The last line reflects the result with this patch ("6.1-rc8+p").
> 
> [1]: https://lore.kernel.org/linux-mm/Y46lqCToUa%2FBgt%2Fc@P9FQF9L96D/T/
> 
> Reported-by: Sven Luther <Sven.Luther@windriver.com>
> Tested-by: Sven Luther <Sven.Luther@windriver.com>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  include/linux/memcontrol.h |  12 +++++
>  ipc/mqueue.c               |  20 ++++++--
>  ipc/msg.c                  |  12 ++---
>  ipc/msgutil.c              | 101 +++++++++++++++++++++++++++++++++----
>  ipc/util.h                 |   8 ++-
>  mm/memcontrol.c            |  62 +++++++++++++++++++++++
>  6 files changed, 194 insertions(+), 21 deletions(-)
> 
...
> diff --git a/ipc/msgutil.c b/ipc/msgutil.c
> index d0a0e877cadd..8667708fc00a 100644
> --- a/ipc/msgutil.c
> +++ b/ipc/msgutil.c
...
> @@ -39,16 +40,76 @@ struct msg_msgseg {
...
> +static struct msg_msg *alloc_msg(size_t len, struct msg_cache *cache)
>  {
>  	struct msg_msg *msg;
>  	struct msg_msgseg **pseg;
>  	size_t alen;
>  
> +	if (cache) {
> +		struct pcpu_msg_cache *pc;
> +
> +		msg = NULL;
> +		pc = get_cpu_ptr(cache->pcpu_cache);
> +		if (pc->msg && pc->len == len) {
> +			struct obj_cgroup *objcg;
> +
> +			rcu_read_lock();
> +			objcg = obj_cgroup_from_current();
> +			if (objcg == pc->objcg) {
> +				msg = pc->msg;
> +				pc->msg = NULL;
> +				obj_cgroup_put(pc->objcg);
> +			}
> +			rcu_read_unlock();
> +		}
> +		put_cpu_ptr(cache->pcpu_cache);
> +		if (msg)
> +			return msg;
> +	}
> +
>  	alen = min(len, DATALEN_MSG);
>  	msg = kmalloc(sizeof(*msg) + alen, GFP_KERNEL_ACCOUNT);
>  	if (msg == NULL)
> @@ -77,18 +138,19 @@ static struct msg_msg *alloc_msg(size_t len)
>  	return msg;
>  
>  out_err:
> -	free_msg(msg);
> +	free_msg(msg, NULL);
>  	return NULL;
>  }
>  
> -struct msg_msg *load_msg(const void __user *src, size_t len)
> +struct msg_msg *load_msg(const void __user *src, size_t len,
> +			 struct msg_cache *cache)
>  {
>  	struct msg_msg *msg;
>  	struct msg_msgseg *seg;
>  	int err = -EFAULT;
>  	size_t alen;
>  
> -	msg = alloc_msg(len);
> +	msg = alloc_msg(len, cache);
>  	if (msg == NULL)
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -104,14 +166,16 @@ struct msg_msg *load_msg(const void __user *src, size_t len)
>  			goto out_err;
>  	}
>  
> -	err = security_msg_msg_alloc(msg);
> -	if (err)
> -		goto out_err;
> +	if (!msg->security) {
> +		err = security_msg_msg_alloc(msg);
> +		if (err)
> +			goto out_err;
> +	}
>  
>  	return msg;
>  
>  out_err:
> -	free_msg(msg);
> +	free_msg(msg, NULL);
>  	return ERR_PTR(err);
>  }
>  #ifdef CONFIG_CHECKPOINT_RESTORE
> @@ -166,10 +230,29 @@ int store_msg(void __user *dest, struct msg_msg *msg, size_t len)
>  	return 0;
>  }
>  
> -void free_msg(struct msg_msg *msg)
> +void free_msg(struct msg_msg *msg, struct msg_cache *cache)
>  {
>  	struct msg_msgseg *seg;
>  
> +	if (cache) {
> +		struct pcpu_msg_cache *pc;
> +		bool cached = false;
> +
> +		pc = get_cpu_ptr(cache->pcpu_cache);
> +		if (!pc->msg) {
> +			pc->objcg = get_obj_cgroup_from_slab_obj(msg);
> +			pc->len = msg->m_ts;
> +			pc->msg = msg;
> +
> +			if (pc->objcg)
> +				cached = true;
> +		}

Hi Roman,

It seems that this is kind of tailored to the ideal conditions
implemented by the test case: i.e., a single, fixed size message being
passed back and forth on a single cpu. Does that actually represent the
production workload?

I'm a little curious if/how this might work for workloads that might
involve more variable sized messages, deeper queue depths (i.e.  sending
more than one message before attempting a recv) and more tasks across
different cpus. For example, it looks like if an "uncommonly" sized
message ended up cached on a cpu, this would always result in subsequent
misses because the alloc side requires an exact size match and the free
side never replaces a cached msg. Hm?

Brian

> +		put_cpu_ptr(cache->pcpu_cache);
> +
> +		if (cached)
> +			return;
> +	}
> +
>  	security_msg_msg_free(msg);
>  
>  	seg = msg->next;
> diff --git a/ipc/util.h b/ipc/util.h
> index b2906e366539..a2da266386aa 100644
> --- a/ipc/util.h
> +++ b/ipc/util.h
> @@ -196,8 +196,12 @@ static inline void ipc_update_pid(struct pid **pos, struct pid *pid)
>  int ipc_parse_version(int *cmd);
>  #endif
>  
> -extern void free_msg(struct msg_msg *msg);
> -extern struct msg_msg *load_msg(const void __user *src, size_t len);
> +struct msg_cache;
> +extern int init_msg_cache(struct msg_cache *cache);
> +extern void free_msg_cache(struct msg_cache *cache);
> +extern void free_msg(struct msg_msg *msg, struct msg_cache *cache);
> +extern struct msg_msg *load_msg(const void __user *src, size_t len,
> +				struct msg_cache *cache);
>  extern struct msg_msg *copy_msg(struct msg_msg *src, struct msg_msg *dst);
>  extern int store_msg(void __user *dest, struct msg_msg *msg, size_t len);
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a1a35c12635e..28528b4da0fb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3004,6 +3004,28 @@ static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
>  	return objcg;
>  }
>  
> +__always_inline struct obj_cgroup *obj_cgroup_from_current(void)
> +{
> +	struct obj_cgroup *objcg = NULL;
> +	struct mem_cgroup *memcg;
> +
> +	if (memcg_kmem_bypass())
> +		return NULL;
> +
> +	if (unlikely(active_memcg()))
> +		memcg = active_memcg();
> +	else
> +		memcg = mem_cgroup_from_task(current);
> +
> +	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
> +		objcg = rcu_dereference(memcg->objcg);
> +		if (likely(objcg))
> +			return objcg;
> +	}
> +
> +	return NULL;
> +}
> +
>  __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
>  {
>  	struct obj_cgroup *objcg = NULL;
> @@ -3046,6 +3068,46 @@ struct obj_cgroup *get_obj_cgroup_from_page(struct page *page)
>  	return objcg;
>  }
>  
> +/*
> + * A passed kernel object must be a slab object or a generic kernel page.
> + * Not suitable for objects, allocated using vmalloc().
> + */
> +struct obj_cgroup *get_obj_cgroup_from_slab_obj(void *p)
> +{
> +	struct obj_cgroup *objcg = NULL;
> +	struct folio *folio;
> +
> +	if (mem_cgroup_disabled())
> +		return NULL;
> +
> +	folio = virt_to_folio(p);
> +	/*
> +	 * Slab object can be either a true slab object, which are accounted
> +	 * individually with objcg pointers stored in a separate objcg array,
> +	 * or it can a generic folio with MEMCG_DATA_KMEM flag set.
> +	 */
> +	if (folio_test_slab(folio)) {
> +		struct obj_cgroup **objcgs;
> +		struct slab *slab;
> +		unsigned int off;
> +
> +		slab = folio_slab(folio);
> +		objcgs = slab_objcgs(slab);
> +		if (!objcgs)
> +			return NULL;
> +
> +		off = obj_to_index(slab->slab_cache, slab, p);
> +		objcg = objcgs[off];
> +	} else {
> +		objcg = __folio_objcg(folio);
> +	}
> +
> +	if (objcg)
> +		obj_cgroup_get(objcg);
> +
> +	return objcg;
> +}
> +
>  static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages)
>  {
>  	mod_memcg_state(memcg, MEMCG_KMEM, nr_pages);
> -- 
> 2.39.0
> 
> 

