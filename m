Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F3B65C59B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238523AbjACSBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238513AbjACSA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:00:57 -0500
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F41270;
        Tue,  3 Jan 2023 10:00:56 -0800 (PST)
Received: by mail-il1-f169.google.com with SMTP id bp26so3757088ilb.3;
        Tue, 03 Jan 2023 10:00:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wm/VAsCJtckCmZFwW1Ji09pFtmWQae4vzQe50HoWg4=;
        b=GD2e6mffm45OB2oyL7ZGQGm/93Ivcs5E/RWdFedMvXO6u5dBXcvd2N1LtE0J2/90Mv
         GlSDLDDcmkzYUxqa8T3ZTdc+MCgs+ryVRx1DaSH+DJada8/DvbGxoXjoWY9u4VI6rnp8
         5VyW2Jg3e4MVS+PnbbvLWDGHXSkwrhe283IU7w36baUk6moXB/EKVd52c+LipKXtWehC
         MqfnPQcMMc7J87bAGZwFYL5FOT20blUDAdYPZoe76K5L8OKL9HrGtTy4fXUDkfajtTMp
         Qx/26YrfbrUaFyUFGwi0LUhiob0AZLsuhgFdKHizcI7ZiT3CiMw3NdAqNWcOiy9uT5B1
         C6WA==
X-Gm-Message-State: AFqh2kp54tTVTkEAFec4CPR3+Y/H9KB/hsKGe3u0pHn0j7H4bWt5RO2S
        CjplyTS2ZvuyOb59sABggTVnIExCEw==
X-Google-Smtp-Source: AMrXdXsBQWnE4m6NFOYZRRt+RQrVTDUs7E3tgSd494Hy/6KB47YogIhvaqdpkp8Sjgc46cbAw5DTRQ==
X-Received: by 2002:a92:db47:0:b0:303:30a9:326a with SMTP id w7-20020a92db47000000b0030330a9326amr28638434ilq.7.1672768856073;
        Tue, 03 Jan 2023 10:00:56 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g14-20020a056e021a2e00b00304ae88ebebsm9803549ile.88.2023.01.03.10.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 10:00:55 -0800 (PST)
Received: (nullmailer pid 3492168 invoked by uid 1000);
        Tue, 03 Jan 2023 18:00:51 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 03 Jan 2023 12:00:31 -0600
Subject: [PATCH 1/2] Revert "of: fdt: Honor CONFIG_CMDLINE* even without /chosen node"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230103-dt-cmdline-fix-v1-1-7038e88b18b6@kernel.org>
References: <20230103-dt-cmdline-fix-v1-0-7038e88b18b6@kernel.org>
In-Reply-To: <20230103-dt-cmdline-fix-v1-0-7038e88b18b6@kernel.org>
To:     Geoff Levand <geoff@infradead.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.12-dev
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a7d550f82b445cf218b47a2c1a9c56e97ecb8c7a.

Some arches (PPC at least) don't call early_init_dt_scan_nodes(), so
moving the cmdline processing there breaks them.

Reported-by: Geoff Levand <geoff@infradead.org>
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/fdt.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index b2272bccf85c..7b571a631639 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1173,6 +1173,26 @@ int __init early_init_dt_scan_chosen(char *cmdline)
 	if (p != NULL && l > 0)
 		strscpy(cmdline, p, min(l, COMMAND_LINE_SIZE));
 
+	/*
+	 * CONFIG_CMDLINE is meant to be a default in case nothing else
+	 * managed to set the command line, unless CONFIG_CMDLINE_FORCE
+	 * is set in which case we override whatever was found earlier.
+	 */
+#ifdef CONFIG_CMDLINE
+#if defined(CONFIG_CMDLINE_EXTEND)
+	strlcat(cmdline, " ", COMMAND_LINE_SIZE);
+	strlcat(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+#elif defined(CONFIG_CMDLINE_FORCE)
+	strscpy(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+#else
+	/* No arguments from boot loader, use kernel's  cmdl*/
+	if (!((char *)cmdline)[0])
+		strscpy(cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
+#endif
+#endif /* CONFIG_CMDLINE */
+
+	pr_debug("Command line is: %s\n", (char *)cmdline);
+
 	rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
 	if (rng_seed && l > 0) {
 		add_bootloader_randomness(rng_seed, l);
@@ -1277,26 +1297,6 @@ void __init early_init_dt_scan_nodes(void)
 	if (rc)
 		pr_warn("No chosen node found, continuing without\n");
 
-	/*
-	 * CONFIG_CMDLINE is meant to be a default in case nothing else
-	 * managed to set the command line, unless CONFIG_CMDLINE_FORCE
-	 * is set in which case we override whatever was found earlier.
-	 */
-#ifdef CONFIG_CMDLINE
-#if defined(CONFIG_CMDLINE_EXTEND)
-	strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
-	strlcat(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
-#elif defined(CONFIG_CMDLINE_FORCE)
-	strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
-#else
-	/* No arguments from boot loader, use kernel's cmdl */
-	if (!boot_command_line[0])
-		strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
-#endif
-#endif /* CONFIG_CMDLINE */
-
-	pr_debug("Command line is: %s\n", boot_command_line);
-
 	/* Setup memory, calling early_init_dt_add_memory_arch */
 	early_init_dt_scan_memory();
 

-- 
2.39.0
