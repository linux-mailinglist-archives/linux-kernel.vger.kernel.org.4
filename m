Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEDC650E0E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbiLSOtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiLSOr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:47:26 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E077230C;
        Mon, 19 Dec 2022 06:47:15 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 8023EE0EAF;
        Mon, 19 Dec 2022 17:47:15 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=V+r2Qtu2863wYYeGJPNLS0EjGaMUWEE9S7FBIhyos6A=; b=kiYnINa80aVq
        aNA5w8Co/rt69H6U1UwFeULG2Md43l5Di5sA4MxJv5cXWLhYtwVlvshvBxqSuk76
        udfKTgyy8/F7VIzb9uQzucptwk0GztL/Gkf5qsPdIJPZob3Jaqj0nzT4DhC8lpqt
        CJ0UqA+vyE6Pfizj1RngLSt7N+87/R4=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 72954E0E70;
        Mon, 19 Dec 2022 17:47:15 +0300 (MSK)
Received: from localhost (10.8.30.14) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Mon, 19 Dec 2022 17:47:15 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 19/26] dmaengine: dw-edma: Use non-atomic io-64 methods
Date:   Mon, 19 Dec 2022 17:46:50 +0300
Message-ID: <20221219144658.26620-20-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219144658.26620-1-Sergey.Semin@baikalelectronics.ru>
References: <20221219144658.26620-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.14]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of splitting the 64-bits IOs up into two 32-bits ones it's
possible to use the already available non-atomic readq/writeq methods
implemented exactly for such cases. They are defined in the dedicated
header files io-64-nonatomic-lo-hi.h/io-64-nonatomic-hi-lo.h. So in case
if the 64-bits readq/writeq methods are unavailable on some platforms at
consideration, the corresponding drivers can have any of these headers
included and stop locally re-implementing the 64-bits IO accessors taking
into account the non-atomic nature of the included methods. Let's do that
in the DW eDMA driver too. Note by doing so we can discard the
CONFIG_64BIT config ifdefs from the code.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-v0-core.c | 55 +++++++++------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 66f296daac5a..51a34b43434c 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -8,6 +8,8 @@
 
 #include <linux/bitfield.h>
 
+#include <linux/io-64-nonatomic-lo-hi.h>
+
 #include "dw-edma-core.h"
 #include "dw-edma-v0-core.h"
 #include "dw-edma-v0-regs.h"
@@ -53,8 +55,6 @@ static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
 		SET_32(dw, rd_##name, value);		\
 	} while (0)
 
-#ifdef CONFIG_64BIT
-
 #define SET_64(dw, name, value)				\
 	writeq(value, &(__dw_regs(dw)->name))
 
@@ -80,8 +80,6 @@ static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
 		SET_64(dw, rd_##name, value);		\
 	} while (0)
 
-#endif /* CONFIG_64BIT */
-
 #define SET_COMPAT(dw, name, value)			\
 	writel(value, &(__dw_regs(dw)->type.unroll.name))
 
@@ -164,14 +162,13 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 #define SET_LL_32(ll, value) \
 	writel(value, ll)
 
-#ifdef CONFIG_64BIT
-
 static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 			     u64 value, void __iomem *addr)
 {
+	unsigned long flags;
+
 	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
 		u32 viewport_sel;
-		unsigned long flags;
 
 		raw_spin_lock_irqsave(&dw->lock, flags);
 
@@ -181,22 +178,22 @@ static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 
 		writel(viewport_sel,
 		       &(__dw_regs(dw)->type.legacy.viewport_sel));
-		writeq(value, addr);
+	}
+
+	writeq(value, addr);
 
+	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY)
 		raw_spin_unlock_irqrestore(&dw->lock, flags);
-	} else {
-		writeq(value, addr);
-	}
 }
 
 static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 			   const void __iomem *addr)
 {
-	u32 value;
+	unsigned long flags;
+	u64 value;
 
 	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
 		u32 viewport_sel;
-		unsigned long flags;
 
 		raw_spin_lock_irqsave(&dw->lock, flags);
 
@@ -206,12 +203,12 @@ static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 
 		writel(viewport_sel,
 		       &(__dw_regs(dw)->type.legacy.viewport_sel));
-		value = readq(addr);
+	}
+
+	value = readq(addr);
 
+	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY)
 		raw_spin_unlock_irqrestore(&dw->lock, flags);
-	} else {
-		value = readq(addr);
-	}
 
 	return value;
 }
@@ -225,8 +222,6 @@ static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 #define SET_LL_64(ll, value) \
 	writeq(value, ll)
 
-#endif /* CONFIG_64BIT */
-
 /* eDMA management callbacks */
 void dw_edma_v0_core_off(struct dw_edma *dw)
 {
@@ -325,19 +320,10 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 		/* Transfer size */
 		SET_LL_32(&lli[i].transfer_size, child->sz);
 		/* SAR */
-		#ifdef CONFIG_64BIT
-			SET_LL_64(&lli[i].sar.reg, child->sar);
-		#else /* CONFIG_64BIT */
-			SET_LL_32(&lli[i].sar.lsb, lower_32_bits(child->sar));
-			SET_LL_32(&lli[i].sar.msb, upper_32_bits(child->sar));
-		#endif /* CONFIG_64BIT */
+		SET_LL_64(&lli[i].sar.reg, child->sar);
 		/* DAR */
-		#ifdef CONFIG_64BIT
-			SET_LL_64(&lli[i].dar.reg, child->dar);
-		#else /* CONFIG_64BIT */
-			SET_LL_32(&lli[i].dar.lsb, lower_32_bits(child->dar));
-			SET_LL_32(&lli[i].dar.msb, upper_32_bits(child->dar));
-		#endif /* CONFIG_64BIT */
+		SET_LL_64(&lli[i].dar.reg, child->dar);
+
 		i++;
 	}
 
@@ -349,12 +335,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	/* Channel control */
 	SET_LL_32(&llp->control, control);
 	/* Linked list */
-	#ifdef CONFIG_64BIT
-		SET_LL_64(&llp->llp.reg, chunk->ll_region.paddr);
-	#else /* CONFIG_64BIT */
-		SET_LL_32(&llp->llp.lsb, lower_32_bits(chunk->ll_region.paddr));
-		SET_LL_32(&llp->llp.msb, upper_32_bits(chunk->ll_region.paddr));
-	#endif /* CONFIG_64BIT */
+	SET_LL_64(&llp->llp.reg, chunk->ll_region.paddr);
 }
 
 void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
-- 
2.38.1


