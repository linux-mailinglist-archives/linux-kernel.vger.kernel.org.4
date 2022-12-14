Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59E964CD81
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 16:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbiLNP4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 10:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238562AbiLNP4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:56:01 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5632525EA3;
        Wed, 14 Dec 2022 07:54:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EBDB621E3C;
        Wed, 14 Dec 2022 15:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671033278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y3f+FcqGXbBknqOS6KZiTyP9VJP1zOTzW5PHqNUH4Bg=;
        b=vLm8RKVBKBJMhRboOIhV92neDIINBqpSEdwkVLIEJKDZjKmKBE56ijdXwu84eVvD5fDyj+
        BcWLip4jZ/p/1PXN8uD9J+MvjVPBQ3qvBqF0uXZ0Ab7xNv/JdbWwyucwpDxWGKU3HZo+ed
        34d8PFvUrdmynD9QM5pHydYePlxAzgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671033278;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y3f+FcqGXbBknqOS6KZiTyP9VJP1zOTzW5PHqNUH4Bg=;
        b=LgsH/OWL4z4zvaU7S8lsBaO5fL75x8DVWpar7FStdALnMcpQSeZfDwgyV5P9Mdpg1v4zza
        ysCxxSN6G9JvHmDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DCA9A138F6;
        Wed, 14 Dec 2022 15:54:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2YjbNb7xmWMXWQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 14 Dec 2022 15:54:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5D883A0727; Wed, 14 Dec 2022 16:54:38 +0100 (CET)
Date:   Wed, 14 Dec 2022 16:54:38 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH v2] block, bfq: fix possible uaf for 'bfqq->bic'
Message-ID: <20221214155438.crsdb2otmsfdhamc@quack3>
References: <20221214030430.3304151-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221214030430.3304151-1-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-12-22 11:04:30, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Our test report a uaf for 'bfqq->bic' in 5.10:
> 
> ==================================================================
> BUG: KASAN: use-after-free in bfq_select_queue+0x378/0xa30
> 
> CPU: 6 PID: 2318352 Comm: fsstress Kdump: loaded Not tainted 5.10.0-60.18.0.50.h602.kasan.eulerosv2r11.x86_64 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-20220320_160524-szxrtosci10000 04/01/2014
> Call Trace:
>  bfq_select_queue+0x378/0xa30
>  bfq_dispatch_request+0xe8/0x130
>  blk_mq_do_dispatch_sched+0x62/0xb0
>  __blk_mq_sched_dispatch_requests+0x215/0x2a0
>  blk_mq_sched_dispatch_requests+0x8f/0xd0
>  __blk_mq_run_hw_queue+0x98/0x180
>  __blk_mq_delay_run_hw_queue+0x22b/0x240
>  blk_mq_run_hw_queue+0xe3/0x190
>  blk_mq_sched_insert_requests+0x107/0x200
>  blk_mq_flush_plug_list+0x26e/0x3c0
>  blk_finish_plug+0x63/0x90
>  __iomap_dio_rw+0x7b5/0x910
>  iomap_dio_rw+0x36/0x80
>  ext4_dio_read_iter+0x146/0x190 [ext4]
>  ext4_file_read_iter+0x1e2/0x230 [ext4]
>  new_sync_read+0x29f/0x400
>  vfs_read+0x24e/0x2d0
>  ksys_read+0xd5/0x1b0
>  do_syscall_64+0x33/0x40
>  entry_SYSCALL_64_after_hwframe+0x61/0xc6
> 
> Commit 3bc5e683c67d ("bfq: Split shared queues on move between cgroups")
> changes that move process to a new cgroup will allocate a new bfqq to
> use, however, the old bfqq and new bfqq can point to the same bic:
> 
> 1) Initial state, two process with io in the same cgroup.
> 
> Process 1       Process 2
>  (BIC1)          (BIC2)
>   |  Λ            |  Λ
>   |  |            |  |
>   V  |            V  |
>   bfqq1           bfqq2
> 
> 2) bfqq1 is merged to bfqq2.
> 
> Process 1       Process 2
>  (BIC1)          (BIC2)
>   |               |
>    \-------------\|
>                   V
>   bfqq1           bfqq2(coop)
> 
> 3) Process 1 exit, then issue new io(denoce IOA) from Process 2.
> 
>  (BIC2)
>   |  Λ
>   |  |
>   V  |
>   bfqq2(coop)
> 
> 4) Before IOA is completed, move Process 2 to another cgroup and issue io.
> 
> Process 2
>  (BIC2)
>    Λ
>    |\--------------\
>    |                V
>   bfqq2           bfqq3
> 
> Now that BIC2 points to bfqq3, while bfqq2 and bfqq3 both point to BIC2.
> If all the requests are completed, and Process 2 exit, BIC2 will be
> freed while there is no guarantee that bfqq2 will be freed before BIC2.
> 
> Fix the problem by clearing bfqq->bic while bfqq is detached from bic.
> 
> Fixes: 3bc5e683c67d ("bfq: Split shared queues on move between cgroups")
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
> Changes in v2:
>  - Use a new solution as suggested by Jan.
> 
>  block/bfq-iosched.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index a72304c728fc..b111a7b8dca6 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -386,6 +386,12 @@ static void bfq_put_stable_ref(struct bfq_queue *bfqq);
>  
>  void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool is_sync)
>  {
> +	struct bfq_queue *old_bfqq = bic->bfqq[is_sync];
> +
> +	/* Clear bic pointer if bfqq is detached from this bic */
> +	if (old_bfqq && old_bfqq->bic == bic)
> +		old_bfqq->bic = NULL;
> +
>  	/*
>  	 * If bfqq != NULL, then a non-stable queue merge between
>  	 * bic->bfqq and bfqq is happening here. This causes troubles
> @@ -5311,7 +5317,6 @@ static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync)
>  		unsigned long flags;
>  
>  		spin_lock_irqsave(&bfqd->lock, flags);
> -		bfqq->bic = NULL;
>  		bfq_exit_bfqq(bfqd, bfqq);
>  		bic_set_bfqq(bic, NULL, is_sync);
>  		spin_unlock_irqrestore(&bfqd->lock, flags);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
