Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C3F65350F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiLUR0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiLUR0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:26:20 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F205FFF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:26:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=An3imOhKDwCgcFKLAea/Fl4ceJIquEcDGMVG6cT/tg+rmbnZ7UHHMxeUoCqtzzv6cKdr6buX9kZudI8a5ZPSWYFDaNbLto/w7BedUmY72PdylqqawlNc/4nZtRxHGZKmKyZUrkD9V9RAxdIYJbWj3dWj8VAAOPGg6Z1UWOcnZ3wKuIqt8kUdA0DQ62pVwbCFvz2rfKHGwbfLosV1El9jWtaJ53dS/nFSDR5vG+aA9hWbmLNMAJXq9wwAotkMQxGQBzQkBEN/q2O/7OqGsh8EewoTmoe1gcBx0ko8TUgGGzR6X0c+4s1tH+hHRcBU7f/xNevEIZJSLon8Crnlpf3Q9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J96pzOxwZFlgg0y0WXIGl2xP84XmZEDfli4PLk6EJVA=;
 b=E8+Y/y0r/RaQS3q/XEYW8MSu2B38IKLum1l3dTWSyi9G3mCMqW2MhSdfOzBiOn6KDUFiYedYAT7nzVW/G/y1FwyIFCpuC57QX0xGP5WdIKpF7rq0j14CoIBtJfloTVq/INH7Ru0YXnDoQyOP7bFabqZRCHaFKCfBsno5Y4VACBfXWeuv0/amrm48JRMce4VrbNKdfADJefgbWYeoeEl3HcuMpVSp7tsV8hDeDq4JD0F5pKXvIaAX99xWelPNEckdWOWe1yniE5ckjag+eZJaqOlvZMeIg1U/SlQ0LrN5NIujz+6tc95FNwMDcGYYFeM4urG9cEheyCRlpSLf5NdLZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J96pzOxwZFlgg0y0WXIGl2xP84XmZEDfli4PLk6EJVA=;
 b=1AohLLTyczqe1EzJ9nAVE0di5vNgO+P5Qvd9bkfoHFXcpSb1eBVdCdYaaoROyWeAKOeZ0PWBRbnAQUgTvo6PYE25rtigoGDkXiuEpd9DEAOoiurhGzSvZtmKynA7iH+CpJS7qUlKAmg27FAfx7tQWkXTZf+YXjDn/L3XUQow3Fg=
Received: from BN9P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::13)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 17:26:17 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::9e) by BN9P222CA0008.outlook.office365.com
 (2603:10b6:408:10c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Wed, 21 Dec 2022 17:26:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.10 via Frontend Transport; Wed, 21 Dec 2022 17:26:17 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 21 Dec
 2022 11:26:16 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 21 Dec
 2022 09:26:16 -0800
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 21 Dec 2022 11:26:13 -0600
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
Date:   Wed, 21 Dec 2022 22:58:48 +0530
Message-ID: <20221221172855.1618766-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ed88a8-e432-4bd7-95f9-08dae37877e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9JTpQ96ka+t5OPr58AVNogKyAdlUBN4oqrwa3DYF1b0CfY26VU4MOnAmBJh90pe8OJ8h6d4+knALFKhkwOPRo70JLWI8QdQ5CH0zh5Aujz1M9HDSajeEqURE3FsjUGP0n4Wxbhj9PvX2WwfcfOSMYD+Em3XuGI1m4UaQW8dQtCOhf5UteZGv6qTM0FaJBu6h01RiqNVZ04lUidJnxif9gOHfA2TPtmgl4stchEDACMWCSe+48AXCChXlioWDNKccZKFL7zGdZh48qmIcdY/gn2MIpcoqQhlg+tav4TXLWawpsMGw07eEHU+LsH5Z2zOg+7Jh8sYil5NIg/V4+NKwpmt38cbVGCklYdJVLZdbTkbj/wADOmuUW9HOcTa7REjPG5ykstAOQzyezhqOGzXFdtGWU8FnGCSajvNnFlWCibGDWcK+9pReMnVu9DT10X0DvdfqEyJ+O+0H6WYBFUVSVrFVCidQRm8ncEisRyJ/0qStSIq5GTno9rJ5g4f/vmcAf44b/8h6bteo5vCcUwQQDRWQlC0lFD68M5tSprD7K4FuhoyUU9jtRBimhrKQI+jGQbb3P01WbePHS2uNpYEw8YFJp1XvsYJCDgXiMg2PoS22QYF7nG6ZRwsKUsUQ5oS6Te5wZ0yzzxXusoNlVg7CN0o905XnR/W6thxKRm0q6TOGwpUttfKm0hkTPlUBlVzCi06htAvuxx9iiVIvros9pj6D8yfmw5ZC0JLByLST+co=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199015)(36840700001)(40470700004)(46966006)(336012)(2616005)(426003)(1076003)(86362001)(316002)(40460700003)(54906003)(7696005)(2906002)(26005)(186003)(110136005)(478600001)(36756003)(6666004)(82740400003)(40480700001)(70586007)(47076005)(36860700001)(41300700001)(82310400005)(8676002)(5660300002)(4326008)(83380400001)(81166007)(356005)(8936002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 17:26:17.2796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ed88a8-e432-4bd7-95f9-08dae37877e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472
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
since v1:
       - fixed below build error
       sound/soc/amd/ps/pci-ps.c:231:60: error: use of undeclared identifier
       'ACP_DMIC_ADDR'
       - fixed below kernel warning
       >> sound/soc/amd/ps/pci-ps.c:135:6: warning: no previous prototype for 
       >> function 'get_acp63_device_config' [-Wmissing-prototypes]

 sound/soc/amd/ps/acp63.h  |  7 +++++++
 sound/soc/amd/ps/pci-ps.c | 38 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 2 deletions(-)

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
index 489f01a20699..86af94f6f06e 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -132,6 +132,39 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
+static void get_acp63_device_config(u32 config, struct pci_dev *pci,
+				    struct acp63_dev_data *acp_data)
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
@@ -183,6 +216,7 @@ static int snd_acp63_probe(struct pci_dev *pci,
 	if (ret)
 		goto release_regions;
 	val = acp63_readl(adata->acp63_base + ACP_PIN_CONFIG);
+	get_acp63_device_config(val, pci, adata);
 	switch (val) {
 	case ACP_CONFIG_0:
 	case ACP_CONFIG_1:
@@ -195,14 +229,14 @@ static int snd_acp63_probe(struct pci_dev *pci,
 	default:
 
 		/* Checking DMIC hardware*/
-		adev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), 0x02, 0);
+		adev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), ACP63_DMIC_ADDR, 0);
 
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

