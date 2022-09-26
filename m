Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A795E998A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 08:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbiIZGeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 02:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiIZGeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 02:34:00 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097B6326FD;
        Sun, 25 Sep 2022 23:33:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXVPMVbARrsR9xqfJaPSMlyV79lkPrAnxwZFP2M2M5X3K0Hxs0Ai+HcXsY1MtcH7TFiE4xM3+7ZsSaPM0EhF57f5t4owqLBfDGp06+m0MHWKQg3TNTIXojdI6UqPukfrFp6Ygi9Netl9n3kiQCNjbVERq4qPzHHmEIKCfIDfW809W55QNpoVRM03nor9gFUhM2QqmK/WucdRrIhhWuKheEmC2gSPbbaAyCfXVesku6tOjGBS+ek0843F0yOOyxE1eOR+ZVT17n9ngZMg4Ux2mN01X18IfXMt6Z1cCh2j5L1SQfhTSoBhJWQg8iL01TeoC+swms25E8vU0nMkGZcW/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAtzvWg+6CXBl8PBikL3Su6pEExcj4paQx7JXJoUAbk=;
 b=Ced0U4HbEXu7KN+dlRkzeSmQlPn2wFpsvdHF6YjJwR4vpsGeLG2BCnpcn1iWkFoAk3AxT3ld1Sw2RQISopqRNPQw+uWrAy3Do/J1oAi8oFAqPIzk+fXwP6gzk944zckpmV6qspPigXMFAh9cRPdvU2mBzLJmlpX8GYiHy6Lu2/00KNvKOE6tld58u6F5xucKu8u0SKsb4qhoRNRqFw5h+p3b/0byYGh74GOTv1WOGn8pTZDIyomocF5mGs0s8sC3Pp8O7ZvllNLAhH8/endoi5dFLuFUdxIJyJ20/x+mr5/WS25HCfDaJgoMrVl1peRISgUn0rUqcl8VJwhBa89JJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAtzvWg+6CXBl8PBikL3Su6pEExcj4paQx7JXJoUAbk=;
 b=pZT3+akPIP3ccyD+DH4VprppjUlUHaK1i5Sw0kXiNR9dt6TYG5B5+4L+43FcU+SHXNrJLC1s2X0aPLPGQQwjU0eY2Pfgzl4BYqo2WWFnTLgh6cfTmqU2fEYjVpveSJ17jlCLgC7x40xjLZRISAkvWM+5xf1jyB5/SjeEJyMHpNM=
