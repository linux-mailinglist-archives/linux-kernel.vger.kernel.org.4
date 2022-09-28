Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F905EE600
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 21:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbiI1Tqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 15:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiI1Tqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 15:46:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240AC77554
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664394409; x=1695930409;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jPtryGRyA9oNt04OYCpGKFm8Yrom3sbeE+tJ5rcufrE=;
  b=BVyC20H4m8y1LICaYKdXiz41EPmhHVb36dispMmTy6zBErHstaGrAbu+
   gov8YH1liOUC6RSqmSKKVZIwMB7xgDFYddkynGReFc86TDbBPVn3RFf06
   iABTQM4sLykCXpIn8A18Z3cMlo1+3ZQFYPgnfI0QcaONd60FuebLj5X/Z
   Jav2v8lPmC6dPXV3izZ4pW7B/2qnOCZzYrskj4ewz/sSRFI33V/94HnYI
   j5HvCI4ViUF13Mit6m+rkS4LKNk8A8U8F7sg/FBc1sNq7/jskhtqmizbS
   nT99dZq3UHZXvmArJuEBQ08pOmi7j8Njjk4FggAyJXqgbwOvddJ/V6AKz
   A==;
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="176079189"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Sep 2022 12:46:48 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 28 Sep 2022 12:46:45 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 28 Sep 2022 12:46:44 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <srinivas.kandagatla@linaro.org>, <gregkh@linuxfoundation.org>,
        "Horatiu Vultur" <horatiu.vultur@microchip.com>
Subject: [PATCH] nvmem: lan9662-otp: Fix compatible string
Date:   Wed, 28 Sep 2022 21:51:12 +0200
Message-ID: <20220928195112.630351-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device tree bindings for lan9662-otp expects the compatible string
to be one of following compatible strings:
microchip,lan9662-otpc
microchip,lan9668-otpc

The problem is that the lan9662-otp driver contains the
microchip,lan9662-otp compatible string instead of
microchip,lan9662-otpc.
Fix this by updating the compatible string in the driver.

Fixes: 9e8f208ad5229d ("nvmem: lan9662-otp: add support")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/nvmem/lan9662-otpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/lan9662-otpc.c b/drivers/nvmem/lan9662-otpc.c
index f4348c97f6e59..56fc19f092a7f 100644
--- a/drivers/nvmem/lan9662-otpc.c
+++ b/drivers/nvmem/lan9662-otpc.c
@@ -203,7 +203,7 @@ static int lan9662_otp_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id lan9662_otp_match[] = {
-	{ .compatible = "microchip,lan9662-otp", },
+	{ .compatible = "microchip,lan9662-otpc", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, lan9662_otp_match);
-- 
2.33.0

