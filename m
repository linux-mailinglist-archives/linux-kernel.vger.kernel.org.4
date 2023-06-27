Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D70C73F2F8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 05:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjF0Dpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 23:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjF0Do4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 23:44:56 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9097B3A8D;
        Mon, 26 Jun 2023 20:42:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QqrBH443mz4f3khW;
        Tue, 27 Jun 2023 11:42:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7OXWppk2B6CMg--.877S6;
        Tue, 27 Jun 2023 11:42:17 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Subject: [PATCH 2/2] md/raid10: handle replacement devices in fix_recovery_read_error
Date:   Tue, 27 Jun 2023 11:41:27 +0800
Message-Id: <20230627034127.4000994-3-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627034127.4000994-1-linan666@huaweicloud.com>
References: <20230627034127.4000994-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7OXWppk2B6CMg--.877S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw18GFy8Kr17CF1kXF1UWrg_yoW8Cr15pr
        nrC3ZYvr98Ga4xZFn8JayDCasYkw1SyrWFyrn5Xw4a934ftrZxKFWagFWjgry8WFyFqF45
        Xan8Kr4rAF1DtaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUQIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrV
        ACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWU
        JVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMx
        kF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r12
        6r1DMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8GsjUUUUUU==
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

In fix_recovery_read_error(), the handling of replacement devices is
missing. Add it. If io error is from replacement, error this device
directly. If io error is from other device, just set badblocks for
replacement.

Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/raid10.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 5105273f60e9..6d9025089455 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2551,7 +2551,7 @@ static void fix_recovery_read_error(struct r10bio *r10_bio)
 
 	while (sectors) {
 		int s = sectors;
-		struct md_rdev *rdev;
+		struct md_rdev *rdev, *repl;
 		sector_t addr;
 		int ok;
 
@@ -2559,6 +2559,7 @@ static void fix_recovery_read_error(struct r10bio *r10_bio)
 			s = PAGE_SIZE >> 9;
 
 		rdev = conf->mirrors[dr].rdev;
+		repl = conf->mirrors[dw].replacement;
 		addr = r10_bio->devs[0].addr + sect,
 		ok = sync_page_io(rdev,
 				  addr,
@@ -2580,6 +2581,9 @@ static void fix_recovery_read_error(struct r10bio *r10_bio)
 					set_bit(MD_RECOVERY_NEEDED,
 						&rdev->mddev->recovery);
 			}
+			if (repl && !sync_page_io(repl, addr, s << 9,
+			    pages[idx], REQ_OP_WRITE, false))
+				md_error(mddev, repl);
 		}
 		if (!ok) {
 			/* We don't worry if we cannot set a bad block -
@@ -2592,7 +2596,9 @@ static void fix_recovery_read_error(struct r10bio *r10_bio)
 				/* need bad block on destination too */
 				rdev = conf->mirrors[dw].rdev;
 				addr = r10_bio->devs[1].addr + sect;
-				if (!rdev_set_badblocks(rdev, addr, s, 0)) {
+				if (!rdev_set_badblocks(rdev, addr, s, 0) ||
+				    (repl &&
+				    !rdev_set_badblocks(repl, addr, s, 0))) {
 					/* just abort the recovery */
 					pr_notice("md/raid10:%s: recovery aborted due to read error\n",
 						  mdname(mddev));
-- 
2.39.2

