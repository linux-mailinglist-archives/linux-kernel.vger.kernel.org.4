Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2E965635F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 15:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiLZOaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 09:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiLZOaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:30:09 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D81F5;
        Mon, 26 Dec 2022 06:30:02 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o15so7615526wmr.4;
        Mon, 26 Dec 2022 06:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VFIJomb/mQCAttQ+nb+AVnywnrRMyslLFJlDXuhv2cg=;
        b=fGaA4uzxMk4aEwNMfCKwOq0qn3mEmABOnHLQSR2DVjHBqdH8/7aGzDyOxkI5D9o5lN
         EWMtezM66uEgh5gCIQMZE6MsZrhukgUaM84SAY9efB1nLFFcwpTKMYytRQJOSlv2U5/n
         Vt939tP2UG8qHhefdHWjPfY2+KNHYSK4KQZ4pPezoBLW/A33rwNTXiLm8PL7hr2IWX8x
         gJ6Rmys6QcDv4EELHXrwKX8MW0WzGs6kV3ofCMyVs+HC3MX9ZZi3S0Dn/T8Me3j9l3AQ
         WpnwndwuPViq2l4Z4LZ94Ph/s2Q2ZD+/PSZRfzFtfU/W5pI8UNhOPtuY7bjOd/wFiTmr
         fF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFIJomb/mQCAttQ+nb+AVnywnrRMyslLFJlDXuhv2cg=;
        b=HOWYkCuaKYCF5XW4uxDg1oezNJl7GY2Twk1Fw86Vg5h9izEMH8IDyMd3AP/A6j8wzE
         jaBcNhJyFW7Ad3qH4+qXHxa6TYuCQbrxvaNob7wK9I02IdwNUSyb3QoVs0naXR8ViyQI
         J6Xnr6zMVNsNh4ENDST1pX9tEHjWJMLgx0KOdfQ59TpMEbifMVnEwr16n4lZmgj3/AmR
         V5v+UYHevzSgOithQ6OB4MHi/GjkqB3cMXf5QzRnkPlX/ViRrA3IzdQ4+PIsZLGkSvVn
         JOMuF9vYStEFkZDOILIJ+joaVWTb9V4ztDDhYHjhwzNBFsJO1o3gqfIVPY2bXuAPyYAK
         x8TA==
X-Gm-Message-State: AFqh2koGdzpf1ISwDa5SoeFGvnckwbI21AY/YURyjj76zyq07uoa8Xkd
        N68H7quGlWR2uIt1UEXQsO5OdNXQmG8=
X-Google-Smtp-Source: AMrXdXvK9iky3bReAaSSKV7dGYZpClFij6a/zVWGHSqaR5BZbrKVO0blUb/6gMSUUW8H2MjBsZzcNA==
X-Received: by 2002:a05:600c:4e09:b0:3d4:5741:af9b with SMTP id b9-20020a05600c4e0900b003d45741af9bmr15961265wmq.0.1672065001066;
        Mon, 26 Dec 2022 06:30:01 -0800 (PST)
Received: from localhost.localdomain (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0a4400b003cf75213bb9sm21511754wmq.8.2022.12.26.06.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 06:30:00 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Add support for pressure sensor Bosch BMP580
Date:   Mon, 26 Dec 2022 15:29:19 +0100
Message-Id: <cover.1672062380.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.39.0
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

Patch 1 introduces a variant enumeration and refactors sensor verification
logic adding a chip_id field to the chip_info struct. This change is
required because BMP380 and BMP580 have the same chip_id and values would
collide using the chip_id as the driver_data value.
Patch 2 introduces new preinit callback and unifies init logic across all
supported variants.
Patch 3 extends the bmp280 driver with the new logic to read measurements
and configure the operation parameters for the BMP580 sensors.
Patch 4 updates the devicetree binding docs with the new sensor id.
Patch 5 adds the NVMEM operations to read and program the NVM user range
contained in the non-volatile memory of the BMP580 sensors.

Changes in V2:
* For patch 3, fixed missing retcodes reported by the kernel test robot.
* For patch 5, fixed logic paths that left the sensor mutex locked
  reported by the kernel test robot.

Angel Iglesias (5):
  iio: pressure: bmp280: Add enumeration to handle chip variants
  iio: pressure: bmp280: Add preinit callback
  iio: pressure: bmp280: Add support for new sensor BMP580
  dt-bindings: iio: pressure: bmp085: Add BMP580 compatible string
  iio: pressure: bmp280: Add nvmem operations for BMP580

 .../bindings/iio/pressure/bmp085.yaml         |   2 +
 drivers/iio/pressure/Kconfig                  |   6 +-
 drivers/iio/pressure/bmp280-core.c            | 617 +++++++++++++++++-
 drivers/iio/pressure/bmp280-i2c.c             |  33 +-
 drivers/iio/pressure/bmp280-regmap.c          |  60 ++
 drivers/iio/pressure/bmp280-spi.c             |  23 +-
 drivers/iio/pressure/bmp280.h                 | 115 ++++
 7 files changed, 815 insertions(+), 41 deletions(-)


base-commit: e807541c2b273677e82ef50b5747ec7ae7d652b9
-- 
2.39.0

