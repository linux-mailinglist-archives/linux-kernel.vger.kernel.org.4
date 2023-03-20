Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6AF6C0E15
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjCTKE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCTKEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:04:23 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328F62448C;
        Mon, 20 Mar 2023 03:03:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlchUWINvRHmppOilwnpDwemBDwvJuEwlJTsVGrHwQOgTiPBAft/Z0uaNxdXNRZe/TWMbKZEXTgS101eDY0IvIFLmEwfQWzGB4kyTq1LOXD5ospreM6zictpaJafven2GWLXvm6QYLD/B4bxhgjPCutWn+j4K99UwBNeZ4dCxNrHaPNKOtcgGAwXRxGupyqr+uS7+zyj9qrwm6aivqFpHtRwuDtdjs2FRLqNf3VIbpJeMb3L5Fx83T4ML4AXFiW53pYkc4NkC0kOTGWkMbJvEVmuGRfm3fbGwToLFFjUCxq3R0ObswOl04jfiwu/utbu+Yx4DL3dJA6f1lPcq4ZftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymbBBZqqJ4+gZVusIXMgD3b2TsKXYiOfyYewbaL57fY=;
 b=e/xUJ9foGIlf8CJInhZVxusVxcs8EBltWENPLOgNThjHMmXpa/yRZU1XI4XPLHr02kScObqVft6m/vIsYxVAr/8CdU85Jh7GoBJJPYFCC8mXi+rnLS6qVu3H1XT4ZB3fbSOmM6jnJx/jO7f32OWMh0Pz6uLEwUPlPOiCa9ORYaaSI7s6CiUVUYBlaY52noDGzk1lfZEDU4m2Wftki3G3Knjh9Zs3qnAGFIEjDi4eRVRxAPYrOlgFcN6VSOcjhBy6taV6ix1q1U3/al0veU2z9CBw118WUyHedLcbcN2hFteu5iZKeYKQDRDHb1iu+SoyslE10QbDtnZ19X1EN97FNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymbBBZqqJ4+gZVusIXMgD3b2TsKXYiOfyYewbaL57fY=;
 b=5LmMlo9zd0LQtX9oykbGYOWJhq9WIzwSz6RkvcV9Tn62p3veoMiC1TTbxcjyebJlb87SWuL9SvxAW0xgKNatZgLa4C6yeWvLPkPbkNX8nQtoJe6EsNZWbUGf30GX1LcXyW6uoFXlSCkJWAHLA3ahakwil2PHNtGza/izr3Z48Gc=
