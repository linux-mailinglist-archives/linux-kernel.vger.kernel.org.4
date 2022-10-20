Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BA8606619
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJTQqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJTQpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:45:38 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B96147BAC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:45:34 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id g10so215148oif.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kDe4jxOa6ATqemfDuPDr+Qi6HC6QVhkDnPC1IPo6CM=;
        b=Z131P7SWVNJXtYteVWRSNP5vtIyZvXhKQbkhHrB4ODeriFSFs2AHqdPpIHCjvtsY2P
         u5WpdC1v6NvCDSa0h0mKnGBEzFXSTeuCVwCGYz7EUSAH+GFuvuc/YUAfchhFBTwdLbX7
         KJWXBba+PTvhrlA3wSY4RQacZz1xtH/0d6pOVrrW1EUkSDdGvQfimcptjDCqGSCDP7n+
         /mjrTMkXDH2IPdQ4evPGzgpsS3TIzJv+iUDFXK/HDLha5d/V8NQ32Mex4eBd+CQznhkE
         9y1g/uB+MRsDOAQeSpd2o2NGK97RJSmL87SOOW14HxAK3NuH8TxjOl2QRHPeZCf/BhY1
         TL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kDe4jxOa6ATqemfDuPDr+Qi6HC6QVhkDnPC1IPo6CM=;
        b=hzg6KHc3hktJDACnAYXwObrAg3F1X/O0YNt0Pp8jH/OvE+e7RSjSrXdvQa1S86m0py
         le23qy/CpBYpvIMTm4O7dWfb2xvJcbCJhrezA1vyo4w7QxCwBt+MNHBDIy+W7GkClPg7
         spxBBddioKw8pYogphzDX/Qat2xFRf7o+9CKuIl+ho7M5AYTM6YA74/x4YwVC9HREkyN
         JgqTf3vITbs6rW2vAHLs4Pvf7hHgrCgfHs5dklcNrHGowc5XizLSuBg1lo6Fg5PZ6eBO
         cHkLvACfBaI0r1Cd3UwPWg4GQ3dO1VFhwhqfx97GZFpMQ7vZv2/R1SZ69bvUwKR4ZypK
         b42A==
X-Gm-Message-State: ACrzQf2k4E3bAFDv2WxNQpNN8PpCJEfO5Fa4wNhrQX7mmZ2pPhuN2iyu
        w7Z5wl7b/BIxf4UbMVbUPey0yY7gkb5mdw==
X-Google-Smtp-Source: AMsMyM4cGEJ2/C9Vsu/CnbUlJpyDqjW2cfuq/o+29Z0hS8+JU/sAFgYxKCeqtoHasqup8/JNEafTTg==
X-Received: by 2002:a05:6808:60a:b0:355:50f8:1743 with SMTP id y10-20020a056808060a00b0035550f81743mr7674174oih.125.1666284334056;
        Thu, 20 Oct 2022 09:45:34 -0700 (PDT)
Received: from fedora.. ([186.122.181.28])
        by smtp.gmail.com with ESMTPSA id u3-20020a056870d58300b0011f00b027bdsm9154325oao.45.2022.10.20.09.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 09:45:33 -0700 (PDT)
From:   Mauro Lima <mauro.lima@eclypsium.com>
To:     broonie@kernel.org
Cc:     mika.westerberg@linux.intel.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mauro Lima <mauro.lima@eclypsium.com>
Subject: [PATCH 1/2] spi: intel-spi: Move software sequencing logic outside the core
Date:   Thu, 20 Oct 2022 13:45:07 -0300
Message-Id: <20221020164508.29182-2-mauro.lima@eclypsium.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221020164508.29182-1-mauro.lima@eclypsium.com>
References: <20221020164508.29182-1-mauro.lima@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move out the software sequencing logic from the core. Keep the
functionality without changes.

Signed-off-by: Mauro Lima <mauro.lima@eclypsium.com>
---
 drivers/spi/Makefile           |   2 +-
 drivers/spi/spi-intel-common.h | 171 +++++++++++++++++
 drivers/spi/spi-intel-swseq.c  | 181 ++++++++++++++++++
 drivers/spi/spi-intel-swseq.h  |  23 +++
 drivers/spi/spi-intel.c        | 326 +++------------------------------
 5 files changed, 401 insertions(+), 302 deletions(-)
 create mode 100644 drivers/spi/spi-intel-common.h
 create mode 100644 drivers/spi/spi-intel-swseq.c
 create mode 100644 drivers/spi/spi-intel-swseq.h

diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 4b34e855c841..47ebb6ec084e 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -63,7 +63,7 @@ obj-$(CONFIG_SPI_HISI_SFC_V3XX)		+= spi-hisi-sfc-v3xx.o
 obj-$(CONFIG_SPI_IMG_SPFI)		+= spi-img-spfi.o
 obj-$(CONFIG_SPI_IMX)			+= spi-imx.o
 obj-$(CONFIG_SPI_INGENIC)		+= spi-ingenic.o
