Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642FD742336
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 11:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjF2J1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 05:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjF2J1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 05:27:18 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1198E6C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 02:27:16 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fa96fd79f0so6119855e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 02:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688030835; x=1690622835;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eGq2XRZm7WtrZy/ifp8hN9B5sySkTAbmyFnaSRlEois=;
        b=TUoE3nwxb1d4VMYI/39Pbb4SsJNJ84IV97uOIXQghUokB0X1ABEU6E1vuPfhRlTgPp
         e3rPLtKXjscafbMz8hvzCgK+PQqCzsPwYD5Mszhh6D7Ctt7fWm9m9UwJ9qSisDoLSa8G
         WBT3MKWYgHTSvnDwfvlmneYC4a4m1VwVdiKEZq47YK4cvHGEAh5rK4nAbs0nBT52kbTO
         UgfoOUx8pAvVXQAR1553ne29fPWN5quoVIwuV4WWCKoSRnU62qo1zsGc9EPKzcOEoyUv
         pekyTjs1OZwSfpkevS3YetidfoaYBSmEmrPijrj+G9EIbBU2YSUIWpxh1cB9wG4fPBfs
         d2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688030835; x=1690622835;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGq2XRZm7WtrZy/ifp8hN9B5sySkTAbmyFnaSRlEois=;
        b=IaFXhjbEcrYb++DCwGpqi5eXh0uuOBKR73G53zGcAPURGItqfiCpMm4aKuFrc7fCmU
         y6Emj1GknMy/hX1pWkYn3pxphICSb8HzP8YnO71wtM9M8+2wnp60LF8Gj7tvw+QjslM3
         lIsuX30Huh5c948fhIbiHZ6evYFI9VJ4GowgAg6D4uT5wATSnqGkYZiE7cSZnwNntSFt
         MeXpsqBHJy6s8A7QH8NcOwzzb9nCXrfa81/z4Ytn++L1/bvrqeYV3PoYrdsmh9zFRIqo
         X0QEet+EX4uFnD9hqoVqLYLWwci+A1ULdWeD5/dkXM4cxSnSYOEH9F4F5w0Ph+bcmzmy
         I8wQ==
X-Gm-Message-State: AC+VfDy38jClS962eW5bAKMfiftYk1lW3IiQ4bNdNYh4XywkFmVqevj2
        UP4A+7Xlw0nIYxrG6g22SUSS1g==
X-Google-Smtp-Source: ACHHUZ7mFYN0YjPebpuPE95VHobjB0afKflB3awvP+AvHNxSt3fF+NPf1DGsNo4udZz2nAqYxiJUbQ==
X-Received: by 2002:a1c:f70f:0:b0:3f7:e58b:5898 with SMTP id v15-20020a1cf70f000000b003f7e58b5898mr42050218wmh.33.1688030835226;
        Thu, 29 Jun 2023 02:27:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id s4-20020adfea84000000b002ca864b807csm15800172wrm.0.2023.06.29.02.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 02:27:14 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 0/4] input: touchscreen: add initial support for Goodix
 Berlin touchscreen IC
Date:   Thu, 29 Jun 2023 11:27:09 +0200
Message-Id: <20230606-topic-goodix-berlin-upstream-initial-v4-0-0947c489be17@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG1OnWQC/53PwW6DMAwG4Fepcp6nEBiBnvYe0w5OMGCJJcihq
 FPFu8/tbdppPf6W9f32zRQSpmLOp5sR2rlwThqal5OJM6aJgAfNxllX29a2sOWVI0w5D3yFQLJ
 wgstaNiH8Ak68MS4QsPfUUezGJhqlAhaCIJjirFi6LIsOV6GRr4/uj0/NM5cty/fjlL26T//Zu
 ldgoUHrmyp0SOPwrmso+TXLZO4Nu3tGdaq6NugzVFFv6Y9aP6PWqo72zftIOHjb/1KP4/gBLoJ
 ZoJoBAAA=
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>
Cc:     linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4025;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=OD5U4uGsA9GU1bBT+Ot0Vy1oiHRIVCr5jZHBHJupASM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBknU5wF1HJPytvxnhJkRyz0455/bsPqbej9oyAdtOP
 +aIfsGKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJ1OcAAKCRB33NvayMhJ0cH5D/
 970SuP+TE38NQg/2wXxyED73CoK3tyx1LR5NG6eqIrT5BV4vfDQRSqibqU199Y7suFsjKRjE4wYGlq
 YoDeFfnoSq1zvTqA+ad24oU3RwbqxHdBeP3CMGP8wgMBdUneN6xSFrzhvqHNLCkYfJsGksk61RAPvt
 Bptw2XTevUM+SjHYCQB4//Xo8xoWmUrYNEXhFkl4ORvSgVMOeAVYg1xpvGZArBj09pPreuMfLs8/QA
 yJvTWNj/9XMXnzjQzglXbnI8xNcG7Fvsjo3fFjNHqZnWSFPXtpzhIlHYsWjiYJZVIf1cnA5cqGjP1O
 kZ7JbwCsUmoMXc88rux0uFQ1r7khLpuUM70A7CcvRO7FZlssfsZYLukIPpeQEQqQDLWNjZcVdzDHxE
 bJwIYCuSV+gLmeQvWHXYf0QXWPgiVfZiidfsm3Rwf6uKG1h1+I6yLmkq1RA+kRF+ptIskku98FJBRJ
 /ZPYo0s/ndhDKzkUBYXIBBhMXkuXs9ZMmJfHG7XDbG8OoFmYDvcM0ZQLmMvwlyiTFV82wYll6dnZHH
 j4M6M8gzwke5TMOIiY7kl2/fwsB3BijlmZnpu3FoUP4Oy7+jL+UYhezGuT/nx4vYKqiJd2VozZmtyl
 6GTA+TqDgDf25HqI4Bhunttrw3LqWSvquGHjp4ZYTnTyXLNyfZHNvShJJasg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These touchscreen ICs support SPI, I2C and I3C interface, up to
