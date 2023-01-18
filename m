Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3D4672496
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjARRQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjARRQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:16:29 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA68D56EF0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:16:27 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k16so4587897wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SrjBu5Fpu8r9KiRz21MNqiLJXd0GSE9QxTWwpVHeYjA=;
        b=AF1zMqs2PsAQM8v8Vdly76XTO56xVtdU8Azix3cipJmr/fcdeGtOvqb/BwlMB17Uvj
         yWP+fUo/Jfl62mTrUE3s2SEHIBs38TT02edBfxGuLAWfDHPfA5C3sL4PBz3pv1aplhX1
         qu//YRteedXAZh0FobbZG6CBJ6wzKUZQT6N9elZIN4YNE4i7UqdIQIdoSEMaFWb6EYE/
         ATYYs0Q3cA1zq/FHjNiABd3UmzwLSDuAcVtioIaZhfmLbPtx2X1GxkZNe5k/vpmXsC+b
         p1qsDJ5fgIrZ0LF8FSGlx58hsKe6sOKtOa2fi5xT9DRLgR8D4vfsYcAOKGbbM0CV2+/y
         tgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SrjBu5Fpu8r9KiRz21MNqiLJXd0GSE9QxTWwpVHeYjA=;
        b=vSWsWwCdXl+1E/sTiMmJSPvYWv4kgDAMSjDgePmW2WvISMNciNfSFJX6HICclvTtt8
         5dAxWrEw6KHZb81VKzui9VQgFWFGoEJ45ADR7dH2/F+Ibe9fF8TX48Cvyb6KZ/vqUcBY
         30yhrA7ZJZ8g9P2tyJ3wvEl/vMjZEudsj2pJsgFcn9dtVk/LPOlBisIDLHcvua7f8rs3
         HTToxJY6R8Z0rZYzBpOQvkRymd+3P8mNBjFiovos33qyNWz1zsCAtnLVq3y4+u5Z7yLS
         1hLZ1FYCzlUKRUtYiAfcTYjY3aQnjDV9iNXbpWWpdT3U8tF5zo75oVCrdZj3uq9CDSXT
         DYSg==
X-Gm-Message-State: AFqh2kqS7E3WiIiQjyzZcCNDFicV2qdnr6/k7QK8vvTGIp049pOMVr//
        O/dy8+W3ZxCVXZvpie+VfJ/OOw==
X-Google-Smtp-Source: AMrXdXvA0GIgJDNL0yBEDhIinmeYR0AJB2BuZ0VSY/DmyvpskMUNbKPRMRO+ruiPE2I5wUgeuFPHRw==
X-Received: by 2002:a1c:7907:0:b0:3cf:a39f:eb2a with SMTP id l7-20020a1c7907000000b003cfa39feb2amr7305539wme.11.1674062186254;
        Wed, 18 Jan 2023 09:16:26 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c198d00b003cfa81e2eb4sm2772780wmq.38.2023.01.18.09.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 09:16:23 -0800 (PST)
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
Subject: [PATCH v9 0/2] mdss-dsi-ctrl binding and dts fixes
Date:   Wed, 18 Jan 2023 17:16:19 +0000
Message-Id: <20230118171621.102694-1-bryan.odonoghue@linaro.org>
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

V9:
- Adds Rob's RB to #1
- Fixes two check splats - Dmitry

V8:
- Squash first and last patch to fix bisectability

link: https://lore.kernel.org/linux-arm-msm/167388664232.594279.4607492026981202284.robh@kernel.org/T/#u

V7:
- The bulk of the patches for this series have been merged.
  There are still four patches to be pushed/updated.
- Adds clocks for msm8974 - Dmitry
- Adds compat strings for sm8150, sm8350, sm8450, sm8550 - Dmitry
- Changes last patch in series to state - Rob
  compatible:
    contains:
      const: qcom,mdss-dsi-ctrl

link: https://lore.kernel.org/linux-arm-msm/20221223021025.1646636-1-bryan.odonoghue@linaro.org/

V6:
- Squashes a number of patches per Krzysztof's comments on bisectability
- Adds in Acked-by Rob and Krzysztof 

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

Bryan O'Donoghue (2):
  dt-bindings: msm: dsi-controller-main: Add compatible strings for
    every current SoC
  dt-bindings: msm: dsi-controller-main: Document clocks on a per
    compatible basis

 .../display/msm/dsi-controller-main.yaml      | 248 ++++++++++++++++--
 .../bindings/display/msm/qcom,mdss.yaml       |   3 +-
 .../display/msm/qcom,msm8998-mdss.yaml        |   8 +-
 .../display/msm/qcom,sc7180-mdss.yaml         |   6 +-
 .../display/msm/qcom,sc7280-mdss.yaml         |   6 +-
 .../display/msm/qcom,sdm845-mdss.yaml         |   8 +-
 .../display/msm/qcom,sm8150-mdss.yaml         |   8 +-
 .../display/msm/qcom,sm8250-mdss.yaml         |   8 +-
 .../display/msm/qcom,sm8350-mdss.yaml         |   6 +-
 .../display/msm/qcom,sm8450-mdss.yaml         |   8 +-
 10 files changed, 266 insertions(+), 43 deletions(-)

-- 
2.38.1

