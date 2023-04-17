Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A4C6E400B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 08:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjDQGqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 02:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjDQGql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:46:41 -0400
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E610A10DE
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 23:46:38 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.138.125])
        by APP-03 (Coremail) with SMTP id rQCowABnb2dI6zxkpKH0Ag--.5355S2;
        Mon, 17 Apr 2023 14:46:32 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com, yanaijie@huawei.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] scsi: aic94xx: Add missing check for dma_map_sg()
Date:   Mon, 17 Apr 2023 14:46:31 +0800
Message-Id: <20230417064631.1939-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABnb2dI6zxkpKH0Ag--.5355S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFyUJw17Cw17WFWrJw47Arb_yoW8Gr1fpF
        WrJasI9rsrtF109wsrJFWDWF15WFn3KFW7WFWDtasIkwsxX3savrW5J3W7WFykCFWxGF47
        Ar1rA3ySgFyUt37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUj0zuJUUUUU==
X-Originating-IP: [124.16.138.125]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add check for dma_map_sg() and return error if it fails.
Moreover, unmap the first buffer when the second dma_map_sg() fails.

Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/scsi/aic94xx/aic94xx_task.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
index 7f0208300110..0ff7aac0bb29 100644
--- a/drivers/scsi/aic94xx/aic94xx_task.c
+++ b/drivers/scsi/aic94xx/aic94xx_task.c
@@ -419,11 +419,20 @@ static int asd_build_smp_ascb(struct asd_ascb *ascb, struct sas_task *task,
 	struct asd_ha_struct *asd_ha = ascb->ha;
 	struct domain_device *dev = task->dev;
 	struct scb *scb;
+	int num;
 
-	dma_map_sg(&asd_ha->pcidev->dev, &task->smp_task.smp_req, 1,
+	num = dma_map_sg(&asd_ha->pcidev->dev, &task->smp_task.smp_req, 1,
 		   DMA_TO_DEVICE);
-	dma_map_sg(&asd_ha->pcidev->dev, &task->smp_task.smp_resp, 1,
+	if (num == 0)
+		return -ENOMEM;
+
+	num = dma_map_sg(&asd_ha->pcidev->dev, &task->smp_task.smp_resp, 1,
 		   DMA_FROM_DEVICE);
+	if (num == 0) {
+		dma_unmap_sg(&asd_ha->pcidev->dev, &task->smp_task.smp_req, 1,
+			     DMA_TO_DEVICE);
+		return -ENOMEM;
+	}
 
 	scb = ascb->scb;
 
-- 
2.25.1

