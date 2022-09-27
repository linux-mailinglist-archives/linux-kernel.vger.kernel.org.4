Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3685ED0C2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 01:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiI0XIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 19:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiI0XIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 19:08:45 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DF710CA47;
        Tue, 27 Sep 2022 16:08:44 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id 138so8924990iou.9;
        Tue, 27 Sep 2022 16:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=KTyDoPOK1pleRSvYG1/2nWqf1JHfv2oKd5erAV4l2LU=;
        b=CLwsQ6ndm+yxCDrRM9fzkOdZZJwsaXY0WpCXXoauIBBJpm4qy9SdGvYCpbIxRJkCsL
         AZoywFF7Wvg5eNWr/XeQrTduzUQ+ctU+6hsSA9OP/lgbnmMr9NTTqEkeQ9WK3JE/Ss/A
         JO3hQ2fmo69cjvwCLl8vPFlXQxaO4639dUeBOy75f/y/XQ/hPN46OE9FjINnfo+oACv0
         3/GwCBGZT76hBVgJm6tPO0R6GKQddq/1LCcBrzzEatBRFHDBAF2jk5KZqPimJC4y0V52
         gJ8esSWboEk0kV/2WGu72fp9A/Wm7gnhkL4WGEDwOqraVc9h7xj4oWdL0Tikjb42YFXy
         x/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=KTyDoPOK1pleRSvYG1/2nWqf1JHfv2oKd5erAV4l2LU=;
        b=zmLAM/rPI8dxDCht/HkNpAdPPDviydoF/NgDLVVBqCd6zTgpdUd0ALC/PHTp00Oln7
         6b6bIozFmhBQtSnwX0oeU+PQz2YmmcVr9B27UYMHUDy1BgYMXYqfKxlawFiGt51BZx5R
         J7MMqxAA7+LQUS2PU0a/UCGVkjLc3kq5FpARRmrWtiOAzpaiCbGmOZhzt4iE11zgbXIV
         O4oX/kg8lN6L9uNjaVsRMN5jJWEtHr8OZBL1moJfHLfHFWEuBEiwr1XyI5zzNuDh24xP
         Na9s2SY3imCnEX79hmUbTdA7u+gNLZFW15stHnChlSp2t/f6zbKAH+yfbAG/NVeJ7++S
         fAxQ==
X-Gm-Message-State: ACrzQf3lxvRtsqrG1UiSeawTAIZoOAwUYzQ20osaDlt+TvB5WUFYBGMh
        lCec0+AUpRZvirZDdsBw8ajXNsa0U1g=
X-Google-Smtp-Source: AMsMyM7XifCsm2Z8N0r9eaBFfIjpSe9OpH4ZcuiqXDsJGO6rG2tAdwrL8INPk/m/nP+rnBvbVVoZaw==
X-Received: by 2002:a6b:e205:0:b0:6a1:122:e3b7 with SMTP id z5-20020a6be205000000b006a10122e3b7mr12278395ioc.161.1664320123623;
        Tue, 27 Sep 2022 16:08:43 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::ac99])
        by smtp.gmail.com with UTF8SMTPSA id p10-20020a92d28a000000b002e9818bc2dfsm172592ilp.8.2022.09.27.16.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 16:08:42 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v5 0/3] SDM670 Pin Control Driver
Date:   Tue, 27 Sep 2022 19:08:30 -0400
Message-Id: <20220927230833.125749-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Changes since v4:
 - accumulate review tag
 - use --cover-letter
 - this is effectively a resend

Changes since v3:
 - constrain gpio-reserved-ranges to 1-75 items
 - proper indentation in dt-bindings example (actually tagged this time
   instead of an outdated commit)
 - remove unnecessary commit reference
 - rename complement_fw_reserved_gpios -> complement_fw_gpio_ranges

Changes since v2:
 - remove quotes from pinctrl.yaml# in dt-bindings
 - constrain gpio-reserved-ranges to 1-76 items (includes ufs_reset)
 - indentation in dt-bindings example
 - cite downstream kernel source
 - remove MODULE_AUTHOR (most imported pinctrl drivers don't have this)

Changes since v1:
 - add a field in msm_pinctrl_soc_data to accomodate the needs of the
   driver and device dts
 - apply changes made to existing tlmm dt documentation
 - add reserved gpios array
 - rename device tree compat string to qcom,sdm670-tlmm
 - remove dependency on ACPI
 - move MODULE_DEVICE_TABLE macro call up
 - add missing pins (fixes most of the debugfs problems)
 - move qup0_pins down
 - add whitespace between UFS_RESET macro and pins array

This patch series adds the driver for the Qualcomm Snapdragon 670 TLMM
(Top-Level Mode Multiplexer) and introduces a new field so that SDM670-
related device trees can reserve their own gpios.

Richard Acayan (3):
  dt-bindings: pinctrl: qcom: add sdm670 pinctrl
  pinctrl: qcom: add support for complementary reserved gpios
  pinctrl: qcom: add sdm670 pinctrl

 .../bindings/pinctrl/qcom,sdm670-tlmm.yaml    |  138 ++
 drivers/pinctrl/qcom/Kconfig                  |    9 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-msm.c            |    5 +-
 drivers/pinctrl/qcom/pinctrl-msm.h            |    4 +
 drivers/pinctrl/qcom/pinctrl-sdm670.c         | 1373 +++++++++++++++++
 6 files changed, 1528 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sdm670.c

-- 
2.37.3

