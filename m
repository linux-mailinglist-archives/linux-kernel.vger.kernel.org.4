Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BC16E04E4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 04:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjDMCxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 22:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjDMCxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 22:53:47 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2F52D68;
        Wed, 12 Apr 2023 19:53:34 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4PxkN03xR9z9sps;
        Thu, 13 Apr 2023 04:40:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1681353648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Nzv5St2LkPkiUBI6mDf96N5hsFtzefwwnleNs4L5yxQ=;
        b=OhtXS1XDbEN5LZ4wYMksGpJgmdzoXmXscrfyibQFLTV/SY+dN0NopHlBaCroT1f5eEhQd8
        VCfN1MNVQ3oo1Ox5Qfu5DO5QGGd3L2gKepsYPH29LJGP7nl06X7fQQ96zqN5QyF/mXUZOb
        m9GPOs/w23FR404liYbsPGuPjX5ILYCDF6mxt9Wz1L9elsnbIVrMbDh0c4K+bDIDqUOxAu
        aQ+2SNc+WmEPN+YXmr7zvEN9/ApvD0IDSEPZh1/yXJOci9NnvndV5ZLmqZYIKZkDU5pGcB
        lJCzBzjAR/59NI/et5/77sipu9WtWDNrWifuL6mr9sgDKlpWjdD85/bjSuNssQ==
From:   Marius Hoch <mail@mariushoch.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marius Hoch <mail@mariushoch.de>
Subject: [PATCH v2 0/6] iio: st_sensors: Add lsm303d support
Date:   Thu, 13 Apr 2023 04:40:07 +0200
Message-Id: <20230413024013.450165-1-mail@mariushoch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4PxkN03xR9z9sps
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


base-commit: e62252bc55b6d4eddc6c2bdbf95a448180d6a08d
-- 
2.39.2

