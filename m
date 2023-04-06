Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584C06D8FCF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbjDFGyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbjDFGyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:54:20 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267498688;
        Wed,  5 Apr 2023 23:54:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6GDU7TVUXCisOIX7gM6osy9lo/+G5ByZrraK1h/N6uL0lyRsYdEGqtknNzF2ORzNx99YTAMFku+RVYARoIrLTPcvv890BODDz+KjpFur1qM6N0pu+PxsL0T/3Z4Qd9DMsT97ahkIbUE0JBBJ6OmRZYErnjBKraUnlTccthD0iHajW4WNJsoBGC3VaO+KlwHhKs7+1Gnfuj5MJYXo9xQixWmWo2ZZpxUEIwW2xRdorA484OFmXQYYRrAAM3wBh2JlypZxy+gTg0iZm3CaxaRdfYZFxtO4NbSMgXhzCRbS2gSY+hfRK+aQm9cnKVxgwFgkwMuLMwrcxLk3vioNdXJHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=964102L2ptz7lsSQnhvi6j9Bkg19X6662QbPJG1sNIQ=;
 b=R376kTl3ue/2a0BKglyK0qq/zYTc6RspuqVNpYWBC8poOvCgp0XVMW8gq1/SpNgsmnQuOPVzSRslQo3nDyBUPyO2cBCUsE0f/9tLhVZwTBoV2815DLA82fcty62r6cO5qYwExJmli8dwwCcUEkkpqszsYTt+LsODYtf26Nb2C2m1Rf4vBc8snADab3xtRa2rw0eY1Wys7I1PC6C3XENNGvPltWsBtG+/qdrOqBzrXJAsQsztxmMq+0jpXZ9OET/WNrzTRTRHZzmgE1T1yh8StJDSIVHy9wWE3qi/COEALhDzei6t/cnx75DlPeuOuefvtEdYzpKEMGtb+LwFiCllEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=964102L2ptz7lsSQnhvi6j9Bkg19X6662QbPJG1sNIQ=;
 b=gjUKqDODlCz/V44X9OxV5o/o5TfljkvzcsM5DoIBlN050waw4+hM++HUcu1RmjS5TgmFnvWLljJ5AV/FVHh8ZDBZ3rDe6xO3tOLGgtXXl+Wr4mo3f68Crx8JxQeNMJw7tkAwmPpwFQCnRqAMG9IHN9tXcX+YdZh6HO6PyEgWXXE=
