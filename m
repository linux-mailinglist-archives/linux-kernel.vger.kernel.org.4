Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5965F9C1A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiJJJjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbiJJJjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:39:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81918E38
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 02:39:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwZeEbIilMWTL3+B5p6rPaoWykxI4pj/lfBSjG/HLHBoxjVdBu1g81XL0fvxlAc8rIWSucSy7kg6L8B/YWpKhL2PsZz+d0PT2SVaADg00WHfWhooXYMfOYlGnRSxvbMkaRD6SQnd1N4EE+YxfvvrSnmMCX1bswPnxf7R07Ktjq8gK/W5GGc7augTmmF6YFb4prmc0mZ0O109Q4MSYYP6/z8XeUSvH5pCutoZbTIAcp/nlGSy9POfzBd6omqNP7YqOmuJivJzhzBcOm/3TEkPp6pIbecjZTg3PWPwmRudeDtaS8uxoJNYijbW9iGPqWMrQ0bndqDI/2kWRs1pxXr5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikvjHGu0K0GSAV9OiPdtT0uLqL3ubRQqif8c/YBpaVo=;
 b=m3YNXEF2YfB2dPlm55wPjLPHr/QG4ebdyhQixLcUMdQmT9h3qU8ChmLhkHsiYQZwOMZacYIVxyo531Ofdq/f0k3YoyS5/RCB9VG+SWVlf/qWEEB1XeN8lAm9Rm1JNxWwXTltYiX9mSaZ0jn9oXLfJXd5oHSEkiZtHQ18LuxBo4N92OXy7cCfu9bC419xHQeN6QOSH2zXC5Gy4XXn2ZIhXh9xV7bjSixStHSgTh9TXJOtmd2XOJ5VpljwmrZrYNg5/28k24UA5CyBDpxifvrCPraAhLkWW5zESCBowhB+l5T8/NrhMSUZYUQWDAKUmsI8TpHW3ZQK467vpxPSCEvHvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikvjHGu0K0GSAV9OiPdtT0uLqL3ubRQqif8c/YBpaVo=;
 b=fa006w1BiY/uymBK6Z7W8IqC3ok/aUUY39ehvdrgiJhh0Uq3wqXLPkvSfSVw8KnlyRNOtNMkLxIpVTkmOnJTw8zeEjlHuuGl8yDDBPHEG2c2GlU/rGDDP/y3Y330HKFtBkK0xO0VES+Yz7/yd6FJz7YmgHr9ZbVLMoOBSNfa0M8=
