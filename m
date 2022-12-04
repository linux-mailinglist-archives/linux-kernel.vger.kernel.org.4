Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C18C641C44
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 10:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiLDJro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 04:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiLDJrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 04:47:37 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA94AE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 01:47:32 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id p8so14166768lfu.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 01:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=janko4BgJGtkNL8mFckP2GXu+qyT3OukB4Vav5ERFlI=;
        b=TtfIZK00X69U8N7vJ76x9AKxq4Au2EonaQTQS244qskV0JbfPwZWKNum52oRCrHbjN
         F/G7VIwn9c+W4nmwga39MRt3aGUzU35rkNKfyXtIfAoAvauhyT/h0Sxo0gUCf2OrRfju
         623UhVKeej8b10C0sZhM1dTdT2pf6j11GLAtFpKSvKmt1ZLFGJdYHybX+mNaOR+8DcGP
         5LinRJ3wYjR7HOWhMaDoHKI6cYPxzoGsA8Hmlzsl2ij5+o/Uoi9UKtAq2eYeUthkA3Pv
         qWGfK3UacKPbifbDNWz4EqavTdVqcoa0g8i+F/CoXuD8ejbjjiliXW3hRB0WdVBgwoXm
         vYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=janko4BgJGtkNL8mFckP2GXu+qyT3OukB4Vav5ERFlI=;
        b=u1tVDn/KCoryNSxZSiJryEELEzRLgyh/BVwPovKvLUU2pRiX6DcZZ5mI4u2+TT/4z/
         tYTfe+Ae6lpbXG0KJcm2zv1kSLBnJwHEtB+aqwiv7VwlG6xmLt9GpEwrbq/lJ65Xx8bW
         +MBKAuyW/Xw1uKLMYwmGAFimIM1Z3NN72ttrgAtRq/Ytse94v2I3itDtzKzl21Ncs2bs
         3Io7hGDu5fYz/TwVu5Ke+BXi3njL0foYWCDQfI9h0TKXFUxXOqO524fgxWH9sG9kDIwH
         BaaJpFx87oJQ8SB9qccOuXVBHenpjugxL1vNa9f7KBY0JQkWuoSyV9mnIi0VW/QJP3ni
         BZvA==
X-Gm-Message-State: ANoB5pnYvBMXWqkN70wU306hpRHVZc2gTW4JUAIgS4byrzjUmdyO5MWG
        DsAYPsN3/tL2owntW4VG7RwESg==
X-Google-Smtp-Source: AA0mqf70DTCspnTZa1ay9+Qc++Song3setHNd0YTNsFVECp207Nslru7RAQM+uUhDMMRdNdgYgeVHg==
X-Received: by 2002:a05:6512:3983:b0:4b4:f88:90d3 with SMTP id j3-20020a056512398300b004b40f8890d3mr27581895lfu.37.1670147250857;
        Sun, 04 Dec 2022 01:47:30 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e18-20020a056512091200b00498f00420e9sm1706703lft.194.2022.12.04.01.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 01:47:30 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, abel.vesa@linaro.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/5] dt-bindings: mmc: sdhci-msm: drop properties mentioned in common MMC
Date:   Sun,  4 Dec 2022 10:47:16 +0100
Message-Id: <20221204094717.74016-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221204094717.74016-1-krzysztof.kozlowski@linaro.org>
References: <20221204094717.74016-1-krzysztof.kozlowski@linaro.org>
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

There is no need to explicitly list properties already brought by
mmc-controller.yaml schema.

Fixes: 8574adf5222d ("dt-bindings: mmc: sdhci-msm: Fix issues in yaml bindings")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 9e7c0e3803c6..39e303468bc4 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -136,16 +136,6 @@ properties:
     description: A phandle to sdhci power domain node
     maxItems: 1
 
-  mmc-ddr-1_8v: true
-
-  mmc-hs200-1_8v: true
-
-  mmc-hs400-1_8v: true
-
-  bus-width: true
-
-  max-frequency: true
-
   operating-points-v2: true
 
 patternProperties:
-- 
2.34.1

