Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5936459A7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiLGMOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 07:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiLGMOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:14:20 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706164B984;
        Wed,  7 Dec 2022 04:14:11 -0800 (PST)
Received: from localhost (89-26-75-29.goll.dyn.salzburg-online.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7F5C56602AA1;
        Wed,  7 Dec 2022 12:14:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670415250;
        bh=3/uRxRGG6yoMOueEiyzHipSTKqqb+LGZzRwkwl5AGpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bAGvs3QdM74tQDYLLFpboM6COmQ3paw2vUq3y30vEh6BwTeiKlr9YXpqJV7g2ui/5
         hSiJIRi7oV5mCibrfDCYbCJSAidydDhYCNA4VipZxKCw3a2TA3lW1UWwJU+BCAshhx
         2o2xy2pboudmxOhmRLtN8JrbPO8V/fuSDUNWOmALd991/4Kx/xH5enHxCWP+B5WxZq
         dx0k7VXNdSngKkZqwRpn5O5sHBiH632uH8EQ2lOSbVDxqnYMsQFOFgICjwPcKBdmzl
         0C9r0Dj03CIySq8xDlUm7bhoTaDP5jkYiMSiUyX20RdBhqZvIJKwD0hnd2hBi3pQr0
         s7zfg9hT0Yvhw==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     linux-media@vger.kernel.org, Nas Chung <nas.chung@chipsnmedia.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.com, linux-kernel@vger.kernel.org
Subject: [PATCH v11 2/6] media: chips-media: wave5: Add vpuapi layer
Date:   Wed,  7 Dec 2022 13:13:46 +0100
Message-Id: <20221207121350.66217-3-sebastian.fricke@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221207121350.66217-1-sebastian.fricke@collabora.com>
References: <20221207121350.66217-1-sebastian.fricke@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nas Chung <nas.chung@chipsnmedia.com>

Add the vpuapi layer of the wave5 codec driver.
This layer is used to configure the hardware according
to the parameters.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../platform/chips-media/wave5/wave5-hw.c     | 3359 +++++++++++++++++
 .../chips-media/wave5/wave5-regdefine.h       |  743 ++++
 .../platform/chips-media/wave5/wave5-vdi.c    |  245 ++
 .../platform/chips-media/wave5/wave5-vdi.h    |   67 +
 .../platform/chips-media/wave5/wave5-vpuapi.c | 1040 +++++
 .../platform/chips-media/wave5/wave5-vpuapi.h | 1136 ++++++
 .../chips-media/wave5/wave5-vpuconfig.h       |   90 +
 .../chips-media/wave5/wave5-vpuerror.h        |  454 +++
 .../media/platform/chips-media/wave5/wave5.h  |   94 +
 9 files changed, 7228 insertions(+)
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-hw.c
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-regdefine.h
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vdi.c
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vdi.h
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpuerror.h
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5.h

diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/drivers/media/platform/chips-media/wave5/wave5-hw.c
new file mode 100644
index 000000000000..25705e61cdb3
--- /dev/null
+++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
@@ -0,0 +1,3359 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Wave5 series multi-standard codec IP - wave5 backend logic
+ *
+ * Copyright (C) 2021 CHIPS&MEDIA INC
+ */
+
+#include <linux/iopoll.h>
+#include "wave5-vpu.h"
+#include "wave5.h"
+#include "wave5-regdefine.h"
+
+#define FIO_TIMEOUT			10000000
+#define FIO_CTRL_READY			BIT(31)
+#define FIO_CTRL_WRITE			BIT(16)
+#define VPU_BUSY_CHECK_TIMEOUT		10000000
+#define QUEUE_REPORT_MASK		0xffff
+
+static void wave5_print_reg_err(struct vpu_device *vpu_dev, u32 reg_fail_reason)
+{
+	char *caller = __builtin_return_address(0);
+	struct device *dev = vpu_dev->dev;
+	u32 reg_val;
+
+	switch (reg_fail_reason) {
+	case WAVE5_SYSERR_QUEUEING_FAIL:
+		reg_val = vpu_read_reg(vpu_dev, W5_RET_QUEUE_FAIL_REASON);
+		dev_dbg(dev, "%s: queueing failure: 0x%x\n", caller, reg_val);
+		break;
+	case WAVE5_SYSERR_RESULT_NOT_READY:
+		dev_err(dev, "%s: result not ready: 0x%x\n", caller, reg_fail_reason);
+		break;
+	case WAVE5_SYSERR_ACCESS_VIOLATION_HW:
+		dev_err(dev, "%s: access violation: 0x%x\n", caller, reg_fail_reason);
+		break;
+	case WAVE5_SYSERR_WATCHDOG_TIMEOUT:
+		dev_err(dev, "%s: watchdog timeout: 0x%x\n", caller, reg_fail_reason);
+		break;
+	case WAVE5_SYSERR_BUS_ERROR:
+		dev_err(dev, "%s: bus error: 0x%x\n", caller, reg_fail_reason);
+		break;
+	case WAVE5_SYSERR_DOUBLE_FAULT:
+		dev_err(dev, "%s: double fault: 0x%x\n", caller, reg_fail_reason);
+		break;
+	case WAVE5_SYSERR_VPU_STILL_RUNNING:
+		dev_err(dev, "%s: still running: 0x%x\n", caller, reg_fail_reason);
+		break;
+	case WAVE5_SYSERR_VLC_BUF_FULL:
+		dev_err(dev, "%s: vlc buf full: 0x%x\n", caller, reg_fail_reason);
+		break;
+	default:
+		dev_err(dev, "%s: failure:: 0x%x\n", caller, reg_fail_reason);
+		break;
+	}
+}
+
+static int wave5_wait_fio_readl(struct vpu_device *vpu_dev, u32 addr, u32 val)
+{
+	u32 ctrl;
+	int ret;
+
+	ctrl = addr & 0xffff;
+	wave5_vdi_write_register(vpu_dev, W5_VPU_FIO_CTRL_ADDR, ctrl);
+	ret = read_poll_timeout(wave5_vdi_readl, ctrl, ctrl & FIO_CTRL_READY,
+				0, FIO_TIMEOUT, false, vpu_dev, W5_VPU_FIO_CTRL_ADDR);
+	if (ret)
+		return ret;
+	if (wave5_vdi_readl(vpu_dev, W5_VPU_FIO_DATA) != val)
+		return -ETIMEDOUT;
+	return 0;
+}
+
+static void wave5_fio_writel(struct vpu_device *vpu_dev, unsigned int addr, unsigned int data)
+{
+	int ret;
+	unsigned int ctrl;
+
+	wave5_vdi_write_register(vpu_dev, W5_VPU_FIO_DATA, data);
+	ctrl = FIO_CTRL_WRITE | (addr & 0xffff);
+	wave5_vdi_write_register(vpu_dev, W5_VPU_FIO_CTRL_ADDR, ctrl);
+	ret = read_poll_timeout(wave5_vdi_readl, ctrl, ctrl & FIO_CTRL_READY, 0, FIO_TIMEOUT,
+				false, vpu_dev, W5_VPU_FIO_CTRL_ADDR);
+	if (ret) {
+		dev_dbg_ratelimited(vpu_dev->dev, "FIO write timeout: addr=0x%x data=%x\n",
+				    ctrl, data);
+	}
+}
+
+static int wave5_wait_bus_busy(struct vpu_device *vpu_dev, unsigned int addr)
+{
+	u32 gdi_status_check_value = 0x3f;
+
+	if (vpu_dev->product_code == WAVE521C_CODE ||
+	    vpu_dev->product_code == WAVE521_CODE ||
+	    vpu_dev->product_code == WAVE521E1_CODE)
+		gdi_status_check_value = 0x00ff1f3f;
+
+	return wave5_wait_fio_readl(vpu_dev, addr, gdi_status_check_value);
+}
+
+static int wave5_wait_vpu_busy(struct vpu_device *vpu_dev, unsigned int addr)
+{
+	u32 data;
+
+	return read_poll_timeout(wave5_vdi_readl, data, data == 0,
+				 0, VPU_BUSY_CHECK_TIMEOUT, false, vpu_dev, addr);
+}
+
+static int wave5_wait_vcpu_bus_busy(struct vpu_device *vpu_dev, unsigned int addr)
+{
+	return wave5_wait_fio_readl(vpu_dev, addr, 0);
+}
+
+bool wave5_vpu_is_init(struct vpu_device *vpu_dev)
+{
+	return vpu_read_reg(vpu_dev, W5_VCPU_CUR_PC) != 0;
+}
+
+unsigned int wave5_vpu_get_product_id(struct vpu_device *vpu_dev)
+{
+	unsigned int product_id = PRODUCT_ID_NONE;
+	u32 val;
+
+	val = vpu_read_reg(vpu_dev, W5_PRODUCT_NUMBER);
+
+	switch (val) {
+	case WAVE521_CODE:
+	case WAVE521C_CODE:
+	case WAVE521C_DUAL_CODE:
+	case WAVE521E1_CODE:
+		product_id = PRODUCT_ID_521;
+		break;
+	case WAVE511_CODE:
+		product_id = PRODUCT_ID_511;
+		break;
+	case WAVE517_CODE:
+	case WAVE537_CODE:
+		product_id = PRODUCT_ID_517;
+		break;
+	default:
+		dev_err(vpu_dev->dev, "Invalid product id (%x)\n", val);
+		break;
+	}
+	return product_id;
+}
+
+void wave5_bit_issue_command(struct vpu_instance *inst, u32 cmd)
+{
+	u32 instance_index = inst->id;
+	u32 codec_mode = inst->std;
+
+	vpu_write_reg(inst->dev, W5_CMD_INSTANCE_INFO, (codec_mode << 16) |
+			(instance_index & 0xffff));
+	vpu_write_reg(inst->dev, W5_VPU_BUSY_STATUS, 1);
+	vpu_write_reg(inst->dev, W5_COMMAND, cmd);
+
+	dev_dbg(inst->dev->dev, "%s: cmd=0x%x\n", __func__, cmd);
+
+	vpu_write_reg(inst->dev, W5_VPU_HOST_INT_REQ, 1);
+}
+
+static int wave5_send_query(struct vpu_instance *inst, enum QUERY_OPT query_opt)
+{
+	int ret;
+
+	vpu_write_reg(inst->dev, W5_QUERY_OPTION, query_opt);
+	vpu_write_reg(inst->dev, W5_VPU_BUSY_STATUS, 1);
+	wave5_bit_issue_command(inst, W5_QUERY);
+
+	ret = wave5_wait_vpu_busy(inst->dev, W5_VPU_BUSY_STATUS);
+	if (ret) {
+		dev_warn(inst->dev->dev, "command: 'W5_QUERY', timed out opt=0x%x\n", query_opt);
+		return ret;
+	}
+
+	if (!vpu_read_reg(inst->dev, W5_RET_SUCCESS))
+		return -EIO;
+
+	return 0;
+}
+
+static int setup_wave5_properties(struct device *dev)
+{
+	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
+	struct vpu_attr *p_attr = &vpu_dev->attr;
+	u32 reg_val;
+	u8 *str;
+	int ret;
+	u32 hw_config_def0, hw_config_def1, hw_config_feature, hw_config_rev;
+
+	vpu_write_reg(vpu_dev, W5_QUERY_OPTION, GET_VPU_INFO);
+	vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 1);
+	vpu_write_reg(vpu_dev, W5_COMMAND, W5_QUERY);
+	vpu_write_reg(vpu_dev, W5_VPU_HOST_INT_REQ, 1);
+	ret = wave5_wait_vpu_busy(vpu_dev, W5_VPU_BUSY_STATUS);
+	if (ret)
+		return ret;
+
+	if (!vpu_read_reg(vpu_dev, W5_RET_SUCCESS))
+		return -EIO;
+
+	reg_val = vpu_read_reg(vpu_dev, W5_RET_PRODUCT_NAME);
+	str = (u8 *)&reg_val;
+	p_attr->product_name[0] = str[3];
+	p_attr->product_name[1] = str[2];
+	p_attr->product_name[2] = str[1];
+	p_attr->product_name[3] = str[0];
+	p_attr->product_name[4] = 0;
+
+	p_attr->product_id = wave5_vpu_get_product_id(vpu_dev);
+	p_attr->product_version = vpu_read_reg(vpu_dev, W5_RET_PRODUCT_VERSION);
+	p_attr->fw_version = vpu_read_reg(vpu_dev, W5_RET_FW_VERSION);
+	p_attr->customer_id = vpu_read_reg(vpu_dev, W5_RET_CUSTOMER_ID);
+	hw_config_def0 = vpu_read_reg(vpu_dev, W5_RET_STD_DEF0);
+	hw_config_def1 = vpu_read_reg(vpu_dev, W5_RET_STD_DEF1);
+	hw_config_feature = vpu_read_reg(vpu_dev, W5_RET_CONF_FEATURE);
+	hw_config_rev = vpu_read_reg(vpu_dev, W5_RET_CONF_REVISION);
+
+	p_attr->support_hevc10bit_enc = (hw_config_feature >> 3) & 1;
+	if (hw_config_rev > 167455) //20190321
+		p_attr->support_avc10bit_enc = (hw_config_feature >> 11) & 1;
+	else
+		p_attr->support_avc10bit_enc = p_attr->support_hevc10bit_enc;
+
+	p_attr->support_decoders = 0;
+	p_attr->support_encoders = 0;
+	if (p_attr->product_id == PRODUCT_ID_521) {
+		p_attr->support_dual_core = ((hw_config_def1 >> 26) & 0x01);
+		if (p_attr->support_dual_core || hw_config_rev < 206116) {
+			p_attr->support_decoders = BIT(STD_AVC);
+			p_attr->support_decoders |= BIT(STD_HEVC);
+			p_attr->support_encoders = BIT(STD_AVC);
+			p_attr->support_encoders |= BIT(STD_HEVC);
+		} else {
+			p_attr->support_decoders |= (((hw_config_def1 >> 3) & 0x01) << STD_AVC);
+			p_attr->support_decoders |= (((hw_config_def1 >> 2) & 0x01) << STD_HEVC);
+			p_attr->support_encoders = (((hw_config_def1 >> 1) & 0x01) << STD_AVC);
+			p_attr->support_encoders |= ((hw_config_def1 & 0x01) << STD_HEVC);
+		}
+	} else if (p_attr->product_id == PRODUCT_ID_511) {
+		p_attr->support_decoders = BIT(STD_HEVC);
+		p_attr->support_decoders |= BIT(STD_AVC);
+	} else if (p_attr->product_id == PRODUCT_ID_517) {
+		p_attr->support_decoders = (((hw_config_def1 >> 4) & 0x01) << STD_AV1);
+		p_attr->support_decoders |= (((hw_config_def1 >> 3) & 0x01) << STD_AVS2);
+		p_attr->support_decoders |= (((hw_config_def1 >> 2) & 0x01) << STD_AVC);
+		p_attr->support_decoders |= (((hw_config_def1 >> 1) & 0x01) << STD_VP9);
+		p_attr->support_decoders |= ((hw_config_def1 & 0x01) << STD_HEVC);
+	}
+
+	p_attr->support_backbone = (hw_config_def0 >> 16) & 0x01;
+	p_attr->support_vcpu_backbone = (hw_config_def0 >> 28) & 0x01;
+	p_attr->support_vcore_backbone = (hw_config_def0 >> 22) & 0x01;
+	p_attr->support_dual_core = (hw_config_def1 >> 26) & 0x01;
+	p_attr->support_endian_mask = BIT(VDI_LITTLE_ENDIAN) |
+				      BIT(VDI_BIG_ENDIAN) |
+				      BIT(VDI_32BIT_LITTLE_ENDIAN) |
+				      BIT(VDI_32BIT_BIG_ENDIAN) |
+				      (0xffffUL << 16);
+	p_attr->support_bitstream_mode = BIT(BS_MODE_INTERRUPT) |
+		BIT(BS_MODE_PIC_END);
+
+	return 0;
+}
+
+int wave5_vpu_get_version(struct vpu_device *vpu_dev, u32 *revision)
+{
+	u32 reg_val;
+	int ret;
+
+	vpu_write_reg(vpu_dev, W5_QUERY_OPTION, GET_VPU_INFO);
+	vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 1);
+	vpu_write_reg(vpu_dev, W5_COMMAND, W5_QUERY);
+	vpu_write_reg(vpu_dev, W5_VPU_HOST_INT_REQ, 1);
+	ret = wave5_wait_vpu_busy(vpu_dev, W5_VPU_BUSY_STATUS);
+	if (ret) {
+		dev_err(vpu_dev->dev, "%s: timeout\n", __func__);
+		return ret;
+	}
+
+	if (!vpu_read_reg(vpu_dev, W5_RET_SUCCESS)) {
+		dev_err(vpu_dev->dev, "%s: failed\n", __func__);
+		return -EIO;
+	}
+
+	reg_val = vpu_read_reg(vpu_dev, W5_RET_FW_VERSION);
+	if (revision)
+		*revision = reg_val;
+
+	return 0;
+}
+
+static void remap_page(struct vpu_device *vpu_dev, dma_addr_t code_base, u32 index)
+{
+	u32 remap_size = (W5_REMAP_MAX_SIZE >> 12) & 0x1ff;
+	u32 reg_val = 0x80000000 | (WAVE5_UPPER_PROC_AXI_ID << 20) | (index << 12) | BIT(11)
+		| remap_size;
+
+	vpu_write_reg(vpu_dev, W5_VPU_REMAP_CTRL, reg_val);
+	vpu_write_reg(vpu_dev, W5_VPU_REMAP_VADDR, index * W5_REMAP_MAX_SIZE);
+	vpu_write_reg(vpu_dev, W5_VPU_REMAP_PADDR, code_base + index * W5_REMAP_MAX_SIZE);
+}
+
+int wave5_vpu_init(struct device *dev, u8 *fw, size_t size)
+{
+	struct vpu_buf *common_vb;
+	struct dma_vpu_buf *sram_vb;
+	dma_addr_t code_base, temp_base;
+	u32 code_size, temp_size;
+	u32 i, reg_val;
+	int ret;
+	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
+
+	common_vb = &vpu_dev->common_mem;
+
+	code_base = common_vb->daddr;
+	/* ALIGN TO 4KB */
+	code_size = (WAVE5_MAX_CODE_BUF_SIZE & ~0xfff);
+	if (code_size < size * 2)
+		return -EINVAL;
+
+	temp_base = common_vb->daddr + WAVE5_TEMPBUF_OFFSET;
+	temp_size = WAVE5_TEMPBUF_SIZE;
+
+	ret = wave5_vdi_write_memory(vpu_dev, common_vb, 0, fw, size, VDI_128BIT_LITTLE_ENDIAN);
+	if (ret < 0) {
+		dev_err(vpu_dev->dev, "VPU init, Writing firmware to common buffer, fail: %d\n",
+			ret);
+		return ret;
+	}
+
+	vpu_write_reg(vpu_dev, W5_PO_CONF, 0);
+
+	/* clear registers */
+
+	for (i = W5_CMD_REG_BASE; i < W5_CMD_REG_END; i += 4)
+		vpu_write_reg(vpu_dev, i, 0x00);
+
+	remap_page(vpu_dev, code_base, W5_REMAP_INDEX0);
+	remap_page(vpu_dev, code_base, W5_REMAP_INDEX1);
+
+	vpu_write_reg(vpu_dev, W5_ADDR_CODE_BASE, code_base);
+	vpu_write_reg(vpu_dev, W5_CODE_SIZE, code_size);
+	vpu_write_reg(vpu_dev, W5_CODE_PARAM, (WAVE5_UPPER_PROC_AXI_ID << 4) | 0);
+	vpu_write_reg(vpu_dev, W5_ADDR_TEMP_BASE, temp_base);
+	vpu_write_reg(vpu_dev, W5_TEMP_SIZE, temp_size);
+
+	vpu_write_reg(vpu_dev, W5_HW_OPTION, 0);
+
+	reg_val = (WAVE5_PROC_AXI_EXT_ADDR & 0xFFFF);
+	wave5_fio_writel(vpu_dev, W5_BACKBONE_PROC_EXT_ADDR, reg_val);
+	reg_val = ((WAVE5_PROC_AXI_AXPROT & 0x7) << 4) |
+		(WAVE5_PROC_AXI_AXCACHE & 0xF);
+	wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, reg_val);
+	reg_val = ((WAVE5_SEC_AXI_AXPROT & 0x7) << 20) |
+		((WAVE5_SEC_AXI_AXCACHE & 0xF) << 16) |
+		(WAVE5_SEC_AXI_EXT_ADDR & 0xFFFF);
+	vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, reg_val);
+
+	/* interrupt */
+	// encoder
+	reg_val = BIT(INT_WAVE5_ENC_SET_PARAM);
+	reg_val |= BIT(INT_WAVE5_ENC_PIC);
+	reg_val |= BIT(INT_WAVE5_BSBUF_FULL);
+	// decoder
+	reg_val |= BIT(INT_WAVE5_INIT_SEQ);
+	reg_val |= BIT(INT_WAVE5_DEC_PIC);
+	reg_val |= BIT(INT_WAVE5_BSBUF_EMPTY);
+	vpu_write_reg(vpu_dev, W5_VPU_VINT_ENABLE, reg_val);
+
+	reg_val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
+	if ((reg_val >> 16) & 1) {
+		reg_val = ((WAVE5_PROC_AXI_ID << 28) |
+			   (WAVE5_PRP_AXI_ID << 24) |
+			   (WAVE5_FBD_Y_AXI_ID << 20) |
+			   (WAVE5_FBC_Y_AXI_ID << 16) |
+			   (WAVE5_FBD_C_AXI_ID << 12) |
+			   (WAVE5_FBC_C_AXI_ID << 8) |
+			   (WAVE5_PRI_AXI_ID << 4) |
+			   WAVE5_SEC_AXI_ID);
+		wave5_fio_writel(vpu_dev, W5_BACKBONE_PROG_AXI_ID, reg_val);
+	}
+
+	sram_vb = &vpu_dev->sram_buf;
+
+	vpu_write_reg(vpu_dev, W5_ADDR_SEC_AXI, sram_vb->daddr);
+	vpu_write_reg(vpu_dev, W5_SEC_AXI_SIZE, sram_vb->size);
+	vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 1);
+	vpu_write_reg(vpu_dev, W5_COMMAND, W5_INIT_VPU);
+	vpu_write_reg(vpu_dev, W5_VPU_REMAP_CORE_START, 1);
+	ret = wave5_wait_vpu_busy(vpu_dev, W5_VPU_BUSY_STATUS);
+	if (ret) {
+		dev_err(vpu_dev->dev, "VPU init(W5_VPU_REMAP_CORE_START) timeout\n");
+		return ret;
+	}
+
+	reg_val = vpu_read_reg(vpu_dev, W5_RET_SUCCESS);
+	if (!reg_val) {
+		u32 reason_code = vpu_read_reg(vpu_dev, W5_RET_FAIL_REASON);
+
+		wave5_print_reg_err(vpu_dev, reason_code);
+		return -EIO;
+	}
+
+	return setup_wave5_properties(dev);
+}
+
+int wave5_vpu_build_up_dec_param(struct vpu_instance *inst,
+				 struct dec_open_param *param)
+{
+	int ret;
+	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
+	u32 bs_endian;
+	struct dma_vpu_buf *sram_vb;
+	struct vpu_device *vpu_dev = inst->dev;
+
+	p_dec_info->cycle_per_tick = 256;
+	switch (inst->std) {
+	case W_HEVC_DEC:
+		p_dec_info->seq_change_mask = SEQ_CHANGE_ENABLE_ALL_HEVC;
+		break;
+	case W_VP9_DEC:
+		p_dec_info->seq_change_mask = SEQ_CHANGE_ENABLE_ALL_VP9;
+		break;
+	case W_AVS2_DEC:
+		p_dec_info->seq_change_mask = SEQ_CHANGE_ENABLE_ALL_AVS2;
+		break;
+	case W_AVC_DEC:
+		p_dec_info->seq_change_mask = SEQ_CHANGE_ENABLE_ALL_AVC;
+		break;
+	case W_AV1_DEC:
+		p_dec_info->seq_change_mask = SEQ_CHANGE_ENABLE_ALL_AV1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (vpu_dev->product == PRODUCT_ID_517)
+		p_dec_info->vb_work.size = WAVE517_WORKBUF_SIZE;
+	else if (vpu_dev->product == PRODUCT_ID_521)
+		p_dec_info->vb_work.size = WAVE521DEC_WORKBUF_SIZE;
+	else if (vpu_dev->product == PRODUCT_ID_511)
+		p_dec_info->vb_work.size = WAVE521DEC_WORKBUF_SIZE;
+
+	ret = wave5_vdi_allocate_dma_memory(inst->dev, &p_dec_info->vb_work);
+	if (ret)
+		return ret;
+
+	vpu_write_reg(inst->dev, W5_CMD_DEC_VCORE_INFO, 1);
+
+	sram_vb = &vpu_dev->sram_buf;
+	p_dec_info->sec_axi_info.buf_base = sram_vb->daddr;
+	p_dec_info->sec_axi_info.buf_size = sram_vb->size;
+
+	wave5_vdi_clear_memory(inst->dev, &p_dec_info->vb_work);
+
+	vpu_write_reg(inst->dev, W5_ADDR_WORK_BASE, p_dec_info->vb_work.daddr);
+	vpu_write_reg(inst->dev, W5_WORK_SIZE, p_dec_info->vb_work.size);
+
+	vpu_write_reg(inst->dev, W5_CMD_DEC_BS_START_ADDR, p_dec_info->stream_buf_start_addr);
+	vpu_write_reg(inst->dev, W5_CMD_DEC_BS_SIZE, p_dec_info->stream_buf_size);
+
+	/* NOTE: when endian mode is 0, SDMA reads MSB first */
+	bs_endian = wave5_vdi_convert_endian(inst->dev, param->stream_endian);
+	bs_endian = (~bs_endian & VDI_128BIT_ENDIAN_MASK);
+	vpu_write_reg(inst->dev, W5_CMD_BS_PARAM, bs_endian);
+	vpu_write_reg(inst->dev, W5_CMD_EXT_ADDR, (param->pri_axprot << 20) |
+			(param->pri_axcache << 16) | param->pri_ext_addr);
+	vpu_write_reg(inst->dev, W5_CMD_NUM_CQ_DEPTH_M1, (COMMAND_QUEUE_DEPTH - 1));
+	vpu_write_reg(inst->dev, W5_CMD_ERR_CONCEAL, (param->error_conceal_unit << 2) |
+			(param->error_conceal_mode));
+
+	wave5_bit_issue_command(inst, W5_CREATE_INSTANCE);
+	// check QUEUE_DONE
+	ret = wave5_wait_vpu_busy(inst->dev, W5_VPU_BUSY_STATUS);
+	if (ret) {
+		dev_warn(inst->dev->dev, "command: 'W5_CREATE_INSTANCE' timed out\n");
+		goto free_vb_work;
+	}
+
+	// Check if we were able to add the parameters into the VCPU QUEUE
+	if (!vpu_read_reg(inst->dev, W5_RET_SUCCESS)) {
+		ret = -EIO;
+		goto free_vb_work;
+	}
+
+	p_dec_info->product_code = vpu_read_reg(inst->dev, W5_PRODUCT_NUMBER);
+
+	return 0;
+free_vb_work:
+	wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_work);
+	return ret;
+}
+
+int wave5_vpu_dec_init_seq(struct vpu_instance *inst)
+{
+	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
+	u32 cmd_option = INIT_SEQ_NORMAL;
+	u32 reg_val, bs_option;
+	int ret;
+
+	if (!inst->codec_info)
+		return -EINVAL;
+
+	if (p_dec_info->thumbnail_mode)
+		cmd_option = INIT_SEQ_W_THUMBNAIL;
+
+	/* set attributes of bitstream buffer controller */
+	switch (p_dec_info->open_param.bitstream_mode) {
+	case BS_MODE_INTERRUPT:
+		bs_option = BSOPTION_ENABLE_EXPLICIT_END;
+		break;
+	case BS_MODE_PIC_END:
+		bs_option = BSOPTION_ENABLE_EXPLICIT_END;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	vpu_write_reg(inst->dev, W5_BS_RD_PTR, p_dec_info->stream_rd_ptr);
+	vpu_write_reg(inst->dev, W5_BS_WR_PTR, p_dec_info->stream_wr_ptr);
+
+	if (p_dec_info->stream_endflag)
+		bs_option = 3;
+	if (inst->std == W_AV1_DEC)
+		bs_option |= ((p_dec_info->open_param.av1_format) << 2);
+	vpu_write_reg(inst->dev, W5_BS_OPTION, BIT(31) | bs_option);
+
+	vpu_write_reg(inst->dev, W5_COMMAND_OPTION, cmd_option);
+	vpu_write_reg(inst->dev, W5_CMD_DEC_USER_MASK, p_dec_info->user_data_enable);
+
+	wave5_bit_issue_command(inst, W5_INIT_SEQ);
+
+	// check QUEUE_DONE
+	ret = wave5_wait_vpu_busy(inst->dev, W5_VPU_BUSY_STATUS);
+	if (ret) {
+		dev_warn(inst->dev->dev, "command: 'W5_INIT_SEQ', timed out\n");
+		return ret;
+	}
+
+	reg_val = vpu_read_reg(inst->dev, W5_RET_QUEUE_STATUS);
+
+	p_dec_info->instance_queue_count = (reg_val >> 16) & 0xff;
+	p_dec_info->report_queue_count = (reg_val & QUEUE_REPORT_MASK);
+
+	// Check if we were able to add a command into VCPU QUEUE
+	if (!vpu_read_reg(inst->dev, W5_RET_SUCCESS)) {
+		reg_val = vpu_read_reg(inst->dev, W5_RET_FAIL_REASON);
+		wave5_print_reg_err(inst->dev, reg_val);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void wave5_get_dec_seq_result(struct vpu_instance *inst, struct dec_initial_info *info)
+{
+	u32 reg_val, sub_layer_info;
+	u32 profile_compatibility_flag;
+	u32 output_bit_depth_minus8;
+	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
+
+	p_dec_info->stream_rd_ptr = wave5_vpu_dec_get_rd_ptr(inst);
+	info->rd_ptr = p_dec_info->stream_rd_ptr;
+
+	p_dec_info->frame_display_flag = vpu_read_reg(inst->dev, W5_RET_DEC_DISP_IDC);
+
+	reg_val = vpu_read_reg(inst->dev, W5_RET_DEC_PIC_SIZE);
+	info->pic_width = ((reg_val >> 16) & 0xffff);
+	info->pic_height = (reg_val & 0xffff);
+	info->min_frame_buffer_count = vpu_read_reg(inst->dev, W5_RET_DEC_NUM_REQUIRED_FB);
+	info->frame_buf_delay = vpu_read_reg(inst->dev, W5_RET_DEC_NUM_REORDER_DELAY);
+
+	reg_val = vpu_read_reg(inst->dev, W5_RET_DEC_CROP_LEFT_RIGHT);
+	info->pic_crop_rect.left = (reg_val >> 16) & 0xffff;
+	info->pic_crop_rect.right = reg_val & 0xffff;
+	reg_val = vpu_read_reg(inst->dev, W5_RET_DEC_CROP_TOP_BOTTOM);
+	info->pic_crop_rect.top = (reg_val >> 16) & 0xffff;
+	info->pic_crop_rect.bottom = reg_val & 0xffff;
+
+	info->f_rate_numerator = vpu_read_reg(inst->dev, W5_RET_DEC_FRAME_RATE_NR);
+	info->f_rate_denominator = vpu_read_reg(inst->dev, W5_RET_DEC_FRAME_RATE_DR);
+
+	reg_val = vpu_read_reg(inst->dev, W5_RET_DEC_COLOR_SAMPLE_INFO);
+	info->luma_bitdepth = reg_val & 0xf;
+	info->chroma_bitdepth = (reg_val >> 4) & 0xf;
+	info->chroma_format_idc = (reg_val >> 8) & 0xf;
+	info->aspect_rate_info = (reg_val >> 16) & 0xff;
+	info->is_ext_sar = ((info->aspect_rate_info == 255) ? true : false);
+	/* [0:15] - vertical size, [16:31] - horizontal size */
+	if (info->is_ext_sar)
+		info->aspect_rate_info = vpu_read_reg(inst->dev, W5_RET_DEC_ASPECT_RATIO);
+	info->bit_rate = vpu_read_reg(inst->dev, W5_RET_DEC_BIT_RATE);
+
+	sub_layer_info = vpu_read_reg(inst->dev, W5_RET_DEC_SUB_LAYER_INFO);
+	info->max_temporal_layers = (sub_layer_info >> 8) & 0x7;
+
+	reg_val = vpu_read_reg(inst->dev, W5_RET_DEC_SEQ_PARAM);
+	info->level = reg_val & 0xff;
+	profile_compatibility_flag = (reg_val >> 12) & 0xff;
+	info->profile = (reg_val >> 24) & 0x1f;
+	info->tier = (reg_val >> 29) & 0x01;
+	output_bit_depth_minus8 = (reg_val >> 30) & 0x03;
+
+	if (inst->std == W_HEVC_DEC) {
+		/* guessing profile */
+		if (!info->profile) {
+			if ((profile_compatibility_flag & 0x06) == 0x06)
+				info->profile = HEVC_PROFILE_MAIN; /* main profile */
+			else if ((profile_compatibility_flag & 0x04) == 0x04)
+				info->profile = HEVC_PROFILE_MAIN10; /* main10 profile */
+			else if ((profile_compatibility_flag & 0x08) == 0x08)
+				/* main still picture profile */
+				info->profile = HEVC_PROFILE_STILLPICTURE;
+			else
+				info->profile = HEVC_PROFILE_MAIN; /* for old version HM */
+		}
+
+	} else if (inst->std == W_AVS2_DEC) {
+		if (info->luma_bitdepth == 10 && output_bit_depth_minus8 == 2)
+			info->output_bit_depth = 10;
+		else
+			info->output_bit_depth = 8;
+
+	} else if (inst->std == W_AVC_DEC) {
+		info->profile = (reg_val >> 24) & 0x7f;
+	}
+
+	info->vlc_buf_size = vpu_read_reg(inst->dev, W5_RET_VLC_BUF_SIZE);
+	info->param_buf_size = vpu_read_reg(inst->dev, W5_RET_PARAM_BUF_SIZE);
+	p_dec_info->vlc_buf_size = info->vlc_buf_size;
+	p_dec_info->param_buf_size = info->param_buf_size;
+}
+
+int wave5_vpu_dec_get_seq_info(struct vpu_instance *inst, struct dec_initial_info *info)
+{
+	int ret;
+	u32 reg_val;
+	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
+
+	vpu_write_reg(inst->dev, W5_CMD_DEC_ADDR_REPORT_BASE, p_dec_info->user_data_buf_addr);
+	vpu_write_reg(inst->dev, W5_CMD_DEC_REPORT_SIZE, p_dec_info->user_data_buf_size);
+	vpu_write_reg(inst->dev, W5_CMD_DEC_REPORT_PARAM,
+		      VPU_USER_DATA_ENDIAN & VDI_128BIT_ENDIAN_MASK);
+
+	// send QUERY cmd
+	ret = wave5_send_query(inst, GET_RESULT);
+	if (ret) {
+		if (ret == -EIO) {
+			reg_val = vpu_read_reg(inst->dev, W5_RET_FAIL_REASON);
+			wave5_print_reg_err(inst->dev, reg_val);
+		}
+		return ret;
+	}
+
+	dev_dbg(inst->dev->dev, "%s: init seq complete\n", __func__);
+
+	reg_val = vpu_read_reg(inst->dev, W5_RET_QUEUE_STATUS);
+
+	p_dec_info->instance_queue_count = (reg_val >> 16) & 0xff;
+	p_dec_info->report_queue_count = (reg_val & QUEUE_REPORT_MASK);
+
+	/* this is not a fatal error, set ret to -EIO but don't return immediately */
+	if (vpu_read_reg(inst->dev, W5_RET_DEC_DECODING_SUCCESS) != 1) {
+		info->seq_init_err_reason = vpu_read_reg(inst->dev, W5_RET_DEC_ERR_INFO);
+		ret = -EIO;
+	} else {
+		info->warn_info = vpu_read_reg(inst->dev, W5_RET_DEC_WARN_INFO);
+	}
+
+	// get sequence info
+	info->user_data_size = 0;
+	info->user_data_buf_full = false;
+	info->user_data_header = vpu_read_reg(inst->dev, W5_RET_DEC_USERDATA_IDC);
+	if (info->user_data_header) {
+		if (info->user_data_header & BIT(USERDATA_FLAG_BUFF_FULL))
+			info->user_data_buf_full = true;
+		info->user_data_size = p_dec_info->user_data_buf_size;
+	}
+
+	wave5_get_dec_seq_result(inst, info);
+
+	return ret;
+}
+
+static u32 calculate_table_size(u32 bit_depth, u32 frame_width, u32 frame_height, u32 ot_bg_width)
+{
+	u32 bgs_width = ((bit_depth > 8) ? 256 : 512);
+	u32 comp_frame_width = ALIGN(ALIGN(frame_width, 16) + 16, 16);
+	u32 ot_frame_width = ALIGN(comp_frame_width, ot_bg_width);
+
+	// sizeof_offset_table()
+	u32 ot_bg_height = 32;
+	u32 bgs_height = BIT(14) / bgs_width / ((bit_depth > 8) ? 2 : 1);
+	u32 comp_frame_height = ALIGN(ALIGN(frame_height, 4) + 4, bgs_height);
+	u32 ot_frame_height = ALIGN(comp_frame_height, ot_bg_height);
+
+	return (ot_frame_width / 16) * (ot_frame_height / 4) * 2;
+}
+
+int wave5_vpu_dec_register_framebuffer(struct vpu_instance *inst, struct frame_buffer *fb_arr,
+				       enum tiled_map_type map_type, unsigned int count)
+{
+	int ret;
+	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
+	struct dec_initial_info *init_info = &p_dec_info->initial_info;
+	size_t remain, idx, j, i, cnt_8_chunk;
+	u32 start_no, end_no;
+	u32 reg_val, cbcr_interleave, nv21, pic_size;
+	u32 endian, yuv_format;
+	u32 addr_y, addr_cb, addr_cr;
+	u32 table_width = init_info->pic_width;
+	u32 table_height = init_info->pic_height;
+	u32 mv_col_size, frame_width, frame_height, fbc_y_tbl_size, fbc_c_tbl_size;
+	struct vpu_buf vb_buf;
+	u32 color_format = 0;
+	u32 pixel_order = 1;
+	u32 bwb_flag = (map_type == LINEAR_FRAME_MAP) ? 1 : 0;
+
+	cbcr_interleave = inst->cbcr_interleave;
+	nv21 = inst->nv21;
+	mv_col_size = 0;
+	fbc_y_tbl_size = 0;
+	fbc_c_tbl_size = 0;
+
+	if (map_type >= COMPRESSED_FRAME_MAP) {
+		cbcr_interleave = 0;
+		nv21 = 0;
+
+		switch (inst->std) {
+		case W_HEVC_DEC:
+			mv_col_size = WAVE5_DEC_HEVC_BUF_SIZE(init_info->pic_width,
+							      init_info->pic_height);
+			break;
+		case W_VP9_DEC:
+			mv_col_size = WAVE5_DEC_VP9_BUF_SIZE(init_info->pic_width,
+							     init_info->pic_height);
+			table_width = ALIGN(table_width, 64);
+			table_height = ALIGN(table_height, 64);
+			break;
+		case W_AVS2_DEC:
+			mv_col_size = WAVE5_DEC_AVS2_BUF_SIZE(init_info->pic_width,
+							      init_info->pic_height);
+			break;
+		case W_AVC_DEC:
+			mv_col_size = WAVE5_DEC_AVC_BUF_SIZE(init_info->pic_width,
+							     init_info->pic_height);
+			break;
+		case W_AV1_DEC:
+			mv_col_size = WAVE5_DEC_AV1_BUF_SZ_1(init_info->pic_width,
+							     init_info->pic_height) +
+				WAVE5_DEC_AV1_BUF_SZ_2(init_info->pic_width, init_info->pic_width,
+						       init_info->pic_height);
+			table_width = ALIGN(table_width, 16);
+			table_height = ALIGN(table_height, 8);
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		mv_col_size = ALIGN(mv_col_size, 16);
+		vb_buf.daddr = 0;
+		if (inst->std == W_HEVC_DEC || inst->std == W_AVS2_DEC || inst->std ==
+				W_VP9_DEC || inst->std == W_AVC_DEC || inst->std ==
+				W_AV1_DEC) {
+			vb_buf.size = ALIGN(mv_col_size, BUFFER_MARGIN) + BUFFER_MARGIN;
+
+			for (i = 0 ; i < count ; i++) {
+				if (p_dec_info->vb_mv[i].size == 0) {
+					ret = wave5_vdi_allocate_dma_memory(inst->dev, &vb_buf);
+					if (ret)
+						goto free_mv_buffers;
+					p_dec_info->vb_mv[i] = vb_buf;
+				}
+			}
+		}
+
+		frame_width = ALIGN(init_info->pic_width, 16);
+		frame_height = ALIGN(init_info->pic_height, 16);
+		if (p_dec_info->product_code == WAVE521C_DUAL_CODE) {
+			// Use a offset table BG width of 1024 for all decoders
+			fbc_y_tbl_size = calculate_table_size(init_info->luma_bitdepth,
+							      frame_width, frame_height, 1024);
+		} else {
+			fbc_y_tbl_size = ALIGN(WAVE5_FBC_LUMA_TABLE_SIZE(table_width,
+									 table_height), 16);
+		}
+
+		vb_buf.daddr = 0;
+		vb_buf.size = ALIGN(fbc_y_tbl_size, BUFFER_MARGIN) + BUFFER_MARGIN;
+		for (i = 0 ; i < count ; i++) {
+			if (p_dec_info->vb_fbc_y_tbl[i].size == 0) {
+				ret = wave5_vdi_allocate_dma_memory(inst->dev, &vb_buf);
+				if (ret)
+					goto free_fbc_y_tbl_buffers;
+				p_dec_info->vb_fbc_y_tbl[i] = vb_buf;
+			}
+		}
+
+		if (p_dec_info->product_code == WAVE521C_DUAL_CODE) {
+			// Use a offset table BG width of 1024 for all decoders
+			fbc_c_tbl_size = calculate_table_size(init_info->chroma_bitdepth,
+							      frame_width / 2, frame_height, 1024);
+		} else {
+			fbc_c_tbl_size = ALIGN(WAVE5_FBC_CHROMA_TABLE_SIZE(table_width,
+									   table_height), 16);
+		}
+
+		vb_buf.daddr = 0;
+		vb_buf.size = ALIGN(fbc_c_tbl_size, BUFFER_MARGIN) + BUFFER_MARGIN;
+		for (i = 0 ; i < count ; i++) {
+			if (p_dec_info->vb_fbc_c_tbl[i].size == 0) {
+				ret = wave5_vdi_allocate_dma_memory(inst->dev, &vb_buf);
+				if (ret)
+					goto free_fbc_c_tbl_buffers;
+				p_dec_info->vb_fbc_c_tbl[i] = vb_buf;
+			}
+		}
+		pic_size = (init_info->pic_width << 16) | (init_info->pic_height);
+
+		// allocate task_buffer
+		vb_buf.size = (p_dec_info->vlc_buf_size * VLC_BUF_NUM) +
+				(p_dec_info->param_buf_size * COMMAND_QUEUE_DEPTH);
+		vb_buf.daddr = 0;
+		ret = wave5_vdi_allocate_dma_memory(inst->dev, &vb_buf);
+		if (ret)
+			goto free_fbc_c_tbl_buffers;
+
+		p_dec_info->vb_task = vb_buf;
+
+		vpu_write_reg(inst->dev, W5_CMD_SET_FB_ADDR_TASK_BUF,
+			      p_dec_info->vb_task.daddr);
+		vpu_write_reg(inst->dev, W5_CMD_SET_FB_TASK_BUF_SIZE, vb_buf.size);
+	} else {
+		pic_size = (init_info->pic_width << 16) | (init_info->pic_height);
+	}
+	endian = wave5_vdi_convert_endian(inst->dev, fb_arr[0].endian);
+	vpu_write_reg(inst->dev, W5_PIC_SIZE, pic_size);
+
+	yuv_format = 0;
+	color_format = 0;
+
+	reg_val =
+		(bwb_flag << 28) |
+		(pixel_order << 23) | /* PIXEL ORDER in 128bit. first pixel in low address */
+		(yuv_format << 20) |
+		(color_format << 19) |
+		(nv21 << 17) |
+		(cbcr_interleave << 16) |
+		(fb_arr[0].stride);
+	vpu_write_reg(inst->dev, W5_COMMON_PIC_INFO, reg_val);
+
+	remain = count;
+	cnt_8_chunk = ALIGN(count, 8) / 8;
+	idx = 0;
+	for (j = 0; j < cnt_8_chunk; j++) {
+		reg_val = (endian << 16) | (j == cnt_8_chunk - 1) << 4 | ((j == 0) << 3);
+		reg_val |= (p_dec_info->open_param.enable_non_ref_fbc_write << 26);
+		vpu_write_reg(inst->dev, W5_SFB_OPTION, reg_val);
+		start_no = j * 8;
+		end_no = start_no + ((remain >= 8) ? 8 : remain) - 1;
+
+		vpu_write_reg(inst->dev, W5_SET_FB_NUM, (start_no << 8) | end_no);
+
+		for (i = 0; i < 8 && i < remain; i++) {
+			if (map_type == LINEAR_FRAME_MAP && p_dec_info->open_param.cbcr_order ==
+					CBCR_ORDER_REVERSED) {
+				addr_y = fb_arr[i + start_no].buf_y;
+				addr_cb = fb_arr[i + start_no].buf_cr;
+				addr_cr = fb_arr[i + start_no].buf_cb;
+			} else {
+				addr_y = fb_arr[i + start_no].buf_y;
+				addr_cb = fb_arr[i + start_no].buf_cb;
+				addr_cr = fb_arr[i + start_no].buf_cr;
+			}
+			vpu_write_reg(inst->dev, W5_ADDR_LUMA_BASE0 + (i << 4), addr_y);
+			vpu_write_reg(inst->dev, W5_ADDR_CB_BASE0 + (i << 4), addr_cb);
+			if (map_type >= COMPRESSED_FRAME_MAP) {
+				/* luma FBC offset table */
+				vpu_write_reg(inst->dev, W5_ADDR_FBC_Y_OFFSET0 + (i << 4),
+					      p_dec_info->vb_fbc_y_tbl[idx].daddr);
+				/* chroma FBC offset table */
+				vpu_write_reg(inst->dev, W5_ADDR_FBC_C_OFFSET0 + (i << 4),
+					      p_dec_info->vb_fbc_c_tbl[idx].daddr);
+				vpu_write_reg(inst->dev, W5_ADDR_MV_COL0 + (i << 2),
+					      p_dec_info->vb_mv[idx].daddr);
+			} else {
+				vpu_write_reg(inst->dev, W5_ADDR_CR_BASE0 + (i << 4), addr_cr);
+				vpu_write_reg(inst->dev, W5_ADDR_FBC_C_OFFSET0 + (i << 4), 0);
+				vpu_write_reg(inst->dev, W5_ADDR_MV_COL0 + (i << 2), 0);
+			}
+			idx++;
+		}
+		remain -= i;
+
+		wave5_bit_issue_command(inst, W5_SET_FB);
+		ret = wave5_wait_vpu_busy(inst->dev, W5_VPU_BUSY_STATUS);
+		if (ret)
+			goto free_buffers;
+	}
+
+	reg_val = vpu_read_reg(inst->dev, W5_RET_SUCCESS);
+	if (!reg_val) {
+		ret = -EIO;
+		goto free_buffers;
+	}
+
+	return 0;
+
+free_buffers:
+	wave5_vdi_free_dma_memory(inst->dev, &p_dec_info->vb_task);
+free_fbc_c_tbl_buffers:
+	for (i = 0; i < count; i++)
+		wave5_vdi_free_dma_memory(inst->dev, &p_dec_info->vb_fbc_c_tbl[i]);
+free_fbc_y_tbl_buffers:
+	for (i = 0; i < count; i++)
+		wave5_vdi_free_dma_memory(inst->dev, &p_dec_info->vb_fbc_y_tbl[i]);
+free_mv_buffers:
+	for (i = 0; i < count; i++)
+		wave5_vdi_free_dma_memory(inst->dev, &p_dec_info->vb_mv[i]);
+	return ret;
+}
+
+int wave5_vpu_decode(struct vpu_instance *inst, struct dec_param *option, u32 *fail_res)
+{
+	u32 mode_option = DEC_PIC_NORMAL, bs_option, reg_val;
+	u32 force_latency = 0;
+	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
+	struct dec_open_param *p_open_param = &p_dec_info->open_param;
+	int ret;
+
+	if (p_dec_info->thumbnail_mode) {
+		mode_option = DEC_PIC_W_THUMBNAIL;
+	} else if (option->skipframe_mode) {
+		switch (option->skipframe_mode) {
+		case WAVE_SKIPMODE_NON_IRAP:
+			mode_option = SKIP_NON_IRAP;
+			force_latency = 1;
+			break;
+		case WAVE_SKIPMODE_NON_REF:
+			mode_option = SKIP_NON_REF_PIC;
+			break;
+		default:
+			// skip mode off
+			break;
+		}
+	}
+
+	// set disable reorder
+	if (!p_dec_info->reorder_enable)
+		force_latency = 1;
+
+	/* set attributes of bitstream buffer controller */
+	bs_option = 0;
+	switch (p_open_param->bitstream_mode) {
+	case BS_MODE_INTERRUPT:
+		bs_option = BSOPTION_ENABLE_EXPLICIT_END;
+		break;
+	case BS_MODE_PIC_END:
+		bs_option = BSOPTION_ENABLE_EXPLICIT_END;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	vpu_write_reg(inst->dev, W5_BS_RD_PTR, p_dec_info->stream_rd_ptr);
+	vpu_write_reg(inst->dev, W5_BS_WR_PTR, p_dec_info->stream_wr_ptr);
+	bs_option = (p_dec_info->stream_endflag << 1) | BS_EXPLICIT_END_MODE_ON;
+	if (p_open_param->bitstream_mode == BS_MODE_PIC_END)
+		bs_option |= BIT(31);
+	if (inst->std == W_AV1_DEC)
+		bs_option |= ((p_open_param->av1_format) << 2);
+	vpu_write_reg(inst->dev, W5_BS_OPTION, bs_option);
+
+	/* secondary AXI */
+	reg_val = p_dec_info->sec_axi_info.wave.use_bit_enable |
+		(p_dec_info->sec_axi_info.wave.use_ip_enable << 9) |
+		(p_dec_info->sec_axi_info.wave.use_lf_row_enable << 15);
+	vpu_write_reg(inst->dev, W5_USE_SEC_AXI, reg_val);
+
+	/* set attributes of user buffer */
+	vpu_write_reg(inst->dev, W5_CMD_DEC_USER_MASK, p_dec_info->user_data_enable);
+
+	vpu_write_reg(inst->dev, W5_COMMAND_OPTION,
+		      ((option->disable_film_grain << 6) | (option->cra_as_bla_flag << 5) |
+		      mode_option));
+	vpu_write_reg(inst->dev, W5_CMD_DEC_TEMPORAL_ID_PLUS1,
+		      (p_dec_info->target_spatial_id << 9) |
+		      (p_dec_info->temp_id_select_mode << 8) | p_dec_info->target_temp_id);
+	vpu_write_reg(inst->dev, W5_CMD_SEQ_CHANGE_ENABLE_FLAG, p_dec_info->seq_change_mask);
+	vpu_write_reg(inst->dev, W5_CMD_DEC_FORCE_FB_LATENCY_PLUS1, force_latency);
+
+	wave5_bit_issue_command(inst, W5_DEC_PIC);
+	// check QUEUE_DONE
+	ret = wave5_wait_vpu_busy(inst->dev, W5_VPU_BUSY_STATUS);
+	if (ret) {
+		dev_warn(inst->dev->dev, "command: 'W5_DEC_PIC', timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	reg_val = vpu_read_reg(inst->dev, W5_RET_QUEUE_STATUS);
+
+	p_dec_info->instance_queue_count = (reg_val >> 16) & 0xff;
+	p_dec_info->report_queue_count = (reg_val & QUEUE_REPORT_MASK);
+	// Check if we were able to add a command into the VCPU QUEUE
+	if (!vpu_read_reg(inst->dev, W5_RET_SUCCESS)) {
+		*fail_res = vpu_read_reg(inst->dev, W5_RET_FAIL_REASON);
+		wave5_print_reg_err(inst->dev, *fail_res);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int wave5_vpu_dec_get_result(struct vpu_instance *inst, struct dec_output_info *result)
+{
+	int ret;
+	u32 index, nal_unit_type, reg_val, sub_layer_info;
+	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
+	struct vpu_device *vpu_dev = inst->dev;
+
+	vpu_write_reg(inst->dev, W5_CMD_DEC_ADDR_REPORT_BASE, p_dec_info->user_data_buf_addr);
+	vpu_write_reg(inst->dev, W5_CMD_DEC_REPORT_SIZE, p_dec_info->user_data_buf_size);
+	vpu_write_reg(inst->dev, W5_CMD_DEC_REPORT_PARAM,
+		      VPU_USER_DATA_ENDIAN & VDI_128BIT_ENDIAN_MASK);
+
+	// send QUERY cmd
+	ret = wave5_send_query(inst, GET_RESULT);
+	if (ret) {
+		if (ret == -EIO) {
+			reg_val = vpu_read_reg(inst->dev, W5_RET_FAIL_REASON);
+			wave5_print_reg_err(inst->dev, reg_val);
+		}
+
+		return ret;
+	}
+
+	dev_dbg(inst->dev->dev, "%s: dec pic complete\n", __func__);
+
+	reg_val = vpu_read_reg(inst->dev, W5_RET_QUEUE_STATUS);
+
+	p_dec_info->instance_queue_count = (reg_val >> 16) & 0xff;
+	p_dec_info->report_queue_count = (reg_val & QUEUE_REPORT_MASK);
+
+	reg_val = vpu_read_reg(inst->dev, W5_RET_DEC_PIC_TYPE);
+
+	nal_unit_type = (reg_val >> 4) & 0x3f;
+
+	if (inst->std == W_VP9_DEC) {
+		if (reg_val & 0x01)
+			result->pic_type = PIC_TYPE_I;
+		else if (reg_val & 0x02)
+			result->pic_type = PIC_TYPE_P;
+		else if (reg_val & 0x04)
+			result->pic_type = PIC_TYPE_REPEAT;
+		else
+			result->pic_type = PIC_TYPE_MAX;
+	} else if (inst->std == W_HEVC_DEC) {
+		if (reg_val & 0x04)
+			result->pic_type = PIC_TYPE_B;
+		else if (reg_val & 0x02)
+			result->pic_type = PIC_TYPE_P;
+		else if (reg_val & 0x01)
+			result->pic_type = PIC_TYPE_I;
+		else
+			result->pic_type = PIC_TYPE_MAX;
+		if ((nal_unit_type == 19 || nal_unit_type == 20) && result->pic_type == PIC_TYPE_I)
+			/* IDR_W_RADL, IDR_N_LP */
+			result->pic_type = PIC_TYPE_IDR;
+	} else if (inst->std == W_AVC_DEC) {
+		if (reg_val & 0x04)
+			result->pic_type = PIC_TYPE_B;
+		else if (reg_val & 0x02)
+			result->pic_type = PIC_TYPE_P;
+		else if (reg_val & 0x01)
+			result->pic_type = PIC_TYPE_I;
+		else
+			result->pic_type = PIC_TYPE_MAX;
+		if (nal_unit_type == 5 && result->pic_type == PIC_TYPE_I)
+			result->pic_type = PIC_TYPE_IDR;
+	} else if (inst->std == W_AV1_DEC) {
+		switch (reg_val & 0x07) {
+		case 0:
+			result->pic_type = PIC_TYPE_KEY;
+			break;
+		case 1:
+			result->pic_type = PIC_TYPE_INTER;
+			break;
+		case 2:
+			result->pic_type = PIC_TYPE_AV1_INTRA;
+			break;
+		case 3:
+			result->pic_type = PIC_TYPE_AV1_SWITCH;
+			break;
+		default:
+			result->pic_type = PIC_TYPE_MAX;
+			break;
+		}
+	} else { // AVS2
+		switch (reg_val & 0x07) {
+		case 0:
+			result->pic_type = PIC_TYPE_I;
+			break;
+		case 1:
+			result->pic_type = PIC_TYPE_P;
+			break;
+		case 2:
+			result->pic_type = PIC_TYPE_B;
+			break;
+		case 3:
+			result->pic_type = PIC_TYPE_AVS2_F;
+			break;
+		case 4:
+			result->pic_type = PIC_TYPE_AVS2_S;
+			break;
+		case 5:
+			result->pic_type = PIC_TYPE_AVS2_G;
+			break;
+		case 6:
+			result->pic_type = PIC_TYPE_AVS2_GB;
+			break;
+		default:
+			result->pic_type = PIC_TYPE_MAX;
+			break;
+		}
+	}
+	index = vpu_read_reg(inst->dev, W5_RET_DEC_DISPLAY_INDEX);
+	result->index_frame_display = index;
+	index = vpu_read_reg(inst->dev, W5_RET_DEC_DECODED_INDEX);
+	result->index_frame_decoded = index;
+	result->index_frame_decoded_for_tiled = index;
+
+	sub_layer_info = vpu_read_reg(inst->dev, W5_RET_DEC_SUB_LAYER_INFO);
+	result->temporal_id = sub_layer_info & 0x7;
+
+	if (inst->std == W_HEVC_DEC) {
+		result->decoded_poc = -1;
+		if (result->index_frame_decoded >= 0 ||
+		    result->index_frame_decoded == DECODED_IDX_FLAG_SKIP)
+			result->decoded_poc = vpu_read_reg(inst->dev, W5_RET_DEC_PIC_POC);
+	} else if (inst->std == W_AVS2_DEC) {
+		result->avs2_info.decoded_poi = -1;
+		result->avs2_info.display_poi = -1;
+		if (result->index_frame_decoded >= 0)
+			result->avs2_info.decoded_poi =
+				vpu_read_reg(inst->dev, W5_RET_DEC_PIC_POC);
+	} else if (inst->std == W_AVC_DEC) {
+		result->decoded_poc = -1;
+		if (result->index_frame_decoded >= 0 ||
+		    result->index_frame_decoded == DECODED_IDX_FLAG_SKIP)
+			result->decoded_poc = vpu_read_reg(inst->dev, W5_RET_DEC_PIC_POC);
+	} else if (inst->std == W_AV1_DEC) {
+		result->decoded_poc = -1;
+		if (result->index_frame_decoded >= 0 ||
+		    result->index_frame_decoded == DECODED_IDX_FLAG_SKIP)
+			result->decoded_poc = vpu_read_reg(inst->dev, W5_RET_DEC_PIC_POC);
+	}
+
+	result->sequence_changed = vpu_read_reg(inst->dev, W5_RET_DEC_NOTIFICATION);
+	reg_val = vpu_read_reg(inst->dev, W5_RET_DEC_PIC_SIZE);
+	result->dec_pic_width = reg_val >> 16;
+	result->dec_pic_height = reg_val & 0xffff;
+
+	if (result->sequence_changed) {
+		memcpy((void *)&p_dec_info->new_seq_info, (void *)&p_dec_info->initial_info,
+		       sizeof(struct dec_initial_info));
+		wave5_get_dec_seq_result(inst, &p_dec_info->new_seq_info);
+	}
+
+	result->dec_host_cmd_tick = vpu_read_reg(inst->dev, W5_RET_DEC_HOST_CMD_TICK);
+	result->dec_decode_end_tick = vpu_read_reg(inst->dev, W5_RET_DEC_DECODING_ENC_TICK);
+
+	if (!p_dec_info->first_cycle_check) {
+		result->frame_cycle =
+			(result->dec_decode_end_tick - result->dec_host_cmd_tick) *
+			p_dec_info->cycle_per_tick;
+		vpu_dev->last_performance_cycles = result->dec_decode_end_tick;
+		p_dec_info->first_cycle_check = true;
+	} else if (result->index_frame_decoded_for_tiled != -1) {
+		result->frame_cycle =
+			(result->dec_decode_end_tick - vpu_dev->last_performance_cycles) *
+			p_dec_info->cycle_per_tick;
+		vpu_dev->last_performance_cycles = result->dec_decode_end_tick;
+		if (vpu_dev->last_performance_cycles < result->dec_host_cmd_tick)
+			result->frame_cycle =
+				(result->dec_decode_end_tick - result->dec_host_cmd_tick) *
+				p_dec_info->cycle_per_tick;
+	}
+
+	// no remaining command. reset frame cycle.
+	if (p_dec_info->instance_queue_count == 0 && p_dec_info->report_queue_count == 0)
+		p_dec_info->first_cycle_check = false;
+
+	return 0;
+}
+
+int wave5_vpu_re_init(struct device *dev, u8 *fw, size_t size)
+{
+	struct vpu_buf *common_vb;
+	dma_addr_t code_base, temp_base;
+	dma_addr_t old_code_base, temp_size;
+	u32 code_size;
+	u32 reg_val;
+	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
+
+	common_vb = &vpu_dev->common_mem;
+
+	code_base = common_vb->daddr;
+	/* ALIGN TO 4KB */
+	code_size = (WAVE5_MAX_CODE_BUF_SIZE & ~0xfff);
+	if (code_size < size * 2)
+		return -EINVAL;
+	temp_base = common_vb->daddr + WAVE5_TEMPBUF_OFFSET;
+	temp_size = WAVE5_TEMPBUF_SIZE;
+
+	old_code_base = vpu_read_reg(vpu_dev, W5_VPU_REMAP_PADDR);
+
+	if (old_code_base != code_base + W5_REMAP_INDEX1 * W5_REMAP_MAX_SIZE) {
+		int ret;
+		struct dma_vpu_buf *sram_vb;
+
+		ret = wave5_vdi_write_memory(vpu_dev, common_vb, 0, fw, size,
+					     VDI_128BIT_LITTLE_ENDIAN);
+		if (ret < 0) {
+			dev_err(vpu_dev->dev,
+				"VPU init, Writing firmware to common buffer, fail: %d\n", ret);
+			return ret;
+		}
+
+		vpu_write_reg(vpu_dev, W5_PO_CONF, 0);
+
+		ret = wave5_vpu_reset(dev, SW_RESET_ON_BOOT);
+		if (ret < 0) {
+			dev_err(vpu_dev->dev, "VPU init, Resetting the VPU, fail: %d\n", ret);
+			return ret;
+		}
+
+		remap_page(vpu_dev, code_base, W5_REMAP_INDEX0);
+		remap_page(vpu_dev, code_base, W5_REMAP_INDEX1);
+
+		vpu_write_reg(vpu_dev, W5_ADDR_CODE_BASE, code_base);
+		vpu_write_reg(vpu_dev, W5_CODE_SIZE, code_size);
+		vpu_write_reg(vpu_dev, W5_CODE_PARAM, (WAVE5_UPPER_PROC_AXI_ID << 4) | 0);
+		vpu_write_reg(vpu_dev, W5_ADDR_TEMP_BASE, temp_base);
+		vpu_write_reg(vpu_dev, W5_TEMP_SIZE, temp_size);
+
+		vpu_write_reg(vpu_dev, W5_HW_OPTION, 0);
+
+		reg_val = (WAVE5_PROC_AXI_EXT_ADDR & 0xFFFF);
+		wave5_fio_writel(vpu_dev, W5_BACKBONE_PROC_EXT_ADDR, reg_val);
+		reg_val = ((WAVE5_PROC_AXI_AXPROT & 0x7) << 4) |
+			(WAVE5_PROC_AXI_AXCACHE & 0xF);
+		wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, reg_val);
+		reg_val = ((WAVE5_SEC_AXI_AXPROT & 0x7) << 20) |
+			((WAVE5_SEC_AXI_AXCACHE & 0xF) << 16) |
+			(WAVE5_SEC_AXI_EXT_ADDR & 0xFFFF);
+		vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, reg_val);
+
+		/* interrupt */
+		// encoder
+		reg_val = BIT(INT_WAVE5_ENC_SET_PARAM);
+		reg_val |= BIT(INT_WAVE5_ENC_PIC);
+		reg_val |= BIT(INT_WAVE5_BSBUF_FULL);
+		// decoder
+		reg_val |= BIT(INT_WAVE5_INIT_SEQ);
+		reg_val |= BIT(INT_WAVE5_DEC_PIC);
+		reg_val |= BIT(INT_WAVE5_BSBUF_EMPTY);
+		vpu_write_reg(vpu_dev, W5_VPU_VINT_ENABLE, reg_val);
+
+		reg_val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
+		if ((reg_val >> 16) & 1) {
+			reg_val = ((WAVE5_PROC_AXI_ID << 28) |
+					(WAVE5_PRP_AXI_ID << 24) |
+					(WAVE5_FBD_Y_AXI_ID << 20) |
+					(WAVE5_FBC_Y_AXI_ID << 16) |
+					(WAVE5_FBD_C_AXI_ID << 12) |
+					(WAVE5_FBC_C_AXI_ID << 8) |
+					(WAVE5_PRI_AXI_ID << 4) |
+					WAVE5_SEC_AXI_ID);
+			wave5_fio_writel(vpu_dev, W5_BACKBONE_PROG_AXI_ID, reg_val);
+		}
+
+		sram_vb = &vpu_dev->sram_buf;
+
+		vpu_write_reg(vpu_dev, W5_ADDR_SEC_AXI, sram_vb->daddr);
+		vpu_write_reg(vpu_dev, W5_SEC_AXI_SIZE, sram_vb->size);
+		vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 1);
+		vpu_write_reg(vpu_dev, W5_COMMAND, W5_INIT_VPU);
+		vpu_write_reg(vpu_dev, W5_VPU_REMAP_CORE_START, 1);
+
+		ret = wave5_wait_vpu_busy(vpu_dev, W5_VPU_BUSY_STATUS);
+		if (ret) {
+			dev_err(vpu_dev->dev, "VPU reinit(W5_VPU_REMAP_CORE_START) timeout\n");
+			return ret;
+		}
+
+		reg_val = vpu_read_reg(vpu_dev, W5_RET_SUCCESS);
+		if (!reg_val) {
+			u32 reason_code = vpu_read_reg(vpu_dev, W5_RET_FAIL_REASON);
+
+			wave5_print_reg_err(vpu_dev, reason_code);
+			return -EIO;
+		}
+	}
+
+	return setup_wave5_properties(dev);
+}
+
+static int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const uint16_t *code,
+				size_t size)
+{
+	u32 reg_val;
+	struct vpu_buf *common_vb;
+	dma_addr_t code_base;
+	u32 code_size;
+	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
+	int ret;
+
+	if (i_sleep_wake) {
+		ret = wave5_wait_vpu_busy(vpu_dev, W5_VPU_BUSY_STATUS);
+		if (ret)
+			return ret;
+
+		/*
+		 * Declare who has ownership for the host interface access
+		 * 1 = VPU
+		 * 0 = Host processer
+		 */
+		vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 1);
+		vpu_write_reg(vpu_dev, W5_COMMAND, W5_SLEEP_VPU);
+		/* Send an interrupt named HOST to the VPU */
+		vpu_write_reg(vpu_dev, W5_VPU_HOST_INT_REQ, 1);
+
+		ret = wave5_wait_vpu_busy(vpu_dev, W5_VPU_BUSY_STATUS);
+		if (ret)
+			return ret;
+
+		if (!vpu_read_reg(vpu_dev, W5_RET_SUCCESS)) {
+			u32 reason = vpu_read_reg(vpu_dev, W5_RET_FAIL_REASON);
+
+			wave5_print_reg_err(vpu_dev, reason);
+			return -EIO;
+		}
+	} else { /* restore */
+		common_vb = &vpu_dev->common_mem;
+
+		code_base = common_vb->daddr;
+		/* ALIGN TO 4KB */
+		code_size = (WAVE5_MAX_CODE_BUF_SIZE & ~0xfff);
+		if (code_size < size * 2) {
+			dev_err(dev, "size too small\n");
+			return -EINVAL;
+		}
+
+		/* Power on without DEBUG mode */
+		vpu_write_reg(vpu_dev, W5_PO_CONF, 0);
+
+		remap_page(vpu_dev, code_base, W5_REMAP_INDEX0);
+		remap_page(vpu_dev, code_base, W5_REMAP_INDEX1);
+
+		vpu_write_reg(vpu_dev, W5_ADDR_CODE_BASE, code_base);
+		vpu_write_reg(vpu_dev, W5_CODE_SIZE, code_size);
+		vpu_write_reg(vpu_dev, W5_CODE_PARAM, (WAVE5_UPPER_PROC_AXI_ID << 4) | 0);
+
+		vpu_write_reg(vpu_dev, W5_HW_OPTION, 0);
+
+		reg_val = (WAVE5_PROC_AXI_EXT_ADDR & 0xFFFF);
+		wave5_fio_writel(vpu_dev, W5_BACKBONE_PROC_EXT_ADDR, reg_val);
+		reg_val = ((WAVE5_PROC_AXI_AXPROT & 0x7) << 4) |
+			(WAVE5_PROC_AXI_AXCACHE & 0xF);
+		wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, reg_val);
+		reg_val = ((WAVE5_SEC_AXI_AXPROT & 0x7) << 20) |
+			((WAVE5_SEC_AXI_AXCACHE & 0xF) << 16) |
+			(WAVE5_SEC_AXI_EXT_ADDR & 0xFFFF);
+		vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, reg_val);
+
+		/* interrupt */
+		// encoder
+		reg_val = BIT(INT_WAVE5_ENC_SET_PARAM);
+		reg_val |= BIT(INT_WAVE5_ENC_PIC);
+		reg_val |= BIT(INT_WAVE5_BSBUF_FULL);
+		// decoder
+		reg_val |= BIT(INT_WAVE5_INIT_SEQ);
+		reg_val |= BIT(INT_WAVE5_DEC_PIC);
+		reg_val |= BIT(INT_WAVE5_BSBUF_EMPTY);
+		vpu_write_reg(vpu_dev, W5_VPU_VINT_ENABLE, reg_val);
+
+		reg_val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
+		if ((reg_val >> 16) & 1) {
+			reg_val = ((WAVE5_PROC_AXI_ID << 28) |
+					(WAVE5_PRP_AXI_ID << 24) |
+					(WAVE5_FBD_Y_AXI_ID << 20) |
+					(WAVE5_FBC_Y_AXI_ID << 16) |
+					(WAVE5_FBD_C_AXI_ID << 12) |
+					(WAVE5_FBC_C_AXI_ID << 8) |
+					(WAVE5_PRI_AXI_ID << 4) |
+					WAVE5_SEC_AXI_ID);
+			wave5_fio_writel(vpu_dev, W5_BACKBONE_PROG_AXI_ID, reg_val);
+		}
+
+		vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 1);
+		vpu_write_reg(vpu_dev, W5_COMMAND, W5_WAKEUP_VPU);
+		/* Start VPU after settings */
+		vpu_write_reg(vpu_dev, W5_VPU_REMAP_CORE_START, 1);
+
+		ret = wave5_wait_vpu_busy(vpu_dev, W5_VPU_BUSY_STATUS);
+		if (ret) {
+			dev_err(vpu_dev->dev, "VPU wakeup(W5_VPU_REMAP_CORE_START) timeout\n");
+			return ret;
+		}
+
+		reg_val = vpu_read_reg(vpu_dev, W5_RET_SUCCESS);
+		if (!reg_val) {
+			u32 reason_code = vpu_read_reg(vpu_dev, W5_RET_FAIL_REASON);
+
+			wave5_print_reg_err(vpu_dev, reason_code);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+int wave5_vpu_reset(struct device *dev, enum sw_reset_mode reset_mode)
+{
+	u32 val = 0;
+	int ret = 0;
+	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
+	struct vpu_attr *p_attr = &vpu_dev->attr;
+	// VPU doesn't send response. force to set BUSY flag to 0.
+	vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 0);
+
+	if (reset_mode == SW_RESET_SAFETY) {
+		ret = wave5_vpu_sleep_wake(dev, true, NULL, 0);
+		if (ret)
+			return ret;
+	}
+
+	val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
+	if ((val >> 16) & 0x1)
+		p_attr->support_backbone = true;
+	if ((val >> 22) & 0x1)
+		p_attr->support_vcore_backbone = true;
+	if ((val >> 28) & 0x1)
+		p_attr->support_vcpu_backbone = true;
+
+	val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG1);
+	if ((val >> 26) & 0x1)
+		p_attr->support_dual_core = true;
+
+	// waiting for completion of bus transaction
+	if (p_attr->support_backbone) {
+		dev_dbg(dev, "%s: backbone supported\n", __func__);
+
+		if (p_attr->support_dual_core) {
+			// check CORE0
+			wave5_fio_writel(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE0, 0x7);
+
+			ret = wave5_wait_bus_busy(vpu_dev, W5_BACKBONE_BUS_STATUS_VCORE0);
+			if (ret) {
+				wave5_fio_writel(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE0, 0x00);
+				return ret;
+			}
+
+			// check CORE1
+			wave5_fio_writel(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE1, 0x7);
+
+			ret = wave5_wait_bus_busy(vpu_dev, W5_BACKBONE_BUS_STATUS_VCORE1);
+			if (ret) {
+				wave5_fio_writel(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE1, 0x00);
+				return ret;
+			}
+
+		} else if (p_attr->support_vcore_backbone) {
+			if (p_attr->support_vcpu_backbone) {
+				// step1 : disable request
+				wave5_fio_writel(vpu_dev, W5_BACKBONE_BUS_CTRL_VCPU, 0xFF);
+
+				// step2 : waiting for completion of bus transaction
+				ret = wave5_wait_vcpu_bus_busy(vpu_dev,
+							       W5_BACKBONE_BUS_STATUS_VCPU);
+				if (ret) {
+					wave5_fio_writel(vpu_dev, W5_BACKBONE_BUS_CTRL_VCPU, 0x00);
+					return ret;
+				}
+			}
+			// step1 : disable request
+			wave5_fio_writel(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE0, 0x7);
+
+			// step2 : waiting for completion of bus transaction
+			if (wave5_wait_bus_busy(vpu_dev, W5_BACKBONE_BUS_STATUS_VCORE0)) {
+				wave5_fio_writel(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE0, 0x00);
+				return -EBUSY;
+			}
+		} else {
+			// step1 : disable request
+			wave5_fio_writel(vpu_dev, W5_COMBINED_BACKBONE_BUS_CTRL, 0x7);
+
+			// step2 : waiting for completion of bus transaction
+			if (wave5_wait_bus_busy(vpu_dev, W5_COMBINED_BACKBONE_BUS_STATUS)) {
+				wave5_fio_writel(vpu_dev, W5_COMBINED_BACKBONE_BUS_CTRL, 0x00);
+				return -EBUSY;
+			}
+		}
+	} else {
+		dev_dbg(dev, "%s: backbone NOT supported\n", __func__);
+		// step1 : disable request
+		wave5_fio_writel(vpu_dev, W5_GDI_BUS_CTRL, 0x100);
+
+		// step2 : waiting for completion of bus transaction
+		ret = wave5_wait_bus_busy(vpu_dev, W5_GDI_BUS_STATUS);
+		if (ret) {
+			wave5_fio_writel(vpu_dev, W5_GDI_BUS_CTRL, 0x00);
+			return ret;
+		}
+	}
+
+	switch (reset_mode) {
+	case SW_RESET_ON_BOOT:
+	case SW_RESET_FORCE:
+	case SW_RESET_SAFETY:
+		val = W5_RST_BLOCK_ALL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (val) {
+		vpu_write_reg(vpu_dev, W5_VPU_RESET_REQ, val);
+
+		ret = wave5_wait_vpu_busy(vpu_dev, W5_VPU_RESET_STATUS);
+		if (ret) {
+			vpu_write_reg(vpu_dev, W5_VPU_RESET_REQ, 0);
+			return ret;
+		}
+		vpu_write_reg(vpu_dev, W5_VPU_RESET_REQ, 0);
+	}
+	// step3 : must clear GDI_BUS_CTRL after done SW_RESET
+	if (p_attr->support_backbone) {
+		if (p_attr->support_dual_core) {
+			wave5_fio_writel(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE0, 0x00);
+			wave5_fio_writel(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE1, 0x00);
+		} else if (p_attr->support_vcore_backbone) {
+			if (p_attr->support_vcpu_backbone)
+				wave5_fio_writel(vpu_dev, W5_BACKBONE_BUS_CTRL_VCPU, 0x00);
+			wave5_fio_writel(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE0, 0x00);
+		} else {
+			wave5_fio_writel(vpu_dev, W5_COMBINED_BACKBONE_BUS_CTRL, 0x00);
+		}
+	} else {
+		wave5_fio_writel(vpu_dev, W5_GDI_BUS_CTRL, 0x00);
+	}
+	if (reset_mode == SW_RESET_SAFETY || reset_mode == SW_RESET_FORCE)
+		ret = wave5_vpu_sleep_wake(dev, false, NULL, 0);
+
+	return ret;
+}
+
+int wave5_vpu_dec_finish_seq(struct vpu_instance *inst, u32 *fail_res)
+{
+	int ret;
+
+	wave5_bit_issue_command(inst, W5_DESTROY_INSTANCE);
+	ret = wave5_wait_vpu_busy(inst->dev, W5_VPU_BUSY_STATUS);
+	if (ret)
+		return -ETIMEDOUT;
+
+	if (!vpu_read_reg(inst->dev, W5_RET_SUCCESS)) {
+		*fail_res = vpu_read_reg(inst->dev, W5_RET_FAIL_REASON);
+		wave5_print_reg_err(inst->dev, *fail_res);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int wave5_vpu_dec_set_bitstream_flag(struct vpu_instance *inst, bool eos)
+{
+	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
+	enum bit_stream_mode bs_mode = (enum bit_stream_mode)p_dec_info->open_param.bitstream_mode;
+
+	p_dec_info->stream_endflag = eos ? 1 : 0;
+
+	if (bs_mode == BS_MODE_INTERRUPT) {
+		int ret;
+
+		vpu_write_reg(inst->dev, W5_BS_OPTION, (p_dec_info->stream_endflag << 1) |
+			      p_dec_info->stream_endflag);
+		vpu_write_reg(inst->dev, W5_BS_WR_PTR, p_dec_info->stream_wr_ptr);
+
+		wave5_bit_issue_command(inst, W5_UPDATE_BS);
+		ret = wave5_wait_vpu_busy(inst->dev,
+					  W5_VPU_BUSY_STATUS);
+		if (ret)
+			return ret;
+
+		if (!vpu_read_reg(inst->dev, W5_RET_SUCCESS))
+			return -EIO;
+	}
+
+	return 0;
+}
+
+int wave5_dec_clr_disp_flag(struct vpu_instance *inst, unsigned int index)
+{
+	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
+	int ret;
+
+	vpu_write_reg(inst->dev, W5_CMD_DEC_CLR_DISP_IDC, BIT(index));
+	vpu_write_reg(inst->dev, W5_CMD_DEC_SET_DISP_IDC, 0);
+	ret = wave5_send_query(inst, UPDATE_DISP_FLAG);
+
+	if (ret) {
+		if (ret == -EIO) {
+			u32 reg_val = vpu_read_reg(inst->dev, W5_RET_FAIL_REASON);
+
+			wave5_print_reg_err(inst->dev, reg_val);
+		}
+		return ret;
+	}
+
+	p_dec_info->frame_display_flag = vpu_read_reg(inst->dev, W5_RET_DEC_DISP_IDC);
+
+	return 0;
+}
+
+int wave5_dec_set_disp_flag(struct vpu_instance *inst, unsigned int index)
+{
+	int ret;
+
+	vpu_write_reg(inst->dev, W5_CMD_DEC_CLR_DISP_IDC, 0);
+	vpu_write_reg(inst->dev, W5_CMD_DEC_SET_DISP_IDC, BIT(index));
+	ret = wave5_send_query(inst, UPDATE_DISP_FLAG);
+
+	if (ret) {
+		if (ret == -EIO) {
+			u32 reg_val = vpu_read_reg(inst->dev, W5_RET_FAIL_REASON);
+
+			wave5_print_reg_err(inst->dev, reg_val);
+		}
+		return ret;
+	}
+
+	return 0;
+}
+
+int wave5_vpu_clear_interrupt(struct vpu_instance *inst, u32 flags)
+{
+	u32 interrupt_reason;
+
+	interrupt_reason = vpu_read_reg(inst->dev, W5_VPU_VINT_REASON_USR);
+	interrupt_reason &= ~flags;
+	vpu_write_reg(inst->dev, W5_VPU_VINT_REASON_USR, interrupt_reason);
+
+	return 0;
+}
+
+dma_addr_t wave5_vpu_dec_get_rd_ptr(struct vpu_instance *inst)
+{
+	int ret;
+
+	ret = wave5_send_query(inst, GET_BS_RD_PTR);
+
+	if (ret)
+		return inst->codec_info->dec_info.stream_rd_ptr;
+
+	return vpu_read_reg(inst->dev, W5_RET_QUERY_DEC_BS_RD_PTR);
+}
+
+int wave5_dec_set_rd_ptr(struct vpu_instance *inst, dma_addr_t addr)
+{
+	int ret;
+
+	vpu_write_reg(inst->dev, W5_RET_QUERY_DEC_SET_BS_RD_PTR, addr);
+
+	ret = wave5_send_query(inst, SET_BS_RD_PTR);
+
+	return ret;
+}
+
+/************************************************************************/
+/* ENCODER functions */
+/************************************************************************/
+
+int wave5_vpu_build_up_enc_param(struct device *dev, struct vpu_instance *inst,
+				 struct enc_open_param *open_param)
+{
+	int ret;
+	struct enc_info *p_enc_info = &inst->codec_info->enc_info;
+	u32 reg_val;
+	struct dma_vpu_buf *sram_vb;
+	u32 bs_endian;
+	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
+	dma_addr_t buffer_addr;
+	size_t buffer_size;
+
+	p_enc_info->cycle_per_tick = 256;
+	sram_vb = &vpu_dev->sram_buf;
+	p_enc_info->sec_axi_info.buf_base = sram_vb->daddr;
+	p_enc_info->sec_axi_info.buf_size = sram_vb->size;
+
+	if (vpu_dev->product == PRODUCT_ID_521)
+		p_enc_info->vb_work.size = WAVE521ENC_WORKBUF_SIZE;
+
+	ret = wave5_vdi_allocate_dma_memory(vpu_dev, &p_enc_info->vb_work);
+	if (ret) {
+		memset(&p_enc_info->vb_work, 0, sizeof(p_enc_info->vb_work));
+		return ret;
+	}
+
+	wave5_vdi_clear_memory(vpu_dev, &p_enc_info->vb_work);
+
+	vpu_write_reg(inst->dev, W5_ADDR_WORK_BASE, p_enc_info->vb_work.daddr);
+	vpu_write_reg(inst->dev, W5_WORK_SIZE, p_enc_info->vb_work.size);
+
+	reg_val = wave5_vdi_convert_endian(vpu_dev, open_param->stream_endian);
+	bs_endian = (~reg_val & VDI_128BIT_ENDIAN_MASK);
+
+	reg_val = (open_param->line_buf_int_en << 6) | bs_endian;
+	vpu_write_reg(inst->dev, W5_CMD_BS_PARAM, reg_val);
+	vpu_write_reg(inst->dev, W5_CMD_EXT_ADDR, (open_param->pri_axprot << 20) |
+			(open_param->pri_axcache << 16) | open_param->pri_ext_addr);
+	vpu_write_reg(inst->dev, W5_CMD_NUM_CQ_DEPTH_M1, (COMMAND_QUEUE_DEPTH - 1));
+
+	reg_val = 0;
+	if (vpu_dev->product == PRODUCT_ID_521)
+		reg_val |= (open_param->sub_frame_sync_enable |
+			    open_param->sub_frame_sync_mode << 1);
+	vpu_write_reg(inst->dev, W5_CMD_ENC_SRC_OPTIONS, reg_val);
+
+	vpu_write_reg(inst->dev, W5_CMD_ENC_VCORE_INFO, 1);
+
+	wave5_bit_issue_command(inst, W5_CREATE_INSTANCE);
+	// check QUEUE_DONE
+	ret = wave5_wait_vpu_busy(inst->dev, W5_VPU_BUSY_STATUS);
+	if (ret) {
+		dev_warn(inst->dev->dev, "command: 'W5_CREATE_INSTANCE' timed out\n");
+		goto free_vb_work;
+	}
+
+	// Check if we were able to add the parameters into the VCPU QUEUE
+	if (!vpu_read_reg(inst->dev, W5_RET_SUCCESS)) {
+		reg_val = vpu_read_reg(inst->dev, W5_RET_FAIL_REASON);
+		wave5_print_reg_err(inst->dev, reg_val);
+		ret = -EIO;
+		goto free_vb_work;
+	}
+
+	buffer_addr = open_param->bitstream_buffer;
+	buffer_size = open_param->bitstream_buffer_size;
+	p_enc_info->sub_frame_sync_config.sub_frame_sync_mode = open_param->sub_frame_sync_mode;
+	p_enc_info->sub_frame_sync_config.sub_frame_sync_on = open_param->sub_frame_sync_enable;
+	p_enc_info->stream_rd_ptr = buffer_addr;
+	p_enc_info->stream_wr_ptr = buffer_addr;
+	p_enc_info->line_buf_int_en = open_param->line_buf_int_en;
+	p_enc_info->stream_buf_start_addr = buffer_addr;
+	p_enc_info->stream_buf_size = buffer_size;
+	p_enc_info->stream_buf_end_addr = buffer_addr + buffer_size;
+	p_enc_info->stride = 0;
+	p_enc_info->initial_info_obtained = false;
+	p_enc_info->product_code = vpu_read_reg(inst->dev, W5_PRODUCT_NUMBER);
+
+	return 0;
+free_vb_work:
+	wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_work);
+	return ret;
+}
+
+static void wave5_set_enc_crop_info(u32 codec, struct enc_wave_param *param, int rot_mode,
+				    int src_width, int src_height)
+{
+	int aligned_width = (codec == W_HEVC_ENC) ? ALIGN(src_width, 32) : ALIGN(src_width, 16);
+	int aligned_height = (codec == W_HEVC_ENC) ? ALIGN(src_height, 32) : ALIGN(src_height, 16);
+	int pad_right, pad_bot;
+	int crop_right, crop_left, crop_top, crop_bot;
+	int prp_mode = rot_mode >> 1; // remove prp_enable bit
+
+	if (codec == W_HEVC_ENC &&
+	    (!rot_mode || prp_mode == 14)) // prp_mode 14 : hor_mir && ver_mir && rot_180
+		return;
+
+	pad_right = aligned_width - src_width;
+	pad_bot = aligned_height - src_height;
+
+	if (param->conf_win_right > 0)
+		crop_right = param->conf_win_right + pad_right;
+	else
+		crop_right = pad_right;
+
+	if (param->conf_win_bot > 0)
+		crop_bot = param->conf_win_bot + pad_bot;
+	else
+		crop_bot = pad_bot;
+
+	crop_top = param->conf_win_top;
+	crop_left = param->conf_win_left;
+
+	param->conf_win_top = crop_top;
+	param->conf_win_left = crop_left;
+	param->conf_win_bot = crop_bot;
+	param->conf_win_right = crop_right;
+
+	if (prp_mode == 1 || prp_mode == 15) {
+		param->conf_win_top = crop_right;
+		param->conf_win_left = crop_top;
+		param->conf_win_bot = crop_left;
+		param->conf_win_right = crop_bot;
+	} else if (prp_mode == 2 || prp_mode == 12) {
+		param->conf_win_top = crop_bot;
+		param->conf_win_left = crop_right;
+		param->conf_win_bot = crop_top;
+		param->conf_win_right = crop_left;
+	} else if (prp_mode == 3 || prp_mode == 13) {
+		param->conf_win_top = crop_left;
+		param->conf_win_left = crop_bot;
+		param->conf_win_bot = crop_right;
+		param->conf_win_right = crop_top;
+	} else if (prp_mode == 4 || prp_mode == 10) {
+		param->conf_win_top = crop_bot;
+		param->conf_win_bot = crop_top;
+	} else if (prp_mode == 8 || prp_mode == 6) {
+		param->conf_win_left = crop_right;
+		param->conf_win_right = crop_left;
+	} else if (prp_mode == 5 || prp_mode == 11) {
+		param->conf_win_top = crop_left;
+		param->conf_win_left = crop_top;
+		param->conf_win_bot = crop_right;
+		param->conf_win_right = crop_bot;
+	} else if (prp_mode == 7 || prp_mode == 9) {
+		param->conf_win_top = crop_right;
+		param->conf_win_left = crop_bot;
+		param->conf_win_bot = crop_left;
+		param->conf_win_right = crop_top;
+	}
+}
+
+int wave5_vpu_enc_init_seq(struct vpu_instance *inst)
+{
+	u32 reg_val = 0, rot_mir_mode, fixed_cu_size_mode = 0x7;
+	struct enc_info *p_enc_info = &inst->codec_info->enc_info;
+	struct enc_open_param *p_open_param = &p_enc_info->open_param;
+	struct enc_wave_param *p_param = &p_open_param->wave_param;
+	int ret;
+
+	if (inst->dev->product != PRODUCT_ID_521)
+		return -EINVAL;
+
+	/*==============================================*/
+	/* OPT_CUSTOM_GOP */
+	/*==============================================*/
+	/*
+	 * SET_PARAM + CUSTOM_GOP
+	 * only when gop_preset_idx == custom_gop, custom_gop related registers should be set
+	 */
+	if (p_param->gop_preset_idx == PRESET_IDX_CUSTOM_GOP) {
+		int i = 0, j = 0;
+
+		vpu_write_reg(inst->dev, W5_CMD_ENC_CUSTOM_GOP_PARAM,
+			      p_param->gop_param.custom_gop_size);
+		for (i = 0; i < p_param->gop_param.custom_gop_size; i++) {
+			vpu_write_reg(inst->dev, W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_0 + (i * 4),
+				      p_param->gop_param.pic_param[i].pic_type |
+				      (p_param->gop_param.pic_param[i].poc_offset << 2) |
+				      (p_param->gop_param.pic_param[i].pic_qp << 6) |
+				      (p_param->gop_param.pic_param[i].use_multi_ref_p << 13) |
+				      ((p_param->gop_param.pic_param[i].ref_poc_l0 & 0x1F) << 14) |
+				      ((p_param->gop_param.pic_param[i].ref_poc_l1 & 0x1F) << 19) |
+				      (p_param->gop_param.pic_param[i].temporal_id << 24));
+		}
+
+		for (j = i; j < MAX_GOP_NUM; j++)
+			vpu_write_reg(inst->dev,
+				      W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_0 + (j * 4), 0);
+
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_SET_PARAM_OPTION, OPT_CUSTOM_GOP);
+		wave5_bit_issue_command(inst, W5_ENC_SET_PARAM);
+
+		ret = wave5_wait_vpu_busy(inst->dev, W5_VPU_BUSY_STATUS);
+		if (ret) {
+			dev_warn(inst->dev->dev, "command: 'W5_ENC_SET_PARAM', timed out op=0x%x\n",
+				 OPT_CUSTOM_GOP);
+			return ret;
+		}
+	}
+
+	/*======================================================================*/
+	/* OPT_COMMON:								*/
+	/*	the last SET_PARAM command should be called with OPT_COMMON	*/
+	/*======================================================================*/
+	rot_mir_mode = 0;
+	if (p_enc_info->rotation_enable) {
+		switch (p_enc_info->rotation_angle) {
+		case 0:
+			rot_mir_mode |= NONE_ROTATE;
+			break;
+		case 90:
+			rot_mir_mode |= ROT_CLOCKWISE_90;
+			break;
+		case 180:
+			rot_mir_mode |= ROT_CLOCKWISE_180;
+			break;
+		case 270:
+			rot_mir_mode |= ROT_CLOCKWISE_270;
+			break;
+		}
+	}
+
+	if (p_enc_info->mirror_enable) {
+		switch (p_enc_info->mirror_direction) {
+		case MIRDIR_NONE:
+			rot_mir_mode |= NONE_ROTATE;
+			break;
+		case MIRDIR_VER:
+			rot_mir_mode |= MIR_VER_FLIP;
+			break;
+		case MIRDIR_HOR:
+			rot_mir_mode |= MIR_HOR_FLIP;
+			break;
+		case MIRDIR_HOR_VER:
+			rot_mir_mode |= MIR_HOR_VER_FLIP;
+			break;
+		}
+	}
+
+	wave5_set_enc_crop_info(inst->std, p_param, rot_mir_mode, p_open_param->pic_width,
+				p_open_param->pic_height);
+
+	/* SET_PARAM + COMMON */
+	vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_SET_PARAM_OPTION, OPT_COMMON);
+	vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_SRC_SIZE, p_open_param->pic_height << 16
+			| p_open_param->pic_width);
+	vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_CUSTOM_MAP_ENDIAN, VDI_LITTLE_ENDIAN);
+
+	if (inst->std == W_AVC_ENC) {
+		reg_val = p_param->profile | (p_param->level << 3) |
+			(p_param->internal_bit_depth << 14) | (p_param->use_long_term << 21);
+		if (p_param->scaling_list_enable == 2) {
+			reg_val |= BIT(22) | BIT(23); // [23]=USE_DEFAULT_SCALING_LIST
+		} else { // 0 or 1
+			reg_val |= (p_param->scaling_list_enable << 22);
+		}
+	} else { // HEVC enc
+		reg_val = p_param->profile |
+			(p_param->level << 3) |
+			(p_param->tier << 12) |
+			(p_param->internal_bit_depth << 14) |
+			(p_param->use_long_term << 21) |
+			(p_param->tmvp_enable << 23) |
+			(p_param->sao_enable << 24) |
+			(p_param->skip_intra_trans << 25) |
+			(p_param->strong_intra_smooth_enable << 27) |
+			(p_param->en_still_picture << 30);
+		if (p_param->scaling_list_enable == 2)
+			reg_val |= BIT(22) | BIT(31); // [31]=USE_DEFAULT_SCALING_LIST
+		else
+			reg_val |= (p_param->scaling_list_enable << 22);
+	}
+
+	vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_SPS_PARAM, reg_val);
+
+	reg_val = (p_param->lossless_enable) |
+		(p_param->const_intra_pred_flag << 1) |
+		(p_param->lf_cross_slice_boundary_enable << 2) |
+		(p_param->weight_pred_enable << 3) |
+		(p_param->wpp_enable << 4) |
+		(p_param->disable_deblk << 5) |
+		((p_param->beta_offset_div2 & 0xF) << 6) |
+		((p_param->tc_offset_div2 & 0xF) << 10) |
+		((p_param->chroma_cb_qp_offset & 0x1F) << 14) |
+		((p_param->chroma_cr_qp_offset & 0x1F) << 19) |
+		(p_param->transform8x8_enable << 29) |
+		(p_param->entropy_coding_mode << 30);
+	vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_PPS_PARAM, reg_val);
+
+	vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_GOP_PARAM, p_param->gop_preset_idx);
+
+	if (inst->std == W_AVC_ENC)
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_INTRA_PARAM, p_param->intra_qp |
+				((p_param->intra_period & 0x7ff) << 6) |
+				((p_param->avc_idr_period & 0x7ff) << 17) |
+				((p_param->forced_idr_header_enable & 3) << 28));
+	else
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_INTRA_PARAM,
+			      p_param->decoding_refresh_type | (p_param->intra_qp << 3) |
+				(p_param->forced_idr_header_enable << 9) |
+				(p_param->intra_period << 16));
+
+	reg_val = (p_param->use_recommend_enc_param) |
+		(p_param->rdo_skip << 2) |
+		(p_param->lambda_scaling_enable << 3) |
+		(p_param->coef_clear_disable << 4) |
+		(fixed_cu_size_mode << 5) |
+		(p_param->intra_nx_n_enable << 8) |
+		(p_param->max_num_merge << 18) |
+		(p_param->custom_md_enable << 20) |
+		(p_param->custom_lambda_enable << 21) |
+		(p_param->monochrome_enable << 22);
+
+	vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_RDO_PARAM, reg_val);
+
+	if (inst->std == W_AVC_ENC)
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_INTRA_REFRESH,
+			      p_param->intra_mb_refresh_arg << 16 | p_param->intra_mb_refresh_mode);
+	else
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_INTRA_REFRESH,
+			      p_param->intra_refresh_arg << 16 | p_param->intra_refresh_mode);
+
+	vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_RC_FRAME_RATE, p_open_param->frame_rate_info);
+	vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_RC_TARGET_RATE, p_open_param->bit_rate);
+
+	if (inst->std == W_AVC_ENC)
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_RC_PARAM,
+			      p_open_param->rc_enable | (p_param->mb_level_rc_enable << 1) |
+			      (p_param->hvs_qp_enable << 2) | (p_param->hvs_qp_scale << 4) |
+			      (p_param->bit_alloc_mode << 8) | (p_param->roi_enable << 13) |
+			      ((p_param->initial_rc_qp & 0x3F) << 14) |
+			      (p_open_param->vbv_buffer_size << 20));
+	else
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_RC_PARAM,
+			      p_open_param->rc_enable | (p_param->cu_level_rc_enable << 1) |
+			      (p_param->hvs_qp_enable << 2) | (p_param->hvs_qp_scale << 4) |
+			      (p_param->bit_alloc_mode << 8) | (p_param->roi_enable << 13) |
+			      ((p_param->initial_rc_qp & 0x3F) << 14) |
+			      (p_open_param->vbv_buffer_size << 20));
+
+	vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_RC_WEIGHT_PARAM,
+		      p_param->rc_weight_buf << 8 | p_param->rc_weight_param);
+
+	vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_RC_MIN_MAX_QP, p_param->min_qp_i |
+		      (p_param->max_qp_i << 6) | (p_param->hvs_max_delta_qp << 12));
+
+	vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_RC_INTER_MIN_MAX_QP, p_param->min_qp_p |
+		      (p_param->max_qp_p << 6) | (p_param->min_qp_b << 12) |
+		      (p_param->max_qp_b << 18));
+
+	vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_RC_BIT_RATIO_LAYER_0_3,
+		      (u32)p_param->fixed_bit_ratio[0] |
+		      ((u32)p_param->fixed_bit_ratio[1] << 8) |
+		      ((u32)p_param->fixed_bit_ratio[2] << 16) |
+		      ((u32)p_param->fixed_bit_ratio[3] << 24));
+
+	vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_RC_BIT_RATIO_LAYER_4_7,
+		      (u32)p_param->fixed_bit_ratio[4] |
+		      ((u32)p_param->fixed_bit_ratio[5] << 8) |
+		      ((u32)p_param->fixed_bit_ratio[6] << 16) |
+		      ((u32)p_param->fixed_bit_ratio[7] << 24));
+
+	vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_ROT_PARAM, rot_mir_mode);
+
+	vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_BG_PARAM, (p_param->bg_detect_enable) |
+		      (p_param->bg_thr_diff << 1) | (p_param->bg_thr_mean_diff << 10) |
+		      (p_param->bg_lambda_qp << 18) | ((p_param->bg_delta_qp & 0x1F) << 24) |
+		      ((inst->std == W_AVC_ENC) ? p_param->s2fme_disable << 29 : 0));
+
+	if (inst->std == W_HEVC_ENC || inst->std == W_AVC_ENC) {
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_CUSTOM_LAMBDA_ADDR,
+			      p_param->custom_lambda_addr);
+
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_CONF_WIN_TOP_BOT,
+			      p_param->conf_win_bot << 16 | p_param->conf_win_top);
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_CONF_WIN_LEFT_RIGHT,
+			      p_param->conf_win_right << 16 | p_param->conf_win_left);
+
+		if (inst->std == W_AVC_ENC)
+			vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_INDEPENDENT_SLICE,
+				      p_param->avc_slice_arg << 16 | p_param->avc_slice_mode);
+		else
+			vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_INDEPENDENT_SLICE,
+				      p_param->independ_slice_mode_arg << 16 |
+				      p_param->independ_slice_mode);
+
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_USER_SCALING_LIST_ADDR,
+			      p_param->user_scaling_list_addr);
+
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_NUM_UNITS_IN_TICK,
+			      p_param->num_units_in_tick);
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_TIME_SCALE, p_param->time_scale);
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_NUM_TICKS_POC_DIFF_ONE,
+			      p_param->num_ticks_poc_diff_one);
+	}
+
+	if (inst->std == W_HEVC_ENC) {
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_CUSTOM_MD_PU04,
+			      (p_param->pu04_delta_rate & 0xFF) |
+			      ((p_param->pu04_intra_planar_delta_rate & 0xFF) << 8) |
+			      ((p_param->pu04_intra_dc_delta_rate & 0xFF) << 16) |
+			      ((p_param->pu04_intra_angle_delta_rate & 0xFF) << 24));
+
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_CUSTOM_MD_PU08,
+			      (p_param->pu08_delta_rate & 0xFF) |
+			      ((p_param->pu08_intra_planar_delta_rate & 0xFF) << 8) |
+			      ((p_param->pu08_intra_dc_delta_rate & 0xFF) << 16) |
+			      ((p_param->pu08_intra_angle_delta_rate & 0xFF) << 24));
+
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_CUSTOM_MD_PU16,
+			      (p_param->pu16_delta_rate & 0xFF) |
+			      ((p_param->pu16_intra_planar_delta_rate & 0xFF) << 8) |
+			      ((p_param->pu16_intra_dc_delta_rate & 0xFF) << 16) |
+			      ((p_param->pu16_intra_angle_delta_rate & 0xFF) << 24));
+
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_CUSTOM_MD_PU32,
+			      (p_param->pu32_delta_rate & 0xFF) |
+			      ((p_param->pu32_intra_planar_delta_rate & 0xFF) << 8) |
+			      ((p_param->pu32_intra_dc_delta_rate & 0xFF) << 16) |
+			      ((p_param->pu32_intra_angle_delta_rate & 0xFF) << 24));
+
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_CUSTOM_MD_CU08,
+			      (p_param->cu08_intra_delta_rate & 0xFF) |
+			      ((p_param->cu08_inter_delta_rate & 0xFF) << 8) |
+			      ((p_param->cu08_merge_delta_rate & 0xFF) << 16));
+
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_CUSTOM_MD_CU16,
+			      (p_param->cu16_intra_delta_rate & 0xFF) |
+			      ((p_param->cu16_inter_delta_rate & 0xFF) << 8) |
+			      ((p_param->cu16_merge_delta_rate & 0xFF) << 16));
+
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_CUSTOM_MD_CU32,
+			      (p_param->cu32_intra_delta_rate & 0xFF) |
+			      ((p_param->cu32_inter_delta_rate & 0xFF) << 8) |
+			      ((p_param->cu32_merge_delta_rate & 0xFF) << 16));
+
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_DEPENDENT_SLICE,
+			      p_param->depend_slice_mode_arg << 16 | p_param->depend_slice_mode);
+
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_NR_PARAM, p_param->nr_y_enable |
+			      (p_param->nr_cb_enable << 1) | (p_param->nr_cr_enable << 2) |
+			      (p_param->nr_noise_est_enable << 3) |
+			      (p_param->nr_noise_sigma_y << 4) |
+			      (p_param->nr_noise_sigma_cb << 12) |
+			      (p_param->nr_noise_sigma_cr << 20));
+
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_NR_WEIGHT,
+			      p_param->nr_intra_weight_y |
+			      (p_param->nr_intra_weight_cb << 5) |
+			      (p_param->nr_intra_weight_cr << 10) |
+			      (p_param->nr_inter_weight_y << 15) |
+			      (p_param->nr_inter_weight_cb << 20) |
+			      (p_param->nr_inter_weight_cr << 25));
+	}
+	if (p_enc_info->open_param.encode_vui_rbsp || p_enc_info->open_param.enc_hrd_rbsp_in_vps) {
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_VUI_HRD_PARAM,
+			      (p_enc_info->open_param.hrd_rbsp_data_size << 18) |
+			      (p_enc_info->open_param.vui_rbsp_data_size << 4) |
+			      (p_enc_info->open_param.enc_hrd_rbsp_in_vps << 2) |
+			      (p_enc_info->open_param.encode_vui_rbsp));
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_VUI_RBSP_ADDR,
+			      p_enc_info->open_param.vui_rbsp_data_addr);
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_HRD_RBSP_ADDR,
+			      p_enc_info->open_param.hrd_rbsp_data_addr);
+	} else {
+		vpu_write_reg(inst->dev, W5_CMD_ENC_SEQ_VUI_HRD_PARAM, 0);
+	}
+
+	wave5_bit_issue_command(inst, W5_ENC_SET_PARAM);
+
+	ret = wave5_wait_vpu_busy(inst->dev, W5_VPU_BUSY_STATUS);
+	if (ret) {
+		dev_warn(inst->dev->dev, "command: 'W5_ENC_SET_PARAM', timed out\n");
+		return ret;
+	}
+
+	if (!vpu_read_reg(inst->dev, W5_RET_SUCCESS)) {
+		reg_val = vpu_read_reg(inst->dev, W5_RET_FAIL_REASON);
+		wave5_print_reg_err(inst->dev, reg_val);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int wave5_vpu_enc_get_seq_info(struct vpu_instance *inst, struct enc_initial_info *info)
+{
+	int ret;
+	u32 reg_val;
+	struct enc_info *p_enc_info = &inst->codec_info->enc_info;
+
+	if (inst->dev->product != PRODUCT_ID_521)
+		return -EINVAL;
+
+	// send QUERY cmd
+	ret = wave5_send_query(inst, GET_RESULT);
+	if (ret) {
+		if (ret == -EIO) {
+			reg_val = vpu_read_reg(inst->dev, W5_RET_FAIL_REASON);
+			wave5_print_reg_err(inst->dev, reg_val);
+		}
+		return ret;
+	}
+
+	dev_dbg(inst->dev->dev, "%s: init seq\n", __func__);
+
+	reg_val = vpu_read_reg(inst->dev, W5_RET_QUEUE_STATUS);
+
+	p_enc_info->instance_queue_count = (reg_val >> 16) & 0xff;
+	p_enc_info->report_queue_count = (reg_val & QUEUE_REPORT_MASK);
+
+	if (vpu_read_reg(inst->dev, W5_RET_ENC_ENCODING_SUCCESS) != 1) {
+		info->seq_init_err_reason = vpu_read_reg(inst->dev, W5_RET_ENC_ERR_INFO);
+		ret = -EIO;
+	} else {
+		info->warn_info = vpu_read_reg(inst->dev, W5_RET_ENC_WARN_INFO);
+	}
+
+	info->min_frame_buffer_count = vpu_read_reg(inst->dev, W5_RET_ENC_NUM_REQUIRED_FB);
+	info->min_src_frame_count = vpu_read_reg(inst->dev, W5_RET_ENC_MIN_SRC_BUF_NUM);
+	info->max_latency_pictures = vpu_read_reg(inst->dev, W5_RET_ENC_PIC_MAX_LATENCY_PICS);
+	info->vlc_buf_size = vpu_read_reg(inst->dev, W5_RET_VLC_BUF_SIZE);
+	info->param_buf_size = vpu_read_reg(inst->dev, W5_RET_PARAM_BUF_SIZE);
+	p_enc_info->vlc_buf_size = info->vlc_buf_size;
+	p_enc_info->param_buf_size = info->param_buf_size;
+
+	return ret;
+}
+
+static u32 calculate_luma_stride(u32 width, u32 bit_depth)
+{
+	return ALIGN(ALIGN(width, 16) * ((bit_depth > 8) ? 5 : 4), 32);
+}
+
+static u32 calculate_chroma_stride(u32 width, u32 bit_depth)
+{
+	return ALIGN(ALIGN(width / 2, 16) * ((bit_depth > 8) ? 5 : 4), 32);
+}
+
+int wave5_vpu_enc_register_framebuffer(struct device *dev, struct vpu_instance *inst,
+				       struct frame_buffer *fb_arr, enum tiled_map_type map_type,
+				       unsigned int count)
+{
+	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
+	int ret = 0;
+	u32 stride;
+	u32 start_no, end_no;
+	size_t remain, idx, j, i, cnt_8_chunk;
+	u32 reg_val = 0, pic_size = 0, mv_col_size, fbc_y_tbl_size, fbc_c_tbl_size;
+	u32 sub_sampled_size = 0;
+	u32 endian, luma_stride, chroma_stride, frame_width, frame_height;
+	u32 buf_height = 0, buf_width = 0;
+	u32 bit_depth;
+	bool avc_encoding = (inst->std == W_AVC_ENC);
+	struct vpu_buf vb_mv = {0};
+	struct vpu_buf vb_fbc_y_tbl = {0};
+	struct vpu_buf vb_fbc_c_tbl = {0};
+	struct vpu_buf vb_sub_sam_buf = {0};
+	struct vpu_buf vb_task = {0};
+	struct enc_open_param *p_open_param;
+	struct enc_info *p_enc_info = &inst->codec_info->enc_info;
+
+	p_open_param = &p_enc_info->open_param;
+	mv_col_size = 0;
+	fbc_y_tbl_size = 0;
+	fbc_c_tbl_size = 0;
+	stride = p_enc_info->stride;
+	bit_depth = p_open_param->wave_param.internal_bit_depth;
+
+	if (avc_encoding) {
+		buf_width = ALIGN(p_open_param->pic_width, 16);
+		buf_height = ALIGN(p_open_param->pic_height, 16);
+
+		if ((p_enc_info->rotation_angle || p_enc_info->mirror_direction) &&
+		    !(p_enc_info->rotation_angle == 180 &&
+					p_enc_info->mirror_direction == MIRDIR_HOR_VER)) {
+			buf_width = ALIGN(p_open_param->pic_width, 16);
+			buf_height = ALIGN(p_open_param->pic_height, 16);
+		}
+
+		if (p_enc_info->rotation_angle == 90 || p_enc_info->rotation_angle == 270) {
+			buf_width = ALIGN(p_open_param->pic_height, 16);
+			buf_height = ALIGN(p_open_param->pic_width, 16);
+		}
+	} else {
+		buf_width = ALIGN(p_open_param->pic_width, 8);
+		buf_height = ALIGN(p_open_param->pic_height, 8);
+
+		if ((p_enc_info->rotation_angle || p_enc_info->mirror_direction) &&
+		    !(p_enc_info->rotation_angle == 180 &&
+					p_enc_info->mirror_direction == MIRDIR_HOR_VER)) {
+			buf_width = ALIGN(p_open_param->pic_width, 32);
+			buf_height = ALIGN(p_open_param->pic_height, 32);
+		}
+
+		if (p_enc_info->rotation_angle == 90 || p_enc_info->rotation_angle == 270) {
+			buf_width = ALIGN(p_open_param->pic_height, 32);
+			buf_height = ALIGN(p_open_param->pic_width, 32);
+		}
+	}
+
+	pic_size = (buf_width << 16) | buf_height;
+
+	if (avc_encoding) {
+		mv_col_size = WAVE5_ENC_AVC_BUF_SIZE(buf_width, buf_height);
+		vb_mv.daddr = 0;
+		vb_mv.size = ALIGN(mv_col_size * count, BUFFER_MARGIN) + BUFFER_MARGIN;
+	} else {
+		mv_col_size = WAVE5_ENC_HEVC_BUF_SIZE(buf_width, buf_height);
+		mv_col_size = ALIGN(mv_col_size, 16);
+		vb_mv.daddr = 0;
+		vb_mv.size = ALIGN(mv_col_size * count, BUFFER_MARGIN) + BUFFER_MARGIN;
+	}
+
+	ret = wave5_vdi_allocate_dma_memory(vpu_dev, &vb_mv);
+	if (ret)
+		return ret;
+
+	p_enc_info->vb_mv = vb_mv;
+
+	frame_width = ALIGN(buf_width, 16);
+	frame_height = ALIGN(buf_height, 16);
+	if (p_enc_info->product_code == WAVE521C_DUAL_CODE) {
+		// Use 1024 for H264(AVC) and 512 for H265(HEVC)
+		fbc_y_tbl_size = calculate_table_size(bit_depth, frame_width, frame_height,
+						      (avc_encoding ? 1024 : 512));
+	} else {
+		fbc_y_tbl_size = WAVE5_FBC_LUMA_TABLE_SIZE(buf_width, buf_height);
+		fbc_y_tbl_size = ALIGN(fbc_y_tbl_size, 16);
+	}
+
+	vb_fbc_y_tbl.daddr = 0;
+	vb_fbc_y_tbl.size = ALIGN(fbc_y_tbl_size * count, BUFFER_MARGIN) + BUFFER_MARGIN;
+	ret = wave5_vdi_allocate_dma_memory(vpu_dev, &vb_fbc_y_tbl);
+	if (ret)
+		goto free_vb_fbc_y_tbl;
+
+	p_enc_info->vb_fbc_y_tbl = vb_fbc_y_tbl;
+
+	if (p_enc_info->product_code == WAVE521C_DUAL_CODE) {
+		// Use 1024 for H264(AVC) and 512 for HEVC
+		fbc_c_tbl_size = calculate_table_size(bit_depth, frame_width, frame_height,
+						      (avc_encoding ? 1024 : 512));
+	} else {
+		fbc_c_tbl_size = WAVE5_FBC_CHROMA_TABLE_SIZE(buf_width, buf_height);
+		fbc_c_tbl_size = ALIGN(fbc_c_tbl_size, 16);
+	}
+
+	vb_fbc_c_tbl.daddr = 0;
+	vb_fbc_c_tbl.size = ALIGN(fbc_c_tbl_size * count, BUFFER_MARGIN) + BUFFER_MARGIN;
+	ret = wave5_vdi_allocate_dma_memory(vpu_dev, &vb_fbc_c_tbl);
+	if (ret)
+		goto free_vb_fbc_c_tbl;
+
+	p_enc_info->vb_fbc_c_tbl = vb_fbc_c_tbl;
+
+	if (avc_encoding)
+		sub_sampled_size = WAVE5_SUBSAMPLED_ONE_SIZE_AVC(buf_width, buf_height);
+	else
+		sub_sampled_size = WAVE5_SUBSAMPLED_ONE_SIZE(buf_width, buf_height);
+	vb_sub_sam_buf.size = ALIGN(sub_sampled_size * count, BUFFER_MARGIN) + BUFFER_MARGIN;
+	vb_sub_sam_buf.daddr = 0;
+	ret = wave5_vdi_allocate_dma_memory(vpu_dev, &vb_sub_sam_buf);
+	if (ret)
+		goto free_vb_sam_buf;
+
+	p_enc_info->vb_sub_sam_buf = vb_sub_sam_buf;
+
+	vb_task.size = (p_enc_info->vlc_buf_size * VLC_BUF_NUM) +
+			(p_enc_info->param_buf_size * COMMAND_QUEUE_DEPTH);
+	vb_task.daddr = 0;
+	if (p_enc_info->vb_task.size == 0) {
+		ret = wave5_vdi_allocate_dma_memory(vpu_dev, &vb_task);
+		if (ret)
+			goto free_vb_task;
+
+		p_enc_info->vb_task = vb_task;
+
+		vpu_write_reg(inst->dev, W5_CMD_SET_FB_ADDR_TASK_BUF,
+			      p_enc_info->vb_task.daddr);
+		vpu_write_reg(inst->dev, W5_CMD_SET_FB_TASK_BUF_SIZE, vb_task.size);
+	}
+
+	// set sub-sampled buffer base addr
+	vpu_write_reg(inst->dev, W5_ADDR_SUB_SAMPLED_FB_BASE, vb_sub_sam_buf.daddr);
+	// set sub-sampled buffer size for one frame
+	vpu_write_reg(inst->dev, W5_SUB_SAMPLED_ONE_FB_SIZE, sub_sampled_size);
+
+	endian = wave5_vdi_convert_endian(vpu_dev, fb_arr[0].endian);
+
+	vpu_write_reg(inst->dev, W5_PIC_SIZE, pic_size);
+
+	// set stride of luma/chroma for compressed buffer
+	if ((p_enc_info->rotation_angle || p_enc_info->mirror_direction) &&
+	    !(p_enc_info->rotation_angle == 180 &&
+	    p_enc_info->mirror_direction == MIRDIR_HOR_VER)) {
+		luma_stride = calculate_luma_stride(buf_width, bit_depth);
+		chroma_stride = calculate_chroma_stride(buf_width / 2, bit_depth);
+	} else {
+		luma_stride = calculate_luma_stride(p_open_param->pic_width, bit_depth);
+		chroma_stride = calculate_chroma_stride(p_open_param->pic_width / 2, bit_depth);
+	}
+
+	vpu_write_reg(inst->dev, W5_FBC_STRIDE, luma_stride << 16 | chroma_stride);
+	vpu_write_reg(inst->dev, W5_COMMON_PIC_INFO, stride);
+
+	remain = count;
+	cnt_8_chunk = ALIGN(count, 8) / 8;
+	idx = 0;
+	for (j = 0; j < cnt_8_chunk; j++) {
+		reg_val = (endian << 16) | (j == cnt_8_chunk - 1) << 4 | ((j == 0) << 3);
+		reg_val |= (p_open_param->enable_non_ref_fbc_write << 26);
+		vpu_write_reg(inst->dev, W5_SFB_OPTION, reg_val);
+		start_no = j * 8;
+		end_no = start_no + ((remain >= 8) ? 8 : remain) - 1;
+
+		vpu_write_reg(inst->dev, W5_SET_FB_NUM, (start_no << 8) | end_no);
+
+		for (i = 0; i < 8 && i < remain; i++) {
+			vpu_write_reg(inst->dev, W5_ADDR_LUMA_BASE0 + (i << 4), fb_arr[i +
+					start_no].buf_y);
+			vpu_write_reg(inst->dev, W5_ADDR_CB_BASE0 + (i << 4),
+				      fb_arr[i + start_no].buf_cb);
+			/* luma FBC offset table */
+			vpu_write_reg(inst->dev, W5_ADDR_FBC_Y_OFFSET0 + (i << 4),
+				      vb_fbc_y_tbl.daddr + idx * fbc_y_tbl_size);
+			/* chroma FBC offset table */
+			vpu_write_reg(inst->dev, W5_ADDR_FBC_C_OFFSET0 + (i << 4),
+				      vb_fbc_c_tbl.daddr + idx * fbc_c_tbl_size);
+
+			vpu_write_reg(inst->dev, W5_ADDR_MV_COL0 + (i << 2),
+				      vb_mv.daddr + idx * mv_col_size);
+			idx++;
+		}
+		remain -= i;
+
+		wave5_bit_issue_command(inst, W5_SET_FB);
+		ret = wave5_wait_vpu_busy(inst->dev, W5_VPU_BUSY_STATUS);
+		if (ret)
+			goto free_vb_mem;
+	}
+
+	reg_val = vpu_read_reg(inst->dev, W5_RET_SUCCESS);
+	if (!reg_val) {
+		ret = -EIO;
+		goto free_vb_mem;
+	}
+
+	return ret;
+
+free_vb_mem:
+	wave5_vdi_free_dma_memory(vpu_dev, &vb_task);
+free_vb_task:
+	wave5_vdi_free_dma_memory(vpu_dev, &vb_sub_sam_buf);
+free_vb_sam_buf:
+	wave5_vdi_free_dma_memory(vpu_dev, &vb_fbc_c_tbl);
+free_vb_fbc_c_tbl:
+	wave5_vdi_free_dma_memory(vpu_dev, &vb_fbc_y_tbl);
+free_vb_fbc_y_tbl:
+	wave5_vdi_free_dma_memory(vpu_dev, &vb_mv);
+	return ret;
+}
+
+int wave5_vpu_encode(struct vpu_instance *inst, struct enc_param *option, u32 *fail_res)
+{
+	u32 src_frame_format;
+	u32 reg_val = 0, bs_endian;
+	u32 src_stride_c = 0;
+	struct enc_info *p_enc_info = &inst->codec_info->enc_info;
+	struct frame_buffer *p_src_frame = option->source_frame;
+	struct enc_open_param *p_open_param = &p_enc_info->open_param;
+	bool justified = WTL_RIGHT_JUSTIFIED;
+	u32 format_no = WTL_PIXEL_8BIT;
+	int ret;
+
+	if (inst->dev->product != PRODUCT_ID_521)
+		return -EINVAL;
+
+	vpu_write_reg(inst->dev, W5_CMD_ENC_BS_START_ADDR, option->pic_stream_buffer_addr);
+	vpu_write_reg(inst->dev, W5_CMD_ENC_BS_SIZE, option->pic_stream_buffer_size);
+	p_enc_info->stream_buf_start_addr = option->pic_stream_buffer_addr;
+	p_enc_info->stream_buf_size = option->pic_stream_buffer_size;
+	p_enc_info->stream_buf_end_addr =
+		option->pic_stream_buffer_addr + option->pic_stream_buffer_size;
+
+	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_SRC_AXI_SEL, DEFAULT_SRC_AXI);
+	/* secondary AXI */
+	reg_val = (p_enc_info->sec_axi_info.wave.use_enc_rdo_enable << 11) |
+		(p_enc_info->sec_axi_info.wave.use_enc_lf_enable << 15);
+	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_USE_SEC_AXI, reg_val);
+
+	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_REPORT_PARAM, 0);
+
+	/*
+	 * CODEOPT_ENC_VCL is used to implicitly encode header/headers to generate bitstream.
+	 * (use ENC_PUT_VIDEO_HEADER for give_command to encode only a header)
+	 */
+	if (option->code_option.implicit_header_encode)
+		vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_CODE_OPTION,
+			      CODEOPT_ENC_HEADER_IMPLICIT | CODEOPT_ENC_VCL |
+			      (option->code_option.encode_aud << 5) |
+			      (option->code_option.encode_eos << 6) |
+			      (option->code_option.encode_eob << 7));
+	else
+		vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_CODE_OPTION,
+			      option->code_option.implicit_header_encode |
+			      (option->code_option.encode_vcl << 1) |
+			      (option->code_option.encode_vps << 2) |
+			      (option->code_option.encode_sps << 3) |
+			      (option->code_option.encode_pps << 4) |
+			      (option->code_option.encode_aud << 5) |
+			      (option->code_option.encode_eos << 6) |
+			      (option->code_option.encode_eob << 7));
+
+	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_PIC_PARAM, option->skip_picture |
+		      (option->force_pic_qp_enable << 1) | (option->force_pic_qp_i << 2) |
+		      (option->force_pic_qp_p << 8) | (option->force_pic_qp_b << 14) |
+		      (option->force_pic_type_enable << 20) | (option->force_pic_type << 21) |
+		      (option->force_all_ctu_coef_drop_enable << 24));
+
+	if (option->src_end_flag)
+		// no more source images.
+		vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_SRC_PIC_IDX, 0xFFFFFFFF);
+	else
+		vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_SRC_PIC_IDX, option->src_idx);
+
+	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_SRC_ADDR_Y, p_src_frame->buf_y);
+	if (p_open_param->cbcr_order == CBCR_ORDER_NORMAL) {
+		vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_SRC_ADDR_U, p_src_frame->buf_cb);
+		vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_SRC_ADDR_V, p_src_frame->buf_cr);
+	} else {
+		vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_SRC_ADDR_U, p_src_frame->buf_cr);
+		vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_SRC_ADDR_V, p_src_frame->buf_cb);
+	}
+
+	switch (p_open_param->src_format) {
+	case FORMAT_420:
+	case FORMAT_422:
+	case FORMAT_YUYV:
+	case FORMAT_YVYU:
+	case FORMAT_UYVY:
+	case FORMAT_VYUY:
+		justified = WTL_LEFT_JUSTIFIED;
+		format_no = WTL_PIXEL_8BIT;
+		src_stride_c = inst->cbcr_interleave ? p_src_frame->stride :
+			(p_src_frame->stride / 2);
+		src_stride_c = (p_open_param->src_format == FORMAT_422) ? src_stride_c * 2 :
+			src_stride_c;
+		break;
+	case FORMAT_420_P10_16BIT_MSB:
+	case FORMAT_422_P10_16BIT_MSB:
+	case FORMAT_YUYV_P10_16BIT_MSB:
+	case FORMAT_YVYU_P10_16BIT_MSB:
+	case FORMAT_UYVY_P10_16BIT_MSB:
+	case FORMAT_VYUY_P10_16BIT_MSB:
+		justified = WTL_RIGHT_JUSTIFIED;
+		format_no = WTL_PIXEL_16BIT;
+		src_stride_c = inst->cbcr_interleave ? p_src_frame->stride :
+			(p_src_frame->stride / 2);
+		src_stride_c = (p_open_param->src_format ==
+				FORMAT_422_P10_16BIT_MSB) ? src_stride_c * 2 : src_stride_c;
+		break;
+	case FORMAT_420_P10_16BIT_LSB:
+	case FORMAT_422_P10_16BIT_LSB:
+	case FORMAT_YUYV_P10_16BIT_LSB:
+	case FORMAT_YVYU_P10_16BIT_LSB:
+	case FORMAT_UYVY_P10_16BIT_LSB:
+	case FORMAT_VYUY_P10_16BIT_LSB:
+		justified = WTL_LEFT_JUSTIFIED;
+		format_no = WTL_PIXEL_16BIT;
+		src_stride_c = inst->cbcr_interleave ? p_src_frame->stride :
+			(p_src_frame->stride / 2);
+		src_stride_c = (p_open_param->src_format ==
+				FORMAT_422_P10_16BIT_LSB) ? src_stride_c * 2 : src_stride_c;
+		break;
+	case FORMAT_420_P10_32BIT_MSB:
+	case FORMAT_422_P10_32BIT_MSB:
+	case FORMAT_YUYV_P10_32BIT_MSB:
+	case FORMAT_YVYU_P10_32BIT_MSB:
+	case FORMAT_UYVY_P10_32BIT_MSB:
+	case FORMAT_VYUY_P10_32BIT_MSB:
+		justified = WTL_RIGHT_JUSTIFIED;
+		format_no = WTL_PIXEL_32BIT;
+		src_stride_c = inst->cbcr_interleave ? p_src_frame->stride :
+			ALIGN(p_src_frame->stride / 2, 16) * BIT(inst->cbcr_interleave);
+		src_stride_c = (p_open_param->src_format ==
+				FORMAT_422_P10_32BIT_MSB) ? src_stride_c * 2 : src_stride_c;
+		break;
+	case FORMAT_420_P10_32BIT_LSB:
+	case FORMAT_422_P10_32BIT_LSB:
+	case FORMAT_YUYV_P10_32BIT_LSB:
+	case FORMAT_YVYU_P10_32BIT_LSB:
+	case FORMAT_UYVY_P10_32BIT_LSB:
+	case FORMAT_VYUY_P10_32BIT_LSB:
+		justified = WTL_LEFT_JUSTIFIED;
+		format_no = WTL_PIXEL_32BIT;
+		src_stride_c = inst->cbcr_interleave ? p_src_frame->stride :
+			ALIGN(p_src_frame->stride / 2, 16) * BIT(inst->cbcr_interleave);
+		src_stride_c = (p_open_param->src_format ==
+				FORMAT_422_P10_32BIT_LSB) ? src_stride_c * 2 : src_stride_c;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	src_frame_format = (inst->cbcr_interleave << 1) | (inst->nv21);
+	switch (p_open_param->packed_format) {
+	case PACKED_YUYV:
+		src_frame_format = 4;
+		break;
+	case PACKED_YVYU:
+		src_frame_format = 5;
+		break;
+	case PACKED_UYVY:
+		src_frame_format = 6;
+		break;
+	case PACKED_VYUY:
+		src_frame_format = 7;
+		break;
+	default:
+		break;
+	}
+
+	reg_val = wave5_vdi_convert_endian(inst->dev, p_open_param->source_endian);
+	bs_endian = (~reg_val & VDI_128BIT_ENDIAN_MASK);
+
+	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_SRC_STRIDE,
+		      (p_src_frame->stride << 16) | src_stride_c);
+	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_SRC_FORMAT, src_frame_format |
+		      (format_no << 3) | (justified << 5) | (bs_endian << 6));
+
+	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_CUSTOM_MAP_OPTION_ADDR,
+		      option->custom_map_opt.addr_custom_map);
+
+	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_CUSTOM_MAP_OPTION_PARAM,
+		      option->custom_map_opt.custom_roi_map_enable |
+		      (option->custom_map_opt.roi_avg_qp << 1) |
+		      (option->custom_map_opt.custom_lambda_map_enable << 8) |
+		      (option->custom_map_opt.custom_mode_map_enable << 9) |
+		      (option->custom_map_opt.custom_coef_drop_enable << 10));
+
+	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_LONGTERM_PIC,
+		      option->use_cur_src_as_longterm_pic | (option->use_longterm_ref << 1));
+
+	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_WP_PIXEL_SIGMA_Y, option->wp_pix_sigma_y);
+	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_WP_PIXEL_SIGMA_C,
+		      (option->wp_pix_sigma_cr << 16) | option->wp_pix_sigma_cb);
+	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_WP_PIXEL_MEAN_Y, option->wp_pix_mean_y);
+	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_WP_PIXEL_MEAN_C,
+		      (option->wp_pix_mean_cr << 16) | (option->wp_pix_mean_cb));
+
+	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_PREFIX_SEI_INFO, 0);
+	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_PREFIX_SEI_NAL_ADDR, 0);
+	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_SUFFIX_SEI_INFO, 0);
+	vpu_write_reg(inst->dev, W5_CMD_ENC_PIC_SUFFIX_SEI_NAL_ADDR, 0);
+
+	wave5_bit_issue_command(inst, W5_ENC_PIC);
+
+	// check QUEUE_DONE
+	ret = wave5_wait_vpu_busy(inst->dev, W5_VPU_BUSY_STATUS);
+	if (ret) {
+		dev_warn(inst->dev->dev, "command: 'W5_ENC_PIC', timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	reg_val = vpu_read_reg(inst->dev, W5_RET_QUEUE_STATUS);
+
+	p_enc_info->instance_queue_count = (reg_val >> 16) & 0xff;
+	p_enc_info->report_queue_count = (reg_val & QUEUE_REPORT_MASK);
+
+	// Check if we were able to add a command into the VCPU QUEUE
+	if (!vpu_read_reg(inst->dev, W5_RET_SUCCESS)) {
+		*fail_res = vpu_read_reg(inst->dev, W5_RET_FAIL_REASON);
+		wave5_print_reg_err(inst->dev, *fail_res);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int wave5_vpu_enc_get_result(struct vpu_instance *inst, struct enc_output_info *result)
+{
+	int ret;
+	u32 encoding_success;
+	u32 reg_val;
+	struct enc_info *p_enc_info = &inst->codec_info->enc_info;
+	struct vpu_device *vpu_dev = inst->dev;
+
+	if (vpu_dev->product != PRODUCT_ID_521)
+		return -EINVAL;
+
+	ret = wave5_send_query(inst, GET_RESULT);
+	if (ret) {
+		if (ret == -EIO) {
+			reg_val = vpu_read_reg(inst->dev, W5_RET_FAIL_REASON);
+			wave5_print_reg_err(inst->dev, reg_val);
+		}
+		return ret;
+	}
+	dev_dbg(inst->dev->dev, "%s: enc pic complete\n", __func__);
+
+	reg_val = vpu_read_reg(inst->dev, W5_RET_QUEUE_STATUS);
+
+	p_enc_info->instance_queue_count = (reg_val >> 16) & 0xff;
+	p_enc_info->report_queue_count = (reg_val & QUEUE_REPORT_MASK);
+
+	encoding_success = vpu_read_reg(inst->dev, W5_RET_ENC_ENCODING_SUCCESS);
+	if (!encoding_success) {
+		result->error_reason = vpu_read_reg(inst->dev, W5_RET_ENC_ERR_INFO);
+		return -EIO;
+	}
+
+	result->warn_info = vpu_read_reg(inst->dev, W5_RET_ENC_WARN_INFO);
+
+	reg_val = vpu_read_reg(inst->dev, W5_RET_ENC_PIC_TYPE);
+	result->pic_type = reg_val & 0xFFFF;
+
+	result->enc_vcl_nut = vpu_read_reg(inst->dev, W5_RET_ENC_VCL_NUT);
+	/*
+	 * To get the reconstructed frame use the following index on
+	 * inst->frame_buf
+	 */
+	result->recon_frame_index = vpu_read_reg(inst->dev, W5_RET_ENC_PIC_IDX);
+	result->enc_pic_byte = vpu_read_reg(inst->dev, W5_RET_ENC_PIC_BYTE);
+	result->enc_src_idx = vpu_read_reg(inst->dev, W5_RET_ENC_USED_SRC_IDX);
+	p_enc_info->stream_wr_ptr = vpu_read_reg(inst->dev, W5_RET_ENC_WR_PTR);
+	p_enc_info->stream_rd_ptr = vpu_read_reg(inst->dev, W5_RET_ENC_RD_PTR);
+
+	result->bitstream_buffer = vpu_read_reg(inst->dev, W5_RET_ENC_RD_PTR);
+	result->rd_ptr = p_enc_info->stream_rd_ptr;
+	result->wr_ptr = p_enc_info->stream_wr_ptr;
+
+	//result for header only(no vcl) encoding
+	if (result->recon_frame_index == RECON_IDX_FLAG_HEADER_ONLY)
+		result->bitstream_size = result->enc_pic_byte;
+	else if (result->recon_frame_index < 0)
+		result->bitstream_size = 0;
+	else
+		result->bitstream_size = result->enc_pic_byte;
+
+	result->enc_host_cmd_tick = vpu_read_reg(inst->dev, W5_RET_ENC_HOST_CMD_TICK);
+	result->enc_encode_end_tick = vpu_read_reg(inst->dev, W5_RET_ENC_ENCODING_END_TICK);
+
+	if (!p_enc_info->first_cycle_check) {
+		result->frame_cycle = (result->enc_encode_end_tick - result->enc_host_cmd_tick) *
+			p_enc_info->cycle_per_tick;
+		p_enc_info->first_cycle_check = true;
+	} else {
+		result->frame_cycle =
+			(result->enc_encode_end_tick - vpu_dev->last_performance_cycles) *
+			p_enc_info->cycle_per_tick;
+		if (vpu_dev->last_performance_cycles < result->enc_host_cmd_tick)
+			result->frame_cycle = (result->enc_encode_end_tick -
+					result->enc_host_cmd_tick) * p_enc_info->cycle_per_tick;
+	}
+	vpu_dev->last_performance_cycles = result->enc_encode_end_tick;
+
+	return 0;
+}
+
+int wave5_vpu_enc_finish_seq(struct vpu_instance *inst, u32 *fail_res)
+{
+	int ret;
+
+	if (inst->dev->product != PRODUCT_ID_521)
+		return -EINVAL;
+
+	wave5_bit_issue_command(inst, W5_DESTROY_INSTANCE);
+	ret = wave5_wait_vpu_busy(inst->dev, W5_VPU_BUSY_STATUS);
+	if (ret)
+		return -ETIMEDOUT;
+
+	if (!vpu_read_reg(inst->dev, W5_RET_SUCCESS)) {
+		*fail_res = vpu_read_reg(inst->dev, W5_RET_FAIL_REASON);
+		wave5_print_reg_err(inst->dev, *fail_res);
+		return -EIO;
+	}
+	return 0;
+}
+
+static int wave5_vpu_enc_check_common_param_valid(struct vpu_instance *inst,
+						  struct enc_open_param *open_param)
+{
+	int i = 0;
+	bool low_delay = true;
+	struct enc_wave_param *param = &open_param->wave_param;
+	struct vpu_device *vpu_dev = inst->dev;
+	struct device *dev = vpu_dev->dev;
+	u32 num_ctu_row = (open_param->pic_height + 64 - 1) / 64;
+	u32 num_ctu_col = (open_param->pic_width + 64 - 1) / 64;
+	u32 ctu_sz = num_ctu_col * num_ctu_row;
+
+	// check low-delay gop structure
+	if (param->gop_preset_idx == PRESET_IDX_CUSTOM_GOP) { /* common gop */
+		if (param->gop_param.custom_gop_size > 1) {
+			s32 min_val = param->gop_param.pic_param[0].poc_offset;
+
+			for (i = 1; i < param->gop_param.custom_gop_size; i++) {
+				if (min_val > param->gop_param.pic_param[i].poc_offset) {
+					low_delay = false;
+					break;
+				}
+				min_val = param->gop_param.pic_param[i].poc_offset;
+			}
+		}
+	}
+
+	if (inst->std == W_HEVC_ENC && low_delay &&
+	    param->decoding_refresh_type == DEC_REFRESH_TYPE_CRA) {
+		dev_warn(dev,
+			 "dec_refresh_type(CRA) shouldn't be used together with low delay GOP\n");
+		dev_warn(dev, "Suggested configuration parameter: decoding refresh type (IDR)\n");
+		param->decoding_refresh_type = 2;
+	}
+
+	if (param->gop_preset_idx == PRESET_IDX_CUSTOM_GOP) {
+		for (i = 0; i < param->gop_param.custom_gop_size; i++) {
+			if (param->gop_param.pic_param[i].temporal_id >= MAX_NUM_TEMPORAL_LAYER) {
+				dev_err(dev, "temporal_id: %d exceeds MAX_NUM_TEMPORAL_LAYER (%u)\n",
+					param->gop_param.pic_param[i].temporal_id,
+					MAX_NUM_TEMPORAL_LAYER);
+				return -EINVAL;
+			}
+
+			if (param->gop_param.pic_param[i].temporal_id < 0) {
+				dev_err(dev, "temporal_id: %d must be greater or equal to 0\n",
+					param->gop_param.pic_param[i].temporal_id);
+				return -EINVAL;
+			}
+		}
+	}
+
+	if (param->wpp_enable && param->independ_slice_mode) {
+		unsigned int num_ctb_in_width = ALIGN(open_param->pic_width, 64) >> 6;
+
+		if (param->independ_slice_mode_arg % num_ctb_in_width) {
+			dev_err(dev, "independ_slice_mode_arg %u must be a multiple of %u\n",
+				param->independ_slice_mode_arg, num_ctb_in_width);
+			return -EINVAL;
+		}
+	}
+
+	// multi-slice & wpp
+	if (param->wpp_enable && param->depend_slice_mode) {
+		dev_err(dev, "wpp_enable && depend_slice_mode cannot be used simultaneously\n");
+		return -EINVAL;
+	}
+
+	if (!param->independ_slice_mode && param->depend_slice_mode) {
+		dev_err(dev, "depend_slice_mode requires independ_slice_mode\n");
+		return -EINVAL;
+	} else if (param->independ_slice_mode &&
+		   param->depend_slice_mode == DEPEND_SLICE_MODE_RECOMMENDED &&
+		   param->independ_slice_mode_arg < param->depend_slice_mode_arg) {
+		dev_err(dev, "independ_slice_mode_arg: %u must be smaller than %u\n",
+			param->independ_slice_mode_arg, param->depend_slice_mode_arg);
+		return -EINVAL;
+	}
+
+	if (param->independ_slice_mode && param->independ_slice_mode_arg > 65535) {
+		dev_err(dev, "independ_slice_mode_arg: %u must be smaller than 65535\n",
+			param->independ_slice_mode_arg);
+		return -EINVAL;
+	}
+
+	if (param->depend_slice_mode && param->depend_slice_mode_arg > 65535) {
+		dev_err(dev, "depend_slice_mode_arg: %u must be smaller than 65535\n",
+			param->depend_slice_mode_arg);
+		return -EINVAL;
+	}
+
+	if (param->conf_win_top % 2) {
+		dev_err(dev, "conf_win_top: %u, must be a multiple of 2\n", param->conf_win_top);
+		return -EINVAL;
+	}
+
+	if (param->conf_win_bot % 2) {
+		dev_err(dev, "conf_win_bot: %u, must be a multiple of 2\n", param->conf_win_bot);
+		return -EINVAL;
+	}
+
+	if (param->conf_win_left % 2) {
+		dev_err(dev, "conf_win_left: %u, must be a multiple of 2\n", param->conf_win_left);
+		return -EINVAL;
+	}
+
+	if (param->conf_win_right % 2) {
+		dev_err(dev, "conf_win_right: %u, Must be a multiple of 2\n",
+			param->conf_win_right);
+		return -EINVAL;
+	}
+
+	if (param->lossless_enable && (param->nr_y_enable || param->nr_cb_enable ||
+				       param->nr_cr_enable)) {
+		/* Noise reduction => en_nr_y, en_nr_cb, en_nr_cr */
+		dev_err(dev, "option noise_reduction cannot be used with lossless_coding\n");
+		return -EINVAL;
+	}
+
+	if (param->lossless_enable && param->bg_detect_enable) {
+		dev_err(dev, "option bg_detect cannot be used with lossless_coding\n");
+		return -EINVAL;
+	}
+
+	if (param->lossless_enable && open_param->rc_enable) {
+		dev_err(dev, "option rate_control cannot be used with lossless_coding\n");
+		return -EINVAL;
+	}
+
+	if (param->lossless_enable && param->roi_enable) {
+		dev_err(dev, "option roi cannot be used with lossless_coding\n");
+		return -EINVAL;
+	}
+
+	if (param->lossless_enable && !param->skip_intra_trans) {
+		dev_err(dev, "option intra_trans_skip must be enabled with lossless_coding\n");
+		return -EINVAL;
+	}
+
+	// intra refresh
+	if (param->intra_refresh_mode && param->intra_refresh_arg == 0) {
+		dev_err(dev, "Invalid refresh argument, mode: %u, refresh: %u must be > 0\n",
+			param->intra_refresh_mode, param->intra_refresh_arg);
+		return -EINVAL;
+	}
+	switch (param->intra_refresh_mode) {
+	case REFRESH_MODE_CTU_ROWS:
+		if (param->intra_mb_refresh_arg > num_ctu_row)
+			goto invalid_refresh_argument;
+		break;
+	case REFRESH_MODE_CTU_COLUMNS:
+		if (param->intra_refresh_arg > num_ctu_col)
+			goto invalid_refresh_argument;
+		break;
+	case REFRESH_MODE_CTU_STEP_SIZE:
+		if (param->intra_refresh_arg > ctu_sz)
+			goto invalid_refresh_argument;
+		break;
+	case REFRESH_MODE_CTUS:
+		if (param->intra_refresh_arg > ctu_sz)
+			goto invalid_refresh_argument;
+		if (param->lossless_enable) {
+			dev_err(dev, "mode: %u cannot be used lossless_enable",
+				param->intra_refresh_mode);
+			return -EINVAL;
+		}
+		if (param->roi_enable) {
+			dev_err(dev, "mode: %u cannot be used and roi_enable",
+				param->intra_refresh_mode);
+			return -EINVAL;
+		}
+	};
+	return 0;
+
+invalid_refresh_argument:
+	dev_err(dev, "Invalid refresh argument, mode: %u, refresh: %u > W(%u)xH(%u)\n",
+		param->intra_refresh_mode, param->intra_refresh_arg,
+		num_ctu_row, num_ctu_col);
+	return -EINVAL;
+}
+
+static int wave5_vpu_enc_check_param_valid(struct vpu_device *vpu_dev,
+					   struct enc_open_param *open_param)
+{
+	struct enc_wave_param *param = &open_param->wave_param;
+
+	if (open_param->rc_enable) {
+		if (param->min_qp_i > param->max_qp_i || param->min_qp_p > param->max_qp_p ||
+		    param->min_qp_b > param->max_qp_b) {
+			dev_err(vpu_dev->dev, "Configuration failed because min_qp is greater than max_qp\n");
+			dev_err(vpu_dev->dev, "Suggested configuration parameters: min_qp = max_qp\n");
+			return -EINVAL;
+		}
+
+		if (open_param->bit_rate <= (int)open_param->frame_rate_info) {
+			dev_err(vpu_dev->dev,
+				"enc_bit_rate: %u must be greater than the frame_rate: %u\n",
+				open_param->bit_rate, (int)open_param->frame_rate_info);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int wave5_vpu_enc_check_custom_gop(struct vpu_device *vpu_dev,
+					  struct enc_open_param *open_param)
+{
+	struct custom_gop_param *gop_param;
+	struct custom_gop_pic_param *gop_pic_param;
+	struct custom_gop_pic_param new_gop[MAX_GOP_NUM * 2 + 1];
+
+	unsigned int i, ei, gi;
+	u32 gop_size;
+	s32 curr_poc, ref_poc;
+	s32 enc_tid[MAX_GOP_NUM * 2 + 1];
+
+	gop_param = &open_param->wave_param.gop_param;
+	gop_size = gop_param->custom_gop_size;
+
+	new_gop[0].poc_offset = 0;
+	new_gop[0].temporal_id = 0;
+	new_gop[0].pic_type = PIC_TYPE_I;
+	new_gop[0].use_multi_ref_p = 0;
+	enc_tid[0] = 0;
+
+	for (i = 0; i < gop_size * 2; i++) {
+		ei = i % gop_size;
+		gi = i / gop_size;
+		gop_pic_param = &gop_param->pic_param[ei];
+
+		curr_poc = gi * gop_size + gop_pic_param->poc_offset;
+		new_gop[i + 1].poc_offset = curr_poc;
+		new_gop[i + 1].temporal_id = gop_pic_param->temporal_id;
+		new_gop[i + 1].pic_type = gop_pic_param->pic_type;
+		new_gop[i + 1].ref_poc_l0 = gop_pic_param->ref_poc_l0 + gi * gop_size;
+		new_gop[i + 1].ref_poc_l1 = gop_pic_param->ref_poc_l1 + gi * gop_size;
+		new_gop[i + 1].use_multi_ref_p = gop_pic_param->use_multi_ref_p;
+		enc_tid[i + 1] = -1;
+	}
+
+	for (i = 0; i < gop_size; i++) {
+		gop_pic_param = &gop_param->pic_param[i];
+
+		if (gop_pic_param->poc_offset <= 0) {
+			dev_err(vpu_dev->dev, "POC of the %u-th pic not greater then -1\n", i + 1);
+			return -EINVAL;
+		}
+		if (gop_pic_param->poc_offset > gop_size) {
+			dev_err(vpu_dev->dev, "POC of %uth pic bigger than gop_size\n", i + 1);
+			return -EINVAL;
+		}
+		if (gop_pic_param->temporal_id < 0) {
+			dev_err(vpu_dev->dev, "temporal_id of the %d-th  < 0\n", i + 1);
+			return -EINVAL;
+		}
+	}
+
+	for (ei = 1; ei < gop_size * 2 + 1; ei++) {
+		struct custom_gop_pic_param *cur_pic = &new_gop[ei];
+
+		if (ei <= gop_size) {
+			enc_tid[cur_pic->poc_offset] = cur_pic->temporal_id;
+			continue;
+		}
+
+		if (new_gop[ei].pic_type != PIC_TYPE_I) {
+			ref_poc = cur_pic->ref_poc_l0;
+
+			/* reference picture is not encoded yet */
+			if (enc_tid[ref_poc] < 0) {
+				dev_err(vpu_dev->dev, "1st ref pic can't be ref of pic (POC: %u)\n",
+					cur_pic->poc_offset - gop_size);
+				return -EINVAL;
+			}
+			if (enc_tid[ref_poc] > cur_pic->temporal_id) {
+				dev_err(vpu_dev->dev, "wrong temporal_id of pic (POC: %u)\n",
+					cur_pic->poc_offset - gop_size);
+				return -EINVAL;
+			}
+			if (ref_poc >= cur_pic->poc_offset) {
+				dev_err(vpu_dev->dev, "POC of 1st ref pic of %u-th pic is wrong\n",
+					cur_pic->poc_offset - gop_size);
+				return -EINVAL;
+			}
+		}
+		if (new_gop[ei].pic_type != PIC_TYPE_P) {
+			ref_poc = cur_pic->ref_poc_l1;
+
+			/* reference picture is not encoded yet */
+			if (enc_tid[ref_poc] < 0) {
+				dev_err(vpu_dev->dev, "2nd ref pic can't be ref of pic (POC: %u)\n"
+						, cur_pic->poc_offset - gop_size);
+				return -EINVAL;
+			}
+			if (enc_tid[ref_poc] > cur_pic->temporal_id) {
+				dev_err(vpu_dev->dev,  "temporal_id of %u-th picture is wrong\n",
+					cur_pic->poc_offset - gop_size);
+				return -EINVAL;
+			}
+			if (new_gop[ei].pic_type == PIC_TYPE_P && new_gop[ei].use_multi_ref_p > 0) {
+				if (ref_poc >= cur_pic->poc_offset) {
+					dev_err(vpu_dev->dev,  "bad POC of 2nd ref pic of %uth pic\n",
+						cur_pic->poc_offset - gop_size);
+					return -EINVAL;
+				}
+			} else if (ref_poc == cur_pic->poc_offset) {
+				/* HOST_PIC_TYPE_B */
+				dev_err(vpu_dev->dev,  "POC of 2nd ref pic of %uth pic is wrong\n",
+					cur_pic->poc_offset - gop_size);
+				return -EINVAL;
+			}
+		}
+		curr_poc = cur_pic->poc_offset;
+		enc_tid[curr_poc] = cur_pic->temporal_id;
+	}
+	return 0;
+}
+
+int wave5_vpu_enc_check_open_param(struct vpu_instance *inst, struct enc_open_param *open_param)
+{
+	u32 pic_width;
+	u32 pic_height;
+	s32 product_id = inst->dev->product;
+	struct vpu_attr *p_attr = &inst->dev->attr;
+	struct enc_wave_param *param;
+
+	if (!open_param)
+		return -EINVAL;
+
+	param = &open_param->wave_param;
+	pic_width = open_param->pic_width;
+	pic_height = open_param->pic_height;
+
+	if (inst->id >= MAX_NUM_INSTANCE) {
+		dev_err(inst->dev->dev, "Too many simultaneous instances: %d (max: %u)\n",
+			inst->id, MAX_NUM_INSTANCE);
+		return -EOPNOTSUPP;
+	}
+
+	if (inst->std != W_HEVC_ENC &&
+	    !(inst->std == W_AVC_ENC && product_id == PRODUCT_ID_521)) {
+		dev_err(inst->dev->dev, "Unsupported encoder-codec & product combination\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (param->internal_bit_depth == 10) {
+		if (inst->std == W_HEVC_ENC && !p_attr->support_hevc10bit_enc) {
+			dev_err(inst->dev->dev,
+				"Flag support_hevc10bit_enc must be set to encode 10bit HEVC\n");
+			return -EOPNOTSUPP;
+		} else if (inst->std == W_AVC_ENC && !p_attr->support_avc10bit_enc) {
+			dev_err(inst->dev->dev,
+				"Flag support_avc10bit_enc must be set to encode 10bit AVC\n");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	if (open_param->ring_buffer_enable) {
+		if (open_param->bitstream_buffer % 8) {
+			dev_err(inst->dev->dev,
+				"Bitstream buffer must be aligned to a multiple of 8\n");
+			return -EINVAL;
+		}
+		if (open_param->bitstream_buffer_size % 1024 ||
+		    open_param->bitstream_buffer_size < MIN_BITSTREAM_BUFFER_SIZE) {
+			dev_err(inst->dev->dev,
+				"Bitstream buffer size must be aligned to a multiple of 1024 and have a minimum size of %u\n",
+				MIN_BITSTREAM_BUFFER_SIZE);
+			return -EINVAL;
+		}
+		if (product_id == PRODUCT_ID_521) {
+			if (open_param->bitstream_buffer % 16) {
+				dev_err(inst->dev->dev,
+					"Bitstream buffer must be aligned to a multiple of 16\n");
+				return -EINVAL;
+			}
+			if (open_param->bitstream_buffer_size < MIN_BITSTREAM_BUFFER_SIZE_WAVE521) {
+				dev_err(inst->dev->dev,
+					"Bitstream buffer too small: %u (minimum: %u)\n",
+					open_param->bitstream_buffer_size,
+					MIN_BITSTREAM_BUFFER_SIZE_WAVE521);
+				return -EINVAL;
+			}
+		}
+	}
+
+	if (!open_param->frame_rate_info)
+		return -EINVAL;
+	if (open_param->bit_rate > MAX_BIT_RATE) {
+		dev_err(inst->dev->dev, "Invalid encoding bit-rate: %u (valid: 0-%u)\n",
+			open_param->bit_rate, MAX_BIT_RATE);
+		return -EINVAL;
+	}
+
+	if (pic_width < W5_MIN_ENC_PIC_WIDTH || pic_width > W5_MAX_ENC_PIC_WIDTH ||
+	    pic_height < W5_MIN_ENC_PIC_HEIGHT || pic_height > W5_MAX_ENC_PIC_HEIGHT) {
+		dev_err(inst->dev->dev, "Invalid encoding dimension: %ux%u\n",
+			pic_width, pic_height);
+		return -EINVAL;
+	}
+
+	if (param->profile) {
+		if (inst->std == W_HEVC_ENC) {
+			if ((param->profile != HEVC_PROFILE_MAIN ||
+			     (param->profile == HEVC_PROFILE_MAIN &&
+			      param->internal_bit_depth > 8)) &&
+			    (param->profile != HEVC_PROFILE_MAIN10 ||
+			     (param->profile == HEVC_PROFILE_MAIN10 &&
+			      param->internal_bit_depth < 10)) &&
+			    param->profile != HEVC_PROFILE_STILLPICTURE) {
+				dev_err(inst->dev->dev,
+					"Invalid HEVC encoding profile: %u (bit-depth: %u)\n",
+					param->profile, param->internal_bit_depth);
+				return -EINVAL;
+			}
+		} else if (inst->std == W_AVC_ENC) {
+			if ((param->internal_bit_depth > 8 &&
+			     param->profile != H264_PROFILE_HIGH10)) {
+				dev_err(inst->dev->dev,
+					"Invalid AVC encoding profile: %u (bit-depth: %u)\n",
+					param->profile, param->internal_bit_depth);
+				return -EINVAL;
+			}
+		}
+	}
+
+	if (param->decoding_refresh_type > DEC_REFRESH_TYPE_IDR) {
+		dev_err(inst->dev->dev, "Invalid decoding refresh type: %u (valid: 0-2)\n",
+			param->decoding_refresh_type);
+		return -EINVAL;
+	}
+
+	if (param->gop_preset_idx == PRESET_IDX_CUSTOM_GOP) {
+		if (param->gop_param.custom_gop_size < 1 ||
+		    param->gop_param.custom_gop_size > MAX_GOP_NUM) {
+			dev_err(inst->dev->dev,
+				"Invalid custom group of pictures size: %u (valid: 1-%u)\n",
+				param->gop_param.custom_gop_size, MAX_GOP_NUM);
+			return -EINVAL;
+		}
+	}
+
+	if (inst->std == W_AVC_ENC && param->custom_lambda_enable) {
+		dev_err(inst->dev->dev,
+			"Cannot combine AVC encoding with the custom lambda option\n");
+		return -EINVAL;
+	}
+	if (param->intra_refresh_mode > REFRESH_MODE_CTUS) {
+		dev_err(inst->dev->dev, "Invalid intra refresh mode: %d (valid: 0-4)\n",
+			param->intra_refresh_mode);
+		return -EINVAL;
+	}
+
+	if (inst->std == W_HEVC_ENC && param->independ_slice_mode &&
+	    param->depend_slice_mode > DEPEND_SLICE_MODE_BOOST) {
+		dev_err(inst->dev->dev,
+			"Can't combine slice modes: independent and fast dependent for HEVC\n");
+		return -EINVAL;
+	}
+
+	if (param->scaling_list_enable > 2) {
+		dev_err(inst->dev->dev, "Invalid scaling_list_enable: %u (valid: 0-2)\n",
+			param->scaling_list_enable);
+		return -EINVAL;
+	}
+
+	if (!param->disable_deblk) {
+		if (param->beta_offset_div2 < -6 || param->beta_offset_div2 > 6) {
+			dev_err(inst->dev->dev, "Invalid beta offset: %d (valid: -6-6)\n",
+				param->beta_offset_div2);
+			return -EINVAL;
+		}
+
+		if (param->tc_offset_div2 < -6 || param->tc_offset_div2 > 6) {
+			dev_err(inst->dev->dev, "Invalid tc offset: %d (valid: -6-6)\n",
+				param->tc_offset_div2);
+			return -EINVAL;
+		}
+	}
+
+	if (param->intra_qp > MAX_INTRA_QP) {
+		dev_err(inst->dev->dev,
+			"Invalid intra quantization parameter: %u (valid: 0-%u)\n",
+			param->intra_qp, MAX_INTRA_QP);
+		return -EINVAL;
+	}
+
+	if (open_param->rc_enable) {
+		if (param->min_qp_i > MAX_INTRA_QP || param->max_qp_i > MAX_INTRA_QP ||
+		    param->min_qp_p > MAX_INTRA_QP || param->max_qp_p > MAX_INTRA_QP ||
+		    param->min_qp_b > MAX_INTRA_QP || param->max_qp_b > MAX_INTRA_QP) {
+			dev_err(inst->dev->dev,
+				"Invalid quantization parameter min/max values: "
+				"I: %u-%u, P: %u-%u, B: %u-%u (valid for each: 0-%u)\n",
+				param->min_qp_i, param->max_qp_i, param->min_qp_p, param->max_qp_p,
+				param->min_qp_b, param->max_qp_b, MAX_INTRA_QP);
+			return -EINVAL;
+		}
+
+		if (param->hvs_qp_enable && param->hvs_max_delta_qp > MAX_HVS_MAX_DELTA_QP) {
+			dev_err(inst->dev->dev,
+				"Invalid HVS max delta quantization parameter: %u (valid: 0-%u)\n",
+				param->hvs_max_delta_qp, MAX_HVS_MAX_DELTA_QP);
+			return -EINVAL;
+		}
+
+		if (param->bit_alloc_mode > BIT_ALLOC_MODE_FIXED_RATIO) {
+			dev_err(inst->dev->dev, "Invalid bit alloc mode: %u (valid: 0-2)\n",
+				param->bit_alloc_mode);
+			return -EINVAL;
+		}
+
+		if (open_param->vbv_buffer_size < MIN_VBV_BUFFER_SIZE ||
+		    open_param->vbv_buffer_size > MAX_VBV_BUFFER_SIZE) {
+			dev_err(inst->dev->dev, "VBV buffer size: %u (valid: %u-%u)\n",
+				open_param->vbv_buffer_size, MIN_VBV_BUFFER_SIZE,
+				MAX_VBV_BUFFER_SIZE);
+			return -EINVAL;
+		}
+	}
+
+	if (wave5_vpu_enc_check_common_param_valid(inst, open_param))
+		return -EINVAL;
+
+	if (wave5_vpu_enc_check_param_valid(inst->dev, open_param))
+		return -EINVAL;
+
+	if (param->gop_preset_idx == PRESET_IDX_CUSTOM_GOP) {
+		if (wave5_vpu_enc_check_custom_gop(inst->dev, open_param))
+			return -EINVAL;
+	}
+
+	if (param->chroma_cb_qp_offset < -12 || param->chroma_cb_qp_offset > 12) {
+		dev_err(inst->dev->dev,
+			"Invalid chroma Cb quantization parameter offset: %d (valid: -12-12)\n",
+			param->chroma_cb_qp_offset);
+		return -EINVAL;
+	}
+
+	if (param->chroma_cr_qp_offset < -12 || param->chroma_cr_qp_offset > 12) {
+		dev_err(inst->dev->dev,
+			"Invalid chroma Cr quantization parameter offset: %d (valid: -12-12)\n",
+			param->chroma_cr_qp_offset);
+		return -EINVAL;
+	}
+
+	if (param->intra_refresh_mode == REFRESH_MODE_CTU_STEP_SIZE && !param->intra_refresh_arg) {
+		dev_err(inst->dev->dev,
+			"Intra refresh mode CTU step-size requires an argument\n");
+		return -EINVAL;
+	}
+
+	if (inst->std == W_HEVC_ENC) {
+		if (param->nr_noise_sigma_y > MAX_NOISE_SIGMA ||
+		    param->nr_noise_sigma_cb > MAX_NOISE_SIGMA ||
+		    param->nr_noise_sigma_cr > MAX_NOISE_SIGMA) {
+			dev_err(inst->dev->dev,
+				"Invalid noise sigma Y(%u) Cb(%u) Cr(%u) (valid: %u)\n",
+				param->nr_noise_sigma_y, param->nr_noise_sigma_cb,
+				param->nr_noise_sigma_cr, MAX_NOISE_SIGMA);
+			return -EINVAL;
+		}
+
+		if (param->nr_intra_weight_y > MAX_INTRA_WEIGHT ||
+		    param->nr_intra_weight_cb > MAX_INTRA_WEIGHT ||
+		    param->nr_intra_weight_cr > MAX_INTRA_WEIGHT) {
+			dev_err(inst->dev->dev,
+				"Invalid intra weight Y(%u) Cb(%u) Cr(%u) (valid: %u)\n",
+				param->nr_intra_weight_y, param->nr_intra_weight_cb,
+				param->nr_intra_weight_cr, MAX_INTRA_WEIGHT);
+			return -EINVAL;
+		}
+
+		if (param->nr_inter_weight_y > MAX_INTER_WEIGHT ||
+		    param->nr_inter_weight_cb > MAX_INTER_WEIGHT ||
+		    param->nr_inter_weight_cr > MAX_INTER_WEIGHT) {
+			dev_err(inst->dev->dev,
+				"Invalid inter weight Y(%u) Cb(%u) Cr(%u) (valid: %u)\n",
+				param->nr_inter_weight_y, param->nr_inter_weight_cb,
+				param->nr_inter_weight_cr, MAX_INTER_WEIGHT);
+			return -EINVAL;
+		}
+
+		if ((param->nr_y_enable || param->nr_cb_enable || param->nr_cr_enable) &&
+		    param->lossless_enable) {
+			dev_err(inst->dev->dev,
+				"Can't enable lossless mode with either nr_y, nr_cb or nr_cr\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/media/platform/chips-media/wave5/wave5-regdefine.h b/drivers/media/platform/chips-media/wave5/wave5-regdefine.h
new file mode 100644
index 000000000000..79b2f17dd7f0
--- /dev/null
+++ b/drivers/media/platform/chips-media/wave5/wave5-regdefine.h
@@ -0,0 +1,743 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Wave5 series multi-standard codec IP - wave5 register definitions
+ *
+ * Copyright (C) 2021 CHIPS&MEDIA INC
+ */
+
+#ifndef __WAVE5_REGISTER_DEFINE_H__
+#define __WAVE5_REGISTER_DEFINE_H__
+
+enum W5_VPU_COMMAND {
+	W5_INIT_VPU        = 0x0001,
+	W5_WAKEUP_VPU      = 0x0002,
+	W5_SLEEP_VPU       = 0x0004,
+	W5_CREATE_INSTANCE = 0x0008,            /* queuing command */
+	W5_FLUSH_INSTANCE  = 0x0010,
+	W5_DESTROY_INSTANCE = 0x0020,            /* queuing command */
+	W5_INIT_SEQ        = 0x0040,            /* queuing command */
+	W5_SET_FB          = 0x0080,
+	W5_DEC_PIC         = 0x0100,            /* queuing command */
+	W5_ENC_PIC         = 0x0100,            /* queuing command */
+	W5_ENC_SET_PARAM   = 0x0200,            /* queuing command */
+	W5_QUERY           = 0x4000,
+	W5_UPDATE_BS       = 0x8000,
+	W5_MAX_VPU_COMD	   = 0x10000,
+};
+
+enum QUERY_OPT {
+	GET_VPU_INFO        = 0,
+	SET_WRITE_PROT      = 1,
+	GET_RESULT          = 2,
+	UPDATE_DISP_FLAG    = 3,
+	GET_BW_REPORT       = 4,
+	GET_BS_RD_PTR       = 5,    // for decoder
+	GET_BS_WR_PTR       = 6,    // for encoder
+	GET_SRC_BUF_FLAG    = 7,    // for encoder
+	SET_BS_RD_PTR       = 8,    // for decoder
+	GET_DEBUG_INFO      = 0x61,
+};
+
+/*
+ * A flag of user data buffer full.
+ * User data buffer full flag equal to 1 specifies that de-
+ * coded frame has more user data size than VPU internal
+ * buffer. VPU only dumps the internal buffer size of us-
+ * er data to USER_DATA_BUF_BASE buffer. In other
+ * words, VPU is unable to report the rest of the user data to
+ * USER_DATA_BUF_BASE buffer after the internal buffer
+ * fullness happens.
+ */
+#define USERDATA_FLAG_BUFF_FULL		1
+
+#define W5_REG_BASE                     0x00000000
+#define W5_CMD_REG_BASE                 0x00000100
+#define W5_CMD_REG_END                  0x00000200
+
+/*
+ * common
+ */
+/* power on configuration
+ * PO_DEBUG_MODE    [0]     1 - power on with debug mode
+ * USE_PO_CONF      [3]     1 - use power-on-configuration
+ */
+#define W5_PO_CONF                     (W5_REG_BASE + 0x0000)
+#define W5_VCPU_CUR_PC                 (W5_REG_BASE + 0x0004)
+#define W5_VCPU_CUR_LR                 (W5_REG_BASE + 0x0008)
+#define W5_VPU_PDBG_STEP_MASK_V        (W5_REG_BASE + 0x000C)
+#define W5_VPU_PDBG_CTRL               (W5_REG_BASE + 0x0010) // v_cpu debugger ctrl register
+#define W5_VPU_PDBG_IDX_REG            (W5_REG_BASE + 0x0014) // v_cpu debugger index register
+#define W5_VPU_PDBG_WDATA_REG          (W5_REG_BASE + 0x0018) // v_cpu debugger write data register
+#define W5_VPU_PDBG_RDATA_REG          (W5_REG_BASE + 0x001C) // v_cpu debugger read data register
+
+#define W5_VPU_FIO_CTRL_ADDR           (W5_REG_BASE + 0x0020)
+#define W5_VPU_FIO_DATA                (W5_REG_BASE + 0x0024)
+#define W5_VPU_VINT_REASON_USR         (W5_REG_BASE + 0x0030)
+#define W5_VPU_VINT_REASON_CLR         (W5_REG_BASE + 0x0034)
+#define W5_VPU_HOST_INT_REQ            (W5_REG_BASE + 0x0038)
+#define W5_VPU_VINT_CLEAR              (W5_REG_BASE + 0x003C)
+#define W5_VPU_HINT_CLEAR              (W5_REG_BASE + 0x0040)
+#define W5_VPU_VPU_INT_STS             (W5_REG_BASE + 0x0044)
+#define W5_VPU_VINT_ENABLE             (W5_REG_BASE + 0x0048)
+#define W5_VPU_VINT_REASON             (W5_REG_BASE + 0x004C)
+#define W5_VPU_RESET_REQ               (W5_REG_BASE + 0x0050)
+#define W5_RST_BLOCK_CCLK(_core)       BIT((_core))
+#define W5_RST_BLOCK_CCLK_ALL          (0xff)
+#define W5_RST_BLOCK_BCLK(_core)       (0x100 << (_core))
+#define W5_RST_BLOCK_BCLK_ALL          (0xff00)
+#define W5_RST_BLOCK_ACLK(_core)       (0x10000 << (_core))
+#define W5_RST_BLOCK_ACLK_ALL          (0xff0000)
+#define W5_RST_BLOCK_VCPU_ALL          (0x3f000000)
+#define W5_RST_BLOCK_ALL               (0x3fffffff)
+#define W5_VPU_RESET_STATUS            (W5_REG_BASE + 0x0054)
+
+#define W5_VCPU_RESTART                (W5_REG_BASE + 0x0058)
+#define W5_VPU_CLK_MASK                (W5_REG_BASE + 0x005C)
+
+/* REMAP_CTRL
+ * PAGE SIZE:   [8:0]   0x001 - 4K
+ *                      0x002 - 8K
+ *                      0x004 - 16K
+ *                      ...
+ *                      0x100 - 1M
+ * REGION ATTR1 [10]    0     - normal
+ *                      1     - make bus error for the region
+ * REGION ATTR2 [11]    0     - normal
+ *                      1     - bypass region
+ * REMAP INDEX  [15:12]       - 0 ~ 3
+ * ENDIAN       [19:16]       - see endian_mode in vdi.h
+ * AXI-ID       [23:20]       - upper AXI-ID
+ * BUS_ERROR    [29]    0     - bypass
+ *                      1     - make BUS_ERROR for unmapped region
+ * BYPASS_ALL   [30]    1     - bypass all
+ * ENABLE       [31]    1     - update control register[30:16]
+ */
+#define W5_VPU_REMAP_CTRL                       (W5_REG_BASE + 0x0060)
+#define W5_VPU_REMAP_VADDR                      (W5_REG_BASE + 0x0064)
+#define W5_VPU_REMAP_PADDR                      (W5_REG_BASE + 0x0068)
+#define W5_VPU_REMAP_CORE_START                 (W5_REG_BASE + 0x006C)
+#define W5_VPU_BUSY_STATUS                      (W5_REG_BASE + 0x0070)
+#define W5_VPU_HALT_STATUS                      (W5_REG_BASE + 0x0074)
+#define W5_VPU_VCPU_STATUS                      (W5_REG_BASE + 0x0078)
+#define W5_VPU_RET_PRODUCT_VERSION              (W5_REG_BASE + 0x0094)
+/*
+ * assign vpu_config0          = {conf_map_converter_reg,      // [31]
+ * conf_map_converter_sig,         // [30]
+ * 8'd0,                        // [29:22]
+ * conf_std_switch_en,          // [21]
+ * conf_bg_detect,              // [20]
+ * conf_3dnr_en,                // [19]
+ * conf_one_axi_en,             // [18]
+ * conf_sec_axi_en,             // [17]
+ * conf_bus_info,               // [16]
+ * conf_afbc_en,                // [15]
+ * conf_afbc_version_id,        // [14:12]
+ * conf_fbc_en,                 // [11]
+ * conf_fbc_version_id,         // [10:08]
+ * conf_scaler_en,              // [07]
+ * conf_scaler_version_id,      // [06:04]
+ * conf_bwb_en,                 // [03]
+ * 3'd0};                       // [02:00]
+ */
+#define W5_VPU_RET_VPU_CONFIG0                  (W5_REG_BASE + 0x0098)
+/*
+ * assign vpu_config1          = {4'd0,                        // [31:28]
+ * conf_perf_timer_en,          // [27]
+ * conf_multi_core_en,          // [26]
+ * conf_gcu_en,                 // [25]
+ * conf_cu_report,              // [24]
+ * 4'd0,                        // [23:20]
+ * conf_vcore_id_3,             // [19]
+ * conf_vcore_id_2,             // [18]
+ * conf_vcore_id_1,             // [17]
+ * conf_vcore_id_0,             // [16]
+ * conf_bwb_opt,                // [15]
+ * 7'd0,                        // [14:08]
+ * conf_cod_std_en_reserved_7,  // [7]
+ * conf_cod_std_en_reserved_6,  // [6]
+ * conf_cod_std_en_reserved_5,  // [5]
+ * conf_cod_std_en_reserved_4,  // [4]
+ * conf_cod_std_en_reserved_3,  // [3]
+ * conf_cod_std_en_reserved_2,  // [2]
+ * conf_cod_std_en_vp9,         // [1]
+ * conf_cod_std_en_hevc};       // [0]
+ * }
+ */
+#define W5_VPU_RET_VPU_CONFIG1                  (W5_REG_BASE + 0x009C)
+
+#define W5_VPU_DBG_REG0							(W5_REG_BASE + 0x00f0)
+#define W5_VPU_DBG_REG1							(W5_REG_BASE + 0x00f4)
+#define W5_VPU_DBG_REG2							(W5_REG_BASE + 0x00f8)
+#define W5_VPU_DBG_REG3							(W5_REG_BASE + 0x00fc)
+
+/************************************************************************/
+/* PRODUCT INFORMATION                                                  */
+/************************************************************************/
+#define W5_PRODUCT_NAME                        (W5_REG_BASE + 0x1040)
+#define W5_PRODUCT_NUMBER                      (W5_REG_BASE + 0x1044)
+
+/************************************************************************/
+/* DECODER/ENCODER COMMON                                               */
+/************************************************************************/
+#define W5_COMMAND                              (W5_REG_BASE + 0x0100)
+#define W5_COMMAND_OPTION                       (W5_REG_BASE + 0x0104)
+#define W5_QUERY_OPTION                         (W5_REG_BASE + 0x0104)
+#define W5_RET_SUCCESS                          (W5_REG_BASE + 0x0108)
+#define W5_RET_FAIL_REASON                      (W5_REG_BASE + 0x010C)
+#define W5_RET_QUEUE_FAIL_REASON                (W5_REG_BASE + 0x0110)
+#define W5_CMD_INSTANCE_INFO                    (W5_REG_BASE + 0x0110)
+
+#define W5_RET_QUEUE_STATUS                     (W5_REG_BASE + 0x01E0)
+#define W5_RET_BS_EMPTY_INST                    (W5_REG_BASE + 0x01E4)
+#define W5_RET_QUEUE_CMD_DONE_INST              (W5_REG_BASE + 0x01E8)
+#define W5_RET_STAGE0_INSTANCE_INFO             (W5_REG_BASE + 0x01EC)
+#define W5_RET_STAGE1_INSTANCE_INFO             (W5_REG_BASE + 0x01F0)
+#define W5_RET_STAGE2_INSTANCE_INFO             (W5_REG_BASE + 0x01F4)
+
+#define W5_RET_SEQ_DONE_INSTANCE_INFO           (W5_REG_BASE + 0x01FC)
+
+#define W5_BS_OPTION                            (W5_REG_BASE + 0x0120)
+
+// return info when QUERY (GET_RESULT) for en/decoder
+#define W5_RET_VLC_BUF_SIZE                     (W5_REG_BASE + 0x01B0)
+// return info when QUERY (GET_RESULT) for en/decoder
+#define W5_RET_PARAM_BUF_SIZE                   (W5_REG_BASE + 0x01B4)
+
+// set when SET_FB for en/decoder
+#define W5_CMD_SET_FB_ADDR_TASK_BUF             (W5_REG_BASE + 0x01D4)
+#define W5_CMD_SET_FB_TASK_BUF_SIZE             (W5_REG_BASE + 0x01D8)
+/************************************************************************/
+/* INIT_VPU - COMMON                                                    */
+/************************************************************************/
+/* note: W5_ADDR_CODE_BASE should be aligned to 4KB */
+#define W5_ADDR_CODE_BASE                       (W5_REG_BASE + 0x0110)
+#define W5_CODE_SIZE                            (W5_REG_BASE + 0x0114)
+#define W5_CODE_PARAM                           (W5_REG_BASE + 0x0118)
+#define W5_ADDR_TEMP_BASE                       (W5_REG_BASE + 0x011C)
+#define W5_TEMP_SIZE                            (W5_REG_BASE + 0x0120)
+#define W5_ADDR_SEC_AXI                         (W5_REG_BASE + 0x0124)
+#define W5_SEC_AXI_SIZE                         (W5_REG_BASE + 0x0128)
+#define W5_HW_OPTION                            (W5_REG_BASE + 0x012C)
+#define W5_SEC_AXI_PARAM                        (W5_REG_BASE + 0x0180)
+
+/************************************************************************/
+/* CREATE_INSTANCE - COMMON                                             */
+/************************************************************************/
+#define W5_ADDR_WORK_BASE                       (W5_REG_BASE + 0x0114)
+#define W5_WORK_SIZE                            (W5_REG_BASE + 0x0118)
+#define W5_CMD_DEC_BS_START_ADDR                (W5_REG_BASE + 0x011C)
+#define W5_CMD_DEC_BS_SIZE                      (W5_REG_BASE + 0x0120)
+#define W5_CMD_BS_PARAM                         (W5_REG_BASE + 0x0124)
+#define W5_CMD_EXT_ADDR                         (W5_REG_BASE + 0x0138)
+#define W5_CMD_NUM_CQ_DEPTH_M1                  (W5_REG_BASE + 0x013C)
+#define W5_CMD_ERR_CONCEAL                      (W5_REG_BASE + 0x0140)
+
+/************************************************************************/
+/* DECODER - INIT_SEQ                                                   */
+/************************************************************************/
+#define W5_BS_RD_PTR                            (W5_REG_BASE + 0x0118)
+#define W5_BS_WR_PTR                            (W5_REG_BASE + 0x011C)
+/************************************************************************/
+/* SET_FRAME_BUF                                                        */
+/************************************************************************/
+/* SET_FB_OPTION 0x00       REGISTER FRAMEBUFFERS
+ * 0x01       UPDATE FRAMEBUFFER, just one framebuffer(linear, fbc and mvcol)
+ */
+#define W5_SFB_OPTION                           (W5_REG_BASE + 0x0104)
+#define W5_COMMON_PIC_INFO                      (W5_REG_BASE + 0x0118)
+#define W5_PIC_SIZE                             (W5_REG_BASE + 0x011C)
+#define W5_SET_FB_NUM                           (W5_REG_BASE + 0x0120)
+#define W5_EXTRA_PIC_INFO                       (W5_REG_BASE + 0x0124)
+
+#define W5_ADDR_LUMA_BASE0                      (W5_REG_BASE + 0x0134)
+#define W5_ADDR_CB_BASE0                        (W5_REG_BASE + 0x0138)
+#define W5_ADDR_CR_BASE0                        (W5_REG_BASE + 0x013C)
+// compression offset table for luma
+#define W5_ADDR_FBC_Y_OFFSET0                   (W5_REG_BASE + 0x013C)
+// compression offset table for chroma
+#define W5_ADDR_FBC_C_OFFSET0                   (W5_REG_BASE + 0x0140)
+#define W5_ADDR_LUMA_BASE1                      (W5_REG_BASE + 0x0144)
+#define W5_ADDR_CB_ADDR1                        (W5_REG_BASE + 0x0148)
+#define W5_ADDR_CR_ADDR1                        (W5_REG_BASE + 0x014C)
+// compression offset table for luma
+#define W5_ADDR_FBC_Y_OFFSET1                   (W5_REG_BASE + 0x014C)
+// compression offset table for chroma
+#define W5_ADDR_FBC_C_OFFSET1                   (W5_REG_BASE + 0x0150)
+#define W5_ADDR_LUMA_BASE2                      (W5_REG_BASE + 0x0154)
+#define W5_ADDR_CB_ADDR2                        (W5_REG_BASE + 0x0158)
+#define W5_ADDR_CR_ADDR2                        (W5_REG_BASE + 0x015C)
+// compression offset table for luma
+#define W5_ADDR_FBC_Y_OFFSET2                   (W5_REG_BASE + 0x015C)
+// compression offset table for chroma
+#define W5_ADDR_FBC_C_OFFSET2                   (W5_REG_BASE + 0x0160)
+#define W5_ADDR_LUMA_BASE3                      (W5_REG_BASE + 0x0164)
+#define W5_ADDR_CB_ADDR3                        (W5_REG_BASE + 0x0168)
+#define W5_ADDR_CR_ADDR3                        (W5_REG_BASE + 0x016C)
+// compression offset table for luma
+#define W5_ADDR_FBC_Y_OFFSET3                   (W5_REG_BASE + 0x016C)
+// compression offset table for chroma
+#define W5_ADDR_FBC_C_OFFSET3                   (W5_REG_BASE + 0x0170)
+#define W5_ADDR_LUMA_BASE4                      (W5_REG_BASE + 0x0174)
+#define W5_ADDR_CB_ADDR4                        (W5_REG_BASE + 0x0178)
+#define W5_ADDR_CR_ADDR4                        (W5_REG_BASE + 0x017C)
+// compression offset table for luma
+#define W5_ADDR_FBC_Y_OFFSET4                   (W5_REG_BASE + 0x017C)
+// compression offset table for chroma
+#define W5_ADDR_FBC_C_OFFSET4                   (W5_REG_BASE + 0x0180)
+#define W5_ADDR_LUMA_BASE5                      (W5_REG_BASE + 0x0184)
+#define W5_ADDR_CB_ADDR5                        (W5_REG_BASE + 0x0188)
+#define W5_ADDR_CR_ADDR5                        (W5_REG_BASE + 0x018C)
+// compression offset table for luma
+#define W5_ADDR_FBC_Y_OFFSET5                   (W5_REG_BASE + 0x018C)
+// compression offset table for chroma
+#define W5_ADDR_FBC_C_OFFSET5                   (W5_REG_BASE + 0x0190)
+#define W5_ADDR_LUMA_BASE6                      (W5_REG_BASE + 0x0194)
+#define W5_ADDR_CB_ADDR6                        (W5_REG_BASE + 0x0198)
+#define W5_ADDR_CR_ADDR6                        (W5_REG_BASE + 0x019C)
+// compression offset table for luma
+#define W5_ADDR_FBC_Y_OFFSET6                   (W5_REG_BASE + 0x019C)
+// compression offset table for chroma
+#define W5_ADDR_FBC_C_OFFSET6                   (W5_REG_BASE + 0x01A0)
+#define W5_ADDR_LUMA_BASE7                      (W5_REG_BASE + 0x01A4)
+#define W5_ADDR_CB_ADDR7                        (W5_REG_BASE + 0x01A8)
+#define W5_ADDR_CR_ADDR7                        (W5_REG_BASE + 0x01AC)
+// compression offset table for luma
+#define W5_ADDR_FBC_Y_OFFSET7                   (W5_REG_BASE + 0x01AC)
+// compression offset table for chroma
+#define W5_ADDR_FBC_C_OFFSET7                   (W5_REG_BASE + 0x01B0)
+#define W5_ADDR_MV_COL0                         (W5_REG_BASE + 0x01B4)
+#define W5_ADDR_MV_COL1                         (W5_REG_BASE + 0x01B8)
+#define W5_ADDR_MV_COL2                         (W5_REG_BASE + 0x01BC)
+#define W5_ADDR_MV_COL3                         (W5_REG_BASE + 0x01C0)
+#define W5_ADDR_MV_COL4                         (W5_REG_BASE + 0x01C4)
+#define W5_ADDR_MV_COL5                         (W5_REG_BASE + 0x01C8)
+#define W5_ADDR_MV_COL6                         (W5_REG_BASE + 0x01CC)
+#define W5_ADDR_MV_COL7                         (W5_REG_BASE + 0x01D0)
+
+/* UPDATE_FB */
+/* CMD_SET_FB_STRIDE [15:0]     - FBC framebuffer stride
+ * [31:15]    - linear framebuffer stride
+ */
+#define W5_CMD_SET_FB_STRIDE                    (W5_REG_BASE + 0x0118)
+#define W5_CMD_SET_FB_INDEX                     (W5_REG_BASE + 0x0120)
+#define W5_ADDR_LUMA_BASE                       (W5_REG_BASE + 0x0134)
+#define W5_ADDR_CB_BASE                         (W5_REG_BASE + 0x0138)
+#define W5_ADDR_CR_BASE                         (W5_REG_BASE + 0x013C)
+#define W5_ADDR_MV_COL                          (W5_REG_BASE + 0x0140)
+#define W5_ADDR_FBC_Y_BASE                      (W5_REG_BASE + 0x0144)
+#define W5_ADDR_FBC_C_BASE                      (W5_REG_BASE + 0x0148)
+#define W5_ADDR_FBC_Y_OFFSET                    (W5_REG_BASE + 0x014C)
+#define W5_ADDR_FBC_C_OFFSET                    (W5_REG_BASE + 0x0150)
+
+/************************************************************************/
+/* DECODER - DEC_PIC                                                    */
+/************************************************************************/
+#define W5_CMD_DEC_VCORE_INFO                   (W5_REG_BASE + 0x0194)
+/* sequence change enable mask register
+ * CMD_SEQ_CHANGE_ENABLE_FLAG [5]   profile_idc
+ *                            [16]  pic_width/height_in_luma_sample
+ *                            [19]  sps_max_dec_pic_buffering, max_num_reorder, max_latency_increase
+ */
+#define W5_CMD_SEQ_CHANGE_ENABLE_FLAG           (W5_REG_BASE + 0x0128)
+#define W5_CMD_DEC_USER_MASK                    (W5_REG_BASE + 0x012C)
+#define W5_CMD_DEC_TEMPORAL_ID_PLUS1            (W5_REG_BASE + 0x0130)
+#define W5_CMD_DEC_FORCE_FB_LATENCY_PLUS1       (W5_REG_BASE + 0x0134)
+#define W5_USE_SEC_AXI                          (W5_REG_BASE + 0x0150)
+
+/************************************************************************/
+/* DECODER - QUERY : GET_VPU_INFO                                       */
+/************************************************************************/
+#define W5_RET_FW_VERSION                       (W5_REG_BASE + 0x0118)
+#define W5_RET_PRODUCT_NAME                     (W5_REG_BASE + 0x011C)
+#define W5_RET_PRODUCT_VERSION                  (W5_REG_BASE + 0x0120)
+#define W5_RET_STD_DEF0                         (W5_REG_BASE + 0x0124)
+#define W5_RET_STD_DEF1                         (W5_REG_BASE + 0x0128)
+#define W5_RET_CONF_FEATURE                     (W5_REG_BASE + 0x012C)
+#define W5_RET_CONF_DATE                        (W5_REG_BASE + 0x0130)
+#define W5_RET_CONF_REVISION                    (W5_REG_BASE + 0x0134)
+#define W5_RET_CONF_TYPE                        (W5_REG_BASE + 0x0138)
+#define W5_RET_PRODUCT_ID                       (W5_REG_BASE + 0x013C)
+#define W5_RET_CUSTOMER_ID                      (W5_REG_BASE + 0x0140)
+
+/************************************************************************/
+/* DECODER - QUERY : GET_RESULT                                         */
+/************************************************************************/
+#define W5_CMD_DEC_ADDR_REPORT_BASE         (W5_REG_BASE + 0x0114)
+#define W5_CMD_DEC_REPORT_SIZE              (W5_REG_BASE + 0x0118)
+#define W5_CMD_DEC_REPORT_PARAM             (W5_REG_BASE + 0x011C)
+
+#define W5_RET_DEC_BS_RD_PTR                (W5_REG_BASE + 0x011C)
+#define W5_RET_DEC_SEQ_PARAM                (W5_REG_BASE + 0x0120)
+#define W5_RET_DEC_COLOR_SAMPLE_INFO        (W5_REG_BASE + 0x0124)
+#define W5_RET_DEC_ASPECT_RATIO             (W5_REG_BASE + 0x0128)
+#define W5_RET_DEC_BIT_RATE                 (W5_REG_BASE + 0x012C)
+#define W5_RET_DEC_FRAME_RATE_NR            (W5_REG_BASE + 0x0130)
+#define W5_RET_DEC_FRAME_RATE_DR            (W5_REG_BASE + 0x0134)
+#define W5_RET_DEC_NUM_REQUIRED_FB          (W5_REG_BASE + 0x0138)
+#define W5_RET_DEC_NUM_REORDER_DELAY        (W5_REG_BASE + 0x013C)
+#define W5_RET_DEC_SUB_LAYER_INFO           (W5_REG_BASE + 0x0140)
+#define W5_RET_DEC_NOTIFICATION             (W5_REG_BASE + 0x0144)
+/*
+ * USER_DATA_FLAGS for HEVC/H264 only.
+ * Bits:
+ * [1] - User data buffer full boolean
+ * [2] - VUI parameter flag
+ * [4] - Pic_timing SEI flag
+ * [5] - 1st user_data_registed_itu_t_t35 prefix SEI flag
+ * [6] - user_data_unregistered prefix SEI flag
+ * [7] - 1st user_data_registed_itu_t_t35 suffix SEI flag
+ * [8] - user_data_unregistered suffix SEI flag
+ * [10]- mastering_display_color_volume prefix SEI flag
+ * [11]- chroma_resampling_display_color_volume prefix SEI flag
+ * [12]- knee_function_info SEI flag
+ * [13]- tone_mapping_info prefix SEI flag
+ * [14]- film_grain_characteristics_info prefix SEI flag
+ * [15]- content_light_level_info prefix SEI flag
+ * [16]- color_remapping_info prefix SEI flag
+ * [28]- 2nd user_data_registed_itu_t_t35 prefix SEI flag
+ * [29]- 3rd user_data_registed_itu_t_t35 prefix SEI flag
+ * [30]- 2nd user_data_registed_itu_t_t35 suffix SEI flag
+ * [31]- 3rd user_data_registed_itu_t_t35 suffix SEI flag
+ */
+#define W5_RET_DEC_USERDATA_IDC             (W5_REG_BASE + 0x0148)
+#define W5_RET_DEC_PIC_SIZE                 (W5_REG_BASE + 0x014C)
+#define W5_RET_DEC_CROP_TOP_BOTTOM          (W5_REG_BASE + 0x0150)
+#define W5_RET_DEC_CROP_LEFT_RIGHT          (W5_REG_BASE + 0x0154)
+/*
+ * #define W5_RET_DEC_AU_START_POS             (W5_REG_BASE + 0x0158)
+ * => Access unit (AU) Bitstream start position
+ * #define W5_RET_DEC_AU_END_POS               (W5_REG_BASE + 0x015C)
+ * => Access unit (AU) Bitstream end position
+ */
+
+/*
+ * Decoded picture type:
+ * reg_val & 0x7			=> picture type
+ * (reg_val >> 4) & 0x3f		=> VCL NAL unit type
+ * (reg_val >> 31) & 0x1		=> output_flag
+ * 16 << ((reg_val >> 10) & 0x3)	=> ctu_size
+ */
+#define W5_RET_DEC_PIC_TYPE                 (W5_REG_BASE + 0x0160)
+#define W5_RET_DEC_PIC_POC                  (W5_REG_BASE + 0x0164)
+/*
+ * #define W5_RET_DEC_RECOVERY_POINT           (W5_REG_BASE + 0x0168)
+ * => HEVC recovery point
+ * reg_val & 0xff => number of signed recovery picture order counts
+ * (reg_val >> 16) & 0x1 => exact match flag
+ * (reg_val >> 17) & 0x1 => broken link flag
+ * (reg_val >> 18) & 0x1 => exist flag
+ */
+#define W5_RET_DEC_DEBUG_INDEX              (W5_REG_BASE + 0x016C)
+#define W5_RET_DEC_DECODED_INDEX            (W5_REG_BASE + 0x0170)
+#define W5_RET_DEC_DISPLAY_INDEX            (W5_REG_BASE + 0x0174)
+/*
+ * #define W5_RET_DEC_REALLOC_INDEX            (W5_REG_BASE + 0x0178)
+ * => display picture index in decoded picture buffer
+ * reg_val & 0xf => display picture index for FBC buffer (by reordering)
+ */
+#define W5_RET_DEC_DISP_IDC                 (W5_REG_BASE + 0x017C)
+/*
+ * #define W5_RET_DEC_ERR_CTB_NUM              (W5_REG_BASE + 0x0180)
+ * => Number of error CTUs
+ * reg_val >> 16	=> erroneous CTUs in bitstream
+ * reg_val & 0xffff	=> total CTUs in bitstream
+ *
+ * #define W5_RET_DEC_PIC_PARAM                (W5_REG_BASE + 0x01A0)
+ * => Bitstream sequence/picture parameter information (AV1 only)
+ * reg_val & 0x1 => intrabc tool enable
+ * (reg_val >> 1) & 0x1 => screen content tools enable
+ */
+#define W5_RET_DEC_HOST_CMD_TICK            (W5_REG_BASE + 0x01B8)
+/*
+ * #define W5_RET_DEC_SEEK_START_TICK          (W5_REG_BASE + 0x01BC)
+ * #define W5_RET_DEC_SEEK_END_TICK            (W5_REG_BASE + 0x01C0)
+ * => Start and end ticks for seeking slices of the picture
+ * #define W5_RET_DEC_PARSING_START_TICK       (W5_REG_BASE + 0x01C4)
+ * #define W5_RET_DEC_PARSING_END_TICK         (W5_REG_BASE + 0x01C8)
+ * => Start and end ticks for parsing slices of the picture
+ * #define W5_RET_DEC_DECODING_START_TICK      (W5_REG_BASE + 0x01CC)
+ * => Start tick for decoding slices of the picture
+ */
+#define W5_RET_DEC_DECODING_ENC_TICK        (W5_REG_BASE + 0x01D0)
+#define W5_RET_DEC_WARN_INFO                (W5_REG_BASE + 0x01D4)
+#define W5_RET_DEC_ERR_INFO                 (W5_REG_BASE + 0x01D8)
+#define W5_RET_DEC_DECODING_SUCCESS         (W5_REG_BASE + 0x01DC)
+
+/************************************************************************/
+/* DECODER - FLUSH_INSTANCE                                             */
+/************************************************************************/
+#define W5_CMD_FLUSH_INST_OPT               (W5_REG_BASE + 0x104)
+
+/************************************************************************/
+/* DECODER - QUERY : UPDATE_DISP_FLAG                                   */
+/************************************************************************/
+#define W5_CMD_DEC_SET_DISP_IDC             (W5_REG_BASE + 0x0118)
+#define W5_CMD_DEC_CLR_DISP_IDC             (W5_REG_BASE + 0x011C)
+
+/************************************************************************/
+/* DECODER - QUERY : SET_BS_RD_PTR                                      */
+/************************************************************************/
+#define W5_RET_QUERY_DEC_SET_BS_RD_PTR      (W5_REG_BASE + 0x011C)
+
+/************************************************************************/
+/* DECODER - QUERY : GET_BS_RD_PTR                                      */
+/************************************************************************/
+#define W5_RET_QUERY_DEC_BS_RD_PTR          (W5_REG_BASE + 0x011C)
+
+/************************************************************************/
+/* QUERY : GET_DEBUG_INFO                                               */
+/************************************************************************/
+#define W5_RET_QUERY_DEBUG_PRI_REASON       (W5_REG_BASE + 0x114)
+
+/************************************************************************/
+/* GDI register for debugging                                           */
+/************************************************************************/
+#define W5_GDI_BASE                         0x8800
+#define W5_GDI_BUS_CTRL                     (W5_GDI_BASE + 0x0F0)
+#define W5_GDI_BUS_STATUS                   (W5_GDI_BASE + 0x0F4)
+
+#define W5_BACKBONE_BASE_VCPU               0xFE00
+#define W5_BACKBONE_BUS_CTRL_VCPU           (W5_BACKBONE_BASE_VCPU + 0x010)
+#define W5_BACKBONE_BUS_STATUS_VCPU         (W5_BACKBONE_BASE_VCPU + 0x014)
+#define W5_BACKBONE_PROG_AXI_ID             (W5_BACKBONE_BASE_VCPU + 0x00C)
+
+#define W5_BACKBONE_PROC_EXT_ADDR           (W5_BACKBONE_BASE_VCPU + 0x0C0)
+#define W5_BACKBONE_AXI_PARAM               (W5_BACKBONE_BASE_VCPU + 0x0E0)
+
+#define W5_BACKBONE_BASE_VCORE0             0x8E00
+#define W5_BACKBONE_BUS_CTRL_VCORE0         (W5_BACKBONE_BASE_VCORE0 + 0x010)
+#define W5_BACKBONE_BUS_STATUS_VCORE0       (W5_BACKBONE_BASE_VCORE0 + 0x014)
+
+#define W5_BACKBONE_BASE_VCORE1             0x9E00  // for dual-core product
+#define W5_BACKBONE_BUS_CTRL_VCORE1         (W5_BACKBONE_BASE_VCORE1 + 0x010)
+#define W5_BACKBONE_BUS_STATUS_VCORE1       (W5_BACKBONE_BASE_VCORE1 + 0x014)
+
+#define W5_COMBINED_BACKBONE_BASE           0xFE00
+#define W5_COMBINED_BACKBONE_BUS_CTRL       (W5_COMBINED_BACKBONE_BASE + 0x010)
+#define W5_COMBINED_BACKBONE_BUS_STATUS     (W5_COMBINED_BACKBONE_BASE + 0x014)
+
+/************************************************************************/
+/*                                                                      */
+/*               for  ENCODER                                           */
+/*                                                                      */
+/************************************************************************/
+#define W5_RET_STAGE3_INSTANCE_INFO             (W5_REG_BASE + 0x1F8)
+/************************************************************************/
+/* ENCODER - CREATE_INSTANCE                                            */
+/************************************************************************/
+// 0x114 ~ 0x124 : defined above (CREATE_INSTANCE COMMON)
+#define W5_CMD_ENC_VCORE_INFO                   (W5_REG_BASE + 0x0194)
+#define W5_CMD_ENC_SRC_OPTIONS                  (W5_REG_BASE + 0x0128)
+
+/************************************************************************/
+/* ENCODER - SET_FB                                                     */
+/************************************************************************/
+#define W5_FBC_STRIDE                           (W5_REG_BASE + 0x128)
+#define W5_ADDR_SUB_SAMPLED_FB_BASE             (W5_REG_BASE + 0x12C)
+#define W5_SUB_SAMPLED_ONE_FB_SIZE              (W5_REG_BASE + 0x130)
+
+/************************************************************************/
+/* ENCODER - ENC_SET_PARAM (COMMON & CHANGE_PARAM)                      */
+/************************************************************************/
+#define W5_CMD_ENC_SEQ_SET_PARAM_OPTION         (W5_REG_BASE + 0x104)
+#define W5_CMD_ENC_SEQ_SET_PARAM_ENABLE         (W5_REG_BASE + 0x118)
+#define W5_CMD_ENC_SEQ_SRC_SIZE                 (W5_REG_BASE + 0x11C)
+#define W5_CMD_ENC_SEQ_CUSTOM_MAP_ENDIAN        (W5_REG_BASE + 0x120)
+#define W5_CMD_ENC_SEQ_SPS_PARAM                (W5_REG_BASE + 0x124)
+#define W5_CMD_ENC_SEQ_PPS_PARAM                (W5_REG_BASE + 0x128)
+#define W5_CMD_ENC_SEQ_GOP_PARAM                (W5_REG_BASE + 0x12C)
+#define W5_CMD_ENC_SEQ_INTRA_PARAM              (W5_REG_BASE + 0x130)
+#define W5_CMD_ENC_SEQ_CONF_WIN_TOP_BOT         (W5_REG_BASE + 0x134)
+#define W5_CMD_ENC_SEQ_CONF_WIN_LEFT_RIGHT      (W5_REG_BASE + 0x138)
+#define W5_CMD_ENC_SEQ_RDO_PARAM                (W5_REG_BASE + 0x13C)
+#define W5_CMD_ENC_SEQ_INDEPENDENT_SLICE        (W5_REG_BASE + 0x140)
+#define W5_CMD_ENC_SEQ_DEPENDENT_SLICE          (W5_REG_BASE + 0x144)
+#define W5_CMD_ENC_SEQ_INTRA_REFRESH            (W5_REG_BASE + 0x148)
+#define W5_CMD_ENC_SEQ_INPUT_SRC_PARAM          (W5_REG_BASE + 0x14C)
+
+#define W5_CMD_ENC_SEQ_RC_FRAME_RATE            (W5_REG_BASE + 0x150)
+#define W5_CMD_ENC_SEQ_RC_TARGET_RATE           (W5_REG_BASE + 0x154)
+#define W5_CMD_ENC_SEQ_RC_PARAM                 (W5_REG_BASE + 0x158)
+#define W5_CMD_ENC_SEQ_RC_MIN_MAX_QP            (W5_REG_BASE + 0x15C)
+#define W5_CMD_ENC_SEQ_RC_BIT_RATIO_LAYER_0_3   (W5_REG_BASE + 0x160)
+#define W5_CMD_ENC_SEQ_RC_BIT_RATIO_LAYER_4_7   (W5_REG_BASE + 0x164)
+#define W5_CMD_ENC_SEQ_RC_INTER_MIN_MAX_QP      (W5_REG_BASE + 0x168)
+#define W5_CMD_ENC_SEQ_RC_WEIGHT_PARAM          (W5_REG_BASE + 0x16C)
+
+#define W5_CMD_ENC_SEQ_ROT_PARAM                (W5_REG_BASE + 0x170)
+#define W5_CMD_ENC_SEQ_NUM_UNITS_IN_TICK        (W5_REG_BASE + 0x174)
+#define W5_CMD_ENC_SEQ_TIME_SCALE               (W5_REG_BASE + 0x178)
+#define W5_CMD_ENC_SEQ_NUM_TICKS_POC_DIFF_ONE   (W5_REG_BASE + 0x17C)
+
+#define W5_CMD_ENC_SEQ_CUSTOM_MD_PU04           (W5_REG_BASE + 0x184)
+#define W5_CMD_ENC_SEQ_CUSTOM_MD_PU08           (W5_REG_BASE + 0x188)
+#define W5_CMD_ENC_SEQ_CUSTOM_MD_PU16           (W5_REG_BASE + 0x18C)
+#define W5_CMD_ENC_SEQ_CUSTOM_MD_PU32           (W5_REG_BASE + 0x190)
+#define W5_CMD_ENC_SEQ_CUSTOM_MD_CU08           (W5_REG_BASE + 0x194)
+#define W5_CMD_ENC_SEQ_CUSTOM_MD_CU16           (W5_REG_BASE + 0x198)
+#define W5_CMD_ENC_SEQ_CUSTOM_MD_CU32           (W5_REG_BASE + 0x19C)
+#define W5_CMD_ENC_SEQ_NR_PARAM                 (W5_REG_BASE + 0x1A0)
+#define W5_CMD_ENC_SEQ_NR_WEIGHT                (W5_REG_BASE + 0x1A4)
+#define W5_CMD_ENC_SEQ_BG_PARAM                 (W5_REG_BASE + 0x1A8)
+#define W5_CMD_ENC_SEQ_CUSTOM_LAMBDA_ADDR       (W5_REG_BASE + 0x1AC)
+#define W5_CMD_ENC_SEQ_USER_SCALING_LIST_ADDR   (W5_REG_BASE + 0x1B0)
+#define W5_CMD_ENC_SEQ_VUI_HRD_PARAM            (W5_REG_BASE + 0x180)
+#define W5_CMD_ENC_SEQ_VUI_RBSP_ADDR            (W5_REG_BASE + 0x1B8)
+#define W5_CMD_ENC_SEQ_HRD_RBSP_ADDR            (W5_REG_BASE + 0x1BC)
+
+/************************************************************************/
+/* ENCODER - ENC_SET_PARAM (CUSTOM_GOP)                                 */
+/************************************************************************/
+#define W5_CMD_ENC_CUSTOM_GOP_PARAM             (W5_REG_BASE + 0x11C)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_0       (W5_REG_BASE + 0x120)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_1       (W5_REG_BASE + 0x124)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_2       (W5_REG_BASE + 0x128)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_3       (W5_REG_BASE + 0x12C)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_4       (W5_REG_BASE + 0x130)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_5       (W5_REG_BASE + 0x134)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_6       (W5_REG_BASE + 0x138)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_7       (W5_REG_BASE + 0x13C)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_8       (W5_REG_BASE + 0x140)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_9       (W5_REG_BASE + 0x144)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_10      (W5_REG_BASE + 0x148)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_11      (W5_REG_BASE + 0x14C)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_12      (W5_REG_BASE + 0x150)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_13      (W5_REG_BASE + 0x154)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_14      (W5_REG_BASE + 0x158)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_15      (W5_REG_BASE + 0x15C)
+
+/************************************************************************/
+/* ENCODER - ENC_PIC                                                    */
+/************************************************************************/
+#define W5_CMD_ENC_BS_START_ADDR                (W5_REG_BASE + 0x118)
+#define W5_CMD_ENC_BS_SIZE                      (W5_REG_BASE + 0x11C)
+#define W5_CMD_ENC_PIC_USE_SEC_AXI              (W5_REG_BASE + 0x124)
+#define W5_CMD_ENC_PIC_REPORT_PARAM             (W5_REG_BASE + 0x128)
+
+#define W5_CMD_ENC_PIC_CUSTOM_MAP_OPTION_PARAM  (W5_REG_BASE + 0x138)
+#define W5_CMD_ENC_PIC_CUSTOM_MAP_OPTION_ADDR   (W5_REG_BASE + 0x13C)
+#define W5_CMD_ENC_PIC_SRC_PIC_IDX              (W5_REG_BASE + 0x144)
+#define W5_CMD_ENC_PIC_SRC_ADDR_Y               (W5_REG_BASE + 0x148)
+#define W5_CMD_ENC_PIC_SRC_ADDR_U               (W5_REG_BASE + 0x14C)
+#define W5_CMD_ENC_PIC_SRC_ADDR_V               (W5_REG_BASE + 0x150)
+#define W5_CMD_ENC_PIC_SRC_STRIDE               (W5_REG_BASE + 0x154)
+#define W5_CMD_ENC_PIC_SRC_FORMAT               (W5_REG_BASE + 0x158)
+#define W5_CMD_ENC_PIC_SRC_AXI_SEL              (W5_REG_BASE + 0x160)
+#define W5_CMD_ENC_PIC_CODE_OPTION              (W5_REG_BASE + 0x164)
+#define W5_CMD_ENC_PIC_PIC_PARAM                (W5_REG_BASE + 0x168)
+#define W5_CMD_ENC_PIC_LONGTERM_PIC             (W5_REG_BASE + 0x16C)
+#define W5_CMD_ENC_PIC_WP_PIXEL_SIGMA_Y         (W5_REG_BASE + 0x170)
+#define W5_CMD_ENC_PIC_WP_PIXEL_SIGMA_C         (W5_REG_BASE + 0x174)
+#define W5_CMD_ENC_PIC_WP_PIXEL_MEAN_Y          (W5_REG_BASE + 0x178)
+#define W5_CMD_ENC_PIC_WP_PIXEL_MEAN_C          (W5_REG_BASE + 0x17C)
+#define W5_CMD_ENC_PIC_CF50_Y_OFFSET_TABLE_ADDR  (W5_REG_BASE + 0x190)
+#define W5_CMD_ENC_PIC_CF50_CB_OFFSET_TABLE_ADDR (W5_REG_BASE + 0x194)
+#define W5_CMD_ENC_PIC_CF50_CR_OFFSET_TABLE_ADDR (W5_REG_BASE + 0x198)
+#define W5_CMD_ENC_PIC_PREFIX_SEI_NAL_ADDR       (W5_REG_BASE + 0x180)
+#define W5_CMD_ENC_PIC_PREFIX_SEI_INFO           (W5_REG_BASE + 0x184)
+#define W5_CMD_ENC_PIC_SUFFIX_SEI_NAL_ADDR       (W5_REG_BASE + 0x188)
+#define W5_CMD_ENC_PIC_SUFFIX_SEI_INFO           (W5_REG_BASE + 0x18c)
+
+/************************************************************************/
+/* ENCODER - QUERY (GET_RESULT)                                         */
+/************************************************************************/
+#define W5_RET_ENC_NUM_REQUIRED_FB              (W5_REG_BASE + 0x11C)
+#define W5_RET_ENC_MIN_SRC_BUF_NUM              (W5_REG_BASE + 0x120)
+#define W5_RET_ENC_PIC_TYPE                     (W5_REG_BASE + 0x124)
+/*
+ * #define W5_RET_ENC_PIC_POC                      (W5_REG_BASE + 0x128)
+ * => picture order count value of current encoded picture
+ */
+#define W5_RET_ENC_PIC_IDX                      (W5_REG_BASE + 0x12C)
+/*
+ * #define W5_RET_ENC_PIC_SLICE_NUM                (W5_REG_BASE + 0x130)
+ * reg_val & 0xffff = total independent slice segment number (16 bits)
+ * (reg_val >> 16) & 0xffff = total dependent slice segment number (16 bits)
+ *
+ * #define W5_RET_ENC_PIC_SKIP                     (W5_REG_BASE + 0x134)
+ * reg_val & 0xfe = picture skip flag (7 bits)
+ *
+ * #define W5_RET_ENC_PIC_NUM_INTRA                (W5_REG_BASE + 0x138)
+ * => number of intra blocks in 8x8 (32 bits)
+ *
+ * #define W5_RET_ENC_PIC_NUM_MERGE                (W5_REG_BASE + 0x13C)
+ * => number of merge blocks in 8x8 (32 bits)
+ *
+ * #define W5_RET_ENC_PIC_NUM_SKIP                 (W5_REG_BASE + 0x144)
+ * => number of skip blocks in 8x8 (32 bits)
+ *
+ * #define W5_RET_ENC_PIC_AVG_CTU_QP               (W5_REG_BASE + 0x148)
+ * => Average CTU QP value (32 bits)
+ */
+#define W5_RET_ENC_PIC_BYTE                     (W5_REG_BASE + 0x14C)
+/*
+ * #define W5_RET_ENC_GOP_PIC_IDX                  (W5_REG_BASE + 0x150)
+ * => picture index in group of pictures
+ */
+#define W5_RET_ENC_USED_SRC_IDX                 (W5_REG_BASE + 0x154)
+/*
+ * #define W5_RET_ENC_PIC_NUM                      (W5_REG_BASE + 0x158)
+ * => encoded picture number
+ */
+#define W5_RET_ENC_VCL_NUT                      (W5_REG_BASE + 0x15C)
+/*
+ * Only for H264:
+ * #define W5_RET_ENC_PIC_DIST_LOW                 (W5_REG_BASE + 0x164)
+ * => lower 32 bits of the sum of squared difference between source Y picture
+ *    and reconstructed Y picture
+ * #define W5_RET_ENC_PIC_DIST_HIGH                (W5_REG_BASE + 0x168)
+ * => upper 32 bits of the sum of squared difference between source Y picture
+ *    and reconstructed Y picture
+ */
+#define W5_RET_ENC_PIC_MAX_LATENCY_PICS     (W5_REG_BASE + 0x16C)
+
+#define W5_RET_ENC_HOST_CMD_TICK                (W5_REG_BASE + 0x1B8)
+/*
+ * #define W5_RET_ENC_PREPARE_START_TICK           (W5_REG_BASE + 0x1BC)
+ * #define W5_RET_ENC_PREPARE_END_TICK             (W5_REG_BASE + 0x1C0)
+ * => Start and end ticks for preparing slices of the picture
+ * #define W5_RET_ENC_PROCESSING_START_TICK        (W5_REG_BASE + 0x1C4)
+ * #define W5_RET_ENC_PROCESSING_END_TICK          (W5_REG_BASE + 0x1C8)
+ * => Start and end ticks for processing slices of the picture
+ * #define W5_RET_ENC_ENCODING_START_TICK          (W5_REG_BASE + 0x1CC)
+ * => Start tick for encoding slices of the picture
+ */
+#define W5_RET_ENC_ENCODING_END_TICK            (W5_REG_BASE + 0x1D0)
+
+#define W5_RET_ENC_WARN_INFO                    (W5_REG_BASE + 0x1D4)
+#define W5_RET_ENC_ERR_INFO                     (W5_REG_BASE + 0x1D8)
+#define W5_RET_ENC_ENCODING_SUCCESS             (W5_REG_BASE + 0x1DC)
+
+/************************************************************************/
+/* ENCODER - QUERY (GET_BS_WR_PTR)                                      */
+/************************************************************************/
+#define W5_RET_ENC_RD_PTR                       (W5_REG_BASE + 0x114)
+#define W5_RET_ENC_WR_PTR                       (W5_REG_BASE + 0x118)
+#define W5_CMD_ENC_REASON_SEL                   (W5_REG_BASE + 0x11C)
+
+/************************************************************************/
+/* ENCODER - QUERY (GET_BW_REPORT)                                      */
+/************************************************************************/
+#define RET_QUERY_BW_PRP_AXI_READ               (W5_REG_BASE + 0x118)
+#define RET_QUERY_BW_PRP_AXI_WRITE              (W5_REG_BASE + 0x11C)
+#define RET_QUERY_BW_FBD_Y_AXI_READ             (W5_REG_BASE + 0x120)
+#define RET_QUERY_BW_FBC_Y_AXI_WRITE            (W5_REG_BASE + 0x124)
+#define RET_QUERY_BW_FBD_C_AXI_READ             (W5_REG_BASE + 0x128)
+#define RET_QUERY_BW_FBC_C_AXI_WRITE            (W5_REG_BASE + 0x12C)
+#define RET_QUERY_BW_PRI_AXI_READ               (W5_REG_BASE + 0x130)
+#define RET_QUERY_BW_PRI_AXI_WRITE              (W5_REG_BASE + 0x134)
+#define RET_QUERY_BW_SEC_AXI_READ               (W5_REG_BASE + 0x138)
+#define RET_QUERY_BW_SEC_AXI_WRITE              (W5_REG_BASE + 0x13C)
+#define RET_QUERY_BW_PROC_AXI_READ              (W5_REG_BASE + 0x140)
+#define RET_QUERY_BW_PROC_AXI_WRITE             (W5_REG_BASE + 0x144)
+#define RET_QUERY_BW_BWB_AXI_WRITE              (W5_REG_BASE + 0x148)
+#define W5_CMD_BW_OPTION                        (W5_REG_BASE + 0x14C)
+
+/************************************************************************/
+/* ENCODER - QUERY (GET_SRC_FLAG)                                       */
+/************************************************************************/
+#define W5_RET_RELEASED_SRC_INSTANCE            (W5_REG_BASE + 0x1EC)
+
+#define W5_ENC_PIC_SUB_FRAME_SYNC_IF            (W5_REG_BASE + 0x0300)
+
+#endif /* __WAVE5_REGISTER_DEFINE_H__ */
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vdi.c b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
new file mode 100644
index 000000000000..8c7c090b4fc2
--- /dev/null
+++ b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Wave5 series multi-standard codec IP - low level access functions
+ *
+ * Copyright (C) 2021 CHIPS&MEDIA INC
+ */
+
+#include <linux/bug.h>
+#include "wave5-vdi.h"
+#include "wave5-vpu.h"
+#include "wave5-regdefine.h"
+#include <linux/delay.h>
+
+#define VDI_SRAM_BASE_ADDR		0x00
+
+#define VDI_SYSTEM_ENDIAN		VDI_LITTLE_ENDIAN
+#define VDI_128BIT_BUS_SYSTEM_ENDIAN	VDI_128BIT_LITTLE_ENDIAN
+
+static int wave5_vdi_allocate_common_memory(struct device *dev)
+{
+	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
+
+	if (!vpu_dev->common_mem.vaddr) {
+		int ret;
+
+		vpu_dev->common_mem.size = SIZE_COMMON;
+		ret = wave5_vdi_allocate_dma_memory(vpu_dev, &vpu_dev->common_mem);
+		if (ret) {
+			dev_err(dev, "unable to allocate common buffer\n");
+			return ret;
+		}
+	}
+
+	dev_dbg(dev, "[VDI] common_mem: daddr=%pad size=%zu vaddr=0x%p\n",
+		&vpu_dev->common_mem.daddr, vpu_dev->common_mem.size, vpu_dev->common_mem.vaddr);
+
+	return 0;
+}
+
+int wave5_vdi_init(struct device *dev)
+{
+	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = wave5_vdi_allocate_common_memory(dev);
+	if (ret < 0) {
+		dev_err(dev, "[VDI] failed to get vpu common buffer from driver\n");
+		return ret;
+	}
+
+	if (!PRODUCT_CODE_W_SERIES(vpu_dev->product_code)) {
+		WARN_ONCE(1, "unsupported product code: 0x%x\n", vpu_dev->product_code);
+		return 0;
+	}
+
+	// if BIT processor is not running.
+	if (wave5_vdi_readl(vpu_dev, W5_VCPU_CUR_PC) == 0) {
+		int i;
+
+		for (i = 0; i < 64; i++)
+			wave5_vdi_write_register(vpu_dev, (i * 4) + 0x100, 0x0);
+	}
+
+	dev_dbg(dev, "[VDI] driver initialized successfully\n");
+
+	return 0;
+}
+
+int wave5_vdi_release(struct device *dev)
+{
+	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
+
+	vpu_dev->vdb_register = NULL;
+	wave5_vdi_free_dma_memory(vpu_dev, &vpu_dev->common_mem);
+
+	return 0;
+}
+
+void wave5_vdi_write_register(struct vpu_device *vpu_dev, u32 addr, u32 data)
+{
+	writel(data, vpu_dev->vdb_register + addr);
+}
+
+unsigned int wave5_vdi_readl(struct vpu_device *vpu_dev, u32 addr)
+{
+	return readl(vpu_dev->vdb_register + addr);
+}
+
+int wave5_vdi_clear_memory(struct vpu_device *vpu_dev, struct vpu_buf *vb)
+{
+	if (!vb || !vb->vaddr) {
+		dev_err(vpu_dev->dev, "%s: unable to clear unmapped buffer\n", __func__);
+		return -EINVAL;
+	}
+
+	memset(vb->vaddr, 0, vb->size);
+	return vb->size;
+}
+
+static void wave5_swap_endian(struct vpu_device *vpu_dev, u8 *data, size_t len,
+			      unsigned int endian);
+
+int wave5_vdi_write_memory(struct vpu_device *vpu_dev, struct vpu_buf *vb, size_t offset,
+			   u8 *data, size_t len, unsigned int endian)
+{
+	if (!vb || !vb->vaddr) {
+		dev_err(vpu_dev->dev, "%s: unable to write to unmapped buffer\n", __func__);
+		return -EINVAL;
+	}
+
+	if (offset > vb->size || len > vb->size || offset + len > vb->size) {
+		dev_err(vpu_dev->dev, "%s: buffer too small\n", __func__);
+		return -ENOSPC;
+	}
+
+	wave5_swap_endian(vpu_dev, data, len, endian);
+	memcpy(vb->vaddr + offset, data, len);
+
+	return len;
+}
+
+int wave5_vdi_allocate_dma_memory(struct vpu_device *vpu_dev, struct vpu_buf *vb)
+{
+	void *vaddr;
+	dma_addr_t daddr;
+
+	if (!vb->size) {
+		dev_err(vpu_dev->dev, "%s: requested size==0\n", __func__);
+		return -EINVAL;
+	}
+
+	vaddr = dma_alloc_coherent(vpu_dev->dev, vb->size, &daddr, GFP_KERNEL);
+	if (!vaddr)
+		return -ENOMEM;
+	vb->vaddr = vaddr;
+	vb->daddr = daddr;
+
+	return 0;
+}
+
+void wave5_vdi_free_dma_memory(struct vpu_device *vpu_dev, struct vpu_buf *vb)
+{
+	if (vb->size == 0)
+		return;
+
+	if (!vb->vaddr)
+		dev_err(vpu_dev->dev, "%s: requested free of unmapped buffer\n", __func__);
+	else
+		dma_free_coherent(vpu_dev->dev, vb->size, vb->vaddr, vb->daddr);
+
+	memset(vb, 0, sizeof(*vb));
+}
+
+unsigned int wave5_vdi_convert_endian(struct vpu_device *vpu_dev, unsigned int endian)
+{
+	if (PRODUCT_CODE_W_SERIES(vpu_dev->product_code)) {
+		switch (endian) {
+		case VDI_LITTLE_ENDIAN:
+			endian = 0x00;
+			break;
+		case VDI_BIG_ENDIAN:
+			endian = 0x0f;
+			break;
+		case VDI_32BIT_LITTLE_ENDIAN:
+			endian = 0x04;
+			break;
+		case VDI_32BIT_BIG_ENDIAN:
+			endian = 0x03;
+			break;
+		}
+	}
+
+	return (endian & 0x0f);
+}
+
+static void byte_swap(unsigned char *data, size_t len)
+{
+	unsigned int i;
+
+	for (i = 0; i < len; i += 2)
+		swap(data[i], data[i + 1]);
+}
+
+static void word_swap(unsigned char *data, size_t len)
+{
+	u16 *ptr = (u16 *)data;
+	unsigned int i;
+	size_t size = len / sizeof(uint16_t);
+
+	for (i = 0; i < size; i += 2)
+		swap(ptr[i], ptr[i + 1]);
+}
+
+static void dword_swap(unsigned char *data, size_t len)
+{
+	u32 *ptr = (u32 *)data;
+	size_t size = len / sizeof(u32);
+	unsigned int i;
+
+	for (i = 0; i < size; i += 2)
+		swap(ptr[i], ptr[i + 1]);
+}
+
+static void lword_swap(unsigned char *data, size_t len)
+{
+	u64 *ptr = (u64 *)data;
+	size_t size = len / sizeof(uint64_t);
+	unsigned int i;
+
+	for (i = 0; i < size; i += 2)
+		swap(ptr[i], ptr[i + 1]);
+}
+
+static void wave5_swap_endian(struct vpu_device *vpu_dev, u8 *data, size_t len,
+			      unsigned int endian)
+{
+	int changes;
+	unsigned int sys_endian = VDI_128BIT_BUS_SYSTEM_ENDIAN;
+	bool byte_change, word_change, dword_change, lword_change;
+
+	if (!PRODUCT_CODE_W_SERIES(vpu_dev->product_code)) {
+		dev_err(vpu_dev->dev, "unknown product id: %08x\n", vpu_dev->product_code);
+		return;
+	}
+
+	endian = wave5_vdi_convert_endian(vpu_dev, endian);
+	sys_endian = wave5_vdi_convert_endian(vpu_dev, sys_endian);
+	if (endian == sys_endian)
+		return;
+
+	changes = endian ^ sys_endian;
+	byte_change = changes & 0x01;
+	word_change = ((changes & 0x02) == 0x02);
+	dword_change = ((changes & 0x04) == 0x04);
+	lword_change = ((changes & 0x08) == 0x08);
+
+	if (byte_change)
+		byte_swap(data, len);
+	if (word_change)
+		word_swap(data, len);
+	if (dword_change)
+		dword_swap(data, len);
+	if (lword_change)
+		lword_swap(data, len);
+}
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vdi.h b/drivers/media/platform/chips-media/wave5/wave5-vdi.h
new file mode 100644
index 000000000000..780be5747332
--- /dev/null
+++ b/drivers/media/platform/chips-media/wave5/wave5-vdi.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Wave5 series multi-standard codec IP - low level access functions
+ *
+ * Copyright (C) 2021 CHIPS&MEDIA INC
+ */
+
+#ifndef _VDI_H_
+#define _VDI_H_
+
+#include "wave5-vpuconfig.h"
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+
+/************************************************************************/
+/* COMMON REGISTERS */
+/************************************************************************/
+#define VPU_PRODUCT_CODE_REGISTER 0x1044
+
+/* system register write */
+#define vpu_write_reg(VPU_INST, ADDR, DATA) wave5_vdi_write_register(VPU_INST, ADDR, DATA)
+/* system register read */
+#define vpu_read_reg(CORE, ADDR) wave5_vdi_readl(CORE, ADDR)
+
+struct vpu_buf {
+	size_t size;
+	dma_addr_t daddr;
+	void *vaddr;
+};
+
+struct dma_vpu_buf {
+	size_t size;
+	dma_addr_t daddr;
+};
+
+enum endian_mode {
+	VDI_LITTLE_ENDIAN = 0, /* 64bit LE */
+	VDI_BIG_ENDIAN, /* 64bit BE */
+	VDI_32BIT_LITTLE_ENDIAN,
+	VDI_32BIT_BIG_ENDIAN,
+	/* WAVE PRODUCTS */
+	VDI_128BIT_LITTLE_ENDIAN = 16,
+	VDI_128BIT_LE_BYTE_SWAP,
+	VDI_128BIT_LE_WORD_SWAP,
+	VDI_128BIT_LE_WORD_BYTE_SWAP,
+	VDI_128BIT_LE_DWORD_SWAP,
+	VDI_128BIT_LE_DWORD_BYTE_SWAP,
+	VDI_128BIT_LE_DWORD_WORD_SWAP,
+	VDI_128BIT_LE_DWORD_WORD_BYTE_SWAP,
+	VDI_128BIT_BE_DWORD_WORD_BYTE_SWAP,
+	VDI_128BIT_BE_DWORD_WORD_SWAP,
+	VDI_128BIT_BE_DWORD_BYTE_SWAP,
+	VDI_128BIT_BE_DWORD_SWAP,
+	VDI_128BIT_BE_WORD_BYTE_SWAP,
+	VDI_128BIT_BE_WORD_SWAP,
+	VDI_128BIT_BE_BYTE_SWAP,
+	VDI_128BIT_BIG_ENDIAN = 31,
+	VDI_ENDIAN_MAX
+};
+
+#define VDI_128BIT_ENDIAN_MASK 0xf
+
+int wave5_vdi_init(struct device *dev);
+int wave5_vdi_release(struct device *dev);	//this function may be called only at system off.
+
+#endif //#ifndef _VDI_H_
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
new file mode 100644
index 000000000000..1458c5587dbc
--- /dev/null
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
@@ -0,0 +1,1040 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Wave5 series multi-standard codec IP - helper functions
+ *
+ * Copyright (C) 2021 CHIPS&MEDIA INC
+ */
+
+#include <linux/bug.h>
+#include "wave5-vpuapi.h"
+#include "wave5-regdefine.h"
+#include "wave5.h"
+
+#define DECODE_ALL_TEMPORAL_LAYERS 0
+#define DECODE_ALL_SPATIAL_LAYERS 0
+
+void wave5_vpu_clear_interrupt_ex(struct vpu_instance *inst, u32 intr_flag)
+{
+	wave5_vpu_clear_interrupt(inst, intr_flag);
+}
+
+static int wave5_initialize_vpu(struct device *dev, u8 *code, size_t size)
+{
+	int ret;
+	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	if (wave5_vpu_is_init(vpu_dev)) {
+		wave5_vpu_re_init(dev, (void *)code, size);
+		ret = -EBUSY;
+		goto err_out;
+	}
+
+	ret = wave5_vpu_reset(dev, SW_RESET_ON_BOOT);
+	if (ret)
+		goto err_out;
+
+	ret = wave5_vpu_init(dev, (void *)code, size);
+
+err_out:
+	mutex_unlock(&vpu_dev->hw_lock);
+	return ret;
+}
+
+int wave5_vpu_init_with_bitcode(struct device *dev, u8 *bitcode, size_t size)
+{
+	if (!bitcode || size == 0)
+		return -EINVAL;
+
+	return wave5_initialize_vpu(dev, bitcode, size);
+}
+
+int wave5_vpu_get_version_info(struct device *dev, u32 *revision, unsigned int *product_id)
+{
+	int ret;
+	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	if (!wave5_vpu_is_init(vpu_dev)) {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	if (product_id)
+		*product_id = vpu_dev->product;
+	ret = wave5_vpu_get_version(vpu_dev, revision);
+
+err_out:
+	mutex_unlock(&vpu_dev->hw_lock);
+	return ret;
+}
+
+static int wave5_check_dec_open_param(struct vpu_instance *inst, struct dec_open_param *param)
+{
+	struct vpu_attr *p_attr = &inst->dev->attr;
+
+	if (inst->id >= MAX_NUM_INSTANCE) {
+		dev_err(inst->dev->dev, "Too many simultaneous instances: %d (max: %u)\n",
+			inst->id, MAX_NUM_INSTANCE);
+		return -EOPNOTSUPP;
+	}
+
+	if (param->bitstream_buffer % 8) {
+		dev_err(inst->dev->dev,
+			"Bitstream buffer must be aligned to a multiple of 8\n");
+		return -EINVAL;
+	}
+
+	if (param->bitstream_mode == BS_MODE_INTERRUPT &&
+	    (param->bitstream_buffer_size % 1024 ||
+	     param->bitstream_buffer_size < MIN_BITSTREAM_BUFFER_SIZE)) {
+		dev_err(inst->dev->dev,
+			"Bitstream buffer size must be aligned to a multiple of 1024 and have a minimum size of %d\n",
+			MIN_BITSTREAM_BUFFER_SIZE);
+		return -EINVAL;
+	}
+
+	if (!(BIT(param->bitstream_mode) && p_attr->support_bitstream_mode)) {
+		dev_err(inst->dev->dev,
+			"Bitstream mode only configurable with the 'support_bitstream_mode' flag");
+		return -EINVAL;
+	}
+
+	if (!(BIT(param->frame_endian) && p_attr->support_endian_mask)) {
+		dev_err(inst->dev->dev,
+			"Frame endianness only configurable with the 'support_endian_mask' flag");
+		return -EINVAL;
+	}
+
+	if (!(BIT(param->stream_endian) && p_attr->support_endian_mask)) {
+		dev_err(inst->dev->dev,
+			"Stream endianness only configurable with the 'support_endian_mask' flag");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int wave5_vpu_dec_open(struct vpu_instance *inst, struct dec_open_param *open_param)
+{
+	struct dec_info *p_dec_info;
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+	dma_addr_t buffer_addr;
+	size_t buffer_size;
+
+	ret = wave5_check_dec_open_param(inst, open_param);
+	if (ret)
+		return ret;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	if (!wave5_vpu_is_init(vpu_dev)) {
+		mutex_unlock(&vpu_dev->hw_lock);
+		return -ENODEV;
+	}
+
+	inst->codec_info = kzalloc(sizeof(*inst->codec_info), GFP_KERNEL);
+	if (!inst->codec_info) {
+		mutex_unlock(&vpu_dev->hw_lock);
+		return -ENOMEM;
+	}
+
+	p_dec_info = &inst->codec_info->dec_info;
+	memcpy(&p_dec_info->open_param, open_param, sizeof(struct dec_open_param));
+
+	buffer_addr = open_param->bitstream_buffer;
+	buffer_size = open_param->bitstream_buffer_size;
+	p_dec_info->stream_wr_ptr = buffer_addr;
+	p_dec_info->stream_rd_ptr = buffer_addr;
+	p_dec_info->stream_buf_start_addr = buffer_addr;
+	p_dec_info->stream_buf_size = buffer_size;
+	p_dec_info->stream_buf_end_addr = buffer_addr + buffer_size;
+	p_dec_info->reorder_enable = TRUE;
+	p_dec_info->mirror_direction = MIRDIR_NONE;
+	p_dec_info->temp_id_select_mode = TEMPORAL_ID_MODE_ABSOLUTE;
+	p_dec_info->target_temp_id = DECODE_ALL_TEMPORAL_LAYERS;
+	p_dec_info->target_spatial_id = DECODE_ALL_SPATIAL_LAYERS;
+
+	ret = wave5_vpu_build_up_dec_param(inst, open_param);
+	if (ret)
+		goto free_codec_info;
+
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return 0;
+
+free_codec_info:
+	kfree(inst->codec_info);
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_dec_close(struct vpu_instance *inst, u32 *fail_res)
+{
+	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+	int i;
+
+	*fail_res = 0;
+	if (!inst->codec_info)
+		return -EINVAL;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	ret = wave5_vpu_dec_finish_seq(inst, fail_res);
+	if (ret) {
+		dev_warn(inst->dev->dev, "dec_finish_seq timed out\n");
+
+		if (*fail_res == WAVE5_SYSERR_VPU_STILL_RUNNING) {
+			mutex_unlock(&vpu_dev->hw_lock);
+			return ret;
+		}
+	}
+
+	dev_dbg(inst->dev->dev, "%s: dec_finish_seq complete\n", __func__);
+
+	if (p_dec_info->vb_work.size)
+		wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_work);
+
+	for (i = 0 ; i < MAX_REG_FRAME; i++) {
+		if (p_dec_info->vb_mv[i].size)
+			wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_mv[i]);
+		if (p_dec_info->vb_fbc_y_tbl[i].size)
+			wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_fbc_y_tbl[i]);
+		if (p_dec_info->vb_fbc_c_tbl[i].size)
+			wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_fbc_c_tbl[i]);
+	}
+
+	if (p_dec_info->vb_task.size)
+		wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_task);
+
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	kfree(inst->codec_info);
+
+	return 0;
+}
+
+int wave5_vpu_dec_issue_seq_init(struct vpu_instance *inst)
+{
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	ret = wave5_vpu_dec_init_seq(inst);
+
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_dec_complete_seq_init(struct vpu_instance *inst, struct dec_initial_info *info)
+{
+	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	ret = wave5_vpu_dec_get_seq_info(inst, info);
+	if (!ret)
+		p_dec_info->initial_info_obtained = true;
+
+	info->rd_ptr = wave5_vpu_dec_get_rd_ptr(inst);
+	info->wr_ptr = p_dec_info->stream_wr_ptr;
+
+	p_dec_info->initial_info = *info;
+
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_dec_register_frame_buffer_ex(struct vpu_instance *inst, int num_of_decoding_fbs,
+					   int num_of_display_fbs, int stride, int height,
+					   int map_type)
+{
+	struct dec_info *p_dec_info;
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+	struct frame_buffer *fb;
+
+	if (num_of_decoding_fbs >= WAVE5_MAX_FBS || num_of_display_fbs >= WAVE5_MAX_FBS)
+		return -EINVAL;
+
+	p_dec_info = &inst->codec_info->dec_info;
+	p_dec_info->num_of_decoding_fbs = num_of_decoding_fbs;
+	p_dec_info->num_of_display_fbs = num_of_display_fbs;
+	p_dec_info->stride = stride;
+
+	if (!p_dec_info->initial_info_obtained)
+		return -EINVAL;
+
+	if (stride < p_dec_info->initial_info.pic_width || (stride % 8 != 0) ||
+	    height < p_dec_info->initial_info.pic_height)
+		return -EINVAL;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	fb = inst->frame_buf;
+	ret = wave5_vpu_dec_register_framebuffer(inst, &fb[p_dec_info->num_of_decoding_fbs],
+						 LINEAR_FRAME_MAP, p_dec_info->num_of_display_fbs);
+	if (ret)
+		goto err_out;
+
+	ret = wave5_vpu_dec_register_framebuffer(inst, &fb[0], COMPRESSED_FRAME_MAP,
+						 p_dec_info->num_of_decoding_fbs);
+
+err_out:
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_dec_get_bitstream_buffer(struct vpu_instance *inst, dma_addr_t *prd_ptr,
+				       dma_addr_t *pwr_ptr, size_t *size)
+{
+	struct dec_info *p_dec_info;
+	dma_addr_t rd_ptr;
+	dma_addr_t wr_ptr;
+	int room;
+	struct vpu_device *vpu_dev = inst->dev;
+	int ret;
+
+	p_dec_info = &inst->codec_info->dec_info;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+	rd_ptr = wave5_vpu_dec_get_rd_ptr(inst);
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	wr_ptr = p_dec_info->stream_wr_ptr;
+
+	if (p_dec_info->open_param.bitstream_mode != BS_MODE_PIC_END) {
+		if (wr_ptr < rd_ptr)
+			room = rd_ptr - wr_ptr;
+		else
+			room = (p_dec_info->stream_buf_end_addr - wr_ptr) +
+				(rd_ptr - p_dec_info->stream_buf_start_addr);
+		room--;
+	} else {
+		room = (p_dec_info->stream_buf_end_addr - wr_ptr);
+	}
+
+	if (prd_ptr)
+		*prd_ptr = rd_ptr;
+	if (pwr_ptr)
+		*pwr_ptr = wr_ptr;
+	if (size)
+		*size = room;
+
+	return 0;
+}
+
+int wave5_vpu_dec_update_bitstream_buffer(struct vpu_instance *inst, size_t size)
+{
+	struct dec_info *p_dec_info;
+	dma_addr_t wr_ptr;
+	dma_addr_t rd_ptr;
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+
+	if (!inst->codec_info)
+		return -EINVAL;
+
+	p_dec_info = &inst->codec_info->dec_info;
+	wr_ptr = p_dec_info->stream_wr_ptr;
+	rd_ptr = p_dec_info->stream_rd_ptr;
+
+	if (size > 0) {
+		if (wr_ptr < rd_ptr && rd_ptr <= wr_ptr + size)
+			return -EINVAL;
+
+		wr_ptr += size;
+
+		if (p_dec_info->open_param.bitstream_mode != BS_MODE_PIC_END) {
+			if (wr_ptr > p_dec_info->stream_buf_end_addr) {
+				u32 room = wr_ptr - p_dec_info->stream_buf_end_addr;
+
+				wr_ptr = p_dec_info->stream_buf_start_addr;
+				wr_ptr += room;
+			} else if (wr_ptr == p_dec_info->stream_buf_end_addr) {
+				wr_ptr = p_dec_info->stream_buf_start_addr;
+			}
+		}
+
+		p_dec_info->stream_wr_ptr = wr_ptr;
+		p_dec_info->stream_rd_ptr = rd_ptr;
+	}
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+	ret = wave5_vpu_dec_set_bitstream_flag(inst, (size == 0));
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_dec_start_one_frame(struct vpu_instance *inst, struct dec_param *param, u32 *res_fail)
+{
+	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+
+	if (p_dec_info->stride == 0) // this means frame buffers have not been registered.
+		return -EINVAL;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	ret = wave5_vpu_decode(inst, param, res_fail);
+
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_dec_set_rd_ptr(struct vpu_instance *inst, dma_addr_t addr, int update_wr_ptr)
+{
+	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	ret = wave5_dec_set_rd_ptr(inst, addr);
+
+	p_dec_info->stream_rd_ptr = addr;
+	if (update_wr_ptr)
+		p_dec_info->stream_wr_ptr = addr;
+
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_dec_get_output_info(struct vpu_instance *inst, struct dec_output_info *info)
+{
+	struct dec_info *p_dec_info;
+	int ret;
+	struct vpu_rect rect_info;
+	u32 val;
+	u32 decoded_index;
+	u32 disp_idx;
+	u32 max_dec_index;
+	struct vpu_device *vpu_dev = inst->dev;
+	struct dec_output_info *disp_info;
+
+	if (!info)
+		return -EINVAL;
+
+	p_dec_info = &inst->codec_info->dec_info;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	memset(info, 0, sizeof(*info));
+
+	ret = wave5_vpu_dec_get_result(inst, info);
+	if (ret) {
+		info->rd_ptr = p_dec_info->stream_rd_ptr;
+		info->wr_ptr = p_dec_info->stream_wr_ptr;
+		goto err_out;
+	}
+
+	decoded_index = info->index_frame_decoded;
+
+	// calculate display frame region
+	val = 0;
+	//default value
+	rect_info.left = 0;
+	rect_info.right = 0;
+	rect_info.top = 0;
+	rect_info.bottom = 0;
+	if (decoded_index < WAVE5_MAX_FBS) {
+		if (inst->std == W_HEVC_DEC || inst->std == W_AVC_DEC)
+			rect_info = p_dec_info->initial_info.pic_crop_rect;
+
+		if (inst->std == W_HEVC_DEC)
+			p_dec_info->dec_out_info[decoded_index].decoded_poc = info->decoded_poc;
+
+		if (inst->std == W_AVS2_DEC)
+			p_dec_info->dec_out_info[decoded_index].avs2_info.decoded_poi =
+				info->avs2_info.decoded_poi;
+
+		p_dec_info->dec_out_info[decoded_index].rc_decoded = rect_info;
+	}
+	info->rc_decoded = rect_info;
+
+	disp_idx = info->index_frame_display;
+	disp_info = &p_dec_info->dec_out_info[disp_idx];
+	if (info->index_frame_display >= 0 && info->index_frame_display < WAVE5_MAX_FBS) {
+		u32 width = info->dec_pic_width;
+		u32 height = info->dec_pic_height;
+
+		if (info->index_frame_display != info->index_frame_decoded) {
+			/*
+			 * when index_frame_decoded < 0, and index_frame_display >= 0
+			 * info->dec_pic_width and info->dec_pic_height are still valid
+			 * but those of p_dec_info->dec_out_info[disp_idx] are invalid in VP9
+			 */
+			width = disp_info->dec_pic_width;
+			height = disp_info->dec_pic_height;
+		}
+		// TODO no rotation/mirror v4l2 cmd implemented for the decoder
+		if (p_dec_info->rotation_enable || p_dec_info->mirror_enable)
+			if (p_dec_info->rotation_angle == 90 || p_dec_info->rotation_angle == 270)
+				swap(width, height);
+
+		if (p_dec_info->rotation_enable) {
+			switch (p_dec_info->rotation_angle) {
+			case 90:
+				info->rc_display.left = disp_info->rc_decoded.top;
+				info->rc_display.right = disp_info->rc_decoded.bottom;
+				info->rc_display.top = disp_info->rc_decoded.right;
+				info->rc_display.bottom = disp_info->rc_decoded.left;
+				break;
+			case 270:
+				info->rc_display.left = disp_info->rc_decoded.bottom;
+				info->rc_display.right = disp_info->rc_decoded.top;
+				info->rc_display.top = disp_info->rc_decoded.left;
+				info->rc_display.bottom = disp_info->rc_decoded.right;
+				break;
+			case 180:
+				info->rc_display.left = disp_info->rc_decoded.right;
+				info->rc_display.right = disp_info->rc_decoded.left;
+				info->rc_display.top = disp_info->rc_decoded.bottom;
+				info->rc_display.bottom = disp_info->rc_decoded.top;
+				break;
+			default:
+				info->rc_display = disp_info->rc_decoded;
+				break;
+			}
+		} else {
+			info->rc_display = disp_info->rc_decoded;
+		}
+
+		if (p_dec_info->mirror_enable) {
+			if (p_dec_info->mirror_direction & MIRDIR_VER)
+				swap(info->rc_display.top, info->rc_display.bottom);
+			if (p_dec_info->mirror_direction & MIRDIR_HOR)
+				swap(info->rc_display.left, info->rc_display.right);
+		}
+
+		switch (inst->std) {
+		case W_AVS2_DEC:
+			info->avs2_info.display_poi =
+				disp_info->avs2_info.decoded_poi;
+			break;
+		default:
+			break;
+		}
+
+		info->disp_pic_width = width;
+		info->disp_pic_height = height;
+	} else {
+		info->rc_display.left = 0;
+		info->rc_display.right = 0;
+		info->rc_display.top = 0;
+		info->rc_display.bottom = 0;
+
+		if (p_dec_info->rotation_enable || p_dec_info->mirror_enable ||
+		    p_dec_info->dering_enable) {
+			info->disp_pic_width = info->dec_pic_width;
+			info->disp_pic_height = info->dec_pic_height;
+		} else {
+			info->disp_pic_width = 0;
+			info->disp_pic_height = 0;
+		}
+	}
+
+	p_dec_info->stream_rd_ptr = wave5_vpu_dec_get_rd_ptr(inst);
+	p_dec_info->frame_display_flag = vpu_read_reg(vpu_dev, W5_RET_DEC_DISP_IDC);
+	if (inst->std == W_VP9_DEC)
+		p_dec_info->frame_display_flag &= 0xFFFF;
+
+	if (p_dec_info->dering_enable || p_dec_info->mirror_enable || p_dec_info->rotation_enable) {
+		info->disp_frame = p_dec_info->rotator_output;
+		info->disp_frame.stride = p_dec_info->rotator_stride;
+	} else {
+		val = p_dec_info->num_of_decoding_fbs; //fb_offset
+
+		max_dec_index = (p_dec_info->num_of_decoding_fbs > p_dec_info->num_of_display_fbs) ?
+			p_dec_info->num_of_decoding_fbs : p_dec_info->num_of_display_fbs;
+
+		if (info->index_frame_display >= 0 &&
+		    info->index_frame_display < (int)max_dec_index)
+			info->disp_frame = inst->frame_buf[val + info->index_frame_display];
+	}
+
+	info->rd_ptr = p_dec_info->stream_rd_ptr;
+	info->wr_ptr = p_dec_info->stream_wr_ptr;
+	info->frame_display_flag = p_dec_info->frame_display_flag;
+
+	info->sequence_no = p_dec_info->initial_info.sequence_no;
+	if (decoded_index < WAVE5_MAX_FBS)
+		p_dec_info->dec_out_info[decoded_index] = *info;
+
+	if (disp_idx < WAVE5_MAX_FBS)
+		info->disp_frame.sequence_no = info->sequence_no;
+
+	if (info->sequence_changed &&
+	    !(info->sequence_changed & SEQ_CHANGE_INTER_RES_CHANGE)) {
+		memcpy((void *)&p_dec_info->initial_info, (void *)&p_dec_info->new_seq_info,
+		       sizeof(struct dec_initial_info));
+		p_dec_info->initial_info.sequence_no++;
+	}
+
+err_out:
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_dec_clr_disp_flag(struct vpu_instance *inst, int index)
+{
+	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
+	int ret = 0;
+	struct vpu_device *vpu_dev = inst->dev;
+
+	if (index >= p_dec_info->num_of_display_fbs)
+		return -EINVAL;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+	ret = wave5_dec_clr_disp_flag(inst, index);
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_dec_set_disp_flag(struct vpu_instance *inst, int index)
+{
+	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
+	int ret = 0;
+	struct vpu_device *vpu_dev = inst->dev;
+
+	if (index >= p_dec_info->num_of_display_fbs)
+		return -EINVAL;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+	ret = wave5_dec_set_disp_flag(inst, index);
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_dec_give_command(struct vpu_instance *inst, enum codec_command cmd, void *parameter)
+{
+	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
+
+	switch (cmd) {
+	case DEC_GET_QUEUE_STATUS: {
+		struct queue_status_info *queue_info = parameter;
+
+		queue_info->instance_queue_count = p_dec_info->instance_queue_count;
+		queue_info->report_queue_count = p_dec_info->report_queue_count;
+		break;
+	}
+	case ENABLE_DEC_THUMBNAIL_MODE:
+		p_dec_info->thumbnail_mode = true;
+		break;
+	case DEC_RESET_FRAMEBUF_INFO: {
+		int i;
+
+		for (i = 0; i < inst->dst_buf_count; i++) {
+			wave5_vdi_free_dma_memory(inst->dev, &inst->frame_vbuf[i]);
+			wave5_vdi_free_dma_memory(inst->dev, &p_dec_info->vb_mv[i]);
+			wave5_vdi_free_dma_memory(inst->dev, &p_dec_info->vb_fbc_y_tbl[i]);
+			wave5_vdi_free_dma_memory(inst->dev, &p_dec_info->vb_fbc_c_tbl[i]);
+		}
+
+		wave5_vdi_free_dma_memory(inst->dev, &p_dec_info->vb_task);
+		break;
+	}
+	case DEC_GET_SEQ_INFO: {
+		struct dec_initial_info *seq_info = parameter;
+
+		*seq_info = p_dec_info->initial_info;
+		break;
+	}
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int wave5_vpu_enc_open(struct vpu_instance *inst, struct enc_open_param *open_param)
+{
+	struct enc_info *p_enc_info;
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+
+	ret = wave5_vpu_enc_check_open_param(inst, open_param);
+	if (ret)
+		return ret;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	if (!wave5_vpu_is_init(vpu_dev)) {
+		mutex_unlock(&vpu_dev->hw_lock);
+		return -ENODEV;
+	}
+
+	inst->codec_info = kzalloc(sizeof(*inst->codec_info), GFP_KERNEL);
+	if (!inst->codec_info) {
+		mutex_unlock(&vpu_dev->hw_lock);
+		return -ENOMEM;
+	}
+
+	p_enc_info = &inst->codec_info->enc_info;
+	p_enc_info->open_param = *open_param;
+
+	ret = wave5_vpu_build_up_enc_param(vpu_dev->dev, inst, open_param);
+	if (ret)
+		goto free_codec_info;
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return 0;
+
+free_codec_info:
+	kfree(inst->codec_info);
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_enc_close(struct vpu_instance *inst, u32 *fail_res)
+{
+	struct enc_info *p_enc_info;
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+	*fail_res = 0;
+
+	if (!inst->codec_info)
+		return -EINVAL;
+	p_enc_info = &inst->codec_info->enc_info;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	ret = wave5_vpu_enc_finish_seq(inst, fail_res);
+	if (ret) {
+		dev_warn(inst->dev->dev, "enc seq end timed out\n");
+
+		if (*fail_res == WAVE5_SYSERR_VPU_STILL_RUNNING) {
+			mutex_unlock(&vpu_dev->hw_lock);
+			return ret;
+		}
+	}
+
+	dev_dbg(inst->dev->dev, "%s: enc seq end timed out\n", __func__);
+
+	if (p_enc_info->vb_work.size)
+		wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_work);
+
+	if (inst->std == W_HEVC_ENC || inst->std == W_AVC_ENC) {
+		if (p_enc_info->vb_sub_sam_buf.size)
+			wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_sub_sam_buf);
+
+		if (p_enc_info->vb_mv.size)
+			wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_mv);
+
+		if (p_enc_info->vb_fbc_y_tbl.size)
+			wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_fbc_y_tbl);
+
+		if (p_enc_info->vb_fbc_c_tbl.size)
+			wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_fbc_c_tbl);
+	}
+
+	if (p_enc_info->vb_task.size)
+		wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_task);
+
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	kfree(inst->codec_info);
+
+	return 0;
+}
+
+int wave5_vpu_enc_register_frame_buffer(struct vpu_instance *inst, unsigned int num,
+					unsigned int stride, int height,
+					enum tiled_map_type map_type)
+{
+	struct enc_info *p_enc_info = &inst->codec_info->enc_info;
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+	unsigned int size_luma, size_chroma;
+	int i;
+
+	if (p_enc_info->stride)
+		return -EINVAL;
+
+	if (!p_enc_info->initial_info_obtained)
+		return -EINVAL;
+
+	if (num < p_enc_info->initial_info.min_frame_buffer_count)
+		return -EINVAL;
+
+	if (stride == 0 || stride % 8 != 0)
+		return -EINVAL;
+
+	if (height <= 0)
+		return -EINVAL;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	p_enc_info->num_frame_buffers = num;
+	p_enc_info->stride = stride;
+
+	size_luma = stride * height;
+	size_chroma = ALIGN(stride / 2, 16) * height;
+
+	for (i = 0; i < num; i++) {
+		if (!inst->frame_buf[i].update_fb_info)
+			continue;
+
+		inst->frame_buf[i].update_fb_info = false;
+		inst->frame_buf[i].stride = stride;
+		inst->frame_buf[i].height = height;
+		inst->frame_buf[i].map_type = COMPRESSED_FRAME_MAP;
+		inst->frame_buf[i].endian = VDI_128BIT_LITTLE_ENDIAN;
+		inst->frame_buf[i].buf_y_size = size_luma;
+		inst->frame_buf[i].buf_cb = inst->frame_buf[i].buf_y + size_luma;
+		inst->frame_buf[i].buf_cb_size = size_chroma;
+		inst->frame_buf[i].buf_cr_size = 0;
+	}
+
+	ret = wave5_vpu_enc_register_framebuffer(inst->dev->dev, inst, &inst->frame_buf[0],
+						 COMPRESSED_FRAME_MAP,
+						 p_enc_info->num_frame_buffers);
+
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+static int wave5_check_enc_param(struct vpu_instance *inst, struct enc_param *param)
+{
+	struct enc_info *p_enc_info = &inst->codec_info->enc_info;
+
+	if (!param)
+		return -EINVAL;
+
+	if (!param->skip_picture && !param->source_frame)
+		return -EINVAL;
+
+	if (p_enc_info->open_param.bit_rate == 0 && inst->std == W_HEVC_ENC) {
+		if (param->force_pic_qp_enable &&
+		    (param->force_pic_qp_i > MAX_INTRA_QP || param->force_pic_qp_p > MAX_INTRA_QP ||
+		     param->force_pic_qp_b > MAX_INTRA_QP))
+			return -EINVAL;
+		if (!p_enc_info->ring_buffer_enable &&
+		    (param->pic_stream_buffer_addr % 16 || param->pic_stream_buffer_size == 0))
+			return -EINVAL;
+	}
+	if (!p_enc_info->ring_buffer_enable &&
+	    (param->pic_stream_buffer_addr % 8 || param->pic_stream_buffer_size == 0))
+		return -EINVAL;
+
+	return 0;
+}
+
+static uint64_t wave5_get_timestamp(struct vpu_instance *inst)
+{
+	struct enc_info *p_enc_info;
+	u64 pts;
+	u32 fps;
+
+	if (!inst->codec_info)
+		return 0;
+
+	p_enc_info = &inst->codec_info->enc_info;
+	fps = p_enc_info->open_param.frame_rate_info;
+	if (fps == 0)
+		fps = 30;
+
+	pts = p_enc_info->cur_pts;
+	p_enc_info->cur_pts += 90000 / fps; /* 90_k_hz/fps */
+
+	return pts;
+}
+
+int wave5_vpu_enc_start_one_frame(struct vpu_instance *inst, struct enc_param *param, u32 *fail_res)
+{
+	struct enc_info *p_enc_info = &inst->codec_info->enc_info;
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+
+	*fail_res = 0;
+
+	if (p_enc_info->stride == 0) // this means frame buffers have not been registered.
+		return -EINVAL;
+
+	ret = wave5_check_enc_param(inst, param);
+	if (ret)
+		return ret;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	p_enc_info->pts_map[param->src_idx] = p_enc_info->open_param.enable_pts ?
+					      wave5_get_timestamp(inst) : param->pts;
+
+	ret = wave5_vpu_encode(inst, param, fail_res);
+
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_enc_get_output_info(struct vpu_instance *inst, struct enc_output_info *info)
+{
+	struct enc_info *p_enc_info = &inst->codec_info->enc_info;
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	ret = wave5_vpu_enc_get_result(inst, info);
+	if (ret) {
+		info->pts = 0;
+		goto unlock;
+	}
+
+	if (info->recon_frame_index >= 0)
+		info->pts = p_enc_info->pts_map[info->enc_src_idx];
+
+unlock:
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_enc_give_command(struct vpu_instance *inst, enum codec_command cmd, void *parameter)
+{
+	struct enc_info *p_enc_info = &inst->codec_info->enc_info;
+
+	switch (cmd) {
+	case ENABLE_ROTATION:
+		p_enc_info->rotation_enable = true;
+		break;
+	case ENABLE_MIRRORING:
+		p_enc_info->mirror_enable = true;
+		break;
+	case SET_MIRROR_DIRECTION: {
+		enum mirror_direction mir_dir;
+
+		mir_dir = *(enum mirror_direction *)parameter;
+		if (mir_dir != MIRDIR_NONE && mir_dir != MIRDIR_HOR &&
+		    mir_dir != MIRDIR_VER && mir_dir != MIRDIR_HOR_VER)
+			return -EINVAL;
+		p_enc_info->mirror_direction = mir_dir;
+		break;
+	}
+	case SET_ROTATION_ANGLE: {
+		int angle;
+
+		angle = *(int *)parameter;
+		if (angle && angle != 90 && angle != 180 && angle != 270)
+			return -EINVAL;
+		if (p_enc_info->initial_info_obtained && (angle == 90 || angle == 270))
+			return -EINVAL;
+		p_enc_info->rotation_angle = angle;
+		break;
+	}
+	case ENC_GET_QUEUE_STATUS: {
+		struct queue_status_info *queue_info = parameter;
+
+		queue_info->instance_queue_count = p_enc_info->instance_queue_count;
+		queue_info->report_queue_count = p_enc_info->report_queue_count;
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int wave5_vpu_enc_issue_seq_init(struct vpu_instance *inst)
+{
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	ret = wave5_vpu_enc_init_seq(inst);
+
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_enc_complete_seq_init(struct vpu_instance *inst, struct enc_initial_info *info)
+{
+	struct enc_info *p_enc_info = &inst->codec_info->enc_info;
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+
+	if (!info)
+		return -EINVAL;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	ret = wave5_vpu_enc_get_seq_info(inst, info);
+	if (ret) {
+		p_enc_info->initial_info_obtained = false;
+		mutex_unlock(&vpu_dev->hw_lock);
+		return ret;
+	}
+
+	p_enc_info->initial_info_obtained = true;
+	p_enc_info->initial_info = *info;
+
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return 0;
+}
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
new file mode 100644
index 000000000000..1b3ffb737925
--- /dev/null
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
@@ -0,0 +1,1136 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Wave5 series multi-standard codec IP - helper definitions
+ *
+ * Copyright (C) 2021 CHIPS&MEDIA INC
+ */
+
+#ifndef VPUAPI_H_INCLUDED
+#define VPUAPI_H_INCLUDED
+
+#include <linux/kfifo.h>
+#include <linux/idr.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-mem2mem.h>
+#include <media/v4l2-ctrls.h>
+#include "wave5-vpuerror.h"
+#include "wave5-vpuconfig.h"
+#include "wave5-vdi.h"
+
+enum product_id {
+	PRODUCT_ID_521,
+	PRODUCT_ID_511,
+	PRODUCT_ID_517,
+	PRODUCT_ID_NONE,
+};
+
+struct vpu_attr;
+
+enum vpu_instance_type {
+	VPU_INST_TYPE_DEC = 0,
+	VPU_INST_TYPE_ENC = 1
+};
+
+enum vpu_instance_state {
+	VPU_INST_STATE_NONE = 0,
+	VPU_INST_STATE_OPEN = 1,
+	VPU_INST_STATE_INIT_SEQ = 2,
+	VPU_INST_STATE_PIC_RUN = 3,
+	VPU_INST_STATE_STOP = 4
+};
+
+#define WAVE5_MAX_FBS 32
+
+#define MAX_REG_FRAME (WAVE5_MAX_FBS * 2)
+
+#define WAVE5_DEC_HEVC_BUF_SIZE(_w, _h) (DIV_ROUND_UP(_w, 64) * DIV_ROUND_UP(_h, 64) * 256 + 64)
+#define WAVE5_DEC_AVC_BUF_SIZE(_w, _h) ((((ALIGN(_w, 256) / 16) * (ALIGN(_h, 16) / 16)) + 16) * 80)
+#define WAVE5_DEC_VP9_BUF_SIZE(_w, _h) (((ALIGN(_w, 64) * ALIGN(_h, 64)) >> 2))
+#define WAVE5_DEC_AVS2_BUF_SIZE(_w, _h) (((ALIGN(_w, 64) * ALIGN(_h, 64)) >> 5))
+// AV1 BUF SIZE : MFMV + segment ID + CDF probs table + film grain param Y+ film graim param C
+#define WAVE5_DEC_AV1_BUF_SZ_1(_w, _h)	\
+	(((ALIGN(_w, 64) / 64) * (ALIGN(_h, 64) / 64) * 512) + 41984 + 8192 + 4864)
+#define WAVE5_DEC_AV1_BUF_SZ_2(_w1, _w2, _h)	\
+	(((ALIGN(_w1, 64) / 64) * 256 + (ALIGN(_w2, 256) / 64) * 128) * (ALIGN(_h, 64) / 64))
+
+#define WAVE5_FBC_LUMA_TABLE_SIZE(_w, _h) (ALIGN(_h, 64) * ALIGN(_w, 256) / 32)
+#define WAVE5_FBC_CHROMA_TABLE_SIZE(_w, _h) (ALIGN((_h), 64) * ALIGN((_w) / 2, 256) / 32)
+#define WAVE5_ENC_AVC_BUF_SIZE(_w, _h) (ALIGN(_w, 64) * ALIGN(_h, 64) / 32)
+#define WAVE5_ENC_HEVC_BUF_SIZE(_w, _h) (ALIGN(_w, 64) / 64 * ALIGN(_h, 64) / 64 * 128)
+
+/*
+ * common struct and definition
+ */
+enum cod_std {
+	STD_AVC = 0,
+	STD_VC1 = 1,
+	STD_MPEG2 = 2,
+	STD_MPEG4 = 3,
+	STD_H263 = 4,
+	STD_DIV3 = 5,
+	STD_RV = 6,
+	STD_AVS = 7,
+	STD_THO = 9,
+	STD_VP3 = 10,
+	STD_VP8 = 11,
+	STD_HEVC = 12,
+	STD_VP9 = 13,
+	STD_AVS2 = 14,
+	STD_AV1 = 16,
+	STD_MAX
+};
+
+enum wave_std {
+	W_HEVC_DEC = 0x00,
+	W_HEVC_ENC = 0x01,
+	W_AVC_DEC = 0x02,
+	W_AVC_ENC = 0x03,
+	W_VP9_DEC = 0x16,
+	W_AVS2_DEC = 0x18,
+	W_AV1_DEC = 0x1A,
+	STD_UNKNOWN = 0xFF
+};
+
+enum SET_PARAM_OPTION {
+	OPT_COMMON = 0, /* SET_PARAM command option for encoding sequence */
+	OPT_CUSTOM_GOP = 1, /* SET_PARAM command option for setting custom GOP */
+	OPT_CUSTOM_HEADER = 2, /* SET_PARAM command option for setting custom VPS/SPS/PPS */
+	OPT_VUI = 3, /* SET_PARAM command option for encoding VUI */
+	OPT_CHANGE_PARAM = 0x10,
+};
+
+enum DEC_PIC_HDR_OPTION {
+	INIT_SEQ_NORMAL = 0x01,
+	INIT_SEQ_W_THUMBNAIL = 0x11,
+};
+
+enum DEC_PIC_OPTION {
+	DEC_PIC_NORMAL = 0x00, /* it is normal mode of DEC_PIC command */
+	DEC_PIC_W_THUMBNAIL = 0x10, /* thumbnail mode (skip non-IRAP without reference reg) */
+	SKIP_NON_IRAP = 0x11, /* it skips to decode non-IRAP pictures */
+	SKIP_NON_REF_PIC = 0x13
+};
+
+/************************************************************************/
+/* PROFILE & LEVEL */
+/************************************************************************/
+/* HEVC */
+#define HEVC_PROFILE_MAIN 1
+#define HEVC_PROFILE_MAIN10 2
+#define HEVC_PROFILE_STILLPICTURE 3
+#define HEVC_PROFILE_MAIN10_STILLPICTURE 2
+
+/* H.264 profile for encoder*/
+#define H264_PROFILE_BP 1
+#define H264_PROFILE_MP 2
+#define H264_PROFILE_EXTENDED 3
+#define H264_PROFILE_HP 4
+#define H264_PROFILE_HIGH10 5
+#define H264_PROFILE_HIGH422 6
+#define H264_PROFILE_HIGH444 7
+
+/************************************************************************/
+/* error codes */
+/************************************************************************/
+
+/************************************************************************/
+/* utility macros */
+/************************************************************************/
+
+/* bit_alloc_mode */
+#define BIT_ALLOC_MODE_FIXED_RATIO		2
+
+/* bit_rate */
+#define MAX_BIT_RATE				700000000
+
+/* decoding_refresh_type */
+#define DEC_REFRESH_TYPE_NON_IRAP		0
+#define DEC_REFRESH_TYPE_CRA			1
+#define DEC_REFRESH_TYPE_IDR			2
+
+/* depend_slice_mode */
+#define DEPEND_SLICE_MODE_RECOMMENDED		1
+#define DEPEND_SLICE_MODE_BOOST			2
+#define DEPEND_SLICE_MODE_FAST			3
+
+/* hvs_max_delta_qp */
+#define MAX_HVS_MAX_DELTA_QP			51
+
+/* intra_refresh_mode */
+#define REFRESH_MODE_CTU_ROWS			1
+#define REFRESH_MODE_CTU_COLUMNS		2
+#define REFRESH_MODE_CTU_STEP_SIZE		3
+#define REFRESH_MODE_CTUS			4
+
+/* intra_mb_refresh_mode */
+#define REFRESH_MB_MODE_NONE			0
+#define REFRESH_MB_MODE_CTU_ROWS		1
+#define REFRESH_MB_MODE_CTU_COLUMNS		2
+#define REFRESH_MB_MODE_CTU_STEP_SIZE		3
+
+/* intra_qp */
+#define MAX_INTRA_QP				63
+
+/* nr_inter_weight_* */
+#define MAX_INTER_WEIGHT			31
+
+/* nr_intra_weight_* */
+#define MAX_INTRA_WEIGHT			31
+
+/* nr_noise_sigma_* */
+#define MAX_NOISE_SIGMA				255
+
+/* bitstream_buffer_size */
+#define MIN_BITSTREAM_BUFFER_SIZE		1024
+#define MIN_BITSTREAM_BUFFER_SIZE_WAVE521	(1024 * 64)
+
+/* vbv_buffer_size */
+#define MIN_VBV_BUFFER_SIZE			10
+#define MAX_VBV_BUFFER_SIZE			3000
+
+/* Bitstream buffer option: Explicit End
+ * When set to 1 the VPU assumes that the bitstream has at least one frame and
+ * will read until the end of the bitstream buffer.
+ * When set to 0 the VPU will not read the last few bytes.
+ * This option can be set anytime but cannot be cleared during processing.
+ * It can be set to force finish decoding even though there is not enough
+ * bitstream data for a full frame.
+ */
+#define BS_EXPLICIT_END_MODE_ON			1
+
+#define BUFFER_MARGIN				4096
+
+/************************************************************************/
+/* */
+/************************************************************************/
+/**
+ * \brief parameters of DEC_SET_SEQ_CHANGE_MASK
+ */
+#define SEQ_CHANGE_ENABLE_PROFILE BIT(5)
+#define SEQ_CHANGE_CHROMA_FORMAT_IDC BIT(15) /* AV1 */
+#define SEQ_CHANGE_ENABLE_SIZE BIT(16)
+#define SEQ_CHANGE_INTER_RES_CHANGE BIT(17) /* VP9 */
+#define SEQ_CHANGE_ENABLE_BITDEPTH BIT(18)
+#define SEQ_CHANGE_ENABLE_DPB_COUNT BIT(19)
+
+#define SEQ_CHANGE_ENABLE_ALL_VP9 (SEQ_CHANGE_ENABLE_PROFILE | \
+		SEQ_CHANGE_ENABLE_SIZE | \
+		SEQ_CHANGE_INTER_RES_CHANGE | \
+		SEQ_CHANGE_ENABLE_BITDEPTH | \
+		SEQ_CHANGE_ENABLE_DPB_COUNT)
+
+#define SEQ_CHANGE_ENABLE_ALL_HEVC (SEQ_CHANGE_ENABLE_PROFILE | \
+		SEQ_CHANGE_ENABLE_SIZE | \
+		SEQ_CHANGE_ENABLE_BITDEPTH | \
+		SEQ_CHANGE_ENABLE_DPB_COUNT)
+
+#define SEQ_CHANGE_ENABLE_ALL_AVS2 (SEQ_CHANGE_ENABLE_PROFILE | \
+		SEQ_CHANGE_ENABLE_SIZE | \
+		SEQ_CHANGE_ENABLE_BITDEPTH | \
+		SEQ_CHANGE_ENABLE_DPB_COUNT)
+
+#define SEQ_CHANGE_ENABLE_ALL_AVC (SEQ_CHANGE_ENABLE_SIZE | \
+		SEQ_CHANGE_ENABLE_BITDEPTH | \
+		SEQ_CHANGE_ENABLE_DPB_COUNT)
+
+#define SEQ_CHANGE_ENABLE_ALL_AV1 (SEQ_CHANGE_ENABLE_PROFILE | \
+		SEQ_CHANGE_CHROMA_FORMAT_IDC | \
+		SEQ_CHANGE_ENABLE_SIZE | \
+		SEQ_CHANGE_ENABLE_BITDEPTH | \
+		SEQ_CHANGE_ENABLE_DPB_COUNT)
+
+#define DISPLAY_IDX_FLAG_SEQ_END -1
+#define DISPLAY_IDX_FLAG_NO_FB -3
+#define DECODED_IDX_FLAG_NO_FB -1
+#define DECODED_IDX_FLAG_SKIP -2
+
+#define RECON_IDX_FLAG_ENC_END -1
+#define RECON_IDX_FLAG_ENC_DELAY -2
+#define RECON_IDX_FLAG_HEADER_ONLY -3
+#define RECON_IDX_FLAG_CHANGE_PARAM -4
+
+enum codec_command {
+	ENABLE_ROTATION,
+	ENABLE_MIRRORING,
+	SET_MIRROR_DIRECTION,
+	SET_ROTATION_ANGLE,
+	ENABLE_DEC_THUMBNAIL_MODE,
+	DEC_GET_QUEUE_STATUS,
+	ENC_GET_QUEUE_STATUS,
+	DEC_RESET_FRAMEBUF_INFO,
+	DEC_GET_SEQ_INFO,
+};
+
+enum error_conceal_mode {
+	ERROR_CONCEAL_MODE_OFF = 0, /* conceal off */
+	ERROR_CONCEAL_MODE_INTRA_ONLY = 1, /* intra conceal in intra-picture, inter-picture */
+	ERROR_CONCEAL_MODE_INTRA_INTER = 2
+};
+
+enum error_conceal_unit {
+	ERROR_CONCEAL_UNIT_PICTURE = 0, /* picture-level error conceal */
+	ERROR_CONCEAL_UNIT_SLICE_TILE = 1, /* slice/tile-level error conceal */
+	ERROR_CONCEAL_UNIT_BLOCK_ROW = 2, /* block-row-level error conceal */
+	ERROR_CONCEAL_UNIT_BLOCK = 3 /* block-level conceal */
+};
+
+enum cb_cr_order {
+	CBCR_ORDER_NORMAL,
+	CBCR_ORDER_REVERSED
+};
+
+enum mirror_direction {
+	MIRDIR_NONE, /* no mirroring */
+	MIRDIR_VER, /* vertical mirroring */
+	MIRDIR_HOR, /* horizontal mirroring */
+	MIRDIR_HOR_VER /* horizontal and vertical mirroring */
+};
+
+enum frame_buffer_format {
+	FORMAT_ERR = -1,
+	FORMAT_420 = 0, /* 8bit */
+	FORMAT_422, /* 8bit */
+	FORMAT_224, /* 8bit */
+	FORMAT_444, /* 8bit */
+	FORMAT_400, /* 8bit */
+
+	/* little endian perspective */
+	/* | addr 0 | addr 1 | */
+	FORMAT_420_P10_16BIT_MSB = 5, /* lsb |000000xx|xxxxxxxx | msb */
+	FORMAT_420_P10_16BIT_LSB, /* lsb |xxxxxxx |xx000000 | msb */
+	FORMAT_420_P10_32BIT_MSB, /* lsb |00xxxxxxxxxxxxxxxxxxxxxxxxxxx| msb */
+	FORMAT_420_P10_32BIT_LSB, /* lsb |xxxxxxxxxxxxxxxxxxxxxxxxxxx00| msb */
+
+	/* 4:2:2 packed format */
+	/* little endian perspective */
+	/* | addr 0 | addr 1 | */
+	FORMAT_422_P10_16BIT_MSB, /* lsb |000000xx |xxxxxxxx | msb */
+	FORMAT_422_P10_16BIT_LSB, /* lsb |xxxxxxxx |xx000000 | msb */
+	FORMAT_422_P10_32BIT_MSB, /* lsb |00xxxxxxxxxxxxxxxxxxxxxxxxxxx| msb */
+	FORMAT_422_P10_32BIT_LSB, /* lsb |xxxxxxxxxxxxxxxxxxxxxxxxxxx00| msb */
+
+	FORMAT_YUYV, /* 8bit packed format : Y0U0Y1V0 Y2U1Y3V1 ... */
+	FORMAT_YUYV_P10_16BIT_MSB,
+	FORMAT_YUYV_P10_16BIT_LSB,
+	FORMAT_YUYV_P10_32BIT_MSB,
+	FORMAT_YUYV_P10_32BIT_LSB,
+
+	FORMAT_YVYU, /* 8bit packed format : Y0V0Y1U0 Y2V1Y3U1 ... */
+	FORMAT_YVYU_P10_16BIT_MSB,
+	FORMAT_YVYU_P10_16BIT_LSB,
+	FORMAT_YVYU_P10_32BIT_MSB,
+	FORMAT_YVYU_P10_32BIT_LSB,
+
+	FORMAT_UYVY, /* 8bit packed format : U0Y0V0Y1 U1Y2V1Y3 ... */
+	FORMAT_UYVY_P10_16BIT_MSB,
+	FORMAT_UYVY_P10_16BIT_LSB,
+	FORMAT_UYVY_P10_32BIT_MSB,
+	FORMAT_UYVY_P10_32BIT_LSB,
+
+	FORMAT_VYUY, /* 8bit packed format : V0Y0U0Y1 V1Y2U1Y3 ... */
+	FORMAT_VYUY_P10_16BIT_MSB,
+	FORMAT_VYUY_P10_16BIT_LSB,
+	FORMAT_VYUY_P10_32BIT_MSB,
+	FORMAT_VYUY_P10_32BIT_LSB,
+
+	FORMAT_MAX,
+};
+
+enum packed_format_num {
+	NOT_PACKED = 0,
+	PACKED_YUYV,
+	PACKED_YVYU,
+	PACKED_UYVY,
+	PACKED_VYUY,
+};
+
+enum wave5_interrupt_bit {
+	INT_WAVE5_INIT_VPU = 0,
+	INT_WAVE5_WAKEUP_VPU = 1,
+	INT_WAVE5_SLEEP_VPU = 2,
+	INT_WAVE5_CREATE_INSTANCE = 3,
+	INT_WAVE5_FLUSH_INSTANCE = 4,
+	INT_WAVE5_DESTROY_INSTANCE = 5,
+	INT_WAVE5_INIT_SEQ = 6,
+	INT_WAVE5_SET_FRAMEBUF = 7,
+	INT_WAVE5_DEC_PIC = 8,
+	INT_WAVE5_ENC_PIC = 8,
+	INT_WAVE5_ENC_SET_PARAM = 9,
+	INT_WAVE5_DEC_QUERY = 14,
+	INT_WAVE5_BSBUF_EMPTY = 15,
+	INT_WAVE5_BSBUF_FULL = 15,
+};
+
+enum pic_type {
+	PIC_TYPE_I = 0, /* I picture */
+	PIC_TYPE_KEY = 0, /* KEY frame for AV1*/
+	PIC_TYPE_P = 1, /* P picture */
+	PIC_TYPE_INTER = 1, /* inter frame for AV1*/
+	PIC_TYPE_B = 2, /* B picture (except VC1) */
+	PIC_TYPE_REPEAT = 2, /* repeat frame (VP9 only) */
+	PIC_TYPE_AV1_INTRA = 2, /* intra only frame (AV1 only) */
+	PIC_TYPE_VC1_BI = 2, /* VC1 BI picture (VC1 only) */
+	PIC_TYPE_VC1_B = 3, /* VC1 B picture (VC1 only) */
+	PIC_TYPE_D = 3,
+	PIC_TYPE_S = 3,
+	PIC_TYPE_AVS2_F = 3, /* F picture in AVS2 */
+	PIC_TYPE_AV1_SWITCH = 3, /* switch frame (AV1 only) */
+	PIC_TYPE_VC1_P_SKIP = 4, /* VC1 P skip picture (VC1 only) */
+	PIC_TYPE_MP4_P_SKIP_NOT_CODED = 4, /* not coded P picture in MPEG4 packed mode */
+	PIC_TYPE_AVS2_S = 4, /* S picture in AVS2 */
+	PIC_TYPE_IDR = 5, /* H.264/H.265 IDR picture */
+	PIC_TYPE_AVS2_G = 5, /* G picture in AVS2 */
+	PIC_TYPE_AVS2_GB = 6, /* GB picture in AVS2 */
+	PIC_TYPE_MAX /* no meaning */
+};
+
+enum bit_stream_mode {
+	BS_MODE_INTERRUPT,
+	BS_MODE_RESERVED, /* reserved for the future */
+	BS_MODE_PIC_END,
+};
+
+enum sw_reset_mode {
+	SW_RESET_SAFETY,
+	SW_RESET_FORCE,
+	SW_RESET_ON_BOOT
+};
+
+enum tiled_map_type {
+	LINEAR_FRAME_MAP = 0, /* linear frame map type */
+	COMPRESSED_FRAME_MAP = 17, /* compressed frame map type*/
+};
+
+enum temporal_id_mode {
+	TEMPORAL_ID_MODE_ABSOLUTE,
+	TEMPORAL_ID_MODE_RELATIVE,
+};
+
+struct vpu_attr {
+	u32 product_id; /* the product ID */
+	char product_name[8]; /* the product name in ascii code */
+	u32 product_version; /* the product version number */
+	u32 fw_version; /* the F/W version */
+	u32 customer_id; /* customer ID number */
+	u32 support_decoders; /* bitmask: see <<vpuapi_h_cod_std>> */
+	u32 support_encoders; /* bitmask: see <<vpuapi_h_cod_std>> */
+	u32 support_endian_mask; /* A variable of supported endian mode in product */
+	u32 support_bitstream_mode;
+	u32 support_backbone: 1;
+	u32 support_avc10bit_enc: 1;
+	u32 support_hevc10bit_enc: 1;
+	u32 support_dual_core: 1; /* this indicates whether a product has two vcores */
+	u32 support_vcore_backbone: 1;
+	u32 support_vcpu_backbone: 1;
+};
+
+struct frame_buffer {
+	dma_addr_t buf_y;
+	dma_addr_t buf_cb;
+	dma_addr_t buf_cr;
+	unsigned int buf_y_size;
+	unsigned int buf_cb_size;
+	unsigned int buf_cr_size;
+	unsigned int endian;
+	enum tiled_map_type map_type;
+	unsigned int stride; /* A horizontal stride for given frame buffer */
+	unsigned int width; /* A width for given frame buffer */
+	unsigned int height; /* A height for given frame buffer */
+	size_t size; /* A size for given frame buffer */
+	unsigned int sequence_no;
+	bool update_fb_info;
+};
+
+struct vpu_rect {
+	unsigned int left; /* horizontal pixel offset from left edge */
+	unsigned int top; /* vertical pixel offset from top edge */
+	unsigned int right; /* horizontal pixel offset from right edge */
+	unsigned int bottom; /* vertical pixel offset from bottom edge */
+};
+
+/*
+ * decode struct and definition
+ */
+
+struct dec_open_param {
+	dma_addr_t bitstream_buffer;
+	size_t bitstream_buffer_size;
+	enum cb_cr_order cbcr_order;
+	unsigned int frame_endian;
+	unsigned int stream_endian;
+	enum bit_stream_mode bitstream_mode;
+	u32 av1_format;
+	enum error_conceal_unit error_conceal_unit;
+	enum error_conceal_mode error_conceal_mode;
+	u32 pri_ext_addr;
+	u32 pri_axprot;
+	u32 pri_axcache;
+	u32 enable_non_ref_fbc_write: 1;
+};
+
+struct dec_initial_info {
+	u32 pic_width;
+	u32 pic_height;
+	s32 f_rate_numerator; /* the numerator part of frame rate fraction */
+	s32 f_rate_denominator; /* the denominator part of frame rate fraction */
+	struct vpu_rect pic_crop_rect;
+	u32 min_frame_buffer_count; /* between 1 to 16 */
+	u32 frame_buf_delay;
+
+	u32 max_temporal_layers; /* it indicates the max number of temporal sub-layers */
+	u32 profile;
+	u32 level;
+	u32 tier;
+	bool is_ext_sar;
+	u32 aspect_rate_info;
+	u32 bit_rate;
+	u32 user_data_header;
+	u32 user_data_size;
+	bool user_data_buf_full;
+	u32 chroma_format_idc;/* A chroma format indicator */
+	u32 luma_bitdepth; /* A bit-depth of luma sample */
+	u32 chroma_bitdepth; /* A bit-depth of chroma sample */
+	u32 seq_init_err_reason;
+	u32 warn_info;
+	dma_addr_t rd_ptr; /* A read pointer of bitstream buffer */
+	dma_addr_t wr_ptr; /* A write pointer of bitstream buffer */
+	u32 sequence_no;
+	u32 output_bit_depth;
+	u32 vlc_buf_size; /* the size of vlc buffer */
+	u32 param_buf_size; /* the size of param buffer */
+};
+
+#define WAVE_SKIPMODE_WAVE_NONE 0
+#define WAVE_SKIPMODE_NON_IRAP 1
+#define WAVE_SKIPMODE_NON_REF 2
+
+struct dec_param {
+	u32 skipframe_mode: 2;
+	u32 cra_as_bla_flag: 1;
+	u32 disable_film_grain: 1;
+};
+
+struct avs2_info {
+	s32 decoded_poi;
+	int display_poi;
+};
+
+struct dec_output_info {
+	/**
+	 * this is a frame buffer index for the picture to be displayed at the moment among
+	 * frame buffers which are registered using vpu_dec_register_frame_buffer(). frame
+	 * data to be displayed are stored into the frame buffer with this index
+	 * when there is no display delay, this index is always
+	 * the same with index_frame_decoded, however, if display delay does exist for display
+	 * reordering in AVC
+	 * or B-frames in VC1), this index might be different with index_frame_decoded.
+	 * by checking this index, HOST application can easily know whether sequence decoding
+	 * has been finished or not.
+	 *
+	 * -3(0xFFFD) or -2(0xFFFE) : it is when a display output cannot be given due to picture
+	 * reordering or skip option
+	 * -1(0xFFFF) : it is when there is no more output for display at the end of sequence
+	 * decoding
+	 */
+	s32 index_frame_display;
+	/**
+	 * this is a frame buffer index of decoded picture among frame buffers which were
+	 * registered using vpu_dec_register_frame_buffer(). the currently decoded frame is stored
+	 * into the frame buffer specified by
+	 * this index.
+	 *
+	 * -2 : it indicates that no decoded output is generated because decoder meets EOS
+	 * (end of sequence) or skip
+	 * -1 : it indicates that decoder fails to decode a picture because there is no available
+	 * frame buffer
+	 */
+	s32 index_frame_decoded;
+	s32 index_frame_decoded_for_tiled;
+	u32 nal_type;
+	unsigned int pic_type;
+	struct vpu_rect rc_display;
+	unsigned int disp_pic_width;
+	unsigned int disp_pic_height;
+	struct vpu_rect rc_decoded;
+	u32 dec_pic_width;
+	u32 dec_pic_height;
+	struct avs2_info avs2_info;
+	s32 decoded_poc;
+	int temporal_id; /* A temporal ID of the picture */
+	dma_addr_t rd_ptr; /* A stream buffer read pointer for the current decoder instance */
+	dma_addr_t wr_ptr; /* A stream buffer write pointer for the current decoder instance */
+	struct frame_buffer disp_frame;
+	u32 frame_display_flag; /* it reports a frame buffer flag to be displayed */
+	/**
+	 * this variable reports that sequence has been changed while H.264/AVC stream decoding.
+	 * if it is 1, HOST application can get the new sequence information by calling
+	 * vpu_dec_get_initial_info() or wave5_vpu_dec_issue_seq_init().
+	 *
+	 * for H.265/HEVC decoder, each bit has a different meaning as follows.
+	 *
+	 * sequence_changed[5] : it indicates that the profile_idc has been changed
+	 * sequence_changed[16] : it indicates that the resolution has been changed
+	 * sequence_changed[19] : it indicates that the required number of frame buffer has
+	 * been changed.
+	 */
+	unsigned int frame_cycle; /* reports the number of cycles for processing a frame */
+	u32 sequence_no;
+
+	u32 dec_host_cmd_tick; /* tick of DEC_PIC command for the picture */
+	u32 dec_decode_end_tick; /* end tick of decoding slices of the picture */
+
+	u32 sequence_changed;
+};
+
+struct queue_status_info {
+	u32 instance_queue_count;
+	u32 report_queue_count;
+};
+
+/*
+ * encode struct and definition
+ */
+
+#define MAX_NUM_TEMPORAL_LAYER 7
+#define MAX_NUM_SPATIAL_LAYER 3
+#define MAX_GOP_NUM 8
+
+struct custom_gop_pic_param {
+	u32 pic_type; /* A picture type of nth picture in the custom GOP */
+	u32 poc_offset; /* A POC of nth picture in the custom GOP */
+	u32 pic_qp; /* A quantization parameter of nth picture in the custom GOP */
+	u32 use_multi_ref_p; /* use multiref pic for P picture. valid only if PIC_TYPE is P */
+	u32 ref_poc_l0; /* A POC of reference L0 of nth picture in the custom GOP */
+	u32 ref_poc_l1; /* A POC of reference L1 of nth picture in the custom GOP */
+	s32 temporal_id; /* A temporal ID of nth picture in the custom GOP */
+};
+
+struct custom_gop_param {
+	u32 custom_gop_size; /* the size of custom GOP (0~8) */
+	struct custom_gop_pic_param pic_param[MAX_GOP_NUM];
+};
+
+struct wave_custom_map_opt {
+	u32 roi_avg_qp; /* it sets an average QP of ROI map */
+	u32 addr_custom_map;
+	u32 custom_roi_map_enable: 1; /* it enables ROI map */
+	u32 custom_lambda_map_enable: 1; /* it enables custom lambda map */
+	u32 custom_mode_map_enable: 1;
+	u32 custom_coef_drop_enable: 1;
+};
+
+struct enc_wave_param {
+	/*
+	 * A profile indicator (HEVC only)
+	 *
+	 * 0 : the firmware determines a profile according to internalbitdepth
+	 * 1 : main profile
+	 * 2 : main10 profile
+	 * 3 : main still picture profile
+	 * in AVC encoder, a profile cannot be set by host application. the firmware decides it
+	 * based on internalbitdepth. it is HIGH profile for bitdepth of 8 and HIGH10 profile for
+	 * bitdepth of 10.
+	 */
+	u32 profile;
+	u32 level; /* A level indicator (level * 10) */
+	u32 internal_bit_depth: 4; /* 8/10 */
+	u32 gop_preset_idx: 4; /* 0 - 9 */
+	u32 decoding_refresh_type: 2; /* 0=non-IRAP, 1=CRA, 2=IDR */
+	u32 intra_qp; /* A quantization parameter of intra picture */
+	u32 intra_period; /* A period of intra picture in GOP size */
+	u32 forced_idr_header_enable: 2;
+	u32 conf_win_top; /* A top offset of conformance window */
+	u32 conf_win_bot; /* A bottom offset of conformance window */
+	u32 conf_win_left; /* A left offset of conformance window */
+	u32 conf_win_right; /* A right offset of conformance window */
+	u32 independ_slice_mode_arg;
+	u32 depend_slice_mode_arg;
+	u32 intra_refresh_mode: 3;
+	/*
+	 * it specifies an intra CTU refresh interval. depending on intra_refresh_mode,
+	 * it can mean one of the following.
+	 *
+	 * the number of consecutive CTU rows for intra_ctu_refresh_mode of 1
+	 * the number of consecutive CTU columns for intra_ctu_refresh_mode of 2
+	 * A step size in CTU for intra_ctu_refresh_mode of 3
+	 * the number of intra ct_us to be encoded in a picture for intra_ctu_refresh_mode of 4
+	 */
+	u32 intra_refresh_arg;
+	/*
+	 * 0 : custom setting
+	 * 1 : recommended encoder parameters (slow encoding speed, highest picture quality)
+	 * 2 : boost mode (normal encoding speed, moderate picture quality)
+	 * 3 : fast mode (fast encoding speed, low picture quality)
+	 */
+	u32 depend_slice_mode : 2;
+	u32 use_recommend_enc_param: 2;
+	u32 max_num_merge: 2;
+	u32 scaling_list_enable: 2;
+	u32 bit_alloc_mode: 2; /* 0=ref-pic-priority, 1=uniform, 2=fixed_bit_ratio */
+	s32 beta_offset_div2: 4; /* it sets beta_offset_div2 for deblocking filter */
+	s32 tc_offset_div2: 4; /* it sets tc_offset_div3 for deblocking filter */
+	u32 hvs_qp_scale: 4; /* QP scaling factor for CU QP adjust if hvs_qp_scale_enable is 1 */
+	u32 hvs_max_delta_qp; /* A maximum delta QP for HVS */
+	/*
+	 * A fixed bit ratio (1 ~ 255) for each picture of GOP's bit
+	 * allocation
+	 *
+	 * N = 0 ~ (MAX_GOP_SIZE - 1)
+	 * MAX_GOP_SIZE = 8
+	 *
+	 * for instance when MAX_GOP_SIZE is 3, fixed_bit_ratio0, fixed_bit_ratio1, and
+	 * fixed_bit_ratio2 can be set as 2, 1, and 1 respectively for
+	 * the fixed bit ratio 2:1:1. this is only valid when bit_alloc_mode is 2.
+	 */
+	u8 fixed_bit_ratio[MAX_GOP_NUM];
+	struct custom_gop_param gop_param; /* <<vpuapi_h_custom_gop_param>> */
+	u32 num_units_in_tick;
+	u32 time_scale;
+	u32 num_ticks_poc_diff_one;
+	s32 chroma_cb_qp_offset; /* the value of chroma(cb) QP offset */
+	s32 chroma_cr_qp_offset; /* the value of chroma(cr) QP offset */
+	s32 initial_rc_qp;
+	u32 nr_intra_weight_y;
+	u32 nr_intra_weight_cb; /* A weight to cb noise level for intra picture (0 ~ 31) */
+	u32 nr_intra_weight_cr; /* A weight to cr noise level for intra picture (0 ~ 31) */
+	u32 nr_inter_weight_y;
+	u32 nr_inter_weight_cb; /* A weight to cb noise level for inter picture (0 ~ 31) */
+	u32 nr_inter_weight_cr; /* A weight to cr noise level for inter picture (0 ~ 31) */
+	u32 nr_noise_sigma_y; /* Y noise standard deviation if nr_noise_est_enable is 0 */
+	u32 nr_noise_sigma_cb;/* cb noise standard deviation if nr_noise_est_enable is 0 */
+	u32 nr_noise_sigma_cr;/* cr noise standard deviation if nr_noise_est_enable is 0 */
+	u32 bg_thr_diff;
+	u32 bg_thr_mean_diff;
+	u32 bg_lambda_qp;
+	u32 bg_delta_qp;
+	u32 pu04_delta_rate: 8; /* added to the total cost of 4x4 blocks */
+	u32 pu08_delta_rate: 8; /* added to the total cost of 8x8 blocks */
+	u32 pu16_delta_rate: 8; /* added to the total cost of 16x16 blocks */
+	u32 pu32_delta_rate: 8; /* added to the total cost of 32x32 blocks */
+	u32 pu04_intra_planar_delta_rate: 8;
+	u32 pu04_intra_dc_delta_rate: 8;
+	u32 pu04_intra_angle_delta_rate: 8;
+	u32 pu08_intra_planar_delta_rate: 8;
+	u32 pu08_intra_dc_delta_rate: 8;
+	u32 pu08_intra_angle_delta_rate: 8;
+	u32 pu16_intra_planar_delta_rate: 8;
+	u32 pu16_intra_dc_delta_rate: 8;
+	u32 pu16_intra_angle_delta_rate: 8;
+	u32 pu32_intra_planar_delta_rate: 8;
+	u32 pu32_intra_dc_delta_rate: 8;
+	u32 pu32_intra_angle_delta_rate: 8;
+	u32 cu08_intra_delta_rate: 8;
+	u32 cu08_inter_delta_rate: 8;
+	u32 cu08_merge_delta_rate: 8;
+	u32 cu16_intra_delta_rate: 8;
+	u32 cu16_inter_delta_rate: 8;
+	u32 cu16_merge_delta_rate: 8;
+	u32 cu32_intra_delta_rate: 8;
+	u32 cu32_inter_delta_rate: 8;
+	u32 cu32_merge_delta_rate: 8;
+	u32 coef_clear_disable: 8;
+	u32 min_qp_i; /* A minimum QP of I picture for rate control */
+	u32 max_qp_i; /* A maximum QP of I picture for rate control */
+	u32 min_qp_p; /* A minimum QP of P picture for rate control */
+	u32 max_qp_p; /* A maximum QP of P picture for rate control */
+	u32 min_qp_b; /* A minimum QP of B picture for rate control */
+	u32 max_qp_b; /* A maximum QP of B picture for rate control */
+	u32 custom_lambda_addr; /* it specifies the address of custom lambda map */
+	u32 user_scaling_list_addr; /* it specifies the address of user scaling list file */
+	u32 avc_idr_period;/* A period of IDR picture (0 ~ 1024). 0 - implies an infinite period */
+	u32 avc_slice_arg;	/* the number of MB for a slice when avc_slice_mode is set with 1 */
+	u32 intra_mb_refresh_mode: 2; /* 0=none, 1=row, 2=column, 3=step-size-in-mb */
+	/**
+	 * it specifies an intra MB refresh interval. depending on intra_mb_refresh_mode,
+	 * it can mean one of the following.
+	 *
+	 * the number of consecutive MB rows for intra_mb_refresh_mode of 1
+	 * the number of consecutive MB columns for intra_mb_refresh_mode of 2
+	 * A step size in MB for intra_mb_refresh_mode of 3
+	 */
+	u32 intra_mb_refresh_arg;
+	u32 rc_weight_param;
+	u32 rc_weight_buf;
+
+	/* flags */
+	u32 en_still_picture: 1; /* still picture profile */
+	u32 tier: 1; /* 0=main, 1=high */
+	u32 independ_slice_mode : 1; /* 0=no-multi-slice, 1=slice-in-ctu-number*/
+	u32 avc_slice_mode: 1; /* 0=none, 1=slice-in-mb-number */
+	u32 entropy_coding_mode: 1; /* 0=CAVLC, 1=CABAC */
+	u32 lossless_enable: 1; /* enables lossless coding */
+	u32 const_intra_pred_flag: 1; /* enables constrained intra prediction */
+	u32 tmvp_enable: 1; /* enables temporal motion vector prediction */
+	u32 wpp_enable: 1;
+	u32 disable_deblk: 1; /* it disables in-loop deblocking filtering */
+	u32 lf_cross_slice_boundary_enable: 1;
+	u32 skip_intra_trans: 1;
+	u32 sao_enable: 1; /* it enables SAO (sample adaptive offset) */
+	u32 intra_nx_n_enable: 1; /* it enables intra nx_n p_us */
+	u32 cu_level_rc_enable: 1; /* it enable CU level rate control */
+	u32 hvs_qp_enable: 1; /* enable CU QP adjustment for subjective quality enhancement */
+	u32 roi_enable: 1; /* it enables ROI map. NOTE: it is valid when rate control is on */
+	u32 nr_y_enable: 1; /* it enables noise reduction algorithm to Y component */
+	u32 nr_noise_est_enable: 1;
+	u32 nr_cb_enable: 1; /* it enables noise reduction algorithm to cb component */
+	u32 nr_cr_enable: 1; /* it enables noise reduction algorithm to cr component */
+	u32 use_long_term: 1; /* it enables long-term reference function */
+	u32 monochrome_enable: 1; /* it enables monochrom encoding mode */
+	u32 strong_intra_smooth_enable: 1; /* it enables strong intra smoothing */
+	u32 weight_pred_enable: 1; /* it enables to use weighted prediction*/
+	u32 bg_detect_enable: 1; /* it enables background detection */
+	u32 custom_lambda_enable: 1; /* it enables custom lambda table */
+	u32 custom_md_enable: 1; /* it enables custom mode decision */
+	u32 rdo_skip: 1; /* it skips RDO(rate distortion optimization) */
+	u32 lambda_scaling_enable: 1; /* it enables lambda scaling using custom GOP */
+	u32 transform8x8_enable: 1; /* it enables 8x8 intra prediction and 8x8 transform */
+	u32 mb_level_rc_enable: 1; /* it enables MB-level rate control */
+	u32 s2fme_disable: 1; /* it disables s2me_fme (only for AVC encoder) */
+};
+
+struct enc_sub_frame_sync_config {
+	u32 sub_frame_sync_mode; /* 0=wire-based, 1=register-based */
+	u32 sub_frame_sync_on;
+};
+
+struct enc_open_param {
+	dma_addr_t bitstream_buffer;
+	unsigned int bitstream_buffer_size;
+	u32 pic_width; /* the width of a picture to be encoded in unit of sample */
+	u32 pic_height; /* the height of a picture to be encoded in unit of sample */
+	u32 frame_rate_info;/* desired fps */
+	u32 vbv_buffer_size;
+	u32 bit_rate; /* target bitrate in bps */
+	struct enc_wave_param wave_param;
+	enum cb_cr_order cbcr_order;
+	unsigned int stream_endian;
+	unsigned int source_endian;
+	enum packed_format_num packed_format; /* <<vpuapi_h_packed_format_num>> */
+	enum frame_buffer_format src_format;
+	/* enum frame_buffer_format output_format; not used yet */
+	u32 enc_hrd_rbsp_in_vps; /* it encodes the HRD syntax rbsp into VPS */
+	u32 hrd_rbsp_data_size; /* the bit size of the HRD rbsp data */
+	u32 hrd_rbsp_data_addr; /* the address of the HRD rbsp data */
+	u32 encode_vui_rbsp;
+	u32 vui_rbsp_data_size; /* the bit size of the VUI rbsp data */
+	u32 vui_rbsp_data_addr; /* the address of the VUI rbsp data */
+	u32 pri_ext_addr;
+	u32 pri_axprot;
+	u32 pri_axcache;
+	bool ring_buffer_enable;
+	bool line_buf_int_en;
+	bool enable_pts; /* an enable flag to report PTS(presentation timestamp) */
+	u32 rc_enable : 1; /* rate control */
+	u32 enable_non_ref_fbc_write: 1;
+	u32 sub_frame_sync_enable: 1;
+	u32 sub_frame_sync_mode: 1;
+};
+
+struct enc_initial_info {
+	u32 min_frame_buffer_count; /* minimum number of frame buffer */
+	u32 min_src_frame_count; /* minimum number of source buffer */
+	u32 max_latency_pictures; /* maximum number of picture latency */
+	u32 seq_init_err_reason; /* error information */
+	u32 warn_info; /* warn information */
+	u32 vlc_buf_size; /* the size of task buffer */
+	u32 param_buf_size; /* the size of task buffer */
+};
+
+struct enc_code_opt {
+	u32 implicit_header_encode: 1;
+	u32 encode_vcl: 1; /* A flag to encode VCL nal unit explicitly */
+	u32 encode_vps: 1; /* A flag to encode VPS nal unit explicitly */
+	u32 encode_sps: 1; /* A flag to encode SPS nal unit explicitly */
+	u32 encode_pps: 1; /* A flag to encode PPS nal unit explicitly */
+	u32 encode_aud: 1; /* A flag to encode AUD nal unit explicitly */
+	u32 encode_eos: 1;
+	u32 encode_eob: 1;
+	u32 encode_vui: 1; /* A flag to encode VUI nal unit explicitly */
+};
+
+struct enc_param {
+	struct frame_buffer *source_frame;
+	u32 pic_stream_buffer_addr;
+	u64 pic_stream_buffer_size;
+	u32 force_pic_qp_i;
+	u32 force_pic_qp_p;
+	u32 force_pic_qp_b;
+	u32 force_pic_type: 2;
+	u32 src_idx; /* A source frame buffer index */
+	struct enc_code_opt code_option;
+	u32 use_cur_src_as_longterm_pic;
+	u32 use_longterm_ref;
+	u64 pts; /* the presentation timestamp (PTS) of input source */
+	struct wave_custom_map_opt custom_map_opt;
+	u32 wp_pix_sigma_y; /* pixel variance of Y component for weighted prediction */
+	u32 wp_pix_sigma_cb; /* pixel variance of cb component for weighted prediction */
+	u32 wp_pix_sigma_cr; /* pixel variance of cr component for weighted prediction */
+	u32 wp_pix_mean_y; /* pixel mean value of Y component for weighted prediction */
+	u32 wp_pix_mean_cb; /* pixel mean value of cb component for weighted prediction */
+	u32 wp_pix_mean_cr; /* pixel mean value of cr component for weighted prediction */
+	bool src_end_flag;
+	u32 skip_picture: 1;
+	u32 force_pic_qp_enable: 1; /* flag used to force picture quantization parameter */
+	u32 force_pic_type_enable: 1; /* A flag to use a force picture type */
+	u32 force_all_ctu_coef_drop_enable: 1; /* forces all coefficients to be zero after TQ */
+};
+
+struct enc_output_info {
+	u32 bitstream_buffer;
+	u32 bitstream_size; /* the byte size of encoded bitstream */
+	u32 pic_type: 2; /* <<vpuapi_h_pic_type>> */
+	s32 recon_frame_index;
+	dma_addr_t rd_ptr;
+	dma_addr_t wr_ptr;
+	u32 enc_pic_byte; /* the number of encoded picture bytes */
+	s32 enc_src_idx; /* the source buffer index of the currently encoded picture */
+	u32 enc_vcl_nut;
+	u32 error_reason; /* the error reason of the currently encoded picture */
+	u32 warn_info; /* the warning information of the currently encoded picture */
+	unsigned int frame_cycle; /* param for reporting the cycle number of encoding one frame*/
+	u64 pts;
+	u32 enc_host_cmd_tick; /* tick of ENC_PIC command for the picture */
+	u32 enc_encode_end_tick; /* end tick of encoding slices of the picture */
+};
+
+enum ENC_PIC_CODE_OPTION {
+	CODEOPT_ENC_HEADER_IMPLICIT = BIT(0),
+	CODEOPT_ENC_VCL = BIT(1), /* A flag to encode VCL nal unit explicitly */
+};
+
+enum GOP_PRESET_IDX {
+	PRESET_IDX_CUSTOM_GOP = 0, /* user defined GOP structure */
+	PRESET_IDX_ALL_I = 1, /* all intra, gopsize = 1 */
+	PRESET_IDX_IPP = 2, /* consecutive P, cyclic gopsize = 1 */
+	PRESET_IDX_IBBB = 3, /* consecutive B, cyclic gopsize = 1 */
+	PRESET_IDX_IBPBP = 4, /* gopsize = 2 */
+	PRESET_IDX_IBBBP = 5, /* gopsize = 4 */
+	PRESET_IDX_IPPPP = 6, /* consecutive P, cyclic gopsize = 4 */
+	PRESET_IDX_IBBBB = 7, /* consecutive B, cyclic gopsize = 4 */
+	PRESET_IDX_RA_IB = 8, /* random access, cyclic gopsize = 8 */
+	PRESET_IDX_IPP_SINGLE = 9, /* consecutive P, cyclic gopsize = 1, with single ref */
+};
+
+struct sec_axi_info {
+	struct {
+		u32 use_ip_enable;
+		u32 use_bit_enable;
+		u32 use_lf_row_enable: 1;
+		u32 use_enc_rdo_enable: 1;
+		u32 use_enc_lf_enable: 1;
+	} wave;
+	unsigned int buf_size;
+	dma_addr_t buf_base;
+};
+
+struct dec_info {
+	struct dec_open_param open_param;
+	struct dec_initial_info initial_info;
+	struct dec_initial_info new_seq_info; /* temporal new sequence information */
+	u32 stream_wr_ptr;
+	u32 stream_rd_ptr;
+	u32 frame_display_flag;
+	dma_addr_t stream_buf_start_addr;
+	dma_addr_t stream_buf_end_addr;
+	u32 stream_buf_size;
+	struct vpu_buf vb_mv[MAX_REG_FRAME];
+	struct vpu_buf vb_fbc_y_tbl[MAX_REG_FRAME];
+	struct vpu_buf vb_fbc_c_tbl[MAX_REG_FRAME];
+	unsigned int num_of_decoding_fbs;
+	unsigned int num_of_display_fbs;
+	unsigned int stride;
+	enum mirror_direction mirror_direction;
+	unsigned int rotation_angle;
+	struct frame_buffer rotator_output;
+	unsigned int rotator_stride;
+	struct sec_axi_info sec_axi_info;
+	dma_addr_t user_data_buf_addr;
+	u32 user_data_enable;
+	u32 user_data_buf_size;
+	struct vpu_buf vb_work;
+	struct vpu_buf vb_task;
+	struct dec_output_info dec_out_info[WAVE5_MAX_FBS];
+	u32 seq_change_mask;
+	enum temporal_id_mode temp_id_select_mode;
+	u32 target_temp_id;
+	u32 target_spatial_id;
+	u32 instance_queue_count;
+	u32 report_queue_count;
+	u32 cycle_per_tick;
+	u32 product_code;
+	u32 vlc_buf_size;
+	u32 param_buf_size;
+	bool rotation_enable;
+	bool mirror_enable;
+	bool dering_enable;
+	bool initial_info_obtained;
+	bool reorder_enable;
+	bool thumbnail_mode;
+	bool first_cycle_check;
+	u32 stream_endflag: 1;
+};
+
+struct enc_info {
+	struct enc_open_param open_param;
+	struct enc_initial_info initial_info;
+	u32 stream_rd_ptr;
+	u32 stream_wr_ptr;
+	dma_addr_t stream_buf_start_addr;
+	dma_addr_t stream_buf_end_addr;
+	u32 stream_buf_size;
+	unsigned int num_frame_buffers;
+	unsigned int stride;
+	bool rotation_enable;
+	bool mirror_enable;
+	enum mirror_direction mirror_direction;
+	unsigned int rotation_angle;
+	bool initial_info_obtained;
+	bool ring_buffer_enable;
+	struct sec_axi_info sec_axi_info;
+	struct enc_sub_frame_sync_config sub_frame_sync_config;
+	bool line_buf_int_en;
+	struct vpu_buf vb_work;
+	struct vpu_buf vb_mv; /* col_mv buffer */
+	struct vpu_buf vb_fbc_y_tbl; /* FBC luma table buffer */
+	struct vpu_buf vb_fbc_c_tbl; /* FBC chroma table buffer */
+	struct vpu_buf vb_sub_sam_buf; /* sub-sampled buffer for ME */
+	struct vpu_buf vb_task;
+	u64 cur_pts; /* current timestamp in 90_k_hz */
+	u64 pts_map[32]; /* PTS mapped with source frame index */
+	u32 instance_queue_count;
+	u32 report_queue_count;
+	bool first_cycle_check;
+	u32 cycle_per_tick;
+	u32 product_code;
+	u32 vlc_buf_size;
+	u32 param_buf_size;
+};
+
+struct vpu_device {
+	struct device *dev;
+	struct v4l2_device v4l2_dev;
+	struct list_head instances;
+	struct video_device *video_dev_dec;
+	struct video_device *video_dev_enc;
+	struct mutex dev_lock; /* the lock for the src,dst v4l2 queues */
+	struct mutex hw_lock; /* lock hw configurations */
+	int irq;
+	enum product_id	 product;
+	struct vpu_attr	 attr;
+	struct vpu_buf common_mem;
+	u32 last_performance_cycles;
+	struct dma_vpu_buf sram_buf;
+	void __iomem *vdb_register;
+	u32 product_code;
+	struct ida inst_ida;
+	struct clk_bulk_data *clks;
+	int num_clks;
+};
+
+struct vpu_instance;
+
+struct vpu_instance_ops {
+	void (*start_process)(struct vpu_instance *inst);
+	void (*stop_process)(struct vpu_instance *inst);
+	void (*finish_process)(struct vpu_instance *inst);
+};
+
+struct vpu_instance {
+	struct list_head list;
+	struct v4l2_fh v4l2_fh;
+	struct v4l2_ctrl_handler v4l2_ctrl_hdl;
+	struct vpu_device *dev;
+	struct v4l2_m2m_dev *v4l2_m2m_dev;
+	struct kfifo irq_status;
+	struct completion irq_done;
+
+	struct v4l2_pix_format_mplane src_fmt;
+	struct v4l2_pix_format_mplane dst_fmt;
+	enum v4l2_colorspace colorspace;
+	enum v4l2_xfer_func xfer_func;
+	enum v4l2_ycbcr_encoding ycbcr_enc;
+	enum v4l2_quantization quantization;
+	enum v4l2_hsv_encoding hsv_enc;
+
+	enum vpu_instance_state state;
+	enum vpu_instance_type type;
+	const struct vpu_instance_ops *ops;
+
+	enum wave_std		 std;
+	s32			 id;
+	union {
+		struct enc_info enc_info;
+		struct dec_info dec_info;
+	} *codec_info;
+	struct frame_buffer frame_buf[MAX_REG_FRAME];
+	struct vpu_buf frame_vbuf[MAX_REG_FRAME];
+	u32 min_dst_buf_count;
+	u32 dst_buf_count;
+	u32 queued_src_buf_num;
+	u32 queued_dst_buf_num;
+	u32 conf_win_width;
+	u32 conf_win_height;
+	u64 timestamp;
+	bool cbcr_interleave;
+	bool nv21;
+	bool eos;
+
+	struct vpu_buf bitstream_vbuf;
+	bool thumbnail_mode;
+
+	unsigned int min_src_buf_count;
+	unsigned int src_buf_count;
+	unsigned int rot_angle;
+	unsigned int mirror_direction;
+	unsigned int bit_depth;
+	unsigned int frame_rate;
+	unsigned int vbv_buf_size;
+	unsigned int rc_mode;
+	unsigned int rc_enable;
+	unsigned int bit_rate;
+	struct enc_wave_param enc_param;
+};
+
+void wave5_vdi_write_register(struct vpu_device *vpu_dev, u32 addr, u32 data);
+u32 wave5_vdi_readl(struct vpu_device *vpu_dev, u32 addr);
+int wave5_vdi_clear_memory(struct vpu_device *vpu_dev, struct vpu_buf *vb);
+int wave5_vdi_allocate_dma_memory(struct vpu_device *vpu_dev, struct vpu_buf *vb);
+int wave5_vdi_write_memory(struct vpu_device *vpu_dev, struct vpu_buf *vb, size_t offset,
+			   u8 *data, size_t len, unsigned int endian);
+unsigned int wave5_vdi_convert_endian(struct vpu_device *vpu_dev, unsigned int endian);
+void wave5_vdi_free_dma_memory(struct vpu_device *vpu_dev, struct vpu_buf *vb);
+
+int wave5_vpu_init_with_bitcode(struct device *dev, u8 *bitcode, size_t size);
+void wave5_vpu_clear_interrupt_ex(struct vpu_instance *inst, u32 intr_flag);
+int wave5_vpu_get_version_info(struct device *dev, u32 *revision, unsigned int *product_id);
+int wave5_vpu_dec_open(struct vpu_instance *inst, struct dec_open_param *open_param);
+int wave5_vpu_dec_close(struct vpu_instance *inst, u32 *fail_res);
+int wave5_vpu_dec_issue_seq_init(struct vpu_instance *inst);
+int wave5_vpu_dec_complete_seq_init(struct vpu_instance *inst, struct dec_initial_info *info);
+int wave5_vpu_dec_register_frame_buffer_ex(struct vpu_instance *inst, int num_of_decoding_fbs,
+					   int num_of_display_fbs, int stride, int height,
+					   int map_type);
+int wave5_vpu_dec_start_one_frame(struct vpu_instance *inst, struct dec_param *param,
+				  u32 *res_fail);
+int wave5_vpu_dec_get_output_info(struct vpu_instance *inst, struct dec_output_info *info);
+int wave5_vpu_dec_set_rd_ptr(struct vpu_instance *inst, dma_addr_t addr, int update_wr_ptr);
+int wave5_vpu_dec_give_command(struct vpu_instance *inst, enum codec_command cmd, void *parameter);
+int wave5_vpu_dec_get_bitstream_buffer(struct vpu_instance *inst, dma_addr_t *prd_ptr,
+				       dma_addr_t *pwr_ptr, size_t *size);
+int wave5_vpu_dec_update_bitstream_buffer(struct vpu_instance *inst, size_t size);
+int wave5_vpu_dec_clr_disp_flag(struct vpu_instance *inst, int index);
+int wave5_vpu_dec_set_disp_flag(struct vpu_instance *inst, int index);
+
+int wave5_vpu_enc_open(struct vpu_instance *inst, struct enc_open_param *open_param);
+int wave5_vpu_enc_close(struct vpu_instance *inst, u32 *fail_res);
+int wave5_vpu_enc_issue_seq_init(struct vpu_instance *inst);
+int wave5_vpu_enc_complete_seq_init(struct vpu_instance *inst, struct enc_initial_info *info);
+int wave5_vpu_enc_register_frame_buffer(struct vpu_instance *inst, unsigned int num,
+					unsigned int stride, int height,
+					enum tiled_map_type map_type);
+int wave5_vpu_enc_start_one_frame(struct vpu_instance *inst, struct enc_param *param,
+				  u32 *fail_res);
+int wave5_vpu_enc_get_output_info(struct vpu_instance *inst, struct enc_output_info *info);
+int wave5_vpu_enc_give_command(struct vpu_instance *inst, enum codec_command cmd, void *parameter);
+
+#endif
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
new file mode 100644
index 000000000000..4527eaf88848
--- /dev/null
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Wave5 series multi-standard codec IP - product config definitions
+ *
+ * Copyright (C) 2021 CHIPS&MEDIA INC
+ */
+
+#ifndef _VPU_CONFIG_H_
+#define _VPU_CONFIG_H_
+
+#define WAVE517_CODE                    0x5170
+#define WAVE537_CODE                    0x5370
+#define WAVE511_CODE                    0x5110
+#define WAVE521_CODE                    0x5210
+#define WAVE521C_CODE                   0x521c
+#define WAVE521C_DUAL_CODE              0x521d  // wave521 dual core
+#define WAVE521E1_CODE                  0x5211
+
+#define PRODUCT_CODE_W_SERIES(x) ({					\
+		int c = x;						\
+		((c) == WAVE517_CODE ||	(c) == WAVE537_CODE ||		\
+		 (c) == WAVE511_CODE || (c) == WAVE521_CODE ||		\
+		 (c) == WAVE521E1_CODE || (c) == WAVE521C_CODE ||	\
+		 (c) == WAVE521C_DUAL_CODE);				\
+})
+
+#define WAVE517_WORKBUF_SIZE            (2 * 1024 * 1024)
+#define WAVE521ENC_WORKBUF_SIZE         (128 * 1024)      //HEVC 128K, AVC 40K
+#define WAVE521DEC_WORKBUF_SIZE         (1784 * 1024)
+
+#define MAX_NUM_INSTANCE                32
+
+#define W5_MIN_ENC_PIC_WIDTH            256
+#define W5_MIN_ENC_PIC_HEIGHT           128
+#define W5_MAX_ENC_PIC_WIDTH            8192
+#define W5_MAX_ENC_PIC_HEIGHT           8192
+
+//  application specific configuration
+#define VPU_ENC_TIMEOUT                 60000
+#define VPU_DEC_TIMEOUT                 60000
+
+#define HOST_ENDIAN                     VDI_128BIT_LITTLE_ENDIAN
+#define VPU_FRAME_ENDIAN                HOST_ENDIAN
+#define VPU_STREAM_ENDIAN               HOST_ENDIAN
+#define VPU_USER_DATA_ENDIAN            HOST_ENDIAN
+#define VPU_SOURCE_ENDIAN               HOST_ENDIAN
+
+// for WAVE encoder
+#define USE_SRC_PRP_AXI         0
+#define USE_SRC_PRI_AXI         1
+#define DEFAULT_SRC_AXI         USE_SRC_PRP_AXI
+
+/************************************************************************/
+/* VPU COMMON MEMORY                                                    */
+/************************************************************************/
+#define VLC_BUF_NUM                     (3)
+
+#define COMMAND_QUEUE_DEPTH             (4)
+
+#define W5_REMAP_INDEX0                 0
+#define W5_REMAP_INDEX1                 1
+#define W5_REMAP_MAX_SIZE               (1024 * 1024)
+
+#define WAVE5_MAX_CODE_BUF_SIZE         (2 * 1024 * 1024)
+#define WAVE5_TEMPBUF_OFFSET            WAVE5_MAX_CODE_BUF_SIZE
+#define WAVE5_TEMPBUF_SIZE              (1024 * 1024)
+
+#define SIZE_COMMON                 (WAVE5_MAX_CODE_BUF_SIZE + WAVE5_TEMPBUF_SIZE)
+
+//=====4. VPU REPORT MEMORY  ======================//
+
+#define WAVE5_UPPER_PROC_AXI_ID     0x0
+
+#define WAVE5_PROC_AXI_ID           0x0
+#define WAVE5_PRP_AXI_ID            0x0
+#define WAVE5_FBD_Y_AXI_ID          0x0
+#define WAVE5_FBC_Y_AXI_ID          0x0
+#define WAVE5_FBD_C_AXI_ID          0x0
+#define WAVE5_FBC_C_AXI_ID          0x0
+#define WAVE5_SEC_AXI_ID            0x0
+#define WAVE5_PRI_AXI_ID            0x0
+
+#define WAVE5_PROC_AXI_AXPROT       0x0
+#define WAVE5_PROC_AXI_AXCACHE      0x0
+#define WAVE5_PROC_AXI_EXT_ADDR     0x0
+#define WAVE5_SEC_AXI_AXPROT        0x0
+#define WAVE5_SEC_AXI_AXCACHE       0x0
+#define WAVE5_SEC_AXI_EXT_ADDR      0x0
+
+#endif  /* _VPU_CONFIG_H_ */
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuerror.h b/drivers/media/platform/chips-media/wave5/wave5-vpuerror.h
new file mode 100644
index 000000000000..6d8c7bb0e8b2
--- /dev/null
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuerror.h
@@ -0,0 +1,454 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Wave5 series multi-standard codec IP - error values
+ *
+ * Copyright (C) 2021 CHIPS&MEDIA INC
+ */
+
+#ifndef ERROR_CODE_H_INCLUDED
+#define ERROR_CODE_H_INCLUDED
+
+/*
+ * WAVE5
+ */
+
+/************************************************************************/
+/* WAVE5 COMMON SYSTEM ERROR (FAIL_REASON)                              */
+/************************************************************************/
+#define WAVE5_SYSERR_QUEUEING_FAIL                                     0x00000001
+#define WAVE5_SYSERR_ACCESS_VIOLATION_HW                               0x00000040
+#define WAVE5_SYSERR_BUS_ERROR                                         0x00000200
+#define WAVE5_SYSERR_DOUBLE_FAULT                                      0x00000400
+#define WAVE5_SYSERR_RESULT_NOT_READY                                  0x00000800
+#define WAVE5_SYSERR_VPU_STILL_RUNNING                                 0x00001000
+#define WAVE5_SYSERR_UNKNOWN_CMD                                       0x00002000
+#define WAVE5_SYSERR_UNKNOWN_CODEC_STD                                 0x00004000
+#define WAVE5_SYSERR_UNKNOWN_QUERY_OPTION                              0x00008000
+#define WAVE5_SYSERR_VLC_BUF_FULL                                      0x00010000
+#define WAVE5_SYSERR_WATCHDOG_TIMEOUT                                  0x00020000
+#define WAVE5_SYSERR_VCPU_TIMEOUT                                      0x00080000
+#define WAVE5_SYSERR_TEMP_SEC_BUF_OVERFLOW                             0x00200000
+#define WAVE5_SYSERR_NEED_MORE_TASK_BUF                                0x00400000
+#define WAVE5_SYSERR_PRESCAN_ERR                                       0x00800000
+#define WAVE5_SYSERR_ENC_GBIN_OVERCONSUME                              0x01000000
+#define WAVE5_SYSERR_ENC_MAX_ZERO_DETECT                               0x02000000
+#define WAVE5_SYSERR_ENC_LVL_FIRST_ERROR                               0x04000000
+#define WAVE5_SYSERR_ENC_EG_RANGE_OVER                                 0x08000000
+#define WAVE5_SYSERR_ENC_IRB_FRAME_DROP                                0x10000000
+#define WAVE5_SYSERR_INPLACE_V                                         0x20000000
+#define WAVE5_SYSERR_FATAL_VPU_HANGUP                                  0xf0000000
+
+/************************************************************************/
+/* WAVE5 COMMAND QUEUE ERROR (FAIL_REASON)                              */
+/************************************************************************/
+#define WAVE5_CMDQ_ERR_NOT_QUEABLE_CMD                                 0x00000001
+#define WAVE5_CMDQ_ERR_SKIP_MODE_ENABLE                                0x00000002
+#define WAVE5_CMDQ_ERR_INST_FLUSHING                                   0x00000003
+#define WAVE5_CMDQ_ERR_INST_INACTIVE                                   0x00000004
+#define WAVE5_CMDQ_ERR_QUEUE_FAIL                                      0x00000005
+#define WAVE5_CMDQ_ERR_CMD_BUF_FULL                                    0x00000006
+
+/************************************************************************/
+/* WAVE5 ERROR ON DECODER (ERR_INFO)                                    */
+/************************************************************************/
+// HEVC
+#define HEVC_SPSERR_SEQ_PARAMETER_SET_ID                               0x00001000
+#define HEVC_SPSERR_CHROMA_FORMAT_IDC                                  0x00001001
+#define HEVC_SPSERR_PIC_WIDTH_IN_LUMA_SAMPLES                          0x00001002
+#define HEVC_SPSERR_PIC_HEIGHT_IN_LUMA_SAMPLES                         0x00001003
+#define HEVC_SPSERR_CONF_WIN_LEFT_OFFSET                               0x00001004
+#define HEVC_SPSERR_CONF_WIN_RIGHT_OFFSET                              0x00001005
+#define HEVC_SPSERR_CONF_WIN_TOP_OFFSET                                0x00001006
+#define HEVC_SPSERR_CONF_WIN_BOTTOM_OFFSET                             0x00001007
+#define HEVC_SPSERR_BIT_DEPTH_LUMA_MINUS8                              0x00001008
+#define HEVC_SPSERR_BIT_DEPTH_CHROMA_MINUS8                            0x00001009
+#define HEVC_SPSERR_LOG2_MAX_PIC_ORDER_CNT_LSB_MINUS4                  0x0000100A
+#define HEVC_SPSERR_SPS_MAX_DEC_PIC_BUFFERING                          0x0000100B
+#define HEVC_SPSERR_SPS_MAX_NUM_REORDER_PICS                           0x0000100C
+#define HEVC_SPSERR_SPS_MAX_LATENCY_INCREASE                           0x0000100D
+#define HEVC_SPSERR_LOG2_MIN_LUMA_CODING_BLOCK_SIZE_MINUS3             0x0000100E
+#define HEVC_SPSERR_LOG2_DIFF_MAX_MIN_LUMA_CODING_BLOCK_SIZE           0x0000100F
+#define HEVC_SPSERR_LOG2_MIN_TRANSFORM_BLOCK_SIZE_MINUS2               0x00001010
+#define HEVC_SPSERR_LOG2_DIFF_MAX_MIN_TRANSFORM_BLOCK_SIZE             0x00001011
+#define HEVC_SPSERR_MAX_TRANSFORM_HIERARCHY_DEPTH_INTER                0x00001012
+#define HEVC_SPSERR_MAX_TRANSFORM_HIERARCHY_DEPTH_INTRA                0x00001013
+#define HEVC_SPSERR_SCALING_LIST                                       0x00001014
+#define HEVC_SPSERR_LOG2_DIFF_MIN_PCM_LUMA_CODING_BLOCK_SIZE_MINUS3    0x00001015
+#define HEVC_SPSERR_LOG2_DIFF_MAX_MIN_PCM_LUMA_CODING_BLOCK_SIZE       0x00001016
+#define HEVC_SPSERR_NUM_SHORT_TERM_REF_PIC_SETS                        0x00001017
+#define HEVC_SPSERR_NUM_LONG_TERM_REF_PICS_SPS                         0x00001018
+#define HEVC_SPSERR_GBU_PARSING_ERROR                                  0x00001019
+#define HEVC_SPSERR_EXTENSION_FLAG                                     0x0000101A
+#define HEVC_SPSERR_VUI_ERROR                                          0x0000101B
+#define HEVC_SPSERR_ACTIVATE_SPS                                       0x0000101C
+#define HEVC_SPSERR_PROFILE_SPACE                                      0x0000101D
+#define HEVC_PPSERR_PPS_PIC_PARAMETER_SET_ID                           0x00002000
+#define HEVC_PPSERR_PPS_SEQ_PARAMETER_SET_ID                           0x00002001
+#define HEVC_PPSERR_NUM_REF_IDX_L0_DEFAULT_ACTIVE_MINUS1               0x00002002
+#define HEVC_PPSERR_NUM_REF_IDX_L1_DEFAULT_ACTIVE_MINUS1               0x00002003
+#define HEVC_PPSERR_INIT_QP_MINUS26                                    0x00002004
+#define HEVC_PPSERR_DIFF_CU_QP_DELTA_DEPTH                             0x00002005
+#define HEVC_PPSERR_PPS_CB_QP_OFFSET                                   0x00002006
+#define HEVC_PPSERR_PPS_CR_QP_OFFSET                                   0x00002007
+#define HEVC_PPSERR_NUM_TILE_COLUMNS_MINUS1                            0x00002008
+#define HEVC_PPSERR_NUM_TILE_ROWS_MINUS1                               0x00002009
+#define HEVC_PPSERR_COLUMN_WIDTH_MINUS1                                0x0000200A
+#define HEVC_PPSERR_ROW_HEIGHT_MINUS1                                  0x0000200B
+#define HEVC_PPSERR_PPS_BETA_OFFSET_DIV2                               0x0000200C
+#define HEVC_PPSERR_PPS_TC_OFFSET_DIV2                                 0x0000200D
+#define HEVC_PPSERR_SCALING_LIST                                       0x0000200E
+#define HEVC_PPSERR_LOG2_PARALLEL_MERGE_LEVEL_MINUS2                   0x0000200F
+#define HEVC_PPSERR_NUM_TILE_COLUMNS_RANGE_OUT                         0x00002010
+#define HEVC_PPSERR_NUM_TILE_ROWS_RANGE_OUT                            0x00002011
+#define HEVC_PPSERR_MORE_RBSP_DATA_ERROR                               0x00002012
+#define HEVC_PPSERR_PPS_PIC_PARAMETER_SET_ID_RANGE_OUT                 0x00002013
+#define HEVC_PPSERR_PPS_SEQ_PARAMETER_SET_ID_RANGE_OUT                 0x00002014
+#define HEVC_PPSERR_NUM_REF_IDX_L0_DEFAULT_ACTIVE_MINUS1_RANGE_OUT     0x00002015
+#define HEVC_PPSERR_NUM_REF_IDX_L1_DEFAULT_ACTIVE_MINUS1_RANGE_OUT     0x00002016
+#define HEVC_PPSERR_PPS_CB_QP_OFFSET_RANGE_OUT                         0x00002017
+#define HEVC_PPSERR_PPS_CR_QP_OFFSET_RANGE_OUT                         0x00002018
+#define HEVC_PPSERR_COLUMN_WIDTH_MINUS1_RANGE_OUT                      0x00002019
+#define HEVC_PPSERR_ROW_HEIGHT_MINUS1_RANGE_OUT                        0x00002020
+#define HEVC_PPSERR_PPS_BETA_OFFSET_DIV2_RANGE_OUT                     0x00002021
+#define HEVC_PPSERR_PPS_TC_OFFSET_DIV2_RANGE_OUT                       0x00002022
+#define HEVC_SHERR_SLICE_PIC_PARAMETER_SET_ID                          0x00003000
+#define HEVC_SHERR_ACTIVATE_PPS                                        0x00003001
+#define HEVC_SHERR_ACTIVATE_SPS                                        0x00003002
+#define HEVC_SHERR_SLICE_TYPE                                          0x00003003
+#define HEVC_SHERR_FIRST_SLICE_IS_DEPENDENT_SLICE                      0x00003004
+#define HEVC_SHERR_SHORT_TERM_REF_PIC_SET_SPS_FLAG                     0x00003005
+#define HEVC_SHERR_SHORT_TERM_REF_PIC_SET                              0x00003006
+#define HEVC_SHERR_SHORT_TERM_REF_PIC_SET_IDX                          0x00003007
+#define HEVC_SHERR_NUM_LONG_TERM_SPS                                   0x00003008
+#define HEVC_SHERR_NUM_LONG_TERM_PICS                                  0x00003009
+#define HEVC_SHERR_LT_IDX_SPS_IS_OUT_OF_RANGE                          0x0000300A
+#define HEVC_SHERR_DELTA_POC_MSB_CYCLE_LT                              0x0000300B
+#define HEVC_SHERR_NUM_REF_IDX_L0_ACTIVE_MINUS1                        0x0000300C
+#define HEVC_SHERR_NUM_REF_IDX_L1_ACTIVE_MINUS1                        0x0000300D
+#define HEVC_SHERR_COLLOCATED_REF_IDX                                  0x0000300E
+#define HEVC_SHERR_PRED_WEIGHT_TABLE                                   0x0000300F
+#define HEVC_SHERR_FIVE_MINUS_MAX_NUM_MERGE_CAND                       0x00003010
+#define HEVC_SHERR_SLICE_QP_DELTA                                      0x00003011
+#define HEVC_SHERR_SLICE_QP_DELTA_IS_OUT_OF_RANGE                      0x00003012
+#define HEVC_SHERR_SLICE_CB_QP_OFFSET                                  0x00003013
+#define HEVC_SHERR_SLICE_CR_QP_OFFSET                                  0x00003014
+#define HEVC_SHERR_SLICE_BETA_OFFSET_DIV2                              0x00003015
+#define HEVC_SHERR_SLICE_TC_OFFSET_DIV2                                0x00003016
+#define HEVC_SHERR_NUM_ENTRY_POINT_OFFSETS                             0x00003017
+#define HEVC_SHERR_OFFSET_LEN_MINUS1                                   0x00003018
+#define HEVC_SHERR_SLICE_SEGMENT_HEADER_EXTENSION_LENGTH               0x00003019
+#define HEVC_SHERR_WRONG_POC_IN_STILL_PICTURE_PROFILE                  0x0000301A
+#define HEVC_SHERR_SLICE_TYPE_ERROR_IN_STILL_PICTURE_PROFILE           0x0000301B
+#define HEVC_SHERR_PPS_ID_NOT_EQUAL_PREV_VALUE                         0x0000301C
+#define HEVC_SPECERR_OVER_PICTURE_WIDTH_SIZE                           0x00004000
+#define HEVC_SPECERR_OVER_PICTURE_HEIGHT_SIZE                          0x00004001
+#define HEVC_SPECERR_OVER_CHROMA_FORMAT                                0x00004002
+#define HEVC_SPECERR_OVER_BIT_DEPTH                                    0x00004003
+#define HEVC_SPECERR_OVER_BUFFER_OVER_FLOW                             0x00004004
+#define HEVC_SPECERR_OVER_WRONG_BUFFER_ACCESS                          0x00004005
+#define HEVC_ETCERR_INIT_SEQ_SPS_NOT_FOUND                             0x00005000
+#define HEVC_ETCERR_DEC_PIC_VCL_NOT_FOUND                              0x00005001
+#define HEVC_ETCERR_NO_VALID_SLICE_IN_AU                               0x00005002
+#define HEVC_ETCERR_INPLACE_V                                          0x0000500F
+
+// AVC
+#define AVC_SPSERR_SEQ_PARAMETER_SET_ID                                0x00001000
+#define AVC_SPSERR_CHROMA_FORMAT_IDC                                   0x00001001
+#define AVC_SPSERR_PIC_WIDTH_IN_LUMA_SAMPLES                           0x00001002
+#define AVC_SPSERR_PIC_HEIGHT_IN_LUMA_SAMPLES                          0x00001003
+#define AVC_SPSERR_CONF_WIN_LEFT_OFFSET                                0x00001004
+#define AVC_SPSERR_CONF_WIN_RIGHT_OFFSET                               0x00001005
+#define AVC_SPSERR_CONF_WIN_TOP_OFFSET                                 0x00001006
+#define AVC_SPSERR_CONF_WIN_BOTTOM_OFFSET                              0x00001007
+#define AVC_SPSERR_BIT_DEPTH_LUMA_MINUS8                               0x00001008
+#define AVC_SPSERR_BIT_DEPTH_CHROMA_MINUS8                             0x00001009
+#define AVC_SPSERR_SPS_MAX_DEC_PIC_BUFFERING                           0x0000100B
+#define AVC_SPSERR_SPS_MAX_NUM_REORDER_PICS                            0x0000100C
+#define AVC_SPSERR_SCALING_LIST                                        0x00001014
+#define AVC_SPSERR_GBU_PARSING_ERROR                                   0x00001019
+#define AVC_SPSERR_VUI_ERROR                                           0x0000101B
+#define AVC_SPSERR_ACTIVATE_SPS                                        0x0000101C
+#define AVC_PPSERR_PPS_PIC_PARAMETER_SET_ID                            0x00002000
+#define AVC_PPSERR_PPS_SEQ_PARAMETER_SET_ID                            0x00002001
+#define AVC_PPSERR_NUM_REF_IDX_L0_DEFAULT_ACTIVE_MINUS1                0x00002002
+#define AVC_PPSERR_NUM_REF_IDX_L1_DEFAULT_ACTIVE_MINUS1                0x00002003
+#define AVC_PPSERR_INIT_QP_MINUS26                                     0x00002004
+#define AVC_PPSERR_PPS_CB_QP_OFFSET                                    0x00002006
+#define AVC_PPSERR_PPS_CR_QP_OFFSET                                    0x00002007
+#define AVC_PPSERR_SCALING_LIST                                        0x0000200E
+#define AVC_PPSERR_MORE_RBSP_DATA_ERROR                                0x00002012
+#define AVC_PPSERR_PPS_PIC_PARAMETER_SET_ID_RANGE_OUT                  0x00002013
+#define AVC_PPSERR_PPS_SEQ_PARAMETER_SET_ID_RANGE_OUT                  0x00002014
+#define AVC_PPSERR_NUM_REF_IDX_L0_DEFAULT_ACTIVE_MINUS1_RANGE_OUT      0x00002015
+#define AVC_PPSERR_NUM_REF_IDX_L1_DEFAULT_ACTIVE_MINUS1_RANGE_OUT      0x00002016
+#define AVC_PPSERR_PPS_CB_QP_OFFSET_RANGE_OUT                          0x00002017
+#define AVC_PPSERR_PPS_CR_QP_OFFSET_RANGE_OUT                          0x00002018
+#define AVC_SHERR_SLICE_PIC_PARAMETER_SET_ID                           0x00003000
+#define AVC_SHERR_ACTIVATE_PPS                                         0x00003001
+#define AVC_SHERR_ACTIVATE_SPS                                         0x00003002
+#define AVC_SHERR_SLICE_TYPE                                           0x00003003
+#define AVC_SHERR_FIRST_MB_IN_SLICE                                    0x00003004
+#define AVC_SHERR_RPLM                                                 0x00003006
+#define AVC_SHERR_LT_IDX_SPS_IS_OUT_OF_RANGE                           0x0000300A
+#define AVC_SHERR_NUM_REF_IDX_L0_ACTIVE_MINUS1                         0x0000300C
+#define AVC_SHERR_NUM_REF_IDX_L1_ACTIVE_MINUS1                         0x0000300D
+#define AVC_SHERR_PRED_WEIGHT_TABLE                                    0x0000300F
+#define AVC_SHERR_SLICE_QP_DELTA                                       0x00003011
+#define AVC_SHERR_SLICE_BETA_OFFSET_DIV2                               0x00003015
+#define AVC_SHERR_SLICE_TC_OFFSET_DIV2                                 0x00003016
+#define AVC_SHERR_DISABLE_DEBLOCK_FILTER_IDC                           0x00003017
+#define AVC_SPECERR_OVER_PICTURE_WIDTH_SIZE                            0x00004000
+#define AVC_SPECERR_OVER_PICTURE_HEIGHT_SIZE                           0x00004001
+#define AVC_SPECERR_OVER_CHROMA_FORMAT                                 0x00004002
+#define AVC_SPECERR_OVER_BIT_DEPTH                                     0x00004003
+#define AVC_SPECERR_OVER_BUFFER_OVER_FLOW                              0x00004004
+#define AVC_SPECERR_OVER_WRONG_BUFFER_ACCESS                           0x00004005
+#define AVC_ETCERR_INIT_SEQ_SPS_NOT_FOUND                              0x00005000
+#define AVC_ETCERR_DEC_PIC_VCL_NOT_FOUND                               0x00005001
+#define AVC_ETCERR_NO_VALID_SLICE_IN_AU                                0x00005002
+#define AVC_ETCERR_ASO                                                 0x00005004
+#define AVC_ETCERR_FMO                                                 0x00005005
+#define AVC_ETCERR_INPLACE_V                                           0x0000500F
+
+// AV1
+#define AV1_SPSERR_MAX_FRAME_WIDTH                                     0x00001001
+#define AV1_SPSERR_MAX_FRAME_HEIGHT                                    0x00001002
+#define AV1_SPSERR_ID_LEN_EXCEED_16                                    0x00001004
+#define AV1_SPSERR_NOT_FOUND_FIRST_SPS                                 0x0000100A
+#define AV1_SPSERR_SEQ_PROFILE                                         0x0000100B
+#define AV1_SPSERR_STILL_PICTURE                                       0x0000100C
+#define AV1_PPSERR_FRAME_SIZE_WIDTH                                    0x00002001
+#define AV1_PPSERR_FRAME_SIZE_HEIGHT                                   0x00002002
+#define AV1_PPSERR_SEEN_FRAME_HEADER                                   0x00002003
+#define AV1_PPSERR_REF_VALID                                           0x00002007
+#define AV1_PPSERR_LAST_ORDER_HINT                                     0x0000200B
+#define AV1_PPSERR_GOLD_ORDER_HINT                                     0x0000200C
+#define AV1_PPSERR_CODED_LOSSLESS_DELTA_Q                              0x0000200E
+#define AV1_PPSERR_FILM_GRAIN_PARAM_REF_IDX                            0x0000200F
+#define AV1_PPSERR_SEQ_CHANGE_BIT_DEPTH                                0x00002010
+#define AV1_PPSERR_SEQ_CHANGE_PROFILE                                  0x00002012
+#define AV1_PPSERR_SEQ_CHANGE_DETECTED_INTER                           0x00002013
+#define AV1_PPSERR_NUM_Y_POINTS                                        0x00002014
+#define AV1_PPSERR_POINT_Y_VALUE                                       0x00002015
+#define AV1_PPSERR_NUM_CB_POINTS                                       0x00002016
+#define AV1_PPSERR_POINT_CB_VALUE                                      0x00002017
+#define AV1_PPSERR_NUM_CR_POINTS                                       0x00002018
+#define AV1_PPSERR_POINT_CR_VALUE                                      0x00002019
+#define AV1_PPSERR_SUBSAMPLING_FORMAT                                  0x0000201A
+#define AV1_FRAMEERR_TILE_START_END_PRESENT                            0x00003001
+#define AV1_FRAMEERR_SHOW_EXISING_FRAME                                0x00003002
+#define AV1_TGERR_NUM_TILES_ZERO                                       0x00004001
+#define AV1_TGERR_START_NOT_TILE_NUM                                   0x00004002
+#define AV1_TGERR_END_LESS_THAN_TG_START                               0x00004003
+#define AV1_TGERR_TILE_SIZE_GREATER_THAN_32M                           0x00004004
+#define AV1_SPECERR_OVER_MAX_H_SIZE                                    0x00005001
+#define AV1_SPECERR_OVER_MAX_V_SIZE                                    0x00005002
+#define AV1_SPECERR_OVER_MAX_TILE_COLS                                 0x00005004
+#define AV1_SPECERR_OVER_MAX_TILE_ROWS                                 0x00005005
+#define AV1_SPECERR_OVER_TILE_SIZE                                     0x00005006
+#define AV1_SPECERR_OVER_NUMTILES_GT_MAX_TILES                         0x00005007
+#define AV1_ETCERR_OBU_HEADER                                          0x00006001
+#define AV1_ETCERR_OBU_SIZE                                            0x00006003
+#define AV1_ETCERR_OVERCONSUME                                         0x00006004
+#define AV1_ETCERR_NOT_SUPPORTED_FEATURE                               0x00006005
+#define AV1_ETCERR_RESILIENCE_FAIL                                     0x00006006
+
+// VP9
+#define VP9_PICERR_FRAME_MARKER                                        0x00001000
+#define VP9_PICERR_PROFILE                                             0x00001001
+#define VP9_PICERR_SYNC_CODE                                           0x00001002
+#define VP9_PICERR_PROFILE_COLOR_SAMPLE                                0x00001003
+#define VP9_PICERR_FRAME_SIZE                                          0x00001004
+#define VP9_PICERR_SEGMENT                                             0x00001005
+#define VP9_PICERR_TILE                                                0x00001006
+#define VP9_PICERR_PROFILE_COMP_MISMATCH_WITH_REF                      0x00001007
+#define VP9_PICERR_COMP_DAT_OVER_CS                                    0x00001008
+#define VP9_PICERR_COMP_TRAILING_BIT_ERR                               0x00001009
+#define VP9_PICERR_MARKER                                              0x0000100A
+#define VP9_PICERR_NOT_EXIST_REF_FRAME                                 0x0000100B
+#define VP9_PICERR_UNINIT_CTX                                          0x0000100C
+#define VP9_PICERR_FRAME_SIZE_LIMIT_BY_REF                             0x0000100D
+#define VP9_SPECERR_OVER_PICTURE_WIDTH_SIZE                            0x00004000
+#define VP9_SPECERR_OVER_PICTURE_HEIGHT_SIZE                           0x00004001
+#define VP9_SPECERR_OVER_CHROMA_FORMAT                                 0x00004002
+#define VP9_SPECERR_OVER_BIT_DEPTH                                     0x00004003
+#define VP9_ETCERR_INIT_KEY_FRAME_NOT_FOUND                            0x00005000
+#define VP9_ETCERR_FORBIDDEN_BS_MODE                                   0x00005004
+#define VP9_ETCERR_SPP_OVER_CS_AU                                      0x00005005
+
+// AVS2
+#define AVS2_SPSERR_PROFILE_ID                                         0x00001000
+#define AVS2_SPSERR_LEVEL_ID                                           0x00001001
+#define AVS2_SPSERR_HORIZONTAL_SIZE                                    0x00001002
+#define AVS2_SPSERR_VERTICAL_SIZE                                      0x00001003
+#define AVS2_SPSERR_CHROMA_FORMAT                                      0x00001004
+#define AVS2_SPSERR_SAMPLE_PRECISION                                   0x00001005
+#define AVS2_SPSERR_ENCODING_PRECISION                                 0x00001006
+#define AVS2_SPSERR_LCU_SIZE                                           0x00001007
+#define AVS2_SPSERR_WEIGHT_QUANT_MATRIX                                0x00001008
+#define AVS2_SPSERR_NUM_OF_RCS                                         0x00001009
+#define AVS2_SPSERR_REFERENCE_CONFIGURATION_SET                        0x0000100A
+#define AVS2_SPSERR_OUTPUT_REORDER_DELAY                               0x0000100B
+#define AVS2_PPSERR_BBV_DELAY                                          0x00002000
+#define AVS2_PPSERR_TIME_CODE                                          0x00002001
+#define AVS2_PPSERR_DECODE_ORDER_INDEX                                 0x00002002
+#define AVS2_PPSERR_TEMPORAL_ID                                        0x00002003
+#define AVS2_PPSERR_PICTURE_OUTPUT_DELAY                               0x00002004
+#define AVS2_PPSERR_RCS_INDEX                                          0x00002005
+#define AVS2_PPSERR_REFERENCE_CONFIGURATION_SET                        0x00002006
+#define AVS2_PPSERR_BBV_CHECK_TIMES                                    0x00002007
+#define AVS2_PPSERR_PICTURE_QP                                         0x00002008
+#define AVS2_PPSERR_ALPHA_C_OFFSET                                     0x00002009
+#define AVS2_PPSERR_BETA_OFFSET                                        0x0000200A
+#define AVS2_PPSERR_CHROMA_QUANT_PARAM_DELTA_CB                        0x0000200B
+#define AVS2_PPSERR_CHROMA_QUANT_PARAM_DELTA_CR                        0x0000200C
+#define AVS2_PPSERR_WEIGHT_QUANT_PARAM_DELTA1                          0x0000200D
+#define AVS2_PPSERR_WEIGHT_QUANT_PARAM_DELTA2                          0x0000200E
+#define AVS2_PPSERR_PICTURE_CODING_TYPE                                0x0000200F
+#define AVS2_PPSERR_ALF_FILTER_NUM_MINUS1                              0x00002010
+#define AVS2_PPSERR_ALF_REGION_DISTANCE                                0x00002011
+#define AVS2_PPSERR_ALF_COEFF_LUMA                                     0x00002012
+#define AVS2_PPSERR_ALF_COEFF_CHROMA_CB                                0x00002013
+#define AVS2_PPSERR_ALF_COEFF_CHROMA_CR                                0x00002014
+#define AVS2_SHERR_SLICE_VERTICAL_POSITION                             0x00003000
+#define AVS2_SHERR_SLICE_VERTICAL_POSITION_EXTENSION                   0x00003001
+#define AVS2_SHERR_SLICE_HORIZONTAL_POSITION                           0x00003002
+#define AVS2_SHERR_SLICE_HORIZONTAL_POSITION_EXTENSION                 0x00003003
+#define AVS2_SHERR_FIXED_SLICE_QP                                      0x00003004
+#define AVS2_SHERR_SLICE_QP                                            0x00003005
+#define AVS2_SHERR_SLICE_SAO_ENABLE_FLAG                               0x00003006
+#define AVS2_SHERR_AEC_BYTE_ALIGNMENT_BIT                              0x00003007
+#define AVS2_SHERR_STREAM_END                                          0x00003008
+#define AVS2_SPECERR_OVER_PICTURE_WIDTH_SIZE                           0x00004000
+#define AVS2_SPECERR_OVER_PICTURE_HEIGHT_SIZE                          0x00004001
+#define AVS2_SPECERR_OVER_CHROMA_FORMAT                                0x00004002
+#define AVS2_SPECERR_OVER_BIT_DEPTH                                    0x00004003
+#define AVS2_SPECERR_OVER_REF_TEMPORAL_ID                              0x00004004
+#define AVS2_ETCERR_SPS_NOT_FOUND                                      0x00005000
+#define AVS2_ETCERR_DEC_PIC_VCL_NOT_FOUND                              0x00005001
+#define AVS2_ETCERR_NO_VALID_SLICE_IN_AU                               0x00005002
+#define AVS2_ETCERR_PPS_ERROR                                          0x00005003
+#define AVS2_ETCERR_SLICE_NUM_OVERFLOW                                 0x00005004
+
+/************************************************************************/
+/* WAVE5 WARNING ON DECODER (WARN_INFO)                                 */
+/************************************************************************/
+// HEVC
+#define HEVC_SPSWARN_MAX_SUB_LAYERS_MINUS1                             0x00000001
+#define HEVC_SPSWARN_GENERAL_RESERVED_ZERO_44BITS                      0x00000002
+#define HEVC_SPSWARN_RESERVED_ZERO_2BITS                               0x00000004
+#define HEVC_SPSWARN_SUB_LAYER_RESERVED_ZERO_44BITS                    0x00000008
+#define HEVC_SPSWARN_GENERAL_LEVEL_IDC                                 0x00000010
+#define HEVC_SPSWARN_SPS_MAX_DEC_PIC_BUFFERING_VALUE_OVER              0x00000020
+#define HEVC_SPSWARN_RBSP_TRAILING_BITS                                0x00000040
+#define HEVC_SPSWARN_ST_RPS_UE_ERROR                                   0x00000080
+#define HEVC_SPSWARN_EXTENSION_FLAG                                    0x01000000
+#define HEVC_SPSWARN_REPLACED_WITH_PREV_SPS                            0x02000000
+#define HEVC_PPSWARN_RBSP_TRAILING_BITS                                0x00000100
+#define HEVC_PPSWARN_REPLACED_WITH_PREV_PPS                            0x00000200
+#define HEVC_SHWARN_FIRST_SLICE_SEGMENT_IN_PIC_FLAG                    0x00001000
+#define HEVC_SHWARN_NO_OUTPUT_OF_PRIOR_PICS_FLAG                       0x00002000
+#define HEVC_SHWARN_PIC_OUTPUT_FLAG                                    0x00004000
+#define HEVC_SHWARN_DUPLICATED_SLICE_SEGMENT                           0x00008000
+#define HEVC_ETCWARN_INIT_SEQ_VCL_NOT_FOUND                            0x00010000
+#define HEVC_ETCWARN_MISSING_REFERENCE_PICTURE                         0x00020000
+#define HEVC_ETCWARN_WRONG_TEMPORAL_ID                                 0x00040000
+#define HEVC_ETCWARN_ERROR_PICTURE_IS_REFERENCED                       0x00080000
+#define HEVC_SPECWARN_OVER_PROFILE                                     0x00100000
+#define HEVC_SPECWARN_OVER_LEVEL                                       0x00200000
+#define HEVC_PRESWARN_PARSING_ERR                                      0x04000000
+#define HEVC_PRESWARN_MVD_OUT_OF_RANGE                                 0x08000000
+#define HEVC_PRESWARN_CU_QP_DELTA_VAL_OUT_OF_RANGE                     0x09000000
+#define HEVC_PRESWARN_COEFF_LEVEL_REMAINING_OUT_OF_RANGE               0x0A000000
+#define HEVC_PRESWARN_PCM_ERR                                          0x0B000000
+#define HEVC_PRESWARN_OVERCONSUME                                      0x0C000000
+#define HEVC_PRESWARN_END_OF_SUBSET_ONE_BIT_ERR                        0x10000000
+#define HEVC_PRESWARN_END_OF_SLICE_SEGMENT_FLAG                        0x20000000
+
+// AVC
+#define AVC_SPSWARN_RESERVED_ZERO_2BITS                                0x00000004
+#define AVC_SPSWARN_GENERAL_LEVEL_IDC                                  0x00000010
+#define AVC_SPSWARN_RBSP_TRAILING_BITS                                 0x00000040
+#define AVC_PPSWARN_RBSP_TRAILING_BITS                                 0x00000100
+#define AVC_SHWARN_NO_OUTPUT_OF_PRIOR_PICS_FLAG                        0x00002000
+#define AVC_ETCWARN_INIT_SEQ_VCL_NOT_FOUND                             0x00010000
+#define AVC_ETCWARN_MISSING_REFERENCE_PICTURE                          0x00020000
+#define AVC_ETCWARN_ERROR_PICTURE_IS_REFERENCED                        0x00080000
+#define AVC_SPECWARN_OVER_PROFILE                                      0x00100000
+#define AVC_SPECWARN_OVER_LEVEL                                        0x00200000
+#define AVC_PRESWARN_MVD_RANGE_OUT                                     0x00400000
+#define AVC_PRESWARN_MB_QPD_RANGE_OUT                                  0x00500000
+#define AVC_PRESWARN_COEFF_RANGE_OUT                                   0x00600000
+#define AVC_PRESWARN_MV_RANGE_OUT                                      0x00700000
+#define AVC_PRESWARN_MB_SKIP_RUN_RANGE_OUT                             0x00800000
+#define AVC_PRESWARN_MB_TYPE_RANGE_OUT                                 0x00900000
+#define AVC_PRESWARN_SUB_MB_TYPE_RANGE_OUT                             0x00A00000
+#define AVC_PRESWARN_CBP_RANGE_OUT                                     0x00B00000
+#define AVC_PRESWARN_INTRA_CHROMA_PRED_MODE_RANGE_OUT                  0x00C00000
+#define AVC_PRESWARN_REF_IDX_RANGE_OUT                                 0x00D00000
+#define AVC_PRESWARN_COEFF_TOKEN_RANGE_OUT                             0x00E00000
+#define AVC_PRESWARN_TOTAL_ZERO_RANGE_OUT                              0x00F00000
+#define AVC_PRESWARN_RUN_BEFORE_RANGE_OUT                              0x01000000
+#define AVC_PRESWARN_OVERCONSUME                                       0x01100000
+#define AVC_PRESWARN_MISSING_SLICE                                     0x01200000
+
+// AV1
+#define AV1_SPSWARN_OBU_EXTENSION_FLAG_ZERO                            0x00001000
+#define AV1_SPSWARN_DUPLICATE_OPERATING_POINT_IDX                      0x00001001
+#define AV1_SPSWARN_MC_IDENTIY_SUBSAMPLING_X                           0x00001002
+#define AV1_PPSWARN_MC_IDENTIY_SUBSAMPLING_Y                           0x00001003
+#define AV1_SPSWARN_NUM_UNITS_IN_DISPLAY_TICK                          0x00001004
+#define AV1_SPSWARN_TIME_SCALE_ZERO                                    0x00001005
+#define AV1_SPSWARN_NUM_TICKS_PER_PICTURE                              0x00001006
+#define AV1_PPSWARN_TILE_WIDTH                                         0x00002001
+#define AV1_PPSWARN_TILE_HEIGHT                                        0x00002002
+#define AV1_PPSWARN_SHOW_EXISTING_KEY_FRAME_OUTPUT                     0x00002004
+#define AV1_PPSWARN_DIFF_FRAME_ID                                      0x00002008
+#define AV1_PPSWARN_CURRENT_FRAME_ID                                   0x00002010
+#define AV1_PPSWARN_REFRESH_FRAME_FLAGS                                0x00002020
+#define AV1_PPSWARN_DISPLAY_ID                                         0x00002040
+#define AV1_PPSWARN_PREV_FRAME_SHOWABLE_FLAG_ZERO                      0x00002080
+#define AV1_PPSWARN_EXPECTED_FRAME_ID                                  0x00002100
+#define AV1_SPECWARN_OVER_MAX_TILE_AREA_SB                             0x00005000
+#define AV1_SPECWARN_OVER_MAX_PIC_SIZE                                 0x00005001
+#define AV1_ETCWARN_OBU_EXTENSION_FLAG                                 0x00006000
+#define AV1_TGWARN_TRAIL_BIT_POS                                       0x00400000
+#define AV1_TGWARN_TRAIL_PAD_BIT                                       0x00800000
+#define AV1_TGWARN_SYM_MAX_OVER                                        0x01000000
+#define AV1_TGWARN_EXP_GOLB_OVER                                       0x02000000
+#define AV1_TGWARN_MV_NOT_VALID                                        0x04000000
+
+// VP9
+#define VP9_PICWARN_COLOR_SPACE_MISMATCH_WITH_REF                      0x00001000
+#define VP9_PRESWARN_OVERCONSUME                                       0x00400000
+#define VP9_PRESWARN_TRAILING_BITS                                     0x00800000
+#define VP9_PRESWARN_MARKER                                            0x01000000
+#define VP9_PRESWARN_MV_RANGE_OVER                                     0x02000000
+#define VP9_PRESWARN_MISIZE_SEG_LVL_ACTIVE                             0x04000000
+
+// AVS2
+#define AVS2_ETCWARN_INIT_SEQ_VCL_NOT_FOUND                            0x00010000
+#define AVS2_ETCWARN_MISSING_REFERENCE_PICTURE                         0x00020000
+#define AVS2_ETCWARN_WRONG_TEMPORAL_ID                                 0x00040000
+#define AVS2_ETCWARN_ERROR_PICTURE_IS_REFERENCED                       0x00080000
+#define AVS2_ETCWARN_REF_WRONG_TEMPORAL_ID                             0x00080001
+#define AVS2_ETCWARN_SPS_ERROR                                         0x00080002
+
+/************************************************************************/
+/* WAVE5 ERROR ON ENCODER (ERR_INFO)                                    */
+/************************************************************************/
+
+/************************************************************************/
+/* WAVE5 WARNING ON ENCODER (WARN_INFO)                                 */
+/************************************************************************/
+#define WAVE5_ETCWARN_FORCED_SPLIT_BY_CU8X8                            0x000000001
+
+/************************************************************************/
+/* WAVE5 debug info (PRI_REASON)                                        */
+/************************************************************************/
+#define WAVE5_DEC_VCORE_VCE_HANGUP                                     0x0001
+#define WAVE5_DEC_VCORE_UNDETECTED_SYNTAX_ERR                          0x0002
+#define WAVE5_DEC_VCORE_MIB_BUSY                                       0x0003
+#define WAVE5_DEC_VCORE_VLC_BUSY                                       0x0004
+
+#endif /* ERROR_CODE_H_INCLUDED */
diff --git a/drivers/media/platform/chips-media/wave5/wave5.h b/drivers/media/platform/chips-media/wave5/wave5.h
new file mode 100644
index 000000000000..d3afb541e356
--- /dev/null
+++ b/drivers/media/platform/chips-media/wave5/wave5.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Wave5 series multi-standard codec IP - wave5 backend definitions
+ *
+ * Copyright (C) 2021 CHIPS&MEDIA INC
+ */
+
+#ifndef __WAVE5_FUNCTION_H__
+#define __WAVE5_FUNCTION_H__
+
+#define WAVE5_SUBSAMPLED_ONE_SIZE(_w, _h)	(ALIGN((_w) / 4, 16) * ALIGN((_h) / 4, 8))
+#define WAVE5_SUBSAMPLED_ONE_SIZE_AVC(_w, _h)	(ALIGN((_w) / 4, 32) * ALIGN((_h) / 4, 4))
+
+#define BSOPTION_ENABLE_EXPLICIT_END        BIT(0)
+
+#define WTL_RIGHT_JUSTIFIED          0
+#define WTL_LEFT_JUSTIFIED           1
+#define WTL_PIXEL_8BIT               0
+#define WTL_PIXEL_16BIT              1
+#define WTL_PIXEL_32BIT              2
+
+/* Mirror & rotation modes of the PRP (pre-processing) module */
+#define NONE_ROTATE		0x0
+#define ROT_CLOCKWISE_90	0x3
+#define ROT_CLOCKWISE_180	0x5
+#define ROT_CLOCKWISE_270	0x7
+#define MIR_HOR_FLIP		0x11
+#define MIR_VER_FLIP		0x9
+#define MIR_HOR_VER_FLIP	(MIR_HOR_FLIP | MIR_VER_FLIP)
+
+bool wave5_vpu_is_init(struct vpu_device *vpu_dev);
+
+unsigned int wave5_vpu_get_product_id(struct vpu_device *vpu_dev);
+
+void wave5_bit_issue_command(struct vpu_instance *inst, u32 cmd);
+
+int wave5_vpu_get_version(struct vpu_device *vpu_dev, u32 *revision);
+
+int wave5_vpu_init(struct device *dev, u8 *fw, size_t size);
+
+int wave5_vpu_reset(struct device *dev, enum sw_reset_mode reset_mode);
+
+int wave5_vpu_build_up_dec_param(struct vpu_instance *inst, struct dec_open_param *param);
+
+int wave5_vpu_dec_set_bitstream_flag(struct vpu_instance *inst, bool eos);
+
+int wave5_vpu_dec_register_framebuffer(struct vpu_instance *inst,
+				       struct frame_buffer *fb_arr, enum tiled_map_type map_type,
+				       unsigned int count);
+
+int wave5_vpu_re_init(struct device *dev, u8 *fw, size_t size);
+
+int wave5_vpu_dec_init_seq(struct vpu_instance *inst);
+
+int wave5_vpu_dec_get_seq_info(struct vpu_instance *inst, struct dec_initial_info *info);
+
+int wave5_vpu_decode(struct vpu_instance *inst, struct dec_param *option, u32 *fail_res);
+
+int wave5_vpu_dec_get_result(struct vpu_instance *inst, struct dec_output_info *result);
+
+int wave5_vpu_dec_finish_seq(struct vpu_instance *inst, u32 *fail_res);
+
+int wave5_dec_clr_disp_flag(struct vpu_instance *inst, unsigned int index);
+
+int wave5_dec_set_disp_flag(struct vpu_instance *inst, unsigned int index);
+
+int wave5_vpu_clear_interrupt(struct vpu_instance *inst, u32 flags);
+
+dma_addr_t wave5_vpu_dec_get_rd_ptr(struct vpu_instance *inst);
+
+int wave5_dec_set_rd_ptr(struct vpu_instance *inst, dma_addr_t addr);
+
+/***< WAVE5 encoder >******/
+
+int wave5_vpu_build_up_enc_param(struct device *dev, struct vpu_instance *inst,
+				 struct enc_open_param *open_param);
+
+int wave5_vpu_enc_init_seq(struct vpu_instance *inst);
+
+int wave5_vpu_enc_get_seq_info(struct vpu_instance *inst, struct enc_initial_info *info);
+
+int wave5_vpu_enc_register_framebuffer(struct device *dev, struct vpu_instance *inst,
+				       struct frame_buffer *fb_arr, enum tiled_map_type map_type,
+				       unsigned int count);
+
+int wave5_vpu_encode(struct vpu_instance *inst, struct enc_param *option, u32 *fail_res);
+
+int wave5_vpu_enc_get_result(struct vpu_instance *inst, struct enc_output_info *result);
+
+int wave5_vpu_enc_finish_seq(struct vpu_instance *inst, u32 *fail_res);
+
+int wave5_vpu_enc_check_open_param(struct vpu_instance *inst, struct enc_open_param *open_param);
+
+#endif /* __WAVE5_FUNCTION_H__ */
-- 
2.25.1

