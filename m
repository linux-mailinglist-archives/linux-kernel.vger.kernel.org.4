Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3376B9E64
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjCNSbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjCNSbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:31:06 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F42177DB2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:30:54 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l7-20020a05600c1d0700b003eb5e6d906bso10806430wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678818653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=biRoXUfCSoBabbn7G7XULvRIrTxmpZeZ/Vb1VeQ6ge4=;
        b=0+29f8IgQGz4s/l4jb3Jnw7cu19o+AnYx6sN+h0C3houydiWAjujLofs3yYa3XsM1F
         L7ztxbmqoNMhKY4JbrtqM1WcTDKXa5HuGAPqGo3/vCBv7rtAiePZEIDdsRXx2EhDVWAV
         JwDzQHyGX3H+jVh7vngc9p1ovDFXYFxENBGkSbdmhMeVmdgkhENPddsoSgzCn+iICKDR
         JsFyip0agDboWmEhcWQiTl2rTobEG38Xhp6D8jNyIZGdFVOKCPEorNAEqaOXTdux2kH3
         iniP5fh+1nYqCpHxoTWeg3eGmRA7CyByp9fwJYT1hLeDe4xwuRnHLxr7z8dkwDyvjYBd
         gOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678818653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=biRoXUfCSoBabbn7G7XULvRIrTxmpZeZ/Vb1VeQ6ge4=;
        b=O3XGKuNkCGjYezZvMf1UJwadi1AI/QXuo1nCzluCPHAIYAzcRrPoRlfd5Fs2SEBefp
         ON/ZRz7qd0MzzJ7yfdUMrrLVOg0LnsfMpdIBVhAmwQKfJN+GYTTX1/FkdnfJwSt3xmzA
         mkP9V9FGI4g9ivN8NEa4lQxlMWAc0SloiGMnRrCktvEq8nqeKU4zSk/C/04gz8f6mUK5
         moiZSS9A9qm8EE29NExerqVO4AX2S8+h/Iud5LSrD41EKB758fAVoJmQUX0BWD3MzPvW
         Ym3cBn4wItiDJu9sQqEtrIYUBNjwzzevCFXe8/2z3GZdCsFJAANwpYSVUkErM2+lXB2+
         qWnA==
X-Gm-Message-State: AO0yUKV66oqt7/1SP2jTyXbtaFcQ/PiHkNZ0V/Eu5K5LVafpQTJkr5GU
        ApjB2qTA5XzHdYNK0TQwo/BpiA==
X-Google-Smtp-Source: AK7set/SDpfta3UW8p39l4owg58MtFbG/jBYddMbmOgOxxLaQY/v7NBG1bRqrBqRGmKNApHoHdxc9w==
X-Received: by 2002:a05:600c:4448:b0:3dc:1687:9ba2 with SMTP id v8-20020a05600c444800b003dc16879ba2mr15041651wmn.35.1678818653479;
        Tue, 14 Mar 2023 11:30:53 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:fd14:bd52:b53b:d94c])
        by smtp.gmail.com with ESMTPSA id k28-20020a05600c1c9c00b003e209b45f6bsm4083938wms.29.2023.03.14.11.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:30:53 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 00/14] arm64: dts: qcom: sa8775p: add basic PMIC support
Date:   Tue, 14 Mar 2023 19:30:29 +0100
Message-Id: <20230314183043.619997-1-brgl@bgdev.pl>
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

Bartosz Golaszewski (14):
  dt-bindings: interrupt-controller: qcom-pdc: add compatible for
    sa8775p
  arm64: dts: qcom: sa8775p: add the pdc node
  arm64: dts: qcom: sa8775p: add the spmi node
  dt-bindings: mfd: qcom,spmi-pmic: add compatible for pmm8654au
  arm64: dts: qcom: sa8775p: add support for the on-board PMICs
  arm64: dts: qcom: sa8775p-ride: enable PMIC support
  arm64: dts: qcom: sa8775p: add the Power On device node
  arm64: dts: qcom: sa8775p: pmic: add the power key
  arm64: dts: qcom: sa8775p-ride: enable the power key
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
 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi   | 136 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts     |   5 +
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         |  59 ++++++++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c      |   1 +
 7 files changed, 205 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi

-- 
2.37.2

