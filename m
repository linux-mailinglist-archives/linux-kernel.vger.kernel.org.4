Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0093660C796
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiJYJJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJYJIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:08:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7685EDD2;
        Tue, 25 Oct 2022 02:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666688685; x=1698224685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xqkw/nHz2P+OWoFK9K0PuGd5Xwk6PET+zl6JvJKlVRY=;
  b=sBXnQI5CWZqQWekQo+aX8eHjjeYHq09TNu6FgnaA6J0wG2nvEXHJR1/P
   eV/xtBoYAVLgOO8ZDneT2m1mezgPQE+Nge610LkL63iR9sTl4xXkj2fC6
   Yh8cqIdQnD4zAAEcRL87anexlYsb0q/VTB5xCTQ4xb8FU8PkRqxJeFItw
   PL/cE7iY//MGlQqkIM/SRywBwGXroY0bJRev+y2z5WYRgxBRSO/NWN0/e
   PUpuBOR0lGLhZh9f+XTA2CQQz9rl1AjMXMdCuUjj7Zj0lobTHY2qu70Su
   Q+zGtfooews8fENxsUTYq6OI622VtO0/yW8ldCtYFKfT2GRAmNrUUEj0b
   w==;
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="196910269"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2022 02:04:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 25 Oct 2022 02:04:35 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 25 Oct 2022 02:04:32 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>
CC:     <maciej.sosnowski@intel.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <torfl6749@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v2 28/32] dmaengine: at_hdmac: Use bitfield access macros
Date:   Tue, 25 Oct 2022 12:03:02 +0300
Message-ID: <20221025090306.297886-29-tudor.ambarus@microchip.com>
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

Use the bitfield access macros in order to clean and to make the driver
easier to read. One will see some "line length exceeds 100 columns"
checkpatch warnings. I chose to not introduce new lines for regs
descriptions in order to preserve the style of the comments throughout
the definitions. Style can be fixed in a further patch.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/dma/at_hdmac.c | 408 ++++++++++++++++++++---------------------
 1 file changed, 198 insertions(+), 210 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index a07e3355f09a..edec6a8c730c 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -10,6 +10,7 @@
  */
 
 #include <dt-bindings/dma/at91.h>
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
 #include <linux/dmapool.h>
@@ -36,176 +37,153 @@
 
 #define	AT_DMA_MAX_NR_CHANNELS	8
 
+/* Global Configuration Register */
+#define AT_DMA_GCFG		0x00
+#define AT_DMA_IF_BIGEND(i)	BIT((i))	/* AHB-Lite Interface i in Big-endian mode */
+#define AT_DMA_ARB_CFG		BIT(4)		/* Arbiter mode. */
 
-#define	AT_DMA_GCFG	0x00	/* Global Configuration Register */
-#define		AT_DMA_IF_BIGEND(i)	(0x1 << (i))	/* AHB-Lite Interface i in Big-endian mode */
-#define		AT_DMA_ARB_CFG	(0x1 << 4)	/* Arbiter mode. */
-#define			AT_DMA_ARB_CFG_FIXED		(0x0 << 4)
-#define			AT_DMA_ARB_CFG_ROUND_ROBIN	(0x1 << 4)
+/* Controller Enable Register */
+#define AT_DMA_EN		0x04
+#define AT_DMA_ENABLE		BIT(0)
 
-#define	AT_DMA_EN	0x04	/* Controller Enable Register */
-#define		AT_DMA_ENABLE	(0x1 << 0)
+/* Software Single Request Register */
+#define AT_DMA_SREQ		0x08
+#define AT_DMA_SSREQ(x)		BIT((x) << 1)		/* Request a source single transfer on channel x */
+#define AT_DMA_DSREQ(x)		BIT(1 + ((x) << 1))	/* Request a destination single transfer on channel x */
 
