Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA81373A4D0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjFVP0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjFVP0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:26:39 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9505D212F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:26:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2T7JvQSNWT8S/JpQE20/0jH60WuoMSgstAK6ZlkMY6KayRZfUMaXJwHBJ8Gs5TgS1iV3zwZasOG6Gm56mxDc2caY6+OXxnojErnuJDiOUn+bWPEs39OzZnl26htgnPcYrUHU5uGeBDeACuuZjjAhP8cFG/qsYFDyxdK/i+7KGxtzcBM6BPeF0/7pzyrJ7ZE7QZrLSVgIqR462lUDOfPp7++UROIRo3JW7iCUv13PHAPNp1UGsSM8+z8oAnExhFSoUriDIexaEC3AbpLRLTRzB9wZrB6aNUHY4iGGLO3fQPArOR4WPnHWeBDidvGEcsPkcQtdGugkeHGfhn6/SBLlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvCBKnW1XfiJYktEn5OXvrGZ5iyfve+4NEgu2JLMNvQ=;
 b=RFuO/k5Qt/SmJdeQWJsnubSoQkbgNjZ/rlP90stngDI3dnWwcCqZgrV83qpsilXxkAJGrwfSYqdnBx+t+hZnG/VVG5xi1YmZAwalZ+s0qFEgrxffPfjQaTKTBDvjoKZffGfqVRAMWkBWT/TBaqB9xye3MxIuwjboL8oLdeuT7FFEA2+PnycHgKRYJeURwRtY0yhZ5LopRoCnjzo2lO57JK3iiG6YwJeEvoYlmpRHF9C4pQgQSQ7xaCMZLxyfV1EBOaqjeFoSp/+RdfVfM4RcQSPHt2iznsvV7HFKnE9dNo1WG/DiEYXepChCuSP4ILiI69CCT9TgHvjRqIYdJwuw3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvCBKnW1XfiJYktEn5OXvrGZ5iyfve+4NEgu2JLMNvQ=;
 b=Y/uBczpcxLm4N3WGc4ZernV6i9BlkA3MDqbAFQ5WYfJMeFpR7zgoFVXADp42s733qfQjByWAU9chB0GeMzQJ013BfaKxrq0fuWPWe2bbNOrTgGEkFqX+L1TGP5VM0QvrhI3A0hZyNnciG59qdh4RwRRz7lAfaFD6lJG6LhG6TFI=
Received: from BY5PR04CA0029.namprd04.prod.outlook.com (2603:10b6:a03:1d0::39)
 by MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 22 Jun
 2023 15:26:16 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::23) by BY5PR04CA0029.outlook.office365.com
 (2603:10b6:a03:1d0::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Thu, 22 Jun 2023 15:26:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Thu, 22 Jun 2023 15:26:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:26:04 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:26:04 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 22 Jun 2023 10:26:00 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/11] ASoC: amd: acp: store platform device reference created in pci probe call
Date:   Thu, 22 Jun 2023 20:53:47 +0530
Message-ID: <20230622152406.3709231-10-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
References: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|MN0PR12MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b47fbb3-3eaa-4735-1b82-08db733504db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bGfl243QyBOZyzioI2Lz/nEh7X7WEvhoTBCSTRUGonr8gxDmyOmV6WC0ADzBEmHgzIsVrj1tYju9cQIYuRoL+YfPT2KR9+nI9/GLKhdY0UAIHrM6nvk9uGd3WehGrQC928SSu50VhQZ0tOfl98bRKNGbH0i9isWYTSKJ7/d5qNVJYpzc2KJEpyCbD3KA28ZEICYQ3mJzHE0+y4+2o3SIFxHnXySwIkGdONmQ2dIHgiQTkjwwBNA7rMFJCN1kDrPm53ACx9uZHtvtyZKKRx8cKvwWUAOAxZUtpuQPGunRgCiJ9MBzNZBoVwBvC7NckXVkrUVSLaCjn6QnOJQJ9dn62srQ4m2VENxT7Fj49++2VBkuiY+LjZkIZlz87N9nxFI1E6eGKcURZ0ajagtK8dHl6YDQ74i8ajDIUnVc4X2tQ1nYSLYe6IRuDhFdCPJy29ctPZfXx18pSB6sExMd5tDLHdC7p4mir2WAJHjhz4XjaI/Q7w5yt/csAiBHacqZy1IBc55pHxHVHi1YNDGYC8Ar2D1XVZ/r/CdVXtyeLvahO+rUwYES/vcxsfD9QYvCC1U+F8WzBMvGJ30+/S6LncefgviQsAzczuF9BH+tRdU00xggB+NBzfr7E79E/bT7QsUJ9G6sfVXA5+NN015bn6OWmb3SRzQIN6Lx0V5Oz02Ra87GNZSNM4BJ9NGOUlzWOinezhx5xtxzvBm3DRc0K++hUwH1NxIa9IysrapbUOJxZjf10AEyh4183TCn8hS5KwZOFXg0HeHzJvZ69zvyKEbdqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(36860700001)(2906002)(47076005)(1076003)(110136005)(6666004)(7696005)(54906003)(478600001)(336012)(83380400001)(186003)(2616005)(426003)(26005)(5660300002)(40460700003)(81166007)(36756003)(356005)(86362001)(70206006)(4326008)(82740400003)(40480700001)(70586007)(316002)(8676002)(8936002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:26:15.3423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b47fbb3-3eaa-4735-1b82-08db733504db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store the platform device reference created in pci driver,
it will be used in restoring the interrupts during system level resume.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp-pci.c | 2 +-
 sound/soc/amd/acp/amd.h     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index d3b2ccbe7fd8..0d91181364e3 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -141,7 +141,7 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		ret = PTR_ERR(pdev);
 		goto unregister_dmic_dev;
 	}
-
+	chip->chip_pdev = pdev;
 	return ret;
 
 unregister_dmic_dev:
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 0d8c0febbbfc..f53613216397 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -115,6 +115,7 @@ struct acp_chip_info {
 	char *name;		/* Platform name */
 	unsigned int acp_rev;	/* ACP Revision id */
 	void __iomem *base;	/* ACP memory PCI base */
+	struct platform_device *chip_pdev;
 };
 
 struct acp_stream {
-- 
2.25.1

