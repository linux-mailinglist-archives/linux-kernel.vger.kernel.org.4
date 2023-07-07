Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D9774B076
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 14:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjGGMI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjGGMIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:08:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6572139
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 05:08:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoyKEgMwGAjGiad8b2nnvyNE78FP/NVLUTsckHsAO2nYtBWO7WmXjXt0FiPsQvZxplI4jie27MfTkhlwqx90N6TPNp0dnHa1gKH7lyjtrFvIsBHtSCOfU5LVcGrH9iSgRKE8tz/vFLWAOjPEeEXJcZpl+K/7ldkV9IRI9HqHIdNjiZXcShyX/lfdxwOYmoTlzafkeUMiuLIepbPo/uo8BJXWH15s3A9K0EHovpoCXY6Tfjr9ELM1tqTg4g2IXkX14rwrHhzGxbelLlOeE8W1oQIL4fS5uL3cMN/+8vW5etVeAsfSb8bCLWhmaZQcUfuVJCT4a//j+uzFV5A6GlAtfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9S1tAAkfGSYREcf+q5bUfKtloPJMGR4TCOmv5xku3Q=;
 b=IOC4hOGbVvNjpdfa4Lkqy0neRNB9zYUFe/WL8/SzaiGGpkC2qSSc/aNLRrEwSX946iXOyxSlROmJgjsh3QH9CH9QvNfo4onhznu8z1OfIS9WiU9X8JB/kvgzrFAd0Uy1Ij0GqEuLXOphpFup4REhdnmGbdb9JHh1wW3O4dOF196UyH8nPBioEP7WCV8FH5RyBHmPPToeIniIvZcaUqCW7J27Fi9BpkRhvDnPX2+DH7eTKsznIhHu8cLA/rUZ093Lpah8syINc+IlbIwphktpAfaANUlC617cVhyhxAjCiWavnkcOW32iP6PV66Zz/zAvwGTqpVpb2YsAQcZNpCv0Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9S1tAAkfGSYREcf+q5bUfKtloPJMGR4TCOmv5xku3Q=;
 b=H9KOJgVAWSDhCigMwD3idInk8TVhtuJQG9fC/stxE0GUr15NH8nh8eGaoGGpJ5KRi/L0Mxqpi9YNCcDABXJ1otl+lvoauyg98HoPTXNH0Qp56rd6drLbCHQnNA2VlVGguPHFGmVv6gG0Bfa/xyuo16FItts0MLpCyF8gm9qZgYA=
Received: from DS7PR06CA0031.namprd06.prod.outlook.com (2603:10b6:8:54::11) by
 SJ2PR12MB7846.namprd12.prod.outlook.com (2603:10b6:a03:4c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 12:08:08 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::e6) by DS7PR06CA0031.outlook.office365.com
 (2603:10b6:8:54::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Fri, 7 Jul 2023 12:08:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Fri, 7 Jul 2023 12:08:08 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 07:08:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 7 Jul 2023
 05:08:07 -0700
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Fri, 7 Jul 2023 07:08:03 -0500
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <vsujithkumar.reddy@amd.com>, <Vijendar.Mukunda@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <syed.sabakareem@amd.com>, <mastan.katragadda@amd.com>,
        <arungopal.kondaveeti@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] ASoC: amd: Add acpi machine id's for vangogh platform
