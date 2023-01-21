Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC3567692B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 21:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjAUUTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 15:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjAUUTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 15:19:52 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E422E23137;
        Sat, 21 Jan 2023 12:19:32 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id bk15so21747124ejb.9;
        Sat, 21 Jan 2023 12:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7G5+S/PVSHz7yMGza3qinD/tbKeLPcUtpFdDTPTxNbI=;
        b=MTfhvV0TM0mIGem6JR2KdbLB6KGqQ7nQOVoRtU+VXzVPlbiulNIuAeWQ40jis9+4j1
         Z5snXhrwBw233PC1FwRjR7I+VJM88+QiEwNEyspOKGMKWNn+5vW1QSIJ9k7nAUZwCNRY
         iPdFkIMIIT69xFbWUu849EXBjyq6jYYn3OWufbPaKZJ/kSmNtS3JYsga8PH3p2M3y8tD
         3lSe2esid2tL/FAww/0T3IsdjUmgjA5EPeEecvGYvQ34GYVM9uZIHcyvgMYTbPKClzQw
         TOZ2fL4N2q4iQSKS5+GIKpHTZhOekGKbQeoxSOytnqFjkau5J+nq00UTy5HKzTzM6wKs
         1u3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7G5+S/PVSHz7yMGza3qinD/tbKeLPcUtpFdDTPTxNbI=;
        b=utu5IPrnjqyzW02W3SWmqUXPnKLPkUAL8721E57syxzzwCeXmP3xdOkgPGvais1pUP
         CLdcvNZ2PkULwcV+v2WfHyKlB1A3Q6+lFG1omAsLdSsGSrF7VGDOE32/R4WoTT5q6Um5
         LWnovFmcwvcV0PZSQCY/zegSKBaZBT2LswPc1L2E/bLC5f+ek9Qi8UTY3GlJE+sWsy3Z
         ZaD2ak13FpDkD++ZQYanULg8Hmv+btNnyplqihLfA77ome6HYf+2Sgopy4OoSn23ltRO
         Wcmtj7+JlEzhi3RsyBht3cIr5D47JNiWIVuU+CDsEoAiuWNm0y9SLuM+kjXu7R5gcu4U
         ItGQ==
X-Gm-Message-State: AFqh2kpDEgSQ6HLrZbz9omSOeeKUF0V/+7VZiq1VoV4YCjNNxvTajaZD
        rfivgWffB0iQC/DR2FnDrqvQy4cYe1mIqg==
X-Google-Smtp-Source: AMrXdXsc5nPomzzhujeJdro79hQ+NL5g2BjdwcuW8fCjiwzRWfJ3jjK4zVr1RSsWyaX5Mff+YcBkcQ==
X-Received: by 2002:a17:907:a2cb:b0:870:7b:94db with SMTP id re11-20020a170907a2cb00b00870007b94dbmr23435891ejc.28.1674332371207;
        Sat, 21 Jan 2023 12:19:31 -0800 (PST)
Received: from localhost.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id ku26-20020a170907789a00b0084d46461852sm17462057ejc.126.2023.01.21.12.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 12:19:30 -0800 (PST)
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
Subject: [PATCH v2 0/2] Add support for Samsung Galaxy S5 (Exynos)
Date:   Sat, 21 Jan 2023 22:19:23 +0200
Message-Id: <20230121201926.46990-1-markuss.broks@gmail.com>
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

