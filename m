Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8309676915
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 21:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjAUURu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 15:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjAUURs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 15:17:48 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE804233F4;
        Sat, 21 Jan 2023 12:17:27 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qx13so21702556ejb.13;
        Sat, 21 Jan 2023 12:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7G5+S/PVSHz7yMGza3qinD/tbKeLPcUtpFdDTPTxNbI=;
        b=VxJ7Ik8GPbs1ye2ECA5AOlymZWRtIEEIG7jgeDxoUypDk8SMx9YYqLJHs2l+1AVxLM
         vQ/2XyDAFVPVxpLCMOTycJtY8ltke1KUiF16Yy2/s5balT8P4wYPagn42G9T4UP/gKjU
         oZihtaC4WyHXlLGOoTY2YnTPNDRkNpZwass4skjg0wf1L/7QvWDRIWTuKnKoXbqR77WL
         T9X+Bcswdz2cHNicj7xm/+baQDuUdezZAtmeS5GgZ5L13ovSMQJXsA7GW56bHJlbxHKy
         XkWPeEsNCQ6SmSxgSp0oIIsYQKBAcuwxowu8OmldMsg9Zd+w6dZaqpP/3SLK3wnQFnnL
         vtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7G5+S/PVSHz7yMGza3qinD/tbKeLPcUtpFdDTPTxNbI=;
        b=nQ2sxL+gRjA2/6OY31mnKDBZQJSJmV7GipCyneX5vF8VaoPUhLhUugL+Ib2djLgDZB
         nvDc4NYlsrM12+hgMLT1ZAiCXiBnB6H73oY9ZXhDFU4nqyQH/rhwBTtBQE8Ps+PjV2Yf
         4+FTuFxGn23qhusBfECfs45izvq9e34BaWtrkT/aYrcHwUqFOpTrWoys5m0Tp4laUmcI
         yya0RWigw3lzJViC+gjMOdaHCMEL2Q3t1L5ahPS4YCt5OclAqh3JLQMiMWpSx0QOelea
         pVGKNi0VDZkdTEA1fUocX73jvRXjQZqCKSK9OhQfEXDMNDL17PBjBUx5Eh4aWHgprTN7
         L0kg==
X-Gm-Message-State: AFqh2kqj+2IzdNoDPzCbUKCGUGuOqZ8zqEGo8z/Yltco/HFu71wzp4uu
        XR1etnMnACwmROhzwSQBR4DFru9XEJFYLw==
X-Google-Smtp-Source: AMrXdXvyRdLsMPWe22AbB1o9gA0fPAcDGZuK18wjNfx8LPHpHLO0bHR+BnCTCH3tXxEND51vrlgHvw==
X-Received: by 2002:a17:907:6d0e:b0:871:7b6f:9c53 with SMTP id sa14-20020a1709076d0e00b008717b6f9c53mr27025600ejc.30.1674332245826;
        Sat, 21 Jan 2023 12:17:25 -0800 (PST)
Received: from localhost.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id p4-20020a170906614400b008512e1379dbsm16599493ejl.171.2023.01.21.12.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 12:17:25 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 0/2] Add support for Samsung Galaxy S5 (Exynos)
Date:   Sat, 21 Jan 2023 22:17:19 +0200
Message-Id: <20230121201722.46636-1-markuss.broks@gmail.com>
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

