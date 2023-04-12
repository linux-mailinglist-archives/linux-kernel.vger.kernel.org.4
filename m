Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF546E01EA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 00:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjDLWhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 18:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDLWhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 18:37:02 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDC340D3;
        Wed, 12 Apr 2023 15:37:00 -0700 (PDT)
Received: from smtp202.mailbox.org (unknown [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Pxcyf1p09z9spl;
        Thu, 13 Apr 2023 00:36:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1681339018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8mgjeVjD9sRPII4svu+aADfY4kCFBWLziUbj6NK6oOs=;
        b=P8Fo76BPo3QvCyGmspEq0DUx91nBvLxrWka/EeqyrkXu41DCG/kyPBvxvQjr1seYO68dMR
        hs6HbLRspT5uezHHMtioCgiBpTrwz4vBjupDeUfQxatGlbi3UwPZK6IaUxkalREatcj0fn
        MFpzJ9JAkG+qBUcm/7DZ6VKhBeOq+O20W3z8sUjMvCdJsTGD+nK5O5lrb/bdWARZXQYdHg
        Jv5INJTrzwx5HSpjp59fvWcxGPl3WNbr+nNFCL+Dj6qYh5gkX5IvtXZeEGM5MFqwpJzQyQ
        XHji0q0sPGGD7xlDVyzFoJCPCmmjw6GmZzxx8GHRU9iPO1SZGtWyJI5IrwVj5Q==
From:   mail@mariushoch.de
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marius Hoch <mail@mariushoch.de>
Subject: [PATCH] iio: st_sensors: Add lsm303d support
Date:   Thu, 13 Apr 2023 00:36:21 +0200
Message-Id: <20230412223627.442963-1-mail@mariushoch.de>
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

Hi!

This patch series adds support for the LSM303D accelerometer and
magnetometer. As the LSM303D is basically, as far as I can tell,
the LSM9DS0 without gyroscope, we can easily re-use its definitions.

This was tested on a Lenovo Yoga Tablet 2 1051-F.

Cheers,
Marius

Marius Hoch (6):
  iio: accel: st_accel: Add LSM303D
  iio: magnetometer: st_accel: Add LSM303D
  iio: st_sensors: Add lsm303d support to the LSM9DS0 IMU driver
  iio: st_sensors: Add ACPI support for lsm303d to the LSM9DS0 IMU
    driver
  iio: Comment that the LSM303D also has the Magnetometer DRDY
  dt-bindings: iio: st-sensors: Add LSM303D accelerometer+magnetometer

 .../devicetree/bindings/iio/st,st-sensors.yaml    |  1 +
 drivers/iio/accel/st_accel_core.c                 |  1 +
 drivers/iio/imu/st_lsm9ds0/Kconfig                |  3 ++-
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c       | 15 +++++++++++++++
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c       | 15 +++++++++++++++
 drivers/iio/magnetometer/st_magn_core.c           |  1 +
 include/linux/iio/common/st_sensors.h             |  1 +
 include/linux/platform_data/st_sensors_pdata.h    |  2 +-
 8 files changed, 37 insertions(+), 2 deletions(-)

-- 
2.39.2

