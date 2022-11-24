Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C301636F38
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 01:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiKXAsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 19:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiKXAs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 19:48:26 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FE0C9ABE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:48:14 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id x5so235920wrt.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eO0tOz0zwXGw3TOZj4ZrnPJ+UUmohAjz6RImQ5MpXA=;
        b=I11XwzaEC+ir6A/K95aGzWsdpEp61vD3pFNkpvU4mVi3BC4N4n7ZvwuyozHApiUigC
         qXzOG86bfe1PGX1/cl9CyC/Oroxv9LNWLw9nz4kTcU4RdoALJdfqlBNlWrBGtTunmba7
         itwgKYDmITMGAwheA1RuaVXoo9kFRhgdbJoNTuki5KNPbEkMyYNaGR1WhWW9/1JQcE2T
         ixXEg7UXqPNPRm1SdRatw5oWwlv9yBlCPCQaRHOlaXlNxFQzT1NExBPKuZOiVWdL6Jvu
         yXTFGau1HwGpckNaTQs1PgbbctMervYDipU/qiPUctDZlLU6+mzRIpZ5B12Sap2chZyF
         HKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eO0tOz0zwXGw3TOZj4ZrnPJ+UUmohAjz6RImQ5MpXA=;
        b=ARZsmY/jJyotfQ2YEEqffN2MstD5xXXk3VbzJyptRFCmKJ6dVsoyhbb6m7TTW3QGF8
         a22jDLXHGReAKOdDXoM7QgXk1PNE/3fQ8ji4pE8SyHHvnkq3F+yQNXGyQ1AUATOaMYwe
         qVzKWDJA7yAJLugq9q28T/O1qyxzdQmNu0KOhLRB4vX/6yazyetd/SvEg2wsGeecqXms
         OiFitEQf201J5e5+dBUP/Zc/oc4YOrW2VThHGpJPPpj/jYFdDwDMx6kwcNWt2OdnWxQc
         mbcvX21Nqhwl27ufdn4N0HC9e8j3Y3cwyws8BseraSlKooi8JxPozH6WcgXC+jMperma
         R/9g==
X-Gm-Message-State: ANoB5pmOXbErIiNO6NIAGHy5hvWB9uRgfFCOjM5P1KQ47YVDbbnSc7w4
        VMCesZWJxYxQf4y5F6BwCkGs9w==
X-Google-Smtp-Source: AA0mqf4yy73QVZpMXWfU9xi9AHxR0nf+n1BO+7UBbflLWuG69yiXRQYNU/eR1741JbBoa77+rdSKkA==
X-Received: by 2002:a5d:69c4:0:b0:236:c206:b2b1 with SMTP id s4-20020a5d69c4000000b00236c206b2b1mr7894471wrw.624.1669250893312;
        Wed, 23 Nov 2022 16:48:13 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n38-20020a05600c3ba600b003c6bbe910fdsm5245076wms.9.2022.11.23.16.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 16:48:12 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org, dianders@chromium.org,
        david@ixit.cz, krzysztof.kozlowski+dt@linaro.org,
        swboyd@chromium.org, konrad.dybcio@somainline.org,
        agross@kernel.org, andersson@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH v3 07/18] dt-bindings: msm: dsi-controller-main: Fix clock declarations
Date:   Thu, 24 Nov 2022 00:47:50 +0000
Message-Id: <20221124004801.361232-8-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221124004801.361232-1-bryan.odonoghue@linaro.org>
References: <20221124004801.361232-1-bryan.odonoghue@linaro.org>
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

When converting from .txt to .yaml dt-binding descriptions we appear to
have missed some of the previous detail on the number and names of
permissible clocks.

Fix this by listing the clock descriptions against the clock names at a
high level.

Fixes: 4dbe55c97741 ("dt-bindings: msm: dsi: add yaml schemas for DSI bindings")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../display/msm/dsi-controller-main.yaml      | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 0c09b9230b7f5..0fbb0c04f4b06 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -36,13 +36,19 @@ properties:
     maxItems: 1
 
   clocks:
-    items:
-      - description: Display byte clock
-      - description: Display byte interface clock
-      - description: Display pixel clock
-      - description: Display core clock
-      - description: Display AHB clock
-      - description: Display AXI clock
+    description: |
+      Several clocks are used, depending on the variant. Typical ones are::
+       - bus:: Display AHB clock.
+       - byte:: Display byte clock.
+       - byte_intf:: Display byte interface clock.
+       - core:: Display core clock.
+       - core_mss:: Core MultiMedia SubSystem clock.
+       - iface:: Display AXI clock.
+       - mdp_core:: MDP Core clock.
+       - mnoc:: MNOC clock
+       - pixel:: Display pixel clock.
+    minItems: 6
+    maxItems: 9
 
   clock-names:
     minItems: 6
-- 
2.38.1

