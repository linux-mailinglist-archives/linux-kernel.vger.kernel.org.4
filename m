Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B146B72A258
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjFISde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjFISd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:33:27 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424A13AAD;
        Fri,  9 Jun 2023 11:33:02 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-33e53672aa6so8864945ab.1;
        Fri, 09 Jun 2023 11:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686335581; x=1688927581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGqPwyg/tCD/J3bWMKGMkc2zAlUcbkmqtQu/P2N7szY=;
        b=WTHqAbnLUxyBGV+5fdmv72hFow6j5lAPFihN2WPIDmhpeWUB5p2qtWsEMrP6UtgUzy
         HOyx00qgfUw1ecu2BKeXpJe/4b6PFNQ4S67CU9CH+pRtBm1jrCqEdd33FFshmewKm2UQ
         azFeU61i8LJCPLCr8lugll3/65F6dJqUz8Pw5tOfKzzxreccVp5e786ZHbh96YVL/SBz
         rLtXbOzOh3ok7qj7008+k0LEW+A9cLRAE7dtjEvesZgIr4UpJfgJyM57klZT1chvc/VA
         quFeHVR8n3M+cA9P6RVmxeKS88hNTRsk4ozw1JJCbIvsjN8v+GNMhpO7uMxIYj1tNGeJ
         ZPNw==
X-Gm-Message-State: AC+VfDxEwOOQFFPbDzeGnv38MU7O+2CRyqJHTEiZZo0oXgvXe8Rmdc0z
        lK1dafcvL6fiVSq6q2yyZw==
X-Google-Smtp-Source: ACHHUZ63xnHUt+KYexhlyUGxFKu+qwec0nXuVDb8tfC5lnpxyCls7eNjwSR1TYwNepBRh0fjXZ+OuA==
X-Received: by 2002:a92:ce11:0:b0:33a:56d6:d9a4 with SMTP id b17-20020a92ce11000000b0033a56d6d9a4mr2619749ilo.10.1686335581349;
        Fri, 09 Jun 2023 11:33:01 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p10-20020a92c10a000000b0033b27117120sm1220618ile.13.2023.06.09.11.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 11:33:00 -0700 (PDT)
Received: (nullmailer pid 1767637 invoked by uid 1000);
        Fri, 09 Jun 2023 18:32:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Paul Walmsley <paul@pwsan.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: omap2: Use of_range_to_resource() for "ranges" parsing
Date:   Fri,  9 Jun 2023 12:32:52 -0600
Message-Id: <20230609183252.1767487-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"ranges" is a standard property with common parsing functions. Users
shouldn't be implementing their own parsing of it. Use the recently
added of_range_to_resource() function instead for OMAP hwmod.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-omap2/omap_hwmod.c | 45 +++++---------------------------
 1 file changed, 6 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index aac4c4ee2528..1e17b5f77588 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2194,23 +2194,8 @@ int omap_hwmod_parse_module_range(struct omap_hwmod *oh,
 				  struct resource *res)
 {
 	struct property *prop;
-	const __be32 *ranges;
 	const char *name;
-	u32 nr_addr, nr_size;
-	u64 base, size;
-	int len, error;
-
-	if (!res)
-		return -EINVAL;
-
-	ranges = of_get_property(np, "ranges", &len);
-	if (!ranges)
-		return -ENOENT;
-
-	len /= sizeof(*ranges);
-
-	if (len < 3)
-		return -EINVAL;
+	int err;
 
 	of_property_for_each_string(np, "compatible", prop, name)
 		if (!strncmp("ti,sysc-", name, 8))
@@ -2219,26 +2204,12 @@ int omap_hwmod_parse_module_range(struct omap_hwmod *oh,
 	if (!name)
 		return -ENOENT;
 
-	error = of_property_read_u32(np, "#address-cells", &nr_addr);
-	if (error)
-		return -ENOENT;
+	err = of_range_to_resource(np, 0, res);
+	if (err)
+		return err;
 
-	error = of_property_read_u32(np, "#size-cells", &nr_size);
-	if (error)
-		return -ENOENT;
-
-	if (nr_addr != 1 || nr_size != 1) {
-		pr_err("%s: invalid range for %s->%pOFn\n", __func__,
-		       oh->name, np);
-		return -EINVAL;
-	}
-
-	ranges++;
-	base = of_translate_address(np, ranges++);
-	size = be32_to_cpup(ranges);
-
-	pr_debug("omap_hwmod: %s %pOFn at 0x%llx size 0x%llx\n",
-		 oh->name, np, base, size);
+	pr_debug("omap_hwmod: %s %pOFn at %pR\n",
+		 oh->name, np, &res);
 
 	if (oh && oh->mpu_rt_idx) {
 		omap_hwmod_fix_mpu_rt_idx(oh, np, res);
@@ -2246,10 +2217,6 @@ int omap_hwmod_parse_module_range(struct omap_hwmod *oh,
 		return 0;
 	}
 
-	res->start = base;
-	res->end = base + size - 1;
-	res->flags = IORESOURCE_MEM;
-
 	return 0;
 }
 
-- 
2.39.2

