Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BB9725B20
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbjFGJ5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjFGJ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:56:58 -0400
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D12173B;
        Wed,  7 Jun 2023 02:56:56 -0700 (PDT)
Received: from ed3e173716be.home.arpa (unknown [124.16.138.125])
        by APP-03 (Coremail) with SMTP id rQCowAD3_y_cT4BkWqGxDA--.3849S2;
        Wed, 07 Jun 2023 17:37:33 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     james.smart@broadcom.com, ram.vegesna@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        chenzhongjin@huawei.com, dwagner@suse.de, hare@suse.de
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] scsi: efct: Add missing check for ioremap
Date:   Wed,  7 Jun 2023 17:37:30 +0800
Message-Id: <20230607093730.18982-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAD3_y_cT4BkWqGxDA--.3849S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw4Utr45ZFWDurWrXrWfuFg_yoWkCwc_uF
        ZI9ryfurWDCr1kJr17Ar1xA39I9rsIgw1fWr1Fqa4F9wsxXrZruay8AF97JrWjgw4ktF1D
        GryDJr4Ykw1jkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbV8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7MxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JU4BT5UUUUU=
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

Add check for ioremap() and return the error if it fails in order to
guarantee the success of ioremap().

Fixes: 4df84e846624 ("scsi: elx: efct: Driver initialization routines")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/scsi/elx/efct/efct_driver.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/elx/efct/efct_driver.c b/drivers/scsi/elx/efct/efct_driver.c
index 49fd2cfed70c..77c6252dcb3e 100644
--- a/drivers/scsi/elx/efct/efct_driver.c
+++ b/drivers/scsi/elx/efct/efct_driver.c
@@ -528,6 +528,8 @@ efct_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		if (pci_resource_flags(pdev, i) & IORESOURCE_MEM) {
 			efct->reg[r] = ioremap(pci_resource_start(pdev, i),
 					       pci_resource_len(pdev, i));
+			if (!efct->reg[r])
+				goto ioremap_out;
 			r++;
 		}
 
@@ -580,7 +582,7 @@ efct_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	efct_teardown_msix(efct);
 dma_mask_out:
 	pci_set_drvdata(pdev, NULL);
-
+ioremap_out:
 	for (i = 0; i < EFCT_PCI_MAX_REGS; i++) {
 		if (efct->reg[i])
 			iounmap(efct->reg[i]);
-- 
2.25.1