-#define	AT_DMA_SREQ	0x08	/* Software Single Request Register */
-#define		AT_DMA_SSREQ(x)	(0x1 << ((x) << 1))		/* Request a source single transfer on channel x */
-#define		AT_DMA_DSREQ(x)	(0x1 << (1 + ((x) << 1)))	/* Request a destination single transfer on channel x */
+/* Software Chunk Transfer Request Register */
+#define AT_DMA_CREQ		0x0c
+#define AT_DMA_SCREQ(x)		BIT((x) << 1)		/* Request a source chunk transfer on channel x */
+#define AT_DMA_DCREQ(x)		BIT(1 + ((x) << 1))	/* Request a destination chunk transfer on channel x */
 
-#define	AT_DMA_CREQ	0x0C	/* Software Chunk Transfer Request Register */
-#define		AT_DMA_SCREQ(x)	(0x1 << ((x) << 1))		/* Request a source chunk transfer on channel x */
-#define		AT_DMA_DCREQ(x)	(0x1 << (1 + ((x) << 1)))	/* Request a destination chunk transfer on channel x */
+/* Software Last Transfer Flag Register */
+#define AT_DMA_LAST		0x10
+#define AT_DMA_SLAST(x)		BIT((x) << 1)		/* This src rq is last tx of buffer on channel x */
+#define AT_DMA_DLAST(x)		BIT(1 + ((x) << 1))	/* This dst rq is last tx of buffer on channel x */
 
-#define	AT_DMA_LAST	0x10	/* Software Last Transfer Flag Register */
-#define		AT_DMA_SLAST(x)	(0x1 << ((x) << 1))		/* This src rq is last tx of buffer on channel x */
-#define		AT_DMA_DLAST(x)	(0x1 << (1 + ((x) << 1)))	/* This dst rq is last tx of buffer on channel x */
-
-#define	AT_DMA_SYNC	0x14	/* Request Synchronization Register */
-#define		AT_DMA_SYR(h)	(0x1 << (h))			/* Synchronize handshake line h */
+/* Request Synchronization Register */
+#define AT_DMA_SYNC		0x14
+#define AT_DMA_SYR(h)		BIT((h))		/* Synchronize handshake line h */
 
 /* Error, Chained Buffer transfer completed and Buffer transfer completed Interrupt registers */
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
+#define AT_DMA_EBCIER		0x18			/* Enable register */
+#define AT_DMA_EBCIDR		0x1c			/* Disable register */
+#define AT_DMA_EBCIMR		0x20			/* Mask Register */
+#define AT_DMA_EBCISR		0x24			/* Status Register */
+#define AT_DMA_CBTC_OFFSET	8
+#define AT_DMA_ERR_OFFSET	16
+#define AT_DMA_BTC(x)		BIT((x))
+#define AT_DMA_CBTC(x)		BIT(AT_DMA_CBTC_OFFSET + (x))
+#define AT_DMA_ERR(x)		BIT(AT_DMA_ERR_OFFSET + (x))
+
+/* Channel Handler Enable Register */
+#define AT_DMA_CHER		0x28
+#define AT_DMA_ENA(x)		BIT((x))
+#define AT_DMA_SUSP(x)		BIT(8 + (x))
+#define AT_DMA_KEEP(x)		BIT(24 + (x))
+
+/* Channel Handler Disable Register */
+#define AT_DMA_CHDR		0x2c
+#define AT_DMA_DIS(x)		BIT(x)
+#define AT_DMA_RES(x)		BIT(8 + (x))
+
+/* Channel Handler Status Register */
+#define AT_DMA_CHSR		0x30
+#define AT_DMA_EMPT(x)		BIT(16 + (x))
+#define AT_DMA_STAL(x)		BIT(24 + (x))
+
+/* Channel registers base address */
+#define AT_DMA_CH_REGS_BASE	0x3c
+#define ch_regs(x)		(AT_DMA_CH_REGS_BASE + (x) * 0x28) /* Channel x base addr */
 
 /* Hardware register offset for each channel */
