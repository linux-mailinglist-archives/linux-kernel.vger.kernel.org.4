Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF0A670F69
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjARBF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjARBE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:04:27 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE845D7C4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:53:34 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r2so32398606wrv.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DalCKvROcpvlYWdSE2CkbjgOeJTZvI5I/bYR1P95SZg=;
        b=lUy8laUTabeuWhRq2uq0HYvvuYEBOkaYXm8HogYtOXuPPzS0T/YzhoTC+DvdLMMw2l
         EEP+jpndhZDQTM3a9V1v/yuSBEOv/LPxTVZ6y+YaS+2rhu//XZ00LFVZ/k5kAG0hDKcT
         aDQ/RVGfN0pkQuwNcgFtwhaJeT6hI9rmJwDsO4L2DyMgBc2kXbl4YCXbj7ppZCS8F1re
         BHm3N3X+Exm51/XBS7i2HWcd1rvK8fxP6qO8uoUNnta5gxbRbE5U94HtAhqxaa2TRVoX
         tknIWml9JlaauvLJtJ/+BC+3rb0vavvjYiLs/P8AdtLktOOg35CRq6AixXn2f1OKcneg
         UByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DalCKvROcpvlYWdSE2CkbjgOeJTZvI5I/bYR1P95SZg=;
        b=Wjh3KkiphI/+4HlVd3D04BIgHRfs7THtaZzpwRxGBo2h8m81VKQMy2Q3H10xrxrIIh
         mKOsu2U/rGw4bUt+VYm/F2yL+KM7YYvSd6tHTQsq+t4NN5H0EavAaop0igBoqWyL+V39
         C0z5uH5To5A4Vag7kR3whZ1dNH3VDJyHbCyrY3GWXuQYYJB0ZaxcqSSS2UXKDNdPgpMR
         6CWRuMUf1hWvs7trpkHJc2Z/NolezwAIOFQRZVrceq9XS+F4BNhhAm6Tj6UA9YkIUtHq
         A8t1eT0jmbjuQFmjRXXEPkWa92lAHN7vE5antF1DREjEzhV6/tq4fIqdQtLVN8Klobfv
         H1rw==
X-Gm-Message-State: AFqh2kqAP2bNLwe2vJGh5oNQETv1aeIIO6JULmsvF8cAtpehM4WZ66d3
        T22eVlm6u4mTLWpl31aE832Evw==
X-Google-Smtp-Source: AMrXdXsa6fqwlhsBt+oOnfgrFCzuV/PxFrYKxo8v/+NPuvbW95EznmuuPfTvqILwrCLL0czmP4PbVQ==
X-Received: by 2002:a5d:63cd:0:b0:273:6845:68ef with SMTP id c13-20020a5d63cd000000b00273684568efmr4076091wrw.60.1674003212740;
        Tue, 17 Jan 2023 16:53:32 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600001d100b00241d21d4652sm29609705wrx.21.2023.01.17.16.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 16:53:32 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v3 1/8] dt-bindings: phy: Add QMP PCIe PHY comptible for SM8550
Date:   Wed, 18 Jan 2023 02:53:21 +0200
Message-Id: <20230118005328.2378792-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118005328.2378792-1-abel.vesa@linaro.org>
References: <20230118005328.2378792-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the QMP PCIe PHY compatible for SM8550.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 8a85318d9c92..65f26cfff3fb 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -20,6 +20,8 @@ properties:
       - qcom,sc8280xp-qmp-gen3x2-pcie-phy
       - qcom,sc8280xp-qmp-gen3x4-pcie-phy
       - qcom,sm8350-qmp-gen3x1-pcie-phy
+      - qcom,sm8550-qmp-gen3x2-pcie-phy
+      - qcom,sm8550-qmp-gen4x2-pcie-phy
 
   reg:
     minItems: 1
-- 
2.34.1

