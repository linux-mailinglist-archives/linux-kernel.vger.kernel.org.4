Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295B96FECF0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237574AbjEKHeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbjEKHd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:33:56 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3998699;
        Thu, 11 May 2023 00:33:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQUXKX/WqGVm/IiCsQR9uWAFrF88W0OwZU+P9qKLRfwRVe1iBLZUw0i/rWDfUu8VvFpeoitNTO686vnJm6IztEtnorfO4nkxJXK+Ap9bJaifRWJSer9nb3QGnbOry0uPvfpp4lL0usMP+p/jH+oZWOU7SWEo7AbP0wxTKEsW0HNSVyknQtaVtVg8VkW8w1s0ErIxX3oRbDoVl1CZdASHRTn3feCrTShnmXXyAQRwf1ruKPms2N+c4GD7nBaTl0Xa30RZWhNgpV62K4yOSrjCU8BNaevbL+QWYUJ35VEM/m3yB2ehF4+dTWKzGQo/BdMvWbtmbWWTyqEWBqW5NTQ+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5KdSSDQ2nsI2TY2AaFPPmoyVvEQ1ALcxSgb22XsW3Y=;
 b=GpZ4F+Dyz4GF02U+73d5Gw+A20I04WpFqTAHWStPRJzG5IG5Vl4hIq2AjP7JkSSIRWSPNUlUpKpdCipP4lY+TyCjm6ui5GsW/x7pSoMjFaaii7wJzQxEHp0wGo4vUwGEUCOqk3gKXBRnREwF0D1bbICQsZpVbq9qPe++YmsJoAfEe2pENiGk07DzV5qJJ8uOJWkzgIYkO3Dx4Xz9GAXf0t2/HGfazqSEhOu1RT/hWKiyBCgi9WyC17Oe7FW3vb74TFwv1q1XCKs/IqXqXsDoEFdEiwpwZrqa0Ot50fuSF40kPM2hjSkvyycmOFX/dDYKwk5yhPX3uETTc023rg7eZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5KdSSDQ2nsI2TY2AaFPPmoyVvEQ1ALcxSgb22XsW3Y=;
 b=l0FdDW5XzjncuZOfFQ9uXUfmnnPtrAJu7EtXueIjIJox4i/JNGjWqDier/fwtYEXzXcixrINWf8E+4vYghCQmof4vQF60ca602U2bxHaCCQ7wE3eRc5Cd4O1PY0Lqk1s5MOnvp4VLfIGIxdYXALpvaBMQGdN1QPp25N6mNn42vQ=
