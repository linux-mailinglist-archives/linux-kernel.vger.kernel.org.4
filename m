Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90AC6738F4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjASMr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjASMrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:47:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFEF11EA7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:47:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CAC460DEC
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 12:47:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED63AC433D2;
        Thu, 19 Jan 2023 12:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674132462;
        bh=AG9ogO1c20RwOMtS2ca5ISHI/3iMgasVpceBdC5C7D8=;
        h=From:To:Cc:Subject:Date:From;
        b=GGejYoR3Izl6cNWBaoKpopgHMCn+CJ6CN1/4OLf48VimYWYWNRsWPYMYDi2DZz9XP
         lWZH82lxerP5f8eIe7Gp6v9N0x2il5MsiZhyGZ35h8Q/2o0WE88Rn5M6BKIuuJv6pZ
         IWUJLeG+MgHXUUE9fe6t39kvu9lYmpSBjGhpjrCoB2yh/7+w2Ki/B5sGI+B4c1sIjI
         C05Zhey184DSvZ3NvlPGH5jX2+9fV2qhqv3ka3VyjXahJgBYJjVpbPOz30Z8xqftA3
         3XYS/pwDSAvUge18+6iYm3KRBcIxxgLj0OqRvEXKw4W0+9BanhRjr5D6b62pLVuvzn
         VQatPm34YdKGg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCH] habanalabs/gaudi2: find decode error root cause
Date:   Thu, 19 Jan 2023 14:47:35 +0200
Message-Id: <20230119124735.751931-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koby Elbaz <kelbaz@habana.ai>

When a decode error happens, we often don't know the exact root
cause (the erroneous address that was accessed) and the exact engine
that created the erroneous transaction.

To find out, we need to go over all the relevant register blocks
in the ASIC. Once we find the relevant engine, we print its details
and the offending address.

This helps tremendously when debugging an error that was created
by running a user workload.

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/habanalabs.h  |  10 +
 drivers/accel/habanalabs/common/security.c    | 174 ++++++++++++++++++
 drivers/accel/habanalabs/common/security.h    | 163 ++++++++++++++++
 drivers/accel/habanalabs/gaudi2/gaudi2.c      | 155 +++++++++++++++-
 drivers/accel/habanalabs/gaudi2/gaudi2P.h     |  37 ++++
 .../include/gaudi2/gaudi2_special_blocks.h    | 157 ++++++++++++++++
 6 files changed, 695 insertions(+), 1 deletion(-)
 create mode 100644 drivers/accel/habanalabs/common/security.h
 create mode 100644 drivers/accel/habanalabs/include/gaudi2/gaudi2_special_blocks.h

diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index afc0c0d3f9e3..fa05e76d3d21 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -29,6 +29,8 @@
 #include <linux/coresight.h>
 #include <linux/dma-buf.h>
 
+#include "security.h"
+
 #define HL_NAME				"habanalabs"
 
 struct hl_device;
