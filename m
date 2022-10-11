Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28DF5FAC9B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiJKGVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJKGVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:21:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C8A876B3;
        Mon, 10 Oct 2022 23:21:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPWqnwUtYiL7HXS7UU7VE6oqF3i2wfA6rncxSpGH6mTLAy0n1rAlDJ+00tP+p+EyIv1RfeLLLryJCaEBxM48HLR3GaMWnSYZmFHCG5yhA2v/0MXrfcsbUEkXSUrswytAW6Bvy9az7UTLhWaxEE4nnriAi6w2Cf9Qfci1GAsnTLCOYkqi9ZkTP6MyRM4qFOMHOBjHnSwg8cUhmxHbiDSiXMMLwLG4Ue3IW+eBYI6pO4TKfQ5QFRCJjHsItWHq+UES07cQwjVy4QQXPtUbpBPjwhxVsv+CFGm1Gp5GVlE74Uotob0ItctrL9cIpTl7X9ITtt7SsQ0pgG/2l48MLpU0OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMc8HZagvV5BKBmHkLKqcigmRmskfGEWRymqfceml5I=;
 b=ELCxZ/Rk/jripih8TWCAEmPAeeyNSHpMxswGL8CaQMy5ZjiXTtbQ4eJE91B4CvKt/bydNer8unt0syfB2OFjhiB7LICh28avIEimJ8zYHnYc1o1N/DwwCWFIYAgTIKsXRMYGv6UzjvDdK/UITlcj83yC5fJ3FxifsVC85/pBvPWljXmlv2CKM30gCplPsPBCrp2G/dM7LLbq9d/Rt6bWlcHguYVh3FS50IfBLyFToh8jkIYkRf6r8qicxFCAC1b9x/fbk0nBmYwoH7klRk4qw90ODtFY/S5PHOlakJvT1ZMB190U8WXn0SEP50hSNwHU4Ex7lh9TnUpq2WRMlpeeOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMc8HZagvV5BKBmHkLKqcigmRmskfGEWRymqfceml5I=;
 b=K7HxOlgaQMZTYdM0wRJ+ts3DisgNWr6XkKQXVqWZYO6WqEVczmB/PcYtFRAtq2mc42do9G13sN++gmv6VRJ3gv2FvloRtuIMgRHp9cFEIzXSwU7OAVtirX8HEeMvlH4AFjH1j0ZW8rbA3YonpZ1jfdtRTRd8LFNiviPssS7lKvY=
Received: from BN9PR03CA0405.namprd03.prod.outlook.com (2603:10b6:408:111::20)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 06:21:01 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::98) by BN9PR03CA0405.outlook.office365.com
 (2603:10b6:408:111::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Tue, 11 Oct 2022 06:21:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 06:21:01 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 01:20:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 01:20:57 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 11 Oct 2022 01:20:54 -0500
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        "Amit Kumar Mahapatra" <amit.kumar-mahapatra@amd.com>
Subject: [PATCH v4 4/7] firmware: xilinx: Add qspi firmware interface
Date:   Tue, 11 Oct 2022 11:50:37 +0530
Message-ID: <20221011062040.12116-5-amit.kumar-mahapatra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011062040.12116-1-amit.kumar-mahapatra@amd.com>
References: <20221011062040.12116-1-amit.kumar-mahapatra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: bae8acac-95ca-499a-e0c5-08daab50c4a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0UaVTOv2gxwu710w0aYpFeGQyNxPWupR4H8IeobZFXosBAxJ++Q0BT83wyLaFynyfGVoccYG0m5yaq3XC5FRSPz1tou8VDrmtT7o/L7T25hH8kVVaIbFfniFknpJzLqa4Vq3dtczi8q1jPiv0+579zdOC4p/2COxvAQliXbyHUuwrq2Hw55RrenMiun4eqnQC9kK3aYSKAfZxlyQzc9FD/R6tjUymF6SPHAYgCaJnZEl0IuwZkYh6cDIow+wnzAm4kvuy0AbRxcWhILbb46k3usB3N/JrdyLylVUNDqijIwhya+H4VV9kMzFtRjLNYVeTwyW4HjlC7zO0BymasYujwt9konc1a5Sf1yxS1xbuMeHVLZnEn4yehU/REPkhvEptX9VuVOOuxqY2LzjTSZJyZ8tfG7uyi4qInW7MPBxOKR+ILO8Xo4pCptVB4p2U/jx2Q6VHK8cCpZICYr7U09lzufC5dxz7Bja3IMKdngI7IGgFKJggznvdEyQwH7L/N/gmCQIEipW7QfHlpQ8490ZGzvL4O7i5UeGJe8vtXQ4dfBEqZcZOftcepUPGm6Ds9m08LbD3jDtgLXzQivltYVE9ZXnv5lf/1vVK5VOxp28MiXh2yGMqmyTq0z9qdTaJ9ucuw6MAp4MOJBdVYxkT1j1IX82LKMvpkyI0X1OObPKKrhP62AoaIP8HnONEQWkcwhap6PgtGJt3scS6mTDI+iY683vtdN58lCjETwqnYFqnIVF3yYEWkM3T7Y2Y5jv3sOJNaxh0AKdHmHy/qYuxKobqeAdlm6M5GWlscMykbpq+f8bUaLsS91xZLIqkqtE3sb
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199015)(36840700001)(46966006)(40470700004)(82740400003)(81166007)(356005)(36756003)(86362001)(2906002)(5660300002)(83380400001)(186003)(47076005)(426003)(40480700001)(336012)(2616005)(1076003)(36860700001)(26005)(6666004)(4326008)(8676002)(70586007)(70206006)(54906003)(110136005)(41300700001)(40460700003)(82310400005)(316002)(8936002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 06:21:01.0841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bae8acac-95ca-499a-e0c5-08daab50c4a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add support for QSPI ioctl functions and enums.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
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

