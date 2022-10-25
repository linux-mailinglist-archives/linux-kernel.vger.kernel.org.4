Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABFA60C79D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJYJJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiJYJIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:08:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E621C1633B2;
        Tue, 25 Oct 2022 02:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666688690; x=1698224690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XkCIcuyoRQdx86jyITgaYhcRVOpc1kw4bzicnB/+A5g=;
  b=CfKlyeJbYJJo2FNuycphTwokTYxtaqiqhAJo1vtnQeOzFjdyJGkHzQcB
   xQng5UUHTnTkzPkVjEGkMY48Imv4Fxa1hST81L7VN2w+bPEiEVOm75oQ6
   5xmDg+W5XFko1mag34DpOxWRK/c2xNzkHRylPrH6Y1C+3y0i/OOyYGBAb
   YQf81Y4VyQoaovIQUASrtGHAuOe0LKbjz7U3ZZkdy6HGyqJ/JN6ptKEed
   JBFSon41vjWTnBMpltLKj2RlVh/0+XDiTpSlT6RYeEpyNOqlrl6GiyS35
   j+x7XWLAdYJM0n+WDnxyCuj5qQQiBxscO2gtWwiUcHaTN+sr2ee8l0SPk
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="183777439"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2022 02:04:49 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 25 Oct 2022 02:04:46 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 25 Oct 2022 02:04:44 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>
CC:     <maciej.sosnowski@intel.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <torfl6749@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v2 32/32] dmaengine: at_hdmac: Convert driver to use virt-dma
Date:   Tue, 25 Oct 2022 12:03:06 +0300
Message-ID: <20221025090306.297886-33-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025090306.297886-1-tudor.ambarus@microchip.com>
References: <20221025090306.297886-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the driver to use the core virt-dma. The driver will be easier to
maintain as it uses the list handling and the tasklet from virt-dma.

With the conversion replace the election of a new transfer in the tasklet
with the election of the new transfer in the interrupt handler. With this
we have a shorter idle window as we remove the scheduling latency of the
tasklet. I chose to do this while doing the conversion to virt-dma,
because if I made a prerequisite patch with the new transfer election in
the irq handler, I would have to duplicate some virt-dma code in the
at_hdmac driver that would end up being removed at the virt-dma conversion
anyway. So do this in a single step.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/Kconfig    |    1 +
 drivers/dma/at_hdmac.c | 1108 +++++++++++++++-------------------------
 2 files changed, 403 insertions(+), 706 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index b73fc89ba877..80848c6b5cd5 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -97,6 +97,7 @@ config AT_HDMAC
 	tristate "Atmel AHB DMA support"
 	depends on ARCH_AT91
 	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
 	help
 	  Support the Atmel AHB DMA controller.
 
diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 143d75c18d1e..8858470246e1 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -3,6 +3,7 @@
  * Driver for the Atmel AHB DMA Controller (aka HDMA or DMAC on AT91 systems)
  *
  * Copyright (C) 2008 Atmel Corporation
+ * Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
  *
  * This supports the Atmel AHB DMA Controller found in several Atmel SoCs.
  * The only Atmel DMA Controller that is not covered by this driver is the one
@@ -25,6 +26,7 @@
 #include <linux/slab.h>
 
 #include "dmaengine.h"
+#include "virt-dma.h"
 
 /*
  * Glossary
@@ -200,25 +202,31 @@ struct at_lli {
 	u32 dscr;	/* chain to next lli */
 };
 
