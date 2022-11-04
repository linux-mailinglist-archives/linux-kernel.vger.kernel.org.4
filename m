Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49639618ECB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 04:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiKDDSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 23:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiKDDRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 23:17:31 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B537C20186;
        Thu,  3 Nov 2022 20:17:03 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l6so3453032pjj.0;
        Thu, 03 Nov 2022 20:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3N39HNFiqYnjEtTIzF8MdLuTkDRvn84ONCWXTbY+Sc=;
        b=ZfixGSIH/mZRzcotLRCWziaYgI6pQe4HhPfxoaOcrlUVe6q4KuY6B/cmG83Vn0rQJW
         qPrvtysuEYTHQcjaD8j3ZuQZerWYCxN6Od3wHqNyAJbXyhjJ+3Xv56v24tqpKvIUWZ/y
         RmGovEz+53FQm/hnL27uqjRQrf7s0t7e2NcSB08424ngTrv7jNpsMRIkTZfeRSfFhreq
         2VpzeQbc5TV+h0gdqioeRjUcFKgZo+6IPYZo4CqA+F6rmpTk+t1Zyet2jtE6Z91/Pfcg
         7SGPjYk6Rs4gymMy6xOj20l+FcQKAWf4dHiPx4FxXgcOEqMC3qPUYTrky/HgHoaeP70p
         NZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3N39HNFiqYnjEtTIzF8MdLuTkDRvn84ONCWXTbY+Sc=;
        b=wud01rNWcN8qkhFw9NQ39pvgK1TqO7ZoUtS6BmemtDLAzI92I4cBZzURpH9aQIY5J0
         gIbGSW5L45xB/oS5eNP9fqPxSLimstedVtPBKQJsoXUxvnn5Oveu9FTkt4lbQ8cM1SUw
         acc/aC6p0iGxwo4hvmCw6Zk2dUgwfrIRWvN+55rxTg0qkuE/8Qcfz5zXtUvxLFzL58AA
         odpLaDa+aMWj5ISQ5ioTSaP3N4uSNPfTZINtbu4uWWbcYaz3voKrfPC2iFCvk2Weppb8
         WEN7NTXbQcVLmhPXog8aP0zA3OFshFd+QZNBgcfpa5xHCNt7q6uezY1y1/56/bAANVgM
         jDCw==
X-Gm-Message-State: ACrzQf2xQhXaDd2m81UAGwLwVG+j0W6mW/5jP/cyW20jwIDaQ4Bj6fXS
        qKjpZ3jaACfEOIrmVF50fSA=
X-Google-Smtp-Source: AMsMyM7nrXImeyb+ka66vCt4Wt9iNDazA7HU2R3RzyPG8uayeoYSEucx8fEc3LM91bjy4udG/2+J7g==
X-Received: by 2002:a17:902:7849:b0:186:68b9:e1ae with SMTP id e9-20020a170902784900b0018668b9e1aemr33322333pln.139.1667531823059;
        Thu, 03 Nov 2022 20:17:03 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id s3-20020a63ff43000000b004702eca61fcsm1078655pgk.36.2022.11.03.20.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 20:17:02 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Helge Deller <deller@gmx.de>, Tony Lindgren <tony@atomide.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH RESEND 09/13] omapfb: connector-analog-tv: remove support for platform data
Date:   Thu,  3 Nov 2022 20:16:38 -0700
Message-Id: <20221103-omapfb-gpiod-v1-9-cba1fae5a77c@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221103-omapfb-gpiod-v1-0-cba1fae5a77c@gmail.com>
References: <20221103-omapfb-gpiod-v1-0-cba1fae5a77c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.0-dev-28747
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no users of connector_atv_platform_data in the mainline
kernel so support for it can be removed from the panel driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../omap2/omapfb/displays/connector-analog-tv.c    | 60 +++-------------------
 include/video/omap-panel-data.h                    | 34 ------------
 2 files changed, 8 insertions(+), 86 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/connector-analog-tv.c b/drivers/video/fbdev/omap2/omapfb/displays/connector-analog-tv.c
