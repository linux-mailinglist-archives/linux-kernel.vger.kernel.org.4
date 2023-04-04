Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC8A6D6A3B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbjDDRRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbjDDRRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:17:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6465B2683;
        Tue,  4 Apr 2023 10:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680628620; x=1712164620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i+Jlcq7+ozFYtO3gopneWBMGEdmaY2LDJGZxZu3AEuw=;
  b=sNto0DczWSZo2MZF1875OA4cp8SG4t+w8IYGeyiC/oNTB14UTtotNvab
   aYpI87/A9uIYafSmaBVYvJqPiRrvFAbccEJy/yozzOf9pxoAhb4JPJyPw
   ZxPPsYCoAkfshjS3/qMijpG9AaZU1wZeaSUrRub/+ak1n2Va0yoQDIfdi
   SWXgNDFIrHmNVP2OLrpq4Q1nIDA0dftpDnnnolsNbHP7xmBQBVqwOZr8z
   chPfS/vcddPkBj+UYv4MdxMdKudjvfN8RO7uupnnSn0isi1m+nh9Rveif
   6kvH5ftWnoLfz9wK0EgebJKxwKjxre0N4O7eFlY/SqPYXwgMd7RhQ5yuo
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,318,1673938800"; 
   d="scan'208";a="219405872"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Apr 2023 10:16:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 10:16:49 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 10:16:47 -0700
From:   Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
To:     <linux-spi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <broonie@kernel.org>
Subject: [PATCH SPI for-next 1/3] spi: mchp-pci1xxxx: Fix length of SPI transactions not set properly in driver
Date:   Tue, 4 Apr 2023 22:46:11 +0530
Message-ID: <20230404171613.1336093-2-tharunkumar.pasumarthi@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404171613.1336093-1-tharunkumar.pasumarthi@microchip.com>
References: <20230404171613.1336093-1-tharunkumar.pasumarthi@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In pci1xxxx_spi_transfer_one API, length of SPI transaction gets cleared
by setting of length mask. Set length of transaction only after masking
length field.

Fixes: 1cc0cbea7167 ("spi: microchip: pci1xxxx: Add driver for SPI controller of PCI1XXXX PCIe switch")
Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
---
 drivers/spi/spi-pci1xxxx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index 1c5731641a04..419a1d3a5c2e 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -199,8 +199,9 @@ static int pci1xxxx_spi_transfer_one(struct spi_controller *spi_ctlr,
 			else
 				regval &= ~SPI_MST_CTL_MODE_SEL;
 
-			regval |= ((clkdiv << 5) | SPI_FORCE_CE | (len << 8));
+			regval |= ((clkdiv << 5) | SPI_FORCE_CE);
 			regval &= ~SPI_MST_CTL_CMD_LEN_MASK;
+			regval |= (len << 8);
 			writel(regval, par->reg_base +
 			       SPI_MST_CTL_REG_OFFSET(p->hw_inst));
 			regval = readl(par->reg_base +
-- 
2.25.1