+/**
+ * struct atdma_sg - atdma scatter gather entry
+ * @len: length of the current Linked List Item.
+ * @lli: linked list item that is passed to the DMA controller
+ * @lli_phys: physical address of the LLI.
+ */
+struct atdma_sg {
+	unsigned int len;
+	struct at_lli *lli;
+	dma_addr_t lli_phys;
+};
+
 /**
  * struct at_desc - software descriptor
- * @at_lli: hardware lli structure
- * @txd: support for the async_tx api
- * @desc_node: node on the channed descriptors list
- * @len: descriptor byte count
+ * @vd: pointer to the virtual dma descriptor.
+ * @atchan: pointer to the atmel dma channel.
  * @total_len: total transaction byte count
+ * @sg_len: number of sg entries.
+ * @sg: array of sgs.
  */
 struct at_desc {
-	/* FIRST values the hardware uses */
-	struct at_lli			lli;
-
-	/* THEN values for driver housekeeping */
-	struct list_head		tx_list;
-	struct dma_async_tx_descriptor	txd;
-	struct list_head		desc_node;
-	size_t				len;
+	struct				virt_dma_desc vd;
+	struct				at_dma_chan *atchan;
 	size_t				total_len;
-
+	unsigned int			sglen;
 	/* Interleaved data */
 	size_t				boundary;
 	size_t				dst_hole;
@@ -228,15 +236,9 @@ struct at_desc {
 	bool				memset_buffer;
 	dma_addr_t			memset_paddr;
 	int				*memset_vaddr;
+	struct atdma_sg			sg[];
 };
 
-static inline struct at_desc *
-txd_to_at_desc(struct dma_async_tx_descriptor *txd)
-{
-	return container_of(txd, struct at_desc, txd);
-}
-
-
 /*--  Channels  --------------------------------------------------------*/
 
 /**
@@ -245,49 +247,40 @@ txd_to_at_desc(struct dma_async_tx_descriptor *txd)
  * Manipulated with atomic operations.
  */
 enum atc_status {
-	ATC_IS_ERROR = 0,
 	ATC_IS_PAUSED = 1,
 	ATC_IS_CYCLIC = 24,
 };
 
 /**
  * struct at_dma_chan - internal representation of an Atmel HDMAC channel
- * @dma_chan: common dmaengine channel object members
+ * @vc: virtual dma channel entry.
+ * @atdma: pointer to the driver data.
  * @ch_regs: memory mapped register base
  * @mask: channel index in a mask
  * @per_if: peripheral interface
  * @mem_if: memory interface
  * @status: transmit status information from irq/prep* functions
  *                to tasklet (use atomic operations)
- * @tasklet: bottom half to finish transaction work
  * @save_cfg: configuration register that is saved on suspend/resume cycle
  * @save_dscr: for cyclic operations, preserve next descriptor address in
  *             the cyclic list on suspend/resume cycle
  * @dma_sconfig: configuration for slave transfers, passed via
  * .device_config
- * @lock: serializes enqueue/dequeue operations to descriptors lists
- * @active_list: list of descriptors dmaengine is being running on
- * @queue: list of descriptors ready to be submitted to engine
- * @free_list: list of descriptors usable by the channel
+ * @desc: pointer to the atmel dma descriptor.
  */
 struct at_dma_chan {
-	struct dma_chan		dma_chan;
+	struct virt_dma_chan	vc;
+	struct at_dma		*atdma;
 	void __iomem		*ch_regs;
 	u8			mask;
 	u8			per_if;
 	u8			mem_if;
 	unsigned long		status;
-	struct tasklet_struct	tasklet;
 	u32			save_cfg;
 	u32			save_dscr;
-	struct dma_slave_config dma_sconfig;
-
-	spinlock_t		lock;
-
-	/* these other elements are all protected by lock */
-	struct list_head	active_list;
-	struct list_head	queue;
-	struct list_head	free_list;
+	struct dma_slave_config	dma_sconfig;
+	bool			cyclic;
+	struct at_desc		*desc;
 };
 
 #define	channel_readl(atchan, name) \
@@ -296,11 +289,6 @@ struct at_dma_chan {
 #define	channel_writel(atchan, name, val) \
 	__raw_writel((val), (atchan)->ch_regs + ATC_##name##_OFFSET)
 
-static inline struct at_dma_chan *to_at_dma_chan(struct dma_chan *dchan)
-{
-	return container_of(dchan, struct at_dma_chan, dma_chan);
-}
-
 /*
  * Fix sconfig's burst size according to at_hdmac. We need to convert them as:
  * 1 -> 0, 4 -> 1, 8 -> 2, 16 -> 3, 32 -> 4, 64 -> 5, 128 -> 6, 256 -> 7.
@@ -342,7 +330,7 @@ static inline u8 convert_buswidth(enum dma_slave_buswidth addr_width)
  * @clk: dma controller clock
  * @save_imr: interrupt mask register that is saved on suspend/resume cycle
  * @all_chan_mask: all channels availlable in a mask
- * @dma_desc_pool: base of DMA descriptor region (DMA address)
+ * @lli_pool: hw lli table
  * @chan: channels table to store at_dma_chan structures
  */
 struct at_dma {
@@ -353,7 +341,7 @@ struct at_dma {
 
 	u8			all_chan_mask;
 
-	struct dma_pool		*dma_desc_pool;
+	struct dma_pool		*lli_pool;
 	struct dma_pool		*memset_pool;
 	/* AT THE END channels table */
 	struct at_dma_chan	chan[];
@@ -364,6 +352,16 @@ struct at_dma {
 #define	dma_writel(atdma, name, val) \
 	__raw_writel((val), (atdma)->regs + AT_DMA_##name)
 
+static inline struct at_desc *to_atdma_desc(struct dma_async_tx_descriptor *t)
+{
+	return container_of(t, struct at_desc, vd.tx);
+}
+
+static inline struct at_dma_chan *to_at_dma_chan(struct dma_chan *chan)
+{
+	return container_of(chan, struct at_dma_chan, vc.chan);
+}
+
 static inline struct at_dma *to_at_dma(struct dma_device *ddev)
 {
 	return container_of(ddev, struct at_dma, dma_device);
@@ -380,15 +378,15 @@ static struct device *chan2dev(struct dma_chan *chan)
 #if defined(VERBOSE_DEBUG)
 static void vdbg_dump_regs(struct at_dma_chan *atchan)
 {
-	struct at_dma	*atdma = to_at_dma(atchan->dma_chan.device);
+	struct at_dma	*atdma = to_at_dma(atchan->vc.chan.device);
 
-	dev_err(chan2dev(&atchan->dma_chan),
+	dev_err(chan2dev(&atchan->vc.chan),
 		"  channel %d : imr = 0x%x, chsr = 0x%x\n",
-		atchan->dma_chan.chan_id,
+		atchan->vc.chan.chan_id,
 		dma_readl(atdma, EBCIMR),
 		dma_readl(atdma, CHSR));
 
-	dev_err(chan2dev(&atchan->dma_chan),
+	dev_err(chan2dev(&atchan->vc.chan),
 		"  channel: s0x%x d0x%x ctrl0x%x:0x%x cfg0x%x l0x%x\n",
 		channel_readl(atchan, SADDR),
 		channel_readl(atchan, DADDR),
@@ -403,7 +401,7 @@ static void vdbg_dump_regs(struct at_dma_chan *atchan) {}
 
 static void atc_dump_lli(struct at_dma_chan *atchan, struct at_lli *lli)
 {
-	dev_crit(chan2dev(&atchan->dma_chan),
+	dev_crit(chan2dev(&atchan->vc.chan),
 		 "desc: s%pad d%pad ctrl0x%x:0x%x l%pad\n",
 		 &lli->saddr, &lli->daddr,
 		 lli->ctrla, lli->ctrlb, &lli->dscr);
@@ -440,7 +438,7 @@ static void atc_disable_chan_irq(struct at_dma *atdma, int chan_id)
  */
 static inline int atc_chan_is_enabled(struct at_dma_chan *atchan)
 {
-	struct at_dma	*atdma = to_at_dma(atchan->dma_chan.device);
+	struct at_dma *atdma = to_at_dma(atchan->vc.chan.device);
 
 	return !!(dma_readl(atdma, CHSR) & atchan->mask);
 }
@@ -464,18 +462,19 @@ static inline int atc_chan_is_cyclic(struct at_dma_chan *atchan)
 }
 
 /**
- * set_desc_eol - set end-of-link to descriptor so it will end transfer
+ * set_lli_eol - set end-of-link to descriptor so it will end transfer
  * @desc: descriptor, signle or at the end of a chain, to end chain on
+ * @i: index of the atmel scatter gather entry that is at the end of the chain.
  */
-static void set_desc_eol(struct at_desc *desc)
+static void set_lli_eol(struct at_desc *desc, unsigned int i)
 {
-	u32 ctrlb = desc->lli.ctrlb;
+	u32 ctrlb = desc->sg[i].lli->ctrlb;
 
 	ctrlb &= ~ATC_IEN;
 	ctrlb |= ATC_SRC_DSCR_DIS | ATC_DST_DSCR_DIS;
 
-	desc->lli.ctrlb = ctrlb;
-	desc->lli.dscr = 0;
+	desc->sg[i].lli->ctrlb = ctrlb;
+	desc->sg[i].lli->dscr = 0;
 }
 
 #define	ATC_DEFAULT_CFG		FIELD_PREP(ATC_FIFOCFG, ATC_FIFOCFG_HALFFIFO)
@@ -518,13 +517,6 @@ struct at_dma_slave {
 	u32			cfg;
 };
 
-/* prototypes */
-static dma_cookie_t atc_tx_submit(struct dma_async_tx_descriptor *tx);
-static void atc_issue_pending(struct dma_chan *chan);
-
-
-/*----------------------------------------------------------------------*/
-
 static inline unsigned int atc_get_xfer_width(dma_addr_t src, dma_addr_t dst,
 						size_t len)
 {
@@ -540,196 +532,72 @@ static inline unsigned int atc_get_xfer_width(dma_addr_t src, dma_addr_t dst,
 	return width;
 }
 
-static struct at_desc *atc_first_active(struct at_dma_chan *atchan)
+static void atdma_lli_chain(struct at_desc *desc, unsigned int i)
 {
-	return list_first_entry(&atchan->active_list,
-				struct at_desc, desc_node);
-}
+	struct atdma_sg *atdma_sg = &desc->sg[i];
 
-static struct at_desc *atc_first_queued(struct at_dma_chan *atchan)
-{
-	return list_first_entry(&atchan->queue,
-				struct at_desc, desc_node);
-}
-
-/**
- * atc_alloc_descriptor - allocate and return an initialized descriptor
- * @chan: the channel to allocate descriptors for
- * @gfp_flags: GFP allocation flags
- *
- * Note: The ack-bit is positioned in the descriptor flag at creation time
- *       to make initial allocation more convenient. This bit will be cleared
- *       and control will be given to client at usage time (during
- *       preparation functions).
- */
-static struct at_desc *atc_alloc_descriptor(struct dma_chan *chan,
-					    gfp_t gfp_flags)
-{
-	struct at_desc	*desc = NULL;
-	struct at_dma	*atdma = to_at_dma(chan->device);
-	dma_addr_t phys;
-
-	desc = dma_pool_zalloc(atdma->dma_desc_pool, gfp_flags, &phys);
-	if (desc) {
-		INIT_LIST_HEAD(&desc->tx_list);
-		dma_async_tx_descriptor_init(&desc->txd, chan);
-		/* txd.flags will be overwritten in prep functions */
-		desc->txd.flags = DMA_CTRL_ACK;
-		desc->txd.tx_submit = atc_tx_submit;
-		desc->txd.phys = phys;
-	}
-
-	return desc;
-}
-
-/**
- * atc_desc_get - get an unused descriptor from free_list
- * @atchan: channel we want a new descriptor for
- */
-static struct at_desc *atc_desc_get(struct at_dma_chan *atchan)
-{
-	struct at_desc *desc, *_desc;
-	struct at_desc *ret = NULL;
-	unsigned long flags;
-	unsigned int i = 0;
-
-	spin_lock_irqsave(&atchan->lock, flags);
-	list_for_each_entry_safe(desc, _desc, &atchan->free_list, desc_node) {
-		i++;
-		if (async_tx_test_ack(&desc->txd)) {
-			list_del(&desc->desc_node);
-			ret = desc;
-			break;
-		}
-		dev_dbg(chan2dev(&atchan->dma_chan),
-				"desc %p not ACKed\n", desc);
-	}
-	spin_unlock_irqrestore(&atchan->lock, flags);
-	dev_vdbg(chan2dev(&atchan->dma_chan),
-		"scanned %u descriptors on freelist\n", i);
-
-	/* no more descriptor available in initial pool: create one more */
-	if (!ret)
-		ret = atc_alloc_descriptor(&atchan->dma_chan, GFP_NOWAIT);
-
-	return ret;
-}
-
-/**
- * atc_desc_put - move a descriptor, including any children, to the free list
- * @atchan: channel we work on
- * @desc: descriptor, at the head of a chain, to move to free list
- */
-static void atc_desc_put(struct at_dma_chan *atchan, struct at_desc *desc)
-{
-	if (desc) {
-		struct at_desc *child;
-		unsigned long flags;
-
-		spin_lock_irqsave(&atchan->lock, flags);
-		list_for_each_entry(child, &desc->tx_list, desc_node)
-			dev_vdbg(chan2dev(&atchan->dma_chan),
-					"moving child desc %p to freelist\n",
-					child);
-		list_splice_init(&desc->tx_list, &atchan->free_list);
-		dev_vdbg(chan2dev(&atchan->dma_chan),
-			 "moving desc %p to freelist\n", desc);
-		list_add(&desc->desc_node, &atchan->free_list);
-		spin_unlock_irqrestore(&atchan->lock, flags);
-	}
-}
-
-/**
- * atc_desc_chain - build chain adding a descriptor
- * @first: address of first descriptor of the chain
- * @prev: address of previous descriptor of the chain
- * @desc: descriptor to queue
- *
- * Called from prep_* functions
- */
-static void atc_desc_chain(struct at_desc **first, struct at_desc **prev,
-			   struct at_desc *desc)
-{
-	if (!(*first)) {
-		*first = desc;
-	} else {
-		/* inform the HW lli about chaining */
-		(*prev)->lli.dscr = desc->txd.phys;
-		/* insert the link descriptor to the LD ring */
-		list_add_tail(&desc->desc_node,
-				&(*first)->tx_list);
-	}
-	*prev = desc;
+	if (i)
+		desc->sg[i - 1].lli->dscr = atdma_sg->lli_phys;
 }
 
 /**
  * atc_dostart - starts the DMA engine for real
  * @atchan: the channel we want to start
- * @first: first descriptor in the list we want to begin with
- *
- * Called with atchan->lock held and bh disabled
  */
-static void atc_dostart(struct at_dma_chan *atchan, struct at_desc *first)
+static void atc_dostart(struct at_dma_chan *atchan)
 {
-	struct at_dma	*atdma = to_at_dma(atchan->dma_chan.device);
+	struct virt_dma_desc *vd = vchan_next_desc(&atchan->vc);
+	struct at_desc *desc;
 
-	/* ASSERT:  channel is idle */
-	if (atc_chan_is_enabled(atchan)) {
-		dev_err(chan2dev(&atchan->dma_chan),
-			"BUG: Attempted to start non-idle channel\n");
-		dev_err(chan2dev(&atchan->dma_chan),
-			"  channel: s0x%x d0x%x ctrl0x%x:0x%x l0x%x\n",
-			channel_readl(atchan, SADDR),
-			channel_readl(atchan, DADDR),
-			channel_readl(atchan, CTRLA),
-			channel_readl(atchan, CTRLB),
-			channel_readl(atchan, DSCR));
-
-		/* The tasklet will hopefully advance the queue... */
+	if (!vd) {
+		atchan->desc = NULL;
 		return;
 	}
 
 	vdbg_dump_regs(atchan);
 
+	list_del(&vd->node);
+	atchan->desc = desc = to_atdma_desc(&vd->tx);
+
 	channel_writel(atchan, SADDR, 0);
 	channel_writel(atchan, DADDR, 0);
 	channel_writel(atchan, CTRLA, 0);
 	channel_writel(atchan, CTRLB, 0);
-	channel_writel(atchan, DSCR, first->txd.phys);
-	channel_writel(atchan, SPIP, FIELD_PREP(ATC_SPIP_HOLE,
-						first->src_hole) |
-		       FIELD_PREP(ATC_SPIP_BOUNDARY, first->boundary));
-	channel_writel(atchan, DPIP, FIELD_PREP(ATC_DPIP_HOLE,
-						first->dst_hole) |
-		       FIELD_PREP(ATC_DPIP_BOUNDARY, first->boundary));
+	channel_writel(atchan, DSCR, desc->sg[0].lli_phys);
+	channel_writel(atchan, SPIP,
+		       FIELD_PREP(ATC_SPIP_HOLE, desc->src_hole) |
+		       FIELD_PREP(ATC_SPIP_BOUNDARY, desc->boundary));
+	channel_writel(atchan, DPIP,
+		       FIELD_PREP(ATC_DPIP_HOLE, desc->dst_hole) |
+		       FIELD_PREP(ATC_DPIP_BOUNDARY, desc->boundary));
+
 	/* Don't allow CPU to reorder channel enable. */
 	wmb();
-	dma_writel(atdma, CHER, atchan->mask);
+	dma_writel(atchan->atdma, CHER, atchan->mask);
 
 	vdbg_dump_regs(atchan);
 }
 
-/*
- * atc_get_desc_by_cookie - get the descriptor of a cookie
- * @atchan: the DMA channel
- * @cookie: the cookie to get the descriptor for
- */
-static struct at_desc *atc_get_desc_by_cookie(struct at_dma_chan *atchan,
-						dma_cookie_t cookie)
+static void atdma_desc_free(struct virt_dma_desc *vd)
 {
-	struct at_desc *desc, *_desc;
+	struct at_dma *atdma = to_at_dma(vd->tx.chan->device);
+	struct at_desc *desc = to_atdma_desc(&vd->tx);
+	unsigned int i;
 
-	list_for_each_entry_safe(desc, _desc, &atchan->queue, desc_node) {
-		if (desc->txd.cookie == cookie)
-			return desc;
+	for (i = 0; i < desc->sglen; i++) {
+		if (desc->sg[i].lli)
+			dma_pool_free(atdma->lli_pool, desc->sg[i].lli,
+				      desc->sg[i].lli_phys);
 	}
 
-	list_for_each_entry_safe(desc, _desc, &atchan->active_list, desc_node) {
-		if (desc->txd.cookie == cookie)
-			return desc;
+	/* If the transfer was a memset, free our temporary buffer */
+	if (desc->memset_buffer) {
+		dma_pool_free(atdma->memset_pool, desc->memset_vaddr,
+			      desc->memset_paddr);
+		desc->memset_buffer = false;
 	}
 
-	return NULL;
+	kfree(desc);
 }
 
 /**
@@ -756,20 +624,19 @@ static inline u32 atc_calc_bytes_left(u32 current_len, u32 ctrla)
 /**
  * atc_get_llis_residue - Get residue for a hardware linked list transfer
  *
- * Calculate the residue by removing the length of the child descriptors already
- * transferred from the total length. To get the current child descriptor we can
- * use the value of the channel's DSCR register and compare it against the value
- * of the hardware linked list structure of each child descriptor.
+ * Calculate the residue by removing the length of the Linked List Item (LLI)
+ * already transferred from the total length. To get the current LLI we can use
+ * the value of the channel's DSCR register and compare it against the DSCR
+ * value of each LLI.
  *
  * The CTRLA register provides us with the amount of data already read from the
- * source for the current child descriptor. So we can compute a more accurate
- * residue by also removing the number of bytes corresponding to this amount of
- * data.
+ * source for the LLI. So we can compute a more accurate residue by also
+ * removing the number of bytes corresponding to this amount of data.
  *
  * However, the DSCR and CTRLA registers cannot be read both atomically. Hence a
- * race condition may occur: the first read register may refer to one child
- * descriptor whereas the second read may refer to a later child descriptor in
- * the list because of the DMA transfer progression inbetween the two reads.
+ * race condition may occur: the first read register may refer to one LLI
+ * whereas the second read may refer to a later LLI in the list because of the
+ * DMA transfer progression inbetween the two reads.
  *
  * One solution could have been to pause the DMA transfer, read the DSCR and
  * CTRLA then resume the DMA transfer. Nonetheless, this approach presents some
@@ -786,12 +653,11 @@ static inline u32 atc_calc_bytes_left(u32 current_len, u32 ctrla)
  * Then we'd rather use another solution: the DSCR is read a first time, the
  * CTRLA is read in turn, next the DSCR is read a second time. If the two
  * consecutive read values of the DSCR are the same then we assume both refers
- * to the very same child descriptor as well as the CTRLA value read inbetween
- * does. For cyclic tranfers, the assumption is that a full loop is "not so
- * fast". If the two DSCR values are different, we read again the CTRLA then the
- * DSCR till two consecutive read values from DSCR are equal or till the
- * maximum trials is reach. This algorithm is very unlikely not to find a stable
- * value for DSCR.
+ * to the very same LLI as well as the CTRLA value read inbetween does. For
+ * cyclic tranfers, the assumption is that a full loop is "not so fast". If the
+ * two DSCR values are different, we read again the CTRLA then the DSCR till two
+ * consecutive read values from DSCR are equal or till the maximum trials is
+ * reach. This algorithm is very unlikely not to find a stable value for DSCR.
  * @atchan: pointer to an atmel hdmac channel.
  * @desc: pointer to the descriptor for which the residue is calculated.
  * @residue: residue to be set to dma_tx_state.
@@ -800,7 +666,6 @@ static inline u32 atc_calc_bytes_left(u32 current_len, u32 ctrla)
 static int atc_get_llis_residue(struct at_dma_chan *atchan,
 				struct at_desc *desc, u32 *residue)
 {
-	struct at_desc *child;
 	u32 len, ctrla, dscr;
 	unsigned int i;
 
@@ -836,24 +701,25 @@ static int atc_get_llis_residue(struct at_dma_chan *atchan,
 		return -ETIMEDOUT;
 
 	/* For the first descriptor we can be more accurate. */
-	if (desc->lli.dscr == dscr) {
+	if (desc->sg[0].lli->dscr == dscr) {
 		*residue = atc_calc_bytes_left(len, ctrla);
 		return 0;
 	}
+	len -= desc->sg[0].len;
 
-	len -= desc->len;
-	list_for_each_entry(child, &desc->tx_list, desc_node) {
-		if (child->lli.dscr == dscr)
+	for (i = 1; i < desc->sglen; i++) {
+		if (desc->sg[i].lli && desc->sg[i].lli->dscr == dscr)
 			break;
-		len -= child->len;
+		len -= desc->sg[i].len;
 	}
 
 	/*
-	 * For the current descriptor in the chain we can calculate the
-	 * remaining bytes using the channel's register.
+	 * For the current LLI in the chain we can calculate the remaining bytes
+	 * using the channel's CTRLA register.
 	 */
 	*residue = atc_calc_bytes_left(len, ctrla);
 	return 0;
+
 }
 
 /**
@@ -867,139 +733,42 @@ static int atc_get_llis_residue(struct at_dma_chan *atchan,
 static int atc_get_residue(struct dma_chan *chan, dma_cookie_t cookie,
 			   u32 *residue)
 {
-	struct at_dma_chan      *atchan = to_at_dma_chan(chan);
-	struct at_desc *desc_first = atc_first_active(atchan);
-	struct at_desc *desc;
+	struct at_dma_chan *atchan = to_at_dma_chan(chan);
+	struct virt_dma_desc *vd;
+	struct at_desc *desc = NULL;
 	u32 len, ctrla;
 
-	/*
-	 * If the cookie doesn't match to the currently running transfer then
-	 * we can return the total length of the associated DMA transfer,
-	 * because it is still queued.
-	 */
-	desc = atc_get_desc_by_cookie(atchan, cookie);
-	if (desc == NULL)
+	vd = vchan_find_desc(&atchan->vc, cookie);
+	if (vd)
+		desc = to_atdma_desc(&vd->tx);
+	else if (atchan->desc && atchan->desc->vd.tx.cookie == cookie)
+		desc = atchan->desc;
+
+	if (!desc)
 		return -EINVAL;
-	else if (desc != desc_first)
-		return desc->total_len;
 
-	if (desc_first->lli.dscr)
+	if (desc->sg[0].lli->dscr)
 		/* hardware linked list transfer */
-		return atc_get_llis_residue(atchan, desc_first, residue);
+		return atc_get_llis_residue(atchan, desc, residue);
 
 	/* single transfer */
-	len = desc_first->total_len;
+	len = desc->total_len;
 	ctrla = channel_readl(atchan, CTRLA);
 	*residue = atc_calc_bytes_left(len, ctrla);
 	return 0;
 }
 
-/**
- * atc_chain_complete - finish work for one transaction chain
- * @atchan: channel we work on
- * @desc: descriptor at the head of the chain we want do complete
- */
-static void
-atc_chain_complete(struct at_dma_chan *atchan, struct at_desc *desc)
-{
-	struct dma_async_tx_descriptor	*txd = &desc->txd;
-	struct at_dma			*atdma = to_at_dma(atchan->dma_chan.device);
-	unsigned long flags;
-
-	dev_vdbg(chan2dev(&atchan->dma_chan),
-		"descriptor %u complete\n", txd->cookie);
-
-	spin_lock_irqsave(&atchan->lock, flags);
-
-	/* mark the descriptor as complete for non cyclic cases only */
-	if (!atc_chan_is_cyclic(atchan))
-		dma_cookie_complete(txd);
-
-	spin_unlock_irqrestore(&atchan->lock, flags);
-
-	dma_descriptor_unmap(txd);
-	/* for cyclic transfers,
-	 * no need to replay callback function while stopping */
-	if (!atc_chan_is_cyclic(atchan))
-		dmaengine_desc_get_callback_invoke(txd, NULL);
-
-	dma_run_dependencies(txd);
-
-	spin_lock_irqsave(&atchan->lock, flags);
-	/* move children to free_list */
-	list_splice_init(&desc->tx_list, &atchan->free_list);
-	/* add myself to free_list */
-	list_add(&desc->desc_node, &atchan->free_list);
-	spin_unlock_irqrestore(&atchan->lock, flags);
-
-	/* If the transfer was a memset, free our temporary buffer */
-	if (desc->memset_buffer) {
-		dma_pool_free(atdma->memset_pool, desc->memset_vaddr,
-			      desc->memset_paddr);
-		desc->memset_buffer = false;
-	}
-}
-
-/**
- * atc_advance_work - at the end of a transaction, move forward
- * @atchan: channel where the transaction ended
- */
-static void atc_advance_work(struct at_dma_chan *atchan)
-{
-	struct at_desc *desc;
-	unsigned long flags;
-
-	dev_vdbg(chan2dev(&atchan->dma_chan), "advance_work\n");
-
-	spin_lock_irqsave(&atchan->lock, flags);
-	if (atc_chan_is_enabled(atchan) || list_empty(&atchan->active_list))
-		return spin_unlock_irqrestore(&atchan->lock, flags);
-
-	desc = atc_first_active(atchan);
-	/* Remove the transfer node from the active list. */
-	list_del_init(&desc->desc_node);
-	spin_unlock_irqrestore(&atchan->lock, flags);
-	atc_chain_complete(atchan, desc);
-
-	/* advance work */
-	spin_lock_irqsave(&atchan->lock, flags);
-	if (!list_empty(&atchan->active_list)) {
-		desc = atc_first_queued(atchan);
-		list_move_tail(&desc->desc_node, &atchan->active_list);
-		atc_dostart(atchan, desc);
-	}
-	spin_unlock_irqrestore(&atchan->lock, flags);
-}
-
-
 /**
  * atc_handle_error - handle errors reported by DMA controller
- * @atchan: channel where error occurs
+ * @atchan: channel where error occurs.
+ * @i: channel index
  */
-static void atc_handle_error(struct at_dma_chan *atchan)
+static void atc_handle_error(struct at_dma_chan *atchan, unsigned int i)
 {
-	struct at_desc *bad_desc;
-	struct at_desc *desc;
-	struct at_desc *child;
-	unsigned long flags;
-
-	spin_lock_irqsave(&atchan->lock, flags);
-	/*
-	 * The descriptor currently at the head of the active list is
-	 * broked. Since we don't have any way to report errors, we'll
-	 * just have to scream loudly and try to carry on.
-	 */
-	bad_desc = atc_first_active(atchan);
-	list_del_init(&bad_desc->desc_node);
-
-	/* Try to restart the controller */
-	if (!list_empty(&atchan->active_list)) {
-		desc = atc_first_queued(atchan);
-		list_move_tail(&desc->desc_node, &atchan->active_list);
-		atc_dostart(atchan, desc);
-	}
+	struct at_desc *desc = atchan->desc;
 
-	spin_unlock_irqrestore(&atchan->lock, flags);
+	/* Disable channel on AHB error */
+	dma_writel(atchan->atdma, CHDR, AT_DMA_RES(i) | atchan->mask);
 
 	/*
 	 * KERN_CRITICAL may seem harsh, but since this only happens
@@ -1008,47 +777,37 @@ static void atc_handle_error(struct at_dma_chan *atchan)
 	 * controller flagged an error instead of scribbling over
 	 * random memory locations.
 	 */
-	dev_crit(chan2dev(&atchan->dma_chan),
-			"Bad descriptor submitted for DMA!\n");
-	dev_crit(chan2dev(&atchan->dma_chan),
-			"  cookie: %d\n", bad_desc->txd.cookie);
-	atc_dump_lli(atchan, &bad_desc->lli);
-	list_for_each_entry(child, &bad_desc->tx_list, desc_node)
-		atc_dump_lli(atchan, &child->lli);
-
-	/* Pretend the descriptor completed successfully */
-	atc_chain_complete(atchan, bad_desc);
-}
-
-/**
- * atc_handle_cyclic - at the end of a period, run callback function
- * @atchan: channel used for cyclic operations
- */
-static void atc_handle_cyclic(struct at_dma_chan *atchan)
-{
-	struct at_desc			*first = atc_first_active(atchan);
-	struct dma_async_tx_descriptor	*txd = &first->txd;
-
-	dev_vdbg(chan2dev(&atchan->dma_chan),
-			"new cyclic period llp 0x%08x\n",
-			channel_readl(atchan, DSCR));
-
-	dmaengine_desc_get_callback_invoke(txd, NULL);
+	dev_crit(chan2dev(&atchan->vc.chan), "Bad descriptor submitted for DMA!\n");
+	dev_crit(chan2dev(&atchan->vc.chan), "cookie: %d\n",
+		 desc->vd.tx.cookie);
+	for (i = 0; i < desc->sglen; i++)
+		atc_dump_lli(atchan, desc->sg[i].lli);
 }
 
-/*--  IRQ & Tasklet  ---------------------------------------------------*/
-
-static void atc_tasklet(struct tasklet_struct *t)
+static void atdma_handle_chan_done(struct at_dma_chan *atchan, u32 pending,
+				   unsigned int i)
 {
-	struct at_dma_chan *atchan = from_tasklet(atchan, t, tasklet);
+	struct at_desc *desc;
 
-	if (test_and_clear_bit(ATC_IS_ERROR, &atchan->status))
-		return atc_handle_error(atchan);
+	spin_lock(&atchan->vc.lock);
+	desc = atchan->desc;
 
-	if (atc_chan_is_cyclic(atchan))
-		return atc_handle_cyclic(atchan);
+	if (desc) {
+		if (pending & AT_DMA_ERR(i)) {
+			atc_handle_error(atchan, i);
+			/* Pretend the descriptor completed successfully */
+		}
 
-	atc_advance_work(atchan);
+		if (atc_chan_is_cyclic(atchan)) {
+			vchan_cyclic_callback(&desc->vd);
+		} else {
+			vchan_cookie_complete(&desc->vd);
+			atchan->desc = NULL;
+			if (!(atc_chan_is_enabled(atchan)))
+				atc_dostart(atchan);
+		}
+	}
+	spin_unlock(&atchan->vc.lock);
 }
 
 static irqreturn_t at_dma_interrupt(int irq, void *dev_id)
@@ -1073,17 +832,10 @@ static irqreturn_t at_dma_interrupt(int irq, void *dev_id)
 
 		for (i = 0; i < atdma->dma_device.chancnt; i++) {
 			atchan = &atdma->chan[i];
-			if (pending & (AT_DMA_BTC(i) | AT_DMA_ERR(i))) {
-				if (pending & AT_DMA_ERR(i)) {
-					/* Disable channel on AHB error */
-					dma_writel(atdma, CHDR,
-						AT_DMA_RES(i) | atchan->mask);
-					/* Give information to tasklet */
-					set_bit(ATC_IS_ERROR, &atchan->status);
-				}
-				tasklet_schedule(&atchan->tasklet);
-				ret = IRQ_HANDLED;
-			}
+			if (!(pending & (AT_DMA_BTC(i) | AT_DMA_ERR(i))))
+				continue;
+			atdma_handle_chan_done(atchan, pending, i);
+			ret = IRQ_HANDLED;
 		}
 
 	} while (pending);
@@ -1091,35 +843,7 @@ static irqreturn_t at_dma_interrupt(int irq, void *dev_id)
 	return ret;
 }
 
-
 /*--  DMA Engine API  --------------------------------------------------*/
-
-/**
- * atc_tx_submit - set the prepared descriptor(s) to be executed by the engine
- * @tx: descriptor at the head of the transaction chain
- *
- * Queue chain if DMA engine is working already
- *
- * Cookie increment and adding to active_list or queue must be atomic
- */
-static dma_cookie_t atc_tx_submit(struct dma_async_tx_descriptor *tx)
-{
-	struct at_desc		*desc = txd_to_at_desc(tx);
-	struct at_dma_chan	*atchan = to_at_dma_chan(tx->chan);
-	dma_cookie_t		cookie;
-	unsigned long		flags;
-
-	spin_lock_irqsave(&atchan->lock, flags);
-	cookie = dma_cookie_assign(tx);
-
-	list_add_tail(&desc->desc_node, &atchan->queue);
-	spin_unlock_irqrestore(&atchan->lock, flags);
-
-	dev_vdbg(chan2dev(tx->chan), "tx_submit: queued %u\n",
-		 desc->txd.cookie);
-	return cookie;
-}
-
 /**
  * atc_prep_dma_interleaved - prepare memory to memory interleaved operation
  * @chan: the channel to prepare operation on
@@ -1131,9 +855,12 @@ atc_prep_dma_interleaved(struct dma_chan *chan,
 			 struct dma_interleaved_template *xt,
 			 unsigned long flags)
 {
+	struct at_dma		*atdma = to_at_dma(chan->device);
 	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
 	struct data_chunk	*first;
-	struct at_desc		*desc = NULL;
+	struct atdma_sg		*atdma_sg;
+	struct at_desc		*desc;
+	struct at_lli		*lli;
 	size_t			xfer_count;
 	unsigned int		dwidth;
 	u32			ctrla;
@@ -1172,8 +899,7 @@ atc_prep_dma_interleaved(struct dma_chan *chan,
 		len += chunk->size;
 	}
 
-	dwidth = atc_get_xfer_width(xt->src_start,
-				    xt->dst_start, len);
+	dwidth = atc_get_xfer_width(xt->src_start, xt->dst_start, len);
 
 	xfer_count = len >> dwidth;
 	if (xfer_count > ATC_BTSIZE_MAX) {
@@ -1190,32 +916,34 @@ atc_prep_dma_interleaved(struct dma_chan *chan,
 		ATC_SRC_PIP | ATC_DST_PIP |
 		FIELD_PREP(ATC_FC, ATC_FC_MEM2MEM);
 
-	/* create the transfer */
-	desc = atc_desc_get(atchan);
-	if (!desc) {
-		dev_err(chan2dev(chan),
-			"%s: couldn't allocate our descriptor\n", __func__);
+	desc = kzalloc(struct_size(desc, sg, 1), GFP_ATOMIC);
+	if (!desc)
+		return NULL;
+	desc->sglen = 1;
+
+	atdma_sg = desc->sg;
+	atdma_sg->lli = dma_pool_alloc(atdma->lli_pool, GFP_NOWAIT,
+				       &atdma_sg->lli_phys);
+	if (!atdma_sg->lli) {
+		kfree(desc);
 		return NULL;
 	}
+	lli = atdma_sg->lli;
 
-	desc->lli.saddr = xt->src_start;
-	desc->lli.daddr = xt->dst_start;
-	desc->lli.ctrla = ctrla | xfer_count;
-	desc->lli.ctrlb = ctrlb;
+	lli->saddr = xt->src_start;
+	lli->daddr = xt->dst_start;
+	lli->ctrla = ctrla | xfer_count;
+	lli->ctrlb = ctrlb;
 
 	desc->boundary = first->size >> dwidth;
 	desc->dst_hole = (dmaengine_get_dst_icg(xt, first) >> dwidth) + 1;
 	desc->src_hole = (dmaengine_get_src_icg(xt, first) >> dwidth) + 1;
 
-	desc->txd.cookie = -EBUSY;
-	desc->total_len = desc->len = len;
-
-	/* set end-of-link to the last link descriptor of list*/
-	set_desc_eol(desc);
-
-	desc->txd.flags = flags; /* client is in control of this ack */
+	atdma_sg->len = len;
+	desc->total_len = len;
 
-	return &desc->txd;
+	set_lli_eol(desc, 0);
+	return vchan_tx_prep(&atchan->vc, &desc->vd, flags);
 }
 
 /**
@@ -1230,25 +958,32 @@ static struct dma_async_tx_descriptor *
 atc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 		size_t len, unsigned long flags)
 {
+	struct at_dma		*atdma = to_at_dma(chan->device);
 	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
 	struct at_desc		*desc = NULL;
-	struct at_desc		*first = NULL;
-	struct at_desc		*prev = NULL;
 	size_t			xfer_count;
 	size_t			offset;
+	size_t			sg_len;
 	unsigned int		src_width;
 	unsigned int		dst_width;
+	unsigned int		i;
 	u32			ctrla;
 	u32			ctrlb;
 
-	dev_vdbg(chan2dev(chan), "prep_dma_memcpy: d%pad s%pad l0x%zx f0x%lx\n",
-			&dest, &src, len, flags);
+	dev_dbg(chan2dev(chan), "prep_dma_memcpy: d%pad s%pad l0x%zx f0x%lx\n",
+		&dest, &src, len, flags);
 
 	if (unlikely(!len)) {
-		dev_dbg(chan2dev(chan), "prep_dma_memcpy: length is zero!\n");
+		dev_err(chan2dev(chan), "prep_dma_memcpy: length is zero!\n");
 		return NULL;
 	}
 
+	sg_len = DIV_ROUND_UP(len, ATC_BTSIZE_MAX);
+	desc = kzalloc(struct_size(desc, sg, sg_len), GFP_ATOMIC);
+	if (!desc)
+		return NULL;
+	desc->sglen = sg_len;
+
 	ctrlb = ATC_DEFAULT_CTRLB | ATC_IEN |
 		FIELD_PREP(ATC_SRC_ADDR_MODE, ATC_SRC_ADDR_MODE_INCR) |
 		FIELD_PREP(ATC_DST_ADDR_MODE, ATC_DST_ADDR_MODE_INCR) |
@@ -1263,50 +998,49 @@ atc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	ctrla = FIELD_PREP(ATC_SRC_WIDTH, src_width) |
 		FIELD_PREP(ATC_DST_WIDTH, dst_width);
 
-	for (offset = 0; offset < len; offset += xfer_count << src_width) {
-		xfer_count = min_t(size_t, (len - offset) >> src_width,
-				ATC_BTSIZE_MAX);
+	for (offset = 0, i = 0; offset < len;
+	     offset += xfer_count << src_width, i++) {
+		struct atdma_sg *atdma_sg = &desc->sg[i];
+		struct at_lli *lli;
 
-		desc = atc_desc_get(atchan);
-		if (!desc)
+		atdma_sg->lli = dma_pool_alloc(atdma->lli_pool, GFP_NOWAIT,
+					       &atdma_sg->lli_phys);
+		if (!atdma_sg->lli)
 			goto err_desc_get;
+		lli = atdma_sg->lli;
+
+		xfer_count = min_t(size_t, (len - offset) >> src_width,
+				   ATC_BTSIZE_MAX);
 
-		desc->lli.saddr = src + offset;
-		desc->lli.daddr = dest + offset;
-		desc->lli.ctrla = ctrla | xfer_count;
-		desc->lli.ctrlb = ctrlb;
+		lli->saddr = src + offset;
+		lli->daddr = dest + offset;
+		lli->ctrla = ctrla | xfer_count;
+		lli->ctrlb = ctrlb;
 
-		desc->txd.cookie = 0;
-		desc->len = xfer_count << src_width;
+		desc->sg[i].len = xfer_count << src_width;
 
-		atc_desc_chain(&first, &prev, desc);
+		atdma_lli_chain(desc, i);
 	}
 
-	/* First descriptor of the chain embedds additional information */
-	first->txd.cookie = -EBUSY;
-	first->total_len = len;
+	desc->total_len = len;
 
 	/* set end-of-link to the last link descriptor of list*/
-	set_desc_eol(desc);
-
-	first->txd.flags = flags; /* client is in control of this ack */
+	set_lli_eol(desc, i - 1);
 
-	return &first->txd;
+	return vchan_tx_prep(&atchan->vc, &desc->vd, flags);
 
 err_desc_get:
-	atc_desc_put(atchan, first);
+	atdma_desc_free(&desc->vd);
 	return NULL;
 }
 
-static struct at_desc *atc_create_memset_desc(struct dma_chan *chan,
-					      dma_addr_t psrc,
-					      dma_addr_t pdst,
-					      size_t len)
+static int atdma_create_memset_lli(struct dma_chan *chan,
+				   struct atdma_sg *atdma_sg,
+				   dma_addr_t psrc, dma_addr_t pdst, size_t len)
 {
-	struct at_dma_chan *atchan = to_at_dma_chan(chan);
-	struct at_desc *desc;
+	struct at_dma *atdma = to_at_dma(chan->device);
+	struct at_lli *lli;
 	size_t xfer_count;
-
 	u32 ctrla = FIELD_PREP(ATC_SRC_WIDTH, 2) | FIELD_PREP(ATC_DST_WIDTH, 2);
 	u32 ctrlb = ATC_DEFAULT_CTRLB | ATC_IEN |
 		    FIELD_PREP(ATC_SRC_ADDR_MODE, ATC_SRC_ADDR_MODE_FIXED) |
@@ -1315,27 +1049,24 @@ static struct at_desc *atc_create_memset_desc(struct dma_chan *chan,
 
 	xfer_count = len >> 2;
 	if (xfer_count > ATC_BTSIZE_MAX) {
-		dev_err(chan2dev(chan), "%s: buffer is too big\n",
-			__func__);
-		return NULL;
+		dev_err(chan2dev(chan), "%s: buffer is too big\n", __func__);
+		return -EINVAL;
 	}
 
-	desc = atc_desc_get(atchan);
-	if (!desc) {
-		dev_err(chan2dev(chan), "%s: can't get a descriptor\n",
-			__func__);
-		return NULL;
-	}
+	atdma_sg->lli = dma_pool_alloc(atdma->lli_pool, GFP_NOWAIT,
+				       &atdma_sg->lli_phys);
+	if (!atdma_sg->lli)
+		return -ENOMEM;
+	lli = atdma_sg->lli;
 
-	desc->lli.saddr = psrc;
-	desc->lli.daddr = pdst;
-	desc->lli.ctrla = ctrla | xfer_count;
-	desc->lli.ctrlb = ctrlb;
+	lli->saddr = psrc;
+	lli->daddr = pdst;
+	lli->ctrla = ctrla | xfer_count;
+	lli->ctrlb = ctrlb;
 
-	desc->txd.cookie = 0;
-	desc->len = len;
+	atdma_sg->len = len;
 
-	return desc;
+	return 0;
 }
 
 /**
@@ -1350,11 +1081,13 @@ static struct dma_async_tx_descriptor *
 atc_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
 		    size_t len, unsigned long flags)
 {
+	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
 	struct at_dma		*atdma = to_at_dma(chan->device);
 	struct at_desc		*desc;
 	void __iomem		*vaddr;
 	dma_addr_t		paddr;
 	char			fill_pattern;
+	int			ret;
 
 	dev_vdbg(chan2dev(chan), "%s: d%pad v0x%x l0x%zx f0x%lx\n", __func__,
 		&dest, value, len, flags);
@@ -1385,27 +1118,28 @@ atc_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
 		       (fill_pattern << 8) |
 		       fill_pattern;
 
-	desc = atc_create_memset_desc(chan, paddr, dest, len);
-	if (!desc) {
-		dev_err(chan2dev(chan), "%s: couldn't get a descriptor\n",
-			__func__);
+	desc = kzalloc(struct_size(desc, sg, 1), GFP_ATOMIC);
+	if (!desc)
 		goto err_free_buffer;
-	}
+	desc->sglen = 1;
+
+	ret = atdma_create_memset_lli(chan, desc->sg, paddr, dest, len);
+	if (ret)
+		goto err_free_desc;
 
 	desc->memset_paddr = paddr;
 	desc->memset_vaddr = vaddr;
 	desc->memset_buffer = true;
 
-	desc->txd.cookie = -EBUSY;
 	desc->total_len = len;
 
 	/* set end-of-link on the descriptor */
-	set_desc_eol(desc);
-
-	desc->txd.flags = flags;
+	set_lli_eol(desc, 0);
 
-	return &desc->txd;
+	return vchan_tx_prep(&atchan->vc, &desc->vd, flags);
 
+err_free_desc:
+	kfree(desc);
 err_free_buffer:
 	dma_pool_free(atdma->memset_pool, vaddr, paddr);
 	return NULL;
@@ -1419,12 +1153,13 @@ atc_prep_dma_memset_sg(struct dma_chan *chan,
 {
 	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
 	struct at_dma		*atdma = to_at_dma(chan->device);
-	struct at_desc		*desc = NULL, *first = NULL, *prev = NULL;
+	struct at_desc		*desc;
 	struct scatterlist	*sg;
 	void __iomem		*vaddr;
 	dma_addr_t		paddr;
 	size_t			total_len = 0;
 	int			i;
+	int			ret;
 
 	dev_vdbg(chan2dev(chan), "%s: v0x%x l0x%zx f0x%lx\n", __func__,
 		 value, sg_len, flags);
@@ -1443,6 +1178,11 @@ atc_prep_dma_memset_sg(struct dma_chan *chan,
 	}
 	*(u32*)vaddr = value;
 
+	desc = kzalloc(struct_size(desc, sg, sg_len), GFP_ATOMIC);
+	if (!desc)
+		goto err_free_dma_buf;
+	desc->sglen = sg_len;
+
 	for_each_sg(sgl, sg, sg_len, i) {
 		dma_addr_t dest = sg_dma_address(sg);
 		size_t len = sg_dma_len(sg);
@@ -1453,38 +1193,33 @@ atc_prep_dma_memset_sg(struct dma_chan *chan,
 		if (!is_dma_fill_aligned(chan->device, dest, 0, len)) {
 			dev_err(chan2dev(chan), "%s: buffer is not aligned\n",
 				__func__);
-			goto err_put_desc;
+			goto err_free_desc;
 		}
 
-		desc = atc_create_memset_desc(chan, paddr, dest, len);
-		if (!desc)
-			goto err_put_desc;
-
-		atc_desc_chain(&first, &prev, desc);
+		ret = atdma_create_memset_lli(chan, &desc->sg[i], paddr, dest,
+					      len);
+		if (ret)
+			goto err_free_desc;
 
+		atdma_lli_chain(desc, i);
 		total_len += len;
 	}
 
-	/*
-	 * Only set the buffer pointers on the last descriptor to
-	 * avoid free'ing while we have our transfer still going
-	 */
 	desc->memset_paddr = paddr;
 	desc->memset_vaddr = vaddr;
 	desc->memset_buffer = true;
 
-	first->txd.cookie = -EBUSY;
-	first->total_len = total_len;
+	desc->total_len = total_len;
 
 	/* set end-of-link on the descriptor */
-	set_desc_eol(desc);
-
-	first->txd.flags = flags;
+	set_lli_eol(desc, i - 1);
 
-	return &first->txd;
+	return vchan_tx_prep(&atchan->vc, &desc->vd, flags);
 
-err_put_desc:
-	atc_desc_put(atchan, first);
+err_free_desc:
+	atdma_desc_free(&desc->vd);
+err_free_dma_buf:
+	dma_pool_free(atdma->memset_pool, vaddr, paddr);
 	return NULL;
 }
 
@@ -1502,11 +1237,11 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		unsigned int sg_len, enum dma_transfer_direction direction,
 		unsigned long flags, void *context)
 {
+	struct at_dma		*atdma = to_at_dma(chan->device);
 	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
 	struct at_dma_slave	*atslave = chan->private;
 	struct dma_slave_config	*sconfig = &atchan->dma_sconfig;
-	struct at_desc		*first = NULL;
-	struct at_desc		*prev = NULL;
+	struct at_desc		*desc;
 	u32			ctrla;
 	u32			ctrlb;
 	dma_addr_t		reg;
@@ -1526,6 +1261,11 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		return NULL;
 	}
 
+	desc = kzalloc(struct_size(desc, sg, sg_len), GFP_ATOMIC);
+	if (!desc)
+		return NULL;
+	desc->sglen = sg_len;
+
 	ctrla = FIELD_PREP(ATC_SCSIZE, sconfig->src_maxburst) |
 		FIELD_PREP(ATC_DCSIZE, sconfig->dst_maxburst);
 	ctrlb = ATC_IEN;
@@ -1542,13 +1282,17 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			 FIELD_PREP(ATC_DIF, atchan->per_if);
 		reg = sconfig->dst_addr;
 		for_each_sg(sgl, sg, sg_len, i) {
-			struct at_desc	*desc;
+			struct atdma_sg *atdma_sg = &desc->sg[i];
+			struct at_lli *lli;
 			u32		len;
 			u32		mem;
 
-			desc = atc_desc_get(atchan);
-			if (!desc)
+			atdma_sg->lli = dma_pool_alloc(atdma->lli_pool,
+						       GFP_NOWAIT,
+						       &atdma_sg->lli_phys);
+			if (!atdma_sg->lli)
 				goto err_desc_get;
+			lli = atdma_sg->lli;
 
 			mem = sg_dma_address(sg);
 			len = sg_dma_len(sg);
@@ -1561,16 +1305,18 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			if (unlikely(mem & 3 || len & 3))
 				mem_width = 0;
 
-			desc->lli.saddr = mem;
-			desc->lli.daddr = reg;
-			desc->lli.ctrla = ctrla |
-					  FIELD_PREP(ATC_SRC_WIDTH, mem_width) |
-					  len >> mem_width;
-			desc->lli.ctrlb = ctrlb;
-			desc->len = len;
+			lli->saddr = mem;
+			lli->daddr = reg;
+			lli->ctrla = ctrla |
+				     FIELD_PREP(ATC_SRC_WIDTH, mem_width) |
+				     len >> mem_width;
+			lli->ctrlb = ctrlb;
 
-			atc_desc_chain(&first, &prev, desc);
+			atdma_sg->len = len;
 			total_len += len;
+
+			desc->sg[i].len = len;
+			atdma_lli_chain(desc, i);
 		}
 		break;
 	case DMA_DEV_TO_MEM:
@@ -1585,13 +1331,17 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 
 		reg = sconfig->src_addr;
 		for_each_sg(sgl, sg, sg_len, i) {
-			struct at_desc	*desc;
+			struct atdma_sg *atdma_sg = &desc->sg[i];
+			struct at_lli *lli;
 			u32		len;
 			u32		mem;
 
-			desc = atc_desc_get(atchan);
-			if (!desc)
+			atdma_sg->lli = dma_pool_alloc(atdma->lli_pool,
+						       GFP_NOWAIT,
+						       &atdma_sg->lli_phys);
+			if (!atdma_sg->lli)
 				goto err_desc_get;
+			lli = atdma_sg->lli;
 
 			mem = sg_dma_address(sg);
 			len = sg_dma_len(sg);
@@ -1604,16 +1354,17 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			if (unlikely(mem & 3 || len & 3))
 				mem_width = 0;
 
-			desc->lli.saddr = reg;
-			desc->lli.daddr = mem;
-			desc->lli.ctrla = ctrla |
-					  FIELD_PREP(ATC_DST_WIDTH, mem_width) |
-					  len >> reg_width;
-			desc->lli.ctrlb = ctrlb;
-			desc->len = len;
+			lli->saddr = reg;
+			lli->daddr = mem;
+			lli->ctrla = ctrla |
+				     FIELD_PREP(ATC_DST_WIDTH, mem_width) |
+				     len >> reg_width;
+			lli->ctrlb = ctrlb;
 
-			atc_desc_chain(&first, &prev, desc);
+			desc->sg[i].len = len;
 			total_len += len;
+
+			atdma_lli_chain(desc, i);
 		}
 		break;
 	default:
@@ -1621,21 +1372,16 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	}
 
 	/* set end-of-link to the last link descriptor of list*/
-	set_desc_eol(prev);
-
-	/* First descriptor of the chain embedds additional information */
-	first->txd.cookie = -EBUSY;
-	first->total_len = total_len;
+	set_lli_eol(desc, i - 1);
 
-	/* first link descriptor of list is responsible of flags */
-	first->txd.flags = flags; /* client is in control of this ack */
+	desc->total_len = total_len;
 
-	return &first->txd;
+	return vchan_tx_prep(&atchan->vc, &desc->vd, flags);
 
 err_desc_get:
 	dev_err(chan2dev(chan), "not enough descriptors available\n");
 err:
-	atc_desc_put(atchan, first);
+	atdma_desc_free(&desc->vd);
 	return NULL;
 }
 
@@ -1665,54 +1411,59 @@ atc_dma_cyclic_check_values(unsigned int reg_width, dma_addr_t buf_addr,
  */
 static int
 atc_dma_cyclic_fill_desc(struct dma_chan *chan, struct at_desc *desc,
-		unsigned int period_index, dma_addr_t buf_addr,
+		unsigned int i, dma_addr_t buf_addr,
 		unsigned int reg_width, size_t period_len,
 		enum dma_transfer_direction direction)
 {
+	struct at_dma		*atdma = to_at_dma(chan->device);
 	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
 	struct dma_slave_config	*sconfig = &atchan->dma_sconfig;
-	u32			ctrla;
+	struct atdma_sg		*atdma_sg = &desc->sg[i];
+	struct at_lli		*lli;
 
-	/* prepare common CRTLA value */
-	ctrla = FIELD_PREP(ATC_SCSIZE, sconfig->src_maxburst) |
-		FIELD_PREP(ATC_DCSIZE, sconfig->dst_maxburst) |
-		FIELD_PREP(ATC_DST_WIDTH, reg_width) |
-		FIELD_PREP(ATC_SRC_WIDTH, reg_width) |
-		period_len >> reg_width;
+	atdma_sg->lli = dma_pool_alloc(atdma->lli_pool, GFP_ATOMIC,
+				       &atdma_sg->lli_phys);
+	if (!atdma_sg->lli)
+		return -ENOMEM;
+	lli = atdma_sg->lli;
 
 	switch (direction) {
 	case DMA_MEM_TO_DEV:
-		desc->lli.saddr = buf_addr + (period_len * period_index);
-		desc->lli.daddr = sconfig->dst_addr;
-		desc->lli.ctrla = ctrla;
-		desc->lli.ctrlb = FIELD_PREP(ATC_DST_ADDR_MODE,
-					     ATC_DST_ADDR_MODE_FIXED) |
-				  FIELD_PREP(ATC_SRC_ADDR_MODE,
-					     ATC_SRC_ADDR_MODE_INCR) |
-				  FIELD_PREP(ATC_FC, ATC_FC_MEM2PER) |
-				  FIELD_PREP(ATC_SIF, atchan->mem_if) |
-				  FIELD_PREP(ATC_DIF, atchan->per_if);
-		desc->len = period_len;
+		lli->saddr = buf_addr + (period_len * i);
+		lli->daddr = sconfig->dst_addr;
+		lli->ctrlb = FIELD_PREP(ATC_DST_ADDR_MODE,
+					ATC_DST_ADDR_MODE_FIXED) |
+			     FIELD_PREP(ATC_SRC_ADDR_MODE,
+					ATC_SRC_ADDR_MODE_INCR) |
+			     FIELD_PREP(ATC_FC, ATC_FC_MEM2PER) |
+			     FIELD_PREP(ATC_SIF, atchan->mem_if) |
+			     FIELD_PREP(ATC_DIF, atchan->per_if);
+
 		break;
 
 	case DMA_DEV_TO_MEM:
-		desc->lli.saddr = sconfig->src_addr;
-		desc->lli.daddr = buf_addr + (period_len * period_index);
-		desc->lli.ctrla = ctrla;
-		desc->lli.ctrlb = FIELD_PREP(ATC_DST_ADDR_MODE,
-					     ATC_DST_ADDR_MODE_INCR) |
-				  FIELD_PREP(ATC_SRC_ADDR_MODE,
-					     ATC_SRC_ADDR_MODE_FIXED) |
-				  FIELD_PREP(ATC_FC, ATC_FC_PER2MEM) |
-				  FIELD_PREP(ATC_SIF, atchan->per_if) |
-				  FIELD_PREP(ATC_DIF, atchan->mem_if);
-		desc->len = period_len;
+		lli->saddr = sconfig->src_addr;
+		lli->daddr = buf_addr + (period_len * i);
+		lli->ctrlb = FIELD_PREP(ATC_DST_ADDR_MODE,
+					ATC_DST_ADDR_MODE_INCR) |
+			     FIELD_PREP(ATC_SRC_ADDR_MODE,
+					ATC_SRC_ADDR_MODE_FIXED) |
+			     FIELD_PREP(ATC_FC, ATC_FC_PER2MEM) |
+			     FIELD_PREP(ATC_SIF, atchan->per_if) |
+			     FIELD_PREP(ATC_DIF, atchan->mem_if);
 		break;
 
 	default:
 		return -EINVAL;
 	}
 
+	lli->ctrla = FIELD_PREP(ATC_SCSIZE, sconfig->src_maxburst) |
+		     FIELD_PREP(ATC_DCSIZE, sconfig->dst_maxburst) |
+		     FIELD_PREP(ATC_DST_WIDTH, reg_width) |
+		     FIELD_PREP(ATC_SRC_WIDTH, reg_width) |
+		     period_len >> reg_width;
+	desc->sg[i].len = period_len;
+
 	return 0;
 }
 
@@ -1733,8 +1484,7 @@ atc_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
 	struct at_dma_slave	*atslave = chan->private;
 	struct dma_slave_config	*sconfig = &atchan->dma_sconfig;
-	struct at_desc		*first = NULL;
-	struct at_desc		*prev = NULL;
+	struct at_desc		*desc;
 	unsigned long		was_cyclic;
 	unsigned int		reg_width;
 	unsigned int		periods = buf_len / period_len;
@@ -1768,33 +1518,26 @@ atc_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 	if (atc_dma_cyclic_check_values(reg_width, buf_addr, period_len))
 		goto err_out;
 
+	desc = kzalloc(struct_size(desc, sg, periods), GFP_ATOMIC);
+	if (!desc)
+		goto err_out;
+	desc->sglen = periods;
+
 	/* build cyclic linked list */
 	for (i = 0; i < periods; i++) {
-		struct at_desc	*desc;
-
-		desc = atc_desc_get(atchan);
-		if (!desc)
-			goto err_desc_get;
-
 		if (atc_dma_cyclic_fill_desc(chan, desc, i, buf_addr,
 					     reg_width, period_len, direction))
-			goto err_desc_get;
-
-		atc_desc_chain(&first, &prev, desc);
+			goto err_fill_desc;
+		atdma_lli_chain(desc, i);
 	}
-
+	desc->total_len = buf_len;
 	/* lets make a cyclic list */
-	prev->lli.dscr = first->txd.phys;
-
-	/* First descriptor of the chain embedds additional information */
-	first->txd.cookie = -EBUSY;
-	first->total_len = buf_len;
+	desc->sg[i - 1].lli->dscr = desc->sg[0].lli_phys;
 
-	return &first->txd;
+	return vchan_tx_prep(&atchan->vc, &desc->vd, flags);
 
-err_desc_get:
-	dev_err(chan2dev(chan), "not enough descriptors available\n");
-	atc_desc_put(atchan, first);
+err_fill_desc:
+	atdma_desc_free(&desc->vd);
 err_out:
 	clear_bit(ATC_IS_CYCLIC, &atchan->status);
 	return NULL;
@@ -1823,17 +1566,17 @@ static int atc_pause(struct dma_chan *chan)
 {
 	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
 	struct at_dma		*atdma = to_at_dma(chan->device);
-	int			chan_id = atchan->dma_chan.chan_id;
+	int			chan_id = atchan->vc.chan.chan_id;
 	unsigned long		flags;
 
 	dev_vdbg(chan2dev(chan), "%s\n", __func__);
 
-	spin_lock_irqsave(&atchan->lock, flags);
+	spin_lock_irqsave(&atchan->vc.lock, flags);
 
 	dma_writel(atdma, CHER, AT_DMA_SUSP(chan_id));
 	set_bit(ATC_IS_PAUSED, &atchan->status);
 
-	spin_unlock_irqrestore(&atchan->lock, flags);
+	spin_unlock_irqrestore(&atchan->vc.lock, flags);
 
 	return 0;
 }
@@ -1842,7 +1585,7 @@ static int atc_resume(struct dma_chan *chan)
 {
 	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
 	struct at_dma		*atdma = to_at_dma(chan->device);
-	int			chan_id = atchan->dma_chan.chan_id;
+	int			chan_id = atchan->vc.chan.chan_id;
 	unsigned long		flags;
 
 	dev_vdbg(chan2dev(chan), "%s\n", __func__);
@@ -1850,12 +1593,12 @@ static int atc_resume(struct dma_chan *chan)
 	if (!atc_chan_is_paused(atchan))
 		return 0;
 
-	spin_lock_irqsave(&atchan->lock, flags);
+	spin_lock_irqsave(&atchan->vc.lock, flags);
 
 	dma_writel(atdma, CHDR, AT_DMA_RES(chan_id));
 	clear_bit(ATC_IS_PAUSED, &atchan->status);
 
-	spin_unlock_irqrestore(&atchan->lock, flags);
+	spin_unlock_irqrestore(&atchan->vc.lock, flags);
 
 	return 0;
 }
@@ -1864,9 +1607,11 @@ static int atc_terminate_all(struct dma_chan *chan)
 {
 	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
 	struct at_dma		*atdma = to_at_dma(chan->device);
-	int			chan_id = atchan->dma_chan.chan_id;
+	int			chan_id = atchan->vc.chan.chan_id;
 	unsigned long		flags;
 
+	LIST_HEAD(list);
+
 	dev_vdbg(chan2dev(chan), "%s\n", __func__);
 
 	/*
@@ -1875,7 +1620,7 @@ static int atc_terminate_all(struct dma_chan *chan)
 	 * channel. We still have to poll the channel enable bit due
 	 * to AHB/HSB limitations.
 	 */
-	spin_lock_irqsave(&atchan->lock, flags);
+	spin_lock_irqsave(&atchan->vc.lock, flags);
 
 	/* disabling channel: must also remove suspend state */
 	dma_writel(atdma, CHDR, AT_DMA_RES(chan_id) | atchan->mask);
@@ -1884,15 +1629,20 @@ static int atc_terminate_all(struct dma_chan *chan)
 	while (dma_readl(atdma, CHSR) & atchan->mask)
 		cpu_relax();
 
-	/* active_list entries will end up before queued entries */
-	list_splice_tail_init(&atchan->queue, &atchan->free_list);
-	list_splice_tail_init(&atchan->active_list, &atchan->free_list);
+	if (atchan->desc) {
+		vchan_terminate_vdesc(&atchan->desc->vd);
+		atchan->desc = NULL;
+	}
+
+	vchan_get_all_descriptors(&atchan->vc, &list);
 
 	clear_bit(ATC_IS_PAUSED, &atchan->status);
 	/* if channel dedicated to cyclic operations, free it */
 	clear_bit(ATC_IS_CYCLIC, &atchan->status);
 
-	spin_unlock_irqrestore(&atchan->lock, flags);
+	spin_unlock_irqrestore(&atchan->vc.lock, flags);
+
+	vchan_dma_desc_free_list(&atchan->vc, &list);
 
 	return 0;
 }
@@ -1922,9 +1672,10 @@ atc_tx_status(struct dma_chan *chan,
 	if (dma_status == DMA_COMPLETE || !txstate)
 		return dma_status;
 
-	spin_lock_irqsave(&atchan->lock, flags);
+	spin_lock_irqsave(&atchan->vc.lock, flags);
+	/*  Get number of bytes left in the active transactions */
 	ret = atc_get_residue(chan, cookie, &residue);
-	spin_unlock_irqrestore(&atchan->lock, flags);
+	spin_unlock_irqrestore(&atchan->vc.lock, flags);
 
 	if (unlikely(ret < 0)) {
 		dev_vdbg(chan2dev(chan), "get residual bytes error\n");
@@ -1939,27 +1690,17 @@ atc_tx_status(struct dma_chan *chan,
 	return dma_status;
 }
 
-/**
- * atc_issue_pending - takes the first transaction descriptor in the pending
- * queue and starts the transfer.
- * @chan: target DMA channel
- */
 static void atc_issue_pending(struct dma_chan *chan)
 {
 	struct at_dma_chan *atchan = to_at_dma_chan(chan);
-	struct at_desc *desc;
 	unsigned long flags;
 
-	dev_vdbg(chan2dev(chan), "issue_pending\n");
-
-	spin_lock_irqsave(&atchan->lock, flags);
-	if (atc_chan_is_enabled(atchan) || list_empty(&atchan->queue))
-		return spin_unlock_irqrestore(&atchan->lock, flags);
-
-	desc = atc_first_queued(atchan);
-	list_move_tail(&desc->desc_node, &atchan->active_list);
-	atc_dostart(atchan, desc);
-	spin_unlock_irqrestore(&atchan->lock, flags);
+	spin_lock_irqsave(&atchan->vc.lock, flags);
+	if (vchan_issue_pending(&atchan->vc) && !atchan->desc) {
+		if (!(atc_chan_is_enabled(atchan)))
+			atc_dostart(atchan);
+	}
+	spin_unlock_irqrestore(&atchan->vc.lock, flags);
 }
 
 /**
@@ -1972,9 +1713,7 @@ static int atc_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
 	struct at_dma		*atdma = to_at_dma(chan->device);
-	struct at_desc		*desc;
 	struct at_dma_slave	*atslave;
-	int			i;
 	u32			cfg;
 
 	dev_vdbg(chan2dev(chan), "alloc_chan_resources\n");
@@ -1985,11 +1724,6 @@ static int atc_alloc_chan_resources(struct dma_chan *chan)
 		return -EIO;
 	}
 
-	if (!list_empty(&atchan->free_list)) {
-		dev_dbg(chan2dev(chan), "can't allocate channel resources (channel not freed from a previous use)\n");
-		return -EIO;
-	}
-
 	cfg = ATC_DEFAULT_CFG;
 
 	atslave = chan->private;
@@ -2005,26 +1739,10 @@ static int atc_alloc_chan_resources(struct dma_chan *chan)
 			cfg = atslave->cfg;
 	}
 
-	/* Allocate initial pool of descriptors */
-	for (i = 0; i < init_nr_desc_per_channel; i++) {
-		desc = atc_alloc_descriptor(chan, GFP_KERNEL);
-		if (!desc) {
-			dev_err(atdma->dma_device.dev,
-				"Only %d initial descriptors\n", i);
-			break;
-		}
-		list_add_tail(&desc->desc_node, &atchan->free_list);
-	}
-
-	dma_cookie_init(chan);
-
 	/* channel parameters */
 	channel_writel(atchan, CFG, cfg);
 
-	dev_dbg(chan2dev(chan),
-		"alloc_chan_resources: allocated %d descriptors\n", i);
-
-	return i;
+	return 0;
 }
 
 /**
@@ -2034,22 +1752,10 @@ static int atc_alloc_chan_resources(struct dma_chan *chan)
 static void atc_free_chan_resources(struct dma_chan *chan)
 {
 	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
-	struct at_dma		*atdma = to_at_dma(chan->device);
-	struct at_desc		*desc, *_desc;
-	LIST_HEAD(list);
 
-	/* ASSERT:  channel is idle */
-	BUG_ON(!list_empty(&atchan->active_list));
-	BUG_ON(!list_empty(&atchan->queue));
 	BUG_ON(atc_chan_is_enabled(atchan));
 
-	list_for_each_entry_safe(desc, _desc, &atchan->free_list, desc_node) {
-		dev_vdbg(chan2dev(chan), "  freeing descriptor %p\n", desc);
-		list_del(&desc->desc_node);
-		/* free link descriptor */
-		dma_pool_free(atdma->dma_desc_pool, desc, desc->txd.phys);
-	}
-	list_splice_init(&atchan->free_list, &list);
+	vchan_free_chan_resources(to_virt_chan(chan));
 	atchan->status = 0;
 
 	/*
@@ -2274,11 +1980,11 @@ static int __init at_dma_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, atdma);
 
 	/* create a pool of consistent memory blocks for hardware descriptors */
-	atdma->dma_desc_pool = dma_pool_create("at_hdmac_desc_pool",
-			&pdev->dev, sizeof(struct at_desc),
-			4 /* word alignment */, 0);
-	if (!atdma->dma_desc_pool) {
-		dev_err(&pdev->dev, "No memory for descriptors dma pool\n");
+	atdma->lli_pool = dma_pool_create("at_hdmac_lli_pool",
+					  &pdev->dev, sizeof(struct at_lli),
+					  4 /* word alignment */, 0);
+	if (!atdma->lli_pool) {
+		dev_err(&pdev->dev, "Unable to allocate DMA LLI descriptor pool\n");
 		err = -ENOMEM;
 		goto err_desc_pool_create;
 	}
@@ -2303,20 +2009,13 @@ static int __init at_dma_probe(struct platform_device *pdev)
 
 		atchan->mem_if = AT_DMA_MEM_IF;
 		atchan->per_if = AT_DMA_PER_IF;
-		atchan->dma_chan.device = &atdma->dma_device;
-		dma_cookie_init(&atchan->dma_chan);
-		list_add_tail(&atchan->dma_chan.device_node,
-				&atdma->dma_device.channels);
 
 		atchan->ch_regs = atdma->regs + ch_regs(i);
-		spin_lock_init(&atchan->lock);
 		atchan->mask = 1 << i;
 
-		INIT_LIST_HEAD(&atchan->active_list);
-		INIT_LIST_HEAD(&atchan->queue);
-		INIT_LIST_HEAD(&atchan->free_list);
-
-		tasklet_setup(&atchan->tasklet, atc_tasklet);
+		atchan->atdma = atdma;
+		atchan->vc.desc_free = atdma_desc_free;
+		vchan_init(&atchan->vc, &atdma->dma_device);
 		atc_enable_chan_irq(atdma, i);
 	}
 
@@ -2390,7 +2089,7 @@ static int __init at_dma_probe(struct platform_device *pdev)
 err_dma_async_device_register:
 	dma_pool_destroy(atdma->memset_pool);
 err_memset_pool_create:
-	dma_pool_destroy(atdma->dma_desc_pool);
+	dma_pool_destroy(atdma->lli_pool);
 err_desc_pool_create:
 	free_irq(platform_get_irq(pdev, 0), atdma);
 err_irq:
@@ -2409,17 +2108,13 @@ static int at_dma_remove(struct platform_device *pdev)
 	dma_async_device_unregister(&atdma->dma_device);
 
 	dma_pool_destroy(atdma->memset_pool);
-	dma_pool_destroy(atdma->dma_desc_pool);
+	dma_pool_destroy(atdma->lli_pool);
 	free_irq(platform_get_irq(pdev, 0), atdma);
 
 	list_for_each_entry_safe(chan, _chan, &atdma->dma_device.channels,
 			device_node) {
-		struct at_dma_chan	*atchan = to_at_dma_chan(chan);
-
 		/* Disable interrupts */
 		atc_disable_chan_irq(atdma, chan->chan_id);
-
-		tasklet_kill(&atchan->tasklet);
 		list_del(&chan->device_node);
 	}
 
@@ -2453,7 +2148,7 @@ static int at_dma_prepare(struct device *dev)
 
 static void atc_suspend_cyclic(struct at_dma_chan *atchan)
 {
-	struct dma_chan	*chan = &atchan->dma_chan;
+	struct dma_chan	*chan = &atchan->vc.chan;
 
 	/* Channel should be paused by user
 	 * do it anyway even if it is not done already */
@@ -2494,7 +2189,7 @@ static int at_dma_suspend_noirq(struct device *dev)
 
 static void atc_resume_cyclic(struct at_dma_chan *atchan)
 {
-	struct at_dma	*atdma = to_at_dma(atchan->dma_chan.device);
+	struct at_dma	*atdma = to_at_dma(atchan->vc.chan.device);
 
 	/* restore channel status for cyclic descriptors list:
 	 * next descriptor in the cyclic list at the time of suspend */
@@ -2568,5 +2263,6 @@ module_exit(at_dma_exit);
 
 MODULE_DESCRIPTION("Atmel AHB DMA Controller driver");
 MODULE_AUTHOR("Nicolas Ferre <nicolas.ferre@atmel.com>");
+MODULE_AUTHOR("Tudor Ambarus <tudor.ambarus@microchip.com>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:at_hdmac");
-- 
2.25.1

