Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347126656AE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjAKJBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbjAKJAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:00:37 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F831182F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:00:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4ULlrqJG/HOndwY7X7NxLaBCwc0lJJKOP0lRjQchP2HmRjQ6Gz0UR8X/qyyAe/O0E3gBotIk23cafM69FM7ZgK0zxoMrG/W/LiKTj88Tzhk8Voi1ns/q3dH8drvPiIdLMdJDj9wJbTA+mSTQXMHcte8Piu54IitJGtuFAbs1u09xq5nms44L11gZHojDdHrjjP4Ln+7fY5hR13YIkJp2D4MOXBzvnt1wS5aWE2RDpw0hWT9noHVAuZ8mbPmRbJSOokhFzxEYir3E9rVwy3JVshZ6DZY5x8qOIcyX+XbnZEna2oXZ7VMzr3M33SQb6jwEhERdh5zr68cCgJJ5nioiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vvE2mbcKlRVFfBTVxCk+9aTWFLPfhBR/Se/X0V+Gd2E=;
 b=EVE7HeIbU5ZYfWoeGsrj9+HIb/F8ZBARAGblLuBnGHXldyOYG0xQ16XfGcaCDXKXij0rLvSXT+cKpqDrVWu9UECTmPyJ8hKcjxKt2GoEmtZlnGmCBxD3oqGQWb8pQ4kULMFtvwNsLC1yJedJDrPyjlCsr9c8HrwwQf1kdJB9cQfXjKP4D1nGc7QnMhZjopr15i4CBZI/vjIRpjmTDadfmnnkOyL5GjwBhF6xKopF/q1ljOjgi7+FQ1wqfr4p79TuHXwku0fnuOuTtsP2DQrlTdNZcOrflfbvHt9Rpnwbaebg1N6XqhJp2Fb/4TmvyKKZdLoqi9zDsSfhCck67vNqAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvE2mbcKlRVFfBTVxCk+9aTWFLPfhBR/Se/X0V+Gd2E=;
 b=pPRsvFqmrktub1Md34BWTVC0idx86I+HPj9pgrdqJBTvv6/E0x0b9k2jtDlcrT9djYooJPYUvWomtr39a0IETVNmP/oJ23yr2obSm01ebSJjJ99UsaDzqshtyuPgWTxT2JTXIA3WyzK1GA1v8zXgPiwrAFZXkV2b64SNFMACAI0=
