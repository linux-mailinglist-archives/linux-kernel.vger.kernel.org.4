Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FE8652073
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbiLTMgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbiLTMgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:36:40 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EE3D2D5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:36:38 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id o5so11607161wrm.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 04:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YZugwc/t/ZJz6w/djvKK9nUP1aiYFAKi2NzgJ26Xsqc=;
        b=O/D7iMUnkCQJjmK1NOzj8UzCydsf1KMAt58QAorUK0RoBo9wwo+OIQzJr3vE4uEOgF
         0dv9KjJY8MJby4yfNjmrisKRiEv2uIF7EBvADYyUjA+q+XDOieRnz1+TPwRKd/2dPofP
         H6V6SlWi1ig3FmXUICAP2UqsJVdI2aBspfOy/K2sNbgbw0oTVbYVfVA8y6tJ6GbKrdP3
         s6QN5iHR8LEidv0LlZT0n1q/JnekeR2cX5e2GHTGS45sKHjwwdFmVCv94E4hU6JquO2Y
         F9R86zcfgedOe7Rf8WiMCdWw7izU2Ms4rFQoiWpz7Vu9W67gvP2EBlg6lUjHcPYi6W3M
         hNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YZugwc/t/ZJz6w/djvKK9nUP1aiYFAKi2NzgJ26Xsqc=;
        b=3yR7wydUgbaxX0UFk5+SL5zRB93BBZX++zB/MVodzWEfC1jTqntqmA5KriNAOgL1JW
         O8zYn76MaH25pOX1K1b+OXKzzrMrY7Im14RT/nE3mBdBuXkOGZTGWsFIGY4xSRIwBDPh
         Y22LKLMVCWJzumUMchz5mI9ZNeJae2CgEcUu6CSINbcQa3o1x+LU3TFcCU33vm6vQWcD
         TLTnh9PNlSZAAPudy172OX+5zst3XmAQW118a8ehgVwwjPecnhKiOe5emfCYqd3qoqcU
         TRv16Z0MxjthXsvdGlA6IRj42Pd9F53B3P7wHez4ZLw2bQ40XTvEQA/L9zxSORG9I4ao
         kTJQ==
X-Gm-Message-State: ANoB5plSNFf9TmY8IzOI1wkKxVzyuVVxgCguq3AvCE9kiEyLr1eYqxxh
        NEJBmtfUk34lXN18/2j1yfMiIA==
X-Google-Smtp-Source: AA0mqf7iEUd3ZUsc2l/5OvGsGvshsOZUpsxm9RxTXn1RYcv03TDyxEBakFAj0tedvJCg6jhwf5zcgA==
X-Received: by 2002:a5d:6a12:0:b0:242:63de:2f57 with SMTP id m18-20020a5d6a12000000b0024263de2f57mr38944318wru.26.1671539797040;
        Tue, 20 Dec 2022 04:36:37 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id da13-20020a056000408d00b00242257f2672sm12641208wrb.77.2022.12.20.04.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 04:36:36 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org, dianders@chromium.org,
        david@ixit.cz, krzysztof.kozlowski+dt@linaro.org,
        swboyd@chromium.org, konrad.dybcio@somainline.org,
        agross@kernel.org, andersson@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH v5 00/21] mdss-dsi-ctrl binding and dts fixes
Date:   Tue, 20 Dec 2022 12:36:13 +0000
Message-Id: <20221220123634.382970-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V5:
- Adds compat strings to bindings/display/msm/qcom,SoC-mdss.yaml - Dmitry
- Re-orders simple fixes to the start of the series to allow backports - Dmitry 
- VDDA and drop of node-names - Krzysztof
- Deprecates qcom,dsi-ctrl-6g-qcm2290 - Krzysztof, Dmitry
- Expands set of updated files to include new msm8953 - bod
- Converts to agreed compat string qcom,SoC-dsi-ctrl hence
  -              - qcom,mdss-dsi-ctrl-msm8996
  +              - qcom,msm8996-dsi-ctrl
- Adds RB where indicated for the compat strings.
V4:
- Moves the update of the example from patch #5 to patch #4

V3:
- Moves declaration of mdss-dsi-ctrl into compat string declaration
  patch - Krzysztof, Dmitry
- Renames qcm-2290 compat string to agreed compat "qcom,socname-dsi-ctrl"
  Dmirty, Krzysztof
- Adds empty line after if clause in yaml control flow section - Dmirty
- Adds Rb/Ack - Krzysztof, Dmitry, Doug, David
- vdd*
  Looking into this some more, I don't believe vdd, vdda, vddio ought to be
  required properties. Its up to the PCB manufacturer and the panel in-use
  how that panel is powered. Powering the panel is not something that
  even necessarily needs to be done from the dsi-ctrl driver.
  Originally marking vdd* as required in the .txt was an error, its not a
  SoC level dtsi requirement.
- clock-names
  Rather than replicate the clock-name in each if block I listed them with
  a specific description from a similar reference in usb/qcom,dwc3.yaml.
 
