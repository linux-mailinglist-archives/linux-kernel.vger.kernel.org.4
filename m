Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582C56C1A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjCTP5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjCTP5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:57:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA5A3B22A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:48:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l27so2501158wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1679327331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tWjazqOLlYGDzjTqrRkMP7kRAts7dnn/Yh7ecc/9Lj0=;
        b=dN+GGAvYV5hDPt7YWV0h9AriUvWQwB6ZGPfj3n7P9th9ZSafdGN10WTjoJciikeG0C
         o/aBJEwVjJWxOm7RKge+aeN8mFtJfXb0Lc3VZzaTER5lwXAW1YTBzbUReAp8/FxFI936
         Xz4gGMVr8u5QDoSSH+kAF1E7iLjluC3/XCR2UisTuDjJvWUtwwbdoZMBQcLdxVR6iXQD
         8qEs4jXXPaau9xrcwCceyF8bzz56Deo13vvMKatwzu1RhYfOFBaE77ijSjf7akd/L5sw
         SoZ12TuckKRbVaMs19yAFDv9ZX88bsmlDvRdRzh/tdjvS+lCe+N4V9FPIZsNf8qsdQ6U
         0IoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679327331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tWjazqOLlYGDzjTqrRkMP7kRAts7dnn/Yh7ecc/9Lj0=;
        b=gBudWmNUKOaFzyegm1hvDE7W8IpFGUkl/UJ6TkTeoxCGqAy2e2aX2taf+XJHRdNYaq
         o/oyZYvAQZ6NNriJRpdVDrp2s0qoXJS1u4DhHBWraBPff4KdagWQ8smkRxi3tRDHs/wj
         bT4Xp7ikiOFfmRTpCTjZhpLCkWKfRU3S8zlujXAlirZ2jQop/DnfhFlPcBg4WmTtcse5
         js5D7xpIWD9Mq6Cp/L5mp3BsHu6+rSltGfBdzZUfFhgSWsLevPtE1zi8QJBqENAmarYF
         DDiI0GvxS+xYUsxci6Bz0UQP6nqeCUxaruZkKMix0w6QE/P0ZBBYtdgd3w+sYdfApwri
         TXCg==
X-Gm-Message-State: AO0yUKUOqkfd1oTlyhbqNaLDWapjAv52L9QVAtp+3c7MJcC4krFwnHgB
        wl5K8EX35VGGDqutEDrYzk4q+Q==
X-Google-Smtp-Source: AK7set+hFMpIJOxf6sMzO3nG/+O9/CrgrwaDUf0HMQmKAadnn0TX7IZB1y9WL6Z/4ohCAPlO3vsZ5A==
X-Received: by 2002:a5d:468c:0:b0:2ce:ac31:54fb with SMTP id u12-20020a5d468c000000b002ceac3154fbmr13481212wrq.33.1679327330851;
        Mon, 20 Mar 2023 08:48:50 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d7d9:4f38:38b4:82b4])
        by smtp.gmail.com with ESMTPSA id o6-20020adfeac6000000b002c71a32394dsm9202578wrn.64.2023.03.20.08.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 08:48:50 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 00/15] arm64: dts: qcom: sa8775p: add basic PMIC support
Date:   Mon, 20 Mar 2023 16:48:26 +0100
Message-Id: <20230320154841.327908-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This adds support for a number of PMIC functionalities on sa8775p. The PMIC
used on the reference board is pm8654au which is another variant of the SPMI
PMIC from Qualcomm. This series doesn't yet add regulators as these will be
added separately together with upcoming users (UFS, USB, etc.). The RTC
doesn't allow setting time and needs to be used in conjunction with SDAM
the support for which will also be added separately.

This series technically doesn't depend on [1] but it comes after it in my
integration tree and as it's already reviewed and ready to be picked up, I'm
making this one depend on it in terms of patch application to avoid future
merge conflicts.

[1] https://lore.kernel.org/linux-arm-msm/20230309103752.173541-1-brgl@bgdev.pl/

v1 -> v2:
- improve DT coding style where needed
- don't disable the power button in PMIC's .dtsi
- add debounce time for pwrkey and resin inputs
- use the official PMIC's name in DT labels
- add reg-names property for the PON node
- add patches that tidy up the dtsi before the PMIC stuff

Bartosz Golaszewski (15):
  arm64: dts: qcom: sa8775p: pad reg properties to 8 digits
  arm64: dts: qcom: sa8775p: sort soc nodes by reg property
  dt-bindings: interrupt-controller: qcom-pdc: add compatible for
    sa8775p
  arm64: dts: qcom: sa8775p: add the pdc node
  arm64: dts: qcom: sa8775p: add the spmi node
  dt-bindings: mfd: qcom,spmi-pmic: add compatible for pmm8654au
  arm64: dts: qcom: sa8775p: add support for the on-board PMICs
  arm64: dts: qcom: sa8775p-ride: enable PMIC support
  arm64: dts: qcom: sa8775p: add the Power On device node
  arm64: dts: qcom: sa8775p: pmic: add the power key
  arm64: dts: qcom: sa8775p: pmic: add support for the pmm8654 RESIN
    input
  arm64: dts: qcom: sa8775p: pmic: add thermal zones
  dt-bindings: pinctrl: qcom,pmic-gpio: add compatible for
    pmm8654au-gpio
  pinctrl: qcom: spmi-gpio: add support for pmm8654au-gpio
  arm64: dts: qcom: sa8775p: add PMIC GPIO controller nodes

 .../interrupt-controller/qcom,pdc.yaml        |   1 +
 .../bindings/mfd/qcom,spmi-pmic.yaml          |   1 +
 .../bindings/pinctrl/qcom,pmic-gpio.yaml      |   2 +
 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi   | 137 ++++++
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts     |   1 +
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 459 ++++++++++--------
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c      |   1 +
 7 files changed, 404 insertions(+), 198 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi

-- 
2.37.2

