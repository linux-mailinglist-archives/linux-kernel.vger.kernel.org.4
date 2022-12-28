Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DDA6571D7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbiL1Bur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbiL1Btu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:49:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A611093
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672192105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJ9ByJhLFtruVSADsqTR17Oo03521BCywNVbpeo2Wkc=;
        b=YSpEeD+WIZeL/fibxNI9b0Eeg16WBTZ2OZaZ3Wd1Keovwdw3b/2f5SP7h2VyHHveWSHd3s
        cmQip2hp+8RTzxRG8Cel6aKIAlTHmW40IkscbZ8sxR52/YAbU+m8XMi+MLAvnyYJgBFbxP
        IP5H+LyN3jpO2/IYp1+BXUG0bmD9zjk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-346-Shay2kF4N5mpVnfzBHw-9w-1; Tue, 27 Dec 2022 20:48:24 -0500
X-MC-Unique: Shay2kF4N5mpVnfzBHw-9w-1
Received: by mail-wm1-f72.google.com with SMTP id q21-20020a7bce95000000b003d236c91639so3557837wmj.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJ9ByJhLFtruVSADsqTR17Oo03521BCywNVbpeo2Wkc=;
        b=R2rZemYs13BgK0Ugb87RP58zQQzsPmvGAHVj2IDFyd1LvUYEjtT65tVDIovBHdKY4I
         QnIdSo0n+PyqCSwOffHieFq+HTvyVCcix9sKrbdGYscoF9jFnWHa8XPonkpsTVuqjlol
         reY7sA56WsW/ZxnzXUnjAQSnIkuElu7byKCn0OoZX5j1Ly938yykdwl4NJMCgAoIGivL
         YE4jM94Wi+OrDSxpHkab2Nb3x8zY29E/vXaDYn3em8Knnq5ZCA9e8p+sCCzUUFps8XUI
         xdUdn3CosZJGWfD6onCQsXYBl9X3PZgKRKqAaKtRhRBJBd3m2KSGXFuf3s2UCvPQwvAi
         BvMw==
X-Gm-Message-State: AFqh2koQ2oNgjCnBHgTvog1o2qghrlQIIY5z+pukCZ55xx5HEJWyBIAx
        CNfsJdvoaXDXzrqmS8RPQewYiEXTHUfdQWosTX7W5WdAiKZMMNkM2Kb99MCqM2YK3MDaPSItKfd
        VCRJBIknv3TKYUle860FWywo+cDH+TdCch9VfZRpc3O583h487XD0yVgA+K0dlvkto/D5iywrAk
        g=
X-Received: by 2002:adf:e10d:0:b0:242:865d:e8d8 with SMTP id t13-20020adfe10d000000b00242865de8d8mr13616569wrz.55.1672192102425;
        Tue, 27 Dec 2022 17:48:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXto0dUlk2L/lKOPF0mvD1oTgPxosonK8r2amfhA5L22s34jg0tDHMwnP/XZmdvPcdpmutQBhA==
X-Received: by 2002:adf:e10d:0:b0:242:865d:e8d8 with SMTP id t13-20020adfe10d000000b00242865de8d8mr13616559wrz.55.1672192101998;
        Tue, 27 Dec 2022 17:48:21 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k16-20020a056000005000b002258235bda3sm14158873wrx.61.2022.12.27.17.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:48:21 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 13/14] drm/panel-sony-tulip-truly-nt35521: Drop custom DSI write macro
Date:   Wed, 28 Dec 2022 02:47:56 +0100
Message-Id: <20221228014757.3170486-14-javierm@redhat.com>
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

 .../panel/panel-sony-tulip-truly-nt35521.c    | 348 +++++++++---------
 1 file changed, 170 insertions(+), 178 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c b/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
index fa9be3c299c0..a0661576acff 100644
--- a/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
+++ b/drivers/gpu/drm/panel/panel-sony-tulip-truly-nt35521.c
@@ -33,14 +33,6 @@ struct truly_nt35521 *to_truly_nt35521(struct drm_panel *panel)
 	return container_of(panel, struct truly_nt35521, panel);
 }
 
