Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186B5600432
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 01:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiJPXmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 19:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiJPXmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 19:42:17 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253D7240AF;
        Sun, 16 Oct 2022 16:42:16 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bk15so15955356wrb.13;
        Sun, 16 Oct 2022 16:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J+qenmk2ncj9OuHjXiCfFzTBlYVWb4ozOhCEQYEEC+o=;
        b=qCBQCDmjowGXjdzcwc7MTRpoyreYujyHsCOwlV5bZwirQpa1FX8X533bZ9clToq/7D
         RPJmYxwLyMu1PctpCPsnGOMYbVp1YqESvUSy8NHueyac84w5tGdRkZm5ewyHuAWMXzFL
         6vapTw3LPWZ7l39nxHbDu2YCrfQtSigziOMTnRft91/LO28tmcuf09R73qWJfEoNjBk0
         vdZ8XsISeEoNc+FObsciXDyZH0Gih63ZD/vRX0N7ZeDfGdFXjUMZY2f6aZhLXexBc9e5
         Ct+XLmK577VAlxfkn8ogxnfA3YP863T4+sdpejFFJglRkCecInjIJvE+75UoBGQ3x4TI
         rdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+qenmk2ncj9OuHjXiCfFzTBlYVWb4ozOhCEQYEEC+o=;
        b=0Av8ZeXBPa3zcQ8pWW4Gzb5P4C6I6T39M/zPA5BtVhSBx8Hl5L1gntgFPFDkqHf2Hr
         xLKeYBWz6VHEtHA8qaolWooSt678O8wgEihFePoIhLWwlKk65+pLw5on8ejtfbD7do/b
         CLKEsZ/pOzTbvieDQaFi9CzfZ+OFAiz9ucZOtX5ri27vAvCMmszjqMFHeKfXlbW6mSQT
         YCuqoCl2RZfE9NfCiwTrZPcAIqnd9dn3/bJUkMLa1qAwhIR0SsS55XTVrDTN3kYVCOWV
         TpVVZCMT25BoP9G3IZYVI9jt5hLDRLTN5nmnyhyMQTXgqHZ61grOShpj+/WW7vTl5Hpd
         m7cw==
X-Gm-Message-State: ACrzQf3PbzEjsgk97Vh3Pkse+R70DqowSOO/vNIMpbCIti+R+HW6jxTW
        y9QTM9XtBNii8zg/mMVJFXtyQRbHq+w=
X-Google-Smtp-Source: AMsMyM5eoiIG3+0zrj72VoU1Ad77pxK/4LOYd6o7toOr7Yn4Sfng9ukbXtZAB1aWrCQwPKrhqMkozA==
X-Received: by 2002:adf:e549:0:b0:22d:b410:d0ed with SMTP id z9-20020adfe549000000b0022db410d0edmr4820365wrm.633.1665963734579;
        Sun, 16 Oct 2022 16:42:14 -0700 (PDT)
Received: from localhost (188.31.4.189.threembb.co.uk. [188.31.4.189])
        by smtp.gmail.com with ESMTPSA id m18-20020a056000009200b0022e0580b7a9sm7052381wrx.17.2022.10.16.16.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 16:42:14 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, michael@walle.cc,
        samuel@sholland.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/13] Add support for AXP192 PMIC
Date:   Mon, 17 Oct 2022 00:43:22 +0100
Message-Id: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the AXP192 PMIC to the AXP20x MFD driver
framework, including support for regulators, ADCs, and AC/USB/battery
power supplies.

v6 is a resend of v5 from July -- the patches haven't changed at all
but I've rebased them on the latest git master branch.

Aidan MacDonald (13):
  dt-bindings: mfd: add bindings for AXP192 MFD device
  dt-bindings: iio: adc: axp209: Add AXP192 compatible
  dt-bindings: power: supply: axp20x: Add AXP192 compatible
  dt-bindings: power: axp20x-battery: Add AXP192 compatible
  mfd: axp20x: Add support for AXP192
  regulator: axp20x: Add support for AXP192
  iio: adc: axp20x_adc: Minor code cleanups
  iio: adc: axp20x_adc: Replace adc_en2 flag with adc_en2_mask field
  iio: adc: axp20x_adc: Add support for AXP192
  power: supply: axp20x_usb_power: Add support for AXP192
  power: axp20x_battery: Add constant charge current table
  power: axp20x_battery: Support battery status without fuel gauge
  power: axp20x_battery: Add support for AXP192

 .../bindings/iio/adc/x-powers,axp209-adc.yaml |  18 +
 .../bindings/mfd/x-powers,axp152.yaml         |   1 +
 .../x-powers,axp20x-battery-power-supply.yaml |   1 +
 .../x-powers,axp20x-usb-power-supply.yaml     |   1 +
 drivers/iio/adc/axp20x_adc.c                  | 356 ++++++++++++++++--
 drivers/mfd/axp20x-i2c.c                      |   2 +
 drivers/mfd/axp20x.c                          | 141 +++++++
 drivers/power/supply/axp20x_battery.c         | 142 ++++++-
 drivers/power/supply/axp20x_usb_power.c       |  84 ++++-
 drivers/regulator/axp20x-regulator.c          | 100 ++++-
 include/linux/mfd/axp20x.h                    |  84 +++++
 11 files changed, 856 insertions(+), 74 deletions(-)

-- 
2.38.0

