Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D469674D3CE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjGJKmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjGJKmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:42:23 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8A1E7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 03:42:22 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36AAgH1A074162;
        Mon, 10 Jul 2023 05:42:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1688985737;
        bh=d91elAz/LgdjxOEkUcZVz3W+TrzC3BXnW61PqEkP0qo=;
        h=From:To:CC:Subject:Date;
        b=eGVAUDuAMP5WBRAAcnzIjikwYiXvMrc7xokWx7JXMq7OSUQmvJbsRLJAevgY626yd
         DqnsCvOEnfLhxPDpQ3+mlWKhEJhbXQJkA249RcU3TF6KGrCggRxn0stqguPOlr094k
         8Q/CabhiSdzujIYV71jotRgwGpqt9x0lalDSN20Q=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36AAgHM5021603
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Jul 2023 05:42:17 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jul 2023 05:42:16 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jul 2023 05:42:16 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36AAgGJw059742;
        Mon, 10 Jul 2023 05:42:16 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <j-choudhary@ti.com>
Subject: [RESEND PATCH v2] soc: ti: k3-ringacc: remove non-fatal probe deferral log
Date:   Mon, 10 Jul 2023 16:12:15 +0530
Message-ID: <20230710104215.156114-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the non-fatal probe deferral log for getting MSI domain.
This makes the kernel log clean and we do not get recurring logs
stating: "Failed to get MSI domain".

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---

v2 patch: <https://lore.kernel.org/all/20230117052052.29953-1-j-choudhary@ti.com/>

Changelog v1->v2:
- Removed the print instead of dropping the loglevel according to the comment
  on similar patch for udma:
  <https://lore.kernel.org/all/Y6wiXlZh1MUL2WrF@matsya/>
  
v1 patch: <https://lore.kernel.org/all/20221128102138.529398-1-j-choudhary@ti.com/>

 drivers/soc/ti/k3-ringacc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 8f131368a758..5eb81895f8bc 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -1374,7 +1374,6 @@ static int k3_ringacc_init(struct platform_device *pdev,
 	dev->msi.domain = of_msi_get_domain(dev, dev->of_node,
 					    DOMAIN_BUS_TI_SCI_INTA_MSI);
 	if (!dev->msi.domain) {
-		dev_err(dev, "Failed to get MSI domain\n");
 		return -EPROBE_DEFER;
 	}
 
-- 
2.25.1

