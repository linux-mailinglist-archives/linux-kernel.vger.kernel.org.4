Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCB96498C2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 06:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiLLF5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 00:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiLLF5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 00:57:03 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAE4F4C;
        Sun, 11 Dec 2022 21:57:02 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id kw15so25214427ejc.10;
        Sun, 11 Dec 2022 21:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:mime-version:message-id:cc:cc:cc:cc:cc:cc:to:cc:cc
         :subject:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2zkeYUz7U/xhI7hB3XZxYQs9NMpqoObeUlI6eDOGe6U=;
        b=K2bwvVAIKo2L/MNR+mHwdB1t0RDOpGEaWihkon/5Ro41X36b3TYft2P6X6KAsmxqXp
         3AkZifhQJepsjl6j2K79s/TUbiOrpp8gF4wrRKCC/yk+Tr06srm/T5Gob33T2wG5XTUD
         2G6eD2bglhVnQa8xk8FYMn5UJ0FDQn1Cx8qShuy1N9XYCnP65hmj1UIuoMEhZf6L/A0R
         PhH5aY+pJf1Rv+zxiSU/P3z9ARnCSPXW/pzOBgCTlcK1tl3SFuntV17jV0SJaPfpw3rv
         uiBhOTbs1OrTUm0RDVAAXKZTz4O731c2BtEGzF0AOFeK4d3wTtN/EPDHAr42/X7zVthS
         srzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:mime-version:message-id:cc:cc:cc:cc:cc:cc:to:cc:cc
         :subject:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zkeYUz7U/xhI7hB3XZxYQs9NMpqoObeUlI6eDOGe6U=;
        b=KjXWzhhDfaDJ5wVmnWL4lj7Pv6oSnDHEldOzKUykChZNqCY8snsrj54KPAdZ+QlFLY
         uKDF8HH8fg7qaii9Iaqnpbq8qH1K320w17lB0V/gQxErzVTUocssH7jXLAovlYvswNld
         d9awLwgIcIMvgyjNrc98l4quPb0mM06fn5Z1ovJ+M0jxd11S9TIti67iAKvu0t8/OY3S
         a/f+kp3Ty2Hc39Zu8GEDUQkKEiF9DKkSZFqeQJ4jEerCE64WKj4n3bqhK2aRgSKIVjB0
         tX1e6gh+nTAMXARCRTGn1bgEj6vRKVxCfX5/WtudOz+/hAO9mK+acgyhv4o4Sg+c+e4F
         C7UA==
X-Gm-Message-State: ANoB5pmKyL77RMgNIbb/QLxSJn/G/LoAiQEZxmIdAq/rbuzORJo3DIdn
        2RZy+bnCzUur7d0huF0dYpX+XwfqsynpbQ==
X-Google-Smtp-Source: AA0mqf64LXZ7GWl8ZnXJP/+7q4A0IUL/2bafvU8oDu00ilAxJDPsiODsd5wEor2VuZysXB4/WvGHjg==
X-Received: by 2002:a17:906:b013:b0:7ba:fcc1:f284 with SMTP id v19-20020a170906b01300b007bafcc1f284mr14580532ejy.73.1670824620445;
        Sun, 11 Dec 2022 21:57:00 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id eq17-20020a170907291100b007a4e02e32ffsm2869017ejc.60.2022.12.11.21.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 21:57:00 -0800 (PST)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
Date:   Mon, 12 Dec 2022 00:58:17 +0100
Subject: [PATCH] of: fdt: Honor CONFIG_CMDLINE* even without /chosen node
Cc:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@kernel.org>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>
Cc:     Lukasz Majewski <lukma@denx.de>
Cc:     Linus Walleij <linusw@kernel.org>
Message-ID: <8c17ab48c809a70d9f9e9fa195cf0d818c763245.camel@gmail.com>
MIME-Version: 1.0
User-Agent: Evolution 3.44.4 
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I do not read a strict requirement on /chosen node in either ePAPR or in
Documentation/devicetree. Help text for CONFIG_CMDLINE and
CONFIG_CMDLINE_EXTEND doesn't make their behavior explicitly dependent on
the presence of /chosen or the presense of /chosen/bootargs.

However the early check for /chosen and bailing out in
early_init_dt_scan_chosen() skips CONFIG_CMDLINE handling which is not
really related to /chosen node or the particular method of passing cmdline
from bootloader.

This leads to counterintuitive combinations (assuming
CONFIG_CMDLINE_EXTEND=y):

a) bootargs="foo", CONFIG_CMDLINE="bar" => cmdline=="foo bar"
b) /chosen missing, CONFIG_CMDLINE="bar" => cmdline==""
c) bootargs="", CONFIG_CMDLINE="bar" => cmdline==" bar"

Move CONFIG_CMDLINE handling outside of early_init_dt_scan_chosen() so that
cases b and c above result in the same cmdline.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 drivers/of/fdt.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 7b571a631639..b2272bccf85c 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1173,26 +1173,6 @@ int __init early_init_dt_scan_chosen(char *cmdline)
 	if (p != NULL && l > 0)
 		strscpy(cmdline, p, min(l, COMMAND_LINE_SIZE));
 
-	/*
-	 * CONFIG_CMDLINE is meant to be a default in case nothing else
-	 * managed to set the command line, unless CONFIG_CMDLINE_FORCE
-	 * is set in which case we override whatever was found earlier.
-	 */
-#ifdef CONFIG_CMDLINE
-#if defined(CONFIG_CMDLINE_EXTEND)
-	strlcat(cmdline, " ", COMMAND_LINE_SIZE);
-	strlcat(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
-#elif defined(CONFIG_CMDLINE_FORCE)
-	strscpy(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
-#else
-	/* No arguments from boot loader, use kernel's  cmdl*/
-	if (!((char *)cmdline)[0])
-		strscpy(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
-#endif
-#endif /* CONFIG_CMDLINE */
-
-	pr_debug("Command line is: %s\n", (char *)cmdline);
-
 	rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
 	if (rng_seed && l > 0) {
 		add_bootloader_randomness(rng_seed, l);
@@ -1297,6 +1277,26 @@ void __init early_init_dt_scan_nodes(void)
 	if (rc)
 		pr_warn("No chosen node found, continuing without\n");
 
+	/*
+	 * CONFIG_CMDLINE is meant to be a default in case nothing else
+	 * managed to set the command line, unless CONFIG_CMDLINE_FORCE
+	 * is set in which case we override whatever was found earlier.
+	 */
+#ifdef CONFIG_CMDLINE
+#if defined(CONFIG_CMDLINE_EXTEND)
+	strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
+	strlcat(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+#elif defined(CONFIG_CMDLINE_FORCE)
+	strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+#else
+	/* No arguments from boot loader, use kernel's cmdl */
+	if (!boot_command_line[0])
+		strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+#endif
+#endif /* CONFIG_CMDLINE */
+
+	pr_debug("Command line is: %s\n", boot_command_line);
+
 	/* Setup memory, calling early_init_dt_add_memory_arch */
 	early_init_dt_scan_memory();
 
-- 
2.37.3