index a9fd732f8103..0daaf9f89bab 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/connector-analog-tv.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/connector-analog-tv.c
@@ -12,7 +12,6 @@
 #include <linux/of.h>
 
 #include <video/omapfb_dss.h>
-#include <video/omap-panel-data.h>
 
 struct panel_drv_data {
 	struct omap_dss_device dssdev;
@@ -178,53 +177,15 @@ static struct omap_dss_driver tvc_driver = {
 	.set_wss		= tvc_set_wss,
 };
 
-static int tvc_probe_pdata(struct platform_device *pdev)
-{
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
-	struct connector_atv_platform_data *pdata;
-	struct omap_dss_device *in, *dssdev;
-
-	pdata = dev_get_platdata(&pdev->dev);
-
-	in = omap_dss_find_output(pdata->source);
-	if (in == NULL) {
-		dev_err(&pdev->dev, "Failed to find video source\n");
-		return -EPROBE_DEFER;
-	}
-
-	ddata->in = in;
-
-	ddata->invert_polarity = pdata->invert_polarity;
-
-	dssdev = &ddata->dssdev;
-	dssdev->name = pdata->name;
-
-	return 0;
-}
-
-static int tvc_probe_of(struct platform_device *pdev)
-{
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
-	struct device_node *node = pdev->dev.of_node;
-	struct omap_dss_device *in;
-
-	in = omapdss_of_find_source_for_first_ep(node);
-	if (IS_ERR(in)) {
-		dev_err(&pdev->dev, "failed to find video source\n");
-		return PTR_ERR(in);
-	}
-
-	ddata->in = in;
-
-	return 0;
-}
-
 static int tvc_probe(struct platform_device *pdev)
 {
 	struct panel_drv_data *ddata;
 	struct omap_dss_device *dssdev;
 	int r;
 
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+
 	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return -ENOMEM;
@@ -232,16 +193,11 @@ static int tvc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ddata);
 	ddata->dev = &pdev->dev;
 
-	if (dev_get_platdata(&pdev->dev)) {
-		r = tvc_probe_pdata(pdev);
-		if (r)
-			return r;
-	} else if (pdev->dev.of_node) {
-		r = tvc_probe_of(pdev);
-		if (r)
-			return r;
-	} else {
-		return -ENODEV;
+	ddata->in = omapdss_of_find_source_for_first_ep(pdev->dev.of_node);
+	r = PTR_ERR_OR_ZERO(ddata->in);
+	if (r) {
+		dev_err(&pdev->dev, "failed to find video source\n");
+		return r;
 	}
 
 	ddata->timings = tvc_pal_timings;
diff --git a/include/video/omap-panel-data.h b/include/video/omap-panel-data.h
deleted file mode 100644
index 18172d7b97d0..000000000000
--- a/include/video/omap-panel-data.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Header containing platform_data structs for omap panels
- *
- * Copyright (C) 2013 Texas Instruments
- * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
- *	   Archit Taneja <archit@ti.com>
- *
- * Copyright (C) 2011 Texas Instruments
- * Author: Mayuresh Janorkar <mayur@ti.com>
- *
- * Copyright (C) 2010 Canonical Ltd.
- * Author: Bryan Wu <bryan.wu@canonical.com>
- */
-
-#ifndef __OMAP_PANEL_DATA_H
-#define __OMAP_PANEL_DATA_H
-
-#include <video/display_timing.h>
-
-/**
- * connector_atv platform data
- * @name: name for this display entity
- * @source: name of the display entity used as a video source
- * @invert_polarity: invert signal polarity
- */
-struct connector_atv_platform_data {
-	const char *name;
-	const char *source;
-
-	bool invert_polarity;
-};
-
-#endif /* __OMAP_PANEL_DATA_H */

-- 
b4 0.11.0-dev-28747
