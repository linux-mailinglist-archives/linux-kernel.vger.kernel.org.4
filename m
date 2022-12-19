Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D8765085E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 09:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiLSIDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 03:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiLSID0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 03:03:26 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3342710;
        Mon, 19 Dec 2022 00:03:24 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id fa4-20020a17090af0c400b002198d1328a0so13543693pjb.0;
        Mon, 19 Dec 2022 00:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SE5EG2RcXnZGveyZgBxlYlUKaJFKWsDPTU6QLh5MsMc=;
        b=bWWNjHVFoL9RRMeI7Hj4RPnCjNuVtwY6vfuAl5kSBACEGzGe8HhMHveb++AZamszxV
         oEosCzv5VrDaBTZVS2jqKxs3sNEMXL3Rgq20xcNJXDQ7G9D6VpDNxntlaayTH/Ce8Ttx
         +DJr05u+vPmCRF4uKjgiy6veqDej8CqSEFxWp5D5kJSG5tWtQVSk8u8GIlAeMW3ZmeIp
         doQpSSsx5Dss6px4bts1QHk3qxkz+LuJyZ1yQb287WWMCYbp/0DDN8uTV8zXagmwTy7/
         ZEiAWUiiEQrK3d7KMeoQ9OiIImxSeOMZi7EppEdwRUinSnk8r35D1QHtQeASAfwnQtFy
         updg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SE5EG2RcXnZGveyZgBxlYlUKaJFKWsDPTU6QLh5MsMc=;
        b=q14cGQZkHrx+VWplrrNtwc+cfr6Upuw0dMls8p3dyQAcp2aoUNTeia0dal1aNb8TFA
         VBD+c57Rowif5d9MPyj9qP2VzP6byAQJYVLfAiNN7joyClLQ/NVens25FiJAarNSNdyH
         +0OJDLMUmMEUzXbMBWM6YqTC85y09HcusEQS3XmOxputkhWaPGxqnSZ79Ri788PwDiPY
         XKdVo7vpnbhRmwEr7cch5Yarp6+DHwi+AqztsTexlxJKeaThuRqIrLQcHEWSsANkoxfF
         5RLZVMkiBHvzQWV8DkbWUqK77jdAtrb+chQOsMqozM8hpF6bL7oRY/1LMBQN3Haa1C5F
         5U+Q==
X-Gm-Message-State: AFqh2koG3ZrjXEZonmIyv0SA60t1MUOE6sV9zTajjDtGOmzSZPKD48NY
        vc8ql7DN2gn7KfUUGeEGRYFCyMQbmaE=
X-Google-Smtp-Source: AMrXdXv3+vkWPWwyGSS7ghlQ6hU+3wmerNcDCv9E+XUwve5CDxzOZZzLinxo3SXYHgCj7bwSjZNmtg==
X-Received: by 2002:a05:6a20:13a6:b0:af:98cd:9dd4 with SMTP id w38-20020a056a2013a600b000af98cd9dd4mr13549031pzh.15.1671437004068;
        Mon, 19 Dec 2022 00:03:24 -0800 (PST)
Received: from localhost ([121.99.145.49])
        by smtp.gmail.com with ESMTPSA id f12-20020aa7968c000000b0057726bd7335sm5906192pfk.121.2022.12.19.00.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 00:03:23 -0800 (PST)
Message-ID: <63a01acb.a70a0220.9a08f.987d@mx.google.com>
From:   Daniel Beer <dlbeer@gmail.com>
Date:   Mon, 19 Dec 2022 20:48:46 +1300
Subject: [PATCH] ad_sigma_delta: fix race between IRQ and completion
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-kernel@vger.kernel.org, Daniel Beer <dlbeer@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ad_sigma_delta waits for a conversion which terminates with the firing
of a one-shot IRQ handler. In this handler, the interrupt is disabled
and a completion is set.

Meanwhile, the thread that initiated the conversion is waiting on the
completion to know when the conversion happened. If this wait times out,
the conversion is aborted and IRQs are disabled. But the IRQ may fire
anyway between the time the completion wait times out and the disabling
of interrupts. If this occurs, we get a double-disabled interrupt.

This patch fixes that by wrapping the completion wait in a function that
handles timeouts correctly by synchronously disabling the interrupt and
then undoing the damage if it got disabled twice.

Fixes: af3008485ea0 ("iio:adc: Add common code for ADI Sigma Delta devices")
Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Daniel Beer <dlbeer@gmail.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 49 +++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index d8570f620785..2f1702eeed56 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -202,6 +202,31 @@ int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
 }
 EXPORT_SYMBOL_NS_GPL(ad_sd_reset, IIO_AD_SIGMA_DELTA);
 
+static int ad_sd_wait_and_disable(struct ad_sigma_delta *sigma_delta,
+				  unsigned long timeout)
+{
+	const int ret = wait_for_completion_interruptible_timeout(
+			&sigma_delta->completion, timeout);
+
+	if (!ret) {
+		/* Just because the completion timed out, doesn't mean that the
+		 * IRQ didn't fire. It might be in progress right now.
+		 */
+		disable_irq(sigma_delta->spi->irq);
+
+		/* The IRQ handler may have run after all. If that happened,
+		 * then we will now have double-disabled the IRQ, and irq_dis
+		 * will be true (having been set in the handler).
+		 */
+		if (sigma_delta->irq_dis)
+			enable_irq(sigma_delta->spi->irq);
+		else
+			sigma_delta->irq_dis = true;
+	}
+
+	return ret;
+}
+
 int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 	unsigned int mode, unsigned int channel)
 {
@@ -223,14 +248,11 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 
 	sigma_delta->irq_dis = false;
 	enable_irq(sigma_delta->spi->irq);
-	timeout = wait_for_completion_timeout(&sigma_delta->completion, 2 * HZ);
-	if (timeout == 0) {
-		sigma_delta->irq_dis = true;
-		disable_irq_nosync(sigma_delta->spi->irq);
+	timeout = ad_sd_wait_and_disable(sigma_delta, 2 * HZ);
+	if (timeout == 0)
 		ret = -EIO;
-	} else {
+	else
 		ret = 0;
-	}
 out:
 	sigma_delta->keep_cs_asserted = false;
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
@@ -296,8 +318,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 
 	sigma_delta->irq_dis = false;
 	enable_irq(sigma_delta->spi->irq);
-	ret = wait_for_completion_interruptible_timeout(
-			&sigma_delta->completion, HZ);
+	ret = ad_sd_wait_and_disable(sigma_delta, HZ);
 
 	if (ret == 0)
 		ret = -EIO;
@@ -314,11 +335,6 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
 		&raw_sample);
 
 out:
-	if (!sigma_delta->irq_dis) {
-		disable_irq_nosync(sigma_delta->spi->irq);
-		sigma_delta->irq_dis = true;
-	}
-
 	sigma_delta->keep_cs_asserted = false;
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
 	sigma_delta->bus_locked = false;
@@ -411,12 +427,7 @@ static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 
 	reinit_completion(&sigma_delta->completion);
-	wait_for_completion_timeout(&sigma_delta->completion, HZ);
-
-	if (!sigma_delta->irq_dis) {
-		disable_irq_nosync(sigma_delta->spi->irq);
-		sigma_delta->irq_dis = true;
-	}
+	ad_sd_wait_and_disable(sigma_delta, HZ);
 
 	sigma_delta->keep_cs_asserted = false;
 	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
-- 
2.38.1

