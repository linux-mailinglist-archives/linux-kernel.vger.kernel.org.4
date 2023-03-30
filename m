Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118D46D010E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjC3KVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjC3KVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:21:17 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8046C8A47;
        Thu, 30 Mar 2023 03:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1680171667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wiu86Bom9SiZH9wS7LEFisDVIvTWugztSoKHUIOyNN4=;
        b=s1e1N0U5Qd95DMQsIoN0TqQUu/34vQG6++4q+0/2CfJ2U+asCFThFCFpmr6BkklDJ9cZ54
        T9LkxLwIuFLyYddgPrwAyOTXSiwdC+r/6rC+6y/acw9uDVi5nhzRNDInNpYEYSwG2foP9n
        QNc2+NYXIKFlNZoYObEWlAE8zwcw4uo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Alisa Roman <alisa.roman@analog.com>
Subject: [PATCH] iio: adc: ad7192: Change "shorted" channels to differential
Date:   Thu, 30 Mar 2023 12:21:00 +0200
Message-Id: <20230330102100.17590-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AD7192 provides a specific channel configuration where both negative
and positive inputs are connected to AIN2. This was represented in the
ad7192 driver as a IIO channel with .channel = 2 and .extended_name set
to "shorted".

The problem with this approach, is that the driver provided two IIO
channels with the identifier .channel = 2; one "shorted" and the other
not. This goes against the IIO ABI, as a channel identifier should be
unique.

Address this issue by changing "shorted" channels to being differential
instead, with channel 2 vs. itself, as we're actually measuring AIN2 vs.
itself.

Note that the fix tag is for the commit that moved the driver out of
staging. The bug existed before that, but backporting would become very
complex further down and unlikely to happen.

Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Co-developed-by: Alisa Roman <alisa.roman@analog.com>
Signed-off-by: Alisa Roman <alisa.roman@analog.com>
---
 drivers/iio/adc/ad7192.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 55a6ab591016..99bb604b78c8 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -897,10 +897,6 @@ static const struct iio_info ad7195_info = {
 	__AD719x_CHANNEL(_si, _channel1, -1, _address, NULL, IIO_VOLTAGE, \
 		BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_info)
 
-#define AD719x_SHORTED_CHANNEL(_si, _channel1, _address) \
-	__AD719x_CHANNEL(_si, _channel1, -1, _address, "shorted", IIO_VOLTAGE, \
-		BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_info)
-
 #define AD719x_TEMP_CHANNEL(_si, _address) \
 	__AD719x_CHANNEL(_si, 0, -1, _address, NULL, IIO_TEMP, 0, NULL)
 
@@ -908,7 +904,7 @@ static const struct iio_chan_spec ad7192_channels[] = {
 	AD719x_DIFF_CHANNEL(0, 1, 2, AD7192_CH_AIN1P_AIN2M),
 	AD719x_DIFF_CHANNEL(1, 3, 4, AD7192_CH_AIN3P_AIN4M),
 	AD719x_TEMP_CHANNEL(2, AD7192_CH_TEMP),
-	AD719x_SHORTED_CHANNEL(3, 2, AD7192_CH_AIN2P_AIN2M),
+	AD719x_DIFF_CHANNEL(3, 2, 2, AD7192_CH_AIN2P_AIN2M),
 	AD719x_CHANNEL(4, 1, AD7192_CH_AIN1),
 	AD719x_CHANNEL(5, 2, AD7192_CH_AIN2),
 	AD719x_CHANNEL(6, 3, AD7192_CH_AIN3),
@@ -922,7 +918,7 @@ static const struct iio_chan_spec ad7193_channels[] = {
 	AD719x_DIFF_CHANNEL(2, 5, 6, AD7193_CH_AIN5P_AIN6M),
 	AD719x_DIFF_CHANNEL(3, 7, 8, AD7193_CH_AIN7P_AIN8M),
 	AD719x_TEMP_CHANNEL(4, AD7193_CH_TEMP),
-	AD719x_SHORTED_CHANNEL(5, 2, AD7193_CH_AIN2P_AIN2M),
+	AD719x_DIFF_CHANNEL(5, 2, 2, AD7193_CH_AIN2P_AIN2M),
 	AD719x_CHANNEL(6, 1, AD7193_CH_AIN1),
 	AD719x_CHANNEL(7, 2, AD7193_CH_AIN2),
 	AD719x_CHANNEL(8, 3, AD7193_CH_AIN3),
-- 
2.39.2

