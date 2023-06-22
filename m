Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E44973A4F9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjFVP3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjFVP3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:29:04 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3398619B7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:27:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKkE8mowltoetLO6I9meJ9cPh7EauSi9qGujYrfzncdA1RbnHOBKHIiOiStKjMvRMW/XvNzLN5v2fJVtxeYFiaWECG8flmjGQtQY6zFAFqMusbnUkC+ejXs1T6bo5zz0v6t+E2qbgD7IdVqlxkIj9E7YW7sHMjrHkRi1VcPI0c4K8IjpyObtLfpbPYZMgdG/cGI6EM+YTNAsJXn4kf+f9Jn2tDpVex34ZbyNnQJ9E9xnYyxz66QT6MISeY7NVDB5NEfND5pOszfevbBNpniapt8WI7Gx1DGnL+n8MJEjUfDboCt0ScKjxIgtGJx8F5iiDHLtkFBQcjlajZjJlgMvJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBy8FZtzhflK/O11biPfyMuMDcZU0bVlpYPp66Nv80c=;
 b=hbdy+zblFjuwwRxvE2ACfa7smEbCH7/tLRhaurTp+ATgPuUkl+nRnHSBAeOiITz2AW90YNkuqKlwdkkse8XRlpYahAmEI2IXbadzC+q1Lg9i3GfUYTs/F9yNJs327tdZwepRf4ghDUllzl83QFNCArl6fK2x9wxEgXYGK21t/SJq2QNBC++RuAJTHdnC49XqNq51kOB0Fwb2voK5vhXxobAbrGeeB7S+TIxYjZvfb0kEtWYszJs6P0inDxLA9xVDXtifvgvLPRk0EFZWMpKXLaSLi4MXoLBtYBRlDHoD5dxhEqfpQPaSuhCwjy062n5WjVvGqbaxVZbdILewFIJzSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBy8FZtzhflK/O11biPfyMuMDcZU0bVlpYPp66Nv80c=;
 b=Wg7/Wb4SwyCOV5sL1LcSHHTa/7aZNpb+NWuKXRxsj1QLRg2wUOkdJvHfb1WXKpdvENmUjId06gb7KKWsuZ05gxrDt6wu/qwj2lU1BLlLIQGYBU1XlBNWpNapLNwB/UU5uYEI0TeK+6QP3ci5wD7mMfA9Jtv7rP9Z1doJa9Zrn+w=
Received: from SA1PR04CA0019.namprd04.prod.outlook.com (2603:10b6:806:2ce::26)
 by DS7PR12MB5837.namprd12.prod.outlook.com (2603:10b6:8:78::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.37; Thu, 22 Jun 2023 15:27:21 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::e0) by SA1PR04CA0019.outlook.office365.com
 (2603:10b6:806:2ce::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Thu, 22 Jun 2023 15:27:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.19 via Frontend Transport; Thu, 22 Jun 2023 15:27:21 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:27:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 22 Jun
 2023 08:27:20 -0700
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 22 Jun 2023 10:27:17 -0500
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
Subject: [PATCH 11/12] ASoC: amd: acp: move pdm macros to common header file
Date:   Thu, 22 Jun 2023 20:53:59 +0530
Message-ID: <20230622152406.3709231-22-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
References: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|DS7PR12MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: b28c9b13-a6e2-4fcb-a9bc-08db73352c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sw8dU52qtSR69YDwSMklMwD4V3Ea3k8oL9udZ6zeVHGss0OS7Xao+uZSy2mOvEcTGj28DFSf/4KBVbLYS2Y92Gv8zoiY6egg4umGUkrWB3NaraH00s5yTHOklbFcatrv4ntgkFQxcCWRivIbsU2jfCOgaAanbyATJU211sK2AHsTGb1qocKmw2P6AsFN2Y/kY/f/YXeJVfC7TpdjIpEIj42i+uEHvaJPQeo/xH/p3AmCCihtBjW23tjkOtKAbW2OQfEj4W8+trY5mqyvvhHCDYmgJhQdcDao7hc3X4rO1GOUZvN8PsoVvp3SdvcQBaN8feLoR4K2yaQEfGcqrDJJo0ZxMUVJDAhyE8h8I4hiYTRgCdNdjaBjDgASRYko+/shZtqFqdNnhFNUoLgBL12rBWkM13Uh6i8pwP0XIvXiRDeytDkI9lX5iXMFSY1o/PFKonN1xI07sTPrshMAVu5nZDPWPt466ibQ08h/aI7O1maP4cVrE+FyLil/vHIWsNTKTeGxHyLRjzBa0TtOZIhxJADXsFp8JqC7D27rzdBKZQYoEKRnOCSy7Otg1QNe6w6TRKrGMFJAqq48pNMHxqELgj6AzZLYaGD1rNMZkpKcIVgh8WviNoLpjHnBl5eSRSJmfTkG8s5/KcEfKoIFLo2kQPLH2sDWewztB8M7sHKyz3Bbf8Z0qy12h2eWkF25Muqw4miIdtOd0ZsdKKSQb5+djxfT43DOt6iPw0MB12q/bVq3slstrQHckAvOXufU9S8TykRWGtXIDVBvA16H69MBvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(186003)(336012)(36860700001)(1076003)(2616005)(70206006)(4326008)(83380400001)(70586007)(2906002)(82310400005)(26005)(426003)(47076005)(36756003)(86362001)(82740400003)(40460700003)(81166007)(5660300002)(356005)(8676002)(41300700001)(7696005)(316002)(8936002)(40480700001)(478600001)(54906003)(110136005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:27:21.3992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b28c9b13-a6e2-4fcb-a9bc-08db73352c2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5837
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

