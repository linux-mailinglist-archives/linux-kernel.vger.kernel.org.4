Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A52166DE3E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbjAQM4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236848AbjAQM4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:56:05 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B442B298
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:56:04 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so4627635wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 04:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buQY0571VmkhR16u9Ow/0LSNQ/qEjT04dxWSimZ2h3Q=;
        b=xgEsPfsOVcftDjdUJFmKJUC6KpSP8O+LKNlXe0lI5XURt7zsOULBR40aMQNEnK2L0G
         yr+NnXwmdnhjkfcnRX1LNRzLgIMRsAVKD81C1IU/YY16EEnslk1OVyBkFwFiPheo9XTC
         23/GnD3qOn1HrGPt9W44veVmFreIXqyKCIShXIEqoggU8nhdPnQFANYq+qzq00KtRno8
         OjJI3KAS2XJ3ZAE2T73HglQYiHTlRjWz17D9UerVGVGY1Fqx98xHFL4rAojxJJfgZUdv
         wlpE+/14yEckFOqtN8NICkpZs+WojeIUOwFm3f27UfMnCgSPuv5EMEuUQS0HK+KaHjzu
         Xkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buQY0571VmkhR16u9Ow/0LSNQ/qEjT04dxWSimZ2h3Q=;
        b=zyc2/d94SmUiRTbTNRLwEbACDEAGedR+MXT1y+nXWVEqg4naNARBAGC1tt6/bDAkqY
         ieKSnwtJ1qPZ0iQ2bwMbreA2nwz3fbgjgt1nUCHXzaL+/0pDWih6qnOIEqBwbTVIkXMj
         LMaBo4feVLJwnpRdvMFF+PQTkFY1fRafQefUmA0r7mi7T7VVUsZFUTCBg/j1iDVbxMij
         rG5AzYT+kWVbuO/F7VQwYtSJwkDltHIEBO6BPvyBxPLFTrXGUZapDutYc2sKMwI/19ep
         PenmlC8UfQDy9GS2UKuhn5jySZrVKv7rgDW5emb2RRsFju1KKf+AC1arqhGm/26ltO29
         fsFA==
X-Gm-Message-State: AFqh2kqqPTDxyOMbx2L0K0SA9RPBbi9NVrt3zO0nuOXsKBPxC4pD+wYw
        xcZwOpN3b3/3oyfvCjGwhZmkJA==
X-Google-Smtp-Source: AMrXdXtkzS9kUkZ12Af2SW4It0OQMhjBk2A7TqVpLtKoAyJzrclkMqUGVQVXGASewTIiEncYTmkDiQ==
X-Received: by 2002:a05:600c:6001:b0:3da:f80a:5e85 with SMTP id az1-20020a05600c600100b003daf80a5e85mr2950758wmb.26.1673960162694;
        Tue, 17 Jan 2023 04:56:02 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b003c70191f267sm45069778wmo.39.2023.01.17.04.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 04:56:02 -0800 (PST)
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
Subject: [PATCH v3 1/6] dt-bindings: phy: Add QMP UFS PHY comptible for SM8550
Date:   Tue, 17 Jan 2023 14:55:50 +0200
Message-Id: <20230117125555.163087-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230117125555.163087-1-abel.vesa@linaro.org>
References: <20230117125555.163087-1-abel.vesa@linaro.org>
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
index 760791de0869..44745a5c64cd 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - qcom,sc8280xp-qmp-ufs-phy
+      - qcom,sm8550-qmp-ufs-phy
       - qcom,sm6125-qmp-ufs-phy
 
   reg:
-- 
2.34.1

