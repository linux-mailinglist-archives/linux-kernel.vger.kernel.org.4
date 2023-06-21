Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFB9739252
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 00:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjFUWMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 18:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFUWMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 18:12:34 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B04619A9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:12:33 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-553c1541d35so2956610a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 15:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687385553; x=1689977553;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X5VBBI/+jK44r8RvxRWw6Pxxx0HHmouRM7Vuu61DxBc=;
        b=ZKFduUXMqvHzJOf3UgLb97A+JHqDsiqXtcz2NMmAV981AciF79aoVdTcfE6M7kQgKu
         8oQ5a8Q1mHnLFI2EVFlqUgOu+UffFBV/vAxnN8rv4dnLI0kxPDJOWAC8ieIfoidC8y47
         yFDLYKH6yJOAWVXmlhWBznLaML3LiooehL2uIF8J1bWz8BXCYoQYhmqJ8VLv+KhmhLLl
         JUW6gtYuIAcrVIvnsEw3ZaTZKJEQgykV9lUOqIt0COQygAKNtlts2x5iG6Ie85IVtKSL
         1i9F9F1USnJnf1tdhN3siTIHGWD2WFrmbM8uxM3VRmIGb1Ob36uQNY+QyRYoLV5oTwec
         UF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687385553; x=1689977553;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X5VBBI/+jK44r8RvxRWw6Pxxx0HHmouRM7Vuu61DxBc=;
        b=QTG3N1hEDfXd7Tla86GVwQsCqguFbfIlFwBXEMGU/FzXKUuOfYDIVpok2poNm0A/wO
         IyRLSPbQx1zo9FqSnxncRdO7MkzBzzms7j3y+RX8q/n2nWyChTsIYLXCYvwy7zA0EhAR
         IZwR3aK8zcQb81Qbn0A0RjHaM8Ya9io6fXv7EHN9OKAi0we4j62x9TWftO4wSycHUZ7O
         SOVveSpKkyj5+kWc0Zvk9TJDPU0d+Kekd4hkjkzUeofFP3QJaz0r+oFsXvRQJW3lZVjM
         mi1zGXDm27m6yKWqVLUNpasSqu79/Dz/eDjiOolhacYO7cwSa/d/QL/3v/1SH9vrFbLO
         py0w==
X-Gm-Message-State: AC+VfDw+EipRbYp4VDm10PluNY23UKh06e356Dv2cI7Y2BLNQOOF8L8Y
        3HoU/GEiAtIvmT/+9viTqt4l0xUhmHN+
X-Google-Smtp-Source: ACHHUZ4+BET7n1d9xU6fAnQCVLRtCIOnbouCbHDq7OzYGEOhVbYdx7BTlJVjV41tRdd49wW6zTh+HLTcl2dz
X-Received: from dhavale-ctop.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5e39])
 (user=dhavale job=sendgmr) by 2002:a65:6418:0:b0:553:c671:b9f4 with SMTP id
 a24-20020a656418000000b00553c671b9f4mr1423444pgv.6.1687385552761; Wed, 21 Jun
 2023 15:12:32 -0700 (PDT)
Date:   Wed, 21 Jun 2023 15:08:47 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621220848.3379029-1-dhavale@google.com>
Subject: [PATCH v1] erofs: Fix detection of atomic context
From:   Sandeep Dhavale <dhavale@google.com>
To:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Sandeep Dhavale <dhavale@google.com>,
        Will Shiu <Will.Shiu@mediatek.com>, kernel-team@android.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current check for atomic context is not sufficient as
z_erofs_decompressqueue_endio can be called under rcu lock
from blk_mq_flush_plug_list(). See the stacktrace [1]

In such case we should hand off the decompression work for async
processing rather than trying to do sync decompression in current
context. Patch fixes the detection by checking for
rcu_read_lock_any_held() and while at it use more appropriate
!in_task() check than in_atomic().

Background: Historically erofs would always schedule a kworker for
decompression which would incur the scheduling cost regardless of
the context. But z_erofs_decompressqueue_endio() may not always
be in atomic context and we could actually benefit from doing the
decompression in z_erofs_decompressqueue_endio() if we are in
thread context, for example when running with dm-verity.
This optimization was later added in patch [2] which has shown
improvement in performance benchmarks.

==============================================
[1] Problem stacktrace
[name:core&]BUG: sleeping function called from invalid context at kernel/locking/mutex.c:291
[name:core&]in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1615, name: CpuMonitorServi
[name:core&]preempt_count: 0, expected: 0
[name:core&]RCU nest depth: 1, expected: 0
CPU: 7 PID: 1615 Comm: CpuMonitorServi Tainted: G S      W  OE      6.1.25-android14-5-maybe-dirty-mainline #1
Hardware name: MT6897 (DT)
Call trace:
 dump_backtrace+0x108/0x15c
 show_stack+0x20/0x30
 dump_stack_lvl+0x6c/0x8c
 dump_stack+0x20/0x48
 __might_resched+0x1fc/0x308
 __might_sleep+0x50/0x88
 mutex_lock+0x2c/0x110
 z_erofs_decompress_queue+0x11c/0xc10
 z_erofs_decompress_kickoff+0x110/0x1a4
 z_erofs_decompressqueue_endio+0x154/0x180
 bio_endio+0x1b0/0x1d8
 __dm_io_complete+0x22c/0x280
 clone_endio+0xe4/0x280
 bio_endio+0x1b0/0x1d8
 blk_update_request+0x138/0x3a4
 blk_mq_plug_issue_direct+0xd4/0x19c
 blk_mq_flush_plug_list+0x2b0/0x354
 __blk_flush_plug+0x110/0x160
 blk_finish_plug+0x30/0x4c
 read_pages+0x2fc/0x370
 page_cache_ra_unbounded+0xa4/0x23c
 page_cache_ra_order+0x290/0x320
 do_sync_mmap_readahead+0x108/0x2c0
 filemap_fault+0x19c/0x52c
 __do_fault+0xc4/0x114
 handle_mm_fault+0x5b4/0x1168
 do_page_fault+0x338/0x4b4
 do_translation_fault+0x40/0x60
 do_mem_abort+0x60/0xc8
 el0_da+0x4c/0xe0
 el0t_64_sync_handler+0xd4/0xfc
 el0t_64_sync+0x1a0/0x1a4

[2] Link: https://lore.kernel.org/all/20210317035448.13921-1-huangjianan@oppo.com/

Reported-by: Will Shiu <Will.Shiu@mediatek.com>
Suggested-by: Gao Xiang <xiang@kernel.org>
Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 fs/erofs/zdata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 264bf553c287..5f1890e309c6 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1447,7 +1447,7 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 	if (atomic_add_return(bios, &io->pending_bios))
 		return;
 	/* Use (kthread_)work and sync decompression for atomic contexts only */
-	if (in_atomic() || irqs_disabled()) {
+	if (!in_task() || irqs_disabled() || rcu_read_lock_any_held()) {
 #ifdef CONFIG_EROFS_FS_PCPU_KTHREAD
 		struct kthread_worker *worker;
 
-- 
2.41.0.162.gfafddb0af9-goog

