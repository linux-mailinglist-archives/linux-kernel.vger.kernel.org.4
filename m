Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC136E38B9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 15:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjDPNfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 09:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjDPNfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 09:35:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652BC1BD4;
        Sun, 16 Apr 2023 06:35:38 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id fy21so14507088ejb.9;
        Sun, 16 Apr 2023 06:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681652137; x=1684244137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcsub8KhIgRh8+LjsAALX2kQhfzLuSTeBZW6A1vW2A0=;
        b=iwMbVHa2MlgG+jx7mloofP6Nhzg6eDc/daviEdAbzrJm8snqyK4r5K/LnDuGCaHplN
         ux+3e6SEg7bmLl68gyyylkkkc6rLq2fFEmXiRkrdalZUEHrdlB31AYnZsceJw8Fl7mNZ
         mCvXrGL20X921acbXCWbvcPEhzWQyG2zfcJPJpnT41ZIFpDoyNYtmGi++8qjAAGiPzSs
         X0TUE/6/+8998N2H5pjWRVr2lLuo7pMNW/ES/2BThl+wol5rBLzECPqcWewNU8ImVjVK
         a9JzopBdhbPXQgoJOBKvvA2PcVrJjf319Ie4UI/yrHgFnE8rEBclRJkEYHBKNrk9kF4n
         iEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681652137; x=1684244137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcsub8KhIgRh8+LjsAALX2kQhfzLuSTeBZW6A1vW2A0=;
        b=Xe1nAU4nLWEB0yVqU/fIPb7nG8NEKl2nWYTK7BrEGw9ccC0VE100cHliu7bWAupS+a
         D6uFt1LaPi8YfZIlAYksUUG4bDpxJFTCJabGmXgugRZS6yiglOzqGCaOawIZawUASVPa
         eVtuWyCjUtVpBNOY3yTAUhHBdQO+zuY8z+Xhgju6ExOhhOFY2b1QDIt5G/Mi8wjcAzZn
         OvjUdgKv62A0HfIe4xD1Btsp9auCT2odRZdnBC/QABVOM/113Ptmwj8Mw3NN2jJfCtQm
         meha2uu+IxhDOABJk64oPjzS3abFAH10HN3U747XcJmPQeVb8N/RFJjEj/Q4YK275sP3
         gMzw==
X-Gm-Message-State: AAQBX9cx31XB0hh5b5vbsPx+rB1z1kXyRbCiO4lEHapnSTE40I37GVgS
        y+a4UxW0JupKykJvh04sXvo=
X-Google-Smtp-Source: AKy350bGaVuX5pzurnhlXfdKfoZIS5zhuQjlj1IZXMX185GoOm0fxbH3sL4jtNmKj8vjEVK4oORE4Q==
X-Received: by 2002:a17:906:254:b0:93b:5f2:36c with SMTP id 20-20020a170906025400b0093b05f2036cmr4220124ejl.61.1681652136807;
        Sun, 16 Apr 2023 06:35:36 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id gn23-20020a1709070d1700b009373f1b5c4esm5122958ejc.161.2023.04.16.06.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 06:35:36 -0700 (PDT)
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
Subject: [PATCH v2 02/12] dt-bindings: clock: add Exynos4212 clock compatible
Date:   Sun, 16 Apr 2023 15:34:12 +0200
Message-Id: <20230416133422.1949-3-aweber.kernel@gmail.com>
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
 .../devicetree/bindings/clock/samsung,exynos-clock.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml
index 0589a63e273a..a36781a455b6 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos-clock.yaml
@@ -24,6 +24,7 @@ properties:
           - samsung,exynos3250-cmu-dmc
           - samsung,exynos3250-cmu-isp
           - samsung,exynos4210-clock
+          - samsung,exynos4212-clock
           - samsung,exynos4412-clock
           - samsung,exynos5250-clock
       - items:
-- 
2.40.0

