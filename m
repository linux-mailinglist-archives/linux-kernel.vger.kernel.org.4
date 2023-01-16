Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FCD66BB67
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjAPKNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjAPKKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:10:21 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E12193C2;
        Mon, 16 Jan 2023 02:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673863791; x=1705399791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IuZb47x7TLyWcGpPQofPk+aIwiBojzXXw1Qi5d4/fhY=;
  b=if+riYTOvo902Kkg8wls1VsHHl/sVJ9lsxrR1+fjfjwpArELQaJlumDM
   o63MJ6StY3tolOR8LIxK5gS3PCHsqPsGGC4hC4Fxpgfq+0XtaKYcBuuYC
   nnF2NEoU4zgDjAMu3sEc12LgvQaAMtwKCvTmenkpj2W/Tt3IhXbrhZlRw
   yU3unTgE38dOUKub6J+hyObFoKKfBj0OBoZQVt83nKJUP8Su7M1gOo1Qv
   /j++M6GFexz0v0Lg6kjIkKmi1VbzerCpPXIPHqXhkKyHsMvJdbwzrMrUN
   fiIv0CRdTRJX1YFqjkmub6iwclY0Ut9em1qB55L2rUMrZXBwQ6vbw+jpg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="326489397"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="326489397"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 02:09:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="832785928"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="832785928"
Received: from xsanroma-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.39.155])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 02:09:47 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v6 11/11] fpga: m10bmc-sec: Add support for N6000
Date:   Mon, 16 Jan 2023 12:08:45 +0200
Message-Id: <20230116100845.6153-12-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com>
References: <20230116100845.6153-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for PMCI-based flash access path and N6000 sec update
support. Access to flash staging area is different for N6000 from that
of the SPI interfaced counterparts.

Introduce intel_m10bmc_flash_bulk_ops to allow interface specific
differentiations for the flash access path for sec update and make
m10bmc_sec_read/write() in sec update driver to use the new operations.
The .flash_mutex serializes read/read. Flash update (erase+write) must
use ->lock/unlock_write() to prevent reads during update (reads would
timeout on setting flash MUX as BMC will prevent it).

Create a type specific RSU status reg handler for N6000 because the
field has moved from doorbell to auth result register.

If a failure is detected while altering the flash MUX, it seems safer
to try to set it back and doesn't seem harmful. Likely there are enough
troubles in that case anyway so setting it back fails too (which is
harmless sans the small extra delay) or just confirms that the value
wasn't changed.

Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
Co-developed-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/fpga/intel-m10-bmc-sec-update.c |  51 ++++-
 drivers/mfd/intel-m10-bmc-pmci.c        | 242 +++++++++++++++++++++++-
 include/linux/mfd/intel-m10-bmc.h       |  51 +++++
 3 files changed, 336 insertions(+), 8 deletions(-)

diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
index 47c0d5c6a4a3..f0acedc80182 100644
--- a/drivers/fpga/intel-m10-bmc-sec-update.c
+++ b/drivers/fpga/intel-m10-bmc-sec-update.c
@@ -48,6 +48,9 @@ static int m10bmc_sec_write(struct m10bmc_sec *sec, const u8 *buf, u32 offset, u
 	u32 leftover_tmp = 0;
 	int ret;
 
+	if (sec->m10bmc->flash_bulk_ops)
+		return sec->m10bmc->flash_bulk_ops->write(m10bmc, buf, offset, size);
+
 	if (WARN_ON_ONCE(stride > sizeof(leftover_tmp)))
 		return -EINVAL;
 
@@ -78,6 +81,9 @@ static int m10bmc_sec_read(struct m10bmc_sec *sec, u8 *buf, u32 addr, u32 size)
 	u32 leftover_tmp;
 	int ret;
 
+	if (sec->m10bmc->flash_bulk_ops)
+		return sec->m10bmc->flash_bulk_ops->read(m10bmc, buf, addr, size);
+
 	if (WARN_ON_ONCE(stride > sizeof(leftover_tmp)))
 		return -EINVAL;
 
@@ -277,6 +283,19 @@ static int m10bmc_sec_n3000_rsu_status(struct m10bmc_sec *sec)
 	return FIELD_GET(DRBL_RSU_STATUS, doorbell);
 }
 