Received: from MW4PR04CA0380.namprd04.prod.outlook.com (2603:10b6:303:81::25)
 by PH0PR12MB5646.namprd12.prod.outlook.com (2603:10b6:510:143::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 09:39:38 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::ef) by MW4PR04CA0380.outlook.office365.com
 (2603:10b6:303:81::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 09:39:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 09:39:38 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 10 Oct
 2022 04:39:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 10 Oct
 2022 02:39:01 -0700
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Mon, 10 Oct 2022 04:38:59 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: Update Pink Sardine platform ACP register header
Date:   Mon, 10 Oct 2022 15:09:40 +0530
Message-ID: <20221010093941.2354783-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT041:EE_|PH0PR12MB5646:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb2c592-4e54-431a-cd84-08daaaa35997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AdDauWDi92utC69AuIdamqneCxNhHU49+r3K7PzH6/9STkPhQBSZRzdU0UuMUKoG/inaD2U7L1zkCyGiLnEvZVK8U1VCPECD7ydD1Kh8JPz6vli4d4leCUQpAvxW6+o2SOZ2bQqpjpqktXl9mnHUdULogKock2D+C2A6UVkJZrcDEhwmKXY0BSRbS3m79tHwzVhSBToSQXP7PbL6t9QOd3uv1iD0sfq1fxOzjTmFKiO+tr4ADAzm/PxB9zqpMzYT4j4uZQF7lLGYdslbMjR2gzaLxjblV2om1VsYaElooiMpTWc7A7Z5YzMjomwKQqfX5Ob1yjJj05xyNYS0gFw10m9hZdBYJp4mrqAvj5JRMOEyPpWtrsOcJgaqyS9D9xomhE2uS1M9lFCV365SVSi7McUQT+XyifTDmIhKP8mOJeFtDZbFTWCuakgIwoImIJYksfHGTO8HgN6GESRSRzF4EHUvGwNim2VSQAmGbA3FdBx3xyYeff4MVJBE2d75YSFrXDhlFLMWj0Kg7k87Vi9hLzwoFbFihcP0KRHx3SNXWCTi2lROFvPYxgLuHqUj0WjgXxP5ta5jccZg5Vn1Ln8WOFtP/ILEzaEIYfk3Lqy9sL53gx+qjBB1JPSdGlYzE1kVE4PeAk2FF9lW+NQxXrrZ2VdyfqZpalGxg5ptZA8k+b2Er5X+y4mdmCOed9UugNhkCfrAimmN9vb/u05y8nv1MPIcpkQkhqrYQc318HmZ5NF18X3ajm5q40sF9Gbu6wI/3cuX+1LohjGmPpF59D1AHQKrATEVtDcZ30rSqTQrIZmOX2IQVmLPaXUVbnQ8kQxb
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(110136005)(36756003)(86362001)(54906003)(5660300002)(30864003)(82740400003)(36860700001)(83380400001)(336012)(2616005)(356005)(81166007)(186003)(47076005)(1076003)(478600001)(70586007)(8676002)(6666004)(4326008)(70206006)(26005)(316002)(7696005)(426003)(8936002)(15650500001)(82310400005)(41300700001)(2906002)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 09:39:38.4296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb2c592-4e54-431a-cd84-08daaaa35997
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5646
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Pink Sardine platform ACP register header with Soundwire
Controller specific registers and other ACP registers.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 include/sound/acp62_chip_offset_byte.h | 214 +++++++++++++++++++++++++
 1 file changed, 214 insertions(+)

diff --git a/include/sound/acp62_chip_offset_byte.h b/include/sound/acp62_chip_offset_byte.h
index f03992f81168..ca38f8a0966e 100644
--- a/include/sound/acp62_chip_offset_byte.h
+++ b/include/sound/acp62_chip_offset_byte.h
@@ -131,6 +131,23 @@
 #define ACP_I2S_WAKE_EN                               0x000145C
 #define ACP_SW1_WAKE_EN                               0x0001460
 
+#define ACP_SW_I2S_ERROR_REASON                       0x00018B4
+#define ACP_SW_POS_TRACK_I2S_TX_CTRL                  0x00018B8
+#define ACP_SW_I2S_TX_DMA_POS                         0x00018BC
+#define ACP_SW_POS_TRACK_BT_TX_CTRL                   0x00018C0
+#define ACP_SW_BT_TX_DMA_POS                          0x00018C4
+#define ACP_SW_POS_TRACK_HS_TX_CTRL                   0x00018C8
+#define ACP_SW_HS_TX_DMA_POS                          0x00018CC
+#define ACP_SW_POS_TRACK_I2S_RX_CTRL                  0x00018D0
+#define ACP_SW_I2S_RX_DMA_POS                         0x00018D4
+#define ACP_SW_POS_TRACK_BT_RX_CTRL                   0x00018D8
+#define ACP_SW_BT_RX_DMA_POS                          0x00018DC
+#define ACP_SW_POS_TRACK_HS_RX_CTRL                   0x00018E0
+#define ACP_SW_HS_RX_DMA_POS                          0x00018E4
+#define ACP_ERROR_INTR_MASK1                          0X0001974
+#define ACP_ERROR_INTR_MASK2                          0X0001978
+#define ACP_ERROR_INTR_MASK3                          0X000197C
+
 /* Registers from ACP_P1_MISC block */
 #define ACP_EXTERNAL_INTR_ENB                         0x0001A00
 #define ACP_EXTERNAL_INTR_CNTL                        0x0001A04
@@ -154,6 +171,8 @@
 #define ACP_P1_SW_BT_RX_DMA_POS                       0x0001A9C
 #define ACP_P1_SW_POS_TRACK_HS_RX_CTRL                0x0001AA0
 #define ACP_P1_SW_HS_RX_DMA_POS                       0x0001AA4
+#define ACP_ERROR_INTR_MASK4                          0X0001AEC
+#define ACP_ERROR_INTR_MASK5                          0X0001AF0
 
 /* Registers from ACP_AUDIO_BUFFERS block */
 #define ACP_I2S_RX_RINGBUFADDR                        0x0002000
@@ -210,6 +229,24 @@
 #define ACP_HS_TX_LINEARPOSITIONCNTR_HIGH             0x00020CC
 #define ACP_HS_TX_LINEARPOSITIONCNTR_LOW              0x00020D0
 #define ACP_HS_TX_INTR_WATERMARK_SIZE                 0x00020D4
+#define ACP_AUDIO_RX_RINGBUFADDR                   ACP_I2S_RX_RINGBUFADDR
+#define ACP_AUDIO_RX_RINGBUFSIZE                   ACP_I2S_RX_RINGBUFSIZE
+#define ACP_AUDIO_RX_LINKPOSITIONCNTR              ACP_I2S_RX_LINKPOSITIONCNTR
+#define ACP_AUDIO_RX_FIFOADDR                      ACP_I2S_RX_FIFOADDR
+#define ACP_AUDIO_RX_FIFOSIZE                      ACP_I2S_RX_FIFOSIZE
+#define ACP_AUDIO_RX_DMA_SIZE                      ACP_I2S_RX_DMA_SIZE
+#define ACP_AUDIO_RX_LINEARPOSITIONCNTR_HIGH       ACP_I2S_RX_LINEARPOSITIONCNTR_HIGH
+#define ACP_AUDIO_RX_LINEARPOSITIONCNTR_LOW        ACP_I2S_RX_LINEARPOSITIONCNTR_LOW
+#define ACP_AUDIO_RX_INTR_WATERMARK_SIZE           ACP_I2S_RX_INTR_WATERMARK_SIZE
+#define ACP_AUDIO_TX_RINGBUFADDR                   ACP_I2S_TX_RINGBUFADDR
+#define ACP_AUDIO_TX_RINGBUFSIZE                   ACP_I2S_TX_RINGBUFSIZE
+#define ACP_AUDIO_TX_LINKPOSITIONCNTR              ACP_I2S_TX_LINKPOSITIONCNTR
+#define ACP_AUDIO_TX_FIFOADDR                      ACP_I2S_TX_FIFOADDR
+#define ACP_AUDIO_TX_FIFOSIZE                      ACP_I2S_TX_FIFOSIZE
+#define ACP_AUDIO_TX_DMA_SIZE                      ACP_I2S_TX_DMA_SIZE
+#define ACP_AUDIO_TX_LINEARPOSITIONCNTR_HIGH       ACP_I2S_TX_LINEARPOSITIONCNTR_HIGH
+#define ACP_AUDIO_TX_LINEARPOSITIONCNTR_LOW        ACP_I2S_TX_LINEARPOSITIONCNTR_LOW
+#define ACP_AUDIO_TX_INTR_WATERMARK_SIZE           ACP_I2S_TX_INTR_WATERMARK_SIZE
 
 /* Registers from ACP_I2S_TDM block */
 #define ACP_I2STDM_IER                                0x0002400
@@ -255,6 +292,102 @@
 #define ACP_WOV_ERROR_STATUS_REGISTER                 0x0002C68
 #define ACP_PDM_CLKDIV                                0x0002C6C
 
+/* Registers from ACP_SW_SWCLK block */
+#define ACP_SW_EN                                     0x0003000
+#define ACP_SW_EN_STATUS                              0x0003004
+#define ACP_SW_FRAMESIZE                              0x0003008
+#define ACP_SW_SSP_COUNTER                            0x000300C
+#define ACP_SW_AUDIO_TX_EN                            0x0003010
+#define ACP_SW_AUDIO_TX_EN_STATUS                     0x0003014
+#define ACP_SW_AUDIO_TX_FRAME_FORMAT                  0x0003018
+#define ACP_SW_AUDIO_TX_SAMPLEINTERVAL                0x000301C
+#define ACP_SW_AUDIO_TX_HCTRL_DP0                     0x0003020
+#define ACP_SW_AUDIO_TX_HCTRL_DP1                     0x0003024
+#define ACP_SW_AUDIO_TX_HCTRL_DP2                     0x0003028
+#define ACP_SW_AUDIO_TX_HCTRL_DP3                     0x000302C
+#define ACP_SW_AUDIO_TX_OFFSET_DP0                    0x0003030
+#define ACP_SW_AUDIO_TX_OFFSET_DP1                    0x0003034
+#define ACP_SW_AUDIO_TX_OFFSET_DP2                    0x0003038
+#define ACP_SW_AUDIO_TX_OFFSET_DP3                    0x000303C
+#define ACP_SW_AUDIO_TX_CHANNEL_ENABLE_DP0            0x0003040
+#define ACP_SW_AUDIO_TX_CHANNEL_ENABLE_DP1            0x0003044
+#define ACP_SW_AUDIO_TX_CHANNEL_ENABLE_DP2            0x0003048
+#define ACP_SW_AUDIO_TX_CHANNEL_ENABLE_DP3            0x000304C
+#define ACP_SW_BT_TX_EN                               0x0003050
+#define ACP_SW_BT_TX_EN_STATUS                        0x0003054
+#define ACP_SW_BT_TX_FRAME_FORMAT                     0x0003058
+#define ACP_SW_BT_TX_SAMPLEINTERVAL                   0x000305C
+#define ACP_SW_BT_TX_HCTRL                            0x0003060
+#define ACP_SW_BT_TX_OFFSET                           0x0003064
+#define ACP_SW_BT_TX_CHANNEL_ENABLE_DP0               0x0003068
+#define ACP_SW_HEADSET_TX_EN                          0x000306C
+#define ACP_SW_HEADSET_TX_EN_STATUS                   0x0003070
+#define ACP_SW_HEADSET_TX_FRAME_FORMAT                0x0003074
+#define ACP_SW_HEADSET_TX_SAMPLEINTERVAL              0x0003078
+#define ACP_SW_HEADSET_TX_HCTRL                       0x000307C
+#define ACP_SW_HEADSET_TX_OFFSET                      0x0003080
+#define ACP_SW_HEADSET_TX_CHANNEL_ENABLE_DP0          0x0003084
+#define ACP_SW_AUDIO_RX_EN                            0x0003088
+#define ACP_SW_AUDIO_RX_EN_STATUS                     0x000308C
+#define ACP_SW_AUDIO_RX_FRAME_FORMAT                  0x0003090
+#define ACP_SW_AUDIO_RX_SAMPLEINTERVAL                0x0003094
+#define ACP_SW_AUDIO_RX_HCTRL_DP0                     0x0003098
+#define ACP_SW_AUDIO_RX_HCTRL_DP1                     0x000309C
+#define ACP_SW_AUDIO_RX_HCTRL_DP2                     0x0003100
+#define ACP_SW_AUDIO_RX_HCTRL_DP3                     0x0003104
+#define ACP_SW_AUDIO_RX_OFFSET_DP0                    0x0003108
+#define ACP_SW_AUDIO_RX_OFFSET_DP1                    0x000310C
+#define ACP_SW_AUDIO_RX_OFFSET_DP2                    0x0003110
+#define ACP_SW_AUDIO_RX_OFFSET_DP3                    0x0003114
+#define ACP_SW_AUDIO_RX_CHANNEL_ENABLE_DP0            0x0003118
+#define ACP_SW_AUDIO_RX_CHANNEL_ENABLE_DP1            0x000311C
+#define ACP_SW_AUDIO_RX_CHANNEL_ENABLE_DP2            0x0003120
+#define ACP_SW_AUDIO_RX_CHANNEL_ENABLE_DP3            0x0003124
+#define ACP_SW_BT_RX_EN                               0x0003128
+#define ACP_SW_BT_RX_EN_STATUS                        0x000312C
+#define ACP_SW_BT_RX_FRAME_FORMAT                     0x0003130
+#define ACP_SW_BT_RX_SAMPLEINTERVAL                   0x0003134
+#define ACP_SW_BT_RX_HCTRL                            0x0003138
+#define ACP_SW_BT_RX_OFFSET                           0x000313C
+#define ACP_SW_BT_RX_CHANNEL_ENABLE_DP0               0x0003140
+#define ACP_SW_HEADSET_RX_EN                          0x0003144
+#define ACP_SW_HEADSET_RX_EN_STATUS                   0x0003148
+#define ACP_SW_HEADSET_RX_FRAME_FORMAT                0x000314C
+#define ACP_SW_HEADSET_RX_SAMPLEINTERVAL              0x0003150
+#define ACP_SW_HEADSET_RX_HCTRL                       0x0003154
+#define ACP_SW_HEADSET_RX_OFFSET                      0x0003158
+#define ACP_SW_HEADSET_RX_CHANNEL_ENABLE_DP0          0x000315C
+#define ACP_SW_BPT_PORT_EN                            0x0003160
+#define ACP_SW_BPT_PORT_EN_STATUS                     0x0003164
+#define ACP_SW_BPT_PORT_FRAME_FORMAT                  0x0003168
+#define ACP_SW_BPT_PORT_SAMPLEINTERVAL                0x000316C
+#define ACP_SW_BPT_PORT_HCTRL                         0x0003170
+#define ACP_SW_BPT_PORT_OFFSET                        0x0003174
+#define ACP_SW_BPT_PORT_CHANNEL_ENABLE                0x0003178
+#define ACP_SW_BPT_PORT_FIRST_BYTE_ADDR               0x000317C
+#define ACP_SW_CLK_RESUME_CTRL                        0x0003180
+#define ACP_SW_CLK_RESUME_DELAY_CNTR                  0x0003184
+#define ACP_SW_BUS_RESET_CTRL                         0x0003188
+#define ACP_SW_PRBS_ERR_STATUS                        0x000318C
+#define SW_IMM_CMD_UPPER_WORD                         0x0003230
+#define SW_IMM_CMD_LOWER_QWORD                        0x0003234
+#define SW_IMM_RESP_UPPER_WORD                        0x0003238
+#define SW_IMM_RESP_LOWER_QWORD                       0x000323C
+#define SW_IMM_CMD_STS                                0x0003240
+#define SW_BRA_BASE_ADDRESS                           0x0003244
+#define SW_BRA_TRANSFER_SIZE                          0x0003248
+#define SW_BRA_DMA_BUSY                               0x000324C
+#define SW_BRA_RESP                                   0x0003250
+#define SW_BRA_RESP_FRAME_ADDR                        0x0003254
+#define SW_BRA_CURRENT_TRANSFER_SIZE                  0x0003258
+#define SW_STATE_CHANGE_STATUS_0TO7                   0x000325C
+#define SW_STATE_CHANGE_STATUS_8TO11                  0x0003260
+#define SW_STATE_CHANGE_STATUS_MASK_0TO7              0x0003264
+#define SW_STATE_CHANGE_STATUS_MASK_8TO11             0x0003268
+#define SW_CLK_FREQUENCY_CTRL                         0x000326C
+#define SW_ERROR_INTR_MASK                            0x0003270
+#define SW_PHY_TEST_MODE_DATA_OFF                     0x0003274
+
 /* Registers from ACP_P1_AUDIO_BUFFERS block */
 #define ACP_P1_I2S_RX_RINGBUFADDR                     0x0003A00
 #define ACP_P1_I2S_RX_RINGBUFSIZE                     0x0003A04
@@ -310,6 +443,87 @@
 #define ACP_P1_HS_TX_LINEARPOSITIONCNTR_HIGH          0x0003ACC
 #define ACP_P1_HS_TX_LINEARPOSITIONCNTR_LOW           0x0003AD0
 #define ACP_P1_HS_TX_INTR_WATERMARK_SIZE              0x0003AD4
+#define ACP_P1_AUDIO_RX_RINGBUFADDR                   ACP_P1_I2S_RX_RINGBUFADDR
+#define ACP_P1_AUDIO_RX_RINGBUFSIZE                   ACP_P1_I2S_RX_RINGBUFSIZE
+#define ACP_P1_AUDIO_RX_LINKPOSITIONCNTR              ACP_P1_I2S_RX_LINKPOSITIONCNTR
+#define ACP_P1_AUDIO_RX_FIFOADDR                      ACP_P1_I2S_RX_FIFOADDR
+#define ACP_P1_AUDIO_RX_FIFOSIZE                      ACP_P1_I2S_RX_FIFOSIZE
+#define ACP_P1_AUDIO_RX_DMA_SIZE                      ACP_P1_I2S_RX_DMA_SIZE
+#define ACP_P1_AUDIO_RX_LINEARPOSITIONCNTR_HIGH       ACP_P1_I2S_RX_LINEARPOSITIONCNTR_HIGH
+#define ACP_P1_AUDIO_RX_LINEARPOSITIONCNTR_LOW        ACP_P1_I2S_RX_LINEARPOSITIONCNTR_LOW
+#define ACP_P1_AUDIO_RX_INTR_WATERMARK_SIZE           ACP_P1_I2S_RX_INTR_WATERMARK_SIZE
+#define ACP_P1_AUDIO_TX_RINGBUFADDR                   ACP_P1_I2S_TX_RINGBUFADDR
+#define ACP_P1_AUDIO_TX_RINGBUFSIZE                   ACP_P1_I2S_TX_RINGBUFSIZE
+#define ACP_P1_AUDIO_TX_LINKPOSITIONCNTR              ACP_P1_I2S_TX_LINKPOSITIONCNTR
+#define ACP_P1_AUDIO_TX_FIFOADDR                      ACP_P1_I2S_TX_FIFOADDR
+#define ACP_P1_AUDIO_TX_FIFOSIZE                      ACP_P1_I2S_TX_FIFOSIZE
+#define ACP_P1_AUDIO_TX_DMA_SIZE                      ACP_P1_I2S_TX_DMA_SIZE
+#define ACP_P1_AUDIO_TX_LINEARPOSITIONCNTR_HIGH       ACP_P1_I2S_TX_LINEARPOSITIONCNTR_HIGH
+#define ACP_P1_AUDIO_TX_LINEARPOSITIONCNTR_LOW        ACP_P1_I2S_TX_LINEARPOSITIONCNTR_LOW
+#define ACP_P1_AUDIO_TX_INTR_WATERMARK_SIZE           ACP_P1_I2S_TX_INTR_WATERMARK_SIZE
+
+/* Registers from ACP_P1_SW_SWCLK block */
+#define ACP_P1_SW_EN                                  0x0003C00
+#define ACP_P1_SW_EN_STATUS                           0x0003C04
+#define ACP_P1_SW_FRAMESIZE                           0x0003C08
+#define ACP_P1_SW_SSP_COUNTER                         0x0003C0C
+#define ACP_P1_SW_BT_TX_EN                            0x0003C50
+#define ACP_P1_SW_BT_TX_EN_STATUS                     0x0003C54
+#define ACP_P1_SW_BT_TX_FRAME_FORMAT                  0x0003C58
+#define ACP_P1_SW_BT_TX_SAMPLEINTERVAL                0x0003C5C
+#define ACP_P1_SW_BT_TX_HCTRL                         0x0003C60
+#define ACP_P1_SW_BT_TX_OFFSET                        0x0003C64
+#define ACP_P1_SW_BT_TX_CHANNEL_ENABLE_DP0            0x0003C68
+#define ACP_P1_SW_BT_RX_EN                            0x0003D28
+#define ACP_P1_SW_BT_RX_EN_STATUS                     0x0003D2C
+#define ACP_P1_SW_BT_RX_FRAME_FORMAT                  0x0003D30
+#define ACP_P1_SW_BT_RX_SAMPLEINTERVAL                0x0003D34
+#define ACP_P1_SW_BT_RX_HCTRL                         0x0003D38
+#define ACP_P1_SW_BT_RX_OFFSET                        0x0003D3C
+#define ACP_P1_SW_BT_RX_CHANNEL_ENABLE_DP0            0x0003D40
+#define ACP_P1_SW_BPT_PORT_EN                         0x0003D60
+#define ACP_P1_SW_BPT_PORT_EN_STATUS                  0x0003D64
+#define ACP_P1_SW_BPT_PORT_FRAME_FORMAT               0x0003D68
+#define ACP_P1_SW_BPT_PORT_SAMPLEINTERVAL             0x0003D6C
+#define ACP_P1_SW_BPT_PORT_HCTRL                      0x0003D70
+#define ACP_P1_SW_BPT_PORT_OFFSET                     0x0003D74
+#define ACP_P1_SW_BPT_PORT_CHANNEL_ENABLE             0x0003D78
+#define ACP_P1_SW_BPT_PORT_FIRST_BYTE_ADDR            0x0003D7C
+#define ACP_P1_SW_CLK_RESUME_CTRL                     0x0003D80
+#define ACP_P1_SW_CLK_RESUME_DELAY_CNTR               0x0003D84
+#define ACP_P1_SW_BUS_RESET_CTRL                      0x0003D88
+#define ACP_P1_SW_PRBS_ERR_STATUS                     0x0003D8C
+
+/* Registers from ACP_P1_SW_ACLK block */
+#define P1_SW_CORB_BASE_ADDRESS                       0x0003E00
+#define P1_SW_CORB_WRITE_POINTER                      0x0003E04
+#define P1_SW_CORB_READ_POINTER                       0x0003E08
+#define P1_SW_CORB_CONTROL                            0x0003E0C
+#define P1_SW_CORB_SIZE                               0x0003E14
+#define P1_SW_RIRB_BASE_ADDRESS                       0x0003E18
+#define P1_SW_RIRB_WRITE_POINTER                      0x0003E1C
+#define P1_SW_RIRB_RESPONSE_INTERRUPT_COUNT           0x0003E20
+#define P1_SW_RIRB_CONTROL                            0x0003E24
+#define P1_SW_RIRB_SIZE                               0x0003E28
+#define P1_SW_RIRB_FIFO_MIN_THDL                      0x0003E2C
+#define P1_SW_IMM_CMD_UPPER_WORD                      0x0003E30
+#define P1_SW_IMM_CMD_LOWER_QWORD                     0x0003E34
+#define P1_SW_IMM_RESP_UPPER_WORD                     0x0003E38
+#define P1_SW_IMM_RESP_LOWER_QWORD                    0x0003E3C
+#define P1_SW_IMM_CMD_STS                             0x0003E40
+#define P1_SW_BRA_BASE_ADDRESS                        0x0003E44
+#define P1_SW_BRA_TRANSFER_SIZE                       0x0003E48
+#define P1_SW_BRA_DMA_BUSY                            0x0003E4C
+#define P1_SW_BRA_RESP                                0x0003E50
+#define P1_SW_BRA_RESP_FRAME_ADDR                     0x0003E54
+#define P1_SW_BRA_CURRENT_TRANSFER_SIZE               0x0003E58
+#define P1_SW_STATE_CHANGE_STATUS_0TO7                0x0003E5C
+#define P1_SW_STATE_CHANGE_STATUS_8TO11               0x0003E60
+#define P1_SW_STATE_CHANGE_STATUS_MASK_0TO7           0x0003E64
+#define P1_SW_STATE_CHANGE_STATUS_MASK_8TO11          0x0003E68
+#define P1_SW_CLK_FREQUENCY_CTRL                      0x0003E6C
+#define P1_SW_ERROR_INTR_MASK                         0x0003E70
+#define P1_SW_PHY_TEST_MODE_DATA_OFF                  0x0003E74
 
 /* Registers from ACP_SCRATCH block */
 #define ACP_SCRATCH_REG_0                             0x0010000
-- 
2.25.1

