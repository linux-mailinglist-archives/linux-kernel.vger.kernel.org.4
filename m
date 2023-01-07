Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F4B661109
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 19:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjAGS1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 13:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjAGS00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 13:26:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87E240C0D;
        Sat,  7 Jan 2023 10:26:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 481B5B8069E;
        Sat,  7 Jan 2023 18:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C762EC433F2;
        Sat,  7 Jan 2023 18:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673115981;
        bh=QCUNFz0znSG4dFhceksvrEhuu6q18JaC/eU7eQcVMhs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=gNCmrHkcPqnUS0a3xVSYftIawDJL6WdNZqVopye1CwTMJj+OhmtcQYMLORNIz1FOo
         S97tPD0HherWzF5Kwps1d8EAJxEhyUXvwpLBl/h5GGtdVQoVjd2DT3CgfL1IeGxijp
         snFUERcxs8PBMKNIMpS3HePYw3vZejQWMRJJwDJlwBV/xBj1KLy1uAxFeW5XxMSQTs
         rGUfWMHLMEYk4qDrkJ699dpdgnxHQmp6LgXcA3g/E9PzRQVGY8PoSwAFEQTJ5M9LVL
         gizeOLkHxcMldONRUSdVHL+ZgJ7gDSv/UrELN9hk8nJSzZK5th0Fx7sDpSCD4AgI6w
         BljwABlVUmJ3w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id AE3BBC46467;
        Sat,  7 Jan 2023 18:26:21 +0000 (UTC)
From:   Sam Ravnborg via B4 Submission Endpoint 
        <devnull+sam.ravnborg.org@kernel.org>
Date:   Sat, 07 Jan 2023 19:26:24 +0100
Subject: [PATCH 10/15] staging: fbtft: core: Introduce backlight_is_blank()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230107-sam-video-backlight-drop-fb_blank-v1-10-1bd9bafb351f@ravnborg.org>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
In-Reply-To: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Helge Deller <deller@gmx.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-staging@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, Stephen Kitt <steve@sk2.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Peter Suti <peter.suti@streamunlimited.com>
X-Mailer: b4 0.11.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673115978; l=1663;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=Wny8vn8SDkRFcw+Qd/s3t358GYJs/Zyqd9rf2tuHfYI=; =?utf-8?q?b=3DpUFPIy6NmR07?=
 =?utf-8?q?yB69L54dJFCXBLLZDCl3QadyGkyvIJRXwpp/cDw+au/L/QLDJM/P3+uhQAXfQqQh?=
 c5dV85FVDaufnLt7Gjhp/q9XLr2r6KxOVyTl6bK1oMF8wdtfOS7s
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Submission Endpoint for sam@ravnborg.org/20230107 with auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: <sam@ravnborg.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>

Avoiding direct access to backlight_properties.props.

Access to the deprecated props.fb_blank replaced by backlight_is_blank().
Access to props.power is dropped - it was only used for debug.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Stephen Kitt <steve@sk2.org>
Cc: Peter Suti <peter.suti@streamunlimited.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/staging/fbtft/fbtft-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index afaba94d1d1c..1746327e1939 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -132,15 +132,15 @@ static int fbtft_backlight_update_status(struct backlight_device *bd)
 {
 	struct fbtft_par *par = bl_get_data(bd);
 	bool polarity = par->polarity;
+	bool blank = backlight_is_blank(bd);
 
-	fbtft_par_dbg(DEBUG_BACKLIGHT, par,
-		      "%s: polarity=%d, power=%d, fb_blank=%d\n",
-		      __func__, polarity, bd->props.power, bd->props.fb_blank);
+	fbtft_par_dbg(DEBUG_BACKLIGHT, par, "%s: polarity=%d, blank=%d\n",
+		      __func__, polarity, blank);
 
-	if (!backlight_is_blank(bd))
-		gpiod_set_value(par->gpio.led[0], polarity);
-	else
+	if (blank)
 		gpiod_set_value(par->gpio.led[0], !polarity);
+	else
+		gpiod_set_value(par->gpio.led[0], polarity);
 
 	return 0;
 }

-- 
2.34.1
