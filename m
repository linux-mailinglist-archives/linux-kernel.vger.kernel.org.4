Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9655465CCAC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 06:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjADFwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 00:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjADFws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 00:52:48 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9592E16592
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 21:52:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3P7dfMUJJzGsTl7eKJgiPPmGPPnJiUn9m6bOTzvHH3ofGzkCL/ervQXefhqYZFTjgbGKdnzkEU22jtnJE+JQJNdQEpyCTqbxfDIhHzN1Gf4Yn3bb2xh/vx7TlsDFBKBvtLl7Kl2DEeS0e4a9dbZJtf6ytDLe61JB0D1dhqBJnsCXtwUKI1zCIAkjaQKxtvajzcKl4QYCh85cwpGnDq4QFsc5OLKr/rqsa+EYRsagiMxLzmqDTTr/tFt+yhyNz+ErFJt5HKYQ82H9eSvtk5xDM9XgNoBIyY0LxW+chyfoRvF/TkLlyVvZh/4eBthcgnDADz7JfbvNgTYR57hn3+9kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erxSFN44UA3AU0z9CXtNLgAlh4sI/urADlv0rTWRUqo=;
 b=gpTvaBCPkEHlvI2qLrdoXs39BGxAzqlJtVZcbrIMbCTA/uesOHM+MixE+GWAlawKIEHGydikokbJ1EdNtJjSFLVroJSOnKwPO2HUV5DLBN++bEhfKesu/eRMfDRhz3rIa2dVbS/RX3QyfmEghq1q9XPTjTm1ck87WT6kU9rt1nGDCx8NZ2D+IpzAk5g3DuFqWTBPU1BjMZ0CV7NMfzUVcYM3LTBUkfK3Ealrbotl3csWqvrZnsG/2qg+BPDl1EZlvgurBDYeOs3rr1HUTdpGAaBO2WWQftXsCllNbwBXNPXIEAQoApFrUOe73P1KKzPdN11RNsRjq9Cs/tZO//Hg4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erxSFN44UA3AU0z9CXtNLgAlh4sI/urADlv0rTWRUqo=;
 b=zVgAm7t8hM13pr7tIH2FbHsWWNwW5OkIbDgBvDokA6JJKImsyNHLQpFcW8j71kOigGz2z/ffWvG1eoBX+5d/2VWbAc00vkAavkwOVk4JcgtHdXL48+OKk6giX3Mv3yezNF9M8RHXJ8i5drB2MtAcYiRmAreP9spgNymzBbnj82I=
Received: from BLAPR03CA0070.namprd03.prod.outlook.com (2603:10b6:208:329::15)
 by DS0PR12MB8271.namprd12.prod.outlook.com (2603:10b6:8:fb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Wed, 4 Jan 2023 05:52:40 +0000
Received: from BL02EPF0000EE3D.namprd05.prod.outlook.com
 (2603:10b6:208:329:cafe::f3) by BLAPR03CA0070.outlook.office365.com
 (2603:10b6:208:329::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5966.19 via Frontend
 Transport; Wed, 4 Jan 2023 05:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0000EE3D.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.10 via Frontend Transport; Wed, 4 Jan 2023 05:52:40 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 23:52:40 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 21:52:39 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 3 Jan 2023 23:52:31 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <syed.sabakareem@amd.com>
CC:     <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        <basavaraj.hiregoudar@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] ASoC: amd: ps: remove unused variable
Date:   Wed, 4 Jan 2023 11:24:31 +0530
Message-ID: <20230104055435.321327-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230104055435.321327-1-Vijendar.Mukunda@amd.com>
References: <20230104055435.321327-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3D:EE_|DS0PR12MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 845c6b82-1965-44ee-3c43-08daee17e425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XEkm865FjnTDWtValgohG9vkxFFzxITOimyNxkXKzYcr++SiFq5r5jbWSq58HqwwLnVgVSnLPVHIgNTVaFqgvsAYbLpthuRteaN0jz+OBgdwSvu+UnjEvcsKRZMu+HzP1rqtHkCmn/dbYbUgQuV/6LjS+CVeoyxRfCodxTXYiBV+P5xSbxSO5kSXhKDYxoRshguSnUvMYSlLAyPc/C3lUQjWXjPUWhnvK+d0UhWcy3Jsh/vBr10aLZs2fj4B8TqPhOWjCH2fnmeUktTwhS1gfj3wyC28PZ2XTBrphHrgkP23UwZGQ4ioUsAXChhhy7JxExrcRwYie+16et/6/y+s9ykB9akk5aH9OUmCOyq1z0W7dbO8FU19GZW2ntOrMADUF2e7CuwxVZwyAEn08UlAQObsKAwYynCvoeIejtTi++mrkh41tXRvvhCfSdpTRJMsIjvp9tX6u2c+FtQNcXHZnnQAet6K1zVdZikrmKJR1ze8Pzjs/BYIzfa9BCXzyWoN06APDH+nAyEV3+LfS3NU6b87aa4ZA+Sc3GhYjS16lUHfq+unYXAkABhd6nqWHPwi4w31Khps80FTu7TgNDA8ba/ci3AquBzhEsEymlE7GffGlGjvXWr5KJy/ZjHDgLIEZMAZTXmjTwPEGLn82OrPdduvUQFap/H4+/8fzvjPf5xm7K4m9gOgkSqmph9svYdQwbEatkM9uFvxWPj5At16qgmKZ8nZwu5AoDqTi3VQ6go=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(41300700001)(70206006)(8676002)(4326008)(8936002)(70586007)(110136005)(54906003)(6636002)(2906002)(316002)(7696005)(478600001)(186003)(26005)(5660300002)(86362001)(40480700001)(36860700001)(336012)(83380400001)(2616005)(1076003)(47076005)(426003)(82740400003)(356005)(4744005)(36756003)(40460700003)(81166007)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 05:52:40.5181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 845c6b82-1965-44ee-3c43-08daee17e425
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8271
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused acp63_audio_mode variable.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/acp63.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index e0160cbf5447..b7535c7d093f 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -105,7 +105,6 @@ static inline void acp63_writel(u32 val, void __iomem *base_addr)
 struct acp63_dev_data {
 	void __iomem *acp63_base;
 	struct resource *res;
-	bool acp63_audio_mode;
 	struct platform_device *pdev[ACP63_DEVS];
 	struct mutex acp_lock; /* protect shared registers */
 	u16 pdev_mask;
-- 
2.34.1

