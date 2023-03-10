Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDAB6B3A57
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjCJJ0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjCJJ0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:26:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A746610A2B0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:22:05 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lgo@pengutronix.de>)
        id 1paYwN-0002lF-P7; Fri, 10 Mar 2023 10:21:31 +0100
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1paYwM-0038yl-36; Fri, 10 Mar 2023 10:21:30 +0100
Received: from lgo by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1paYwL-004Dqb-De; Fri, 10 Mar 2023 10:21:29 +0100
From:   =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
To:     Alain Volmat <alain.volmat@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     kernel@pengutronix.de,
        =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] spi: stm32: split large transfers based on word size instead of bytes
Date:   Fri, 10 Mar 2023 10:20:53 +0100
Message-Id: <20230310092053.1006459-2-l.goehrs@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230310092053.1006459-1-l.goehrs@pengutronix.de>
References: <20230310092053.1006459-1-l.goehrs@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: lgo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TSIZE register in CR2, to which the number of words to transfer
is written, is only 16 Bit. This limits transfers to 65535 SPI
_words_ at a time. The existing code uses spi_split_transfers_maxsize
to limit transfers to 65535 _bytes_ at a time.

This breaks large transfers with bits_per_word > 8, as they are
split inside of a word boundary by the odd size limit.

Split transfers based on the number of words instead.
This has the added benefit of not artificially limiting the maximum
length of bpw > 8 transfers to half or a quarter of the actual limit.

The combination of very large transfers and bits_per_word = 16 is triggered
e.g. by MIPI DBI displays when updating large parts of the screen.

Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
---
 drivers/spi/spi-stm32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index def09cf0dc14..d2e16f16fae6 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -984,9 +984,9 @@ static int stm32_spi_prepare_msg(struct spi_master *master,
 	if (spi->cfg->set_number_of_data) {
 		int ret;
 
-		ret = spi_split_transfers_maxsize(master, msg,
-						  STM32H7_SPI_TSIZE_MAX,
-						  GFP_KERNEL | GFP_DMA);
+		ret = spi_split_transfers_maxwords(master, msg,
+						   STM32H7_SPI_TSIZE_MAX,
+						   GFP_KERNEL | GFP_DMA);
 		if (ret)
 			return ret;
 	}
-- 
2.30.2

