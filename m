Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EF46B4CDD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjCJQ0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjCJQ0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:26:12 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0805CC1A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:22:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZbkKCQ7/RBMPxMbCydTRi5EyfeX/E9DY57xNSm/KicyXQcBYBQydszM3OUlz73gWU9VYJ3wCew2oXuG+rMOQpFtp5wxqxf5dHHO2jmyK03FT7pirF8hI6XbXsU3Jo2t5rB0VBTiuHUDW+ugAcEvLOJnuZyUxP16k0XrSuqkKuvVlrCZmaQuEQkSuK8JcXbMZ2JOVSnJYm8gBmj4aEj8flDf53tP6FmtiGiPanrgq9qZXg+7kMuUjND0VK91CmZeDuaPwDet1ufmzwumb29MmYuq0IOLaQ6Q/8uYUBRtObNoRt0ZUDnv1iQSTPdmETny0xh7ujEA9PzXGfL4+1KIQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHVkkAtubX5ebZ8pNTb1+w1zLKdiP9GNrp6gbMCCH34=;
 b=Gy+coTpOv6Q/6x50K5cmbAs9UrqbozuvIh07C/TJqoqUYcxfxwqFacn2yZPDI5eN29St3SYa9AnsQit4+UqR3Ejdd2O6srL7N49Lo2wH/m3PsTnzkBtRcqYdtoUMTVQbfcaOqrkKTEn4IaDaiBlU8eOW8vRWiMXx6XfbPUBZVSzliw4Qs29vuF7/eYOP1sFNtnkxjAlCIevVTOXatygtotFtWS7OYZwhfja9g0Bk7mnFWTyFrLvlD4fqnNxlLNHWXCOlgqvOdU+SVXDxXIxlpWpLOtkBIB0jGvxvBqTknfkIHD/wNJaBaiFmAxeN5K3tNWSR0uwUYoDTY72YbKD52Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHVkkAtubX5ebZ8pNTb1+w1zLKdiP9GNrp6gbMCCH34=;
 b=LW1Jx503vyY+qNtJOGH6eEdtizDE5XzN+08/Ukyo6Z+/sJSlKrFW7YM6IBUrhy9+3+O7uJR1eBbvccV32CCh9PxPIvKq4BFDFx/uTdvKQ1V7KYqtAXjhEHvcnMG+zOHca9egb/C8qB0Yq36sbp0tdfTxDgChoCIKU0KOAWR+aEw=
Received: from DM6PR13CA0048.namprd13.prod.outlook.com (2603:10b6:5:134::25)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 16:22:11 +0000
Received: from DS1PEPF0000E63C.namprd02.prod.outlook.com
 (2603:10b6:5:134:cafe::1e) by DM6PR13CA0048.outlook.office365.com
 (2603:10b6:5:134::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Fri, 10 Mar 2023 16:22:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000E63C.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 16:22:11 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 10:22:10 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 10:22:10 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Fri, 10 Mar 2023 10:22:06 -0600
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <vkoul@kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <pierre-louis.bossart@linux.intel.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>, <amadeuszx.slawinski@linux.intel.com>,
        <Mastan.Katragadda@amd.com>, <Arungopal.kondaveeti@amd.com>,
        <claudiu.beznea@microchip.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V7 2/8] soundwire: amd: Add support for AMD Manager driver
