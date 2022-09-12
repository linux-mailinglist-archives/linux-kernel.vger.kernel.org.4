Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A1D5B5907
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 13:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiILLKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 07:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiILLKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 07:10:50 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9471D32B;
        Mon, 12 Sep 2022 04:10:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1KyPa/Qei+bzdXrLI6ubN2SEG7BodcWSvjvrkVHMI9SCtgEZH/jdXyqUgy5U4buG9YdvtLOXpizqFhVeosNaoagNfUZMJyye7T5tfS/eq+z+vsour0jZ9EgbRbEx4NwMmL1hQ7xLnjgYbFsnKSs/LSEPV9DLz3++zqw85x4cM+dkXFSOJ7YPLwuxIaDguDSIEWHAYW/OAvbnobAQiKllQvgle+Egi8oem2cWA5Pysv7lvpP//hZZsrrZttdf99417XQT4CpASLQ3pdBtPCY6Hh9ywQrAhIvxS6gEzLXHMYdOOdLQSyLU06irdNketZL2qLZT0KS0d+l5KjtokO84g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZbFC85bkj/RvBJfbQcnBHb5epGscIBT9JhGF1tgFx0=;
 b=YRT2bRoGXMKAOs83Zjmf/Tts90BElC9zliqPDnKTRgrTxdU+t6+Yc8UnSl4hw7QeSdYn5bzRHqFuW1lA2uPMh6nYWrVHC8HrbGR6pEsIwPGuChe/a9HbsjZH+xUBxd9BOwKVAsoYGKVn5ecvK5WxVgTXDTFy3C0t2OQSmd8jrOtl9NhRnCkiySx+MuwUInpt7VexniKkTx9tZDtbcVOe2LIurWlNViWMt/HPbvRwgT4SQ/fOf8lXUEuB53yYz6JQZrRT/857XUF4XnM5JFin3odci+cKjEf7x9bm4X978AD/Y7Um4A35ZJy310gWob0IQ3XfsAYkq9yZYURZl8Mcxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZbFC85bkj/RvBJfbQcnBHb5epGscIBT9JhGF1tgFx0=;
 b=LvNENYwpy5SaslTYv/B/3Xn0Laq5aSYFOs+smre8u4vgtKPEFK4nbZJjE3sfyEoJx2gEm8Au690qvYYBxpou3dj35x0iL+WC2XJ9Rs5E+HBMU16nIZBEpqJNBpu+KnWv8sYIfoGNvkt9dQA/xjLBmc1DFycdsEs/gPo/jCA0KvQ=
Received: from MN2PR10CA0008.namprd10.prod.outlook.com (2603:10b6:208:120::21)
 by MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Mon, 12 Sep
 2022 11:10:46 +0000
