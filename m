Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F345F74513D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjGBTpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjGBTnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:43:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B9B2D79;
        Sun,  2 Jul 2023 12:42:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E55460DBE;
        Sun,  2 Jul 2023 19:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613C8C433C7;
        Sun,  2 Jul 2023 19:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326907;
        bh=IyU/Yhadw3CmrZucro21DPcfsbzu3Hwp3ekwYzzbAd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XUbGDWZSamQBldmVloJtVJAI47kR9xdO5LPnzqJKzIzV2jx0dHhrS4zh6EGV73gex
         JofD39v7iNgDU3E4oCpHDGOpuJWIqSB5F0ObSyzHQcfcJU9S/ijbzSc56CCxDPpRl+
         VmMB7NfPSRSiAR11aSoex6N2Ivo2w+luSPwxslvwjmwQvYhR2ZeYr1PWEgNoN9JNvE
         N5IjR7m0kDU5lCIfWzggHdwDcn4kGaVSOGcZmnHSGqdl1jlwWiTg3+t8oeDZzqhicb
         6yHTFRomoo00H+nWpOOiZr+oV1y7WUxdEuU7vJgofvpWuPHvDa1L9aNYCKa2QmIrUB
         qXJfmarE/fuPw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yu Kuai <yukuai3@huawei.com>, Song Liu <song@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 05/10] md/raid10: prevent soft lockup while flush writes
Date:   Sun,  2 Jul 2023 15:41:34 -0400
Message-Id: <20230702194139.1778398-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702194139.1778398-1-sashal@kernel.org>
References: <20230702194139.1778398-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.119
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
index 1f5589c5294dc..ddfccc0a5dcf6 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -895,6 +895,7 @@ static void flush_pending_writes(struct r10conf *conf)
 			else
 				submit_bio_noacct(bio);
 			bio = next;
+			cond_resched();
 		}
 		blk_finish_plug(&plug);
 	} else
@@ -1108,6 +1109,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 		else
 			submit_bio_noacct(bio);
 		bio = next;
+		cond_resched();
 	}
 	kfree(plug);
 }
-- 
2.39.2

