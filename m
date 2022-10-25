Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B0160C794
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiJYJJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiJYJHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:07:48 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB6D105377;
        Tue, 25 Oct 2022 02:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666688683; x=1698224683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zVgANsCCc3ipqprz/Z8+mPN/eCR9gcToKd2ky+uI2oM=;
  b=GEbnOpJaKN5ZDv+DinzcMYPq+p10ilstQUT0aw1iz+61Mgtna75bdxvM
   2hos7//jptLhRsg5Xzcxq9dRgZlrsSLfIqnx7K1jXcdpRcPU4AyS1zUBw
   OF+nQ18sJBG61ahgUNyKahTHKeJI7D24fPty/dQUtyuzeYOak08QyS+aP
   WADbePbALae2+XiAzTeIv8whnGQdjMqZzSo9hBmWroQcFgNZT1gXhYc5R
   OflVpItUHBxHvhRz9u3uDDpdPlmDah3kvV1HoYmXuL59Uo57TEBXXwNN9
   D+gWFAJj+xL6K80ngUTW+uQdJvmevBCXjWLx1T+hzmlTt7uMWo/z+5nwG
   w==;
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="196910260"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2022 02:04:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 25 Oct 2022 02:04:32 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 25 Oct 2022 02:04:29 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>
CC:     <maciej.sosnowski@intel.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <torfl6749@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v2 27/32] dmaengine: at_hdmac: Keep register definitions and structures private to at_hdmac.c
Date:   Tue, 25 Oct 2022 12:03:01 +0300
Message-ID: <20221025090306.297886-28-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025090306.297886-1-tudor.ambarus@microchip.com>
References: <20221025090306.297886-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not expose register definitions, structures and helpers via a .h file
because there are used only by at_hdmac.c. Since there are no other users,
remove the ambiguity and move all the .h contents to the .c file.

One may notice some checkpatch warnings and errors with this move. The move
was done "as it was", checkpatch complaints can be fixed in a further
patch.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 MAINTAINERS                 |   1 -
 drivers/dma/at_hdmac.c      | 469 ++++++++++++++++++++++++++++++++++-
 drivers/dma/at_hdmac_regs.h | 478 ------------------------------------
 3 files changed, 468 insertions(+), 480 deletions(-)
 delete mode 100644 drivers/dma/at_hdmac_regs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..0fd65ca63218 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13420,7 +13420,6 @@ L:	dmaengine@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/dma/atmel-dma.txt
 F:	drivers/dma/at_hdmac.c
-F:	drivers/dma/at_hdmac_regs.h
 F:	drivers/dma/at_xdmac.c
 F:	include/dt-bindings/dma/at91.h
 
diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index a3fa8bffdb74..a07e3355f09a 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -23,7 +23,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include "at_hdmac_regs.h"
 #include "dmaengine.h"
 
 /*
@@ -35,6 +34,474 @@
  * atc_	/ atchan	: ATmel DMA Channel entity related
  */
 