Received: from BL02EPF0000C409.namprd05.prod.outlook.com
 (2603:10b6:208:120:cafe::2e) by MN2PR10CA0008.outlook.office365.com
 (2603:10b6:208:120::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Mon, 12 Sep 2022 11:10:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0000C409.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.10 via Frontend Transport; Mon, 12 Sep 2022 11:10:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 12 Sep
 2022 06:10:45 -0500
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 12 Sep 2022 06:10:42 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <michal.simek@amd.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <siva.durga.prasad.paladugu@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH 2/2] usb: dwc3: xilinx: fix usb3 non-wakeup source resume failure
Date:   Mon, 12 Sep 2022 16:40:17 +0530
Message-ID: <20220912111017.901321-3-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912111017.901321-1-piyush.mehta@amd.com>
References: <20220912111017.901321-1-piyush.mehta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C409:EE_|MN2PR12MB4342:EE_
X-MS-Office365-Filtering-Correlation-Id: 763ead70-f387-4c0b-8f19-08da94af7128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RrdwtLVGp/u1kjBC9mE4ppafPYXu8JSotsUm7JQvL5FcYi055SMJHRa6dYbwu0L60FyHtpkeOjv0uBgABzJnRgMqAd3Rr7s/GtgW5g75iSQ24aerFzPOq5crduLarI2FnTnKn5pcPxAJn+lCmeOQD5Rnd1iS1hldsJDuzcodaO+lD8yOk7pwDppOHfeLDJJr3W+v74EmEtlJDtHgtS0QhRfffC5gUs8Sz5Y8/m89QRD1MxzzhuaK6FKUHqhYvXhDke7ve/JYWy6WinAIwzQfvgeUlU5dSYSp8hZfklHkflEckbKRKgbD6isuKmR4rJXHy+oqW6uc5B0gcAmHVMo0pPXB2rCzhL3V3oWzFNU2Jvj6pjaneoKzwALmp/NE7ZMVUoU30m+BYze7Bx2cfAeRnIGyB+bwn4lF24wvyEtc7leWq/cWWv0GX5vyBlT/Xp5kCISI8Gdw0s4VTm3O91Vi6DfMhnciaL8gKQ/p+1R3OLiZqsX/KboGpGkn6UA7beIKaksaBgcT4OhAgrVraJUNU2u55fTTNnBPvHB6bewUCyKiPRc8RJm8xT1qm2WbADOu2uLOKKGOLMUH5u8dn6EXW+okaI8a+zoyXe+3BXGgH8qmgvafkgn0mgVdnzqkq5XjMbICL1YOnigPmthJiJO6Jez9iUJsZKMZ27a1aCeWjH3EIZjmmgOqdbreqgIWPpu/IPuxqz+MMnoOb9Jg3Zk7TuXEaShtofwQ74AUimJvjrixrPOphLRkTADMSScMcyhW9yApHi62FZZ4odCKaaEltMSnQ7eOHmb71+KuFd2CFqdMfyF3n4Vt8O37dM/vJiYxWDsnq1RDOTuM8MF8eSYsoQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(136003)(39860400002)(46966006)(40470700004)(36840700001)(36860700001)(40480700001)(40460700003)(356005)(86362001)(6666004)(82740400003)(82310400005)(70206006)(4326008)(8676002)(70586007)(5660300002)(8936002)(41300700001)(81166007)(110136005)(54906003)(478600001)(316002)(83380400001)(336012)(47076005)(426003)(1076003)(26005)(2906002)(44832011)(2616005)(186003)(36756003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 11:10:46.4392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 763ead70-f387-4c0b-8f19-08da94af7128
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4342
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When USB is in super-speed mode and disabled as a wakeup source,
observed that on the resume path, lanes have not been configured
properly in the phy-zynqmp driver.
As a result, after the resume, USB device detection failed on host.

To resolved the above issue, added phy_init on resume and phy_exit
on suspend path, to configure the GT lanes correctly.
The re-initialization of phy, reset the device and re-enumerate
the USB subsystem.

This use-case is specific to Xilinx ZynqMP SoC.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
 drivers/usb/dwc3/dwc3-xilinx.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index a0d0280a045e..8607d4c23283 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -47,6 +47,7 @@ struct dwc3_xlnx {
 	struct device			*dev;
 	void __iomem			*regs;
 	int				(*pltfm_init)(struct dwc3_xlnx *data);
+	struct phy			*usb3_phy;
 };
 
 static void dwc3_xlnx_mask_phy_rst(struct dwc3_xlnx *priv_data, bool mask)
@@ -100,13 +101,12 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	struct device		*dev = priv_data->dev;
 	struct reset_control	*crst, *hibrst, *apbrst;
 	struct gpio_desc	*reset_gpio;
-	struct phy		*usb3_phy;
 	int			ret = 0;
 	u32			reg;
 
-	usb3_phy = devm_phy_optional_get(dev, "usb3-phy");
-	if (IS_ERR(usb3_phy)) {
-		ret = PTR_ERR(usb3_phy);
+	priv_data->usb3_phy = devm_phy_optional_get(dev, "usb3-phy");
+	if (IS_ERR(priv_data->usb3_phy)) {
+		ret = PTR_ERR(priv_data->usb3_phy);
 		dev_err_probe(dev, ret,
 			      "failed to get USB3 PHY\n");
 		goto err;
@@ -121,7 +121,7 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	 * in use but the usb3-phy entry is missing from the device tree.
 	 * Therefore, skip these operations in this case.
 	 */
-	if (!usb3_phy)
+	if (!priv_data->usb3_phy)
 		goto skip_usb3_phy;
 
 	crst = devm_reset_control_get_exclusive(dev, "usb_crst");
@@ -166,9 +166,9 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 		goto err;
 	}
 
-	ret = phy_init(usb3_phy);
+	ret = phy_init(priv_data->usb3_phy);
 	if (ret < 0) {
-		phy_exit(usb3_phy);
+		phy_exit(priv_data->usb3_phy);
 		goto err;
 	}
 
@@ -196,9 +196,9 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 		goto err;
 	}
 
-	ret = phy_power_on(usb3_phy);
+	ret = phy_power_on(priv_data->usb3_phy);
 	if (ret < 0) {
-		phy_exit(usb3_phy);
+		phy_exit(priv_data->usb3_phy);
 		goto err;
 	}
 
@@ -350,6 +350,8 @@ static int __maybe_unused dwc3_xlnx_suspend(struct device *dev)
 {
 	struct dwc3_xlnx *priv_data = dev_get_drvdata(dev);
 
+	phy_exit(priv_data->usb3_phy);
+
 	/* Disable the clocks */
 	clk_bulk_disable(priv_data->num_clocks, priv_data->clks);
 
@@ -365,6 +367,16 @@ static int __maybe_unused dwc3_xlnx_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	ret = phy_init(priv_data->usb3_phy);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_power_on(priv_data->usb3_phy);
+	if (ret < 0) {
+		phy_exit(priv_data->usb3_phy);
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.25.1

