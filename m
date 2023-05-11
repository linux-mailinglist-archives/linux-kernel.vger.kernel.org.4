Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000096FECF2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbjEKHeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbjEKHeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:34:02 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8896A5A;
        Thu, 11 May 2023 00:33:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YG4gBRCwahp2ovMCGmYbqqxD1bVjoOLHA9lTjG/A1oxIbFqrZDI84LWs121fVkLYV8wrdw6I5t9WvR1R+7jcFr3tHxvm0AGDCOlgH+jUWIPYJuLauiQ+fdJHS32ldYT0jG475uAC7ft8M85+jX0R8cJIv3g0XRmRe49CA0OOfBfBf20D/Q0HGHcKhCp1OOWWgxVVADXbfNABMEsqk0StCjS6Nqtcj6LMPy5Z7/wRDM0B1ZCssSVv0nIzqwM+bENIhWkXD6sG5OAHMa38spTQ6+KKH0aOkonwoz9uBAHTkNTZ8kGnrxU7FuAmX6YMmsB64n16ruaDKT0Nev5Rs4Sp8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=he65cIQQwqLcPUh0K7+4CXQr0jLidhcBa3blMtvOwsw=;
 b=S+9PYvX9nLZPQ+Z/guIVpp40rOprqd+jQcVcbqRTOFEu5xTFW9zBSUoMnKmNUIIjCskh0Dp6NM+rCcWDEA6D+7uOEzihAjTDPCksjocTjg/7oy5TNrXPAkORRUt5cCv+ErBDvZDm9yD1l34Tp580LH6gs/LSU3aA5izdJS2YjRThIyB/YkwiA6CTqJN6901Pwa6rFYVi4RFtuiF03hTFcbN3/saCE2gGJZdbBTSQuPVoxUJNzhEHeNYpWaKvTbuh8azG/63btZsvJzcnFXcyt7NJdIJC+z4NJkVSecyDgbnFhFvAIF5j1P5/SJNZ2+TBtqycICNrLoOz5nHHm2/TPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=he65cIQQwqLcPUh0K7+4CXQr0jLidhcBa3blMtvOwsw=;
 b=j7RrGtmVn+CwvDpExd74nZkuXT15lZcHaEeq2A6zS2jVfCr9BZjx1utzfPbRrTTOFkXfRC1DCQkarbK+x5R5/8EOl690Oh0J0zXNQNAZYZLKCWWcWfA0ur/h8BDzKRH8UTuSuw+WFGL9Yw5rz2mZ7KB5RLrKefTDbD0QGiqRXYA=
Received: from MWH0EPF00056D11.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:14) by BL1PR12MB5160.namprd12.prod.outlook.com
 (2603:10b6:208:311::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Thu, 11 May
 2023 07:33:23 +0000
Received: from CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::204) by MWH0EPF00056D11.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.5 via Frontend
 Transport; Thu, 11 May 2023 07:33:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT115.mail.protection.outlook.com (10.13.174.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.22 via Frontend Transport; Thu, 11 May 2023 07:33:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 11 May
 2023 02:33:20 -0500
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Thu, 11 May 2023 02:33:16 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
        <pratyush@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <michael@walle.cc>
CC:     <sbinding@opensource.cirrus.com>, <git@amd.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
        <amitrkcian2002@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH V8 7/7] spi: spi-zynqmp-gqspi: Add parallel memories support in GQSPI driver
Date:   Thu, 11 May 2023 13:01:34 +0530
Message-ID: <20230511073134.41180-8-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230511073134.41180-1-amit.kumar-mahapatra@amd.com>
References: <20230511073134.41180-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT115:EE_|BL1PR12MB5160:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a40346-e233-49da-e6b2-08db51f1ff72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /d4LnYtR7TJG+UlbcJ8tUE4yGYLjOPi8iHBeo9OhbKCP8s9AZ7SPkM5cjYeUjj99afh/GwJhx8NWm6l0+thRSJfRb40fITGcDYiI/LfrHfRZAbOBMUipi9ZQfqapRzsRL+XP2/D9Aqw6ve5UgQJPsBiGs+Y8loseW7jF4aZW0iH6gLJxML1ZLIzhX4ePp7b7B8bYcJNSLiWMkMea4vTKmdOw7IDQWnEB28Mp8fsuKa5cMPZHAO5YiQ0Cz+9zEMDfA3d4XZ5roOoWcqF60BgR6x96Ziiq2VolWBSTtzZ17udLF8r5j//NGe26bquC6mLnwe5fzQFEJo2Mt7wmmaqWJtkGnNO9qZfosDxRuQwWwLviDcbE1h1FtZR2SP8N6LzZTvA5DrDWEGH7KuSAS+k2bi0tglxokgWzSXf72ziI3c9d5HNjNxgLyVSf8vLRxhr3TcxGsy784+mCToJXc46qqxggRZQ8wc9tIinpmlmWuT+q+c/OwWgHn0EEPZN14fNNGNYxptS0aTuleaCdcOM886LlO6xD8iyQ2m83u2pRcQTZbO3UB0nKVfETtFy52b7QLfG5R2H0n+ZDwM8JbPYPkGIKTedDMrXXmBmEKoDdUbLpeFRCD+VsiojjsE2vTj7JzV1s8feoicU2krlre1QCuEGYcBe/xrXZXuodsT6EWzVXQASN3iDoiMwqOky7OGxDuwmEXcj7/61G/dJ2o0RVwPpEBW3vWbuiic4Ba4aw3DMEW6+qrBMPbwxySFFHI/9ib5aUACEc9HZameOxvZPGeg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(70206006)(82310400005)(70586007)(41300700001)(336012)(4326008)(316002)(426003)(82740400003)(110136005)(36756003)(40460700003)(356005)(83380400001)(54906003)(2906002)(81166007)(8936002)(8676002)(86362001)(7416002)(5660300002)(26005)(1076003)(186003)(36860700001)(47076005)(2616005)(478600001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 07:33:21.6026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a40346-e233-49da-e6b2-08db51f1ff72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During probe GQSPI driver sets SPI_CONTROLLER_MULTI_CS bit in ctlr->flags
for notifying SPI core about multi CS capability of the controller.
In parallel mode the controller can either split the data between both the
flash or can send the same data to both the flashes, this is determined by
the STRIPE bit. While sending commands to the flashes the GQSPI driver
send the same command to both the flashes by resetting the STRIPE bit, but
while writing/reading data to & from the flash the GQSPI driver splits the
data evenly between both the flashes by setting the STRIPE bit.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 39 +++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 3d2b92a88e8a..2b2b5c0385fc 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -23,6 +23,7 @@
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 #include <linux/spi/spi-mem.h>
+#include <linux/mtd/spi-nor.h>
 
 /* Generic QSPI register offsets */
 #define GQSPI_CONFIG_OFST		0x00000100
