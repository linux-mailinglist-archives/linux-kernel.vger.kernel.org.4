Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4D5625505
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiKKINS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiKKINQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:13:16 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAA1729A0;
        Fri, 11 Nov 2022 00:13:14 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4N7s072rwQz9snR;
        Fri, 11 Nov 2022 09:13:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 07M8D8QAOO2x; Fri, 11 Nov 2022 09:13:11 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4N7s063rWRz9snY;
        Fri, 11 Nov 2022 09:13:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 75DA78B763;
        Fri, 11 Nov 2022 09:13:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 45bLmjQ46Rob; Fri, 11 Nov 2022 09:13:10 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.235.201])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 442AC8B786;
        Fri, 11 Nov 2022 09:13:10 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2AAIoap61220191
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 19:50:36 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2AAIoY851220189;
        Thu, 10 Nov 2022 19:50:34 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [PATCH] ata: sata_dwc_460ex: Check !irq instead of irq == NO_IRQ
Date:   Thu, 10 Nov 2022 19:50:33 +0100
Message-Id: <a99c89d7b39b63663739f064cd60514938b77833.1668106138.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1668106231; l=1673; s=20211009; h=from:subject:message-id; bh=697B1goXQCfCxCA8jP4a/aN+jcy10LL+IqzfU/rtgcU=; b=/bAZD59D7IhmBsRVLLf9ggh312NYkXw4m3g7vxpft2/aRG/FjRQ5sSJl85mXQsVi+6XKdrvhWBzL 2k0tpyW2CCXgccKpZ3DGHikIMtUldnUOpQXPI+caqba0Olj0PYPW
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

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/ata/sata_dwc_460ex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index e3263e961045..5fb80ccde65b 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -242,7 +242,7 @@ static int sata_dwc_dma_init_old(struct platform_device *pdev,
 
 	/* Get SATA DMA interrupt number */
 	hsdev->dma->irq = irq_of_parse_and_map(np, 1);
-	if (hsdev->dma->irq == NO_IRQ) {
+	if (!hsdev->dma->irq) {
 		dev_err(dev, "no SATA DMA irq\n");
 		return -ENODEV;
 	}
@@ -1180,7 +1180,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 
 	/* Get SATA interrupt number */
 	irq = irq_of_parse_and_map(np, 0);
-	if (irq == NO_IRQ) {
+	if (!irq) {
 		dev_err(dev, "no SATA DMA irq\n");
 		return -ENODEV;
 	}
-- 
2.37.1

