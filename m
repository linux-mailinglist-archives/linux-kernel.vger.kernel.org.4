Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE1665C59A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbjACSB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjACSA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:00:56 -0500
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6608D270;
        Tue,  3 Jan 2023 10:00:55 -0800 (PST)
Received: by mail-il1-f171.google.com with SMTP id d10so18383209ilc.12;
        Tue, 03 Jan 2023 10:00:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ai+C4kfMYDVX4+GGvR2fZcw0TFCgshT4pT+LtG/a7/c=;
        b=u5NORUKAjX3NIPccbp4aU6szdijFGUJIpK+gKQCSaMxnbQSGro5UwWRI4oy1lpECFM
         NRTs+2TW24QBpP1zo/oAYdLMvsPUd/RsGZLVKgL520OOlOo85ZYcBDpvNheF1D0tYsvh
         bq5pwTfZUO5CPiNbz7NRdvhiInAkz6uYiNtvqolaW12k3h+3ztg3zUMlWH2qBBExhNdw
         vtNXM47nLLuiahr2I/HNluY1zvQp3Oq0OsBFPXMvs3DCmzrXbPfV9aNJbsL7yFypJlRN
         QJvFqsg6VtOMQv6WvgdPJmPyBoW1fXZZ1ucOLuf9hYofX2T1Tm/WtEnFt0WegBp4EcYs
         z0RQ==
X-Gm-Message-State: AFqh2koMZLW2qIIUZR7FUNSmTayE1dFjR1tYbxc0pVPi0fYV9mD0dqg9
        yQ9Ft3LqiWI2BfVuZSp+QA==
X-Google-Smtp-Source: AMrXdXsksLPmE6aWIt4TlmhZsPgEpUfsGIUOklE906/pA/IpeCfW2n4vxsDwSBLBihHE5y3FbqOhVQ==
X-Received: by 2002:a05:6e02:12eb:b0:303:94bf:b0bb with SMTP id l11-20020a056e0212eb00b0030394bfb0bbmr39009852iln.29.1672768854567;
        Tue, 03 Jan 2023 10:00:54 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y16-20020a056e02129000b0030bff5524eesm8092289ilq.50.2023.01.03.10.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 10:00:54 -0800 (PST)
Received: (nullmailer pid 3492170 invoked by uid 1000);
        Tue, 03 Jan 2023 18:00:51 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 03 Jan 2023 12:00:32 -0600
Subject: [PATCH 2/2] of: fdt: Honor CONFIG_CMDLINE* even without /chosen node, take 2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230103-dt-cmdline-fix-v1-2-7038e88b18b6@kernel.org>
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

Rework early_init_dt_scan_chosen() so that the cmdline config options are
always handled.

[commit msg written by Alexander Sverdlin]
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/fdt.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 7b571a631639..4b94bb52671e 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1161,18 +1161,32 @@ int __init early_init_dt_scan_chosen(char *cmdline)
 	if (node < 0)
 		node = fdt_path_offset(fdt, "/chosen@0");
 	if (node < 0)
-		return -ENOENT;
+		/* Handle the cmdline config options even if no /chosen node */
+		goto handle_cmdline;
 
 	chosen_node_offset = node;
 
 	early_init_dt_check_for_initrd(node);
 	early_init_dt_check_for_elfcorehdr(node);
 
+	rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
+	if (rng_seed && l > 0) {
+		add_bootloader_randomness(rng_seed, l);
+
+		/* try to clear seed so it won't be found. */
+		fdt_nop_property(initial_boot_params, node, "rng-seed");
+
+		/* update CRC check value */
+		of_fdt_crc32 = crc32_be(~0, initial_boot_params,
+				fdt_totalsize(initial_boot_params));
+	}
+
 	/* Retrieve command line */
 	p = of_get_flat_dt_prop(node, "bootargs", &l);
 	if (p != NULL && l > 0)
 		strscpy(cmdline, p, min(l, COMMAND_LINE_SIZE));
 
+handle_cmdline:
 	/*
 	 * CONFIG_CMDLINE is meant to be a default in case nothing else
 	 * managed to set the command line, unless CONFIG_CMDLINE_FORCE
@@ -1193,18 +1207,6 @@ int __init early_init_dt_scan_chosen(char *cmdline)
 
 	pr_debug("Command line is: %s\n", (char *)cmdline);
 
-	rng_seed = of_get_flat_dt_prop(node, "rng-seed", &l);
-	if (rng_seed && l > 0) {
-		add_bootloader_randomness(rng_seed, l);
-
-		/* try to clear seed so it won't be found. */
-		fdt_nop_property(initial_boot_params, node, "rng-seed");
-
-		/* update CRC check value */
-		of_fdt_crc32 = crc32_be(~0, initial_boot_params,
-				fdt_totalsize(initial_boot_params));
-	}
-
 	return 0;
 }
 

-- 
2.39.0