@@ -192,6 +193,7 @@ struct qspi_platform_data {
  * @op_lock:		Operational lock
  * @speed_hz:          Current SPI bus clock speed in hz
  * @has_tapdelay:	Used for tapdelay register available in qspi
+ * @is_parallel:		Used for multi CS support
  */
 struct zynqmp_qspi {
 	struct spi_controller *ctlr;
@@ -214,8 +216,33 @@ struct zynqmp_qspi {
 	struct mutex op_lock;
 	u32 speed_hz;
 	bool has_tapdelay;
+	bool is_parallel;
 };
 
+/**
+ * zynqmp_gqspi_update_stripe - For GQSPI controller data stripe capabilities
+ * @op:	Pointer to mem ops
+ * Return:      Status of the data stripe
+ *
+ * Returns true if data stripe need to be enabled, else returns false
+ */
+bool zynqmp_gqspi_update_stripe(const struct spi_mem_op *op)
+{
+	if (op->cmd.opcode ==  SPINOR_OP_BE_4K ||
+	    op->cmd.opcode ==  SPINOR_OP_BE_32K ||
+	    op->cmd.opcode ==  SPINOR_OP_CHIP_ERASE ||
+	    op->cmd.opcode ==  SPINOR_OP_SE ||
+	    op->cmd.opcode ==  SPINOR_OP_BE_32K_4B ||
+	    op->cmd.opcode ==  SPINOR_OP_SE_4B ||
+	    op->cmd.opcode == SPINOR_OP_BE_4K_4B ||
+	    op->cmd.opcode ==  SPINOR_OP_WRSR ||
+	    op->cmd.opcode ==  SPINOR_OP_BRWR ||
+	    (op->cmd.opcode ==  SPINOR_OP_WRSR2 && !op->addr.nbytes))
+		return false;
+
+	return true;
+}
+
 /**
  * zynqmp_gqspi_read - For GQSPI controller read operation
  * @xqspi:	Pointer to the zynqmp_qspi structure
@@ -470,7 +497,14 @@ static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
 
 	genfifoentry |= GQSPI_GENFIFO_MODE_SPI;
 
-	if (qspi->cs_index_mask & GQSPI_SELECT_UPPER_CS) {
+	if ((qspi->cs_index_mask & GQSPI_SELECT_LOWER_CS) &&
+	    (qspi->cs_index_mask & GQSPI_SELECT_UPPER_CS)) {
+		zynqmp_gqspi_selectslave(xqspi,
+					 GQSPI_SELECT_FLASH_CS_BOTH,
+					 GQSPI_SELECT_FLASH_BUS_BOTH);
+		if (!xqspi->is_parallel)
+			xqspi->is_parallel = true;
+	} else if (qspi->cs_index_mask & GQSPI_SELECT_UPPER_CS) {
 		zynqmp_gqspi_selectslave(xqspi,
 					 GQSPI_SELECT_FLASH_CS_UPPER,
 					 GQSPI_SELECT_FLASH_BUS_LOWER);
@@ -1139,6 +1173,8 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 	}
 
 	if (op->data.nbytes) {
+		if (xqspi->is_parallel && zynqmp_gqspi_update_stripe(op))
+			genfifoentry |= GQSPI_GENFIFO_STRIPE;
 		reinit_completion(&xqspi->data_completion);
 		if (op->data.dir == SPI_MEM_DATA_OUT) {
 			xqspi->txbuf = (u8 *)op->data.buf.out;
@@ -1334,6 +1370,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctlr->dev.of_node = np;
 	ctlr->auto_runtime_pm = true;
+	ctlr->flags |= SPI_CONTROLLER_MULTI_CS;
 
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret) {
-- 
2.17.1

