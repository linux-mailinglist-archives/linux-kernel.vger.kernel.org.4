Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42B973384F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344957AbjFPSrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344112AbjFPSrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:47:16 -0400
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFA23A9E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:47:13 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id AETTqsIxdzGOZAETTqbwHa; Fri, 16 Jun 2023 20:47:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686941231;
        bh=mjmm8to/bELzOA//iAPouJVx5kPEfLD/xVc4EtzWKJQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CSO71O13/XmQ1IidOFGljlCsp76z72TXUzO/xep7q9frqV4mp5S5vU7UUXS5wVK1g
         JZgOO4QJ0HDS9BXemYhW4rbEhJOOQ2MeG5V6WO7O0/b8O5nT1fmwNvIVKHV5SWl+Tp
         UjJXQH8DeXkxv7MDya/JQkTRY2aBwjby5XFG5lLSKviGfqcmlMOjI1HpoeIqb4zBfo
         5z+JKruJH9UIMaI7te/Xic79xKvXhudx6/k/cVIyGaW1RMmje1CL2VSr2rNC8ZqPMN
         9Z72eIMurdEnnRQhDx6v1LC18CwqRtmuZbdEdjvYJOAZIChRtKmobmRRRAxEoLRyxz
         k500PkAeIJ9Ew==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 16 Jun 2023 20:47:11 +0200
X-ME-IP: 86.243.2.178
Message-ID: <d188b6b7-af05-3bd2-c972-87722106180c@wanadoo.fr>
Date:   Fri, 16 Jun 2023 20:47:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] mm/memcg: remove return value of
 mem_cgroup_scan_tasks()
Content-Language: fr
To:     Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev,
        akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
References: <20230616063030.977586-1-zhangpeng362@huawei.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230616063030.977586-1-zhangpeng362@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 16/06/2023 à 08:30, Peng Zhang a écrit :
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> No user checks the return value of mem_cgroup_scan_tasks(). Make the
> return value void.
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> ---
> v2:
> - drop redundant return 0 per kernel test robot
> 
>   include/linux/memcontrol.h | 7 +++----
>   mm/memcontrol.c            | 9 ++++-----
>   2 files changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index c3d3a0c09315..5818af8eca5a 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -820,8 +820,8 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
>   				   struct mem_cgroup *,
>   				   struct mem_cgroup_reclaim_cookie *);
>   void mem_cgroup_iter_break(struct mem_cgroup *, struct mem_cgroup *);
> -int mem_cgroup_scan_tasks(struct mem_cgroup *,
> -			  int (*)(struct task_struct *, void *), void *);
> +void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
> +			   int (*)(struct task_struct *, void *), void *arg);
>   
>   static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
>   {
> @@ -1364,10 +1364,9 @@ static inline void mem_cgroup_iter_break(struct mem_cgroup *root,
>   {
>   }
>   
> -static inline int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
> +static inline void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>   		int (*fn)(struct task_struct *, void *), void *arg)
>   {
> -	return 0;
>   }
>   
>   static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index cf06b1c9b3bb..a834b1edcde9 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1259,13 +1259,13 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
>    *
>    * This function iterates over tasks attached to @memcg or to any of its
>    * descendants and calls @fn for each task. If @fn returns a non-zero
> - * value, the function breaks the iteration loop and returns the value.
> - * Otherwise, it will iterate over all tasks and return 0.
> + * value, the function breaks the iteration loop. Otherwise, it will iterate
> + * over all tasks and return 0.

It does not return 0 any more in such a case.

CJ

>    *
>    * This function must not be called for the root memory cgroup.
>    */
> -int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
> -			  int (*fn)(struct task_struct *, void *), void *arg)
> +void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
> +			   int (*fn)(struct task_struct *, void *), void *arg)
>   {
>   	struct mem_cgroup *iter;
>   	int ret = 0;
> @@ -1285,7 +1285,6 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>   			break;
>   		}
>   	}
> -	return ret;
>   }
>   
>   #ifdef CONFIG_DEBUG_VM

