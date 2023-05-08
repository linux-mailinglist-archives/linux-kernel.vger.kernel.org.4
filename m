Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E5E6FA09C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjEHHHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjEHHGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:06:37 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A758C1FAB0
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 00:05:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5cvnFHGRAKIBoSFQQN5aRkydYRMriJl6VxEePKJSSttdxQ90FvrzUv0Ydams4K646cfLZCcgu66YACr8ygSxDC6PPPlSloVGE+j6KHpZxnOyAgWyYY8b5OmHD2VbZzL/XlRXLFfwACUUyjN+MQDXvXN9i6MGybAWg2xz0laf2p2iLQcBe46Flel/Tgpv2EaWXh77l8z3O63f4eP1EipSKOBQevnVUrzeUzQVPf03r3ETe2NqHccVmBDlJsE64t4Wbh568ODMc64cZ6udOfOMntrz6wOg+XWo8w9oIjTKSz/Kzd6O1gE12GkNjHNtAthdEEeUo3SkiaTsIPvIS3CCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoTurC6oONuSRxeT6uhTL53UbU/vNJrDs+75QjE4XPo=;
 b=L1k+XPy0LzsfCVM/DvdmzmhYoczFXV7ps05jGd9/6NqvyCgmS6kBY1UOtobEOEl7/s+8XhEsjFZmYmKiITwWYfTxE9qNE5/P3E9m1KjHfoZ5tFg4YseJv9tOj8qSGaFHHU9xV3jDjsqdfgJ4fg9HxH8P1Y4mF53nw+3oRjqO4H6N40jB6q6YnKQncmplxlGaPu+0ZyABHjfhUYIgQpmpDv14TBeNHC5UVCW+vJcx4eMBRCk6nEfbd8UI3QK05hITRO2oHROxJtDuHXIlVqnwWTePPC3MqR17cAi6SprcOyH6ncR/sQeuCXTU9rl1jMTAccMNnVdT4OpUkMGyQhLsjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoTurC6oONuSRxeT6uhTL53UbU/vNJrDs+75QjE4XPo=;
 b=xGJGGtLtubfrhemKJhpmVpRODkq2D2TbfzH6NqcKNM2nmfE1tnvuEftYk80akUP1R3MZdApY/36lk7/erCpThq2+lq1B4rz2DKF+K01TRsu0Pwgl+xXk1vLUnQXKD6297miY1+79QGAixgQ7+lhZzS0dgxdCl82gU+m4BDlZhP8=
Received: from BL0PR02CA0081.namprd02.prod.outlook.com (2603:10b6:208:51::22)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 07:05:17 +0000
Received: from BL02EPF0000C406.namprd05.prod.outlook.com
 (2603:10b6:208:51:cafe::1a) by BL0PR02CA0081.outlook.office365.com
 (2603:10b6:208:51::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32 via Frontend
 Transport; Mon, 8 May 2023 07:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0000C406.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Mon, 8 May 2023 07:05:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 8 May
 2023 02:05:16 -0500
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 8 May 2023 02:05:10 -0500
From:   V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
        <ssabakar@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        "Bard Liao" <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Paul Olaru <paul.olaru@nxp.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: SOF: amd: Fix NULL pointer crash in acp_sof_ipc_msg_data function
Date:   Mon, 8 May 2023 12:35:08 +0530
Message-ID: <20230508070510.6100-1-Vsujithkumar.Reddy@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C406:EE_|CH2PR12MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: 12f4824e-30a4-47d4-eeaf-08db4f929412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qppGI4yAz9SauyVHx9kx14Vk9Y/cLXeS6eeXv3S96NedkBA1cAuDCghnnHHs2oT01SmCi7uo6jzbAwSZ05cqyzX3XoCW/YvBShxkWnQTuM4Nb++VRT/HN6E6yr8vS1O6VNCWkBugsbmHRBqd3gUpD64Uy16ro/8CSrnMeRzYIjUWTqn+dKqASvpKsdDxjmgiZUErSoy8XUZvQbrhlsMZymB3GPb8RkG2P2grYhxUTAohZXGIM6ZrKtFVFOUDEP0bqWyutpSokIv8FrZpEAXF9wmyn1IPfU6PrRVm+ejIvSbKfgn5a4AMjKtTJ2hBzubG6ksba07rv/epVcUrfDCubcUFOlKS+TT2Yeb4WF07BBOQskaMOYazY/A3ExE/zUGC+ZUuR5078md/JusIVedQgsQSkti4DpvPD2xqIUzT+8hcGQQte8YB+CgujMBomR32zDYIQZ9j0NDG25uvbxdevemlF75hEq3oP71sWrcn+yT7TYJlwQ1lOqXBCpzp4VzqCeVjLvkbr/zDI3HjHVmGzj2aP1eG29Rm4FdT7ivLpevMW7AG6wG4VRlHyLeB/1n7SiscUadSIE6rAUOmXICwDvhoXJSbje0EzN7QciQ5NuqoB6BKq9T1kqql5vMp1JQL8+mNE8By407bRBhxf1gRFSOBVRusEVBdThZm5UOtdxbMXs63lJm1px1Qvx0BVS8fSt0lnp8s/YTWM8rQo+YT4vL+AiJ1Zovk1g6bT5ger0w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(70586007)(70206006)(4326008)(478600001)(7696005)(316002)(110136005)(54906003)(86362001)(36756003)(47076005)(336012)(83380400001)(1076003)(26005)(36860700001)(2616005)(426003)(8676002)(8936002)(5660300002)(41300700001)(7416002)(4744005)(2906002)(82310400005)(40480700001)(356005)(82740400003)(186003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 07:05:17.0677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f4824e-30a4-47d4-eeaf-08db4f929412
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C406.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check substream and runtime variables before assigning.

Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
---
 sound/soc/sof/amd/acp-ipc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/amd/acp-ipc.c b/sound/soc/sof/amd/acp-ipc.c
index 4e0c48a36159..749e856dc601 100644
--- a/sound/soc/sof/amd/acp-ipc.c
+++ b/sound/soc/sof/amd/acp-ipc.c
@@ -209,7 +209,12 @@ int acp_sof_ipc_msg_data(struct snd_sof_dev *sdev, struct snd_sof_pcm_stream *sp
 		acp_mailbox_read(sdev, offset, p, sz);
 	} else {
 		struct snd_pcm_substream *substream = sps->substream;
-		struct acp_dsp_stream *stream = substream->runtime->private_data;
+		struct acp_dsp_stream *stream;
+
+		if (!substream || !substream->runtime)
+			return -ESTRPIPE;
+
+		stream = substream->runtime->private_data;
 
 		if (!stream)
 			return -ESTRPIPE;
-- 
2.25.1

