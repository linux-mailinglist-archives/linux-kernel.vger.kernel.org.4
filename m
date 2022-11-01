Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1658D615082
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiKARWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiKARW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:22:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D081C1B1DA;
        Tue,  1 Nov 2022 10:22:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BBEEB81E94;
        Tue,  1 Nov 2022 17:22:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95AF3C43470;
        Tue,  1 Nov 2022 17:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667323345;
        bh=R3TRmjuGx+CX5AlLSbI9Rvvjf7XA13+5XQn1/SO/l5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L/kAMOScwPlrSIF+9gRC70XY3fpqGTMzrt3tXL/NorI0wBHDs8oJu+8+siDIvZ3U+
         X7YFTBLqTcEAs4KyzWnMYYuDQGzwofeTbQt+bIHTpigOxuYtw5ltL0NGTSpVw4o1AZ
         ZPTCjZImXmCP9ooRI96Y8WH8oOdpiqyR76XO0pTTjYvB/U7hJXwA7poJgI6GqAE7Is
         LN3BJAIgO0rzZsgRi74wtYxMkBCqSSjRmxMY1gQTsxQ8+2Qmq3zSOrGsL2DGNdtvti
         cdHoTgR3qen8cl0FZ+zNpyJKzTXj6iUbeTiPmslAtbz/avpihFxLNXA5+1ev48teOo
         mMajMspEW1keA==
Date:   Tue, 1 Nov 2022 11:22:21 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Dmitrii Tcvetkov <me@demsh.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [bisected] RAID1 direct IO redirecting sector loop since 6.0
Message-ID: <Y2FVzdcro8HCfODK@kbusch-mbp>
References: <20221101001558.648ee024@xps.demsh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101001558.648ee024@xps.demsh.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 12:15:58AM +0300, Dmitrii Tcvetkov wrote:
> 
> # cat /proc/7906/stack
> [<0>] submit_bio_wait+0xdb/0x140
> [<0>] blkdev_direct_IO+0x62f/0x770
> [<0>] blkdev_read_iter+0xc1/0x140
> [<0>] vfs_read+0x34e/0x3c0
> [<0>] __x64_sys_pread64+0x74/0xc0
> [<0>] do_syscall_64+0x6a/0x90
> [<0>] entry_SYSCALL_64_after_hwframe+0x4b/0xb5
> 
> After "mdadm --fail" invocation the last line becomes:
> [pid  7906] pread64(13, 0x627c34c8d200, 4096, 0) = -1 EIO (Input/output error)

It looks like something isn't accounting for the IO size correctly when
there's an offset. It may be something specific to one of the stacking
drivers in your block setup. Does this still happen without the
cryptosetup step?

For a different experiment, it may be safer to just force all alignment
for stacking drivers. Could you try the following and see if that gets
it working again? 

---
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 8bb9eef5310e..5c16fdb00c6f 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -646,6 +646,7 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 		t->misaligned = 1;
 		ret = -1;
 	}
+	blk_queue_dma_alignment(t, t->logical_block_size - 1);
 
 	t->max_sectors = blk_round_down_sectors(t->max_sectors, t->logical_block_size);
 	t->max_hw_sectors = blk_round_down_sectors(t->max_hw_sectors, t->logical_block_size);
--
