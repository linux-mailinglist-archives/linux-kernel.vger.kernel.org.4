Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10511626A6F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 17:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiKLQEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 11:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbiKLQEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 11:04:36 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712E6193C7;
        Sat, 12 Nov 2022 08:04:35 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso4946416wmo.1;
        Sat, 12 Nov 2022 08:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oo1e2pdndrGc6hVcKePpw8O0AQvGqHawFLLzPC17yeY=;
        b=pP5PuMeTMje8MHtJrs+dShOCpQSTLDpgsZzH09YamX+H1RoikyDCjlk9vvfHT2/aMU
         FiWuOMH7TsXRfzFC5GfrEoCvF/NRd64KxpbkWtgMVsIyDVgHIh05Fz4jrlvmjswSPeB9
         AInStLhIx08ygaA4RWh9iPga0eID/dZM9qYqn1zDR4bOKsVX17XcTHGQ7U+Z7SjlSaJ1
         SGkQQOdqktLJCOWzbuQIe3RjL8hQILzEOr0/mp88mKElGzqKho4yxJZMclHdb/7Urty0
         2DTGpD2IHN1Z4nZ9838i/YtDtwrhqRU6lRKsHsicqpZva9vwfrUEa2NuPUmGtaUlbwkY
         5ttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oo1e2pdndrGc6hVcKePpw8O0AQvGqHawFLLzPC17yeY=;
        b=YgaWYmTb/pBn3vIH2k8MruUjvykzJFwyxt0ppx3768ohxkKZqYGK/foLCVj9lgXkIx
         wp2zwpsTE84m0t45cRnFn/vKo/CLNWy6iZbxLgFeso9SpORob0lE+TfVPM6MDzZxRGWR
         Kw4lIT3muJBpo5KROJWif7Duti+uLIYhJDOyZqpoXcoYQ/0N4VBDXCdhpkYcYc0d20Ej
         rSlm3eUx7x5KzKTe1/TKYtiNMh2KGkVQkTrH4RimkONbsdTE4hQS3W1g1wSzRqpOmXAT
         fVgnrZGFPGN2v8XTvL4tAtIQz3PWNdkBO1C9ASQqCNiFl773RNWt92rz9Qx6Sz5U0YKm
         EcTQ==
X-Gm-Message-State: ANoB5pkKskMCjXis0unJb4gJDRDmne0ZO3xSmuH+1i1mH3XMxdOk2S9b
        X+TBlFQ5lkNoWMeS8xIVPiA=
X-Google-Smtp-Source: AA0mqf6gNkLJsyCFH5GzLpe8VqEmtAK/h1PHEytwQxLYAAuYv407DsjfvhExhFcj2H9GE3FK/R86DA==
X-Received: by 2002:a05:600c:4b16:b0:3cf:77a6:2c2e with SMTP id i22-20020a05600c4b1600b003cf77a62c2emr4084324wmp.179.1668269074086;
        Sat, 12 Nov 2022 08:04:34 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b003cf87623c16sm14605752wmb.4.2022.11.12.08.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 08:04:33 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] dt-bindings: arm: rockchip: Add SOQuartz Blade
Date:   Sat, 12 Nov 2022 17:04:02 +0100
Message-Id: <20221112160404.70868-6-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221112160404.70868-1-frattaroli.nicolas@gmail.com>
References: <20221112160404.70868-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 244c42eaae8c..fc5f14fcd007 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -579,6 +579,7 @@ properties:
         items:
           - enum:
               - pine64,soquartz-cm4io
+              - pine64,soquartz-blade
           - const: pine64,soquartz
           - const: rockchip,rk3566
 
-- 
2.38.1