-obj-$(CONFIG_SPI_INTEL)			+= spi-intel.o
+obj-$(CONFIG_SPI_INTEL)			+= spi-intel.o spi-intel-swseq.o
 obj-$(CONFIG_SPI_INTEL_PCI)		+= spi-intel-pci.o
 obj-$(CONFIG_SPI_INTEL_PLATFORM)	+= spi-intel-platform.o
 obj-$(CONFIG_SPI_LANTIQ_SSC)		+= spi-lantiq-ssc.o
diff --git a/drivers/spi/spi-intel-common.h b/drivers/spi/spi-intel-common.h
new file mode 100644
index 000000000000..32dd75a1ea30
--- /dev/null
+++ b/drivers/spi/spi-intel-common.h
@@ -0,0 +1,171 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Intel PCH/PCU SPI flash driver.
+ *
+ * Copyright (C) 2016 - 2022, Intel Corporation
+ * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
+ */
+
+#ifndef SPI_INTEL_COMMON_H
+#define SPI_INTEL_COMMON_H
+
+#include <linux/spi/spi-mem.h>
+#include <linux/mtd/spi-nor.h>
+
+/* Offsets are from @ispi->base */
+#define BFPREG				0x00
+
+#define HSFSTS_CTL			0x04
+#define HSFSTS_CTL_FSMIE		BIT(31)
+#define HSFSTS_CTL_FDBC_SHIFT		24
+#define HSFSTS_CTL_FDBC_MASK		(0x3f << HSFSTS_CTL_FDBC_SHIFT)
+
+#define HSFSTS_CTL_FCYCLE_SHIFT		17
+#define HSFSTS_CTL_FCYCLE_MASK		(0x0f << HSFSTS_CTL_FCYCLE_SHIFT)
+/* HW sequencer opcodes */
+#define HSFSTS_CTL_FCYCLE_READ		(0x00 << HSFSTS_CTL_FCYCLE_SHIFT)
+#define HSFSTS_CTL_FCYCLE_WRITE		(0x02 << HSFSTS_CTL_FCYCLE_SHIFT)
+#define HSFSTS_CTL_FCYCLE_ERASE		(0x03 << HSFSTS_CTL_FCYCLE_SHIFT)
+#define HSFSTS_CTL_FCYCLE_ERASE_64K	(0x04 << HSFSTS_CTL_FCYCLE_SHIFT)
+#define HSFSTS_CTL_FCYCLE_RDID		(0x06 << HSFSTS_CTL_FCYCLE_SHIFT)
+#define HSFSTS_CTL_FCYCLE_WRSR		(0x07 << HSFSTS_CTL_FCYCLE_SHIFT)
+#define HSFSTS_CTL_FCYCLE_RDSR		(0x08 << HSFSTS_CTL_FCYCLE_SHIFT)
+
+#define HSFSTS_CTL_FGO			BIT(16)
+#define HSFSTS_CTL_FLOCKDN		BIT(15)
+#define HSFSTS_CTL_FDV			BIT(14)
+#define HSFSTS_CTL_SCIP			BIT(5)
+#define HSFSTS_CTL_AEL			BIT(2)
+#define HSFSTS_CTL_FCERR		BIT(1)
+#define HSFSTS_CTL_FDONE		BIT(0)
+
+#define FADDR				0x08
+#define DLOCK				0x0c
+#define FDATA(n)			(0x10 + ((n) * 4))
+
+#define FRACC				0x50
+
+#define FREG(n)				(0x54 + ((n) * 4))
+#define FREG_BASE_MASK			0x3fff
+#define FREG_LIMIT_SHIFT		16
+#define FREG_LIMIT_MASK			(0x03fff << FREG_LIMIT_SHIFT)
+
+/* Offset is from @ispi->pregs */
+#define PR(n)				((n) * 4)
+#define PR_WPE				BIT(31)
+#define PR_LIMIT_SHIFT			16
+#define PR_LIMIT_MASK			(0x3fff << PR_LIMIT_SHIFT)
+#define PR_RPE				BIT(15)
+#define PR_BASE_MASK			0x3fff
+
+/* Offsets are from @ispi->sregs */
+#define SSFSTS_CTL			0x00
+#define SSFSTS_CTL_FSMIE		BIT(23)
+#define SSFSTS_CTL_DS			BIT(22)
+#define SSFSTS_CTL_DBC_SHIFT		16
+#define SSFSTS_CTL_SPOP			BIT(11)
+#define SSFSTS_CTL_ACS			BIT(10)
+#define SSFSTS_CTL_SCGO			BIT(9)
+#define SSFSTS_CTL_COP_SHIFT		12
+#define SSFSTS_CTL_FRS			BIT(7)
+#define SSFSTS_CTL_DOFRS		BIT(6)
+#define SSFSTS_CTL_AEL			BIT(4)
+#define SSFSTS_CTL_FCERR		BIT(3)
+#define SSFSTS_CTL_FDONE		BIT(2)
+#define SSFSTS_CTL_SCIP			BIT(0)
+
+#define PREOP_OPTYPE			0x04
+#define OPMENU0				0x08
+#define OPMENU1				0x0c
+
+#define OPTYPE_READ_NO_ADDR		0
+#define OPTYPE_WRITE_NO_ADDR		1
+#define OPTYPE_READ_WITH_ADDR		2
+#define OPTYPE_WRITE_WITH_ADDR		3
+
+/* CPU specifics */
+#define BYT_PR				0x74
+#define BYT_SSFSTS_CTL			0x90
+#define BYT_FREG_NUM			5
+#define BYT_PR_NUM			5
+
+#define LPT_PR				0x74
+#define LPT_SSFSTS_CTL			0x90
+#define LPT_FREG_NUM			5
+#define LPT_PR_NUM			5
+
+#define BXT_PR				0x84
+#define BXT_SSFSTS_CTL			0xa0
+#define BXT_FREG_NUM			12
+#define BXT_PR_NUM			6
+
+#define CNL_PR				0x84
+#define CNL_FREG_NUM			6
+#define CNL_PR_NUM			5
+
+#define LVSCC				0xc4
+#define UVSCC				0xc8
+#define ERASE_OPCODE_SHIFT		8
+#define ERASE_OPCODE_MASK		(0xff << ERASE_OPCODE_SHIFT)
+#define ERASE_64K_OPCODE_SHIFT		16
+#define ERASE_64K_OPCODE_MASK		(0xff << ERASE_OPCODE_SHIFT)
+
+/* Flash descriptor fields */
+#define FLVALSIG_MAGIC			0x0ff0a55a
+#define FLMAP0_NC_MASK			GENMASK(9, 8)
+#define FLMAP0_NC_SHIFT			8
+#define FLMAP0_FCBA_MASK		GENMASK(7, 0)
+
+#define FLCOMP_C0DEN_MASK		GENMASK(3, 0)
+#define FLCOMP_C0DEN_512K		0x00
+#define FLCOMP_C0DEN_1M			0x01
+#define FLCOMP_C0DEN_2M			0x02
+#define FLCOMP_C0DEN_4M			0x03
+#define FLCOMP_C0DEN_8M			0x04
+#define FLCOMP_C0DEN_16M		0x05
+#define FLCOMP_C0DEN_32M		0x06
+#define FLCOMP_C0DEN_64M		0x07
+
+#define INTEL_SPI_TIMEOUT		5000 /* ms */
+#define INTEL_SPI_FIFO_SZ		64
+
+/**
+ * struct intel_spi - Driver private data
+ * @dev: Device pointer
+ * @info: Pointer to board specific info
+ * @base: Beginning of MMIO space
+ * @pregs: Start of protection registers
+ * @sregs: Start of software sequencer registers
+ * @master: Pointer to the SPI controller structure
+ * @nregions: Maximum number of regions
+ * @pr_num: Maximum number of protected range registers
+ * @chip0_size: Size of the first flash chip in bytes
+ * @locked: Is SPI setting locked
+ * @swseq_reg: Use SW sequencer in register reads/writes
+ * @swseq_erase: Use SW sequencer in erase operation
+ * @swseq_enabled: SW sequencer enabled to use
+ * @atomic_preopcode: Holds preopcode when atomic sequence is requested
+ * @opcodes: Opcodes which are supported. This are programmed by BIOS
+ *           before it locks down the controller.
+ * @mem_ops: Pointer to SPI MEM ops supported by the controller
+ */
+struct intel_spi {
+	struct device *dev;
+	const struct intel_spi_boardinfo *info;
+	void __iomem *base;
+	void __iomem *pregs;
+	void __iomem *sregs;
+	struct spi_controller *master;
+	size_t nregions;
+	size_t pr_num;
+	size_t chip0_size;
+	bool locked;
+	bool swseq_reg;
+	bool swseq_erase;
+	bool swseq_enabled;
+	u8 atomic_preopcode;
+	u8 opcodes[8];
+	const struct intel_spi_mem_op *mem_ops;
+};
+
+#endif /* SPI_INTEL_COMMON_H */
diff --git a/drivers/spi/spi-intel-swseq.c b/drivers/spi/spi-intel-swseq.c
new file mode 100644
index 000000000000..2597aa06a160
--- /dev/null
+++ b/drivers/spi/spi-intel-swseq.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel PCH/PCU SPI flash driver.
+ *
+ * Copyright (C) 2016 - 2022, Intel Corporation
+ * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
+ */
+
+#include <linux/iopoll.h>
+
+#include "spi-intel.h"
+#include "spi-intel-common.h"
+#include "spi-intel-swseq.h"
+
+bool mem_op_supported_on_spi_locked(const struct intel_spi *ispi,
+				    const struct spi_mem_op *op)
+{
+	int i;
+
+	/* Check if it is in the locked opcodes list */
+	for (i = 0; i < ARRAY_SIZE(ispi->opcodes); i++) {
+		if (ispi->opcodes[i] == op->cmd.opcode)
+			return true;
+	}
+
+	dev_dbg(ispi->dev, "%#x not supported\n", op->cmd.opcode);
+	return false;
+}
+EXPORT_SYMBOL(mem_op_supported_on_spi_locked);
+
+inline bool is_swseq_enabled(void)
+{
+	return true;
+}
+EXPORT_SYMBOL(is_swseq_enabled);
+
+int handle_swseq_wren(struct intel_spi *ispi)
+{
+	u16 preop;
+	const u8 opcode = SPINOR_OP_WREN;
+
+	if (!ispi->swseq_reg)
+		return 0;
+
+	preop = readw(ispi->sregs + PREOP_OPTYPE);
+	if ((preop & 0xff) != SPINOR_OP_WREN && (preop >> 8) != SPINOR_OP_WREN) {
+		if (ispi->locked)
+			return -EINVAL;
+		writel(opcode, ispi->sregs + PREOP_OPTYPE);
+	}
+
+	/*
+	 * This enables atomic sequence on next SW sycle. Will
+	 * be cleared after next operation.
+	*/
+	ispi->atomic_preopcode = opcode;
+	return 0;
+}
+EXPORT_SYMBOL(handle_swseq_wren);
+
+static int intel_spi_wait_sw_busy(const struct intel_spi *ispi)
+{
+	u32 val;
+
+	return readl_poll_timeout(ispi->sregs + SSFSTS_CTL, val,
+				  !(val & SSFSTS_CTL_SCIP), 0,
+				  INTEL_SPI_TIMEOUT * 1000);
+}
+
+static int intel_spi_opcode_index(const struct intel_spi *ispi, u8 opcode, int optype)
+{
+	int i;
+	int preop;
+
+	if (ispi->locked) {
+		for (i = 0; i < ARRAY_SIZE(ispi->opcodes); i++)
+			if (ispi->opcodes[i] == opcode)
+				return i;
+
+		return -EINVAL;
+	}
+
+	/* The lock is off, so just use index 0 */
+	writel(opcode, ispi->sregs + OPMENU0);
+	preop = readw(ispi->sregs + PREOP_OPTYPE);
+	writel(optype << 16 | preop, ispi->sregs + PREOP_OPTYPE);
+
+	return 0;
+}
+
+int intel_spi_sw_cycle(struct intel_spi *ispi, u8 opcode, size_t len,
+		       int optype)
+{
+	u32 val = 0, status;
+	u8 atomic_preopcode;
+	int ret;
+
+	ret = intel_spi_opcode_index(ispi, opcode, optype);
+	if (ret < 0)
+		return ret;
+
+	if (len > INTEL_SPI_FIFO_SZ)
+		return -EINVAL;
+
+	/*
+	 * Always clear it after each SW sequencer operation regardless
+	 * of whether it is successful or not.
+	 */
+	atomic_preopcode = ispi->atomic_preopcode;
+	ispi->atomic_preopcode = 0;
+
+	/* Only mark 'Data Cycle' bit when there is data to be transferred */
+	if (len > 0)
+		val = ((len - 1) << SSFSTS_CTL_DBC_SHIFT) | SSFSTS_CTL_DS;
+	val |= ret << SSFSTS_CTL_COP_SHIFT;
+	val |= SSFSTS_CTL_FCERR | SSFSTS_CTL_FDONE;
+	val |= SSFSTS_CTL_SCGO;
+	if (atomic_preopcode) {
+		u16 preop;
+
+		switch (optype) {
+		case OPTYPE_WRITE_NO_ADDR:
+		case OPTYPE_WRITE_WITH_ADDR:
+			/* Pick matching preopcode for the atomic sequence */
+			preop = readw(ispi->sregs + PREOP_OPTYPE);
+			if ((preop & 0xff) == atomic_preopcode)
+				; /* Do nothing */
+			else if ((preop >> 8) == atomic_preopcode)
+				val |= SSFSTS_CTL_SPOP;
+			else
+				return -EINVAL;
+
+			/* Enable atomic sequence */
+			val |= SSFSTS_CTL_ACS;
+			break;
+
+		default:
+			return -EINVAL;
+		}
+	}
+	writel(val, ispi->sregs + SSFSTS_CTL);
+
+	ret = intel_spi_wait_sw_busy(ispi);
+	if (ret)
+		return ret;
+
+	status = readl(ispi->sregs + SSFSTS_CTL);
+	if (status & SSFSTS_CTL_FCERR)
+		return -EIO;
+	else if (status & SSFSTS_CTL_AEL)
+		return -EACCES;
+
+	return 0;
+}
+EXPORT_SYMBOL(intel_spi_sw_cycle);
+
+void disable_smi_generation(const struct intel_spi *ispi)
+{
+	u32 val;
+	val = readl(ispi->sregs + SSFSTS_CTL);
+	val &= ~SSFSTS_CTL_FSMIE;
+	writel(val, ispi->sregs + SSFSTS_CTL);
+}
+EXPORT_SYMBOL(disable_smi_generation);
+
+void populate_opmenus(struct intel_spi *ispi, u32 *opmenu0, u32 *opmenu1)
+{
+	unsigned int i;
+	*opmenu0 = readl(ispi->sregs + OPMENU0);
+	*opmenu1 = readl(ispi->sregs + OPMENU1);
+
+	if (*opmenu0 && *opmenu1) {
+		for (i = 0; i < ARRAY_SIZE(ispi->opcodes) / 2; i++) {
+			ispi->opcodes[i] = *opmenu0 >> i * 8;
+			ispi->opcodes[i + 4] = *opmenu1 >> i * 8;
+		}
+	}
+}
+EXPORT_SYMBOL(populate_opmenus);
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/spi/spi-intel-swseq.h b/drivers/spi/spi-intel-swseq.h
new file mode 100644
index 000000000000..457fb64814e2
--- /dev/null
+++ b/drivers/spi/spi-intel-swseq.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Intel PCH/PCU SPI flash driver.
+ *
+ * Copyright (C) 2016 - 2022, Intel Corporation
+ * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
+ */
+
+#ifndef SPI_INTEL_SWSEQ_H
+#define SPI_INTEL_SWSEQ_H
+
+#include <linux/types.h>
+
+int intel_spi_sw_cycle(struct intel_spi *ispi, u8 opcode, size_t len,
+		       int optype);
+inline bool is_swseq_enabled(void);
+int handle_swseq_wren(struct intel_spi *ispi);
+bool mem_op_supported_on_spi_locked(const struct intel_spi *ispi,
+				    const struct spi_mem_op *op);
+void disable_smi_generation(const struct intel_spi *ispi);
+void populate_opmenus(struct intel_spi *ispi, u32 *opmenu0, u32 *opmenu1);
+
+#endif /* SPI_INTEL_SWSEQ_H */
diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index 55f4ee2db002..8cdea5551e36 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -17,160 +17,8 @@
 #include <linux/spi/spi-mem.h>
 
 #include "spi-intel.h"