+#define	AT_DMA_MAX_NR_CHANNELS	8
+
+
+#define	AT_DMA_GCFG	0x00	/* Global Configuration Register */
+#define		AT_DMA_IF_BIGEND(i)	(0x1 << (i))	/* AHB-Lite Interface i in Big-endian mode */
+#define		AT_DMA_ARB_CFG	(0x1 << 4)	/* Arbiter mode. */
+#define			AT_DMA_ARB_CFG_FIXED		(0x0 << 4)
+#define			AT_DMA_ARB_CFG_ROUND_ROBIN	(0x1 << 4)
+
+#define	AT_DMA_EN	0x04	/* Controller Enable Register */
+#define		AT_DMA_ENABLE	(0x1 << 0)
+
+#define	AT_DMA_SREQ	0x08	/* Software Single Request Register */
+#define		AT_DMA_SSREQ(x)	(0x1 << ((x) << 1))		/* Request a source single transfer on channel x */
+#define		AT_DMA_DSREQ(x)	(0x1 << (1 + ((x) << 1)))	/* Request a destination single transfer on channel x */
+
+#define	AT_DMA_CREQ	0x0C	/* Software Chunk Transfer Request Register */
+#define		AT_DMA_SCREQ(x)	(0x1 << ((x) << 1))		/* Request a source chunk transfer on channel x */
+#define		AT_DMA_DCREQ(x)	(0x1 << (1 + ((x) << 1)))	/* Request a destination chunk transfer on channel x */
+
+#define	AT_DMA_LAST	0x10	/* Software Last Transfer Flag Register */
+#define		AT_DMA_SLAST(x)	(0x1 << ((x) << 1))		/* This src rq is last tx of buffer on channel x */
+#define		AT_DMA_DLAST(x)	(0x1 << (1 + ((x) << 1)))	/* This dst rq is last tx of buffer on channel x */
+
+#define	AT_DMA_SYNC	0x14	/* Request Synchronization Register */
+#define		AT_DMA_SYR(h)	(0x1 << (h))			/* Synchronize handshake line h */
+
+/* Error, Chained Buffer transfer completed and Buffer transfer completed Interrupt registers */
+#define	AT_DMA_EBCIER	0x18	/* Enable register */
+#define	AT_DMA_EBCIDR	0x1C	/* Disable register */
+#define	AT_DMA_EBCIMR	0x20	/* Mask Register */
+#define	AT_DMA_EBCISR	0x24	/* Status Register */
+#define		AT_DMA_CBTC_OFFSET	8
+#define		AT_DMA_ERR_OFFSET	16
+#define		AT_DMA_BTC(x)	(0x1 << (x))
+#define		AT_DMA_CBTC(x)	(0x1 << (AT_DMA_CBTC_OFFSET + (x)))
+#define		AT_DMA_ERR(x)	(0x1 << (AT_DMA_ERR_OFFSET + (x)))
+
+#define	AT_DMA_CHER	0x28	/* Channel Handler Enable Register */
+#define		AT_DMA_ENA(x)	(0x1 << (x))
+#define		AT_DMA_SUSP(x)	(0x1 << ( 8 + (x)))
+#define		AT_DMA_KEEP(x)	(0x1 << (24 + (x)))
+
+#define	AT_DMA_CHDR	0x2C	/* Channel Handler Disable Register */
+#define		AT_DMA_DIS(x)	(0x1 << (x))
+#define		AT_DMA_RES(x)	(0x1 << ( 8 + (x)))
+
+#define	AT_DMA_CHSR	0x30	/* Channel Handler Status Register */
+#define		AT_DMA_EMPT(x)	(0x1 << (16 + (x)))
+#define		AT_DMA_STAL(x)	(0x1 << (24 + (x)))
+
+
+#define	AT_DMA_CH_REGS_BASE	0x3C	/* Channel registers base address */
+#define	ch_regs(x)	(AT_DMA_CH_REGS_BASE + (x) * 0x28) /* Channel x base addr */
+
+/* Hardware register offset for each channel */
+#define	ATC_SADDR_OFFSET	0x00	/* Source Address Register */
+#define	ATC_DADDR_OFFSET	0x04	/* Destination Address Register */
+#define	ATC_DSCR_OFFSET		0x08	/* Descriptor Address Register */
+#define	ATC_CTRLA_OFFSET	0x0C	/* Control A Register */
+#define	ATC_CTRLB_OFFSET	0x10	/* Control B Register */
+#define	ATC_CFG_OFFSET		0x14	/* Configuration Register */
+#define	ATC_SPIP_OFFSET		0x18	/* Src PIP Configuration Register */
+#define	ATC_DPIP_OFFSET		0x1C	/* Dst PIP Configuration Register */
+
+
+/* Bitfield definitions */
+
+/* Bitfields in DSCR */
+#define	ATC_DSCR_IF(i)		(0x3 & (i))	/* Dsc feched via AHB-Lite Interface i */
+
+/* Bitfields in CTRLA */
+#define	ATC_BTSIZE_MAX		0xFFFFUL	/* Maximum Buffer Transfer Size */
+#define	ATC_BTSIZE(x)		(ATC_BTSIZE_MAX & (x)) /* Buffer Transfer Size */
+#define	ATC_SCSIZE_MASK		(0x7 << 16)	/* Source Chunk Transfer Size */
+#define		ATC_SCSIZE(x)		(ATC_SCSIZE_MASK & ((x) << 16))
+#define		ATC_SCSIZE_1		(0x0 << 16)
+#define		ATC_SCSIZE_4		(0x1 << 16)
+#define		ATC_SCSIZE_8		(0x2 << 16)
+#define		ATC_SCSIZE_16		(0x3 << 16)
+#define		ATC_SCSIZE_32		(0x4 << 16)
+#define		ATC_SCSIZE_64		(0x5 << 16)
+#define		ATC_SCSIZE_128		(0x6 << 16)
+#define		ATC_SCSIZE_256		(0x7 << 16)
+#define	ATC_DCSIZE_MASK		(0x7 << 20)	/* Destination Chunk Transfer Size */
+#define		ATC_DCSIZE(x)		(ATC_DCSIZE_MASK & ((x) << 20))
+#define		ATC_DCSIZE_1		(0x0 << 20)
+#define		ATC_DCSIZE_4		(0x1 << 20)
+#define		ATC_DCSIZE_8		(0x2 << 20)
+#define		ATC_DCSIZE_16		(0x3 << 20)
+#define		ATC_DCSIZE_32		(0x4 << 20)
+#define		ATC_DCSIZE_64		(0x5 << 20)
+#define		ATC_DCSIZE_128		(0x6 << 20)
+#define		ATC_DCSIZE_256		(0x7 << 20)
+#define	ATC_SRC_WIDTH_MASK	(0x3 << 24)	/* Source Single Transfer Size */
+#define		ATC_SRC_WIDTH(x)	((x) << 24)
+#define		ATC_SRC_WIDTH_BYTE	(0x0 << 24)
+#define		ATC_SRC_WIDTH_HALFWORD	(0x1 << 24)
+#define		ATC_SRC_WIDTH_WORD	(0x2 << 24)
+#define		ATC_REG_TO_SRC_WIDTH(r)	(((r) >> 24) & 0x3)
+#define	ATC_DST_WIDTH_MASK	(0x3 << 28)	/* Destination Single Transfer Size */
+#define		ATC_DST_WIDTH(x)	((x) << 28)
+#define		ATC_DST_WIDTH_BYTE	(0x0 << 28)
+#define		ATC_DST_WIDTH_HALFWORD	(0x1 << 28)
+#define		ATC_DST_WIDTH_WORD	(0x2 << 28)
+#define	ATC_DONE		(0x1 << 31)	/* Tx Done (only written back in descriptor) */
+
+/* Bitfields in CTRLB */
+#define	ATC_SIF(i)		(0x3 & (i))	/* Src tx done via AHB-Lite Interface i */
+#define	ATC_DIF(i)		((0x3 & (i)) <<  4)	/* Dst tx done via AHB-Lite Interface i */
+				  /* Specify AHB interfaces */
+#define AT_DMA_MEM_IF		0 /* interface 0 as memory interface */
+#define AT_DMA_PER_IF		1 /* interface 1 as peripheral interface */
+
+#define	ATC_SRC_PIP		(0x1 <<  8)	/* Source Picture-in-Picture enabled */
+#define	ATC_DST_PIP		(0x1 << 12)	/* Destination Picture-in-Picture enabled */
+#define	ATC_SRC_DSCR_DIS	(0x1 << 16)	/* Src Descriptor fetch disable */
+#define	ATC_DST_DSCR_DIS	(0x1 << 20)	/* Dst Descriptor fetch disable */
+#define	ATC_FC_MASK		(0x7 << 21)	/* Choose Flow Controller */
+#define		ATC_FC_MEM2MEM		(0x0 << 21)	/* Mem-to-Mem (DMA) */
+#define		ATC_FC_MEM2PER		(0x1 << 21)	/* Mem-to-Periph (DMA) */
+#define		ATC_FC_PER2MEM		(0x2 << 21)	/* Periph-to-Mem (DMA) */
+#define		ATC_FC_PER2PER		(0x3 << 21)	/* Periph-to-Periph (DMA) */
+#define		ATC_FC_PER2MEM_PER	(0x4 << 21)	/* Periph-to-Mem (Peripheral) */
+#define		ATC_FC_MEM2PER_PER	(0x5 << 21)	/* Mem-to-Periph (Peripheral) */
+#define		ATC_FC_PER2PER_SRCPER	(0x6 << 21)	/* Periph-to-Periph (Src Peripheral) */
+#define		ATC_FC_PER2PER_DSTPER	(0x7 << 21)	/* Periph-to-Periph (Dst Peripheral) */
+#define	ATC_SRC_ADDR_MODE_MASK	(0x3 << 24)
+#define		ATC_SRC_ADDR_MODE_INCR	(0x0 << 24)	/* Incrementing Mode */
+#define		ATC_SRC_ADDR_MODE_DECR	(0x1 << 24)	/* Decrementing Mode */
+#define		ATC_SRC_ADDR_MODE_FIXED	(0x2 << 24)	/* Fixed Mode */
+#define	ATC_DST_ADDR_MODE_MASK	(0x3 << 28)
+#define		ATC_DST_ADDR_MODE_INCR	(0x0 << 28)	/* Incrementing Mode */
+#define		ATC_DST_ADDR_MODE_DECR	(0x1 << 28)	/* Decrementing Mode */
+#define		ATC_DST_ADDR_MODE_FIXED	(0x2 << 28)	/* Fixed Mode */
+#define	ATC_IEN			(0x1 << 30)	/* BTC interrupt enable (active low) */
+#define	ATC_AUTO		(0x1 << 31)	/* Auto multiple buffer tx enable */
+
+/* Bitfields in CFG */
+#define ATC_PER_MSB(h)	((0x30U & (h)) >> 4)	/* Extract most significant bits of a handshaking identifier */
+
+#define	ATC_SRC_PER(h)		(0xFU & (h))	/* Channel src rq associated with periph handshaking ifc h */
+#define	ATC_DST_PER(h)		((0xFU & (h)) <<  4)	/* Channel dst rq associated with periph handshaking ifc h */
+#define	ATC_SRC_REP		(0x1 <<  8)	/* Source Replay Mod */
+#define	ATC_SRC_H2SEL		(0x1 <<  9)	/* Source Handshaking Mod */
+#define		ATC_SRC_H2SEL_SW	(0x0 <<  9)
+#define		ATC_SRC_H2SEL_HW	(0x1 <<  9)
+#define	ATC_SRC_PER_MSB(h)	(ATC_PER_MSB(h) << 10)	/* Channel src rq (most significant bits) */
+#define	ATC_DST_REP		(0x1 << 12)	/* Destination Replay Mod */
+#define	ATC_DST_H2SEL		(0x1 << 13)	/* Destination Handshaking Mod */
+#define		ATC_DST_H2SEL_SW	(0x0 << 13)
+#define		ATC_DST_H2SEL_HW	(0x1 << 13)
+#define	ATC_DST_PER_MSB(h)	(ATC_PER_MSB(h) << 14)	/* Channel dst rq (most significant bits) */
+#define	ATC_SOD			(0x1 << 16)	/* Stop On Done */
+#define	ATC_LOCK_IF		(0x1 << 20)	/* Interface Lock */
+#define	ATC_LOCK_B		(0x1 << 21)	/* AHB Bus Lock */
+#define	ATC_LOCK_IF_L		(0x1 << 22)	/* Master Interface Arbiter Lock */
+#define		ATC_LOCK_IF_L_CHUNK	(0x0 << 22)
+#define		ATC_LOCK_IF_L_BUFFER	(0x1 << 22)
+#define	ATC_AHB_PROT_MASK	(0x7 << 24)	/* AHB Protection */
+#define	ATC_FIFOCFG_MASK	(0x3 << 28)	/* FIFO Request Configuration */
+#define		ATC_FIFOCFG_LARGESTBURST	(0x0 << 28)
+#define		ATC_FIFOCFG_HALFFIFO		(0x1 << 28)
+#define		ATC_FIFOCFG_ENOUGHSPACE		(0x2 << 28)
+
+/* Bitfields in SPIP */
+#define	ATC_SPIP_HOLE(x)	(0xFFFFU & (x))
+#define	ATC_SPIP_BOUNDARY(x)	((0x3FF & (x)) << 16)
+
+/* Bitfields in DPIP */
+#define	ATC_DPIP_HOLE(x)	(0xFFFFU & (x))
+#define	ATC_DPIP_BOUNDARY(x)	((0x3FF & (x)) << 16)
+
+
+/*--  descriptors  -----------------------------------------------------*/
+
+/* LLI == Linked List Item; aka DMA buffer descriptor */
+struct at_lli {
+	/* values that are not changed by hardware */
+	u32 saddr;
+	u32 daddr;
+	/* value that may get written back: */
+	u32 ctrla;
+	/* more values that are not changed by hardware */
+	u32 ctrlb;
+	u32 dscr;	/* chain to next lli */
+};
+
+/**
+ * struct at_desc - software descriptor
+ * @at_lli: hardware lli structure
+ * @txd: support for the async_tx api
+ * @desc_node: node on the channed descriptors list
+ * @len: descriptor byte count
+ * @total_len: total transaction byte count
+ */
+struct at_desc {
+	/* FIRST values the hardware uses */
+	struct at_lli			lli;
+
+	/* THEN values for driver housekeeping */
+	struct list_head		tx_list;
+	struct dma_async_tx_descriptor	txd;
+	struct list_head		desc_node;
+	size_t				len;
+	size_t				total_len;
+
+	/* Interleaved data */
+	size_t				boundary;
+	size_t				dst_hole;
+	size_t				src_hole;
+
+	/* Memset temporary buffer */
+	bool				memset_buffer;
+	dma_addr_t			memset_paddr;
+	int				*memset_vaddr;
+};
+
+static inline struct at_desc *
+txd_to_at_desc(struct dma_async_tx_descriptor *txd)
+{
+	return container_of(txd, struct at_desc, txd);
+}
+
+
+/*--  Channels  --------------------------------------------------------*/
+
+/**
+ * atc_status - information bits stored in channel status flag
+ *
+ * Manipulated with atomic operations.
+ */
+enum atc_status {
+	ATC_IS_ERROR = 0,
+	ATC_IS_PAUSED = 1,
+	ATC_IS_CYCLIC = 24,
+};
+
+/**
+ * struct at_dma_chan - internal representation of an Atmel HDMAC channel
+ * @chan_common: common dmaengine channel object members
+ * @device: parent device
+ * @ch_regs: memory mapped register base
+ * @mask: channel index in a mask
+ * @per_if: peripheral interface
+ * @mem_if: memory interface
+ * @status: transmit status information from irq/prep* functions
+ *                to tasklet (use atomic operations)
+ * @tasklet: bottom half to finish transaction work
+ * @save_cfg: configuration register that is saved on suspend/resume cycle
+ * @save_dscr: for cyclic operations, preserve next descriptor address in
+ *             the cyclic list on suspend/resume cycle
+ * @dma_sconfig: configuration for slave transfers, passed via
+ * .device_config
+ * @lock: serializes enqueue/dequeue operations to descriptors lists
+ * @active_list: list of descriptors dmaengine is being running on
+ * @queue: list of descriptors ready to be submitted to engine
+ * @free_list: list of descriptors usable by the channel
+ */
+struct at_dma_chan {
+	struct dma_chan		chan_common;
+	struct at_dma		*device;
+	void __iomem		*ch_regs;
+	u8			mask;
+	u8			per_if;
+	u8			mem_if;
+	unsigned long		status;
+	struct tasklet_struct	tasklet;
+	u32			save_cfg;
+	u32			save_dscr;
+	struct dma_slave_config dma_sconfig;
+
+	spinlock_t		lock;
+
+	/* these other elements are all protected by lock */
+	struct list_head	active_list;
+	struct list_head	queue;
+	struct list_head	free_list;
+};
+
+#define	channel_readl(atchan, name) \
+	__raw_readl((atchan)->ch_regs + ATC_##name##_OFFSET)
+
+#define	channel_writel(atchan, name, val) \
+	__raw_writel((val), (atchan)->ch_regs + ATC_##name##_OFFSET)
+
+static inline struct at_dma_chan *to_at_dma_chan(struct dma_chan *dchan)
+{
+	return container_of(dchan, struct at_dma_chan, chan_common);
+}
+
+/*
+ * Fix sconfig's burst size according to at_hdmac. We need to convert them as:
+ * 1 -> 0, 4 -> 1, 8 -> 2, 16 -> 3, 32 -> 4, 64 -> 5, 128 -> 6, 256 -> 7.
+ *
+ * This can be done by finding most significant bit set.
+ */
+static inline void convert_burst(u32 *maxburst)
+{
+	if (*maxburst > 1)
+		*maxburst = fls(*maxburst) - 2;
+	else
+		*maxburst = 0;
+}
+
+/*
+ * Fix sconfig's bus width according to at_hdmac.
+ * 1 byte -> 0, 2 bytes -> 1, 4 bytes -> 2.
+ */
+static inline u8 convert_buswidth(enum dma_slave_buswidth addr_width)
+{
+	switch (addr_width) {
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+		return 1;
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+		return 2;
+	default:
+		/* For 1 byte width or fallback */
+		return 0;
+	}
+}
+
+/*--  Controller  ------------------------------------------------------*/
+
+/**
+ * struct at_dma - internal representation of an Atmel HDMA Controller
+ * @chan_common: common dmaengine dma_device object members
+ * @atdma_devtype: identifier of DMA controller compatibility
+ * @ch_regs: memory mapped register base
+ * @clk: dma controller clock
+ * @save_imr: interrupt mask register that is saved on suspend/resume cycle
+ * @all_chan_mask: all channels availlable in a mask
+ * @dma_desc_pool: base of DMA descriptor region (DMA address)
+ * @chan: channels table to store at_dma_chan structures
+ */
+struct at_dma {
+	struct dma_device	dma_common;
+	void __iomem		*regs;
+	struct clk		*clk;
+	u32			save_imr;
+
+	u8			all_chan_mask;
+
+	struct dma_pool		*dma_desc_pool;
+	struct dma_pool		*memset_pool;
+	/* AT THE END channels table */
+	struct at_dma_chan	chan[];
+};
+
+#define	dma_readl(atdma, name) \
+	__raw_readl((atdma)->regs + AT_DMA_##name)
+#define	dma_writel(atdma, name, val) \
+	__raw_writel((val), (atdma)->regs + AT_DMA_##name)
+
+static inline struct at_dma *to_at_dma(struct dma_device *ddev)
+{
+	return container_of(ddev, struct at_dma, dma_common);
+}
+
+
+/*--  Helper functions  ------------------------------------------------*/
+
+static struct device *chan2dev(struct dma_chan *chan)
+{
+	return &chan->dev->device;
+}
+
+#if defined(VERBOSE_DEBUG)
+static void vdbg_dump_regs(struct at_dma_chan *atchan)
+{
+	struct at_dma	*atdma = to_at_dma(atchan->chan_common.device);
+
+	dev_err(chan2dev(&atchan->chan_common),
+		"  channel %d : imr = 0x%x, chsr = 0x%x\n",
+		atchan->chan_common.chan_id,
+		dma_readl(atdma, EBCIMR),
+		dma_readl(atdma, CHSR));
+
+	dev_err(chan2dev(&atchan->chan_common),
+		"  channel: s0x%x d0x%x ctrl0x%x:0x%x cfg0x%x l0x%x\n",
+		channel_readl(atchan, SADDR),
+		channel_readl(atchan, DADDR),
+		channel_readl(atchan, CTRLA),
+		channel_readl(atchan, CTRLB),
+		channel_readl(atchan, CFG),
+		channel_readl(atchan, DSCR));
+}
+#else
+static void vdbg_dump_regs(struct at_dma_chan *atchan) {}
+#endif
+
+static void atc_dump_lli(struct at_dma_chan *atchan, struct at_lli *lli)
+{
+	dev_crit(chan2dev(&atchan->chan_common),
+		 "desc: s%pad d%pad ctrl0x%x:0x%x l%pad\n",
+		 &lli->saddr, &lli->daddr,
+		 lli->ctrla, lli->ctrlb, &lli->dscr);
+}
+
+
+static void atc_setup_irq(struct at_dma *atdma, int chan_id, int on)
+{
+	u32 ebci;
+
+	/* enable interrupts on buffer transfer completion & error */
+	ebci =    AT_DMA_BTC(chan_id)
+		| AT_DMA_ERR(chan_id);
+	if (on)
+		dma_writel(atdma, EBCIER, ebci);
+	else
+		dma_writel(atdma, EBCIDR, ebci);
+}
+
+static void atc_enable_chan_irq(struct at_dma *atdma, int chan_id)
+{
+	atc_setup_irq(atdma, chan_id, 1);
+}
+
+static void atc_disable_chan_irq(struct at_dma *atdma, int chan_id)
+{
+	atc_setup_irq(atdma, chan_id, 0);
+}
+
+
+/**
+ * atc_chan_is_enabled - test if given channel is enabled
+ * @atchan: channel we want to test status
+ */
+static inline int atc_chan_is_enabled(struct at_dma_chan *atchan)
+{
+	struct at_dma	*atdma = to_at_dma(atchan->chan_common.device);
+
+	return !!(dma_readl(atdma, CHSR) & atchan->mask);
+}
+
+/**
+ * atc_chan_is_paused - test channel pause/resume status
+ * @atchan: channel we want to test status
+ */
+static inline int atc_chan_is_paused(struct at_dma_chan *atchan)
+{
+	return test_bit(ATC_IS_PAUSED, &atchan->status);
+}
+
+/**
+ * atc_chan_is_cyclic - test if given channel has cyclic property set
+ * @atchan: channel we want to test status
+ */
+static inline int atc_chan_is_cyclic(struct at_dma_chan *atchan)
+{
+	return test_bit(ATC_IS_CYCLIC, &atchan->status);
+}
+
+/**
+ * set_desc_eol - set end-of-link to descriptor so it will end transfer
+ * @desc: descriptor, signle or at the end of a chain, to end chain on
+ */
+static void set_desc_eol(struct at_desc *desc)
+{
+	u32 ctrlb = desc->lli.ctrlb;
+
+	ctrlb &= ~ATC_IEN;
+	ctrlb |= ATC_SRC_DSCR_DIS | ATC_DST_DSCR_DIS;
+
+	desc->lli.ctrlb = ctrlb;
+	desc->lli.dscr = 0;
+}
+
 #define	ATC_DEFAULT_CFG		(ATC_FIFOCFG_HALFFIFO)
 #define	ATC_DEFAULT_CTRLB	(ATC_SIF(AT_DMA_MEM_IF) \
 				|ATC_DIF(AT_DMA_MEM_IF))
diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
deleted file mode 100644
index d4d382d74607..000000000000
--- a/drivers/dma/at_hdmac_regs.h
+++ /dev/null
@@ -1,478 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Header file for the Atmel AHB DMA Controller driver
- *
- * Copyright (C) 2008 Atmel Corporation
- */
-#ifndef AT_HDMAC_REGS_H
-#define	AT_HDMAC_REGS_H
-
-#define	AT_DMA_MAX_NR_CHANNELS	8
-
-
-#define	AT_DMA_GCFG	0x00	/* Global Configuration Register */
-#define		AT_DMA_IF_BIGEND(i)	(0x1 << (i))	/* AHB-Lite Interface i in Big-endian mode */
-#define		AT_DMA_ARB_CFG	(0x1 << 4)	/* Arbiter mode. */
-#define			AT_DMA_ARB_CFG_FIXED		(0x0 << 4)
-#define			AT_DMA_ARB_CFG_ROUND_ROBIN	(0x1 << 4)
-
-#define	AT_DMA_EN	0x04	/* Controller Enable Register */
-#define		AT_DMA_ENABLE	(0x1 << 0)
-
-#define	AT_DMA_SREQ	0x08	/* Software Single Request Register */
-#define		AT_DMA_SSREQ(x)	(0x1 << ((x) << 1))		/* Request a source single transfer on channel x */
-#define		AT_DMA_DSREQ(x)	(0x1 << (1 + ((x) << 1)))	/* Request a destination single transfer on channel x */
-
-#define	AT_DMA_CREQ	0x0C	/* Software Chunk Transfer Request Register */
-#define		AT_DMA_SCREQ(x)	(0x1 << ((x) << 1))		/* Request a source chunk transfer on channel x */
-#define		AT_DMA_DCREQ(x)	(0x1 << (1 + ((x) << 1)))	/* Request a destination chunk transfer on channel x */
-
-#define	AT_DMA_LAST	0x10	/* Software Last Transfer Flag Register */
-#define		AT_DMA_SLAST(x)	(0x1 << ((x) << 1))		/* This src rq is last tx of buffer on channel x */
-#define		AT_DMA_DLAST(x)	(0x1 << (1 + ((x) << 1)))	/* This dst rq is last tx of buffer on channel x */
-
-#define	AT_DMA_SYNC	0x14	/* Request Synchronization Register */
-#define		AT_DMA_SYR(h)	(0x1 << (h))			/* Synchronize handshake line h */
-
-/* Error, Chained Buffer transfer completed and Buffer transfer completed Interrupt registers */
-#define	AT_DMA_EBCIER	0x18	/* Enable register */
-#define	AT_DMA_EBCIDR	0x1C	/* Disable register */
-#define	AT_DMA_EBCIMR	0x20	/* Mask Register */
-#define	AT_DMA_EBCISR	0x24	/* Status Register */
-#define		AT_DMA_CBTC_OFFSET	8
-#define		AT_DMA_ERR_OFFSET	16
-#define		AT_DMA_BTC(x)	(0x1 << (x))
-#define		AT_DMA_CBTC(x)	(0x1 << (AT_DMA_CBTC_OFFSET + (x)))
-#define		AT_DMA_ERR(x)	(0x1 << (AT_DMA_ERR_OFFSET + (x)))
-
-#define	AT_DMA_CHER	0x28	/* Channel Handler Enable Register */
-#define		AT_DMA_ENA(x)	(0x1 << (x))
-#define		AT_DMA_SUSP(x)	(0x1 << ( 8 + (x)))
-#define		AT_DMA_KEEP(x)	(0x1 << (24 + (x)))
-
-#define	AT_DMA_CHDR	0x2C	/* Channel Handler Disable Register */
-#define		AT_DMA_DIS(x)	(0x1 << (x))
-#define		AT_DMA_RES(x)	(0x1 << ( 8 + (x)))
-
-#define	AT_DMA_CHSR	0x30	/* Channel Handler Status Register */
-#define		AT_DMA_EMPT(x)	(0x1 << (16 + (x)))
-#define		AT_DMA_STAL(x)	(0x1 << (24 + (x)))
-
-
-#define	AT_DMA_CH_REGS_BASE	0x3C	/* Channel registers base address */
-#define	ch_regs(x)	(AT_DMA_CH_REGS_BASE + (x) * 0x28) /* Channel x base addr */
-
-/* Hardware register offset for each channel */
-#define	ATC_SADDR_OFFSET	0x00	/* Source Address Register */
-#define	ATC_DADDR_OFFSET	0x04	/* Destination Address Register */
-#define	ATC_DSCR_OFFSET		0x08	/* Descriptor Address Register */
-#define	ATC_CTRLA_OFFSET	0x0C	/* Control A Register */
-#define	ATC_CTRLB_OFFSET	0x10	/* Control B Register */
-#define	ATC_CFG_OFFSET		0x14	/* Configuration Register */
-#define	ATC_SPIP_OFFSET		0x18	/* Src PIP Configuration Register */
-#define	ATC_DPIP_OFFSET		0x1C	/* Dst PIP Configuration Register */
-
-
-/* Bitfield definitions */
-
-/* Bitfields in DSCR */
-#define	ATC_DSCR_IF(i)		(0x3 & (i))	/* Dsc feched via AHB-Lite Interface i */
-
-/* Bitfields in CTRLA */
-#define	ATC_BTSIZE_MAX		0xFFFFUL	/* Maximum Buffer Transfer Size */
-#define	ATC_BTSIZE(x)		(ATC_BTSIZE_MAX & (x)) /* Buffer Transfer Size */
-#define	ATC_SCSIZE_MASK		(0x7 << 16)	/* Source Chunk Transfer Size */
-#define		ATC_SCSIZE(x)		(ATC_SCSIZE_MASK & ((x) << 16))
-#define		ATC_SCSIZE_1		(0x0 << 16)
-#define		ATC_SCSIZE_4		(0x1 << 16)
-#define		ATC_SCSIZE_8		(0x2 << 16)
-#define		ATC_SCSIZE_16		(0x3 << 16)
-#define		ATC_SCSIZE_32		(0x4 << 16)
-#define		ATC_SCSIZE_64		(0x5 << 16)
-#define		ATC_SCSIZE_128		(0x6 << 16)
-#define		ATC_SCSIZE_256		(0x7 << 16)
-#define	ATC_DCSIZE_MASK		(0x7 << 20)	/* Destination Chunk Transfer Size */
-#define		ATC_DCSIZE(x)		(ATC_DCSIZE_MASK & ((x) << 20))
-#define		ATC_DCSIZE_1		(0x0 << 20)
-#define		ATC_DCSIZE_4		(0x1 << 20)
-#define		ATC_DCSIZE_8		(0x2 << 20)
-#define		ATC_DCSIZE_16		(0x3 << 20)
-#define		ATC_DCSIZE_32		(0x4 << 20)
-#define		ATC_DCSIZE_64		(0x5 << 20)
-#define		ATC_DCSIZE_128		(0x6 << 20)
-#define		ATC_DCSIZE_256		(0x7 << 20)
-#define	ATC_SRC_WIDTH_MASK	(0x3 << 24)	/* Source Single Transfer Size */
-#define		ATC_SRC_WIDTH(x)	((x) << 24)
-#define		ATC_SRC_WIDTH_BYTE	(0x0 << 24)
-#define		ATC_SRC_WIDTH_HALFWORD	(0x1 << 24)
-#define		ATC_SRC_WIDTH_WORD	(0x2 << 24)
-#define		ATC_REG_TO_SRC_WIDTH(r)	(((r) >> 24) & 0x3)
-#define	ATC_DST_WIDTH_MASK	(0x3 << 28)	/* Destination Single Transfer Size */
-#define		ATC_DST_WIDTH(x)	((x) << 28)
-#define		ATC_DST_WIDTH_BYTE	(0x0 << 28)
-#define		ATC_DST_WIDTH_HALFWORD	(0x1 << 28)
-#define		ATC_DST_WIDTH_WORD	(0x2 << 28)
-#define	ATC_DONE		(0x1 << 31)	/* Tx Done (only written back in descriptor) */
-
-/* Bitfields in CTRLB */
-#define	ATC_SIF(i)		(0x3 & (i))	/* Src tx done via AHB-Lite Interface i */
-#define	ATC_DIF(i)		((0x3 & (i)) <<  4)	/* Dst tx done via AHB-Lite Interface i */
-				  /* Specify AHB interfaces */
-#define AT_DMA_MEM_IF		0 /* interface 0 as memory interface */
-#define AT_DMA_PER_IF		1 /* interface 1 as peripheral interface */
-
-#define	ATC_SRC_PIP		(0x1 <<  8)	/* Source Picture-in-Picture enabled */
-#define	ATC_DST_PIP		(0x1 << 12)	/* Destination Picture-in-Picture enabled */
-#define	ATC_SRC_DSCR_DIS	(0x1 << 16)	/* Src Descriptor fetch disable */
-#define	ATC_DST_DSCR_DIS	(0x1 << 20)	/* Dst Descriptor fetch disable */
-#define	ATC_FC_MASK		(0x7 << 21)	/* Choose Flow Controller */
-#define		ATC_FC_MEM2MEM		(0x0 << 21)	/* Mem-to-Mem (DMA) */
-#define		ATC_FC_MEM2PER		(0x1 << 21)	/* Mem-to-Periph (DMA) */
-#define		ATC_FC_PER2MEM		(0x2 << 21)	/* Periph-to-Mem (DMA) */
-#define		ATC_FC_PER2PER		(0x3 << 21)	/* Periph-to-Periph (DMA) */
-#define		ATC_FC_PER2MEM_PER	(0x4 << 21)	/* Periph-to-Mem (Peripheral) */
-#define		ATC_FC_MEM2PER_PER	(0x5 << 21)	/* Mem-to-Periph (Peripheral) */
-#define		ATC_FC_PER2PER_SRCPER	(0x6 << 21)	/* Periph-to-Periph (Src Peripheral) */
-#define		ATC_FC_PER2PER_DSTPER	(0x7 << 21)	/* Periph-to-Periph (Dst Peripheral) */
-#define	ATC_SRC_ADDR_MODE_MASK	(0x3 << 24)
-#define		ATC_SRC_ADDR_MODE_INCR	(0x0 << 24)	/* Incrementing Mode */
-#define		ATC_SRC_ADDR_MODE_DECR	(0x1 << 24)	/* Decrementing Mode */
-#define		ATC_SRC_ADDR_MODE_FIXED	(0x2 << 24)	/* Fixed Mode */
-#define	ATC_DST_ADDR_MODE_MASK	(0x3 << 28)
-#define		ATC_DST_ADDR_MODE_INCR	(0x0 << 28)	/* Incrementing Mode */
-#define		ATC_DST_ADDR_MODE_DECR	(0x1 << 28)	/* Decrementing Mode */
-#define		ATC_DST_ADDR_MODE_FIXED	(0x2 << 28)	/* Fixed Mode */
-#define	ATC_IEN			(0x1 << 30)	/* BTC interrupt enable (active low) */
-#define	ATC_AUTO		(0x1 << 31)	/* Auto multiple buffer tx enable */
-
-/* Bitfields in CFG */
-#define ATC_PER_MSB(h)	((0x30U & (h)) >> 4)	/* Extract most significant bits of a handshaking identifier */
-
-#define	ATC_SRC_PER(h)		(0xFU & (h))	/* Channel src rq associated with periph handshaking ifc h */
-#define	ATC_DST_PER(h)		((0xFU & (h)) <<  4)	/* Channel dst rq associated with periph handshaking ifc h */
-#define	ATC_SRC_REP		(0x1 <<  8)	/* Source Replay Mod */
-#define	ATC_SRC_H2SEL		(0x1 <<  9)	/* Source Handshaking Mod */
-#define		ATC_SRC_H2SEL_SW	(0x0 <<  9)
-#define		ATC_SRC_H2SEL_HW	(0x1 <<  9)
-#define	ATC_SRC_PER_MSB(h)	(ATC_PER_MSB(h) << 10)	/* Channel src rq (most significant bits) */
-#define	ATC_DST_REP		(0x1 << 12)	/* Destination Replay Mod */
-#define	ATC_DST_H2SEL		(0x1 << 13)	/* Destination Handshaking Mod */
-#define		ATC_DST_H2SEL_SW	(0x0 << 13)
-#define		ATC_DST_H2SEL_HW	(0x1 << 13)
-#define	ATC_DST_PER_MSB(h)	(ATC_PER_MSB(h) << 14)	/* Channel dst rq (most significant bits) */
-#define	ATC_SOD			(0x1 << 16)	/* Stop On Done */
-#define	ATC_LOCK_IF		(0x1 << 20)	/* Interface Lock */
-#define	ATC_LOCK_B		(0x1 << 21)	/* AHB Bus Lock */
-#define	ATC_LOCK_IF_L		(0x1 << 22)	/* Master Interface Arbiter Lock */
-#define		ATC_LOCK_IF_L_CHUNK	(0x0 << 22)
-#define		ATC_LOCK_IF_L_BUFFER	(0x1 << 22)
-#define	ATC_AHB_PROT_MASK	(0x7 << 24)	/* AHB Protection */
-#define	ATC_FIFOCFG_MASK	(0x3 << 28)	/* FIFO Request Configuration */
-#define		ATC_FIFOCFG_LARGESTBURST	(0x0 << 28)
-#define		ATC_FIFOCFG_HALFFIFO		(0x1 << 28)
-#define		ATC_FIFOCFG_ENOUGHSPACE		(0x2 << 28)
-
-/* Bitfields in SPIP */
-#define	ATC_SPIP_HOLE(x)	(0xFFFFU & (x))
-#define	ATC_SPIP_BOUNDARY(x)	((0x3FF & (x)) << 16)
-
-/* Bitfields in DPIP */
-#define	ATC_DPIP_HOLE(x)	(0xFFFFU & (x))
-#define	ATC_DPIP_BOUNDARY(x)	((0x3FF & (x)) << 16)
-
-
-/*--  descriptors  -----------------------------------------------------*/
-
-/* LLI == Linked List Item; aka DMA buffer descriptor */
-struct at_lli {
-	/* values that are not changed by hardware */
-	u32 saddr;
-	u32 daddr;
-	/* value that may get written back: */
-	u32 ctrla;
-	/* more values that are not changed by hardware */
-	u32 ctrlb;
-	u32 dscr;	/* chain to next lli */
-};
-
-/**
- * struct at_desc - software descriptor
- * @at_lli: hardware lli structure
- * @txd: support for the async_tx api
- * @desc_node: node on the channed descriptors list
- * @len: descriptor byte count
- * @total_len: total transaction byte count
- */
-struct at_desc {
-	/* FIRST values the hardware uses */
-	struct at_lli			lli;
-
-	/* THEN values for driver housekeeping */
-	struct list_head		tx_list;
-	struct dma_async_tx_descriptor	txd;
-	struct list_head		desc_node;
-	size_t				len;
-	size_t				total_len;
-
-	/* Interleaved data */
-	size_t				boundary;
-	size_t				dst_hole;
-	size_t				src_hole;
-
-	/* Memset temporary buffer */
-	bool				memset_buffer;
-	dma_addr_t			memset_paddr;
-	int				*memset_vaddr;
-};
-
-static inline struct at_desc *
-txd_to_at_desc(struct dma_async_tx_descriptor *txd)
-{
-	return container_of(txd, struct at_desc, txd);
-}
-
-
-/*--  Channels  --------------------------------------------------------*/
-
-/**
- * atc_status - information bits stored in channel status flag
- *
- * Manipulated with atomic operations.
- */
-enum atc_status {
-	ATC_IS_ERROR = 0,
-	ATC_IS_PAUSED = 1,
-	ATC_IS_CYCLIC = 24,
-};
-
-/**
- * struct at_dma_chan - internal representation of an Atmel HDMAC channel
- * @chan_common: common dmaengine channel object members
- * @device: parent device
- * @ch_regs: memory mapped register base
- * @mask: channel index in a mask
- * @per_if: peripheral interface
- * @mem_if: memory interface
- * @status: transmit status information from irq/prep* functions
- *                to tasklet (use atomic operations)
- * @tasklet: bottom half to finish transaction work
- * @save_cfg: configuration register that is saved on suspend/resume cycle
- * @save_dscr: for cyclic operations, preserve next descriptor address in
- *             the cyclic list on suspend/resume cycle
- * @dma_sconfig: configuration for slave transfers, passed via
- * .device_config
- * @lock: serializes enqueue/dequeue operations to descriptors lists
- * @active_list: list of descriptors dmaengine is being running on
- * @queue: list of descriptors ready to be submitted to engine
- * @free_list: list of descriptors usable by the channel
- */
-struct at_dma_chan {
-	struct dma_chan		chan_common;
-	struct at_dma		*device;
-	void __iomem		*ch_regs;
-	u8			mask;
-	u8			per_if;
-	u8			mem_if;
-	unsigned long		status;
-	struct tasklet_struct	tasklet;
-	u32			save_cfg;
-	u32			save_dscr;
-	struct dma_slave_config dma_sconfig;
-
-	spinlock_t		lock;
-
-	/* these other elements are all protected by lock */
-	struct list_head	active_list;
-	struct list_head	queue;
-	struct list_head	free_list;
-};
-
-#define	channel_readl(atchan, name) \
-	__raw_readl((atchan)->ch_regs + ATC_##name##_OFFSET)
-
-#define	channel_writel(atchan, name, val) \
-	__raw_writel((val), (atchan)->ch_regs + ATC_##name##_OFFSET)
-
-static inline struct at_dma_chan *to_at_dma_chan(struct dma_chan *dchan)
-{
-	return container_of(dchan, struct at_dma_chan, chan_common);
-}
-
-/*
- * Fix sconfig's burst size according to at_hdmac. We need to convert them as:
- * 1 -> 0, 4 -> 1, 8 -> 2, 16 -> 3, 32 -> 4, 64 -> 5, 128 -> 6, 256 -> 7.
- *
- * This can be done by finding most significant bit set.
- */
-static inline void convert_burst(u32 *maxburst)
-{
-	if (*maxburst > 1)
-		*maxburst = fls(*maxburst) - 2;
-	else
-		*maxburst = 0;
-}
-
-/*
- * Fix sconfig's bus width according to at_hdmac.
- * 1 byte -> 0, 2 bytes -> 1, 4 bytes -> 2.
- */
-static inline u8 convert_buswidth(enum dma_slave_buswidth addr_width)
-{
-	switch (addr_width) {
-	case DMA_SLAVE_BUSWIDTH_2_BYTES:
-		return 1;
-	case DMA_SLAVE_BUSWIDTH_4_BYTES:
-		return 2;
-	default:
-		/* For 1 byte width or fallback */
-		return 0;
-	}
-}
-
-/*--  Controller  ------------------------------------------------------*/
-
-/**
- * struct at_dma - internal representation of an Atmel HDMA Controller
- * @chan_common: common dmaengine dma_device object members
- * @atdma_devtype: identifier of DMA controller compatibility
- * @ch_regs: memory mapped register base
- * @clk: dma controller clock
- * @save_imr: interrupt mask register that is saved on suspend/resume cycle
- * @all_chan_mask: all channels availlable in a mask
- * @dma_desc_pool: base of DMA descriptor region (DMA address)
- * @chan: channels table to store at_dma_chan structures
- */
-struct at_dma {
-	struct dma_device	dma_common;
-	void __iomem		*regs;
-	struct clk		*clk;
-	u32			save_imr;
-
-	u8			all_chan_mask;
-
-	struct dma_pool		*dma_desc_pool;
-	struct dma_pool		*memset_pool;
-	/* AT THE END channels table */
-	struct at_dma_chan	chan[];
-};
-
-#define	dma_readl(atdma, name) \
-	__raw_readl((atdma)->regs + AT_DMA_##name)
-#define	dma_writel(atdma, name, val) \
-	__raw_writel((val), (atdma)->regs + AT_DMA_##name)
-
-static inline struct at_dma *to_at_dma(struct dma_device *ddev)
-{
-	return container_of(ddev, struct at_dma, dma_common);
-}
-
-
-/*--  Helper functions  ------------------------------------------------*/
-
-static struct device *chan2dev(struct dma_chan *chan)
-{
-	return &chan->dev->device;
-}
-
-#if defined(VERBOSE_DEBUG)
-static void vdbg_dump_regs(struct at_dma_chan *atchan)
-{
-	struct at_dma	*atdma = to_at_dma(atchan->chan_common.device);
-
-	dev_err(chan2dev(&atchan->chan_common),
-		"  channel %d : imr = 0x%x, chsr = 0x%x\n",
-		atchan->chan_common.chan_id,
-		dma_readl(atdma, EBCIMR),
-		dma_readl(atdma, CHSR));
-
-	dev_err(chan2dev(&atchan->chan_common),
-		"  channel: s0x%x d0x%x ctrl0x%x:0x%x cfg0x%x l0x%x\n",
-		channel_readl(atchan, SADDR),
-		channel_readl(atchan, DADDR),
-		channel_readl(atchan, CTRLA),
-		channel_readl(atchan, CTRLB),
-		channel_readl(atchan, CFG),
-		channel_readl(atchan, DSCR));
-}
-#else
-static void vdbg_dump_regs(struct at_dma_chan *atchan) {}
-#endif
-
-static void atc_dump_lli(struct at_dma_chan *atchan, struct at_lli *lli)
-{
-	dev_crit(chan2dev(&atchan->chan_common),
-		 "desc: s%pad d%pad ctrl0x%x:0x%x l%pad\n",
-		 &lli->saddr, &lli->daddr,
-		 lli->ctrla, lli->ctrlb, &lli->dscr);
-}
-
-
-static void atc_setup_irq(struct at_dma *atdma, int chan_id, int on)
-{
-	u32 ebci;
-
-	/* enable interrupts on buffer transfer completion & error */
-	ebci =    AT_DMA_BTC(chan_id)
-		| AT_DMA_ERR(chan_id);
-	if (on)
-		dma_writel(atdma, EBCIER, ebci);
-	else
-		dma_writel(atdma, EBCIDR, ebci);
-}
-
-static void atc_enable_chan_irq(struct at_dma *atdma, int chan_id)
-{
-	atc_setup_irq(atdma, chan_id, 1);
-}
-
-static void atc_disable_chan_irq(struct at_dma *atdma, int chan_id)
-{
-	atc_setup_irq(atdma, chan_id, 0);
-}
-
-
-/**
- * atc_chan_is_enabled - test if given channel is enabled
- * @atchan: channel we want to test status
- */
-static inline int atc_chan_is_enabled(struct at_dma_chan *atchan)
-{
-	struct at_dma	*atdma = to_at_dma(atchan->chan_common.device);
-
-	return !!(dma_readl(atdma, CHSR) & atchan->mask);
-}
-
-/**
- * atc_chan_is_paused - test channel pause/resume status
- * @atchan: channel we want to test status
- */
-static inline int atc_chan_is_paused(struct at_dma_chan *atchan)
-{
-	return test_bit(ATC_IS_PAUSED, &atchan->status);
-}
-
-/**
- * atc_chan_is_cyclic - test if given channel has cyclic property set
- * @atchan: channel we want to test status
- */
-static inline int atc_chan_is_cyclic(struct at_dma_chan *atchan)
-{
-	return test_bit(ATC_IS_CYCLIC, &atchan->status);
-}
-
-/**
- * set_desc_eol - set end-of-link to descriptor so it will end transfer
- * @desc: descriptor, signle or at the end of a chain, to end chain on
- */
-static void set_desc_eol(struct at_desc *desc)
-{
-	u32 ctrlb = desc->lli.ctrlb;
-
-	ctrlb &= ~ATC_IEN;
-	ctrlb |= ATC_SRC_DSCR_DIS | ATC_DST_DSCR_DIS;
-
-	desc->lli.ctrlb = ctrlb;
-	desc->lli.dscr = 0;
-}
-
-#endif /* AT_HDMAC_REGS_H */
-- 
2.25.1