-#define dsi_generic_write_seq(dsi, seq...) do {				\
-		static const u8 d[] = { seq };				\
-		int ret;						\
-		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));	\
-		if (ret < 0)						\
-			return ret;					\
-	} while (0)
-
 static void truly_nt35521_reset(struct truly_nt35521 *ctx)
 {
 	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
@@ -59,200 +51,200 @@ static int truly_nt35521_on(struct truly_nt35521 *ctx)
 
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
-	dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x00);
-	dsi_generic_write_seq(dsi, 0xff, 0xaa, 0x55, 0xa5, 0x80);
-	dsi_generic_write_seq(dsi, 0x6f, 0x11, 0x00);
-	dsi_generic_write_seq(dsi, 0xf7, 0x20, 0x00);
-	dsi_generic_write_seq(dsi, 0x6f, 0x01);
-	dsi_generic_write_seq(dsi, 0xb1, 0x21);
-	dsi_generic_write_seq(dsi, 0xbd, 0x01, 0xa0, 0x10, 0x08, 0x01);
-	dsi_generic_write_seq(dsi, 0xb8, 0x01, 0x02, 0x0c, 0x02);
-	dsi_generic_write_seq(dsi, 0xbb, 0x11, 0x11);
-	dsi_generic_write_seq(dsi, 0xbc, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, 0xb6, 0x02);
-	dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x01);
-	dsi_generic_write_seq(dsi, 0xb0, 0x09, 0x09);
-	dsi_generic_write_seq(dsi, 0xb1, 0x09, 0x09);
-	dsi_generic_write_seq(dsi, 0xbc, 0x8c, 0x00);
-	dsi_generic_write_seq(dsi, 0xbd, 0x8c, 0x00);
-	dsi_generic_write_seq(dsi, 0xca, 0x00);
-	dsi_generic_write_seq(dsi, 0xc0, 0x04);
-	dsi_generic_write_seq(dsi, 0xbe, 0xb5);
-	dsi_generic_write_seq(dsi, 0xb3, 0x35, 0x35);
-	dsi_generic_write_seq(dsi, 0xb4, 0x25, 0x25);
-	dsi_generic_write_seq(dsi, 0xb9, 0x43, 0x43);
-	dsi_generic_write_seq(dsi, 0xba, 0x24, 0x24);
-	dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x02);
-	dsi_generic_write_seq(dsi, 0xee, 0x03);
-	dsi_generic_write_seq(dsi, 0xb0,
+	mipi_dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xff, 0xaa, 0x55, 0xa5, 0x80);
+	mipi_dsi_generic_write_seq(dsi, 0x6f, 0x11, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xf7, 0x20, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0x6f, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0xb1, 0x21);
+	mipi_dsi_generic_write_seq(dsi, 0xbd, 0x01, 0xa0, 0x10, 0x08, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0xb8, 0x01, 0x02, 0x0c, 0x02);
+	mipi_dsi_generic_write_seq(dsi, 0xbb, 0x11, 0x11);
+	mipi_dsi_generic_write_seq(dsi, 0xbc, 0x00, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xb6, 0x02);
+	mipi_dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x09, 0x09);
+	mipi_dsi_generic_write_seq(dsi, 0xb1, 0x09, 0x09);
+	mipi_dsi_generic_write_seq(dsi, 0xbc, 0x8c, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xbd, 0x8c, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xca, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xc0, 0x04);
+	mipi_dsi_generic_write_seq(dsi, 0xbe, 0xb5);
+	mipi_dsi_generic_write_seq(dsi, 0xb3, 0x35, 0x35);
+	mipi_dsi_generic_write_seq(dsi, 0xb4, 0x25, 0x25);
+	mipi_dsi_generic_write_seq(dsi, 0xb9, 0x43, 0x43);
+	mipi_dsi_generic_write_seq(dsi, 0xba, 0x24, 0x24);
+	mipi_dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x02);
+	mipi_dsi_generic_write_seq(dsi, 0xee, 0x03);
+	mipi_dsi_generic_write_seq(dsi, 0xb0,
 			      0x00, 0xb2, 0x00, 0xb3, 0x00, 0xb6, 0x00, 0xc3,
 			      0x00, 0xce, 0x00, 0xe1, 0x00, 0xf3, 0x01, 0x11);