Received: from DM6PR10CA0004.namprd10.prod.outlook.com (2603:10b6:5:60::17) by
 PH7PR12MB7020.namprd12.prod.outlook.com (2603:10b6:510:1ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Thu, 6 Apr
 2023 06:54:12 +0000
Received: from DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::ec) by DM6PR10CA0004.outlook.office365.com
 (2603:10b6:5:60::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.37 via Frontend
 Transport; Thu, 6 Apr 2023 06:54:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT104.mail.protection.outlook.com (10.13.173.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.31 via Frontend Transport; Thu, 6 Apr 2023 06:54:11 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 6 Apr
 2023 01:53:48 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 6 Apr
 2023 01:53:48 -0500
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Thu, 6 Apr 2023 01:53:43 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <broonie@kernel.org>, <tudor.ambarus@linaro.org>,
        <pratyush@kernel.org>, <michael@walle.cc>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <git@amd.com>, <sbinding@opensource.cirrus.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <michal.simek@amd.com>, <linux-arm-kernel@lists.infradead.org>,
        <amitrkcian2002@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH V7 1/7] spi: Add stacked and parallel memories support in SPI core
Date:   Thu, 6 Apr 2023 12:23:30 +0530
Message-ID: <20230406065336.10980-2-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406065336.10980-1-amit.kumar-mahapatra@amd.com>
References: <20230406065336.10980-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT104:EE_|PH7PR12MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: dbfcd0a7-01e8-4a42-6e79-08db366bba35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 00Q2kOb8hVKadJig2NjuLFuEEVVbpohSkpWApqxupdqXwB6fVIfvzTLAI1Pd7CVM3o8vjNPWoE3BVi0c0dq6QbnMkPebqq++y6bmRgBB3Mx1TjZuaJC6DH1wWFg+8xwr1n5Oggca9hzxfCh7ZPZzqAytipeaUIWCPYzJlxrKOgHsas7HysvdJK5AxlYcpXrDRU95yXyULBFcmjZm4QBV/oxxtTlxzokhXFio96nbIS5Cli+98vKgyMRMgqiH1CsCeH7KYzszOwiaNU1TbRPPR82+V+gHLNCXn3acyBqbAjsoKPoekG75uORHMsgNwttEcKRbODEKGf53cW/E6ZFKw4WkO9fqcGZZMjLlVtYaQ7In4zNFMM6nsKQQ3AAubxrWxIMXZ87VyybLN1xkH7nG8UmJ7Ua1rxg1vlhKbO9tGDeTdk0kRJ0YSZpW3Ous+iAt8SAqHSvaAzvEsdBsDlxG68YA+z7398yzG2cmsg/3goToj0j2gJCEeUtPZpCnVAqm8CrJ5SX/RR7XLFLYC2CPErBQ1DOjfN3lob/Fyh3WGr+KuLU0MOdrDQGWmXPc6JFmQ7/Q1khcY9bCINPKxPyjQ1gMXBzD83ycdsz4j/UmByFt28R59x592eLGUT0dxbrfzrL9URDJfyWeox5SUCcfskmsXAWYENqedU2KmCgDhMTtecEOR4KZKgNBIL+MCxxdgSgFoYEDqvMCwpTbbKept2dk9Le913ofOKDTAfHGAa7gPSsUYo6gUNW41/8u3wZB
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(26005)(82310400005)(186003)(6666004)(41300700001)(8676002)(478600001)(47076005)(40460700003)(83380400001)(426003)(70586007)(316002)(4326008)(1076003)(336012)(70206006)(2616005)(110136005)(81166007)(356005)(36756003)(82740400003)(36860700001)(7416002)(8936002)(54906003)(86362001)(30864003)(2906002)(5660300002)(40480700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 06:54:11.5740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbfcd0a7-01e8-4a42-6e79-08db366bba35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7020
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For supporting multiple CS the SPI device need to be aware of all the CS
values. So, the "chip_select" member in the spi_device structure is now an
array that holds all the CS values.

spi_device structure now has a "cs_index_mask" member. This acts as an
index to the chip_select array. If nth bit of spi->cs_index_mask is set
then the driver would assert spi->chip_select[n].

In parallel mode all the chip selects are asserted/de-asserted
simultaneously and each byte of data is stored in both devices, the even
bits in one, the odd bits in the other. The split is automatically handled
by the GQSPI controller. The GQSPI controller supports a maximum of two
flashes connected in parallel mode. A SPI_CONTROLLER_MULTI_CS flag bit is
added in the spi controntroller flags, through ctlr->flags the spi core
will make sure that the controller is capable of handling multiple chip
selects at once.

For supporting multiple CS via GPIO the cs_gpiod member of the spi_device
structure is now an array that holds the gpio descriptor for each
chipselect.

Multi CS support using GPIO is not tested due to unavailability of
necessary hardware setup.

Multi CS configuration with one native CS and one GPIO CS is not supported
as this configuration could not be tested due to unavailability of
necessary hardware setup.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
 drivers/spi/spi.c       | 226 ++++++++++++++++++++++++++++------------
 include/linux/spi/spi.h |  32 ++++--
 2 files changed, 183 insertions(+), 75 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9036d7a50674..04d7322170c4 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -612,10 +612,24 @@ static int spi_dev_check(struct device *dev, void *data)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct spi_device *new_spi = data;
+	int idx, nw_idx;
 
-	if (spi->controller == new_spi->controller &&
-	    spi_get_chipselect(spi, 0) == spi_get_chipselect(new_spi, 0))
-		return -EBUSY;
+	if (spi->controller == new_spi->controller) {
+		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+			for (nw_idx = 0; nw_idx < SPI_CS_CNT_MAX; nw_idx++) {
+				if ((idx != 0 && !spi_get_chipselect(spi, idx)) ||
+				    (nw_idx != 0 && !spi_get_chipselect(spi, nw_idx))) {
+					continue;
+				} else if (spi_get_chipselect(spi, idx) ==
+				    spi_get_chipselect(new_spi, nw_idx)) {
+					dev_err(dev,
+						"chipselect %d already in use\n",
+						spi_get_chipselect(new_spi, nw_idx));
+					return -EBUSY;
+				}
+			}
+		}
+	}
 	return 0;
 }
 
