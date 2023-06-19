Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF7D734B05
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 06:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjFSEKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 00:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjFSEKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 00:10:02 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BEE136;
        Sun, 18 Jun 2023 21:09:57 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f76a0a19d4so3608809e87.2;
        Sun, 18 Jun 2023 21:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687147795; x=1689739795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYtDZyF0WoEWQ1plW2ceJSRw4b2t8G0Pprfn6lRFwQY=;
        b=fMwUIgG9I8eZar1K6k9TKYp6nYtLYLmJrqtDvhVj+jg7gnYtJ3QYDKlkBvckg7gXkd
         foKwcbTga478MAG9WaunjZYidYNGadZhuU5OF3CEtblRevUtrd0tbPIMsTrIebxOzKMZ
         0aCpRWTjsW8FRX2c1aZpirVOyeZFz2FdxgWsxWuKIFCO9KsCxYqkLSBIP5ug8dukzodn
         /SMW9F+PJq5hRMssaaRF/19ELicxlSP2YT0UhhF6xRrjHOWVbI/KUidLRCHr0MATNvuz
         PFNDNnpesNgCcBji67f/lw1r9G8Okn6pfxO9BgSUXi+pMSJp6e6Fd3xtAx3aoD7KakNo
         wkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687147795; x=1689739795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYtDZyF0WoEWQ1plW2ceJSRw4b2t8G0Pprfn6lRFwQY=;
        b=CL0EEBZs7cgtDwqUEPERnswbxB0LBXHvKOjrRCCaMSSVP5eda2nnqT+Rx2CeOdNgyA
         ifJtcsGwyYr7Od3QrpjUkhh6yYF67sPh0YHKOJUa/zTk3Oe1IpWyz/9czTCixfNajnBW
         n3MWYdgZ1geeKgZBLhqGrzK6biIl/o88awptU8ookyHNQzg9BEvdQZUSvrfi44ulO51r
         bXZm+d6uBQf1haj5Nc6lmRe9NjkAabuNMoDMCqU4aT8mtCR4tXbwWx4DkMzN69Av14eC
         0h5lUobDv4CSsWJid8s6u4u6PQc2PLm/GOAtnh5BKgxrh/3k7aqDcM0mvvgZGhUOyUQ1
         SqVg==
X-Gm-Message-State: AC+VfDw1WZFjfR8yAFwNMonlEM/xtTucJq0Ng396YqrlPkGVpIaNToHL
        qJxhKTT7VT4c7f+MUSkEUbm3nv4bC8U=
X-Google-Smtp-Source: ACHHUZ4oGXxUm6faTWmGR4k58VgP8mrIDXFKieK8hPsgHjzCraQ2Dpjef1Bv+KCKIALaUndcpBDYqg==
X-Received: by 2002:a05:6512:3290:b0:4f7:5f9e:fc59 with SMTP id p16-20020a056512329000b004f75f9efc59mr4235673lfe.39.1687147794901;
        Sun, 18 Jun 2023 21:09:54 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d6e0e000000b003078354f774sm30004052wrz.36.2023.06.18.21.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 21:09:54 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com, yangshiji66@outlook.com
Subject: [PATCH v5 8/9] mips: ralink: get cpu rate from new driver code
Date:   Mon, 19 Jun 2023 06:09:40 +0200
Message-Id: <20230619040941.1340372-9-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619040941.1340372-1-sergio.paracuellos@gmail.com>
References: <20230619040941.1340372-1-sergio.paracuellos@gmail.com>
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

At very early stage on boot, there is a need to set 'mips_hpt_frequency'.
This timer frequency is a half of the CPU frequency. To get clocks properly
set we need to call to 'of_clk_init()' and properly get cpu clock frequency
afterwards. Depending on the SoC, CPU clock index and compatible differs, so
use them to get the proper clock frm the clock provider. Hence, adapt code
to be aligned with new clock driver.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/ralink/clk.c | 61 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/arch/mips/ralink/clk.c b/arch/mips/ralink/clk.c
index 5b02bb7e0829..9db73fcac522 100644
--- a/arch/mips/ralink/clk.c
+++ b/arch/mips/ralink/clk.c
@@ -11,29 +11,72 @@
 #include <linux/clkdev.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <asm/mach-ralink/ralink_regs.h>
 
 #include <asm/time.h>
 
 #include "common.h"
 
-void ralink_clk_add(const char *dev, unsigned long rate)
+static const char *clk_cpu(int *idx)
 {
-	struct clk *clk = clk_register_fixed_rate(NULL, dev, NULL, 0, rate);
-
-	if (!clk)
-		panic("failed to add clock");
-
-	clkdev_create(clk, NULL, "%s", dev);
+	switch (ralink_soc) {
+	case RT2880_SOC:
+		*idx = 0;
+		return "ralink,rt2880-sysc";
+	case RT3883_SOC:
+		*idx = 0;
+		return "ralink,rt3883-sysc";
+	case RT305X_SOC_RT3050:
+		*idx = 0;
+		return "ralink,rt3050-sysc";
+	case RT305X_SOC_RT3052:
+		*idx = 0;
+		return "ralink,rt3052-sysc";
+	case RT305X_SOC_RT3350:
+		*idx = 1;
+		return "ralink,rt3350-sysc";
+	case RT305X_SOC_RT3352:
+		*idx = 1;
+		return "ralink,rt3352-sysc";
+	case RT305X_SOC_RT5350:
+		*idx = 1;
+		return "ralink,rt5350-sysc";
+	case MT762X_SOC_MT7620A:
+		*idx = 2;
+		return "ralink,mt7620-sysc";
+	case MT762X_SOC_MT7620N:
+		*idx = 2;
+		return "ralink,mt7620-sysc";
+	case MT762X_SOC_MT7628AN:
+		*idx = 1;
+		return "ralink,mt7628-sysc";
+	case MT762X_SOC_MT7688:
+		*idx = 1;
+		return "ralink,mt7688-sysc";
+	default:
+		*idx = -1;
+		return "invalid";
+	}
 }
 
 void __init plat_time_init(void)
 {
+	struct of_phandle_args clkspec;
+	const char *compatible;
 	struct clk *clk;
+	int cpu_clk_idx;
 
 	ralink_of_remap();
 
-	ralink_clk_init();
-	clk = clk_get_sys("cpu", NULL);
+	compatible = clk_cpu(&cpu_clk_idx);
+	if (cpu_clk_idx == -1)
+		panic("unable to get CPU clock index");
+
+	of_clk_init(NULL);
+	clkspec.np = of_find_compatible_node(NULL, NULL, compatible);
+	clkspec.args_count = 1;
+	clkspec.args[0] = cpu_clk_idx;
+	clk = of_clk_get_from_provider(&clkspec);
 	if (IS_ERR(clk))
 		panic("unable to get CPU clock, err=%ld", PTR_ERR(clk));
 	pr_info("CPU Clock: %ldMHz\n", clk_get_rate(clk) / 1000000);
-- 
2.25.1

