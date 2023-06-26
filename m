Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1CB73E132
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjFZN4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjFZN4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:56:17 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE29C10CA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:56:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9yObnqTc17dBl1iVRPrm59W/q3CYkwI4eHZ0iuthlzZcXuTqUt4HRrzQtJfgtRQSJ3UeLXgliG6xAH2E6saIchx7cL4mQ5Fo/jinPU8dzUsXiHHerIk91Lsvn7JWXGZ5wET9PsJjZlIk7nP4mNJjuGjUbPdSP88EGSVHG6c0L9OgBpdEvc2z9HnDeNHyb7ifM10Z5VQrq8Qq8Tj4NEuRB83XGsztXyc4KYCfftCPcQyEVoH8HsdKHiWxaDHZlBl8wemCT39rHM6Rd2IEJQpu8M0JSHER0ITwrmU7hhMyTDnQN2ASD4/ArDmUbaFvdWSl/BCeU3a2oTnjRFJsnhUiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mdo4IP/A/wiEj4Q8e+VleHB4YIhHhCP13+qmEsMKgSc=;
 b=iofAaE86gMA/y601JoGbWvBo+OJP/gjgxM3yMPy6wZlcpSaDzuEGrwFeaJPA4IE9jzQt+vI+RXMqj3YpdxAFQdCyDABeUWgUoXrXVQDQxw9l40KyzmJLkoE8iNefYQjqO76LXpfHb/JLBfq+tLLJrySB4PsChR4ZohkefdDp0bIVmmgUSiMaBZ5YfVEPGqWurg95Kw9SEMQXO588ziDH7s4BFPTP4HD0L42SZExtmyCyLSZxEjWFK9pdqcMn+RwZHmjtQDkqjNt1yNE3ZpktXGqxmeLyGm6wtjxzZHYgY1Geej73pipV25jN8bgbSkjeGdt8rO0jop/IwFM3MnNCQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mdo4IP/A/wiEj4Q8e+VleHB4YIhHhCP13+qmEsMKgSc=;
 b=c4cdq+dR/FHLgVAzLJg4ySWnYIJTnKN9jP2ZMF82Q4lOb41dOTfsv2piLNTrZweqQEQ9jt+GKwM+UXvDYtVrzLAkkwsNRXLy2dg2AjaOs6GJalawww65y7rtx3bf++5VxaEvCzntWj87QoxigY0Ypl7hzRNUOhKuc/ezvRzAMyo=
