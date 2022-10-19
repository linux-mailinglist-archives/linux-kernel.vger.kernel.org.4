Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F75604915
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbiJSOV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbiJSOVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:21:09 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC4543E65
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:04:37 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id e18so13005453wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=PVj2DAdfLIU/pX3XZE26BCq9oqHkdH2P1yACg55ATYc=;
        b=QlA9FYPVLD1k0zfaUSwjLI8Q83sBFeoAzC7eQuA8Vn4Dp8rjm78gQg6ZSYljWFaYI7
         +EDL8mVklujMsDG8GH9sEfGXq2u99dWf+2LcmapexNQMysE0Gk9TzJ7RJR9XciOpt60T
         v2f7F0XsTAOUDv9oH+0tpL/amAfarJmdENSkKa5Fmhky74UWZjAH3KB+l6inFESY5V1f
         aNjyQ0JZwMql16HhSJGSg149q426+rWzciTmWU7Ja794brJrFd4gv8Mq63R3zu2Skj0B
         bJKMfYLkoBFcz8AsXb9NzPVITJMOIhiV15K+OlEVdt/gbPnIOGmsPEGVwyHC61oOIOBn
         bN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PVj2DAdfLIU/pX3XZE26BCq9oqHkdH2P1yACg55ATYc=;
        b=Llirvecp6VzT4jao3jRTfwE7/61OAiO7KngygPraj6d1HBqbCssyFQQRFiPDwD0DU6
         UZFCZvg+0toDtodmTBFoxwWw2XPX/vqZfhp0gkhp3Jv7Kcl2M+zTPezhctClX9GmDMcG
         yoI8sy1V19C/HdDarbFHXlEFTvU7cpvk0RWwMesfTLgt4C8TBa7aaS3969eHSGXsLnV3
         26Ks2xrE2JaDI4iPbF1TOUx5K+HaXsGg9+Nlm1ac8IcKOgFQc8DHG9Sn+kRsQNWycCYA
         RspqUBiYUcld5ymdIe5TPS2lB6u0JIKUc0SYhLkcfuT4X9t5K6o9eH4AscaV/RjADcmt
         kEYA==
X-Gm-Message-State: ACrzQf2HViVeewlq/OGZlWTpdOZyiCESZdQD5RLKFNiY/cjzSyV5RLl1
        Z4eXHwB7S+U7Ubr7h3bqNEmTJA==
X-Google-Smtp-Source: AMsMyM5VncASy5bf6AEIZVI0iOwpTrGuyy+Dcp8M8CChiqgXYaA84TGEqw0ITPNidhlKL1DMQ9mdMg==
X-Received: by 2002:a05:600c:468f:b0:3c6:f85c:25a1 with SMTP id p15-20020a05600c468f00b003c6f85c25a1mr5696138wmo.60.1666188197604;
        Wed, 19 Oct 2022 07:03:17 -0700 (PDT)
Received: from [127.0.1.1] (rtr.23.90.200.126.unyc.it. [23.90.200.126])
        by smtp.googlemail.com with ESMTPSA id o5-20020a5d62c5000000b00228cbac7a25sm13998628wrv.64.2022.10.19.07.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 07:03:17 -0700 (PDT)
Subject: [PATCH v3 0/2] spi: amlogic: meson-spicc: Use pinctrl to drive CLK line when idle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAB4DUGMC/3WNzQrCMBCEX6Xs2ZV0q/bn5HuIh01c7UKalsQWS+m7G7x7Gr6Bb2aDJFElQVdsEG
 XRpGPIUB0KcD2Hl6A+MgMZotKYE84T8uDxqR9Mk6Ija2upG7mYCrJkOQnayMH1WQuz97nsNb3HuP5O
 Fspx+7u3EBqspGFpSy5bOl8tr15tlKMbB7jv+/4FlmtKQLQAAAA=
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Wed, 19 Oct 2022 16:01:02 +0200
Message-Id: <20221004-up-aml-fix-spi-v3-0-89de126fd163@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Da Xue <da@libre.computer>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1666188196; l=1508;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=/olsUtwOJnRswdLM6doMxbVMNoGB8qZCnkiNegDbh1w=;
 b=aFPV+HsjpwaTDlj7ngssvgjXRK+U0pQ5Yu0g/7m9QFR2MBhDYQYr2iRBsvSx6x+PD6M/5IKDkRss
 MTCh+avjCw3BKpkSwtHHwbLoGKJbXu2qDxoOXZfjOz5/8jYPCtQC
X-Developer-Key: i=aouledameur@baylibre.com; a=ed25519;
 pk=HgYWawSL4qLGPx+RzJ+Cuu+V8Pi/KQnDDm1wjWPMOFE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Between SPI transactions, all SPI pins are in HiZ state. When using the SS
signal from the SPICC controller it's not an issue because when the
transaction resumes all pins come back to the right state at the same time
as SS.

The problem is when we use CS as a GPIO. In fact, between the GPIO CS
state change and SPI pins state change from idle, you can have a missing or
spurious clock transition.

Set a bias on the clock depending on the clock polarity requested before CS
goes active, by passing a special "idle-low" and "idle-high" pinctrl state
and setting the right state at a start of a message.

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
Changes in v3:
- Fixed documentation by removing pinctrl states as they are not mandatory.
- Link to v2: https://lore.kernel.org/r/20221004-up-aml-fix-spi-v2-0-3e8ae91a1925@baylibre.com

---
Amjad Ouled-Ameur (2):
      spi: dt-bindings: amlogic, meson-gx-spicc: Add pinctrl names for SPI signal states
      spi: meson-spicc: Use pinctrl to drive CLK line when idle

 .../bindings/spi/amlogic,meson-gx-spicc.yaml       | 67 ++++++++++++++--------
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         | 14 +++++
 drivers/spi/spi-meson-spicc.c                      | 39 ++++++++++++-
 3 files changed, 94 insertions(+), 26 deletions(-)
---
base-commit: aae703b02f92bde9264366c545e87cec451de471
change-id: 20221004-up-aml-fix-spi-c2bb7e78e603

Best regards,
-- 
Amjad Ouled-Ameur <aouledameur@baylibre.com>
