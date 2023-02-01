Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E696870C3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 23:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjBAWAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 17:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBAWAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 17:00:02 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ECD721D2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 14:00:01 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id j6-20020a9d7686000000b0068d4ba9d141so226165otl.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 14:00:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KnsdEPYwX/ZNMl/l3teqeX2/D7jKm45H92eGfCLGbh4=;
        b=wQUvMx1Z5eSmrggG020HvIH+fVdisTql69Rv2GcGtz3MCWWV6SFS5WMwhuR6LH8b6Q
         79RYoSvkdlw9OdODZ2IH+frgQofrV3UvGivn9Re9d4gTaOxP26Ud4bXa7w7oFiEJJmsc
         j0E+okv2bPxCZ9hZsYaSFRSrSjpAKAhDiTzg5eSOxov5LkjBPJcovlDkS0LbqFZ9mspu
         w/QeiaK+wQPJGh/pZLFXY3Dy5cK7DBWeBSD5OQbKSWZh2Ev/eu7lqOmi2gvQ3bCKnBeV
         7pgwnoSKotFguvpNdp3cIXAlrVNmgX7g9PAsx6VQN+RNeRRvXO3lcNr0lsSX6FP9FYDT
         6cVA==
X-Gm-Message-State: AO0yUKUhyRTOgxTvY+D34qrnz1qTj/muKRgcFPBEd+pSaVsTJ36imacT
        Vr2LMu9oJqLEfQ0alnZLGA==
X-Google-Smtp-Source: AK7set8fYP5ut+0fIMu4n6g8KX0Oo7nzolLnmWQejXZ1w2vjX6IVqmiiQcmf+ccbkdd0V+RX7ktD4A==
X-Received: by 2002:a05:6830:381a:b0:68b:ba4d:1c94 with SMTP id bh26-20020a056830381a00b0068bba4d1c94mr2361983otb.4.1675288800384;
        Wed, 01 Feb 2023 14:00:00 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m6-20020a9d4c86000000b0068d3f341dd9sm1333849otf.62.2023.02.01.13.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 13:59:59 -0800 (PST)
Received: (nullmailer pid 246856 invoked by uid 1000);
        Wed, 01 Feb 2023 21:59:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bus: imx-weim: Remove open coded "ranges" parsing
Date:   Wed,  1 Feb 2023 15:58:54 -0600
Message-Id: <20230201215854.245717-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"ranges" is a standard property and we have common helper functions for
parsing it, so let's use them.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Compile tested only!
---
 drivers/bus/imx-weim.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 828c66bbaa67..bb9d1f5ed73b 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
@@ -86,8 +87,8 @@ MODULE_DEVICE_TABLE(of, weim_id_table);
 static int imx_weim_gpr_setup(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct property *prop;
-	const __be32 *p;
+	struct of_range_parser parser;
+	struct of_range range;
 	struct regmap *gpr;
 	u32 gprvals[4] = {
 		05,	/* CS0(128M) CS1(0M)  CS2(0M)  CS3(0M)  */
@@ -106,13 +107,13 @@ static int imx_weim_gpr_setup(struct platform_device *pdev)
 		return 0;
 	}
 
-	of_property_for_each_u32(np, "ranges", prop, p, val) {
-		if (i % 4 == 0) {
-			cs = val;
-		} else if (i % 4 == 3 && val) {
-			val = (val / SZ_32M) | 1;
-			gprval |= val << cs * 3;
-		}
+	if (of_range_parser_init(&parser, np))
+		goto err;
+
+	for_each_of_range(&parser, &range) {
+		cs = range.bus_addr >> 32;
+		val = (range.size / SZ_32M) | 1;
+		gprval |= val << cs * 3;
 		i++;
 	}
 
-- 
2.39.0

