Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68CA6D41F6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjDCK0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjDCK03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:26:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC0B113D7;
        Mon,  3 Apr 2023 03:26:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Un7wUdRDwUFLfFMJOcnoLUprl8UEtyzUAAjpIb4BzagTgWgqSOAtsIHfSXfORuxsubAmPuRMj099izxZrnfG855i2C+SqgMR+cENT8hJad7zpg4yorVlCUSJDudcwFRCn87gBsnbqCbMZKPdQ54qPA/3oQdBVEi5FJPhhZ8UIMgTnBODFgfVRf2BgiNReRE2k4qikNFOYSvaOUKG2R9Z9Y6NK3hkGk2ONRByEwUpNwKMhGbxHNKgk0tQk0w1E371Td8zOOi6n0IDc2BKLqQj3er1i+yvEYDWtR32FMIPVspuwOBv8NYgX+J788YRd5vI5nRz9SkyeibihDxZVt0v1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehuPES+rvGtvOFSZQxDC/djuDdzbTC2UZn5AFh6w/yc=;
 b=TAX8Vgc5AzMhN17dUpi27y9q8PaaW9vNvjp7WCGrS3O3hI1epp0o+dTBeq5WHUe62pU0iEh9LxkHThCOwYkjFeKLemwhdHrdNoqcHWQ/OpeZSRJ+hZwAaG+jJ0X1aa21/Xto9KbweHsxLQKmCETphf4VPL/wL8pb8k7uri09JhN8PY70B5tD74Q/ImRfdMQsWj5w121xEw5bbCCzYYevvxt6kDmm9BsKD7Al6mC+F1ZIlDJz9zNouDRUYDvuFvVqVOxT5aRWaooyxT2XB5pgQX5hzvcPtbb94eFQoMsqwiOAbLj4m40qhoVi/Wb0EfDk2Hkx/H9YIepbFcteEDYGtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehuPES+rvGtvOFSZQxDC/djuDdzbTC2UZn5AFh6w/yc=;
 b=SI9tg6HdRr0FVtwA/JIAW8fewxewp10wwRDJf9TZubQ574HBv4sSc90DTAOvfx5PvGqpxLSECtMZyQ6GM5sHG+FOFLsNMQA5v4YRJk2Cl4UfugUJHujy/dWvd0iGXYHCtqsoZJqiqWzbf+U9UWFpMIYxrwgRhOF2S/2rNapwwV0=
Received: from DS7P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::15) by
 SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.33; Mon, 3 Apr 2023 10:26:22 +0000
Received: from DS1PEPF0000E636.namprd02.prod.outlook.com
 (2603:10b6:8:2e:cafe::f0) by DS7P222CA0012.outlook.office365.com
 (2603:10b6:8:2e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Mon, 3 Apr 2023 10:26:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E636.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 3 Apr 2023 10:26:21 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 05:26:21 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 03:26:20 -0700
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 3 Apr 2023 05:26:17 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <saikrishna12468@gmail.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH v3 3/3] mmc: sdhci-of-arasan: Skip setting clock delay for 400KHz
Date:   Mon, 3 Apr 2023 15:55:51 +0530
Message-ID: <20230403102551.3763054-4-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230403102551.3763054-1-sai.krishna.potthuri@amd.com>
References: <20230403102551.3763054-1-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E636:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: abf21d48-a11d-4fed-e9db-08db342ddeb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OZ2qVz7Yp2Wyn1j7b8MNbWo2BnX2WM9LOFHoxtX6imC+WFh1DJvcxTWOkd7H4zy1D5G5HMzLihHwW+lCxFU3oExnXX7i7TeSpI9eSVcOYCD3woh1QOzYf59mB3hZnyfa8PuoXRDmy5mK7UsG0JjEAv+Gkt5l5M9Q4LheBK3IbE82wE6ITb5dYX9O86mZYJH5k7U1Cmgw1Jyy7FOZZyaLi14Lc7sWCdYFTbk8MVt9RSdnLyVU4yBuCg+DTZVt5gZFetBLt8FNqtC2X5sD2/36W+U3zWSk5n5yiJKDm2u3Df4+lj8S/kkxoRoJPGfme7KEB8BHXohxh8ZQAOszNwCzT6CXG/8b9RXwlztjB3kC8UyDtp3WitfM6VTLsxom8jFLVR415my4U/PcXfInOls8FTlJ2vFh7PQed6sS425q5Uo05jNCFxJ+GlPSWlRgrl7MMXEmdA66VFsC5H31JHyfwkp1yp07QjYmaq8pliddCH1Sf00PIQIlpWNSjUZYiC7UJU4/GMTvhhF4sh6rQZF+qwZMR3rNowWrwXqP8kmLlqNztU7FQSBqpyUXRsUqpVaU6rml3o14uskR20h0KOEAp3P6T7zQTxoBTplJTHtJB69IqHfgpyTs5wbX8SJWXvaZ5rBt4VsIq4KjVxy1EK2365CD/OoIE1f1ArGFZwq7M/1sk5T0IHgUwx6uc2GsL6Qtw1nDCi5Up7/WlsPOs0969E0p+knpcPI6IIF58RgFi2U=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199021)(40470700004)(36840700001)(46966006)(2906002)(4744005)(81166007)(7416002)(356005)(5660300002)(82740400003)(70206006)(70586007)(8936002)(41300700001)(4326008)(8676002)(40460700003)(36860700001)(36756003)(110136005)(54906003)(316002)(83380400001)(2616005)(47076005)(82310400005)(426003)(336012)(86362001)(40480700001)(186003)(478600001)(6666004)(1076003)(26005)(103116003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 10:26:21.6625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abf21d48-a11d-4fed-e9db-08db342ddeb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E636.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock delay settings are not defined for 400KHz, so add frequency check
to skip calling the clock delay settings when frequency is <=400KHz.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index c3fecb8ba66e..d9a29c346745 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -413,7 +413,7 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 
 	/* Set the Input and Output Clock Phase Delays */
-	if (clk_data->set_clk_delays)
+	if (clk_data->set_clk_delays && clock > PHY_CLK_TOO_SLOW_HZ)
 		clk_data->set_clk_delays(host);
 
 	if (sdhci_arasan->internal_phy_reg && clock >= MIN_PHY_CLK_HZ) {
-- 
2.25.1