-#define	ATC_SADDR_OFFSET	0x00	/* Source Address Register */
-#define	ATC_DADDR_OFFSET	0x04	/* Destination Address Register */
-#define	ATC_DSCR_OFFSET		0x08	/* Descriptor Address Register */
-#define	ATC_CTRLA_OFFSET	0x0C	/* Control A Register */
-#define	ATC_CTRLB_OFFSET	0x10	/* Control B Register */
-#define	ATC_CFG_OFFSET		0x14	/* Configuration Register */
-#define	ATC_SPIP_OFFSET		0x18	/* Src PIP Configuration Register */
-#define	ATC_DPIP_OFFSET		0x1C	/* Dst PIP Configuration Register */
+#define ATC_SADDR_OFFSET	0x00	/* Source Address Register */
+#define ATC_DADDR_OFFSET	0x04	/* Destination Address Register */
+#define ATC_DSCR_OFFSET		0x08	/* Descriptor Address Register */
+#define ATC_CTRLA_OFFSET	0x0c	/* Control A Register */
+#define ATC_CTRLB_OFFSET	0x10	/* Control B Register */
+#define ATC_CFG_OFFSET		0x14	/* Configuration Register */
+#define ATC_SPIP_OFFSET		0x18	/* Src PIP Configuration Register */
+#define ATC_DPIP_OFFSET		0x1c	/* Dst PIP Configuration Register */
 
 
 /* Bitfield definitions */
 
 /* Bitfields in DSCR */