Received: from BL1PR13CA0135.namprd13.prod.outlook.com (2603:10b6:208:2bb::20)
 by SN7PR12MB7978.namprd12.prod.outlook.com (2603:10b6:806:34b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Thu, 11 May
 2023 07:33:13 +0000
Received: from BL02EPF000145B8.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::bd) by BL1PR13CA0135.outlook.office365.com
 (2603:10b6:208:2bb::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.7 via Frontend
 Transport; Thu, 11 May 2023 07:33:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF000145B8.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Thu, 11 May 2023 07:33:13 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 11 May
 2023 02:33:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 11 May
 2023 00:32:28 -0700
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Thu, 11 May 2023 02:32:23 -0500
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
Subject: [PATCH V8 5/7] spi: spi-zynqmp-gqspi: Add stacked memories support in GQSPI driver
Date:   Thu, 11 May 2023 13:01:32 +0530
Message-ID: <20230511073134.41180-6-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230511073134.41180-1-amit.kumar-mahapatra@amd.com>
References: <20230511073134.41180-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145B8:EE_|SN7PR12MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ec74146-3478-4d24-cf0c-08db51f1fa3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1l6E8Z0QHmmKNIqn2/PT9ZmYtZceJvnhBgv4CDAk8isTnp9v/+w++V6njM/j0HrGDiJvO+T0xIhXu/WdOB5O3KdUdpU/08y5x8VYrabQrgXPTRmjEcYE4GsknmSsTJ0WyDgNLUa34oUvkhyYkCkM5R2HKk7POb/vh9Xl+S3yY3HwVNxzmCzUVYoEdpfYW7RG55YuIFvaUsu/odY6qCQO+cURgesTU08KEwi6CuCFN9YcbJVfeDprsDWjhCyrEpVXiB5QLDiJK7FMEyjUMfAmGQYAQ2hBQQD1pop0FlJuWhfYHTXESxbQQQCLEQIJEm44yiRz1AkCyGTVE3MUiPuFlydDFplfyVoc6hMXfQ5K8UtzvglF9EPDkOkFMtZWJSBe2aoBo02h9FJV9HJKqnWCl8fu3hp3ScEsoqbLW4mmZ/+DbFe51SGVW1MoQPhqZ04O5+waX0grmlc7zAaQM7nwXsI2QaSOJg5gcIHORIaBbUbnyUaz3sz8jBxc0foq/xJpq+Tup3Pp9thR01FxLQ4jm+WsIwew1or3wDjpzef24f2KTtMnZov1X3c142du6KjG4i20lwuYqRlc3p2BHTKBqoHwewj+S6MdnA2nqiKD3OHDpvPtZXxmaojD1HISuOiMIqFNu1VMvAGUv4BWL1mO5l50oe3ALJIkhftGXXQsJQlOvxr6sEz403mfIyDQ5aUmAB/XsLA1iDExAh5m4ZsGZCGzSTwz3dfCq0GJuWKrJMdvP9p+2t3K7/EjAu2/oxFJMSTiTqsF+EGLYGodnOS1KA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(6666004)(36860700001)(81166007)(41300700001)(82740400003)(356005)(47076005)(8936002)(26005)(1076003)(7416002)(8676002)(5660300002)(2616005)(336012)(426003)(83380400001)(186003)(2906002)(40480700001)(86362001)(82310400005)(70586007)(70206006)(4326008)(316002)(478600001)(36756003)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 07:33:13.0042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ec74146-3478-4d24-cf0c-08db51f1fa3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145B8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7978
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GQSPI supports two chip select CS0 & CS1. Update the driver to
assert/de-assert the appropriate chip select as per the bits set in
qspi->cs_index_mask.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index fb2ca9b90eab..3d2b92a88e8a 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -156,6 +156,9 @@
 #define GQSPI_FREQ_100MHZ	100000000
 #define GQSPI_FREQ_150MHZ	150000000
 
+#define GQSPI_SELECT_LOWER_CS  BIT(0)
+#define GQSPI_SELECT_UPPER_CS  BIT(1)
+
 #define SPI_AUTOSUSPEND_TIMEOUT		3000
 enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
 
@@ -467,15 +470,17 @@ static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
 
 	genfifoentry |= GQSPI_GENFIFO_MODE_SPI;
 
+	if (qspi->cs_index_mask & GQSPI_SELECT_UPPER_CS) {
+		zynqmp_gqspi_selectslave(xqspi,
+					 GQSPI_SELECT_FLASH_CS_UPPER,
+					 GQSPI_SELECT_FLASH_BUS_LOWER);
+	} else if (qspi->cs_index_mask & GQSPI_SELECT_LOWER_CS) {
+		zynqmp_gqspi_selectslave(xqspi,
+					 GQSPI_SELECT_FLASH_CS_LOWER,
+					 GQSPI_SELECT_FLASH_BUS_LOWER);
+	}
+	genfifoentry |= xqspi->genfifobus;
 	if (!is_high) {
-		if (!spi_get_chipselect(qspi, 0)) {
-			xqspi->genfifobus = GQSPI_GENFIFO_BUS_LOWER;
-			xqspi->genfifocs = GQSPI_GENFIFO_CS_LOWER;
-		} else {
-			xqspi->genfifobus = GQSPI_GENFIFO_BUS_UPPER;
-			xqspi->genfifocs = GQSPI_GENFIFO_CS_UPPER;
-		}
-		genfifoentry |= xqspi->genfifobus;
 		genfifoentry |= xqspi->genfifocs;
 		genfifoentry |= GQSPI_GENFIFO_CS_SETUP;
 	} else {
-- 
2.17.1

