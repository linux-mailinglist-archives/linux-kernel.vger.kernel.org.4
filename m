Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9E8653517
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiLUR0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiLUR0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:26:33 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A06C6359
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:26:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eULAdynaDW5EFgAhehcCieQIu7dkUMRrYJTTrBUFP9ENlRaAnj6nZQP2R4k7ROcQM5SHhyZEqzgsVpLbKuy/H3dTHS2w8VF4xGBR4FFa5Xymnz590uphoxImvTEWcT0cwcyrs9ztN6dsetvsD1DfeW432HJ28M7rydmDCMcZ2QX2ROEUb4kEKZzjJCQ8UQJcwdA1zvria8Gkry9bhmQmyHDXtnthgyAuQblStJPz8FuqwTVDCQ9cTT8+ABPE6/hM5qzyX2RjZc5xcRTwUsXPyyPMCDu+fJ6acG5tTOIFvD0Rr9YvhauzYOr52lFSX9RbevFDz4z9BvypRwD3WzYplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1Wg2Sr8Um6WI5KE93rI10l+9dfj4VSJ5c4l8C3nJ/M=;
 b=eMsXshOR600Xqtu3ZlxrZa/gz7MMp92McyS3RZdHPT5h4lA3kKbdyO4Trg4JwuPpUnZFaqiyovEZsuJqzZL4AdKGSv6DqD1FAOl0ua5CsMfqeu99nXeSbNcIxmGmnNsVbU3k4ClzbuWlnjAbFLFEyoNh0Vb0gKmOycg+qzd/XvJAtWFKCFz3NF8G3+wL3VkEwoFiUBLt0mT1Xh2vgUENmGG5A3cU+b98QgJWMHpYtqSmyL737NrteHRCW9i6oF8rUOCpnIjm9z692S3oeQG8+q9J7FP7xF1xD7Q3KsK3mYN9U2AZ48QddcgKO3ZN1JDslUPg+g6ERNSMCEcgfcczaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1Wg2Sr8Um6WI5KE93rI10l+9dfj4VSJ5c4l8C3nJ/M=;
 b=ThE9TW1GkeoYz9AZWexwKufBj4dzwcO7NUWSHDKZgitfxf8C40lfUmrcvuUA2F9qwm5ZJQDHjmh+i7GnR0ENyLazokU2PH9LSdLlYPrNJPYvX8potzcxPnbda5DTzelh5TADYzV3uE59xDq0baX+OZzo7G/5b0CN9g9FwhOz0lg=
Received: from BN9PR03CA0521.namprd03.prod.outlook.com (2603:10b6:408:131::16)
 by MW4PR12MB5668.namprd12.prod.outlook.com (2603:10b6:303:16b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 17:26:30 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::30) by BN9PR03CA0521.outlook.office365.com
 (2603:10b6:408:131::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Wed, 21 Dec 2022 17:26:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.6 via Frontend Transport; Wed, 21 Dec 2022 17:26:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 21 Dec
 2022 11:26:29 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 21 Dec
 2022 11:26:29 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 21 Dec 2022 11:26:26 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 3/4] ASoC: amd: ps: update dev index value in irq handler
Date:   Wed, 21 Dec 2022 22:58:50 +0530
Message-ID: <20221221172855.1618766-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221221172855.1618766-1-Vijendar.Mukunda@amd.com>
References: <20221221172855.1618766-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|MW4PR12MB5668:EE_
X-MS-Office365-Filtering-Correlation-Id: f6eb4930-e27b-492e-fd28-08dae3787f46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xb4AJF33VVv8KMugtuWUqa887j3uyZ4bRHkuPjJbjCMP1GNQxBk5FjRlwwQuXB+sWECO0hTmf0umh6lK4tYStM285lTaYKoP2QmYy4jsHjz3QXd9cpr9C3dNCv15qijnRovynX5pl1Hh+16E4t5dqVkSP21BV2fO5nY20xztV2Y/UX+FAO0FlsZaIEkO/yBT04Ai/2NWwvNj2HAuk1VzSnZBkpwXiOTCOWPzpUWpBGyJUCXq5MeGRjSoCEufxmD2x6E+i3CNmw4Hj7KkoTgncFid/Zq0oyPTD/yvdLgpd0W5Y09SEFYjlsu8wPJuQW++VjiHhAT7JgEM7SnAVG3/qmHzwOfmgwplkUr6TyaywJwsJrV0+W9uIkv+nfpaxUvhlWfaubKeTim2MZm7LC5YQaBTroi9UhMkxvUZKDo2efzBOKvWKRqiB6Fq8lFlj9N+pElOmGq5Wxscn8xTiNVErcIObHKqqXTGSAHjCy5gkiLZ9t+5FOLcUPPbhJpAcveb4soa7n8WLUvCb1Joco+jpUxwTCRlSAi2fO0rLfcBz4iVHFslQmQtWtRvFqvCz+a9PtgejpqgC54yp8BPGUT7SJSvwk37uvS/68LR+3zmFSqdqx30OJhGEi+qUeBgEXIHaaBmCv9XftExZyRKdIe46ur4ffF1bueD6+/sRf6MOnkk/Q/8JwjEFn5mG0eWH7XndE7OnPEPEhk6ko4B+K9GorbDKVholZUSLLlNWds8mpw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(2906002)(40460700003)(316002)(54906003)(336012)(110136005)(36756003)(82310400005)(86362001)(36860700001)(1076003)(2616005)(83380400001)(47076005)(426003)(26005)(7696005)(81166007)(6666004)(478600001)(186003)(356005)(82740400003)(40480700001)(4326008)(8936002)(41300700001)(5660300002)(8676002)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 17:26:29.6817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6eb4930-e27b-492e-fd28-08dae3787f46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5668
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using hard coded index value for platform device index,
retrieve the device index based on platform devices created.
In PDM config case, ACP PCI driver retrieves dev index from
pdm_dev_index variable.
This will avoid overhead when multiple endpoint combinations
support is added later.
platform device index will vary based on audio endpoint
configuration.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/pci-ps.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 8ae7bdfb0e8c..4553e81da164 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -116,6 +116,7 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
 	struct acp63_dev_data *adata;
 	struct pdm_dev_data *ps_pdm_data;
 	u32 val;
+	u16 pdev_index;
 
 	adata = dev_id;
 	if (!adata)
@@ -123,7 +124,8 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
 
 	val = acp63_readl(adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
 	if (val & BIT(PDM_DMA_STAT)) {
-		ps_pdm_data = dev_get_drvdata(&adata->pdev[0]->dev);
+		pdev_index = adata->pdm_dev_index;
+		ps_pdm_data = dev_get_drvdata(&adata->pdev[pdev_index]->dev);
 		acp63_writel(BIT(PDM_DMA_STAT), adata->acp63_base + ACP_EXTERNAL_INTR_STAT);
 		if (ps_pdm_data->capture_stream)
 			snd_pcm_period_elapsed(ps_pdm_data->capture_stream);
-- 
2.34.1