@@ -546,6 +548,8 @@ struct hl_hints_range {
 /**
  * struct asic_fixed_properties - ASIC specific immutable properties.
  * @hw_queues_props: H/W queues properties.
+ * @special_blocks: points to an array containing special blocks info.
+ * @skip_special_blocks_cfg: special blocks skip configs.
  * @cpucp_info: received various information from CPU-CP regarding the H/W, e.g.
  *		available sensors.
  * @uboot_ver: F/W U-boot version.
@@ -645,6 +649,8 @@ struct hl_hints_range {
  *                                      (i.e. the DRAM supports multiple page sizes), otherwise
  *                                      it will shall  be equal to dram_page_size.
  * @num_engine_cores: number of engine cpu cores
+ * @num_of_special_blocks: special_blocks array size.
+ * @glbl_err_cause_num: global err cause number.
  * @hbw_flush_reg: register to read to generate HBW flush. value of 0 means HBW flush is
  *                 not supported.
  * @collective_first_sob: first sync object available for collective use
@@ -695,6 +701,8 @@ struct hl_hints_range {
  */
 struct asic_fixed_properties {
 	struct hw_queue_properties	*hw_queues_props;
+	struct hl_special_block_info	*special_blocks;
+	struct hl_skip_blocks_cfg	skip_special_blocks_cfg;
 	struct cpucp_info		cpucp_info;
 	char				uboot_ver[VERSION_MAX_LEN];
 	char				preboot_ver[VERSION_MAX_LEN];
@@ -767,6 +775,8 @@ struct asic_fixed_properties {
 	u32				xbar_edge_enabled_mask;
 	u32				device_mem_alloc_default_page_size;
 	u32				num_engine_cores;
+	u32				num_of_special_blocks;
+	u32				glbl_err_cause_num;
 	u32				hbw_flush_reg;
 	u16				collective_first_sob;
 	u16				collective_first_mon;
diff --git a/drivers/accel/habanalabs/common/security.c b/drivers/accel/habanalabs/common/security.c
index 6196c0487c8b..5f03ade07ead 100644
--- a/drivers/accel/habanalabs/common/security.c
+++ b/drivers/accel/habanalabs/common/security.c
@@ -7,6 +7,19 @@
 
 #include "habanalabs.h"
 
+static const char * const hl_glbl_error_cause[HL_MAX_NUM_OF_GLBL_ERR_CAUSE] = {
+	"Error due to un-priv read",
+	"Error due to un-secure read",
+	"Error due to read from unmapped reg",
+	"Error due to un-priv write",
+	"Error due to un-secure write",
+	"Error due to write to unmapped reg",
+	"External I/F write sec violation",
+	"External I/F write to un-mapped reg",
+	"Read to write only",
+	"Write to read only"
+};
+
 /**
  * hl_get_pb_block - return the relevant block within the block array
  *
@@ -598,3 +611,164 @@ void hl_ack_pb_single_dcore(struct hl_device *hdev, u32 dcore_offset,
 				blocks_array_size);
 
 }
+
+static u32 hl_automated_get_block_base_addr(struct hl_device *hdev,
+		struct hl_special_block_info *block_info,
+		u32 major, u32 minor, u32 sub_minor)
+{
+	u32 fw_block_base_address = block_info->base_addr +
+			major * block_info->major_offset +
+			minor * block_info->minor_offset +
+			sub_minor * block_info->sub_minor_offset;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+
+	/* Calculation above returns an address for FW use, and therefore should
+	 * be casted for driver use.
+	 */
+	return (fw_block_base_address - lower_32_bits(prop->cfg_base_address));
+}
+
+static bool hl_check_block_type_exclusion(struct hl_skip_blocks_cfg *skip_blocks_cfg,
+		int block_type)
+{
+	int i;
+
+	/* Check if block type is listed in the exclusion list of block types */
+	for (i = 0 ; i < skip_blocks_cfg->block_types_len ; i++)
+		if (block_type == skip_blocks_cfg->block_types[i])
+			return true;
+
+	return false;
+}
+
+static bool hl_check_block_range_exclusion(struct hl_device *hdev,
+		struct hl_skip_blocks_cfg *skip_blocks_cfg,
+		struct hl_special_block_info *block_info,
+		u32 major, u32 minor, u32 sub_minor)
+{
+	u32 blocks_in_range, block_base_addr_in_range, block_base_addr;
+	int i, j;
+
+	block_base_addr = hl_automated_get_block_base_addr(hdev, block_info,
+			major, minor, sub_minor);
+
+	for (i = 0 ; i < skip_blocks_cfg->block_ranges_len ; i++) {
+		blocks_in_range = (skip_blocks_cfg->block_ranges[i].end -
+				skip_blocks_cfg->block_ranges[i].start) /
+				HL_BLOCK_SIZE + 1;
+		for (j = 0 ; j < blocks_in_range ; j++) {
+			block_base_addr_in_range = skip_blocks_cfg->block_ranges[i].start +
+					j * HL_BLOCK_SIZE;
+			if (block_base_addr == block_base_addr_in_range)
+				return true;
+		}
+	}
+
+	return false;
+}
+
+static int hl_read_glbl_errors(struct hl_device *hdev,
+		u32 blk_idx, u32 major, u32 minor, u32 sub_minor, void *data)
+{
+	struct hl_special_block_info *special_blocks = hdev->asic_prop.special_blocks;
+	struct hl_special_block_info *current_block = &special_blocks[blk_idx];
+	u32 glbl_err_addr, glbl_err_cause, addr_val, cause_val, block_base,
+		base = current_block->base_addr - lower_32_bits(hdev->asic_prop.cfg_base_address);
+	int i;
+
+	block_base = base + major * current_block->major_offset +
+			minor * current_block->minor_offset +
+			sub_minor * current_block->sub_minor_offset;
+
+	glbl_err_cause = block_base + HL_GLBL_ERR_CAUSE_OFFSET;
+	cause_val = RREG32(glbl_err_cause);
+	if (!cause_val)
+		return 0;
+
+	glbl_err_addr = block_base + HL_GLBL_ERR_ADDR_OFFSET;
+	addr_val = RREG32(glbl_err_addr);
+
+	for (i = 0 ; i < hdev->asic_prop.glbl_err_cause_num ; i++) {
+		if (cause_val & BIT(i))
+			dev_err_ratelimited(hdev->dev,
+				"%s, addr %#llx\n",
+				hl_glbl_error_cause[i],
+				hdev->asic_prop.cfg_base_address + block_base +
+				FIELD_GET(HL_GLBL_ERR_ADDRESS_MASK, addr_val));
+	}
+
+	WREG32(glbl_err_cause, cause_val);
+
+	return 0;
+}
+
+void hl_check_for_glbl_errors(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct hl_special_blocks_cfg special_blocks_cfg;
+	struct iterate_special_ctx glbl_err_iter;
+	int rc;
+
+	memset(&special_blocks_cfg, 0, sizeof(special_blocks_cfg));
+	special_blocks_cfg.skip_blocks_cfg = &prop->skip_special_blocks_cfg;
+
+	glbl_err_iter.fn = &hl_read_glbl_errors;
+	glbl_err_iter.data = &special_blocks_cfg;
+
+	rc = hl_iterate_special_blocks(hdev, &glbl_err_iter);
+	if (rc)
+		dev_err_ratelimited(hdev->dev,
+			"Could not iterate special blocks, glbl error check failed\n");
+}
+
+int hl_iterate_special_blocks(struct hl_device *hdev, struct iterate_special_ctx *ctx)
+{
+	struct hl_special_blocks_cfg *special_blocks_cfg =
+			(struct hl_special_blocks_cfg *)ctx->data;
+	struct hl_skip_blocks_cfg *skip_blocks_cfg =
+			special_blocks_cfg->skip_blocks_cfg;
+	u32 major, minor, sub_minor, blk_idx, num_blocks;
+	struct hl_special_block_info *block_info_arr;
+	int rc;
+
+	block_info_arr = hdev->asic_prop.special_blocks;
+	if (!block_info_arr)
+		return -EINVAL;
+
+	num_blocks = hdev->asic_prop.num_of_special_blocks;
+
+	for (blk_idx = 0 ; blk_idx < num_blocks ; blk_idx++, block_info_arr++) {
+		if (hl_check_block_type_exclusion(skip_blocks_cfg, block_info_arr->block_type))
+			continue;
+
+		for (major = 0 ; major < block_info_arr->major ; major++) {
+			minor = 0;
+			do {
+				sub_minor = 0;
+				do {
+					if ((hl_check_block_range_exclusion(hdev,
+							skip_blocks_cfg, block_info_arr,
+							major, minor, sub_minor)) ||
+						(skip_blocks_cfg->skip_block_hook &&
+						skip_blocks_cfg->skip_block_hook(hdev,
+							special_blocks_cfg,
+							blk_idx, major, minor, sub_minor))) {
+						sub_minor++;
+						continue;
+					}
+
+					rc = ctx->fn(hdev, blk_idx, major, minor,
+								sub_minor, ctx->data);
+					if (rc)
+						return rc;
+
+					sub_minor++;
+				} while (sub_minor < block_info_arr->sub_minor);
+
+				minor++;
+			} while (minor < block_info_arr->minor);
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/accel/habanalabs/common/security.h b/drivers/accel/habanalabs/common/security.h
new file mode 100644
index 000000000000..234b4a6ed8bc
--- /dev/null
+++ b/drivers/accel/habanalabs/common/security.h
@@ -0,0 +1,163 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2016-2022 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ *
+ */
+
+#ifndef SECURITY_H_
+#define SECURITY_H_
+
+#include <linux/io-64-nonatomic-lo-hi.h>
+
+extern struct hl_device *hdev;
+
+/* special blocks */
+#define HL_MAX_NUM_OF_GLBL_ERR_CAUSE		10
+#define HL_GLBL_ERR_ADDRESS_MASK		GENMASK(11, 0)
+/* GLBL_ERR_ADDR register offset from the start of the block */
+#define HL_GLBL_ERR_ADDR_OFFSET		0xF44
+/* GLBL_ERR_CAUSE register offset from the start of the block */
+#define HL_GLBL_ERR_CAUSE_OFFSET	0xF48
+
+/*
+ * struct hl_special_block_info - stores address details of a particular type of
+ * IP block which has a SPECIAL part.
+ *
+ * @block_type: block type as described in every ASIC's block_types enum.
+ * @base_addr: base address of the first block of particular type,
+ *             e.g., address of NIC0_UMR0_0 of 'NIC_UMR' block.
+ * @major: number of major blocks of particular type.
+ * @minor: number of minor blocks of particular type.
+ * @sub_minor: number of sub minor blocks of particular type.
+ * @major_offset: address gap between 2 consecutive major blocks of particular type,
+ *                e.g., offset between NIC0_UMR0_0 and NIC1_UMR0_0 is 0x80000.
+ * @minor_offset: address gap between 2 consecutive minor blocks of particular type,
+ *                e.g., offset between NIC0_UMR0_0 and NIC0_UMR1_0 is 0x20000.
+ * @sub_minor_offset: address gap between 2 consecutive sub_minor blocks of particular
+ *                    type, e.g., offset between NIC0_UMR0_0 and NIC0_UMR0_1 is 0x1000.
+ *
+ * e.g., in Gaudi2, NIC_UMR blocks can be interpreted as:
+ * NIC<major>_UMR<minor>_<sub_minor> where major=12, minor=2, sub_minor=15.
+ * In other words, for each of 12 major numbers (i.e 0 to 11) there are
+ * 2 blocks with different minor numbers (i.e. 0 to 1). Again, for each minor
+ * number there are 15 blocks with different sub_minor numbers (i.e. 0 to 14).
+ * So different blocks are NIC0_UMR0_0, NIC0_UMR0_1, ..., NIC0_UMR1_0, ....,
+ * NIC11_UMR1_14.
+ *
+ * Struct's formatted data is located in the SOL-based auto-generated protbits headers.
+ */
+struct hl_special_block_info {
+	int block_type;
+	u32 base_addr;
+	u32 major;
+	u32 minor;
+	u32 sub_minor;
+	u32 major_offset;
+	u32 minor_offset;
+	u32 sub_minor_offset;
+};
+
+/*
+ * struct hl_automated_pb_cfg - represents configurations of a particular type
+ * of IP block which has protection bits.
+ *
+ * @addr: address details as described in hl_automation_pb_addr struct.
+ * @prot_map: each bit corresponds to one among 32 protection configuration regs
+ *            (e.g., SPECIAL_GLBL_PRIV). '1' means 0xffffffff and '0' means 0x0
+ *            to be written into the corresponding protection configuration reg.
+ *            This bit is meaningful if same bit in data_map is 0, otherwise ignored.
+ * @data_map: each bit corresponds to one among 32 protection configuration regs
+ *            (e.g., SPECIAL_GLBL_PRIV). '1' means corresponding protection
+ *            configuration reg is to be written with a value in array pointed
+ *            by 'data', otherwise the value is decided by 'prot_map'.
+ * @data: pointer to data array which stores the config value(s) to be written
+ *            to corresponding protection configuration reg(s).
+ * @data_size: size of the data array.
+ *
+ * Each bit of 'data_map' and 'prot_map' fields corresponds to one among 32
+ * protection configuration registers e.g., SPECIAL GLBL PRIV regs (starting at
+ * offset 0xE80). '1' in 'data_map' means protection configuration to be done
+ * using configuration in data array. '0' in 'data_map" means protection
+ * configuration to be done as per the value of corresponding bit in 'prot_map'.
+ * '1' in 'prot_map' means the register to be programmed with 0xFFFFFFFF
+ * (all non-protected). '0' in 'prot_map' means the register to be programmed
+ * with 0x0 (all protected).
+ *
+ * e.g., prot_map = 0x00000001, data_map = 0xC0000000 , data = {0xff, 0x12}
+ * SPECIAL_GLBL_PRIV[0] = 0xFFFFFFFF
+ * SPECIAL_GLBL_PRIV[1..29] = 0x0
+ * SPECIAL_GLBL_PRIV[30] = 0xFF
+ * SPECIAL_GLBL_PRIV[31] = 0x12
+ */
+struct hl_automated_pb_cfg {
+	struct hl_special_block_info addr;
+	u32 prot_map;
+	u32 data_map;
+	const u32 *data;
+	u8 data_size;
+};
+
+/* struct hl_special_blocks_cfg - holds special blocks cfg data.
+ *
+ * @priv_automated_pb_cfg: points to the main privileged PB array.
+ * @sec_automated_pb_cfg: points to the main secured PB array.
+ * @skip_blocks_cfg: holds arrays of block types & block ranges to be excluded.
+ * @priv_cfg_size: size of the main privileged PB array.
+ * @sec_cfg_size: size of the main secured PB array.
+ * @prot_lvl_priv: indication if it's a privileged/secured PB configurations.
+ */
+struct hl_special_blocks_cfg {
+	struct hl_automated_pb_cfg *priv_automated_pb_cfg;
+	struct hl_automated_pb_cfg *sec_automated_pb_cfg;
+	struct hl_skip_blocks_cfg *skip_blocks_cfg;
+	u32 priv_cfg_size;
+	u32 sec_cfg_size;
+	u8 prot_lvl_priv;
+};
+
+/* Automated security */
+
+/* struct hl_skip_blocks_cfg - holds arrays of block types & block ranges to be
+ * excluded from special blocks configurations.
+ *
+ * @block_types: an array of block types NOT to be configured.
+ * @block_types_len: len of an array of block types not to be configured.
+ * @block_ranges: an array of block ranges not to be configured.
+ * @block_ranges_len: len of an array of block ranges not to be configured.
+ * @skip_block_hook: hook that will be called before initializing special blocks.
+ */
+struct hl_skip_blocks_cfg {
+	int *block_types;
+	size_t block_types_len;
+	struct range *block_ranges;
+	size_t block_ranges_len;
+	bool (*skip_block_hook)(struct hl_device *hdev,
+				struct hl_special_blocks_cfg *special_blocks_cfg,
+				u32 blk_idx, u32 major, u32 minor, u32 sub_minor);
+};
+
+/**
+ * struct iterate_special_ctx - HW module special block iterator
+ * @fn: function to apply to each HW module special block instance
+ * @data: optional internal data to the function iterator
+ */
+struct iterate_special_ctx {
+	/*
+	 * callback for the HW module special block iterator
+	 * @hdev: pointer to the habanalabs device structure
+	 * @block_id: block (ASIC specific definition can be dcore/hdcore)
+	 * @major: major block index within block_id
+	 * @minor: minor block index within the major block
+	 * @sub_minor: sub_minor block index within the minor block
+	 * @data: function specific data
+	 */
+	int (*fn)(struct hl_device *hdev, u32 block_id, u32 major, u32 minor,
+						u32 sub_minor, void *data);
+	void *data;
+};
+
+int hl_iterate_special_blocks(struct hl_device *hdev, struct iterate_special_ctx *ctx);
+void hl_check_for_glbl_errors(struct hl_device *hdev);
+
+#endif /* SECURITY_H_ */
diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 65c720a0c64c..f1f2a58ee68c 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -7,6 +7,7 @@
 
 #include "gaudi2P.h"
 #include "gaudi2_masks.h"
+#include "../include/gaudi2/gaudi2_special_blocks.h"
 #include "../include/hw_ip/mmu/mmu_general.h"
 #include "../include/hw_ip/mmu/mmu_v2_0.h"
 #include "../include/gaudi2/gaudi2_packets.h"
@@ -1683,6 +1684,30 @@ struct hbm_mc_error_causes {
 	char cause[50];
 };
 
+static struct hl_special_block_info gaudi2_special_blocks[] = GAUDI2_SPECIAL_BLOCKS;
+
+/* Special blocks iterator is currently used to configure security protection bits,
+ * and read global errors. Most HW blocks are addressable and those who aren't (N/A)-
+ * must be skipped. Following configurations are commonly used for both PB config
+ * and global error reading, since currently they both share the same settings.
+ * Once it changes, we must remember to use separate configurations for either one.
+ */
+static int gaudi2_iterator_skip_block_types[] = {
+		GAUDI2_BLOCK_TYPE_PLL,
+		GAUDI2_BLOCK_TYPE_EU_BIST,
+		GAUDI2_BLOCK_TYPE_HBM,
+		GAUDI2_BLOCK_TYPE_XFT
+};
+
+static struct range gaudi2_iterator_skip_block_ranges[] = {
+		/* Skip all PSOC blocks except for PSOC_GLOBAL_CONF */
+		{mmPSOC_I2C_M0_BASE, mmPSOC_EFUSE_BASE},
+		{mmPSOC_BTL_BASE, mmPSOC_MSTR_IF_RR_SHRD_HBW_BASE},
+		/* Skip all CPU blocks except for CPU_IF */
+		{mmCPU_CA53_CFG_BASE, mmCPU_CA53_CFG_BASE},
+		{mmCPU_TIMESTAMP_BASE, mmCPU_MSTR_IF_RR_SHRD_HBW_BASE}
+};
+
 static struct hbm_mc_error_causes hbm_mc_spi[GAUDI2_NUM_OF_HBM_MC_SPI_CAUSE] = {
 	{HBM_MC_SPI_TEMP_PIN_CHG_MASK, "temperature pins changed"},
 	{HBM_MC_SPI_THR_ENG_MASK, "temperature-based throttling engaged"},
@@ -2997,6 +3022,99 @@ static inline int gaudi2_get_non_zero_random_int(void)
 	return rand ? rand : 1;
 }
 
+static void gaudi2_special_blocks_free(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct hl_skip_blocks_cfg *skip_special_blocks_cfg =
+			&prop->skip_special_blocks_cfg;
+
+	kfree(prop->special_blocks);
+	kfree(skip_special_blocks_cfg->block_types);
+	kfree(skip_special_blocks_cfg->block_ranges);
+}
+
+static void gaudi2_special_blocks_iterator_free(struct hl_device *hdev)
+{
+	gaudi2_special_blocks_free(hdev);
+}
+
+static bool gaudi2_special_block_skip(struct hl_device *hdev,
+		struct hl_special_blocks_cfg *special_blocks_cfg,
+		u32 blk_idx, u32 major, u32 minor, u32 sub_minor)
+{
+	return false;
+}
+
+static int gaudi2_special_blocks_config(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	int i, rc;
+
+	/* Configure Special blocks */
+	prop->glbl_err_cause_num = GAUDI2_NUM_OF_GLBL_ERR_CAUSE;
+	prop->num_of_special_blocks = ARRAY_SIZE(gaudi2_special_blocks);
+	prop->special_blocks = kmalloc_array(prop->num_of_special_blocks,
+			sizeof(*prop->special_blocks), GFP_KERNEL);
+	if (!prop->special_blocks)
+		return -ENOMEM;
+
+	for (i = 0 ; i < prop->num_of_special_blocks ; i++)
+		memcpy(&prop->special_blocks[i], &gaudi2_special_blocks[i],
+				sizeof(*prop->special_blocks));
+
+	/* Configure when to skip Special blocks */
+	memset(&prop->skip_special_blocks_cfg, 0, sizeof(prop->skip_special_blocks_cfg));
+	prop->skip_special_blocks_cfg.skip_block_hook = gaudi2_special_block_skip;
+
+	if (ARRAY_SIZE(gaudi2_iterator_skip_block_types)) {
+		prop->skip_special_blocks_cfg.block_types =
+				kmalloc_array(ARRAY_SIZE(gaudi2_iterator_skip_block_types),
+					sizeof(gaudi2_iterator_skip_block_types[0]), GFP_KERNEL);
+		if (!prop->skip_special_blocks_cfg.block_types) {
+			rc = -ENOMEM;
+			goto free_special_blocks;
+		}
+
+		memcpy(prop->skip_special_blocks_cfg.block_types, gaudi2_iterator_skip_block_types,
+				sizeof(gaudi2_iterator_skip_block_types));
+
+		prop->skip_special_blocks_cfg.block_types_len =
+					ARRAY_SIZE(gaudi2_iterator_skip_block_types);
+	}
+
+	if (ARRAY_SIZE(gaudi2_iterator_skip_block_ranges)) {
+		prop->skip_special_blocks_cfg.block_ranges =
+				kmalloc_array(ARRAY_SIZE(gaudi2_iterator_skip_block_ranges),
+					sizeof(gaudi2_iterator_skip_block_ranges[0]), GFP_KERNEL);
+		if (!prop->skip_special_blocks_cfg.block_ranges) {
+			rc = -ENOMEM;
+			goto free_skip_special_blocks_types;
+		}
+
+		for (i = 0 ; i < ARRAY_SIZE(gaudi2_iterator_skip_block_ranges) ; i++)
+			memcpy(&prop->skip_special_blocks_cfg.block_ranges[i],
+					&gaudi2_iterator_skip_block_ranges[i],
+					sizeof(struct range));
+
+		prop->skip_special_blocks_cfg.block_ranges_len =
+					ARRAY_SIZE(gaudi2_iterator_skip_block_ranges);
+	}
+
+	return 0;
+
+free_skip_special_blocks_types:
+	kfree(prop->skip_special_blocks_cfg.block_types);
+free_special_blocks:
+	kfree(prop->special_blocks);
+
+	return rc;
+}
+
+static int gaudi2_special_blocks_iterator_config(struct hl_device *hdev)
+{
+	return gaudi2_special_blocks_config(hdev);
+}
+
 static int gaudi2_sw_init(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
@@ -3092,8 +3210,15 @@ static int gaudi2_sw_init(struct hl_device *hdev)
 
 	hdev->asic_funcs->set_pci_memory_regions(hdev);
 
+	rc = gaudi2_special_blocks_iterator_config(hdev);
+	if (rc)
+		goto free_scratchpad_mem;
+
 	return 0;
 
+free_scratchpad_mem:
+	hl_asic_dma_pool_free(hdev, gaudi2->scratchpad_kernel_address,
+				gaudi2->scratchpad_bus_address);
 free_virt_msix_db_mem:
 	hl_cpu_accessible_dma_pool_free(hdev, prop->pmmu.page_size, gaudi2->virt_msix_db_cpu_addr);
 free_cpu_accessible_dma_pool:
@@ -3113,6 +3238,8 @@ static int gaudi2_sw_fini(struct hl_device *hdev)
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct gaudi2_device *gaudi2 = hdev->asic_specific;
 
+	gaudi2_special_blocks_iterator_free(hdev);
+
 	hl_cpu_accessible_dma_pool_free(hdev, prop->pmmu.page_size, gaudi2->virt_msix_db_cpu_addr);
 
 	gen_pool_destroy(hdev->cpu_accessible_dma_pool);
@@ -7836,9 +7963,11 @@ static int gaudi2_handle_qm_sei_err(struct hl_device *hdev, u16 event_type,
 		error_count += _gaudi2_handle_qm_sei_err(hdev,
 					qman_base + NIC_QM_OFFSET, event_type);
 
-	if (extended_err_check)
+	if (extended_err_check) {
 		/* check if RAZWI happened */
 		gaudi2_ack_module_razwi_event_handler(hdev, module, 0, 0, event_mask);
+		hl_check_for_glbl_errors(hdev);
+	}
 
 	return error_count;
 }
@@ -7958,6 +8087,8 @@ static int gaudi2_handle_qman_err(struct hl_device *hdev, u16 event_type, u64 *e
 		gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_EDMA, index, 0, event_mask);
 	}
 
+	hl_check_for_glbl_errors(hdev);
+
 	return error_count;
 }
 
@@ -7976,6 +8107,8 @@ static int gaudi2_handle_arc_farm_sei_err(struct hl_device *hdev, u16 event_type
 		}
 	}
 
+	hl_check_for_glbl_errors(hdev);
+
 	WREG32(mmARC_FARM_ARC0_AUX_ARC_SEI_INTR_CLR, sts_clr_val);
 
 	return error_count;
@@ -7996,6 +8129,8 @@ static int gaudi2_handle_cpu_sei_err(struct hl_device *hdev, u16 event_type)
 		}
 	}
 
+	hl_check_for_glbl_errors(hdev);
+
 	WREG32(mmCPU_IF_CPU_SEI_INTR_CLR, sts_clr_val);
 
 	return error_count;
@@ -8018,6 +8153,7 @@ static int gaudi2_handle_rot_err(struct hl_device *hdev, u8 rot_index, u16 event
 
 	/* check if RAZWI happened */
 	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_ROT, rot_index, 0, event_mask);
+	hl_check_for_glbl_errors(hdev);
 
 	return error_count;
 }
