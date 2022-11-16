Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AA662BB33
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbiKPLQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239114AbiKPLQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:16:03 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F8962C4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:03:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIQkJrwOQKyUVoDfoylVU3w19FE7XsIOx9xVd/u6hhvPS+D783OoC2AJSuUVO8B5CNid0+hmfwd3sah+OckZUZ0ByMLXNHGhbr0EDNazQUqMPuATiMie7ffDSZQUKyo/eItoZDEuUFBzd7pAuE6AaZT5bubM5XHhSW90Gy2grwpSn/o5HLLo/GrL2asmII97sZm5uv8ho4QlafPc05NiPEFg3t4wVTKscmy35npFKZ3fle2qXOrnL9QolannfnS0P7bbIA6fWFZR/gxwm4KtFpXhJcQTRnghWUUzvKfmDT5ecsRi2xjzd1B01i2HiVCFbe2RGzsphH/vpgTINb+1iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVBoVLeBzE5AGTOglpZA92Z+2QbA4+A6zEZciZQz9Ns=;
 b=Cqo+VZm9bZwkhg6ebNcp94mm5SU5pZGOr5RMX0iHk2lcfSIrKA4As3WEexZztMTeIaFlhyXHAgrPbnZVQ7TNekvKsWrXWFpnIxB++FTyUoccB7XtE7zh9pgauKtU7Bszt1hKgdPPW7Mg/Ww7TzquebNWeEC211AItZKc77Hc9N9HMJzHjEx1W3bIVb1HWvUJdiMOY4Ts9VvYvtczYEBhAciZYDp0i6GmBkhGSCeMukrWLqj05LH6FA/JwvJKsbtYc8nDcdyS3/2uPBiVFJmp3r0foy/PIRhiV+ZsgcEarmWChVaJrJA7npg5AaH9403OksNVyWZPTZtsxbIehQGdJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVBoVLeBzE5AGTOglpZA92Z+2QbA4+A6zEZciZQz9Ns=;
 b=WzGwdwHO5L/kew1v734dfwj9rF2BCAdafVOJuVIW4G0oAdBXe4wBs48pr/R+4LNIgXJOQyb3/0HNwDMNVtFa5bmfVPP+tr7kEQzwj+URdAgFa8w2mOrMYtxRxIxyWaJy45C0Z43myEB8/cyPX+Wm2EYC4mQk4P+4VGGpD7HKpLU=
Received: from MW4PR04CA0094.namprd04.prod.outlook.com (2603:10b6:303:83::9)
 by DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 11:03:28 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::f0) by MW4PR04CA0094.outlook.office365.com
 (2603:10b6:303:83::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Wed, 16 Nov 2022 11:03:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Wed, 16 Nov 2022 11:03:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 16 Nov
 2022 05:03:26 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 16 Nov
 2022 05:03:14 -0600
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 16 Nov 2022 05:03:10 -0600
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ASoC: amd: ps: Move acp63_dev_data strcture from PCI driver
Date:   Wed, 16 Nov 2022 16:29:23 +0530
Message-ID: <20221116105938.762550-2-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221116105938.762550-1-Syed.SabaKareem@amd.com>
References: <20221116105938.762550-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT028:EE_|DM6PR12MB4172:EE_
X-MS-Office365-Filtering-Correlation-Id: 30fa151f-f454-4d06-c260-08dac7c230c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dy7j6zPx33EICAEjU3o6KAEc17UtYc1rwYBnSy0kYW/KddwDNBQaD0E2wxqqMmOz4Tcq78T6RAP34Rb1M1D/WQaz/ZSqy/HQfZRydUk1T4ae8+z2fJrxAHurrUu6DjFsCj/Biti/Z+P0ZebxOGhqRK+TwWZb8KL8gCK74hIWwMHYEgO9KAuPJb17Z/AaQdPkc7xsslIQaJZH0cqjdYpzUEm85QzhQKQHlSVwmMFadxSAFvd4zLHxWOrX1apENm3SW+shchXDJbgzq44ZUEbuOPSan/+W2bDM1bV4CwUxZLIjGSbqh5BgAOm5xUAIjwHDDxIyc5ghq6f+WCe2ZFqg8dQlMGSSSxIGYoxALYEU80OPBeJcjSd37h6jBJ4ongeJly3MPgyZ0ArVwFw+ge0ndfSeHNXzv3Q8PIgTlmbSm/StjSLjy8Fqx+zRVeO1UHmmtsVe7gPpqLiC8b6q2Ppqn9CUgsChA6xW6IWl1OJbC6XfSvcinxCF1CnLtoKgq/+gHxFguiDSAavs4E1MHbLkxnfWfW/f4/s8pZhjqASpjN8x3NwGHreLy/YF7BExVfjj+2+Hkawpy3T3dv2oRDrj6zTZL6GPQi6D+x76eCyHGBMdyaMJAon/4iVikpFLKPyMeUm8YYTSGyZYgPOMKv5WyyinfxVpp4IvBqLDCcdYS4p0aHYlXJHQ1xw6tVmfLk3bh+nSWMb9dllASon9F2Hsvo81FiBTEMb0p1Vf/uWO3IL8UmfoJ+ZmHgZOY+n8JbZd+XDCitraAiv4mZi+KHQhPcyOzIBO9+xrFeDmKIuTxmaAoaiBgGpMVdtQtrKheCmD
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(36840700001)(46966006)(40470700004)(7696005)(26005)(36860700001)(86362001)(40460700003)(83380400001)(478600001)(40480700001)(36756003)(82740400003)(6666004)(5660300002)(70206006)(70586007)(2616005)(82310400005)(41300700001)(336012)(1076003)(186003)(8676002)(4326008)(2906002)(81166007)(54906003)(426003)(47076005)(356005)(8936002)(316002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 11:03:28.0674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fa151f-f454-4d06-c260-08dac7c230c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move acp63_dev_data structure from PCI driver to acp header file.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/ps/acp63.h  | 7 +++++++
 sound/soc/amd/ps/pci-ps.c | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index a90ba3b20dc7..5e7f9c1c1b0e 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -96,3 +96,10 @@ static inline void acp63_writel(u32 val, void __iomem *base_addr)
 {
 	writel(val, base_addr);
 }
+
+struct acp63_dev_data {
+	void __iomem *acp63_base;
+	struct resource *res;
+	bool acp63_audio_mode;
+	struct platform_device *pdev[ACP63_DEVS];
+};
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 98dddd1a0cf4..489f01a20699 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -17,13 +17,6 @@
 
 #include "acp63.h"
 
-struct acp63_dev_data {
-	void __iomem *acp63_base;
-	struct resource *res;
-	bool acp63_audio_mode;
-	struct platform_device *pdev[ACP63_DEVS];
-};
-
 static int acp63_power_on(void __iomem *acp_base)
 {
 	u32 val;
-- 
2.25.1

