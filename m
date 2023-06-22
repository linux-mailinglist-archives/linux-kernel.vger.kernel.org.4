Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB2773A4C3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjFVPZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjFVPZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:25:18 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2CAE75
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:25:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNbE9rsQUI0CgMVdAxy/jyFUNX1uZyd/slh/fsOk3VzW2Up5bgFgAWZLAW9u1+8PLrQk4+NKWnuXrLUGtdUjGWO08Rt/gcercES1qgQWvZkgjRij4kFXuVeyrdZpnzQdj8ZTVm4YQxF2CqB8mB9jIxZgJFMIAlSAagUernxZx0Mi/ppOGBVKTcBUKwSkfKGoRpXiXKpXxFplKindleTpOXdIoQj3bWhY8WoKdljb7clCaPpYhvmtxjbx6fX6lSFY0DHPkoq8jYzEu0PYalIMXnYOWPr0FFUAum8r+Ah3g8L9mIfDAUbDwN82LRyl3Vj4gxGJUv3QyVbvyyOiS8c2FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTi+jNwx22Rw4e2bVwgKMy2ba0IycMTYdowrOqOEbg4=;
 b=gOjexJ0zOIrg/vCSZG8SaQx3/+fQww8iI1oOE8rQAIQbH7vCaC8P/dbdu+WOtV0KXLcOSJzjUVgpbznIVdZrqfiPRIgFAy7MDIXxiefSiScBoSqbma+plqTyHkEi6+bGhIvlXTiAW6/e4mgRIxZK80WVPG22dRizRMR7HoaHZO2vgDJ2WBc8/l13HkaVcwDZH3Irixwfprh53HaD6tt2wUV78I0gtAkp29FL5JC/An8nAfhbF/OFwDZQ0m/WJm/axUorfn2XlJ9iVYBACtP+QJ9m+zT93z+ddhQdK8WEbKGaM992I97sOJoIgxGo1AkW2TFfq8XrjMjYiTsW0qG1Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTi+jNwx22Rw4e2bVwgKMy2ba0IycMTYdowrOqOEbg4=;
 b=Y3PmUcNYBrJltL1hLvUK9G8MLNm4i4od45GDgUyE9wxnQ8VGYFJ+96KE/3kmU0ZLO2ATY6FQexO4yZs7yZC+OM9lsrtAYM9LakWGiZv5yW06h8D9wLQ/a6Nm6BjACjzDbz87jS3pU5i1t+bGCCT8TFFsKhkNzKUyJAJWrvfmAfE=
Received: from BY3PR05CA0001.namprd05.prod.outlook.com (2603:10b6:a03:254::6)
 by BL0PR12MB5011.namprd12.prod.outlook.com (2603:10b6:208:1c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 15:25:08 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::91) by BY3PR05CA0001.outlook.office365.com
 (2603:10b6:a03:254::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.9 via Frontend
 Transport; Thu, 22 Jun 2023 15:25:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 15:25:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:25:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:25:03 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 22 Jun 2023 10:24:59 -0500
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
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/11] ASoC: amd: acp: add acp i2s master clock generation for rembrandt platform
Date:   Thu, 22 Jun 2023 20:53:42 +0530
Message-ID: <20230622152406.3709231-5-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
References: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|BL0PR12MB5011:EE_
X-MS-Office365-Filtering-Correlation-Id: 226b9a0d-ed15-4c3c-c098-08db7334dc76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5DY7rXqJYUbeFPYAa41dMMoH+3rnF5QK2dRVWBNZlYEsInq4V7isffjZinqVmoLc1ReVDLUHCMEo/PY1p9MT2ITFRz7aJYGxWG35Ol6z/p49V4iCymx04y8pKzuEkCpmMJRV+PsJ2FjQSVQLRUeBm+UkvYbm8lo1fBkDmCDJtoJ1DDvV9DV0lc68jqOog8Nm5YhYUlzy1KSMhVY4dK6Z8TGk/3iducFjBKg7CzpiQu/H0paUlVEPoeIZJboTjIjW87Xzt3F/wZGLLmm43K1GLAhL6vfWurY17LKy/FncyH/aX+DUCEo4Rcuk2FO4bFgOAY29y/lDqmnQ9jAYBQLd8vLNNuaV5gD5W3Lgo4QTf3t7oMv/nAt3/dGD+2OrBB7akXNw7n+j0YThQx4QsLIz6N88JCKWoNBPRJa29cX3qLODaR20hGODeJUQgiBQR6OdNhqWJM1mKqMspJSZr+38+tsMuEJDGlPesComyKkyvHSZTvA3uWDC61RK+6kGYf02+joML0/d3Idx9foAOyIRM6xDZQqckM8m556VhSWCnB0J5zWjuNwsFV52IPoAAVPq5iiTMTGafPg/S80YWfDiOlGqu/JHIMDSRtqJMvux8S4G0lChKE+z7wfhYFGKWGVHbTJhGkhpUnQGOO9ghH9gO4SDqwlTuK/sJULJY8Y2R2CTh4UyubPvQbT2yE/xyvKPvQKB0qXyKa0J1Cws0kL4bqNjCxADx1VKjwK5CDRIUPgplwKFfteF75pkTg/OYxUNPawFWHarTUdCSpXs7RD1IQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(47076005)(5660300002)(2906002)(1076003)(40480700001)(8936002)(8676002)(186003)(41300700001)(26005)(40460700003)(2616005)(336012)(7696005)(478600001)(82310400005)(356005)(82740400003)(81166007)(36860700001)(83380400001)(426003)(70586007)(70206006)(4326008)(86362001)(54906003)(110136005)(36756003)(6666004)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:25:07.5758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 226b9a0d-ed15-4c3c-c098-08db7334dc76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5011
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
index 59b1653b8479..83515ee753f3 100644
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
 
+int acp6x_master_clock_generate(struct device *dev)
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

