Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEA472BE95
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjFLKQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbjFLKPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:15:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397DB4C22
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:56:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqWnKjhEmLS02nigvZnancpDuvjhzU7VYgJMOytYTmVdBgW6FujLHP3FYxoiSuAdPSXIF39YkET/qh17qC85ttmETUVuZB2VjpMQ5VFn7cEOGZGkXRzGeg2DLKMkmlmyKxVc9rJPX9GMMVRfwO5AUHEzozt5eZRSv7sZi+4XO4Vhz/BwCRyWUhCkHIxbohD3nFhoSycV7z65a/ZmpcJ8l40YaYv0F1rXWD6Gm2jDlcBgZgsdJBQhyIYb2FoQJCCSBoda4UqHCy+hXnEMz5OpL4+Ys1iqZlTU27tnf2Mdw7Rts5u5LYIffVkkV+lsIHM9uBvxAhMbqPMC6ujkRoDA2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inpX2LjsuHMkWbSLnz82y1+NSnshQjmZxdZ+pLLDCEc=;
 b=TnPB6fQYeOJ/seOcrNK6xyHPqeISBey3H5ts4g2Qpdbn1Ke2jbfrTBWjGdxI131XpSU2Sq0reCE0kfzYtgGNfgfpS06uQ0BsFhaxcvUfs0kaQj56DWa57bBdpOWtZgmQ3ttVL20ZNDhjLtiGhseeSRpwEDbjhvVfxNDMRDYfYCtFNukB/mImR0XctnsnTszVM+5qLHyKaDznnkXCMMzNLsGzk6qAQADpdcjMVHxLZqnDJIuMp/MtQspMDohfX37ceO2oxTEeKtlkVZyGoD2XrxO0jo36WVCWvvq3b7xZs27i2Dze3zPWigr9NAHv+VFLqUEKnIXlud4TqFdpheGasA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inpX2LjsuHMkWbSLnz82y1+NSnshQjmZxdZ+pLLDCEc=;
 b=kNLrYMeqgwgter723WfqeBCNr06nJMbjMcR/aYlXR3Om9zFQGMfHsGAMdQ0BytvBVpPyRMEF6HItD0g2XF+tnBWXG6hHjSdt2s/hpU626Zj01tzUNybU7NzxFfMdm+O6PrexLr8bUK9Q2Qku/bhyfmQXSwL0L1S+3ttzdYuIsNY=
Received: from CY8PR10CA0008.namprd10.prod.outlook.com (2603:10b6:930:4f::17)
 by SJ2PR12MB8649.namprd12.prod.outlook.com (2603:10b6:a03:53c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Mon, 12 Jun
 2023 09:56:16 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:4f:cafe::16) by CY8PR10CA0008.outlook.office365.com
 (2603:10b6:930:4f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.34 via Frontend
 Transport; Mon, 12 Jun 2023 09:56:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Mon, 12 Jun 2023 09:56:16 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 04:56:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 12 Jun
 2023 02:55:47 -0700
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Mon, 12 Jun 2023 04:55:43 -0500
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
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V4 9/9] ASoC: amd: ps: add acp_reset flag check in acp pci driver pm ops.
Date:   Mon, 12 Jun 2023 15:29:03 +0530
Message-ID: <20230612095903.2113464-10-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612095903.2113464-1-Vijendar.Mukunda@amd.com>
References: <20230612095903.2113464-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|SJ2PR12MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: c10dad78-bf12-4a54-78a6-08db6b2b4372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 728Q2gib57Dk0YkIcDHu8WMNSKOjxbv4gItGDeOQfz0Tck3HnqXLncSba1RRPlGVQL54OnLlobZvv699HYWHxM7NaLfdGfmbUqPrKjMukVCJyawxBcbzlm3mPyCR3hXIBkWjQL/pYnhpgoY0nUMRR8d2oDaLzinRDRx16uDcbET66Nn61mhNI7uHLLgc8VSHPUZGUXmow25PN19nkTzhnSCr8fQCbaMecb2L6NPzvtEtCxQ0O0Cu5PUazUKqVnEzJ+/1GDN4KLSklsjBRmD1Fu/escdcPm5hpvUx92xml5PmnE5CYPzBAScJJB6h/PNnoyn92OiLLdS7Wod3MpSaSz9WluRUDVE0KaOqjXjjWUSm2j+WqsA+T/M3XiTu+CRCCpSv7Vi2eHHHbyRBXOZEFGIzxWnlVgL38YUyT6JroK1Cln6UxpW5YgrIMrtdn/TW+jK7XjbBPpbGxTgEI+aHG5Re+6pay8nNH7wjH0lOzFZ6RrfWSuEFX4PyiGlE6exMiM7+UVxQOUfTPrm+KksjTMLYCSQ8iBZgyj1FvUpaC5CmQcTzc95fpRYqt6K3cAqhr2NhnkR+UH+QzWxfE5ik1eOUe8jxIpxh24II9davwh4afpezbmb+HNB0whySqwVEx0uwG5vs+myGPJr7HDE3jlGWsULwHnhL72u3zUqF2HCoIb9gOgqxazhFg/l9kda44MA6AhwhQiCLhKBTTD6iP3ic2VIjnKEtR6AzXHuP0GOqKxn8oRMq9QqKkpGYzXEwC7y6m/EXxjJWcN5O1f+dxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199021)(40470700004)(36840700001)(46966006)(478600001)(70586007)(356005)(81166007)(82740400003)(36756003)(70206006)(4326008)(6916009)(54906003)(8936002)(8676002)(40480700001)(86362001)(5660300002)(2906002)(316002)(41300700001)(83380400001)(40460700003)(2616005)(336012)(426003)(47076005)(1076003)(26005)(186003)(6666004)(36860700001)(7696005)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 09:56:16.0523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c10dad78-bf12-4a54-78a6-08db6b2b4372
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8649
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD SoundWire manager supports different power modes.
acp_reset flag will be set to false only when SoundWire manager power
mode is selected as ClockStop Mode. For rest of the combinations
(ACP PDM + SDW), acp_reset flag will be set to true.
When acp_reset flag is set, acp de-init and acp init sequence should
be invoked during suspend/resume callbacks.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/pci-ps.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index ff734a90951b..5b46dc8573f8 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -669,24 +669,28 @@ static int snd_acp63_probe(struct pci_dev *pci,
 static int __maybe_unused snd_acp63_suspend(struct device *dev)
 {
 	struct acp63_dev_data *adata;
-	int ret;
+	int ret = 0;
 
 	adata = dev_get_drvdata(dev);
-	ret = acp63_deinit(adata->acp63_base, dev);
-	if (ret)
-		dev_err(dev, "ACP de-init failed\n");
+	if (adata->acp_reset) {
+		ret = acp63_deinit(adata->acp63_base, dev);
+		if (ret)
+			dev_err(dev, "ACP de-init failed\n");
+	}
 	return ret;
 }
 
 static int __maybe_unused snd_acp63_resume(struct device *dev)
 {
 	struct acp63_dev_data *adata;
-	int ret;
+	int ret = 0;
 
 	adata = dev_get_drvdata(dev);
-	ret = acp63_init(adata->acp63_base, dev);
-	if (ret)
-		dev_err(dev, "ACP init failed\n");
+	if (adata->acp_reset) {
+		ret = acp63_init(adata->acp63_base, dev);
+		if (ret)
+			dev_err(dev, "ACP init failed\n");
+	}
 	return ret;
 }
 
-- 
2.34.1

