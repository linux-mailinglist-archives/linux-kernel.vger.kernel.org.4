Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313E0702F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240672AbjEOOUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240436AbjEOOUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:20:43 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847DE2D4F;
        Mon, 15 May 2023 07:20:39 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4QKh686nRNz9sff;
        Mon, 15 May 2023 16:08:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sP8Prco6FGrk; Mon, 15 May 2023 16:08:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4QKh660K6pz9sfM;
        Mon, 15 May 2023 16:07:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EE52A8B770;
        Mon, 15 May 2023 16:07:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YeSbbQzs-Bkw; Mon, 15 May 2023 16:07:57 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.36])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B28C18B763;
        Mon, 15 May 2023 16:07:57 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 34FE7Poh583509
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 16:07:25 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 34FE7P9G583508;
        Mon, 15 May 2023 16:07:25 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2][For 5.15/5.10/5.4] spi: fsl-spi: Re-organise transfer bits_per_word adaptation
Date:   Mon, 15 May 2023 16:07:16 +0200
Message-Id: <1e4bfb4850ba849c316f48a0ab0d7123da0e2f54.1684156552.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <674d9af640acf4aa04abd642cc81de926d3271ed.1684158520.git.christophe.leroy@csgroup.eu>
References: <674d9af640acf4aa04abd642cc81de926d3271ed.1684158520.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684159635; l=4013; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=5Lf/4Fp+QxG7Girtdqkg/6yPgFLDCR7G2jYrA/4gH7M=; b=n/nc1XrPunIxYVs+C91SiaBWUQz7EQotCpbnWzkQnrWyZJAuP9PYD8FAok5YUKMZbB6tDx27t 8oi3cU8toekARz39ad/vDwPWmDli59fCmFYun/sUCYfs451s5lHs74v
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

(backported from upstream 8a5299a1278eadf1e08a598a5345c376206f171e)

For different reasons, fsl-spi driver performs bits_per_word
modifications for different reasons:
- On CPU mode, to minimise amount of interrupts
- On CPM/QE mode to work around controller byte order

For CPU mode that's done in fsl_spi_prepare_message() while
for CPM mode that's done in fsl_spi_setup_transfer().

Reunify all of it in fsl_spi_prepare_message(), and catch
impossible cases early through master's bits_per_word_mask
instead of returning EINVAL later.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Link: https://lore.kernel.org/r/0ce96fe96e8b07cba0613e4097cfd94d09b8919a.1680371809.git.christophe.leroy@csgroup.eu
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-spi.c | 50 ++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 1bad0ceac81b..f1d4aa310233 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -203,26 +203,6 @@ static int mspi_apply_cpu_mode_quirks(struct spi_mpc8xxx_cs *cs,
 	return bits_per_word;
 }
 
-static int mspi_apply_qe_mode_quirks(struct spi_mpc8xxx_cs *cs,
-				struct spi_device *spi,
-				int bits_per_word)
-{
-	/* CPM/QE uses Little Endian for words > 8
-	 * so transform 16 and 32 bits words into 8 bits
-	 * Unfortnatly that doesn't work for LSB so
-	 * reject these for now */
-	/* Note: 32 bits word, LSB works iff
-	 * tfcr/rfcr is set to CPMFCR_GBL */
-	if (spi->mode & SPI_LSB_FIRST &&
-	    bits_per_word > 8)
-		return -EINVAL;
-	if (bits_per_word <= 8)
-		return bits_per_word;
-	if (bits_per_word == 16 || bits_per_word == 32)
-		return 8; /* pretend its 8 bits */
-	return -EINVAL;
-}
-
 static int fsl_spi_setup_transfer(struct spi_device *spi,
 					struct spi_transfer *t)
 {
@@ -250,9 +230,6 @@ static int fsl_spi_setup_transfer(struct spi_device *spi,
 		bits_per_word = mspi_apply_cpu_mode_quirks(cs, spi,
 							   mpc8xxx_spi,
 							   bits_per_word);
-	else
-		bits_per_word = mspi_apply_qe_mode_quirks(cs, spi,
-							  bits_per_word);
 
 	if (bits_per_word < 0)
 		return bits_per_word;
@@ -370,14 +347,27 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 	 * In CPU mode, optimize large byte transfers to use larger
 	 * bits_per_word values to reduce number of interrupts taken.
 	 */
-	if (!(mpc8xxx_spi->flags & SPI_CPM_MODE)) {
-		list_for_each_entry(t, &m->transfers, transfer_list) {
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (!(mpc8xxx_spi->flags & SPI_CPM_MODE)) {
 			if (t->len < 256 || t->bits_per_word != 8)
 				continue;
 			if ((t->len & 3) == 0)
 				t->bits_per_word = 32;
 			else if ((t->len & 1) == 0)
 				t->bits_per_word = 16;
+		} else {
+			/*
+			 * CPM/QE uses Little Endian for words > 8
+			 * so transform 16 and 32 bits words into 8 bits
+			 * Unfortnatly that doesn't work for LSB so
+			 * reject these for now
+			 * Note: 32 bits word, LSB works iff
+			 * tfcr/rfcr is set to CPMFCR_GBL
+			 */
+			if (m->spi->mode & SPI_LSB_FIRST && t->bits_per_word > 8)
+				return -EINVAL;
+			if (t->bits_per_word == 16 || t->bits_per_word == 32)
+				t->bits_per_word = 8; /* pretend its 8 bits */
 		}
 	}
 
@@ -635,8 +625,14 @@ static struct spi_master *fsl_spi_probe(struct device *dev,
 	if (mpc8xxx_spi->type == TYPE_GRLIB)
 		fsl_spi_grlib_probe(dev);
 
-	master->bits_per_word_mask =
-		(SPI_BPW_RANGE_MASK(4, 16) | SPI_BPW_MASK(32)) &
+	if (mpc8xxx_spi->flags & SPI_CPM_MODE)
+		master->bits_per_word_mask =
+			(SPI_BPW_RANGE_MASK(4, 8) | SPI_BPW_MASK(16) | SPI_BPW_MASK(32));
+	else
+		master->bits_per_word_mask =
+			(SPI_BPW_RANGE_MASK(4, 16) | SPI_BPW_MASK(32));
+
+	master->bits_per_word_mask &=
 		SPI_BPW_RANGE_MASK(1, mpc8xxx_spi->max_bits_per_word);
 
 	if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE)
-- 
2.40.1

