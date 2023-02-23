Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F1F6A0CD9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbjBWP1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBWP1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:27:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDABA57D11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677166009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KHtou2/5zqJwC6ho4cwiGhxNp8JauNifdY/zB21gNeU=;
        b=Y0paDsQWT1OQwC6GDfPeD+ss2msYDUHbCjQ0l/pzsGURAVVtm4YWA4S51SU0BUfO3yvZwx
        2jBOJo3v+ssbYU4iy4nkkb4XseTMUnVDBgFBK6Ancl/atH3zRWFL/FOWyV3UznhqSKmMgv
        p5jrprroaUHniV4EkqRmx+1QK0uNz+0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-577-_kWFeRutPpSWs2IU9m8Lug-1; Thu, 23 Feb 2023 10:26:48 -0500
X-MC-Unique: _kWFeRutPpSWs2IU9m8Lug-1
Received: by mail-qk1-f199.google.com with SMTP id x4-20020a05620a448400b007283b33bfb3so5498633qkp.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:26:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHtou2/5zqJwC6ho4cwiGhxNp8JauNifdY/zB21gNeU=;
        b=x43ex6E/EIyCCLmfGODDSHz2V6CG3hTQ2a5rxQx0da6il8pzS2bqFtUi0X3y0+ghCm
         e9uP2mM27JboaG0hfTOFvXj0TzPVgBxcSp0CWKQfSMsB8POX6niPiAM+EvMfOC2sZh0q
         SjtrLl+Frv/ImPj5tgK73A8LkwA8LrIz/Jqj2GXvCY9ghY26P8s1L8aPilCU5S9MCPns
         XtTmlyKye6uHuprX+zhZaC9B+2TPN0cKnDnypd/Jkw8sjLxGL9klW9yZvSNKeb6VtTmM
         1dpyKRjmlGjde2r+GEW/FF9tZ3UYJWlULglulshay7T0h79kph1PvEtgXxQZuSvU5iLV
         GO3A==
X-Gm-Message-State: AO0yUKWo29fPWZDrcslwcER9zPs8jFL4LfoI0Xe90Ve0SQ1+vg4AkQQJ
        /i0RjIp+7d6gtqTRnvFaCcYpLVNAncOvu9k6Q1/P09OnSQomHCpsVq9YLQGAQnvIXIU9aG2A4rG
        m7BP0w5pf3bUdTF1uGqINcO1k
X-Received: by 2002:a05:622a:58c:b0:3b8:5461:94ad with SMTP id c12-20020a05622a058c00b003b8546194admr22025531qtb.16.1677166008087;
        Thu, 23 Feb 2023 07:26:48 -0800 (PST)
X-Google-Smtp-Source: AK7set/55oQiRvJVI9xV3g83PFmjMXXndkQkhX01qfALHEPRgGzIZdR3Qf5R/rWL8ymibk/nZALllg==
X-Received: by 2002:a05:622a:58c:b0:3b8:5461:94ad with SMTP id c12-20020a05622a058c00b003b8546194admr22025493qtb.16.1677166007790;
        Thu, 23 Feb 2023 07:26:47 -0800 (PST)
Received: from optiplex-fbsd (c-73-249-122-233.hsd1.nh.comcast.net. [73.249.122.233])
        by smtp.gmail.com with ESMTPSA id v185-20020a3793c2000000b0073b9ccb171asm4305649qkd.130.2023.02.23.07.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 07:26:47 -0800 (PST)
Date:   Thu, 23 Feb 2023 10:26:45 -0500
From:   Rafael Aquini <aquini@redhat.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com,
        sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@i-love.sakura.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] mm: vmscan: make global slab shrink lockless
Message-ID: <Y/eFtTO+8kXlsW7x@optiplex-fbsd>
References: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
 <20230223132725.11685-3-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223132725.11685-3-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 09:27:20PM +0800, Qi Zheng wrote:
> The shrinker_rwsem is a global lock in shrinkers subsystem,
> it is easy to cause blocking in the following cases:
> 
> a. the write lock of shrinker_rwsem was held for too long.
>    For example, there are many memcgs in the system, which
>    causes some paths to hold locks and traverse it for too
>    long. (e.g. expand_shrinker_info())
> b. the read lock of shrinker_rwsem was held for too long,
>    and a writer came at this time. Then this writer will be
>    forced to wait and block all subsequent readers.
>    For example:
>    - be scheduled when the read lock of shrinker_rwsem is
>      held in do_shrink_slab()
>    - some shrinker are blocked for too long. Like the case
>      mentioned in the patchset[1].
> 
> Therefore, many times in history ([2],[3],[4],[5]), some
> people wanted to replace shrinker_rwsem reader with SRCU,
> but they all gave up because SRCU was not unconditionally
> enabled.
> 
> But now, since commit 1cd0bd06093c ("rcu: Remove CONFIG_SRCU"),
> the SRCU is unconditionally enabled. So it's time to use
> SRCU to protect readers who previously held shrinker_rwsem.
> 
> [1]. https://lore.kernel.org/lkml/20191129214541.3110-1-ptikhomirov@virtuozzo.com/
> [2]. https://lore.kernel.org/all/1437080113.3596.2.camel@stgolabs.net/
> [3]. https://lore.kernel.org/lkml/1510609063-3327-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp/
> [4]. https://lore.kernel.org/lkml/153365347929.19074.12509495712735843805.stgit@localhost.localdomain/
> [5]. https://lore.kernel.org/lkml/20210927074823.5825-1-sultan@kerneltoast.com/
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  mm/vmscan.c | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9f895ca6216c..02987a6f95d1 100644
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

I think you could revert the rwsem back to a simple mutex, now.

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
> -- 
> 2.20.1
> 
> 

