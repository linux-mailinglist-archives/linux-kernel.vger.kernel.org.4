Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B476E651B80
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbiLTHYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiLTHYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:24:08 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B0A11C28
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:23:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTaJYYZ27ltCVsPCUlY09b3Kjo9cgwc59uObIdwLfSZyCY38SpbhN+OIYW15e2kwJTCe/wJbxvT9pS+Ifafl94Z2Sxgc6WNGUYycZi3O6T+xpULyrF00epf6lhWJaxtIA+3HyazhQh8+beIrEqNWzTXckSFYh5DKaz3Pgnz4G9c7AufjwBsdbPySml29nYsyHaQzs5J1SIrAQD+bzApKuCj60S2ZpE3v9dYt0qyW1CKUiQ2PEWgXea7+csL1jn+FoDSCQ/P3EwbUj4tjBjeRIucjRpDgrHDAZuMP0aOhP9U95tXQFcr8EWwXEM+EdiET0goco1NczDj5XLKr6O52sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykCI5N8keBqShLGS5+VKgUK3O6kAbfgv32T0VSJUBok=;
 b=StPfj0eZvZxCBfTSKW+KvtBdPTcahryxVLeNGUL5/YAlJBjUv+imERf61gSfMvsZF5Tr+QfhePlhFLaq+9OJWck4q4pclwmAafK3njV6VhPb+YTryWOLX2M1Ti+v8n1rFGs1SzkbV8yntZhEHSz1zUvtqvI0pQx5UgMVQx++4HkVhX8yiqImJTjr8r53o0sEHCsPjFo0y2eiT+WcHLJ0yy7Q2ipBkfc/t4THX80/3BcBeZnUU5kB9bOkc7APlubTUk6uZAyYie3pMugmFLfO1HLaKRgkxZ1Hyj1Hhs5c2cIZ2I93QxDYf9pTCDElWdowTu3xzLM4T8CQzE8SuRAL+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykCI5N8keBqShLGS5+VKgUK3O6kAbfgv32T0VSJUBok=;
 b=F6XLg7dJu8oj3iovNmVFEQ9SQg3OEf0tOIZfg6hoYD5o7Egkzll9fFOboW+z5O8DlcZJqyNQ6KS5z/fddTU83xKUyU/uXWcMqlK/Ahb4BqtYZmnpSHwGJiH5gnkHEGX4sDA2d4IXvRVTD5crwdfgEF5nZeTUNOkbeaif2ieHtYc=
Received: from DS7PR03CA0147.namprd03.prod.outlook.com (2603:10b6:5:3b4::32)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 07:23:55 +0000
Received: from DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::32) by DS7PR03CA0147.outlook.office365.com
 (2603:10b6:5:3b4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Tue, 20 Dec 2022 07:23:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT110.mail.protection.outlook.com (10.13.173.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.16 via Frontend Transport; Tue, 20 Dec 2022 07:23:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 20 Dec
 2022 01:23:51 -0600
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 20 Dec 2022 01:23:42 -0600
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <vsujithkumar.reddy@amd.com>, <Vijendar.Mukunda@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <ssabakar@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] ASoC: amd: acp: Enable tdm support for skyrim platforms
Date:   Tue, 20 Dec 2022 12:57:05 +0530
Message-ID: <20221220072705.1456908-6-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221220072705.1456908-1-venkataprasad.potturu@amd.com>
References: <20221220072705.1456908-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT110:EE_|IA0PR12MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 381d2692-0ef9-4c88-d38c-08dae25b26a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fDa7D/DPwEg+b26SyEwH7YaifUGfbkZrhkN0Fk2kF2B6PcKK4stI/ckMwS00Pi8F4qLgdXY3JaVlG6+f/qrbnh+yuIwld2I2Omr6+WWxHppoNHzJHzfwuTTlgxghHsEyBCBoK4ghKz20ciNhmh/i0kE36kANqZEJ6b3aPzrKbIWy26yrs6uwv4Tsq6yp7ms/RQHMEK2P01n59PpzMppkUKfXyvxchqvospaR6My1iIBoaIC5ii1eVnndMMgPc2tAf4Tr+PU84GiLHNHezho7FvuLRArGpE4Sxnvb0n4mM5tdWcggITz2dUnuubk3odpjxHolNzAdknxwP7PYUqXMUYwFdalul6uZwoHRErSIOdSSfsndH18TD3beVI5WmXZJfbEauwwPujMQ2uMgmAs8sVrqdpTcNN/D0P+gxhh511KzbP2PRh6OJndBMhT0WpmHJcOpenFQmO+rQCJHOLBckaR7URezJrM/MU2Ffwqs0gByVnaI6bP6F/qgmqbV8tEUHeOaGP7ps4t3gqkS1sDDM42kzgtvHQAxABCKfJnllKYQYtLCiuLQMidTY4CgrX68EHPJJKpHXbK0LDbteJ0nuBpwsUOncNnzJCl2v+Wl7S+EL2Rr/6ZopxFIXmjeIA5m2KN+Ah3wa/Omd9UHIfX1HlAhNHbJ5kkjNMm9vTcEV6ZJOBXmfZzn8OtMBF0pgyvjDJEjQGrdhUc3jdcZEnQNqtPXqGOlzkgD8WnyBjYshyE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199015)(46966006)(40470700004)(36840700001)(5660300002)(4326008)(8676002)(110136005)(54906003)(70586007)(70206006)(2906002)(6666004)(478600001)(26005)(186003)(7696005)(41300700001)(47076005)(426003)(40480700001)(86362001)(82310400005)(36860700001)(2616005)(336012)(1076003)(36756003)(82740400003)(81166007)(356005)(8936002)(316002)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 07:23:54.3868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 381d2692-0ef9-4c88-d38c-08dae25b26a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable tdm support for skyrim platform using dmi quirks.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-legacy-mach.c |  8 ++++++++
 sound/soc/amd/acp/acp-mach-common.c | 14 ++++++++++++++
 sound/soc/amd/acp/acp-mach.h        |  1 +
 sound/soc/amd/acp/acp-sof-mach.c    |  8 ++++++++
 4 files changed, 31 insertions(+)

