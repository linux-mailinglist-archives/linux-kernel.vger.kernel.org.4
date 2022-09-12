Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAB95B644C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 01:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiILXob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 19:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiILXo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 19:44:28 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBF81FCC8;
        Mon, 12 Sep 2022 16:44:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c11so18024277wrp.11;
        Mon, 12 Sep 2022 16:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=v8PIwy1hbcLR+ry7wUtqp5tyu2XN0J5uMtXiUjC7ge8=;
        b=IkCTjy+HZ1pwY9b0eL7AekHyToTZJ6S2rq5nUNGvuLssfUAoS2qkRzb1joKmGxHSgs
         hHi97FkqLT4q7wL1qaw9hbrt7XI3+WqJMb4r5MX9JUFCSQnybXDJRfABop1/J/SJhr3f
         AXCNJJ9M+SwGJBE857iX1JxfjgxVlxLsX/GUy1BNkyL42vlWfZtjKjtDMZAFGO4/i4P3
         Io4XtLUrx1/7sOKLHOWU95hzhxL2IKQKTMmYvR2l15Mk+rFdxOtixWBbPcQfug+zrCjl
         UUjM7IJ17QPpDYiSXyqDvoYX3IFd9VHl4Dfj04SzPnHEJPCSS878zKwK0KplzxY02CB4
         XejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=v8PIwy1hbcLR+ry7wUtqp5tyu2XN0J5uMtXiUjC7ge8=;
        b=wIdZM4SnSpxtcI3B4CrkHJ+klXx9LJ2n0Gx8ARsyvnhQlLALzyKa/EJFdBPc8gez6m
         mhqxUggjZCxDNCY7SuToho7Hz+4H2e3EPFOXzJWeRdvoq8zfnHp41RTrAm0AT1TzDupp
         4TI41DiPLxV1BgvQ568DGLr8L5FEIcEPiXhJJekuQXqYcVrfvdgRpCRVSdbJ1/Djjc+K
         cf57GNd7bmQt+zxSkuci6quMpJiwZCDdCUwJJRnwRoAvjS5ixJghdphPjf9vdAIKFKvA
         UWHtMDZIiBOqy/5/bLPeP8k0IkObPelthRmWzUwIBbobzmac7NdFmejox7v99Byt1kRK
         R8kA==
X-Gm-Message-State: ACgBeo03tIaCfKlYkFdzbOH3+ZQ+iDAs0jzrD2D3VH58nIMjj9gdP4b2
        Q5Rxfl9XDEp/vME5cvUgdJJp+kh5Z8U=
X-Google-Smtp-Source: AA6agR6WtDi0693iv0cBu/peZL7Be0Ht5fQv8RxHdrMddO63sl+SGhwR/bltjXou1KX+dEsuOLjKew==
X-Received: by 2002:adf:df8f:0:b0:228:df40:bb57 with SMTP id z15-20020adfdf8f000000b00228df40bb57mr16714900wrl.692.1663026264185;
        Mon, 12 Sep 2022 16:44:24 -0700 (PDT)
Received: from localhost.localdomain (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c3b9600b003b435c41103sm14082752wms.0.2022.09.12.16.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 16:44:23 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio <linux-iio@vger.kernel.org>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/9] Add support for pressure sensor Bosch BMP380
Date:   Tue, 13 Sep 2022 01:43:46 +0200
Message-Id: <cover.1663025017.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds BMP380 variant to the already existing drivers for
the Bosch BMP180/280 pressure sensors.

Patch 1 reorder local variables declarations following reverse xmas tree
conventions, as suggested by Andy Shevchenko <andy.shevchenko@gmail.com>.
Patch 2 migrates existing code to use FIELD_GET/FIELD_PREP and GENMASK
utilities.
Patch 3 is a minor refactor of the function that loads bmp280 calibration
params, taking advantage of the data contiguity in memory.
Patch 4 is a minor refactor simplifying driver initialization logic
to facilitate the integration of the new sensor variant extending the
information stored in the "chip_info" struct.
Patch 5 fixes DMA unsafe regmap_bulk_* calls reported by Jonathan Cameron
<jic23@kernel.org>.
Patch 6 is a minor refactor reordering device match tables declarations in
forward order as suggested by Andy Shevchenko <andy.shevchenko@gmail.com>.
Patch 7 adds the basic logic to initialize and read measurements from
the sensor.
Patch 8 adds references and sensor id to the devicetree bindings docs.
Patch 9 adds advanced configurable features such as sampling frequency
and IIR filter through the IIO sysfs ABI.

Changes in v6:
 - Introduced patch 1 reordering local variables declarations.
 - Patch 2 is separated form v5 patch 1, separating initialization
   refactor from migration to FIELD_GET, FIELD_PREP and GENMASK.
 - Patch 3 backports a refactor made to bmp280 calibration load
   on v5 patch 2.
 - Introduced patch 6 reordering i2c device match tables declarations.
 - Revised patch 7 and 9 and smoothed transition to patch 9 moving some
   code on v5 patch 5 to patch 7 (BMP380 basic enablement).
 - Cleaned error handling of regmap calls thorough patches.
 - Changed formula used to handle IIR filter on patch 9 following feedback
   made by Andy Shevchenko <andy.shevchenko@gmail.com>.
 - Made union with data buffers on patch 5 anonymous (suggested by Andy
   Shevchenko <andy.shevchenko@gmail.com>)
 - Improved handling of be16 and le16 data on patch 5 integrating changes
   suggested by Jonathan Cameron <jic23@kernel.org>.

