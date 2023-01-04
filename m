Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5056E65CD12
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 07:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjADG2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 01:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjADG1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 01:27:35 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD4218E2B;
        Tue,  3 Jan 2023 22:26:46 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3046QOIH054824;
        Wed, 4 Jan 2023 00:26:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672813584;
        bh=JH3+7om56Hn+Os1YAI02Uac/iNLa0MUdUR9qw1LiMaE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Stq26XXZB7DzzkC24qob+ewfNrA/y9zB5IfuzGmBxtxohNFg19VX0qXXgHZGvTbPZ
         HB6Yg7KJQkiMThxQvn+QynvtxcQhEFHLxTaLTYy9hKYwBNAWWK659EzFUpBID2AA26
         sdqKVgU671FKd04mp2iwadtHOD7lqdVqJXyY9OXk=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3046QOs0104566
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Jan 2023 00:26:24 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 4
 Jan 2023 00:26:24 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 4 Jan 2023 00:26:24 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3046QNO0095871;
        Wed, 4 Jan 2023 00:26:23 -0600
From:   Dhruva Gole <d-gole@ti.com>
To:     <broonie@kernel.org>
CC:     Dhruva Gole <d-gole@ti.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh <vigneshr@ti.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Vaishnav Achath <vaishnav.a@ti.com>
Subject: [PATCH 1/2] spi: cadence-quadspi: setup ADDR Bits in cmd reads
Date:   Wed, 4 Jan 2023 11:56:03 +0530
Message-ID: <20230104062604.1556763-2-d-gole@ti.com>
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

Setup the Addr bit field while issuing register reads in STIG mode. This
is needed for example flashes like cypress define in their transaction
table that to read any register there is 1 cmd byte and a few more address
bytes trailing the cmd byte. Absence of addr bytes will obviously fail
to read correct data from flash register that maybe requested by flash
driver because the controller doesn't even specify which address of the
flash register the read is being requested from.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 676313e1bdad..8c7938776cfc 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -531,6 +531,17 @@ static int cqspi_command_read(struct cqspi_flash_pdata *f_pdata,
 	/* 0 means 1 byte. */
 	reg |= (((n_rx - 1) & CQSPI_REG_CMDCTRL_RD_BYTES_MASK)
 		<< CQSPI_REG_CMDCTRL_RD_BYTES_LSB);
+
+	/* setup ADDR BIT field */
+	if (op->addr.nbytes) {
+		reg |= (0x1 << CQSPI_REG_CMDCTRL_ADDR_EN_LSB);
+		reg |= ((op->addr.nbytes - 1) &
+			CQSPI_REG_CMDCTRL_ADD_BYTES_MASK)
+			<< CQSPI_REG_CMDCTRL_ADD_BYTES_LSB;
+
+		writel(op->addr.val, reg_base + CQSPI_REG_CMDADDRESS);
+	}
+
 	status = cqspi_exec_flash_cmd(cqspi, reg);
 	if (status)
 		return status;
-- 
2.25.1

