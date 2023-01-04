Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EBC65CD14
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 07:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjADG2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 01:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbjADG1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 01:27:41 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0211B1F8;
        Tue,  3 Jan 2023 22:26:48 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3046QRPu120495;
        Wed, 4 Jan 2023 00:26:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672813587;
        bh=NliV50lmKoUKDsRuaYCtjajFhmQGOUAjwjZaOIj01AY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KtEB5PTlqItNnIv3+LQTbhE/nFUMn45P43x100P19gUOYY/tQVqSaIlrcb4p6dRjW
         VuYKfMrLu+y7ntvhbW2D3ZAk4K261aHJnv1+01gJExU8BHwAw4s0BUFhE//RRmDH6M
         m+DfEjLV0r95NNX7hfN0YLex7sqzj4GxTSl6w4cI=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3046QRPN004457
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jan 2023 00:26:27 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 4
 Jan 2023 00:26:27 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 4 Jan 2023 00:26:27 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3046QPv3095883;
        Wed, 4 Jan 2023 00:26:26 -0600
From:   Dhruva Gole <d-gole@ti.com>
To:     <broonie@kernel.org>
CC:     Dhruva Gole <d-gole@ti.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh <vigneshr@ti.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Vaishnav Achath <vaishnav.a@ti.com>
Subject: [PATCH 2/2] spi: cadence-quadspi: use STIG mode for small reads
Date:   Wed, 4 Jan 2023 11:56:04 +0530
Message-ID: <20230104062604.1556763-3-d-gole@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230104062604.1556763-1-d-gole@ti.com>
References: <20230104062604.1556763-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 8c7938776cfc..f5188dc52db6 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1344,7 +1344,13 @@ static int cqspi_mem_process(struct spi_mem *mem, const struct spi_mem_op *op)
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

