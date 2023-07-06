Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5270D749C2C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjGFMoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGFMo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:44:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2C326BE;
        Thu,  6 Jul 2023 05:43:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99384a80af7so75643066b.2;
        Thu, 06 Jul 2023 05:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688647430; x=1691239430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VYDnnG7pWiRMK+bq/FaL1Nx3W8B4x4Bv4nmC1xi18oc=;
        b=WU3DExWNLUqZYnkc9V3f7/rFyIuLhFJTUI6iVkpSJtiPCDIRilY9gAoaxfXuj7YxdB
         PMId4qdyX4Fg7rD4WPczrjDXryD8vtXhLafBvdpjzZYVgmZ4Oho0TZk1fLXfyD8OqONc
         FU5MAmCTEtctoM57qKdk6n6Rl4eYJoJhY+S0kJ0jGaqfdcirBLh/h8RoHeOW3dlM0jeM
         i2Z7f3gfPD4aqsXssb1HTeBha6FXNUaG3xtfl0qzTU1dAVssTZo+UEy0Te/+Yydb/P/P
         KsLOyADoajSgQ2d84xOOSJKR2OiLBHMUJObkRqVEZE8/P8hi64iwghK4gLmoUKtCXhkp
         0qWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688647430; x=1691239430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYDnnG7pWiRMK+bq/FaL1Nx3W8B4x4Bv4nmC1xi18oc=;
        b=NFAYHXgeOoWZutxY/FiAWNTGRK0E5oLRMylD0yH/X6+QT5HB/jr/B9SaZK5jvS2H91
         MnxrgHhZXzNZPezpB0TLT3SrT7ftLyePdRBPjP99rOJQbzzGZkoqHUqGnTfX6f8eMAgE
         rqFikvRoOI/iOZMCxmImxpuGRHgqaBj8uZZZ2Zzn7s96jNiMTY31s2zeMyCMzexKj7KG
         tHdMLYuAR5o0xktMPfz9BmXCXn85GNnw8O6TMz+7GhMTSD4PvXuhqg9pMvJxAsP3x7JZ
         3X5ZZ5h7V+esQqoNYA++3ADEJj1O61te0geFbwLc+im8aCzxaZC2pD8ou6MjQ34sFHEU
         cBIg==
X-Gm-Message-State: ABy/qLa8bxvw9wTQuww8OLa55zjRRtjzFUoK5+cJz0zC4nbJNaC8kqM8
        sOdXF4oN4lHh/h0M1FTyPlw=
X-Google-Smtp-Source: APBJJlFJLMBcouDHV83V7fJLXsWaO6PWP1fxv417ufkbm6zxVAmoGb3QorUlneH/dqmW1wEzU5sI/A==
X-Received: by 2002:a17:906:6543:b0:993:a396:ac64 with SMTP id u3-20020a170906654300b00993a396ac64mr1218886ejn.38.1688647430394;
        Thu, 06 Jul 2023 05:43:50 -0700 (PDT)
Received: from david-ryuzu.fritz.box (ipbcc3a9b0.dynamic.kabel-deutschland.de. [188.195.169.176])
        by smtp.googlemail.com with ESMTPSA id w14-20020a170906b18e00b00992ca779f42sm775915ejy.97.2023.07.06.05.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 05:43:49 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH v2 0/7] Add initial support for SM7125 and Xiaomi SM7125 platform
Date:   Thu,  6 Jul 2023 14:40:19 +0200
Message-ID: <20230706124339.134272-1-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
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

This series introduces support for the Qualcomm SM7125 SoC and the
Xiaomi SM7125 platform.

Signed-off-by: David Wronek <davidwronek@gmail.com>
---
Changes in v2:
- Allow qcom,board-id and qcom,msm-id properties
- Use QCOM_SCM_VMID_MSS_MSA definition
- Change initial regulator modes from LPM to HPM
- Move status to the bottom of nodes
- Fix up PM6150 interrupts
- Move clk patch to beginning of series
- Fix up copyright
- Take ownership of all commits with permission
- Link to v1: https://lore.kernel.org/all/20230704163848.169853-2-davidwronek@gmail.com/

---
David Wronek (7):
  clk: qcom: gcc-sc7180: Fix up gcc_sdcc2_apps_clk_src
  dt-bindings: arm: qcom,ids: Add SoC ID for SM7125
  dt-bindings: arm: qcom: Document SM7125 and xiaomi,joyeuse board
  soc: qcom: socinfo: Add SoC ID for SM7125
  arm64: dts: qcom: pm6150: Add resin and rtc nodes
  arm64: dts: qcom: Add SM7125 device tree
  arm64: dts: qcom: Add support for the Xiaomi SM7125 platform

 .../devicetree/bindings/arm/qcom.yaml         |   7 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/pm6150.dtsi          |  15 +
 .../boot/dts/qcom/sm7125-xiaomi-joyeuse.dts   |  16 +
 .../boot/dts/qcom/sm7125-xiaomi-miatoll.dtsi  | 419 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm7125.dtsi          |  16 +
 drivers/clk/qcom/gcc-sc7180.c                 |   1 +
 drivers/soc/qcom/socinfo.c                    |   1 +
 include/dt-bindings/arm/qcom,ids.h            |   1 +
 9 files changed, 477 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm7125-xiaomi-joyeuse.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm7125-xiaomi-miatoll.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sm7125.dtsi

-- 
2.41.0

