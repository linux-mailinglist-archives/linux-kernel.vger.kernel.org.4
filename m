Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A155B9B45
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiIOMrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiIOMrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:47:52 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D288581688
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 05:47:51 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q9so8107896pgq.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 05:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=URE3/J3RANnPHCClBrc/4NGVv2emAKT3zL/Qo/JABk0=;
        b=dj3VKLtvBttzG9eaXf9+khQo4R3mg2ja3pCX+3deq9Gr60Dl+EVRvhmqyubCdACo9z
         HbKkJhYbMNup1JgJEb7HOYe3Gdj2MPRAvFe13mlqp/pFH5+FXEoIPZJtygZDH5O/AUF9
         VfJZVQeNqd25j2G9BDMoLT60HWTx01k+xa82uzijIBoqOh4N3JdORZ/rsO+RS3L54v3S
         Zzb979uyoFptJc9sIwqUy/wb+LVtAep49ncJ4R3MXTZ8XqZX2QPyUITTt09OvWkE+y+l
         eGaG2DkD69vl17ry7jXmQfQsTN9SWPGOgVDcfDLG71EkRPbNYGMv7yWrenv27U5nTNFS
         RwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=URE3/J3RANnPHCClBrc/4NGVv2emAKT3zL/Qo/JABk0=;
        b=CD6slV0nztXnGGuQyE3w6ulZ85/K2MM9WxT032768Z40dFAqvgw1Y/8F8P+GhokADc
         x6AXtE3kVJSD8q9A7C+r0LuoJqfogiRqzjCk0C7lqSOJ5RafuWo5cm3vE93OCFqkZOyM
         Ewv8YvFrC+7CbT0JN21VDXqq3wxdTpEUqFEwgfHKlO7AS3Ruwp172EfjBxXRXiUAFBM9
         Rt5TXI1ESqeRYkHbSRjotZ/9W0Kq70WThD8wHh3FiqKvEMTSoxYbZw+j3mv2Oysqk1En
         a5Qbz3IQ1DYMkA73pBEYjfuUyQX76hYRbLseI8qNXZzzPQ9jBkibUgvg7N1i8CncSacV
         PlFw==
X-Gm-Message-State: ACrzQf0WQrSZO3m6U4vpjLEZ30iEp6fZW93v22RSRqYg3AheGd/lJ+pM
        f7q7YS00K++FLCoj9l8G6ESNrJ5CSBqb83BX
X-Google-Smtp-Source: AMsMyM5lrmcGia5DM+NRJg5O8euN8FrBOaYjnQFifyC7n+j+MNEB7quBU7e8F3XUizsNpijMiWRzmQ==
X-Received: by 2002:a63:7704:0:b0:439:ae51:3bc1 with SMTP id s4-20020a637704000000b00439ae513bc1mr544134pgc.558.1663246071216;
        Thu, 15 Sep 2022 05:47:51 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id x12-20020a17090a46cc00b001fd9c63e56bsm1550567pjg.32.2022.09.15.05.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:47:49 -0700 (PDT)
Date:   Thu, 15 Sep 2022 21:47:44 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     vbabka@suse.cz, linux-mm@kvack.org, rientjes@google.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de
Subject: Re: [PATCH V2] mm: slub: fix flush_cpu_slab()/__free_slab()
 invocations in task context.
Message-ID: <YyMe8LvKxc5juCfr@hyeyoo>
References: <20220912161140.34281-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912161140.34281-1-mlombard@redhat.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 06:11:40PM +0200, Maurizio Lombardi wrote:
> Commit 5a836bf6b09f ("mm: slub: move flush_cpu_slab() invocations
> __free_slab() invocations out of IRQ context") moved all flush_cpu_slab()
> invocations to the global workqueue to avoid a problem related
> with deactivate_slab()/__free_slab() being called from an IRQ context
> on PREEMPT_RT kernels.
> 
> When the flush_all_cpu_locked() function is called from a task context
> it may happen that a workqueue with WQ_MEM_RECLAIM bit set ends up
> flushing the global workqueue, this will cause a dependency issue.
> 
>  workqueue: WQ_MEM_RECLAIM nvme-delete-wq:nvme_delete_ctrl_work [nvme_core]
>    is flushing !WQ_MEM_RECLAIM events:flush_cpu_slab
>  WARNING: CPU: 37 PID: 410 at kernel/workqueue.c:2637
>    check_flush_dependency+0x10a/0x120
>  Workqueue: nvme-delete-wq nvme_delete_ctrl_work [nvme_core]
>  RIP: 0010:check_flush_dependency+0x10a/0x120[  453.262125] Call Trace:
>  __flush_work.isra.0+0xbf/0x220
>  ? __queue_work+0x1dc/0x420
>  flush_all_cpus_locked+0xfb/0x120
>  __kmem_cache_shutdown+0x2b/0x320
>  kmem_cache_destroy+0x49/0x100
>  bioset_exit+0x143/0x190
>  blk_release_queue+0xb9/0x100
>  kobject_cleanup+0x37/0x130
>  nvme_fc_ctrl_free+0xc6/0x150 [nvme_fc]
>  nvme_free_ctrl+0x1ac/0x2b0 [nvme_core]
> 
> Fix this bug by creating a workqueue for the flush operation with
> the WQ_MEM_RECLAIM bit set.
> 
> v2: Create a workqueue with WQ_MEM_RECLAIM
>     instead of trying to revert the changes.
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>  mm/slub.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 862dbd9af4f5..cdb8011884d0 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -310,6 +310,11 @@ static inline void stat(const struct kmem_cache *s, enum stat_item si)
>   */
>  static nodemask_t slab_nodes;
>  
> +/*
> + * Workqueue used for flush_cpu_slab().
> + */
> +static struct workqueue_struct *flushwq;
> +
>  /********************************************************************
>   * 			Core slab cache functions
>   *******************************************************************/
> @@ -2730,7 +2735,7 @@ static void flush_all_cpus_locked(struct kmem_cache *s)
>  		INIT_WORK(&sfw->work, flush_cpu_slab);
>  		sfw->skip = false;
>  		sfw->s = s;
> -		schedule_work_on(cpu, &sfw->work);
> +		queue_work_on(cpu, flushwq, &sfw->work);
>  	}
>  
>  	for_each_online_cpu(cpu) {
> @@ -4858,6 +4863,8 @@ void __init kmem_cache_init(void)
>  
>  void __init kmem_cache_init_late(void)
>  {
> +	flushwq = create_workqueue("slub_flushwq");
> +	BUG_ON(!flushwq);
>  }
>  
>  struct kmem_cache *
> -- 
> 2.31.1
>

No objection about this patch,
but it seems create_workqueue is deprecated?


-- 
Thanks,
Hyeonggon
