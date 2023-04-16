Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C4B6E38B5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 15:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjDPNfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 09:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjDPNfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 09:35:36 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF111BD4;
        Sun, 16 Apr 2023 06:35:35 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id vc20so2533730ejc.10;
        Sun, 16 Apr 2023 06:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681652134; x=1684244134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UY+jtzkZVxp695kD2INeOepNCktKBgUK3witE0IcM4=;
        b=iaTooN0HV3wy+r8wq4Tu/QDcwsEjpCqQ8moi/+BO4r9tom4CDZcYLjR3oWufi4pXYN
         DUnYtHtrBufhSYykf/7uASG1jLIRcIi3pBOgIPvkPQCBjmZsGJ/YUYlo4nDw/5rtH9zJ
         665gVk1zHEQlfSU2JIvzLHo32isQYdX9yg49Bfq0nSxHE9PS5Qn3oDcBa0H8Z2b19Ra7
         aQTK413zxQxnMRKoXShJvxc2Q6l8qNMBDEyZPTzcn47LVOWJ0qYWr3ACHhxTDVhFU1Y7
         3e6NsXzjs3aLxJvGCMBE7LzoPa8e2eh71tloy/03nMr0f17wKg5yH0wyP1l5TEXQdy+h
         JyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681652134; x=1684244134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UY+jtzkZVxp695kD2INeOepNCktKBgUK3witE0IcM4=;
        b=RG458k7Wi0vrfqt03TBB0hoQNccctj6UP7EmXHSsepcyU4G3WH+S0/bCK/wSC0PTfS
         +NTUzPr9LYxMTyPOYz9tuIggBEIQqk0+DUKhtOZkf9aJ2sB0dgphbTCawEic2W0fJJBX
         vXe0g6ccBHa+aGA+hwZqcnoEjNCJnYq69JzL6KQMMy2gyt5oyYTZixk2mlwvLQW346pg
         PUcQ3i/kI88cG2jI5o0idZ+z4zC5DevJLADn54WO4LKOQhHbKSnq73abQrTcPDuHOplG
         sLbhEbffaC99pIrDzzXL32slYkD1VVTOF6GKFcsTBRYJ1ZXuA1qqBxWHEtqyceYQcSyM
         cI+g==
X-Gm-Message-State: AAQBX9dOHmmo7hrfdtFmre/MlvivcXiW4T+n/zAAv/aF+2O4Q/emRRji
        CiOxoptEFoCg4YKQNV1QuuI=
X-Google-Smtp-Source: AKy350ZO/bAqHPULEAVisdWwkRtRXKRD5ZhIpPWHtjHQe58iG5EhjU3xPTw+FcVrRY82zYRSX+U8RA==
X-Received: by 2002:a17:906:58d:b0:94e:da66:c5b2 with SMTP id 13-20020a170906058d00b0094eda66c5b2mr3861559ejn.73.1681652134152;
        Sun, 16 Apr 2023 06:35:34 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id gn23-20020a1709070d1700b009373f1b5c4esm5122958ejc.161.2023.04.16.06.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 06:35:33 -0700 (PDT)
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
Subject: [PATCH v2 01/12] dt-bindings: soc: samsung: add Exynos4212 PMU compatible
Date:   Sun, 16 Apr 2023 15:34:11 +0200
Message-Id: <20230416133422.1949-2-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230416133422.1949-1-aweber.kernel@gmail.com>
References: <20230416133422.1949-1-aweber.kernel@gmail.com>
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

The platform was originally dropped in commit bca9085e0ae9 ("ARM:
dts: exynos: remove Exynos4212 support (dead code)"), as there were
no boards using it.

We will be adding a device that uses it, so add it back.

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

