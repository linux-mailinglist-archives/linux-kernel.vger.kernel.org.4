Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829F072C8FC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbjFLOxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjFLOxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:53:35 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26207C5;
        Mon, 12 Jun 2023 07:53:34 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-55b78f40301so1555187eaf.0;
        Mon, 12 Jun 2023 07:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686581613; x=1689173613;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xXZUlqp9iu1ElLOxxvAF9ZxKXgH0SiVjPs4yNCri6CY=;
        b=Tx+Unm/hPrtYr1cm5fwuKOm6z5/O01iP/qAh+HKbM7hXaGbIhjPA8r+z8El060ncx7
         a2Q1DrZzjHlKTVOKphheqCOqAxobblWB1fL7faxEwJgTdq7KH5mWvbxOXvmceo5wt2Mc
         yIrU6nMzWr31uS33/58dpzUcWTriPQlLLJzITT8glRAVjjN5xgb/17+AAkIu/tiA3vXx
         Rl8nlKceM+TBHsp2tGDR8QQd1eJacf2K4OAVLYr8h5rAehky4bVPnxL7UBhOkSrUXMD3
         Gz1a83ze7HyQ8JV1gwiHWhz1NvvCrKLIovnzSwnDLD878xYAcGaCw1tlH/zVCxEPTY7X
         XO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686581613; x=1689173613;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXZUlqp9iu1ElLOxxvAF9ZxKXgH0SiVjPs4yNCri6CY=;
        b=aCOjqu04bixa6RKPw82ZPnvp3uXnBt+Vype4KKnLeXFo2t9ORHDIzBJI7MZZsV5bvO
         ZPms0ey6O1rae0d+JE3LuPfYHeIITXOtJD02pP9fsmGtJl9lz9aFoKw+6YMy1heKmZ0J
         zkUW8+E1ZxEh2P/Ma4byd7YFZCr7Q+OG1yftNQIZWZu3fy15h3wHoKNvOfOTbjsH1GTP
         VuNOt18JIr0qH4mc2JFj9JJDNak59Z8FH/eNXNvSVg/rKD6kKbSoGN/nUBtDDMiNChim
         tZeOQ9xDyuYs0YRdTTr4PVEM7L/Os+2ezBru/TYWHafkH58U4BcJlUBw1zMNf4ONpf6G
         2TlQ==
X-Gm-Message-State: AC+VfDwVrfMz8OQdKedI7uIft7I39d8hUgESBlrfBz6AgkqQXGlpxeEQ
        ypBgkDJwc6Uw1JEK1Twe96N5j3mVHoY=
X-Google-Smtp-Source: ACHHUZ6hRVi2pnJLN+sHvQh2tjj20aUUPfQBb9JvRUOPPYM664hoNCeQTgN6hta4lDXxJpIh/T4Dqg==
X-Received: by 2002:a05:6808:1291:b0:398:2c03:45fc with SMTP id a17-20020a056808129100b003982c0345fcmr5776211oiw.15.1686581612951;
        Mon, 12 Jun 2023 07:53:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ft4-20020a17090b0f8400b0025c0cd8a91bsm29883pjb.9.2023.06.12.07.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 07:53:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <41ecdf8d-59be-ded0-1ace-0a7cadabbcc3@roeck-us.net>
Date:   Mon, 12 Jun 2023 07:53:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel@axis.com
References: <20230608-pretimeout-oom-v2-1-581f0ad0e4f3@axis.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] watchdog/mm: Allow dumping memory info in pretimeout
In-Reply-To: <20230608-pretimeout-oom-v2-1-581f0ad0e4f3@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/23 00:26, Vincent Whitchurch wrote:
> On my (embedded) systems, the most common cause of hitting the watchdog
> (pre)timeout is due to thrashing.  Diagnosing these problems is hard
> without knowing the memory state at the point of the watchdog hit.  In
> order to make this information available, add a module parameter to the
> watchdog pretimeout panic governor to ask it to dump memory info and the
> OOM task list (using a new helper in the OOM code) before triggering the
> panic.
> 

Personally I don't think this is the right way of approaching this problem.
First, the userspace task controlling the watchdog should run as realtime
task, forced to be in memory, and not be affected by thrashing.
Second, the problem should be observable well before the watchdog fires.
Last but not least, I don't think it is appropriate to intertwine watchdog
code with oom handling code as suggested here.

Guenter

> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> Changes in v2:
> - Add missing static to fix warning reported by kernel test robot.
> - Export __show_mem to fix error reported by kernel test robot.
> - Link to v1: https://lore.kernel.org/r/20230608-pretimeout-oom-v1-1-542cc91062d7@axis.com
> ---
>   drivers/watchdog/pretimeout_panic.c | 15 +++++++++++
>   include/linux/oom.h                 |  5 ++++
>   include/linux/sched/task.h          |  5 ++++
>   lib/show_mem.c                      |  1 +
>   mm/oom_kill.c                       | 54 ++++++++++++++++++++++++++++++++++++-
>   5 files changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/pretimeout_panic.c b/drivers/watchdog/pretimeout_panic.c
> index 2cc3c41d2be5b..52d686fa541c7 100644
> --- a/drivers/watchdog/pretimeout_panic.c
> +++ b/drivers/watchdog/pretimeout_panic.c
> @@ -5,10 +5,15 @@
>   
>   #include <linux/kernel.h>
>   #include <linux/module.h>
> +#include <linux/mm.h>
> +#include <linux/oom.h>
>   #include <linux/watchdog.h>
>   
>   #include "watchdog_pretimeout.h"
>   
> +static unsigned long dump_min_rss_bytes;
> +module_param(dump_min_rss_bytes, ulong, 0644);
> +
>   /**
>    * pretimeout_panic - Panic on watchdog pretimeout event
>    * @wdd - watchdog_device
> @@ -17,6 +22,16 @@
>    */
>   static void pretimeout_panic(struct watchdog_device *wdd)
>   {
> +	/*
> +	 * Since the root cause is not certain to be low memory, only print
> +	 * tasks with RSS above a configurable limit, to avoid losing
> +	 * potentially more important messages from the log.
> +	 */
> +	if (dump_min_rss_bytes) {
> +		show_mem(SHOW_MEM_FILTER_NODES, NULL);
> +		oom_dump_tasks(DIV_ROUND_UP(dump_min_rss_bytes, PAGE_SIZE));
> +	}
> +
>   	panic("watchdog pretimeout event\n");
>   }
>   
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index 7d0c9c48a0c54..1451fe2c38d78 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -52,6 +52,9 @@ struct oom_control {
>   
>   	/* Used to print the constraint info. */
>   	enum oom_constraint constraint;
> +
> +	bool dump_trylock;
> +	unsigned long dump_min_rss_pages;
>   };
>   
>   extern struct mutex oom_lock;
> @@ -102,6 +105,8 @@ long oom_badness(struct task_struct *p,
>   
>   extern bool out_of_memory(struct oom_control *oc);
>   
> +extern void oom_dump_tasks(unsigned long min_rss_pages);
> +
>   extern void exit_oom_victim(void);
>   
>   extern int register_oom_notifier(struct notifier_block *nb);
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index e0f5ac90a228b..e8a68b2a3e829 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -183,6 +183,11 @@ static inline void task_lock(struct task_struct *p)
>   	spin_lock(&p->alloc_lock);
>   }
>   
> +static inline int task_trylock(struct task_struct *p)
> +{
> +	return spin_trylock(&p->alloc_lock);
> +}
> +
>   static inline void task_unlock(struct task_struct *p)
>   {
>   	spin_unlock(&p->alloc_lock);
> diff --git a/lib/show_mem.c b/lib/show_mem.c
> index 1485c87be9354..cf90d1c5182b7 100644
> --- a/lib/show_mem.c
> +++ b/lib/show_mem.c
> @@ -35,3 +35,4 @@ void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
>   	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
>   #endif
>   }
> +EXPORT_SYMBOL_GPL(__show_mem);
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 044e1eed720ee..0fad1c6d3c90c 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -149,6 +149,30 @@ struct task_struct *find_lock_task_mm(struct task_struct *p)
>   	return t;
>   }
>   
> +/*
> + * Identical to the above, except that we avoid tasks which we can't lock, to
> + * avoid deadlocks when called from an interrupt handler.
> + */
> +static struct task_struct *find_trylock_task_mm(struct task_struct *p)
> +{
> +	struct task_struct *t;
> +
> +	rcu_read_lock();
> +
> +	for_each_thread(p, t) {
> +		if (!task_trylock(t))
> +			continue;
> +		if (likely(t->mm))
> +			goto found;
> +		task_unlock(t);
> +	}
> +	t = NULL;
> +found:
> +	rcu_read_unlock();
> +
> +	return t;
> +}
> +
>   /*
>    * order == -1 means the oom kill is required by sysrq, otherwise only
>    * for display purposes.
> @@ -390,15 +414,26 @@ static int dump_task(struct task_struct *p, void *arg)
>   	if (!is_memcg_oom(oc) && !oom_cpuset_eligible(p, oc))
>   		return 0;
>   
> -	task = find_lock_task_mm(p);
> +	task = oc->dump_trylock ? find_trylock_task_mm(p) :
> +				  find_lock_task_mm(p);
>   	if (!task) {
>   		/*
>   		 * All of p's threads have already detached their mm's. There's
>   		 * no need to report them; they can't be oom killed anyway.
> +		 *
> +		 * Or we got here from an interrupt and the task lock is
> +		 * locked, in which case we're forced to ignore this task to
> +		 * avoid deadlocks.
>   		 */
>   		return 0;
>   	}
>   
> +	if (oc->dump_min_rss_pages &&
> +	    get_mm_rss(task->mm) < oc->dump_min_rss_pages) {
> +		task_unlock(task);
> +		return 0;
> +	}
> +
>   	pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n",
>   		task->pid, from_kuid(&init_user_ns, task_uid(task)),
>   		task->tgid, task->mm->total_vm, get_mm_rss(task->mm),
> @@ -437,6 +472,23 @@ static void dump_tasks(struct oom_control *oc)
>   	}
>   }
>   
> +void oom_dump_tasks(unsigned long min_rss_pages)
> +{
> +	const gfp_t gfp_mask = GFP_KERNEL;
> +	struct oom_control oc = {
> +		.zonelist = node_zonelist(first_memory_node, gfp_mask),
> +		.nodemask = NULL,
> +		.memcg = NULL,
> +		.gfp_mask = gfp_mask,
> +		.order = -1,
> +		.dump_min_rss_pages = min_rss_pages,
> +		.dump_trylock = in_interrupt(),
> +	};
> +
> +	dump_tasks(&oc);
> +}
> +EXPORT_SYMBOL_GPL(oom_dump_tasks);
> +
>   static void dump_oom_summary(struct oom_control *oc, struct task_struct *victim)
>   {
>   	/* one line summary of the oom killer context. */
> 
> ---
> base-commit: 9561de3a55bed6bdd44a12820ba81ec416e705a7
> change-id: 20230608-pretimeout-oom-99148438a1df
> 
> Best regards,

