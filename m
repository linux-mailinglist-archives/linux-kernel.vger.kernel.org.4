Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0279F70D4CE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbjEWHVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbjEWHUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:20:41 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37813E4D
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:20:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hacpQPtZP8556wMVW868BVJDEuMlqcckUP7mm3WZccn6arawEYJjqEbVKtOToedCxN2hKiopBXOZCMCpRE3GR5kkykovMsQK+enjOGTaTAy7JvIBa1NvBWV30ncVVSLW6yC4rEsrURqYQP5l5sZujBtfC5v1qnD8/AB6BBWdlmwqBb1qSKx7TRE95xahlOAD+jWaFz3dSWxCMljefBE2Jr0oV6W6v0/jg/DVCrh8bfQhcbfoK36teCVxBWWSoo2TeuxmLH2oHcoYNvr5yGmcSFfMuSmg+634U4oRmj38zOUR3w5qkS82nWy8kymcrilWAj+Bm6e7SFkTBnAawu53pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otlXDDkSfela3l9GOQcqPZfV1C1F0uhALZQrQkJfvCU=;
 b=KETbpent+GWHXZx3iJyDPYgBN1GQ2CYNOGaRn2mUgopwYtchR0UG9ry6B8nn8jKeisF7zSTyKgNkz2UGSZ5yZUjeJp3K4qJ3RlAI+CHlcTP9xWiVQgYhBUhPvK6eVFQaeVtUKkhTNxOzxdReYvTWwJB6D7qsKMWJGkG6p7Q5+3p8+oAicSlki+xYyIqIr/ybHu3Fzvd/V/E8yznI3lOHcsT/aovl8SutbSYZVjkqurAzHoYijkhcBaqPu+96uRSVvsOT+DuVuSXPQTJRr9ew0nzCxMHgeeEPwvUGV0/qq+iY+CUF2QyhlYV4pljQC2urqUmQx1QjApcQdGUUg9ESyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otlXDDkSfela3l9GOQcqPZfV1C1F0uhALZQrQkJfvCU=;
 b=tP7iasZYtH7enurmkRvHy8SkCAQRZ13VOpESpxS78Qxpv4oMnGKtZFoEtzzNDYlblJEKfmFrNNJkJ2FeeblFn5kVsuFVpcwxoqLoRtgBUdoDyryRjk2kZQX4oZNhPrsGigCXM4pdaRRQrQ0mnGuIIw0k2/07eVhsQl/xVKnS2+4=
