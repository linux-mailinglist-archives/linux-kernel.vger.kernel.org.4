Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F24F629A44
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiKONbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiKONbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:31:12 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7357E58
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:31:11 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id f7so21860984edc.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IiZNPefqWsmH3ZBwLzJSiNW009NxhDiT7gHxpkwTECI=;
        b=kyMm9dzGTmkggekSl/fhsLsfuT8amxXO4nXvV3egvBQEdesRVsaWe8PtW5bKNQvtKm
         utNBsudX6+R6JDFrkZCybji7HWB8/tc0MHD87PCqLk/h61ijC7HJKGcEUxmay3sa+cYN
         n94o9hzrHBxHETnHy879umkzFz+aBDQ65gsP1w5ULcp+P5IiRCbdmVbWrUxNK3iRD32S
         6uNLZKvcQrqOEVOeaE7cs7wef+HXgW67h6WfduQWqzK82mpvdy8OqN6K6sDOg7qc+SJc
         DqNz44GQIefFBkAF8dFb6LiNt/u33l9YxlUbqzQcClLerQrklw8+wJYBbuot3F+kcjwS
         Y+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IiZNPefqWsmH3ZBwLzJSiNW009NxhDiT7gHxpkwTECI=;
        b=vJcVIm8+9/s6YOwGaS71pcXg/8Zt+n6MkVV8FT98dEXdxDD5v1YKO2luL6STrNbLxo
         fwwzRMmEo3yPrXcR4RWYEs4IRcjoO9tv4K+fhGAhjh2CU/9VhT8mSfUUTE87R0Y1kdJS
         I1KwZOGOp2vnE6Lnu1hsonHpa60weurNGq9GkUgAiYS4YssCnLHWY9C9YIje8v53ZPHM
         OVvzqkIZdHKx+soRj+w6IGjzxyvn47dN1VmcTL2aJovHKDg5VnaIardAOi8pTX4EZpaN
         oq0nWQHwjxgwPcPhEl5kpAPPF/APRlyShKG2/eN3yct/EuX8ZFtVVvdnGpMwGwBv01+m
         jOXQ==
X-Gm-Message-State: ANoB5pnpnjJMWtJ8FTUe/n5jHDSR3IVYO7qf84jVBjptC6pyRSTzqUas
        sd8shXd1j41wGKBB6cTfNHHXgA==
X-Google-Smtp-Source: AA0mqf4dpx4w6x/phoewqJ5Ke40pRyOHvvagLP/cl7aCR6H+XDSla2FPNOiX4W017H1HCmTjVHDr0A==
X-Received: by 2002:a05:6402:f19:b0:461:a1c1:b667 with SMTP id i25-20020a0564020f1900b00461a1c1b667mr15330299eda.191.1668519070263;
        Tue, 15 Nov 2022 05:31:10 -0800 (PST)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id q22-20020aa7d456000000b004618f2127d2sm6162176edr.57.2022.11.15.05.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 05:31:09 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        quic_kalyant@quicinc.com, swboyd@chromium.org,
        robert.foss@linaro.org, angelogioacchino.delregno@somainline.org,
        loic.poulain@linaro.org, quic_khsieh@quicinc.com,
        quic_vpolimer@quicinc.com, vkoul@kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        vinod.koul@linaro.org, quic_jesszhan@quicinc.com,
        andersson@kernel.org
Subject: [PATCH v2 00/12] Enable Display for SM8350
Date:   Tue, 15 Nov 2022 14:30:53 +0100
Message-Id: <20221115133105.980877-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dependencies:
https://lore.kernel.org/all/20221102231309.583587-1-dmitry.baryshkov@linaro.org/
https://lore.kernel.org/all/20221024164225.3236654-1-dmitry.baryshkov@linaro.org/
https://lore.kernel.org/all/20221104130324.1024242-5-dmitry.baryshkov@linaro.org/

Branch:
https://git.linaro.org/people/robert.foss/linux.git/log/?h=sm8350_dsi_v2

This series implements display support for SM8350 and
enables HDMI output for the SM8350-HDK platform.


Changes from v1:
 - Added R-b tags from v1
 - Added qcom,sm8350-dpu binding patch
 - Added qcom,sm8350-mdss binding patch
 - Corrected sm8350.dtsi according to new dpu/mdss bindings
 - Bjorn: Removed regulator-always-on property from lt9611_1v2 regulator
 - Bjorn: Moved lt9611 pinctl pins into a common node
 - Bjorn/Krzysztof: Moved status property to last in node
 - Krzysztof: Changed hdmi-out to hdmi-connector
 - Krzysztof: Fixed regulator node name
 - Krzysztof: Changed &mdss to status=disabled as default
 - Krzysztof: Changed &mdss_mdp node name to display-controller
 - Krzysztof: Fixed opp-table node name
 - Krzysztof: Fixed phy node name
 - Dmitry: Split commit containing dpu & mdss compatibles string
 - Dmitry: Added msm_mdss_enable case
 - Dmitry: Fixed dpu ctl features
 


Robert Foss (12):
  dt-bindings: display: msm: Add qcom,sm8350-dpu binding
  dt-bindings: display: msm: Add qcom,sm8350-mdss binding
  drm/msm/dpu: Refactor sc7280_pp location
  drm/msm/dpu: Add SM8350 to hw catalog
  drm/msm/dpu: Add support for SM8350
  drm/msm: Add support for SM8350
  arm64: dts: qcom: sm8350: Add &tlmm gpio-line-names
  arm64: dts: qcom: sm8350: Remove mmxc power-domain-name
  arm64: dts: qcom: sm8350: Use 2 interconnect cells
  arm64: dts: qcom: sm8350: Add display system nodes
  arm64: dts: qcom: sm8350-hdk: Enable display & dsi nodes
  arm64: dts: qcom: sm8350-hdk: Enable lt9611uxc dsi-hdmi bridge

 .../bindings/display/msm/qcom,sm8350-dpu.yaml | 120 +++++++
 .../display/msm/qcom,sm8350-mdss.yaml         | 240 +++++++++++++
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts       | 332 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8350.dtsi          | 226 +++++++++++-
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 210 ++++++++++-
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |   1 +
 drivers/gpu/drm/msm/msm_mdss.c                |   4 +
 8 files changed, 1108 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm8350-dpu.yaml
 create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml

-- 
2.34.1

