Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9355B9A69
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiIOMIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiIOMIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:08:32 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E4F7D7B8;
        Thu, 15 Sep 2022 05:08:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjUEvC7tiGJ1YlFeXriayNVwGJ/BhFm0V0iP/GiBBIfm4uFEd2t/OEQW+quCa1yn/lKK21ErAmY8+JGBcWs53Z3U4Aty4f2KtnvTXVvgB0D71GFU/bFJKWlbarFRZ/G/3GhBOIqG9GCmjRfg9nk04lo3P7jGwJKMnq3R9m5p3+CsUWr2eZ+P8+1vKTodMQ6l+3xH1EIhPY3bmRYTkO6tjXEzX4IEzCyzhX2hktkAx+JML+fnhGg+iNKI3PzOY5FBjVaA4RiRXZq1txpy4nL7wJVHaXrXuNU2m9iN+g3R5nLLS/KAREQ6Ne5IrOuxZMInFY39IzceDf+CEQiXhFcySA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwNAbj05ECbWou82JkSRfkXCkZqQBgDF65tx8+StLfg=;
 b=YCR9usKYXf/LDXCzkyjm93Yo1bgeovAkjP/T7pLFfADojwD/tufmhLAVSKXGTlAVDbagMO5kUkWaq9LkowV+2PzEikFlLAXlOAWCzaDxoEsfxiNetz6d4yyR1Qtq74zKq6F4+0sC5P9g4q/gJCaqji7UropHv7C4lyETu63K4/5CCcjyNbhJ+9n4rd/LsRzcR6eHxaY1uRsfIfQZ72CgaNDxtln8eN4g02dRfI9F5nItMnqcrCkjH7gw+AaTZeEUK8k9vkdEIAGq30RDK5+ju5lbSIgef9ro/9D7nSWko+M31BahjWpHr0/rA2fSgr86XZSK5BPsSPZzU/rtIdxqQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwNAbj05ECbWou82JkSRfkXCkZqQBgDF65tx8+StLfg=;
 b=DRgFfc4wVjzD6otQA88fH1w5poEX1ORlKN4RK0u/DbDxCjXJ2IGH9OEh1fov69IMi7Ll0v4gs4WqV/TKKVru4MhRRAcIUQ1qHc5jWb7dZuyTE1atajyOVE68fEOhn5dOKTBY6rvEmLPz4lUdYfuWzDGGT9Tmi5igEsQrfET8w+A=
