Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6815A6B74F1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjCMK7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCMK6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:58:50 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E1425B96
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:58:42 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:7ed1:e2c6:b94:264a])
        by andre.telenet-ops.be with bizsmtp
        id Xmyg2900301Vtj801mygD8; Mon, 13 Mar 2023 11:58:40 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pbfsQ-00C3I2-FR;
        Mon, 13 Mar 2023 11:58:39 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pbft1-008cWg-T7;
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
Subject: [PATCH 2/6] spi: fsl-dspi: Remove unneeded cast to same type
Date:   Mon, 13 Mar 2023 11:58:34 +0100
Message-Id: <a417735ca3ff629ee897327b163b23414673f0a3.1678704562.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1678704562.git.geert+renesas@glider.be>
References: <cover.1678704562.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is never a need to cast a pointer to the same pointer type.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-fsl-dspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index ee42285b5c5243a5..4339485d202c05c7 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1068,7 +1068,7 @@ static int dspi_setup(struct spi_device *spi)
 
 static void dspi_cleanup(struct spi_device *spi)
 {
-	struct chip_data *chip = spi_get_ctldata((struct spi_device *)spi);
+	struct chip_data *chip = spi_get_ctldata(spi);
 
 	dev_dbg(&spi->dev, "spi_device %u.%u cleanup\n",
 		spi->controller->bus_num, spi_get_chipselect(spi, 0));
-- 
2.34.1

