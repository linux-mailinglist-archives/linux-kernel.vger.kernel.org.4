Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA91F73C539
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 02:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjFXAlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 20:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjFXAlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 20:41:06 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CFA294B;
        Fri, 23 Jun 2023 17:41:03 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id D454E3F78B;
        Sat, 24 Jun 2023 02:41:00 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
Subject: [PATCH 00/15] drm/msm: Add SM6125 MDSS/DPU hardware and enable
 Sony Xperia 10 II panel
Date:   Sat, 24 Jun 2023 02:40:58 +0200
Message-Id: <20230624-sm6125-dpu-v1-0-1d5a638cebf2@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJs7lmQC/x2NSwqDQBAFryK9ToOOZiS5SnAxn5fYYCYyjSEg3
 t0myyooaidFFSjdm50qvqLyKQbdpaE0h/ICSzYm17q+9W5gffvOXTmvGwfkdPP9CIyRLIhBwbG
 GkmZLyrYsJteKp/z+h8d0HCeH6zvdcQAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>,
        Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring up the SM6125 DPU now that all preliminary series (such as INTF
TE) have been merged (for me to test the hardware properly), and most
other conflicting work (barring ongoing catalog *improvements*) has made
its way in as well or is still being discussed.

The second part of the series complements that by immediately utilizing
this hardware in DT, and even enabling the MDSS/DSI nodes complete with
a 6.0" 1080x2520 panel for Sony's Seine PDX201 (Xperia 10 II).

The last patch ("sm6125-seine: Configure MDSS, DSI and panel") depends
on (an impending v2 of) my Sony panel collection series [1].

[1]: https://lore.kernel.org/linux-arm-msm/20230521-drm-panels-sony-v1-0-541c341d6bee@somainline.org/

---
Marijn Suijten (15):
      arm64: dts: qcom: sm6125: Sort spmi_bus node numerically by reg
      dt-bindings: clock: qcom,dispcc-sm6125: Remove unused GCC_DISP_AHB_CLK
      dt-bindings: clock: qcom,dispcc-sm6125: Require GCC PLL0 DIV clock
      dt-bindings: clock: qcom,dispcc-sm6125: Allow power-domains property
      dt-bindings: display/msm: dsi-controller-main: Document SM6125
      dt-bindings: display/msm: sc7180-dpu: Describe SM6125
      dt-bindings: display/msm: Add SM6125 MDSS
      drm/msm/dpu: Add SM6125 support
      drm/msm/mdss: Add SM6125 support
      dt-bindings: msm: dsi-phy-14nm: Document SM6125 variant
      drm/msm/dsi: Add 14nm phy configuration for SM6125
      arm64: dts: qcom: sm6125: Switch fixed xo_board clock to RPM XO clock
      arm64: dts: qcom: sm6125: Add dispcc node
      arm64: dts: qcom: sm6125: Add display hardware nodes
      arm64: dts: qcom: sm6125-seine: Configure MDSS, DSI and panel

 .../bindings/clock/qcom,dispcc-sm6125.yaml         |  17 +-
 .../bindings/display/msm/dsi-controller-main.yaml  |   2 +
 .../bindings/display/msm/dsi-phy-14nm.yaml         |   1 +
 .../bindings/display/msm/qcom,sc7180-dpu.yaml      |   1 +
 .../bindings/display/msm/qcom,sm6125-mdss.yaml     | 206 +++++++++++++++++
 .../dts/qcom/sm6125-sony-xperia-seine-pdx201.dts   |  59 +++++
 arch/arm64/boot/dts/qcom/sm6125.dtsi               | 244 +++++++++++++++++++--
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_4_sm6125.h | 173 +++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   6 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |   2 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h              |   1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c         |  15 ++
 drivers/gpu/drm/msm/msm_mdss.c                     |   8 +
 15 files changed, 712 insertions(+), 25 deletions(-)
---
base-commit: 8d2be868b42c08290509c60515865f4de24ea704
change-id: 20230624-sm6125-dpu-aedc9637ee7b

Best regards,
-- 
Marijn Suijten <marijn.suijten@somainline.org>

