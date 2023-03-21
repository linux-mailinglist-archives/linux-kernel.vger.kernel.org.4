Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9106C3032
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjCULTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjCULTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:19:31 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F9935ED1;
        Tue, 21 Mar 2023 04:19:17 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so15904762pjp.1;
        Tue, 21 Mar 2023 04:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679397556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNSI1SuiKT5NcaoyUjFy5BZ+DYkIivWoxiRtmrSmg6M=;
        b=DheE77XXkMzxdoLM+Rho12tc06/LYOxBOoccNlrMJzBJ4kwONz0voLdobOffPDw7jn
         n9VtdvtrCXhb/0AnFw1H/psUhhhZIZ3tTj0Rm4fX/TGURkksrMpCYgJPRFb3m2AtVeRC
         /YdJH4TRvan28xuB+8Fvxpw7PdhlqD/jFKsatMHI528fUTao+5rpCtrqWvzQMGZs7Spq
         O2JsRobiddodGnn+lgJ/zMzCi6b/N2GmkdvSHppgsqdgiLpI6L2vOMVl68IHTUDF1524
         6Lr4xLIcwlf0pN6BeR39HKs4DCx9xayO43hUxZYI0uh8F8GzgYGwmRvzSMw3P66E9hL1
         /jRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679397556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNSI1SuiKT5NcaoyUjFy5BZ+DYkIivWoxiRtmrSmg6M=;
        b=kNML2r+sGKBPW/kt5PtlDmGt4NA7NPQuLyP0pP44KfdSLXM3TELj5trbMX9A2EFtwa
         Ve3zXCAU0YasiSpXlN1RoTOrd3/L1uMXXBFFqdXpZ638+X4/Wd7Rw7uw3Eh5V7Btloea
         1gEQLuCj/TqjqwofrO7HiXsYt3TaLKx1BGq8wyDkSTnKg8YIQJhUOi3DNE9KhcKrepI5
         h00/HETKhxvovXKSQpEUK2brZzo/macn8JyPqD7tdlAzdTN59yxoULwwow5Rbh01EK5+
         LnBwt8yIgzxmMhK9AhP8SFDtwweeAfv73VbKU2D061lcEWhTnmcY28O4ZdyLNfxHzReP
         KvUg==
X-Gm-Message-State: AO0yUKWisZPIzNyw2hg5WX/iL3IilPslx2rUoWFArtybDmfth5NTyJjR
        MGRV472VGmK/DbJrMqnu/xB/jdpHnC8=
X-Google-Smtp-Source: AK7set+icQk0c36jGojI8I2HJKiahfG1uQ5jszldiFanGiJkujVVZH05Rofv47tqwLGfs8T8W2/o6g==
X-Received: by 2002:a05:6a20:6aa1:b0:cc:ca9:4fde with SMTP id bi33-20020a056a206aa100b000cc0ca94fdemr2060766pzb.33.1679397556131;
        Tue, 21 Mar 2023 04:19:16 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id c4-20020aa78804000000b005dd65169628sm8238838pfo.144.2023.03.21.04.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 04:19:15 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v5 4/4] MIPS: loongson32: Update the clock initialization
Date:   Tue, 21 Mar 2023 19:18:17 +0800
Message-Id: <20230321111817.71756-5-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321111817.71756-1-keguang.zhang@gmail.com>
References: <20230321111817.71756-1-keguang.zhang@gmail.com>
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

The Loongson-1 clock driver is under re-implementation
to add DT support. As a result, ls1x_clk_init() will be dropped soon.
Therefore, call of_clk_init() for clock initialization instead.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
V4 -> V5: None
V3 -> V4: None
V2 -> V3: Add this patch to "Devicetree support for Loongson-1 clock" series
	  Add Acked-by tag from Stephen Boyd and Thomas Bogendoerfer
V1 -> V2: None
---
 arch/mips/include/asm/mach-loongson32/platform.h | 1 -
 arch/mips/loongson32/common/time.c               | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson32/platform.h b/arch/mips/include/asm/mach-loongson32/platform.h
index 86e1a6aab4e5..2cdcfb5f6012 100644
--- a/arch/mips/include/asm/mach-loongson32/platform.h
+++ b/arch/mips/include/asm/mach-loongson32/platform.h
@@ -20,7 +20,6 @@ extern struct platform_device ls1x_gpio1_pdev;
 extern struct platform_device ls1x_rtc_pdev;
 extern struct platform_device ls1x_wdt_pdev;
 
-void __init ls1x_clk_init(void);
 void __init ls1x_rtc_set_extclk(struct platform_device *pdev);
 void __init ls1x_serial_set_uartclk(struct platform_device *pdev);
 
diff --git a/arch/mips/loongson32/common/time.c b/arch/mips/loongson32/common/time.c
index 459b15c96d3b..965c04aa56fd 100644
--- a/arch/mips/loongson32/common/time.c
+++ b/arch/mips/loongson32/common/time.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/of_clk.h>
 #include <linux/interrupt.h>
 #include <linux/sizes.h>
 #include <asm/time.h>
@@ -211,7 +212,7 @@ void __init plat_time_init(void)
 	struct clk *clk = NULL;
 
 	/* initialize LS1X clocks */
-	ls1x_clk_init();
+	of_clk_init(NULL);
 
 #ifdef CONFIG_CEVT_CSRC_LS1X
 	/* setup LS1X PWM timer */
-- 
2.34.1

