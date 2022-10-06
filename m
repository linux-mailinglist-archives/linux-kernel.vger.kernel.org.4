Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FA95F6093
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 07:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJFFYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 01:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJFFY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 01:24:27 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6B1760E1
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 22:24:26 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Mjfy04fXtz9srK;
        Thu,  6 Oct 2022 07:24:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JFDVKqW9pMLK; Thu,  6 Oct 2022 07:24:24 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Mjfy03kv3z9scJ;
        Thu,  6 Oct 2022 07:24:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6BCFE8B765;
        Thu,  6 Oct 2022 07:24:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qxpcNt9sdWlA; Thu,  6 Oct 2022 07:24:24 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.234])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4895F8B763;
        Thu,  6 Oct 2022 07:24:24 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2965O9aq211188
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 6 Oct 2022 07:24:09 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2965O8OA211185;
        Thu, 6 Oct 2022 07:24:08 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [PATCH] iommu: fsl_pamu: Replace NO_IRQ by 0
Date:   Thu,  6 Oct 2022 07:24:03 +0200
Message-Id: <2a2570a8d12c80a7d36837b6c586daa708ca09d7.1665033732.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1665033842; l=1066; s=20211009; h=from:subject:message-id; bh=WVcxtNkdP75Xbucx/zgnBIsm6p0wTWlU5q6S1YFhBNo=; b=SaE4BxoXgGNkBEuhgX2OV8RyZh6I7OEIu2MewWz3a4QCsIWqiBhiJx+UF+r4gbfgHQlgC9/LO1BI HKYnTZX+CAdUQZ4xQjfVFsxL/M7lXwgz44SpMlCGlAw/UT2rhSc2
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
 drivers/iommu/fsl_pamu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index 0d03f837a5d4..1b53d2da2c19 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -779,7 +779,7 @@ static int fsl_pamu_probe(struct platform_device *pdev)
 	of_get_address(dev->of_node, 0, &size, NULL);
 
 	irq = irq_of_parse_and_map(dev->of_node, 0);
-	if (irq == NO_IRQ) {
+	if (!irq) {
 		dev_warn(dev, "no interrupts listed in PAMU node\n");
 		goto error;
 	}
@@ -903,7 +903,7 @@ static int fsl_pamu_probe(struct platform_device *pdev)
 	return 0;
 
 error:
-	if (irq != NO_IRQ)
+	if (irq)
 		free_irq(irq, data);
 
 	kfree_sensitive(data);
-- 
2.37.1

