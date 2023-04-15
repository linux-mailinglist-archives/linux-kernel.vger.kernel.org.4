Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AF36E3468
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 01:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjDOXMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 19:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjDOXMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 19:12:10 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507C3D8;
        Sat, 15 Apr 2023 16:12:09 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4PzTbn6F4Qz9t4h;
        Sun, 16 Apr 2023 01:12:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1681600325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aaBdxoh2tTQE/D7UbYD1GfSy8FZRjzStnfxmiQyyUCU=;
        b=NQW5ku21w7BMbgJTUa80Ynbqp9OYOavkA84NeF+zHMi4NI/V2JyL85JW1nqS9++ECVkNdQ
        iH6apcmiAHqXV10IpdotW1T7FOE3jHmVT0fOzkowmicWhd+3Y0yBN1x0HTMdWPzEVc5BdB
        svV0qGXn9/qg9Wm8BDEOcP+ktAeM3f7ty5rIn8p0WzN41YECFr4alK5NwBwKp7akTldDP3
        jNhiz2Kt1oQxOlNkz5VWJtPy6ulXTZvJy6xfqhsxeMBr7Ba0tgzsWNd5hB3ClvZAs078aO
        ITegTcZoyfkQPNj0yRguIBh/v68S/j4jc4XoCP4v5N9xT/vmewub4eutQM5Qtw==
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
Subject: [PATCH v3 2/6] iio: magnetometer: st_accel: Add LSM303D
Date:   Sun, 16 Apr 2023 01:11:26 +0200
Message-Id: <20230415231130.115094-3-mail@mariushoch.de>
In-Reply-To: <20230415231130.115094-1-mail@mariushoch.de>
References: <20230415231130.115094-1-mail@mariushoch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4PzTbn6F4Qz9t4h
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
 drivers/iio/magnetometer/st_magn_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 8faa7409d9e1..6cc0dfd31821 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -427,6 +427,7 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
 		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
 		.sensors_supported = {
 			[0] = LSM9DS0_IMU_DEV_NAME,
+			[1] = LSM303D_IMU_DEV_NAME,
 		},
 		.ch = (struct iio_chan_spec *)st_magn_4_16bit_channels,
 		.odr = {
-- 
2.39.2

