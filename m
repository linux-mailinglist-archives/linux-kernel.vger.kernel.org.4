Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542C66E5CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjDRJEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjDRJDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:03:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07E54EF7;
        Tue, 18 Apr 2023 02:03:26 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v10so8523949wmn.5;
        Tue, 18 Apr 2023 02:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681808605; x=1684400605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oM8GpGbGiC8m3xETpqZOKVCeTGKwMkImG6hLD6+J4YY=;
        b=ctxsXyNnKMhP95P4Hk+NQVH7kFsUxogvu2M9hpBDmk2zks8C/0mUeEu7nvWTh4FjxH
         QNdXdKZYlV/toXwg3YBYysppewAJhmYXPksk5qNDVyUzN1pUDaaPtww0qIka5SbAw18z
         l3C5YWND3LquNZG6OIEoOgqhFDtB66aFqHc+CDb3lHhmiU25Vw4wgYeAz+2km3Mx/d1L
         Q9eqdQQ5lKBhQe5sgtUr0nwdsmsygbom3qNSz9Jada1rk06b8FLW0+9Tua+wVDAhkVP+
         ku78bLqiYA0DaR4MYSb3hjR++0I70LMxpekh96Mfdjz59oUbL8BXLKahBFKq74SHDU87
         bF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681808605; x=1684400605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oM8GpGbGiC8m3xETpqZOKVCeTGKwMkImG6hLD6+J4YY=;
        b=j+kNSgnZ+Wz8hUwMqLc19ZTpfz+HbIX6AWYB9BtBSjGsjBgJpSerN0P8M0RZ+3wUry
         ziJHSHIEScWWYK5LdkREGKxmWINNv2YZu3a1BJhhL93OWbvoLgtnND0a+OdXp+QevA6F
         aYFfy9oDcF1exckXTdIH6JhXWS+z0TwUAC+K8kmSrlgX8JT9VyLfOTcAI5rY8Oqcvy5x
         WI+VdMsu01/6RGRQXHy4+W4ItudtYL3dUrt9pskAa9rxHQk00QHqjrltxCfidDtYOoor
         +x4qTCMRo7EF+eypN82L0kMXuFGJT67uPJZpZwTsazvLAWGz8FBueFzRijXw0Y7KWBk7
         Q0ig==
X-Gm-Message-State: AAQBX9cOOKSwakoEM9ZIf7m7zbUJVNwUhIo1EDQ5BMKBPDfg89fWbJbP
        5/MFqdYrdRsTajNkBcwTviBzVNoXuIw=
X-Google-Smtp-Source: AKy350ba2UVFuOG+JFOM810cCwXF9qurZCiipIbtykJbm4w1Eypd53rHW1F0rfXI/P4TwSF8P1/8Ng==
X-Received: by 2002:a05:600c:ac8:b0:3f1:6fe2:c4b2 with SMTP id c8-20020a05600c0ac800b003f16fe2c4b2mr5968273wmr.23.1681808605051;
        Tue, 18 Apr 2023 02:03:25 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id u7-20020a7bcb07000000b003ee70225ed2sm14341109wmj.15.2023.04.18.02.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 02:03:24 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH v3 8/9] mips: ralink: get cpu rate from new driver code
Date:   Tue, 18 Apr 2023 11:03:11 +0200
Message-Id: <20230418090312.2818879-9-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230418090312.2818879-1-sergio.paracuellos@gmail.com>
References: <20230418090312.2818879-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At very early stage on boot, there is a need to set 'mips_hpt_frequency'.
This timer frequency is a half of the CPU frequency. To get clocks properly
set we need to call to 'of_clk_init()' and properly get cpu clock frequency
afterwards. Depending on the SoC, CPU clock index in the clock provider is
different being two for MT7620 SoC and one for the rest. Hence, adapt code
to be aligned with new clock driver.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/ralink/clk.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/mips/ralink/clk.c b/arch/mips/ralink/clk.c
index 5b02bb7e0829..3d29e956f785 100644
--- a/arch/mips/ralink/clk.c
+++ b/arch/mips/ralink/clk.c
@@ -11,29 +11,41 @@
 #include <linux/clkdev.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <asm/mach-ralink/ralink_regs.h>
 
 #include <asm/time.h>
 
 #include "common.h"
 
-void ralink_clk_add(const char *dev, unsigned long rate)
+static int clk_cpu_index(void)
 {
-	struct clk *clk = clk_register_fixed_rate(NULL, dev, NULL, 0, rate);
+	if (ralink_soc == RALINK_UNKNOWN)
+		return -1;
 
-	if (!clk)
-		panic("failed to add clock");
+	if (ralink_soc == MT762X_SOC_MT7620A ||
+	    ralink_soc == MT762X_SOC_MT7620N)
+		return 2;
 
-	clkdev_create(clk, NULL, "%s", dev);
+	return 1;
 }
 
 void __init plat_time_init(void)
 {
+	struct of_phandle_args clkspec;
 	struct clk *clk;
+	int cpu_clk_idx;
 
 	ralink_of_remap();
 
-	ralink_clk_init();
-	clk = clk_get_sys("cpu", NULL);
+	cpu_clk_idx = clk_cpu_index();
+	if (cpu_clk_idx == -1)
+		panic("unable to get CPU clock index");
+
+	of_clk_init(NULL);
+	clkspec.np = of_find_node_by_name(NULL, "sysc");
+	clkspec.args_count = 1;
+	clkspec.args[0] = cpu_clk_idx;
+	clk = of_clk_get_from_provider(&clkspec);
 	if (IS_ERR(clk))
 		panic("unable to get CPU clock, err=%ld", PTR_ERR(clk));
 	pr_info("CPU Clock: %ldMHz\n", clk_get_rate(clk) / 1000000);
-- 
2.25.1

