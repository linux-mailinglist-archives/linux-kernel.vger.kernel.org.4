Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AE66BCD37
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCPKsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjCPKrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:47:52 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83731BE5E5;
        Thu, 16 Mar 2023 03:47:35 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id x37so648347pga.1;
        Thu, 16 Mar 2023 03:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678963654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fN3Gy/q/ROltRj7J+tAnlAlwoyPhTrdOdavHnYVZxvY=;
        b=N1lmQSw69vl53i59yOsOt26IWJZAgCGAqRqIm4+t8wAFQHtA5tSz7H1S9PPjsBsmr+
         1jvqLKHCAjVI+rLSj1jgL9lHRJ3A5aVJtHfbAxJ2z+VUaIvSPF9cblsjdPJcJ5oD2rlU
         4dRn1Z5EHmbSmVWrNhGC09MPPe5IbA0WxlrLkFMpJJ9XgxwN9ASSlR9ovnPqLE3Ze+L/
         rL9VOgE6x8Le4ZbeTKrcJJESvgnqQgeqPOmHncGR9IOkTESp3Y+ogU23ht/vIbhHQVmn
         MV0Qi1d44Le3gnngzB7J9XB7jk+IDVxVUlF0Cc6Dn01qRcDzjMsO3rKNFr1xyI13uuRD
         i/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678963654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fN3Gy/q/ROltRj7J+tAnlAlwoyPhTrdOdavHnYVZxvY=;
        b=fWYgEGJxqmQGpEzIx2/E4wNoeW1envaHPGNP9AQTdqLLX4E7P0Ri9HOxwkCoKDLk2O
         Bq2FJOmIOIn2GPuSWYOIO9qFHfWwyWanBZLG/PYhm4mEU64XeKy8Z9W2NUVM9RAXloq6
         uWgKCXD8YUvCQp254X8aFUX6/rS2AtAZibSdeU5xUZ0SLo2zNkQwk/h/McDpRtMis/kg
         VtDUuduDigq12eCCckEYfvPHv+fXya5Af8sMaboC0MMutLuVQB1idC3EwnYcgh6IZJeZ
         g6lQvktaDs2kxg50lluJh3GjLdAId3KfiOuf+1fHxHp6xErgP7/6HkeBbUEdO6vBWm9q
         m8cA==
X-Gm-Message-State: AO0yUKWdYwd6/XuA49j6citDuVmo4jwOEMLV29hmcMDRVdZ3w6EhwenT
        HjFBXbrxTRlMNc3JR1mUfjGzgZ7LAsRZkg==
X-Google-Smtp-Source: AK7set9fDPEuIUSuBy66rQSPu01HWrD6bc8RXkq2wZtUz8RLOPY1or5svlsEg6YYJoW3DtohKh8XNQ==
X-Received: by 2002:a05:6a00:2e8a:b0:625:8d3e:34ff with SMTP id fd10-20020a056a002e8a00b006258d3e34ffmr3416209pfb.12.1678963653773;
        Thu, 16 Mar 2023 03:47:33 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id f11-20020aa78b0b000000b005d4e89b69e5sm5143263pfd.127.2023.03.16.03.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 03:47:33 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v3 4/4] MIPS: loongson32: Update the clock initialization
Date:   Thu, 16 Mar 2023 18:47:07 +0800
Message-Id: <20230316104707.236034-5-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230316104707.236034-1-keguang.zhang@gmail.com>
References: <20230316104707.236034-1-keguang.zhang@gmail.com>
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

