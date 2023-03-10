Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DBF6B46EF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjCJOrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbjCJOrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:47:22 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1E8105568;
        Fri, 10 Mar 2023 06:47:04 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1755e639b65so6078243fac.3;
        Fri, 10 Mar 2023 06:47:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ze4x2UjW4SC+7SgOWlyCc0ynsM258m+gI2GkQIZTPMI=;
        b=yTt3CTEiH7cPMBp+ZAX14PZgaXmETv68qxJToExAFp3anwLcRJQr8Lwi2eWSxrSAqb
         LDES7Zo/NifSQGbRrOUcUSVjh4G2mbDT/YsiBntb9DsC6Cl9cC3so/wPvkcccUIpiFww
         fGw2T2pdJdAcFgUFr3zh2kR80PICZ3xlCoD4DG8IWeED7/t3wfG1zHnyVCxMzzRkYvAS
         3D9s1QQEZdi4vimwlcdOxvmhsxX+jWLs6I8QpAcvbpAe75zRitsH2Q2oiFNAP+bDnQoh
         MD6TymTyicoYlzm02C79BMC1zZ7s8Vbz/DJFgbMBGdsQwZ0+V3VLwONFj0OdFbOl0Vy/
         DoXQ==
X-Gm-Message-State: AO0yUKXu0WBUCF1cYqarvawRkMz5TxMrlGo7z2hm3jzGDf15SQJaLEvM
        iSbwkynCJlH29eFt/yHt2wvYBNsY8g==
X-Google-Smtp-Source: AK7set82KIT56SQJ6WqeSwMPkCDv0B0eHIXclgRxzxBAzHabdT7fVwRv6tyCkq20rhBO+1pi1bynLQ==
X-Received: by 2002:a05:6870:73cc:b0:176:4920:bf8c with SMTP id a12-20020a05687073cc00b001764920bf8cmr16477103oan.55.1678459619557;
        Fri, 10 Mar 2023 06:46:59 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e15-20020a056871044f00b0016e9308e17bsm73055oag.52.2023.03.10.06.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:46:59 -0800 (PST)
Received: (nullmailer pid 1540838 invoked by uid 1000);
        Fri, 10 Mar 2023 14:46:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Paul Walmsley <paul@pwsan.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: omap2: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:46:55 -0600
Message-Id: <20230310144655.1540793-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties.
Convert reading boolean properties to to of_property_read_bool().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-omap2/omap_hwmod.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5a2a9b8e61ed..989195f6f7be 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2322,11 +2322,11 @@ static int __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data,
 static void __init parse_module_flags(struct omap_hwmod *oh,
 				      struct device_node *np)
 {
-	if (of_find_property(np, "ti,no-reset-on-init", NULL))
+	if (of_property_read_bool(np, "ti,no-reset-on-init"))
 		oh->flags |= HWMOD_INIT_NO_RESET;
-	if (of_find_property(np, "ti,no-idle-on-init", NULL))
+	if (of_property_read_bool(np, "ti,no-idle-on-init"))
 		oh->flags |= HWMOD_INIT_NO_IDLE;
-	if (of_find_property(np, "ti,no-idle", NULL))
+	if (of_property_read_bool(np, "ti,no-idle"))
 		oh->flags |= HWMOD_NO_IDLE;
 }
 
-- 
2.39.2

