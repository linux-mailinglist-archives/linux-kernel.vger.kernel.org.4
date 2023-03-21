Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357B06C2FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjCULJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjCULJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:09:09 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EF8113F5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:09:06 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id cn12so12435089edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679396945; x=1681988945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlYdf0oD3XbnROhVpvr7ozRGQ51z4vIH01wpFVje8Fw=;
        b=hzzP8GwiMuhQULwroki9um0YiLSASaZ3SE+ht/1iv3XkJJfjNa2ukQEZrl61MHLgMv
         qMKmjyVQ+fng3z5+4lEZAJmddxP7V/kgSzwMX7XDto7ytI6CZwxbgFssREBpkA3BMrGg
         lioHRn+MLA1Ts86kJ5pdQnnUYD9epoBhFo/jae46wKZUH/G93Ph4NOZlckdjHz6uZxNZ
         k4GK0BWVnpP2NfVVc4BZh0nZLQFIgg1u9iGz3Q2L0AYcle5+Mkuy+tUtbRmNnXiS2yke
         MG8k1B9Z8jlJHs1IycOf4Ko7Fmk/sQOJfUMhq2400NQyfh2VuzmJhiJ4US0r3JwUc6kp
         4fkg==
X-Gm-Message-State: AO0yUKX3kdInuvUXS7jnUERiXYYnOdP9Mdh+M15Lu7jqdqNzmTkOSyjT
        5pQz5i4Z/hRnwObrLYSamdA=
X-Google-Smtp-Source: AK7set/CxBC4yLKLhwTkyBrObkrJISMBfOB5Z0rmXNYxYxS8N0ZsX2h7kjFH6O7YzJLG5Q14GN5ADA==
X-Received: by 2002:a17:906:7485:b0:933:37f4:2ff4 with SMTP id e5-20020a170906748500b0093337f42ff4mr1837408ejl.0.1679396945118;
        Tue, 21 Mar 2023 04:09:05 -0700 (PDT)
Received: from [10.100.102.14] (85.65.253.165.dynamic.barak-online.net. [85.65.253.165])
        by smtp.gmail.com with ESMTPSA id 11-20020a170906318b00b008d606b1bbb1sm5624160ejy.9.2023.03.21.04.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 04:09:04 -0700 (PDT)
Message-ID: <042385ef-285e-5179-941b-ab37f490c1d8@grimberg.me>
Date:   Tue, 21 Mar 2023 13:09:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] nvme: fix heap-use-after-free and oops in bio_endio for
 nvme multipath
Content-Language: en-US
To:     Lei Lei2 Yin <yinlei2@lenovo.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cybeyond@foxmail.com" <cybeyond@foxmail.com>
References: <PS1PR03MB493948DD1ECFAF150EE7B2F688819@PS1PR03MB4939.apcprd03.prod.outlook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <PS1PR03MB493948DD1ECFAF150EE7B2F688819@PS1PR03MB4939.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/23 12:50, Lei Lei2 Yin wrote:
>  From b134e7930b50679ce48e5522ddd37672b1802340 Mon Sep 17 00:00:00 2001
> From: Lei Yin <yinlei2@lenovo.com>
> Date: Tue, 21 Mar 2023 16:09:08 +0800
> Subject: [PATCH] nvme: fix heap-use-after-free and oops in bio_endio for nvme
>   multipath
> 
> When blk_queue_split works in nvme_ns_head_submit_bio, input bio will be
> splited to two bios. If parent bio is completed first, and the bi_disk
> in parent bio is kfreed by nvme_free_ns, child will access this freed
> bi_disk in bio_endio. This will trigger heap-use-after-free or null
> pointer oops.

Can you explain further? It is unclear to me how we can delete the ns
gendisk

