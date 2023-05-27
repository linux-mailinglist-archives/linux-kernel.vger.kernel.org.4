Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707B47133C9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 11:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjE0JkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 05:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjE0JkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 05:40:14 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE09ADE;
        Sat, 27 May 2023 02:40:12 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-970056276acso247010666b.2;
        Sat, 27 May 2023 02:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685180411; x=1687772411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYU8DIZ4LFg3qtG4sMU0TrZZjEkZx2DAGPUz4yxPtkQ=;
        b=MiHVekn2dSfJv23gVug5N1DWYZCh42FwDNmDYfoFnkLjVIJj9gbiuzgEpbkQQxx1CA
         i0fc7/ve7cRHPs4U2tVmfSzHcKvu7GVB/pkfeuE9CzX01ly8H//73uC1mFJVFqHBS/n9
         vuaZ40KRTb31Bv+t4zwzl3Tw6csrARby9Sf6wWU1C3ZGxV3HZSl5A5zuouMgjqKwOmkj
         BRiqBpLFjUK29/WwMHQPs2/jU2FEE3x6vMLyu+386y1/Zl2Rs6v/Jv8sZV1dt/xIytUY
         inTdCVgeyNqfHKUbrCpNciUTLmM2dHeywfIBrqNkKhUkvTecufYFOeaNi71CTfO6pN9Q
         MrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685180411; x=1687772411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYU8DIZ4LFg3qtG4sMU0TrZZjEkZx2DAGPUz4yxPtkQ=;
        b=QSKpos7dYwkSDjJegI6Ce4LJ36jOk0L2/HwJfqT1OgwOLCjKQcNRgBKMtaLDuY0a9t
         xQ+otoraArMMjYm6T0O1XYyXnT2pCKLIdi+eVp66DRDH8kAOpsCeGlyUHCjbuX/y+UFf
         LxqavMi8bCqDPp+eCgj9Q/nI+15JNTC2+/DcdV0/lk1u7tMJoRy3S0fGedHrp2ZsHSWh
         KRgYoEKYRlF9K2JwuE9eEhjtgLFe1PR2vL2r2SvZUkJ+4IkDkfNEdeEVbaPuUDFEgwRL
         be5qQLIwcnsXr//MiGddT6Ct2LcIHY/14tPzhJGZ4Qx5iEqn3duqWlfsAlEJ6VDQWGH2
         rA6w==
X-Gm-Message-State: AC+VfDykUJhNDvZ6CZkcDWigZdusIl3vP0UB2gYkSc+E8nPiX5PI6Ps8
        0OZYK0VtsJ5oRYeYYNaIUwk=
X-Google-Smtp-Source: ACHHUZ57NUw5hsNGLDK9WItLKApipqy0WT+YEapN79ko9MMyAXgY8BxIgAr1OuYIIV/6rgZLxRmgpg==
X-Received: by 2002:a17:907:80e:b0:96f:5747:a0de with SMTP id wv14-20020a170907080e00b0096f5747a0demr4112464ejb.6.1685180411121;
        Sat, 27 May 2023 02:40:11 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id kq12-20020a170906abcc00b009596e7e0dbasm3163623ejb.162.2023.05.27.02.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 02:40:10 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: clock: qcom,msm8996-cbf: Add compatible for MSM8996 Pro
Date:   Sat, 27 May 2023 12:39:32 +0300
Message-Id: <20230527093934.101335-2-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230527093934.101335-1-y.oudjana@protonmail.com>
References: <20230527093934.101335-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

The CBF clock on MSM8996 Pro has a different divisor compared to MSM8996
and is therefore not fully compatible with it. Add a new compatible string
to differentiate between them.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,msm8996-cbf.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,msm8996-cbf.yaml b/Documentation/devicetree/bindings/clock/qcom,msm8996-cbf.yaml
index 3ffe69d8cdd5..0dfbd8c4d465 100644
--- a/Documentation/devicetree/bindings/clock/qcom,msm8996-cbf.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,msm8996-cbf.yaml
@@ -15,7 +15,9 @@ description: >
 
 properties:
   compatible:
-    const: qcom,msm8996-cbf
+    enum:
+      - qcom,msm8996-cbf
+      - qcom,msm8996pro-cbf
 
   reg:
     maxItems: 1
-- 
2.40.1