10 finger touch, stylus and gestures events.

This initial driver is derived from the Goodix goodix_ts_berlin
available at [1] and [2] and only supports the GT9916 IC
present on the Qualcomm SM8550 MTP & QRD touch panel.

The current implementation only supports BerlinD, aka GT9916.

Support for advanced features like:
- Firmware & config update
- Stylus events
- Gestures events
- Previous revisions support (BerlinA or BerlinB)
is not included in current version.

The current support will work with currently flashed firmware
and config, and bail out if firmware or config aren't flashed yet.

[1] https://github.com/goodix/goodix_ts_berlin
[2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v4:
- Core updates:
 - drop kconfig depends, deps will be handled by _SPI and _I2C
 - change power_on() error labels
 - print errors on all dev_err() prints
 - remove useless default variable initialization
 - switch irq touch checksum error to dev_err()
 - add Jeff's review tag
- I2C changes
 - change REGMAP_I2C Kconfig from depends to select
 - add Jeff's review tag
- SPI changes
 - add select REGMAP to Kconfig
 - added GOODIX_BERLIN_ prefix to defines
 - switched from ret to error
 - add Jeff's review tag
- Link to v3: https://lore.kernel.org/r/20230606-topic-goodix-berlin-upstream-initial-v3-0-f0577cead709@linaro.org

Changes in v3:
- Another guge cleanups after Jeff's review:
 - appended goodix_berlin_ before all defines
 - removed some unused defines
 - removed retries on most of read functions, can be added back later
 - added __le to ic_info structures
 - reworked and simplified irq handling, dropped enum and ts_event structs
 - added struct for touch data
 - simplified and cleaned goodix_berlin_check_checksum & goodix_berlin_is_dummy_data
 - moved touch_data_addr to the end of the main code_data
 - reworked probe to get_irq last and right before setip input device
 - cleaned probe by removing the "cd->dev"
 - added short paragraph to justify new driver for berlin devices
 - defined all offsets & masks
- Added bindings review tag
- Link to v2: https://lore.kernel.org/r/20230606-topic-goodix-berlin-upstream-initial-v2-0-26bc8fe1e90e@linaro.org

Changes in v2:
- Huge cleanups after Jeff's review:
 - switch to error instead of ret
 - drop dummy vendor/product ids
 - drop unused defined/enums
 - drop unused ic_info and only keep needes values
 - cleanup namings and use goodix_berlin_ everywhere
 - fix regulator setup
 - fix default variables value when assigned afterwars
 - removed indirections
 - dropped debugfs
 - cleaned input_dev setup
 - dropped _remove()
 - sync'ed i2c and spi drivers
- fixed yaml bindings
- Link to v1: https://lore.kernel.org/r/20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org

---
Neil Armstrong (4):
      dt-bindings: input: document Goodix Berlin Touchscreen IC
      input: touchscreen: add core support for Goodix Berlin Touchscreen IC
      input: touchscreen: add I2C support for Goodix Berlin Touchscreen IC
      input: touchscreen: add SPI support for Goodix Berlin Touchscreen IC

 .../bindings/input/touchscreen/goodix,gt9916.yaml  |  95 ++++
 drivers/input/touchscreen/Kconfig                  |  31 ++
 drivers/input/touchscreen/Makefile                 |   3 +
 drivers/input/touchscreen/goodix_berlin.h          | 159 ++++++
 drivers/input/touchscreen/goodix_berlin_core.c     | 581 +++++++++++++++++++++
 drivers/input/touchscreen/goodix_berlin_i2c.c      |  69 +++
 drivers/input/touchscreen/goodix_berlin_spi.c      | 173 ++++++
 7 files changed, 1111 insertions(+)
---
base-commit: 6db29e14f4fb7bce9eb5290288e71b05c2b0d118
change-id: 20230606-topic-goodix-berlin-upstream-initial-ba97e8ec8f4c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