@@ -8039,6 +8175,7 @@ static int gaudi2_tpc_ack_interrupts(struct hl_device *hdev,  u8 tpc_index, u16
 
 	/* check if RAZWI happened */
 	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_TPC, tpc_index, 0, event_mask);
+	hl_check_for_glbl_errors(hdev);
 
 	return error_count;
 }
@@ -8072,6 +8209,7 @@ static int gaudi2_handle_dec_err(struct hl_device *hdev, u8 dec_index, u16 event
 
 	/* check if RAZWI happened */
 	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_DEC, dec_index, 0, event_mask);
+	hl_check_for_glbl_errors(hdev);
 
 	/* Write 1 clear errors */
 	WREG32(sts_addr, sts_clr_val);
@@ -8103,6 +8241,8 @@ static int gaudi2_handle_mme_err(struct hl_device *hdev, u8 mme_index, u16 event
 	for (i = MME_WRITE ; i < MME_INITIATORS_MAX ; i++)
 		gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_MME, mme_index, i, event_mask);
 
+	hl_check_for_glbl_errors(hdev);
+
 	WREG32(sts_clr_addr, sts_clr_val);
 
 	return error_count;
@@ -8120,6 +8260,8 @@ static int gaudi2_handle_mme_sbte_err(struct hl_device *hdev, u16 event_type,
 			error_count++;
 		}
 
