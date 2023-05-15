Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C006702F77
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239961AbjEOOUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237208AbjEOOUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:20:30 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A589C1BFB;
        Mon, 15 May 2023 07:20:28 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4QKh652927z9sfK;
        Mon, 15 May 2023 16:07:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TIq3ECWBFt4Z; Mon, 15 May 2023 16:07:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4QKh650yV1z9sfH;
        Mon, 15 May 2023 16:07:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0EF2A8B770;
        Mon, 15 May 2023 16:07:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DVnxLdnlrnuA; Mon, 15 May 2023 16:07:56 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.36])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C5EED8B763;
        Mon, 15 May 2023 16:07:55 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 34FE7PGS583505
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 16:07:25 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 34FE7P4L583504;
        Mon, 15 May 2023 16:07:25 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/3][For 4.19/4.14] spi: fsl-cpm: Use 16 bit mode for large transfers with even size
Date:   Mon, 15 May 2023 16:07:15 +0200
Message-Id: <9363da33f54e9862b4b59c0ed97924ca7265f7a4.1684158520.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <674d9af640acf4aa04abd642cc81de926d3271ed.1684158520.git.christophe.leroy@csgroup.eu>
References: <674d9af640acf4aa04abd642cc81de926d3271ed.1684158520.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684159635; l=3126; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=l7gMBo+J9VneTb7HZST7+pC/HbETdxgOtrQIZaFHdik=; b=Q+cyRKRh9x9rIqyUk77SliaUcnE7JGKafPsMuKOhte+TWtTI/IvZ6MpVBCvlnBAip35wo7Y/5 8g0bvpE1SCsB8AbCr0TZN5mJfLL1MXw54ZPV2ETMxbVJPptxeCXlk4V
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cherry picked from upstream fc96ec826bced75cc6b9c07a4ac44bbf651337ab)

On CPM, the RISC core is a lot more efficiant when doing transfers
in 16-bits chunks than in 8-bits chunks, but unfortunately the
words need to be byte swapped as seen in a previous commit.

So, for large tranfers with an even size, allocate a temporary tx
buffer and byte-swap data before and after transfer.

This change allows setting higher speed for transfer. For instance
on an MPC 8xx (CPM1 comms RISC processor), the documentation tells
that transfer in byte mode at 1 kbit/s uses 0.200% of CPM load
at 25 MHz while a word transfer at the same speed uses 0.032%
of CPM load. This means the speed can be 6 times higher in
word mode for the same CPM load.

For the time being, only do it on CPM1 as there must be a
trade-off between the CPM load reduction and the CPU load required
to byte swap the data.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Link: https://lore.kernel.org/r/f2e981f20f92dd28983c3949702a09248c23845c.1680371809.git.christophe.leroy@csgroup.eu
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-cpm.c | 23 +++++++++++++++++++++++
 drivers/spi/spi-fsl-spi.c |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
index 8f7b26ec181e..0485593dc2f5 100644
--- a/drivers/spi/spi-fsl-cpm.c
+++ b/drivers/spi/spi-fsl-cpm.c
@@ -25,6 +25,7 @@
 #include <linux/spi/spi.h>
 #include <linux/types.h>
 #include <linux/platform_device.h>
+#include <linux/byteorder/generic.h>
 
 #include "spi-fsl-cpm.h"
 #include "spi-fsl-lib.h"
@@ -124,6 +125,21 @@ int fsl_spi_cpm_bufs(struct mpc8xxx_spi *mspi,
 		mspi->rx_dma = mspi->dma_dummy_rx;
 		mspi->map_rx_dma = 0;
 	}
+	if (t->bits_per_word == 16 && t->tx_buf) {
+		const u16 *src = t->tx_buf;
+		u16 *dst;
+		int i;
+
+		dst = kmalloc(t->len, GFP_KERNEL);
+		if (!dst)
+			return -ENOMEM;
+
+		for (i = 0; i < t->len >> 1; i++)
+			dst[i] = cpu_to_le16p(src + i);
+
+		mspi->tx = dst;
+		mspi->map_tx_dma = 1;
+	}
 
 	if (mspi->map_tx_dma) {
 		void *nonconst_tx = (void *)mspi->tx; /* shut up gcc */
@@ -177,6 +193,13 @@ void fsl_spi_cpm_bufs_complete(struct mpc8xxx_spi *mspi)
 	if (mspi->map_rx_dma)
 		dma_unmap_single(dev, mspi->rx_dma, t->len, DMA_FROM_DEVICE);
 	mspi->xfer_in_progress = NULL;
+
+	if (t->bits_per_word == 16 && t->rx_buf) {
+		int i;
+
+		for (i = 0; i < t->len; i += 2)
+			le16_to_cpus(t->rx_buf + i);
+	}
 }
 EXPORT_SYMBOL_GPL(fsl_spi_cpm_bufs_complete);
 
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index e08a11070c5c..5e49fed487f8 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -366,6 +366,9 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 				return -EINVAL;
 			if (t->bits_per_word == 16 || t->bits_per_word == 32)
 				t->bits_per_word = 8; /* pretend its 8 bits */
+			if (t->bits_per_word == 8 && t->len >= 256 &&
+			    (mpc8xxx_spi->flags & SPI_CPM1))
+				t->bits_per_word = 16;
 		}
 	}
 
-- 
2.40.1

