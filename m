Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFDE5F60B6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 07:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiJFFhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 01:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJFFhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 01:37:13 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2619796A9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 22:37:12 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MjgDl4669z9srT;
        Thu,  6 Oct 2022 07:37:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id odayZfG_m7h5; Thu,  6 Oct 2022 07:37:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MjgDl3RFPz9srN;
        Thu,  6 Oct 2022 07:37:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 65A528B765;
        Thu,  6 Oct 2022 07:37:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id XmtdwkcWTKNJ; Thu,  6 Oct 2022 07:37:11 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.234])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3FA448B763;
        Thu,  6 Oct 2022 07:37:11 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2965avtQ213290
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 6 Oct 2022 07:36:57 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2965auF5213276;
        Thu, 6 Oct 2022 07:36:56 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] uio: uio_fsl_elbc_gpcm: Replace NO_IRQ by 0
Date:   Thu,  6 Oct 2022 07:36:50 +0200
Message-Id: <68ccdf51811ab26bdb452babf17ae860fa4900c2.1665034535.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1665034609; l=1366; s=20211009; h=from:subject:message-id; bh=IhUmM59Bi4OxIXBZPLXUc5310CIz8zYhGR7D9RGi2qs=; b=pq/37VGqLZXZP4LwG8NRuo04SNfJTXDzlW4WRpXZjAQ1ta5/EvzzHx0gKE2YTa83whvBxlFKy+1Z XJmQoGwmDtsl7qW1VPZlOnUh3D7vo0jXsupLSBgiL/2AMM6mLKaA
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NO_IRQ is used to check the return of irq_of_parse_and_map().

On some architecture NO_IRQ is 0, on other architectures it is -1.

irq_of_parse_and_map() returns 0 on error, independent of NO_IRQ.

So use 0 instead of using NO_IRQ.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/uio/uio_fsl_elbc_gpcm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/uio/uio_fsl_elbc_gpcm.c b/drivers/uio/uio_fsl_elbc_gpcm.c
index 7d8eb9dc2068..82dda799f327 100644
--- a/drivers/uio/uio_fsl_elbc_gpcm.c
+++ b/drivers/uio/uio_fsl_elbc_gpcm.c
@@ -390,13 +390,13 @@ static int uio_fsl_elbc_gpcm_probe(struct platform_device *pdev)
 	info->priv = priv;
 	info->name = uio_name;
 	info->version = "0.0.1";
-	if (irq != NO_IRQ) {
+	if (irq) {
 		if (priv->irq_handler) {
 			info->irq = irq;
 			info->irq_flags = IRQF_SHARED;
 			info->handler = priv->irq_handler;
 		} else {
-			irq = NO_IRQ;
+			irq = 0;
 			dev_warn(priv->dev, "ignoring irq, no handler\n");
 		}
 	}
@@ -417,7 +417,7 @@ static int uio_fsl_elbc_gpcm_probe(struct platform_device *pdev)
 	dev_info(priv->dev,
 		 "eLBC/GPCM device (%s) at 0x%llx, bank %d, irq=%d\n",
 		 priv->name, (unsigned long long)res.start, priv->bank,
-		 irq != NO_IRQ ? irq : -1);
+		 irq ? : -1);
 
 	return 0;
 out_err2:
-- 
2.37.1

