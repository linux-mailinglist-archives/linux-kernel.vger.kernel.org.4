Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FBD71283C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 16:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243849AbjEZObC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 10:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237425AbjEZObA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 10:31:00 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF05A187;
        Fri, 26 May 2023 07:30:59 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-96fbe7fbdd4so141524766b.3;
        Fri, 26 May 2023 07:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685111458; x=1687703458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fFHHdaXDW2P2XXbm6YKoOMdrCYP6Pv8lFV6aN1Yl2G8=;
        b=AgQOYwvReGu3+EI+OQ2VgzXzt8b75OzUQlYDAnUSeNYoNDRQWec8l/q9m0almb+XhX
         1NKrKcqlUTOe1E8Z7BHo/DJY253HwLKC14BbituqRGUYYRATjeOI/vVsIz9+fLUyl+bI
         JZ65K22rNiLHO9q4KkWggCVwH09wSeQNTIWVe2WxXiN6vDM3H2dDLK8n3UB6IookN5Uj
         Wu3hZ2GbznRk6+tk+0PG7l7roXOHMYkIIFhFqUcKgoMrCWihWHAnvmQ7m3Epmaz5QqjP
         JnYqzOt7z+0ayw1+CTRkwPdDp85FvG4TuazwzpMOn8PXOZK12Z9xat5CgVLLPMKIon5a
         UYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685111458; x=1687703458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFHHdaXDW2P2XXbm6YKoOMdrCYP6Pv8lFV6aN1Yl2G8=;
        b=HXCxHWq2pdvXONc9DyFtDsq7wSxu8r7TKUt2QoLyqWXJav3s8SdNCm1abI9OsMF4wW
         d3A+NFo4KC9JzJDr3+Gzq/slM4y707QqpaT8b78w8r+DpoPUEg7w2SznWLWOgBhMs0yF
         fSfGV9ZZ18JLtn4+2A/ojSD0GWf9piovzjVRO/sC0P7EB5dqu7AEPpH50foi60XMhick
         tn4cyINaGqzVI74SZzGZMHHwhJJ8Vq0hh9W7c/Q9cR8BeN4oNdluFlCzSuJguKzoNzvR
         vgerpaZIq6ZO8xBqsr0jwpTA1g4ACd+KYqzN60zlMEiFnF2G3rVqnKsJ1GlsEQILa2Nf
         hxyQ==
X-Gm-Message-State: AC+VfDw4C9k8h8wGF0rHJMj9dk8Z7EvooeVz0v+Lfc3k2H1qSIm44p17
        cwdzrD7zKGlGffDY0sHp0LQ=
X-Google-Smtp-Source: ACHHUZ6+ai32bLVuCr8UK+8rM2zGClUneW9eATSaPqRwFqg5CSCV1N5wCi+5APrc6O4x8T10BbZJDg==
X-Received: by 2002:a17:906:6a0f:b0:96f:d67b:8095 with SMTP id qw15-20020a1709066a0f00b0096fd67b8095mr2419998ejc.1.1685111457800;
        Fri, 26 May 2023 07:30:57 -0700 (PDT)
Received: from carbian.corp.quobyte.com ([2a02:8109:aa3f:ead8::d8a0])
        by smtp.gmail.com with ESMTPSA id r20-20020a170906365400b0094e7d196aa4sm2157023ejb.160.2023.05.26.07.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 07:30:57 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v4 0/7] iio: accel: Add support for Kionix/ROHM KX132-1211 accelerometer
Date:   Fri, 26 May 2023 16:30:41 +0200
Message-Id: <cover.1685109507.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hello everyone,

Version 4 for adding support for the kx132-1211 accelerometer

KX132-1211 accelerometer is a sensor which:
	- supports G-ranges of (+/-) 2, 4, 8, and 16G
	- can be connected to I2C or SPI
	- has internal HW FIFO buffer
	- supports various ODRs (output data rates)

The KX132-1211 accelerometer is very similair to the KX022A. 
One key difference is number of bits to report the number of data bytes that 
have been stored in the buffer: 8 bits for KX022A vs 10 bits for
KX132-1211.

Changes in v4:
- moved the allocation of the fifo_buffer to kx022a_fifo_enable and
  kx022a_fifo_disable
- some fixes to the regmap ranges of kx132-1211 

Changes in v3:
- added two new patches by separating the addition of the 
  i2c_device_id table and the removal of blank lines from other
  unrelated changes
- fixes a warning detected by the kernel test robot
- made all the changes related the chip_info in one patch

Changes in v2:
- added a new patch for warning when the device_id match fails in the
  probe function
- added a new patch for the function that retrieves the number of bytes
  in the buffer
- added a change to the Kconfig file in the patch adding the support
  for the kx132-1211
- various fixes and modifications listed under each patch

Mehdi Djait (7):
  dt-bindings: iio: Add KX132-1211 accelerometer
  iio: accel: kionix-kx022a: Remove blank lines
  iio: accel: kionix-kx022a: Warn on failed matches and assume
    compatibility
  iio: accel: kionix-kx022a: Add an i2c_device_id table
  iio: accel: kionix-kx022a: Refactor driver and add chip_info structure
  iio: accel: kionix-kx022a: Add a function to retrieve number of bytes
    in buffer
  iio: accel: Add support for Kionix/ROHM KX132-1211 accelerometer

 .../bindings/iio/accel/kionix,kx022a.yaml     |  12 +-
 drivers/iio/accel/Kconfig                     |   8 +-
 drivers/iio/accel/kionix-kx022a-i2c.c         |  22 +-
 drivers/iio/accel/kionix-kx022a-spi.c         |  13 +-
 drivers/iio/accel/kionix-kx022a.c             | 315 ++++++++++++++----
 drivers/iio/accel/kionix-kx022a.h             | 109 +++++-
 6 files changed, 404 insertions(+), 75 deletions(-)

-- 
2.30.2