-#define	ATC_DSCR_IF(i)		(0x3 & (i))	/* Dsc feched via AHB-Lite Interface i */
+#define ATC_DSCR_IF		GENMASK(1, 0)	/* Dsc feched via AHB-Lite Interface */
 
 /* Bitfields in CTRLA */
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
+#define ATC_BTSIZE_MAX		GENMASK(15, 0)	/* Maximum Buffer Transfer Size */
+#define ATC_BTSIZE		GENMASK(15, 0)	/* Buffer Transfer Size */
+#define ATC_SCSIZE		GENMASK(18, 16)	/* Source Chunk Transfer Size */
+#define ATC_DCSIZE		GENMASK(22, 20)	/* Destination Chunk Transfer Size */
+#define ATC_SRC_WIDTH		GENMASK(25, 24)	/* Source Single Transfer Size */
+#define ATC_DST_WIDTH		GENMASK(29, 28)	/* Destination Single Transfer Size */
+#define ATC_DONE		BIT(31)	/* Tx Done (only written back in descriptor) */
 
 /* Bitfields in CTRLB */
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
+#define ATC_SIF			GENMASK(1, 0)	/* Src tx done via AHB-Lite Interface i */
+#define ATC_DIF			GENMASK(5, 4)	/* Dst tx done via AHB-Lite Interface i */
+#define AT_DMA_MEM_IF		0x0		/* interface 0 as memory interface */
+#define AT_DMA_PER_IF		0x1		/* interface 1 as peripheral interface */
+#define ATC_SRC_PIP		BIT(8)		/* Source Picture-in-Picture enabled */
+#define ATC_DST_PIP		BIT(12)		/* Destination Picture-in-Picture enabled */
+#define ATC_SRC_DSCR_DIS	BIT(16)		/* Src Descriptor fetch disable */
+#define ATC_DST_DSCR_DIS	BIT(20)		/* Dst Descriptor fetch disable */
+#define ATC_FC			GENMASK(22, 21)	/* Choose Flow Controller */
+#define ATC_FC_MEM2MEM		0x0		/* Mem-to-Mem (DMA) */
+#define ATC_FC_MEM2PER		0x1		/* Mem-to-Periph (DMA) */
+#define ATC_FC_PER2MEM		0x2		/* Periph-to-Mem (DMA) */
+#define ATC_FC_PER2PER		0x3		/* Periph-to-Periph (DMA) */
+#define ATC_FC_PER2MEM_PER	0x4		/* Periph-to-Mem (Peripheral) */
+#define ATC_FC_MEM2PER_PER	0x5		/* Mem-to-Periph (Peripheral) */
+#define ATC_FC_PER2PER_SRCPER	0x6		/* Periph-to-Periph (Src Peripheral) */
+#define ATC_FC_PER2PER_DSTPER	0x7		/* Periph-to-Periph (Dst Peripheral) */
+#define ATC_SRC_ADDR_MODE	GENMASK(25, 24)
+#define ATC_SRC_ADDR_MODE_INCR	0x0		/* Incrementing Mode */
+#define ATC_SRC_ADDR_MODE_DECR	0x1		/* Decrementing Mode */
+#define ATC_SRC_ADDR_MODE_FIXED	0x2		/* Fixed Mode */
+#define ATC_DST_ADDR_MODE	GENMASK(29, 28)
+#define ATC_DST_ADDR_MODE_INCR	0x0		/* Incrementing Mode */
+#define ATC_DST_ADDR_MODE_DECR	0x1		/* Decrementing Mode */
+#define ATC_DST_ADDR_MODE_FIXED	0x2		/* Fixed Mode */
+#define ATC_IEN			BIT(30)		/* BTC interrupt enable (active low) */
+#define ATC_AUTO		BIT(31)		/* Auto multiple buffer tx enable */
 
 /* Bitfields in CFG */
 #define ATC_PER_MSB(h)	((0x30U & (h)) >> 4)	/* Extract most significant bits of a handshaking identifier */
 
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
+#define ATC_SRC_PER		GENMASK(3, 0)	/* Channel src rq associated with periph handshaking ifc h */
+#define ATC_DST_PER		GENMASK(7, 4)	/* Channel dst rq associated with periph handshaking ifc h */
+#define ATC_SRC_REP		BIT(8)		/* Source Replay Mod */
+#define ATC_SRC_H2SEL		BIT(9)		/* Source Handshaking Mod */
+#define ATC_SRC_PER_MSB		GENMASK(11, 10)	/* Channel src rq (most significant bits) */
+#define ATC_DST_REP		BIT(12)		/* Destination Replay Mod */
+#define ATC_DST_H2SEL		BIT(13)		/* Destination Handshaking Mod */
+#define ATC_DST_PER_MSB		GENMASK(15, 14)	/* Channel dst rq (most significant bits) */
+#define ATC_SOD			BIT(16)		/* Stop On Done */
+#define ATC_LOCK_IF		BIT(20)		/* Interface Lock */
+#define ATC_LOCK_B		BIT(21)		/* AHB Bus Lock */
+#define ATC_LOCK_IF_L		BIT(22)		/* Master Interface Arbiter Lock */
+#define ATC_AHB_PROT		GENMASK(26, 24)	/* AHB Protection */
+#define ATC_FIFOCFG		GENMASK(29, 28)	/* FIFO Request Configuration */
+#define ATC_FIFOCFG_LARGESTBURST	0x0
+#define ATC_FIFOCFG_HALFFIFO		0x1
+#define ATC_FIFOCFG_ENOUGHSPACE		0x2
 
 /* Bitfields in SPIP */
-#define	ATC_SPIP_HOLE(x)	(0xFFFFU & (x))
-#define	ATC_SPIP_BOUNDARY(x)	((0x3FF & (x)) << 16)
+#define ATC_SPIP_HOLE		GENMASK(15, 0)
+#define ATC_SPIP_BOUNDARY	GENMASK(25, 16)
 
 /* Bitfields in DPIP */
-#define	ATC_DPIP_HOLE(x)	(0xFFFFU & (x))
-#define	ATC_DPIP_BOUNDARY(x)	((0x3FF & (x)) << 16)
+#define ATC_DPIP_HOLE		GENMASK(15, 0)
+#define ATC_DPIP_BOUNDARY	GENMASK(25, 16)
+
+#define ATC_SRC_PER_ID(id)	(FIELD_PREP(ATC_SRC_PER_MSB, (id)) |	\
+				 FIELD_PREP(ATC_SRC_PER, (id)))
+#define ATC_DST_PER_ID(id)	(FIELD_PREP(ATC_DST_PER_MSB, (id)) |	\
+				 FIELD_PREP(ATC_DST_PER, (id)))
+
 
 
 /*--  descriptors  -----------------------------------------------------*/
