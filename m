Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1521686C24
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjBAQxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBAQx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:53:28 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1EA1CAE9
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 08:53:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvczro+2zQfioRC8F1i0Uxfy2cMwaFXrX8hgL7MCIgFZmEESbk6YkE1HcQORAX8kXdMoEu5bo7JiTQ0/ZJVw+wiXRPRVxEcwAu4UMHCQzu1vX1sP/DuDgDIIVEcH25ROZ0mHeL+Bu5a/z0RFyRT6Qe5DLu3wxLuZ4o/bKq5OdFEf16dPw8TLnTSFfUlTRgX2MSgV3h6ynScqlnbBA2bZ073EU7qm+JxzEv8qADZd0EflDisTGuzPnGKZ2R24WFkG4oox52nFDb9ROD++X7BjGCyHGwjL4Gzm2m+3HVpr9gy+Mb4au7yLwBvbNzvv7oI5DvT0BFJWckEWHErD1bn65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBxzHA84iwoac5hrM10pwV5f4IWAlpFQgQ8GHcp5JSA=;
 b=QOvqXVawEKq8b/akp0U8118ahMWcw3GqRIxALX99Hiud1ZJbin8V4fcdlzYSiFkyLRXZNZbD/w0OzS0JHR/7Pd00P215nL1hfuLdG5o0zDdAfkt6qMc0fil1Yv4TzkJHg/AiC05WhdZCSNh/vdP8XM1vdYSTlgoKE7WFzrtoiXpYtn1vxIVgN0wwv8LedBhdD7M6HmqdWLsW1/YfK5gZ6kMZ/8xuGjD/ySB7H6R6LQ6uQM+pxXOSN54+dRH00SysRXnqyYYA53oX4P9BCSCQsEmfweRRNGLqWi4lnTg9kgOFby3xD/yBPTwqziNGGTwOQ1I8PiQ4POSwOqF5Ofyh5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBxzHA84iwoac5hrM10pwV5f4IWAlpFQgQ8GHcp5JSA=;
 b=ENPJNE4atoc4i1DdskEVSAkAUyfZprFv7/k+U7e8zMnQ4zm1PuoS0tL944Kv46dwirc/cIIwvoZWtCl87tDtRoQwSqo+zDOYuy0s/sUtAuf6TXvO5LVwLo8NYpXzqWf2BkMuvJgR1rBgGTO94d8zVZvWTJ+hA2RBQXOHkket6Zo=
