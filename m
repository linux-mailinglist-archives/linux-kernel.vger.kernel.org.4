Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387E0686A90
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjBAPnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjBAPnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:43:33 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2EB47ECD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:43:30 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id bk16so17700319wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVHw9v0pXQ6R2l7L/ywJP0jDdDW7tCjuR1IC/AfCQUo=;
        b=zVmBSXytm14PHNgLXnLeq9lKld2GcQqOrfiRoFGShVTQR0YFqsgc1OwCwM5/kNIa5e
         SzdPe30qovmpuw6ENB4PRa+JJZxWI+FJl8G06tlFeiTYT7ERvBpPWLygebHI9nvNXv3b
         hJH/45P0iGpmWwZPvak7pIudtr2Ew3yanC3KW1lpSRY6r6843cLHQAF66CPt2YVTW+ej
         Tsa6aDilRko1beWBsRRWsdl6QADlcO7T0/mhS+dNXnej+fI16iAA3d69zrDyLAaJshx5
         hSgyS5MiAePupoVs8Prvf2wyJUKlIYxkiLopH6fP/QTyVyV3X9Z1BClVzPbPFltBXwwy
         oAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVHw9v0pXQ6R2l7L/ywJP0jDdDW7tCjuR1IC/AfCQUo=;
        b=lXoGaSCiKaAx8kED+6LcWqzphpVVjX7MyPtjfD64tIZYuFUjNVi5qz4iy33quD2hxq
         HP+dkbMaRiCCNwX5JxwMamGDpXMsHwvSkdmvAwMqB53NSPU+4QgIbI070uI7DqtHTRSM
         5Mahj2+Su72uA9lQWQsiaFpMlvXn6BQ6wlYswRSizzml6dZkqmGfUN/TEUVTGAth+pJR
         igtNWBB/8vSGWn4IM+qdlJ/OyIPxDHQudlQHPQCgCteCzitVTDDAz6xYIR2mMh/xXMC+
         4Zl2brSqDt2flDVCq6h9CJkiVEOqpm0jsqlJAWnRG8m3ct0fZ2umMdnS6JnfYk2B5wvM
         v7Pw==
X-Gm-Message-State: AO0yUKW6r0HCwV2pnCTdPOKIBfLVEa6OiwX2UdKWg9GDOop8e+BMfHR9
        qhK1MyUGAZZ/no6OwzcnsaqcSQ==
X-Google-Smtp-Source: AK7set8EWDsKhlyO++K9kQHaMrRc/G96gFxbwgCfGoe/0B8dA5vQYKGbnttoDr25HOxCFejOnNybhg==
X-Received: by 2002:a05:6000:1f0f:b0:2bf:94ea:67ca with SMTP id bv15-20020a0560001f0f00b002bf94ea67camr2935761wrb.25.1675266208846;
        Wed, 01 Feb 2023 07:43:28 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d598f000000b002bdff778d87sm19374487wri.34.2023.02.01.07.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:43:28 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] dt-bindings: pinctrl: qcom,sm8350: add input-disable
Date:   Wed,  1 Feb 2023 16:43:21 +0100
Message-Id: <20230201154321.276419-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230201154321.276419-1-krzysztof.kozlowski@linaro.org>
References: <20230201154321.276419-1-krzysztof.kozlowski@linaro.org>
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

The SM8350 HDK8350 board uses input-disable property, so allow it:

  sm8350-hdk.dtb: pinctrl@f100000: lt9611-state: 'oneOf' conditional failed, one must be fixed:
    ...
    'input-disable' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml
index 49a74f351e99..e13d50d6d388 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml
@@ -109,6 +109,7 @@ $defs:
       bias-pull-down: true
       bias-pull-up: true
       drive-strength: true
+      input-disable: true
       input-enable: true
       output-high: true
       output-low: true
-- 
2.34.1

