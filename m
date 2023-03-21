Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3236D6C2987
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjCUFBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjCUFBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:01:05 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FCC28D25;
        Mon, 20 Mar 2023 22:00:48 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id p13-20020a05600c358d00b003ed346d4522so8727889wmq.2;
        Mon, 20 Mar 2023 22:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679374847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oM8GpGbGiC8m3xETpqZOKVCeTGKwMkImG6hLD6+J4YY=;
        b=GfRBIcpe3wFNdHmhexJwF7JilSuXtkvzLBf8rdiQVvXhG5EPxSRgNak5MWg1O7f9VP
         QiZ5iwBFX1gZwsa+r5FrGnNSrnBgemWKXY0utmECwMZArVW2ATKhGK8+AMGf9rbFWaE1
         hpMWsVMuNwP0M2xAXq8XJ/2un4B2mie3V4AbNn0ZMM+UBuWm6NNNEZVlrMdLkzg74ooh
         4wwxIRdOj4ecLpQq7eorfk8QtvKC0iYR8ZyLXYhUkKu42eM+1UQcoJ2j4K4XpaVZo7T4
         gsoEiVW6CpujiFCt7WV4XfyLvV+zaTpFSBgpe+NU4G0PLa0LTA21baJju06Sv8tb2tMp
         v2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679374847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oM8GpGbGiC8m3xETpqZOKVCeTGKwMkImG6hLD6+J4YY=;
        b=yPJoSh9QAUr+FB/+x0IWlRdv8kL2haGM1CZnFD8+hD0GGdxoI8BIG9ZLqGLELJ6Q5p
         JoKcmLk2ZxkguvCndEPvuAJIGodKZ2roWWq8fl/6LkNxIcZD4IivGi9CdQt4Deqst0Bz
         8SUfeOG6m3w6NrH1XTbK4ZqRRZOQHVNmYJaS5WPTlUuvDuET7LAgsy8iXkI741NqxFbk
         NgFlkkIsO1lDYEFjM36o4ZvcDsqWqq9kkqTuhHFvIluGEtU0oqhrqFtljGVLjMlxqw+H
         PkyNGgApYa24HIOqe7v3+DwCK/onkBy9BO+5GwsDpKdzrlue+Rvj2uKnJAIdkyR5d0nI
         5QKA==
X-Gm-Message-State: AO0yUKWWG8r6+kTBGL2rrLsG7OT1LPF4VJgEqTA3QeGfkDIo1kegy+Mv
        m32EKStTdpDGnH0P9k0ObiNzK+sU+0k=
X-Google-Smtp-Source: AK7set8HBXWS/FYkcRKE3pknFN6YBcSsisaXT198uTqdLgQGJavlJmTYeuzoxwj+VJqh+g7goG9/pA==
X-Received: by 2002:a7b:c00b:0:b0:3ed:2b27:5bcc with SMTP id c11-20020a7bc00b000000b003ed2b275bccmr1286063wmb.38.1679374847534;
        Mon, 20 Mar 2023 22:00:47 -0700 (PDT)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c020300b003eddefd8792sm6238432wmi.14.2023.03.20.22.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 22:00:47 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH v2 8/9] mips: ralink: get cpu rate from new driver code
Date:   Tue, 21 Mar 2023 06:00:33 +0100
Message-Id: <20230321050034.1431379-9-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230321050034.1431379-1-sergio.paracuellos@gmail.com>
References: <20230321050034.1431379-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