Received: from DS7PR03CA0347.namprd03.prod.outlook.com (2603:10b6:8:55::6) by
 BN9PR12MB5132.namprd12.prod.outlook.com (2603:10b6:408:119::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.24; Wed, 1 Feb 2023 16:53:18 +0000
Received: from DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::42) by DS7PR03CA0347.outlook.office365.com
 (2603:10b6:8:55::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Wed, 1 Feb 2023 16:53:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT093.mail.protection.outlook.com (10.13.172.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.33 via Frontend Transport; Wed, 1 Feb 2023 16:53:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Feb
 2023 10:53:17 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 1 Feb 2023 10:53:14 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Basavaraj.Hiregoudar@amd.com>, <Sunilkumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>, <Mastan.Katragadda@amd.com>,
        <arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: update ps platform acp header file
Date:   Wed, 1 Feb 2023 22:26:25 +0530
Message-ID: <20230201165626.3169041-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT093:EE_|BN9PR12MB5132:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4eb76e-20ca-4cb5-35c9-08db0474d166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6n4fBcPbx45LsUXaKO9rbVMjTuMGKo0i7ajktd+4HqC9aksLR4faTI2a1dkpHF7taNH1S31RhC6p0R9V1RP2onKoly/R0uL+6TSxXVxOn06fZCzyrfqWqVl2lxO5ub/n+WChwo4ViCSQUyrlhmFtgaqbUe5LzHYkDDz8B0NRMJTs3TNyaORBFlsnP6kMPYzlQLiD4fql9cY0dYIe6Pv7+CCJVDGLgWwYnDldorGn1djhF7+WwX98nnUxYJhzl59VMRVRTOyFzCEcnRsDBYgJZRdKUYPQ8+zsva5bBrlLSzbZCnLM9BBNYP4vIx7A8C8mbryaD3gvrYOOXTG2yzQEpgsy8pYGENkG2899y+vWdV8x2aVWu+MbXr/k3fk38QG11Sl3qqu1+fvmS+wIIiGreRTCKJ/HIBScbLEtRsywqwG3trlDqYv4UguKy38iaGitANaUSvl2bm7BSpIP4GhKZUqAkWhC6Vi+YaqTMsOEXO/+rwjfsqgpVBcKVwW7JowoJqKdADH70yxhPFrVRUDVh7iN72SZm9Bl4z0tra9TqsJZkXPV8iIz7+PlYYsQWeytadMrhc8wfMaYgekAXEWuFO0pSFBbZKrKqvMBAufajd38I8vqa3vr/keDnaZ/8L7oImv9YSAO5FN3GJ/ksvifUrM+25N7ejgXaK89wOSGqM44PJLMDvv3SuiQGsXCuyRbu1CCDcYah4ygf/DYgSc0JI6kqAi8I2MFITzsgrmlLe4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199018)(46966006)(40470700004)(36840700001)(2906002)(1076003)(186003)(6666004)(2616005)(30864003)(26005)(5660300002)(82740400003)(47076005)(426003)(70206006)(70586007)(336012)(86362001)(36756003)(8936002)(7696005)(83380400001)(4326008)(478600001)(8676002)(82310400005)(40480700001)(356005)(110136005)(41300700001)(81166007)(54906003)(40460700003)(36860700001)(316002)(36900700001)(559001)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 16:53:17.8129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4eb76e-20ca-4cb5-35c9-08db0474d166
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5132
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename Audio buffer and soundwire manager instance registers.
Remove scratch registers as these registers can be accessed
using ACP_SCRATCH_REG_0 register relative offset.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 include/sound/acp63_chip_offset_byte.h | 751 ++++++++++---------------
 1 file changed, 294 insertions(+), 457 deletions(-)

diff --git a/include/sound/acp63_chip_offset_byte.h b/include/sound/acp63_chip_offset_byte.h
index c9260e1640ae..d746c1cb0163 100644
--- a/include/sound/acp63_chip_offset_byte.h
+++ b/include/sound/acp63_chip_offset_byte.h
@@ -126,24 +126,24 @@
 #define ACP_PAD_PULLDOWN_CTRL                         0x0001448
 #define ACP_PAD_DRIVE_STRENGTH_CTRL                   0x000144C
 #define ACP_PAD_SCHMEN_CTRL                           0x0001450
-#define ACP_SW_PAD_KEEPER_EN                          0x0001454
-#define ACP_SW_WAKE_EN                                0x0001458
+#define ACP_SW0_PAD_KEEPER_EN                         0x0001454
+#define ACP_SW0_WAKE_EN                               0x0001458
 #define ACP_I2S_WAKE_EN                               0x000145C
 #define ACP_SW1_WAKE_EN                               0x0001460
 
-#define ACP_SW_I2S_ERROR_REASON                       0x00018B4
-#define ACP_SW_POS_TRACK_I2S_TX_CTRL                  0x00018B8
-#define ACP_SW_I2S_TX_DMA_POS                         0x00018BC
-#define ACP_SW_POS_TRACK_BT_TX_CTRL                   0x00018C0
-#define ACP_SW_BT_TX_DMA_POS                          0x00018C4
-#define ACP_SW_POS_TRACK_HS_TX_CTRL                   0x00018C8
-#define ACP_SW_HS_TX_DMA_POS                          0x00018CC
-#define ACP_SW_POS_TRACK_I2S_RX_CTRL                  0x00018D0
-#define ACP_SW_I2S_RX_DMA_POS                         0x00018D4
-#define ACP_SW_POS_TRACK_BT_RX_CTRL                   0x00018D8
-#define ACP_SW_BT_RX_DMA_POS                          0x00018DC
-#define ACP_SW_POS_TRACK_HS_RX_CTRL                   0x00018E0
-#define ACP_SW_HS_RX_DMA_POS                          0x00018E4
+#define ACP_SW0_I2S_ERROR_REASON                      0x00018B4
+#define ACP_SW0_POS_TRACK_AUDIO0_TX_CTRL              0x00018B8
+#define ACP_SW0_AUDIO0_TX_DMA_POS                     0x00018BC
+#define ACP_SW0_POS_TRACK_AUDIO1_TX_CTRL              0x00018C0
+#define ACP_SW0_AUDIO1_TX_DMA_POS                     0x00018C4
+#define ACP_SW0_POS_TRACK_AUDIO2_TX_CTRL              0x00018C8
+#define ACP_SW0_AUDIO2_TX_DMA_POS                     0x00018CC
+#define ACP_SW0_POS_TRACK_AUDIO0_RX_CTRL              0x00018D0
+#define ACP_SW0_AUDIO0_DMA_POS                        0x00018D4
+#define ACP_SW0_POS_TRACK_AUDIO1_RX_CTRL              0x00018D8
+#define ACP_SW0_AUDIO1_RX_DMA_POS                     0x00018DC
+#define ACP_SW0_POS_TRACK_AUDIO2_RX_CTRL              0x00018E0
+#define ACP_SW0_AUDIO2_RX_DMA_POS                     0x00018E4
 #define ACP_ERROR_INTR_MASK1                          0X0001974
 #define ACP_ERROR_INTR_MASK2                          0X0001978
 #define ACP_ERROR_INTR_MASK3                          0X000197C
@@ -155,98 +155,80 @@
 #define ACP_EXTERNAL_INTR_STAT                        0x0001A0C
 #define ACP_EXTERNAL_INTR_STAT1                       0x0001A10
 #define ACP_ERROR_STATUS                              0x0001A4C
-#define ACP_P1_SW_I2S_ERROR_REASON                    0x0001A50
-#define ACP_P1_SW_POS_TRACK_I2S_TX_CTRL               0x0001A6C
-#define ACP_P1_SW_I2S_TX_DMA_POS                      0x0001A70
-#define ACP_P1_SW_POS_TRACK_I2S_RX_CTRL               0x0001A74
-#define ACP_P1_SW_I2S_RX_DMA_POS                      0x0001A78
+#define ACP_SW1_I2S_ERROR_REASON                      0x0001A50
+#define ACP_SW1_POS_TRACK_AUDIO0_TX_CTRL              0x0001A6C
+#define ACP_SW1_AUDIO0_TX_DMA_POS                     0x0001A70
+#define ACP_SW1_POS_TRACK_AUDIO0_RX_CTRL              0x0001A74
+#define ACP_SW1_AUDIO0_RX_DMA_POS                     0x0001A78
 #define ACP_P1_DMIC_I2S_GPIO_INTR_CTRL                0x0001A7C
 #define ACP_P1_DMIC_I2S_GPIO_INTR_STATUS              0x0001A80
 #define ACP_SCRATCH_REG_BASE_ADDR                     0x0001A84
-#define ACP_P1_SW_POS_TRACK_BT_TX_CTRL                0x0001A88
-#define ACP_P1_SW_BT_TX_DMA_POS                       0x0001A8C
-#define ACP_P1_SW_POS_TRACK_HS_TX_CTRL                0x0001A90
-#define ACP_P1_SW_HS_TX_DMA_POS                       0x0001A94
-#define ACP_P1_SW_POS_TRACK_BT_RX_CTRL                0x0001A98
-#define ACP_P1_SW_BT_RX_DMA_POS                       0x0001A9C
-#define ACP_P1_SW_POS_TRACK_HS_RX_CTRL                0x0001AA0
-#define ACP_P1_SW_HS_RX_DMA_POS                       0x0001AA4
+#define ACP_SW1_POS_TRACK_AUDIO1_TX_CTRL              0x0001A88
+#define ACP_SW1_AUDIO1_TX_DMA_POS                     0x0001A8C
+#define ACP_SW1_POS_TRACK_AUDIO2_TX_CTRL              0x0001A90
+#define ACP_SW1_AUDIO2_TX_DMA_POS                     0x0001A94
+#define ACP_SW1_POS_TRACK_AUDIO1_RX_CTRL              0x0001A98
+#define ACP_SW1_AUDIO1_RX_DMA_POS                     0x0001A9C
+#define ACP_SW1_POS_TRACK_AUDIO2_RX_CTRL              0x0001AA0
+#define ACP_SW1_AUDIO2_RX_DMA_POS                     0x0001AA4
 #define ACP_ERROR_INTR_MASK4                          0X0001AEC
 #define ACP_ERROR_INTR_MASK5                          0X0001AF0
 
 /* Registers from ACP_AUDIO_BUFFERS block */
-#define ACP_I2S_RX_RINGBUFADDR                        0x0002000
-#define ACP_I2S_RX_RINGBUFSIZE                        0x0002004
-#define ACP_I2S_RX_LINKPOSITIONCNTR                   0x0002008
-#define ACP_I2S_RX_FIFOADDR                           0x000200C
-#define ACP_I2S_RX_FIFOSIZE                           0x0002010
-#define ACP_I2S_RX_DMA_SIZE                           0x0002014
-#define ACP_I2S_RX_LINEARPOSITIONCNTR_HIGH            0x0002018
-#define ACP_I2S_RX_LINEARPOSITIONCNTR_LOW             0x000201C
-#define ACP_I2S_RX_INTR_WATERMARK_SIZE                0x0002020
-#define ACP_I2S_TX_RINGBUFADDR                        0x0002024
-#define ACP_I2S_TX_RINGBUFSIZE                        0x0002028
-#define ACP_I2S_TX_LINKPOSITIONCNTR                   0x000202C
-#define ACP_I2S_TX_FIFOADDR                           0x0002030
-#define ACP_I2S_TX_FIFOSIZE                           0x0002034
-#define ACP_I2S_TX_DMA_SIZE                           0x0002038
-#define ACP_I2S_TX_LINEARPOSITIONCNTR_HIGH            0x000203C
-#define ACP_I2S_TX_LINEARPOSITIONCNTR_LOW             0x0002040
-#define ACP_I2S_TX_INTR_WATERMARK_SIZE                0x0002044
-#define ACP_BT_RX_RINGBUFADDR                         0x0002048
-#define ACP_BT_RX_RINGBUFSIZE                         0x000204C
-#define ACP_BT_RX_LINKPOSITIONCNTR                    0x0002050
-#define ACP_BT_RX_FIFOADDR                            0x0002054
-#define ACP_BT_RX_FIFOSIZE                            0x0002058
-#define ACP_BT_RX_DMA_SIZE                            0x000205C
-#define ACP_BT_RX_LINEARPOSITIONCNTR_HIGH             0x0002060
-#define ACP_BT_RX_LINEARPOSITIONCNTR_LOW              0x0002064
-#define ACP_BT_RX_INTR_WATERMARK_SIZE                 0x0002068
-#define ACP_BT_TX_RINGBUFADDR                         0x000206C
-#define ACP_BT_TX_RINGBUFSIZE                         0x0002070
-#define ACP_BT_TX_LINKPOSITIONCNTR                    0x0002074
-#define ACP_BT_TX_FIFOADDR                            0x0002078
-#define ACP_BT_TX_FIFOSIZE                            0x000207C
-#define ACP_BT_TX_DMA_SIZE                            0x0002080
-#define ACP_BT_TX_LINEARPOSITIONCNTR_HIGH             0x0002084
-#define ACP_BT_TX_LINEARPOSITIONCNTR_LOW              0x0002088
-#define ACP_BT_TX_INTR_WATERMARK_SIZE                 0x000208C
-#define ACP_HS_RX_RINGBUFADDR                         0x0002090
-#define ACP_HS_RX_RINGBUFSIZE                         0x0002094
-#define ACP_HS_RX_LINKPOSITIONCNTR                    0x0002098
-#define ACP_HS_RX_FIFOADDR                            0x000209C
-#define ACP_HS_RX_FIFOSIZE                            0x00020A0
-#define ACP_HS_RX_DMA_SIZE                            0x00020A4
-#define ACP_HS_RX_LINEARPOSITIONCNTR_HIGH             0x00020A8
-#define ACP_HS_RX_LINEARPOSITIONCNTR_LOW              0x00020AC
-#define ACP_HS_RX_INTR_WATERMARK_SIZE                 0x00020B0
-#define ACP_HS_TX_RINGBUFADDR                         0x00020B4
-#define ACP_HS_TX_RINGBUFSIZE                         0x00020B8
-#define ACP_HS_TX_LINKPOSITIONCNTR                    0x00020BC
-#define ACP_HS_TX_FIFOADDR                            0x00020C0
-#define ACP_HS_TX_FIFOSIZE                            0x00020C4
-#define ACP_HS_TX_DMA_SIZE                            0x00020C8
-#define ACP_HS_TX_LINEARPOSITIONCNTR_HIGH             0x00020CC
-#define ACP_HS_TX_LINEARPOSITIONCNTR_LOW              0x00020D0
-#define ACP_HS_TX_INTR_WATERMARK_SIZE                 0x00020D4
-#define ACP_AUDIO_RX_RINGBUFADDR                   ACP_I2S_RX_RINGBUFADDR
-#define ACP_AUDIO_RX_RINGBUFSIZE                   ACP_I2S_RX_RINGBUFSIZE
-#define ACP_AUDIO_RX_LINKPOSITIONCNTR              ACP_I2S_RX_LINKPOSITIONCNTR
-#define ACP_AUDIO_RX_FIFOADDR                      ACP_I2S_RX_FIFOADDR
-#define ACP_AUDIO_RX_FIFOSIZE                      ACP_I2S_RX_FIFOSIZE
-#define ACP_AUDIO_RX_DMA_SIZE                      ACP_I2S_RX_DMA_SIZE
-#define ACP_AUDIO_RX_LINEARPOSITIONCNTR_HIGH       ACP_I2S_RX_LINEARPOSITIONCNTR_HIGH
-#define ACP_AUDIO_RX_LINEARPOSITIONCNTR_LOW        ACP_I2S_RX_LINEARPOSITIONCNTR_LOW
-#define ACP_AUDIO_RX_INTR_WATERMARK_SIZE           ACP_I2S_RX_INTR_WATERMARK_SIZE
-#define ACP_AUDIO_TX_RINGBUFADDR                   ACP_I2S_TX_RINGBUFADDR
-#define ACP_AUDIO_TX_RINGBUFSIZE                   ACP_I2S_TX_RINGBUFSIZE
-#define ACP_AUDIO_TX_LINKPOSITIONCNTR              ACP_I2S_TX_LINKPOSITIONCNTR
-#define ACP_AUDIO_TX_FIFOADDR                      ACP_I2S_TX_FIFOADDR
-#define ACP_AUDIO_TX_FIFOSIZE                      ACP_I2S_TX_FIFOSIZE
-#define ACP_AUDIO_TX_DMA_SIZE                      ACP_I2S_TX_DMA_SIZE
-#define ACP_AUDIO_TX_LINEARPOSITIONCNTR_HIGH       ACP_I2S_TX_LINEARPOSITIONCNTR_HIGH
-#define ACP_AUDIO_TX_LINEARPOSITIONCNTR_LOW        ACP_I2S_TX_LINEARPOSITIONCNTR_LOW
-#define ACP_AUDIO_TX_INTR_WATERMARK_SIZE           ACP_I2S_TX_INTR_WATERMARK_SIZE
+#define ACP_AUDIO0_RX_RINGBUFADDR                        0x0002000
+#define ACP_AUDIO0_RX_RINGBUFSIZE                        0x0002004
+#define ACP_AUDIO0_RX_LINKPOSITIONCNTR                   0x0002008
+#define ACP_AUDIO0_RX_FIFOADDR                           0x000200C
+#define ACP_AUDIO0_RX_FIFOSIZE                           0x0002010
+#define ACP_AUDIO0_RX_DMA_SIZE                           0x0002014
+#define ACP_AUDIO0_RX_LINEARPOSITIONCNTR_HIGH            0x0002018
+#define ACP_AUDIO0_RX_LINEARPOSITIONCNTR_LOW             0x000201C
+#define ACP_AUDIO0_RX_INTR_WATERMARK_SIZE                0x0002020
+#define ACP_AUDIO0_TX_RINGBUFADDR                        0x0002024
+#define ACP_AUDIO0_TX_RINGBUFSIZE                        0x0002028
+#define ACP_AUDIO0_TX_LINKPOSITIONCNTR                   0x000202C
+#define ACP_AUDIO0_TX_FIFOADDR                           0x0002030
+#define ACP_AUDIO0_TX_FIFOSIZE                           0x0002034
+#define ACP_AUDIO0_TX_DMA_SIZE                           0x0002038
+#define ACP_AUDIO0_TX_LINEARPOSITIONCNTR_HIGH            0x000203C
+#define ACP_AUDIO0_TX_LINEARPOSITIONCNTR_LOW             0x0002040
+#define ACP_AUDIO0_TX_INTR_WATERMARK_SIZE                0x0002044
+#define ACP_AUDIO1_RX_RINGBUFADDR                        0x0002048
+#define ACP_AUDIO1_RX_RINGBUFSIZE                        0x000204C
+#define ACP_AUDIO1_RX_LINKPOSITIONCNTR                   0x0002050
+#define ACP_AUDIO1_RX_FIFOADDR                           0x0002054
+#define ACP_AUDIO1_RX_FIFOSIZE                           0x0002058
+#define ACP_AUDIO1_RX_DMA_SIZE                           0x000205C
+#define ACP_AUDIO1_RX_LINEARPOSITIONCNTR_HIGH            0x0002060
+#define ACP_AUDIO1_RX_LINEARPOSITIONCNTR_LOW             0x0002064
+#define ACP_AUDIO1_RX_INTR_WATERMARK_SIZE                0x0002068
+#define ACP_AUDIO1_TX_RINGBUFADDR                        0x000206C
+#define ACP_AUDIO1_TX_RINGBUFSIZE                        0x0002070
+#define ACP_AUDIO1_TX_LINKPOSITIONCNTR                   0x0002074
+#define ACP_AUDIO1_TX_FIFOADDR                           0x0002078
+#define ACP_AUDIO1_TX_FIFOSIZE                           0x000207C
+#define ACP_AUDIO1_TX_DMA_SIZE                           0x0002080
+#define ACP_AUDIO1_TX_LINEARPOSITIONCNTR_HIGH            0x0002084
+#define ACP_AUDIO1_TX_LINEARPOSITIONCNTR_LOW             0x0002088
+#define ACP_AUDIO1_TX_INTR_WATERMARK_SIZE                0x000208C
+#define ACP_AUDIO2_RX_RINGBUFADDR                        0x0002090
+#define ACP_AUDIO2_RX_RINGBUFSIZE                        0x0002094
+#define ACP_AUDIO2_RX_LINKPOSITIONCNTR                   0x0002098
+#define ACP_AUDIO2_RX_FIFOADDR                           0x000209C
+#define ACP_AUDIO2_RX_FIFOSIZE                           0x00020A0
+#define ACP_AUDIO2_RX_DMA_SIZE                           0x00020A4
+#define ACP_AUDIO2_RX_LINEARPOSITIONCNTR_HIGH            0x00020A8
+#define ACP_AUDIO2_RX_LINEARPOSITIONCNTR_LOW             0x00020AC
+#define ACP_AUDIO2_RX_INTR_WATERMARK_SIZE                0x00020B0
+#define ACP_AUDIO2_TX_RINGBUFADDR                        0x00020B4
+#define ACP_AUDIO2_TX_RINGBUFSIZE                        0x00020B8
+#define ACP_AUDIO2_TX_LINKPOSITIONCNTR                   0x00020BC
+#define ACP_AUDIO2_TX_FIFOADDR                           0x00020C0
+#define ACP_AUDIO2_TX_FIFOSIZE                           0x00020C4
+#define ACP_AUDIO2_TX_DMA_SIZE                           0x00020C8
+#define ACP_AUDIO2_TX_LINEARPOSITIONCNTR_HIGH            0x00020CC
+#define ACP_AUDIO2_TX_LINEARPOSITIONCNTR_LOW             0x00020D0
+#define ACP_AUDIO2_TX_INTR_WATERMARK_SIZE                0x00020D4
 
 /* Registers from ACP_I2S_TDM block */
 #define ACP_I2STDM_IER                                0x0002400
@@ -292,367 +274,222 @@
 #define ACP_WOV_ERROR_STATUS_REGISTER                 0x0002C68
 #define ACP_PDM_CLKDIV                                0x0002C6C
 
-/* Registers from ACP_SW_SWCLK block */
-#define ACP_SW_EN                                     0x0003000
-#define ACP_SW_EN_STATUS                              0x0003004
-#define ACP_SW_FRAMESIZE                              0x0003008
-#define ACP_SW_SSP_COUNTER                            0x000300C
-#define ACP_SW_AUDIO_TX_EN                            0x0003010
-#define ACP_SW_AUDIO_TX_EN_STATUS                     0x0003014
-#define ACP_SW_AUDIO_TX_FRAME_FORMAT                  0x0003018
-#define ACP_SW_AUDIO_TX_SAMPLEINTERVAL                0x000301C
-#define ACP_SW_AUDIO_TX_HCTRL_DP0                     0x0003020
-#define ACP_SW_AUDIO_TX_HCTRL_DP1                     0x0003024
-#define ACP_SW_AUDIO_TX_HCTRL_DP2                     0x0003028
-#define ACP_SW_AUDIO_TX_HCTRL_DP3                     0x000302C
-#define ACP_SW_AUDIO_TX_OFFSET_DP0                    0x0003030
-#define ACP_SW_AUDIO_TX_OFFSET_DP1                    0x0003034
-#define ACP_SW_AUDIO_TX_OFFSET_DP2                    0x0003038
-#define ACP_SW_AUDIO_TX_OFFSET_DP3                    0x000303C
-#define ACP_SW_AUDIO_TX_CHANNEL_ENABLE_DP0            0x0003040
-#define ACP_SW_AUDIO_TX_CHANNEL_ENABLE_DP1            0x0003044
-#define ACP_SW_AUDIO_TX_CHANNEL_ENABLE_DP2            0x0003048
-#define ACP_SW_AUDIO_TX_CHANNEL_ENABLE_DP3            0x000304C
-#define ACP_SW_BT_TX_EN                               0x0003050
-#define ACP_SW_BT_TX_EN_STATUS                        0x0003054
-#define ACP_SW_BT_TX_FRAME_FORMAT                     0x0003058
-#define ACP_SW_BT_TX_SAMPLEINTERVAL                   0x000305C
-#define ACP_SW_BT_TX_HCTRL                            0x0003060
-#define ACP_SW_BT_TX_OFFSET                           0x0003064
-#define ACP_SW_BT_TX_CHANNEL_ENABLE_DP0               0x0003068
-#define ACP_SW_HEADSET_TX_EN                          0x000306C
-#define ACP_SW_HEADSET_TX_EN_STATUS                   0x0003070
-#define ACP_SW_HEADSET_TX_FRAME_FORMAT                0x0003074
-#define ACP_SW_HEADSET_TX_SAMPLEINTERVAL              0x0003078
-#define ACP_SW_HEADSET_TX_HCTRL                       0x000307C
-#define ACP_SW_HEADSET_TX_OFFSET                      0x0003080
-#define ACP_SW_HEADSET_TX_CHANNEL_ENABLE_DP0          0x0003084
-#define ACP_SW_AUDIO_RX_EN                            0x0003088
-#define ACP_SW_AUDIO_RX_EN_STATUS                     0x000308C
-#define ACP_SW_AUDIO_RX_FRAME_FORMAT                  0x0003090
-#define ACP_SW_AUDIO_RX_SAMPLEINTERVAL                0x0003094
-#define ACP_SW_AUDIO_RX_HCTRL_DP0                     0x0003098
-#define ACP_SW_AUDIO_RX_HCTRL_DP1                     0x000309C
-#define ACP_SW_AUDIO_RX_HCTRL_DP2                     0x0003100
-#define ACP_SW_AUDIO_RX_HCTRL_DP3                     0x0003104
-#define ACP_SW_AUDIO_RX_OFFSET_DP0                    0x0003108
-#define ACP_SW_AUDIO_RX_OFFSET_DP1                    0x000310C
-#define ACP_SW_AUDIO_RX_OFFSET_DP2                    0x0003110
-#define ACP_SW_AUDIO_RX_OFFSET_DP3                    0x0003114
-#define ACP_SW_AUDIO_RX_CHANNEL_ENABLE_DP0            0x0003118
-#define ACP_SW_AUDIO_RX_CHANNEL_ENABLE_DP1            0x000311C
-#define ACP_SW_AUDIO_RX_CHANNEL_ENABLE_DP2            0x0003120
-#define ACP_SW_AUDIO_RX_CHANNEL_ENABLE_DP3            0x0003124
-#define ACP_SW_BT_RX_EN                               0x0003128
-#define ACP_SW_BT_RX_EN_STATUS                        0x000312C
-#define ACP_SW_BT_RX_FRAME_FORMAT                     0x0003130
-#define ACP_SW_BT_RX_SAMPLEINTERVAL                   0x0003134
-#define ACP_SW_BT_RX_HCTRL                            0x0003138
-#define ACP_SW_BT_RX_OFFSET                           0x000313C
-#define ACP_SW_BT_RX_CHANNEL_ENABLE_DP0               0x0003140
-#define ACP_SW_HEADSET_RX_EN                          0x0003144
-#define ACP_SW_HEADSET_RX_EN_STATUS                   0x0003148
-#define ACP_SW_HEADSET_RX_FRAME_FORMAT                0x000314C
-#define ACP_SW_HEADSET_RX_SAMPLEINTERVAL              0x0003150
-#define ACP_SW_HEADSET_RX_HCTRL                       0x0003154
-#define ACP_SW_HEADSET_RX_OFFSET                      0x0003158
-#define ACP_SW_HEADSET_RX_CHANNEL_ENABLE_DP0          0x000315C
-#define ACP_SW_BPT_PORT_EN                            0x0003160
-#define ACP_SW_BPT_PORT_EN_STATUS                     0x0003164
-#define ACP_SW_BPT_PORT_FRAME_FORMAT                  0x0003168
-#define ACP_SW_BPT_PORT_SAMPLEINTERVAL                0x000316C
-#define ACP_SW_BPT_PORT_HCTRL                         0x0003170
-#define ACP_SW_BPT_PORT_OFFSET                        0x0003174
-#define ACP_SW_BPT_PORT_CHANNEL_ENABLE                0x0003178
-#define ACP_SW_BPT_PORT_FIRST_BYTE_ADDR               0x000317C
-#define ACP_SW_CLK_RESUME_CTRL                        0x0003180
-#define ACP_SW_CLK_RESUME_DELAY_CNTR                  0x0003184
-#define ACP_SW_BUS_RESET_CTRL                         0x0003188
-#define ACP_SW_PRBS_ERR_STATUS                        0x000318C
-#define SW_IMM_CMD_UPPER_WORD                         0x0003230
-#define SW_IMM_CMD_LOWER_QWORD                        0x0003234
-#define SW_IMM_RESP_UPPER_WORD                        0x0003238
-#define SW_IMM_RESP_LOWER_QWORD                       0x000323C
-#define SW_IMM_CMD_STS                                0x0003240
-#define SW_BRA_BASE_ADDRESS                           0x0003244
-#define SW_BRA_TRANSFER_SIZE                          0x0003248
-#define SW_BRA_DMA_BUSY                               0x000324C
-#define SW_BRA_RESP                                   0x0003250
-#define SW_BRA_RESP_FRAME_ADDR                        0x0003254
-#define SW_BRA_CURRENT_TRANSFER_SIZE                  0x0003258
-#define SW_STATE_CHANGE_STATUS_0TO7                   0x000325C
-#define SW_STATE_CHANGE_STATUS_8TO11                  0x0003260
-#define SW_STATE_CHANGE_STATUS_MASK_0TO7              0x0003264
-#define SW_STATE_CHANGE_STATUS_MASK_8TO11             0x0003268
-#define SW_CLK_FREQUENCY_CTRL                         0x000326C
-#define SW_ERROR_INTR_MASK                            0x0003270
-#define SW_PHY_TEST_MODE_DATA_OFF                     0x0003274
+/* Registers from ACP_SW0_SWCLK block */
+#define ACP_SW0_EN                                     0x0003000
+#define ACP_SW0_EN_STATUS                              0x0003004
+#define ACP_SW0_FRAMESIZE                              0x0003008
+#define ACP_SW0_SSP_COUNTER                            0x000300C
+#define ACP_SW0_AUDIO0_TX_EN                           0x0003010
+#define ACP_SW0_AUDIO0_TX_EN_STATUS                    0x0003014
+#define ACP_SW0_AUDIO0_TX_FRAME_FORMAT                 0x0003018
+#define ACP_SW0_AUDIO0_TX_SAMPLEINTERVAL               0x000301C
+#define ACP_SW0_AUDIO0_TX_HCTRL_DP0                    0x0003020
+#define ACP_SW0_AUDIO0_TX_HCTRL_DP1                    0x0003024
+#define ACP_SW0_AUDIO0_TX_HCTRL_DP2                    0x0003028
+#define ACP_SW0_AUDIO0_TX_HCTRL_DP3                    0x000302C
+#define ACP_SW0_AUDIO0_TX_OFFSET_DP0                   0x0003030
+#define ACP_SW0_AUDIO0_TX_OFFSET_DP1                   0x0003034
+#define ACP_SW0_AUDIO0_TX_OFFSET_DP2                   0x0003038
+#define ACP_SW0_AUDIO0_TX_OFFSET_DP3                   0x000303C
+#define ACP_SW0_AUDIO0_TX_CHANNEL_ENABLE_DP0           0x0003040
+#define ACP_SW0_AUDIO0_TX_CHANNEL_ENABLE_DP1           0x0003044
+#define ACP_SW0_AUDIO0_TX_CHANNEL_ENABLE_DP2           0x0003048
+#define ACP_SW0_AUDIO0_TX_CHANNEL_ENABLE_DP3           0x000304C
+#define ACP_SW0_AUDIO1_TX_EN                           0x0003050
+#define ACP_SW0_AUDIO1_TX_EN_STATUS                    0x0003054
+#define ACP_SW0_AUDIO1_TX_FRAME_FORMAT                 0x0003058
+#define ACP_SW0_AUDIO1_TX_SAMPLEINTERVAL               0x000305C
+#define ACP_SW0_AUDIO1_TX_HCTRL                        0x0003060
+#define ACP_SW0_AUDIO1_TX_OFFSET                       0x0003064
+#define ACP_SW0_AUDIO1_TX_CHANNEL_ENABLE_DP0           0x0003068
+#define ACP_SW0_AUDIO2_TX_EN                           0x000306C
+#define ACP_SW0_AUDIO2_TX_EN_STATUS                    0x0003070
+#define ACP_SW0_AUDIO2_TX_FRAME_FORMAT                 0x0003074
+#define ACP_SW0_AUDIO2_TX_SAMPLEINTERVAL               0x0003078
+#define ACP_SW0_AUDIO2_TX_HCTRL                        0x000307C
+#define ACP_SW0_AUDIO2_TX_OFFSET                       0x0003080
+#define ACP_SW0_AUDIO2_TX_CHANNEL_ENABLE_DP0           0x0003084
+#define ACP_SW0_AUDIO0_RX_EN                           0x0003088
+#define ACP_SW0_AUDIO0_RX_EN_STATUS                    0x000308C
+#define ACP_SW0_AUDIO0_RX_FRAME_FORMAT                 0x0003090
+#define ACP_SW0_AUDIO0_RX_SAMPLEINTERVAL               0x0003094
+#define ACP_SW0_AUDIO0_RX_HCTRL_DP0                    0x0003098
+#define ACP_SW0_AUDIO0_RX_HCTRL_DP1                    0x000309C
+#define ACP_SW0_AUDIO0_RX_HCTRL_DP2                    0x0003100
+#define ACP_SW0_AUDIO0_RX_HCTRL_DP3                    0x0003104
+#define ACP_SW0_AUDIO0_RX_OFFSET_DP0                   0x0003108
+#define ACP_SW0_AUDIO0_RX_OFFSET_DP1                   0x000310C
+#define ACP_SW0_AUDIO0_RX_OFFSET_DP2                   0x0003110
+#define ACP_SW0_AUDIO0_RX_OFFSET_DP3                   0x0003114
+#define ACP_SW0_AUDIO0_RX_CHANNEL_ENABLE_DP0           0x0003118
+#define ACP_SW0_AUDIO0_RX_CHANNEL_ENABLE_DP1           0x000311C
+#define ACP_SW0_AUDIO0_RX_CHANNEL_ENABLE_DP2           0x0003120
+#define ACP_SW0_AUDIO0_RX_CHANNEL_ENABLE_DP3           0x0003124
+#define ACP_SW0_AUDIO1_RX_EN                           0x0003128
+#define ACP_SW0_AUDIO1_RX_EN_STATUS                    0x000312C
+#define ACP_SW0_AUDIO1_RX_FRAME_FORMAT                 0x0003130
+#define ACP_SW0_AUDIO1_RX_SAMPLEINTERVAL               0x0003134
+#define ACP_SW0_AUDIO1_RX_HCTRL                        0x0003138
+#define ACP_SW0_AUDIO1_RX_OFFSET                       0x000313C
+#define ACP_SW0_AUDIO1_RX_CHANNEL_ENABLE_DP0           0x0003140
+#define ACP_SW0_AUDIO2_RX_EN                           0x0003144
+#define ACP_SW0_AUDIO2_RX_EN_STATUS                    0x0003148
+#define ACP_SW0_AUDIO2_RX_FRAME_FORMAT                 0x000314C
+#define ACP_SW0_AUDIO2_RX_SAMPLEINTERVAL               0x0003150
+#define ACP_SW0_AUDIO2_RX_HCTRL                        0x0003154
+#define ACP_SW0_AUDIO2_RX_OFFSET                       0x0003158
+#define ACP_SW0_AUDIO2_RX_CHANNEL_ENABLE_DP0           0x000315C
+#define ACP_SW0_BPT_PORT_EN                            0x0003160
+#define ACP_SW0_BPT_PORT_EN_STATUS                     0x0003164
+#define ACP_SW0_BPT_PORT_FRAME_FORMAT                  0x0003168
+#define ACP_SW0_BPT_PORT_SAMPLEINTERVAL                0x000316C
+#define ACP_SW0_BPT_PORT_HCTRL                         0x0003170
+#define ACP_SW0_BPT_PORT_OFFSET                        0x0003174
+#define ACP_SW0_BPT_PORT_CHANNEL_ENABLE                0x0003178
+#define ACP_SW0_BPT_PORT_FIRST_BYTE_ADDR               0x000317C
+#define ACP_SW0_CLK_RESUME_CTRL                        0x0003180
+#define ACP_SW0_CLK_RESUME_DELAY_CNTR                  0x0003184
+#define ACP_SW0_BUS_RESET_CTRL                         0x0003188
+#define ACP_SW0_PRBS_ERR_STATUS                        0x000318C
+#define ACP_SW0_IMM_CMD_UPPER_WORD                     0x0003230
+#define ACP_SW0_IMM_CMD_LOWER_QWORD                    0x0003234
+#define ACP_SW0_IMM_RESP_UPPER_WORD                    0x0003238
+#define ACP_SW0_IMM_RESP_LOWER_QWORD                   0x000323C
+#define ACP_SW0_IMM_CMD_STS                            0x0003240
+#define ACP_SW0_BRA_BASE_ADDRESS                       0x0003244
+#define ACP_SW0_BRA_TRANSFER_SIZE                      0x0003248
+#define ACP_SW0_BRA_DMA_BUSY                           0x000324C
+#define ACP_SW0_BRA_RESP                               0x0003250
+#define ACP_SW0_BRA_RESP_FRAME_ADDR                    0x0003254
+#define ACP_SW0_BRA_CURRENT_TRANSFER_SIZE              0x0003258
+#define ACP_SW0_STATECHANGE_STATUS_0TO7                0x000325C
+#define ACP_SW0_STATECHANGE_STATUS_8TO11               0x0003260
+#define ACP_SW0_STATECHANGE_STATUS_MASK_0TO7           0x0003264
+#define ACP_SW0_STATECHANGE_STATUS_MASK_8TO11          0x0003268
+#define ACP_SW0_CLK_FREQUENCY_CTRL                     0x000326C
+#define ACP_SW0_ERROR_INTR_MASK                        0x0003270
+#define ACP_SW0_PHY_TEST_MODE_DATA_OFF                 0x0003274
 
 /* Registers from ACP_P1_AUDIO_BUFFERS block */
-#define ACP_P1_I2S_RX_RINGBUFADDR                     0x0003A00
-#define ACP_P1_I2S_RX_RINGBUFSIZE                     0x0003A04
-#define ACP_P1_I2S_RX_LINKPOSITIONCNTR                0x0003A08
-#define ACP_P1_I2S_RX_FIFOADDR                        0x0003A0C
-#define ACP_P1_I2S_RX_FIFOSIZE                        0x0003A10
-#define ACP_P1_I2S_RX_DMA_SIZE                        0x0003A14
-#define ACP_P1_I2S_RX_LINEARPOSITIONCNTR_HIGH         0x0003A18
-#define ACP_P1_I2S_RX_LINEARPOSITIONCNTR_LOW          0x0003A1C
-#define ACP_P1_I2S_RX_INTR_WATERMARK_SIZE             0x0003A20
-#define ACP_P1_I2S_TX_RINGBUFADDR                     0x0003A24
-#define ACP_P1_I2S_TX_RINGBUFSIZE                     0x0003A28
-#define ACP_P1_I2S_TX_LINKPOSITIONCNTR                0x0003A2C
-#define ACP_P1_I2S_TX_FIFOADDR                        0x0003A30
-#define ACP_P1_I2S_TX_FIFOSIZE                        0x0003A34
-#define ACP_P1_I2S_TX_DMA_SIZE                        0x0003A38
-#define ACP_P1_I2S_TX_LINEARPOSITIONCNTR_HIGH         0x0003A3C
-#define ACP_P1_I2S_TX_LINEARPOSITIONCNTR_LOW          0x0003A40
-#define ACP_P1_I2S_TX_INTR_WATERMARK_SIZE             0x0003A44
-#define ACP_P1_BT_RX_RINGBUFADDR                      0x0003A48
-#define ACP_P1_BT_RX_RINGBUFSIZE                      0x0003A4C
-#define ACP_P1_BT_RX_LINKPOSITIONCNTR                 0x0003A50
-#define ACP_P1_BT_RX_FIFOADDR                         0x0003A54
-#define ACP_P1_BT_RX_FIFOSIZE                         0x0003A58
-#define ACP_P1_BT_RX_DMA_SIZE                         0x0003A5C
-#define ACP_P1_BT_RX_LINEARPOSITIONCNTR_HIGH          0x0003A60
-#define ACP_P1_BT_RX_LINEARPOSITIONCNTR_LOW           0x0003A64
-#define ACP_P1_BT_RX_INTR_WATERMARK_SIZE              0x0003A68
-#define ACP_P1_BT_TX_RINGBUFADDR                      0x0003A6C
-#define ACP_P1_BT_TX_RINGBUFSIZE                      0x0003A70
-#define ACP_P1_BT_TX_LINKPOSITIONCNTR                 0x0003A74
-#define ACP_P1_BT_TX_FIFOADDR                         0x0003A78
-#define ACP_P1_BT_TX_FIFOSIZE                         0x0003A7C
-#define ACP_P1_BT_TX_DMA_SIZE                         0x0003A80
-#define ACP_P1_BT_TX_LINEARPOSITIONCNTR_HIGH          0x0003A84
-#define ACP_P1_BT_TX_LINEARPOSITIONCNTR_LOW           0x0003A88
-#define ACP_P1_BT_TX_INTR_WATERMARK_SIZE              0x0003A8C
-#define ACP_P1_HS_RX_RINGBUFADDR                      0x0003A90
-#define ACP_P1_HS_RX_RINGBUFSIZE                      0x0003A94
-#define ACP_P1_HS_RX_LINKPOSITIONCNTR                 0x0003A98
-#define ACP_P1_HS_RX_FIFOADDR                         0x0003A9C
-#define ACP_P1_HS_RX_FIFOSIZE                         0x0003AA0
-#define ACP_P1_HS_RX_DMA_SIZE                         0x0003AA4
-#define ACP_P1_HS_RX_LINEARPOSITIONCNTR_HIGH          0x0003AA8
-#define ACP_P1_HS_RX_LINEARPOSITIONCNTR_LOW           0x0003AAC
-#define ACP_P1_HS_RX_INTR_WATERMARK_SIZE              0x0003AB0
-#define ACP_P1_HS_TX_RINGBUFADDR                      0x0003AB4
-#define ACP_P1_HS_TX_RINGBUFSIZE                      0x0003AB8
-#define ACP_P1_HS_TX_LINKPOSITIONCNTR                 0x0003ABC
-#define ACP_P1_HS_TX_FIFOADDR                         0x0003AC0
-#define ACP_P1_HS_TX_FIFOSIZE                         0x0003AC4
-#define ACP_P1_HS_TX_DMA_SIZE                         0x0003AC8
-#define ACP_P1_HS_TX_LINEARPOSITIONCNTR_HIGH          0x0003ACC
-#define ACP_P1_HS_TX_LINEARPOSITIONCNTR_LOW           0x0003AD0
-#define ACP_P1_HS_TX_INTR_WATERMARK_SIZE              0x0003AD4
-#define ACP_P1_AUDIO_RX_RINGBUFADDR                   ACP_P1_I2S_RX_RINGBUFADDR
-#define ACP_P1_AUDIO_RX_RINGBUFSIZE                   ACP_P1_I2S_RX_RINGBUFSIZE
-#define ACP_P1_AUDIO_RX_LINKPOSITIONCNTR              ACP_P1_I2S_RX_LINKPOSITIONCNTR
-#define ACP_P1_AUDIO_RX_FIFOADDR                      ACP_P1_I2S_RX_FIFOADDR
-#define ACP_P1_AUDIO_RX_FIFOSIZE                      ACP_P1_I2S_RX_FIFOSIZE
-#define ACP_P1_AUDIO_RX_DMA_SIZE                      ACP_P1_I2S_RX_DMA_SIZE
-#define ACP_P1_AUDIO_RX_LINEARPOSITIONCNTR_HIGH       ACP_P1_I2S_RX_LINEARPOSITIONCNTR_HIGH
-#define ACP_P1_AUDIO_RX_LINEARPOSITIONCNTR_LOW        ACP_P1_I2S_RX_LINEARPOSITIONCNTR_LOW
-#define ACP_P1_AUDIO_RX_INTR_WATERMARK_SIZE           ACP_P1_I2S_RX_INTR_WATERMARK_SIZE
-#define ACP_P1_AUDIO_TX_RINGBUFADDR                   ACP_P1_I2S_TX_RINGBUFADDR
-#define ACP_P1_AUDIO_TX_RINGBUFSIZE                   ACP_P1_I2S_TX_RINGBUFSIZE
-#define ACP_P1_AUDIO_TX_LINKPOSITIONCNTR              ACP_P1_I2S_TX_LINKPOSITIONCNTR
-#define ACP_P1_AUDIO_TX_FIFOADDR                      ACP_P1_I2S_TX_FIFOADDR
-#define ACP_P1_AUDIO_TX_FIFOSIZE                      ACP_P1_I2S_TX_FIFOSIZE
-#define ACP_P1_AUDIO_TX_DMA_SIZE                      ACP_P1_I2S_TX_DMA_SIZE
-#define ACP_P1_AUDIO_TX_LINEARPOSITIONCNTR_HIGH       ACP_P1_I2S_TX_LINEARPOSITIONCNTR_HIGH
-#define ACP_P1_AUDIO_TX_LINEARPOSITIONCNTR_LOW        ACP_P1_I2S_TX_LINEARPOSITIONCNTR_LOW
-#define ACP_P1_AUDIO_TX_INTR_WATERMARK_SIZE           ACP_P1_I2S_TX_INTR_WATERMARK_SIZE
+#define ACP_P1_AUDIO0_RX_RINGBUFADDR                     0x0003A00
+#define ACP_P1_AUDIO0_RX_RINGBUFSIZE                     0x0003A04
+#define ACP_P1_AUDIO0_RX_LINKPOSITIONCNTR                0x0003A08
+#define ACP_P1_AUDIO0_RX_FIFOADDR                        0x0003A0C
+#define ACP_P1_AUDIO0_RX_FIFOSIZE                        0x0003A10
+#define ACP_P1_AUDIO0_RX_DMA_SIZE                        0x0003A14
+#define ACP_P1_AUDIO0_RX_LINEARPOSITIONCNTR_HIGH         0x0003A18
+#define ACP_P1_AUDIO0_RX_LINEARPOSITIONCNTR_LOW          0x0003A1C
+#define ACP_P1_AUDIO0_RX_INTR_WATERMARK_SIZE             0x0003A20
+#define ACP_P1_AUDIO0_TX_RINGBUFADDR                     0x0003A24
+#define ACP_P1_AUDIO0_TX_RINGBUFSIZE                     0x0003A28
+#define ACP_P1_AUDIO0_TX_LINKPOSITIONCNTR                0x0003A2C
+#define ACP_P1_AUDIO0_TX_FIFOADDR                        0x0003A30
+#define ACP_P1_AUDIO0_TX_FIFOSIZE                        0x0003A34
+#define ACP_P1_AUDIO0_TX_DMA_SIZE                        0x0003A38
+#define ACP_P1_AUDIO0_TX_LINEARPOSITIONCNTR_HIGH         0x0003A3C
+#define ACP_P1_AUDIO0_TX_LINEARPOSITIONCNTR_LOW          0x0003A40
+#define ACP_P1_AUDIO0_TX_INTR_WATERMARK_SIZE             0x0003A44
+#define ACP_P1_AUDIO1_RX_RINGBUFADDR                     0x0003A48
+#define ACP_P1_AUDIO1_RX_RINGBUFSIZE                     0x0003A4C
+#define ACP_P1_AUDIO1_RX_LINKPOSITIONCNTR                0x0003A50
+#define ACP_P1_AUDIO1_RX_FIFOADDR                        0x0003A54
+#define ACP_P1_AUDIO1_RX_FIFOSIZE                        0x0003A58
+#define ACP_P1_AUDIO1_RX_DMA_SIZE                        0x0003A5C
+#define ACP_P1_AUDIO1_RX_LINEARPOSITIONCNTR_HIGH         0x0003A60
+#define ACP_P1_AUDIO1_RX_LINEARPOSITIONCNTR_LOW          0x0003A64
+#define ACP_P1_AUDIO1_RX_INTR_WATERMARK_SIZE             0x0003A68
+#define ACP_P1_AUDIO1_TX_RINGBUFADDR                     0x0003A6C
+#define ACP_P1_AUDIO1_TX_RINGBUFSIZE                     0x0003A70
+#define ACP_P1_AUDIO1_TX_LINKPOSITIONCNTR                0x0003A74
+#define ACP_P1_AUDIO1_TX_FIFOADDR                        0x0003A78
+#define ACP_P1_AUDIO1_TX_FIFOSIZE                        0x0003A7C
+#define ACP_P1_AUDIO1_TX_DMA_SIZE                        0x0003A80
+#define ACP_P1_AUDIO1_TX_LINEARPOSITIONCNTR_HIGH         0x0003A84
+#define ACP_P1_AUDIO1_TX_LINEARPOSITIONCNTR_LOW          0x0003A88
+#define ACP_P1_AUDIO1_TX_INTR_WATERMARK_SIZE             0x0003A8C
+#define ACP_P1_AUDIO2_RX_RINGBUFADDR                     0x0003A90
+#define ACP_P1_AUDIO2_RX_RINGBUFSIZE                     0x0003A94
+#define ACP_P1_AUDIO2_RX_LINKPOSITIONCNTR                0x0003A98
+#define ACP_P1_AUDIO2_RX_FIFOADDR                        0x0003A9C
+#define ACP_P1_AUDIO2_RX_FIFOSIZE                        0x0003AA0
+#define ACP_P1_AUDIO2_RX_DMA_SIZE                        0x0003AA4
+#define ACP_P1_AUDIO2_RX_LINEARPOSITIONCNTR_HIGH         0x0003AA8
+#define ACP_P1_AUDIO2_RX_LINEARPOSITIONCNTR_LOW          0x0003AAC
+#define ACP_P1_AUDIO2_RX_INTR_WATERMARK_SIZE             0x0003AB0
+#define ACP_P1_AUDIO2_TX_RINGBUFADDR                     0x0003AB4
+#define ACP_P1_AUDIO2_TX_RINGBUFSIZE                     0x0003AB8
+#define ACP_P1_AUDIO2_TX_LINKPOSITIONCNTR                0x0003ABC
+#define ACP_P1_AUDIO2_TX_FIFOADDR                        0x0003AC0
+#define ACP_P1_AUDIO2_TX_FIFOSIZE                        0x0003AC4
+#define ACP_P1_AUDIO2_TX_DMA_SIZE                        0x0003AC8
+#define ACP_P1_AUDIO2_TX_LINEARPOSITIONCNTR_HIGH         0x0003ACC
+#define ACP_P1_AUDIO2_TX_LINEARPOSITIONCNTR_LOW          0x0003AD0
+#define ACP_P1_AUDIO2_TX_INTR_WATERMARK_SIZE             0x0003AD4
 
-/* Registers from ACP_P1_SW_SWCLK block */
-#define ACP_P1_SW_EN                                  0x0003C00
-#define ACP_P1_SW_EN_STATUS                           0x0003C04
-#define ACP_P1_SW_FRAMESIZE                           0x0003C08
-#define ACP_P1_SW_SSP_COUNTER                         0x0003C0C
-#define ACP_P1_SW_BT_TX_EN                            0x0003C50
-#define ACP_P1_SW_BT_TX_EN_STATUS                     0x0003C54
-#define ACP_P1_SW_BT_TX_FRAME_FORMAT                  0x0003C58
-#define ACP_P1_SW_BT_TX_SAMPLEINTERVAL                0x0003C5C
-#define ACP_P1_SW_BT_TX_HCTRL                         0x0003C60
-#define ACP_P1_SW_BT_TX_OFFSET                        0x0003C64
-#define ACP_P1_SW_BT_TX_CHANNEL_ENABLE_DP0            0x0003C68
-#define ACP_P1_SW_BT_RX_EN                            0x0003D28
-#define ACP_P1_SW_BT_RX_EN_STATUS                     0x0003D2C
-#define ACP_P1_SW_BT_RX_FRAME_FORMAT                  0x0003D30
-#define ACP_P1_SW_BT_RX_SAMPLEINTERVAL                0x0003D34
-#define ACP_P1_SW_BT_RX_HCTRL                         0x0003D38
-#define ACP_P1_SW_BT_RX_OFFSET                        0x0003D3C
-#define ACP_P1_SW_BT_RX_CHANNEL_ENABLE_DP0            0x0003D40
-#define ACP_P1_SW_BPT_PORT_EN                         0x0003D60
-#define ACP_P1_SW_BPT_PORT_EN_STATUS                  0x0003D64
-#define ACP_P1_SW_BPT_PORT_FRAME_FORMAT               0x0003D68
-#define ACP_P1_SW_BPT_PORT_SAMPLEINTERVAL             0x0003D6C
-#define ACP_P1_SW_BPT_PORT_HCTRL                      0x0003D70
-#define ACP_P1_SW_BPT_PORT_OFFSET                     0x0003D74
-#define ACP_P1_SW_BPT_PORT_CHANNEL_ENABLE             0x0003D78
-#define ACP_P1_SW_BPT_PORT_FIRST_BYTE_ADDR            0x0003D7C
-#define ACP_P1_SW_CLK_RESUME_CTRL                     0x0003D80
-#define ACP_P1_SW_CLK_RESUME_DELAY_CNTR               0x0003D84
-#define ACP_P1_SW_BUS_RESET_CTRL                      0x0003D88
-#define ACP_P1_SW_PRBS_ERR_STATUS                     0x0003D8C
+/* Registers from ACP_SW1_SWCLK block */
+#define ACP_SW1_EN                                       0x0003C00
+#define ACP_SW1_EN_STATUS                                0x0003C04
+#define ACP_SW1_FRAMESIZE                                0x0003C08
+#define ACP_SW1_SSP_COUNTER                              0x0003C0C
+#define ACP_SW1_AUDIO1_TX_EN                             0x0003C50
+#define ACP_SW1_AUDIO1_TX_EN_STATUS                      0x0003C54
+#define ACP_SW1_AUDIO1_TX_FRAME_FORMAT                   0x0003C58
+#define ACP_SW1_AUDIO1_TX_SAMPLEINTERVAL                 0x0003C5C
+#define ACP_SW1_AUDIO1_TX_HCTRL                          0x0003C60
+#define ACP_SW1_AUDIO1_TX_OFFSET                         0x0003C64
+#define ACP_SW1_AUDIO1_TX_CHANNEL_ENABLE_DP0             0x0003C68
+#define ACP_SW1_AUDIO1_RX_EN                             0x0003D28
+#define ACP_SW1_AUDIO1_RX_EN_STATUS                      0x0003D2C
+#define ACP_SW1_AUDIO1_RX_FRAME_FORMAT                   0x0003D30
+#define ACP_SW1_AUDIO1_RX_SAMPLEINTERVAL                 0x0003D34
+#define ACP_SW1_AUDIO1_RX_HCTRL                          0x0003D38
+#define ACP_SW1_AUDIO1_RX_OFFSET                         0x0003D3C
+#define ACP_SW1_AUDIO1_RX_CHANNEL_ENABLE_DP0             0x0003D40
+#define ACP_SW1_BPT_PORT_EN                              0x0003D60
+#define ACP_SW1_BPT_PORT_EN_STATUS                       0x0003D64
+#define ACP_SW1_BPT_PORT_FRAME_FORMAT                    0x0003D68
+#define ACP_SW1_BPT_PORT_SAMPLEINTERVAL                  0x0003D6C
+#define ACP_SW1_BPT_PORT_HCTRL                           0x0003D70
+#define ACP_SW1_BPT_PORT_OFFSET                          0x0003D74
+#define ACP_SW1_BPT_PORT_CHANNEL_ENABLE                  0x0003D78
+#define ACP_SW1_BPT_PORT_FIRST_BYTE_ADDR                 0x0003D7C
+#define ACP_SW1_CLK_RESUME_CTRL                          0x0003D80
+#define ACP_SW1_CLK_RESUME_DELAY_CNTR                    0x0003D84
+#define ACP_SW1_BUS_RESET_CTRL                           0x0003D88
+#define ACP_SW1_PRBS_ERR_STATUS                          0x0003D8C
 
-/* Registers from ACP_P1_SW_ACLK block */
-#define P1_SW_CORB_BASE_ADDRESS                       0x0003E00
-#define P1_SW_CORB_WRITE_POINTER                      0x0003E04
-#define P1_SW_CORB_READ_POINTER                       0x0003E08
-#define P1_SW_CORB_CONTROL                            0x0003E0C
-#define P1_SW_CORB_SIZE                               0x0003E14
-#define P1_SW_RIRB_BASE_ADDRESS                       0x0003E18
-#define P1_SW_RIRB_WRITE_POINTER                      0x0003E1C
-#define P1_SW_RIRB_RESPONSE_INTERRUPT_COUNT           0x0003E20
-#define P1_SW_RIRB_CONTROL                            0x0003E24
-#define P1_SW_RIRB_SIZE                               0x0003E28
-#define P1_SW_RIRB_FIFO_MIN_THDL                      0x0003E2C
-#define P1_SW_IMM_CMD_UPPER_WORD                      0x0003E30
-#define P1_SW_IMM_CMD_LOWER_QWORD                     0x0003E34
-#define P1_SW_IMM_RESP_UPPER_WORD                     0x0003E38
-#define P1_SW_IMM_RESP_LOWER_QWORD                    0x0003E3C
-#define P1_SW_IMM_CMD_STS                             0x0003E40
-#define P1_SW_BRA_BASE_ADDRESS                        0x0003E44
-#define P1_SW_BRA_TRANSFER_SIZE                       0x0003E48
-#define P1_SW_BRA_DMA_BUSY                            0x0003E4C
-#define P1_SW_BRA_RESP                                0x0003E50
-#define P1_SW_BRA_RESP_FRAME_ADDR                     0x0003E54
-#define P1_SW_BRA_CURRENT_TRANSFER_SIZE               0x0003E58
-#define P1_SW_STATE_CHANGE_STATUS_0TO7                0x0003E5C
-#define P1_SW_STATE_CHANGE_STATUS_8TO11               0x0003E60
-#define P1_SW_STATE_CHANGE_STATUS_MASK_0TO7           0x0003E64
-#define P1_SW_STATE_CHANGE_STATUS_MASK_8TO11          0x0003E68
-#define P1_SW_CLK_FREQUENCY_CTRL                      0x0003E6C
-#define P1_SW_ERROR_INTR_MASK                         0x0003E70
-#define P1_SW_PHY_TEST_MODE_DATA_OFF                  0x0003E74
+/* Registers from ACP_SW1_ACLK block */
+#define ACP_SW1_CORB_BASE_ADDRESS                       0x0003E00
+#define ACP_SW1_CORB_WRITE_POINTER                      0x0003E04
+#define ACP_SW1_CORB_READ_POINTER                       0x0003E08
+#define ACP_SW1_CORB_CONTROL                            0x0003E0C
+#define ACP_SW1_CORB_SIZE                               0x0003E14
+#define ACP_SW1_RIRB_BASE_ADDRESS                       0x0003E18
+#define ACP_SW1_RIRB_WRITE_POINTER                      0x0003E1C
+#define ACP_SW1_RIRB_RESPONSE_INTERRUPT_COUNT           0x0003E20
+#define ACP_SW1_RIRB_CONTROL                            0x0003E24
+#define ACP_SW1_RIRB_SIZE                               0x0003E28
+#define ACP_SW1_RIRB_FIFO_MIN_THDL                      0x0003E2C
+#define ACP_SW1_IMM_CMD_UPPER_WORD                      0x0003E30
+#define ACP_SW1_IMM_CMD_LOWER_QWORD                     0x0003E34
+#define ACP_SW1_IMM_RESP_UPPER_WORD                     0x0003E38
+#define ACP_SW1_IMM_RESP_LOWER_QWORD                    0x0003E3C
+#define ACP_SW1_IMM_CMD_STS                             0x0003E40
+#define ACP_SW1_BRA_BASE_ADDRESS                        0x0003E44
+#define ACP_SW1_BRA_TRANSFER_SIZE                       0x0003E48
+#define ACP_SW1_BRA_DMA_BUSY                            0x0003E4C
+#define ACP_SW1_BRA_RESP                                0x0003E50
+#define ACP_SW1_BRA_RESP_FRAME_ADDR                     0x0003E54
+#define ACP_SW1_BRA_CURRENT_TRANSFER_SIZE               0x0003E58
+#define ACP_SW1_STATECHANGE_STATUS_0TO7                 0x0003E5C
+#define ACP_SW1_STATECHANGE_STATUS_8TO11                0x0003E60
+#define ACP_SW1_STATECHANGE_STATUS_MASK_0TO7            0x0003E64
+#define ACP_SW1_STATECHANGE_STATUS_MASK_8TO11           0x0003E68
+#define ACP_SW1_CLK_FREQUENCY_CTRL                      0x0003E6C
+#define ACP_SW1_ERROR_INTR_MASK                         0x0003E70
+#define ACP_SW1_PHY_TEST_MODE_DATA_OFF                  0x0003E74
 
 /* Registers from ACP_SCRATCH block */
-#define ACP_SCRATCH_REG_0                             0x0010000
-#define ACP_SCRATCH_REG_1                             0x0010004
-#define ACP_SCRATCH_REG_2                             0x0010008
-#define ACP_SCRATCH_REG_3                             0x001000C
-#define ACP_SCRATCH_REG_4                             0x0010010
-#define ACP_SCRATCH_REG_5                             0x0010014
-#define ACP_SCRATCH_REG_6                             0x0010018
-#define ACP_SCRATCH_REG_7                             0x001001C
-#define ACP_SCRATCH_REG_8                             0x0010020
-#define ACP_SCRATCH_REG_9                             0x0010024
-#define ACP_SCRATCH_REG_10                            0x0010028
-#define ACP_SCRATCH_REG_11                            0x001002C
-#define ACP_SCRATCH_REG_12                            0x0010030
-#define ACP_SCRATCH_REG_13                            0x0010034
-#define ACP_SCRATCH_REG_14                            0x0010038
-#define ACP_SCRATCH_REG_15                            0x001003C
-#define ACP_SCRATCH_REG_16                            0x0010040
-#define ACP_SCRATCH_REG_17                            0x0010044
-#define ACP_SCRATCH_REG_18                            0x0010048
-#define ACP_SCRATCH_REG_19                            0x001004C
-#define ACP_SCRATCH_REG_20                            0x0010050
-#define ACP_SCRATCH_REG_21                            0x0010054
-#define ACP_SCRATCH_REG_22                            0x0010058
-#define ACP_SCRATCH_REG_23                            0x001005C
-#define ACP_SCRATCH_REG_24                            0x0010060
-#define ACP_SCRATCH_REG_25                            0x0010064
-#define ACP_SCRATCH_REG_26                            0x0010068
-#define ACP_SCRATCH_REG_27                            0x001006C
-#define ACP_SCRATCH_REG_28                            0x0010070
-#define ACP_SCRATCH_REG_29                            0x0010074
-#define ACP_SCRATCH_REG_30                            0x0010078
-#define ACP_SCRATCH_REG_31                            0x001007C
-#define ACP_SCRATCH_REG_32                            0x0010080
-#define ACP_SCRATCH_REG_33                            0x0010084
-#define ACP_SCRATCH_REG_34                            0x0010088
-#define ACP_SCRATCH_REG_35                            0x001008C
-#define ACP_SCRATCH_REG_36                            0x0010090
-#define ACP_SCRATCH_REG_37                            0x0010094
-#define ACP_SCRATCH_REG_38                            0x0010098
-#define ACP_SCRATCH_REG_39                            0x001009C
-#define ACP_SCRATCH_REG_40                            0x00100A0
-#define ACP_SCRATCH_REG_41                            0x00100A4
-#define ACP_SCRATCH_REG_42                            0x00100A8
-#define ACP_SCRATCH_REG_43                            0x00100AC
-#define ACP_SCRATCH_REG_44                            0x00100B0
-#define ACP_SCRATCH_REG_45                            0x00100B4
-#define ACP_SCRATCH_REG_46                            0x00100B8
-#define ACP_SCRATCH_REG_47                            0x00100BC
-#define ACP_SCRATCH_REG_48                            0x00100C0
-#define ACP_SCRATCH_REG_49                            0x00100C4
-#define ACP_SCRATCH_REG_50                            0x00100C8
-#define ACP_SCRATCH_REG_51                            0x00100CC
-#define ACP_SCRATCH_REG_52                            0x00100D0
-#define ACP_SCRATCH_REG_53                            0x00100D4
-#define ACP_SCRATCH_REG_54                            0x00100D8
-#define ACP_SCRATCH_REG_55                            0x00100DC
-#define ACP_SCRATCH_REG_56                            0x00100E0
-#define ACP_SCRATCH_REG_57                            0x00100E4
-#define ACP_SCRATCH_REG_58                            0x00100E8
-#define ACP_SCRATCH_REG_59                            0x00100EC
-#define ACP_SCRATCH_REG_60                            0x00100F0
-#define ACP_SCRATCH_REG_61                            0x00100F4
-#define ACP_SCRATCH_REG_62                            0x00100F8
-#define ACP_SCRATCH_REG_63                            0x00100FC
-#define ACP_SCRATCH_REG_64                            0x0010100
-#define ACP_SCRATCH_REG_65                            0x0010104
-#define ACP_SCRATCH_REG_66                            0x0010108
-#define ACP_SCRATCH_REG_67                            0x001010C
-#define ACP_SCRATCH_REG_68                            0x0010110
-#define ACP_SCRATCH_REG_69                            0x0010114
-#define ACP_SCRATCH_REG_70                            0x0010118
-#define ACP_SCRATCH_REG_71                            0x001011C
-#define ACP_SCRATCH_REG_72                            0x0010120
-#define ACP_SCRATCH_REG_73                            0x0010124
-#define ACP_SCRATCH_REG_74                            0x0010128
-#define ACP_SCRATCH_REG_75                            0x001012C
-#define ACP_SCRATCH_REG_76                            0x0010130
-#define ACP_SCRATCH_REG_77                            0x0010134
-#define ACP_SCRATCH_REG_78                            0x0010138
-#define ACP_SCRATCH_REG_79                            0x001013C
-#define ACP_SCRATCH_REG_80                            0x0010140
-#define ACP_SCRATCH_REG_81                            0x0010144
-#define ACP_SCRATCH_REG_82                            0x0010148
-#define ACP_SCRATCH_REG_83                            0x001014C
-#define ACP_SCRATCH_REG_84                            0x0010150
-#define ACP_SCRATCH_REG_85                            0x0010154
-#define ACP_SCRATCH_REG_86                            0x0010158
-#define ACP_SCRATCH_REG_87                            0x001015C
-#define ACP_SCRATCH_REG_88                            0x0010160
-#define ACP_SCRATCH_REG_89                            0x0010164
-#define ACP_SCRATCH_REG_90                            0x0010168
-#define ACP_SCRATCH_REG_91                            0x001016C
-#define ACP_SCRATCH_REG_92                            0x0010170
-#define ACP_SCRATCH_REG_93                            0x0010174
-#define ACP_SCRATCH_REG_94                            0x0010178
-#define ACP_SCRATCH_REG_95                            0x001017C
-#define ACP_SCRATCH_REG_96                            0x0010180
-#define ACP_SCRATCH_REG_97                            0x0010184
-#define ACP_SCRATCH_REG_98                            0x0010188
-#define ACP_SCRATCH_REG_99                            0x001018C
-#define ACP_SCRATCH_REG_100                           0x0010190
-#define ACP_SCRATCH_REG_101                           0x0010194
-#define ACP_SCRATCH_REG_102                           0x0010198
-#define ACP_SCRATCH_REG_103                           0x001019C
-#define ACP_SCRATCH_REG_104                           0x00101A0
-#define ACP_SCRATCH_REG_105                           0x00101A4
-#define ACP_SCRATCH_REG_106                           0x00101A8
-#define ACP_SCRATCH_REG_107                           0x00101AC
-#define ACP_SCRATCH_REG_108                           0x00101B0
-#define ACP_SCRATCH_REG_109                           0x00101B4
-#define ACP_SCRATCH_REG_110                           0x00101B8
-#define ACP_SCRATCH_REG_111                           0x00101BC
-#define ACP_SCRATCH_REG_112                           0x00101C0
-#define ACP_SCRATCH_REG_113                           0x00101C4
-#define ACP_SCRATCH_REG_114                           0x00101C8
-#define ACP_SCRATCH_REG_115                           0x00101CC
-#define ACP_SCRATCH_REG_116                           0x00101D0
-#define ACP_SCRATCH_REG_117                           0x00101D4
-#define ACP_SCRATCH_REG_118                           0x00101D8
-#define ACP_SCRATCH_REG_119                           0x00101DC
-#define ACP_SCRATCH_REG_120                           0x00101E0
-#define ACP_SCRATCH_REG_121                           0x00101E4
-#define ACP_SCRATCH_REG_122                           0x00101E8
-#define ACP_SCRATCH_REG_123                           0x00101EC
-#define ACP_SCRATCH_REG_124                           0x00101F0
-#define ACP_SCRATCH_REG_125                           0x00101F4
-#define ACP_SCRATCH_REG_126                           0x00101F8
-#define ACP_SCRATCH_REG_127                           0x00101FC
-#define ACP_SCRATCH_REG_128                           0x0010200
+#define ACP_SCRATCH_REG_0                               0x0010000
+
 #endif
-- 
2.34.1

