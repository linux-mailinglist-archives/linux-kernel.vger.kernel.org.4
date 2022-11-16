Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAAF62BB31
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbiKPLQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239128AbiKPLPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:15:51 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F7647312
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:03:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uj4ZOrTuNircQbX0rHmvtqSXXvg0Dg+F6TpRVhaTadE7IJr5O6Ugh+AJrwn1qwJ1XrVvMphhjJtiKL5K+4GYswqnS2bhOEDGWXCd0qTyNFTobVCUV+5TwI5GIYMyblIKddV0fexlvmoK7l7RJVp+0MyHCt+YrN3HcFGu7iqdRhiYqckDJglRgCtmOjqS9ScZkphug8cqT3K4VRSsNuTjFgCBmBecp8j5JwJhNS2WH3s1+bTKkT1kdeIwl6Gnz4DnLdG41T4bL1dqKeJAitvlEihWY8k2+86R6MPOonu+Mh5pp122U1Lf+OtdTnElzIN2sguyV93iVXWLx1FXMNx8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sU20L9RN8j09NNh2OKJPRj2hxIAk9x+Ju9Wo+bH/TA=;
 b=YoETkssfeOHucq8ELWWPmvuqzUzUAD45VTQCMcm2ZECovxGg3PLwjp6i121CQs+FOwm/w1M33uMi6pam3tCK2/ZpYgDMSvjRRkZvxxnXT/UAQ64b9RSXOCjLDGP533/82xV8J2feaiveZz3NOiQpw1xmsE4xSJlgM9HU88oCTGJwkUZQoH/cZwMMebt+iVNukNIDVCw+wJj7mcemMRdIQteVr4BJGArzzLskAyRfUO5hNlo+efD2enqVn2dEmuLDHHTgskpKaymcIL3dl5OElUeMKvZTI0BDDJSpnoUGv5Z6ciMrICyaTemxmsVxSwpFhZJHNRZKYSNi2cP0shUg5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sU20L9RN8j09NNh2OKJPRj2hxIAk9x+Ju9Wo+bH/TA=;
 b=RsucGj7IlovypHDTVW6VCnN53RQz0+jK+PFvbnpEtz6CvzTSoeGAqL51HQxRDOdwZclA4mrTc1RPMwukx8C237963pS6L4bIT7lmvHcVZV4ihXAqENmDXQIdvI4p+Qqygx2Gb7zVH5FVcQpsHQJVRql7hkjLpr/8ChKMWJkl3xg=
