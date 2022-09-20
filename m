Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9505BE223
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiITJdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiITJci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:32:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EA56F256
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:31:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fs14so2391566pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=jhiFotfKEwRTBie6b0ARo9g+JM1MchEjIl3xnVZP1Ss=;
        b=JZPZjCyy0z7pxSjJUkcQLJJbq6Q+CMhEZw29GqjGGxXK6gQgWeWr1hRYIVyhAogATW
         cH2PEVbtRtvMy4vufLEFrR7fho0AYFlCnYqDgx/gzrGNquLuxjqKpYPmqK/xeL8I7beo
         UEd1osTVjuUvCX59WvNTbkmFXsBsTYP+irqb28UpRqH7WTmp1JMiamZIM4mCgvFbfhm/
         f5q/LABuNUlm5n+rJS8nf+ykoNVPEJDK/JUfEDjkdutVcwhcf0oUTqXrhi1Q1UPjFrbS
         QY5bFb7n3iBKNGLj1k9Tm+lRiaCqwoC9sZwFofbqlxJk/BzOI2LISb5QOvNPUzDKaEhG
         Ahiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jhiFotfKEwRTBie6b0ARo9g+JM1MchEjIl3xnVZP1Ss=;
        b=42sYLiIMCgraWd1yEPvMSVVFAbBT8o7W4vlOCAe94iWu/ySm+cwnenorLjFpjnPhI+
         QV4+GRmDIucyuX702IK2YdWb/dLSHUTSpEJhDci5OTxDxqaiZ/lwBZAwuM749etnaYnm
         BdCz+jpvHl6OexyrfGIp7B+vKHF7NBp6rCKdH+MWVtRDQVrSXlKNwdUqZ5c9K5DeOqJT
         E6Nyu8Iv8roFq42jJIlPJ004I7lnXBphH6dUypMBQfHncg7DeNnKc1xmASoAk83DAmGO
         bvEa5i0k1QlQ3J42vfpQBxKPv/rQ7GYMvMcngny031b9R68bInGAtASY9di+V8YXZLPf
         Le5g==
X-Gm-Message-State: ACrzQf08/4bd+3Kprv2Efg/gB1jkYP27TPps5cKi95zTpjZhxYhWZq/V
        vjeZgN5iFo9rcCPCxXqzKJ0=
X-Google-Smtp-Source: AMsMyM7qZmPiCWi7jcSakYM4o2e67VEJ5fA1xD+Zr54EuUE0iaGWOuX43Hv3feDtcM729mqLi0KFHA==
X-Received: by 2002:a17:90b:3a81:b0:203:1247:4920 with SMTP id om1-20020a17090b3a8100b0020312474920mr2850724pjb.102.1663666292098;
        Tue, 20 Sep 2022 02:31:32 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id w16-20020a17090a529000b00203a4f70b90sm952542pjh.45.2022.09.20.02.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 02:31:31 -0700 (PDT)
Date:   Tue, 20 Sep 2022 18:31:26 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Maurizio Lombardi <mlombard@redhat.com>
Cc:     vbabka@suse.cz, linux-mm@kvack.org, rientjes@google.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de
Subject: Re: [PATCH V3] mm: slub: fix flush_cpu_slab()/__free_slab()
 invocations in task context.
Message-ID: <YymIbnKYaVabF03T@hyeyoo>
References: <20220919163929.351068-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919163929.351068-1-mlombard@redhat.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 06:39:29PM +0200, Maurizio Lombardi wrote:
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
> v3: replace create_workqueue() with alloc_workqueue() and BUG_ON() with
>     WARN_ON()
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>  mm/slub.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 862dbd9af4f5..016da09608fb 100644
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
> +	flushwq = alloc_workqueue("slub_flushwq", WQ_MEM_RECLAIM, 0);
> +	WARN_ON(!flushwq);
>  }
>  
>  struct kmem_cache *
> -- 
> 2.31.1
>

Looks good to me.
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Thanks,
Hyeonggon
