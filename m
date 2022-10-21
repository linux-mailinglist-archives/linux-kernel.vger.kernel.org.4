Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5AD860787D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiJUNbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiJUNbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:31:42 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BB42639DF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:31:38 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bp11so4539963wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=i1C8rgUAGHf+jLqpE/CuMvEaAQwxa6V5+hxBqPwgUl4=;
        b=VT5D5asWne9UXufhJlAhGa0EmSt5P0Hw6devsJJzR8+iofV3cA2BWJNKGMuFsN4Fqm
         IcxrUgNFDdlniCIrLtHcj2X/aWeccarjVBhWGNRF3+ZiX7UCWzjuHQyC02aq8LPYOsjf
         ZGE5hxa5G71mBHwZUBvVV25OqgTXv3Yl7zKW1SvuSkCQkS8PDUL2OHPIPe0rSDBHGiPW
         O1dVAsqXIH9brG0AsAHQtaPtvqepSVJIynaIH37rTakT/6U2fYRn8zm/EVqYCqt5dvsy
         siz+j4NbG8YUcKTzJjdaKZy4VDS/2VZdm7wyi+JVA7TSqXvRln6ioq+sJKYjgN+DqxRi
         h3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1C8rgUAGHf+jLqpE/CuMvEaAQwxa6V5+hxBqPwgUl4=;
        b=od05JDWm3sxvG744k5GWbDs479tWUPtBbdq9bdVHc5s90z9XPwTJw3+XPVwOn2nUYr
         VvmjCHTLjD98eDUlXncOBGBJa3dwZeFaxe7OwuMnDbhTOlFdFruIuBDgrRWbO2yDaH1C
         /4JxBmXk9DYd0HYtr4mcF+g9ONe+jG+0+Y7OBzpdg9GkXZgViPkAp8DXQkaWNsvSMv8k
         LGSVmuwn+j8U5C0VWXuVTO9gjtYUBRZ/fYUG3vuAgmLRN47Rsv6sU8rBqeUyw7peIjtw
         XKjaPTlwvcePD/KDMF/05sRoi24SnlxU0HFnk71M+ZeVieIQoremtRZNVAaOnS9tmwj1
         ox9Q==
X-Gm-Message-State: ACrzQf37BDQvHbxL7pDNBYl4UZXa05sTnCWP+uqA/5ZNwkbqonAcqFVj
        +2BqPuZhboyZlmWj/eBTENLaZw==
X-Google-Smtp-Source: AMsMyM5qyI1cW3ggb8lP2/pXLZo9ZzZ8Tvd5w+92XYdbvWvWBG5C05J0jgsWEpZL+/L7Tqi/pOTWvA==
X-Received: by 2002:a5d:5983:0:b0:22e:bb12:7041 with SMTP id n3-20020a5d5983000000b0022ebb127041mr12385502wri.645.1666359096510;
        Fri, 21 Oct 2022 06:31:36 -0700 (PDT)
Received: from [127.0.1.1] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id j8-20020a05600c1c0800b003c6b7f5567csm10325280wms.0.2022.10.21.06.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:31:35 -0700 (PDT)
Subject: [PATCH v4 0/4] spi: amlogic: meson-spicc: Use pinctrl to drive CLK line when idle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIACyfUmMC/33NTQrCMBAF4KuUrB1JJrU/rryHuEjSqR2IbUlssJTe3eBS0NXwHrxvNhEpMEVxLj
 YRKHHkacyhPBTCDWa8E3CXs0CJqKQsYZnBPDz0/II4Mzi0tqa6oUpqkUfWRAIbzOiGPBsX73M5cHxO
 Yf08SZjP9aeXECRoagy1yqgWTxdrVs820NFND3HLWtL/BZ2Fpu1IYdV3qtJfwr7vb0sgc/P2AAAA
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Fri, 21 Oct 2022 15:31:24 +0200
Message-Id: <20221004-up-aml-fix-spi-v4-0-0342d8e10c49@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-amlogic@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Da Xue <da@libre.computer>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1666359095; l=1850;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=uh9b1V5lppXzVxalMWZveFXtfZNKXVHWr9osZJQJmd8=;
 b=0swTXrE+WS10AzArr7fM6CGstAbhVRX7nQSIOVPrQrbIfFk9podLHQ5iJt+C/00Nj7XVBVPwvjaG
 BSHMkaSkDAQUMKq8yDVgWMXnURoaBsPi/EI1jLcB/9/tmwrPLfas
X-Developer-Key: i=aouledameur@baylibre.com; a=ed25519;
 pk=HgYWawSL4qLGPx+RzJ+Cuu+V8Pi/KQnDDm1wjWPMOFE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Changes in v4:
- Fixed documentation by defining pinctrl-x.
- Link to v3: https://lore.kernel.org/r/20221004-up-aml-fix-spi-v3-0-89de126fd163@baylibre.com

Changes in v3:
- Fixed documentation by removing pinctrl states as they are not mandatory.
- Link to v2: https://lore.kernel.org/r/20221004-up-aml-fix-spi-v2-0-3e8ae91a1925@baylibre.com

---
Amjad Ouled-Ameur (4):
      spi: dt-bindings: amlogic, meson-gx-spicc: Add pinctrl names for SPI signal states
      spi: meson-spicc: Use pinctrl to drive CLK line when idle
      arm64: dts: meson-gxl: add SPI pinctrl nodes for CLK
      arm64: dts: meson-gxbb: add SPI pinctrl nodes for CLK

 .../bindings/spi/amlogic,meson-gx-spicc.yaml       | 75 ++++++++++++++--------
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 14 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         | 14 ++++
 drivers/spi/spi-meson-spicc.c                      | 39 ++++++++++-
 4 files changed, 113 insertions(+), 29 deletions(-)
---
base-commit: e35184f321518acadb681928a016da21a9a20c13
change-id: 20221004-up-aml-fix-spi-c2bb7e78e603

Best regards,
-- 
Amjad Ouled-Ameur <aouledameur@baylibre.com>
