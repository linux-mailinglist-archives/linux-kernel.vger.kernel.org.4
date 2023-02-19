Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9010E69C018
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 12:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjBSLqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 06:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjBSLqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 06:46:25 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9FDCA27
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 03:46:19 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4PKNzr1FXvz9sTx;
        Sun, 19 Feb 2023 12:46:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1676807176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8s5cyNEZ69bCI7i4TE/gwmJDIVWf0jgsyM+wk8nT1gY=;
        b=s3wUanb3YMmzXRANmsUL8lF+o9wOEVWd3y/FWEjtg+7HBePxjG3AreJ23l6BxZtNaPsvB6
        0LBtV2Tyf17CzJcwwrq905k6uBdrBs1MPVipxfe4ITTKtEPe8KdPtdPDLL2ZlKKIvIwqSZ
        xUXSQeefBi5+YJLoUN6Y8qSRfMNlI8spIaVqrrZ02Uwut5tUrNeSGGlZuYSsY9vLOrvSV8
        XQuxZ2BtLc8LYzuy1D3MCMBzKh/Og+O206xdb+vqtBENxQub+D6XuQ2TCptObgc61Lu9vX
        doSpstvqiKbAas+ZPWJLb/CyhaAE2tuVu5naGAJkXlna4z7OzD2Zsut5sL++1A==
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Ondrej Jirman <megous@megous.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM PANEL DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc:     Frank Oltmanns <frank@oltmanns.dev>
Subject: [PATCH 1/1] drm/panel: st7703: Fix vertical refresh rate of XBD599
Date:   Sun, 19 Feb 2023 12:45:53 +0100
Message-Id: <20230219114553.288057-2-frank@oltmanns.dev>
In-Reply-To: <20230219114553.288057-1-frank@oltmanns.dev>
References: <20230219114553.288057-1-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4PKNzr1FXvz9sTx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the XBD599 panel's slight visual stutter by correcting the pixel
clock speed so that the panel's 60Hz vertical refresh rate is met.

Set the clock speed using the underlying formula instead of a magic
number. To have a consistent procedure for both panels, set the JH057N
panel's clock also as a formula.
---
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index 6747ca237ced..cd7d631f7573 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -139,7 +139,7 @@ static const struct drm_display_mode jh057n00900_mode = {
 	.vsync_start = 1440 + 20,
 	.vsync_end   = 1440 + 20 + 4,
 	.vtotal	     = 1440 + 20 + 4 + 12,
-	.clock	     = 75276,
+	.clock	     = (720 + 90 + 20 + 20) * (1440 + 20 + 4 + 12) * 60 / 1000,
 	.flags	     = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
 	.width_mm    = 65,
 	.height_mm   = 130,
@@ -324,7 +324,7 @@ static const struct drm_display_mode xbd599_mode = {
 	.vsync_start = 1440 + 18,
 	.vsync_end   = 1440 + 18 + 10,
 	.vtotal	     = 1440 + 18 + 10 + 17,
-	.clock	     = 69000,
+	.clock	     = (720 + 40 + 40 + 40) * (1440 + 18 + 10 + 17) * 60 / 1000,
 	.flags	     = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
 	.width_mm    = 68,
 	.height_mm   = 136,
-- 
2.39.1

