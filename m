Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCD864A129
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiLLNgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbiLLNfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:35:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271D613F1E;
        Mon, 12 Dec 2022 05:35:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 18EF51FEA0;
        Mon, 12 Dec 2022 13:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670852138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3kvbV1iUur+xypLxktToJdMaRK2U74GIxla1Zf8hI0c=;
        b=WFdS5FsPd2V69pXoxeYLFw5qg5BMAvCJhEHE89JyLcX8K4TelIRGKt/tZMsNPaiLnbAA+x
        8GrxrEYgaeUcxlejLJVeP0JoxZnlM6bqi1h2obdFqxi0UXpocg1DXDuXTsXNBLPonbB0Lk
        k8pP28OFtXPM+LWgPUGMdk3UNoDtdOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670852138;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3kvbV1iUur+xypLxktToJdMaRK2U74GIxla1Zf8hI0c=;
        b=3UhE1553YNQujJOuI/Yo3Yi5vKTJ51zgtK57MdDL3pVoL8ypKctz2haqtoiLPKfNzENI5s
        wKEj9++BzzAEMsBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A39113456;
        Mon, 12 Dec 2022 13:35:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SZV2Aioul2M1JQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 12 Dec 2022 13:35:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 79268A0728; Mon, 12 Dec 2022 14:35:37 +0100 (CET)
Date:   Mon, 12 Dec 2022 14:35:37 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH] block, bfq: fix possible uaf for 'bfqq->bic'
Message-ID: <20221212133537.hrs5t32ijj6lxoaf@quack3>
References: <20221210102537.655670-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221210102537.655670-1-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 10-12-22 18:25:37, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Our test report a uaf for 'bfqq->bic' in 5.10:
> 
> ==================================================================
> BUG: KASAN: use-after-free in bfq_select_queue+0x378/0xa30
> Read of size 8 at addr ffff88810efb42d8 by task fsstress/2318352
> 
> CPU: 6 PID: 2318352 Comm: fsstress Kdump: loaded Not tainted 5.10.0-60.18.0.50.h602.kasan.eulerosv2r11.x86_64 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-20220320_160524-szxrtosci10000 04/01/2014
> Call Trace:
...
>  bfq_select_queue+0x378/0xa30
>  __bfq_dispatch_request+0x1c4/0x220
>  bfq_dispatch_request+0xe8/0x130
>  __blk_mq_do_dispatch_sched+0x3f4/0x560
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

Perhaps we can trim this UAF report a bit to what I've left above? That
should be enough to give idea about the problem.

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
> Process 1       Process 2（cg1)
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
> Fix the problem by clearing bfqq->bic if process references is decreased
> to zero, since that they are not related anymore.
> 
> Fixes: 3bc5e683c67d ("bfq: Split shared queues on move between cgroups")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Thanks for the analysis and the patch! I agree this is a problem.

> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index a72304c728fc..6eada99d1b34 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -3036,6 +3036,14 @@ void bfq_release_process_ref(struct bfq_data *bfqd, struct bfq_queue *bfqq)
>  
>  	bfq_reassign_last_bfqq(bfqq, NULL);
>  
> +	/*
> +	 * __bfq_bic_change_cgroup() just reset bic->bfqq so that a new bfqq
> +	 * will be created to handle new io, while old bfqq will stay around
> +	 * until all the requests are completed. It's unsafe to keep bfqq->bic
> +	 * since they are not related anymore.
> +	 */
> +	if (bfqq_process_refs(bfqq) == 1)
> +		bfqq->bic = NULL;
>  	bfq_put_queue(bfqq);

Rather than changing bfq_release_process_ref() I think it would be more
logical to change bic_set_bfqq() like:

	struct bfq_queue *old_bfqq = bic->bfqq[is_sync];

	/* Clear bic pointer if we are detaching bfqq from its bic */
	if (old_bfqq && old_bfqq->bic == bic)
		old_bfqq->bic = NULL;

And then we can also remove several explicit bfqq->bic = NULL statements
from bfq code.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
