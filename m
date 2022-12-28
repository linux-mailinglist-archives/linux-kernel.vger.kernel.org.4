Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C846571D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbiL1BuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbiL1Btf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:49:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9355F21
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672192100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UzhOyd87pzqH2lLPP8bW2hUWTvEpAwSTndaCbjcNTpo=;
        b=FYR4XCck0qoo4lrIJwA2nmwuwYMRP62xBQjQQ31JKt75zJwKd2/JCTB4jJlaH1x+Vcym1F
        pZ4xw4M8bZ5REmdmJgrwmXr/U87alrkuiMiYAKWJsW2gHeYXxrFBxiZDm3B/VQwN5cpH2U
        1lcRNkH1RDcHbWZzNOMrX0G0zYN+JD4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-75-B8WGzFoqPuC-5jCDdzrxAg-1; Tue, 27 Dec 2022 20:48:18 -0500
X-MC-Unique: B8WGzFoqPuC-5jCDdzrxAg-1
Received: by mail-wm1-f72.google.com with SMTP id fm25-20020a05600c0c1900b003d9702a11e5so5976339wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzhOyd87pzqH2lLPP8bW2hUWTvEpAwSTndaCbjcNTpo=;
        b=QgBexI3Ab3HY7ATaJ3jD/ye5PIeDPyx9r9NhnkNDL0gBZnNGucN3poDldTN61NIrdu
         c9E5E6YL1DR3/jQVEHOt5SxlywUplmC/TlaVQ+8zBvpRfTUaK8M9QNMvEJspAQGCNTQp
         W0G0zTDwhOCqHDtk3YKLbG04o6a0KWbP2/q/pEnqX8yHyd5hZST87RONNH6F6Dvm1/W5
         2wvUTcEDyutvh+uXb0JqBt9pz5HBHxDo+BCWfZB6gKSnuP2McyzDNDlZIIY3g4+AYntk
         pjIRN3YZCMFfmTL7sUz1ZzVYm0j7uNwSzOYZAeZud1yHn80BPqF9wZyrUcf4k2+72Z3f
         vJcQ==
X-Gm-Message-State: AFqh2kp8zppSWP6ECStI1kLNfIpeiDLpBnfZhqBqFa9F/vOlesAQy4qJ
        UvtcCHHuFkwo8tr3cdhRMA7yuApxvfYRTFSQHfqKtc7zvUNSlD93tkb010Yd0YIaI4QwsAiMS9s
        C/piPAHXNRW4tmuHpOrMvseRNVG1PsQPRI/+UQxkahKe8x8TCgVr4wn90/barj3p1AVBXS/uekq
        w=
X-Received: by 2002:a5d:6244:0:b0:242:eb5:254f with SMTP id m4-20020a5d6244000000b002420eb5254fmr13630617wrv.48.1672192096954;
        Tue, 27 Dec 2022 17:48:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs8CwqFT9w2GCJT0hpiJ5lnmv6UiA/bcKXFdt9OP764WinkWZC0pn6kDbgah1SaCPsH72jgNA==
X-Received: by 2002:a5d:6244:0:b0:242:eb5:254f with SMTP id m4-20020a5d6244000000b002420eb5254fmr13630603wrv.48.1672192096692;
        Tue, 27 Dec 2022 17:48:16 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k16-20020a056000005000b002258235bda3sm14158873wrx.61.2022.12.27.17.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:48:16 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 09/14] drm/panel-samsung-s6e88a0-ams452ef01: Drop custom DSI write macro
Date:   Wed, 28 Dec 2022 02:47:52 +0100
Message-Id: <20221228014757.3170486-10-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221228014757.3170486-1-javierm@redhat.com>
References: <20221228014757.3170486-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a macro for this already in the <drm/drm_mipi_dsi.h> header, use
that instead and delete the custom DSI write macro defined in the driver.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 .../panel/panel-samsung-s6e88a0-ams452ef01.c  | 24 +++++++------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c
index 97ff7a18545c..e94d88fed4f3 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c
@@ -28,14 +28,6 @@ s6e88a0_ams452ef01 *to_s6e88a0_ams452ef01(struct drm_panel *panel)
 	return container_of(panel, struct s6e88a0_ams452ef01, panel);
 }
 
-#define dsi_dcs_write_seq(dsi, seq...) do {				\
-		static const u8 d[] = { seq };				\
-		int ret;						\
-		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));	\
-		if (ret < 0)						\
-			return ret;					\
-	} while (0)
-
 static void s6e88a0_ams452ef01_reset(struct s6e88a0_ams452ef01 *ctx)
 {
 	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
@@ -54,8 +46,8 @@ static int s6e88a0_ams452ef01_on(struct s6e88a0_ams452ef01 *ctx)
 
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
-	dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a); // enable LEVEL2 commands
-	dsi_dcs_write_seq(dsi, 0xcc, 0x4c); // set Pixel Clock Divider polarity
+	mipi_dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a); // enable LEVEL2 commands
+	mipi_dsi_dcs_write_seq(dsi, 0xcc, 0x4c); // set Pixel Clock Divider polarity
 
 	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
 	if (ret < 0) {
@@ -65,7 +57,7 @@ static int s6e88a0_ams452ef01_on(struct s6e88a0_ams452ef01 *ctx)
 	msleep(120);
 
 	// set default brightness/gama
-	dsi_dcs_write_seq(dsi, 0xca,
+	mipi_dsi_dcs_write_seq(dsi, 0xca,
 			  0x01, 0x00, 0x01, 0x00, 0x01, 0x00,	// V255 RR,GG,BB
 			  0x80, 0x80, 0x80,			// V203 R,G,B
 			  0x80, 0x80, 0x80,			// V151 R,G,B
@@ -77,11 +69,11 @@ static int s6e88a0_ams452ef01_on(struct s6e88a0_ams452ef01 *ctx)
 			  0x6b, 0x68, 0x71,			// V3   R,G,B
 			  0x00, 0x00, 0x00);			// V1   R,G,B
 	// set default Amoled Off Ratio
-	dsi_dcs_write_seq(dsi, 0xb2, 0x40, 0x0a, 0x17, 0x00, 0x0a);
-	dsi_dcs_write_seq(dsi, 0xb6, 0x2c, 0x0b); // set default elvss voltage
-	dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
-	dsi_dcs_write_seq(dsi, 0xf7, 0x03); // gamma/aor update
-	dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5); // disable LEVEL2 commands
+	mipi_dsi_dcs_write_seq(dsi, 0xb2, 0x40, 0x0a, 0x17, 0x00, 0x0a);
+	mipi_dsi_dcs_write_seq(dsi, 0xb6, 0x2c, 0x0b); // set default elvss voltage
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, 0xf7, 0x03); // gamma/aor update
+	mipi_dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5); // disable LEVEL2 commands
 
 	ret = mipi_dsi_dcs_set_display_on(dsi);
 	if (ret < 0) {
-- 
2.38.1

