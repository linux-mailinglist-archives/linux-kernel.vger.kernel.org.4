Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013066B74E9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjCMK6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjCMK6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:58:47 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77E925B8F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:58:42 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:7ed1:e2c6:b94:264a])
        by andre.telenet-ops.be with bizsmtp
        id Xmyg2900501Vtj801mygDA; Mon, 13 Mar 2023 11:58:40 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pbfsQ-00C3I9-HE;
        Mon, 13 Mar 2023 11:58:40 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pbft1-008cWt-Uy;
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
Subject: [PATCH 5/6] spi: Constify spi parameters of chip select APIs
Date:   Mon, 13 Mar 2023 11:58:37 +0100
Message-Id: <b112de79e7a1e9095a3b6ff22b639f39e39d7748.1678704562.git.geert+renesas@glider.be>
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

The "spi" parameters of spi_get_chipselect() and spi_get_csgpiod() can
be const.

Fixes: 303feb3cc06ac066 ("spi: Add APIs in spi core to set/get spi->chip_select and spi->cs_gpiod")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/spi/spi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index e09a61dd34594330..74bff5a2f53d36cc 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -266,7 +266,7 @@ static inline void *spi_get_drvdata(const struct spi_device *spi)
 	return dev_get_drvdata(&spi->dev);
 }
 
-static inline u8 spi_get_chipselect(struct spi_device *spi, u8 idx)
+static inline u8 spi_get_chipselect(const struct spi_device *spi, u8 idx)
 {
 	return spi->chip_select;
 }
@@ -276,7 +276,7 @@ static inline void spi_set_chipselect(struct spi_device *spi, u8 idx, u8 chipsel
 	spi->chip_select = chipselect;
 }
 
-static inline struct gpio_desc *spi_get_csgpiod(struct spi_device *spi, u8 idx)
+static inline struct gpio_desc *spi_get_csgpiod(const struct spi_device *spi, u8 idx)
 {
 	return spi->cs_gpiod;
 }
-- 
2.34.1

