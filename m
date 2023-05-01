Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AEA6F38CD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjEAT5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjEAT4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:56:23 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97083C05;
        Mon,  1 May 2023 12:55:57 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94ed7e49541so479932566b.1;
        Mon, 01 May 2023 12:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682970956; x=1685562956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTzD+ObYPqz4vMUGcRmByVEWvAs3h4l+qXUdZRMrqEU=;
        b=T15jY1Mn7c6eIkNv1Ps9edBAwkf5/aQXqP/2vEri1eioCfDdUo8F5bQSB5ds/YbrZs
         kzW1MzleqUfq1DrXcbOoiw+0++IjuuOalC9Vjs/935chfOZ0Po6zsc94J8D5gs7JgiwK
         6xM1VRl/3X8zOiKu0LIyON5uyQEadbztGvLb8JYy02AmioCgN5mT0k5J6kDxksHtaBeb
         I1ZKEeC2zXQQBc1wZt+FmCfOVWSBk9ipHzTniA+6Lp5+CJVgdaflGcfxzV0W20qQ154v
         1/l14i7Y5ttPq359OpuMbK0nX/euKnVf8ErbQ0hdIX384142+QJ4y9XDVoyCkLzlsmZr
         2ITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682970956; x=1685562956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTzD+ObYPqz4vMUGcRmByVEWvAs3h4l+qXUdZRMrqEU=;
        b=gBTr2SAek91UrrLKCb+qlvJ9vc5kgKLC2UI1O2NMno1PtJ/ClFym8VMLuu2qirCziW
         VujqL++isnRgCOW4+KgEzFbX58+nN1jnLWa0dCEgdBPGWF1gjhpZFBBMgrgOWfYZZYkd
         MLTzncYtqhSulp7rmK4g8i9Gtu47Tf85kFepXS6Q0Fg3rWhZEPyXBg2MV0S57LjBhzOR
         e7JZ+6G895Ofxy3HyntJrx3niH+QjjEgST656FeMVqqQTJOikZfOTBNqbwoPiBxNd50x
         P0lJzrAq2yQRJHYOK5MFDORr0kUJB+TwjKr5fSRL+xTMm+Jsq3zLxAk75nq57RhPPm9Y
         URIg==
X-Gm-Message-State: AC+VfDyQNA8qsOouc5WG8wEyIEG/lypPWzIbTvwiEiG/tiTPdUCw8jcv
        jhTCqNOfjiaMIVZPzl6CECc=
X-Google-Smtp-Source: ACHHUZ6+4vLeKUkttnnAwUq3xaysMH1UDPT0yO2wXLoODVKlxgGlnE0tDhFVNqWffYf1KKFksbIg6g==
X-Received: by 2002:a17:907:6d03:b0:947:55ad:dd00 with SMTP id sa3-20020a1709076d0300b0094755addd00mr15076107ejc.26.1682970956138;
        Mon, 01 May 2023 12:55:56 -0700 (PDT)
Received: from localhost.my.domain (83.8.115.30.ipv4.supernova.orange.pl. [83.8.115.30])
        by smtp.gmail.com with ESMTPSA id og36-20020a1709071de400b009600ce4fb53sm6333650ejc.37.2023.05.01.12.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:55:55 -0700 (PDT)
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
Subject: [PATCH v3 12/13] dt-bindings: arm: samsung: Add Samsung Galaxy Tab3 family boards
Date:   Mon,  1 May 2023 21:55:24 +0200
Message-Id: <20230501195525.6268-13-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230501195525.6268-1-aweber.kernel@gmail.com>
References: <20230501195525.6268-1-aweber.kernel@gmail.com>
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

Add the compatible strings for the Samsung Galaxy Tab 3 8.0 series
of tablets.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changed in v3:
 - Moved Exynos4212 board before 4412
 - Changed description to Galaxy Tab3 instead of just Tab3
---
 .../bindings/arm/samsung/samsung-boards.yaml           | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
index deb2cf971871..e3ffd8159ab6 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -72,6 +72,16 @@ properties:
           - const: samsung,exynos4210
           - const: samsung,exynos4
 
+      - description: Samsung Galaxy Tab3 family boards
+        items:
+          - enum:
+              - samsung,t310                    # Samsung Galaxy Tab 3 8.0 WiFi (SM-T310)
+              - samsung,t311                    # Samsung Galaxy Tab 3 8.0 3G (SM-T311)
+              - samsung,t315                    # Samsung Galaxy Tab 3 8.0 LTE (SM-T315)
+          - const: samsung,tab3
+          - const: samsung,exynos4212
+          - const: samsung,exynos4
+
       - description: Exynos4412 based boards
         items:
           - enum:
-- 
2.40.1

