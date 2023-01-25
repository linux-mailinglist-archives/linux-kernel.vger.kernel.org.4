Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E1667AB68
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 09:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjAYILZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 03:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbjAYILW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 03:11:22 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1384DE15;
        Wed, 25 Jan 2023 00:11:17 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30P8BA9l011886;
        Wed, 25 Jan 2023 02:11:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674634270;
        bh=Hn4D1RStKcp308sq3cbg4/Y6SSqzZ28U4qiM8PCYDgk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=AoHM/UWRS/effmMZCsJiCPgtXBNrhgKYttnXZS4eNB6SIvMs/uMdcR1v62isnjPdc
         Hd+YwrNpLDwZHGQhCYsfemD0HHuq7n+A+/IRlcjAsxjbSlTlv00iMJ4pvddukd+q0j
         VxOX8hxIkUORtMxQTL21rD8Cuse1CTOiGPi6ma+w=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30P8BAFU121583
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jan 2023 02:11:10 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 25
 Jan 2023 02:11:09 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 25 Jan 2023 02:11:09 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30P8B8gG009447;
        Wed, 25 Jan 2023 02:11:09 -0600
From:   Dhruva Gole <d-gole@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Dhruva Gole <d-gole@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Takahiro.Kuwano@infineon.com>, Pratyush Yadav <ptyadav@amazon.de>
Subject: [PATCH v2 4/4] spi: cadence-quadspi: use STIG mode for small reads
Date:   Wed, 25 Jan 2023 13:40:23 +0530
Message-ID: <20230125081023.1573712-5-d-gole@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230125081023.1573712-1-d-gole@ti.com>
References: <20230125081023.1573712-1-d-gole@ti.com>
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

Fix the issue where some flash chips like cypress S25HS256T return the
value of the same register over and over in DAC mode.

For example in the TI K3-AM62x Processors refer [0] Technical Reference
Manual there is a layer of digital logic in front of the QSPI/OSPI
Drive when used in DAC mode. This is part of the Flash Subsystem (FSS)
which provides access to external Flash devices.

The FSS0_0_SYSCONFIG Register (Offset = 4h) has a BIT Field for
OSPI_32B_DISABLE_MODE which has a Reset value = 0. This means, OSPI 32bit
mode enabled by default.

Thus, by default controller operates in 32 bit mode causing it to always
align all data to 4 bytes from a 4byte aligned address. In some flash
chips like cypress for example if we try to read some regs in DAC mode
then it keeps sending the value of the first register that was requested
and inorder to read the next reg, we have to stop and re-initiate a new
transaction.

This causes wrong register values to be read than what is desired when
registers are read in DAC mode. Hence if the data.nbytes is very less
then prefer STIG mode for such small reads.

[0] https://www.ti.com/lit/ug/spruiv7a/spruiv7a.pdf

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index a6d0f1b0bb49..2954c06a7f57 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1359,7 +1359,13 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
 	cqspi_configure(f_pdata, mem->spi->max_speed_hz);

 	if (op->data.dir == SPI_MEM_DATA_IN && op->data.buf.in) {
-		if (!op->addr.nbytes)
+	/*
+	 * Performing reads in DAC mode forces to read minimum 4 bytes
+	 * which is unsupported on some flash devices during register
+	 * reads, prefer STIG mode for such small reads.
+	 */
+		if (!op->addr.nbytes ||
+		    op->data.nbytes <= CQSPI_STIG_DATA_LEN_MAX)
 			return cqspi_command_read(f_pdata, op);

 		return cqspi_read(f_pdata, op);
--
2.25.1