-
-/* Offsets are from @ispi->base */
-#define BFPREG				0x00
-
-#define HSFSTS_CTL			0x04
-#define HSFSTS_CTL_FSMIE		BIT(31)
-#define HSFSTS_CTL_FDBC_SHIFT		24
-#define HSFSTS_CTL_FDBC_MASK		(0x3f << HSFSTS_CTL_FDBC_SHIFT)
-
-#define HSFSTS_CTL_FCYCLE_SHIFT		17
-#define HSFSTS_CTL_FCYCLE_MASK		(0x0f << HSFSTS_CTL_FCYCLE_SHIFT)
-/* HW sequencer opcodes */
-#define HSFSTS_CTL_FCYCLE_READ		(0x00 << HSFSTS_CTL_FCYCLE_SHIFT)
-#define HSFSTS_CTL_FCYCLE_WRITE		(0x02 << HSFSTS_CTL_FCYCLE_SHIFT)
-#define HSFSTS_CTL_FCYCLE_ERASE		(0x03 << HSFSTS_CTL_FCYCLE_SHIFT)
-#define HSFSTS_CTL_FCYCLE_ERASE_64K	(0x04 << HSFSTS_CTL_FCYCLE_SHIFT)
-#define HSFSTS_CTL_FCYCLE_RDID		(0x06 << HSFSTS_CTL_FCYCLE_SHIFT)
-#define HSFSTS_CTL_FCYCLE_WRSR		(0x07 << HSFSTS_CTL_FCYCLE_SHIFT)
-#define HSFSTS_CTL_FCYCLE_RDSR		(0x08 << HSFSTS_CTL_FCYCLE_SHIFT)
-
-#define HSFSTS_CTL_FGO			BIT(16)
-#define HSFSTS_CTL_FLOCKDN		BIT(15)
-#define HSFSTS_CTL_FDV			BIT(14)
-#define HSFSTS_CTL_SCIP			BIT(5)
-#define HSFSTS_CTL_AEL			BIT(2)
-#define HSFSTS_CTL_FCERR		BIT(1)
-#define HSFSTS_CTL_FDONE		BIT(0)
-
-#define FADDR				0x08
-#define DLOCK				0x0c
-#define FDATA(n)			(0x10 + ((n) * 4))
-
-#define FRACC				0x50
-
-#define FREG(n)				(0x54 + ((n) * 4))
-#define FREG_BASE_MASK			0x3fff
-#define FREG_LIMIT_SHIFT		16
-#define FREG_LIMIT_MASK			(0x03fff << FREG_LIMIT_SHIFT)
-
-/* Offset is from @ispi->pregs */
-#define PR(n)				((n) * 4)
-#define PR_WPE				BIT(31)
-#define PR_LIMIT_SHIFT			16
-#define PR_LIMIT_MASK			(0x3fff << PR_LIMIT_SHIFT)
-#define PR_RPE				BIT(15)
-#define PR_BASE_MASK			0x3fff
-
-/* Offsets are from @ispi->sregs */
-#define SSFSTS_CTL			0x00
-#define SSFSTS_CTL_FSMIE		BIT(23)
-#define SSFSTS_CTL_DS			BIT(22)
-#define SSFSTS_CTL_DBC_SHIFT		16
-#define SSFSTS_CTL_SPOP			BIT(11)
-#define SSFSTS_CTL_ACS			BIT(10)
-#define SSFSTS_CTL_SCGO			BIT(9)
-#define SSFSTS_CTL_COP_SHIFT		12
-#define SSFSTS_CTL_FRS			BIT(7)
-#define SSFSTS_CTL_DOFRS		BIT(6)
-#define SSFSTS_CTL_AEL			BIT(4)
-#define SSFSTS_CTL_FCERR		BIT(3)
-#define SSFSTS_CTL_FDONE		BIT(2)
-#define SSFSTS_CTL_SCIP			BIT(0)
-
-#define PREOP_OPTYPE			0x04
-#define OPMENU0				0x08
-#define OPMENU1				0x0c
-
-#define OPTYPE_READ_NO_ADDR		0
-#define OPTYPE_WRITE_NO_ADDR		1
-#define OPTYPE_READ_WITH_ADDR		2
-#define OPTYPE_WRITE_WITH_ADDR		3
-
-/* CPU specifics */
-#define BYT_PR				0x74
-#define BYT_SSFSTS_CTL			0x90
-#define BYT_FREG_NUM			5
-#define BYT_PR_NUM			5
-
-#define LPT_PR				0x74
-#define LPT_SSFSTS_CTL			0x90
-#define LPT_FREG_NUM			5
-#define LPT_PR_NUM			5
-
-#define BXT_PR				0x84
-#define BXT_SSFSTS_CTL			0xa0
-#define BXT_FREG_NUM			12
-#define BXT_PR_NUM			6
-
-#define CNL_PR				0x84
-#define CNL_FREG_NUM			6
-#define CNL_PR_NUM			5
-
-#define LVSCC				0xc4
-#define UVSCC				0xc8
-#define ERASE_OPCODE_SHIFT		8
-#define ERASE_OPCODE_MASK		(0xff << ERASE_OPCODE_SHIFT)
-#define ERASE_64K_OPCODE_SHIFT		16
-#define ERASE_64K_OPCODE_MASK		(0xff << ERASE_OPCODE_SHIFT)
-
-/* Flash descriptor fields */
-#define FLVALSIG_MAGIC			0x0ff0a55a
-#define FLMAP0_NC_MASK			GENMASK(9, 8)
-#define FLMAP0_NC_SHIFT			8
-#define FLMAP0_FCBA_MASK		GENMASK(7, 0)
-
-#define FLCOMP_C0DEN_MASK		GENMASK(3, 0)
-#define FLCOMP_C0DEN_512K		0x00
-#define FLCOMP_C0DEN_1M			0x01
-#define FLCOMP_C0DEN_2M			0x02
-#define FLCOMP_C0DEN_4M			0x03
-#define FLCOMP_C0DEN_8M			0x04
-#define FLCOMP_C0DEN_16M		0x05
-#define FLCOMP_C0DEN_32M		0x06
-#define FLCOMP_C0DEN_64M		0x07
-
-#define INTEL_SPI_TIMEOUT		5000 /* ms */
-#define INTEL_SPI_FIFO_SZ		64
-
-/**
- * struct intel_spi - Driver private data
- * @dev: Device pointer
- * @info: Pointer to board specific info
- * @base: Beginning of MMIO space
- * @pregs: Start of protection registers
- * @sregs: Start of software sequencer registers
- * @master: Pointer to the SPI controller structure
- * @nregions: Maximum number of regions
- * @pr_num: Maximum number of protected range registers
- * @chip0_size: Size of the first flash chip in bytes
- * @locked: Is SPI setting locked
- * @swseq_reg: Use SW sequencer in register reads/writes
- * @swseq_erase: Use SW sequencer in erase operation
- * @atomic_preopcode: Holds preopcode when atomic sequence is requested
- * @opcodes: Opcodes which are supported. This are programmed by BIOS
- *           before it locks down the controller.
- * @mem_ops: Pointer to SPI MEM ops supported by the controller
- */
-struct intel_spi {
-	struct device *dev;
-	const struct intel_spi_boardinfo *info;
-	void __iomem *base;
-	void __iomem *pregs;
-	void __iomem *sregs;
-	struct spi_controller *master;
-	size_t nregions;
-	size_t pr_num;
-	size_t chip0_size;
-	bool locked;
-	bool swseq_reg;
-	bool swseq_erase;
-	u8 atomic_preopcode;
-	u8 opcodes[8];
-	const struct intel_spi_mem_op *mem_ops;
-};
+#include "spi-intel-common.h"
+#include "spi-intel-swseq.h"
 
 struct intel_spi_mem_op {
 	struct spi_mem_op mem_op;
@@ -259,9 +107,12 @@ static void intel_spi_dump_regs(struct intel_spi *ispi)
 	}
 
 	dev_dbg(ispi->dev, "Using %cW sequencer for register access\n",
-		ispi->swseq_reg ? 'S' : 'H');
+		ispi->swseq_reg && ispi->swseq_enabled ? 'S' : 'H');
 	dev_dbg(ispi->dev, "Using %cW sequencer for erase operation\n",
-		ispi->swseq_erase ? 'S' : 'H');
+		ispi->swseq_erase && ispi->swseq_enabled ? 'S' : 'H');
+
+	if (!ispi->swseq_enabled)
+		dev_dbg(ispi->dev, "SW sequencer is disabled for all operations\n");
 }
 
 /* Reads max INTEL_SPI_FIFO_SZ bytes from the device fifo */
