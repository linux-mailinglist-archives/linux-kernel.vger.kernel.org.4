Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E652966216C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbjAIJ0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjAIJ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:26:43 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E67EBE
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:26:42 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so8504583wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 01:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MWvSqhjRDjdOGajMwI2MbXsT3YyWqCAWU/iLLKmUGh0=;
        b=aZUhZeumnG/a5YiUl5oh2vro6tywv9/wTzDqxGjC7ZWgZxBX9ACQOoPQ4T7l9dFDd3
         Zy8HEjc1ykRWUs8KEGyGrgoDZJd28FotIx7IQUWEEF5pmym3SgFRozT6v22LStJKiPLz
         u3zMoh9iBX59UdYDGE8NPJNdpP32+b1pSjm4mFgndQFAKGNueDiXS4isFot8GNn+pBhO
         yKOKvRlXmWz/BlAU2N8MQkk3GpKU20Jvph6PAlgpEZfvc8rlwaIxORwlGBOHefeh7QfX
         PVPb1KeWKfv5iAHVLdgZOro2ilk/b0FMTJBhivpqo1KbpGo9VzBK2FJ8ND8BIaheE39S
         awDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWvSqhjRDjdOGajMwI2MbXsT3YyWqCAWU/iLLKmUGh0=;
        b=1QhVkLmrUSCvgHpkqx0gQPSahuaYLfvk2IFi+QUyTDrBBZSmUwbU0x63JBVEPiwdDj
         XLMrGI1HHaPNM8Nfj3cPcEHZhck5pb29ONakNn6rS0mTzy2ffHyZ2ErKNG42uZDm4/DG
         SETUvCJkmIOPrdCsr4ltDhWZcsxH9BKZx9yDMHusEqzf1PYoj7zPRjYzNCwPtdmvbcJT
         svU/j8xhKAkJVQhiUxcoYhflWT5EQ2V+SIggMehoiXE9Hni/DPOGZ5IV7q+zHnC8MAXz
         KmzBOyhY/2zEI4r4lbLV8jxcynjlnX5+QVJaImivqBrWHp9wywe/MMEYKKGQykjmot5t
         1WTA==
X-Gm-Message-State: AFqh2ko9XB/9yaIATychNzhKKqh5raADbpYxOBF5BVjcp7mD3QHvTf7H
        gSfy4xO9D5/6XYDhWbTFjmoZXw==
X-Google-Smtp-Source: AMrXdXs5NwhzuhuWP/h8r1XwoVrRdCWWlr7HPQR961uxYFaxPB6TQ1jo0ypS88EVkdsmREpg8/21Mg==
X-Received: by 2002:a05:600c:1d0e:b0:3cf:7c8b:a7c7 with SMTP id l14-20020a05600c1d0e00b003cf7c8ba7c7mr45328512wms.39.1673256400815;
        Mon, 09 Jan 2023 01:26:40 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id s23-20020a1cf217000000b003d1e3b1624dsm15195758wmc.2.2023.01.09.01.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 01:26:40 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/7] drm/msm: add support for SM8550
Date:   Mon, 09 Jan 2023 10:26:33 +0100
Message-Id: <20230103-topic-sm8550-upstream-mdss-dsi-v2-0-87f1c16d7635@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMndu2MC/42OQQ6CMBBFr0K6dkwpqYIr72FclOkAk0BLOkg0h
 LtbOYHL9xb//U0JJSZRt2JTiVYWjiGDORUKBxd6AvaZldGm0qWuYIkzI8hUW6vhNcuSyE0weRHw
 wlBZdLVDctY0Ko+0Tgja5AIOeSa8xjHLOVHH76P6eGYeWJaYPseJtfzZv3trCRoaRH+lizUd+vv
 IwaV4jqlXz33fvxzCjoriAAAA
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the MDSS/DPU/DSI on the Qualcomm SM8550 platform.

This patchset is based on the SM8450 display support serie at [1].

In order to work, the following patchsets are required:
- PM8550 LDO fix at [2]
- DISPCC driver at [3]

+ the DT changes.

[1] https://lore.kernel.org/all/20221207012231.112059-1-dmitry.baryshkov@linaro.org/
[2] https://lore.kernel.org/all/20230102-topic-sm8550-upstream-fixes-reg-l11b-nldo-v1-1-d97def246338@linaro.org/
[3] https://lore.kernel.org/all/20230103-topic-sm8550-upstream-dispcc-v1-0-81bfcc26b2dc@linaro.org/

To: Rob Clark <robdclark@gmail.com>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sean Paul <sean@poorly.run>
To: David Airlie <airlied@gmail.com>
To: Daniel Vetter <daniel@ffwll.ch>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Jonathan Marek <jonathan@marek.ca>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

---
Changes in v2:
- Rebased on msm-next-lumag & msm-next-lumag-dpu
- Fixed cover letter title to SM8550
- Patch 1: renamed compatible to qcom,sm8550-dsi-phy-4nm 
- Patch 2: split in 2 patches, switch to renamed qcom,sm8550-dsi-phy-4nm
- Patch 3: switch CTL to use CTL_SC7280_MASK, Added Reviewed-by
- Patch 4: Added Reviewed-by
- Patch 5: fixed V5.2 quirk order
- Patch 6: Added Reviewed-by
- Link to v1: https://lore.kernel.org/r/20230103-topic-sm8550-upstream-mdss-dsi-v1-0-9ccd7e652fcd@linaro.org

---
Neil Armstrong (7):
      dt-bindings: display/msm: document the SM8550 DSI PHY
      dt-bindings: display/msm: document DPU on SM8550
      dt-bindings: display/msm: document MDSS on SM8550
      drm/msm/dpu: add support for SM8550
      drm/msm: mdss: add support for SM8550
      drm/msm/dsi: add support for DSI-PHY on SM8550
      drm/msm/dsi: add support for DSI 2.7.0

 .../bindings/display/msm/dsi-phy-7nm.yaml          |   1 +
 .../bindings/display/msm/qcom,sm8550-dpu.yaml      | 134 +++++++++
 .../bindings/display/msm/qcom,sm8550-mdss.yaml     | 331 +++++++++++++++++++++
 drivers/gpu/drm/msm/Kconfig                        |   4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     | 197 ++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
 drivers/gpu/drm/msm/dsi/dsi_cfg.c                  |  16 +
 drivers/gpu/drm/msm/dsi/dsi_cfg.h                  |   1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |   2 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h              |   1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c          |  88 +++++-
 drivers/gpu/drm/msm/msm_mdss.c                     |   2 +
 14 files changed, 765 insertions(+), 16 deletions(-)
---
base-commit: 58372c69004c06773cbe74a05f2c1a4a8b23db9c
change-id: 20230103-topic-sm8550-upstream-mdss-dsi-35ca8acea529

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
