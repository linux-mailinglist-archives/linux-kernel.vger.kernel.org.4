Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227D6638A04
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiKYMhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiKYMgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:36:54 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66134A9E7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:36:51 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id g12so6547882wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eO0tOz0zwXGw3TOZj4ZrnPJ+UUmohAjz6RImQ5MpXA=;
        b=rw7OkFYVSgqoQVPYbmo07GPVDQZXbOZfklzf0iuA1pLB5kn87Z0aRfgz1vNm1AUXcw
         Hn9bRVntNUaM/efzL7ltG91jGkxVMd5y/63GyTRSjJeC5V1gFDQriYOujPczG0WgHrfo
         Lceqv6BqJXrBd8NzsZFO9LpVq4TyOJ2A8cGjHtv1tirsP99H+6aN1k0V4SuBYmlSEwjD
         NaC3Nbg6lXbHcAC7cD+7fzrl9ZxpjPEQ4UXRfMzKrxXRqLWd/uOTO2qhQZ18AMfk9nPs
         8Ah+Fs9pIV/K+atMhMVxbMbejMgkd/T7GUndMvDEkrfRai/F2RcimLvsqBb7AckwmELB
         IQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eO0tOz0zwXGw3TOZj4ZrnPJ+UUmohAjz6RImQ5MpXA=;
        b=oZSZgluGWBo3vezdXeGdtKylosid5fkzxrWQRA04cNqS7OdEOs4TGbK/WRzDMDhSIW
         bUQiZ4KQpfit+J30Cv/1OrL9YLEOeA2A/xcj/jrkYb8BDyE1bc2xWdzIhhaTnAEQCJ2V
         4Abfa3+wYdNZsRu2vcf7oyErjSkrxNSiD739UvENPs8etkvPGHhiJdqEH84YBdhpnubw
         J7waJX6ZU3s84J7F6uLwtlQWFLx22IJuhaQB1b1xQbcABvj7oNYo+XiAnGoKYNP56ywR
         IQA2ZulXDSLrGqwtb4ln4uFgegCQLmQmUu5UNN6njy9K9ALblxJky3RBvVgJhwxn5ep3
         Vbmw==
X-Gm-Message-State: ANoB5pmvwyGdjYUTXQPVeClfwSlhP7z+Ccc2WfipAm4GzAdWA/L4mJet
        btlfcu1vWSbrnkNVs622bKgqiw==
X-Google-Smtp-Source: AA0mqf4OKlROBYEynzKQq2L5JzBnHuUvehZ+0OQFWf3AtQSueLGxT8saq9/9I3MB1lWsXVVGH9/oQg==
X-Received: by 2002:adf:fb44:0:b0:236:87f4:75d with SMTP id c4-20020adffb44000000b0023687f4075dmr22313163wrs.447.1669379810368;
        Fri, 25 Nov 2022 04:36:50 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k15-20020a5d6d4f000000b002366dd0e030sm3574111wri.68.2022.11.25.04.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 04:36:49 -0800 (PST)
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
Subject: [PATCH v4 07/18] dt-bindings: msm: dsi-controller-main: Fix clock declarations
Date:   Fri, 25 Nov 2022 12:36:27 +0000
Message-Id: <20221125123638.823261-8-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
References: <20221125123638.823261-1-bryan.odonoghue@linaro.org>
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