https://lore.kernel.org/linux-arm-msm/eb80681f-2e0b-605f-0444-ec65562f74b8@linaro.org/

V2:
https://www.spinics.net/lists/linux-arm-msm/msg116326.html

- Moves the DSI PHY changes to a different later series.
  There are enough dsi-controller-main changes to justify its own
  standalone series.

- The original phy-name binding change given discussion with Rob and
  Krzysztof became its own standalone series that has since been merged.
  https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg403214.html

- Retains the drop of power-domain from yaml as a required property.
  I dug into the available dtsi. The apq8064 doesn't appear to have any
  GDSC which can be attached as a power-domain, which means the
  power-domain requirement is not universal across the various silicon
  versions.

- Adds Dmitry's RB to power-domain drop

- For the clock declarations I've
  * I noticed that the simple change I had worked for msm8939 but
    subsquently broke other dtsi which drove a bigger change to document
    the clocks on a per compatible basis.
  * Added compat strings in yaml.
  * Moved the allOf down later in the file to acomodate the if/then.
  * Number of clocks validated on a per compatible basis
  * The driver code which doesn't care about the number of clocks
    can still operate on the mdss-dsi-ctrl compat but the dts checks will
    validate against the compat string and yaml.

- vdd descriptions
  Took the previous text I missed from the .txt file - Krzysztof, Dmitry
  Adds vdd, vdda and vddio to the required list. This exposes warnings in
  existing dtsi but the previous .txt declared these regulators as
  required. - Krzysztof
 
V1:
This series fixes up a number of dtbs checks which are being flagged adding
in the msm8939 dtsi.


When converting from .txt to .yaml a number of the parameters for the older
msm8916 silicon were not transmitted into the yaml.

Adding in the msm8939 which is a near 1:1 copy of the msm8916 in terms of
dtsi triggers a rake of dtbs checks as a result.

https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg403211.html

Bryan O'Donoghue (21):
  dt-bindings: msm: dsi-controller-main: Fix operating-points-v2
    constraint
  dt-bindings: msm: dsi-controller-main: Fix power-domain constraint
  dt-bindings: msm: dsi-controller-main: Fix description of core clock
  dt-bindings: msm: dsi-controller-main: Add compatible strings for
    every current SoC
  dt-bindings: msm: dsi-controller-main: Deprecate
    qcom,dsi-ctrl-6g-qcm2290 in favour of qcom,qcm2290-dsi-ctrl
  dt-bindings: msm: dsi-controller-main: Document clocks on a per
    compatible basis
  dt-bindings: msm: dsi-controller-main: Fix clock declarations
  dt-bindings: msm: dsi-controller-main: Add vdd* descriptions back in
  dt-bindings: display/msm: Add list of mdss-dsi-ctrl compats
  dt-bindings: display/msm: Update MDSS dsi compat strings
  ARM: dts: qcom: apq8064: add compat qcom,apq8064-dsi-ctrl
  ARM: dts: qcom: msm8974: Add compat qcom,msm8974-dsi-ctrl
  arm64: dts: qcom: msm8916: Add compat qcom,msm8916-dsi-ctrl
  arm64: dts: qcom: msm8953: Add compat qcom,msm8953-dsi-ctrl
  arm64: dts: qcom: msm8996: Add compat qcom,msm8996-dsi-ctrl
  arm64: dts: qcom: sc7180: Add compat qcom,sc7180-dsi-ctrl
  arm64: dts: qcom: sc7280: Add compat qcom,sc7280-dsi-ctrl
  arm64: dts: qcom: sdm630: Add compat qcom,sdm660-dsi-ctrl
  arm64: dts: qcom: sdm660: Add compat qcom,sdm660-dsi-ctrl
  arm64: dts: qcom: sdm845: Add compat qcom,sdm845-dsi-ctrl
  arm64: dts: qcom: sm8250: Add compat qcom,sm8250-dsi-ctrl

 .../display/msm/dsi-controller-main.yaml      | 250 ++++++++++++++++--
 .../bindings/display/msm/qcom,mdss.yaml       |  16 +-
 .../display/msm/qcom,msm8998-mdss.yaml        |   8 +-
 .../display/msm/qcom,sc7180-mdss.yaml         |   6 +-
 .../display/msm/qcom,sc7280-mdss.yaml         |   6 +-
 .../display/msm/qcom,sdm845-mdss.yaml         |   8 +-
 .../display/msm/qcom,sm8250-mdss.yaml         |   8 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi           |   3 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi           |   3 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |   3 +-
 arch/arm64/boot/dts/qcom/msm8953.dtsi         |   4 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |   6 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi          |   3 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |   3 +-
 arch/arm64/boot/dts/qcom/sdm630.dtsi          |   3 +-
 arch/arm64/boot/dts/qcom/sdm660.dtsi          |   3 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   6 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |   6 +-
 18 files changed, 293 insertions(+), 52 deletions(-)

-- 
2.38.1

