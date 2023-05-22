Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B2370BFBE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbjEVN2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbjEVN1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:27:50 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731EFE45
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 06:27:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4jXxA6TU9bRsY7ZE3Y+1Dpqs4GCA9vzoVEBYOai5QBESAy9b5boGg6Y14iMKojf1Ug722DJcYAiNdbEx3HhRC6HF7tmzryt6i3uRffU4cj+8n55/I+E9b/wYNWn1nxDASjS3N3PYim3TArnDU60foJdMPgcvFBrP2au419Pjqepm83YCWyq5/znZHP9TY5YGtuyRS0vvqBoXk4Kr95FI2SAAFgqCPUSLnoOT+Ax1BvWCMPi591ev6Z92yYrjmh4UDF+QyAjTSFHkFiNQZx2UKNJCLstMreiTc+FTRKn5ge3p6W8Csmn1F2fkiNSAONhuGKr/YpYg64mR1/V1sxVEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgZh2m1ue2OnvyVEBBAWUfeFVyNibjtPlMMW0oX3v90=;
 b=lEu4rS4Ab5ujbhsBEa5ZervW6zDP+JeYzkthCMFrl+jaRKhDxD271cKNDQTeVUWEmKdcAQ8r0M560hkGVqljl97Ft1WyJK1s/e1AwO4IBdKbelHf+XUTN8FHnPzyCYRrxeovtO3ks+HcWdNHbALw2k21rOZMwM2+TeChRHu6S2rsptd6saO1V+n1Xc/Jejm00gBWXUkEsHu1oN6l5eOe1iEo8D1uia7/i34kgBkB2h7ydR43gta82jXU5+Dy5zZz8YN52XtyxY6cMD5mnZtmJe/JS0OqS27f5W9krntmfChEyqPnhmizCCcN7lTObFHayfLypSKmcMYgpXOLpv+rsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgZh2m1ue2OnvyVEBBAWUfeFVyNibjtPlMMW0oX3v90=;
 b=bdzwZHGz06ZZ6khfZVsfeyVmjOILTC3p8kV5BZDompbq7rDuKIOUmvtxuakeK7X4mKUKSDHHy7b3ld6U+07Q1LFZYrDQGMl5xgmObQ5bTb5r0UmRK09Pc4qvVyq40tMo95iLDf7GF7ThZwq7KVzcwQESjcyxoZmwQf//HId+jNc=
Received: from MW4PR04CA0213.namprd04.prod.outlook.com (2603:10b6:303:87::8)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 13:27:24 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::ee) by MW4PR04CA0213.outlook.office365.com
 (2603:10b6:303:87::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 13:27:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.29 via Frontend Transport; Mon, 22 May 2023 13:27:24 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 08:27:23 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 06:27:23 -0700
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 22 May 2023 08:27:19 -0500
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
Subject: [PATCH V2 9/9] ASoC: amd: ps: Add SoundWire specific checks in pci driver in pm ops.
Date:   Mon, 22 May 2023 19:01:22 +0530
Message-ID: <20230522133122.166841-10-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522133122.166841-1-Vijendar.Mukunda@amd.com>
References: <20230522133122.166841-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|SN7PR12MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e48deb-7c10-4b60-8127-08db5ac847be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0QNdF8xR6bK7iDeKxXSW2Fui1ngVHyuIt4eXiXFJTon9J2R9h6XZ1joM8vBoOLRwbaGQrDir9VmApwsFLlO1OPNBXbYy9muwSgDTfH4/A8V7zJUmAvDhZC1819zD88+IepLiCjvcy4fClqx31noTFScDUNg3QRF8J+i597qE14Xlz3fFrkBB8n+G96Pe0v662BmGSO3w8tyJ3zUTk3nvv+paekawrke3y3HFT4g3dX9eqj6fR73Q+HiP595IcmvIzfVfusnDVM+EsrLDvMMsLFs2tlCLSzRijhu0/6WpkSMXvgRHSN42qW8KSJS50XlMped5OKcjJd8yhcY8hNTvqbkv0JEKcmsn/PZDyh0cfXEgFh6ehQrt0FSw+S8O8Q5/v/5XHLPCpvjLcGEbZaGLI2X1Y9n/PnGa551MYVOuD8hcHXvjgT8rhhLV9bRyyCFDoaLcNS10UwzROW+Bu8xh8qs1c+M6vyqaJAbooe723ds3GGaKr8VClfRoDSGIz7xGNprisCqwakC3qP/zXLAD5HE4xG/l2jrXmXGCMFFOKvmvEKSk7fsN8xkE5Hc+VSAy/ooDUVBoB2FKjmCwSzGBjzBCjYqy2lC7qspXKh2rmqA+l68Gl4OUtgAh63kRUigFQnuBngQYGU7oaNP+ehKUWT7XPFQs0fSdy2JfNMSCZNh/9eZ1v2xWId+PdNjCFuDy4jw6bhDVm9LaDhuXN6p2MHA9JUBwpZFeq5SFyiNn77+a6HUQ2tfgbcv1trap84Q5vPnPLkQafEfJnUclAEzzSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199021)(36840700001)(46966006)(40470700004)(40480700001)(1076003)(26005)(316002)(6666004)(7696005)(41300700001)(54906003)(478600001)(6916009)(4326008)(70206006)(70586007)(8936002)(8676002)(40460700003)(81166007)(5660300002)(36860700001)(82740400003)(83380400001)(47076005)(86362001)(356005)(2616005)(426003)(336012)(2906002)(36756003)(82310400005)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 13:27:24.5277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e48deb-7c10-4b60-8127-08db5ac847be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130
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
In case of SoundWire Power off Mode, ACP pci parent driver
should invoke acp de-init and init sequence during suspend/resume
callbacks.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/pci-ps.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index c99ac5d90097..f6d14baf2c2e 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -659,10 +659,15 @@ static int snd_acp63_probe(struct pci_dev *pci,
 static int __maybe_unused snd_acp63_suspend(struct device *dev)
 {
 	struct acp63_dev_data *adata;
-	int ret;
+	int ret = 0;
 
 	adata = dev_get_drvdata(dev);
-	ret = acp63_deinit(adata->acp63_base, dev);
+	if (adata->pdev_mask & ACP63_SDW_DEV_MASK) {
+		if (adata->acp_reset)
+			ret = acp63_deinit(adata->acp63_base, dev);
+	} else {
+		ret = acp63_deinit(adata->acp63_base, dev);
+	}
 	if (ret)
 		dev_err(dev, "ACP de-init failed\n");
 	return ret;
@@ -671,10 +676,15 @@ static int __maybe_unused snd_acp63_suspend(struct device *dev)
 static int __maybe_unused snd_acp63_resume(struct device *dev)
 {
 	struct acp63_dev_data *adata;
-	int ret;
+	int ret = 0;
 
 	adata = dev_get_drvdata(dev);
-	ret = acp63_init(adata->acp63_base, dev);
+	if (adata->pdev_mask & ACP63_SDW_DEV_MASK) {
+		if (adata->acp_reset)
+			ret = acp63_init(adata->acp63_base, dev);
+	} else {
+		ret = acp63_init(adata->acp63_base, dev);
+	}
 	if (ret)
 		dev_err(dev, "ACP init failed\n");
 	return ret;
-- 
2.34.1

