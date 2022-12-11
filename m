Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643C56498CD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 07:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiLLGB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 01:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiLLGBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 01:01:55 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092EA2DE6;
        Sun, 11 Dec 2022 22:01:54 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id m19so11358719edj.8;
        Sun, 11 Dec 2022 22:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:mime-version:message-id:to:cc:subject:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2zkeYUz7U/xhI7hB3XZxYQs9NMpqoObeUlI6eDOGe6U=;
        b=oHDLpIsNH/jWL9Ns3j/4mrJo+PkiFyP9H1iJ2V/InQ6cbopI+kguqhNBHOXjkrx1F0
         60wILoOfad7NiiUy++U7/CUynnfgMHULNVOsKKVJjQhorqiHKBtNzoO+669117MRNq0q
         7Nd+jOKLZwPGj6ZvJ31jwOdQyfebWgcTK54UycUiMw8QxS1zH7KDSJ6FM0sCTgQJmNwg
         hSP71O9V1zlOkuuCibfc5FArkcOKu6nZsaWFuTZFZZDtCRZD37icRhKqiI/swc0AGmHG
         w39u6UjcjoJCYORaWvZRL1cPXTRgT224NnyLSzxKFxB9DbGzIvljWlG6vyuELcak2yDS
         erhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:mime-version:message-id:to:cc:subject:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2zkeYUz7U/xhI7hB3XZxYQs9NMpqoObeUlI6eDOGe6U=;
        b=Q9/SEOhzmPBzz9BQ5IK4h59IJaYKgX3zHqdHYJTijme36kC0KskSjUOBSu2s7FLLrC
         Cp4pc0JDtWOcByEs1I2PhEgKWhWNWDbD4rkVmqh493yxWAJgKudGk+5hVxsyhBMP7foR
         I4k223/1VOd5v6vW/FKBZdPgB54/b0kl3sNCqBax6bvxoDO6wT/Ua3TyZlkJutRi9bma
         WAzUJTd5aBkU4K19XLPbKIc68ppu82/MAYd6BtDKolikNseDQyeaTRSS1j4t/lmpA5Qs
         3VlZr1jo285PXKv8Kv8GuuZFP8qGVomXbUEIrBaqTKSLBcY/nT8Bgvpj4elcLLxlDjBQ
         VjXA==
X-Gm-Message-State: ANoB5pmnEedgkwoqTkKIGl3YRf3KSnXp0CDWQNjmQD7cb/ro+QF8WISs
        cADLgSmqa6uFa5LFdy53FnCL8TqpyxSGPQ==
X-Google-Smtp-Source: AA0mqf6sOIbwqdmzmTGHt1YW2HT4nuZpobdVrWOwQH0OPxjniz4MSzB08im/Lb/SEEfeJ8pv5fcC2w==
X-Received: by 2002:a50:ec89:0:b0:46f:a73d:367c with SMTP id e9-20020a50ec89000000b0046fa73d367cmr4976062edr.34.1670824912574;
        Sun, 11 Dec 2022 22:01:52 -0800 (PST)
Received: from giga-mm.home ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ee48-20020a056402293000b004615f7495e0sm3385134edb.8.2022.12.11.22.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 22:01:52 -0800 (PST)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
Date:   Mon, 12 Dec 2022 00:58:17 +0100
Subject: [PATCH] of: fdt: Honor CONFIG_CMDLINE* even without /chosen node
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linusw@kernel.org>
To:     devicetree@vger.kernel.org
Message-ID: <11af73e05bad75e4ef49067515e3214f6d944b3d.camel@gmail.com>
MIME-Version: 1.0
User-Agent: Evolution 3.44.4 
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
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
