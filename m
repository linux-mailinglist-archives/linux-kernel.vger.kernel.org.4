Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AA45B6843
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 08:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiIMG6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 02:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiIMG6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:58:33 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA3727FF5;
        Mon, 12 Sep 2022 23:58:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKxdoExieUVQ5Gy4ZSbKYKt68t8zAu6mvmPTd/TamtmO/Hrp2ReMi5Elx75/Rupw9QlHG21Yo+DkPwMAypx1wvdOukFEKAaBxcM+oDOZjg4PZDAYNM5VEgd66xfat7HC/dj45+0e5DHVTREXN7yEclFX17uX1l8jD/wIooAprVogCmc3LdHYibiW10Q4ZkwrufuXDyBIjCkiOEym0/glFqeSVbDRtVWVLP3HMyzDV3oNVUwSMhZh7gqxe9SOhp5INWo1tUJNPTSYAF0q/LU29jARkyU2bEAKdSif0yKmDUBti6K+x6J97bszO8I0jCWR3S1yI9ilU5Aig0kiy8sgmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAkhN1/HY1TdvW1FRt9TinpxeraRBhXdEQhiO6FLN1I=;
 b=QscqNo/K6LHDA/NYxHh4n4m8TzkFDDKuu+SLlPxDfEGVTO6Cyo0n6zhR9b0YV9SaMZwc+gVrUG6oJgiDNUpvX9ubePgW+vZwGEkTo8PBA6oiVIu066vlWstbsbodDff+ZhHM/uXkUhycL9hMusYPWKKxn+LGNqpbCVYowN7zUkLyNt66hWGeBCv1mLiQtSv2eNuwlFG2veUnccy7TXWWovXBMSvhvmV8rJmUsVBkQrnS1H9UmDgWpSZWZiQxRTo0gkrmpU5Kf9/1vUcjrbqzK0Ql3tqe03F/M9m0DiSmpa/BHDecAE+D4utSRSB9q8ShZ2HaggpedvV4+wsWfSY8wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAkhN1/HY1TdvW1FRt9TinpxeraRBhXdEQhiO6FLN1I=;
 b=YhQtmV20rslImjYUjK+27ej8nQ5FjB0QdI5d2/6D0gNIIlMvzOD5V/GAYSHzgKQo5kefogUy7osTW6on2KdB6v2ZJ7ZwcZKmicxCH2GuWu2GgMkathxxyiQ4HLDFZMaXhVjiMgjLBSDCsCwsDmrNYngihVgo3O/KPc9l8xg91GnVpQ/il+m9lqU9BI/5EqdXSaCWFCsNiWHJ0Poa4g+HQpT8jcmMY3fFD5vDyQ2CqkRLkWQfAlYdpNOat+54Op5wS999W2xAhzNNKOdipP8HsJpPRyphF0bf0RhH+faORAgfZZahCqfoRXrEAIbiEz6PPKqLj2TedbLEh3wJCbwX3w==
