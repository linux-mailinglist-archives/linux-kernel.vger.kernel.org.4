Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD456571D6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbiL1Buj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiL1Bto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:49:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A487010B3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672192102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FAya4FSKwba6VvdFIeSAErTX1xwGmtOXg5P4/ZRBg8k=;
        b=LXJlnUxe2f1WjYRo/uFf6O+9uomNU3Zas7/CaTXK0PPtQW1G4w7t2gXlhXIWVFqxdXr8OZ
        hOwaeBd5o7Ac7NRduNwlWN8xKIkxg8GrB3QbA6ZiG5nN9NDLppjPJCqa9Osls22YekiJtH
        mI2XdRyYEG7I4uPYybgZhXFyWzxBLfs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-663-oOImoZaoMe-yM6UdDTulTA-1; Tue, 27 Dec 2022 20:48:20 -0500
X-MC-Unique: oOImoZaoMe-yM6UdDTulTA-1
Received: by mail-wm1-f72.google.com with SMTP id p34-20020a05600c1da200b003d990064285so1230695wms.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAya4FSKwba6VvdFIeSAErTX1xwGmtOXg5P4/ZRBg8k=;
        b=EDXue6vcOLtctWR/IEVskVNxgcvzQm7Gh1r4MWDvChHFwDU6xxiFhdKf89fOVY8QlK
         xEKkWYgYPGZQAUAnyVJqLV0g49GPO31cBIYg2FlbbhBFX3QCL+CDKyzu8/VQUoHKt1/s
         gOhXHvAFrD6Et474YS/wQjACtW1DRKuKNSQlqIdV2fzhSnNVhSZhb9+krqqRWo8nBfEr
         IL2mH+ZFeuEbbvBanvvyb4wSx34WBfPgEiaQjONeYlNk4uE4kR4hAbKn7Tuln4e/cNpR
         jTk2tZc61pDbMKhj/+C4TyBU3lgJAfLNccrA1ybuMeqPzu3vQlFjdt5UrxSkp/NXoQJM
         DfAQ==
X-Gm-Message-State: AFqh2krngS/oI9YRxMGAiSujyUy3rOhzFhUNd4qgdjl7P6PBGCKtG3SN
        BfgJOOdmBBTdH8F1a0a1p5ue0jKXDsPJIp1BlSwBQkECmVtSN0ONs8giq4jD4YVgTbHrYNxuX/c
        PCjQH+LPxn1SY5ecdxEK0mLEerbDZaH5n4TyIjih9xqiO2iGl0zWUuz5Kh3EGmY0MWlG8SYi73J
        8=
X-Received: by 2002:adf:fc51:0:b0:27d:ddaa:8bd8 with SMTP id e17-20020adffc51000000b0027dddaa8bd8mr5313660wrs.13.1672192099394;
        Tue, 27 Dec 2022 17:48:19 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs/Kssky6t73oZG/gcrNsPYZiX5THvQztGesgNjeV0fyMNB/Jn0TcbRPckGXXZFNtoGYRY1hw==
X-Received: by 2002:adf:fc51:0:b0:27d:ddaa:8bd8 with SMTP id e17-20020adffc51000000b0027dddaa8bd8mr5313649wrs.13.1672192099191;
        Tue, 27 Dec 2022 17:48:19 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k16-20020a056000005000b002258235bda3sm14158873wrx.61.2022.12.27.17.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:48:18 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 11/14] drm/panel-sharp-ls060t1sx01: Drop custom DSI write macro
Date:   Wed, 28 Dec 2022 02:47:54 +0100
Message-Id: <20221228014757.3170486-12-javierm@redhat.com>
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

 .../gpu/drm/panel/panel-sharp-ls060t1sx01.c   | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sharp-ls060t1sx01.c b/drivers/gpu/drm/panel/panel-sharp-ls060t1sx01.c
index 8a4e0c1fe73f..68f52eaaf4fa 100644
--- a/drivers/gpu/drm/panel/panel-sharp-ls060t1sx01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-ls060t1sx01.c
@@ -32,12 +32,6 @@ static inline struct sharp_ls060 *to_sharp_ls060(struct drm_panel *panel)
 	return container_of(panel, struct sharp_ls060, panel);
 }
 
-#define dsi_dcs_write_seq(dsi, seq...) ({				\
-		static const u8 d[] = { seq };				\
-									\
-		mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));	\
-	})
-
 static void sharp_ls060_reset(struct sharp_ls060 *ctx)
 {
 	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
@@ -56,17 +50,8 @@ static int sharp_ls060_on(struct sharp_ls060 *ctx)
 
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
-	ret = dsi_dcs_write_seq(dsi, 0xbb, 0x13);
-	if (ret < 0) {
-		dev_err(dev, "Failed to send command: %d\n", ret);
-		return ret;
-	}
-
-	ret = dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_MEMORY_START);
-	if (ret < 0) {
-		dev_err(dev, "Failed to send command: %d\n", ret);
-		return ret;
-	}
+	mipi_dsi_dcs_write_seq(dsi, 0xbb, 0x13);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_MEMORY_START);
 
 	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
 	if (ret < 0) {
-- 
2.38.1

