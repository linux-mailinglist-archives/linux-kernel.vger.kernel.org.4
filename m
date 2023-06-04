Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59754721526
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 08:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjFDGap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 02:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDGan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 02:30:43 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06905BD;
        Sat,  3 Jun 2023 23:30:42 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-75d44cb20a2so71648585a.3;
        Sat, 03 Jun 2023 23:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685860241; x=1688452241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SbqYJAHskzU5DpmVfI7uhOaA6IbRO1C4pvsLQyJWA6o=;
        b=n4wXNxl+K400gB1Ir/Qmwa1PG4A0CdCHuO3n26/m7JRfeqUYaC6QmPPeFE+sHuy9ER
         3FkmS/JP9ThGJws0SVJl8IZxnjyLtmPPUknFTJvflPMGlbMFws+2TjVRm217Sy9rV8x5
         bP/aBOFOfuZ+d/JWFg33GFlBZKXMFAzCsUS7Tq61FLWbir7XaY8KqwHV3oX3cHyMhsv0
         qQmRoJJvGfFExjXQdLe3rELNFYFPH/97TD0Xcxi23Rgv8xecAlJ71eySA5mvqSD21Om3
         egN8WTiBKBh2FSzGd3iRe/b6RbUH28UYaZ1ii/k/FcC6xW24YZT+rSrdfDU1ji8/uAhM
         9qyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685860241; x=1688452241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SbqYJAHskzU5DpmVfI7uhOaA6IbRO1C4pvsLQyJWA6o=;
        b=Dx0m5HOTRyvE1VeLeSHVwaGzrpRBAhCQU0ZNqBvysWl8C6HPWrP4x4DZHWdO+EUeOl
         zEqq24WD37BjIX5KTVmcAyalKnz2tpz0iy1qSwuxxQnq/CUSSRI/ERsCSgcR4RLEqrMj
         wdmEYrLQpEtdbjKJZ5q5wtzXNHavi/oC4ix8SZC++4aEXluE/bvc8mYPLUeOhLTaKfz2
         j3dsEQTJPemfTpNgs6w9eL+msgupdlloetv41MSkmH++UbkgFFRpLi0OzI8YtnoBg4QW
         gvxOrsuJ/2PUgjCmPWUc/R3cCaUtQSoZoRV0yG62mV/IRxLUv4rs5XNY4YjXSkKUK37q
         JBIw==
X-Gm-Message-State: AC+VfDyVfnmonbjAeRBp50S1UktjAcGbFrobntFRyB0rZeQwgVRHsjnC
        Kz+Th8f6oLE6lKEtfOwc3oONBzSnDzkJ7Q==
X-Google-Smtp-Source: ACHHUZ6IUiD2zJzv9IRX3p+2i7RHR6TC4L//qeKiNXgoHsvBjkZf4Y2adSGmxeR2gcKQg2LBugYnqw==
X-Received: by 2002:ac8:5812:0:b0:3f6:a015:d9d4 with SMTP id g18-20020ac85812000000b003f6a015d9d4mr4419511qtg.65.1685860241025;
        Sat, 03 Jun 2023 23:30:41 -0700 (PDT)
Received: from Latitude-E6420.mynetworksettings.com ([2600:4040:2007:9800:ab78:dd77:aea4:8d1a])
        by smtp.gmail.com with ESMTPSA id e10-20020ac85dca000000b003f018e18c35sm3044163qtx.27.2023.06.03.23.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 23:30:40 -0700 (PDT)
From:   Rudraksha Gupta <guptarud@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org
Cc:     Rudraksha Gupta <guptarud@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/4] Samsung Galaxy Express SGH-I437 Support
Date:   Sun,  4 Jun 2023 02:30:17 -0400
Message-Id: <20230604063032.365775-1-guptarud@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

This patch series adds support for the Samsung Galaxy Express SGH-I437.
Currently the following things work on this phone: UART, eMMC, SD Card, and
USB.

version 3:
- Added Ack
- Fixed compatible in qcom,usb-hs-phy.yaml. `make dt_binding_check dtbs_check`
  no longer complains about USB
- Fixed formatting in qcom-msm8960.dtsi and qcom-msm8960-samsung-expressatt.dts
- Fixed the spi1_default node in qcom-msm8960-samsung-expressatt.dts.
  `make dt_binding_check dtbs_check` no longer complains

version 2:
- Combined patch 1 into patch 4, as the sleep_clk label is specifically needed
  for the USB node.
- Reformatted the commit messages to align with the style used in other commit
  messages that modify the same files.
- Included a cover letter to provide an overview of the patch series.
- Slight refactoring of the device tree source (DTS) file.

Rudraksha Gupta (4):
  dt-bindings: arm: qcom: Add Samsung Galaxy Express
  dt-bindings: phy: qcom,usb-hs-phy: Add compatible
  ARM: dts: qcom: msm8960: Add USB node
  ARM: dts: qcom: Add Samsung Galaxy Express support

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 .../bindings/phy/qcom,usb-hs-phy.yaml         |   5 +-
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/qcom-msm8960-samsung-expressatt.dts   | 331 ++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8960.dtsi           |  34 +-
 5 files changed, 370 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-msm8960-samsung-expressatt.dts

-- 
2.34.1

