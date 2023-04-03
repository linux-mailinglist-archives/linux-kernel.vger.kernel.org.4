Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8C56D3DEF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjDCHPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjDCHOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:14:38 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF6286A2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:14:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0uSoX3UmqULa66homYFZQOKXcW8tmIpYoEZLHNB4p5bb3TqtZK1SnNqb7XwbgHa6vFkhQOl54UI/7YftMhfBjKpjtE9+WNDZQiYiA2Jg4xLcodgz7sowyo1VGV3waIdA7xDNkIySEZ9YwLYWuxrbNUVadt+ybEyHcMBzPXxakMpSYOepM4t3tEfsaWAIaIagtFUeH7n062geNgp90Yy4ZXrF3pG5EfWahMbcyxPpYWhS312T1wmqjGxT+NS1c8GfKvFMOEDC6Wbw/ysXImuSuG2knysDwLXlu/VtaoBUuMUfqc1Uh1QD+4ORUXWDag+Zh7Jhm+NA6mM/9QKEGC9vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AU+uHkSU6Exc4JfMFgx7HbIAQ0exW7+oUXuA3dDjqQ8=;
 b=X+NYXOdX2DNh05C4ym4GT0NNBCasJ/m11jE1qfpReOz0Hy5iWYLH13qNYCmYoMriryMVzfxt3o5xZosuCuxt+3+UU182BGECZKoYulHfwn8jCmvBJqwHyWVBjJzlzEyzJiALvGTdh3X/Px2U9nvmN0mHca8ATYJJatAoH35FjJ405YmhJThjsQyKAnwiEoNSpCOqVEsOKHZD+UHEZrCOnCa1RTOSY6Fi6odAKwt9wjY4LHZqQ3ztvd8BA+sJ0HfnI7PwVlhSHbvcWzlFwMGNyK3H6DNOwD8fUh4J31uPZbo08qNhyVU2NhaNUDEaFUPUiENUrRWV3t9evn3IXplZbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AU+uHkSU6Exc4JfMFgx7HbIAQ0exW7+oUXuA3dDjqQ8=;
 b=chs/K78JH3/AJL8PLZB4PzV1kOgl5w1pUE/jFyqI182UUYw5eB09XUsuqRXCIj8hvVmHd88ABz8Mba/RImfPx9yG/H13apN1632U0CRG/UcNs0GmiLzSR2kcm1YnmvsC3wau7c5KG07YbXzLwfEkZ1N0gKYhnCDz5KylzIDLF6A=
Received: from DM6PR03CA0011.namprd03.prod.outlook.com (2603:10b6:5:40::24) by
 SN7PR12MB6690.namprd12.prod.outlook.com (2603:10b6:806:272::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.28; Mon, 3 Apr 2023 07:14:28 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::1d) by DM6PR03CA0011.outlook.office365.com
 (2603:10b6:5:40::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Mon, 3 Apr 2023 07:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.14 via Frontend Transport; Mon, 3 Apr 2023 07:14:28 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 02:14:27 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 3 Apr
 2023 00:14:27 -0700
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 3 Apr 2023 02:14:22 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        "Bard Liao" <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "V sujith kumar Reddy" <Vsujithkumar.Reddy@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Rander Wang <rander.wang@intel.com>,
        Zheng Bin <zhengbin13@huawei.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] ASoC: SOF: amd: refactor dmic codec platform device creation