Received: from DM6PR06CA0034.namprd06.prod.outlook.com (2603:10b6:5:120::47)
 by DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Tue, 13 Sep
 2022 06:58:30 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::de) by DM6PR06CA0034.outlook.office365.com
 (2603:10b6:5:120::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15 via Frontend
 Transport; Tue, 13 Sep 2022 06:58:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Tue, 13 Sep 2022 06:58:30 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Tue, 13 Sep 2022 06:58:29 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 12 Sep 2022 23:58:29 -0700
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 12 Sep 2022 23:58:27 -0700
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <tiwai@suse.com>, <perex@perex.cz>, <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [v2] ALSA: hda: Fix Nvidia dp infoframe
Date:   Tue, 13 Sep 2022 12:28:18 +0530
Message-ID: <20220913065818.13015-1-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: b892a30d-3540-40e6-ecce-08da95555dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Geal0j6zPpmfoB3zjTLzOT0jhMwTvpUabwu471f/MLGaJSZXUgpuqiAjsqUEy16iWBm5lnBYZoAnOgI2E5rBFMuaG2jl59bZln0SJ+S3SlEUmM1yH41VdqDMl6XyDUZXsle+kNbBl6wsD/MYxcPdvkKZi1N7y2+wuXxrgYVnjVjoUjYCL5h8S40g+sJbkb4AsIi0hs6cuSEPB8LYn6zNmEk/7nsauXPWpsUyDHyo8AWRv8MOBccto4EX6lTjNNZvdIj6UIMuRnJen9L00DnJcdye23AwM0EMVLY+XQrLZPC8IuYJWEafozNiiwYbla1q3wm0Utr7DX2nvikdTtUqhF6iYT/HPpKXw54Ex1n3AgXRuOacsZyVwygaUR2D61u7MKs6ZFvUzEzoZ0SFjFBfZntvrwSMZ15uIFtjj+5JeUbcmZDUNVrFIrEtuX4YQyvZA2VaKUawKRQSmgolvvCaXW9wqUAZrK6N6iC8N0l4hU3LYv6feo2ag5Ksus6dDbLNQyEJO0AlXswVoAHvKrO4tBGPQJ8BxO45EsAjQf+5zpKhGT30HNmBnPdVHiIHMvizq4Ekkom6Nn+Zf3+B1BcljzePNmuXvY6nc3UfHEMXSzb1ThIjQa9zYs89LV2ZrRzThNd3OKHjok9D4K/+xQhi7CnOJQZc8iV2jgxi9xarypiMH2jRP0qo/usoV75VlCw+tJ4Xsz4s3+3keco577Fa45IRnklXVAXjZRCCUY70wNIkvMTv8RTNnUbnnKhs6vEqcTpcoVSN3G5BFVVG0vWbbh8zugIu6r/u99gG+zJ2sYk7PVNT2j/6THj5s5Gt99Vm
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(86362001)(36860700001)(1076003)(316002)(41300700001)(478600001)(6666004)(82310400005)(40480700001)(7696005)(2906002)(2616005)(81166007)(5660300002)(4326008)(8936002)(47076005)(426003)(8676002)(82740400003)(83380400001)(40460700003)(54906003)(110136005)(356005)(107886003)(186003)(336012)(26005)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 06:58:30.3737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b892a30d-3540-40e6-ecce-08da95555dd1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nvidia HDA HW expects infoframe data bytes order same for both
HDMI and DP i.e infoframe data starts from 5th bytes offset. As
dp infoframe structure has 4th byte as valid infoframe data, use
hdmi infoframe structure for nvidia dp infoframe to match HW behvaior.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 sound/pci/hda/patch_hdmi.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 6c209cd26c0c..9127dd1b1a9c 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -170,6 +170,8 @@ struct hdmi_spec {
 	bool dyn_pcm_no_legacy;
 	/* hdmi interrupt trigger control flag for Nvidia codec */
 	bool hdmi_intr_trig_ctrl;
+	bool nv_dp_workaround; /* workaround DP audio infoframe for Nvidia */
+
 	bool intel_hsw_fixup;	/* apply Intel platform-specific fixups */
 	/*
 	 * Non-generic VIA/NVIDIA specific
@@ -679,15 +681,24 @@ static void hdmi_pin_setup_infoframe(struct hda_codec *codec,
 				     int ca, int active_channels,
 				     int conn_type)
 {
+	struct hdmi_spec *spec = codec->spec;
 	union audio_infoframe ai;
 
 	memset(&ai, 0, sizeof(ai));
-	if (conn_type == 0) { /* HDMI */
+	if ((conn_type == 0) || /* HDMI */
+		/* Nvidia DisplayPort: Nvidia HW expects same layout as HDMI */
+		(conn_type == 1 && spec->nv_dp_workaround)) {
 		struct hdmi_audio_infoframe *hdmi_ai = &ai.hdmi;
 
-		hdmi_ai->type		= 0x84;
-		hdmi_ai->ver		= 0x01;
-		hdmi_ai->len		= 0x0a;
+		if (conn_type == 0) { /* HDMI */
+			hdmi_ai->type		= 0x84;
+			hdmi_ai->ver		= 0x01;
+			hdmi_ai->len		= 0x0a;
+		} else {/* Nvidia DP */
+			hdmi_ai->type		= 0x84;
+			hdmi_ai->ver		= 0x1b;
+			hdmi_ai->len		= 0x11 << 2;
+		}
 		hdmi_ai->CC02_CT47	= active_channels - 1;
 		hdmi_ai->CA		= ca;
 		hdmi_checksum_audio_infoframe(hdmi_ai);
@@ -3617,6 +3628,7 @@ static int patch_nvhdmi_2ch(struct hda_codec *codec)
 	spec->pcm_playback.rates = SUPPORTED_RATES;
 	spec->pcm_playback.maxbps = SUPPORTED_MAXBPS;
 	spec->pcm_playback.formats = SUPPORTED_FORMATS;
+	spec->nv_dp_workaround = true;
 	return 0;
 }
 
@@ -3756,6 +3768,7 @@ static int patch_nvhdmi(struct hda_codec *codec)
 	spec->chmap.ops.chmap_cea_alloc_validate_get_type =
 		nvhdmi_chmap_cea_alloc_validate_get_type;
 	spec->chmap.ops.chmap_validate = nvhdmi_chmap_validate;
+	spec->nv_dp_workaround = true;
 
 	codec->link_down_at_suspend = 1;
 
@@ -3779,6 +3792,7 @@ static int patch_nvhdmi_legacy(struct hda_codec *codec)
 	spec->chmap.ops.chmap_cea_alloc_validate_get_type =
 		nvhdmi_chmap_cea_alloc_validate_get_type;
 	spec->chmap.ops.chmap_validate = nvhdmi_chmap_validate;
+	spec->nv_dp_workaround = true;
 
 	codec->link_down_at_suspend = 1;
 
@@ -3992,6 +4006,7 @@ static int tegra_hdmi_init(struct hda_codec *codec)
 	spec->chmap.ops.chmap_cea_alloc_validate_get_type =
 		nvhdmi_chmap_cea_alloc_validate_get_type;
 	spec->chmap.ops.chmap_validate = nvhdmi_chmap_validate;
+	spec->nv_dp_workaround = true;
 
 	return 0;
 }
-- 
2.17.1