diff --git a/sound/soc/amd/acp/acp-legacy-mach.c b/sound/soc/amd/acp/acp-legacy-mach.c
index d508792dba4f..04958a884cfd 100644
--- a/sound/soc/amd/acp/acp-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-legacy-mach.c
@@ -16,6 +16,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc-acpi.h>
 #include <sound/soc-dapm.h>
+#include <linux/dmi.h>
 #include <linux/module.h>
 
 #include "acp-mach.h"
@@ -95,6 +96,8 @@ static int acp_asoc_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = NULL;
 	struct device *dev = &pdev->dev;
+	const struct dmi_system_id *dmi_id;
+	struct acp_card_drvdata *acp_drvdata;
 	int ret;
 
 	if (!pdev->id_entry)
@@ -113,6 +116,11 @@ static int acp_asoc_probe(struct platform_device *pdev)
 	card->num_controls = ARRAY_SIZE(acp_controls);
 	card->drvdata = (struct acp_card_drvdata *)pdev->id_entry->driver_data;
 
+	acp_drvdata = card->drvdata;
+	dmi_id = dmi_first_match(acp_quirk_table);
+	if (dmi_id && dmi_id->driver_data)
+		acp_drvdata->tdm_mode = dmi_id->driver_data;
+
 	acp_legacy_dai_links_create(card);
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index 73a27f02b52b..bde3ea3377ef 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -32,6 +32,20 @@
 #define DUAL_CHANNEL	2
 #define FOUR_CHANNEL	4
 
+#define TDM_MODE_ENABLE 1
+
+const struct dmi_system_id acp_quirk_table[] = {
+	{
+		/* Google skyrim proto-0 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_PRODUCT_FAMILY, "Google_Skyrim"),
+		},
+		.driver_data = (void *)TDM_MODE_ENABLE,
+	},
+	{}
+};
+EXPORT_SYMBOL_GPL(acp_quirk_table);
+
 static struct snd_soc_jack pco_jack;
 
 static const unsigned int channels[] = {
diff --git a/sound/soc/amd/acp/acp-mach.h b/sound/soc/amd/acp/acp-mach.h
index 9f87439b3cfd..165f407697c0 100644
--- a/sound/soc/amd/acp/acp-mach.h
+++ b/sound/soc/amd/acp/acp-mach.h
@@ -65,5 +65,6 @@ struct acp_card_drvdata {
 
 int acp_sofdsp_dai_links_create(struct snd_soc_card *card);
 int acp_legacy_dai_links_create(struct snd_soc_card *card);
+extern const struct dmi_system_id acp_quirk_table[];
 
 #endif
diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
index f3ba22a25962..e5b3a0d5363a 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -16,6 +16,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc-acpi.h>
 #include <sound/soc-dapm.h>
+#include <linux/dmi.h>
 #include <linux/module.h>
 
 #include "acp-mach.h"
@@ -102,6 +103,8 @@ static int acp_sof_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = NULL;
 	struct device *dev = &pdev->dev;
+	const struct dmi_system_id *dmi_id;
+	struct acp_card_drvdata *acp_drvdata;
 	int ret;
 
 	if (!pdev->id_entry)
@@ -120,6 +123,11 @@ static int acp_sof_probe(struct platform_device *pdev)
 	card->num_controls = ARRAY_SIZE(acp_controls);
 	card->drvdata = (struct acp_card_drvdata *)pdev->id_entry->driver_data;
 
+	acp_drvdata = card->drvdata;
+	dmi_id = dmi_first_match(acp_quirk_table);
+	if (dmi_id && dmi_id->driver_data)
+		acp_drvdata->tdm_mode = dmi_id->driver_data;
+
 	acp_sofdsp_dai_links_create(card);
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
-- 
2.25.1

