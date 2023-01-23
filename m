Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1419A678AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbjAWWXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjAWWXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:23:46 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8ED30194;
        Mon, 23 Jan 2023 14:23:44 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v30so16369127edb.9;
        Mon, 23 Jan 2023 14:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1fPD3yMwyErqgyHP1cVk5L5Dh397sb2S5yn/YVy8ldA=;
        b=DUAIZe+ryw7hzpevXSDEpm7IN0lvQO69vkLizbB0wOvV8/K7qK++Tl0jmHGgueWohj
         yKjKGrkc+xQALKpvhj2M9l+tPxrSiiyyFjGO0gbc6b2tXBmOo9wQ7R/E5MIBblUsZjAe
         bmQThA3zDezYl2/Zbh13DGGl5mZqVlEPWQKewAWFK93daI/hPWq9gRieR/dlxbbhiQDz
         BMb+UuYKe+P2KwHC/as6iU/P9JHbhTjQQ8NXyfKZNFGGb3QWU4Q0I2XrCFFc0M6oP0XL
         TdDi4sqBxsA+UFYKw0Zo6KGFTYMvusBlJXUhgjDPCMv9wjGYOx0AHU8as06mH7oeZFQK
         Ogrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1fPD3yMwyErqgyHP1cVk5L5Dh397sb2S5yn/YVy8ldA=;
        b=2i3ii0QBNvTGxaSTCFsPxhRc+zmWVZOUMpkGhb3LjeAyDZtFrSnj3GjBWsV45KPc1b
         YpEm7BoPVYw1u7Qktp8mEGYHekyLtSaJcGbhk8AMYgNkJmn7yB3w3rSc+24+D5olaY63
         kdTln2hry7Kp0cpD/dAGSshAW3gB+ltHK1h2pIvIlG/REHW45Q2qCI4yGLgAPGjmi05B
         4Ld8nXu2/+sjYazMN1W2OW972JhMNF31g/IcwAbDRyQNke86s7t9ZZYWy90Qxnus4tFP
         ihCxCoCanvV4rqc9XSRm74RacCUqDO0nEN4ASKvF69yG3LtjsDmIhgCPW0g/zvswhUCS
         m2Dg==
X-Gm-Message-State: AFqh2kr+SRajikidRRJpD4IeC/vhMaVY9OXn9rSO2f7AsUkAnIOTJew2
        vYR1YtVXAwQ+uuFyUFDvB9fLI3jT1iY=
X-Google-Smtp-Source: AMrXdXsMJ/EKeGVhaWg184wBLwM0V9JJR46yYEdZwyH1Mkx0KFL1AwIaJqj9RCzRBF/hpaoJJnJT4g==
X-Received: by 2002:a05:6402:5110:b0:499:bec8:4f with SMTP id m16-20020a056402511000b00499bec8004fmr35743134edd.20.1674512622636;
        Mon, 23 Jan 2023 14:23:42 -0800 (PST)
Received: from localhost.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id l19-20020a056402345300b0049f5ab4fa97sm256928edc.86.2023.01.23.14.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 14:23:42 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 0/2] Add support for Samsung Galaxy S5 (Exynos)
Date:   Tue, 24 Jan 2023 00:23:26 +0200
Message-Id: <20230123222329.13994-1-markuss.broks@gmail.com>
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

Samsung Galaxy S5 (Exynos) is a mobile phone released in 2014.
It has an Exynos5422 platform. This version of Galaxy S5 is only
capable of 3G communication using the Intel modem, while the
LTE version of the device (klte) has a Qualcomm Snapdragon SoC.

Currently, internal eMMC, USB, regulators on a PMIC, and touchscreen
are enabled in the device-tree.

It also has the following peripherals:

- 5" 1080p S6E3FA2 DSI display,
- Cypress StreetFighter touch buttons,
- Broadcom BCM4354 wireless connectivity module,
- Intel XMM6360 3G modem,
- STM32F401 serving as a sensor hub,
- Validify Solutions VFS61 series fingerprint sensor,
- Lattice ICE401M FPGA as an IRDA controller,
- Maxim MAX86900 heart rate sensor,
- NXP PN547 NFC controller,
- Wolfson WM5110 Audio DSP,
- Broadcom BCM4753 GPS radio,
- Maxim MAX77804 PMIC,
- Silicon Image SII8240 MHL controller,
- TI LP5562 LED driver

Cc: Mark Brown <broonie@kernel.org>

v1 -> v2:
- use better subject prefixes
- rename Galaxy S5 (Exynos) to Galaxy S5 (SM-G900H)
- align the compatibles and clock output names
- reorder the includes
- generic node name for regulator-tsp-vdd-en
- GPIO flag for regulator
- rename all the regulators, leaving the voltage values only where
  it makes sense (e.g. on 3V3 and 1V8 supplies for the HRM)
v2 -> v3:
- touch-pin to touch-irq-pins
- s2mps11-irq-pin to s2mps11-irq-pins
- touch_pin to touch_irq

Markuss Broks (2):
  Documentation: devicetree: bindings: Add compatible for Samsung Galaxy
    S5 (Exynos)
  arm: dts: Add device-tree for Samsung Galaxy S5 (Exynos)

 .../bindings/arm/samsung/samsung-boards.yaml  |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/exynos5422-samsung-k3g.dts  | 676 ++++++++++++++++++
 3 files changed, 678 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos5422-samsung-k3g.dts

-- 
2.39.0

