Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F1169C173
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 18:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjBSRAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 12:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjBSRAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 12:00:14 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C9F113C7;
        Sun, 19 Feb 2023 09:00:13 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id g7so574861wrd.3;
        Sun, 19 Feb 2023 09:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qgZZTiL8OE5qA01DYT9WBSfQOurPUqR3I7v32yZEImQ=;
        b=ibGnr6Y3K8ev6t0zRn1AGQr23wKZ/vXEc73eeyf0TUo8CNb/3FnZeLVTNk5gj4Q/B2
         kqipjH+IFIDXsq/NzFytIyI6puSR2X+nvR7KncsayC5tOWO0/XkOuPidRiwplXe8zA87
         UEdefl/WxWrG03k6gYZutLItlKE6sWbpMQpu//Wqym2Gvr+uggoPaVhfmAnsuAnfd9BO
         /KwUL3nlSHwn/jazogpiUEdUZsJxfM0UnM2u4kvexuDkmk+obAXQSEZJj7pGixFsv/ej
         DDokcrDx38CmZKvOc0EKOpJDTZy0Xx76nXuVmLahrt+CI2vJIX+1Hd009PaXKjekdXU/
         HsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qgZZTiL8OE5qA01DYT9WBSfQOurPUqR3I7v32yZEImQ=;
        b=hQ1l2rAP5Lvjb3BWaPlIo2VFY9R9PkKPJwZ/XYRq9ZVZNds2bZvj0e9dJtxOwKk4Nc
         W/uRzBhFW3kjmW+ZlAn2SFRv0w3ioRhjTW8xmnhJ/Q8iYGoCvRU4/8fapc8jOoba63o7
         R9icLDelRuinVlC+SXtcBzcqYMLO51Hxds3j9uql2VM7VVFXPu3+eJCR45uungMsMwcR
         gnrpzU+GTcMfTUzP5ohRSKk734Z5t3/vaSUdDzkkxkVC48B0hguxtHiEGWc/QWxU9E53
         FxObfdweo+avehqvJ4j0xuEMPnMZP7LXivOVnuCuxUsLB843aDSy8WfMymyxoftRKMx6
         D6cw==
X-Gm-Message-State: AO0yUKUkm6nfQpvGhWrozL6t9PWkKC7MyhJ0suVi5ItZ865DFWkoBRL/
        /ABhXr9JnwrYZ9ld+nB+X1Pn/Tc2mlY=
X-Google-Smtp-Source: AK7set85GYX7QZ3z8wiFcVP+I/oyZO176oogg7KLPzCorzwg1PahNL92MdFa0CMi4WdkhXkQVZNOpQ==
X-Received: by 2002:a5d:4c50:0:b0:2c5:4cd0:4b86 with SMTP id n16-20020a5d4c50000000b002c54cd04b86mr1604127wrt.68.1676826011443;
        Sun, 19 Feb 2023 09:00:11 -0800 (PST)
Received: from localhost.localdomain (6.red-83-37-22.dynamicip.rima-tde.net. [83.37.22.6])
        by smtp.gmail.com with ESMTPSA id v20-20020a5d5914000000b002c552c6c8c2sm366427wrd.87.2023.02.19.09.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 09:00:11 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandru Lazar <alazar@startmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/7] Add support for pressure sensor Bosch BMP580
Date:   Sun, 19 Feb 2023 17:57:58 +0100
Message-Id: <cover.1676823250.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the new pressure sensors BMP580 extending
the bmp280 driver.

Patch 1 introduces a minor refactor of the driver structure to change how
the device matching and driver initialization is performed. In place of
the chips ids, the driver_data now contains a pointer to its chip_info.
To perform this change, a series of declarations previously on the core
file were migrated to the shared header file, to allow access to specific
fields on the chip_info on the I2C and SPI drivers. This change is
required because BMP380 and BMP580 have the same chip_id and values would
collide using the chip_id as the driver_data value.
Patch 2 introduces new preinit callback and unifies init logic across all
supported variants.
Patch 3 made calibration callback function optional.
Patch 4 deletes misleading i2c reference on bmp280 Kconfig entry.
Patch 5 extends the bmp280 driver with the new logic to read measurements
and configure the operation parameters for the BMP580 sensors.
Patch 6 updates the devicetree binding docs with the new sensor id.
Patch 7 adds the NVMEM operations to read and program the NVM user range
contained in the non-volatile memory of the BMP580 sensors.

Changes in v4:
* Dropped redundant and excessive verbose comments.
* Change BMP580 temp IIO return type to IIO_VAL_FRACTIONAL_LOG2
* Dropped loop waiting for NVM operation completion and use
  regmap_read_poll_timeout instead.
* Fix various sizeof calls on NVMEM handling codepath.

Changes in v3:
* Refactor driver structure to use chip_info structs as driver_data and
  updated i2c and spi implementations device match codepaths.
* Deleted Kconfig driver title misleading i2c reference.
* Made calibration reading optional as a prerequisite patch in preparation
  for the bmp580 built in compensation.
* Break command helper function in soft-reset helper function and NVM
  operation helper.
* Fixed minor styling issues thorough patches.

Changes in v2:
* For patch 3, fixed missing retcodes reported by the kernel test robot.
* For patch 5, fixed logic paths that left the sensor mutex locked
  reported by the kernel test robot.

Angel Iglesias (7):
  iio: pressure: bmp280: Use chip_info pointers for each chip as driver
    data
  iio: pressure: bmp280: Add preinit callback
  iio: pressure: bmp280: Make read calibration callback optional
  iio: pressure: Kconfig: Delete misleading I2C reference on bmp280
    title
  iio: pressure: bmp280: Add support for new sensor BMP580
  dt-bindings: iio: pressure: bmp085: Add BMP580 compatible string
  iio: pressure: bmp280: Add nvmem operations for BMP580

 .../bindings/iio/pressure/bmp085.yaml         |   2 +
 drivers/iio/pressure/Kconfig                  |   6 +-
 drivers/iio/pressure/bmp280-core.c            | 765 +++++++++++++-----
 drivers/iio/pressure/bmp280-i2c.c             |  45 +-
 drivers/iio/pressure/bmp280-regmap.c          |  60 ++
 drivers/iio/pressure/bmp280-spi.c             |  47 +-
 drivers/iio/pressure/bmp280.h                 | 273 ++++++-
 7 files changed, 953 insertions(+), 245 deletions(-)


base-commit: 91ba2700aa75859957613aedf307a04a83010cee
-- 
2.39.2

