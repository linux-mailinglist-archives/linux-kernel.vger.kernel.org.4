Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5555374F1F2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjGKOWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjGKOWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:22:14 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940DD1724
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:21:57 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b6f97c7115so88238421fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689085311; x=1691677311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VFrOQnDAjQXhegqY3n085GeOtwznqIRmWRPa23xaqYk=;
        b=IlGgStRsBKeMLAFHJdbUiGKJo1bir5icXwayDj/ChqrfXnHbSeTLx0r3b2Wr+ISbHx
         RF5U3VQWKBXdklcE/6WDZ/pT1xzdbtMH1/DrDDJ5blYp1I1VPHE8PjO7jbk4W/LTTbUl
         RY5rh1I5jxerBO3uyO7GPAR8Oa08hyLKzz2B7H3f/x4hn3RnlMRv782Yvid6ZBsnk6XV
         Hq6nX5/2k6QRlnfA1cT3wXCccQkvYCsE3xuHh6g6wXv2BSH7U/RYLjUmgfsXqA0d/CAy
         2DYgxcoK8cqrjydXdo7Http9VSQD7GmHi7d738p4hMnuwqxUyAwqAUxLlhL7w8IY9z83
         Ddww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689085311; x=1691677311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFrOQnDAjQXhegqY3n085GeOtwznqIRmWRPa23xaqYk=;
        b=kOS5PN8WXu+qVSTOwUUhnzWN0jZrSZ3aGgc1ldhZ1gDHRnF+kgvQ+X9h6bBJ/s/60r
         fFPVpH2CHV3iOOikL0w/hOChlu6JwT5cjQcVM8DdIkhaU3kIcINxBOPRtC4v55NgVwcn
         EHMIWb64ofevvnWjxVRjn15wUlRgN8o7dsW+fcQXgoQ0Kiy3Prj/4j69K93X+TWglbCF
         KY7vjzhvh2KbmfVCEEwE8B+5yXIInYCqeUU8YhniCU2q+OLFZYPwYVugrltqdlYJXM3l
         qkM5roURFKc9g5rlZDC83RVWXRXQhSPRi5RY7BqFNQPp1K8CZ8WTsWL8FhK5L1BneXbI
         TxOA==
X-Gm-Message-State: ABy/qLaZS/twqMG14Lfe26hJPN+37uws2p5EWW9lhzJ71EBri4XImJe4
        BkOfQ6mrkegqxYGP3rOvQw2qZw==
X-Google-Smtp-Source: APBJJlFpJIzG7c3KWaB6WeDaqp42L69JcYpEqVOIElZ7HYwlvZNeiW0m5Dae5iPiRFppI4th8bQ+5A==
X-Received: by 2002:a2e:9208:0:b0:2b6:e124:4d96 with SMTP id k8-20020a2e9208000000b002b6e1244d96mr12317412ljg.26.1689085311515;
        Tue, 11 Jul 2023 07:21:51 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id j17-20020a2e6e11000000b002b6ee75648fsm483080ljc.12.2023.07.11.07.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:21:51 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 11/18] soc: samsung: Move power-domain driver to the genpd dir
Date:   Tue, 11 Jul 2023 16:21:48 +0200
Message-Id: <20230711142148.751712-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify with maintenance let's move the samsung power-domain driver to
the new genpd directory. Going forward, patches are intended to be managed
through a separate git tree, according to MAINTAINERS.

Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: <linux-samsung-soc@vger.kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/genpd/Makefile                                          | 1 +
 drivers/genpd/samsung/Makefile                                  | 2 ++
 .../samsung/pm_domains.c => genpd/samsung/exynos-pm-domains.c}  | 0
 drivers/soc/samsung/Makefile                                    | 1 -
 4 files changed, 3 insertions(+), 1 deletion(-)
 create mode 100644 drivers/genpd/samsung/Makefile
 rename drivers/{soc/samsung/pm_domains.c => genpd/samsung/exynos-pm-domains.c} (100%)

diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index c178421e0cbc..1cf0ff26a44f 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -7,3 +7,4 @@ obj-y					+= mediatek/
 obj-y					+= qcom/
 obj-y					+= renesas/
 obj-y					+= rockchip/
+obj-y					+= samsung/
diff --git a/drivers/genpd/samsung/Makefile b/drivers/genpd/samsung/Makefile
new file mode 100644
index 000000000000..397aa5908c1d
--- /dev/null
+++ b/drivers/genpd/samsung/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_EXYNOS_PM_DOMAINS)		+= exynos-pm-domains.o
diff --git a/drivers/soc/samsung/pm_domains.c b/drivers/genpd/samsung/exynos-pm-domains.c
similarity index 100%
rename from drivers/soc/samsung/pm_domains.c
rename to drivers/genpd/samsung/exynos-pm-domains.c
diff --git a/drivers/soc/samsung/Makefile b/drivers/soc/samsung/Makefile
index d35270fc6b2b..248a33d7754a 100644
--- a/drivers/soc/samsung/Makefile
+++ b/drivers/soc/samsung/Makefile
@@ -10,7 +10,6 @@ obj-$(CONFIG_EXYNOS_PMU)	+= exynos-pmu.o
 
 obj-$(CONFIG_EXYNOS_PMU_ARM_DRIVERS)	+= exynos3250-pmu.o exynos4-pmu.o \
 					exynos5250-pmu.o exynos5420-pmu.o
-obj-$(CONFIG_EXYNOS_PM_DOMAINS) += pm_domains.o
 obj-$(CONFIG_EXYNOS_REGULATOR_COUPLER) += exynos-regulator-coupler.o
 
 obj-$(CONFIG_SAMSUNG_PM_CHECK)	+= s3c-pm-check.o
-- 
2.34.1

