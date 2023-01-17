Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA2666E043
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjAQOUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjAQOUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:20:33 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE63C3C294
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:20:32 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so4816300wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r70HIPPoSUCJDW7BtmV/6Lm1b7r37Y3H9xwbUY6W4Xo=;
        b=uRRabZd19roB+Ol4p25HXFYM9ypkBiyoXdUJADadlr6OfWgI31cbSLM81p/bduBPLG
         HmlnS1wNdz2KHXDCqNmsCB0Go9MDZIwvp1llUhAvtf1WgFqDt66kfw3MN14YXZlk9oD+
         H49MviBNnhLyIcO7ljKQIJKzJqZvaaWY24lgutszKLNkeWHljrOMrRAGHF+og6mcnJ8y
         8pbt/IQ6KM9lfbDEMMNNiCAkchcmbq8jKCT78KquAJpXDb9zS1qKf30qmKEZB8SyMAB5
         tP1jgw0EBUYZGjtyogxGUZGwX8YZQaL4zLNpz2xCaFFD10j6iYEdw5FKKr0in9nKQ24c
         7wGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r70HIPPoSUCJDW7BtmV/6Lm1b7r37Y3H9xwbUY6W4Xo=;
        b=A2N9xoRPIt9eElyQR89popLTFyjIHfS9HUVU7GrHCP6B2fZyp+vN7rzGcq3LOmoo7V
         EZftodZ02v8QBZQLd50iXIQeVDp9JJg+fDBIibLmJjcQead0FVRaZkTcWKGXs1Z/UbmN
         0fu2X6Amz8dtvnTQZ7PuITbiRJCiBdgJLQTnu4Fy1tgqkLg1ODSTnsQqyHwIKu9hDTHg
         p2v9WyT77lYUN17bzbnzx5XHqCPnSbX2gX99W0AaheOQb9BDEEbdH6FetZqVum7dELR6
         rzbxF0Qb1bAVRmQOLxuc00E0uIq3nV+XT+o6/Gps4YU3SlHYHuV0kmEz1NdJBpRacjwq
         9qeg==
X-Gm-Message-State: AFqh2kr+V2+5vHQMpMoxocT2JQYKlJrgS6rpKCmaNJBHI80/VVNnlWb1
        zTSldb46keo1ux0zWyp5bSjeOw==
X-Google-Smtp-Source: AMrXdXsAllzHCawsRFdiyLfn7UCdizc4IAPDTAwzUNxLeYtqmbUsSPokyJ4aOzCfJQQcLAX2fcBYbQ==
X-Received: by 2002:a05:600c:331d:b0:3d6:ecc4:6279 with SMTP id q29-20020a05600c331d00b003d6ecc46279mr11932841wmp.27.1673965231276;
        Tue, 17 Jan 2023 06:20:31 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id i8-20020a05600c354800b003cf894dbc4fsm40443133wmq.25.2023.01.17.06.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 06:20:30 -0800 (PST)
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
Subject: [PATCH v4 1/6] dt-bindings: phy: Add QMP UFS PHY comptible for SM8550
Date:   Tue, 17 Jan 2023 16:20:10 +0200
Message-Id: <20230117142015.509675-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230117142015.509675-1-abel.vesa@linaro.org>
References: <20230117142015.509675-1-abel.vesa@linaro.org>
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