-	dsi_generic_write_seq(dsi, 0xb1,
+	mipi_dsi_generic_write_seq(dsi, 0xb1,
 			      0x01, 0x2e, 0x01, 0x5c, 0x01, 0x82, 0x01, 0xc3,
 			      0x01, 0xfe, 0x02, 0x00, 0x02, 0x37, 0x02, 0x77);
-	dsi_generic_write_seq(dsi, 0xb2,
+	mipi_dsi_generic_write_seq(dsi, 0xb2,
 			      0x02, 0xa1, 0x02, 0xd7, 0x02, 0xfe, 0x03, 0x2c,
 			      0x03, 0x4b, 0x03, 0x63, 0x03, 0x8f, 0x03, 0x90);
-	dsi_generic_write_seq(dsi, 0xb3, 0x03, 0x96, 0x03, 0x98);
-	dsi_generic_write_seq(dsi, 0xb4,
+	mipi_dsi_generic_write_seq(dsi, 0xb3, 0x03, 0x96, 0x03, 0x98);
+	mipi_dsi_generic_write_seq(dsi, 0xb4,
 			      0x00, 0x81, 0x00, 0x8b, 0x00, 0x9c, 0x00, 0xa9,
 			      0x00, 0xb5, 0x00, 0xcb, 0x00, 0xdf, 0x01, 0x02);
-	dsi_generic_write_seq(dsi, 0xb5,
+	mipi_dsi_generic_write_seq(dsi, 0xb5,
 			      0x01, 0x1f, 0x01, 0x51, 0x01, 0x7a, 0x01, 0xbf,
 			      0x01, 0xfa, 0x01, 0xfc, 0x02, 0x34, 0x02, 0x76);
-	dsi_generic_write_seq(dsi, 0xb6,
+	mipi_dsi_generic_write_seq(dsi, 0xb6,
 			      0x02, 0x9f, 0x02, 0xd7, 0x02, 0xfc, 0x03, 0x2c,
 			      0x03, 0x4a, 0x03, 0x63, 0x03, 0x8f, 0x03, 0xa2);
-	dsi_generic_write_seq(dsi, 0xb7, 0x03, 0xb8, 0x03, 0xba);
-	dsi_generic_write_seq(dsi, 0xb8,
+	mipi_dsi_generic_write_seq(dsi, 0xb7, 0x03, 0xb8, 0x03, 0xba);
+	mipi_dsi_generic_write_seq(dsi, 0xb8,
 			      0x00, 0x01, 0x00, 0x02, 0x00, 0x0e, 0x00, 0x2a,
 			      0x00, 0x41, 0x00, 0x67, 0x00, 0x87, 0x00, 0xb9);
-	dsi_generic_write_seq(dsi, 0xb9,
+	mipi_dsi_generic_write_seq(dsi, 0xb9,
 			      0x00, 0xe2, 0x01, 0x22, 0x01, 0x54, 0x01, 0xa3,
 			      0x01, 0xe6, 0x01, 0xe7, 0x02, 0x24, 0x02, 0x67);
-	dsi_generic_write_seq(dsi, 0xba,
+	mipi_dsi_generic_write_seq(dsi, 0xba,
 			      0x02, 0x93, 0x02, 0xcd, 0x02, 0xf6, 0x03, 0x31,
 			      0x03, 0x6c, 0x03, 0xe9, 0x03, 0xef, 0x03, 0xf4);
-	dsi_generic_write_seq(dsi, 0xbb, 0x03, 0xf6, 0x03, 0xf7);
-	dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x03);
-	dsi_generic_write_seq(dsi, 0xb0, 0x22, 0x00);
-	dsi_generic_write_seq(dsi, 0xb1, 0x22, 0x00);
-	dsi_generic_write_seq(dsi, 0xb2, 0x05, 0x00, 0x60, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, 0xb3, 0x05, 0x00, 0x60, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, 0xb4, 0x05, 0x00, 0x60, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, 0xb5, 0x05, 0x00, 0x60, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, 0xba, 0x53, 0x00, 0x60, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, 0xbb, 0x53, 0x00, 0x60, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, 0xbc, 0x53, 0x00, 0x60, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, 0xbd, 0x53, 0x00, 0x60, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, 0xc0, 0x00, 0x34, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, 0xc1, 0x00, 0x00, 0x34, 0x00);
-	dsi_generic_write_seq(dsi, 0xc2, 0x00, 0x00, 0x34, 0x00);
-	dsi_generic_write_seq(dsi, 0xc3, 0x00, 0x00, 0x34, 0x00);
-	dsi_generic_write_seq(dsi, 0xc4, 0x60);
-	dsi_generic_write_seq(dsi, 0xc5, 0xc0);
-	dsi_generic_write_seq(dsi, 0xc6, 0x00);
-	dsi_generic_write_seq(dsi, 0xc7, 0x00);
-	dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x05);
-	dsi_generic_write_seq(dsi, 0xb0, 0x17, 0x06);
-	dsi_generic_write_seq(dsi, 0xb1, 0x17, 0x06);
-	dsi_generic_write_seq(dsi, 0xb2, 0x17, 0x06);
-	dsi_generic_write_seq(dsi, 0xb3, 0x17, 0x06);
-	dsi_generic_write_seq(dsi, 0xb4, 0x17, 0x06);
-	dsi_generic_write_seq(dsi, 0xb5, 0x17, 0x06);
-	dsi_generic_write_seq(dsi, 0xb6, 0x17, 0x06);
-	dsi_generic_write_seq(dsi, 0xb7, 0x17, 0x06);
-	dsi_generic_write_seq(dsi, 0xb8, 0x00);
-	dsi_generic_write_seq(dsi, 0xb9, 0x00, 0x03);
-	dsi_generic_write_seq(dsi, 0xba, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, 0xbb, 0x02, 0x03);
-	dsi_generic_write_seq(dsi, 0xbc, 0x02, 0x03);
-	dsi_generic_write_seq(dsi, 0xbd, 0x03, 0x03, 0x00, 0x03, 0x03);
-	dsi_generic_write_seq(dsi, 0xc0, 0x0b);
-	dsi_generic_write_seq(dsi, 0xc1, 0x09);
-	dsi_generic_write_seq(dsi, 0xc2, 0xa6);
-	dsi_generic_write_seq(dsi, 0xc3, 0x05);
-	dsi_generic_write_seq(dsi, 0xc4, 0x00);
-	dsi_generic_write_seq(dsi, 0xc5, 0x02);
-	dsi_generic_write_seq(dsi, 0xc6, 0x22);
-	dsi_generic_write_seq(dsi, 0xc7, 0x03);
-	dsi_generic_write_seq(dsi, 0xc8, 0x07, 0x20);
-	dsi_generic_write_seq(dsi, 0xc9, 0x03, 0x20);
-	dsi_generic_write_seq(dsi, 0xca, 0x01, 0x60);
-	dsi_generic_write_seq(dsi, 0xcb, 0x01, 0x60);
-	dsi_generic_write_seq(dsi, 0xcc, 0x00, 0x00, 0x02);
-	dsi_generic_write_seq(dsi, 0xcd, 0x00, 0x00, 0x02);
-	dsi_generic_write_seq(dsi, 0xce, 0x00, 0x00, 0x02);
-	dsi_generic_write_seq(dsi, 0xcf, 0x00, 0x00, 0x02);
-	dsi_generic_write_seq(dsi, 0xd1, 0x00, 0x05, 0x01, 0x07, 0x10);
-	dsi_generic_write_seq(dsi, 0xd2, 0x10, 0x05, 0x05, 0x03, 0x10);
-	dsi_generic_write_seq(dsi, 0xd3, 0x20, 0x00, 0x43, 0x07, 0x10);
-	dsi_generic_write_seq(dsi, 0xd4, 0x30, 0x00, 0x43, 0x07, 0x10);
-	dsi_generic_write_seq(dsi, 0xd0,
+	mipi_dsi_generic_write_seq(dsi, 0xbb, 0x03, 0xf6, 0x03, 0xf7);
+	mipi_dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x03);
+	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x22, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xb1, 0x22, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xb2, 0x05, 0x00, 0x60, 0x00, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xb3, 0x05, 0x00, 0x60, 0x00, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xb4, 0x05, 0x00, 0x60, 0x00, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xb5, 0x05, 0x00, 0x60, 0x00, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xba, 0x53, 0x00, 0x60, 0x00, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xbb, 0x53, 0x00, 0x60, 0x00, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xbc, 0x53, 0x00, 0x60, 0x00, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xbd, 0x53, 0x00, 0x60, 0x00, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xc0, 0x00, 0x34, 0x00, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xc1, 0x00, 0x00, 0x34, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xc2, 0x00, 0x00, 0x34, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xc3, 0x00, 0x00, 0x34, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xc4, 0x60);
+	mipi_dsi_generic_write_seq(dsi, 0xc5, 0xc0);
+	mipi_dsi_generic_write_seq(dsi, 0xc6, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xc7, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x05);
+	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x17, 0x06);
+	mipi_dsi_generic_write_seq(dsi, 0xb1, 0x17, 0x06);
+	mipi_dsi_generic_write_seq(dsi, 0xb2, 0x17, 0x06);
+	mipi_dsi_generic_write_seq(dsi, 0xb3, 0x17, 0x06);
+	mipi_dsi_generic_write_seq(dsi, 0xb4, 0x17, 0x06);
+	mipi_dsi_generic_write_seq(dsi, 0xb5, 0x17, 0x06);
+	mipi_dsi_generic_write_seq(dsi, 0xb6, 0x17, 0x06);
+	mipi_dsi_generic_write_seq(dsi, 0xb7, 0x17, 0x06);
+	mipi_dsi_generic_write_seq(dsi, 0xb8, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xb9, 0x00, 0x03);
+	mipi_dsi_generic_write_seq(dsi, 0xba, 0x00, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xbb, 0x02, 0x03);
+	mipi_dsi_generic_write_seq(dsi, 0xbc, 0x02, 0x03);
+	mipi_dsi_generic_write_seq(dsi, 0xbd, 0x03, 0x03, 0x00, 0x03, 0x03);
+	mipi_dsi_generic_write_seq(dsi, 0xc0, 0x0b);
+	mipi_dsi_generic_write_seq(dsi, 0xc1, 0x09);
+	mipi_dsi_generic_write_seq(dsi, 0xc2, 0xa6);
+	mipi_dsi_generic_write_seq(dsi, 0xc3, 0x05);
+	mipi_dsi_generic_write_seq(dsi, 0xc4, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xc5, 0x02);
+	mipi_dsi_generic_write_seq(dsi, 0xc6, 0x22);
+	mipi_dsi_generic_write_seq(dsi, 0xc7, 0x03);
+	mipi_dsi_generic_write_seq(dsi, 0xc8, 0x07, 0x20);
+	mipi_dsi_generic_write_seq(dsi, 0xc9, 0x03, 0x20);
+	mipi_dsi_generic_write_seq(dsi, 0xca, 0x01, 0x60);
+	mipi_dsi_generic_write_seq(dsi, 0xcb, 0x01, 0x60);
+	mipi_dsi_generic_write_seq(dsi, 0xcc, 0x00, 0x00, 0x02);
+	mipi_dsi_generic_write_seq(dsi, 0xcd, 0x00, 0x00, 0x02);
+	mipi_dsi_generic_write_seq(dsi, 0xce, 0x00, 0x00, 0x02);
+	mipi_dsi_generic_write_seq(dsi, 0xcf, 0x00, 0x00, 0x02);
+	mipi_dsi_generic_write_seq(dsi, 0xd1, 0x00, 0x05, 0x01, 0x07, 0x10);
+	mipi_dsi_generic_write_seq(dsi, 0xd2, 0x10, 0x05, 0x05, 0x03, 0x10);
+	mipi_dsi_generic_write_seq(dsi, 0xd3, 0x20, 0x00, 0x43, 0x07, 0x10);
+	mipi_dsi_generic_write_seq(dsi, 0xd4, 0x30, 0x00, 0x43, 0x07, 0x10);
+	mipi_dsi_generic_write_seq(dsi, 0xd0,
 			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, 0xd5,
+	mipi_dsi_generic_write_seq(dsi, 0xd5,
 			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 			      0x00, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, 0xd6,
+	mipi_dsi_generic_write_seq(dsi, 0xd6,
 			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 			      0x00, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, 0xd7,
+	mipi_dsi_generic_write_seq(dsi, 0xd7,
 			      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 			      0x00, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, 0xd8, 0x00, 0x00, 0x00, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, 0xe5, 0x06);
-	dsi_generic_write_seq(dsi, 0xe6, 0x06);
-	dsi_generic_write_seq(dsi, 0xe7, 0x00);
-	dsi_generic_write_seq(dsi, 0xe8, 0x06);
-	dsi_generic_write_seq(dsi, 0xe9, 0x06);
-	dsi_generic_write_seq(dsi, 0xea, 0x06);
-	dsi_generic_write_seq(dsi, 0xeb, 0x00);
-	dsi_generic_write_seq(dsi, 0xec, 0x00);
-	dsi_generic_write_seq(dsi, 0xed, 0x30);
-	dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x06);
-	dsi_generic_write_seq(dsi, 0xb0, 0x31, 0x31);
-	dsi_generic_write_seq(dsi, 0xb1, 0x31, 0x31);
-	dsi_generic_write_seq(dsi, 0xb2, 0x2d, 0x2e);
-	dsi_generic_write_seq(dsi, 0xb3, 0x31, 0x34);
-	dsi_generic_write_seq(dsi, 0xb4, 0x29, 0x2a);
-	dsi_generic_write_seq(dsi, 0xb5, 0x12, 0x10);
-	dsi_generic_write_seq(dsi, 0xb6, 0x18, 0x16);
-	dsi_generic_write_seq(dsi, 0xb7, 0x00, 0x02);
-	dsi_generic_write_seq(dsi, 0xb8, 0x08, 0x31);
-	dsi_generic_write_seq(dsi, 0xb9, 0x31, 0x31);
-	dsi_generic_write_seq(dsi, 0xba, 0x31, 0x31);
-	dsi_generic_write_seq(dsi, 0xbb, 0x31, 0x08);
-	dsi_generic_write_seq(dsi, 0xbc, 0x03, 0x01);
-	dsi_generic_write_seq(dsi, 0xbd, 0x17, 0x19);
-	dsi_generic_write_seq(dsi, 0xbe, 0x11, 0x13);
-	dsi_generic_write_seq(dsi, 0xbf, 0x2a, 0x29);
-	dsi_generic_write_seq(dsi, 0xc0, 0x34, 0x31);
-	dsi_generic_write_seq(dsi, 0xc1, 0x2e, 0x2d);
-	dsi_generic_write_seq(dsi, 0xc2, 0x31, 0x31);
-	dsi_generic_write_seq(dsi, 0xc3, 0x31, 0x31);
-	dsi_generic_write_seq(dsi, 0xc4, 0x31, 0x31);
-	dsi_generic_write_seq(dsi, 0xc5, 0x31, 0x31);
-	dsi_generic_write_seq(dsi, 0xc6, 0x2e, 0x2d);
-	dsi_generic_write_seq(dsi, 0xc7, 0x31, 0x34);
-	dsi_generic_write_seq(dsi, 0xc8, 0x29, 0x2a);
-	dsi_generic_write_seq(dsi, 0xc9, 0x17, 0x19);
-	dsi_generic_write_seq(dsi, 0xca, 0x11, 0x13);
-	dsi_generic_write_seq(dsi, 0xcb, 0x03, 0x01);
-	dsi_generic_write_seq(dsi, 0xcc, 0x08, 0x31);
-	dsi_generic_write_seq(dsi, 0xcd, 0x31, 0x31);
-	dsi_generic_write_seq(dsi, 0xce, 0x31, 0x31);
-	dsi_generic_write_seq(dsi, 0xcf, 0x31, 0x08);
-	dsi_generic_write_seq(dsi, 0xd0, 0x00, 0x02);
-	dsi_generic_write_seq(dsi, 0xd1, 0x12, 0x10);
-	dsi_generic_write_seq(dsi, 0xd2, 0x18, 0x16);
-	dsi_generic_write_seq(dsi, 0xd3, 0x2a, 0x29);
-	dsi_generic_write_seq(dsi, 0xd4, 0x34, 0x31);
-	dsi_generic_write_seq(dsi, 0xd5, 0x2d, 0x2e);
-	dsi_generic_write_seq(dsi, 0xd6, 0x31, 0x31);
-	dsi_generic_write_seq(dsi, 0xd7, 0x31, 0x31);
-	dsi_generic_write_seq(dsi, 0xe5, 0x31, 0x31);
-	dsi_generic_write_seq(dsi, 0xe6, 0x31, 0x31);
-	dsi_generic_write_seq(dsi, 0xd8, 0x00, 0x00, 0x00, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, 0xd9, 0x00, 0x00, 0x00, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, 0xe7, 0x00);
-	dsi_generic_write_seq(dsi, 0x6f, 0x02);
-	dsi_generic_write_seq(dsi, 0xf7, 0x47);
-	dsi_generic_write_seq(dsi, 0x6f, 0x0a);
-	dsi_generic_write_seq(dsi, 0xf7, 0x02);
-	dsi_generic_write_seq(dsi, 0x6f, 0x17);
-	dsi_generic_write_seq(dsi, 0xf4, 0x60);
-	dsi_generic_write_seq(dsi, 0x6f, 0x01);
-	dsi_generic_write_seq(dsi, 0xf9, 0x46);
-	dsi_generic_write_seq(dsi, 0x6f, 0x11);
-	dsi_generic_write_seq(dsi, 0xf3, 0x01);
-	dsi_generic_write_seq(dsi, 0x35, 0x00);
-	dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x00);
-	dsi_generic_write_seq(dsi, 0xd9, 0x02, 0x03, 0x00);
-	dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x00);
-	dsi_generic_write_seq(dsi, 0xb1, 0x6c, 0x21);
-	dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x00, 0x00);
-	dsi_generic_write_seq(dsi, 0x35, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xd8, 0x00, 0x00, 0x00, 0x00, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xe5, 0x06);
+	mipi_dsi_generic_write_seq(dsi, 0xe6, 0x06);
+	mipi_dsi_generic_write_seq(dsi, 0xe7, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xe8, 0x06);
+	mipi_dsi_generic_write_seq(dsi, 0xe9, 0x06);
+	mipi_dsi_generic_write_seq(dsi, 0xea, 0x06);
+	mipi_dsi_generic_write_seq(dsi, 0xeb, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xec, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xed, 0x30);
+	mipi_dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x06);
+	mipi_dsi_generic_write_seq(dsi, 0xb0, 0x31, 0x31);
+	mipi_dsi_generic_write_seq(dsi, 0xb1, 0x31, 0x31);
+	mipi_dsi_generic_write_seq(dsi, 0xb2, 0x2d, 0x2e);
+	mipi_dsi_generic_write_seq(dsi, 0xb3, 0x31, 0x34);
+	mipi_dsi_generic_write_seq(dsi, 0xb4, 0x29, 0x2a);
+	mipi_dsi_generic_write_seq(dsi, 0xb5, 0x12, 0x10);
+	mipi_dsi_generic_write_seq(dsi, 0xb6, 0x18, 0x16);
+	mipi_dsi_generic_write_seq(dsi, 0xb7, 0x00, 0x02);
+	mipi_dsi_generic_write_seq(dsi, 0xb8, 0x08, 0x31);
+	mipi_dsi_generic_write_seq(dsi, 0xb9, 0x31, 0x31);
+	mipi_dsi_generic_write_seq(dsi, 0xba, 0x31, 0x31);
+	mipi_dsi_generic_write_seq(dsi, 0xbb, 0x31, 0x08);
+	mipi_dsi_generic_write_seq(dsi, 0xbc, 0x03, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0xbd, 0x17, 0x19);
+	mipi_dsi_generic_write_seq(dsi, 0xbe, 0x11, 0x13);
+	mipi_dsi_generic_write_seq(dsi, 0xbf, 0x2a, 0x29);
+	mipi_dsi_generic_write_seq(dsi, 0xc0, 0x34, 0x31);
+	mipi_dsi_generic_write_seq(dsi, 0xc1, 0x2e, 0x2d);
+	mipi_dsi_generic_write_seq(dsi, 0xc2, 0x31, 0x31);
+	mipi_dsi_generic_write_seq(dsi, 0xc3, 0x31, 0x31);
+	mipi_dsi_generic_write_seq(dsi, 0xc4, 0x31, 0x31);
+	mipi_dsi_generic_write_seq(dsi, 0xc5, 0x31, 0x31);
+	mipi_dsi_generic_write_seq(dsi, 0xc6, 0x2e, 0x2d);
+	mipi_dsi_generic_write_seq(dsi, 0xc7, 0x31, 0x34);
+	mipi_dsi_generic_write_seq(dsi, 0xc8, 0x29, 0x2a);
+	mipi_dsi_generic_write_seq(dsi, 0xc9, 0x17, 0x19);
+	mipi_dsi_generic_write_seq(dsi, 0xca, 0x11, 0x13);
+	mipi_dsi_generic_write_seq(dsi, 0xcb, 0x03, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0xcc, 0x08, 0x31);
+	mipi_dsi_generic_write_seq(dsi, 0xcd, 0x31, 0x31);
+	mipi_dsi_generic_write_seq(dsi, 0xce, 0x31, 0x31);
+	mipi_dsi_generic_write_seq(dsi, 0xcf, 0x31, 0x08);
+	mipi_dsi_generic_write_seq(dsi, 0xd0, 0x00, 0x02);
+	mipi_dsi_generic_write_seq(dsi, 0xd1, 0x12, 0x10);
+	mipi_dsi_generic_write_seq(dsi, 0xd2, 0x18, 0x16);
+	mipi_dsi_generic_write_seq(dsi, 0xd3, 0x2a, 0x29);
+	mipi_dsi_generic_write_seq(dsi, 0xd4, 0x34, 0x31);
+	mipi_dsi_generic_write_seq(dsi, 0xd5, 0x2d, 0x2e);
+	mipi_dsi_generic_write_seq(dsi, 0xd6, 0x31, 0x31);
+	mipi_dsi_generic_write_seq(dsi, 0xd7, 0x31, 0x31);
+	mipi_dsi_generic_write_seq(dsi, 0xe5, 0x31, 0x31);
+	mipi_dsi_generic_write_seq(dsi, 0xe6, 0x31, 0x31);
+	mipi_dsi_generic_write_seq(dsi, 0xd8, 0x00, 0x00, 0x00, 0x00, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xd9, 0x00, 0x00, 0x00, 0x00, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xe7, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0x6f, 0x02);
+	mipi_dsi_generic_write_seq(dsi, 0xf7, 0x47);
+	mipi_dsi_generic_write_seq(dsi, 0x6f, 0x0a);
+	mipi_dsi_generic_write_seq(dsi, 0xf7, 0x02);
+	mipi_dsi_generic_write_seq(dsi, 0x6f, 0x17);
+	mipi_dsi_generic_write_seq(dsi, 0xf4, 0x60);
+	mipi_dsi_generic_write_seq(dsi, 0x6f, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0xf9, 0x46);
+	mipi_dsi_generic_write_seq(dsi, 0x6f, 0x11);
+	mipi_dsi_generic_write_seq(dsi, 0xf3, 0x01);
+	mipi_dsi_generic_write_seq(dsi, 0x35, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xd9, 0x02, 0x03, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x00, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x08, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0xb1, 0x6c, 0x21);
+	mipi_dsi_generic_write_seq(dsi, 0xf0, 0x55, 0xaa, 0x52, 0x00, 0x00);
+	mipi_dsi_generic_write_seq(dsi, 0x35, 0x00);
 
 	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
 	if (ret < 0) {
@@ -268,7 +260,7 @@ static int truly_nt35521_on(struct truly_nt35521 *ctx)
 	}
 	usleep_range(1000, 2000);
 
-	dsi_generic_write_seq(dsi, 0x53, 0x24);
+	mipi_dsi_generic_write_seq(dsi, 0x53, 0x24);
 
 	return 0;
 }
-- 
2.38.1

