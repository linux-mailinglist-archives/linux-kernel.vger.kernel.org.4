Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31E56626B7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237126AbjAINSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbjAINSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:18:06 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C0417E01
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 05:17:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sqo1W0aWkY8xbKhztQgw/DiD98z57JgLfkXFQv5Rk0OKKD5HLYIIN5Krsh/PviReRUIPqMIziDN8ZZdhjYFK3jcPxaYgFAeILBXgsKCjyAeuRgmNzsliD/80aHDuQQ44gSmGGmYmIh2Xj5pw/kkUpOcR5ZWzO5Aole+KLOrzvMdMh38m9JJTEwuim8IfmUEQGOfAaD3F27Ri1+nuhXRM0wnrY+wyEulciQygbOAj4LB/diGNbvJ+/u/nILxK4orgDsJfZvrIxcNWq0i6iGQFBp4p2QOM6t5YhcYHr6OreGxJK3JqlZAt31g0spBiMQxq5R8GvyEXEvbmp6x4+N3EFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ri/h6paH/3Qy6PA6nANoA2FSo6zPjGIKEUPaduyvixU=;
 b=MNL8J/coN5ckZ9yEb+BsW2pyJ0O4m+U1fDGeUrozgLbCXzuOxxtZXOsvJdzWfGnT7NgbK36w3GLXYmsFqafCrRYNj3+37w8kgc5MO3t9Y2EE+FEqHNaQdNSusfTTK0rKyy/S3D9S4iPAywBtmAqQiy4hZwAfPEae31125IKRN5Wk8yPEkMJiX7gKgxkxRK1geLOAASvocsPDvGJehc3X2CoUA27qTD/COqs0uhN8ZmhIkhvUxZpGol916thZQZPItTx1gVJZkYeGkcJ2Foj3dAhsSWZKIBU6GsjvNKxk9Qcg0qHNv7+OFo0u0B9t7JnB/GOXXWtrxcGhM0rneIMwjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ri/h6paH/3Qy6PA6nANoA2FSo6zPjGIKEUPaduyvixU=;
 b=2RNIPUrBJFgS0CK407tMgvwX6DF4DWl4GVAxcUznc8XA/1BRoUlSTNOxTsXvmUvmYnecQybjSbw+aRrqHqAwXIdnnjsOETVWeUjo7/CfKEjFpEYhAx7Atn1y656GOIBPvOiCTDjGE/r2tA7rfN+2V76tLATEtQPXA7H6GY5RK7s=
Received: from DM6PR07CA0075.namprd07.prod.outlook.com (2603:10b6:5:337::8) by
 BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 13:17:52 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::43) by DM6PR07CA0075.outlook.office365.com
 (2603:10b6:5:337::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 13:17:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 13:17:52 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 07:17:51 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 05:17:51 -0800
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 9 Jan 2023 07:17:42 -0600
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
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/5] ASoC: amd: acp: Enable i2s tdm support for skyrim platforms
Date:   Mon, 9 Jan 2023 18:51:04 +0530
Message-ID: <20230109132104.1259479-6-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109132104.1259479-1-venkataprasad.potturu@amd.com>
References: <20230109132104.1259479-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT004:EE_|BL1PR12MB5142:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6d7a84-16af-4c25-89e7-08daf243e9b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bhr/8eh519SVX0GYkRCr1XI+fxW8bcxPtxkl0B8pOSDBUi57sp2ek8qumjkOMs9SA78td0DjRJKc3RIGNnjnB1luqZT+148pd5z2cxO7jkvk/otqgDU7qWeUb/YZnJNOEsWoilyB9NHkitktZhYVMgWaUky3ZKDL/UdCXrB8u5xued0upK779EAWHxVIfV0Q8NlopyObFIu93oHdTO/VskDvZGSZiQ7ey7xRqKiEc+bbk0/xjePtrmDjr8AuSU2JjgxRzJZ01dIJxLxWAxGNAwG+KMF7dWmEfBbL6r/7p1avP4Q6q52TceJPnv5m8q2Ze1xgdJwlmA8ITcBAwIRsuu0DsRXGicbZnMNgexXo7pxA2+WGT9o0a76E2XqlyAqX3LqqQmCNYmhEO9wMyTGi/dME/ei0qXMRDV04xwTxcZ2+7VZmO4JRHsNPcgR7Ow9Y2PQdEfLhlepkBgi7khn9ofKNKW439PEG/XZtfBO9zngzFDrHVJOj5b4P1pEEHsoZ+bXpdo2ZDCuAFqB86/pTRQG6rl0ROt1ydUu0L1Pq6mcdgeo6WAuvI29oHBOUOy2qt5EXlsUM7j0R7JYuuzvG36q4JaFFtIESMktUm+peghjoagcpqWvz288sqv08EBQyQvWvG2qwmfTaNoWgxpttwsLVgpg0i7OATeMhgYQwd68Kj+/B/Z/zdQYvAkq2DUvoUl29XUJzY7sy4NnbnhTJR5i65vQX2gkWTipVZy9+9kM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199015)(40470700004)(46966006)(36840700001)(82310400005)(8936002)(40460700003)(2906002)(5660300002)(426003)(47076005)(41300700001)(81166007)(7696005)(4326008)(70586007)(8676002)(70206006)(316002)(356005)(110136005)(54906003)(186003)(26005)(82740400003)(40480700001)(2616005)(1076003)(336012)(36860700001)(86362001)(36756003)(478600001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 13:17:52.3350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6d7a84-16af-4c25-89e7-08daf243e9b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable i2s tdm support for skyrim platform using dmi quirks.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-legacy-mach.c |  8 ++++++++
 sound/soc/amd/acp/acp-mach-common.c | 14 ++++++++++++++
 sound/soc/amd/acp/acp-mach.h        |  1 +
 sound/soc/amd/acp/acp-sof-mach.c    |  8 ++++++++
 4 files changed, 31 insertions(+)

diff --git a/sound/soc/amd/acp/acp-legacy-mach.c b/sound/soc/amd/acp/acp-legacy-mach.c
index d508792dba4f..676ad50638d0 100644
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
+	struct acp_card_drvdata *acp_card_drvdata;
 	int ret;
 
 	if (!pdev->id_entry)
@@ -113,6 +116,11 @@ static int acp_asoc_probe(struct platform_device *pdev)
 	card->num_controls = ARRAY_SIZE(acp_controls);
 	card->drvdata = (struct acp_card_drvdata *)pdev->id_entry->driver_data;
 
+	acp_card_drvdata = card->drvdata;
+	dmi_id = dmi_first_match(acp_quirk_table);
+	if (dmi_id && dmi_id->driver_data)
+		acp_card_drvdata->tdm_mode = dmi_id->driver_data;
+
 	acp_legacy_dai_links_create(card);
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index ffab6328baf0..b83ae946b3e4 100644
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
index f3ba22a25962..99a7d3879340 100644
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
+	struct acp_card_drvdata *acp_card_drvdata;
 	int ret;
 
 	if (!pdev->id_entry)
@@ -120,6 +123,11 @@ static int acp_sof_probe(struct platform_device *pdev)
 	card->num_controls = ARRAY_SIZE(acp_controls);
 	card->drvdata = (struct acp_card_drvdata *)pdev->id_entry->driver_data;
 
+	acp_card_drvdata = card->drvdata;
+	dmi_id = dmi_first_match(acp_quirk_table);
+	if (dmi_id && dmi_id->driver_data)
+		acp_card_drvdata->tdm_mode = dmi_id->driver_data;
+
 	acp_sofdsp_dai_links_create(card);
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
-- 
2.25.1

