Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1667263DAA9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiK3Qat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiK3Qan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:30:43 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Nov 2022 08:30:39 PST
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CA17BFB0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:30:39 -0800 (PST)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20221130162934b2bc8ab26bff278ea9
        for <linux-kernel@vger.kernel.org>;
        Wed, 30 Nov 2022 17:29:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=MtB5tz/j9s9gUxGsjyyYNfEHmDjtAZKu38geeW3NeWE=;
 b=L4mHrUdkPh9EdH2JANf41RhZvr5a5KYhGv69An6b07S6JQ9hgoL+WU7mqnGWbC/zV2/GTG
 7hXrmKMqosRqxwfsRn7FIUAr0TGuUtyrOzJRmsxHsg0H2Y257vVIT/q67SCCH8zIoXIUN7Qf
 4sfduKJJ8trdI/MQZKylt9nS7EuoY=;
From:   "A. Sverdlin" <alexander.sverdlin@siemens.com>
To:     linux-spi@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@siemens.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v2] spi: spidev: mask SPI_CS_HIGH in SPI_IOC_RD_MODE
Date:   Wed, 30 Nov 2022 17:29:27 +0100
Message-Id: <20221130162927.539512-1-alexander.sverdlin@siemens.com>
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
Changelog:
v2:
- fix SPI_IOC_RD_MODE32 as well

 drivers/spi/spidev.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index b2775d82d2d7b..6313e7d0cdf87 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -377,12 +377,23 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	switch (cmd) {
 	/* read requests */
 	case SPI_IOC_RD_MODE:
-		retval = put_user(spi->mode & SPI_MODE_MASK,
-					(__u8 __user *)arg);
-		break;
 	case SPI_IOC_RD_MODE32:
-		retval = put_user(spi->mode & SPI_MODE_MASK,
-					(__u32 __user *)arg);
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
+		if (cmd == SPI_IOC_RD_MODE)
+			retval = put_user(tmp & SPI_MODE_MASK,
+					  (__u8 __user *)arg);
+		else
+			retval = put_user(tmp & SPI_MODE_MASK,
+					  (__u32 __user *)arg);
 		break;
 	case SPI_IOC_RD_LSB_FIRST:
 		retval = put_user((spi->mode & SPI_LSB_FIRST) ?  1 : 0,
-- 
2.34.1

