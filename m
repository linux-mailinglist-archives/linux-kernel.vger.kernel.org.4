Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1841B6F757F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjEDT5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjEDTzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:55:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF84C1CFE2;
        Thu,  4 May 2023 12:49:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A8D7637CB;
        Thu,  4 May 2023 19:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D2AC433D2;
        Thu,  4 May 2023 19:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229667;
        bh=4y7pOBGCYDjIbIf9y/Y4h8+y9QfTW9ujHRZ0qgN4S/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iK3Up/gnNn/pCHA0NkimwnR7kr1pdrWO7jB2JHXpvJOiasaOfTd3E6OPQ3LdN9lrK
         BP0kGBbLpO0sfW5OqIIXeAkuEL39Fhtf/gLUnFzFC/wyO4BT7v3fWks53Fq1ofy4L5
         PD2UMStNGGmBHEZsujbsSSMx1r+/0CQkD+JykGez4iYfWtlVcsxriITw6jVz523Aez
         rVeqUeSS1NAO7j3MIHiKjikPmQcg7fmwZ12MXmVCVVkIxVrDEa2cusvo2AeqLQdmFX
         0X656v6+MGvobeWq1tdhQDkE/h/dTwVkyE0bqEYAUbm1EIL84Iox10mjWILDbXK/+N
         C6LlWGox84Awg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        paolo.valente@linaro.org, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 32/49] block, bfq: Fix division by zero error on zero wsum
Date:   Thu,  4 May 2023 15:46:09 -0400
Message-Id: <20230504194626.3807438-32-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194626.3807438-1-sashal@kernel.org>
References: <20230504194626.3807438-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.i.king@gmail.com>

[ Upstream commit e53413f8deedf738a6782cc14cc00bd5852ccf18 ]

When the weighted sum is zero the calculation of limit causes
a division by zero error. Fix this by continuing to the next level.

This was discovered by running as root:

stress-ng --ioprio 0

Fixes divison by error oops:

[  521.450556] divide error: 0000 [#1] SMP NOPTI
[  521.450766] CPU: 2 PID: 2684464 Comm: stress-ng-iopri Not tainted 6.2.1-1280.native #1
[  521.451117] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
[  521.451627] RIP: 0010:bfqq_request_over_limit+0x207/0x400
[  521.451875] Code: 01 48 8d 0c c8 74 0b 48 8b 82 98 00 00 00 48 8d 0c c8 8b 85 34 ff ff ff 48 89 ca 41 0f af 41 50 48 d1 ea 48 98 48 01 d0 31 d2 <48> f7 f1 41 39 41 48 89 85 34 ff ff ff 0f 8c 7b 01 00 00 49 8b 44
[  521.452699] RSP: 0018:ffffb1af84eb3948 EFLAGS: 00010046
[  521.452938] RAX: 000000000000003c RBX: 0000000000000000 RCX: 0000000000000000
[  521.453262] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffb1af84eb3978
[  521.453584] RBP: ffffb1af84eb3a30 R08: 0000000000000001 R09: ffff8f88ab8a4ba0
[  521.453905] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8f88ab8a4b18
[  521.454224] R13: ffff8f8699093000 R14: 0000000000000001 R15: ffffb1af84eb3970
[  521.454549] FS:  00005640b6b0b580(0000) GS:ffff8f88b3880000(0000) knlGS:0000000000000000
[  521.454912] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  521.455170] CR2: 00007ffcbcae4e38 CR3: 00000002e46de001 CR4: 0000000000770ee0
[  521.455491] PKRU: 55555554
[  521.455619] Call Trace:
[  521.455736]  <TASK>
[  521.455837]  ? bfq_request_merge+0x3a/0xc0
[  521.456027]  ? elv_merge+0x115/0x140
[  521.456191]  bfq_limit_depth+0xc8/0x240
[  521.456366]  __blk_mq_alloc_requests+0x21a/0x2c0
[  521.456577]  blk_mq_submit_bio+0x23c/0x6c0
[  521.456766]  __submit_bio+0xb8/0x140
[  521.457236]  submit_bio_noacct_nocheck+0x212/0x300
[  521.457748]  submit_bio_noacct+0x1a6/0x580
[  521.458220]  submit_bio+0x43/0x80
[  521.458660]  ext4_io_submit+0x23/0x80
[  521.459116]  ext4_do_writepages+0x40a/0xd00
[  521.459596]  ext4_writepages+0x65/0x100
[  521.460050]  do_writepages+0xb7/0x1c0
[  521.460492]  __filemap_fdatawrite_range+0xa6/0x100
[  521.460979]  file_write_and_wait_range+0xbf/0x140
[  521.461452]  ext4_sync_file+0x105/0x340
[  521.461882]  __x64_sys_fsync+0x67/0x100
[  521.462305]  ? syscall_exit_to_user_mode+0x2c/0x1c0
[  521.462768]  do_syscall_64+0x3b/0xc0
[  521.463165]  entry_SYSCALL_64_after_hwframe+0x5a/0xc4
[  521.463621] RIP: 0033:0x5640b6c56590
[  521.464006] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 80 3d 71 70 0e 00 00 74 17 b8 4a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Link: https://lore.kernel.org/r/20230413133009.1605335-1-colin.i.king@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bfq-iosched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index ff9d238894157..52eb79d60a3f3 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -637,6 +637,8 @@ static bool bfqq_request_over_limit(struct bfq_queue *bfqq, int limit)
 					sched_data->service_tree[i].wsum;
 			}
 		}
+		if (!wsum)
+			continue;
 		limit = DIV_ROUND_CLOSEST(limit * entity->weight, wsum);
 		if (entity->allocated >= limit) {
 			bfq_log_bfqq(bfqq->bfqd, bfqq,
-- 
2.39.2

