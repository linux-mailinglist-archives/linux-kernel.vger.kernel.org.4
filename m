Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A8F73A4EC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjFVP2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjFVP1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:27:34 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A57135
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:27:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d43SBcvYmYjRLmWKkeYiZ7/2h5Ow4iR6k7zctMNq+um/6KwKXws6EIAETipyE0uC8SGIGtBAnFE64ugxbgd9MgZ0VrsuMBNlD/2Js9p0m/rKKpHg3hJznPbpidD75jIUE0t9/Go3+8MjNz/6VXFB5qAHupLG4Hka6tNHbQRuSXWFGeskkvojzuUL4jH+2Jl+9HRc/gv9ZqEGqQ7Gc2TO1Drmk5tC7Ft3qxRg1lucvG99n2YpeVkwKDp7XLoTEnfMzkM/HdtyIyT8BWfR87J6stISORcOE0dSKhTF5ggfXKDhkaMhkf7EMArbWVHjpGNNvXq7vwW6RxQCucqTe7OZMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBy8FZtzhflK/O11biPfyMuMDcZU0bVlpYPp66Nv80c=;
 b=BsEkflmG21CSqv3XZBQh4y4OHvUb1Jzqv3xsY/paKopCKD7yHkyXGHktUdDUB+eaLeDTuAPkEOALcmJ1e30du/KUsVVdSZ+zpmuB8EPVQWr6KqaUgFU16NfAJyBcNhXV8M89sijhzKcA3M0cC1i/6aBMuKpnLmD8AgNqQrLQOC6i96jIPV9VepEm7FsWQw5wg9z49rBo073DE8VIJaQ2n5BG9+MhjmHKgbEAbZsZtAel5VEVI43j0+IAT7kypTnMTy0cG2L55iKN1wfvtmvkdf2m10BEbqdlB3rx6DwpcGWs08gddDutYq26xWja6kOaMj8B1PqqsibYfRRdeMK2Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBy8FZtzhflK/O11biPfyMuMDcZU0bVlpYPp66Nv80c=;
 b=jL4RNEzXDM23rU9SymWljx4xnZiWUv96TqKMDcKnesZvsv9saqTvxGAYqdusjy2iBxL7UvnKsixFCes5xa14Rdgo4tTz8vntfzbqZ9qwcSq1VtlawHrDhseuLECWFYJ+Hl1bABEUPmkuszvIMAI1nSfjxivURHJGaFkERFytpb0=
Received: from PH7PR13CA0005.namprd13.prod.outlook.com (2603:10b6:510:174::8)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 15:26:58 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::13) by PH7PR13CA0005.outlook.office365.com
 (2603:10b6:510:174::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.9 via Frontend
 Transport; Thu, 22 Jun 2023 15:26:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.23 via Frontend Transport; Thu, 22 Jun 2023 15:26:58 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:26:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 08:26:57 -0700
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 22 Jun 2023 10:26:53 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/11] ASoC: amd: acp: move pdm macros to common header file
Date:   Thu, 22 Jun 2023 20:53:56 +0530
Message-ID: <20230622152406.3709231-19-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
References: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|BY5PR12MB4305:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2c6004-2ef6-4a06-2c88-08db73351e3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JEbYIWKG2bfqu5fh90jJOJDt23XmTRqijRLFJCVZGV0JtYdwZMY2E2dlox9UIBJNoCy+g/1XU5Xm+pTqskzTNBzC5dpxAyOvDBYsTyhJ4r6/ji6pZgVmuow6twrx0x7KNm4BFc4xju/aEbqlvHYK14J1g2d0MchiqG/WiOXLe8PKfCSmaG8zFSsSfCK0ihG9a2GSup71QPGWeK9nto5UyxZHpn3ZYOlQn9hAWI48v/GvQPO0mksKomTIwSUTrBNVkVtlW1hb1gng6BZsAAdYLH+xIrIVA9rng2OHt1EB5hTfcyIOleGkpSoZnJzS+B69yF+LBtPfKtLzk/Pxi3QKd2OgXTVDeKMjwWRKK3upHB1zSlCBHy+a/HPtLsFZm9ZBqe9a4ML+38Zfav5TF3/Burnm+wc/P62w5WsXKm9SlBYhW/hkjhEY4+OKv8PwEFaw4JY10n2CZZI/Nb7I8+7uRfYvdIqHwxBcYwxiUJxSM2j7JpHkzkqLlYaFuAnmiuNuihy6vQ2TiymrHApt7OZjN46an2g6khZFR3ln6etlY+oWUkNh1QonBruMZ+Tkgy51kAuiR4RrKF7/UNTIUGbPZ0T6nrP457FNOat95k/6/cfw5AMVADrk8d/+U+7Cv8nJ2T9A64aHyo343vy6V7k8B12jUezWUPp7NxdFCOtGLjNYrsMrcFKHFIYIjJ59JBmMBidh3YW8BTKidI6bhBaLDiwJ4Q46pl3nOZ3zhKb2RON77i9Ne/qpmlRTl8fAqjxIb0z5N3w6a5sCAko8r7VPyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(356005)(81166007)(82740400003)(2906002)(36860700001)(82310400005)(47076005)(83380400001)(426003)(336012)(8676002)(8936002)(41300700001)(26005)(5660300002)(186003)(86362001)(2616005)(1076003)(40460700003)(36756003)(54906003)(7696005)(110136005)(70206006)(70586007)(478600001)(316002)(4326008)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:26:58.0243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2c6004-2ef6-4a06-2c88-08db73351e3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move pdm related macros from pdm file to common header file so
that it can be used across different files.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp-pdm.c | 12 ------------
 sound/soc/amd/acp/amd.h     | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/amd/acp/acp-pdm.c b/sound/soc/amd/acp/acp-pdm.c
index 2833d2b7e596..f754bf79b5e3 100644
--- a/sound/soc/amd/acp/acp-pdm.c
+++ b/sound/soc/amd/acp/acp-pdm.c
@@ -25,18 +25,6 @@
 
 #define DRV_NAME "acp-pdm"
 
-#define PDM_DMA_STAT		0x10
-#define PDM_DMA_INTR_MASK	0x10000
-#define PDM_DEC_64		0x2
-#define PDM_CLK_FREQ_MASK	0x07
-#define PDM_MISC_CTRL_MASK	0x10
-#define PDM_ENABLE		0x01
-#define PDM_DISABLE		0x00
-#define DMA_EN_MASK		0x02
-#define DELAY_US		5
-#define PDM_TIMEOUT		1000
-#define ACP_REGION2_OFFSET	0x02000000
-
 static int acp_dmic_prepare(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 82e0684cb284..8dc663c8d98a 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -111,6 +111,18 @@
 #define ACP_TIMEOUT		500
 #define DELAY_US		5
 
+#define PDM_DMA_STAT            0x10
+#define PDM_DMA_INTR_MASK       0x10000
+#define PDM_DEC_64              0x2
+#define PDM_CLK_FREQ_MASK       0x07
+#define PDM_MISC_CTRL_MASK      0x10
+#define PDM_ENABLE              0x01
+#define PDM_DISABLE             0x00
+#define DMA_EN_MASK             0x02
+#define DELAY_US                5
+#define PDM_TIMEOUT             1000
+#define ACP_REGION2_OFFSET      0x02000000
+
 struct acp_chip_info {
 	char *name;		/* Platform name */
 	unsigned int acp_rev;	/* ACP Revision id */
-- 
2.25.1

