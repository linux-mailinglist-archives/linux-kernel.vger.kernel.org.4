Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFF86656A9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbjAKJAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236126AbjAKI76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:59:58 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D5710568
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:59:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdn1de4Cs3JZ0QCCFgkLnAxAY8Z8kBvxxhFcXgX6e54sXFAxGr2bRB82bpGCH15le9RKRnW9eSt8RjqsSDNHC55vHojN0QbUth69hVf75mvE6sq187XtQlrDa7yPmH8yhkRYm8hSJSTnhJZqoIBDfeFK4oSQY/Rsg/Xi3/y67aYuMLAlYQCvYZZFu5vtn/re6Tz0VB5EOs7BF0cJxSKLl6EdnMSFBpnn+r42actd+jxJ4ttTG5D/JWhUUpEvGL8CL+itiEyfpRMvDdFXMZEGHcrJIimhlcfvPp1GI7Rq7bQQ4W5lvPLCqkJZGD5pXMEaJH+pLOxXOxpjU6KIXPGGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjLi+EX2nenBMsCeBmAMvFRdYBHLLEcTdxyYvYAXArM=;
 b=DTtuGb3go3yVeoIfzJN068qaZxecMskKFixipNLNPBtSdlgJRyM0lI0GaF4xuKzQnI0lHJgV7hUdKZA5VVolLCl1YB7E3KTFh6VS/zIxe+az9QvI8D7Ep/naX2bvC29+6nsEIOg28KLPuY+SaFQtSxe2ZPpr7yvwowS2lB5lTa6w7hvMcXactoBEnI33A5mjwXVMBzznhjQs9NBZqaZU1HrD65xVFCw6bFY39FPOFPZ+kPuoIMI9rJD/0Xs7N/XMp0iu2Ysk/4qhf+B423nmvcZtbfTlu1ZEKRhbBDhQKy9kAoFRRq4oujnx1IqsB180yZrW0+SUw014gzWohHO0VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjLi+EX2nenBMsCeBmAMvFRdYBHLLEcTdxyYvYAXArM=;
 b=c5JPBA00mrYMkoEbBUGuWhVLfsjlYD55g6xC49aFnVGY0ljEd39NSz3H667no1tiWzK7RZ1iFPkiziA5ClhYCwZMb0P50DB/X6w66TsfyxUmdnrvaLiY+F8T0oTYKQdv/4/Ip77eRz8VqP9rH7KAPoxjh5kL1ErKXUdepfIJwFE=
