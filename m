Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C316F388E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjEATzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjEATzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:55:41 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258502D67;
        Mon,  1 May 2023 12:55:34 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bc070c557so3845811a12.0;
        Mon, 01 May 2023 12:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682970932; x=1685562932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oG5Sr+UvBJkF4hZeZmJOgj40jy7b88Q0+yZEwWLbmAQ=;
        b=MnfkLblocHM2pnbYno0bochDrSf7U8mdgl6+UEZqa25Az1IZ+gLrgZP5WgHCZRuKF9
         7xLz18zVJd/K7wrCBlV32h6cfZPOFqvcpBdbi1U8hJE7PXY4RKiIKo1qLjqDBSn5Lz/h
         hlYQz8y3Ee3GSecIo9nMWXcf8EnKkljqF+NRTOSI+aM8cKCblZRuagjGLJKRLrczL9ZO
         ci3Oq1r1NFmtnztD7+J53zsSP8ve9BE1TmUMpq1hogIaF+qeU6eoMLv4YZXPiQRjTPbH
         1CwQTatLo3sUVL76icF9L0Omo8zm6xrZNabw1HnIW7IiDPmLW/YNuKHoNxvvtT37VcPD
         +xFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682970932; x=1685562932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oG5Sr+UvBJkF4hZeZmJOgj40jy7b88Q0+yZEwWLbmAQ=;
        b=LQEOKW5hnFAZsLXeFbWcMv/e/s0zb4du02nAtHVGuPBinexQBoT6UvaJ1AtC6CBcVU
         JhMFKe2eAuJc7V2KeEtXNNkHH6LtYiCNecPZK5KIVs+NcIhH5TjqD8Ly4cXfwegJz/WA
         dDQYxQYhaojikVWWr39dkL5/v5qrs/oXMTrnV0wV/tphsXl9PO92vmsGdHq7XrMRkjjn
         MclRZhXfVecUWAlXMTIpcVh/jdLQ3QC34BR/vAkU/um8N7Mj0aWnc4bXZfaINp73hrRb
         pYLtStFKfExUIKJIRW8wklkdauyC/KcUshv2CbEncBVxhs7cIkvUHgQ+I/GoXPihuvHb
         GoPg==
X-Gm-Message-State: AC+VfDyktZaS/S6jgN0n04cKq7oAhvnrAiXyHljJDlqk8BG+tL9rsRst
        dM5v76UnaoUyPo89qcmhzbE=
X-Google-Smtp-Source: ACHHUZ6tUMl/jI3cnu8jGQfco5YOb/fN6HlvvKCVpDZoo0ebUZMqmLdiZI6JNGRKPJqWQmqchr3dSQ==
X-Received: by 2002:a17:907:3e08:b0:94f:29f0:edc0 with SMTP id hp8-20020a1709073e0800b0094f29f0edc0mr13127980ejc.44.1682970932547;
        Mon, 01 May 2023 12:55:32 -0700 (PDT)
Received: from localhost.my.domain (83.8.115.30.ipv4.supernova.orange.pl. [83.8.115.30])
        by smtp.gmail.com with ESMTPSA id og36-20020a1709071de400b009600ce4fb53sm6333650ejc.37.2023.05.01.12.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:55:32 -0700 (PDT)
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
Subject: [PATCH v3 01/13] dt-bindings: soc: samsung: add Exynos4212 PMU compatible
Date:   Mon,  1 May 2023 21:55:13 +0200
Message-Id: <20230501195525.6268-2-aweber.kernel@gmail.com>
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

Support for the Exynos4212 SoC was originally dropped as there were
no boards using it. We will be adding a device that uses it, so add
back the relevant compatible.

This reverts part of commit c40610198f35 ("soc: samsung: Remove
Exynos4212 related dead code").

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changed in v3:
 - Added Exynos4212 compatible next to all Exynos4412 compatible
   appearances
---
 .../devicetree/bindings/soc/samsung/exynos-pmu.yaml          | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-pmu.yaml
index 5d8d9497f18e..e1d716df5dfa 100644
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
@@ -50,6 +52,7 @@ properties:
           - enum:
               - samsung,exynos3250-pmu
               - samsung,exynos4210-pmu
+              - samsung,exynos4212-pmu
               - samsung,exynos4412-pmu
               - samsung,exynos5250-pmu
               - samsung,exynos5420-pmu
@@ -125,6 +128,7 @@ allOf:
             enum:
               - samsung,exynos3250-pmu
               - samsung,exynos4210-pmu
+              - samsung,exynos4212-pmu
               - samsung,exynos4412-pmu
               - samsung,exynos5250-pmu
               - samsung,exynos5410-pmu
@@ -143,6 +147,7 @@ allOf:
             enum:
               - samsung,exynos3250-pmu
               - samsung,exynos4210-pmu
+              - samsung,exynos4212-pmu
               - samsung,exynos4412-pmu
               - samsung,exynos5250-pmu
               - samsung,exynos5420-pmu
-- 
2.40.1

