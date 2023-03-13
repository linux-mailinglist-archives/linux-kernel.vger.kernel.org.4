Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E1B6B74EF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjCMK6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCMK6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:58:47 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E744625962
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:58:42 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:7ed1:e2c6:b94:264a])
        by baptiste.telenet-ops.be with bizsmtp
        id Xmyg2900B01Vtj801mygzf; Mon, 13 Mar 2023 11:58:40 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pbfsQ-00C3II-I2;
        Mon, 13 Mar 2023 11:58:40 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pbft1-008cWx-Ve;
        Mon, 13 Mar 2023 11:58:39 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>, Min Li <min.li.xe@renesas.com>,
        Lee Jones <lee@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Michal Simek <michal.simek@amd.com>
Cc:     linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 6/6] spi: sh-msiof: Remove casts to drop constness
Date:   Mon, 13 Mar 2023 11:58:38 +0100
Message-Id: <bc14c7c75f8d63c5c11f61f80daaa53b12bb15fb.1678704562.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1678704562.git.geert+renesas@glider.be>
References: <cover.1678704562.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the chip select APIs take const pointers, there is no longer a need
to cast away constness.

Fixes: 9e264f3f85a56cc1 ("spi: Replace all spi->chip_select and spi->cs_gpiod references with function call")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 50498c4eb661d09f..55dfe2fd89c8ba4c 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -587,11 +587,11 @@ static int sh_msiof_prepare_message(struct spi_controller *ctlr,
 	u32 ss, cs_high;
 
 	/* Configure pins before asserting CS */
-	if (spi_get_csgpiod((struct spi_device *)spi, 0)) {
+	if (spi_get_csgpiod(spi, 0)) {
 		ss = ctlr->unused_native_cs;
 		cs_high = p->native_cs_high;
 	} else {
-		ss = spi_get_chipselect((struct spi_device *)spi, 0);
+		ss = spi_get_chipselect(spi, 0);
 		cs_high = !!(spi->mode & SPI_CS_HIGH);
 	}
 	sh_msiof_spi_set_pin_regs(p, ss, !!(spi->mode & SPI_CPOL),
-- 
2.34.1

