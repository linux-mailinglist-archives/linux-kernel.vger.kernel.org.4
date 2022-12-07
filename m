Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67541645BF4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiLGODZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiLGOCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:02:25 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251AD5E9CA;
        Wed,  7 Dec 2022 06:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670421671; x=1701957671;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w+QJEwn0ZcbEKI9H0GIF6G+r453iLRw7ezRK3Dm8zOo=;
  b=a+QbruRwTcQojCeC114a9SUmrfjKA55LGgS+3/vu1oovQA1Zrj9u6Rxp
   I29Q+PK44tA5YNnw5/r3aYrE3A8+Bw88TkiOlOaI6kj4Y2DxeyRzP/ZE5
   DUpdQ2kwH5w+tdOdwyd+ASD1NTtWN4gGG3I02uiNbPwXbBT80uCGPQm7C
   HEKDZhJSbAiS4ZJ5lgqdWA8UjOXzYm9YPMrXZFZ1aonmQaPsMOGet8YEr
   RWtYK9QPJt9RIf51efqOTO41n+yUgnDBG93rmV/sbEeLpUy2/aHcth26h
   Hxn8khPGLxjv+t4ZHymHpmExe/dUnxCdMTwgmA7npvYKvFM7OQugIDvPm
   A==;
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="186983168"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Dec 2022 07:00:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Dec 2022 07:00:55 -0700
Received: from ROB-ULT-M68701.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 7 Dec 2022 07:00:53 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>
CC:     <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH] crypto: atmel: Add capability case for the 0x600 SHA and AES IP versions
Date:   Wed, 7 Dec 2022 15:59:55 +0200
Message-ID: <20221207135953.136557-1-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for the driver to be made aware of the capabilities of the SHA
and AES IP versions 0x600 , such as those present on the SAM9X60 SoC's,
add a corresponding switch case to the capability method of the respective
drivers. Without this, besides the capabilities not being correctly set,
the self tests may hang since the driver is endlessly waiting for a
completion to be set by a never occurring DMA interrupt handler.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---
 drivers/crypto/atmel-aes.c | 1 +
 drivers/crypto/atmel-sha.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index 886bf258544c..063394cfa874 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -2510,6 +2510,7 @@ static void atmel_aes_get_cap(struct atmel_aes_dev *dd)
 	/* keep only major version number */
 	switch (dd->hw_version & 0xff0) {
 	case 0x700:
+	case 0x600:
 	case 0x500:
 		dd->caps.has_dualbuff = 1;
 		dd->caps.has_cfb64 = 1;
diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
index ca4b01926d1b..00be792e605c 100644
--- a/drivers/crypto/atmel-sha.c
+++ b/drivers/crypto/atmel-sha.c
@@ -2509,6 +2509,7 @@ static void atmel_sha_get_cap(struct atmel_sha_dev *dd)
 	/* keep only major version number */
 	switch (dd->hw_version & 0xff0) {
 	case 0x700:
+	case 0x600:
 	case 0x510:
 		dd->caps.has_dma = 1;
 		dd->caps.has_dualbuff = 1;
-- 
2.34.1

