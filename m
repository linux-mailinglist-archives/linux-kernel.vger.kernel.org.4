Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0633B6464DE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiLGXPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLGXPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:15:03 -0500
X-Greylist: delayed 320 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 07 Dec 2022 15:15:02 PST
Received: from smtp-out3.electric.net (ipam.electric.net [208.70.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787CC84DE8;
        Wed,  7 Dec 2022 15:15:02 -0800 (PST)
Received: from 1p33Xn-0000xz-TP by out3b.electric.net with emc1-ok (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1p33Xo-000123-U1; Wed, 07 Dec 2022 15:09:40 -0800
Received: by emcmailer; Wed, 07 Dec 2022 15:09:40 -0800
Received: from [66.210.251.27] (helo=mail.embeddedts.com)
        by out3b.electric.net with esmtps  (TLS1.2) tls TLS_DHE_RSA_WITH_SEED_CBC_SHA
        (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1p33Xn-0000xz-TP; Wed, 07 Dec 2022 15:09:39 -0800
Received: from tsdebian.ts-local.net (unknown [75.164.86.214])
        by mail.embeddedts.com (Postfix) with ESMTPSA id 716BF6236;
        Wed,  7 Dec 2022 16:09:59 -0700 (MST)
From:   Kris Bahnsen <kris@embeddedTS.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mark@embeddedTS.com,
        Kris Bahnsen <kris@embeddedTS.com>
Subject: [PATCH] spi: spi-gpio: Don't set MOSI as an input if not 3WIRE mode
Date:   Wed,  7 Dec 2022 15:08:53 -0800
Message-Id: <20221207230853.6174-1-kris@embeddedTS.com>
X-Mailer: git-send-email 2.11.0
X-Outbound-IP: 66.210.251.27
X-Env-From: kris@embeddedTS.com
X-Proto: esmtps
X-Revdns: wsip-66-210-251-27.ph.ph.cox.net
X-HELO: mail.embeddedts.com
X-TLS:  TLS1.2:DHE-RSA-SEED-SHA:128
X-Authenticated_ID: 
X-VIPRE-Scanners: virus_bd;virus_clamav;
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embeddedTS.com; s=mailanyone20220121;h=Message-Id:Date:To:From; bh=OImUirt3A4zEHL9+Yq4pc3tOb7R+KFknOF6v5ZWL6lU=;b=LpZvaY61SIyPJqu2rRwKWORDqecrRUcVZ2qdeS7oB2kQa6hodFFBmZyYtomdSk7mez8dhDom0FQH74oeViuQoE4P1B3OaN3lvuO8L5wKOeWVMHqBseXWzA3uG7pp8e8mZpQPOi6YFbV8wRlyMw0GWYNS8Rs3hvBjJJCZf56VPCDvIC7V/FWHw60gHChbe+/LjuWqEymEobnJpCtVM0Dh1pAL0BWONycZvrIFIk00FHMJRhW3lkQnnL+79nktkxDjjBz3/NoAa7hqJFGILLjMofcFDHTEpz/YDmN/twboOEaQKlMMhm0LxfkFttrisaRIjUPaeLD9u0zllRadeK0nYA==;
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The addition of 3WIRE support would affect MOSI direction even
when still in standard (4 wire) mode. This can lead to MOSI being
at an invalid logic level when a device driver sets an SPI
message with a NULL tx_buf.

spi.h states that if tx_buf is NULL then "zeros will be shifted
out ... " If MOSI is tristated then the data shifted out is subject
to pull resistors, keepers, or in the absence of those, noise.

This issue came to light when using spi-gpio connected to an
ADS7843 touchscreen controller. MOSI pulled high when clocking
MISO data in caused the SPI device to interpret this as a command
which would put the device in an unexpected and non-functional
state.

Fixes: 4b859db2c606 ("spi: spi-gpio: add SPI_3WIRE support")
Fixes: 5132b3d28371 ("spi: gpio: Support 3WIRE high-impedance turn-around")
Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
---

As an aside, I wasn't sure how to best put down the Fixes: tags.
4b859db2c606 ("spi: spi-gpio: add SPI_3WIRE support") introduced the
actual bug, but 5132b3d28371 ("spi: gpio: Support 3WIRE high-impedance turn-around")
modified that commit slightly and is what this patch actually applies
to. Let me know if marking both as fixes is incorrect and I can
create another patch.

 drivers/spi/spi-gpio.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 4b12c4964a66..9c8c7948044e 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -268,9 +268,19 @@ static int spi_gpio_set_direction(struct spi_device *spi, bool output)
 	if (output)
 		return gpiod_direction_output(spi_gpio->mosi, 1);
 
-	ret = gpiod_direction_input(spi_gpio->mosi);
-	if (ret)
-		return ret;
+	/*
+	 * Only change MOSI to an input if using 3WIRE mode.
+	 * Otherwise, MOSI could be left floating if there is
+	 * no pull resistor connected to the I/O pin, or could
+	 * be left logic high if there is a pull-up. Transmitting
+	 * logic high when only clocking MISO data in can put some
+	 * SPI devices in to a bad state.
+	 */
+	if (spi->mode & SPI_3WIRE) {
+		ret = gpiod_direction_input(spi_gpio->mosi);
+		if (ret)
+			return ret;
+	}
 	/*
 	 * Send a turnaround high impedance cycle when switching
 	 * from output to input. Theoretically there should be
-- 
2.11.0

