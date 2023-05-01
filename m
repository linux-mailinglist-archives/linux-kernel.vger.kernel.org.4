Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0713B6F389E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjEAT41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjEAT4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:56:01 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72A435B1;
        Mon,  1 May 2023 12:55:42 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-94f0dd117dcso498374166b.3;
        Mon, 01 May 2023 12:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682970941; x=1685562941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLv8sGaRe8aHSb+AdoBzh5LujY+igvlve60gkCrF8RQ=;
        b=C8DMc4JaKQvEjKgY9hBY4KRgwbrWrCzs43/QY8dxNhRP0YphFClq3AdINz2tDHQkWu
         gMokCSa26p16KAHxdYKlTeHd8qy9WYhXvLhSv6Ad0MKTdfbEmIRFhSiA3ULMZpLJABCd
         ddHvieNBYQB3yNcab8VPPrwNEV6uAC8QyRWJe4jEpizd6st7gKM75djw6xqgQbAIiQr7
         ayrUHj0YgVH9d4aUDDjemsNQ2HrGhXZyNncB2TnMCrt7RlPB2dRhZ/9jhNRT3Nc0VBZD
         mvMfk4u/Vse7gKlpRyBtVsGhn8idQNWAgsUwmZkcM4NZ0rDr8NmOSS5vWkUdXRZLbkmK
         psnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682970941; x=1685562941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLv8sGaRe8aHSb+AdoBzh5LujY+igvlve60gkCrF8RQ=;
        b=IrGrZAIiQUQIJENYgPARYl+xJ7ZU0Djj1jL7rTKyluhheptQGSTXROUxRc6z83kb1t
         bwRS0gbVuImemXlXcHra4ztpR7l6SC3ohzJ+J0XnvuEKSf40pIB+NK2QbVRzEgflK2Bg
         L42RKi/1xhp6a4/SHEWra9Glq2+MTygLoMdGXe7iLBVj2K/04PHPH/i5Aqwp+aYywtLN
         xtDRz35MAjbhK0+LaZwQmF0/2R9ioAOW1iIwJSz7JFUeIlV2KCwsRuHiiXuAtuu0uFXe
         /o1Qsg9W7xc64lqnbwB8AqMf52GuExeRDxge9i0l1/fBiUEEH8iDFuOteLiN2IcLSftU
         s3TA==
X-Gm-Message-State: AC+VfDxwY+dFgnEfRgl3RZG1Tg2m6rvRAsPRSnXP/X/3wrnFYhclRrdC
        v9kAnxDlu9tye1irZH7Sw3M=
X-Google-Smtp-Source: ACHHUZ7ocgZuC4FvvCMO40aJHJVgOYPYQUBdNycXgNijS5wGRU3ojlIhqdgXy5nJafD8RS/+RbwixA==
X-Received: by 2002:a17:907:1c1a:b0:94f:4102:25c8 with SMTP id nc26-20020a1709071c1a00b0094f410225c8mr14074942ejc.61.1682970941016;
        Mon, 01 May 2023 12:55:41 -0700 (PDT)
Received: from localhost.my.domain (83.8.115.30.ipv4.supernova.orange.pl. [83.8.115.30])
        by smtp.gmail.com with ESMTPSA id og36-20020a1709071de400b009600ce4fb53sm6333650ejc.37.2023.05.01.12.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:55:40 -0700 (PDT)
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
Subject: [PATCH v3 05/13] clk: samsung: Add Exynos4212 compatible to CLKOUT driver
Date:   Mon,  1 May 2023 21:55:17 +0200
Message-Id: <20230501195525.6268-6-aweber.kernel@gmail.com>
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

This reverts commit d5cd103b06f9d766295d18798de484528eb120ea.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 drivers/clk/samsung/clk-exynos-clkout.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos-clkout.c b/drivers/clk/samsung/clk-exynos-clkout.c
index e6d6cbf8c4e6..326d5fc58727 100644
--- a/drivers/clk/samsung/clk-exynos-clkout.c
+++ b/drivers/clk/samsung/clk-exynos-clkout.c
@@ -55,6 +55,9 @@ static const struct of_device_id exynos_clkout_ids[] = {
 	}, {
 		.compatible = "samsung,exynos4210-pmu",
 		.data = &exynos_clkout_exynos4,
+	}, {
+		.compatible = "samsung,exynos4212-pmu",
+		.data = &exynos_clkout_exynos4,
 	}, {
 		.compatible = "samsung,exynos4412-pmu",
 		.data = &exynos_clkout_exynos4,
-- 
2.40.1