+	hl_check_for_glbl_errors(hdev);
+
 	return error_count;
 }
 
@@ -8146,6 +8288,7 @@ static int gaudi2_handle_mme_wap_err(struct hl_device *hdev, u8 mme_index, u16 e
 	/* check if RAZWI happened on WAP0/1 */
 	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_MME, mme_index, MME_WAP0, event_mask);
 	gaudi2_ack_module_razwi_event_handler(hdev, RAZWI_MME, mme_index, MME_WAP1, event_mask);
+	hl_check_for_glbl_errors(hdev);
 
 	WREG32(sts_clr_addr, sts_clr_val);
 
@@ -8170,6 +8313,8 @@ static int gaudi2_handle_kdma_core_event(struct hl_device *hdev, u16 event_type,
 			error_count++;
 		}
 
+	hl_check_for_glbl_errors(hdev);
+
 	return error_count;
 }
 
@@ -8186,6 +8331,8 @@ static int gaudi2_handle_dma_core_event(struct hl_device *hdev, u16 event_type,
 			error_count++;
 		}
 
+	hl_check_for_glbl_errors(hdev);
+
 	return error_count;
 }
 
@@ -8238,6 +8385,7 @@ static int gaudi2_print_pcie_addr_dec_info(struct hl_device *hdev, u16 event_typ
 
 		switch (intr_cause_data & BIT_ULL(i)) {
 		case PCIE_WRAP_PCIE_IC_SEI_INTR_IND_AXI_LBW_ERR_INTR_MASK:
+			hl_check_for_glbl_errors(hdev);
 			break;
 		case PCIE_WRAP_PCIE_IC_SEI_INTR_IND_BAD_ACCESS_INTR_MASK:
 			gaudi2_print_pcie_mstr_rr_mstr_if_razwi_info(hdev, event_mask);
@@ -8412,6 +8560,8 @@ static int gaudi2_handle_sm_err(struct hl_device *hdev, u16 event_type, u8 sm_in
 		WREG32(cq_intr_addr, 0);
 	}
 
+	hl_check_for_glbl_errors(hdev);
+
 	return error_count;
 }
 
@@ -8466,6 +8616,7 @@ static int gaudi2_handle_mmu_spi_sei_err(struct hl_device *hdev, u16 event_type,
 
 	error_count = gaudi2_handle_mmu_spi_sei_generic(hdev, event_type, mmu_base,
 							is_pmmu, event_mask);
+	hl_check_for_glbl_errors(hdev);
 
 	return error_count;
 }
@@ -8792,6 +8943,8 @@ static int gaudi2_handle_psoc_drain(struct hl_device *hdev, u64 intr_cause_data)
 		}
 	}
 
