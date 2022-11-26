Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4B1639317
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 02:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiKZB0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 20:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiKZB0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 20:26:12 -0500
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EAFC343878;
        Fri, 25 Nov 2022 17:26:10 -0800 (PST)
Received: from localhost.localdomain (unknown [124.16.138.125])
        by APP-05 (Coremail) with SMTP id zQCowABXd8wna4FjF24+Ag--.33231S2;
        Sat, 26 Nov 2022 09:25:59 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     error27@gmail.com, maximlevitsky@gmail.com, oakad@yahoo.com,
        ulf.hansson@linaro.org, christophe.jaillet@wanadoo.fr,
        axboe@kernel.dk, hare@suse.de
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v2] memstick/ms_block: Add check for alloc_ordered_workqueue
Date:   Sat, 26 Nov 2022 09:25:58 +0800
Message-Id: <20221126012558.34374-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABXd8wna4FjF24+Ag--.33231S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFy5WF4UCF1xAFyxJF1kZrb_yoW8Xw4fpa
        15CF9rWw4rGa1DGrn8tr15WFW3C3W8G3yfG3sagwnIvwn5ArsxXFyxtas0qFs8uFZ3JF4D
        AFsxt3yDWFyDJw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
        73UjIFyTuYvjfUOMKZDUUUU
X-Originating-IP: [124.16.138.125]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the alloc_ordered_workqueue may return NULL pointer,
it should be better to add check for the return
value.
Moreover, the msb->io_queue should be freed if error occurs later.

Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog:

v1 -> v2:

1. Assign error number to rc if alloc_ordered_workqueue fails.
2. Free msb->io_queue if error occurs later.
---
 drivers/memstick/core/ms_block.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index ba8414519515..04115cd92433 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -2116,6 +2116,11 @@ static int msb_init_disk(struct memstick_dev *card)
 	dbg("Set total disk size to %lu sectors", capacity);
 
 	msb->io_queue = alloc_ordered_workqueue("ms_block", WQ_MEM_RECLAIM);
+	if (!msb->io_queue) {
+		rc = -ENOMEM;
+		goto out_cleanup_disk;
+	}
+
 	INIT_WORK(&msb->io_work, msb_io_work);
 	sg_init_table(msb->prealloc_sg, MS_BLOCK_MAX_SEGS+1);
 
@@ -2125,10 +2130,12 @@ static int msb_init_disk(struct memstick_dev *card)
 	msb_start(card);
 	rc = device_add_disk(&card->dev, msb->disk, NULL);
 	if (rc)
-		goto out_cleanup_disk;
+		goto out_destroy_workqueue;
 	dbg("Disk added");
 	return 0;
 
+out_destroy_workqueue:
+	destroy_workqueue(msb->io_queue);
 out_cleanup_disk:
 	put_disk(msb->disk);
 out_free_tag_set:
-- 
2.25.1

