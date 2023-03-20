Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC846C1B78
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjCTQ0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjCTQZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:25:14 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC7F14E85;
        Mon, 20 Mar 2023 09:18:41 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o32so1514550wms.1;
        Mon, 20 Mar 2023 09:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679329121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oM8GpGbGiC8m3xETpqZOKVCeTGKwMkImG6hLD6+J4YY=;
        b=pqleI3/sbRl1vdeDzJoXM09C5CNbpQRJL/JmaJCOrR6ozCxtu3pEf/4fSlOV3r5B3x
         xkRLcOYP25jC8DIpfDzB0CY5HS+pzHWsNy0tFXkcolvnk5kOLanKXSg3AjI1h0KH7hqs
         5vTlBiEK3K/ATnoC19YgQKcCOwizsOvhLe1WUW7J+UAcKFImlhUpxB2yN4hrLwlRXmrn
         SyBMfBGnAplxlMswPy5dXBaDhf6M0y3WJOBjp0HH7JRouABMCF5GakS+O+aqYjp4revp
         eTQ7bE3fS2CiuFCJpRrjZ9+jMzf41ye7hWdy9DwhWeX1lv/VZ5OQeaeG71UfBLcpl9yB
         hkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oM8GpGbGiC8m3xETpqZOKVCeTGKwMkImG6hLD6+J4YY=;
        b=Z3IahHBhaGopOPodkp2hva2F4XR+LbgKoPZDhm/dZ9RTyZ7u3rHDrgmo4CKvU8dKxz
         gNOG8cQ0k0DXNpkC4bMGt4RBMZpmlKqwESQ1BscvJE/bR9eGIoY/WVeV0mNC8Pa/PzUC
         /wQbdKcdkO0kkNWhK6ZE5Hm6DYlHSIJGXsjO12e2U44HQ7RuBd8SxOgZ+JaYAhYU6NhM
         iBNh/GboVnlzcfbxrNfIETc8N7VLfYqYFQ7mZXBhOGmNaD6eNfsvfSRApfXSPHDHptVJ
         pkKA+fRQP9SzhXVcUglLbyTodzFpacm9iKaxoO8YmPlwJE0V0oD6Jdv1xvzpYtCxIjmV
         gomQ==
X-Gm-Message-State: AO0yUKWkPHPfXW/v5SLUoXnbevUqumExrkEl+Od0tRBPSSuouT6ONTXM
        Ope5udFook+/lj/EiKsd13qR/eE5CEE=
X-Google-Smtp-Source: AK7set/ebkMAtb/OC+EwXIR1KGDkJgBk8R+DvG5xZiO9rKE4WvacMxeNV2sAqH1/UVYoplZ5pY2fkQ==
X-Received: by 2002:a1c:4b10:0:b0:3ed:e5db:52e1 with SMTP id y16-20020a1c4b10000000b003ede5db52e1mr76491wma.15.1679329120691;
        Mon, 20 Mar 2023 09:18:40 -0700 (PDT)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b003ee1acdaf95sm847776wmb.36.2023.03.20.09.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:18:40 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH 09/10] mips: ralink: get cpu rate from new driver code
Date:   Mon, 20 Mar 2023 17:18:22 +0100
Message-Id: <20230320161823.1424278-10-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
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

