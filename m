Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAF063CF38
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 07:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbiK3GaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 01:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbiK3GaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 01:30:06 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907EC3FB8D;
        Tue, 29 Nov 2022 22:30:01 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 9so15927416pfx.11;
        Tue, 29 Nov 2022 22:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7X0wN6DpjI8XmLGa5Qd3cypCN6OHZWy7qqAwTdstsr8=;
        b=c6N/EiTsBJ0oILqhP/MASxki8AiPnSFzQ76UCpiCxwo8q6BiNUJBIG4Va6iHGdnBFm
         YHAZVajb5UyT+Kg5M1tD52BTN+AP5V+aiEIMyJEu+dnFL/ogiFItbWfXtOoOarzgNVQA
         aBcey8TUpTMZz9FEhOCl0iJbT9vVO+zDKITL3DrpnLOsum+0kksfRBdcprYRNRJmBasy
         hW6yPYstZ+xY88dkg1mUHZ0x8N95szGmZMB6Y4WVz1Xtd0LMs3N0QIqDeD0wOxFH5UNe
         P9hs9bN604Bf8tijSu64t0zre1ail3od+xpZNkVxJ0KR5OonU3CehrAnHpEdK7bnxadK
         H3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7X0wN6DpjI8XmLGa5Qd3cypCN6OHZWy7qqAwTdstsr8=;
        b=eKZEYFSL1Xkyq5cWB3V58vAljI2fD8bzgedGUVx2/SvIzrSmIuta+FYzoY+6VJNC6O
         qO9wu2tUgz0WzyIbA80uOidrQfw5D5agHg/k/wmYRHux6iAAAieSVRUa6w93qHt8BiLN
         qTll8cIcoG3GKMjuC5M0eZid49GyfOv2t4KQ+SF22AMYGSGzQLTjfyVcMnTg8qK+U6Sd
         EZebG3hA/g1UxqxhF40Z1DUkgDbgk3whdX07YeDaP8dfvB7f+UF6HVypWdbwjJMGqU8w
         7M15mRB64Tpke/d9lOw9KsSaozwUj4uUlpmsQzj7eu7WsSJrnUuePxoLAnxGNbLMjMnM
         BwAA==
X-Gm-Message-State: ANoB5pm7i/Yxp8A14toD3LwOPE304ithN6tyVyAKb4487c30YzvpMZ5W
        CNiBgmlHlSnBoVM265R+c2Rm9IVCO9M=
X-Google-Smtp-Source: AA0mqf5+A5G3kVOZzVagiGlVvettoA3+DZ/f+f57uEicoYYeZEgeg0pDXaomEoJc/YLsSfF03u1Gcw==
X-Received: by 2002:a63:5409:0:b0:476:e3bb:2340 with SMTP id i9-20020a635409000000b00476e3bb2340mr34690736pgb.530.1669789800526;
        Tue, 29 Nov 2022 22:30:00 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2d4-7fe5-300a-7c16-8b65-8a51.emome-ip6.hinet.net. [2001:b400:e2d4:7fe5:300a:7c16:8b65:8a51])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902780200b00188b63f0782sm432375pll.288.2022.11.29.22.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 22:29:59 -0800 (PST)
From:   Owen Yang <ecs.taipeikernel@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Harvey <hunge@google.com>, Bob Moragues <moragues@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Gavin Lee <gavin.lee@ecs.com.tw>,
        Matthias Kaehlcke <mka@google.com>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Owen Yang <ecs.taipeikernel@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v10 1/2] dt-bindings: arm: qcom: Add zombie
Date:   Wed, 30 Nov 2022 14:29:52 +0800
Message-Id: <20221130142829.v10.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entries in the device tree binding for sc7280-zombie.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
---

Changes in v10:
- Add "Reviewed-by" tags in this patch log.
- Fixed history log list.

Changes in v9:
- Fixed version number (v7 and v8 were erroneously posted as v6)

Changes in v8:
- Correct commit log. Use "entries" instead of "an entry". As requested by Krzysztof, Matthias and Douglas.

Changes in v7:
- None.

Changes in v6:
- None.

Changes in v5:
- None.

Changes in v4:
- None.

Changes in v3:
- None.

Changes in v2:
- Fixed patch order.

 Documentation/devicetree/bindings/arm/qcom.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 463509f0f23a..7ec6240311db 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -655,6 +655,16 @@ properties:
           - const: google,villager-sku512
           - const: qcom,sc7280
 
+      - description: Google Zombie (newest rev)
+        items:
+          - const: google,zombie
+          - const: qcom,sc7280
+
+      - description: Google Zombie with LTE (newest rev)
+        items:
+          - const: google,zombie-sku512
+          - const: qcom,sc7280
+
       - items:
           - enum:
               - lenovo,flex-5g
-- 
2.17.1

