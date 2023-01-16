Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F8A66BD07
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjAPLlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjAPLlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:41:07 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5053310CB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:41:05 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id s25so29723989lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bAzr3WbepHH/Xzw3XY7+Qyd2EYJHyzok2hFrIPSgsi8=;
        b=W3zFXG1CifPHncC3axUe9wXlorA4Z55HvPebPUfGeJXpgJbQG8XOEJ2h45A4eVBHip
         0x3+QEX/JBeZ+DrmbqnDk/x3ml+kmr6FtH3LaOmTW33IWrqGzAiglQPnb+Yie7+nKhoN
         6fEiQyWktJLR+nOFWggMUDK7agb2Xl71a62ZqaR1iCrgB2bS/3FLRHYFzDTIhwNE7z3z
         YTcO/GJihhOH8sFe7/4I1opzLrgzykmByosB9J5fGr2Zv4JWr88NVN+OulPziFYGFNMj
         izYkzknOqcKf2bSeEJx7EH5rewbX6ildpqYws+7JXUsPvCVobu0WGNJo6mAOawsWE4nN
         ArnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bAzr3WbepHH/Xzw3XY7+Qyd2EYJHyzok2hFrIPSgsi8=;
        b=QHceNb3Wu/vAMKyemTAkkGIgjvrlCcrhBpdpkWMPtc3lvEaygr90Day8ZkEG2W7YXa
         tEJ33D6xI1iGjnQ61V2nVdGR56/fg4DIxL9YGQCULYf+7PG+qSIEMjU11XO6S0flPON2
         AnkCC7x8YDGyo53XQOdjxDSnvLdcq1eWZ0qwzJJh3YhDum5R4DPbodo9J5qZjz/0+iAf
         LDNBgFq1ZVkVLI+VTeKjpdeo6gFKJ/oWuMer6wZTBr0Hc4hA7akAVN43AFAzY5NFiyDn
         M9KY2yLKCiJmK/3RdzDGZlYXhD7NbXYbRpvFAfYY7W9c2bD29mtdMTWgttIZ9AA2MaQe
         dLBw==
X-Gm-Message-State: AFqh2kouJhIFLWILyGMvymlOaLJtVx9Ylt9h+S4wdVIbrirO32xkk6Ex
        IFMdtBwWBI+kGdRu+2eGRtjUOQ==
X-Google-Smtp-Source: AMrXdXuyo8z+lpPJjrE3F6tFchQ8Fr0hXF7Q1C6orut7naGETw7CiURB4lbO1OBvqDWT2nI+dH35AA==
X-Received: by 2002:a05:651c:1992:b0:27f:b2cf:85a0 with SMTP id bx18-20020a05651c199200b0027fb2cf85a0mr28139431ljb.43.1673869263688;
        Mon, 16 Jan 2023 03:41:03 -0800 (PST)
Received: from localhost.localdomain (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id k10-20020a05651c10aa00b0027fb9e64bd0sm918946ljn.86.2023.01.16.03.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 03:41:03 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: display/msm: Add SM6375 DSI PHY
Date:   Mon, 16 Jan 2023 12:40:58 +0100
Message-Id: <20230116114059.346327-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM6375 has a single 7nm DSI PHY. Document it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
index 78ab8c410ccd..9c9184f94c44 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
@@ -18,6 +18,7 @@ properties:
       - qcom,dsi-phy-7nm
       - qcom,dsi-phy-7nm-8150
       - qcom,sc7280-dsi-phy-7nm
+      - qcom,sm6375-dsi-phy-7nm
       - qcom,sm8350-dsi-phy-5nm
       - qcom,sm8450-dsi-phy-5nm
       - qcom,sm8550-dsi-phy-4nm
-- 
2.39.0