Received: from MW2PR2101CA0003.namprd21.prod.outlook.com (2603:10b6:302:1::16)
 by CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 11:03:07 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::77) by MW2PR2101CA0003.outlook.office365.com
 (2603:10b6:302:1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.5 via Frontend
 Transport; Wed, 16 Nov 2022 11:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Wed, 16 Nov 2022 11:03:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 16 Nov
 2022 05:03:04 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 16 Nov
 2022 05:03:04 -0600
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 16 Nov 2022 05:03:01 -0600
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ASoC: amd: ps: update macros with ps platform naming convention
Date:   Wed, 16 Nov 2022 16:29:22 +0530
Message-ID: <20221116105938.762550-1-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|CY5PR12MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d5e827-4189-47b5-75f7-08dac7c223f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g5fVxRcwM+WR9YlsjsnIV1+MzcrRDxia7ZoW75ew88M9R1JyMu5dZCan39/Sr8RFCPc6i03GAjAhANlQ+k80e3W3yZ3Fri7IRAtv7TAHnq78izWF6lCCbm4UAJV4gvUx6CyyYaZKd2j7W9UDz2SR2wXO83vA1ZEaV3SHWw6KVL4kGOUqZ6yDO+zjGy+q1vmm1GbleBFQWpWzCaWUlpkySrSUdkM51R3R18eTvZpgiuMoiaHgcgEJq34EZQyxbeU7frj0KR+E3tRIR0t4RZJeua1m3BXyEjCIJgO526HfINzfdWzS5vtIJmB+bB5m1qwbeRCCe/eZzGDUgbJmCPNh+ESC5OEuJ7e39OQxK30kVaYjnWRJkD+SfKXHTbNoaEGldAReJh/QEByZ/yponX1Kus073hE93hV20+W0FQ6ng/sss6b3eK+WszJSXN7yNd8gs4kuEpRSfR2v3ylz5Se1/tuEid2qO9oCfBVs33opM7mI7AcC/OI2dKGgqsmTrCKjfGwWH1/XY0rgngu+9enLoQG8rTWVyU5jxTH7HxgOjkmDQG3eX4RHE4d4W4d77W8muw016UNAoeGe4zqMpk+lsnDZLOwBKKYeh/rmbfopiTvIbMvaSx7NxEZSmYvqA1aByiKHFFJ1p8PW49b9evWO/DWoO6/l3AXPfZbXtTcSWqkeJ65UPoTK8fEwz9YIMnyFdYc50q9GmrOAw+aTKiWxyGYN5mK9liSPyr6tJHR8UFeIuPDjS31VYNqkI+haoWy62kxFg8K3rXYI+/XpG3xXf80jjumf3vxEu5xB3i4NRkjLBxzb1/07B5wW/OB+sLXZ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199015)(36840700001)(40470700004)(46966006)(356005)(81166007)(2616005)(54906003)(40480700001)(316002)(40460700003)(36756003)(6666004)(110136005)(7696005)(4326008)(8676002)(70586007)(26005)(41300700001)(70206006)(86362001)(47076005)(426003)(82310400005)(2906002)(83380400001)(15650500001)(186003)(82740400003)(1076003)(336012)(5660300002)(8936002)(478600001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 11:03:06.5484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d5e827-4189-47b5-75f7-08dac7c223f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update macros using ps platform naming convention.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/ps/acp63.h  |  8 ++++----
 sound/soc/amd/ps/pci-ps.c | 14 +++++++-------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 85f869c2229f..a90ba3b20dc7 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -8,10 +8,10 @@
 #include <sound/acp63_chip_offset_byte.h>
 
 #define ACP_DEVICE_ID 0x15E2
-#define ACP6x_REG_START		0x1240000
-#define ACP6x_REG_END		0x1250200
-#define ACP6x_DEVS		3
-#define ACP6x_PDM_MODE		1
+#define ACP63_REG_START		0x1240000
+#define ACP63_REG_END		0x1250200
+#define ACP63_DEVS		3
+#define ACP63_PDM_MODE		1
 
 #define ACP_SOFT_RESET_SOFTRESET_AUDDONE_MASK	0x00010001
 #define ACP_PGFSM_CNTL_POWER_ON_MASK	1
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 08c4b9bef055..98dddd1a0cf4 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -21,7 +21,7 @@ struct acp63_dev_data {
 	void __iomem *acp63_base;
 	struct resource *res;
 	bool acp63_audio_mode;
-	struct platform_device *pdev[ACP6x_DEVS];
+	struct platform_device *pdev[ACP63_DEVS];
 };
 
 static int acp63_power_on(void __iomem *acp_base)
@@ -143,7 +143,7 @@ static int snd_acp63_probe(struct pci_dev *pci,
 			   const struct pci_device_id *pci_id)
 {
 	struct acp63_dev_data *adata;
-	struct platform_device_info pdevinfo[ACP6x_DEVS];
+	struct platform_device_info pdevinfo[ACP63_DEVS];
 	int index, ret;
 	int val = 0x00;
 	struct acpi_device *adev;
@@ -219,8 +219,8 @@ static int snd_acp63_probe(struct pci_dev *pci,
 			adata->res->name = "acp_iomem";
 			adata->res->flags = IORESOURCE_MEM;
 			adata->res->start = addr;
-			adata->res->end = addr + (ACP6x_REG_END - ACP6x_REG_START);
-			adata->acp63_audio_mode = ACP6x_PDM_MODE;
+			adata->res->end = addr + (ACP63_REG_END - ACP63_REG_START);
+			adata->acp63_audio_mode = ACP63_PDM_MODE;
 
 			memset(&pdevinfo, 0, sizeof(pdevinfo));
 			pdevinfo[0].name = "acp_ps_pdm_dma";
@@ -237,7 +237,7 @@ static int snd_acp63_probe(struct pci_dev *pci,
 			pdevinfo[2].id = 0;
 			pdevinfo[2].parent = &pci->dev;
 
-			for (index = 0; index < ACP6x_DEVS; index++) {
+			for (index = 0; index < ACP63_DEVS; index++) {
 				adata->pdev[index] =
 					platform_device_register_full(&pdevinfo[index]);
 
@@ -312,8 +312,8 @@ static void snd_acp63_remove(struct pci_dev *pci)
 	int ret, index;
 
 	adata = pci_get_drvdata(pci);
-	if (adata->acp63_audio_mode == ACP6x_PDM_MODE) {
-		for (index = 0; index < ACP6x_DEVS; index++)
+	if (adata->acp63_audio_mode == ACP63_PDM_MODE) {
+		for (index = 0; index < ACP63_DEVS; index++)
 			platform_device_unregister(adata->pdev[index]);
 	}
 	ret = acp63_deinit(adata->acp63_base, &pci->dev);
-- 
2.25.1