+	hl_check_for_glbl_errors(hdev);
+
 	return error_count;
 }
 
diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2P.h b/drivers/accel/habanalabs/gaudi2/gaudi2P.h
index ed09864c2dfc..2687404d9d21 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2P.h
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2P.h
@@ -240,6 +240,8 @@
 #define GAUDI2_SOB_INCREMENT_BY_ONE	(FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_SOB_OBJ_VAL_MASK, 1) | \
 					FIELD_PREP(DCORE0_SYNC_MNGR_OBJS_SOB_OBJ_INC_MASK, 1))
 
+#define GAUDI2_NUM_OF_GLBL_ERR_CAUSE		8
+
 enum gaudi2_reserved_sob_id {
 	GAUDI2_RESERVED_SOB_CS_COMPLETION_FIRST,
 	GAUDI2_RESERVED_SOB_CS_COMPLETION_LAST =
@@ -532,6 +534,41 @@ struct gaudi2_device {
 	u32				num_of_valid_hw_events;
 };
 
+/*
+ * Types of the Gaudi2 IP blocks, used by special blocks iterator.
+ * Required for scenarios where only particular block types can be
+ * addressed (e.g., special PLDM images).
+ */
+enum gaudi2_block_types {
+	GAUDI2_BLOCK_TYPE_PLL,
+	GAUDI2_BLOCK_TYPE_RTR,
+	GAUDI2_BLOCK_TYPE_CPU,
+	GAUDI2_BLOCK_TYPE_HIF,
+	GAUDI2_BLOCK_TYPE_HBM,
+	GAUDI2_BLOCK_TYPE_NIC,
+	GAUDI2_BLOCK_TYPE_PCIE,
+	GAUDI2_BLOCK_TYPE_PCIE_PMA,
+	GAUDI2_BLOCK_TYPE_PDMA,
+	GAUDI2_BLOCK_TYPE_EDMA,
+	GAUDI2_BLOCK_TYPE_PMMU,
+	GAUDI2_BLOCK_TYPE_PSOC,
+	GAUDI2_BLOCK_TYPE_ROT,
+	GAUDI2_BLOCK_TYPE_ARC_FARM,
+	GAUDI2_BLOCK_TYPE_DEC,
+	GAUDI2_BLOCK_TYPE_MME,
+	GAUDI2_BLOCK_TYPE_EU_BIST,
+	GAUDI2_BLOCK_TYPE_SYNC_MNGR,
+	GAUDI2_BLOCK_TYPE_STLB,
+	GAUDI2_BLOCK_TYPE_TPC,
+	GAUDI2_BLOCK_TYPE_HMMU,
+	GAUDI2_BLOCK_TYPE_SRAM,
+	GAUDI2_BLOCK_TYPE_XBAR,
+	GAUDI2_BLOCK_TYPE_KDMA,
+	GAUDI2_BLOCK_TYPE_XDMA,
+	GAUDI2_BLOCK_TYPE_XFT,
+	GAUDI2_BLOCK_TYPE_MAX
+};
+
 extern const u32 gaudi2_dma_core_blocks_bases[DMA_CORE_ID_SIZE];
 extern const u32 gaudi2_qm_blocks_bases[GAUDI2_QUEUE_ID_SIZE];
 extern const u32 gaudi2_mme_acc_blocks_bases[MME_ID_SIZE];
diff --git a/drivers/accel/habanalabs/include/gaudi2/gaudi2_special_blocks.h b/drivers/accel/habanalabs/include/gaudi2/gaudi2_special_blocks.h
new file mode 100644
index 000000000000..a55668f92dd1
--- /dev/null
+++ b/drivers/accel/habanalabs/include/gaudi2/gaudi2_special_blocks.h
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright 2022 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+/*
+ * This file was generated automatically.
+ * DON'T EDIT THIS FILE.
+ */
+
+#ifndef GAUDI2_SPECIAL_BLOCKS_H
+#define GAUDI2_SPECIAL_BLOCKS_H
+
+#define GAUDI2_SPECIAL_BLOCKS { \
+	{ GAUDI2_BLOCK_TYPE_TPC, 0xfc008000, 4, 6, 0, 0x200000, 0x10000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_TPC, 0xfc00a000, 4, 6, 0, 0x200000, 0x10000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_TPC, 0xfc00b000, 4, 6, 0, 0x200000, 0x10000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_TPC, 0xfc00c000, 4, 6, 0, 0x200000, 0x10000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_HMMU, 0xfc080000, 4, 4, 0, 0x200000, 0x10000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_HMMU, 0xfc081000, 4, 4, 0, 0x200000, 0x10000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_HMMU, 0xfc083000, 4, 4, 0, 0x200000, 0x10000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_HMMU, 0xfc084000, 4, 4, 0, 0x200000, 0x10000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_MME, 0xfc0c8000, 4, 0, 0, 0x200000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_MME, 0xfc0c9000, 4, 0, 0, 0x200000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_MME, 0xfc0ca000, 4, 0, 0, 0x200000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_MME, 0xfc0cb000, 4, 0, 0, 0x200000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_MME, 0xfc0cc000, 4, 0, 0, 0x200000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_EU_BIST, 0xfc0cd000, 4, 0, 0, 0x200000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_MME, 0xfc0ce000, 4, 0, 0, 0x200000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_MME, 0xfc0cf000, 4, 0, 0, 0x200000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_MME, 0xfc0d0000, 4, 5, 0, 0x200000, 0x8000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_MME, 0xfc0d1000, 4, 5, 0, 0x200000, 0x8000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_MME, 0xfc0f8000, 4, 0, 0, 0x200000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_MME, 0xfc0f9000, 4, 2, 0, 0x200000, 0x1000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_SYNC_MNGR, 0xfc11e000, 4, 0, 0, 0x200000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_SYNC_MNGR, 0xfc11f000, 4, 0, 0, 0x200000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_HIF, 0xfc120000, 4, 4, 0, 0x200000, 0x4000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_RTR, 0xfc140000, 4, 8, 0, 0x200000, 0x8000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_RTR, 0xfc141000, 4, 8, 0, 0x200000, 0x8000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_RTR, 0xfc142000, 4, 8, 0, 0x200000, 0x8000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_RTR, 0xfc143000, 4, 8, 0, 0x200000, 0x8000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_RTR, 0xfc144000, 4, 8, 0, 0x200000, 0x8000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_RTR, 0xfc145000, 4, 8, 0, 0x200000, 0x8000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_SRAM, 0xfc180000, 4, 8, 0, 0x200000, 0x8000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_RTR, 0xfc181000, 4, 8, 0, 0x200000, 0x8000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_SRAM, 0xfc182000, 4, 8, 0, 0x200000, 0x8000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_EDMA, 0xfc1c8000, 4, 2, 0, 0x200000, 0x10000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_EDMA, 0xfc1ca000, 4, 2, 0, 0x200000, 0x10000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_EDMA, 0xfc1cb000, 4, 2, 0, 0x200000, 0x10000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_EDMA, 0xfc1cc000, 4, 2, 0, 0x200000, 0x10000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_DEC, 0xfc1e3000, 4, 2, 0, 0x200000, 0x10000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_DEC, 0xfc1e4000, 4, 2, 0, 0x200000, 0x10000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_DEC, 0xfc1e5000, 4, 2, 0, 0x200000, 0x10000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PCIE, 0xfcc01000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PCIE, 0xfcc04000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PCIE, 0xfcc07000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PCIE, 0xfcc10000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PCIE, 0xfcc14000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PCIE, 0xfcc15000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PCIE, 0xfcc16000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PSOC, 0xfcc4a000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PSOC, 0xfcc4b000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PSOC, 0xfcc4e000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PSOC, 0xfcc4f000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PSOC, 0xfcc53000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PSOC, 0xfcc54000, 2, 0, 0, 0x1000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PSOC, 0xfcc58000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PSOC, 0xfcc59000, 2, 0, 0, 0x3000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PSOC, 0xfcc5a000, 2, 0, 0, 0x3000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PSOC, 0xfcc5b000, 2, 0, 0, 0x3000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PSOC, 0xfcc60000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PSOC, 0xfcc61000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PSOC, 0xfcc62000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PSOC, 0xfcc63000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PSOC, 0xfcc64000, 3, 0, 0, 0x1000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PLL, 0xfcc6c000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PLL, 0xfcc6d000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PLL, 0xfcc6e000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PSOC, 0xfcc74000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PSOC, 0xfcc76000, 3, 0, 0, 0x1000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PSOC, 0xfcc79000, 2, 0, 0, 0x1000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PSOC, 0xfcc7b000, 3, 0, 0, 0x1000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PSOC, 0xfcc7f000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PDMA, 0xfcc88000, 2, 0, 0, 0x10000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PDMA, 0xfcc8a000, 2, 0, 0, 0x10000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PDMA, 0xfcc8b000, 2, 0, 0, 0x10000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PDMA, 0xfcc8c000, 2, 0, 0, 0x10000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_CPU, 0xfccc0000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_CPU, 0xfccc1000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_CPU, 0xfccc3000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PMMU, 0xfcd00000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PMMU, 0xfcd01000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PMMU, 0xfcd02000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PMMU, 0xfcd03000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PLL, 0xfcd04000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PLL, 0xfcd05000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_XBAR, 0xfcd40000, 4, 0, 0, 0x10000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PLL, 0xfcd41000, 4, 0, 0, 0x10000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PLL, 0xfcd42000, 4, 0, 0, 0x10000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PLL, 0xfcd43000, 4, 0, 0, 0x10000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PLL, 0xfcd44000, 2, 0, 0, 0x10000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_XBAR, 0xfcd48000, 4, 0, 0, 0x10000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PLL, 0xfcd55000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PLL, 0xfcd64000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PLL, 0xfcd65000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PLL, 0xfcd74000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_ROT, 0xfce08000, 2, 0, 0, 0x10000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_ROT, 0xfce0a000, 2, 0, 0, 0x10000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_ROT, 0xfce0b000, 2, 0, 0, 0x10000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_ROT, 0xfce0c000, 2, 0, 0, 0x10000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_RTR, 0xfce40000, 4, 2, 0, 0x10000, 0x4000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_RTR, 0xfce41000, 4, 2, 0, 0x10000, 0x4000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_RTR, 0xfce42000, 4, 2, 0, 0x10000, 0x4000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_RTR, 0xfce43000, 4, 2, 0, 0x10000, 0x4000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_RTR, 0xfce48000, 4, 0, 0, 0x10000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_RTR, 0xfce49000, 4, 0, 0, 0x10000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_RTR, 0xfce4a000, 4, 0, 0, 0x10000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_RTR, 0xfce4b000, 4, 0, 0, 0x10000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_RTR, 0xfce4c000, 4, 0, 0, 0x10000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_ARC_FARM, 0xfce81000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_ARC_FARM, 0xfce82000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_ARC_FARM, 0xfce88000, 4, 0, 0, 0x20000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_ARC_FARM, 0xfce89000, 4, 0, 0, 0x20000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_ARC_FARM, 0xfce8b000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_ARC_FARM, 0xfce8c000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_ARC_FARM, 0xfce8f000, 4, 0, 0, 0x20000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_DEC, 0xfcf03000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_DEC, 0xfcf04000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_DEC, 0xfcf05000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_XFT, 0xfcf40000, 4, 0, 0, 0x10000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PLL, 0xfcf41000, 4, 0, 0, 0x10000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PLL, 0xfcf42000, 4, 0, 0, 0x10000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PLL, 0xfcf43000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PLL, 0xfcf53000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_PLL, 0xfcf73000, 1, 0, 0, 0x0, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_HBM, 0xfd000000, 6, 2, 0, 0x80000, 0x20000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_HBM, 0xfd001000, 6, 2, 8, 0x80000, 0x20000, 0x1000 }, \
+	{ GAUDI2_BLOCK_TYPE_HBM, 0xfd009000, 6, 2, 0, 0x80000, 0x20000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_NIC, 0xfd400000, 12, 2, 15, 0x80000, 0x20000, 0x1000 }, \
+	{ GAUDI2_BLOCK_TYPE_NIC, 0xfd418000, 12, 2, 0, 0x80000, 0x20000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_NIC, 0xfd41a000, 12, 2, 0, 0x80000, 0x20000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_NIC, 0xfd41f000, 12, 2, 0, 0x80000, 0x20000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_NIC, 0xfd448000, 12, 0, 0, 0x80000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_NIC, 0xfd449000, 12, 0, 0, 0x80000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_NIC, 0xfd44a000, 12, 2, 0, 0x80000, 0x1000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_NIC, 0xfd44c000, 12, 2, 0, 0x80000, 0x1000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_NIC, 0xfd450000, 12, 2, 0, 0x80000, 0x1000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_NIC, 0xfd452000, 12, 2, 0, 0x80000, 0x1000, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_NIC, 0xfd454000, 12, 0, 0, 0x80000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_NIC, 0xfd455000, 12, 0, 0, 0x80000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_NIC, 0xfd460000, 12, 0, 0, 0x80000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_NIC, 0xfd468000, 12, 0, 0, 0x80000, 0x0, 0x0 }, \
+	{ GAUDI2_BLOCK_TYPE_NIC, 0xfd469000, 12, 0, 0, 0x80000, 0x0, 0x0 }, \
+}
+
+#endif
-- 
2.25.1