@@ -314,15 +165,6 @@ static int intel_spi_wait_hw_busy(struct intel_spi *ispi)
 				  INTEL_SPI_TIMEOUT * 1000);
 }
 
-static int intel_spi_wait_sw_busy(struct intel_spi *ispi)
-{
-	u32 val;
-
-	return readl_poll_timeout(ispi->sregs + SSFSTS_CTL, val,
-				  !(val & SSFSTS_CTL_SCIP), 0,
-				  INTEL_SPI_TIMEOUT * 1000);
-}
-
 static bool intel_spi_set_writeable(struct intel_spi *ispi)
 {
 	if (!ispi->info->set_writeable)
@@ -331,27 +173,6 @@ static bool intel_spi_set_writeable(struct intel_spi *ispi)
 	return ispi->info->set_writeable(ispi->base, ispi->info->data);
 }
 
-static int intel_spi_opcode_index(struct intel_spi *ispi, u8 opcode, int optype)
-{
-	int i;
-	int preop;
-
-	if (ispi->locked) {
-		for (i = 0; i < ARRAY_SIZE(ispi->opcodes); i++)
-			if (ispi->opcodes[i] == opcode)
-				return i;
-
-		return -EINVAL;
-	}
-
-	/* The lock is off, so just use index 0 */
-	writel(opcode, ispi->sregs + OPMENU0);
-	preop = readw(ispi->sregs + PREOP_OPTYPE);
-	writel(optype << 16 | preop, ispi->sregs + PREOP_OPTYPE);
-
-	return 0;
-}
-
 static int intel_spi_hw_cycle(struct intel_spi *ispi, u8 opcode, size_t len)
 {
 	u32 val, status;
@@ -395,71 +216,6 @@ static int intel_spi_hw_cycle(struct intel_spi *ispi, u8 opcode, size_t len)
 	return 0;
 }
 
