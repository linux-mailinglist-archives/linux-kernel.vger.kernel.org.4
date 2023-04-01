Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11356D3300
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 20:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjDASAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 14:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDASAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 14:00:19 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1343C1CB9B;
        Sat,  1 Apr 2023 11:00:19 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4PplLP1m69z9sSD;
        Sat,  1 Apr 2023 20:00:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0W6b0gppB2Pe; Sat,  1 Apr 2023 20:00:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4PplLN0z4Rz9sV8;
        Sat,  1 Apr 2023 20:00:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0D70A8B841;
        Sat,  1 Apr 2023 20:00:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id KftFVfkjAvZr; Sat,  1 Apr 2023 20:00:11 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.134])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ABE998B844;
        Sat,  1 Apr 2023 20:00:11 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 331I05l5573348
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 1 Apr 2023 20:00:05 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 331I04Z1573317;
        Sat, 1 Apr 2023 20:00:04 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Mark Brown <broonie@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Grant Likely <grant.likely@secretlab.ca>,
        Anton Vorontsov <cbouatmailru@gmail.com>,
        Joakim Tjernlund <Joakim.Tjernlund@transmode.se>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Subject: [PATCH v1 1/5] spi: fsl-spi: Fix CPM/QE mode Litte Endian
Date:   Sat,  1 Apr 2023 19:59:46 +0200
Message-Id: <1b7d3e84b1128f42c1887dd2fb9cdf390f541bc1.1680371809.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680371987; l=2189; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=CgWsJH1kDjKAwWszHPjbBObgOnX301PTR9UI6ftZaso=; b=Ppex+ovDil8envKKHfuDdPmvN3xoLtXTCAwvNlbCY9i9sh+FmKJyUJI6u4FKbmhsxk/PZ682F a7YyVDm7QKEAUG31OhnUidm1SBwTc5XuDNbBZk7KJEb2BX7W2WynPyu
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPM has the same problem as QE so for CPM also use the fix added
by commit 0398fb70940e ("spi/spi_mpc8xxx: Fix QE mode Litte Endian"):

  CPM mode uses Little Endian so words > 8 bits are byte swapped.
  Workaround this by always enforcing wordsize 8 for 16 and 32 bits
  words. Unfortunately this will not work for LSB transfers
  where wordsize is > 8 bits so disable these for now.

Also limit the workaround to 16 and 32 bits words because it can
only work for multiples of 8-bits.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Fixes: 0398fb70940e ("spi/spi_mpc8xxx: Fix QE mode Litte Endian")
---
 drivers/spi/spi-fsl-spi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 93152144fd2e..5602f052b2b5 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -181,8 +181,8 @@ static int mspi_apply_qe_mode_quirks(struct spi_mpc8xxx_cs *cs,
 				struct spi_device *spi,
 				int bits_per_word)
 {
-	/* QE uses Little Endian for words > 8
-	 * so transform all words > 8 into 8 bits
+	/* CPM/QE uses Little Endian for words > 8
+	 * so transform 16 and 32 bits words into 8 bits
 	 * Unfortnatly that doesn't work for LSB so
 	 * reject these for now */
 	/* Note: 32 bits word, LSB works iff
@@ -190,9 +190,11 @@ static int mspi_apply_qe_mode_quirks(struct spi_mpc8xxx_cs *cs,
 	if (spi->mode & SPI_LSB_FIRST &&
 	    bits_per_word > 8)
 		return -EINVAL;
-	if (bits_per_word > 8)
+	if (bits_per_word <= 8)
+		return bits_per_word;
+	if (bits_per_word == 16 || bits_per_word == 32)
 		return 8; /* pretend its 8 bits */
-	return bits_per_word;
+	return -EINVAL;
 }
 
 static int fsl_spi_setup_transfer(struct spi_device *spi,
@@ -222,7 +224,7 @@ static int fsl_spi_setup_transfer(struct spi_device *spi,
 		bits_per_word = mspi_apply_cpu_mode_quirks(cs, spi,
 							   mpc8xxx_spi,
 							   bits_per_word);
-	else if (mpc8xxx_spi->flags & SPI_QE)
+	else
 		bits_per_word = mspi_apply_qe_mode_quirks(cs, spi,
 							  bits_per_word);
 
-- 
2.39.2

