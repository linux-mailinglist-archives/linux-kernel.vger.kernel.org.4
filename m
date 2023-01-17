Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDB5670CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjAQXH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjAQXHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:07:12 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B30B53FB2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 14:41:59 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id z5so31115867wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 14:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r70HIPPoSUCJDW7BtmV/6Lm1b7r37Y3H9xwbUY6W4Xo=;
        b=sWrmfqJ27JEVuWH0BM6QD9/vCbZOknUOQJfd/fNz1Js8TPqGfsKheapQBjql2tTcHs
         1WYQIt1e6y+S13Wj9k3Df9691P+Cy1uFYLfd1R++0y9VGFbSBCCDGGxdnHhtC71wqL23
         oqyPwVcg9Yu6SXGX/BfJrBRftccHyOY/T8RIFzyh9Dl6fUK5yRO1B4i+vT+tPugI4zOc
         BHKsemhS3tgYT7EITwJ8JbADWjdlSctyCTPtvUMBoQLKKAPFNRw7L6hhq1VwJQhU+ipR
         2uVuceaavI0cvLloEKyFDB8ZxeLttkVXNBANkbgFg/ACzHy4PZWVCA9LUCBQlQgYxwK9
         sySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r70HIPPoSUCJDW7BtmV/6Lm1b7r37Y3H9xwbUY6W4Xo=;
        b=BcB9xvHaoVC1Cxi019SvTVdCnRngVtW0i1G9y/IK4mu8pJdaCm4Oa09RAdHF2F3Pdp
         Td2Y7J28fuZUIf2R3jdE59i7e2cvCtJm3fcuJlce65ViSUAos8UAN9iF9q5++ZXNDZ/M
         LYYzAnchfkr7DHtgSLxhBnGfblo3VHbUFlY+V1q8F9dA1NOYG2ygam90uUIJ5siGDlGR
         tbuZXqkVtiNo6k5JJkyoShkKGnuslntv8Hy5nCprbR7j0eijf0jA+m+vHJ1vN4BbthuN
         4h3JubzyuG9Kgt5rzOsW2iItXop9auUxnsL70gwqsV2bVhIksoaPcvHrm2DG9Z2N3e5x
         ST6g==
X-Gm-Message-State: AFqh2kpUlgUsUrAhm08BALQYmT5My7p3A1tkLEaxhhmnCq5DEyN/X7Cj
        u+Cmq9tPtPg7Z1JM3ZXNzuzWwQ==
X-Google-Smtp-Source: AMrXdXucCp+E/4eIszaPq+GEjiHcs0MuUiEJXTo2i+kwCrqT4EvbEoigyglefocCMvD0vkynn1SgqQ==
X-Received: by 2002:a5d:570b:0:b0:277:2e27:61e7 with SMTP id a11-20020a5d570b000000b002772e2761e7mr4292022wrv.17.1673995315665;
        Tue, 17 Jan 2023 14:41:55 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id m1-20020a5d6241000000b002bbdaf21744sm27024916wrv.113.2023.01.17.14.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 14:41:55 -0800 (PST)
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
        Johan Hovold <johan@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/6] dt-bindings: phy: Add QMP UFS PHY comptible for SM8550
Date:   Wed, 18 Jan 2023 00:41:43 +0200
Message-Id: <20230117224148.1914627-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230117224148.1914627-1-abel.vesa@linaro.org>
References: <20230117224148.1914627-1-abel.vesa@linaro.org>
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

Document the QMP UFS PHY compatible for SM8550.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
index 760791de0869..64ed331880f6 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
@@ -18,6 +18,7 @@ properties:
     enum:
       - qcom,sc8280xp-qmp-ufs-phy
       - qcom,sm6125-qmp-ufs-phy
+      - qcom,sm8550-qmp-ufs-phy
 
   reg:
     maxItems: 1
-- 
2.34.1

