Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64416D3306
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 20:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjDASAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 14:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjDASAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 14:00:37 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A85265AB;
        Sat,  1 Apr 2023 11:00:29 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4PplLX4mtSz9sVF;
        Sat,  1 Apr 2023 20:00:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1We6b6nlkxln; Sat,  1 Apr 2023 20:00:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4PplLX3xB6z9sVB;
        Sat,  1 Apr 2023 20:00:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 75DFF8B841;
        Sat,  1 Apr 2023 20:00:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id bKU_w5W2O2fv; Sat,  1 Apr 2023 20:00:20 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.134])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3635B8B837;
        Sat,  1 Apr 2023 20:00:20 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 331I0BUU573368
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 1 Apr 2023 20:00:11 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 331I0B1j573363;
        Sat, 1 Apr 2023 20:00:11 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Mark Brown <broonie@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Grant Likely <grant.likely@secretlab.ca>,
        Anton Vorontsov <cbouatmailru@gmail.com>,
        Joakim Tjernlund <Joakim.Tjernlund@transmode.se>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] spi: fsl-spi: No need to check transfer length versus word size
Date:   Sat,  1 Apr 2023 19:59:50 +0200
Message-Id: <9ace69a8085e22fafd9159e99edd7bbfae2f9940.1680371809.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1b7d3e84b1128f42c1887dd2fb9cdf390f541bc1.1680371809.git.christophe.leroy@csgroup.eu>
References: <1b7d3e84b1128f42c1887dd2fb9cdf390f541bc1.1680371809.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680371987; l=984; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=hDCmrEe6o7BVI++8Bmh+Jjuo/S+dkFP/T6OxyOCQ3ig=; b=3xbEppuBrUE5lXt+oR5zif9k15I3E7RJyyz48IY/jL7gV6/I6v0zdT1x/v2//U734hYpVKGAB XvQLcQmeygQBkeQG8BvzK0/kBL4qg3tIf+S4PWAmOqnIaK9/N9iCaK9
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The verification is already do in the SPI core by function
__spi_validate(), not it to check it again in fsl_spi_bufs().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/spi/spi-fsl-spi.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index d011beddee29..9938b058c9e2 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -263,18 +263,10 @@ static int fsl_spi_bufs(struct spi_device *spi, struct spi_transfer *t,
 	if (t->bits_per_word)
 		bits_per_word = t->bits_per_word;
 
-	if (bits_per_word > 8) {
-		/* invalid length? */
-		if (len & 1)
-			return -EINVAL;
+	if (bits_per_word > 8)
 		len /= 2;
-	}
-	if (bits_per_word > 16) {
-		/* invalid length? */
-		if (len & 1)
-			return -EINVAL;
+	if (bits_per_word > 16)
 		len /= 2;
-	}
 
 	mpc8xxx_spi->tx = t->tx_buf;
 	mpc8xxx_spi->rx = t->rx_buf;
-- 
2.39.2

