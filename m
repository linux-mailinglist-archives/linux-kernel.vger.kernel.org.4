Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1A8653023
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 12:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbiLULXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 06:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiLULXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 06:23:35 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1702BD2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 03:23:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoRts4uqDTRP9vOGFppuiA5hisI2VK80bTocIzcrLGbMwIDyeR0c7YRRu7aoTVl+4GA9gxkxCSJkYsHPZdpEvmNwV+XJqZ77BVyRr0N8XibVGpc7aGyh7XIDvQgmHWSZDsuEysnX4bBCr2ks9CzsI69bYLUNPrD/BNBkKeypqjh587/KZVKvLQ9EJuMJ4wccU3QIJfmlLQSxjdpJN1BqeH1ZjzQnlPE+0fJXZFWTmOZFcSelaeeSx/JeYZlU18Uqo42EPLMGixjtNZr9U7LI7eB4qhT7PR/LAMya+bZQQYh2Gh86Z2KgFhxYBSXNMtp3q4yaKhaoUdtrnMEyHTNhug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1GVwBYvoHa0SIGmiUy1ZqDZSdZAxyh1wI56roI5VLg=;
 b=nAjTCUVbxuVS70wErjUb+EHFyHu2ld8c4iMepabvWo0dAcfR9u9IoE0aLgxJYF9lBO7+Agf6XAOyyCOC5VEsBbkL5Qi6fAPfEYQPn/Y+k0DC/vdAlRKGkUV98i8V1Me/Q9EgXT4p4DnWuSigz/oYXbpQK1ORE2hGP0hHTtQ7G8qT+ISkDUWvoDqs7XM6R0I8PJj0R/KWY0wSYV0mcxm9HHJV0YIAXdbHtP64nJIkj2CLcu9CHa6j31eFdlAddIEEMDHMu9EHIj6SeDDKeg2jvMzVEMdJ0iQA14qxwNj0yQHohA1CoABW3HrDZ7h+826W8O8ejBeoFTwEyX8w6Z9Ebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1GVwBYvoHa0SIGmiUy1ZqDZSdZAxyh1wI56roI5VLg=;
 b=JnX2uD5qWe4Rakc8Rr+GcPrgjLzf+UDKyx0t+/jfeKQ32eXxlScohXvg+pPn/IHRGq9RgzJ75ddtiqfKiwC20Dwba8oFQKZk8lF6uI+qESE6cP54JG3DIaJzPaNNGY46vCs9NC+ijmtxF5G6XpqyfaAH4/eOUx6ZJe2UMpSCOJ0=
