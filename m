Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B8373A2FF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjFVO3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjFVO3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:29:07 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9AB19B7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:29:05 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31297125334so763156f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687444144; x=1690036144;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q6puVKPodb7fnIeZGT3HM/7egIk8BBqCuZeufHWrWv8=;
        b=SQZkU8PWShGK9tcx+dKSW9GaiMEwtYANr84T5ngYhUXsQjIk355HFzKYNdoGu9xpkH
         iND5YGrYa3Ke1vQ0z0esXjkoVquYMqvsQuaJov3EKr4714JdbA+OtdrVFurSZjVy+mVA
         5Rz0II7IEFUy5ihBIEyNy2lfuf4oMJf3Dxqb6HyI+F6t619EcaL8SasoQp1OoSMRDiDJ
         sDJAOchSQQ5sbqWT0tTzlNKPEv6LDDY6bMFdprN+ex6tTaaEYVB1alwkqgRwczI8Vma+
         gpN9T75RVL1nCs1w7cgTtU8KcB8uG86DCPdeMSlyN6CUy0r4onqNI0zbvAA8Vv9Nwtb8
         I0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687444144; x=1690036144;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q6puVKPodb7fnIeZGT3HM/7egIk8BBqCuZeufHWrWv8=;
        b=LY2xq6UsEIyAVIisE4sFg+6nky+MaFZdjS8Rp1kpO6qs5WIHK1yX59cOMTr6fKLd7I
         kCSc+q/txdrDy+E1GozW62GmBhJa27lhhMGtZJNrmeHWsHrbjtfbfbHkgZgM9kV0tzZ8
         YYtc30VjX+DI2AGX98rkwUw510jM++HidOf/ZIISjUagVJSJn3nj3FEDOOTFpMuytvMC
         A+tSA6404TB86EbCwD9/TWbB2qCWZBBKkX0hLbjYUjuF0iEnqVFSGFfMH8IKO6SiQ3n5
         ThGmcdYtOobWeU3u+txHsn+3lPYpgait3iz02qL4wR5lW3prqGzNdOFgUSFwqU/sVx3m
         eLZw==
X-Gm-Message-State: AC+VfDweNmd56ye2DjD/bQE79/htts++5qo/kPzuT8EKwmww9ulj1P0n
        XL4gnstZ3iW3FYvVy2TZHFJi3A==
X-Google-Smtp-Source: ACHHUZ6qSes5SnF8qkXG81bCzq/oLfmzOh46JCuPmFOxmQsw2jRNwsKvdMnSuzg0JkcIqqKJZ7RsLQ==
X-Received: by 2002:a5d:50cb:0:b0:30f:d07f:5a3b with SMTP id f11-20020a5d50cb000000b0030fd07f5a3bmr22092877wrt.9.1687444143835;
        Thu, 22 Jun 2023 07:29:03 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id w18-20020a5d6812000000b0030ae69920c9sm7168361wru.53.2023.06.22.07.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:29:03 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/4] input: touchscreen: add initial support for Goodix
 Berlin touchscreen IC
Date:   Thu, 22 Jun 2023 16:28:58 +0200
Message-Id: <20230606-topic-goodix-berlin-upstream-initial-v3-0-f0577cead709@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKpalGQC/52PMQ7CMAxFr4IyY5SGqhQm7oEYnNRtLZWkctoKh
 Hp3DBsjjO/Lev/7aTIJUzanzdMILZw5RYX9dmNCj7Ej4EbZOOv2trIVTGnkAF1KDd/BkwwcYR7
 zJIQ34MgT4wAejweqKdRtGYyqPGYCLxhDr7I4D4OGo1DL90/35arcc56SPD5TluKd/ti6FGChR
 HsoC18jtc1Zz1DSLkln3g2L+8fq1Ooqr89QQUdLX9Z1XV8CerPhRAEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3366;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=85RQ3QfjPlDD8JRppLNrio/v0iNTp1dj7AjRx+bbrjQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBklFqst+pd8aEBjksWinDt4TKoDjP/MjimwpVa+hyo
 tWlznvGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJRarAAKCRB33NvayMhJ0SL4D/
 9W4/Bbp4anUA+tEHkNMr99bmWddXuiK7iXuLJe3Nq1s8JZMgRGwiEvwN1uMkEBtJrjib0B7ITckJqE
 A5369lS1NxjtFrUKqi+1+r//IWXK+FsLxqbpvbHfolNa134T4zfTGb9PcmoFkAQCS/p6TexbTkCFDE
 3ABnzyyfO8Gu5eZr1p1zFqmNT8Z2es+GOxvEVcp4qsomyplD0nNux6EVHs1l4yi5aIaT8hEN9211VU
 dmo2+ukZ/h7/JSAWkoNPmu/kiVcNkgUAz9RmZKDyppBRqpHxw5EYcR7lNmBSqABbsacbyfSQKtmzpm
 kbLgSLvyeaRy0/AhQ/4NPwywcdXY1aoEf4GykcjxrFCPHbiXntgybioF1lC6mP52zItbFforhCCV2R
 fnmTYv59971+ULf4mCT8Ts18c5eduXoq05mvOVSiqEDi0Yak8CqLkXQcijyAn9NLy2Dye9CXHF//50
 ZC1VCqWZXyuX5Rt+g/9M8LMUydidl0sKDVglAfEvkRGJyu6t8iTsTloJ1x/c78+r6z7tAyQTUwUvMJ
 zREs544YqiBwtTPHAsp46zmMnPSJ3ywwV3WB2fRNCUMhGtQr25yNCg7Vh3SoVRPH3e4eNI4Q3wzs2G
 37caPqhvnSeuL4EK9jgQgJURevZr17lJwVc7xmvxLxaivyJzWUmUyxhFCLfQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
 drivers/input/touchscreen/Kconfig                  |  32 ++
 drivers/input/touchscreen/Makefile                 |   3 +
 drivers/input/touchscreen/goodix_berlin.h          | 159 ++++++
 drivers/input/touchscreen/goodix_berlin_core.c     | 584 +++++++++++++++++++++
 drivers/input/touchscreen/goodix_berlin_i2c.c      |  69 +++
 drivers/input/touchscreen/goodix_berlin_spi.c      | 172 ++++++
 7 files changed, 1114 insertions(+)
---
base-commit: 6db29e14f4fb7bce9eb5290288e71b05c2b0d118
change-id: 20230606-topic-goodix-berlin-upstream-initial-ba97e8ec8f4c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