Received: from DM6PR03CA0013.namprd03.prod.outlook.com (2603:10b6:5:40::26) by
 CH3PR12MB8546.namprd12.prod.outlook.com (2603:10b6:610:15f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 11 Jan
 2023 08:59:51 +0000
Received: from DS1PEPF0000B073.namprd05.prod.outlook.com
 (2603:10b6:5:40:cafe::e5) by DM6PR03CA0013.outlook.office365.com
 (2603:10b6:5:40::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Wed, 11 Jan 2023 08:59:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B073.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Wed, 11 Jan 2023 08:59:50 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 02:59:49 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 11 Jan 2023 02:59:46 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <vkoul@kernel.org>,
        <alsa-devel@alsa-project.org>
CC:     <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>, <Mastan.Katragadda@amd.com>,
        <arungopal.kondaveeti@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/19] soundwire: amd: Add support for AMD Master driver
Date:   Wed, 11 Jan 2023 14:32:05 +0530
Message-ID: <20230111090222.2016499-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B073:EE_|CH3PR12MB8546:EE_
X-MS-Office365-Filtering-Correlation-Id: 58401ef8-7572-44b2-7331-08daf3b232dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5fx7zGH+R721udeDnxwsfGauzXrKN8YHyvshCXQgD43+UTde4MjZlYl2AdZvQtt+l3aPImZmHHWfnrSxq/9Xu4yCvhSMxGIzIS83iytmsIWDqWw3OZ6OAuXCiLGo/iZGBgppLZswrdJwGjao3/OZq2Gy8tCHZAZAjyZfqKmx0BJckbCw5QwDWVJqzpfEG0hmqUNNPWtfHf0g8od889kM5HqtygaCzqXrkV9+k8gv5ct4JnWE5PSUSr8grki369LhYBO8P2UO+zxaiiww7NRpjWoaa+eXZzThViL1LptjFUt/fW2TWMGoJ1NIE9s6fFb4IxyyGAlRp2ohSBO8TCYpN7svA7v5+EPeQp5OEGNf9e3wlTDho/EMrn8EsGiN0PIiAD0S3xA6Pi8Fqk0kiEFvMs3ChytoTip4Z2Krn918OSwTSKrLgcF/P6KcNBh4d2Ia3PFV3IVayX8654+xHAqPdc07lSOkqVEO+AF4jvnqWuLZpnM+032wXH5wJMYbJni+Wk/Qb5gIoOZAvkaK6paclJiLL+jWO8s2eAzaJ7PnqNhAE32UCa0BbaMf0sdtuGdcgKLLZ5O8jvpvCUjIXmDw02S8b0expAHfCQAx5+cLWAgNnS8MNSJObKjXueNWxFXwueiIalEUL/UjpBvp+zYcUl27+anhveXKs8rcZgK9YF+ez/7OkHcXA/pdurSbFzTUXv3mMA6fK7v2qHBcdXKddCnUb5EyRvUlNpeJMgTjlDI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(82740400003)(478600001)(426003)(47076005)(81166007)(356005)(41300700001)(1076003)(86362001)(40460700003)(110136005)(54906003)(2616005)(316002)(336012)(7696005)(82310400005)(186003)(26005)(40480700001)(70206006)(70586007)(4326008)(8676002)(36756003)(5660300002)(6666004)(36860700001)(2906002)(30864003)(83380400001)(8936002)(36900700001)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 08:59:50.8667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58401ef8-7572-44b2-7331-08daf3b232dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B073.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8546
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD ACP IP block has two soundwire controller devices.
Add support for
- Master driver probe & remove sequence
- Helper functions to enable/disable interrupts, Initialize sdw controller,
  enable sdw pads
- Master driver sdw_master_ops & port_ops callbacks

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_master.c    | 1075 +++++++++++++++++++++++++++++
 drivers/soundwire/amd_master.h    |  279 ++++++++
 include/linux/soundwire/sdw_amd.h |   21 +
 3 files changed, 1375 insertions(+)
 create mode 100644 drivers/soundwire/amd_master.c
 create mode 100644 drivers/soundwire/amd_master.h

diff --git a/drivers/soundwire/amd_master.c b/drivers/soundwire/amd_master.c
new file mode 100644
index 000000000000..7e1f618254ac
--- /dev/null
+++ b/drivers/soundwire/amd_master.c
@@ -0,0 +1,1075 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SoundWire AMD Master driver
+ *
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_registers.h>
+#include <linux/soundwire/sdw_amd.h>
+#include <linux/wait.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include "bus.h"
+#include "amd_master.h"
+
+#define DRV_NAME "amd_sdw_controller"
+
+#define to_amd_sdw(b)	container_of(b, struct amd_sdwc_ctrl, bus)
+
+static int amd_enable_sdw_pads(struct amd_sdwc_ctrl *ctrl)
+{
+	u32 sw_pad_enable_mask;
+	u32 sw_pad_pulldown_mask;
+	u32 sw_pad_pulldown_val;
+	u32 val = 0;
+
+	switch (ctrl->instance) {
+	case ACP_SDW0:
+		sw_pad_enable_mask = AMD_SDW0_PAD_KEEPER_EN_MASK;
+		sw_pad_pulldown_mask = AMD_SDW0_PAD_PULLDOWN_CTRL_ENABLE_MASK;
+		break;
+	case ACP_SDW1:
+		sw_pad_enable_mask = AMD_SDW1_PAD_KEEPER_EN_MASK;
+		sw_pad_pulldown_mask = AMD_SDW1_PAD_PULLDOWN_CTRL_ENABLE_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mutex_lock(ctrl->sdw_lock);
+	val = acp_reg_readl(ctrl->mmio + ACP_SW_PAD_KEEPER_EN);
+	val |= sw_pad_enable_mask;
+	acp_reg_writel(val, ctrl->mmio + ACP_SW_PAD_KEEPER_EN);
+	mutex_unlock(ctrl->sdw_lock);
+	usleep_range(1000, 1500);
+
+	mutex_lock(ctrl->sdw_lock);
+	sw_pad_pulldown_val  = acp_reg_readl(ctrl->mmio + ACP_PAD_PULLDOWN_CTRL);
+	sw_pad_pulldown_val &= sw_pad_pulldown_mask;
+	acp_reg_writel(sw_pad_pulldown_val, ctrl->mmio + ACP_PAD_PULLDOWN_CTRL);
+	mutex_unlock(ctrl->sdw_lock);
+	return 0;
+}
+
+static int amd_init_sdw_controller(struct amd_sdwc_ctrl *ctrl)
+{
+	u32 acp_sw_en_reg, acp_sw_en_stat_reg, sw_bus_reset_reg;
+	u32 val = 0;
+	u32 timeout = 0;
+	u32 retry_count = 0;
+
+	switch (ctrl->instance) {
+	case ACP_SDW0:
+		acp_sw_en_reg = ACP_SW_EN;
+		acp_sw_en_stat_reg = ACP_SW_EN_STATUS;
+		sw_bus_reset_reg = ACP_SW_BUS_RESET_CTRL;
+		break;
+	case ACP_SDW1:
+		acp_sw_en_reg = ACP_P1_SW_EN;
+		acp_sw_en_stat_reg = ACP_P1_SW_EN_STATUS;
+		sw_bus_reset_reg = ACP_P1_SW_BUS_RESET_CTRL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	acp_reg_writel(AMD_SDW_ENABLE, ctrl->mmio + acp_sw_en_reg);
+	do {
+		val = acp_reg_readl(ctrl->mmio + acp_sw_en_stat_reg);
+		if (val)
+			break;
+		usleep_range(10, 50);
+	} while (retry_count++ < AMD_SDW_STAT_MAX_RETRY_COUNT);
+
+	if (retry_count > AMD_SDW_STAT_MAX_RETRY_COUNT)
+		return -ETIMEDOUT;
+
+	/* Sdw Controller reset */
+	acp_reg_writel(AMD_SDW_BUS_RESET_REQ, ctrl->mmio + sw_bus_reset_reg);
+	val = acp_reg_readl(ctrl->mmio + sw_bus_reset_reg);
+	while (!(val & AMD_SDW_BUS_RESET_DONE)) {
+		val = acp_reg_readl(ctrl->mmio + sw_bus_reset_reg);
+		if (timeout > AMD_DELAY_LOOP_ITERATION)
+			break;
+		usleep_range(1, 5);
+		timeout++;
+	}
+	timeout = 0;
+	acp_reg_writel(AMD_SDW_BUS_RESET_CLEAR_REQ, ctrl->mmio + sw_bus_reset_reg);
+	val = acp_reg_readl(ctrl->mmio + sw_bus_reset_reg);
+	while (val) {
+		val = acp_reg_readl(ctrl->mmio + sw_bus_reset_reg);
+		if (timeout > AMD_DELAY_LOOP_ITERATION)
+			break;
+		usleep_range(1, 5);
+		timeout++;
+	}
+	if (timeout == AMD_DELAY_LOOP_ITERATION) {
+		dev_err(ctrl->dev, "Failed to reset SW%x Soundwire Controller\n", ctrl->instance);
+		return -ETIMEDOUT;
+	}
+	retry_count = 0;
+	acp_reg_writel(AMD_SDW_DISABLE, ctrl->mmio + acp_sw_en_reg);
+	do {
+		val = acp_reg_readl(ctrl->mmio + acp_sw_en_stat_reg);
+		if (!val)
+			break;
+		usleep_range(10, 50);
+	} while (retry_count++ < AMD_SDW_STAT_MAX_RETRY_COUNT);
+
+	if (retry_count > AMD_SDW_STAT_MAX_RETRY_COUNT)
+		return -ETIMEDOUT;
+	return 0;
+}
+
+static int amd_enable_sdw_controller(struct amd_sdwc_ctrl *ctrl)
+{
+	u32 acp_sw_en_reg;
+	u32 acp_sw_en_stat_reg;
+	u32 val = 0;
+	u32 retry_count = 0;
+
+	switch (ctrl->instance) {
+	case ACP_SDW0:
+		acp_sw_en_reg = ACP_SW_EN;
+		acp_sw_en_stat_reg = ACP_SW_EN_STATUS;
+		break;
+	case ACP_SDW1:
+		acp_sw_en_reg = ACP_P1_SW_EN;
+		acp_sw_en_stat_reg = ACP_P1_SW_EN_STATUS;
+		break;
+	default:
+		return -EINVAL;
+	}
+	acp_reg_writel(AMD_SDW_ENABLE, ctrl->mmio + acp_sw_en_reg);
+
+	do {
+		val = acp_reg_readl(ctrl->mmio + acp_sw_en_stat_reg);
+		if (val)
+			break;
+		usleep_range(10, 50);
+	} while (retry_count++ < AMD_SDW_STAT_MAX_RETRY_COUNT);
+
+	if (retry_count > AMD_SDW_STAT_MAX_RETRY_COUNT)
+		return -ETIMEDOUT;
+	return 0;
+}
+
+static int amd_disable_sdw_controller(struct amd_sdwc_ctrl *ctrl)
+{
+	u32 clk_resume_ctrl_reg;
+	u32 acp_sw_en_reg;
+	u32 acp_sw_en_stat_reg;
+	u32 val = 0;
+	u32 retry_count = 0;
+
+	switch (ctrl->instance) {
+	case ACP_SDW0:
+		acp_sw_en_reg = ACP_SW_EN;
+		acp_sw_en_stat_reg = ACP_SW_EN_STATUS;
+		clk_resume_ctrl_reg = ACP_SW_CLK_RESUME_CTRL;
+		break;
+	case ACP_SDW1:
+		acp_sw_en_reg = ACP_P1_SW_EN;
+		acp_sw_en_stat_reg = ACP_P1_SW_EN_STATUS;
+		clk_resume_ctrl_reg = ACP_P1_SW_CLK_RESUME_CTRL;
+		break;
+	default:
+		return -EINVAL;
+	}
+	acp_reg_writel(AMD_SDW_DISABLE, ctrl->mmio + acp_sw_en_reg);
+
+	/*
+	 * After invoking controller disable sequence, check whether
+	 * controller has executed clock stop sequence. In this case,
+	 * controller should ignore checking enable status register.
+	 */
+	val = acp_reg_readl(ctrl->mmio + clk_resume_ctrl_reg);
+	if (val)
+		return 0;
+
+	do {
+		val = acp_reg_readl(ctrl->mmio + acp_sw_en_stat_reg);
+		if (!val)
+			break;
+		usleep_range(10, 50);
+	} while (retry_count++ < AMD_SDW_STAT_MAX_RETRY_COUNT);
+
+	if (retry_count > AMD_SDW_STAT_MAX_RETRY_COUNT)
+		return -ETIMEDOUT;
+	return 0;
+}
+
+static int amd_enable_sdw_interrupts(struct amd_sdwc_ctrl *ctrl)
+{
+	u32 val;
+	u32 acp_ext_intr_stat, acp_ext_intr_ctrl, acp_sdw_intr_mask;
+	u32 sw_stat_mask_0to7, sw_stat_mask_8to11, sw_err_intr_mask;
+
+	switch (ctrl->instance) {
+	case ACP_SDW0:
+		acp_ext_intr_ctrl = ACP_EXTERNAL_INTR_CNTL;
+		acp_sdw_intr_mask = AMD_SDW0_EXT_INTR_MASK;
+		acp_ext_intr_stat = ACP_EXTERNAL_INTR_STAT;
+		sw_stat_mask_0to7 = SW_STATE_CHANGE_STATUS_MASK_0TO7;
+		sw_stat_mask_8to11 = SW_STATE_CHANGE_STATUS_MASK_8TO11;
+		sw_err_intr_mask = SW_ERROR_INTR_MASK;
+		break;
+	case ACP_SDW1:
+		acp_ext_intr_ctrl = ACP_EXTERNAL_INTR_CNTL1;
+		acp_sdw_intr_mask = AMD_SDW1_EXT_INTR_MASK;
+		acp_ext_intr_stat = ACP_EXTERNAL_INTR_STAT1;
+		sw_stat_mask_0to7 = P1_SW_STATE_CHANGE_STATUS_MASK_0TO7;
+		sw_stat_mask_8to11 = P1_SW_STATE_CHANGE_STATUS_MASK_8TO11;
+		sw_err_intr_mask = P1_SW_ERROR_INTR_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+	mutex_lock(ctrl->sdw_lock);
+	val = acp_reg_readl(ctrl->mmio + acp_ext_intr_ctrl);
+	val |= acp_sdw_intr_mask;
+	acp_reg_writel(val, ctrl->mmio + acp_ext_intr_ctrl);
+	val = acp_reg_readl(ctrl->mmio + acp_ext_intr_ctrl);
+	mutex_unlock(ctrl->sdw_lock);
+	dev_dbg(ctrl->dev, "%s: acp_ext_intr_ctrl[0x%x]:0x%x\n", __func__, acp_ext_intr_ctrl, val);
+	val = acp_reg_readl(ctrl->mmio + acp_ext_intr_stat);
+	if (val)
+		acp_reg_writel(val, ctrl->mmio + acp_ext_intr_stat);
+	acp_reg_writel(AMD_SDW_IRQ_MASK_0TO7, ctrl->mmio + sw_stat_mask_0to7);
+	acp_reg_writel(AMD_SDW_IRQ_MASK_8TO11, ctrl->mmio + sw_stat_mask_8to11);
+	acp_reg_writel(AMD_SDW_IRQ_ERROR_MASK, ctrl->mmio + sw_err_intr_mask);
+	return 0;
+}
+
+static int amd_disable_sdw_interrupts(struct amd_sdwc_ctrl *ctrl)
+{
+	u32 val;
+	u32 acp_ext_intr_cntl;
+	u32 acp_sdw_intr_mask;
+	u32 sw_stat_mask_0to7;
+	u32 sw_stat_mask_8to11;
+	u32 sw_err_intr_mask;
+
+	switch (ctrl->instance) {
+	case ACP_SDW0:
+		acp_ext_intr_cntl = ACP_EXTERNAL_INTR_CNTL;
+		acp_sdw_intr_mask = AMD_SDW0_EXT_INTR_MASK;
+		sw_stat_mask_0to7 = SW_STATE_CHANGE_STATUS_MASK_0TO7;
+		sw_stat_mask_8to11 = SW_STATE_CHANGE_STATUS_MASK_8TO11;
+		sw_err_intr_mask = SW_ERROR_INTR_MASK;
+		break;
+	case ACP_SDW1:
+		acp_ext_intr_cntl = ACP_EXTERNAL_INTR_CNTL1;
+		acp_sdw_intr_mask = AMD_SDW1_EXT_INTR_MASK;
+		sw_stat_mask_0to7 = P1_SW_STATE_CHANGE_STATUS_MASK_0TO7;
+		sw_stat_mask_8to11 = P1_SW_STATE_CHANGE_STATUS_MASK_8TO11;
+		sw_err_intr_mask = P1_SW_ERROR_INTR_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+	mutex_lock(ctrl->sdw_lock);
+	val = acp_reg_readl(ctrl->mmio + acp_ext_intr_cntl);
+	val &= ~acp_sdw_intr_mask;
+	acp_reg_writel(val, ctrl->mmio + acp_ext_intr_cntl);
+	mutex_unlock(ctrl->sdw_lock);
+
+	acp_reg_writel(0x00, ctrl->mmio + sw_stat_mask_0to7);
+	acp_reg_writel(0x00, ctrl->mmio + sw_stat_mask_8to11);
+	acp_reg_writel(0x00, ctrl->mmio + sw_err_intr_mask);
+	return 0;
+}
+
+static int amd_sdwc_set_frameshape(struct amd_sdwc_ctrl *ctrl, u32 rows, u32 cols)
+{
+	u32 sdw_rows, sdw_cols, frame_size;
+	u32 acp_sw_frame_reg;
+
+	switch (ctrl->instance) {
+	case ACP_SDW0:
+		acp_sw_frame_reg = ACP_SW_FRAMESIZE;
+		break;
+	case ACP_SDW1:
+		acp_sw_frame_reg = ACP_P1_SW_FRAMESIZE;
+		break;
+	default:
+		return -EINVAL;
+	}
+	sdw_cols = sdw_find_col_index(cols);
+	sdw_rows = sdw_find_row_index(rows);
+	frame_size = (sdw_rows << 3) | sdw_cols;
+	acp_reg_writel(frame_size, ctrl->mmio + acp_sw_frame_reg);
+	return 0;
+}
+
+static void amd_sdwc_ctl_word_prep(u32 *low_word, u32 *high_word, u32 cmd_type,
+				   struct sdw_msg *msg, int cmd_offset)
+{
+	u32 low_data = 0, high_data = 0;
+	u16 addr;
+	u8 addr_high, addr_low;
+	u8 data = 0;
+
+	addr = msg->addr + cmd_offset;
+	addr_high = (addr & 0xFF00) >> 8;
+	addr_low = addr & 0xFF;
+
+	if (cmd_type == AMD_SDW_CMD_WRITE)
+		data = msg->buf[cmd_offset];
+
+	high_data = FIELD_PREP(AMD_SDW_MCP_CMD_DEV_ADDR, msg->dev_num);
+	high_data |= FIELD_PREP(AMD_SDW_MCP_CMD_COMMAND, cmd_type);
+	high_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_ADDR_HIGH, addr_high);
+	low_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_ADDR_LOW, addr_low);
+	low_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_DATA, data);
+
+	*high_word = high_data;
+	*low_word = low_data;
+}
+
+static u64 amd_sdwc_send_cmd_get_resp(struct amd_sdwc_ctrl *ctrl, u32 lword, u32 uword)
+{
+	u64 resp = 0;
+	u32 imm_cmd_stat_reg, imm_cmd_uword_reg, imm_cmd_lword_reg;
+	u32 imm_resp_uword_reg, imm_resp_lword_reg;
+	u32 resp_lower, resp_high;
+	u32 sts = 0;
+	u32 timeout = 0;
+
+	switch (ctrl->instance) {
+	case ACP_SDW0:
+		imm_cmd_stat_reg = SW_IMM_CMD_STS;
+		imm_cmd_uword_reg = SW_IMM_CMD_UPPER_WORD;
+		imm_cmd_lword_reg = SW_IMM_CMD_LOWER_QWORD;
+		imm_resp_uword_reg = SW_IMM_RESP_UPPER_WORD;
+		imm_resp_lword_reg = SW_IMM_RESP_LOWER_QWORD;
+		break;
+	case ACP_SDW1:
+		imm_cmd_stat_reg = P1_SW_IMM_CMD_STS;
+		imm_cmd_uword_reg = P1_SW_IMM_CMD_UPPER_WORD;
+		imm_cmd_lword_reg = P1_SW_IMM_CMD_LOWER_QWORD;
+		imm_resp_uword_reg = P1_SW_IMM_RESP_UPPER_WORD;
+		imm_resp_lword_reg = P1_SW_IMM_RESP_LOWER_QWORD;
+		break;
+	default:
+		return -EINVAL;
+	}
+	sts = acp_reg_readl(ctrl->mmio + imm_cmd_stat_reg);
+	while (sts & AMD_SDW_IMM_CMD_BUSY) {
+		sts = acp_reg_readl(ctrl->mmio + imm_cmd_stat_reg);
+		if (timeout > AMD_SDW_RETRY_COUNT) {
+			dev_err(ctrl->dev, "SDW%x previous cmd status clear failed\n",
+				ctrl->instance);
+			return -ETIMEDOUT;
+		}
+		timeout++;
+	}
+
+	timeout = 0;
+	if (sts & AMD_SDW_IMM_RES_VALID) {
+		dev_err(ctrl->dev, "SDW%x controller is in bad state\n", ctrl->instance);
+		acp_reg_writel(0x00, ctrl->mmio + imm_cmd_stat_reg);
+	}
+	acp_reg_writel(uword, ctrl->mmio + imm_cmd_uword_reg);
+	acp_reg_writel(lword, ctrl->mmio + imm_cmd_lword_reg);
+
+	sts = acp_reg_readl(ctrl->mmio + imm_cmd_stat_reg);
+	while (!(sts & AMD_SDW_IMM_RES_VALID)) {
+		sts = acp_reg_readl(ctrl->mmio + imm_cmd_stat_reg);
+		if (timeout > AMD_SDW_RETRY_COUNT) {
+			dev_err(ctrl->dev, "SDW%x cmd response timeout occurred\n", ctrl->instance);
+			return -ETIMEDOUT;
+		}
+		timeout++;
+	}
+	resp_high = acp_reg_readl(ctrl->mmio + imm_resp_uword_reg);
+	resp_lower = acp_reg_readl(ctrl->mmio + imm_resp_lword_reg);
+	timeout = 0;
+	acp_reg_writel(AMD_SDW_IMM_RES_VALID, ctrl->mmio + imm_cmd_stat_reg);
+	while ((sts & AMD_SDW_IMM_RES_VALID)) {
+		sts = acp_reg_readl(ctrl->mmio + imm_cmd_stat_reg);
+		if (timeout > AMD_SDW_RETRY_COUNT) {
+			dev_err(ctrl->dev, "SDW%x cmd status retry failed\n", ctrl->instance);
+			return -ETIMEDOUT;
+		}
+		timeout++;
+	}
+	resp = resp_high;
+	resp = (resp << 32) | resp_lower;
+	return resp;
+}
+
+static enum sdw_command_response
+amd_program_scp_addr(struct amd_sdwc_ctrl *ctrl, struct sdw_msg *msg)
+{
+	struct sdw_msg scp_msg = {0};
+	u64 response_buf[2] = {0};
+	u32 uword = 0, lword = 0;
+	int nack = 0, no_ack = 0;
+	int index, timeout = 0;
+
+	scp_msg.dev_num = msg->dev_num;
+	scp_msg.addr = SDW_SCP_ADDRPAGE1;
+	scp_msg.buf = &msg->addr_page1;
+	amd_sdwc_ctl_word_prep(&lword, &uword, AMD_SDW_CMD_WRITE, &scp_msg, 0);
+	response_buf[0] = amd_sdwc_send_cmd_get_resp(ctrl, lword, uword);
+	scp_msg.addr = SDW_SCP_ADDRPAGE2;
+	scp_msg.buf = &msg->addr_page2;
+	amd_sdwc_ctl_word_prep(&lword, &uword, AMD_SDW_CMD_WRITE, &scp_msg, 0);
+	response_buf[1] = amd_sdwc_send_cmd_get_resp(ctrl, lword, uword);
+
+	/* check response the writes */
+	for (index = 0; index < 2; index++) {
+		if (response_buf[index] == -ETIMEDOUT) {
+			dev_err(ctrl->dev, "Program SCP cmd timeout\n");
+			timeout = 1;
+		} else if (!(response_buf[index] & AMD_SDW_MCP_RESP_ACK)) {
+			no_ack = 1;
+			if (response_buf[index] & AMD_SDW_MCP_RESP_NACK) {
+				nack = 1;
+				dev_err(ctrl->dev, "Program SCP NACK received\n");
+			}
+		}
+	}
+
+	if (timeout) {
+		dev_err_ratelimited(ctrl->dev,
+				    "SCP_addrpage command timeout for Slave %d\n", msg->dev_num);
+		return SDW_CMD_TIMEOUT;
+	}
+
+	if (nack) {
+		dev_err_ratelimited(ctrl->dev,
+				    "SCP_addrpage NACKed for Slave %d\n", msg->dev_num);
+		return SDW_CMD_FAIL;
+	}
+
+	if (no_ack) {
+		dev_dbg_ratelimited(ctrl->dev,
+				    "SCP_addrpage ignored for Slave %d\n", msg->dev_num);
+		return SDW_CMD_IGNORED;
+	}
+	return SDW_CMD_OK;
+}
+
+static int amd_prep_msg(struct amd_sdwc_ctrl *ctrl, struct sdw_msg *msg, int *cmd)
+{
+	int ret;
+
+	if (msg->page) {
+		ret = amd_program_scp_addr(ctrl, msg);
+		if (ret) {
+			msg->len = 0;
+			return ret;
+		}
+	}
+	switch (msg->flags) {
+	case SDW_MSG_FLAG_READ:
+		*cmd = AMD_SDW_CMD_READ;
+		break;
+	case SDW_MSG_FLAG_WRITE:
+		*cmd = AMD_SDW_CMD_WRITE;
+		break;
+	default:
+		dev_err(ctrl->dev, "Invalid msg cmd: %d\n", msg->flags);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static unsigned int _amd_sdwc_xfer_msg(struct amd_sdwc_ctrl *ctrl, struct sdw_msg *msg,
+				       int cmd, int cmd_offset)
+{
+	u64 response = 0;
+	u32 uword = 0, lword = 0;
+	int nack = 0, no_ack = 0;
+	int timeout = 0;
+
+	amd_sdwc_ctl_word_prep(&lword, &uword, cmd, msg, cmd_offset);
+	response = amd_sdwc_send_cmd_get_resp(ctrl, lword, uword);
+
+	if (response & AMD_SDW_MCP_RESP_ACK) {
+		if (cmd == AMD_SDW_CMD_READ)
+			msg->buf[cmd_offset] = FIELD_GET(AMD_SDW_MCP_RESP_RDATA, response);
+	} else {
+		no_ack = 1;
+		if (response == -ETIMEDOUT) {
+			timeout = 1;
+		} else if (response & AMD_SDW_MCP_RESP_NACK) {
+			nack = 1;
+			dev_err(ctrl->dev, "Program SCP NACK received\n");
+		}
+	}
+
+	if (timeout) {
+		dev_err_ratelimited(ctrl->dev, "command timeout for Slave %d\n", msg->dev_num);
+		return SDW_CMD_TIMEOUT;
+	}
+	if (nack) {
+		dev_err_ratelimited(ctrl->dev,
+				    "command response NACK received for Slave %d\n", msg->dev_num);
+		return SDW_CMD_FAIL;
+	}
+
+	if (no_ack) {
+		dev_err_ratelimited(ctrl->dev, "command is ignored for Slave %d\n", msg->dev_num);
+		return SDW_CMD_IGNORED;
+	}
+	return SDW_CMD_OK;
+}
+
+static enum sdw_command_response amd_sdwc_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg)
+{
+	struct amd_sdwc_ctrl *ctrl = to_amd_sdw(bus);
+	int ret, i;
+	int cmd = 0;
+
+	ret = amd_prep_msg(ctrl, msg, &cmd);
+	if (ret)
+		return SDW_CMD_FAIL_OTHER;
+	for (i = 0; i < msg->len; i++) {
+		ret = _amd_sdwc_xfer_msg(ctrl, msg, cmd, i);
+		if (ret)
+			return ret;
+	}
+	return SDW_CMD_OK;
+}
+
+static enum sdw_command_response
+amd_reset_page_addr(struct sdw_bus *bus, unsigned int dev_num)
+{
+	struct amd_sdwc_ctrl *ctrl = to_amd_sdw(bus);
+	struct sdw_msg msg;
+
+	/* Create dummy message with valid device number */
+	memset(&msg, 0, sizeof(msg));
+	msg.dev_num = dev_num;
+	return amd_program_scp_addr(ctrl, &msg);
+}
+
+static u32 amd_sdwc_read_ping_status(struct sdw_bus *bus)
+{
+	struct amd_sdwc_ctrl *ctrl = to_amd_sdw(bus);
+	u64 response;
+	u32 slave_stat = 0;
+
+	response = amd_sdwc_send_cmd_get_resp(ctrl, 0, 0);
+	/* slave status from ping response*/
+	slave_stat = FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_0_3, response);
+	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_4_11, response) << 8;
+	dev_dbg(ctrl->dev, "%s: slave_stat:0x%x\n", __func__, slave_stat);
+	return slave_stat;
+}
+
+static void amd_sdwc_compute_slave_ports(struct sdw_master_runtime *m_rt,
+					 struct sdw_transport_data *t_data)
+{
+	struct sdw_slave_runtime *s_rt = NULL;
+	struct sdw_port_runtime *p_rt;
+	int port_bo, sample_int;
+	unsigned int rate, bps, ch = 0;
+	unsigned int slave_total_ch;
+	struct sdw_bus_params *b_params = &m_rt->bus->params;
+
+	port_bo = t_data->block_offset;
+	list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
+		rate = m_rt->stream->params.rate;
+		bps = m_rt->stream->params.bps;
+		sample_int = (m_rt->bus->params.curr_dr_freq / rate);
+		slave_total_ch = 0;
+
+		list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
+			ch = sdw_ch_mask_to_ch(p_rt->ch_mask);
+
+			sdw_fill_xport_params(&p_rt->transport_params,
+					      p_rt->num, false,
+					      SDW_BLK_GRP_CNT_1,
+					      sample_int, port_bo, port_bo >> 8,
+					      t_data->hstart,
+					      t_data->hstop,
+					      SDW_BLK_PKG_PER_PORT, 0x0);
+
+			sdw_fill_port_params(&p_rt->port_params,
+					     p_rt->num, bps,
+					     SDW_PORT_FLOW_MODE_ISOCH,
+					     b_params->s_data_mode);
+
+			port_bo += bps * ch;
+			slave_total_ch += ch;
+		}
+
+		if (m_rt->direction == SDW_DATA_DIR_TX &&
+		    m_rt->ch_count == slave_total_ch) {
+			port_bo = t_data->block_offset;
+		}
+	}
+}
+
+static int amd_sdwc_compute_params(struct sdw_bus *bus)
+{
+	struct sdw_transport_data t_data = {0};
+	struct sdw_master_runtime *m_rt;
+	struct sdw_port_runtime *p_rt;
+	struct sdw_bus_params *b_params = &bus->params;
+	int port_bo, hstart, hstop, sample_int;
+	unsigned int rate, bps;
+
+	port_bo  = 0;
+	hstart = 1;
+	hstop = bus->params.col - 1;
+	t_data.hstop = hstop;
+	t_data.hstart = hstart;
+
+	list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
+		rate = m_rt->stream->params.rate;
+		bps = m_rt->stream->params.bps;
+		sample_int = (bus->params.curr_dr_freq / rate);
+		list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
+			port_bo = (p_rt->num * 64) + 1;
+			dev_dbg(bus->dev, "p_rt->num=%d hstart=%d hstop=%d port_bo=%d\n",
+				p_rt->num, hstart, hstop, port_bo);
+			sdw_fill_xport_params(&p_rt->transport_params, p_rt->num,
+					      false, SDW_BLK_GRP_CNT_1, sample_int,
+					      port_bo, port_bo >> 8, hstart, hstop,
+					      SDW_BLK_PKG_PER_PORT, 0x0);
+
+			sdw_fill_port_params(&p_rt->port_params,
+					     p_rt->num, bps,
+					     SDW_PORT_FLOW_MODE_ISOCH,
+					     b_params->m_data_mode);
+			t_data.hstart = hstart;
+			t_data.hstop = hstop;
+			t_data.block_offset = port_bo;
+			t_data.sub_block_offset = 0;
+		}
+		amd_sdwc_compute_slave_ports(m_rt, &t_data);
+	}
+	return 0;
+}
+
+static int amd_sdwc_port_params(struct sdw_bus *bus, struct sdw_port_params *p_params,
+				unsigned int bank)
+{
+	struct amd_sdwc_ctrl *ctrl = to_amd_sdw(bus);
+	u32 channel_type, frame_fmt_reg, dpn_frame_fmt;
+
+	dev_dbg(ctrl->dev, "%s: p_params->num:0x%x\n", __func__, p_params->num);
+	switch (ctrl->instance) {
+	case ACP_SDW0:
+		channel_type = p_params->num;
+		break;
+	case ACP_SDW1:
+		channel_type = p_params->num + ACP_SDW0_MAX_DAI;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (channel_type) {
+	case ACP_SDW0_AUDIO_TX:
+		frame_fmt_reg = ACP_SW_AUDIO_TX_FRAME_FORMAT;
+		break;
+	case ACP_SDW0_HS_TX:
+		frame_fmt_reg = ACP_SW_HEADSET_TX_FRAME_FORMAT;
+		break;
+	case ACP_SDW0_BT_TX:
+		frame_fmt_reg = ACP_SW_BT_TX_FRAME_FORMAT;
+		break;
+	case ACP_SDW1_BT_TX:
+		frame_fmt_reg = ACP_P1_SW_BT_TX_FRAME_FORMAT;
+		break;
+	case ACP_SDW0_AUDIO_RX:
+		frame_fmt_reg = ACP_SW_AUDIO_RX_FRAME_FORMAT;
+		break;
+	case ACP_SDW0_HS_RX:
+		frame_fmt_reg = ACP_SW_HEADSET_RX_FRAME_FORMAT;
+		break;
+	case ACP_SDW0_BT_RX:
+		frame_fmt_reg = ACP_SW_BT_RX_FRAME_FORMAT;
+		break;
+	case ACP_SDW1_BT_RX:
+		frame_fmt_reg = ACP_P1_SW_BT_RX_FRAME_FORMAT;
+		break;
+	default:
+		dev_err(bus->dev, "%s:Invalid channel:%d\n", __func__, channel_type);
+		return -EINVAL;
+	}
+	dpn_frame_fmt = acp_reg_readl(ctrl->mmio + frame_fmt_reg);
+	u32p_replace_bits(&dpn_frame_fmt, p_params->flow_mode, AMD_DPN_FRAME_FMT_PFM);
+	u32p_replace_bits(&dpn_frame_fmt, p_params->data_mode, AMD_DPN_FRAME_FMT_PDM);
+	u32p_replace_bits(&dpn_frame_fmt, p_params->bps - 1, AMD_DPN_FRAME_FMT_WORD_LEN);
+	acp_reg_writel(dpn_frame_fmt, ctrl->mmio + frame_fmt_reg);
+	return 0;
+}
+
+static int amd_sdwc_transport_params(struct sdw_bus *bus,
+				     struct sdw_transport_params *params,
+				     enum sdw_reg_bank bank)
+{
+	struct amd_sdwc_ctrl *ctrl = to_amd_sdw(bus);
+	u32 ssp_counter_reg;
+	u32 dpn_frame_fmt;
+	u32 dpn_sampleinterval;
+	u32 dpn_hctrl;
+	u32 dpn_offsetctrl;
+	u32 dpn_lanectrl;
+	u32 channel_type;
+	u32 frame_fmt_reg, sample_int_reg, hctrl_dp0_reg;
+	u32 offset_reg, lane_ctrl_reg;
+
+	switch (ctrl->instance) {
+	case ACP_SDW0:
+		ssp_counter_reg = ACP_SW_SSP_COUNTER;
+		channel_type = params->port_num;
+		break;
+	case ACP_SDW1:
+		ssp_counter_reg = ACP_P1_SW_SSP_COUNTER;
+		channel_type = params->port_num + ACP_SDW0_MAX_DAI;
+		break;
+	default:
+		return -EINVAL;
+	}
+	acp_reg_writel(AMD_SDW_SSP_COUNTER_VAL, ctrl->mmio + ssp_counter_reg);
+	dev_dbg(bus->dev, "%s: p_params->num:0x%x entry channel_type:0x%x\n",
+		__func__, params->port_num, channel_type);
+
+	switch (channel_type) {
+	case ACP_SDW0_AUDIO_TX:
+	{
+		frame_fmt_reg = ACP_SW_AUDIO_TX_FRAME_FORMAT;
+		sample_int_reg = ACP_SW_AUDIO_TX_SAMPLEINTERVAL;
+		hctrl_dp0_reg = ACP_SW_AUDIO_TX_HCTRL_DP0;
+		offset_reg = ACP_SW_AUDIO_TX_OFFSET_DP0;
+		lane_ctrl_reg = ACP_SW_AUDIO_TX_CHANNEL_ENABLE_DP0;
+		break;
+	}
+	case ACP_SDW0_HS_TX:
+	{
+		frame_fmt_reg = ACP_SW_HEADSET_TX_FRAME_FORMAT;
+		sample_int_reg = ACP_SW_HEADSET_TX_SAMPLEINTERVAL;
+		hctrl_dp0_reg = ACP_SW_HEADSET_TX_HCTRL;
+		offset_reg = ACP_SW_HEADSET_TX_OFFSET;
+		lane_ctrl_reg = ACP_SW_HEADSET_TX_CHANNEL_ENABLE_DP0;
+		break;
+	}
+	case ACP_SDW0_BT_TX:
+	{
+		frame_fmt_reg = ACP_SW_BT_TX_FRAME_FORMAT;
+		sample_int_reg = ACP_SW_BT_TX_SAMPLEINTERVAL;
+		hctrl_dp0_reg = ACP_SW_BT_TX_HCTRL;
+		offset_reg = ACP_SW_BT_TX_OFFSET;
+		lane_ctrl_reg = ACP_SW_BT_TX_CHANNEL_ENABLE_DP0;
+		break;
+	}
+	case ACP_SDW1_BT_TX:
+	{
+		frame_fmt_reg = ACP_P1_SW_BT_TX_FRAME_FORMAT;
+		sample_int_reg = ACP_P1_SW_BT_TX_SAMPLEINTERVAL;
+		hctrl_dp0_reg = ACP_P1_SW_BT_TX_HCTRL;
+		offset_reg = ACP_P1_SW_BT_TX_OFFSET;
+		lane_ctrl_reg = ACP_P1_SW_BT_TX_CHANNEL_ENABLE_DP0;
+		break;
+	}
+	case ACP_SDW0_AUDIO_RX:
+	{
+		frame_fmt_reg = ACP_SW_AUDIO_RX_FRAME_FORMAT;
+		sample_int_reg = ACP_SW_AUDIO_RX_SAMPLEINTERVAL;
+		hctrl_dp0_reg = ACP_SW_AUDIO_RX_HCTRL_DP0;
+		offset_reg = ACP_SW_AUDIO_RX_OFFSET_DP0;
+		lane_ctrl_reg = ACP_SW_AUDIO_RX_CHANNEL_ENABLE_DP0;
+		break;
+	}
+	case ACP_SDW0_HS_RX:
+	{
+		frame_fmt_reg = ACP_SW_HEADSET_RX_FRAME_FORMAT;
+		sample_int_reg = ACP_SW_HEADSET_RX_SAMPLEINTERVAL;
+		hctrl_dp0_reg = ACP_SW_HEADSET_RX_HCTRL;
+		offset_reg = ACP_SW_HEADSET_RX_OFFSET;
+		lane_ctrl_reg = ACP_SW_HEADSET_RX_CHANNEL_ENABLE_DP0;
+		break;
+	}
+	case ACP_SDW0_BT_RX:
+	{
+		frame_fmt_reg = ACP_SW_BT_RX_FRAME_FORMAT;
+		sample_int_reg = ACP_SW_BT_RX_SAMPLEINTERVAL;
+		hctrl_dp0_reg = ACP_SW_BT_RX_HCTRL;
+		offset_reg = ACP_SW_BT_RX_OFFSET;
+		lane_ctrl_reg = ACP_SW_BT_RX_CHANNEL_ENABLE_DP0;
+		break;
+	}
+	case ACP_SDW1_BT_RX:
+	{
+		frame_fmt_reg = ACP_P1_SW_BT_RX_FRAME_FORMAT;
+		sample_int_reg = ACP_P1_SW_BT_RX_SAMPLEINTERVAL;
+		hctrl_dp0_reg = ACP_P1_SW_BT_RX_HCTRL;
+		offset_reg = ACP_P1_SW_BT_RX_OFFSET;
+		lane_ctrl_reg = ACP_P1_SW_BT_RX_CHANNEL_ENABLE_DP0;
+		break;
+	}
+	default:
+		dev_err(bus->dev, "%s:Invalid channel:%d\n", __func__, channel_type);
+		return -EINVAL;
+	}
+	dpn_frame_fmt = acp_reg_readl(ctrl->mmio + frame_fmt_reg);
+	u32p_replace_bits(&dpn_frame_fmt, params->blk_pkg_mode, AMD_DPN_FRAME_FMT_BLK_PKG_MODE);
+	u32p_replace_bits(&dpn_frame_fmt, params->blk_grp_ctrl, AMD_DPN_FRAME_FMT_BLK_GRP_CTRL);
+	u32p_replace_bits(&dpn_frame_fmt, SDW_STREAM_PCM, AMD_DPN_FRAME_FMT_PCM_OR_PDM);
+	acp_reg_writel(dpn_frame_fmt, ctrl->mmio + frame_fmt_reg);
+
+	dpn_sampleinterval = params->sample_interval - 1;
+	acp_reg_writel(dpn_sampleinterval, ctrl->mmio + sample_int_reg);
+
+	dpn_hctrl = FIELD_PREP(AMD_DPN_HCTRL_HSTOP, params->hstop);
+	dpn_hctrl |= FIELD_PREP(AMD_DPN_HCTRL_HSTART, params->hstart);
+	acp_reg_writel(dpn_hctrl, ctrl->mmio + hctrl_dp0_reg);
+
+	dpn_offsetctrl = FIELD_PREP(AMD_DPN_OFFSET_CTRL_1, params->offset1);
+	dpn_offsetctrl |= FIELD_PREP(AMD_DPN_OFFSET_CTRL_2, params->offset2);
+	acp_reg_writel(dpn_offsetctrl, ctrl->mmio + offset_reg);
+
+	dpn_lanectrl = acp_reg_readl(ctrl->mmio + lane_ctrl_reg);
+	u32p_replace_bits(&dpn_lanectrl, params->lane_ctrl, AMD_DPN_CH_EN_LCTRL);
+	acp_reg_writel(dpn_lanectrl, ctrl->mmio + lane_ctrl_reg);
+	return 0;
+}
+
+static int amd_sdwc_port_enable(struct sdw_bus *bus,
+				struct sdw_enable_ch *enable_ch,
+				unsigned int bank)
+{
+	struct amd_sdwc_ctrl *ctrl = to_amd_sdw(bus);
+	u32 dpn_ch_enable;
+	u32 ch_enable_reg, channel_type;
+
+	switch (ctrl->instance) {
+	case ACP_SDW0:
+		channel_type = enable_ch->port_num;
+		break;
+	case ACP_SDW1:
+		channel_type = enable_ch->port_num + ACP_SDW0_MAX_DAI;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (channel_type) {
+	case ACP_SDW0_AUDIO_TX:
+		ch_enable_reg = ACP_SW_AUDIO_TX_CHANNEL_ENABLE_DP0;
+		break;
+	case ACP_SDW0_HS_TX:
+		ch_enable_reg = ACP_SW_HEADSET_TX_CHANNEL_ENABLE_DP0;
+		break;
+	case ACP_SDW0_BT_TX:
+		ch_enable_reg = ACP_SW_BT_TX_CHANNEL_ENABLE_DP0;
+		break;
+	case ACP_SDW1_BT_TX:
+		ch_enable_reg = ACP_P1_SW_BT_TX_CHANNEL_ENABLE_DP0;
+		break;
+	case ACP_SDW0_AUDIO_RX:
+		ch_enable_reg = ACP_SW_AUDIO_RX_CHANNEL_ENABLE_DP0;
+		break;
+	case ACP_SDW0_HS_RX:
+		ch_enable_reg = ACP_SW_HEADSET_RX_CHANNEL_ENABLE_DP0;
+		break;
+	case ACP_SDW0_BT_RX:
+		ch_enable_reg = ACP_SW_BT_RX_CHANNEL_ENABLE_DP0;
+		break;
+	case ACP_SDW1_BT_RX:
+		ch_enable_reg = ACP_P1_SW_BT_RX_CHANNEL_ENABLE_DP0;
+		break;
+	default:
+		dev_err(bus->dev, "%s:Invalid channel:%d\n", __func__, channel_type);
+		return -EINVAL;
+	}
+
+	dpn_ch_enable =  acp_reg_readl(ctrl->mmio + ch_enable_reg);
+	u32p_replace_bits(&dpn_ch_enable, enable_ch->ch_mask, AMD_DPN_CH_EN_CHMASK);
+	if (enable_ch->enable)
+		acp_reg_writel(dpn_ch_enable, ctrl->mmio + ch_enable_reg);
+	else
+		acp_reg_writel(0, ctrl->mmio + ch_enable_reg);
+	return 0;
+}
+
+static int sdw_master_read_amd_prop(struct sdw_bus *bus)
+{
+	struct amd_sdwc_ctrl *ctrl = to_amd_sdw(bus);
+	struct fwnode_handle *link;
+	struct sdw_master_prop *prop;
+	u32 quirk_mask = 0;
+	u32 wake_en_mask = 0;
+	u32 power_mode_mask = 0;
+	char name[32];
+
+	prop = &bus->prop;
+	/* Find master handle */
+	snprintf(name, sizeof(name), "mipi-sdw-link-%d-subproperties", bus->link_id);
+	link = device_get_named_child_node(bus->dev, name);
+	if (!link) {
+		dev_err(bus->dev, "Master node %s not found\n", name);
+		return -EIO;
+	}
+	fwnode_property_read_u32(link, "amd-sdw-enable", &quirk_mask);
+	if (!(quirk_mask & AMD_SDW_QUIRK_MASK_BUS_ENABLE))
+		prop->hw_disabled = true;
+	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH |
+		       SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY;
+
+	fwnode_property_read_u32(link, "amd-sdw-wake-enable", &wake_en_mask);
+	ctrl->wake_en_mask = wake_en_mask;
+	fwnode_property_read_u32(link, "amd-sdw-power-mode", &power_mode_mask);
+	ctrl->power_mode_mask = power_mode_mask;
+	return 0;
+}
+
+static int amd_prop_read(struct sdw_bus *bus)
+{
+	sdw_master_read_prop(bus);
+	sdw_master_read_amd_prop(bus);
+	return 0;
+}
+
+static const struct sdw_master_port_ops amd_sdwc_port_ops = {
+	.dpn_set_port_params = amd_sdwc_port_params,
+	.dpn_set_port_transport_params = amd_sdwc_transport_params,
+	.dpn_port_enable_ch = amd_sdwc_port_enable,
+};
+
+static const struct sdw_master_ops amd_sdwc_ops = {
+	.read_prop = amd_prop_read,
+	.xfer_msg = amd_sdwc_xfer_msg,
+	.reset_page_addr = amd_reset_page_addr,
+	.read_ping_status = amd_sdwc_read_ping_status,
+};
+
+static void amd_sdwc_probe_work(struct work_struct *work)
+{
+	struct amd_sdwc_ctrl *ctrl  = container_of(work, struct amd_sdwc_ctrl, probe_work);
+	struct sdw_master_prop *prop;
+	int ret;
+
+	prop = &ctrl->bus.prop;
+	if (!prop->hw_disabled) {
+		ret = amd_enable_sdw_pads(ctrl);
+		if (ret)
+			return;
+		ret = amd_init_sdw_controller(ctrl);
+		if (ret)
+			return;
+		amd_enable_sdw_interrupts(ctrl);
+		ret = amd_enable_sdw_controller(ctrl);
+		if (ret)
+			return;
+		ret = amd_sdwc_set_frameshape(ctrl, 50, 10);
+		if (!ret)
+			ctrl->startup_done = true;
+	}
+}
+
+static int amd_sdwc_probe(struct platform_device *pdev)
+{
+	const struct acp_sdw_pdata *pdata = pdev->dev.platform_data;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	struct sdw_master_prop *prop;
+	struct sdw_bus_params *params;
+	struct amd_sdwc_ctrl *ctrl;
+	int ret;
+
+	if (!pdev->dev.platform_data) {
+		dev_err(&pdev->dev, "platform_data not retrieved\n");
+		return -ENODEV;
+	}
+	ctrl = devm_kzalloc(&pdev->dev, sizeof(struct amd_sdwc_ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
+		return -ENOMEM;
+	}
+	ctrl->mmio = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (IS_ERR(ctrl->mmio)) {
+		dev_err(&pdev->dev, "mmio not found\n");
+		return PTR_ERR(ctrl->mmio);
+	}
+	ctrl->instance = pdata->instance;
+	ctrl->sdw_lock  = pdata->sdw_lock;
+	ctrl->rows_index = sdw_find_row_index(50);
+	ctrl->cols_index = sdw_find_col_index(10);
+
+	ctrl->dev = dev;
+	dev_set_drvdata(&pdev->dev, ctrl);
+
+	ctrl->bus.ops = &amd_sdwc_ops;
+	ctrl->bus.port_ops = &amd_sdwc_port_ops;
+	ctrl->bus.compute_params = &amd_sdwc_compute_params;
+	ctrl->bus.clk_stop_timeout = 1;
+	switch (ctrl->instance) {
+	case ACP_SDW0:
+		ctrl->num_dout_ports =  AMD_SDW0_MAX_TX_PORTS;
+		ctrl->num_din_ports = AMD_SDW0_MAX_RX_PORTS;
+		break;
+	case ACP_SDW1:
+		ctrl->num_dout_ports = AMD_SDW1_MAX_TX_PORTS;
+		ctrl->num_din_ports = AMD_SDW1_MAX_RX_PORTS;
+		break;
+	default:
+		return -EINVAL;
+	}
+	params = &ctrl->bus.params;
+	params->max_dr_freq = AMD_SDW_DEFAULT_CLK_FREQ * 2;
+	params->curr_dr_freq = AMD_SDW_DEFAULT_CLK_FREQ * 2;
+	params->col = 10;
+	params->row = 50;
+
+	prop = &ctrl->bus.prop;
+	prop->clk_freq = &amd_sdwc_freq_tbl[0];
+	prop->mclk_freq = AMD_SDW_BUS_BASE_FREQ;
+	ctrl->bus.link_id = ctrl->instance;
+	ret = sdw_bus_master_add(&ctrl->bus, dev, dev->fwnode);
+	if (ret) {
+		dev_err(dev, "Failed to register Soundwire controller (%d)\n",
+			ret);
+		return ret;
+	}
+	INIT_WORK(&ctrl->probe_work, amd_sdwc_probe_work);
+	schedule_work(&ctrl->probe_work);
+	return 0;
+}
+
+static int amd_sdwc_remove(struct platform_device *pdev)
+{
+	struct amd_sdwc_ctrl *ctrl = dev_get_drvdata(&pdev->dev);
+	int ret;
+
+	amd_disable_sdw_interrupts(ctrl);
+	sdw_bus_master_delete(&ctrl->bus);
+	ret = amd_disable_sdw_controller(ctrl);
+	return ret;
+}
+
+static struct platform_driver amd_sdwc_driver = {
+	.probe	= &amd_sdwc_probe,
+	.remove = &amd_sdwc_remove,
+	.driver = {
+		.name	= "amd_sdw_controller",
+	}
+};
+module_platform_driver(amd_sdwc_driver);
+
+MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
+MODULE_DESCRIPTION("AMD soundwire driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
+
diff --git a/drivers/soundwire/amd_master.h b/drivers/soundwire/amd_master.h
new file mode 100644
index 000000000000..42f32ca0c7a8
--- /dev/null
+++ b/drivers/soundwire/amd_master.h
@@ -0,0 +1,279 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2023 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#ifndef __AMD_MASTER_H
+#define __AMD_MASTER_H
+
+#define ACP_PAD_PULLDOWN_CTRL                         0x0001448
+#define ACP_SW_PAD_KEEPER_EN                          0x0001454
+#define ACP_SW_WAKE_EN                                0x0001458
+#define ACP_SW1_WAKE_EN                               0x0001460
+#define ACP_SW_I2S_ERROR_REASON                       0x00018B4
+
+#define ACP_EXTERNAL_INTR_ENB                         0x0001A00
+#define ACP_EXTERNAL_INTR_CNTL                        0x0001A04
+#define ACP_EXTERNAL_INTR_CNTL1                       0x0001A08
+#define ACP_EXTERNAL_INTR_STAT                        0x0001A0C
+#define ACP_EXTERNAL_INTR_STAT1                       0x0001A10
+#define ACP_ERROR_STATUS                              0x0001A4C
+#define ACP_P1_SW_I2S_ERROR_REASON                    0x0001A50
+
+#define ACP_SW_EN                                     0x0003000
+#define ACP_SW_EN_STATUS                              0x0003004
+#define ACP_SW_FRAMESIZE                              0x0003008
+#define ACP_SW_SSP_COUNTER                            0x000300C
+#define ACP_SW_AUDIO_TX_EN                            0x0003010
+#define ACP_SW_AUDIO_TX_EN_STATUS                     0x0003014
+#define ACP_SW_AUDIO_TX_FRAME_FORMAT                  0x0003018
+#define ACP_SW_AUDIO_TX_SAMPLEINTERVAL                0x000301C
+#define ACP_SW_AUDIO_TX_HCTRL_DP0                     0x0003020
+#define ACP_SW_AUDIO_TX_HCTRL_DP1                     0x0003024
+#define ACP_SW_AUDIO_TX_HCTRL_DP2                     0x0003028
+#define ACP_SW_AUDIO_TX_HCTRL_DP3                     0x000302C
+#define ACP_SW_AUDIO_TX_OFFSET_DP0                    0x0003030
+#define ACP_SW_AUDIO_TX_OFFSET_DP1                    0x0003034
+#define ACP_SW_AUDIO_TX_OFFSET_DP2                    0x0003038
+#define ACP_SW_AUDIO_TX_OFFSET_DP3                    0x000303C
+#define ACP_SW_AUDIO_TX_CHANNEL_ENABLE_DP0            0x0003040
+#define ACP_SW_AUDIO_TX_CHANNEL_ENABLE_DP1            0x0003044
+#define ACP_SW_AUDIO_TX_CHANNEL_ENABLE_DP2            0x0003048
+#define ACP_SW_AUDIO_TX_CHANNEL_ENABLE_DP3            0x000304C
+#define ACP_SW_BT_TX_EN                               0x0003050
+#define ACP_SW_BT_TX_EN_STATUS                        0x0003054
+#define ACP_SW_BT_TX_FRAME_FORMAT                     0x0003058
+#define ACP_SW_BT_TX_SAMPLEINTERVAL                   0x000305C
+#define ACP_SW_BT_TX_HCTRL                            0x0003060
+#define ACP_SW_BT_TX_OFFSET                           0x0003064
+#define ACP_SW_BT_TX_CHANNEL_ENABLE_DP0               0x0003068
+#define ACP_SW_HEADSET_TX_EN                          0x000306C
+#define ACP_SW_HEADSET_TX_EN_STATUS                   0x0003070
+#define ACP_SW_HEADSET_TX_FRAME_FORMAT                0x0003074
+#define ACP_SW_HEADSET_TX_SAMPLEINTERVAL              0x0003078
+#define ACP_SW_HEADSET_TX_HCTRL                       0x000307C
+#define ACP_SW_HEADSET_TX_OFFSET                      0x0003080
+#define ACP_SW_HEADSET_TX_CHANNEL_ENABLE_DP0          0x0003084
+#define ACP_SW_AUDIO_RX_EN                            0x0003088
+#define ACP_SW_AUDIO_RX_EN_STATUS                     0x000308C
+#define ACP_SW_AUDIO_RX_FRAME_FORMAT                  0x0003090
+#define ACP_SW_AUDIO_RX_SAMPLEINTERVAL                0x0003094
+#define ACP_SW_AUDIO_RX_HCTRL_DP0                     0x0003098
+#define ACP_SW_AUDIO_RX_HCTRL_DP1                     0x000309C
+#define ACP_SW_AUDIO_RX_HCTRL_DP2                     0x0003100
+#define ACP_SW_AUDIO_RX_HCTRL_DP3                     0x0003104
+#define ACP_SW_AUDIO_RX_OFFSET_DP0                    0x0003108
+#define ACP_SW_AUDIO_RX_OFFSET_DP1                    0x000310C
+#define ACP_SW_AUDIO_RX_OFFSET_DP2                    0x0003110
+#define ACP_SW_AUDIO_RX_OFFSET_DP3                    0x0003114
+#define ACP_SW_AUDIO_RX_CHANNEL_ENABLE_DP0            0x0003118
+#define ACP_SW_AUDIO_RX_CHANNEL_ENABLE_DP1            0x000311C
+#define ACP_SW_AUDIO_RX_CHANNEL_ENABLE_DP2            0x0003120
+#define ACP_SW_AUDIO_RX_CHANNEL_ENABLE_DP3            0x0003124
+#define ACP_SW_BT_RX_EN                               0x0003128
+#define ACP_SW_BT_RX_EN_STATUS                        0x000312C
+#define ACP_SW_BT_RX_FRAME_FORMAT                     0x0003130
+#define ACP_SW_BT_RX_SAMPLEINTERVAL                   0x0003134
+#define ACP_SW_BT_RX_HCTRL                            0x0003138
+#define ACP_SW_BT_RX_OFFSET                           0x000313C
+#define ACP_SW_BT_RX_CHANNEL_ENABLE_DP0               0x0003140
+#define ACP_SW_HEADSET_RX_EN                          0x0003144
+#define ACP_SW_HEADSET_RX_EN_STATUS                   0x0003148
+#define ACP_SW_HEADSET_RX_FRAME_FORMAT                0x000314C
+#define ACP_SW_HEADSET_RX_SAMPLEINTERVAL              0x0003150
+#define ACP_SW_HEADSET_RX_HCTRL                       0x0003154
+#define ACP_SW_HEADSET_RX_OFFSET                      0x0003158
+#define ACP_SW_HEADSET_RX_CHANNEL_ENABLE_DP0          0x000315C
+#define ACP_SW_BPT_PORT_EN                            0x0003160
+#define ACP_SW_BPT_PORT_EN_STATUS                     0x0003164
+#define ACP_SW_BPT_PORT_FRAME_FORMAT                  0x0003168
+#define ACP_SW_BPT_PORT_SAMPLEINTERVAL                0x000316C
+#define ACP_SW_BPT_PORT_HCTRL                         0x0003170
+#define ACP_SW_BPT_PORT_OFFSET                        0x0003174
+#define ACP_SW_BPT_PORT_CHANNEL_ENABLE                0x0003178
+#define ACP_SW_BPT_PORT_FIRST_BYTE_ADDR               0x000317C
+#define ACP_SW_CLK_RESUME_CTRL                        0x0003180
+#define ACP_SW_CLK_RESUME_DELAY_CNTR                  0x0003184
+#define ACP_SW_BUS_RESET_CTRL                         0x0003188
+#define ACP_SW_PRBS_ERR_STATUS                        0x000318C
+#define SW_IMM_CMD_UPPER_WORD                         0x0003230
+#define SW_IMM_CMD_LOWER_QWORD                        0x0003234
+#define SW_IMM_RESP_UPPER_WORD                        0x0003238
+#define SW_IMM_RESP_LOWER_QWORD                       0x000323C
+#define SW_IMM_CMD_STS                                0x0003240
+#define SW_BRA_BASE_ADDRESS                           0x0003244
+#define SW_BRA_TRANSFER_SIZE                          0x0003248
+#define SW_BRA_DMA_BUSY                               0x000324C
+#define SW_BRA_RESP                                   0x0003250
+#define SW_BRA_RESP_FRAME_ADDR                        0x0003254
+#define SW_BRA_CURRENT_TRANSFER_SIZE                  0x0003258
+#define SW_STATE_CHANGE_STATUS_0TO7                   0x000325C
+#define SW_STATE_CHANGE_STATUS_8TO11                  0x0003260
+#define SW_STATE_CHANGE_STATUS_MASK_0TO7              0x0003264
+#define SW_STATE_CHANGE_STATUS_MASK_8TO11             0x0003268
+#define SW_CLK_FREQUENCY_CTRL                         0x000326C
+#define SW_ERROR_INTR_MASK                            0x0003270
+#define SW_PHY_TEST_MODE_DATA_OFF                     0x0003274
+
+#define ACP_P1_SW_EN                                  0x0003C00
+#define ACP_P1_SW_EN_STATUS                           0x0003C04
+#define ACP_P1_SW_FRAMESIZE                           0x0003C08
+#define ACP_P1_SW_SSP_COUNTER                         0x0003C0C
+#define ACP_P1_SW_BT_TX_EN                            0x0003C50
+#define ACP_P1_SW_BT_TX_EN_STATUS                     0x0003C54
+#define ACP_P1_SW_BT_TX_FRAME_FORMAT                  0x0003C58
+#define ACP_P1_SW_BT_TX_SAMPLEINTERVAL                0x0003C5C
+#define ACP_P1_SW_BT_TX_HCTRL                         0x0003C60
+#define ACP_P1_SW_BT_TX_OFFSET                        0x0003C64
+#define ACP_P1_SW_BT_TX_CHANNEL_ENABLE_DP0            0x0003C68
+#define ACP_P1_SW_BT_RX_EN                            0x0003D28
+#define ACP_P1_SW_BT_RX_EN_STATUS                     0x0003D2C
+#define ACP_P1_SW_BT_RX_FRAME_FORMAT                  0x0003D30
+#define ACP_P1_SW_BT_RX_SAMPLEINTERVAL                0x0003D34
+#define ACP_P1_SW_BT_RX_HCTRL                         0x0003D38
+#define ACP_P1_SW_BT_RX_OFFSET                        0x0003D3C
+#define ACP_P1_SW_BT_RX_CHANNEL_ENABLE_DP0            0x0003D40
+#define ACP_P1_SW_BPT_PORT_EN                         0x0003D60
+#define ACP_P1_SW_BPT_PORT_EN_STATUS                  0x0003D64
+#define ACP_P1_SW_BPT_PORT_FRAME_FORMAT               0x0003D68
+#define ACP_P1_SW_BPT_PORT_SAMPLEINTERVAL             0x0003D6C
+#define ACP_P1_SW_BPT_PORT_HCTRL                      0x0003D70
+#define ACP_P1_SW_BPT_PORT_OFFSET                     0x0003D74
+#define ACP_P1_SW_BPT_PORT_CHANNEL_ENABLE             0x0003D78
+#define ACP_P1_SW_BPT_PORT_FIRST_BYTE_ADDR            0x0003D7C
+#define ACP_P1_SW_CLK_RESUME_CTRL                     0x0003D80
+#define ACP_P1_SW_CLK_RESUME_DELAY_CNTR               0x0003D84
+#define ACP_P1_SW_BUS_RESET_CTRL                      0x0003D88
+#define ACP_P1_SW_PRBS_ERR_STATUS                     0x0003D8C
+
+#define P1_SW_IMM_CMD_UPPER_WORD                      0x0003E30
+#define P1_SW_IMM_CMD_LOWER_QWORD                     0x0003E34
+#define P1_SW_IMM_RESP_UPPER_WORD                     0x0003E38
+#define P1_SW_IMM_RESP_LOWER_QWORD                    0x0003E3C
+#define P1_SW_IMM_CMD_STS                             0x0003E40
+#define P1_SW_BRA_BASE_ADDRESS                        0x0003E44
+#define P1_SW_BRA_TRANSFER_SIZE                       0x0003E48
+#define P1_SW_BRA_DMA_BUSY                            0x0003E4C
+#define P1_SW_BRA_RESP                                0x0003E50
+#define P1_SW_BRA_RESP_FRAME_ADDR                     0x0003E54
+#define P1_SW_BRA_CURRENT_TRANSFER_SIZE               0x0003E58
+#define P1_SW_STATE_CHANGE_STATUS_0TO7                0x0003E5C
+#define P1_SW_STATE_CHANGE_STATUS_8TO11               0x0003E60
+#define P1_SW_STATE_CHANGE_STATUS_MASK_0TO7           0x0003E64
+#define P1_SW_STATE_CHANGE_STATUS_MASK_8TO11          0x0003E68
+#define P1_SW_CLK_FREQUENCY_CTRL                      0x0003E6C
+#define P1_SW_ERROR_INTR_MASK                         0x0003E70
+#define P1_SW_PHY_TEST_MODE_DATA_OFF                  0x0003E74
+
+#define ACP_PHY_BASE_ADDRESS		0x1240000
+#define AMD_DELAY_LOOP_ITERATION	1000
+#define AMD_SDW_DEFAULT_CLK_FREQ	12000000
+#define AMD_SDW_RETRY_COUNT		1000
+
+#define AMD_SDW_MCP_RESP_ACK		BIT(0)
+#define AMD_SDW_MCP_RESP_NACK		BIT(1)
+#define AMD_SDW_MCP_RESP_RDATA		GENMASK(14, 7)
+
+#define AMD_SDW_MCP_CMD_SSP_TAG			BIT(31)
+#define AMD_SDW_MCP_CMD_COMMAND			GENMASK(14, 12)
+#define AMD_SDW_MCP_CMD_DEV_ADDR		GENMASK(11, 8)
+#define AMD_SDW_MCP_CMD_REG_ADDR_HIGH		GENMASK(7, 0)
+#define AMD_SDW_MCP_CMD_REG_ADDR_LOW		GENMASK(31, 24)
+#define AMD_SDW_MCP_CMD_REG_DATA		GENMASK(14, 7)
+#define AMD_SDW_MCP_SLAVE_STAT_0_3		GENMASK(14, 7)
+#define AMD_SDW_MCP_SLAVE_STAT_4_11		GENMASK(39, 24)
+#define AMD_SDW_MCP_SLAVE_STATUS_MASK		GENMASK(1, 0)
+#define AMD_SDW_MCP_SLAVE_STATUS_BITS		GENMASK(3, 2)
+#define AMD_SDW_MCP_SLAVE_STATUS_8TO_11		GENMASK(15, 0)
+#define AMD_SDW_MCP_SLAVE_STATUS_VALID_MASK(x)  BIT(((x) * 4))
+#define AMD_SDW_MCP_SLAVE_STAT_SHIFT_MASK(x)	(((x) * 4) + 1)
+
+#define AMD_SDW_MASTER_SUSPEND_DELAY_MS		3000
+#define AMD_SDW_CLK_STOP_MAX_RETRY_COUNT	100
+#define AMD_SDW_QUIRK_MASK_BUS_ENABLE		BIT(0)
+
+#define AMD_SDW_IMM_RES_VALID		1
+#define AMD_SDW_IMM_CMD_BUSY		2
+#define AMD_SDW_ENABLE			1
+#define AMD_SDW_DISABLE			0
+#define AMD_SDW_BUS_RESET_CLEAR_REQ	0
+#define AMD_SDW_BUS_RESET_REQ		1
+#define AMD_SDW_BUS_RESET_DONE		2
+#define AMD_SDW_BUS_BASE_FREQ		24000000
+
+#define AMD_SDW0_EXT_INTR_MASK		0x200000
+#define AMD_SDW1_EXT_INTR_MASK		4
+#define AMD_SDW_IRQ_MASK_0TO7		0x77777777
+#define AMD_SDW_IRQ_MASK_8TO11		0x000D7777
+#define AMD_SDW_IRQ_ERROR_MASK		0xFF
+#define AMD_SDW_MAX_FREQ_NUM		1
+#define AMD_SDW0_MAX_TX_PORTS		3
+#define AMD_SDW0_MAX_RX_PORTS		3
+#define AMD_SDW1_MAX_TX_PORTS		1
+#define AMD_SDW1_MAX_RX_PORTS		1
+
+#define AMD_SDW_SLAVE_0_ATTACHED	5
+#define AMD_SDW_SSP_COUNTER_VAL	3
+
+#define AMD_DPN_FRAME_FMT_PFM			GENMASK(1, 0)
+#define AMD_DPN_FRAME_FMT_PDM			GENMASK(3, 2)
+#define AMD_DPN_FRAME_FMT_BLK_PKG_MODE		BIT(4)
+#define AMD_DPN_FRAME_FMT_BLK_GRP_CTRL		GENMASK(6, 5)
+#define AMD_DPN_FRAME_FMT_WORD_LEN		GENMASK(12, 7)
+#define AMD_DPN_FRAME_FMT_PCM_OR_PDM		BIT(13)
+#define AMD_DPN_HCTRL_HSTOP			GENMASK(3, 0)
+#define AMD_DPN_HCTRL_HSTART			GENMASK(7, 4)
+#define AMD_DPN_OFFSET_CTRL_1			GENMASK(7, 0)
+#define AMD_DPN_OFFSET_CTRL_2			GENMASK(15, 8)
+#define AMD_DPN_CH_EN_LCTRL			GENMASK(2, 0)
+#define AMD_DPN_CH_EN_CHMASK			GENMASK(10, 3)
+#define AMD_SDW_STAT_MAX_RETRY_COUNT		100
+#define AMD_SDW0_PAD_PULLDOWN_CTRL_ENABLE_MASK	0x7F9F
+#define AMD_SDW1_PAD_PULLDOWN_CTRL_ENABLE_MASK	0x7FFA
+#define AMD_SDW0_PAD_PULLDOWN_CTRL_DISABLE_MASK	0x60
+#define AMD_SDW1_PAD_PULLDOWN_CTRL_DISABLE_MASK	5
+#define AMD_SDW0_PAD_KEEPER_EN_MASK	1
+#define AMD_SDW1_PAD_KEEPER_EN_MASK	0x10
+#define AMD_SDW0_PAD_KEEPER_DISABLE_MASK        0x1E
+#define AMD_SDW1_PAD_KEEPER_DISABLE_MASK	0xF
+
+enum amd_sdw_channel {
+	/* SDW0 */
+	ACP_SDW0_AUDIO_TX = 0,
+	ACP_SDW0_BT_TX,
+	ACP_SDW0_HS_TX,
+	ACP_SDW0_AUDIO_RX,
+	ACP_SDW0_BT_RX,
+	ACP_SDW0_HS_RX,
+	/* SDW1 */
+	ACP_SDW1_BT_TX,
+	ACP_SDW1_BT_RX,
+};
+
+enum amd_sdw_cmd_type {
+	AMD_SDW_CMD_PING = 0,
+	AMD_SDW_CMD_READ = 2,
+	AMD_SDW_CMD_WRITE = 3,
+};
+
+static u32 amd_sdwc_freq_tbl[AMD_SDW_MAX_FREQ_NUM] = {
+	AMD_SDW_DEFAULT_CLK_FREQ,
+};
+
+struct sdw_transport_data {
+	int hstart;
+	int hstop;
+	int block_offset;
+	int sub_block_offset;
+};
+
+static inline u32 acp_reg_readl(void __iomem *base_addr)
+{
+	return readl(base_addr);
+}
+
+static inline void acp_reg_writel(u32 val, void __iomem *base_addr)
+{
+	writel(val, base_addr);
+}
+#endif
diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
index f0123815af46..5ec39f8c2f2e 100644
--- a/include/linux/soundwire/sdw_amd.h
+++ b/include/linux/soundwire/sdw_amd.h
@@ -10,9 +10,30 @@
 
 #define AMD_SDW_CLK_STOP_MODE		1
 #define AMD_SDW_POWER_OFF_MODE		2
+#define ACP_SDW0	0
+#define ACP_SDW1	1
+#define ACP_SDW0_MAX_DAI	6
 
 struct acp_sdw_pdata {
 	u16 instance;
 	struct mutex *sdw_lock;
 };
+
+struct amd_sdwc_ctrl {
+	struct sdw_bus bus;
+	struct device *dev;
+	void __iomem *mmio;
+	struct work_struct probe_work;
+	struct mutex *sdw_lock;
+	int num_din_ports;
+	int num_dout_ports;
+	int cols_index;
+	int rows_index;
+	u32 instance;
+	u32 quirks;
+	u32 wake_en_mask;
+	int num_ports;
+	bool startup_done;
+	u32 power_mode_mask;
+};
 #endif
-- 
2.34.1