@@ -629,7 +643,7 @@ static int __spi_add_device(struct spi_device *spi)
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct device *dev = ctlr->dev.parent;
-	int status;
+	int status, idx;
 
 	/*
 	 * We need to make sure there's no other device with this
@@ -638,8 +652,6 @@ static int __spi_add_device(struct spi_device *spi)
 	 */
 	status = bus_for_each_dev(&spi_bus_type, NULL, spi, spi_dev_check);
 	if (status) {
-		dev_err(dev, "chipselect %d already in use\n",
-				spi_get_chipselect(spi, 0));
 		return status;
 	}
 
@@ -649,8 +661,10 @@ static int __spi_add_device(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	if (ctlr->cs_gpiods)
-		spi_set_csgpiod(spi, 0, ctlr->cs_gpiods[spi_get_chipselect(spi, 0)]);
+	if (ctlr->cs_gpiods) {
+		for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
+			spi_set_csgpiod(spi, idx, ctlr->cs_gpiods[spi_get_chipselect(spi, idx)]);
+	}
 
 	/*
 	 * Drivers may modify this initial i/o setup, but will
@@ -690,13 +704,15 @@ int spi_add_device(struct spi_device *spi)
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct device *dev = ctlr->dev.parent;
-	int status;
+	int status, idx;
 
-	/* Chipselects are numbered 0..max; validate. */
-	if (spi_get_chipselect(spi, 0) >= ctlr->num_chipselect) {
-		dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi, 0),
-			ctlr->num_chipselect);
-		return -EINVAL;
+	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+		/* Chipselects are numbered 0..max; validate. */
+		if (spi_get_chipselect(spi, idx) >= ctlr->num_chipselect) {
+			dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi, idx),
+				ctlr->num_chipselect);
+			return -EINVAL;
+		}
 	}
 
 	/* Set the bus ID string */
@@ -713,12 +729,15 @@ static int spi_add_device_locked(struct spi_device *spi)
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct device *dev = ctlr->dev.parent;
+	int idx;
 
-	/* Chipselects are numbered 0..max; validate. */
-	if (spi_get_chipselect(spi, 0) >= ctlr->num_chipselect) {
-		dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi, 0),
-			ctlr->num_chipselect);
-		return -EINVAL;
+	for (idx = 0; idx < SPI_CS_CNT_MAX; idx++) {
+		/* Chipselects are numbered 0..max; validate. */
+		if (spi_get_chipselect(spi, idx) >= ctlr->num_chipselect) {
+			dev_err(dev, "cs%d >= max %d\n", spi_get_chipselect(spi, idx),
+				ctlr->num_chipselect);
+			return -EINVAL;
+		}
 	}
 
 	/* Set the bus ID string */
