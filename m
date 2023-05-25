Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A7A710AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240565AbjEYLZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240311AbjEYLZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:25:08 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FBF1AB
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 04:25:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZOiKk/649LXIRdS9EEHzpGbVmzZ6IMgIXLnEVPD9csMjqZqwC+V/TFKUJUEPQ4zsu9B5luqGJnydz8q+EFhHWeKcr4Sp4no2m3NvQRlC264F8HNL3t+ZnAxckG6Jr5M+aoIUG03gNBle5N5NC1jl+2Y6AOl+Ld59loopOvwQDQP6pMkhn6F/I/4qotiyYDX7ZiGyHRIiCXECdfe2p8RAbvTcT5z98jef78IfF+fob5SsHk9kqrADsn6ALqlN6M8X/JQ7gcXrxQC7EKKmwngJlBhiCQ6B4HjsG7GBFDdjYq+S7+P9w1XmRO4R45eowLRCGeyPJFKwckmP2kZqMcFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLsEbhoWS7fzniBAl/0fEaIPombo+keItzi4f2MVq6s=;
 b=QbkSQ4ivy7rkRLwbdOkLD+ZWzKWZ4ouqQkZtBltDEyW9UhGNi4mWjwKS0JXxocrx6pFCvu7R3eye93PdIAfMK/GREeidNZ+4KA+skogAxm5bQqval7uEOKIOiJ2y4O9RkGilXUz63T6rASPYJzjtri1z3M1Fwn18Og2i6gwVfuA3FvTUs7TLj1+jmI9nxM2XCF2bj3pY37KpnItKPl3XmWDWJ+oyUV9gS81Q6Tos+0by3EGRfYOZKfhaaj7ndx6BwktSVFALbMJeVYoWkRkDbeJuuYQrEuHfsjOb/+bYpggQmjuaNvY45gHs260JW0rDZmoVFLALotmKp3/1S+Mp4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLsEbhoWS7fzniBAl/0fEaIPombo+keItzi4f2MVq6s=;
 b=frC3SPyleup2Xiiyf3nJaCNqdYsimgy8WNVdXKfIFPfkCAqWvR45K1kS44lplDF1T2gnsXfqFU07p82b99aWgJXXqWJcaVZKe9IVdsj78QYj+b6bFQSfvrWc27p3T9JFED3hCc0TfQWv23o3K/7aKbYUZnG7eiIAn+n0b1d5080=
