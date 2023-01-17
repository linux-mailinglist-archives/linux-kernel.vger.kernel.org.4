Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3050466D58E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 06:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbjAQFVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 00:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbjAQFVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 00:21:09 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01D45263
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 21:21:00 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30H5KrXL073175;
        Mon, 16 Jan 2023 23:20:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673932853;
        bh=4KrU4rKvHGWN4haTjPdOGhuOQFXUGMP+s8OimkmkKiY=;
        h=From:To:CC:Subject:Date;
        b=CWhPZTKxeUiTrjXcNRVI6G2Kp52K8v7V3M59aoOEDBvty9cz7Rwusvd/Am2ynBIF0
         vpaWv7wBuyx033sN/2J5ucvtgvO2rlEzvzhtLtAeErjRaKEkOcS9dqBNO15ek1hqVj
         pPSE6Q07qyX+2gnL5LTMKxlzV2Ln9NoJ8bQ/P0lo=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30H5KrbW113434
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jan 2023 23:20:53 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 16
 Jan 2023 23:20:53 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 16 Jan 2023 23:20:53 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30H5Kq5v014241;
        Mon, 16 Jan 2023 23:20:52 -0600
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <j-choudhary@ti.com>
Subject: [PATCH v2] soc: ti: k3-ringacc: remove non-fatal probe deferral log
Date:   Tue, 17 Jan 2023 10:50:52 +0530
Message-ID: <20230117052052.29953-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Changelog v1->v2:
- Removed the print instead of dropping the loglevel according to the comment
  on similar patch for udma:
  <https://lore.kernel.org/all/Y6wiXlZh1MUL2WrF@matsya/>
  
v1 patch: <https://lore.kernel.org/all/20221128102138.529398-1-j-choudhary@ti.com/>

 drivers/soc/ti/k3-ringacc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index e01e4d815230..776407f80dd4 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -1367,7 +1367,6 @@ static int k3_ringacc_init(struct platform_device *pdev,
 	dev->msi.domain = of_msi_get_domain(dev, dev->of_node,
 					    DOMAIN_BUS_TI_SCI_INTA_MSI);
 	if (!dev->msi.domain) {
-		dev_err(dev, "Failed to get MSI domain\n");
 		return -EPROBE_DEFER;
 	}
 
-- 
2.25.1

