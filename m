Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE74C6E371A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 12:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDPKSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 06:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjDPKSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:18:11 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EAB1722;
        Sun, 16 Apr 2023 03:18:10 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50670cc3abfso2300233a12.1;
        Sun, 16 Apr 2023 03:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681640288; x=1684232288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ictKT9aVXsy71NADauVKmbOAOmI+urQXpaOOBezHLGg=;
        b=NmVfd+lGkyzIR89aTXtzukxRcrjPYn7C0h2vuCLNzXGN+ESHg7XCpJ05A0r2JFDj8A
         ThSYnlSVdf/13t1J3961GHMbdlNv2jDuNPkJlyZjkQpoQAuDMQ019JKdzlhnNjhHsa2D
         fF8kmlHnLHneEsPKwni4PtIvZmmYjfJRYmQwNrKSQIjA2/H6QePZhY8yOK+Kuv/zbwhl
         PDA5PAAp+DXDXzgSneFDhQ5M5W+a1mPgofcdxOg5GbpESo+IvLoGqF1/f52FVuO5i8Jw
         4en1XGcuCPvnrP/0arn8WBfOQUQUGvUuA0ulv3xi+hslfOFu4dl0OrFKqk22Cn1W9ftc
         3QIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681640288; x=1684232288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ictKT9aVXsy71NADauVKmbOAOmI+urQXpaOOBezHLGg=;
        b=czd+sZ+224DlOSNjac7H2Yz8jXPgW73UgW5Y0MPnjloRJclVUNiHDJ8CLoIU3AdMpF
         w7RneadtHxtiwkgI20fmqKxyw1s6G34RmEC2S96RGO68MQ0KSoLXD5ezDOKxgtvwRUGO
         n4Guto8b5iFHXSh6wtQkKI5Sb/SS1IuoIv94rN/dWWKvkWYDHE6JAn3lgA6zmodwy+Wp
         8wiVoV2/KUuRuYFK1MnL6ZRTIr9rMqYQfcZYchXhwd4uCQb0Mt4J3IRer8fnsEMDh4xp
         hfnZa2WOi4Pu/YWMmM2AR73ELF7DjrhUFkuvSaRw98crgJR9pJg4AyzsqtvM+oSWHc/g
         WQog==
X-Gm-Message-State: AAQBX9en0EB0Yp2D5eYS01u8znrwhk4FsL7Dwa39XeuhpB3GLF0o8JFT
        +df2ktcjNKBO/AU/GP40/oM=
X-Google-Smtp-Source: AKy350b4tPKvu3DKWB3ezxr4rb5TH+DVkFeKgGXShis+Z10SPj3vkg0ePywiJThMbrjGTZeKUqdoTw==
X-Received: by 2002:aa7:cb19:0:b0:502:6e48:65ea with SMTP id s25-20020aa7cb19000000b005026e4865eamr8951620edt.12.1681640288447;
        Sun, 16 Apr 2023 03:18:08 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id r20-20020a056402019400b0050476da5160sm4427443edv.45.2023.04.16.03.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 03:18:07 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH 01/12] dt-bindings: soc: samsung: add Exynos4212 PMU compatible
Date:   Sun, 16 Apr 2023 12:16:13 +0200
Message-Id: <20230416101624.15866-2-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230416101624.15866-1-aweber.kernel@gmail.com>
References: <20230416101624.15866-1-aweber.kernel@gmail.com>
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

Re-introduced as part of the Exynos4212 re-introduction effort.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
index f7c141dd11ec..be3128f2c0df 100644
--- a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
@@ -17,6 +17,7 @@ select:
         enum:
           - samsung,exynos3250-pmu
           - samsung,exynos4210-pmu
+          - samsung,exynos4212-pmu
           - samsung,exynos4412-pmu
           - samsung,exynos5250-pmu
           - samsung,exynos5260-pmu
@@ -36,6 +37,7 @@ properties:
           - enum:
               - samsung,exynos3250-pmu
               - samsung,exynos4210-pmu
+              - samsung,exynos4212-pmu
               - samsung,exynos4412-pmu
               - samsung,exynos5250-pmu
               - samsung,exynos5260-pmu
@@ -122,6 +124,7 @@ allOf:
             enum:
               - samsung,exynos3250-pmu
               - samsung,exynos4210-pmu
+              - samsung,exynos4212-pmu
               - samsung,exynos4412-pmu
               - samsung,exynos5250-pmu
               - samsung,exynos5410-pmu
-- 
2.40.0

