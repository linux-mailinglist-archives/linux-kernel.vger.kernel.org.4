Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2176F587A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjECNCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjECNCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:02:01 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3611A5;
        Wed,  3 May 2023 06:01:58 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-959a3e2dc72so1010251766b.2;
        Wed, 03 May 2023 06:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683118917; x=1685710917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhiOdhDEfb+iWh2Mv/2vV0thu45ELxEEl7Ux8olY3M8=;
        b=GDgWhCa7cTPRM91qlWVp/Nbs6yAAzQTxkEm9m3fVLU05H+ocy+NgohNDdjESCghGYH
         pqeZbQHx/QVpX+CWCp9T/QRqvV3Vnl4e6jhqqtAHTxMeNTLLl8KDEl6dF1aDfH46bXuM
         0RaDonz5kNkl4RUHwaKFsXP0PS9NSwIVO7JqfS4xb/rSqPAD6u8QcQ109WAC++fWH5si
         wt2eEFU5qXN7HhHQ5P08n85ETKpzJIxQRnJhRMVHbfyICPnxiqwP0N1IKeZUcs8Y+Rw8
         2ifiKzBy0i4GzGz8dSpo+2UjlKo4bMNkAlqqBNhjCzaezSEVgEbuNBVo7wWyFsGCIQ8H
         SYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683118917; x=1685710917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhiOdhDEfb+iWh2Mv/2vV0thu45ELxEEl7Ux8olY3M8=;
        b=EaPgHR1HGz+gkq0PbQBN+q5ibIyUWbTaEq/hb66Z2DmgxSYJ/09bOO/6BEnR8Jc31F
         kmPk3wyFFX2oTLPNweqHUErcG/OwBEmZIEs1J6euAPyN4AnZOvT1NR3POzSMAgyzxeIc
         Fxj25nXJYGUm2M8TIPfSP1cLmt56HbEy910ayOXwxG8V7x4CuoPN636AQT8FFdAJFZ6B
         L7e4+0Pkr2vMUb+XqaxlvyQ+p3cDiwmtfmC9twNvHEOUf9f7E6nc3iWWnWoeEc8l/ryb
         fYtO4JfMXdMfak/N/k5zyD8S8b0L4tq6M4LoHWL4YuiCzTeXLnhwUJQu5ZFWFKrB8p7x
         zsWA==
X-Gm-Message-State: AC+VfDz0qEF32QF+cDxqEWESfTkCNSPwmP3YDKxzhfjEpWFgemKQnqqO
        6hwHGwpT8joReuG7UQKkG1o=
X-Google-Smtp-Source: ACHHUZ5VBCxtl59/JZsu9Fjmhg//S8oBIMkURJC7sUdEzQiKrgokJkDMu0wHpflO+8wKkVT9t+9ZWw==
X-Received: by 2002:a17:906:ef0a:b0:958:5c21:3fa7 with SMTP id f10-20020a170906ef0a00b009585c213fa7mr3490600ejs.25.1683118916731;
        Wed, 03 May 2023 06:01:56 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id my17-20020a1709065a5100b0095728081944sm16105578ejc.146.2023.05.03.06.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 06:01:56 -0700 (PDT)
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/3] dt-bindings: clock: qcom,msm8996-cbf: Add compatible for MSM8996 Pro
Date:   Wed,  3 May 2023 16:00:50 +0300
Message-Id: <20230503130051.144708-2-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503130051.144708-1-y.oudjana@protonmail.com>
References: <20230503130051.144708-1-y.oudjana@protonmail.com>
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
2.40.0

