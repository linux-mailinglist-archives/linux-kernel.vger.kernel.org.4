Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C2D6E3470
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 01:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjDOXMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 19:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjDOXMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 19:12:10 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C375359B;
        Sat, 15 Apr 2023 16:12:07 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4PzTbm0LpZz9sQy;
        Sun, 16 Apr 2023 01:12:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1681600324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ezPGoQ6QPL9E3+YlJ6ixpTBZV0SadJ4wrscpZIJ3NMk=;
        b=CDAGgUhvg3l9geNDUw5GbBPdgY8QoBh914E/43fM3Vj9Pxm0aGZ+Bi1pjyg6Ej0JLcbIDM
        aza0H6MMs3m8Zv0/UiHGdxGFOeGChq0YGGm00/e5cG6oeIpCurHIml4hOhla83MxA5CEkr
        AZC/dmM2MDQLLGsIBRz1G+lJAjR3OiSvOiVHsALDq14d5h5XL9atWZCjVJ34t10CrVJ/Sr
        nMj+SnxsUJckiNOFF6RXOOyG/AAnu6n/vZYuc8SfraRnxRSWqlz2YjSYagU+/PpcC5tBtJ
        V/Bpvuxw1knJLfqIpj/IkI85OhUnISyTdKUD7G0uvkZ+UbQV7sg4CcpqZPUZwg==
From:   Marius Hoch <mail@mariushoch.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marius Hoch <mail@mariushoch.de>
Subject: [PATCH v3 1/6] iio: accel: st_accel: Add LSM303D
Date:   Sun, 16 Apr 2023 01:11:25 +0200
Message-Id: <20230415231130.115094-2-mail@mariushoch.de>
In-Reply-To: <20230415231130.115094-1-mail@mariushoch.de>
References: <20230415231130.115094-1-mail@mariushoch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4PzTbm0LpZz9sQy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

