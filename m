Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFD36E01E6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 00:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjDLWhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 18:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLWhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 18:37:02 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E73769F;
        Wed, 12 Apr 2023 15:37:00 -0700 (PDT)
Received: from smtp202.mailbox.org (unknown [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Pxcyf75MHz9sjS;
        Thu, 13 Apr 2023 00:36:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1681339019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+34EnDhAJCatx3SNd1/tC/5zzh0I4K1A1JF9qlALTBc=;
        b=f7ZqlbC8afJS+Ogc/CUkJ0KzPowmajk/qOvrzw1xJzLtAgh9W5vLHCsUcVOlHnPYedPSic
        8crGZdkPv2xeY7AvlYOuHVt5f3e9zussIbwSG9z6gZ+4A3kNr++CMSSCT5mPnXReSdKaf4
        YLvxQdjzT9YJOCYDL6oSBizWvpZe9Q4ujDsjW5CHHIp9fB037k8hnW66jPxLXMGS8cjRQ9
        sexXAssbhvxyt5OnYlNt7asUMabVgbMh+KSTH7f6oHi2WoANvMZfW7CNd4QNPd/0d8SgCO
        dSP+OStH5GYNDRQNomxpfYklPugvN+ORWao9sscKay/1+WeW6ql/c5VYgTf5EA==
From:   mail@mariushoch.de
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marius Hoch <mail@mariushoch.de>
Subject: [PATCH] iio: accel: st_accel: Add LSM303D
Date:   Thu, 13 Apr 2023 00:36:22 +0200
Message-Id: <20230412223627.442963-2-mail@mariushoch.de>
In-Reply-To: <20230412223627.442963-1-mail@mariushoch.de>
References: <20230412223627.442963-1-mail@mariushoch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marius Hoch <mail@mariushoch.de>

The lsm303d has the same register mapping as the lsm9ds0,
thus we can just re-use that.

Tested on a Lenovo Yoga Tablet 2 1051-F.

Signed-off-by: Marius Hoch <mail@mariushoch.de>
---
 drivers/iio/accel/st_accel_core.c     | 1 +
 include/linux/iio/common/st_sensors.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 6b8562f684d5..1628b177d0ed 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -1006,6 +1006,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
 			[0] = LSM9DS0_IMU_DEV_NAME,
+			[1] = LSM303D_IMU_DEV_NAME,
 		},
 		.ch = (struct iio_chan_spec *)st_accel_16bit_channels,
 		.odr = {
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index f5f3ee57bc70..607c3a89a647 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -22,6 +22,7 @@
 #include <linux/platform_data/st_sensors_pdata.h>
 
 #define LSM9DS0_IMU_DEV_NAME		"lsm9ds0"
+#define LSM303D_IMU_DEV_NAME		"lsm303d"
 
 /*
  * Buffer size max case: 2bytes per channel, 3 channels in total +
-- 
2.39.2