Received: from SN4PR0501CA0106.namprd05.prod.outlook.com
 (2603:10b6:803:42::23) by SA1PR02MB8351.namprd02.prod.outlook.com
 (2603:10b6:806:1e6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 06:33:57 +0000
Received: from SN1NAM02FT0057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::a5) by SN4PR0501CA0106.outlook.office365.com
 (2603:10b6:803:42::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.8 via Frontend
 Transport; Mon, 26 Sep 2022 06:33:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0057.mail.protection.outlook.com (10.97.4.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 06:33:56 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 25 Sep 2022 23:33:47 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.9 via Frontend Transport; Sun, 25 Sep 2022 23:33:47 -0700
Envelope-to: broonie@kernel.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 akumarma@amd.com,
 git@amd.com,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 amit.kumar-mahapatra@amd.com,
 michal.simek@amd.com
Received: from [10.140.6.18] (port=46254 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1ochgY-000GAg-Kz; Sun, 25 Sep 2022 23:33:47 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <akumarma@amd.com>, <git@amd.com>, <michal.simek@xilinx.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <amit.kumar-mahapatra@amd.com>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Michal Simek <michal.simek@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [RESEND PATCH v3 4/7] firmware: xilinx: Add qspi firmware interface
Date:   Mon, 26 Sep 2022 12:03:24 +0530
Message-ID: <20220926063327.20753-5-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220926063327.20753-1-amit.kumar-mahapatra@xilinx.com>
References: <20220926063327.20753-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1NAM02FT0057:EE_|SA1PR02MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9da39a-7101-4cee-6d2a-08da9f8916df
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oyfPVR1gl+VXWwLB//zJpyJju+QU/PtV5lZQB06u0OHFkWUdkvqV49Fdh0CbyjTXujfKHUtwM+biEhUbJ1dc/GGZt7+ZI/KOw6J7MAQKk/DVYJnJHrC3WGMjauvQliYEUXBj5Fpt33kMxDJaDcK3e3iR0766qxtpX5yuienwU/3VzWNZWkTVMWh84p6ywZXBvkqTRX5yJMBqZ9BeZ8eW5CCJxYJW3BH4hGfffSeA0GPNRRgnUIbmkJMxD1h3rdNYBxZ2RmWIO5dGNfkSw8taA9Vw76mkqdOnv1avsZDThFc2A/qFNvTa6yAzS10oUk3PqPp8Qn8fHzBrF2QWtZfC0GZU49qsxIoeR5SK/I8vqbULFP9ee5WJyJAV0d7k5qDwQwNiRdJlgHcDXjw+cjZTuc72jQy6HZGWLirVvhw+lxv9YwaQWB7qWsx9/CDn56o8t7Ps7XegJ/Z6qF4+LgMgfFTA8BQie2i6TxxT+aa92zEpenASqB5RQ/DypMwrCPOR6mzgswg6CBPxoVKXKW1WOLE1kR8ASFylVCKmmlPfDHFSVtowryvpnBsSMt+h64yF1YTNW69IFX45oexw/csAWh7iZQIn/akAGH0syMlXMqYKwrSTL4zTpgqKATFsU1XZyiBQ4jFMbBnSP0FJOsOWLSUU+9av9OPTor5yeFdX1v7i8Gw5opqjg+lW4/fULsmv66Xyq7iLusBbXbWBnBrO73pJprmQFu85Qdb3fwIybHQkZV6Hs2aY4WsZXhm4pBOgDoWifzfOv82toM2gV9SU7pUTjT1jeJcIp4KaGR3pNio=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(7416002)(5660300002)(41300700001)(2906002)(36756003)(8936002)(9786002)(356005)(7636003)(36860700001)(70586007)(110136005)(4326008)(70206006)(40480700001)(8676002)(54906003)(478600001)(316002)(47076005)(186003)(336012)(107886003)(1076003)(82740400003)(2616005)(426003)(6666004)(7696005)(83380400001)(26005)(40460700003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 06:33:56.8329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9da39a-7101-4cee-6d2a-08da9f8916df
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8351
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
index d1f652802181..5d709faf9fe2 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -843,6 +843,13 @@ int zynqmp_pm_read_pggs(u32 index, u32 *value)
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
index 9f50dacbf7d6..0a84b04af26e 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -135,6 +135,7 @@ enum pm_ret_status {
 };
 
 enum pm_ioctl_id {
+	IOCTL_SET_TAPDELAY_BYPASS = 4,
 	IOCTL_SD_DLL_RESET = 6,
 	IOCTL_SET_SD_TAPDELAY = 7,
 	IOCTL_SET_PLL_FRAC_MODE = 8,
@@ -386,6 +387,18 @@ enum zynqmp_pm_shutdown_subtype {
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
@@ -457,6 +470,7 @@ int zynqmp_pm_write_ggs(u32 index, u32 value);
 int zynqmp_pm_read_ggs(u32 index, u32 *value);
 int zynqmp_pm_write_pggs(u32 index, u32 value);
 int zynqmp_pm_read_pggs(u32 index, u32 *value);
+int zynqmp_pm_set_tapdelay_bypass(u32 index, u32 value);
 int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype);
 int zynqmp_pm_set_boot_health_status(u32 value);
 int zynqmp_pm_pinctrl_request(const u32 pin);
@@ -666,6 +680,11 @@ static inline int zynqmp_pm_read_pggs(u32 index, u32 *value)
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
2.17.1

