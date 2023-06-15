Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE66073153F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239850AbjFOK1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244494AbjFOK1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:27:12 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B50199
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:27:10 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30fc26affa9so3545366f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686824829; x=1689416829;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J62bA6AG82c5ZNdMpXDKp2JLMan8hk/fgX9Ih6U7+Iw=;
        b=m5aw+Va+McZTa+Xm3nwgOKmneiWbqZT8P3M1VQ1PWR5h39YWJrX/jiw03F7Dv7kMbV
         3gc+88vhJC9hNOYztDJ/aHctspFPxyyySmiXkP1kFz7bGv5d3bxazVB5+zEN7H7jSx50
         vwyqpdg9SPCAvJCALj5LuYd9JWZF0OBTvOepkBHpXth+uGbEKywRZFuS1+BS/KBbSIcE
         eDeB24T4gpx2iqpVYPDtTjK99CvFX1A6Nd4tUOHehcYwG7Z12duLIMeXR48cEteoBEts
         w4Pyz9tmggiR4fdD85VOwFwsvqElwsrt5gJ53/OXqFvIp3qqVg9xHxpdcgNAMOJCBf+4
         lKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686824829; x=1689416829;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J62bA6AG82c5ZNdMpXDKp2JLMan8hk/fgX9Ih6U7+Iw=;
        b=c9Kt6+hn3VptgORcfcXAh4jvTAJWs4Y47Ba3k3rVlyq7dEjlIc3L2MOJQssxb2Il+P
         TXSl8t348KHeSmC/rxrXlqj7EsqJCB1jUkXVqTM/8eKc+kyr/72DVJ1uB0VrHFp0ZOWw
         g3+jONY9+df6BBS3H8xuCeIheVar833NjZCY+g935ljlfBGGW4/yr4WDRn6CHxY06thU
         X20HeXK244kcwr1SmXa/3MkKniHkDIOp0gQZ0TvdysylJdbGGZx9RNY2nV8EJLfjFbCD
         pbNNcZnpLHe7aly9sCvn8AD36da9x8DzBYMo1JYWgrFeDAOX4rLZDtPf8EqQeASz41jX
         VpRg==
X-Gm-Message-State: AC+VfDzhG1XGOjq2MHVnQtS2MnG5NC/aJlbHUOdlMzJzLsKslT3ELoxm
        OBwa2ldTCxcAtHNMl5DJzl7TDA==
X-Google-Smtp-Source: ACHHUZ5W7cI7dv9pQEp8cnuFC7A6U3F4L/SeMihVJrbSUM6NVkKeWV8/yqjgSzNP6SO16UcuykhMjQ==
X-Received: by 2002:adf:ee8a:0:b0:30e:38d3:cc4f with SMTP id b10-20020adfee8a000000b0030e38d3cc4fmr8778471wro.36.1686824828751;
        Thu, 15 Jun 2023 03:27:08 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id u5-20020a5d5145000000b0030fa57d8064sm17332337wrt.52.2023.06.15.03.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 03:27:08 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/4] input: touchscreen: add initial support for Goodix
 Berlin touchscreen IC
Date:   Thu, 15 Jun 2023 12:26:59 +0200
Message-Id: <20230606-topic-goodix-berlin-upstream-initial-v2-0-26bc8fe1e90e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHPnimQC/5WOQQqDMBBFryJZd0q0orar3qO4mMRRB2wikygW8
 e5NvUGX7/N5/+8qkDAF9ch2JbRyYO8SFJdM2RHdQMBdYlXo4qYrXUH0M1sYvO94A0MysYNlDlE
 I38COI+MEBu81NWSbvrQqqQwGAiPo7JhkbpmmFM5CPW/n9qtNPHKIXj7nlTX/pX+urjloKFHXZ
 W4apL57phqKv3oZVHscxxdyXbnt7gAAAA==
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2501;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=iGL9bUP8goPqAzcNxq7omTa+Gww+6KyorHhyHSm3Zcw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkiud5J9vMYNI/p+w/ntz9pJLX2vyPR7wdcE+yGGO4
 pvmohTyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIrneQAKCRB33NvayMhJ0atxEA
 Ci5tKuWwsSHATYkdYiVZmETBuW7GOYTrstjhqzPHhGf9gsdtRStQMPM2g1NPfBOlj5oGEovfQsh0zv
 LWpiXcaaY82bvlJqKQ3jBlLf1BmiywvVTWvEnEQ1EeSMVCr4y0CnUV8l0pGKNEXyG991VIy3FUIBnV
 2oBPdenRtUi3V9oy24UNG8bGuFTnfNOWVWHypDaSJsGnB8ow8oWrmkQo0hDJcnrRuV41kxqDP6IZ4c
 7njrV4/GpC6EZ1VpMJZguLfZlrUGV8Snf2bxHULM/NjO5LL3vao1bBzItGzouwV/Ikh8YZHr1hr+MG
 qbCpCTAITb8J5bWU2tHt5Sy7CRmts1hl0lGjqzL1RyoeSumu3G+baZyESwmdy81mxRaKnTP/8FLXlB
 me3YBjvY0Q4H19KWrLqt4DmbTLDg8QXLMDouK+OWFmhmlqPbmeSOeem+nBW+EtoOKwhAiEuFC69FS/
 uRy6NlqbcBl8dmD+zaOxRPyIm3NCzXQTPtha4pYkJBwZX2xCf/d2+TS9ZpoFGoXVX4kXQKAqcF7rro
 mL/CArp4mvST5/hqLt1TfTaTXZs6z0UMclzkUU4ZfTVb6bAS+cYdyyuZ2Qbq8YES975FgUMaKrqxNt
 4pwn4TVmcfaFxrzA/mVi0Dj6UD2ukpZVvQeEU1NuMetuwihBcNjNaEVld4vQ==
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

 .../bindings/input/touchscreen/goodix,gt9916.yaml  |  95 +++
 drivers/input/touchscreen/Kconfig                  |  32 +
 drivers/input/touchscreen/Makefile                 |   3 +
 drivers/input/touchscreen/goodix_berlin.h          | 178 ++++++
 drivers/input/touchscreen/goodix_berlin_core.c     | 681 +++++++++++++++++++++
 drivers/input/touchscreen/goodix_berlin_i2c.c      |  69 +++
 drivers/input/touchscreen/goodix_berlin_spi.c      | 172 ++++++
 7 files changed, 1230 insertions(+)
---
base-commit: 6db29e14f4fb7bce9eb5290288e71b05c2b0d118
change-id: 20230606-topic-goodix-berlin-upstream-initial-ba97e8ec8f4c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

