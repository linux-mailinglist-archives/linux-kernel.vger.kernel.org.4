Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72312653028
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 12:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiLULYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 06:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbiLULYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 06:24:01 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F40422B2F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 03:23:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bj+sfpgWiowUCszZS/jo3DV0ikU24QuaiIvzVbW2Ye/FcAAvah4JWvHRb0n3Zv3DeyiHF1jhxfpuqaG/95uYGCKkiRmHkt0aW5hUyhrQj5PW8Wr/kQ8tOe05BEkLRYGBeIccHPly4FoMp3pGj2oYppRe3DWFAmpPQVuXf2p6GHYrXpDGc5C1lqObNjZ3mHtQEAS1JEAtR03+VmeRVjvfr/HnxLXxHI4K9Z93nZDEiE5UTD8Tx+MbhMl9tEtZRG4jLMqTqVUpp3feDbq55b9S/YRCbxv1cE3vQh5w7VF1/3cl/WfDKrgLDOVqZ5xdbm4sk/NFUuoIVYBwVGnrg9OmGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaXirGc4eefVb9eOXcEIZCUFJnxvbTNszCNokeXLiQw=;
 b=U6b3EVOOV52G/m6hp4jnRAh4RzyZQbQ8Zt3JhEn4oqvCzPoWTBKvryrSt4r17iZQ0feadpdDh9Gi5USCD0IuyKnb2Wd5DrpuTunUBTKYaBbr3W1uF/88Jf6jddql6B7BOIAG0g6dJkmPwxi5G1IlAQMzsXauCgSapkBPejs5YjGPfjBWGPe1zaHIFJFj6B3op/jsN6hnMYAZPEUfmFSzb6prOEId7iVZSMFqkTwDcvyar7yQkW1yIYc+7FYPeLneR+IQ4xXkC2/CRMYHdGPxvVLeE8j0Tbe+ASOrMTSbbLMF9HlvglvqZp4j3jMsRq4kuZnLuYeeIHagVTTNX08hxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaXirGc4eefVb9eOXcEIZCUFJnxvbTNszCNokeXLiQw=;
 b=vSkjp6FNEYVyuHf2Y0C6SNDoZKk1jqu2m4hMVpISu55H/dNRh2ndRxzdDH8KwmT8xZT4VEXBNWVgh2tQsP216Hyvh+4pJQDjuX11o9dcbdh8G6looDcRjLjpzt1Q+pf+Hnv/SYCjzZtY63a/S7yyPjFoaKW2CnMegSJQAacnHRQ=
Received: from MW3PR06CA0019.namprd06.prod.outlook.com (2603:10b6:303:2a::24)
 by DM6PR12MB4880.namprd12.prod.outlook.com (2603:10b6:5:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 11:23:53 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::1d) by MW3PR06CA0019.outlook.office365.com
 (2603:10b6:303:2a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19 via Frontend
 Transport; Wed, 21 Dec 2022 11:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.6 via Frontend Transport; Wed, 21 Dec 2022 11:23:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 21 Dec
 2022 05:23:49 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 21 Dec 2022 05:23:46 -0600
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
Subject: [PATCH v2 3/4] ASoC: amd: ps: update dev index value in irq handler
Date:   Wed, 21 Dec 2022 16:56:05 +0530
Message-ID: <20221221112611.1373278-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221221112611.1373278-1-Vijendar.Mukunda@amd.com>
References: <20221221112611.1373278-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|DM6PR12MB4880:EE_
X-MS-Office365-Filtering-Correlation-Id: dead2501-9f48-4ff2-0ec7-08dae345d74a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IRFH5ZJ/F9n+DaxwixZw1N2PwbikgC5UTsp+bKSROg/ugo34BQwCs5CL3xW7oqcpz2OKDpGFLXw3bu2vh2+3Jele7HE88ed6DegJ/AnspAZrGSy8/FC5SQEyG7zECSXTRe/Cg05qFWybT0TnOcQlT1P82wbirU3jWxo6UUxF1th0F3smWgHwnZuCMK7O6GxS51cAfZHKpwosdGfYt85LeAjhCuM0B4i1HdpFU9Z4NR8cTZ5U5CUQJZTO6/4zQ/mDDsgRk+K8BfW+X3s02hZlWtT4bTCOQso4PfxGWf4zwNDHW326ys5E9CvYfq2kq8oeUktf1I5NRFgehEptqLwrXgw1h1cmu6QUM0d8HUz76g81iAlvl+MhXpyZ8/VQeF+ip+kjYjhAdiSpEoxcApIS+yyphsuL0blQmfx1b1+Fzyc6BYehG50gfiN+lIfN0jRR/U0TAIhRrceDpddVuq5npdpTZmw992klSh18TQ1K5FQ0Dlpg3YbAWsJDMg+e0am0RXd4uTSyhUZ9s9Kp4eoZRybx97tTKACo1cXP4BPjXIjfXh2j2rTrQ11nHoGK0wOb8ckMsg14hFEDd1SgxajpsO0ktGUPJInJrlXoIaDBz5sk8C3mN3ZDQBarVRNZkN3p9f5vuSK5PmxSJVwhR4QxMlVyAk6NDguPXUoH4fJEqidPmrU6uD5ZdFum5e5ifdZhb5d8E6JaCBcsOO+4cMu3iQGZ+MPj3gQvXKfmA+tNStc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(36840700001)(40470700004)(46966006)(82740400003)(81166007)(2906002)(356005)(40480700001)(5660300002)(41300700001)(83380400001)(47076005)(426003)(1076003)(4326008)(70206006)(8676002)(36860700001)(316002)(70586007)(336012)(8936002)(36756003)(26005)(82310400005)(2616005)(40460700003)(186003)(86362001)(54906003)(478600001)(110136005)(7696005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 11:23:52.8987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dead2501-9f48-4ff2-0ec7-08dae345d74a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4880
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
index 3033185ea39c..b3628fbfdafd 100644
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

