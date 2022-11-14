Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F87627470
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 03:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbiKNCJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 21:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKNCJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 21:09:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A84E009
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 18:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668391687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ts9U6w5n6BGeeWKUtrtGgB4Re7OUzK6+ZorIGzZLcIM=;
        b=YMckqdgvoZG+jtefEs7Qc/XMGMtP9FQsISEnQXR0kuspxzjO/G7ygu4xSZhhxe7ohI66jI
        jLEXkbhnn7OcNZxQBKlqxLYalXUIe64VKW9S3W/AM92w/PY4s5dlns95Mp+6fHI0x673XS
        1NXeo4ZQJVScwBCSnCW5QgDhBy83EZA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-FpkZavv7Olq1dhrf_P8MEg-1; Sun, 13 Nov 2022 21:08:03 -0500
X-MC-Unique: FpkZavv7Olq1dhrf_P8MEg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFCF73C01D82;
        Mon, 14 Nov 2022 02:08:02 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D078111F3CB;
        Mon, 14 Nov 2022 02:07:58 +0000 (UTC)
Date:   Mon, 14 Nov 2022 10:07:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH -next] blk-mq: fix warning when unregister mq sysfs
Message-ID: <Y3Gi+Yt0nyYPx6hX@T590>
References: <20221112082813.704873-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221112082813.704873-1-yebin@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 04:28:13PM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> There's issue as follows when do fault injection test:
> ------------[ cut here ]------------
> kernfs: can not remove 'nr_tags', no directory
> WARNING: CPU: 8 PID: 2308 at fs/kernfs/dir.c:1635 kernfs_remove_by_name_ns+0xdd/0x100
> Modules linked in: null_blk(-)
> CPU: 8 PID: 2308 Comm: rmmod Not tainted 6.1.0-rc4-next-20221111+ #131
> RIP: 0010:kernfs_remove_by_name_ns+0xdd/0x100
> RSP: 0018:ffff88812149fbc8 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffffffffb8137508 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: ffffffffb6b49ae0 RDI: ffffed1024293f6b
> RBP: ffffffffb8137600 R08: 0000000000000001 R09: ffffed1024293f3d
> R10: ffff88812149f9e7 R11: ffffed1024293f3c R12: 0000000000000000
> R13: ffffffffb6b2d2a0 R14: ffffffffb6b2d1e0 R15: ffff88822f7f14b8
> FS:  00007f97eacb9740(0000) GS:ffff8883ace00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f97e9b72b81 CR3: 000000022fbda000 CR4: 00000000000006e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  remove_files.isra.0+0x6c/0x170
>  sysfs_remove_group+0x9b/0x180
>  sysfs_remove_groups+0x4f/0xa0
>  __kobject_del+0x7d/0x1d0
>  kobject_del+0x32/0x50
>  blk_mq_sysfs_unregister.cold+0x8/0xd
>  blk_unregister_queue+0xed/0x260
>  del_gendisk+0x27e/0x900
>  null_del_dev.part.0+0x166/0x510 [null_blk]
>  null_destroy_dev+0x37/0x5c [null_blk]
>  null_exit+0x4c/0x9d [null_blk]
>  __do_sys_delete_module.isra.0+0x2f3/0x520
>  do_syscall_64+0x3b/0x90
>  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>  </TASK>
> 
> Fault injection context as follows:
>  kobject_add
>  blk_mq_register_hctx
>  blk_mq_sysfs_register
>  blk_register_queue
>  device_add_disk
>  null_add_dev.part.0 [null_blk]
> 
> As 'blk_mq_sysfs_register' may failed, but when unregister mq sysfs don't
> judge sysfs if registered. 'blk_mq_sysfs_register' also didn't handle
> error correctly.
> To solve above issue, if sysfs is unregstered just exit.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  block/blk-mq-sysfs.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
> index 93997d297d42..0cda0a729f3c 100644
> --- a/block/blk-mq-sysfs.c
> +++ b/block/blk-mq-sysfs.c
> @@ -185,7 +185,7 @@ static int blk_mq_register_hctx(struct blk_mq_hw_ctx *hctx)
>  {
>  	struct request_queue *q = hctx->queue;
>  	struct blk_mq_ctx *ctx;
> -	int i, ret;
> +	int i, j, ret;
>  
>  	if (!hctx->nr_ctx)
>  		return 0;
> @@ -197,9 +197,16 @@ static int blk_mq_register_hctx(struct blk_mq_hw_ctx *hctx)
>  	hctx_for_each_ctx(hctx, ctx, i) {
>  		ret = kobject_add(&ctx->kobj, &hctx->kobj, "cpu%u", ctx->cpu);
>  		if (ret)
> -			break;
> +			goto out;
>  	}
>  
> +	return 0;
> +out:
> +	hctx_for_each_ctx(hctx, ctx, j) {
> +		if (j < i)
> +			kobject_del(&ctx->kobj);
> +	}
> +	kobject_del(&hctx->kobj);

The above change looks fine.

>  	return ret;
>  }
>  
> @@ -278,6 +285,8 @@ void blk_mq_sysfs_unregister(struct gendisk *disk)
>  	struct blk_mq_hw_ctx *hctx;
>  	unsigned long i;
>  
> +	if (!q->mq_sysfs_init_done)
> +		return;

The above should be one warning, and I suggest to handle failure of blk_mq_sysfs_register
from blk_register_queue() in this patch too.

Thanks,
Ming