Received: from DM6PR03CA0007.namprd03.prod.outlook.com (2603:10b6:5:40::20) by
 DM4PR12MB6613.namprd12.prod.outlook.com (2603:10b6:8:b8::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Wed, 11 Jan 2023 09:00:32 +0000
Received: from DS1PEPF0000B073.namprd05.prod.outlook.com
 (2603:10b6:5:40:cafe::99) by DM6PR03CA0007.outlook.office365.com
 (2603:10b6:5:40::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Wed, 11 Jan 2023 09:00:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B073.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Wed, 11 Jan 2023 09:00:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 03:00:28 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 03:00:28 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 11 Jan 2023 03:00:24 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <vkoul@kernel.org>,
        <alsa-devel@alsa-project.org>
CC:     <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>, <Mastan.Katragadda@amd.com>,
        <arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 07/19] ASoC: amd: ps: add soundwire dma driver for pink sardine platform
Date:   Wed, 11 Jan 2023 14:32:10 +0530
Message-ID: <20230111090222.2016499-8-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B073:EE_|DM4PR12MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 16eb6858-0e18-46f4-d62d-08daf3b24bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nvd5OagH98mdx1YfQQh0VlTT2VH99Ct55sLL2FCSnj7qBDiOkMprKb0orc9/PRatQSuyDF6EMGtzTUWGa3uA6c5SjV2nOmSz1q+foVf9i9wHbNqcKNLfBeb4xI+8PgKDzs1d9W1AfDAy9D6UXxAxErD/racy4aW6adg6lbrM0WY2Fdx4J8QAtX6ka3iwxFFnHsE6Vv/z7kuwlieCFtrtHSpZOF9RN2G89NAXpQq/UKcla/0SeqdGALtjOieWxsZi1Fu1CDYW+bhoaDEfxUkwpwwpmTCgSweNd81ZzjSEHYgvqc/bPrkeqwOkfbd7xtlFac3SE5lY3AFNTSbccbI8HqRyOcsFphWENwhzUHyAz7kVOi+F9S1masgR99lUJG1RRjz7HHi2CUp+ofOLZRSmnCVqB76MQQwkipTPbMJC8J51Wii4wgdJXhH8gIvO5YGqw2dMOLtGrXnmlj4mBaZ5H4W+f1RpTJXZdEkFB1AMHaB7g2LhNSTTHQ8BIBjy3s3Ih2tbx2OORJTLUbT0cVV5uLusEtcM1E8QmgfmL8LrH9Pqpd5L6r+xCDGZ8tRlxBV2fc+PNsHP/qBEf2wGotnE+zku/uWS4aop1hVoasPPXNDNGnJ5mtwlOdaMt1qLsg3wtRzQbeP4OH4Y9ID2XI33C+c6pzNtlkXLULoiykqm6SvfU4SstLm1eiY2Rk+8jVwHMGNEFKrXxzxd+UGK9EUn029ZubfKvF0eOyKTtt/BOZA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(36840700001)(46966006)(40470700004)(2906002)(82310400005)(47076005)(83380400001)(336012)(36860700001)(426003)(81166007)(7696005)(2616005)(1076003)(40480700001)(5660300002)(8936002)(6666004)(36756003)(186003)(26005)(478600001)(70586007)(70206006)(8676002)(54906003)(110136005)(41300700001)(86362001)(356005)(316002)(4326008)(40460700003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 09:00:32.4755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16eb6858-0e18-46f4-d62d-08daf3b24bac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B073.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6613
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Soundwire DMA platform driver binds to the platform device created by
ACP PCI device. Soundwire DMA driver registers ALSA DMA component
with ASoC framework.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h      |  5 +++
 sound/soc/amd/ps/ps-sdw-dma.c | 72 +++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 sound/soc/amd/ps/ps-sdw-dma.c

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 0bd9dc363461..b462320fdf2a 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -135,3 +135,8 @@ struct acp63_dev_data {
 	bool is_sdw_dev;
 	bool acp_sdw_power_off;
 };
+
+struct sdw_dma_dev_data {
+	void __iomem *acp_base;
+	struct mutex *acp_lock;
+};
diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
new file mode 100644
index 000000000000..388a4b7df715
--- /dev/null
+++ b/sound/soc/amd/ps/ps-sdw-dma.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AMD ALSA SoC Pink Sardine Soundwire DMA Driver
+ *
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+#include "acp63.h"
+
+#define DRV_NAME "amd_ps_sdw_dma"
+
+static const struct snd_soc_component_driver acp63_sdw_component = {
+	.name		= DRV_NAME,
+};
+
+static int acp63_sdw_platform_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct sdw_dma_dev_data *sdw_data;
+	int status;
+
+	if (!pdev->dev.platform_data) {
+		dev_err(&pdev->dev, "platform_data not retrieved\n");
+		return -ENODEV;
+	}
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
+		return -ENODEV;
+	}
+
+	sdw_data = devm_kzalloc(&pdev->dev, sizeof(*sdw_data), GFP_KERNEL);
+	if (!sdw_data)
+		return -ENOMEM;
+
+	sdw_data->acp_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!sdw_data->acp_base)
+		return -ENOMEM;
+
+	sdw_data->acp_lock = pdev->dev.platform_data;
+	dev_set_drvdata(&pdev->dev, sdw_data);
+	status = devm_snd_soc_register_component(&pdev->dev,
+						 &acp63_sdw_component,
+						 NULL, 0);
+	if (status) {
+		dev_err(&pdev->dev, "Fail to register acp pdm dai\n");
+
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static struct platform_driver acp63_sdw_dma_driver = {
+	.probe = acp63_sdw_platform_probe,
+	.driver = {
+		.name = "amd_ps_sdw_dma",
+	},
+};
+
+module_platform_driver(acp63_sdw_dma_driver);
+
+MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
+MODULE_DESCRIPTION("AMD ACP6.3 PS SDW DMA Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.34.1

