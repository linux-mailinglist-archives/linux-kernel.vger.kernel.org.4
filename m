Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB766903E8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjBIJfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBIJfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:35:17 -0500
X-Greylist: delayed 414 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Feb 2023 01:35:15 PST
Received: from cstnet.cn (smtp80.cstnet.cn [159.226.251.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0CC35EFBE;
        Thu,  9 Feb 2023 01:35:15 -0800 (PST)
Received: from localhost.localdomain (unknown [124.16.138.125])
        by APP-01 (Coremail) with SMTP id qwCowABHTs6vvORjDk40BA--.101S2;
        Thu, 09 Feb 2023 17:28:15 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     s.shtylyov@omp.ru, damien.lemoal@opensource.wdc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] ata: pata_pxa: Add missing check for devm_ioremap
Date:   Thu,  9 Feb 2023 17:28:14 +0800
Message-Id: <20230209092814.10847-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowABHTs6vvORjDk40BA--.101S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFWxuFW8CFW5Jw4ftr4xJFb_yoW3tFc_Ca
        yxZFWrW3yjkFyIk3WUJr13ZrW2y3s5uFna9FyftF93JrW5Xr4xX345Zws8Z39ru3y8GFnx
        Jw1UXFW5uF15CjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2AFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8uwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
        1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4KZXUUUUU=
X-Originating-IP: [124.16.138.125]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the check for the return value of the devm_ioremap in order to avoid
NULL pointer dereference.

Fixes: 2dc6c6f15da9 ("[ARM] pata_pxa: DMA-capable PATA driver")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/ata/pata_pxa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index 985f42c4fd70..a20bb0824573 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -227,6 +227,8 @@ static int pxa_ata_probe(struct platform_device *pdev)
 						resource_size(ctl_res));
 	ap->ioaddr.bmdma_addr	= devm_ioremap(&pdev->dev, dma_res->start,
 						resource_size(dma_res));
+	if (!ap->ioaddr.cmd_addr || !ap->ioaddr.ctl_addr || !ap->ioaddr.bmdma_addr)
+		return -ENOMEM;
 
 	/*
 	 * Adjust register offsets
-- 
2.25.1

