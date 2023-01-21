Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425FE676921
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 21:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjAUUTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 15:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjAUUTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 15:19:01 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431FD5FCA;
        Sat, 21 Jan 2023 12:19:00 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z11so10450599ede.1;
        Sat, 21 Jan 2023 12:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwQ17Lcm2IqVHFAnePP290nHJ1hZODiXeBdsdtLFjw0=;
        b=FUXXhdqANULg7ZotC2pLpEfJqS2F0W8GKHoIPlLcjHFCFPLSZUSgepsZotVvY7eGMw
         5vVvC2b/qMx4OpJdm/r+6AQoChRHf/F/VaUPQuVVK76kGGpDfq2Hisa5WqrCx3R/agid
         2KsW5yhLhIBWOJPTmMtEaaCN3RFEEjjNF4td9mtVXOhrG/5Ypr6ZKDAlqhcSyDOMxJHe
         HdrA9qw7XbzOcwrGblNwXzvIaKKJc4Q3n/7g3eAYibqH2FOF1ILhaPeS/NGGOrntOQXg
         YJmqURb56UN4YeLsT7Q1KgbLqQQ/6RJGXA0dV3iqfvOCiwv6carXW6TNedH9GtCCVkIj
         bWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwQ17Lcm2IqVHFAnePP290nHJ1hZODiXeBdsdtLFjw0=;
        b=IupvOcP/g/hskdDTPJu2BqdP4XUA8IQLoY3tZA3DtlmZj0Pl/PuJc8KnbJp/IkPE96
         Lm5Y0B2Qo3qG6455mDrtzlJ55hST/ZFAm+rQl0KKY0Fp6o/2wsBuBISm3RAlZi295sW+
         BWd/5S/FQ1J0nPDOkmsRs+BJrpRBzYIXeh4H+tfvAYutG2qOXCgJzoZ+jl2wFf6KvAU0
         qnLwT7ctuBZkugZ45NI3bNG310NUvi1ccfkGTLvgrOtwC/z6XZVVjgpWyEn7t/JctUG7
         1bUkPgaWdVb3X0CfVwVGpvo+kDxn/3GG8Hn8ZvMNpSEtCuPQYtiAuCux9fNLes9se3x/
         LwUQ==
X-Gm-Message-State: AFqh2kq9q1zV5gYIy9J2oyjCGpB9r9ljO5BnSSbmVzyAqrnt4FJtVvfj
        spIWPts4/w5/PEXEd8s+oztIHN6VpVKFfw==
X-Google-Smtp-Source: AMrXdXvGt++PN5EjA0ztBQb2c/gjgcgD4qFpNIX0JHL6I/yrpki+hm6vVeEIFzUneViDHYXRYrObXA==
X-Received: by 2002:a05:6402:1cb2:b0:49e:f052:d9d3 with SMTP id cz18-20020a0564021cb200b0049ef052d9d3mr4793877edb.15.1674332338445;
        Sat, 21 Jan 2023 12:18:58 -0800 (PST)
Received: from localhost.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id i23-20020a50fc17000000b0047c6f3eccb2sm19203423edr.50.2023.01.21.12.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 12:18:58 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 1/2] arm: dts: exynos5420: Use Exynos5420 compatible for the MIPI video phy
Date:   Sat, 21 Jan 2023 22:18:42 +0200
Message-Id: <20230121201844.46872-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121201844.46872-1-markuss.broks@gmail.com>
References: <20230121201844.46872-1-markuss.broks@gmail.com>
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

For some reason, the driver adding support for Exynos5420 MIPI phy
back in 2016 wasn't used on Exynos5420, which caused a kernel panic.
Add the proper compatible for it.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 9f2523a873d9..62263eb91b3c 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -592,7 +592,7 @@ dp_phy: dp-video-phy {
 		};
 
 		mipi_phy: mipi-video-phy {
-			compatible = "samsung,s5pv210-mipi-video-phy";
+			compatible = "samsung,exynos5420-mipi-video-phy";
 			syscon = <&pmu_system_controller>;
 			#phy-cells = <1>;
 		};
-- 
2.39.0