Date:   Fri, 7 Jul 2023 17:37:29 +0530
Message-ID: <20230707120730.1948445-4-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230707120730.1948445-1-venkataprasad.potturu@amd.com>
References: <20230707120730.1948445-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT008:EE_|SJ2PR12MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: 21fd59af-12af-44b1-9d7b-08db7ee2d3c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0OpC3i11fpTLQ8n6/Iu21tmgDRfjeAn838BzhEI2BoBB4C4F+Qr2HOHhUTPxX6Q4c7aGxRgvlmZTPsYEWZC3skcO453ptZjgJfmNDE985khD4VmLf5SqdzcFM6DVyhOcIQbIIH5L+Q4ODVPOpK76nHzj9Ib7jSmUV+eMK+2LYTunf2Uamyr+sEoYMwHVCJ0RCFc6JjLMtRXhBMcbFS0KG4anPkUQeJiPa7atY4PRCpWwzL7TJkehXetgE/ImOVGSdB5IasoqY00kg6NPCNneg4vWYK4RnXUpsbsY9uvV+6s6Io5toIi8HKB0BLzCnBQGmc2QF942JbCwVZT/L/MfgMCjClsQCMl9qPV43gSDfYGyfy02dF+xDQUncoTu8cftB9LyCS3QJ9wVdH8QXIfxAfMJjhfTTS3DGCl7E7MAF9qqQ/zN/av/EkXAmLqtpVFpeSKxQuFD8mhgbvPVwmlpvZdFPvtWp/n31rkr2mZMKH3UA2hcWA4Sgk61E2dLjNt56YjsJU5CFXLHt+456XKYLNsCzZ0cPACJOsw+w7dnKx/1xF/WY0Yh5FNpkJNErSaQYqVABmNsLzJJI9qG8XOU5tK8VvGIy/Njd/V5lAq/euLt841y8+P86AIS+nKelwx+/HczegEEhwkmw+dZ2Fb/hXmCxcSxoIeBhvAi7EFCoXrIeAmjAEedNrzGCAq3coIdBWnkGeafBfLxpf8007cquP/c7HJevo9hiKohb68tSC5MHCEqGB1mLuRH9AEDtypbINxrLCo2Tvsxx20DdXdYxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(36840700001)(46966006)(40470700004)(6666004)(40460700003)(70206006)(70586007)(82740400003)(4326008)(2616005)(356005)(81166007)(82310400005)(186003)(336012)(86362001)(26005)(1076003)(36860700001)(47076005)(426003)(36756003)(478600001)(7696005)(40480700001)(110136005)(54906003)(41300700001)(5660300002)(8936002)(8676002)(2906002)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 12:08:08.2731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fd59af-12af-44b1-9d7b-08db7ee2d3c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7846
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add acpi machine id's for vangogh platform and configure
driver data to enable SOF sound card support on newer boards.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp-config.c       | 19 +++++++++++++++++++
 sound/soc/amd/acp/acp-sof-mach.c | 16 ++++++++++++++++
 sound/soc/amd/mach-config.h      |  1 +
 3 files changed, 36 insertions(+)

diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index 0932473b6394..f002397caeef 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -82,6 +82,11 @@ static struct snd_soc_acpi_codecs amp_max = {
 	.codecs = {"MX98360A"}
 };
 
+static struct snd_soc_acpi_codecs amp_max98388 = {
+	.num_codecs = 1,
+	.codecs = {"ADS8388"}
+};
+
 struct snd_soc_acpi_mach snd_soc_acpi_amd_sof_machines[] = {
 	{
 		.id = "10EC5682",
@@ -130,6 +135,20 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_sof_machines[] = {
 };
 EXPORT_SYMBOL(snd_soc_acpi_amd_sof_machines);
 
+struct snd_soc_acpi_mach snd_soc_acpi_amd_vangogh_sof_machines[] = {
+	{
+		.id = "NVTN2020",
+		.drv_name = "nau8821-max",
+		.pdata = &acp_quirk_data,
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &amp_max98388,
+		.fw_filename = "sof-vangogh.ri",
+		.sof_tplg_filename = "sof-vangogh-nau8821-max.tplg",
+	},
+	{},
+};
+EXPORT_SYMBOL(snd_soc_acpi_amd_vangogh_sof_machines);
+
 struct snd_soc_acpi_mach snd_soc_acpi_amd_rmb_sof_machines[] = {
 	{
 		.id = "AMDI1019",
diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
index 99a7d3879340..a1c893f33f74 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -83,6 +83,17 @@ static struct acp_card_drvdata sof_rt5682s_hs_rt1019_data = {
 	.tdm_mode = false,
 };
 
+static struct acp_card_drvdata sof_nau8821_max98388_data = {
+	.hs_cpu_id = I2S_SP,
+	.amp_cpu_id = I2S_HS,
+	.dmic_cpu_id = NONE,
+	.hs_codec_id = NAU8821,
+	.amp_codec_id = MAX98388,
+	.dmic_codec_id = NONE,
+	.soc_mclk = true,
+	.tdm_mode = false,
+};
+
 static const struct snd_kcontrol_new acp_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
@@ -166,6 +177,10 @@ static const struct platform_device_id board_ids[] = {
 		.name = "rt5682s-hs-rt1019",
 		.driver_data = (kernel_ulong_t)&sof_rt5682s_hs_rt1019_data
 	},
+	{
+		.name = "nau8821-max",
+		.driver_data = (kernel_ulong_t)&sof_nau8821_max98388_data
+	},
 	{ }
 };
 static struct platform_driver acp_asoc_audio = {
@@ -187,4 +202,5 @@ MODULE_ALIAS("platform:rt5682s-max");
 MODULE_ALIAS("platform:rt5682s-rt1019");
 MODULE_ALIAS("platform:nau8825-max");
 MODULE_ALIAS("platform:rt5682s-hs-rt1019");
+MODULE_ALIAS("platform:nau8821-max");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/amd/mach-config.h b/sound/soc/amd/mach-config.h
index 7b4c625da40d..d392e6d6e6e1 100644
--- a/sound/soc/amd/mach-config.h
+++ b/sound/soc/amd/mach-config.h
@@ -20,6 +20,7 @@
 
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_sof_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_rmb_sof_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_amd_vangogh_sof_machines[];
 
 struct config_entry {
 	u32 flags;
-- 
2.25.1