Received: from BLAPR03CA0051.namprd03.prod.outlook.com (2603:10b6:208:32d::26)
 by DS0PR12MB7972.namprd12.prod.outlook.com (2603:10b6:8:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Thu, 25 May
 2023 11:25:03 +0000
Received: from BL02EPF000145BA.namprd05.prod.outlook.com
 (2603:10b6:208:32d:cafe::2f) by BLAPR03CA0051.outlook.office365.com
 (2603:10b6:208:32d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18 via Frontend
 Transport; Thu, 25 May 2023 11:25:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF000145BA.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.7 via Frontend Transport; Thu, 25 May 2023 11:25:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 25 May
 2023 06:25:02 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Thu, 25 May 2023 06:24:58 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <pierre-louis.bossart@linux.intel.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        <mario.limonciello@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: ps: fix for acp_lock access in pdm driver
Date:   Thu, 25 May 2023 16:59:55 +0530
Message-ID: <20230525113000.1290758-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BA:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: a859d088-cf7b-46a6-38fe-08db5d12af1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lH8X/XDgMPJJrghL9J0IqW5g96PZujMjxtWTDWpJSkn4if6vjH09W61Di7DcKVYQbgBVJBQKfCkYZPtK957OaILyaC/gM4gQB4O9P2wIqG4QBBCgZzHj99kNVUFVWrjzdwhG0t2MygXKCnYJCVurx5A3uEy/F8O5rYgl3Qq1j2tg1ceDWfSpbK3g9D5k8Hv+c7X+cu8dF352GR6ttlo4a4TSjcWOPK1JeIZiggdmlkBZHPnNbWssX5KuhXDtMHM+8y2O5r8pjhzmHoSZ9t3kEIMMNh0kYnao+JwC2HFIKEMnHA/4TC3KLP6kERsKnIUW2Ij03ohqinD911yMg40epRLYp32GBd8gbbpMcdAgA8gQtn87BB4tiRUziGjmUMQGpD9lSr5ZxJXj0PumAlOb6EU/j5hxUyEUDc30kZ8hZRDf+yuJ5iBvEEr9fHDUR7WLMDozK+jWM9UonfWFVQlskXop7O7AXeLVzK8y7FLFqBIrZcsetgJjiaTwp9oLt1jmmUs2k5e7+be9lv4+UWe81QKmZJMXlTuBtfmwM/FtjN9LB2o5Ji8w7F13hFX2VdK184YSxw0buI12dzFQnoGxkPmwlBVsgNZlv0aH9PeKdP6JJELIgT/4d8z5pt8eb/5ZU4hIC3cJy6wLfqUKL3dtWN8B2xEcAKvg9QaZ95lyLHOLanKin7I5YRHuSS5TNJ5uunEzDwvYUc8wPAzLT3BiTgyq5EDzb/2OXJc9bf3K1XJSwzPfwRBipa+fHbgtr3mBGb83AYFJWUxfxuyAQg+C6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(6666004)(7696005)(40460700003)(41300700001)(26005)(1076003)(8676002)(8936002)(5660300002)(36756003)(36860700001)(2616005)(47076005)(82310400005)(83380400001)(2906002)(426003)(336012)(186003)(86362001)(356005)(81166007)(40480700001)(82740400003)(6916009)(4326008)(70586007)(70206006)(54906003)(478600001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 11:25:03.1245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a859d088-cf7b-46a6-38fe-08db5d12af1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sending the mutex address(acp_lock) as platform
data during ACP PDM platform driver register sequence,
its creating copy of the platform data.
Referencing this platform data in ACP PDM driver results
incorrect reference to the common lock usage.

Instead of directly passing the lock address as platform
data, retrieve it from parent driver data structure
and use the same lock reference in ACP PDM driver.

Fixes: 45aa83cb9388 ("ASoC: amd: ps: use acp_lock to protect common registers in pdm driver")

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/pci-ps.c     |  3 +--
 sound/soc/amd/ps/ps-pdm-dma.c | 10 +++++-----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index c957718abefc..54752d6040d6 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -198,8 +198,7 @@ static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data
 	case ACP63_PDM_DEV_MASK:
 		adata->pdm_dev_index  = 0;
 		acp63_fill_platform_dev_info(&pdevinfo[0], parent, NULL, "acp_ps_pdm_dma",
-					     0, adata->res, 1, &adata->acp_lock,
-					     sizeof(adata->acp_lock));
+					     0, adata->res, 1, NULL, 0);
 		acp63_fill_platform_dev_info(&pdevinfo[1], parent, NULL, "dmic-codec",
 					     0, NULL, 0, NULL, 0);
 		acp63_fill_platform_dev_info(&pdevinfo[2], parent, NULL, "acp_ps_mach",
diff --git a/sound/soc/amd/ps/ps-pdm-dma.c b/sound/soc/amd/ps/ps-pdm-dma.c
index 3ecc6cf3fd34..bdbbb797c74d 100644
--- a/sound/soc/amd/ps/ps-pdm-dma.c
+++ b/sound/soc/amd/ps/ps-pdm-dma.c
@@ -358,12 +358,12 @@ static int acp63_pdm_audio_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct pdm_dev_data *adata;
+	struct acp63_dev_data *acp_data;
+	struct device *parent;
 	int status;
 
-	if (!pdev->dev.platform_data) {
-		dev_err(&pdev->dev, "platform_data not retrieved\n");
-		return -ENODEV;
-	}
+	parent = pdev->dev.parent;
+	acp_data = dev_get_drvdata(parent);
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
@@ -379,7 +379,7 @@ static int acp63_pdm_audio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	adata->capture_stream = NULL;
-	adata->acp_lock = pdev->dev.platform_data;
+	adata->acp_lock = &acp_data->acp_lock;
 	dev_set_drvdata(&pdev->dev, adata);
 	status = devm_snd_soc_register_component(&pdev->dev,
 						 &acp63_pdm_component,
-- 
2.34.1