Received: from MW2PR16CA0024.namprd16.prod.outlook.com (2603:10b6:907::37) by
 SJ0PR12MB5405.namprd12.prod.outlook.com (2603:10b6:a03:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 10:03:30 +0000
Received: from CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::94) by MW2PR16CA0024.outlook.office365.com
 (2603:10b6:907::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 10:03:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT078.mail.protection.outlook.com (10.13.175.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 10:03:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 05:03:25 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 05:03:11 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 20 Mar 2023 05:03:09 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, <saikrishna12468@gmail.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH 2/2] spi: cadence-quadspi: Disable the SPI before reconfiguring
Date:   Mon, 20 Mar 2023 15:29:31 +0530
Message-ID: <20230320095931.2651714-3-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320095931.2651714-1-sai.krishna.potthuri@amd.com>
References: <20230320095931.2651714-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT078:EE_|SJ0PR12MB5405:EE_
X-MS-Office365-Filtering-Correlation-Id: c77c9134-e28f-4ffe-3565-08db292a5b82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Idvdal2HXUPChA0MkqvVO9I/PDLqMIykY93cO9dyR8o13XoYPtqDq1fV/eQrLHjspvu2bqNHAI/euMqg9oVvBY2jtce9LuvwEEcwjvP70p8ZVtIpLlsNgzYR86M7+ifwx7DlUoPH6FKaS86y1BriLGzWFVnUYtIVaNLsFAKCgvHicZ5i2v2if2wOV97b6xziTQAc89AV2Z3jXhui8uodFE1RlbvjEoBqJRjlS+ZwtVIhGjzlHuySPoZKR0gJFjC9vaqPsz4auujnw5guZzUuHag64YERulZdk9v9tc7Bb0wflJ1fIsED/Sw1PdCKXNbI24qtTakXWwQpT75oGlLuuH4Ba9zkWfBoEZbVTWVqPcZgn2kiwxnNpPXhwh4oqGbITX9ohe+U2g0Mf5wz3ln/9Q7bLd5lhiSMVRW9UkVKeBY2CH4xYCQQ+ust2bH2soA6rpylcJVDPZLRFIpUlCBfF/2D1hTLhPnmrRjQNCSlTV0dzP4azmwyOWM+D7Lf3O6v1duOWOj+YeAp20RxB9ZfoBE1Gvj5UUbiGBY50II01JxZGxkja7XBYwRat6OZKEu963Sc+dXxsPLta5EBLurXDViU3lv/bSNpvgSAjlgZidpO+sMnrsHK5Sv4494HnkMayBedNIb8igu4zfBsFRKm7AlCTZreNMfxQW8/Tpt0Ut7TDgralrntGIrGaD0PA4st0Bkg0DMxjQdrtJCSq9QPRFITmNWC60haHGMi5iCRm6k=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(2616005)(426003)(47076005)(478600001)(83380400001)(6666004)(336012)(316002)(8676002)(70206006)(6916009)(70586007)(186003)(26005)(1076003)(54906003)(4326008)(36860700001)(41300700001)(5660300002)(8936002)(40460700003)(81166007)(82740400003)(2906002)(356005)(40480700001)(82310400005)(86362001)(36756003)(103116003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 10:03:30.1963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c77c9134-e28f-4ffe-3565-08db292a5b82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5405
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Observed random DMA timeout failures while doing back to back
transfers which involves switching the modes from DMA to NON-DMA.
This issue is observed while testing the OSPI+UBIFS file system test case
where rootfs is mounted from OSPI UBIFS partition.
To avoid this issue, disable the SPI before changing the configuration
from external DMA to NON-DMA and vice versa and reenable it after changing
the configuration.
As per the Cadence Octal SPI design specification, it is recommended to
disable the Octal-SPI enable bit before reconfiguring.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 drivers/spi/spi-cadence-quadspi.c | 38 +++++++++++++++++++------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index e281732aba91..d4a2b72985da 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -791,6 +791,21 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 	return ret;
 }
 
+static void cqspi_controller_enable(struct cqspi_st *cqspi, bool enable)
+{
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+
+	reg = readl(reg_base + CQSPI_REG_CONFIG);
+
+	if (enable)
+		reg |= CQSPI_REG_CONFIG_ENABLE_MASK;
+	else
+		reg &= ~CQSPI_REG_CONFIG_ENABLE_MASK;
+
+	writel(reg, reg_base + CQSPI_REG_CONFIG);
+}
+
 static int cqspi_versal_indirect_read_dma(struct cqspi_flash_pdata *f_pdata,
 					  u_char *rxbuf, loff_t from_addr,
 					  size_t n_rx)
@@ -815,10 +830,14 @@ static int cqspi_versal_indirect_read_dma(struct cqspi_flash_pdata *f_pdata,
 	if (ret)
 		return ret;
 
+	cqspi_controller_enable(cqspi, 0);
+
 	reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
 	reg |= CQSPI_REG_CONFIG_DMA_MASK;
 	writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
 
+	cqspi_controller_enable(cqspi, 1);
+
 	dma_addr = dma_map_single(dev, rxbuf, bytes_to_dma, DMA_FROM_DEVICE);
 	if (dma_mapping_error(dev, dma_addr)) {
 		dev_err(dev, "dma mapping failed\n");
@@ -876,10 +895,14 @@ static int cqspi_versal_indirect_read_dma(struct cqspi_flash_pdata *f_pdata,
 	       cqspi->iobase + CQSPI_REG_INDIRECTRD);
 	dma_unmap_single(dev, dma_addr, bytes_to_dma, DMA_FROM_DEVICE);
 
+	cqspi_controller_enable(cqspi, 0);
+
 	reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
 	reg &= ~CQSPI_REG_CONFIG_DMA_MASK;
 	writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
 
+	cqspi_controller_enable(cqspi, 1);
+
 	ret = zynqmp_pm_ospi_mux_select(cqspi->pd_dev_id,
 					PM_OSPI_MUX_SEL_LINEAR);
 	if (ret)
@@ -1182,21 +1205,6 @@ static void cqspi_readdata_capture(struct cqspi_st *cqspi,
 	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
 }
 
-static void cqspi_controller_enable(struct cqspi_st *cqspi, bool enable)
-{
-	void __iomem *reg_base = cqspi->iobase;
-	unsigned int reg;
-
-	reg = readl(reg_base + CQSPI_REG_CONFIG);
-
-	if (enable)
-		reg |= CQSPI_REG_CONFIG_ENABLE_MASK;
-	else
-		reg &= ~CQSPI_REG_CONFIG_ENABLE_MASK;
-
-	writel(reg, reg_base + CQSPI_REG_CONFIG);
-}
-
 static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 			    unsigned long sclk)
 {
-- 
2.25.1

