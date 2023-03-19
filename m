Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD186C0315
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 17:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjCSQbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 12:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCSQbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 12:31:50 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A00D1CAF4;
        Sun, 19 Mar 2023 09:31:48 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id o14so4473836ioa.3;
        Sun, 19 Mar 2023 09:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679243507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hSX5ZPGb2yPp6ZpbFyBngnXqKXKCG97zLl53DNRvOI=;
        b=GIMMPzRojsBzhe3WxMjlbAvuNIrRiRWi1aIgHno27afqEkkfPhZxpkucGt7XFuT9Mv
         bKPOQzZsfKnLoiFu5pGPKOHRtfbBkSfDDy5EuPbhgVjiq3rJput+wdCrFpIy+kOVaJTz
         s8V0WWMo5UqAkirWz0/t0gjSgTKEv6wSXmkgLSFHwW4bZYuTZqZYHBEIKBWGqeSECMZf
         W6ZhTNndOBOgPJWOYvFAENx2y/Is+Yd3WU7L7wLDQZBTWpPMC9nwDxnvImeinWbE8k/x
         q80lAo7QqfOqpYuMhj2536Bgif0vJZ0b3tWKY6I3HcrdkEeILAVET5xbVzv/2n446hOP
         uVYg==
X-Gm-Message-State: AO0yUKVXAdZnlMEyNoS9xI2KuJjHH0invwYQu5rvLiz5hkxv/7RNrHSV
        +fevIsmG1UWlYbbjqCb0CA==
X-Google-Smtp-Source: AK7set9HV7q7rvAjTiYs9B/VtfzoC5vf+dG2d//y81dBAIqiozn35gr6aS3op9YITmU61jPJrk6WDg==
X-Received: by 2002:a5e:da4b:0:b0:74c:b180:c5db with SMTP id o11-20020a5eda4b000000b0074cb180c5dbmr3971680iop.20.1679243507334;
        Sun, 19 Mar 2023 09:31:47 -0700 (PDT)
Received: from robh_at_kernel.org ([2605:ef80:80c7:2689:137d:d795:47e4:3de1])
        by smtp.gmail.com with ESMTPSA id d65-20020a026244000000b004062d749099sm2498783jac.51.2023.03.19.09.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 09:31:46 -0700 (PDT)
Received: (nullmailer pid 225260 invoked by uid 1000);
        Sun, 19 Mar 2023 16:31:44 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Paul Walmsley <paul@pwsan.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: omap: Use of_address_to_resource()
Date:   Sun, 19 Mar 2023 11:31:35 -0500
Message-Id: <20230319163135.225076-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded parsing of "reg" with of_address_to_resource().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-omap2/omap_hwmod.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5a2a9b8e61ed..37ae8ba41ddd 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -706,9 +706,7 @@ static const struct of_device_id ti_clkctrl_match_table[] __initconst = {
 
 static int __init _setup_clkctrl_provider(struct device_node *np)
 {
-	const __be32 *addrp;
 	struct clkctrl_provider *provider;
-	u64 size;
 	int i;
 
 	provider = memblock_alloc(sizeof(*provider), SMP_CACHE_BYTES);
@@ -717,8 +715,7 @@ static int __init _setup_clkctrl_provider(struct device_node *np)
 
 	provider->node = np;
 
-	provider->num_addrs =
-		of_property_count_elems_of_size(np, "reg", sizeof(u32)) / 2;
+	provider->num_addrs = of_address_count(np);
 
 	provider->addr =
 		memblock_alloc(sizeof(void *) * provider->num_addrs,
@@ -733,11 +730,11 @@ static int __init _setup_clkctrl_provider(struct device_node *np)
 		return -ENOMEM;
 
 	for (i = 0; i < provider->num_addrs; i++) {
-		addrp = of_get_address(np, i, &size, NULL);
-		provider->addr[i] = (u32)of_translate_address(np, addrp);
-		provider->size[i] = size;
-		pr_debug("%s: %pOF: %x...%x\n", __func__, np, provider->addr[i],
-			 provider->addr[i] + provider->size[i]);
+		struct resource res;
+		of_address_to_resource(np, i, &res);
+		provider->addr[i] = res.start;
+		provider->size[i] = resource_size(&res);
+		pr_debug("%s: %pOF: %pR\n", __func__, np, &res);
 	}
 
 	list_add(&provider->link, &clkctrl_providers);
-- 
2.39.2

