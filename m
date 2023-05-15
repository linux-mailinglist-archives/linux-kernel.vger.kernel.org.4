Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0521E702D57
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242085AbjEONEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbjEOND7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:03:59 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20627.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9995D1999;
        Mon, 15 May 2023 06:03:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvSp1cFLWzossRSnMT6IRH4JJy95uYAOTCcbicDSs+mJBab07rnwCcWMyumKJfppj5xaiWeIECRIqLVBQagTYD9eMBMV2wRVmZC03mOf/lc1bh5ve9wrxYMjcoGYHzzFOLK3OmhzCcShznZ7M9A7FMJbHvEEhF8vvz6Y/wZbGCB5f7kgpafCK8dD0XGjZh8hc9W7rt3ZAs+DGJ66vSHcwR9WTzVoxbm56oqic4j0uXZCKNNJu/263KF0OR74/7epaUCUJc3Rm7cJnkuwYaKaFciaqgCT5VKRXuQy3w5T6IqI/kODwgwWH3hykx5HDTojA3RW37hhOmR7Ce89RaqGUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJkWugCg+TuiLU9N7KENIF4vQvxEOI7okOSQE57I8F0=;
 b=BQ84ysvhdfo2sOjtk11CLhHNuh8rxc4E8AyzkwTwa0aGiKKjDfudDEmrHG1TuTk7jTJGupWpYkzZgR8A6FmArZFl2yGjpYmy9owfP7KALiNro6jA6/YiAruJyeqPE0tcAsfxDnMWow65NvuM7kykzZw07WsD8DbY9homM/m3+V6+Vj2C2M0ur1REu0TZEoNsH3Ps9X4Bmk0tUEHSLKm2OA0JLFc7OgKLJ00X4DKWkBHN0UuGJXHeDJ5kXVPLrQbF+lrXZT4VlSUoiIEtONAs0ku3RNlElva1PpKtrl3nYBUa0cPvr+EJqGphcCuO1Y1hNYYdWhjq5mJ1CQ3V/7ypBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJkWugCg+TuiLU9N7KENIF4vQvxEOI7okOSQE57I8F0=;
 b=5CJs2ESM8gN6sk6M7dJlp56NMtqFT+m4vdKEtgOqgtsPH9vTyJdfZ9PkcbXXJiyTgjupJEGfes/EvDHaK6/sXK8pz+r6+0R9F+d1u5E9Z5qXu0YsCeJi2Cbu9RelMPs128x0PcfoSQZfDRWO/oA3peaXKbzno6gtMwhcyDEOSeA=
Received: from DM5PR08CA0034.namprd08.prod.outlook.com (2603:10b6:4:60::23) by
 LV8PR12MB9184.namprd12.prod.outlook.com (2603:10b6:408:18f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.30; Mon, 15 May 2023 13:03:54 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::30) by DM5PR08CA0034.outlook.office365.com
 (2603:10b6:4:60::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32 via Frontend
 Transport; Mon, 15 May 2023 13:03:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Mon, 15 May 2023 13:03:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 15 May
 2023 08:03:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 15 May
 2023 08:03:53 -0500
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 15 May 2023 08:03:50 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <broonie@kernel.org>
CC:     <blarson@amd.com>, <git@amd.com>, <fancer.lancer@gmail.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <amitrkcian2002@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: [PATCH] spi: dw: Replace spi->chip_select references with function calls
Date:   Mon, 15 May 2023 18:33:43 +0530
Message-ID: <20230515130343.63770-1-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|LV8PR12MB9184:EE_
X-MS-Office365-Filtering-Correlation-Id: 96475230-75b8-4770-d502-08db5544d617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s9yNTJVYBCFhIYg/AlUBMfPG+of2qqkuXpz199wWRVOomySy/TOy8IfRBS90SiKca+B+kmiLstTxKvb2bYtUtaOAfoii5r1mNeTUbju6LYw+9+U11+F8MG4vJTJcN8IwVn7ObH8MA024beG8ahEevv4s9j2ULvcn/8QRQbXxl5/UQ3R/rd411sSYRg2mNaR9S1Lz52xPdf53uLuFmT+MkX0e2l24xJTayO4wChZiT9rgyzH2qAl9m8tzFROf0VTxQ9P6/XVg+2iwd4oPTKLwgONBZct7jlTyOWkvM5Ku5DV3jyRowOk5RLhM1BZae08rHDN+qHalSLZLHbw+Z4Tqit8zn36iTP6PNLIdeQ2Z+uPeUV2o1MavGvMX/8Q5lvwLf927aYietaRuoqBttNoh+rygQixXFuM99fydcILNYBPUABfah2UtYKPx+arPvjAgtjZ+1N7RxxfCrQQsY3Wwf6LsQB58dxj3bXlLM0c904V6n3mz+V8nqphek4CK6sX6z5tZE/ZisKF01F+4TgXND8jITTwNkZYH8imfzEiAL/4Lb17XjY6Ir5/XKpz7I1QYeLuVQBupuFk5cxa/g/Gv/Q5Caqwn4RtB+YZLoVH2ExOL0+FeYtVu5OlsIXuRhYfcQQLylAEerjFhSc81RP8htoXsI/6b5Y2ePkyd3beHjNXyKt2ivrkKSOlUX99uvJ2e/1HZ29EooilWIBe2/hcYppUA2p8dzszN9z23b0IQZkKH8+BybzvsWpg268UHqtcFkOzjW4bfJbNlU3mZp7GNnA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(83380400001)(36860700001)(336012)(47076005)(426003)(4326008)(316002)(82740400003)(6916009)(36756003)(356005)(41300700001)(81166007)(26005)(1076003)(40480700001)(478600001)(2616005)(70586007)(70206006)(86362001)(5660300002)(2906002)(8936002)(8676002)(40460700003)(54906003)(186003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 13:03:54.0299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96475230-75b8-4770-d502-08db5544d617
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9184
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New set/get APIs for accessing spi->chip_select were introduced by
'commit 9e264f3f85a5 ("spi: Replace all spi->chip_select and spi->cs_gpiod
references with function call")', but the 'commit 2c8606040a80 ("spi: dw:
Add support for AMD Pensando Elba SoC")' uses the old interface by directly
accessing spi->chip_select. So, replace all spi->chip_select references
in the driver with new get/set APIs.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
---
BRANCH: for-next
---
 drivers/spi/spi-dw-mmio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 5e6faa98aa85..5f2aee69c1c1 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -264,17 +264,17 @@ static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
 	struct regmap *syscon = dwsmmio->priv;
 	u8 cs;
 
-	cs = spi->chip_select;
+	cs = spi_get_chipselect(spi, 0);
 	if (cs < 2)
-		dw_spi_elba_override_cs(syscon, spi->chip_select, enable);
+		dw_spi_elba_override_cs(syscon, spi_get_chipselect(spi, 0), enable);
 
 	/*
 	 * The DW SPI controller needs a native CS bit selected to start
 	 * the serial engine.
 	 */
-	spi->chip_select = 0;
+	spi_set_chipselect(spi, 0, 0);
 	dw_spi_set_cs(spi, enable);
-	spi->chip_select = cs;
+	spi_get_chipselect(spi, cs);
 }
 
 static int dw_spi_elba_init(struct platform_device *pdev,
-- 
2.17.1

