Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BA468E8B0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjBHHGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBHHGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:06:22 -0500
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D24AA1BC0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:06:20 -0800 (PST)
Received: from localhost.localdomain (unknown [124.16.138.125])
        by APP-05 (Coremail) with SMTP id zQCowADX3vLgSeNj3KslBA--.38623S2;
        Wed, 08 Feb 2023 15:06:09 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     ogabbay@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        ttayar@habana.ai, dliberman@habana.ai, obitton@habana.ai,
        osharabi@habana.ai, dhirschfeld@habana.ai
Cc:     linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] habanalabs: Fix freeing uninitialized pointers
Date:   Wed,  8 Feb 2023 15:05:59 +0800
Message-Id: <20230208070559.19589-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADX3vLgSeNj3KslBA--.38623S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GrWrXw18tFWxKw4Dtr1kZrb_yoWDKrb_Wr
        WrZr12qry8GFnY9wnIyr45Zryjk3yDGr4kZFnagFZ5tryavw4SqryvvrnYg3Wfua1Yywnr
        Zr1jg3yS9348KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
        0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoO
        J5UUUUU
X-Originating-IP: [124.16.138.125]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the memory allocated by kcalloc has not been set to zero, it may
contain uninitialized pointers.
Therefore, free the non-NULL pointers may cause undefined behaviour.

Fixes: 5574cb2194b1 ("habanalabs: Assign each CQ with its own work queue")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/misc/habanalabs/common/device.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 87ab329e65d4..dc6fcb9cca7a 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -901,9 +901,8 @@ static int device_early_init(struct hl_device *hdev)
 free_eq_wq:
 	destroy_workqueue(hdev->eq_wq);
 free_cq_wq:
-	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
-		if (hdev->cq_wq[i])
-			destroy_workqueue(hdev->cq_wq[i]);
+	while (i--)
+		destroy_workqueue(hdev->cq_wq[i]);
 	kfree(hdev->cq_wq);
 asid_fini:
 	hl_asid_fini(hdev);
-- 
2.25.1