Changes in v5:
 - Moved dt bindings patch (previously patch 2/5) to 4/5 to preserve
   tree coherence as suggested by Jonathan Cameron <jic23@kernel.org>
 - Patch 1: Simplified initial oversampling values assignation.
 - Patch 1: Updated codepaths for bmp180 and bmp280 to use FIELD_GET and
   FIELD_GET helpers. Migrated compatible masks to use GENMASK.
 - Patch 2: Store DMA-safe buffers on the device data struct instead of
   using dynamic allocations for calibration buffers.
   Thanks Jonathan Cameron <jic23@kernel.org>.
 - Patch 3: Fixed small typos
 - Patch 3: Fixed incompatible division on 32-bit machines reported by
   Andy Shevchenko <andy.shevchenko@gmail.com> and kernel test robot
   <lkp@intel.com>.
 - Patch 3: Fixed inconsistent use of "x" and "X" declaring constants.
 - Patch 5: Dropped incorrect reported-by tag on changelog message.
 - Patch 5: Fixed typos on various comments.

Changes in v4:
 - Patch 4 and 2: Merged v3 patch 2 (Kconfig refs update) into this patch.
 - Patch 3: Added patch fixing unsafe DMA regmap_bulk_* calls reported by
   Jonathan Cameron <jic23@kernel.org>.
 - Patch 4: Fixed DMA unsafe buffers used on regmap_bulk_* calls reported
   by Jonathan Cameron <jic23@kernel.org>.

Changes in v3:
 - Patch 2: Fixed incorrect abbreviation.
 - Patch 3: use dev_err_probe helper to handle error initializing sensor.
 - Patch 4: Fixed kernel test robot warning provoked by missing include.
 - Patch 4: Fixed bug reported by Dan Carpenter <dan.carpenter@oracle.com>.
 - Patch 5: Fixed formatting and typos on multiple comments.
 - Patch 5: Fixed missing boolean initialization reported by
   Andy Shevchenko <andy.shevchenko@gmail.com>.
 - Patch 5: Replaced duplicated comments with a single comment containing
   a brief explantation in a shared location.
 - Patch 5: Dropped incorrect use of unlikely macro.

Changes in v2:
 - Added patch 2 updating Kconfig with references to new sensor.
 - Patch 3 adds changes proposed by Jonathan Cameron <jic23@kernel.org>
   to declutter and unify configuration logic for the different sensors
   extending "chip_info" struct with default configuration parameters.
 - Patch 4: store temperature and pressure adc values on 3 byte array
   instead of using the type __le32. Uses function get_unaligned_le24
   to convert the little-endian encoded 3 byte value to an integer.
 - Patch 4: drops custom macro le16_from_bytes and use get_unaligned_le16.
 - Patch 4: generate masks using GENMASK macro.
 - Patch 4: use FIELD_PREP to generate bitfields for registries.
 - Patch 4: dropped stray formatting change.
 - Patch 5: adds sanity checks in bmp280_read_raw for channel properties
   only available in the BMP380.
 - Patch 5: on bmp280_write_* checks if a problem occurred committing new
   configuration and tries to restore previous working configuration
   to keep the sensor in a previous working state.
 - Patch 5: refactored bmp380_chip_config to only check for configuration
   errors when a configuration change is detected.
 - Patch 5: improved invalid configuration detection on BMP380 restarting
   measurement loop to force a new measurement after the configuration is
   updated.

Previous patch version available on:
 https://lore.kernel.org/all/cover.1659872590.git.ang.iglesiasg@gmail.com/

Angel Iglesias (9):
  iio: pressure: bmp280: reorder local variables following reverse xmas
    tree
  iio: pressure: bmp280: use FIELD_GET, FIELD_PREP and GENMASK
  iio: pressure: bmp280: Simplify bmp280 calibration data reading
  iio: pressure: bmp280: simplify driver initialization logic
  iio: pressure: bmp280: Fix alignment for DMA safety
  iio: pressure: bmp280: reorder i2c device tables declarations
  iio: pressure: bmp280: Add support for BMP380 sensor family
  dt-bindings: iio: pressure: bmp085: Add BMP380 compatible string
  iio: pressure: bmp280: Add more tunable config parameters for BMP380

 .../bindings/iio/pressure/bmp085.yaml         |   4 +-
 drivers/iio/pressure/Kconfig                  |   6 +-
 drivers/iio/pressure/bmp280-core.c            | 962 +++++++++++++++---
 drivers/iio/pressure/bmp280-i2c.c             |  15 +-
 drivers/iio/pressure/bmp280-regmap.c          |  55 +
 drivers/iio/pressure/bmp280-spi.c             |   5 +
 drivers/iio/pressure/bmp280.h                 | 164 ++-
 7 files changed, 1018 insertions(+), 193 deletions(-)


base-commit: 2f61ff8272967c9bdcba810aa978170814b08f7c
-- 
2.37.3

