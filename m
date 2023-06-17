Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36D7733E5D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 07:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjFQFZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 01:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbjFQFYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 01:24:50 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E62E1FD3;
        Fri, 16 Jun 2023 22:24:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3112902f785so311189f8f.0;
        Fri, 16 Jun 2023 22:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686979487; x=1689571487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oM8GpGbGiC8m3xETpqZOKVCeTGKwMkImG6hLD6+J4YY=;
        b=mwSgJMaRHXaoJE51Kb/zfV5fhx/XDb0SS6uteUAMO1XeNQXwwxHRzjo0tGzrcDpl2o
         BkfHZ67hO6vO7EaLVBPd41C75ezSrmgyY1+VlmUk3snVkWoTebbdz081cX1TFJQCfCvC
         /c1HHkT4V/pxP/92iPVpsBsCVIKQde9UTlsMa2ZumqF7h7gPppGUA+zQ7nKtkVE+UODK
         7Q7FVZN8jdMg9+NKvdZ/tI/jRoII9N+SLD0rVvbMo6W8t5Q2WE+NlK/NW1bH/hj0u+MP
         7zGssjDUSWg8v2IaPurzraVrX/jv/7glYuQaMfu6PqhWHyigiIbNuRM7/UxUUsPI/4ym
         Q2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686979487; x=1689571487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oM8GpGbGiC8m3xETpqZOKVCeTGKwMkImG6hLD6+J4YY=;
        b=AN1b6VM5ckoBL+tFfZC7BgxcvGeGPUjGIEOA2cq6P5Hh/KJlAH2DGimdZJ080robDh
         8iTxOMHAiyWMbJ75YVj3ylcEC/Bv63o/nA0SF3pkkSJ71+JFEyOAaGp8IUx1okqiybdQ
         5KZgMbRHVrG0QxcylShA6dC8A1XEalJCqPosVZDNsxOzdc/bIu03p162hJzc5U7zHNys
         PGZNncE/1olcJORzLCf7RjPMHnJm9W+xMI8c5XkUJp7F0r5NGoz/nlgYvRmKeXCOX8+g
         UwQ5nM6/Qy9cKOOrNjhwePlNr+AAqiPuL0OD/+XOANPjDJ6FfuI2jcC+HurrTYiMW0z2
         9SJg==
X-Gm-Message-State: AC+VfDwXfE54jMXvVU2zxJIfGaaAuSjnkNzBc0D/VtGfGZGGcrptRb36
        h7kbbeUxCTjMmn/L/gzuBH7/bIrQHTM=
X-Google-Smtp-Source: ACHHUZ7wBgaUXg2hQK3jUZtSHd/HGoWuZ908/0F2SDnGcFg05XdS13pQYEPtuoFtL/03aikAgvXFjg==
X-Received: by 2002:adf:dd8a:0:b0:30f:cdf7:9f05 with SMTP id x10-20020adfdd8a000000b0030fcdf79f05mr8373495wrl.27.1686979487238;
        Fri, 16 Jun 2023 22:24:47 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id a3-20020a056000050300b003068f5cca8csm25198228wrf.94.2023.06.16.22.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 22:24:46 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH v4 8/9] mips: ralink: get cpu rate from new driver code
Date:   Sat, 17 Jun 2023 07:24:34 +0200
Message-Id: <20230617052435.359177-9-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230617052435.359177-1-sergio.paracuellos@gmail.com>
References: <20230617052435.359177-1-sergio.paracuellos@gmail.com>
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

