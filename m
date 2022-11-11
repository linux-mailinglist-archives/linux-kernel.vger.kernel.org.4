Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530D3625554
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbiKKIbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiKKIbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:31:08 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071FD7B23C;
        Fri, 11 Nov 2022 00:31:07 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4N7sNm2swzz9snb;
        Fri, 11 Nov 2022 09:31:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1h5Tw1p4eEV5; Fri, 11 Nov 2022 09:31:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4N7sNm28NQz9snY;
        Fri, 11 Nov 2022 09:31:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3AB558B786;
        Fri, 11 Nov 2022 09:31:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vGQmwCgOE861; Fri, 11 Nov 2022 09:31:04 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.235.201])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F3CE68B763;
        Fri, 11 Nov 2022 09:31:03 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2AB8UrLG1224942
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 09:30:54 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2AB8Uqne1224938;
        Fri, 11 Nov 2022 09:30:52 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [PATCH v2] ata: sata_dwc_460ex: Check !irq instead of irq == NO_IRQ
Date:   Fri, 11 Nov 2022 09:30:46 +0100
Message-Id: <146506d93c96b842422d31a90b5d23c98b70a111.1668155425.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1668155445; l=2065; s=20211009; h=from:subject:message-id; bh=kJeJYqdLxMtxzzZVD2m5nEZc0ye6WZ1r6uQHyJMp1mQ=; b=fEGzqVbxatKtg4XAQ9Njlsv6bP1voD8N6m/dNiYA6BVgu8ai1aCF1l2d8a+h+op1lgCRRNfEPosz HHbgcHb+Boq3NEK9zlU2SmcussNgyUErJC0hITZ3StfDvxJRkMyk
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NO_IRQ is a relic from the old days. It is not used anymore in core
functions. By the way, function irq_of_parse_and_map() returns value 0
on error.

In some drivers, NO_IRQ is erroneously used to check the return of
irq_of_parse_and_map().

It is not a real bug today because the only architectures using the
drivers being fixed by this patch define NO_IRQ as 0, but there are
architectures which define NO_IRQ as -1. If one day those
architectures start using the non fixed drivers, there will be a
problem.

Long time ago Linus advocated for not using NO_IRQ, see
https://lkml.org/lkml/2005/11/21/221 . He re-iterated the same view
recently in https://lkml.org/lkml/2022/10/12/622

So test !irq instead of tesing irq == NO_IRQ.

And remove the fallback definition of NO_IRQ at the top of the file.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Also removed the #ifndef NO_IRQ #define NO_IRQ 0 at the top
---
 drivers/ata/sata_dwc_460ex.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index e3263e961045..7b7e1516dbdd 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -42,10 +42,6 @@
 #define sata_dwc_writel(a, v)	writel_relaxed(v, a)
 #define sata_dwc_readl(a)	readl_relaxed(a)
 
-#ifndef NO_IRQ
-#define NO_IRQ		0
-#endif
-
 #define AHB_DMA_BRST_DFLT	64	/* 16 data items burst length */
 
 enum {
@@ -242,7 +238,7 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
 
 	/* Get SATA DMA interrupt number */
 	hsdev->dma->irq = irq_of_parse_and_map(np, 1);
-	if (hsdev->dma->irq == NO_IRQ) {
+	if (!hsdev->dma->irq) {
 		dev_err(dev, "no SATA DMA irq\n");
 		return -ENODEV;
 	}
@@ -1180,7 +1176,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 
 	/* Get SATA interrupt number */
 	irq = irq_of_parse_and_map(np, 0);
-	if (irq == NO_IRQ) {
+	if (!irq) {
 		dev_err(dev, "no SATA DMA irq\n");
 		return -ENODEV;
 	}
-- 
2.37.1

