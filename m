Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B77702F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbjEOOUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240239AbjEOOUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:20:39 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79DA2685;
        Mon, 15 May 2023 07:20:35 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4QKh695P20z9sfM;
        Mon, 15 May 2023 16:08:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id n7iBsVw3BR-u; Mon, 15 May 2023 16:08:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4QKh662g1Wz9sfH;
        Mon, 15 May 2023 16:07:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4A0618B770;
        Mon, 15 May 2023 16:07:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id alq4ozSJz5kR; Mon, 15 May 2023 16:07:58 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.36])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 08C2C8B763;
        Mon, 15 May 2023 16:07:57 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 34FE7OO1583495
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 16:07:24 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 34FE7OhM583494;
        Mon, 15 May 2023 16:07:24 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/3][For 4.19/4.14] spi: spi-fsl-spi: automatically adapt bits-per-word in cpu mode
Date:   Mon, 15 May 2023 16:07:13 +0200
Message-Id: <674d9af640acf4aa04abd642cc81de926d3271ed.1684158520.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684159634; l=1846; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=OWc7X3nzzTeipDvjQyYBRZZJhdcswKxTsmbPVSf0T6w=; b=wRJPE7NaTac/3r834KzwijlYzcX1UtMJJV6UAtQ0MOaDVhKWMSQWCsCpEmOR2Pg6Me5ICd3gb epA+e6RJDvEC4MrkUpuXfOyzZwIndITdnQ1g0xp6vMnK7u8+nSVwxEa
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

From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

(cherry picked from upstream af0e6242909c3c4297392ca3e94eff1b4db71a97)

Taking one interrupt for every byte is rather slow. Since the
controller is perfectly capable of transmitting 32 bits at a time,
change t->bits_per-word to 32 when the length is divisible by 4 and
large enough that the reduced number of interrupts easily compensates
for the one or two extra fsl_spi_setup_transfer() calls this causes.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/spi/spi-fsl-spi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 479d10dc6cb8..946b417f2d1c 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -357,12 +357,28 @@ static int fsl_spi_bufs(struct spi_device *spi, struct spi_transfer *t,
 static int fsl_spi_do_one_msg(struct spi_master *master,
 			      struct spi_message *m)
 {
+	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(master);
 	struct spi_device *spi = m->spi;
 	struct spi_transfer *t, *first;
 	unsigned int cs_change;
 	const int nsecs = 50;
 	int status;
 
+	/*
+	 * In CPU mode, optimize large byte transfers to use larger
+	 * bits_per_word values to reduce number of interrupts taken.
+	 */
+	if (!(mpc8xxx_spi->flags & SPI_CPM_MODE)) {
+		list_for_each_entry(t, &m->transfers, transfer_list) {
+			if (t->len < 256 || t->bits_per_word != 8)
+				continue;
+			if ((t->len & 3) == 0)
+				t->bits_per_word = 32;
+			else if ((t->len & 1) == 0)
+				t->bits_per_word = 16;
+		}
+	}
+
 	/* Don't allow changes if CS is active */
 	first = list_first_entry(&m->transfers, struct spi_transfer,
 			transfer_list);
-- 
2.40.1

