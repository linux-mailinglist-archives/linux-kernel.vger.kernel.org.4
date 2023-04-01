Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7996A6D3302
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 20:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjDASA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 14:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDASAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 14:00:22 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B292325570;
        Sat,  1 Apr 2023 11:00:21 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4PplLQ349wz9sV8;
        Sat,  1 Apr 2023 20:00:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id R8cb4RF3CLXf; Sat,  1 Apr 2023 20:00:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4PplLN176nz9sV9;
        Sat,  1 Apr 2023 20:00:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 10EBD8B84A;
        Sat,  1 Apr 2023 20:00:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tEPuPQF0yVAb; Sat,  1 Apr 2023 20:00:11 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.134])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A77368B837;
        Sat,  1 Apr 2023 20:00:11 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 331I05Zd573356
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 1 Apr 2023 20:00:06 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 331I05R9573355;
        Sat, 1 Apr 2023 20:00:05 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Mark Brown <broonie@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Grant Likely <grant.likely@secretlab.ca>,
        Anton Vorontsov <cbouatmailru@gmail.com>,
        Joakim Tjernlund <Joakim.Tjernlund@transmode.se>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] spi: fsl-cpm: Use 16 bit mode for large transfers with even size
Date:   Sat,  1 Apr 2023 19:59:48 +0200
Message-Id: <f2e981f20f92dd28983c3949702a09248c23845c.1680371809.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1b7d3e84b1128f42c1887dd2fb9cdf390f541bc1.1680371809.git.christophe.leroy@csgroup.eu>
References: <1b7d3e84b1128f42c1887dd2fb9cdf390f541bc1.1680371809.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680371987; l=2940; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=lVLQUGMytV7/53kYwCEUJcA4ot68EwNziN6Q6ZstEIE=; b=lRwVBXnm/gcJzpDaE24yNC0vlsGWUhBLNV022NIXbOaukEArzY0Vg9lq6hXL6PqrrFx+iW62A IbA/u8yrng9C/VtCbdlmLccU9SUKNv5PcBbuzQ2dgvrMVOQo8sqppJ3
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/spi/spi-fsl-cpm.c | 23 +++++++++++++++++++++++
 drivers/spi/spi-fsl-spi.c |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
index 17a44d4f5021..38452089e8f3 100644
--- a/drivers/spi/spi-fsl-cpm.c
+++ b/drivers/spi/spi-fsl-cpm.c
@@ -21,6 +21,7 @@
 #include <linux/spi/spi.h>
 #include <linux/types.h>
 #include <linux/platform_device.h>
+#include <linux/byteorder/generic.h>
 
 #include "spi-fsl-cpm.h"
 #include "spi-fsl-lib.h"
@@ -120,6 +121,21 @@ int fsl_spi_cpm_bufs(struct mpc8xxx_spi *mspi,
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
@@ -173,6 +189,13 @@ void fsl_spi_cpm_bufs_complete(struct mpc8xxx_spi *mspi)
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
index 7e0aca620b72..b14f430a699d 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -351,6 +351,9 @@ static int fsl_spi_prepare_message(struct spi_controller *ctlr,
 				return -EINVAL;
 			if (t->bits_per_word == 16 || t->bits_per_word == 32)
 				t->bits_per_word = 8; /* pretend its 8 bits */
+			if (t->bits_per_word == 8 && t->len >= 256 &&
+			    (mpc8xxx_spi->flags & SPI_CPM1))
+				t->bits_per_word = 16;
 		}
 	}
 	return fsl_spi_setup_transfer(m->spi, first);
-- 
2.39.2