Received: from DM6PR01CA0025.prod.exchangelabs.com (2603:10b6:5:296::30) by
 SJ0PR02MB7261.namprd02.prod.outlook.com (2603:10b6:a03:2a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 12:08:21 +0000
Received: from DM3NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::3d) by DM6PR01CA0025.outlook.office365.com
 (2603:10b6:5:296::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 12:08:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT032.mail.protection.outlook.com (10.13.5.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Thu, 15 Sep 2022 12:08:21 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Thu, 15 Sep 2022 05:08:09 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Thu, 15 Sep 2022 05:08:09 -0700
Envelope-to: broonie@kernel.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 git@amd.com,
 michal.simek@amd.com,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 akumarma@amd.com
Received: from [10.140.6.39] (port=33420 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1oYnf6-000Fci-Px; Thu, 15 Sep 2022 05:08:09 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <akumarma@amd.com>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH v2 4/7] firmware: xilinx: Add qspi firmware interface
Date:   Thu, 15 Sep 2022 17:37:47 +0530
Message-ID: <20220915120750.1424984-5-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915120750.1424984-1-amit.kumar-mahapatra@xilinx.com>
References: <20220915120750.1424984-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3NAM02FT032:EE_|SJ0PR02MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: fa5c7bad-23e8-400d-05f2-08da9712fbd7
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nKJNmyhVOby4oMpOk2LgS+9rN196xbEl/F6tsCWGE5BMcPTRIdG/9NxVOb0byZDYfqAmfn/TdLpV1WSA4pVOsN3kwgy6LoRJwjfANn5Nm8OtnjejkuFcAeMH2aVtLBuONgm3judbFlOmBeC3y0A0ON8nfIJftTKIGm0kgctWsVr8/vc92DWvgy0XaoXxqg0lAHZTW/T37sy3CknhQkJb0XxE2h/hFPHYtsJLgZRweOgG4GBmfyMnhhv1kziT2Gh+qw9lKa3rlPqsfzBEJj10O6R6iGZHzAPW+320nTVpXTyjt8EbSWKXWmYBhr95yHUIdwwdcjfjYqBQTzklMxy5xZVCzYtnjYLM8UHKjU5wmGVf18dAXMMmQnAoQ6qeExOngWrRCcc665vsuLt7IMBsvaQpQ9CRjxhqLaXEmN0DLoHDLhVt8tGIDCvfmm+XwicZWVoi49HmQ+d3dS7K7+yt0ESZxHl+XV+JlNXs6KXeTe/Ji1AVn6lU96yixintHQ/8WuQxN8HXUyqa/KKa4+yBk/gAWmQuF4JXSwlb5zRe3Y1oHtwKO/4/OGA2qVVJxKk+lZbmPt5qBZp4EwjkCAaOpzTwvVN44ninGDvzQtQLWgqyBJjx69MWYJRkqaDarCypHElHX7SKgokKgK8zopQ1NEorJjhSRRaDZ4s9pwCCSC6AZNtoUM9INdyjU3/tVpNTx6Co3OoZkkV8uRJPIKOh83lMDV7YVHDjEPEjdzmwbW8W1CtA6opoqc0FmCEbL5YkfAb9hbE9C14gOPygpDBSVh9grv+BVDFVkVPfnNz39Pg=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199015)(46966006)(40470700004)(36840700001)(47076005)(83380400001)(36860700001)(336012)(426003)(356005)(1076003)(7636003)(82310400005)(41300700001)(40460700003)(478600001)(8936002)(9786002)(36756003)(2906002)(2616005)(186003)(82740400003)(110136005)(54906003)(5660300002)(7416002)(40480700001)(8676002)(70206006)(7696005)(70586007)(4326008)(6666004)(26005)(107886003)(316002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 12:08:21.5787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5c7bad-23e8-400d-05f2-08da9712fbd7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7261
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add support for QSPI ioctl functions and enums.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     |  7 +++++++
 include/linux/firmware/xlnx-zynqmp.h | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 7977a494a651..b119f170437a 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -829,6 +829,13 @@ int zynqmp_pm_read_pggs(u32 index, u32 *value)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_read_pggs);
 
+int zynqmp_pm_set_tapdelay_bypass(u32 index, u32 value)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_SET_TAPDELAY_BYPASS,
+				   index, value, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_set_tapdelay_bypass);
+
 /**
  * zynqmp_pm_set_boot_health_status() - PM API for setting healthy boot status
  * @value:	Status value to be written
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 1ec73d5352c3..b38d12b6040f 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -134,6 +134,7 @@ enum pm_ret_status {
 };
 
 enum pm_ioctl_id {
+	IOCTL_SET_TAPDELAY_BYPASS = 4,
 	IOCTL_SD_DLL_RESET = 6,
 	IOCTL_SET_SD_TAPDELAY = 7,
 	IOCTL_SET_PLL_FRAC_MODE = 8,
@@ -380,6 +381,18 @@ enum zynqmp_pm_shutdown_subtype {
 	ZYNQMP_PM_SHUTDOWN_SUBTYPE_SYSTEM = 2,
 };
 
+enum tap_delay_signal_type {
+	PM_TAPDELAY_NAND_DQS_IN = 0,
+	PM_TAPDELAY_NAND_DQS_OUT = 1,
+	PM_TAPDELAY_QSPI = 2,
+	PM_TAPDELAY_MAX = 3,
+};
+
+enum tap_delay_bypass_ctrl {
+	PM_TAPDELAY_BYPASS_DISABLE = 0,
+	PM_TAPDELAY_BYPASS_ENABLE = 1,
+};
+
 enum ospi_mux_select_type {
 	PM_OSPI_MUX_SEL_DMA = 0,
 	PM_OSPI_MUX_SEL_LINEAR = 1,
@@ -451,6 +464,7 @@ int zynqmp_pm_write_ggs(u32 index, u32 value);
 int zynqmp_pm_read_ggs(u32 index, u32 *value);
 int zynqmp_pm_write_pggs(u32 index, u32 value);
 int zynqmp_pm_read_pggs(u32 index, u32 *value);
+int zynqmp_pm_set_tapdelay_bypass(u32 index, u32 value);
 int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype);
 int zynqmp_pm_set_boot_health_status(u32 value);
 int zynqmp_pm_pinctrl_request(const u32 pin);
@@ -659,6 +673,11 @@ static inline int zynqmp_pm_read_pggs(u32 index, u32 *value)
 	return -ENODEV;
 }
 
+static inline int zynqmp_pm_set_tapdelay_bypass(u32 index, u32 value)
+{
+	return -ENODEV;
+}
+
 static inline int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype)
 {
 	return -ENODEV;
-- 
2.25.1