Received: from DM6PR01CA0027.prod.exchangelabs.com (2603:10b6:5:296::32) by
 SJ1PR12MB6195.namprd12.prod.outlook.com (2603:10b6:a03:457::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 11:23:32 +0000
Received: from DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::60) by DM6PR01CA0027.outlook.office365.com
 (2603:10b6:5:296::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 21 Dec 2022 11:23:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT094.mail.protection.outlook.com (10.13.172.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.6 via Frontend Transport; Wed, 21 Dec 2022 11:23:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 21 Dec
 2022 05:23:31 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 21 Dec
 2022 05:23:31 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 21 Dec 2022 05:23:28 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 1/4] ASoC: amd: ps: implement api to retrieve acp device config
Date:   Wed, 21 Dec 2022 16:56:03 +0530
Message-ID: <20221221112611.1373278-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT094:EE_|SJ1PR12MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f7bf640-ee03-448d-92b0-08dae345cae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ox0+U49w6OrcDT9z8dAXH14la9lOq5AfV2ZQFBdB9vTGR/Go9/9FhPt7+9prZMfrHkT5z7FAc/yuae7T3TiBCq7Ps/sqgtk9w9j7L1iv3VWCuYqJH8jawe/Xx68r5nUnN91C3MYk7DNRmaugmFS9QXoGyPhHPZKXGFr8BDLrBuOUIk1LkkLc5huEPc6s5hEE5jGkH2tpN0yOyZlaJov62Dk52VXOqPmTbeVF4HVi97I+LCYyQxQ9Us1Vt/ZF4aVX7kQsKdcj8CrpQRdbAD32i+CxcPzB9k40fLtJO0ZDu01EjMVP7qAwb4D4pKY1j6ZgG72uSsByDRbd8D8S85dNDvmcvSK7VxuVKM1cJ6Lb6BxlZReVXvLz8ZQm3JzA/i+tGJiJfHy8WCMP1L52oKvtXsWuqyeCaPGlpJTTTxq/j/88KBZ0u4k4aOpmEkMaNWCMkq5qmaLFcGN1NbyRxhKVNl0SlY/tiuAq+hQJQqaoPxSPjbEzxS8Lui1PwxOXWuInSDoUmuUMd4ZL6VIdiMdYAeZL9kDIkE+9l5lql7aGYyzxpG6WzDMnyHTk9+lKNg7Qjx80kQBkwpr1Cmzdg/dJxT7SNWrh71EhhhNRLMF+OULZGCwjV1EGWMFkzPRFYlntPYlYF5TP9k+OyDP5S5ojjO9LN8WCde7vwes0WXx7gy7WRznk/5+CMxn9CRgetJzNsozGrap+xsp9PZhmiVomnvH4b0VDbce/Y6Ec4x4Wcys=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(7696005)(478600001)(36756003)(2906002)(186003)(336012)(26005)(40460700003)(110136005)(81166007)(41300700001)(1076003)(82310400005)(8676002)(70206006)(70586007)(47076005)(5660300002)(83380400001)(426003)(4326008)(316002)(8936002)(40480700001)(54906003)(356005)(86362001)(36860700001)(82740400003)(2616005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 11:23:32.1594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7bf640-ee03-448d-92b0-08dae345cae1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6195
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement API to retrieve acp device config and calculate platform
device count and dev mask for platform device node creation.

Currently for DMIC configuration, mask and dev count are calculated.
Same api will be used to extend support for different ACP device
configurations.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
v1->v2:
    - used ACP_DMIC_DEV macro instead of hard coded value
    - changed is_dmic_dev variable initialization
    - changed debug level

 sound/soc/amd/ps/acp63.h  |  7 +++++++
 sound/soc/amd/ps/pci-ps.c | 37 +++++++++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 5e7f9c1c1b0e..b015e845e5fa 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -54,6 +54,11 @@
 /* time in ms for runtime suspend delay */
 #define ACP_SUSPEND_DELAY_MS	2000
 
+#define ACP63_DMIC_ADDR		2
+#define ACP63_PDM_MODE_DEVS		3
+#define ACP63_PDM_DEV_MASK		1
+#define ACP_DMIC_DEV	2
+
 enum acp_config {
 	ACP_CONFIG_0 = 0,
 	ACP_CONFIG_1,
@@ -102,4 +107,6 @@ struct acp63_dev_data {
 	struct resource *res;
 	bool acp63_audio_mode;
 	struct platform_device *pdev[ACP63_DEVS];
+	u16 pdev_mask;
+	u16 pdev_count;
 };
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 489f01a20699..9066a625e501 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -132,6 +132,38 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
+void get_acp63_device_config(u32 config, struct pci_dev *pci, struct acp63_dev_data *acp_data)
+{
+	struct acpi_device *dmic_dev;
+	const union acpi_object *obj;
+	bool is_dmic_dev = false;
+
+	dmic_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_DMIC_ADDR, 0);
+	if (dmic_dev) {
+		if (!acpi_dev_get_property(dmic_dev, "acp-audio-device-type",
+					   ACPI_TYPE_INTEGER, &obj) &&
+					   obj->integer.value == ACP_DMIC_DEV)
+			is_dmic_dev = true;
+	}
+
+	switch (config) {
+	case ACP_CONFIG_0:
+	case ACP_CONFIG_1:
+	case ACP_CONFIG_2:
+	case ACP_CONFIG_3:
+	case ACP_CONFIG_9:
+	case ACP_CONFIG_15:
+		dev_dbg(&pci->dev, "Audio Mode %d\n", config);
+		break;
+	default:
+		if (is_dmic_dev) {
+			acp_data->pdev_mask = ACP63_PDM_DEV_MASK;
+			acp_data->pdev_count = ACP63_PDM_MODE_DEVS;
+		}
+		break;
+	}
+}
+
 static int snd_acp63_probe(struct pci_dev *pci,
 			   const struct pci_device_id *pci_id)
 {
@@ -183,6 +215,7 @@ static int snd_acp63_probe(struct pci_dev *pci,
 	if (ret)
 		goto release_regions;
 	val = acp63_readl(adata->acp63_base + ACP_PIN_CONFIG);
+	get_acp63_device_config(val, pci, adata);
 	switch (val) {
 	case ACP_CONFIG_0:
 	case ACP_CONFIG_1:
@@ -195,14 +228,14 @@ static int snd_acp63_probe(struct pci_dev *pci,
 	default:
 
 		/* Checking DMIC hardware*/
-		adev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), 0x02, 0);
+		adev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP_DMIC_ADDR, 0);
 
 		if (!adev)
 			break;
 
 		if (!acpi_dev_get_property(adev, "acp-audio-device-type",
 					   ACPI_TYPE_INTEGER, &obj) &&
-					   obj->integer.value == 2) {
+					   obj->integer.value == ACP_DMIC_DEV) {
 			adata->res = devm_kzalloc(&pci->dev, sizeof(struct resource), GFP_KERNEL);
 			if (!adata->res) {
 				ret = -ENOMEM;
-- 
2.34.1

