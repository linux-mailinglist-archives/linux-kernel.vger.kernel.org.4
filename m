Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD636244B0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiKJOul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiKJOuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:50:39 -0500
X-Greylist: delayed 347 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 06:50:38 PST
Received: from box.opentheblackbox.net (box.opentheblackbox.net [IPv6:2600:3c02::f03c:92ff:fee2:82bc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2522FFAD7;
        Thu, 10 Nov 2022 06:50:38 -0800 (PST)
Received: from authenticated-user (box.opentheblackbox.net [172.105.151.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.opentheblackbox.net (Postfix) with ESMTPSA id DC99C3FA28;
        Thu, 10 Nov 2022 09:44:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pgazz.com; s=mail;
        t=1668091490; bh=fQdau5QS7mf10RLv3bPTZ0/QHvF1wJc9X2hCGYwzcvk=;
        h=Date:From:To:Cc:Subject:From;
        b=RpGtRxzsgkYxic0iBon465gLp0z5Gr9xa/hUV9flV8XuK07ERNxQca6JHimvNoz6L
         4VbkSEQYqy3+39PofPqzZ970+HgxGuAMdTrWQO38eg1Qieil+FOKIQR3BovmX550N8
         1OTQFzVxp4CXFnJof3wJYto88F7QnM/ZnMFZrAcodRaMAl+aW6sTPtzATc9EKGQ/jJ
         orADq1NOv07VrnvRqwBWdxCZmLSnWlGoLsLqxWbe2D+uEjsy37tRrAkeKPcPAhf9Dk
         iG/r8Zfk1K2F22iwBsfsQNdVliM0snQLGq5neSI+VvJzRej/8c3xVhstqBL9kXoeWk
         i/CXA7tfquv4g==
Date:   Thu, 10 Nov 2022 09:44:48 -0500
From:   Paul Gazzillo <paul@pgazz.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1]: iio: light: rpr0521: add missing Kconfig dependencies
Message-ID: <20221110144448.wexu6neb67krqhla@device>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,RCVD_IN_XBL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steps to reproduce (v6.1-rc2, x86_64):

1. make defconfig menuconfig
2. Enable the driver:
    -> Device Drivers
      -> Industrial I/O support (IIO [=y])
        -> Light sensors
          -> ROHM RPR0521 ALS and proximity sensor driver
3. make drivers/iio/light/rpr0521.o

Causes "implicit declaration of function" errors, e.g.,

    CC      drivers/iio/light/rpr0521.o
  drivers/iio/light/rpr0521.c: In function 'rpr0521_drdy_irq_thread':
  drivers/iio/light/rpr0521.c:434:3: error: implicit declaration of function
           'iio_trigger_poll_chained' [-Werror=implicit-function-declaration]
    434 |   iio_trigger_poll_chained(data->drdy_trigger0);
        |   ^~~~~~~~~~~~~~~~~~~~~~~~

(This bug was found with the help of a tool, krepair, that generates
configuration files for commits: https://github.com/paulgazz/kmax)

The following patch ensures that the code controlled by IIO_BUFFER and
IIO_TRIGGERED_BUFFER is available:

Reported-by: Paul Gazzillo <paul@pgazz.com>
---
 drivers/iio/light/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 7cf6e8490123..0d4447df7200 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -293,6 +293,8 @@ config RPR0521
 	tristate "ROHM RPR0521 ALS and proximity sensor driver"
 	depends on I2C
 	select REGMAP_I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say Y here if you want to build support for ROHM's RPR0521
 	  ambient light and proximity sensor device.
-- 
2.25.1