-static int intel_spi_sw_cycle(struct intel_spi *ispi, u8 opcode, size_t len,
-			      int optype)
-{
-	u32 val = 0, status;
-	u8 atomic_preopcode;
-	int ret;
-
-	ret = intel_spi_opcode_index(ispi, opcode, optype);
-	if (ret < 0)
-		return ret;
-
-	if (len > INTEL_SPI_FIFO_SZ)
-		return -EINVAL;
-
-	/*
-	 * Always clear it after each SW sequencer operation regardless
-	 * of whether it is successful or not.
-	 */
-	atomic_preopcode = ispi->atomic_preopcode;
-	ispi->atomic_preopcode = 0;
-
-	/* Only mark 'Data Cycle' bit when there is data to be transferred */
-	if (len > 0)
-		val = ((len - 1) << SSFSTS_CTL_DBC_SHIFT) | SSFSTS_CTL_DS;
-	val |= ret << SSFSTS_CTL_COP_SHIFT;
-	val |= SSFSTS_CTL_FCERR | SSFSTS_CTL_FDONE;
-	val |= SSFSTS_CTL_SCGO;
-	if (atomic_preopcode) {
-		u16 preop;
-
-		switch (optype) {
-		case OPTYPE_WRITE_NO_ADDR:
-		case OPTYPE_WRITE_WITH_ADDR:
-			/* Pick matching preopcode for the atomic sequence */
-			preop = readw(ispi->sregs + PREOP_OPTYPE);
-			if ((preop & 0xff) == atomic_preopcode)
-				; /* Do nothing */
-			else if ((preop >> 8) == atomic_preopcode)
-				val |= SSFSTS_CTL_SPOP;
-			else
-				return -EINVAL;
-
-			/* Enable atomic sequence */
-			val |= SSFSTS_CTL_ACS;
-			break;
-
-		default:
-			return -EINVAL;
-		}
-	}
-	writel(val, ispi->sregs + SSFSTS_CTL);
-
-	ret = intel_spi_wait_sw_busy(ispi);
-	if (ret)
-		return ret;
-
-	status = readl(ispi->sregs + SSFSTS_CTL);
-	if (status & SSFSTS_CTL_FCERR)
-		return -EIO;
-	else if (status & SSFSTS_CTL_AEL)
-		return -EACCES;
-
-	return 0;
-}
-
 static u32 intel_spi_chip_addr(const struct intel_spi *ispi,
 			       const struct spi_mem *mem)
 {
@@ -479,7 +235,7 @@ static int intel_spi_read_reg(struct intel_spi *ispi, const struct spi_mem *mem,
 
 	writel(intel_spi_chip_addr(ispi, mem), ispi->base + FADDR);
 
-	if (ispi->swseq_reg)
+	if (ispi->swseq_reg && ispi->swseq_enabled)
 		ret = intel_spi_sw_cycle(ispi, opcode, nbytes,
 					 OPTYPE_READ_NO_ADDR);
 	else
@@ -508,26 +264,8 @@ static int intel_spi_write_reg(struct intel_spi *ispi, const struct spi_mem *mem
 	 * When hardware sequencer is used there is no need to program
 	 * any opcodes (it handles them automatically as part of a command).
 	 */
-	if (opcode == SPINOR_OP_WREN) {
-		u16 preop;
-
-		if (!ispi->swseq_reg)
-			return 0;
-
-		preop = readw(ispi->sregs + PREOP_OPTYPE);
-		if ((preop & 0xff) != opcode && (preop >> 8) != opcode) {
-			if (ispi->locked)
-				return -EINVAL;
-			writel(opcode, ispi->sregs + PREOP_OPTYPE);
-		}
-
-		/*
-		 * This enables atomic sequence on next SW sycle. Will
-		 * be cleared after next operation.
-		 */
-		ispi->atomic_preopcode = opcode;
-		return 0;
-	}
+	if (opcode == SPINOR_OP_WREN)
+		return handle_swseq_wren(ispi);
 
 	/*
 	 * We hope that HW sequencer will do the right thing automatically and
@@ -545,7 +283,7 @@ static int intel_spi_write_reg(struct intel_spi *ispi, const struct spi_mem *mem
 	if (ret)
 		return ret;
 
-	if (ispi->swseq_reg)
+	if (ispi->swseq_reg && ispi->swseq_enabled)
 		return intel_spi_sw_cycle(ispi, opcode, nbytes,
 					  OPTYPE_WRITE_NO_ADDR);
 	return intel_spi_hw_cycle(ispi, opcode, nbytes);
@@ -686,7 +424,11 @@ static int intel_spi_erase(struct intel_spi *ispi, const struct spi_mem *mem,
 
 	writel(addr, ispi->base + FADDR);
 
-	if (ispi->swseq_erase)
+	/*
+	 * If swseq_erase is true, it means that we cannot erase using
+	 * HW sequencer.
+	 */
+	if (ispi->swseq_erase && ispi->swseq_enabled)
 		return intel_spi_sw_cycle(ispi, opcode, 0,
 					  OPTYPE_WRITE_WITH_ADDR);
 
@@ -767,18 +509,8 @@ static bool intel_spi_supports_mem_op(struct spi_mem *mem,
 	 * For software sequencer check that the opcode is actually
 	 * present in the opmenu if it is locked.
 	 */
-	if (ispi->swseq_reg && ispi->locked) {
-		int i;
-
-		/* Check if it is in the locked opcodes list */
-		for (i = 0; i < ARRAY_SIZE(ispi->opcodes); i++) {
-			if (ispi->opcodes[i] == op->cmd.opcode)
-				return true;
-		}
-
-		dev_dbg(ispi->dev, "%#x not supported\n", op->cmd.opcode);
-		return false;
-	}
+	if (ispi->swseq_reg && ispi->locked && ispi->swseq_enabled)
+		return mem_op_supported_on_spi_locked(ispi, op);
 
 	return true;
 }
@@ -1068,7 +800,8 @@ static int intel_spi_init(struct intel_spi *ispi)
 {
 	u32 opmenu0, opmenu1, lvscc, uvscc, val;
 	bool erase_64k = false;
-	int i;
+
+	ispi->swseq_enabled = is_swseq_enabled();
 
 	switch (ispi->info->type) {
 	case INTEL_SPI_BYT:
@@ -1141,37 +874,28 @@ static int intel_spi_init(struct intel_spi *ispi)
 		return -EINVAL;
 	}
 
+
 	/*
 	 * Some controllers can only do basic operations using hardware
 	 * sequencer. All other operations are supposed to be carried out
 	 * using software sequencer.
 	 */
-	if (ispi->swseq_reg) {
+	if (ispi->swseq_reg && ispi->swseq_enabled) {
 		/* Disable #SMI generation from SW sequencer */
-		val = readl(ispi->sregs + SSFSTS_CTL);
-		val &= ~SSFSTS_CTL_FSMIE;
-		writel(val, ispi->sregs + SSFSTS_CTL);
+		disable_smi_generation(ispi);
 	}
 
 	/* Check controller's lock status */
 	val = readl(ispi->base + HSFSTS_CTL);
 	ispi->locked = !!(val & HSFSTS_CTL_FLOCKDN);
 
-	if (ispi->locked && ispi->sregs) {
+	if (ispi->locked && ispi->sregs && ispi->swseq_enabled) {
 		/*
 		 * BIOS programs allowed opcodes and then locks down the
 		 * register. So read back what opcodes it decided to support.
 		 * That's the set we are going to support as well.
 		 */
-		opmenu0 = readl(ispi->sregs + OPMENU0);
-		opmenu1 = readl(ispi->sregs + OPMENU1);
-
-		if (opmenu0 && opmenu1) {
-			for (i = 0; i < ARRAY_SIZE(ispi->opcodes) / 2; i++) {
-				ispi->opcodes[i] = opmenu0 >> i * 8;
-				ispi->opcodes[i + 4] = opmenu1 >> i * 8;
-			}
-		}
+		populate_opmenus(ispi, &opmenu0, &opmenu1);
 	}
 
 	if (erase_64k) {
-- 
2.34.3

