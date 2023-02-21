Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E073C69D891
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 03:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjBUCht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 21:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbjBUChs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 21:37:48 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BB823664;
        Mon, 20 Feb 2023 18:37:04 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vc9zAOj_1676946995;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Vc9zAOj_1676946995)
          by smtp.aliyun-inc.com;
          Tue, 21 Feb 2023 10:36:35 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     damien.lemoal@opensource.wdc.com
Cc:     s.shtylyov@omp.ru, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] ata: pata_macio: Use of_property_present() helper
Date:   Tue, 21 Feb 2023 10:36:34 +0800
Message-Id: <20230221023634.87925-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_property_present() instead of of_get_property/of_find_property()
in places where we just need to test presence of a property.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/ata/pata_macio.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 9ccaac9e2bc3..f698d77e87e1 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -479,10 +479,9 @@ static int pata_macio_cable_detect(struct ata_port *ap)
 	    priv->kind == controller_un_ata6 ||
 	    priv->kind == controller_k2_ata6 ||
 	    priv->kind == controller_sh_ata6) {
-		const char* cable = of_get_property(priv->node, "cable-type",
-						    NULL);
+		const char *cable = of_property_present(priv->node, "cable-type");
 		struct device_node *root = of_find_node_by_path("/");
-		const char *model = of_get_property(root, "model", NULL);
+		const char *model = of_property_present(root, "model");
 
 		of_node_put(root);
 
@@ -973,7 +972,7 @@ static void pata_macio_invariants(struct pata_macio_priv *priv)
 	/* XXX FIXME --- setup priv->mediabay here */
 
 	/* Get Apple bus ID (for clock and ASIC control) */
-	bidp = of_get_property(priv->node, "AAPL,bus-id", NULL);
+	bidp = of_property_present(priv->node, "AAPL,bus-id");
 	priv->aapl_bus_id =  bidp ? *bidp : 0;
 
 	/* Fixup missing Apple bus ID in case of media-bay */
-- 
2.20.1.7.g153144c