+static int m10bmc_sec_n6000_rsu_status(struct m10bmc_sec *sec)
+{
+	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
+	u32 auth_result;
+	int ret;
+
+	ret = m10bmc_sys_read(sec->m10bmc, csr_map->auth_result, &auth_result);
+	if (ret)
+		return ret;
+
+	return FIELD_GET(AUTH_RESULT_RSU_STATUS, auth_result);
+}
+
 static bool rsu_status_ok(u32 status)
 {
 	return (status == RSU_STAT_NORMAL ||
@@ -520,22 +539,33 @@ static enum fw_upload_err m10bmc_sec_prepare(struct fw_upload *fwl,
 	if (!size || size > M10BMC_STAGING_SIZE)
 		return FW_UPLOAD_ERR_INVALID_SIZE;
 
+	if (sec->m10bmc->flash_bulk_ops)
+		if (sec->m10bmc->flash_bulk_ops->lock_write(sec->m10bmc))
+			return FW_UPLOAD_ERR_BUSY;
+
 	ret = rsu_check_idle(sec);
 	if (ret != FW_UPLOAD_ERR_NONE)
-		return ret;
+		goto unlock_flash;
 
 	ret = rsu_update_init(sec);
 	if (ret != FW_UPLOAD_ERR_NONE)
-		return ret;
+		goto unlock_flash;
 
 	ret = rsu_prog_ready(sec);
 	if (ret != FW_UPLOAD_ERR_NONE)
-		return ret;
+		goto unlock_flash;
 
-	if (sec->cancel_request)
-		return rsu_cancel(sec);
+	if (sec->cancel_request) {
+		ret = rsu_cancel(sec);
+		goto unlock_flash;
+	}
 
 	return FW_UPLOAD_ERR_NONE;
+
+unlock_flash:
+	if (sec->m10bmc->flash_bulk_ops)
+		sec->m10bmc->flash_bulk_ops->unlock_write(sec->m10bmc);
+	return ret;
 }
 
 #define WRITE_BLOCK_SIZE 0x4000	/* Default write-block size is 0x4000 bytes */
@@ -622,6 +652,9 @@ static void m10bmc_sec_cleanup(struct fw_upload *fwl)
 	struct m10bmc_sec *sec = fwl->dd_handle;
 
 	(void)rsu_cancel(sec);
+
+	if (sec->m10bmc->flash_bulk_ops)
+		sec->m10bmc->flash_bulk_ops->unlock_write(sec->m10bmc);
 }
 
 static const struct fw_upload_ops m10bmc_ops = {
@@ -636,6 +669,10 @@ static const struct m10bmc_sec_ops m10sec_n3000_ops = {
 	.rsu_status = m10bmc_sec_n3000_rsu_status,
 };
 
+static const struct m10bmc_sec_ops m10sec_n6000_ops = {
+	.rsu_status = m10bmc_sec_n6000_rsu_status,
+};
+
 #define SEC_UPDATE_LEN_MAX 32
 static int m10bmc_sec_probe(struct platform_device *pdev)
 {
@@ -705,6 +742,10 @@ static const struct platform_device_id intel_m10bmc_sec_ids[] = {
 		.name = "d5005bmc-sec-update",
 		.driver_data = (kernel_ulong_t)&m10sec_n3000_ops,
 	},
+	{
+		.name = "n6000bmc-sec-update",
+		.driver_data = (kernel_ulong_t)&m10sec_n6000_ops,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, intel_m10bmc_sec_ids);
diff --git a/drivers/mfd/intel-m10-bmc-pmci.c b/drivers/mfd/intel-m10-bmc-pmci.c
index 975019f644b5..8821f1876dd6 100644
--- a/drivers/mfd/intel-m10-bmc-pmci.c
+++ b/drivers/mfd/intel-m10-bmc-pmci.c
@@ -6,16 +6,20 @@
  * Copyright (C) 2020-2023 Intel Corporation.
  */
 
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/dfl.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/intel-m10-bmc.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 
 struct m10bmc_pmci_device {
 	void __iomem *base;
 	struct intel_m10bmc m10bmc;
+	struct mutex flash_mutex;	/* protects flash_busy and serializes flash read/read */
+	bool flash_busy;
 };
 
 /*
@@ -114,6 +118,215 @@ static int indirect_reg_write(void *context, unsigned int reg, unsigned int val)
 	return ret2;
 }
 
+static void pmci_write_fifo(void __iomem *base, const u32 *buf, size_t count)
+{
+	while (count--)
+		writel(*buf++, base);
+}
+
+static void pmci_read_fifo(void __iomem *base, u32 *buf, size_t count)
+{
+	while (count--)
+		*buf++ = readl(base);
+}
+
+static u32 pmci_get_write_space(struct m10bmc_pmci_device *pmci)
+{
+	u32 val;
+	int ret;
+
+	ret = read_poll_timeout(readl, val,
+				FIELD_GET(M10BMC_N6000_FLASH_FIFO_SPACE, val) ==
+				M10BMC_N6000_FIFO_MAX_WORDS,
+				M10BMC_FLASH_INT_US, M10BMC_FLASH_TIMEOUT_US,
+				false, pmci->base + M10BMC_N6000_FLASH_CTRL);
+	if (ret == -ETIMEDOUT)
+		return 0;
+
+	return FIELD_GET(M10BMC_N6000_FLASH_FIFO_SPACE, val) * M10BMC_N6000_FIFO_WORD_SIZE;
+}
+
+static int pmci_flash_bulk_write(struct intel_m10bmc *m10bmc, const u8 *buf, u32 size)
+{
+	struct m10bmc_pmci_device *pmci = container_of(m10bmc, struct m10bmc_pmci_device, m10bmc);
+	u32 blk_size, offset = 0, write_count;
+
+	while (size) {
+		blk_size = min(pmci_get_write_space(pmci), size);
+		if (blk_size == 0) {
+			dev_err(m10bmc->dev, "get FIFO available size fail\n");
+			return -EIO;
+		}
+
+		if (size < M10BMC_N6000_FIFO_WORD_SIZE)
+			break;
+
+		write_count = blk_size / M10BMC_N6000_FIFO_WORD_SIZE;
+		pmci_write_fifo(pmci->base + M10BMC_N6000_FLASH_FIFO,
+				(u32 *)(buf + offset), write_count);
+
+		size -= blk_size;
+		offset += blk_size;
+	}
+
+	/* Handle remainder (less than M10BMC_N6000_FIFO_WORD_SIZE bytes) */
+	if (size) {
+		u32 tmp = 0;
+
+		memcpy(&tmp, buf + offset, size);
+		pmci_write_fifo(pmci->base + M10BMC_N6000_FLASH_FIFO, &tmp, 1);
+	}
+
+	return 0;
+}
+
+static int pmci_flash_bulk_read(struct intel_m10bmc *m10bmc, u8 *buf, u32 addr, u32 size)
+{
+	struct m10bmc_pmci_device *pmci = container_of(m10bmc, struct m10bmc_pmci_device, m10bmc);
+	u32 blk_size, offset = 0, val, full_read_count, read_count;
+	int ret;
+
+	while (size) {
+		blk_size = min_t(u32, size, M10BMC_N6000_READ_BLOCK_SIZE);
+		full_read_count = blk_size / M10BMC_N6000_FIFO_WORD_SIZE;
+
+		read_count = full_read_count;
+		if (full_read_count * M10BMC_N6000_FIFO_WORD_SIZE < blk_size)
+			read_count++;
+
+		writel(addr + offset, pmci->base + M10BMC_N6000_FLASH_ADDR);
+		writel(FIELD_PREP(M10BMC_N6000_FLASH_READ_COUNT, read_count) |
+		       M10BMC_N6000_FLASH_RD_MODE,
+		       pmci->base + M10BMC_N6000_FLASH_CTRL);
+
+		ret = readl_poll_timeout((pmci->base + M10BMC_N6000_FLASH_CTRL), val,
+					 !(val & M10BMC_N6000_FLASH_BUSY),
+					 M10BMC_FLASH_INT_US, M10BMC_FLASH_TIMEOUT_US);
+		if (ret) {
+			dev_err(m10bmc->dev, "read timed out on reading flash 0x%xn", val);
+			return ret;
+		}
+
+		pmci_read_fifo(pmci->base + M10BMC_N6000_FLASH_FIFO,
+			       (u32 *)(buf + offset), full_read_count);
+
+		size -= blk_size;
+		offset += blk_size;
+
+		if (full_read_count < read_count)
+			break;
+
+		writel(0, pmci->base + M10BMC_N6000_FLASH_CTRL);
+	}
+
+	/* Handle remainder (less than M10BMC_N6000_FIFO_WORD_SIZE bytes) */
+	if (size) {
+		u32 tmp;
+
+		pmci_read_fifo(pmci->base + M10BMC_N6000_FLASH_FIFO, &tmp, 1);
+		memcpy(buf + offset, &tmp, size);
+
+		writel(0, pmci->base + M10BMC_N6000_FLASH_CTRL);
+	}
+
+	return 0;
+}
+
+static int m10bmc_pmci_set_flash_host_mux(struct intel_m10bmc *m10bmc, bool request)
+{
+	u32 ctrl;
+	int ret;
+
+	ret = regmap_update_bits(m10bmc->regmap, M10BMC_N6000_FLASH_MUX_CTRL,
+				 M10BMC_N6000_FLASH_HOST_REQUEST,
+				 FIELD_PREP(M10BMC_N6000_FLASH_HOST_REQUEST, request));
+	if (ret)
+		return ret;
+
+	return regmap_read_poll_timeout(m10bmc->regmap,
+					M10BMC_N6000_FLASH_MUX_CTRL, ctrl,
+					request ?
+					(get_flash_mux(ctrl) == M10BMC_N6000_FLASH_MUX_HOST) :
+					(get_flash_mux(ctrl) != M10BMC_N6000_FLASH_MUX_HOST),
+					M10BMC_FLASH_INT_US, M10BMC_FLASH_TIMEOUT_US);
+}
+
+static int m10bmc_pmci_flash_read(struct intel_m10bmc *m10bmc, u8 *buf, u32 addr, u32 size)
+{
+	struct m10bmc_pmci_device *pmci = container_of(m10bmc, struct m10bmc_pmci_device, m10bmc);
+	int ret, ret2;
+
+	mutex_lock(&pmci->flash_mutex);
+	if (pmci->flash_busy) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	ret = m10bmc_pmci_set_flash_host_mux(m10bmc, true);
+	if (ret)
+		goto mux_fail;
+
+	ret = pmci_flash_bulk_read(m10bmc, buf, addr, size);
+
+mux_fail:
+	ret2 = m10bmc_pmci_set_flash_host_mux(m10bmc, false);
+
+unlock:
+	mutex_unlock(&pmci->flash_mutex);
+	if (ret)
+		return ret;
+	return ret2;
+}
+
+static int m10bmc_pmci_flash_write(struct intel_m10bmc *m10bmc, const u8 *buf, u32 offset, u32 size)
+{
+	struct m10bmc_pmci_device *pmci = container_of(m10bmc, struct m10bmc_pmci_device, m10bmc);
+	int ret;
+
+	mutex_lock(&pmci->flash_mutex);
+	WARN_ON_ONCE(!pmci->flash_busy);
+	/* On write, firmware manages flash MUX */
+	ret = pmci_flash_bulk_write(m10bmc, buf + offset, size);
+	mutex_unlock(&pmci->flash_mutex);
+
+	return ret;
+}
+
+static int m10bmc_pmci_flash_lock(struct intel_m10bmc *m10bmc)
+{
+	struct m10bmc_pmci_device *pmci = container_of(m10bmc, struct m10bmc_pmci_device, m10bmc);
+	int ret = 0;
+
+	mutex_lock(&pmci->flash_mutex);
+	if (pmci->flash_busy) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	pmci->flash_busy = true;
+
+unlock:
+	mutex_unlock(&pmci->flash_mutex);
+	return ret;
+}
+
+static void m10bmc_pmci_flash_unlock(struct intel_m10bmc *m10bmc)
+{
+	struct m10bmc_pmci_device *pmci = container_of(m10bmc, struct m10bmc_pmci_device, m10bmc);
+
+	mutex_lock(&pmci->flash_mutex);
+	WARN_ON_ONCE(!pmci->flash_busy);
+	pmci->flash_busy = false;
+	mutex_unlock(&pmci->flash_mutex);
+}
+
+static const struct intel_m10bmc_flash_bulk_ops m10bmc_pmci_flash_bulk_ops = {
+	.read = m10bmc_pmci_flash_read,
+	.write = m10bmc_pmci_flash_write,
+	.lock_write = m10bmc_pmci_flash_lock,
+	.unlock_write = m10bmc_pmci_flash_unlock,
+};
+
 static const struct regmap_range m10bmc_pmci_regmap_range[] = {
 	regmap_reg_range(M10BMC_N6000_SYS_BASE, M10BMC_N6000_SYS_END),
 };
@@ -136,6 +349,7 @@ static struct regmap_config m10bmc_pmci_regmap_config = {
 
 static struct mfd_cell m10bmc_pmci_n6000_bmc_subdevs[] = {
 	{ .name = "n6000bmc-hwmon" },
+	{ .name = "n6000bmc-sec-update" },
 };
 
 static const struct m10bmc_csr_map m10bmc_n6000_csr_map = {
@@ -169,11 +383,13 @@ static int m10bmc_pmci_probe(struct dfl_device *ddev)
 	struct device *dev = &ddev->dev;
 	struct m10bmc_pmci_device *pmci;
 	struct indirect_ctx *ctx;
+	int ret;
 
 	pmci = devm_kzalloc(dev, sizeof(*pmci), GFP_KERNEL);
 	if (!pmci)
 		return -ENOMEM;
 
+	pmci->m10bmc.flash_bulk_ops = &m10bmc_pmci_flash_bulk_ops;
 	pmci->m10bmc.dev = dev;
 
 	pmci->base = devm_ioremap_resource(dev, &ddev->mmio_res);
@@ -184,15 +400,34 @@ static int m10bmc_pmci_probe(struct dfl_device *ddev)
 	if (!ctx)
 		return -ENOMEM;
 
+	mutex_init(&pmci->flash_mutex);
+
 	ctx->base = pmci->base + M10BMC_N6000_INDIRECT_BASE;
 	ctx->dev = dev;
 	indirect_clear_cmd(ctx);
 	pmci->m10bmc.regmap = devm_regmap_init(dev, NULL, ctx, &m10bmc_pmci_regmap_config);
 
-	if (IS_ERR(pmci->m10bmc.regmap))
-		return PTR_ERR(pmci->m10bmc.regmap);
+	if (IS_ERR(pmci->m10bmc.regmap)) {
+		ret = PTR_ERR(pmci->m10bmc.regmap);
+		goto destroy_mutex;
+	}
+
+	ret = m10bmc_dev_init(&pmci->m10bmc, &m10bmc_pmci_n6000);
+	if (ret)
+		goto destroy_mutex;
+	return 0;
+
+destroy_mutex:
+	mutex_destroy(&pmci->flash_mutex);
+	return ret;
+}
+
+static void m10bmc_pmci_remove(struct dfl_device *ddev)
+{
+	struct intel_m10bmc *m10bmc = dev_get_drvdata(&ddev->dev);
+	struct m10bmc_pmci_device *pmci = container_of(m10bmc, struct m10bmc_pmci_device, m10bmc);
 
-	return m10bmc_dev_init(&pmci->m10bmc, &m10bmc_pmci_n6000);
+	mutex_destroy(&pmci->flash_mutex);
 }
 
 #define FME_FEATURE_ID_M10BMC_PMCI	0x12
@@ -210,6 +445,7 @@ static struct dfl_driver m10bmc_pmci_driver = {
 	},
 	.id_table = m10bmc_pmci_ids,
 	.probe    = m10bmc_pmci_probe,
+	.remove   = m10bmc_pmci_remove,
 };
 
 module_dfl_driver(m10bmc_pmci_driver);
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index 810534b1bd12..1812ebfa11a8 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -127,6 +127,7 @@
 
 #define M10BMC_N6000_DOORBELL			0x1c0
 #define M10BMC_N6000_AUTH_RESULT		0x1c4
+#define AUTH_RESULT_RSU_STATUS			GENMASK(23, 16)
 
 #define M10BMC_N6000_BUILD_VER			0x0
 #define NIOS2_N6000_FW_VERSION			0x4
@@ -148,6 +149,35 @@
 
 #define M10BMC_N6000_STAGING_FLASH_COUNT	0x7ff5000
 
+#define M10BMC_N6000_FLASH_MUX_CTRL		0x1d0
+#define M10BMC_N6000_FLASH_MUX_SELECTION	GENMASK(2, 0)
+#define M10BMC_N6000_FLASH_MUX_IDLE		0
+#define M10BMC_N6000_FLASH_MUX_NIOS		1
+#define M10BMC_N6000_FLASH_MUX_HOST		2
+#define M10BMC_N6000_FLASH_MUX_PFL		4
+#define get_flash_mux(mux)			FIELD_GET(M10BMC_N6000_FLASH_MUX_SELECTION, mux)
+
+#define M10BMC_N6000_FLASH_NIOS_REQUEST		BIT(4)
+#define M10BMC_N6000_FLASH_HOST_REQUEST		BIT(5)
+
+#define M10BMC_N6000_FLASH_CTRL			0x40
+#define M10BMC_N6000_FLASH_WR_MODE		BIT(0)
+#define M10BMC_N6000_FLASH_RD_MODE		BIT(1)
+#define M10BMC_N6000_FLASH_BUSY			BIT(2)
+#define M10BMC_N6000_FLASH_FIFO_SPACE		GENMASK(13, 4)
+#define M10BMC_N6000_FLASH_READ_COUNT		GENMASK(25, 16)
+
+#define M10BMC_N6000_FLASH_ADDR			0x44
+#define M10BMC_N6000_FLASH_FIFO			0x800
+#define M10BMC_N6000_READ_BLOCK_SIZE		0x800
+#define M10BMC_N6000_FIFO_MAX_BYTES		0x800
+#define M10BMC_N6000_FIFO_WORD_SIZE		4
+#define M10BMC_N6000_FIFO_MAX_WORDS		(M10BMC_N6000_FIFO_MAX_BYTES / \
+						 M10BMC_N6000_FIFO_WORD_SIZE)
+
+#define M10BMC_FLASH_INT_US			1
+#define M10BMC_FLASH_TIMEOUT_US			10000
+
 /**
  * struct m10bmc_csr_map - Intel MAX 10 BMC CSR register map
  */
@@ -183,16 +213,37 @@ struct intel_m10bmc_platform_info {
 	const struct m10bmc_csr_map *csr_map;
 };
 
+struct intel_m10bmc;
+
+/**
+ * struct intel_m10bmc_flash_bulk_ops - device specific operations for flash R/W
+ * @read: read a block of data from flash
+ * @write: write a block of data to flash
+ * @lock_write: locks flash access for erase+write
+ * @unlock_write: unlock flash access
+ *
+ * Write must be protected with @lock_write and @unlock_write. While the flash
+ * is locked, @read returns -EBUSY.
+ */
+struct intel_m10bmc_flash_bulk_ops {
+	int (*read)(struct intel_m10bmc *m10bmc, u8 *buf, u32 addr, u32 size);
+	int (*write)(struct intel_m10bmc *m10bmc, const u8 *buf, u32 offset, u32 size);
+	int (*lock_write)(struct intel_m10bmc *m10bmc);
+	void (*unlock_write)(struct intel_m10bmc *m10bmc);
+};
+
 /**
  * struct intel_m10bmc - Intel MAX 10 BMC parent driver data structure
  * @dev: this device
  * @regmap: the regmap used to access registers by m10bmc itself
  * @info: the platform information for MAX10 BMC
+ * @flash_bulk_ops: optional device specific operations for flash R/W
  */
 struct intel_m10bmc {
 	struct device *dev;
 	struct regmap *regmap;
 	const struct intel_m10bmc_platform_info *info;
+	const struct intel_m10bmc_flash_bulk_ops *flash_bulk_ops;
 };
 
 /*
-- 
2.30.2

