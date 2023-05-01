Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C32C6F38A7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjEAT4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbjEAT4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:56:09 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFC72716;
        Mon,  1 May 2023 12:55:47 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-95f4c5cb755so582641866b.0;
        Mon, 01 May 2023 12:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682970945; x=1685562945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZF9V8MP6FMsrIXcptSFMR5OUYRqz1S+wnIjX1bjUvo=;
        b=HaOmIqvmk1JHA/KItZj3I55JN+ZBTUXiADiAmo6feTqkUk6J7XUJrXbeu8Gfq+GcTF
         z9BVKGIe9337gLP0hBF/KU3cMJ4jTkeKl7lXTngVTG2FbKId5KXo76Jpm9XIDW2u+vNP
         a9SXdnNOp1VT2VTr8XVoU0VeHTGaiZsaktaO8p4givJ2qe1xEwviZZmap6qLbXeS7B41
         lqOu2cXoVrk9RVPGtpxh9x6yGMiUYOW6sPoBX0LCnrClCq+o8uSeiki5RdY1BR/1/i8r
         ogzmy9eUjQO+qB3AIu3tMpuOwZtzn/OA+ejlvJ967tLUTXmoE2QyjKcMoqad8iG1c5t0
         YMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682970945; x=1685562945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZF9V8MP6FMsrIXcptSFMR5OUYRqz1S+wnIjX1bjUvo=;
        b=Eolh8XxfkyWiiCU7l1wd7+YXtOj7HPNQ3HGgOMgtECrRfss7UnN9PwIze7QG8m6Tjq
         lMX45DnXWIU8vvzMlJDjLzWfMFT0eTOSBkPp+6KRkxCNVccgEZ9iV6xv1Nd/RiQejhIE
         gyYl/PGMY8t6pu23chfTH34yajrBcltQplgJ7JxJWmpOqXO+r8DdtHbIMc4gEs0u0JOf
         oz5ZGjfWHrqkpjDc0U7sgn1nYq3l+XnsZTmk1m2GpCNlzs2JAs87uZLX7eRDzGR3ElE1
         4JzdrTaNDDYK7iod6G5TLobgZwwSvGQDG4vuBNHpNKe2qBzI586aRi1QJp29SFQRNjt8
         wKyw==
X-Gm-Message-State: AC+VfDxJ4purmkW6NLcJyaPJfYk1VfeLzQEDnhvTWF67T0ufus/BODnY
        iTnTdo9OOwWWfCaUBU34ZIc=
X-Google-Smtp-Source: ACHHUZ6+S0BN/oZ+tDA58xehKEFG9fQFSkwXItwRKWNM24ayj85NNvyjS0h6IsMI7XCGkixpp/NRNA==
X-Received: by 2002:a17:906:5d0b:b0:94e:4523:b0d8 with SMTP id g11-20020a1709065d0b00b0094e4523b0d8mr13675831ejt.73.1682970945314;
        Mon, 01 May 2023 12:55:45 -0700 (PDT)
Received: from localhost.my.domain (83.8.115.30.ipv4.supernova.orange.pl. [83.8.115.30])
        by smtp.gmail.com with ESMTPSA id og36-20020a1709071de400b009600ce4fb53sm6333650ejc.37.2023.05.01.12.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:55:44 -0700 (PDT)
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
Subject: [PATCH v3 07/13] Revert "media: exynos4-is: Remove dependency on obsolete SoC support"
Date:   Mon,  1 May 2023 21:55:19 +0200
Message-Id: <20230501195525.6268-8-aweber.kernel@gmail.com>
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
it back.

This reverts commit 2d41a0c9ae51ac363d107f2510022106e7234b33.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 drivers/media/platform/samsung/exynos4-is/Kconfig     | 2 +-
 drivers/media/platform/samsung/exynos4-is/fimc-core.c | 2 +-
 drivers/media/platform/samsung/exynos4-is/fimc-lite.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos4-is/Kconfig b/drivers/media/platform/samsung/exynos4-is/Kconfig
index da33faa7132e..7f9ba053dd8e 100644
--- a/drivers/media/platform/samsung/exynos4-is/Kconfig
+++ b/drivers/media/platform/samsung/exynos4-is/Kconfig
@@ -47,7 +47,7 @@ config VIDEO_S5P_MIPI_CSIS
 config VIDEO_EXYNOS_FIMC_LITE
 	tristate "EXYNOS FIMC-LITE camera interface driver"
 	depends on I2C
-	depends on SOC_EXYNOS4412 || SOC_EXYNOS5250 || COMPILE_TEST
+	depends on SOC_EXYNOS4212 || SOC_EXYNOS4412 || SOC_EXYNOS5250 || COMPILE_TEST
 	depends on HAS_DMA
 	select VIDEOBUF2_DMA_CONTIG
 	select VIDEO_EXYNOS4_IS_COMMON
diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-core.c b/drivers/media/platform/samsung/exynos4-is/fimc-core.c
index 1791100b6935..e2f394e60dee 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-core.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-core.c
@@ -1129,7 +1129,7 @@ static const struct fimc_drvdata fimc_drvdata_exynos4210 = {
 	.out_buf_count	= 32,
 };
 
-/* EXYNOS4412 */
+/* EXYNOS4212, EXYNOS4412 */
 static const struct fimc_drvdata fimc_drvdata_exynos4x12 = {
 	.num_entities	= 4,
 	.lclk_frequency	= 166000000UL,
diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-lite.c b/drivers/media/platform/samsung/exynos4-is/fimc-lite.c
index e185a40305a8..f80047095f30 100644
--- a/drivers/media/platform/samsung/exynos4-is/fimc-lite.c
+++ b/drivers/media/platform/samsung/exynos4-is/fimc-lite.c
@@ -1619,7 +1619,7 @@ static const struct dev_pm_ops fimc_lite_pm_ops = {
 			   NULL)
 };
 
-/* EXYNOS4412 */
+/* EXYNOS4212, EXYNOS4412 */
 static struct flite_drvdata fimc_lite_drvdata_exynos4 = {
 	.max_width		= 8192,
 	.max_height		= 8192,
-- 
2.40.1

