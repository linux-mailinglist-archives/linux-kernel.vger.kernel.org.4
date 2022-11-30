Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E386B63D860
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiK3OlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiK3OlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:41:05 -0500
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Nov 2022 06:41:01 PST
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0242FFE8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:41:00 -0800 (PST)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20221130143956f1027e955ed21a8562
        for <linux-kernel@vger.kernel.org>;
        Wed, 30 Nov 2022 15:39:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=dpt5mrvPw7RM7k6Ey4ll2TJ6SXaTSEx8JWL9PuzsCpk=;
 b=DRLweHjIruPYZjaXyBdguWxe1SX2EiS6ywDH+hMPwfiN520wk1EfkE4Ofov8tv1Fd3S5GR
 yTA1gcDL+3KkeFQoqEGxcilvhre+wva8mp+DMiqONebpm+daMZ80GQHD7qDpI66Bn+Rf9D27
 Dh8eJdwhEXwI8NsVpCw7p97BRRjLs=;
From:   "A. Sverdlin" <alexander.sverdlin@siemens.com>
To:     linux-spi@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@siemens.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH] spi: spidev: mask SPI_CS_HIGH in SPI_IOC_RD_MODE
Date:   Wed, 30 Nov 2022 15:39:48 +0100
Message-Id: <20221130143948.426640-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Commit f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
has changed the user-space interface so that bogus SPI_CS_HIGH started
to appear in the mask returned by SPI_IOC_RD_MODE even for active-low CS
pins. Commit 138c9c32f090
("spi: spidev: Fix CS polarity if GPIO descriptors are used") fixed only
SPI_IOC_WR_MODE part of the problem. Let's fix SPI_IOC_RD_MODE
symmetrically.

Test case:

	#include <sys/ioctl.h>
	#include <fcntl.h>
	#include <linux/spi/spidev.h>

	int main(int argc, char **argv)
	{
		char modew = SPI_CPHA;
		char moder;
		int f = open("/dev/spidev0.0", O_RDWR);

		if (f < 0)
			return 1;

		ioctl(f, SPI_IOC_WR_MODE, &modew);
		ioctl(f, SPI_IOC_RD_MODE, &moder);

		return moder == modew ? 0 : 2;
	}

Fixes: f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/spi/spidev.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index b2775d82d2d7b..23177a7c916c3 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -377,8 +377,17 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	switch (cmd) {
 	/* read requests */
 	case SPI_IOC_RD_MODE:
-		retval = put_user(spi->mode & SPI_MODE_MASK,
-					(__u8 __user *)arg);
+		tmp = spi->mode;
+
+		{
+			struct spi_controller *ctlr = spi->controller;
+
+			if (ctlr->use_gpio_descriptors && ctlr->cs_gpiods &&
+			    ctlr->cs_gpiods[spi->chip_select])
+				tmp &= ~SPI_CS_HIGH;
+		}
+
+		retval = put_user(tmp & SPI_MODE_MASK, (__u8 __user *)arg);
 		break;
 	case SPI_IOC_RD_MODE32:
 		retval = put_user(spi->mode & SPI_MODE_MASK,
-- 
2.34.1

