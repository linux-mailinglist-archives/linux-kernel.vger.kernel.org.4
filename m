Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA9C6C0F82
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjCTKnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjCTKmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:42:46 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BB327D4B;
        Mon, 20 Mar 2023 03:40:59 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so11926029pjb.0;
        Mon, 20 Mar 2023 03:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679308825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTx1RTgcMpJdUT9XB22QQmexAtSw6sIUctVzKqjmOSw=;
        b=aTAxsIJ3LKUVrBItSTu1Ub9c+RrV6Z02CLMeqcAxDnbPaOZASIk17COuGg0grIKKJR
         /msLMOicVfolaiGsRcbwIJFx4jdDXidaJmR4Eahv2fFmhojiydOfcnEa7cnHxsR2EKSV
         +gBtcw2L6RL9Vka0nY4AJtaTZlmFTkpiFKDFrGjdvA20iFO+vD4kJs0/LzCNue6rCz7v
         XY4IU38Hi9Ruhxj+95/V+Dlb8lx3ADT8UXvxryUrxl1LuKwcoPWYrO9PG31yM+1RNg2D
         sttn8dfnjkewOsrNO83aGLyPHs0FxsvbF5FbXDaGn5hW/6kg2JgpDeKUoJnliO0Q5oEQ
         EyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTx1RTgcMpJdUT9XB22QQmexAtSw6sIUctVzKqjmOSw=;
        b=MGX3vMc9cDfRt5Q/DT5lbGsI8RvQ5S4W0duXvaHw/n+/jxos4UmcEhB2EmAZwRxC9Q
         eYUT5MfMJNhNN+57o8iONk+ekBoda6kv6NX86V6BO0bSdN4KDst024EHE6mJhK94vql/
         Semziow58a54ftsG51bx+x30JMz7sXgjiMgfgDXML1svw7TflONQiBjxkJpJfzQE3QSv
         Z/+FIHQMcFU8D2mgoXrHUkFVEmOCLFwFBbFagSZY/eWIRabsdO8IlLtC6cQbDCVVl3Tt
         VRFFXU1aPi1Lr9M1iSax6XqZyp3EQhRg/8XInCZo+CH/xc8B1cOjk5znDl0nkRfmWLv1
         BGRQ==
X-Gm-Message-State: AO0yUKWds8AedOzrzn4qp8YOZho2bikcQsyIdVyDEvlmz8jfRom4UkJm
        IzrdxUU/wOQ5dC7Y2KKjX4cKBM6w8Jo=
X-Google-Smtp-Source: AK7set9usRFhUHX9GCCIP+uLhLKxBOiOiRvmudbbn4l09HOx+I6TGwYrKFlv5AcbZuXLVkCbUIFHOg==
X-Received: by 2002:a05:6a20:b81f:b0:d6:e295:7dbd with SMTP id fi31-20020a056a20b81f00b000d6e2957dbdmr12749672pzb.28.1679308825581;
        Mon, 20 Mar 2023 03:40:25 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id e17-20020a63ee11000000b00478c48cf73csm5922535pgi.82.2023.03.20.03.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 03:40:25 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v4 4/4] MIPS: loongson32: Update the clock initialization
Date:   Mon, 20 Mar 2023 18:40:03 +0800
Message-Id: <20230320104003.407844-5-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320104003.407844-1-keguang.zhang@gmail.com>
References: <20230320104003.407844-1-keguang.zhang@gmail.com>
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

