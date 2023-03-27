Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8616CA314
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjC0MJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjC0MJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:09:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249973A94
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679918911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=f6OgJqgpSNTTFYSUSudYbvVLpng6GaBH202qHK3zoFk=;
        b=GRtKQ8ZPIGezvq0f9RP1TxcsJ1sz8zb38pOyP2bCjhVERraEE+Bfww0CY22xi7TzmZcndd
        toT2wT6HUwdZbTLD4dvw8OLAyfNkLSAFft762oSt1pGyrv9xAeEuBcQgYf/YkH9CJvA0bb
        tNaC1lp5QdNsQxMVDlKpg3ya/y57w8c=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-I2WpT1nbO1Oy0aDp0Vk7qA-1; Mon, 27 Mar 2023 08:08:27 -0400
X-MC-Unique: I2WpT1nbO1Oy0aDp0Vk7qA-1
Received: by mail-qt1-f197.google.com with SMTP id n10-20020a05622a11ca00b003e4e30c6c98so3123546qtk.19
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679918907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6OgJqgpSNTTFYSUSudYbvVLpng6GaBH202qHK3zoFk=;
        b=cOjRRvBxg6WtEopH/JhshzXV/QmH7ll4IgQlTwwwtohIAmU927P0OrZzMP6X4PsP+L
         Mym9dkIrHwmATUHQ47eZ1TyeKUNU4UcY+BqY+Yi/kq/9wBXJ/4nGTmK+HMd9pXiksVcM
         5D8aP0hElMkAuf62mLicbXQPTa8neI+GsPEogTRWIsw7+Xh70fODcfXHyattnnyb1CZj
         XCUdfry2OdtVRKWH35ZF9UMKlhGy/ad8tss3sTsQ0sib1O1xZFAnlLHPMa90k8Uy9stR
         OhlJVHw+90GKiOIpDeMM3jPVNUu7gMWZL9pJmfGbRbsU+U8CTLIkkIUBJmTiArCEJj/W
         znWg==
X-Gm-Message-State: AO0yUKXdpzzVFr268fp48pjdQlmIkkEjJgYJ6NBPpxXMQTh4eXnkGar6
        wrLKEfoN/NTHmix8ANK6CH9H1mvlnQB1NtrjhI4nuUmsEpO0He2fvXjDYsY7rkz7RjeodUjCrun
        IQNaTM+9mTFoTtvpmmCP0Dr62
X-Received: by 2002:ac8:574e:0:b0:3d6:d1d3:eeb8 with SMTP id 14-20020ac8574e000000b003d6d1d3eeb8mr20398694qtx.11.1679918907443;
        Mon, 27 Mar 2023 05:08:27 -0700 (PDT)
X-Google-Smtp-Source: AKy350YyfOhpAFIIn4S3oaK+SRWKemSRvTcR5bSBOqlG0NAjA410/ztoUYY6RVRQVXHBhcaeImdxww==
X-Received: by 2002:ac8:574e:0:b0:3d6:d1d3:eeb8 with SMTP id 14-20020ac8574e000000b003d6d1d3eeb8mr20398655qtx.11.1679918907195;
        Mon, 27 Mar 2023 05:08:27 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id bn29-20020a05620a2add00b007486052d731sm1396515qkb.10.2023.03.27.05.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 05:08:26 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     jic23@kernel.org, lars@metafoo.de, nathan@kernel.org,
        ndesaulniers@google.com, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] iio: tsl2772: remove unused prox_diode_mask variable
Date:   Mon, 27 Mar 2023 08:08:23 -0400
Message-Id: <20230327120823.1369700-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/iio/light/tsl2772.c:576:24: error: variable
  'prox_diode_mask' set but not used [-Werror,-Wunused-but-set-variable]
        int i, ret, num_leds, prox_diode_mask;
                              ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iio/light/tsl2772.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index ad50baa0202c..c090405c2358 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -573,7 +573,7 @@ static int tsl2772_read_prox_led_current(struct tsl2772_chip *chip)
 static int tsl2772_read_prox_diodes(struct tsl2772_chip *chip)
 {
 	struct device *dev = &chip->client->dev;
-	int i, ret, num_leds, prox_diode_mask;
+	int i, ret, num_leds;
 	u32 leds[TSL2772_MAX_PROX_LEDS];
 
 	ret = device_property_count_u32(dev, "amstaos,proximity-diodes");
@@ -590,13 +590,8 @@ static int tsl2772_read_prox_diodes(struct tsl2772_chip *chip)
 		return ret;
 	}
 
-	prox_diode_mask = 0;
 	for (i = 0; i < num_leds; i++) {
-		if (leds[i] == 0)
-			prox_diode_mask |= TSL2772_DIODE0;
-		else if (leds[i] == 1)
-			prox_diode_mask |= TSL2772_DIODE1;
-		else {
+		if (leds[i] > 1) {
 			dev_err(dev, "Invalid value %d in amstaos,proximity-diodes.\n", leds[i]);
 			return -EINVAL;
 		}
-- 
2.27.0