Date:   Fri, 10 Mar 2023 21:55:48 +0530
Message-ID: <20230310162554.699766-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310162554.699766-1-Vijendar.Mukunda@amd.com>
References: <20230310162554.699766-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63C:EE_|DM6PR12MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b9733d-3a7f-43c5-d24f-08db21839a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B+pajG39kOQ0RD/lDh0Ch4x41PjhnkT2FJa801SLMdcMkuy9pDrUNZex+Bkmu8yem8Tl5hF8rF5zFcEkjFStHTPaBtqBKTGCp5dprHhFycZmUJexzY564Eh8M9PEsbrmpr9Enamy5S+QUqLc7adkyRYIvIJ+G1voaxP7SaWOo6FM9VEBfX0Q/dGMEmWV5157B/3XN+f//+H5EZFHgtnnpwykEE0CmxGlWnz9iUHIrgOc1pS8QEnB24/nTYHrObg0NWLaQlW2gbgs9VZmvdD8BoAUu3aSYSSCMsy2s3Fd3WR7UAjyMXhWr90u1SiczPSaQFd0ttUgX/hGvv1wS7P9KjzofoHM7LgjhIe72BG2qpnnE7dVmDwfzZ4BRbR/n70s6Q6J9rBT5UOOTNB9EFRGpTovdLEHww1zuax66UboEBvwTBLDBn3XSqOOuVU5bD6ESKUGKNIrB+LkD+hl8aPsHNrmqE8+MH9BInEW4YU+A6krvRCckorslfm+SYDdi1jsG9sRkcJ7Ou0W5yTGiUL3rdfCdcNWgq+URnNBvkUpkpgWMAqV0gWD02XwUM2caFT/ZfATC7JD5bypzHZnNCx1+j5EY4fxsIzTTQenp4dxIojtzU6DCv80BKA41D3bEIfh4pRAS/AQI4ZD1nx3zc7Yq/G6iwJvdSHFKmHTBTzEtBEycIYNHc/bXrVpqhan/y7LTcGT+WaHj2sE5M9v/c1Z6LWKCB+m8P8t1UhMQA0P+2Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199018)(40470700004)(46966006)(36840700001)(8936002)(30864003)(36756003)(5660300002)(26005)(1076003)(82740400003)(36860700001)(81166007)(186003)(82310400005)(336012)(40460700003)(426003)(47076005)(83380400001)(2616005)(8676002)(86362001)(316002)(54906003)(4326008)(70586007)(41300700001)(6916009)(6666004)(356005)(7696005)(40480700001)(478600001)(70206006)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 16:22:11.2550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b9733d-3a7f-43c5-d24f-08db21839a20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD ACP(v6.x) IP block has two SoundWire manager devices.
Add support for
  - Manager driver probe & remove sequence
  - Helper functions to enable/disable interrupts,
    Initialize sdw manager, enable sdw pads
  - Manager driver sdw_master_ops & port_ops callbacks

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.c   | 698 ++++++++++++++++++++++++++++++
 drivers/soundwire/amd_manager.h   | 251 +++++++++++
 include/linux/soundwire/sdw_amd.h |  67 +++
 3 files changed, 1016 insertions(+)
 create mode 100644 drivers/soundwire/amd_manager.c
 create mode 100644 drivers/soundwire/amd_manager.h
 create mode 100644 include/linux/soundwire/sdw_amd.h

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
new file mode 100644
index 000000000000..180c2d5943e1
--- /dev/null
+++ b/drivers/soundwire/amd_manager.c
@@ -0,0 +1,698 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SoundWire AMD Manager driver
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
+#include <linux/wait.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include "bus.h"
+#include "amd_manager.h"
+
+#define DRV_NAME "amd_sdw_manager"
+
+#define to_amd_sdw(b)	container_of(b, struct amd_sdw_manager, bus)
+
+static void amd_enable_sdw_pads(struct amd_sdw_manager *amd_manager)
+{
+	u32 sw_pad_pulldown_val;
+	u32 val;
+
+	mutex_lock(amd_manager->acp_sdw_lock);
+	val = acp_reg_readl(amd_manager->acp_mmio + ACP_SW_PAD_KEEPER_EN);
+	val |= amd_manager->reg_mask->sw_pad_enable_mask;
+	acp_reg_writel(val, amd_manager->acp_mmio + ACP_SW_PAD_KEEPER_EN);
+	usleep_range(1000, 1500);
+
+	sw_pad_pulldown_val = acp_reg_readl(amd_manager->acp_mmio + ACP_PAD_PULLDOWN_CTRL);
+	sw_pad_pulldown_val &= amd_manager->reg_mask->sw_pad_pulldown_mask;
+	acp_reg_writel(sw_pad_pulldown_val, amd_manager->acp_mmio + ACP_PAD_PULLDOWN_CTRL);
+	mutex_unlock(amd_manager->acp_sdw_lock);
+}
+
+static int amd_init_sdw_manager(struct amd_sdw_manager *amd_manager)
+{
+	u32 val;
+	int ret;
+
+	acp_reg_writel(AMD_SDW_ENABLE, amd_manager->mmio + ACP_SW_EN);
+	ret = read_poll_timeout(acp_reg_readl, val, val, ACP_DELAY_US, AMD_SDW_TIMEOUT, false,
+				amd_manager->mmio + ACP_SW_EN_STATUS);
+	if (ret)
+		return ret;
+
+	/* SoundWire manager bus reset */
+	acp_reg_writel(AMD_SDW_BUS_RESET_REQ, amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
+	ret = read_poll_timeout(acp_reg_readl, val, (val & AMD_SDW_BUS_RESET_DONE), ACP_DELAY_US,
+				AMD_SDW_TIMEOUT, false, amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
+	if (ret)
+		return ret;
+
+	acp_reg_writel(AMD_SDW_BUS_RESET_CLEAR_REQ, amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
+	ret = read_poll_timeout(acp_reg_readl, val, !val, ACP_DELAY_US, AMD_SDW_TIMEOUT, false,
+				amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
+	if (ret) {
+		dev_err(amd_manager->dev, "Failed to reset SoundWire manager instance%d\n",
+			amd_manager->instance);
+		return ret;
+	}
+
+	acp_reg_writel(AMD_SDW_DISABLE, amd_manager->mmio + ACP_SW_EN);
+	return read_poll_timeout(acp_reg_readl, val, !val, ACP_DELAY_US, AMD_SDW_TIMEOUT, false,
+				 amd_manager->mmio + ACP_SW_EN_STATUS);
+}
+
+static int amd_enable_sdw_manager(struct amd_sdw_manager *amd_manager)
+{
+	u32 val;
+
+	acp_reg_writel(AMD_SDW_ENABLE, amd_manager->mmio + ACP_SW_EN);
+	return read_poll_timeout(acp_reg_readl, val, val, ACP_DELAY_US, AMD_SDW_TIMEOUT, false,
+				 amd_manager->mmio + ACP_SW_EN_STATUS);
+}
+
+static int amd_disable_sdw_manager(struct amd_sdw_manager *amd_manager)
+{
+	u32 val;
+
+	acp_reg_writel(AMD_SDW_DISABLE, amd_manager->mmio + ACP_SW_EN);
+	/*
+	 * After invoking manager disable sequence, check whether
+	 * manager has executed clock stop sequence. In this case,
+	 * manager should ignore checking enable status register.
+	 */
+	val = acp_reg_readl(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
+	if (val)
+		return 0;
+	return read_poll_timeout(acp_reg_readl, val, !val, ACP_DELAY_US, AMD_SDW_TIMEOUT, false,
+				 amd_manager->mmio + ACP_SW_EN_STATUS);
+}
+
+static void amd_enable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
+{
+	struct sdw_manager_reg_mask *reg_mask = amd_manager->reg_mask;
+	u32 val;
+
+	mutex_lock(amd_manager->acp_sdw_lock);
+	val = acp_reg_readl(amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
+	val |= reg_mask->acp_sdw_intr_mask;
+	acp_reg_writel(val, amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
+	mutex_unlock(amd_manager->acp_sdw_lock);
+
+	acp_reg_writel(AMD_SDW_IRQ_MASK_0TO7, amd_manager->mmio +
+		       ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
+	acp_reg_writel(AMD_SDW_IRQ_MASK_8TO11, amd_manager->mmio +
+		       ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
+	acp_reg_writel(AMD_SDW_IRQ_ERROR_MASK, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
+}
+
+static void amd_disable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
+{
+	struct sdw_manager_reg_mask *reg_mask = amd_manager->reg_mask;
+	u32 val;
+
+	mutex_lock(amd_manager->acp_sdw_lock);
+	val = acp_reg_readl(amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
+	val &= ~reg_mask->acp_sdw_intr_mask;
+	acp_reg_writel(val, amd_manager->acp_mmio + ACP_EXTERNAL_INTR_CNTL(amd_manager->instance));
+	mutex_unlock(amd_manager->acp_sdw_lock);
+
+	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
+	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
+	acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
+}
+
+static void amd_sdw_set_frameshape(struct amd_sdw_manager *amd_manager)
+{
+	u32 frame_size;
+
+	frame_size = (amd_manager->rows_index << 3) | amd_manager->cols_index;
+	acp_reg_writel(frame_size, amd_manager->mmio + ACP_SW_FRAMESIZE);
+}
+
+static void amd_sdw_ctl_word_prep(u32 *lower_word, u32 *upper_word, u32 cmd_type,
+				  struct sdw_msg *msg, int cmd_offset)
+{
+	u32 upper_data;
+	u32 lower_data = 0;
+	u16 addr;
+	u8 upper_addr, lower_addr;
+	u8 data = 0;
+
+	addr = msg->addr + cmd_offset;
+	upper_addr = (addr & 0xFF00) >> 8;
+	lower_addr = addr & 0xFF;
+
+	if (cmd_type == AMD_SDW_CMD_WRITE)
+		data = msg->buf[cmd_offset];
+
+	upper_data = FIELD_PREP(AMD_SDW_MCP_CMD_DEV_ADDR, msg->dev_num);
+	upper_data |= FIELD_PREP(AMD_SDW_MCP_CMD_COMMAND, cmd_type);
+	upper_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_ADDR_HIGH, upper_addr);
+	lower_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_ADDR_LOW, lower_addr);
+	lower_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_DATA, data);
+
+	*upper_word = upper_data;
+	*lower_word = lower_data;
+}
+
+static u64 amd_sdw_send_cmd_get_resp(struct amd_sdw_manager *amd_manager, u32 lower_data,
+				     u32 upper_data)
+{
+	u64 resp;
+	u32 lower_resp, upper_resp;
+	u32 sts;
+	int ret;
+
+	ret = read_poll_timeout(acp_reg_readl, sts, !(sts & AMD_SDW_IMM_CMD_BUSY), ACP_DELAY_US,
+				AMD_SDW_TIMEOUT, false, amd_manager->mmio + ACP_SW_IMM_CMD_STS);
+	if (ret) {
+		dev_err(amd_manager->dev, "SDW%x previous cmd status clear failed\n",
+			amd_manager->instance);
+		return ret;
+	}
+
+	if (sts & AMD_SDW_IMM_RES_VALID) {
+		dev_err(amd_manager->dev, "SDW%x manager is in bad state\n", amd_manager->instance);
+		acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_IMM_CMD_STS);
+	}
+	acp_reg_writel(upper_data, amd_manager->mmio + ACP_SW_IMM_CMD_UPPER_WORD);
+	acp_reg_writel(lower_data, amd_manager->mmio + ACP_SW_IMM_CMD_LOWER_QWORD);
+
+	ret = read_poll_timeout(acp_reg_readl, sts, (sts & AMD_SDW_IMM_RES_VALID), ACP_DELAY_US,
+				AMD_SDW_TIMEOUT, false, amd_manager->mmio + ACP_SW_IMM_CMD_STS);
+	if (ret) {
+		dev_err(amd_manager->dev, "SDW%x cmd response timeout occurred\n",
+			amd_manager->instance);
+		return ret;
+	}
+	upper_resp = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_RESP_UPPER_WORD);
+	lower_resp = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_RESP_LOWER_QWORD);
+
+	acp_reg_writel(AMD_SDW_IMM_RES_VALID, amd_manager->mmio + ACP_SW_IMM_CMD_STS);
+	ret = read_poll_timeout(acp_reg_readl, sts, !(sts & AMD_SDW_IMM_RES_VALID), ACP_DELAY_US,
+				AMD_SDW_TIMEOUT, false, amd_manager->mmio + ACP_SW_IMM_CMD_STS);
+	if (ret) {
+		dev_err(amd_manager->dev, "SDW%x cmd status retry failed\n",
+			amd_manager->instance);
+		return ret;
+	}
+	resp = upper_resp;
+	resp = (resp << 32) | lower_resp;
+	return resp;
+}
+
+static enum sdw_command_response
+amd_program_scp_addr(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg)
+{
+	struct sdw_msg scp_msg = {0};
+	u64 response_buf[2] = {0};
+	u32 upper_data = 0, lower_data = 0;
+	int nack = 0, no_ack = 0;
+	int index, timeout = 0;
+
+	scp_msg.dev_num = msg->dev_num;
+	scp_msg.addr = SDW_SCP_ADDRPAGE1;
+	scp_msg.buf = &msg->addr_page1;
+	amd_sdw_ctl_word_prep(&lower_data, &upper_data, AMD_SDW_CMD_WRITE, &scp_msg, 0);
+	response_buf[0] = amd_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data);
+	scp_msg.addr = SDW_SCP_ADDRPAGE2;
+	scp_msg.buf = &msg->addr_page2;
+	amd_sdw_ctl_word_prep(&lower_data, &upper_data, AMD_SDW_CMD_WRITE, &scp_msg, 0);
+	response_buf[1] = amd_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data);
+
+	for (index = 0; index < 2; index++) {
+		if (response_buf[index] == -ETIMEDOUT) {
+			dev_err(amd_manager->dev, "Program SCP cmd timeout\n");
+			timeout = 1;
+		} else if (!(response_buf[index] & AMD_SDW_MCP_RESP_ACK)) {
+			no_ack = 1;
+			if (response_buf[index] & AMD_SDW_MCP_RESP_NACK) {
+				nack = 1;
+				dev_err(amd_manager->dev, "Program SCP NACK received\n");
+			}
+		}
+	}
+
+	if (timeout) {
+		dev_err_ratelimited(amd_manager->dev,
+				    "SCP_addrpage command timeout for Slave %d\n", msg->dev_num);
+		return SDW_CMD_TIMEOUT;
+	}
+
+	if (nack) {
+		dev_err_ratelimited(amd_manager->dev,
+				    "SCP_addrpage NACKed for Slave %d\n", msg->dev_num);
+		return SDW_CMD_FAIL;
+	}
+
+	if (no_ack) {
+		dev_dbg_ratelimited(amd_manager->dev,
+				    "SCP_addrpage ignored for Slave %d\n", msg->dev_num);
+		return SDW_CMD_IGNORED;
+	}
+	return SDW_CMD_OK;
+}
+
+static int amd_prep_msg(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg, int *cmd)
+{
+	int ret;
+
+	if (msg->page) {
+		ret = amd_program_scp_addr(amd_manager, msg);
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
+		dev_err(amd_manager->dev, "Invalid msg cmd: %d\n", msg->flags);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static enum sdw_command_response amd_sdw_fill_msg_resp(struct amd_sdw_manager *amd_manager,
+						       struct sdw_msg *msg, u64 response,
+						       int offset)
+{
+	int nack = 0, no_ack = 0;
+	int timeout = 0;
+
+	if (response & AMD_SDW_MCP_RESP_ACK) {
+		if (msg->flags == SDW_MSG_FLAG_READ)
+			msg->buf[offset] = FIELD_GET(AMD_SDW_MCP_RESP_RDATA, response);
+	} else {
+		no_ack = 1;
+		if (response == -ETIMEDOUT) {
+			timeout = 1;
+		} else if (response & AMD_SDW_MCP_RESP_NACK) {
+			nack = 1;
+			dev_err(amd_manager->dev, "Program SCP NACK received\n");
+		}
+	}
+
+	if (timeout) {
+		dev_err_ratelimited(amd_manager->dev, "command timeout for Slave %d\n",
+				    msg->dev_num);
+		return SDW_CMD_TIMEOUT;
+	}
+	if (nack) {
+		dev_err_ratelimited(amd_manager->dev,
+				    "command response NACK received for Slave %d\n", msg->dev_num);
+		return SDW_CMD_FAIL;
+	}
+
+	if (no_ack) {
+		dev_err_ratelimited(amd_manager->dev, "command is ignored for Slave %d\n",
+				    msg->dev_num);
+		return SDW_CMD_IGNORED;
+	}
+	return SDW_CMD_OK;
+}
+
+static unsigned int _amd_sdw_xfer_msg(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg,
+				      int cmd, int cmd_offset)
+{
+	u64 response;
+	u32 upper_data = 0, lower_data = 0;
+
+	amd_sdw_ctl_word_prep(&lower_data, &upper_data, cmd, msg, cmd_offset);
+	response = amd_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data);
+	return amd_sdw_fill_msg_resp(amd_manager, msg, response, cmd_offset);
+}
+
+static enum sdw_command_response amd_sdw_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg)
+{
+	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
+	int ret, i;
+	int cmd = 0;
+
+	ret = amd_prep_msg(amd_manager, msg, &cmd);
+	if (ret)
+		return SDW_CMD_FAIL_OTHER;
+	for (i = 0; i < msg->len; i++) {
+		ret = _amd_sdw_xfer_msg(amd_manager, msg, cmd, i);
+		if (ret)
+			return ret;
+	}
+	return SDW_CMD_OK;
+}
+
+static u32 amd_sdw_read_ping_status(struct sdw_bus *bus)
+{
+	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
+	u64 response;
+	u32 slave_stat;
+
+	response = amd_sdw_send_cmd_get_resp(amd_manager, 0, 0);
+	/* slave status from ping response */
+	slave_stat = FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_0_3, response);
+	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_4_11, response) << 8;
+	dev_dbg(amd_manager->dev, "slave_stat:0x%x\n", slave_stat);
+	return slave_stat;
+}
+
+static int amd_sdw_compute_params(struct sdw_bus *bus)
+{
+	struct sdw_transport_data t_data = {0};
+	struct sdw_master_runtime *m_rt;
+	struct sdw_port_runtime *p_rt;
+	struct sdw_bus_params *b_params = &bus->params;
+	int port_bo, hstart, hstop, sample_int;
+	unsigned int rate, bps;
+
+	port_bo = 0;
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
+		sdw_compute_slave_ports(m_rt, &t_data);
+	}
+	return 0;
+}
+
+static int amd_sdw_port_params(struct sdw_bus *bus, struct sdw_port_params *p_params,
+			       unsigned int bank)
+{
+	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
+	u32 frame_fmt_reg, dpn_frame_fmt;
+
+	dev_dbg(amd_manager->dev, "p_params->num:0x%x\n", p_params->num);
+	switch (amd_manager->instance) {
+	case ACP_SDW0:
+		frame_fmt_reg = sdw0_manager_dp_reg[p_params->num].frame_fmt_reg;
+		break;
+	case ACP_SDW1:
+		frame_fmt_reg = sdw1_manager_dp_reg[p_params->num].frame_fmt_reg;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	dpn_frame_fmt = acp_reg_readl(amd_manager->mmio + frame_fmt_reg);
+	u32p_replace_bits(&dpn_frame_fmt, p_params->flow_mode, AMD_DPN_FRAME_FMT_PFM);
+	u32p_replace_bits(&dpn_frame_fmt, p_params->data_mode, AMD_DPN_FRAME_FMT_PDM);
+	u32p_replace_bits(&dpn_frame_fmt, p_params->bps - 1, AMD_DPN_FRAME_FMT_WORD_LEN);
+	acp_reg_writel(dpn_frame_fmt, amd_manager->mmio + frame_fmt_reg);
+	return 0;
+}
+
+static int amd_sdw_transport_params(struct sdw_bus *bus,
+				    struct sdw_transport_params *params,
+				    enum sdw_reg_bank bank)
+{
+	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
+	u32 dpn_frame_fmt;
+	u32 dpn_sampleinterval;
+	u32 dpn_hctrl;
+	u32 dpn_offsetctrl;
+	u32 dpn_lanectrl;
+	u32 frame_fmt_reg, sample_int_reg, hctrl_dp0_reg;
+	u32 offset_reg, lane_ctrl_ch_en_reg;
+
+	switch (amd_manager->instance) {
+	case ACP_SDW0:
+		frame_fmt_reg = sdw0_manager_dp_reg[params->port_num].frame_fmt_reg;
+		sample_int_reg = sdw0_manager_dp_reg[params->port_num].sample_int_reg;
+		hctrl_dp0_reg = sdw0_manager_dp_reg[params->port_num].hctrl_dp0_reg;
+		offset_reg = sdw0_manager_dp_reg[params->port_num].offset_reg;
+		lane_ctrl_ch_en_reg = sdw0_manager_dp_reg[params->port_num].lane_ctrl_ch_en_reg;
+		break;
+	case ACP_SDW1:
+		frame_fmt_reg = sdw1_manager_dp_reg[params->port_num].frame_fmt_reg;
+		sample_int_reg = sdw1_manager_dp_reg[params->port_num].sample_int_reg;
+		hctrl_dp0_reg = sdw1_manager_dp_reg[params->port_num].hctrl_dp0_reg;
+		offset_reg = sdw1_manager_dp_reg[params->port_num].offset_reg;
+		lane_ctrl_ch_en_reg = sdw1_manager_dp_reg[params->port_num].lane_ctrl_ch_en_reg;
+		break;
+	default:
+		return -EINVAL;
+	}
+	acp_reg_writel(AMD_SDW_SSP_COUNTER_VAL, amd_manager->mmio + ACP_SW_SSP_COUNTER);
+
+	dpn_frame_fmt = acp_reg_readl(amd_manager->mmio + frame_fmt_reg);
+	u32p_replace_bits(&dpn_frame_fmt, params->blk_pkg_mode, AMD_DPN_FRAME_FMT_BLK_PKG_MODE);
+	u32p_replace_bits(&dpn_frame_fmt, params->blk_grp_ctrl, AMD_DPN_FRAME_FMT_BLK_GRP_CTRL);
+	u32p_replace_bits(&dpn_frame_fmt, SDW_STREAM_PCM, AMD_DPN_FRAME_FMT_PCM_OR_PDM);
+	acp_reg_writel(dpn_frame_fmt, amd_manager->mmio + frame_fmt_reg);
+
+	dpn_sampleinterval = params->sample_interval - 1;
+	acp_reg_writel(dpn_sampleinterval, amd_manager->mmio + sample_int_reg);
+
+	dpn_hctrl = FIELD_PREP(AMD_DPN_HCTRL_HSTOP, params->hstop);
+	dpn_hctrl |= FIELD_PREP(AMD_DPN_HCTRL_HSTART, params->hstart);
+	acp_reg_writel(dpn_hctrl, amd_manager->mmio + hctrl_dp0_reg);
+
+	dpn_offsetctrl = FIELD_PREP(AMD_DPN_OFFSET_CTRL_1, params->offset1);
+	dpn_offsetctrl |= FIELD_PREP(AMD_DPN_OFFSET_CTRL_2, params->offset2);
+	acp_reg_writel(dpn_offsetctrl, amd_manager->mmio + offset_reg);
+
+	/*
+	 * lane_ctrl_ch_en_reg will be used to program lane_ctrl and ch_mask
+	 * parameters.
+	 */
+	dpn_lanectrl = acp_reg_readl(amd_manager->mmio + lane_ctrl_ch_en_reg);
+	u32p_replace_bits(&dpn_lanectrl, params->lane_ctrl, AMD_DPN_CH_EN_LCTRL);
+	acp_reg_writel(dpn_lanectrl, amd_manager->mmio + lane_ctrl_ch_en_reg);
+	return 0;
+}
+
+static int amd_sdw_port_enable(struct sdw_bus *bus,
+			       struct sdw_enable_ch *enable_ch,
+			       unsigned int bank)
+{
+	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
+	u32 dpn_ch_enable;
+	u32 lane_ctrl_ch_en_reg;
+
+	switch (amd_manager->instance) {
+	case ACP_SDW0:
+		lane_ctrl_ch_en_reg = sdw0_manager_dp_reg[enable_ch->port_num].lane_ctrl_ch_en_reg;
+		break;
+	case ACP_SDW1:
+		lane_ctrl_ch_en_reg = sdw1_manager_dp_reg[enable_ch->port_num].lane_ctrl_ch_en_reg;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * lane_ctrl_ch_en_reg will be used to program lane_ctrl and ch_mask
+	 * parameters.
+	 */
+	dpn_ch_enable = acp_reg_readl(amd_manager->mmio + lane_ctrl_ch_en_reg);
+	u32p_replace_bits(&dpn_ch_enable, enable_ch->ch_mask, AMD_DPN_CH_EN_CHMASK);
+	if (enable_ch->enable)
+		acp_reg_writel(dpn_ch_enable, amd_manager->mmio + lane_ctrl_ch_en_reg);
+	else
+		acp_reg_writel(0, amd_manager->mmio + lane_ctrl_ch_en_reg);
+	return 0;
+}
+
+static int sdw_master_read_amd_prop(struct sdw_bus *bus)
+{
+	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
+	struct fwnode_handle *link;
+	struct sdw_master_prop *prop;
+	u32 quirk_mask = 0;
+	u32 wake_en_mask = 0;
+	u32 power_mode_mask = 0;
+	char name[32];
+
+	prop = &bus->prop;
+	/* Find manager handle */
+	snprintf(name, sizeof(name), "mipi-sdw-link-%d-subproperties", bus->link_id);
+	link = device_get_named_child_node(bus->dev, name);
+	if (!link) {
+		dev_err(bus->dev, "Manager node %s not found\n", name);
+		return -EIO;
+	}
+	fwnode_property_read_u32(link, "amd-sdw-enable", &quirk_mask);
+	if (!(quirk_mask & AMD_SDW_QUIRK_MASK_BUS_ENABLE))
+		prop->hw_disabled = true;
+	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH |
+		       SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY;
+
+	fwnode_property_read_u32(link, "amd-sdw-wakeup-enable", &wake_en_mask);
+	amd_manager->wake_en_mask = wake_en_mask;
+	fwnode_property_read_u32(link, "amd-sdw-power-mode", &power_mode_mask);
+	amd_manager->power_mode_mask = power_mode_mask;
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
+static const struct sdw_master_port_ops amd_sdw_port_ops = {
+	.dpn_set_port_params = amd_sdw_port_params,
+	.dpn_set_port_transport_params = amd_sdw_transport_params,
+	.dpn_port_enable_ch = amd_sdw_port_enable,
+};
+
+static const struct sdw_master_ops amd_sdw_ops = {
+	.read_prop = amd_prop_read,
+	.xfer_msg = amd_sdw_xfer_msg,
+	.read_ping_status = amd_sdw_read_ping_status,
+};
+
+static void amd_sdw_probe_work(struct work_struct *work)
+{
+	struct amd_sdw_manager *amd_manager = container_of(work, struct amd_sdw_manager,
+							   probe_work);
+	struct sdw_master_prop *prop;
+	int ret;
+
+	prop = &amd_manager->bus.prop;
+	if (!prop->hw_disabled) {
+		amd_enable_sdw_pads(amd_manager);
+		ret = amd_init_sdw_manager(amd_manager);
+		if (ret)
+			return;
+		amd_enable_sdw_interrupts(amd_manager);
+		ret = amd_enable_sdw_manager(amd_manager);
+		if (ret)
+			return;
+		amd_sdw_set_frameshape(amd_manager);
+	}
+}
+
+static int amd_sdw_manager_probe(struct platform_device *pdev)
+{
+	const struct acp_sdw_pdata *pdata = pdev->dev.platform_data;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	struct sdw_master_prop *prop;
+	struct sdw_bus_params *params;
+	struct amd_sdw_manager *amd_manager;
+	int ret;
+
+	amd_manager = devm_kzalloc(dev, sizeof(struct amd_sdw_manager), GFP_KERNEL);
+	if (!amd_manager)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENOMEM;
+
+	amd_manager->acp_mmio = devm_ioremap(dev, res->start, resource_size(res));
+	if (IS_ERR(amd_manager->mmio)) {
+		dev_err(dev, "mmio not found\n");
+		return PTR_ERR(amd_manager->mmio);
+	}
+	amd_manager->instance = pdata->instance;
+	amd_manager->mmio = amd_manager->acp_mmio +
+			    (amd_manager->instance * SDW_MANAGER_REG_OFFSET);
+	amd_manager->acp_sdw_lock = pdata->acp_sdw_lock;
+	amd_manager->cols_index = sdw_find_col_index(AMD_SDW_DEFAULT_COLUMNS);
+	amd_manager->rows_index = sdw_find_row_index(AMD_SDW_DEFAULT_ROWS);
+	amd_manager->dev = dev;
+	amd_manager->bus.ops = &amd_sdw_ops;
+	amd_manager->bus.port_ops = &amd_sdw_port_ops;
+	amd_manager->bus.compute_params = &amd_sdw_compute_params;
+	amd_manager->bus.clk_stop_timeout = 200;
+	amd_manager->bus.link_id = amd_manager->instance;
+	switch (amd_manager->instance) {
+	case ACP_SDW0:
+		amd_manager->num_dout_ports = AMD_SDW0_MAX_TX_PORTS;
+		amd_manager->num_din_ports = AMD_SDW0_MAX_RX_PORTS;
+		break;
+	case ACP_SDW1:
+		amd_manager->num_dout_ports = AMD_SDW1_MAX_TX_PORTS;
+		amd_manager->num_din_ports = AMD_SDW1_MAX_RX_PORTS;
+		break;
+	default:
+		return -EINVAL;
+	}
+	amd_manager->reg_mask = &sdw_manager_reg_mask_array[amd_manager->instance];
+	params = &amd_manager->bus.params;
+	params->max_dr_freq = AMD_SDW_DEFAULT_CLK_FREQ * 2;
+	params->curr_dr_freq = AMD_SDW_DEFAULT_CLK_FREQ * 2;
+	params->col = AMD_SDW_DEFAULT_COLUMNS;
+	params->row = AMD_SDW_DEFAULT_ROWS;
+	prop = &amd_manager->bus.prop;
+	prop->clk_freq = &amd_sdw_freq_tbl[0];
+	prop->mclk_freq = AMD_SDW_BUS_BASE_FREQ;
+
+	ret = sdw_bus_master_add(&amd_manager->bus, dev, dev->fwnode);
+	if (ret) {
+		dev_err(dev, "Failed to register SoundWire manager(%d)\n", ret);
+		return ret;
+	}
+	dev_set_drvdata(dev, amd_manager);
+	INIT_WORK(&amd_manager->probe_work, amd_sdw_probe_work);
+	/*
+	 * Instead of having lengthy probe sequence, use deferred probe.
+	 */
+	schedule_work(&amd_manager->probe_work);
+	return 0;
+}
+
+static int amd_sdw_manager_remove(struct platform_device *pdev)
+{
+	struct amd_sdw_manager *amd_manager = dev_get_drvdata(&pdev->dev);
+
+	cancel_work_sync(&amd_manager->probe_work);
+	amd_disable_sdw_interrupts(amd_manager);
+	sdw_bus_master_delete(&amd_manager->bus);
+	return amd_disable_sdw_manager(amd_manager);
+}
+
+static struct platform_driver amd_sdw_driver = {
+	.probe	= &amd_sdw_manager_probe,
+	.remove = &amd_sdw_manager_remove,
+	.driver = {
+		.name	= "amd_sdw_manager",
+	}
+};
+module_platform_driver(amd_sdw_driver);
+
+MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
+MODULE_DESCRIPTION("AMD SoundWire driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
new file mode 100644
index 000000000000..0d4b8653877e
--- /dev/null
+++ b/drivers/soundwire/amd_manager.h
@@ -0,0 +1,251 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2023 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#ifndef __AMD_MANAGER_H
+#define __AMD_MANAGER_H
+
+#include <linux/soundwire/sdw_amd.h>
+
+#define SDW_MANAGER_REG_OFFSET				0xC00
+#define AMD_SDW_DEFAULT_ROWS				50
+#define AMD_SDW_DEFAULT_COLUMNS				10
+#define ACP_PAD_PULLDOWN_CTRL				0x0001448
+#define ACP_SW_PAD_KEEPER_EN				0x0001454
+#define ACP_SW0_WAKE_EN					0x0001458
+#define ACP_EXTERNAL_INTR_CNTL0				0x0001A04
+#define ACP_EXTERNAL_INTR_STAT0				0x0001A0C
+#define ACP_EXTERNAL_INTR_CNTL(i)			(ACP_EXTERNAL_INTR_CNTL0 + ((i) * 4))
+#define ACP_EXTERNAL_INTR_STAT(i)			(ACP_EXTERNAL_INTR_STAT0 + ((i) * 4))
+#define ACP_SW_WAKE_EN(i)				(ACP_SW0_WAKE_EN + ((i) * 8))
+
+#define ACP_SW_EN					0x0003000
+#define ACP_SW_EN_STATUS				0x0003004
+#define ACP_SW_FRAMESIZE				0x0003008
+#define ACP_SW_SSP_COUNTER				0x000300C
+#define ACP_SW_AUDIO0_TX_EN				0x0003010
+#define ACP_SW_AUDIO0_TX_EN_STATUS			0x0003014
+#define ACP_SW_AUDIO0_TX_FRAME_FORMAT			0x0003018
+#define ACP_SW_AUDIO0_TX_SAMPLEINTERVAL			0x000301C
+#define ACP_SW_AUDIO0_TX_HCTRL_DP0			0x0003020
+#define ACP_SW_AUDIO0_TX_HCTRL_DP1			0x0003024
+#define ACP_SW_AUDIO0_TX_HCTRL_DP2			0x0003028
+#define ACP_SW_AUDIO0_TX_HCTRL_DP3			0x000302C
+#define ACP_SW_AUDIO0_TX_OFFSET_DP0			0x0003030
+#define ACP_SW_AUDIO0_TX_OFFSET_DP1			0x0003034
+#define ACP_SW_AUDIO0_TX_OFFSET_DP2			0x0003038
+#define ACP_SW_AUDIO0_TX_OFFSET_DP3			0x000303C
+#define ACP_SW_AUDIO0_TX_CHANNEL_ENABLE_DP0		0x0003040
+#define ACP_SW_AUDIO0_TX_CHANNEL_ENABLE_DP1		0x0003044
+#define ACP_SW_AUDIO0_TX_CHANNEL_ENABLE_DP2		0x0003048
+#define ACP_SW_AUDIO0_TX_CHANNEL_ENABLE_DP3		0x000304C
+#define ACP_SW_AUDIO1_TX_EN				0x0003050
+#define ACP_SW_AUDIO1_TX_EN_STATUS			0x0003054
+#define ACP_SW_AUDIO1_TX_FRAME_FORMAT			0x0003058
+#define ACP_SW_AUDIO1_TX_SAMPLEINTERVAL			0x000305C
+#define ACP_SW_AUDIO1_TX_HCTRL				0x0003060
+#define ACP_SW_AUDIO1_TX_OFFSET				0x0003064
+#define ACP_SW_AUDIO1_TX_CHANNEL_ENABLE_DP0		0x0003068
+#define ACP_SW_AUDIO2_TX_EN				0x000306C
+#define ACP_SW_AUDIO2_TX_EN_STATUS			0x0003070
+#define ACP_SW_AUDIO2_TX_FRAME_FORMAT			0x0003074
+#define ACP_SW_AUDIO2_TX_SAMPLEINTERVAL			0x0003078
+#define ACP_SW_AUDIO2_TX_HCTRL				0x000307C
+#define ACP_SW_AUDIO2_TX_OFFSET				0x0003080
+#define ACP_SW_AUDIO2_TX_CHANNEL_ENABLE_DP0		0x0003084
+#define ACP_SW_AUDIO0_RX_EN				0x0003088
+#define ACP_SW_AUDIO0_RX_EN_STATUS			0x000308C
+#define ACP_SW_AUDIO0_RX_FRAME_FORMAT			0x0003090
+#define ACP_SW_AUDIO0_RX_SAMPLEINTERVAL			0x0003094
+#define ACP_SW_AUDIO0_RX_HCTRL_DP0			0x0003098
+#define ACP_SW_AUDIO0_RX_HCTRL_DP1			0x000309C
+#define ACP_SW_AUDIO0_RX_HCTRL_DP2			0x0003100
+#define ACP_SW_AUDIO0_RX_HCTRL_DP3			0x0003104
+#define ACP_SW_AUDIO0_RX_OFFSET_DP0			0x0003108
+#define ACP_SW_AUDIO0_RX_OFFSET_DP1			0x000310C
+#define ACP_SW_AUDIO0_RX_OFFSET_DP2			0x0003110
+#define ACP_SW_AUDIO0_RX_OFFSET_DP3			0x0003114
+#define ACP_SW_AUDIO0_RX_CHANNEL_ENABLE_DP0		0x0003118
+#define ACP_SW_AUDIO0_RX_CHANNEL_ENABLE_DP1		0x000311C
+#define ACP_SW_AUDIO0_RX_CHANNEL_ENABLE_DP2		0x0003120
+#define ACP_SW_AUDIO0_RX_CHANNEL_ENABLE_DP3		0x0003124
+#define ACP_SW_AUDIO1_RX_EN				0x0003128
+#define ACP_SW_AUDIO1_RX_EN_STATUS			0x000312C
+#define ACP_SW_AUDIO1_RX_FRAME_FORMAT			0x0003130
+#define ACP_SW_AUDIO1_RX_SAMPLEINTERVAL			0x0003134
+#define ACP_SW_AUDIO1_RX_HCTRL				0x0003138
+#define ACP_SW_AUDIO1_RX_OFFSET				0x000313C
+#define ACP_SW_AUDIO1_RX_CHANNEL_ENABLE_DP0		0x0003140
+#define ACP_SW_AUDIO2_RX_EN				0x0003144
+#define ACP_SW_AUDIO2_RX_EN_STATUS			0x0003148
+#define ACP_SW_AUDIO2_RX_FRAME_FORMAT			0x000314C
+#define ACP_SW_AUDIO2_RX_SAMPLEINTERVAL			0x0003150
+#define ACP_SW_AUDIO2_RX_HCTRL				0x0003154
+#define ACP_SW_AUDIO2_RX_OFFSET				0x0003158
+#define ACP_SW_AUDIO2_RX_CHANNEL_ENABLE_DP0		0x000315C
+#define ACP_SW_BPT_PORT_EN				0x0003160
+#define ACP_SW_BPT_PORT_EN_STATUS			0x0003164
+#define ACP_SW_BPT_PORT_FRAME_FORMAT			0x0003168
+#define ACP_SW_BPT_PORT_SAMPLEINTERVAL			0x000316C
+#define ACP_SW_BPT_PORT_HCTRL				0x0003170
+#define ACP_SW_BPT_PORT_OFFSET				0x0003174
+#define ACP_SW_BPT_PORT_CHANNEL_ENABLE			0x0003178
+#define ACP_SW_BPT_PORT_FIRST_BYTE_ADDR			0x000317C
+#define ACP_SW_CLK_RESUME_CTRL				0x0003180
+#define ACP_SW_CLK_RESUME_DELAY_CNTR			0x0003184
+#define ACP_SW_BUS_RESET_CTRL				0x0003188
+#define ACP_SW_PRBS_ERR_STATUS				0x000318C
+#define ACP_SW_IMM_CMD_UPPER_WORD			0x0003230
+#define ACP_SW_IMM_CMD_LOWER_QWORD			0x0003234
+#define ACP_SW_IMM_RESP_UPPER_WORD			0x0003238
+#define ACP_SW_IMM_RESP_LOWER_QWORD			0x000323C
+#define ACP_SW_IMM_CMD_STS				0x0003240
+#define ACP_SW_BRA_BASE_ADDRESS				0x0003244
+#define ACP_SW_BRA_TRANSFER_SIZE			0x0003248
+#define ACP_SW_BRA_DMA_BUSY				0x000324C
+#define ACP_SW_BRA_RESP					0x0003250
+#define ACP_SW_BRA_RESP_FRAME_ADDR			0x0003254
+#define ACP_SW_BRA_CURRENT_TRANSFER_SIZE		0x0003258
+#define ACP_SW_STATE_CHANGE_STATUS_0TO7			0x000325C
+#define ACP_SW_STATE_CHANGE_STATUS_8TO11		0x0003260
+#define ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7		0x0003264
+#define ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11		0x0003268
+#define ACP_SW_CLK_FREQUENCY_CTRL			0x000326C
+#define ACP_SW_ERROR_INTR_MASK				0x0003270
+#define ACP_SW_PHY_TEST_MODE_DATA_OFF			0x0003274
+
+#define ACP_DELAY_US					10
+#define AMD_SDW_TIMEOUT					1000
+#define AMD_SDW_DEFAULT_CLK_FREQ			12000000
+
+#define AMD_SDW_MCP_RESP_ACK				BIT(0)
+#define AMD_SDW_MCP_RESP_NACK				BIT(1)
+#define AMD_SDW_MCP_RESP_RDATA				GENMASK(14, 7)
+
+#define AMD_SDW_MCP_CMD_SSP_TAG				BIT(31)
+#define AMD_SDW_MCP_CMD_COMMAND				GENMASK(14, 12)
+#define AMD_SDW_MCP_CMD_DEV_ADDR			GENMASK(11, 8)
+#define AMD_SDW_MCP_CMD_REG_ADDR_HIGH			GENMASK(7, 0)
+#define AMD_SDW_MCP_CMD_REG_ADDR_LOW			GENMASK(31, 24)
+#define AMD_SDW_MCP_CMD_REG_DATA			GENMASK(14, 7)
+#define AMD_SDW_MCP_SLAVE_STAT_0_3			GENMASK(14, 7)
+#define AMD_SDW_MCP_SLAVE_STAT_4_11			GENMASK_ULL(39, 24)
+#define AMD_SDW_MCP_SLAVE_STATUS_MASK			GENMASK(1, 0)
+#define AMD_SDW_MCP_SLAVE_STATUS_BITS			GENMASK(3, 2)
+#define AMD_SDW_MCP_SLAVE_STATUS_8TO_11			GENMASK_ULL(15, 0)
+#define AMD_SDW_MCP_SLAVE_STATUS_VALID_MASK(x)		BIT(((x) * 4))
+#define AMD_SDW_MCP_SLAVE_STAT_SHIFT_MASK(x)		(((x) * 4) + 1)
+
+#define AMD_SDW_MASTER_SUSPEND_DELAY_MS			2000
+#define AMD_SDW_QUIRK_MASK_BUS_ENABLE			BIT(0)
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
+#define AMD_SDW0_MAX_DAI		6
+#define AMD_SDW1_MAX_DAI		2
+#define AMD_SDW_SLAVE_0_ATTACHED	5
+#define AMD_SDW_SSP_COUNTER_VAL		3
+
+#define AMD_DPN_FRAME_FMT_PFM				GENMASK(1, 0)
+#define AMD_DPN_FRAME_FMT_PDM				GENMASK(3, 2)
+#define AMD_DPN_FRAME_FMT_BLK_PKG_MODE			BIT(4)
+#define AMD_DPN_FRAME_FMT_BLK_GRP_CTRL			GENMASK(6, 5)
+#define AMD_DPN_FRAME_FMT_WORD_LEN			GENMASK(12, 7)
+#define AMD_DPN_FRAME_FMT_PCM_OR_PDM			BIT(13)
+#define AMD_DPN_HCTRL_HSTOP				GENMASK(3, 0)
+#define AMD_DPN_HCTRL_HSTART				GENMASK(7, 4)
+#define AMD_DPN_OFFSET_CTRL_1				GENMASK(7, 0)
+#define AMD_DPN_OFFSET_CTRL_2				GENMASK(15, 8)
+#define AMD_DPN_CH_EN_LCTRL				GENMASK(2, 0)
+#define AMD_DPN_CH_EN_CHMASK				GENMASK(10, 3)
+#define AMD_SDW_STAT_MAX_RETRY_COUNT			100
+#define AMD_SDW0_PAD_PULLDOWN_CTRL_ENABLE_MASK		0x7F9F
+#define AMD_SDW1_PAD_PULLDOWN_CTRL_ENABLE_MASK		0x7FFA
+#define AMD_SDW0_PAD_PULLDOWN_CTRL_DISABLE_MASK		0x60
+#define AMD_SDW1_PAD_PULLDOWN_CTRL_DISABLE_MASK		5
+#define AMD_SDW0_PAD_KEEPER_EN_MASK			1
+#define AMD_SDW1_PAD_KEEPER_EN_MASK			0x10
+#define AMD_SDW0_PAD_KEEPER_DISABLE_MASK		0x1E
+#define AMD_SDW1_PAD_KEEPER_DISABLE_MASK		0xF
+
+enum amd_sdw_cmd_type {
+	AMD_SDW_CMD_PING = 0,
+	AMD_SDW_CMD_READ = 2,
+	AMD_SDW_CMD_WRITE = 3,
+};
+
+static u32 amd_sdw_freq_tbl[AMD_SDW_MAX_FREQ_NUM] = {
+	AMD_SDW_DEFAULT_CLK_FREQ,
+};
+
+struct sdw_manager_dp_reg {
+	u32 frame_fmt_reg;
+	u32 sample_int_reg;
+	u32 hctrl_dp0_reg;
+	u32 offset_reg;
+	u32 lane_ctrl_ch_en_reg;
+};
+
+static struct sdw_manager_dp_reg sdw0_manager_dp_reg[AMD_SDW0_MAX_DAI] =  {
+	{ACP_SW_AUDIO0_TX_FRAME_FORMAT, ACP_SW_AUDIO0_TX_SAMPLEINTERVAL, ACP_SW_AUDIO0_TX_HCTRL_DP0,
+	 ACP_SW_AUDIO0_TX_OFFSET_DP0, ACP_SW_AUDIO0_TX_CHANNEL_ENABLE_DP0},
+	{ACP_SW_AUDIO1_TX_FRAME_FORMAT, ACP_SW_AUDIO1_TX_SAMPLEINTERVAL, ACP_SW_AUDIO1_TX_HCTRL,
+	 ACP_SW_AUDIO1_TX_OFFSET, ACP_SW_AUDIO1_TX_CHANNEL_ENABLE_DP0},
+	{ACP_SW_AUDIO2_TX_FRAME_FORMAT, ACP_SW_AUDIO2_TX_SAMPLEINTERVAL, ACP_SW_AUDIO2_TX_HCTRL,
+	 ACP_SW_AUDIO2_TX_OFFSET, ACP_SW_AUDIO2_TX_CHANNEL_ENABLE_DP0},
+	{ACP_SW_AUDIO0_RX_FRAME_FORMAT, ACP_SW_AUDIO0_RX_SAMPLEINTERVAL, ACP_SW_AUDIO0_RX_HCTRL_DP0,
+	 ACP_SW_AUDIO0_RX_OFFSET_DP0, ACP_SW_AUDIO0_RX_CHANNEL_ENABLE_DP0},
+	{ACP_SW_AUDIO1_RX_FRAME_FORMAT, ACP_SW_AUDIO1_RX_SAMPLEINTERVAL, ACP_SW_AUDIO1_RX_HCTRL,
+	 ACP_SW_AUDIO1_RX_OFFSET, ACP_SW_AUDIO1_RX_CHANNEL_ENABLE_DP0},
+	{ACP_SW_AUDIO2_RX_FRAME_FORMAT, ACP_SW_AUDIO2_RX_SAMPLEINTERVAL, ACP_SW_AUDIO2_RX_HCTRL,
+	 ACP_SW_AUDIO2_RX_OFFSET, ACP_SW_AUDIO2_RX_CHANNEL_ENABLE_DP0},
+};
+
+static struct sdw_manager_dp_reg sdw1_manager_dp_reg[AMD_SDW1_MAX_DAI] =  {
+	{ACP_SW_AUDIO1_TX_FRAME_FORMAT, ACP_SW_AUDIO1_TX_SAMPLEINTERVAL, ACP_SW_AUDIO1_TX_HCTRL,
+	 ACP_SW_AUDIO1_TX_OFFSET, ACP_SW_AUDIO1_TX_CHANNEL_ENABLE_DP0},
+	{ACP_SW_AUDIO1_RX_FRAME_FORMAT, ACP_SW_AUDIO1_RX_SAMPLEINTERVAL, ACP_SW_AUDIO1_RX_HCTRL,
+	 ACP_SW_AUDIO1_RX_OFFSET, ACP_SW_AUDIO1_RX_CHANNEL_ENABLE_DP0}
+};
+
+static struct sdw_manager_reg_mask sdw_manager_reg_mask_array[2] =  {
+	{
+		AMD_SDW0_PAD_KEEPER_EN_MASK,
+		AMD_SDW0_PAD_PULLDOWN_CTRL_ENABLE_MASK,
+		AMD_SDW0_EXT_INTR_MASK
+	},
+	{
+		AMD_SDW1_PAD_KEEPER_EN_MASK,
+		AMD_SDW1_PAD_PULLDOWN_CTRL_ENABLE_MASK,
+		AMD_SDW1_EXT_INTR_MASK
+	}
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
new file mode 100644
index 000000000000..c14a291a40e8
--- /dev/null
+++ b/include/linux/soundwire/sdw_amd.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2023 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#ifndef __SDW_AMD_H
+#define __SDW_AMD_H
+
+#include <linux/soundwire/sdw.h>
+
+#define ACP_SDW0	0
+#define ACP_SDW1	1
+
+struct acp_sdw_pdata {
+	u16 instance;
+	/* mutex to protect acp common register access */
+	struct mutex *acp_sdw_lock;
+};
+
+struct sdw_manager_reg_mask {
+	u32 sw_pad_enable_mask;
+	u32 sw_pad_pulldown_mask;
+	u32 acp_sdw_intr_mask;
+};
+
+/**
+ * struct amd_sdw_manager - amd manager driver context
+ * @bus: bus handle
+ * @dev: linux device
+ * @mmio: SoundWire registers mmio base
+ * @acp_mmio: acp registers mmio base
+ * @reg_mask: register mask structure per manager instance
+ * @probe_work: SoundWire manager probe workqueue
+ * @acp_sdw_lock: mutex to protect acp share register access
+ * @num_din_ports: number of input ports
+ * @num_dout_ports: number of output ports
+ * @cols_index: Column index in frame shape
+ * @rows_index: Rows index in frame shape
+ * @instance: SoundWire manager instance
+ * @quirks: SoundWire manager quirks
+ * @wake_en_mask: wake enable mask per SoundWire manager
+ * @power_mode_mask: flag interprets amd SoundWire manager power mode
+ */
+struct amd_sdw_manager {
+	struct sdw_bus bus;
+	struct device *dev;
+
+	void __iomem *mmio;
+	void __iomem *acp_mmio;
+
+	struct sdw_manager_reg_mask *reg_mask;
+	struct work_struct probe_work;
+	/* mutex to protect acp common register access */
+	struct mutex *acp_sdw_lock;
+
+	int num_din_ports;
+	int num_dout_ports;
+
+	int cols_index;
+	int rows_index;
+
+	u32 instance;
+	u32 quirks;
+	u32 wake_en_mask;
+	u32 power_mode_mask;
+};
+#endif
-- 
2.34.1