> 
> The following is kasan report:
> 
> BUG: KASAN: use-after-free in bio_endio+0x477/0x500
> Read of size 8 at addr ffff888106f2e3a8 by task kworker/1:1H/241
> 
> CPU: 1 PID: 241 Comm: kworker/1:1H Kdump: loaded Tainted: G           O
>        5.10.167 #1
> Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> Workqueue: kblockd nvme_requeue_work [nvme_core]
> Call Trace:
>   dump_stack+0x92/0xc4
>   ? bio_endio+0x477/0x500
>   print_address_description.constprop.7+0x1e/0x230
>   ? record_print_text.cold.40+0x11/0x11
>   ? _raw_spin_trylock_bh+0x120/0x120
>   ? blk_throtl_bio+0x225/0x3050
>   ? bio_endio+0x477/0x500
>   ? bio_endio+0x477/0x500
>   kasan_report.cold.9+0x37/0x7c
>   ? bio_endio+0x477/0x500
>   bio_endio+0x477/0x500
>   nvme_ns_head_submit_bio+0x950/0x1130 [nvme_core]
>   ? nvme_find_path+0x7f0/0x7f0 [nvme_core]
>   ? __kasan_slab_free+0x11a/0x150
>   ? bio_endio+0x213/0x500
>   submit_bio_noacct+0x2a4/0xd10
>   ? _dev_info+0xcd/0xff
>   ? _dev_notice+0xff/0xff
>   ? blk_queue_enter+0x6c0/0x6c0
>   ? _raw_spin_lock_irq+0x81/0xd5
>   ? _raw_spin_lock+0xd0/0xd0
>   nvme_requeue_work+0x144/0x18c [nvme_core]
>   process_one_work+0x878/0x13e0
>   worker_thread+0x87/0xf70
>   ? __kthread_parkme+0x8f/0x100
>   ? process_one_work+0x13e0/0x13e0
>   kthread+0x30f/0x3d0
>   ? kthread_parkme+0x80/0x80
>   ret_from_fork+0x1f/0x30
> 
> Allocated by task 52:
>   kasan_save_stack+0x19/0x40
>   __kasan_kmalloc.constprop.11+0xc8/0xd0
>   __alloc_disk_node+0x5c/0x320
>   nvme_alloc_ns+0x6e9/0x1520 [nvme_core]
>   nvme_validate_or_alloc_ns+0x17c/0x370 [nvme_core]
>   nvme_scan_work+0x2d4/0x4d0 [nvme_core]
>   process_one_work+0x878/0x13e0
>   worker_thread+0x87/0xf70
>   kthread+0x30f/0x3d0
>   ret_from_fork+0x1f/0x30
> 
> Freed by task 54:
>   kasan_save_stack+0x19/0x40
>   kasan_set_track+0x1c/0x30
>   kasan_set_free_info+0x1b/0x30
>   __kasan_slab_free+0x108/0x150
>   kfree+0xa7/0x300
>   device_release+0x98/0x210
>   kobject_release+0x109/0x3a0
>   nvme_free_ns+0x15e/0x1f7 [nvme_core]
>   nvme_remove_namespaces+0x22f/0x390 [nvme_core]
>   nvme_do_delete_ctrl+0xac/0x106 [nvme_core]
>   process_one_work+0x878/0x13e0
>   worker_thread+0x87/0xf70
>   kthread+0x30f/0x3d0
>   ret_from_fork+0x1f/0x30
> 
> Signed-off-by: Lei Yin <yinlei2@lenovo.com>
> ---
>   drivers/nvme/host/nvme.h | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index c3e4d9b6f9c0..b441c5ce4157 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -749,8 +749,17 @@ static inline void nvme_trace_bio_complete(struct request *req,
>   {
>   	struct nvme_ns *ns = req->q->queuedata;
>   
> -	if ((req->cmd_flags & REQ_NVME_MPATH) && req->bio)
> +	if ((req->cmd_flags & REQ_NVME_MPATH) && req->bio) {
>   		trace_block_bio_complete(ns->head->disk->queue, req->bio);
> +
> +		/* Point bio->bi_disk to head disk.
> +		 * This bio maybe as other bio's parent in bio chain. If this bi_disk
> +		 * is kfreed by nvme_free_ns, other bio may get this bio by __bio_chain_endio
> +		 * in bio_endio, and access this bi_disk. This will trigger heap-use-after-free
> +		 * or null pointer oops.
> +		 */
> +		req->bio->bi_disk = ns->head->disk;
> +	}

This is absolutely the wrong place to do this. This is a tracing
function, it should not have any other logic.

What tree is this against anyways? There is no bi_disk in struct bio 
anymore.
