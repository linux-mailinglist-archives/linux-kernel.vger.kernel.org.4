Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F94673A4C5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjFVPZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjFVPZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:25:50 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6AA1FE1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnCx1+qxzWdTNwH9xRf2TFCuHOIB4fsRI0LL3xpphFwkLE65JNTAnUVXv+vwjtB178+z7cm4B8D7IrCtvWrnPb6y/p1Lrhu3auGXnwJT7D706XoaWiHqWacbTbiECDCfYnXrnWXmOHDWr3DOTvtiXarDZGBbVDcIIaEDkeJ52FBJkC9RedQjr419YK9y/3scDEl0cXQsMs9UemyTsQX6b277EgJOxnujc7ID6My4La45uCrBi6WGJyXBCjP4Ab3HqQuchLfhhuEF3p7SrBmAQWK3mRQ11EMrGJaix7nrSJB3eQW4ozITciDonPxFZyfmctYztwAIF+i4g8uDkOITqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTi+jNwx22Rw4e2bVwgKMy2ba0IycMTYdowrOqOEbg4=;
 b=EfAAaZT0krtMH4xA+2ujBAv+GOKH4gqE+gCB033KvhHDBqDJOIcRxq8zqLzhrzgpdWtOPSsxZ4kiqPSXgx79NvlEqYC1Mv1N0APvHns5eS7bGG2pkUKGqi9L8cOQcVL1EzXK5lssrdjBHdYuSNBlsT/5LtTvgfhSipkZvHI7bFCkBl06yFueBJoZuMLeYteq8f/CiVXrX/waClK0mb+PZRzDgHC/qB2WL1yDIhad4WtT61cTN8w/C5rvD5KHC2Y/+kIz8eY5ZnGiYN3ZqmWyMgk/yQe7ciBzJPx+HGgvZmXsxuusEC2hddPo3CgvQamG2JbdM/EvjcRoI7eM/ib4tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTi+jNwx22Rw4e2bVwgKMy2ba0IycMTYdowrOqOEbg4=;
 b=I/TBx9aR0jWW8pn/y5F9BUJDJ8v4gGC5z7AiifgqDpFt6BwVPxVNv5VWveZINd4nYZi8OJSgTlQjZLq9TYrEons0UeKolxtts84HV5qR7TKgeh6by5wXbl/1W2K+hzpwpSW2C0pup7chCV6gCVeNboOcCor7L2NkBNT3AR5sYv4=
Received: from SN6PR16CA0056.namprd16.prod.outlook.com (2603:10b6:805:ca::33)
 by DM4PR12MB6255.namprd12.prod.outlook.com (2603:10b6:8:a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 15:25:33 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:805:ca:cafe::9e) by SN6PR16CA0056.outlook.office365.com
 (2603:10b6:805:ca::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 15:25:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 15:25:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:25:32 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 22 Jun 2023 10:25:28 -0500
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
Subject: [PATCH 04/12] ASoC: amd: acp: add acp i2s master clock generation for rembrandt platform
Date:   Thu, 22 Jun 2023 20:53:44 +0530
Message-ID: <20230622152406.3709231-7-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
References: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|DM4PR12MB6255:EE_
X-MS-Office365-Filtering-Correlation-Id: 752ddcd1-74f4-41d5-e4ec-08db7334ebb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bsq9V5dVZNSQLWKvihDR2xCZYOwq0yAZaV/09O4yvHbIGpCmknbZcJFtzM+r/0Hi54IwDtAAkWxLxmIyPYrddFzZBTdRUy1byEM6Jj8gqhKWSI5NsgKBIwYPVOcZTBKGGGu68h+fDlDDaln6/lmIv4UclEgk50X7mQtvBMbLWxHwjqcUtoeNkIGBWX0jY5xEC1ZhVaCtKgyI+TwapblbAtTdVIIpIe8lHRPJZBXoDploBV/y779hjevBr2aG0vy2jfJcTZ1GVyJft36+n6sEaxZz38eqJFIf1XvObDoWcxgPNp8IJ7rS+d7cSD8HeU0aXCaKpJ4hn75uvFyp5OXcZSV8UEq/X630jvl3/LOgurs50nS64q1Fp/B9S/DNn8KKTt3akR2IDuoOf1KvbTFC+00fne63F2GBWTQxPbpTkGpyt4J7oDIflzHGCtqrm/6HLPeMYVVlnn2sVMR/5GbwmcAZaiV/f9OhoQQiHY3l7S2TFLptvDmbDkefKxe3JsUEyC4w5hU7Qo9PXRZUxve/G/KzgOPLdkL1nfagqZVDyE9BGBqrv/djF6mzQ659a6YRXAlpw93Mz+tuNVGhN8tW9sXcrX6KI2M1ZJls08kZI6jYg2LyQDzivJ5OFmt/5dJ/rmcGRvnMKtku4nSq3VaMfMkFLHyjf2a0XnEd/QJfWmWyFNrTsXdn2SJPlrDKUA9XiIkqjubz2F3uZaeqAVtuRExIUvtN4iDizTA9FW9yL+tYs4cXB4HA8IKt9/Ct9VXljko+bFuBSlfip/AkzASEjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(54906003)(2616005)(86362001)(110136005)(40480700001)(478600001)(7696005)(186003)(6666004)(41300700001)(70206006)(70586007)(316002)(47076005)(83380400001)(26005)(82310400005)(4326008)(426003)(336012)(1076003)(8936002)(5660300002)(36756003)(8676002)(36860700001)(40460700003)(2906002)(82740400003)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:25:33.2688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 752ddcd1-74f4-41d5-e4ec-08db7334ebb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6255
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