@@ -502,9 +480,9 @@ static void set_desc_eol(struct at_desc *desc)
 	desc->lli.dscr = 0;
 }
 
-#define	ATC_DEFAULT_CFG		(ATC_FIFOCFG_HALFFIFO)
-#define	ATC_DEFAULT_CTRLB	(ATC_SIF(AT_DMA_MEM_IF) \
-				|ATC_DIF(AT_DMA_MEM_IF))
+#define	ATC_DEFAULT_CFG		FIELD_PREP(ATC_FIFOCFG, ATC_FIFOCFG_HALFFIFO)
+#define	ATC_DEFAULT_CTRLB	(FIELD_PREP(ATC_SIF, AT_DMA_MEM_IF) | \
+				 FIELD_PREP(ATC_DIF, AT_DMA_MEM_IF))
 #define ATC_DMA_BUSWIDTHS\
 	(BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED) |\
 	BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |\
@@ -720,10 +698,12 @@ static void atc_dostart(struct at_dma_chan *atchan, struct at_desc *first)
 	channel_writel(atchan, CTRLA, 0);
 	channel_writel(atchan, CTRLB, 0);
 	channel_writel(atchan, DSCR, first->txd.phys);
-	channel_writel(atchan, SPIP, ATC_SPIP_HOLE(first->src_hole) |
-		       ATC_SPIP_BOUNDARY(first->boundary));
-	channel_writel(atchan, DPIP, ATC_DPIP_HOLE(first->dst_hole) |
-		       ATC_DPIP_BOUNDARY(first->boundary));
+	channel_writel(atchan, SPIP, FIELD_PREP(ATC_SPIP_HOLE,
+						first->src_hole) |
+		       FIELD_PREP(ATC_SPIP_BOUNDARY, first->boundary));
+	channel_writel(atchan, DPIP, FIELD_PREP(ATC_DPIP_HOLE,
+						first->dst_hole) |
+		       FIELD_PREP(ATC_DPIP_BOUNDARY, first->boundary));
 	/* Don't allow CPU to reorder channel enable. */
 	wmb();
 	dma_writel(atdma, CHER, atchan->mask);
