Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3A8745173
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjGBTqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjGBTpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:45:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6A93A85;
        Sun,  2 Jul 2023 12:42:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B458B60C75;
        Sun,  2 Jul 2023 19:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A15EC433C8;
        Sun,  2 Jul 2023 19:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326946;
        bh=wlVTynccw7PNVOK61ckZBcwokuRu5q7ogLXw3+vW4aY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cKhGWA+rXr79dyk41LhDCZ1AY1h0iAr0SYUUiNMXC6kZEW65D2UR2r/Xh1or3kAGj
         71U68tBk+3kaz8KhWJFF2nyoniTxA2M4WJqE4XTXP9it+mqmREDBsdDMH7J5nMzaXI
         Cm9oQBqIn0Jb9FQ+kGyzgcqRAGmSvCIVtndCWdGHLUoLc1bhLkOMTpsi+GbPFYLJea
         1M6fQkPErAlOpg5Z8Hg0JWdLMyBTDa+TO7uEOBEabdygJFf2P8eVLBiaJQTPwTIwUq
         J3ipSVppyaGjwYYayx0ZGfs8BELCnglhVMCXeHkgtZkoJMl5s7/Hbcxlw1gRVN2unQ
         K8pg644KpXBqQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yu Kuai <yukuai3@huawei.com>, Song Liu <song@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 4/5] md/raid10: prevent soft lockup while flush writes
Date:   Sun,  2 Jul 2023 15:42:18 -0400
Message-Id: <20230702194219.1779408-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702194219.1779408-1-sashal@kernel.org>
References: <20230702194219.1779408-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.288
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 010444623e7f4da6b4a4dd603a7da7469981e293 ]

Currently, there is no limit for raid1/raid10 plugged bio. While flushing
writes, raid1 has cond_resched() while raid10 doesn't, and too many
writes can cause soft lockup.

Follow up soft lockup can be triggered easily with writeback test for
raid10 with ramdisks:

watchdog: BUG: soft lockup - CPU#10 stuck for 27s! [md0_raid10:1293]
Call Trace:
 <TASK>
 call_rcu+0x16/0x20
 put_object+0x41/0x80
 __delete_object+0x50/0x90
 delete_object_full+0x2b/0x40
 kmemleak_free+0x46/0xa0
 slab_free_freelist_hook.constprop.0+0xed/0x1a0
 kmem_cache_free+0xfd/0x300
 mempool_free_slab+0x1f/0x30
 mempool_free+0x3a/0x100
 bio_free+0x59/0x80
 bio_put+0xcf/0x2c0
 free_r10bio+0xbf/0xf0
 raid_end_bio_io+0x78/0xb0
 one_write_done+0x8a/0xa0
 raid10_end_write_request+0x1b4/0x430
 bio_endio+0x175/0x320
 brd_submit_bio+0x3b9/0x9b7 [brd]
 __submit_bio+0x69/0xe0
 submit_bio_noacct_nocheck+0x1e6/0x5a0
 submit_bio_noacct+0x38c/0x7e0
 flush_pending_writes+0xf0/0x240
 raid10d+0xac/0x1ed0

Fix the problem by adding cond_resched() to raid10 like what raid1 did.

Note that unlimited plugged bio still need to be optimized, for example,
in the case of lots of dirty pages writeback, this will take lots of
memory and io will spend a long time in plug, hence io latency is bad.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230529131106.2123367-2-yukuai1@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid10.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index f6d2be1d23864..31ee0f2d75b70 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -934,6 +934,7 @@ static void flush_pending_writes(struct r10conf *conf)
 			else
 				generic_make_request(bio);
 			bio = next;
+			cond_resched();
 		}
 		blk_finish_plug(&plug);
 	} else
@@ -1119,6 +1120,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 		else
 			generic_make_request(bio);
 		bio = next;
+		cond_resched();
 	}
 	kfree(plug);
 }
-- 
2.39.2

