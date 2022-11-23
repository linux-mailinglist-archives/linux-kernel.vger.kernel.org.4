Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915E56359E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbiKWKaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236054AbiKWK3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:29:44 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A5A26E4;
        Wed, 23 Nov 2022 02:11:48 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id g5so374428pjd.4;
        Wed, 23 Nov 2022 02:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDXkUNj19oN7kKoHOgamDv/9yxtzhVdBO0sCtPpIE6s=;
        b=qsRIxirAU8x1w5IVEEwOzTmEmZxApJmmcFbHy00EU7/rufYApvm5YbeLFUC8bp7Okp
         ESFj/LwUCQ0RMpnXFZWTU4IDn78HUvnN2a066zW4sP3lbdsllncEs5ixGe5UCCIqzUHd
         Bl1L03WAhYK+ZzCmomYsj5TOtlRF9AC1FomgTtRI0fZJ4p/0CiYfPQ323dO7v7vuHbL1
         eN6AYj8vrL4b5uEZtR+XLZQ2VwVIQ7aQSx/havGxMiG2c3N3Vcc4yxJ8dnPQB9nVwCo/
         hAYBcmmsDKwo/06spqmQekeMfS7osfkifjK6wyUPw0luijDprHeCAnDZfYxH1bYHVmSO
         9aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDXkUNj19oN7kKoHOgamDv/9yxtzhVdBO0sCtPpIE6s=;
        b=4VZv/2wll5RNkyOj408N++XfgJSEYKrhHJTQhdILZanv2d5AL49lG/c3X4ZHd4sykM
         Ek9O9V/BM4H3O2r0MchZ1csBBhOCkL5ONaeZMt4fRJ6+JxrDPvBPJ/9Gqp3RwSkQTG/T
         tzs9phaxwQLgj5u9GWpbqaappoI+xyuUvcaXxh557Uk+aTev+CiD/kTf7/4Yj+f8Jel2
         OTodEoZR0yJoixMwbm3Nv7Rc0cQA4mHLuEFsmUEfknMklxFkUpVfEAlmI9CIDuxM22G5
         FSFMeyal/AWSKcJvXAEVN2jIBiy2CPGZoAgHG5bpgdSiJ/2Eugv7mPmp69hs5MK3DqJL
         CLaQ==
X-Gm-Message-State: ANoB5plFhvbgp9A6dnVO3MUXNxjHcnhEAN7JKld7QRMRG3DtKFUk7e6r
        rW/GApiDdwPi6U+/cpFL6ClyhmGcjdc=
X-Google-Smtp-Source: AA0mqf7HBxQ18SaVsrrunUCqGDqPNcTNCL1t53Jl8giBfLDq4xgbaZ49OdYip5jrstCZ5JYaquR7yA==
X-Received: by 2002:a17:90b:3c04:b0:218:4b47:9c29 with SMTP id pb4-20020a17090b3c0400b002184b479c29mr29119800pjb.54.1669198307069;
        Wed, 23 Nov 2022 02:11:47 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2d2-0afd-5100-fe55-e832-ec51.emome-ip6.hinet.net. [2001:b400:e2d2:afd:5100:fe55:e832:ec51])
        by smtp.gmail.com with ESMTPSA id c8-20020aa79528000000b005622f99579esm12277929pfp.160.2022.11.23.02.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 02:11:46 -0800 (PST)
From:   Owen Yang <ecs.taipeikernel@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, Harvey <hunge@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Owen Yang <ecs.taipeikernel@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: qcom: Adding DT binding for zombie
Date:   Wed, 23 Nov 2022 18:11:12 +0800
Message-Id: <20221123181043.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
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

Add an entry in the device tree binding for sc7280-zombie.

Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
---

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