@@ -763,8 +743,8 @@ static struct at_desc *atc_get_desc_by_cookie(struct at_dma_chan *atchan,
  */
 static inline u32 atc_calc_bytes_left(u32 current_len, u32 ctrla)
 {
-	u32 btsize = (ctrla & ATC_BTSIZE_MAX);
-	u32 src_width = ATC_REG_TO_SRC_WIDTH(ctrla);
+	u32 btsize = FIELD_GET(ATC_BTSIZE, ctrla);
+	u32 src_width = FIELD_GET(ATC_SRC_WIDTH, ctrla);
 
 	/*
 	 * According to the datasheet, when reading the Control A Register
@@ -1203,15 +1183,14 @@ atc_prep_dma_interleaved(struct dma_chan *chan,
 		return NULL;
 	}
 
-	ctrla = ATC_SRC_WIDTH(dwidth) |
-		ATC_DST_WIDTH(dwidth);
+	ctrla = FIELD_PREP(ATC_SRC_WIDTH, dwidth) |
+		FIELD_PREP(ATC_DST_WIDTH, dwidth);
 
-	ctrlb =   ATC_DEFAULT_CTRLB | ATC_IEN
-		| ATC_SRC_ADDR_MODE_INCR
-		| ATC_DST_ADDR_MODE_INCR
-		| ATC_SRC_PIP
-		| ATC_DST_PIP
-		| ATC_FC_MEM2MEM;
+	ctrlb = ATC_DEFAULT_CTRLB | ATC_IEN |
+		FIELD_PREP(ATC_SRC_ADDR_MODE, ATC_SRC_ADDR_MODE_INCR) |
+		FIELD_PREP(ATC_DST_ADDR_MODE, ATC_DST_ADDR_MODE_INCR) |
+		ATC_SRC_PIP | ATC_DST_PIP |
+		FIELD_PREP(ATC_FC, ATC_FC_MEM2MEM);
 
 	/* create the transfer */
 	desc = atc_desc_get(atchan);
@@ -1272,10 +1251,10 @@ atc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 		return NULL;
 	}
 
-	ctrlb =   ATC_DEFAULT_CTRLB | ATC_IEN
-		| ATC_SRC_ADDR_MODE_INCR
-		| ATC_DST_ADDR_MODE_INCR
-		| ATC_FC_MEM2MEM;
+	ctrlb = ATC_DEFAULT_CTRLB | ATC_IEN |
+		FIELD_PREP(ATC_SRC_ADDR_MODE, ATC_SRC_ADDR_MODE_INCR) |
+		FIELD_PREP(ATC_DST_ADDR_MODE, ATC_DST_ADDR_MODE_INCR) |
+		FIELD_PREP(ATC_FC, ATC_FC_MEM2MEM);
 
 	/*
 	 * We can be a lot more clever here, but this should take care
@@ -1283,8 +1262,8 @@ atc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	 */
 	src_width = dst_width = atc_get_xfer_width(src, dest, len);
 
-	ctrla = ATC_SRC_WIDTH(src_width) |
-		ATC_DST_WIDTH(dst_width);
+	ctrla = FIELD_PREP(ATC_SRC_WIDTH, src_width) |
+		FIELD_PREP(ATC_DST_WIDTH, dst_width);
 
 	for (offset = 0; offset < len; offset += xfer_count << src_width) {
 		xfer_count = min_t(size_t, (len - offset) >> src_width,
@@ -1330,11 +1309,11 @@ static struct at_desc *atc_create_memset_desc(struct dma_chan *chan,
 	struct at_desc *desc;
 	size_t xfer_count;
 
-	u32 ctrla = ATC_SRC_WIDTH(2) | ATC_DST_WIDTH(2);
+	u32 ctrla = FIELD_PREP(ATC_SRC_WIDTH, 2) | FIELD_PREP(ATC_DST_WIDTH, 2);
 	u32 ctrlb = ATC_DEFAULT_CTRLB | ATC_IEN |
-		ATC_SRC_ADDR_MODE_FIXED |
-		ATC_DST_ADDR_MODE_INCR |
-		ATC_FC_MEM2MEM;
+		    FIELD_PREP(ATC_SRC_ADDR_MODE, ATC_SRC_ADDR_MODE_FIXED) |
+		    FIELD_PREP(ATC_DST_ADDR_MODE, ATC_DST_ADDR_MODE_INCR) |
+		    FIELD_PREP(ATC_FC, ATC_FC_MEM2MEM);
 
 	xfer_count = len >> 2;
 	if (xfer_count > ATC_BTSIZE_MAX) {
@@ -1549,18 +1528,20 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		return NULL;
 	}
 
-	ctrla =   ATC_SCSIZE(sconfig->src_maxburst)
-		| ATC_DCSIZE(sconfig->dst_maxburst);
+	ctrla = FIELD_PREP(ATC_SCSIZE, sconfig->src_maxburst) |
+		FIELD_PREP(ATC_DCSIZE, sconfig->dst_maxburst);
 	ctrlb = ATC_IEN;
 
 	switch (direction) {
 	case DMA_MEM_TO_DEV:
 		reg_width = convert_buswidth(sconfig->dst_addr_width);
-		ctrla |=  ATC_DST_WIDTH(reg_width);
-		ctrlb |=  ATC_DST_ADDR_MODE_FIXED
-			| ATC_SRC_ADDR_MODE_INCR
-			| ATC_FC_MEM2PER
-			| ATC_SIF(atchan->mem_if) | ATC_DIF(atchan->per_if);
+		ctrla |= FIELD_PREP(ATC_DST_WIDTH, reg_width);
+		ctrlb |= FIELD_PREP(ATC_DST_ADDR_MODE,
+				    ATC_DST_ADDR_MODE_FIXED) |
+			 FIELD_PREP(ATC_SRC_ADDR_MODE, ATC_SRC_ADDR_MODE_INCR) |
+			 FIELD_PREP(ATC_FC, ATC_FC_MEM2PER) |
+			 FIELD_PREP(ATC_SIF, atchan->mem_if) |
+			 FIELD_PREP(ATC_DIF, atchan->per_if);
 		reg = sconfig->dst_addr;
 		for_each_sg(sgl, sg, sg_len, i) {
 			struct at_desc	*desc;
@@ -1584,9 +1565,9 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 
 			desc->lli.saddr = mem;
 			desc->lli.daddr = reg;
-			desc->lli.ctrla = ctrla
-					| ATC_SRC_WIDTH(mem_width)
-					| len >> mem_width;
+			desc->lli.ctrla = ctrla |
+					  FIELD_PREP(ATC_SRC_WIDTH, mem_width) |
+					  len >> mem_width;
 			desc->lli.ctrlb = ctrlb;
 			desc->len = len;
 
@@ -1596,11 +1577,13 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		break;
 	case DMA_DEV_TO_MEM:
 		reg_width = convert_buswidth(sconfig->src_addr_width);
-		ctrla |=  ATC_SRC_WIDTH(reg_width);
-		ctrlb |=  ATC_DST_ADDR_MODE_INCR
-			| ATC_SRC_ADDR_MODE_FIXED
-			| ATC_FC_PER2MEM
-			| ATC_SIF(atchan->per_if) | ATC_DIF(atchan->mem_if);
+		ctrla |= FIELD_PREP(ATC_SRC_WIDTH, reg_width);
+		ctrlb |= FIELD_PREP(ATC_DST_ADDR_MODE, ATC_DST_ADDR_MODE_INCR) |
+			 FIELD_PREP(ATC_SRC_ADDR_MODE,
+				    ATC_SRC_ADDR_MODE_FIXED) |
+			 FIELD_PREP(ATC_FC, ATC_FC_PER2MEM) |
+			 FIELD_PREP(ATC_SIF, atchan->per_if) |
+			 FIELD_PREP(ATC_DIF, atchan->mem_if);
 
 		reg = sconfig->src_addr;
 		for_each_sg(sgl, sg, sg_len, i) {
@@ -1625,9 +1608,9 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 
 			desc->lli.saddr = reg;
 			desc->lli.daddr = mem;
-			desc->lli.ctrla = ctrla
-					| ATC_DST_WIDTH(mem_width)
-					| len >> reg_width;
+			desc->lli.ctrla = ctrla |
+					  FIELD_PREP(ATC_DST_WIDTH, mem_width) |
+					  len >> reg_width;
 			desc->lli.ctrlb = ctrlb;
 			desc->len = len;
 
@@ -1693,22 +1676,24 @@ atc_dma_cyclic_fill_desc(struct dma_chan *chan, struct at_desc *desc,
 	u32			ctrla;
 
 	/* prepare common CRTLA value */
-	ctrla =   ATC_SCSIZE(sconfig->src_maxburst)
-		| ATC_DCSIZE(sconfig->dst_maxburst)
-		| ATC_DST_WIDTH(reg_width)
-		| ATC_SRC_WIDTH(reg_width)
-		| period_len >> reg_width;
+	ctrla = FIELD_PREP(ATC_SCSIZE, sconfig->src_maxburst) |
+		FIELD_PREP(ATC_DCSIZE, sconfig->dst_maxburst) |
+		FIELD_PREP(ATC_DST_WIDTH, reg_width) |
+		FIELD_PREP(ATC_SRC_WIDTH, reg_width) |
+		period_len >> reg_width;
 
 	switch (direction) {
 	case DMA_MEM_TO_DEV:
 		desc->lli.saddr = buf_addr + (period_len * period_index);
 		desc->lli.daddr = sconfig->dst_addr;
 		desc->lli.ctrla = ctrla;
-		desc->lli.ctrlb = ATC_DST_ADDR_MODE_FIXED
-				| ATC_SRC_ADDR_MODE_INCR
-				| ATC_FC_MEM2PER
-				| ATC_SIF(atchan->mem_if)
-				| ATC_DIF(atchan->per_if);
+		desc->lli.ctrlb = FIELD_PREP(ATC_DST_ADDR_MODE,
+					     ATC_DST_ADDR_MODE_FIXED) |
+				  FIELD_PREP(ATC_SRC_ADDR_MODE,
+					     ATC_SRC_ADDR_MODE_INCR) |
+				  FIELD_PREP(ATC_FC, ATC_FC_MEM2PER) |
+				  FIELD_PREP(ATC_SIF, atchan->mem_if) |
+				  FIELD_PREP(ATC_DIF, atchan->per_if);
 		desc->len = period_len;
 		break;
 
@@ -1716,11 +1701,13 @@ atc_dma_cyclic_fill_desc(struct dma_chan *chan, struct at_desc *desc,
 		desc->lli.saddr = sconfig->src_addr;
 		desc->lli.daddr = buf_addr + (period_len * period_index);
 		desc->lli.ctrla = ctrla;
-		desc->lli.ctrlb = ATC_DST_ADDR_MODE_INCR
-				| ATC_SRC_ADDR_MODE_FIXED
-				| ATC_FC_PER2MEM
-				| ATC_SIF(atchan->per_if)
-				| ATC_DIF(atchan->mem_if);
+		desc->lli.ctrlb = FIELD_PREP(ATC_DST_ADDR_MODE,
+					     ATC_DST_ADDR_MODE_INCR) |
+				  FIELD_PREP(ATC_SRC_ADDR_MODE,
+					     ATC_SRC_ADDR_MODE_FIXED) |
+				  FIELD_PREP(ATC_FC, ATC_FC_PER2MEM) |
+				  FIELD_PREP(ATC_SIF, atchan->per_if) |
+				  FIELD_PREP(ATC_DIF, atchan->mem_if);
 		desc->len = period_len;
 		break;
 
@@ -2115,14 +2102,13 @@ static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
 		return NULL;
 	}
 
-	atslave->cfg = ATC_DST_H2SEL_HW | ATC_SRC_H2SEL_HW;
+	atslave->cfg = ATC_DST_H2SEL | ATC_SRC_H2SEL;
 	/*
 	 * We can fill both SRC_PER and DST_PER, one of these fields will be
 	 * ignored depending on DMA transfer direction.
 	 */
 	per_id = dma_spec->args[1] & AT91_DMA_CFG_PER_ID_MASK;
-	atslave->cfg |= ATC_DST_PER_MSB(per_id) | ATC_DST_PER(per_id)
-		     | ATC_SRC_PER_MSB(per_id) | ATC_SRC_PER(per_id);
+	atslave->cfg |= ATC_DST_PER_ID(per_id) |  ATC_SRC_PER_ID(per_id);
 	/*
 	 * We have to translate the value we get from the device tree since
 	 * the half FIFO configuration value had to be 0 to keep backward
@@ -2130,14 +2116,16 @@ static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
 	 */
 	switch (dma_spec->args[1] & AT91_DMA_CFG_FIFOCFG_MASK) {
 	case AT91_DMA_CFG_FIFOCFG_ALAP:
-		atslave->cfg |= ATC_FIFOCFG_LARGESTBURST;
+		atslave->cfg |= FIELD_PREP(ATC_FIFOCFG,
+					   ATC_FIFOCFG_LARGESTBURST);
 		break;
 	case AT91_DMA_CFG_FIFOCFG_ASAP:
-		atslave->cfg |= ATC_FIFOCFG_ENOUGHSPACE;
+		atslave->cfg |= FIELD_PREP(ATC_FIFOCFG,
+					   ATC_FIFOCFG_ENOUGHSPACE);
 		break;
 	case AT91_DMA_CFG_FIFOCFG_HALF:
 	default:
-		atslave->cfg |= ATC_FIFOCFG_HALFFIFO;
+		atslave->cfg |= FIELD_PREP(ATC_FIFOCFG, ATC_FIFOCFG_HALFFIFO);
 	}
 	atslave->dma_dev = &dmac_pdev->dev;
 
-- 
2.25.1

