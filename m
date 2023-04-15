Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76C96E346B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 01:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjDOXMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 19:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjDOXMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 19:12:10 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A008A35B1;
        Sat, 15 Apr 2023 16:12:07 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4PzTbk1lsxz9sZW;
        Sun, 16 Apr 2023 01:12:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1681600322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TZOlclxLbG2/RAYSbmsgQ6MptuuAsr8C7mcJ+W6XUuE=;
        b=xCZAav4Zv47a/bdLN8Lwykx1oKrxT1xGyovb3GDJr500pVHqpTnGzTv7wLC0wRJSdhgy3P
        KuzaYimg9Q9QF0yAP/gw/P1+tZOomLRIGzWNtHk/tYtN6W7429xDndQWTBySiU9GN4Wg+v
        hvLkMI/XWCadhtrAU+na+49rFOn2tFEFiNSSkNsr7WTLxc5fwdFOoYmeBMFsTs4nPuOhGr
        +VftiJkzjG8mxAGemmns+CaQeb2XFNNrSZwQtVeXYB7gVoyC+Kn6eu5NCEeiNC0n4/Bc4t
        syTt1jmWmzWA779pwevXStR1Dkfq0v4RLMj9oAl+lnsttT9uALvu9y/v0rJnVA==
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
Subject: [PATCH v3 0/6] iio: st_sensors: Add lsm303d support
Date:   Sun, 16 Apr 2023 01:11:24 +0200
Message-Id: <20230415231130.115094-1-mail@mariushoch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4PzTbk1lsxz9sZW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch series adds support for the LSM303D accelerometer and
magnetometer. As the LSM303D is basically, as far as I can tell,
the LSM9DS0 without gyroscope, we can easily re-use its definitions.

This was tested on a Lenovo Yoga Tablet 2 1051-F.

Cheers,
Marius

Changes in v3:
Simplified the ACPI tables in the LSM9DS0 IMU driver, per Jonathan Cameron.

Marius Hoch (6):
  iio: accel: st_accel: Add LSM303D
  iio: magnetometer: st_accel: Add LSM303D
  iio: st_sensors: Add lsm303d support to the LSM9DS0 IMU driver
  iio: st_sensors: Add ACPI support for lsm303d to the LSM9DS0 IMU
    driver
  iio: Comment that the LSM303D also has the Magnetometer DRDY
  dt-bindings: iio: st-sensors: Add LSM303D accelerometer+magnetometer

 .../devicetree/bindings/iio/st,st-sensors.yaml       |  1 +
 drivers/iio/accel/st_accel_core.c                    |  1 +
 drivers/iio/imu/st_lsm9ds0/Kconfig                   |  3 ++-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c          | 12 ++++++++++++
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c          | 12 ++++++++++++
 drivers/iio/magnetometer/st_magn_core.c              |  1 +
 include/linux/iio/common/st_sensors.h                |  1 +
 include/linux/platform_data/st_sensors_pdata.h       |  2 +-
 8 files changed, 31 insertions(+), 2 deletions(-)


base-commit: e62252bc55b6d4eddc6c2bdbf95a448180d6a08d
-- 
2.39.2

