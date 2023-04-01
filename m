Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD476D32FF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 20:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjDASAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 14:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDASAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 14:00:17 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1711C1E2;
        Sat,  1 Apr 2023 11:00:14 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4PplLN1f0Zz9sVC;
        Sat,  1 Apr 2023 20:00:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id B9eTxWX3FjsX; Sat,  1 Apr 2023 20:00:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4PplLN0TxTz9sSD;
        Sat,  1 Apr 2023 20:00:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F36D98B847;
        Sat,  1 Apr 2023 20:00:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id IBL46jb69r6G; Sat,  1 Apr 2023 20:00:11 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.134])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A87038B841;
        Sat,  1 Apr 2023 20:00:11 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 331I06ME573360
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 1 Apr 2023 20:00:06 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 331I06i9573359;
        Sat, 1 Apr 2023 20:00:06 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Mark Brown <broonie@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Grant Likely <grant.likely@secretlab.ca>,
        Anton Vorontsov <cbouatmailru@gmail.com>,
        Joakim Tjernlund <Joakim.Tjernlund@transmode.se>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] spi: fsl-spi: Change mspi_apply_cpu_mode_quirks() to void
Date:   Sat,  1 Apr 2023 19:59:49 +0200
Message-Id: <3142a7c40af12a160f4e134764f2c34da3d8e1e2.1680371809.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1b7d3e84b1128f42c1887dd2fb9cdf390f541bc1.1680371809.git.christophe.leroy@csgroup.eu>
References: <1b7d3e84b1128f42c1887dd2fb9cdf390f541bc1.1680371809.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680371987; l=2214; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=y+PEJF6XqVie4ke0nw0Agu0nauLo+Hi4IlqTBMxDKYQ=; b=0IkDFT6u0GqSYJR3DZcnpbTEdlLJX5cECznJLKi5CAz8Xfb3jQtqbVeHyQY8bFpwgag/bCGaY LCyy6FFB50SBl0fpMKkviMCQcQiW3w/AYyK/NnMA9Z2HgI2FxpKA+OK
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mspi_apply_cpu_mode_quirks() always returns the passed bits_per_word
unmodified.

Make it return void, then don't check bits_per_word anymore on
return as it doesn't change.

bits_per_word is already checked by __spi_validate() so no risk to
have bits_per_word higher than 32.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/spi/spi-fsl-spi.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index b14f430a699d..d011beddee29 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -145,10 +145,10 @@ static void fsl_spi_grlib_set_shifts(u32 *rx_shift, u32 *tx_shift,
 	}
 }
 
-static int mspi_apply_cpu_mode_quirks(struct spi_mpc8xxx_cs *cs,
-				struct spi_device *spi,
-				struct mpc8xxx_spi *mpc8xxx_spi,
-				int bits_per_word)
+static void mspi_apply_cpu_mode_quirks(struct spi_mpc8xxx_cs *cs,
+				       struct spi_device *spi,
+				       struct mpc8xxx_spi *mpc8xxx_spi,
+				       int bits_per_word)
 {
 	cs->rx_shift = 0;
 	cs->tx_shift = 0;
@@ -161,8 +161,7 @@ static int mspi_apply_cpu_mode_quirks(struct spi_mpc8xxx_cs *cs,
 	} else if (bits_per_word <= 32) {
 		cs->get_rx = mpc8xxx_spi_rx_buf_u32;
 		cs->get_tx = mpc8xxx_spi_tx_buf_u32;
-	} else
-		return -EINVAL;
+	}
 
 	if (mpc8xxx_spi->set_shifts)
 		mpc8xxx_spi->set_shifts(&cs->rx_shift, &cs->tx_shift,
@@ -173,8 +172,6 @@ static int mspi_apply_cpu_mode_quirks(struct spi_mpc8xxx_cs *cs,
 	mpc8xxx_spi->tx_shift = cs->tx_shift;
 	mpc8xxx_spi->get_rx = cs->get_rx;
 	mpc8xxx_spi->get_tx = cs->get_tx;
-
-	return bits_per_word;
 }
 
 static int fsl_spi_setup_transfer(struct spi_device *spi,
@@ -201,12 +198,7 @@ static int fsl_spi_setup_transfer(struct spi_device *spi,
 		hz = spi->max_speed_hz;
 
 	if (!(mpc8xxx_spi->flags & SPI_CPM_MODE))
-		bits_per_word = mspi_apply_cpu_mode_quirks(cs, spi,
-							   mpc8xxx_spi,
-							   bits_per_word);
-
-	if (bits_per_word < 0)
-		return bits_per_word;
+		mspi_apply_cpu_mode_quirks(cs, spi, mpc8xxx_spi, bits_per_word);
 
 	if (bits_per_word == 32)
 		bits_per_word = 0;
-- 
2.39.2