Date:   Mon, 3 Apr 2023 12:46:46 +0530
Message-ID: <20230403071651.919027-6-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230403071651.919027-1-Vijendar.Mukunda@amd.com>
References: <20230403071651.919027-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT020:EE_|SN7PR12MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: 1217d979-d76f-4363-a5a9-08db34131040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJbCP4e2f4yWcU+jQhBkGwlpV57RbPVrbfVuFqdULVYfAmesC99I3+sLtLv05N5gF/RkKrAYsOoiqXaMrbu4s5nH4/qrdep4QisWAVJr8243FTnZP6fXYnO3rYQKKxertbKW1jmJwbWLVxYLauOXP28ndd7tOPgg/l8zzkAvjQDeXlet1ywB0qlEvIXWNcapDzjOAvRsGF56CrZFbfTUrjhK0Nlar8/K2asn1nQQSBtgImX+vwcR/TKv5lpm0xNVtr/tNkLljxUb0E+0s8G63Pihk82NJU8+4F7ojjyU15LEgbsj1m91ov5YMj8uUW3wBmM/sCtUSPRrNkz4Hk7g2D0mNEvM+TcLNe8CBsp+LFIoD7O0/Kt6cm7W0QxnEjzQTaf9px3nBQqgAV0Nrk1yMKKH4K7YVURjQrRrzzOG0Mmzm3tK3Y6L8U+S0mNqVUVwGBO/Klqt2pwkrEU3fga+Brqd5bDY6H1pS1+vQn9Muw1wzHhZmBTtGxNM4nDCjCHmEr04oQ7ThuOtBJQlzzBc7D7k5I8p3x56F3cYPowMQaNJqU+8f+BlFvfgm/1r7fgvFMS7S+FcYljH+ZqJgJHvBG2+gcEGZxgtCeFoQrEiaK/ZdkkWULKPVGzONhq44g3YfH2JnCFJMismO/DHfLNAte+CevCZXQk8VRME6K0+eaUtLkzLB2PblJtTwWQjaCliFSIOF+UUeJvWWgJoLCnlkULXFqWaTHU0cf5Q3vYqQC0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(186003)(83380400001)(336012)(4326008)(6916009)(6666004)(70206006)(1076003)(26005)(7696005)(426003)(2616005)(47076005)(70586007)(478600001)(54906003)(356005)(81166007)(316002)(82740400003)(41300700001)(5660300002)(2906002)(7416002)(8676002)(8936002)(86362001)(82310400005)(36756003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 07:14:28.3971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1217d979-d76f-4363-a5a9-08db34131040
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6690
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under snd_sof_dev device scope, create platform device for dmic
codec.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp.c     | 17 +++++++++++++++--
 sound/soc/sof/amd/acp.h     |  2 ++
 sound/soc/sof/amd/pci-rmb.c | 19 +------------------
 sound/soc/sof/amd/pci-rn.c  | 19 +------------------
 4 files changed, 19 insertions(+), 38 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index dbf9ee6d79ed..2ae76bcd3590 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -481,11 +481,18 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 		return -ENOMEM;
 
 	adata->dev = sdev;
+	adata->dmic_dev = platform_device_register_data(sdev->dev, "dmic-codec",
+							PLATFORM_DEVID_NONE, NULL, 0);
+	if (IS_ERR(adata->dmic_dev)) {
+		dev_err(sdev->dev, "failed to register platform for dmic codec\n");
+		return PTR_ERR(adata->dmic_dev);
+	}
 	addr = pci_resource_start(pci, ACP_DSP_BAR);
 	sdev->bar[ACP_DSP_BAR] = devm_ioremap(sdev->dev, addr, pci_resource_len(pci, ACP_DSP_BAR));
 	if (!sdev->bar[ACP_DSP_BAR]) {
 		dev_err(sdev->dev, "ioremap error\n");
-		return -ENXIO;
+		ret = -ENXIO;
+		goto unregister_dev;
 	}
 
 	pci_set_master(pci);
@@ -494,7 +501,8 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	adata->smn_dev = pci_get_device(PCI_VENDOR_ID_AMD, chip->host_bridge_id, NULL);
 	if (!adata->smn_dev) {
 		dev_err(sdev->dev, "Failed to get host bridge device\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto unregister_dev;
 	}
 
 	sdev->ipc_irq = pci->irq;
@@ -529,6 +537,8 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	free_irq(sdev->ipc_irq, sdev);
 free_smn_dev:
 	pci_dev_put(adata->smn_dev);
+unregister_dev:
+	platform_device_unregister(adata->dmic_dev);
 	return ret;
 }
 EXPORT_SYMBOL_NS(amd_sof_acp_probe, SND_SOC_SOF_AMD_COMMON);
@@ -543,6 +553,9 @@ int amd_sof_acp_remove(struct snd_sof_dev *sdev)
 	if (sdev->ipc_irq)
 		free_irq(sdev->ipc_irq, sdev);
 
+	if (adata->dmic_dev)
+		platform_device_unregister(adata->dmic_dev);
+
 	return acp_reset(sdev);
 }
 EXPORT_SYMBOL_NS(amd_sof_acp_remove, SND_SOC_SOF_AMD_COMMON);
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index fd04e5ae7303..1c535cc6c3a9 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -170,6 +170,8 @@ struct sof_amd_acp_desc {
 /* Common device data struct for ACP devices */
 struct acp_dev_data {
 	struct snd_sof_dev  *dev;
+	/* DMIC device */
+	struct platform_device *dmic_dev;
 	unsigned int fw_bin_size;
 	unsigned int fw_data_bin_size;
 	u32 fw_bin_page_count;
diff --git a/sound/soc/sof/amd/pci-rmb.c b/sound/soc/sof/amd/pci-rmb.c
index 2b84f95072d3..eaf70ea6e556 100644
--- a/sound/soc/sof/amd/pci-rmb.c
+++ b/sound/soc/sof/amd/pci-rmb.c
@@ -26,8 +26,6 @@
 #define ACP6x_REG_START		0x1240000
 #define ACP6x_REG_END		0x125C000
 
-static struct platform_device *dmic_dev;
-
 static const struct sof_amd_acp_desc rembrandt_chip_info = {
 	.rev		= 6,
 	.host_bridge_id = HOST_BRIDGE_RMB,
@@ -65,32 +63,17 @@ static const struct sof_dev_desc rembrandt_desc = {
 
 static int acp_pci_rmb_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 {
-	struct device *dev = &pci->dev;
 	unsigned int flag;
-	int ret;
 
 	flag = snd_amd_acp_find_config(pci);
 	if (flag != FLAG_AMD_SOF && flag != FLAG_AMD_SOF_ONLY_DMIC)
 		return -ENODEV;
 
-	ret = sof_pci_probe(pci, pci_id);
-	if (ret != 0)
-		return ret;
-
-	dmic_dev = platform_device_register_data(dev, "dmic-codec", PLATFORM_DEVID_NONE, NULL, 0);
-	if (IS_ERR(dmic_dev)) {
-		dev_err(dev, "failed to create DMIC device\n");
-		sof_pci_remove(pci);
-		return PTR_ERR(dmic_dev);
-	}
-	return ret;
+	return sof_pci_probe(pci, pci_id);
 };
 
 static void acp_pci_rmb_remove(struct pci_dev *pci)
 {
-	if (dmic_dev)
-		platform_device_unregister(dmic_dev);
-
 	sof_pci_remove(pci);
 }
 
diff --git a/sound/soc/sof/amd/pci-rn.c b/sound/soc/sof/amd/pci-rn.c
index a17b15552a7d..4809cb644152 100644
--- a/sound/soc/sof/amd/pci-rn.c
+++ b/sound/soc/sof/amd/pci-rn.c
@@ -26,8 +26,6 @@
 #define ACP3x_REG_START		0x1240000
 #define ACP3x_REG_END		0x125C000
 
-static struct platform_device *dmic_dev;
-
 static const struct sof_amd_acp_desc renoir_chip_info = {
 	.rev		= 3,
 	.host_bridge_id = HOST_BRIDGE_CZN,
@@ -65,32 +63,17 @@ static const struct sof_dev_desc renoir_desc = {
 
 static int acp_pci_rn_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 {
-	struct device *dev = &pci->dev;
 	unsigned int flag;
-	int ret;
 
 	flag = snd_amd_acp_find_config(pci);
 	if (flag != FLAG_AMD_SOF && flag != FLAG_AMD_SOF_ONLY_DMIC)
 		return -ENODEV;
 
-	ret = sof_pci_probe(pci, pci_id);
-	if (ret != 0)
-		return ret;
-
-	dmic_dev = platform_device_register_data(dev, "dmic-codec", PLATFORM_DEVID_NONE, NULL, 0);
-	if (IS_ERR(dmic_dev)) {
-		dev_err(dev, "failed to create DMIC device\n");
-		sof_pci_remove(pci);
-		return PTR_ERR(dmic_dev);
-	}
-	return ret;
+	return sof_pci_probe(pci, pci_id);
 };
 
 static void acp_pci_rn_remove(struct pci_dev *pci)
 {
-	if (dmic_dev)
-		platform_device_unregister(dmic_dev);
-
 	return sof_pci_remove(pci);
 }
 
-- 
2.34.1