@@ -966,58 +985,118 @@ static void spi_res_release(struct spi_controller *ctlr, struct spi_message *mes
 static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 {
 	bool activate = enable;
+	u32 cs_num = __ffs(spi->cs_index_mask);
+	int idx;
 
 	/*
-	 * Avoid calling into the driver (or doing delays) if the chip select
-	 * isn't actually changing from the last time this was called.
+	 * In parallel mode all the chip selects are asserted/de-asserted
+	 * at once
 	 */
-	if (!force && ((enable && spi->controller->last_cs == spi_get_chipselect(spi, 0)) ||
-		       (!enable && spi->controller->last_cs != spi_get_chipselect(spi, 0))) &&
-	    (spi->controller->last_cs_mode_high == (spi->mode & SPI_CS_HIGH)))
-		return;
-
-	trace_spi_set_cs(spi, activate);
-
-	spi->controller->last_cs = enable ? spi_get_chipselect(spi, 0) : -1;
-	spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
-
-	if ((spi_get_csgpiod(spi, 0) || !spi->controller->set_cs_timing) && !activate)
-		spi_delay_exec(&spi->cs_hold, NULL);
-
-	if (spi->mode & SPI_CS_HIGH)
-		enable = !enable;
+	if ((spi->cs_index_mask & SPI_PARALLEL_CS_MASK) == SPI_PARALLEL_CS_MASK) {
+		spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
+
+		if ((spi_get_csgpiod(spi, 0) || !spi->controller->set_cs_timing) && !activate)
+			spi_delay_exec(&spi->cs_hold, NULL);
+
+		if (spi->mode & SPI_CS_HIGH)
+			enable = !enable;
+
+		if (spi_get_csgpiod(spi, 0) && spi_get_csgpiod(spi, 1)) {
+			if (!(spi->mode & SPI_NO_CS)) {
+				/*
+				 * Historically ACPI has no means of the GPIO polarity and
+				 * thus the SPISerialBus() resource defines it on the per-chip
+				 * basis. In order to avoid a chain of negations, the GPIO
+				 * polarity is considered being Active High. Even for the cases
+				 * when _DSD() is involved (in the updated versions of ACPI)
+				 * the GPIO CS polarity must be defined Active High to avoid
+				 * ambiguity. That's why we use enable, that takes SPI_CS_HIGH
+				 * into account.
+				 */
+				if (has_acpi_companion(&spi->dev)) {
+					for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
+						gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
+									 !enable);
+				} else {
+					for (idx = 0; idx < SPI_CS_CNT_MAX; idx++)
+						/* Polarity handled by GPIO library */
+						gpiod_set_value_cansleep(spi_get_csgpiod(spi, idx),
+									 activate);
+				}
+			}
+			/* Some SPI masters need both GPIO CS & slave_select */
+			if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
+			    spi->controller->set_cs)
+				spi->controller->set_cs(spi, !enable);
+		} else if (spi->controller->set_cs) {
+			spi->controller->set_cs(spi, !enable);
+		}
 
-	if (spi_get_csgpiod(spi, 0)) {
-		if (!(spi->mode & SPI_NO_CS)) {
-			/*
-			 * Historically ACPI has no means of the GPIO polarity and
-			 * thus the SPISerialBus() resource defines it on the per-chip
-			 * basis. In order to avoid a chain of negations, the GPIO
-			 * polarity is considered being Active High. Even for the cases
-			 * when _DSD() is involved (in the updated versions of ACPI)
-			 * the GPIO CS polarity must be defined Active High to avoid
-			 * ambiguity. That's why we use enable, that takes SPI_CS_HIGH
-			 * into account.
-			 */
-			if (has_acpi_companion(&spi->dev))
-				gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), !enable);
+		if (spi_get_csgpiod(spi, 0) || spi_get_csgpiod(spi, 1) ||
+		    !spi->controller->set_cs_timing) {
+			if (activate)
+				spi_delay_exec(&spi->cs_setup, NULL);
 			else
-				/* Polarity handled by GPIO library */
-				gpiod_set_value_cansleep(spi_get_csgpiod(spi, 0), activate);
+				spi_delay_exec(&spi->cs_inactive, NULL);
 		}
-		/* Some SPI masters need both GPIO CS & slave_select */
-		if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
-		    spi->controller->set_cs)
+	} else {
+		/*
+		 * Avoid calling into the driver (or doing delays) if the chip select
+		 * isn't actually changing from the last time this was called.
+		 */
+		if (!force && ((enable && spi->controller->last_cs ==
+				spi_get_chipselect(spi, cs_num)) ||
+				(!enable && spi->controller->last_cs !=
+				 spi_get_chipselect(spi, cs_num))) &&
+		    (spi->controller->last_cs_mode_high ==
+		     (spi->mode & SPI_CS_HIGH)))
+			return;
+
+		trace_spi_set_cs(spi, activate);
+
+		spi->controller->last_cs = enable ? spi_get_chipselect(spi, cs_num) : -1;
+		spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
+
+		if ((spi_get_csgpiod(spi, cs_num) || !spi->controller->set_cs_timing) && !activate)
+			spi_delay_exec(&spi->cs_hold, NULL);
+
+		if (spi->mode & SPI_CS_HIGH)
+			enable = !enable;
+
+		if (spi_get_csgpiod(spi, cs_num)) {
+			if (!(spi->mode & SPI_NO_CS)) {
+				/*
+				 * Historically ACPI has no means of the GPIO polarity and
+				 * thus the SPISerialBus() resource defines it on the per-chip
+				 * basis. In order to avoid a chain of negations, the GPIO
+				 * polarity is considered being Active High. Even for the cases
+				 * when _DSD() is involved (in the updated versions of ACPI)
+				 * the GPIO CS polarity must be defined Active High to avoid
+				 * ambiguity. That's why we use enable, that takes SPI_CS_HIGH
+				 * into account.
+				 */
+				if (has_acpi_companion(&spi->dev))
+					gpiod_set_value_cansleep(spi_get_csgpiod(spi, cs_num),
+								 !enable);
+				else
+					/* Polarity handled by GPIO library */
+					gpiod_set_value_cansleep(spi_get_csgpiod(spi, cs_num),
+								 activate);
+			}
+			/* Some SPI masters need both GPIO CS & slave_select */
+			if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
+			    spi->controller->set_cs)
+				spi->controller->set_cs(spi, !enable);
+		} else if (spi->controller->set_cs) {
 			spi->controller->set_cs(spi, !enable);
-	} else if (spi->controller->set_cs) {
-		spi->controller->set_cs(spi, !enable);
-	}
+		}
 
