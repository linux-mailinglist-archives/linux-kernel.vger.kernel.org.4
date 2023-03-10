Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30536B4809
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjCJO46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjCJOzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:55:48 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B00C10423;
        Fri, 10 Mar 2023 06:51:10 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id m25-20020a05683026d900b006941a2838caso3034682otu.7;
        Fri, 10 Mar 2023 06:51:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ps/svGZ6xWHVJQ0dMU8++7OD08k18rg46UI9xmEWbIc=;
        b=SNOXjbDEuAAwDLrA7muF5z7WVZYKlwNXGLcOybgyHdpQu6/Mgyag4wd7EAN21mxPOs
         +p0/D6L3s8ghpq8ixHlYfSFkobdTSCpGBz1qSetf2vjbUuF7030/6tMcnvrQPU2PNbfK
         a4K/3wzfkE5bFru9dPK6+UwYszYT1e37g9vbeo0Wjai1PYkAYognTgw/Yv8eOkGTxeC9
         qi8dpcmwLR5KRm7aYHn0J5QOdOkDfz9Z1/qx9IWA8tc8DnisG5jpWeCyJbX5mbbyPYCb
         gouo2IoRg/ukG8Id5CAo+KaF8RtmJBQUikAqxbC/lJifL8zWmvyx3XJNcnZ2ch/hhyiO
         Fu2A==
X-Gm-Message-State: AO0yUKWdRygX88qmIbCEpiVJsnRAQxxaqnNLPP6LTkqmkW/GGgMsvw9U
        pGZV2ZRuwEA4t19pAlpkSg==
X-Google-Smtp-Source: AK7set9IVJnTY/EvHnm9u8/rDXJ25KPAa+oF7Itt6s3eH5A96+jOhMraQGJ1753yivMUYDLltPrUBA==
X-Received: by 2002:a05:6830:3687:b0:693:d927:645e with SMTP id bk7-20020a056830368700b00693d927645emr13293296otb.6.1678459717375;
        Fri, 10 Mar 2023 06:48:37 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 63-20020a9d0845000000b00690f6d9a737sm135685oty.8.2023.03.10.06.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:48:36 -0800 (PST)
Received: (nullmailer pid 1546057 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:30 -0000
From:   Rob Herring <robh@kernel.org>
To:     Helge Deller <deller@gmx.de>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] fbdev: Use of_property_read_bool() for boolean properties
Date:   Fri, 10 Mar 2023 08:47:30 -0600
Message-Id: <20230310144730.1546031-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
 drivers/video/fbdev/offb.c     | 4 ++--
 drivers/video/fbdev/sm501fb.c  | 4 ++--
 drivers/video/fbdev/tcx.c      | 3 +--
 drivers/video/fbdev/xilinxfb.c | 3 +--
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index f7ad6bc9d02d..b97d251d894b 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -549,10 +549,10 @@ static void offb_init_nodriver(struct platform_device *parent, struct device_nod
 	int foreign_endian = 0;
 
 #ifdef __BIG_ENDIAN
-	if (of_get_property(dp, "little-endian", NULL))
+	if (of_property_read_bool(dp, "little-endian"))
 		foreign_endian = FBINFO_FOREIGN_ENDIAN;
 #else
-	if (of_get_property(dp, "big-endian", NULL))
+	if (of_property_read_bool(dp, "big-endian"))
 		foreign_endian = FBINFO_FOREIGN_ENDIAN;
 #endif
 
diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index f743bfbde2a6..1f3cbe723def 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -1737,10 +1737,10 @@ static int sm501fb_init_fb(struct fb_info *fb, enum sm501_controller head,
 
 #if defined(CONFIG_OF)
 #ifdef __BIG_ENDIAN
-	if (of_get_property(info->dev->parent->of_node, "little-endian", NULL))
+	if (of_property_read_bool(info->dev->parent->of_node, "little-endian"))
 		fb->flags |= FBINFO_FOREIGN_ENDIAN;
 #else
-	if (of_get_property(info->dev->parent->of_node, "big-endian", NULL))
+	if (of_property_read_bool(info->dev->parent->of_node, "big-endian"))
 		fb->flags |= FBINFO_FOREIGN_ENDIAN;
 #endif
 #endif
diff --git a/drivers/video/fbdev/tcx.c b/drivers/video/fbdev/tcx.c
index 01d87f53324d..f2eaf6e7fff6 100644
--- a/drivers/video/fbdev/tcx.c
+++ b/drivers/video/fbdev/tcx.c
@@ -379,8 +379,7 @@ static int tcx_probe(struct platform_device *op)
 
 	spin_lock_init(&par->lock);
 
-	par->lowdepth =
-		(of_find_property(dp, "tcx-8-bit", NULL) != NULL);
+	par->lowdepth = of_property_read_bool(dp, "tcx-8-bit");
 
 	sbusfb_fill_var(&info->var, dp, 8);
 	info->var.red.length = 8;
diff --git a/drivers/video/fbdev/xilinxfb.c b/drivers/video/fbdev/xilinxfb.c
index 1ac83900a21c..c17cfffd9a84 100644
--- a/drivers/video/fbdev/xilinxfb.c
+++ b/drivers/video/fbdev/xilinxfb.c
@@ -469,8 +469,7 @@ static int xilinxfb_of_probe(struct platform_device *pdev)
 		pdata.yvirt = prop[1];
 	}
 
-	if (of_find_property(pdev->dev.of_node, "rotate-display", NULL))
-		pdata.rotate_screen = 1;
+	pdata.rotate_screen = of_property_read_bool(pdev->dev.of_node, "rotate-display");
 
 	platform_set_drvdata(pdev, drvdata);
 	return xilinxfb_assign(pdev, drvdata, &pdata);
-- 
2.39.2