Received: from BN0PR08CA0013.namprd08.prod.outlook.com (2603:10b6:408:142::21)
 by SN7PR12MB7225.namprd12.prod.outlook.com (2603:10b6:806:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 07:20:21 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::c1) by BN0PR08CA0013.outlook.office365.com
 (2603:10b6:408:142::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Tue, 23 May 2023 07:20:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.29 via Frontend Transport; Tue, 23 May 2023 07:20:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 02:20:20 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 02:20:20 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 23 May 2023 02:20:09 -0500
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <vsujithkumar.reddy@amd.com>, <Vijendar.Mukunda@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <ssabakar@amd.com>, <akondave@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: SOF: amd: Add pci revision id check
Date:   Tue, 23 May 2023 12:50:01 +0530
Message-ID: <20230523072009.2379198-1-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT032:EE_|SN7PR12MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1d9f3a-2b24-49f7-f417-08db5b5e2b19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iFFrakB0Y66zS+uGvLQxkuO+l0cptnsUYTZj2ApNy9OiJ+2V1LmnyNJs+BhpmND4tUFA7DD1DXSCIHATml02IfDPTVP+HofPVv+41y4F10l8kvYwkkjFHEA2149ZD/q7wPxOns6OP2E8O7ydmkcnJ2OSaMEPdBUpNR6/wcW5srh/6wtN2Q/RyKS8DeSIdNvJJH4TXkk+3NaBdhm7UP+G48K1s5gV+hhmIxwwQlUFES+MkgRP17JaupRqGfJ3mmG44UHKnbX8VYHZQP9IfAiL4dam588rZ0CWv0ifwtJKjb0u8AlYHDZitsL/KMtnjNwm9l3GSbe6cpug9dRMOPq/hZuLYvEHnPPHutsc7nhvu8OWp1rrH5SoiaWoMfOUkxwDaMDZOxv95DTXfWznQWaf/voBFFyHBeVkn40mwWBmUdCbq6NPtLiThnG3nrld8Wy0cwpT+/2yrHr9oN20i7tBMIaKd3rhfNyVRFIBwb9L/JXiR2gVCvHbozx3BOQYu+b9jgtfyMp+rby3zA2tcS0D7X/mL1Cf+a303ZkuZHwSDrJI/Mmw9yY1E6jmAPGLtYRSDV/5BJcC7GzbmODckfytMirWN0RwUQ6pjcE9e3EBa3QfHX+LXnuzbRNinjnG2fJndnSkpASqPGc3EKbsXkSYpqjlXOPJIw2a4c9pNwUmOrnftLATQ8dNBK5mXjp9x1PdlRyj7jrTqWSTp7N8kpI9pEXhoLO7xiTRwh8jx07TEDgE2Y49LcWf+A7jLySUikfwXf5Baupq54ZUNSAw5hLKlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(40470700004)(36840700001)(46966006)(81166007)(356005)(8676002)(8936002)(7416002)(5660300002)(82740400003)(40460700003)(47076005)(40480700001)(26005)(1076003)(186003)(2906002)(2616005)(36756003)(336012)(426003)(82310400005)(36860700001)(86362001)(316002)(54906003)(110136005)(6666004)(4326008)(478600001)(70206006)(70586007)(41300700001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 07:20:21.0763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1d9f3a-2b24-49f7-f417-08db5b5e2b19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7225
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pci revision id check for renoir and rembrandt platforms.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/sof/amd/acp.h     | 3 +++
 sound/soc/sof/amd/pci-rmb.c | 3 +++
 sound/soc/sof/amd/pci-rn.c  | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 1c535cc6c3a9..dc624f727aa3 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -55,6 +55,9 @@
 
 #define ACP_DSP_TO_HOST_IRQ			0x04
 
+#define ACP_RN_PCI_ID				0x01
+#define ACP_RMB_PCI_ID				0x6F
+
 #define HOST_BRIDGE_CZN				0x1630
 #define HOST_BRIDGE_RMB				0x14B5
 #define ACP_SHA_STAT				0x8000
diff --git a/sound/soc/sof/amd/pci-rmb.c b/sound/soc/sof/amd/pci-rmb.c
index eaf70ea6e556..58b3092425f1 100644
--- a/sound/soc/sof/amd/pci-rmb.c
+++ b/sound/soc/sof/amd/pci-rmb.c
@@ -65,6 +65,9 @@ static int acp_pci_rmb_probe(struct pci_dev *pci, const struct pci_device_id *pc
 {
 	unsigned int flag;
 
+	if (pci->revision != ACP_RMB_PCI_ID)
+		return -ENODEV;
+
 	flag = snd_amd_acp_find_config(pci);
 	if (flag != FLAG_AMD_SOF && flag != FLAG_AMD_SOF_ONLY_DMIC)
 		return -ENODEV;
diff --git a/sound/soc/sof/amd/pci-rn.c b/sound/soc/sof/amd/pci-rn.c
index 4809cb644152..7409e21ce5aa 100644
--- a/sound/soc/sof/amd/pci-rn.c
+++ b/sound/soc/sof/amd/pci-rn.c
@@ -65,6 +65,9 @@ static int acp_pci_rn_probe(struct pci_dev *pci, const struct pci_device_id *pci
 {
 	unsigned int flag;
 
+	if (pci->revision != ACP_RN_PCI_ID)
+		return -ENODEV;
+
 	flag = snd_amd_acp_find_config(pci);
 	if (flag != FLAG_AMD_SOF && flag != FLAG_AMD_SOF_ONLY_DMIC)
 		return -ENODEV;
-- 
2.25.1