Received: from BN8PR04CA0032.namprd04.prod.outlook.com (2603:10b6:408:70::45)
 by PH0PR12MB5450.namprd12.prod.outlook.com (2603:10b6:510:e8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Mon, 26 Jun
 2023 13:56:08 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::bf) by BN8PR04CA0032.outlook.office365.com
 (2603:10b6:408:70::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 13:56:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 13:56:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 08:56:05 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 26 Jun 2023 08:56:00 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        "V Sujith Kumar Reddy" <vsujithkumar.reddy@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Venkata Prasad Potturu" <venkataprasad.potturu@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 02/10] ASoC: amd: acp: add acp i2s master clock generation for rembrandt platform
Date:   Mon, 26 Jun 2023 19:25:06 +0530
Message-ID: <20230626135515.1252063-3-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626135515.1252063-1-Syed.SabaKareem@amd.com>
References: <20230626135515.1252063-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT054:EE_|PH0PR12MB5450:EE_
X-MS-Office365-Filtering-Correlation-Id: 138683e3-457a-435f-278d-08db764d17c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mnh7wQzzagLBE4QApXI+SE7xbrTkzSyKFK1106B+AmOF4jWhYP4w4e0stuf7dQmCNZ45qKMY21kNEnJr0+3HJzZubQde867pAx7cyLC4eTqWdkYCew6n3ZZGg/wxkepNqpu/g3crZ7Pk4pZTi/cafVIRItHj5MdWB7APM++lciQ/172P/mQ8uWsZAV4xQYsLVNE8m6jp/K0OD47pflFWzMW6phNWHU0td/PeOEES5VPRrTu+CMgMm7yNGZN0h/rD0wQOg4ymS0xidqHERBVo7Iu3pY7KARqB9ou0uvsFuj5+PzLxwRHmAC2GQIHYNIkwYOEGy5ka5ytuGPnQcAgktHWO7EnpPcJo8TQ5uSKldhpIjx/vWiWs1BTo+UmwUXYFmFZZhnW8e+7lT3YSRjMYHXnFUiCnKGpszoPSq34jzrjOGirRE5U0zH7WwIEIlBKwYpdbraczBnFOqs0tP8dd2OH/44gkT+/FOEmiAjyXuN7V4pE6lNBfyPzzhyc8aVnuGamDPaoSLwehQJUIacS3apf0RWIZGO44TcNrNRsJZj3KrGTU922S8xxgwVbQDX0w2pDY0umWNIC3P3ppDzlZxk2G1gnip1975ucQA3mS5SKuA3DE84WkvEPU6i59PT56QMZu1zou8lQHHxXkWPLxMyn0cDqFxK/Eh5Rf85uALkdsIPKvXzIdme4fhe+tRi+1L4uziLsriz6IU748aDbsgvbpYqD+rd2v65D5/FJMgPZ3rM9OnbKn15F1a74td8l/TSkBy+oSm4cyrtUm7Zu9nQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(110136005)(7696005)(478600001)(54906003)(2906002)(26005)(186003)(1076003)(82310400005)(316002)(70206006)(8676002)(41300700001)(5660300002)(70586007)(8936002)(81166007)(356005)(36756003)(4326008)(40460700003)(82740400003)(86362001)(36860700001)(47076005)(83380400001)(40480700001)(336012)(426003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 13:56:08.6141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 138683e3-457a-435f-278d-08db764d17c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5450
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add acp i2s master clock generation logic for rembrandt platform.

Signed-off-by: V Sujith Kumar Reddy <vsujithkumar.reddy@amd.com>
Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp-legacy-common.c | 19 +++++++++++++++++++
 sound/soc/amd/acp/acp-rembrandt.c     | 26 ++++++++++++++++++++++++++
 sound/soc/amd/acp/amd.h               |  3 +++
 3 files changed, 48 insertions(+)

diff --git a/sound/soc/amd/acp/acp-legacy-common.c b/sound/soc/amd/acp/acp-legacy-common.c
index 5b7000eae693..4302d8db88a4 100644
--- a/sound/soc/amd/acp/acp-legacy-common.c
+++ b/sound/soc/amd/acp/acp-legacy-common.c
@@ -13,6 +13,7 @@
  */
 
 #include "amd.h"
+#include <linux/pci.h>
 #include <linux/export.h>
 
 static int acp_power_on(struct acp_chip_info *chip)
@@ -96,4 +97,22 @@ int acp_deinit(void __iomem *base)
 }
 EXPORT_SYMBOL_NS_GPL(acp_deinit, SND_SOC_ACP_COMMON);
 
+int smn_write(struct pci_dev *dev, u32 smn_addr, u32 data)
+{
+	pci_write_config_dword(dev, 0x60, smn_addr);
+	pci_write_config_dword(dev, 0x64, data);
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(smn_write, SND_SOC_ACP_COMMON);
+
+int smn_read(struct pci_dev *dev, u32 smn_addr)
+{
+	u32 data;
+
+	pci_write_config_dword(dev, 0x60, smn_addr);
+	pci_read_config_dword(dev, 0x64, &data);
+	return data;
+}
+EXPORT_SYMBOL_NS_GPL(smn_read, SND_SOC_ACP_COMMON);
+
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/amd/acp/acp-rembrandt.c b/sound/soc/amd/acp/acp-rembrandt.c
index 59b1653b8479..82a1bf2ddfc6 100644
--- a/sound/soc/amd/acp/acp-rembrandt.c
+++ b/sound/soc/amd/acp/acp-rembrandt.c
@@ -19,11 +19,17 @@
 #include <sound/soc.h>
 #include <sound/soc-dai.h>
 #include <linux/dma-mapping.h>
+#include <linux/pci.h>
 
 #include "amd.h"
 
 #define DRV_NAME "acp_asoc_rembrandt"
 
+#define MP1_C2PMSG_69 0x3B10A14
+#define MP1_C2PMSG_85 0x3B10A54
+#define MP1_C2PMSG_93 0x3B10A74
+#define HOST_BRIDGE_ID 0x14B5
+
 static struct acp_resource rsrc = {
 	.offset = 0,
 	.no_of_ctrls = 2,
@@ -160,6 +166,25 @@ static struct snd_soc_dai_driver acp_rmb_dai[] = {
 },
 };
 
+static int acp6x_master_clock_generate(struct device *dev)
+{
+	int data = 0;
+	struct pci_dev *smn_dev;
+
+	smn_dev = pci_get_device(PCI_VENDOR_ID_AMD, HOST_BRIDGE_ID, NULL);
+	if (!smn_dev) {
+		dev_err(dev, "Failed to get host bridge device\n");
+		return -ENODEV;
+	}
+
+	smn_write(smn_dev, MP1_C2PMSG_93, 0);
+	smn_write(smn_dev, MP1_C2PMSG_85, 0xC4);
+	smn_write(smn_dev, MP1_C2PMSG_69, 0x4);
+	read_poll_timeout(smn_read, data, data, DELAY_US,
+			  ACP_TIMEOUT, false, smn_dev, MP1_C2PMSG_93);
+	return 0;
+}
+
 static void acp6x_enable_interrupts(struct acp_dev_data *adata)
 {
 	struct acp_resource *rsrc = adata->rsrc;
@@ -228,6 +253,7 @@ static int rembrandt_audio_probe(struct platform_device *pdev)
 	acp_machine_select(adata);
 
 	dev_set_drvdata(dev, adata);
+	acp6x_master_clock_generate(dev);
 	acp6x_enable_interrupts(adata);
 	acp_platform_register(dev);
 
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 83c9a3ba8584..96bd87290eee 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -187,6 +187,9 @@ int acp_platform_unregister(struct device *dev);
 
 int acp_machine_select(struct acp_dev_data *adata);
 
+int smn_read(struct pci_dev *dev, u32 smn_addr);
+int smn_write(struct pci_dev *dev, u32 smn_addr, u32 data);
+
 int acp_init(struct acp_chip_info *chip);
 int acp_deinit(void __iomem *base);
 /* Machine configuration */
-- 
2.25.1

