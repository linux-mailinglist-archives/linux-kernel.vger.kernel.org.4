Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219F56D6A35
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbjDDRQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjDDRQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:16:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAE8D3;
        Tue,  4 Apr 2023 10:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680628613; x=1712164613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r3aKOSdvH+07JEB/Anw6Ara6+1P1wt7dI3yReMFX3Bg=;
  b=TaMnRRARwZtp4GrvTbsBhb36wadtjwWnH+u68RNZvU/BRqTW9xQtLA4D
   arOuWtArvkddOaQR2UbnqljGrZ69wsHeX3mizLFLH6SBsC+Q2oWwMaOMt
   eDkggoQwE3xMUCimbo87ipgLqOyl4kCos0U2DDC2n8K9fg8gkpvc4+2Kq
   v+sQl3fdizajU5voMUtRr9Fmo2SdsTsbWACU11/IOCI1glelvJWwQK0ve
   U8CPaeHD3rvVlmZGTUNbRf2TbgSd1/AoOHAvr/uIkVWICWhSAJEfKp9Rl
   NxsjAc7z2rIR7Q3mJqh3427nmhAAJjH/mwZexI2Tn59IbzQijxhOGzV5+
   w==;
X-IronPort-AV: E=Sophos;i="5.98,318,1673938800"; 
   d="scan'208";a="204973525"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Apr 2023 10:16:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 10:16:52 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 10:16:51 -0700
From:   Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
To:     <linux-spi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <broonie@kernel.org>
Subject: [PATCH SPI for-next 2/3] spi: mchp-pci1xxxx: Fix SPI transactions not working after suspend and resume
Date:   Tue, 4 Apr 2023 22:46:12 +0530
Message-ID: <20230404171613.1336093-3-tharunkumar.pasumarthi@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404171613.1336093-1-tharunkumar.pasumarthi@microchip.com>
References: <20230404171613.1336093-1-tharunkumar.pasumarthi@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci1xxxx_spi_resume API masks SPI interrupt bit which prohibits interrupt
from coming to the host at the end of the transaction after suspend-resume.
This patch unmasks this bit at resume.

Fixes: 1cc0cbea7167 ("spi: microchip: pci1xxxx: Add driver for SPI controller of PCI1XXXX PCIe switch")
Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
---
 drivers/spi/spi-pci1xxxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index 419a1d3a5c2e..82d4bfeea1fa 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -58,7 +58,7 @@
 #define VENDOR_ID_MCHP 0x1055
 
 #define SPI_SUSPEND_CONFIG 0x101
-#define SPI_RESUME_CONFIG 0x303
+#define SPI_RESUME_CONFIG 0x203
 
 struct pci1xxxx_spi_internal {
 	u8 hw_inst;
-- 
2.25.1