-	if (spi_get_csgpiod(spi, 0) || !spi->controller->set_cs_timing) {
-		if (activate)
-			spi_delay_exec(&spi->cs_setup, NULL);
-		else
-			spi_delay_exec(&spi->cs_inactive, NULL);
+		if (spi_get_csgpiod(spi, cs_num) || !spi->controller->set_cs_timing) {
+			if (activate)
+				spi_delay_exec(&spi->cs_setup, NULL);
+			else
+				spi_delay_exec(&spi->cs_inactive, NULL);
+		}
 	}
 }
 
@@ -2246,8 +2325,8 @@ static void of_spi_parse_dt_cs_delay(struct device_node *nc,
 static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 			   struct device_node *nc)
 {
-	u32 value;
-	int rc;
+	u32 value, cs[SPI_CS_CNT_MAX] = {0};
+	int rc, idx;
 
 	/* Mode (clock phase/polarity/etc.) */
 	if (of_property_read_bool(nc, "spi-cpha"))
@@ -2320,13 +2399,21 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	}
 
 	/* Device address */
-	rc = of_property_read_u32(nc, "reg", &value);
-	if (rc) {
+	rc = of_property_read_variable_u32_array(nc, "reg", &cs[0], 1,
+						 SPI_CS_CNT_MAX);
+	if (rc < 0 || rc > ctlr->num_chipselect) {
 		dev_err(&ctlr->dev, "%pOF has no valid 'reg' property (%d)\n",
 			nc, rc);
 		return rc;
+	} else if ((of_property_read_bool(nc, "parallel-memories")) &&
+		   (!(ctlr->flags & SPI_CONTROLLER_MULTI_CS))) {
+		dev_err(&ctlr->dev, "SPI controller doesn't support multi CS\n");
+		return -EINVAL;
 	}
-	spi_set_chipselect(spi, 0, value);
+	for (idx = 0; idx < rc; idx++)
+		spi_set_chipselect(spi, idx, cs[idx]);
+	/* By default set the spi->cs_index_mask as 1 */
+	spi->cs_index_mask = 0x01;
 
 	/* Device speed */
 	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
@@ -3907,7 +3994,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 	 * cs_change is set for each transfer.
 	 */
 	if ((spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits & SPI_CS_WORD) ||
-					  spi_get_csgpiod(spi, 0))) {
+					  spi_get_csgpiod(spi, 0) ||
+					  spi_get_csgpiod(spi, 1))) {
 		size_t maxsize;
 		int ret;
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 873ced6ae4ca..6453b246e0af 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -19,6 +19,11 @@
 #include <linux/acpi.h>
 #include <linux/u64_stats_sync.h>
 
+/* Max no. of CS supported per spi device */
+#define SPI_CS_CNT_MAX 2
+
+/* chip select mask */
+#define SPI_PARALLEL_CS_MASK	(BIT(0) | BIT(1))
 struct dma_chan;
 struct software_node;
 struct ptp_system_timestamp;
@@ -166,6 +171,7 @@ extern void spi_transfer_cs_change_delay_exec(struct spi_message *msg,
  *	deasserted. If @cs_change_delay is used from @spi_transfer, then the
  *	two delays will be added up.
  * @pcpu_statistics: statistics for the spi_device
+ * @cs_index_mask: Bit mask of the active chipselect(s) in the chipselect array
  *
  * A @spi_device is used to interchange data between an SPI slave
  * (usually a discrete chip) and CPU memory.
@@ -181,7 +187,7 @@ struct spi_device {
 	struct spi_controller	*controller;
 	struct spi_controller	*master;	/* Compatibility layer */
 	u32			max_speed_hz;
-	u8			chip_select;
+	u8			chip_select[SPI_CS_CNT_MAX];
 	u8			bits_per_word;
 	bool			rt;
 #define SPI_NO_TX	BIT(31)		/* No transmit wire */
@@ -202,7 +208,7 @@ struct spi_device {
 	void			*controller_data;
 	char			modalias[SPI_NAME_SIZE];
 	const char		*driver_override;
-	struct gpio_desc	*cs_gpiod;	/* Chip select gpio desc */
+	struct gpio_desc	*cs_gpiod[SPI_CS_CNT_MAX];	/* Chip select gpio desc */
 	struct spi_delay	word_delay; /* Inter-word delay */
 	/* CS delays */
 	struct spi_delay	cs_setup;
@@ -212,6 +218,13 @@ struct spi_device {
 	/* The statistics */
 	struct spi_statistics __percpu	*pcpu_statistics;
 
+	/* Bit mask of the chipselect(s) that the driver need to use from
+	 * the chipselect array.When the controller is capable to handle
+	 * multiple chip selects & memories are connected in parallel
+	 * then more than one bit need to be set in cs_index_mask.
+	 */
+	u32			cs_index_mask : SPI_CS_CNT_MAX;
+
 	/*
 	 * likely need more hooks for more protocol options affecting how
 	 * the controller talks to each chip, like:
@@ -268,22 +281,22 @@ static inline void *spi_get_drvdata(const struct spi_device *spi)
 
 static inline u8 spi_get_chipselect(const struct spi_device *spi, u8 idx)
 {
-	return spi->chip_select;
+	return spi->chip_select[idx];
 }
 
 static inline void spi_set_chipselect(struct spi_device *spi, u8 idx, u8 chipselect)
 {
-	spi->chip_select = chipselect;
+	spi->chip_select[idx] = chipselect;
 }
 
 static inline struct gpio_desc *spi_get_csgpiod(const struct spi_device *spi, u8 idx)
 {
-	return spi->cs_gpiod;
+	return spi->cs_gpiod[idx];
 }
 
 static inline void spi_set_csgpiod(struct spi_device *spi, u8 idx, struct gpio_desc *csgpiod)
 {
-	spi->cs_gpiod = csgpiod;
+	spi->cs_gpiod[idx] = csgpiod;
 }
 
 /**
@@ -388,6 +401,8 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @bus_lock_spinlock: spinlock for SPI bus locking
  * @bus_lock_mutex: mutex for exclusion of multiple callers
  * @bus_lock_flag: indicates that the SPI bus is locked for exclusive use
+ * @multi_cs_cap: indicates that the SPI Controller can assert/de-assert
+ *	more than one chip select at once.
  * @setup: updates the device mode and clocking records used by a
  *	device's SPI controller; protocol code may call this.  This
  *	must fail if an unrecognized or unsupported mode is requested.
@@ -554,6 +569,11 @@ struct spi_controller {
 #define SPI_CONTROLLER_MUST_TX		BIT(4)	/* Requires tx */
 
 #define SPI_MASTER_GPIO_SS		BIT(5)	/* GPIO CS must select slave */
+	/*
+	 * The spi-controller has multi chip select capability and can
+	 * assert/de-assert more than one chip select at once.
+	 */
+#define SPI_CONTROLLER_MULTI_CS		BIT(6)
 
 	/* Flag indicating if the allocation of this struct is devres-managed */
 	bool			devm_allocated;
-- 
2.17.1

