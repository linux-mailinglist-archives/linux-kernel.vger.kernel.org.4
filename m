Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652B96B4705
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjCJOsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjCJOr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:47:26 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EFA122CE7;
        Fri, 10 Mar 2023 06:47:09 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id u3-20020a4ad0c3000000b0052541ef0bafso814695oor.5;
        Fri, 10 Mar 2023 06:47:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILWNY1eyaJenpJzny+CKLBX7/KrXnf6t+tVzPKNHAYc=;
        b=5quM+J1JfIaZNm/jXL+CRZVS/m3rOsIwiN7M7mlnE6raEth4S/azuJ1/WDyVPoV9GK
         CsMNrf1MXB1XsrrIRLfLxhn2Nh6GeHiRcQ/Ek8wVu7sByAWdmvGPRS+6YsSSHg3lpJ3q
         WKj7dobOgWPfzm6ha+0wJmoCarwlUKlDZjuggPbdcOw9wkQsm4XZ2FeMr6z8xnIVOz0u
         4CBp1l3NNgC8y3B1E4ehzB7QeluE6SSQ2ZF+CN1/J8UZw08kxXAwVJ9z/5an5LUEf7zS
         TaPenX2k1PG+EnS2v3R30e6acS8DwFlzQ3qY28NW6a5mWPSw+GduoXi5z5z4NKaFefTD
         sxYQ==
X-Gm-Message-State: AO0yUKUM8tCCtv5a8FFS90jQatCqTVB3a/ZM9qnE/bskywMvPlcKpqPT
        eeWvUNii1xewbURsDUh9K5i8H2Qlzg==
X-Google-Smtp-Source: AK7set9FlOE+iISk22iFJf1vh3PJrLOesXIMld5q8UttYtQUUp7De/NGPPX4nvkgv41a1KZml6Fc7g==
X-Received: by 2002:a05:6820:1048:b0:525:d9c:b1bb with SMTP id x8-20020a056820104800b005250d9cb1bbmr11363049oot.2.1678459627124;
        Fri, 10 Mar 2023 06:47:07 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r2-20020acada02000000b00383ef567cfdsm963361oig.21.2023.03.10.06.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:06 -0800 (PST)
Received: (nullmailer pid 1541599 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: microchip: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:01 -0600
Message-Id: <20230310144701.1541573-1-robh@kernel.org>
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
 drivers/clk/microchip/clk-pic32mzda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/microchip/clk-pic32mzda.c b/drivers/clk/microchip/clk-pic32mzda.c
index b72c76f9ecd1..eabfc4931fe9 100644
--- a/drivers/clk/microchip/clk-pic32mzda.c
+++ b/drivers/clk/microchip/clk-pic32mzda.c
@@ -184,7 +184,7 @@ static int pic32mzda_clk_probe(struct platform_device *pdev)
 	clks[UPLLCLK] = clk_register_fixed_rate(&pdev->dev, "usbphy_clk", NULL,
 						0, 24000000);
 	/* fixed rate (optional) clock */
-	if (of_find_property(np, "microchip,pic32mzda-sosc", NULL)) {
+	if (of_property_read_bool(np, "microchip,pic32mzda-sosc")) {
 		pr_info("pic32-clk: dt requests SOSC.\n");
 		clks[SOSCCLK] = pic32_sosc_clk_register(&sosc_clk, core);
 	}
-- 
2.39.2

