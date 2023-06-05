Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE9372200A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjFEHtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFEHs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:48:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D33DF
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 00:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685951291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mJ6LVDenz7leEoWEGqkNGYbuR5Ekaz6eOK5tZIJsJWA=;
        b=CoJr/Jp/E5kYJzpOmzXW82a1rBb8xhAIcMMicF1LMPc/a3JKrSzrddUTrxZsVx/Z9q/HvB
        1vVaKkOHKehpKBGfGDnX5eS5tvMvA1krNkcENwpOcjP7Sin9KMgLApfhtCQ4eW1t8xlknO
        TrMVWc8lIFccAiC/yz/D5ZCDJeSC43A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-g85FDL9yOyuR86ZKPwFnFw-1; Mon, 05 Jun 2023 03:48:10 -0400
X-MC-Unique: g85FDL9yOyuR86ZKPwFnFw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f7678c74beso5050815e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 00:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685951288; x=1688543288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJ6LVDenz7leEoWEGqkNGYbuR5Ekaz6eOK5tZIJsJWA=;
        b=LSK4MCmDTGObCQJ/MDkVkWPYFs1csyoFwW9ZvBAbNEt6a0wEUC2d3bCRc5NROh5azj
         q14W1v2rB2wcKnRmv3h1RNvPw9EMUpeeK+ik8xI2udrRXqv6ZUHe79+P5E+MTmPELBvg
         0cRrfv+duee1bnBxs/NDJJu/0h3uZt2b29Y63s5VfxpxpyMTm+FoRdxUT3h+xS/FTlfb
         +a7pZFIYWC2ctf06aYZjZWXQ+QrhXMupvL9hQ+2r7kxU9JaA4pybD6NVe78emXDupGEF
         UctzbrTM0WrHyMJCr/yynNJSOKzRJcOaUutTB6G+sHsPp14xDpjC2Nd6zeS7c7PlTQzl
         Agfw==
X-Gm-Message-State: AC+VfDxrCxwWfYRlIeKSJpCXAxqjaSNbhnPFkV3QZSS2gefLpUvCYJFE
        Z3mCUCQ62VrQ/L469bXC9vXISxR7fQWzz/LX5R3ce0EhQqDv85J+itcJeVB48gmjsz/Z5MUFWSa
        wbmbHxw+gOHBbvy/2IT5FAIetojC/YqHHqUVPnC5Kktdn9UHkykpVD3ZrAS+VXqxB6+dWU6VyJP
        5svsm91KY=
X-Received: by 2002:a05:600c:284a:b0:3f6:1377:8b15 with SMTP id r10-20020a05600c284a00b003f613778b15mr7656290wmb.21.1685951288612;
        Mon, 05 Jun 2023 00:48:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Y3sEsxNIwZK3n9IEdro6U7y6EP48MP57T3BvOfN5LZhOYLajzhcd2K85ImHRDwpnr2Kb1WQ==
X-Received: by 2002:a05:600c:284a:b0:3f6:1377:8b15 with SMTP id r10-20020a05600c284a00b003f613778b15mr7656272wmb.21.1685951288313;
        Mon, 05 Jun 2023 00:48:08 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q21-20020a1ce915000000b003f4fb5532a1sm9715192wmc.43.2023.06.05.00.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 00:48:07 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 1/5] drm/ssd130x: Make default width and height to be controller dependent
Date:   Mon,  5 Jun 2023 09:47:49 +0200
Message-Id: <20230605074753.562332-2-javierm@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605074753.562332-1-javierm@redhat.com>
References: <20230605074753.562332-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the driver hardcodes the default values to 96x16 pixels but this
default resolution depends on the controller. The datasheets for the chips
describes the following display controller resolutions:

 - SH1106:  132 x 64 Dot Matrix OLED/PLED
 - SSD1306: 128 x 64 Dot Matrix OLED/PLED
 - SSD1307: 128 x 39 Dot Matrix OLED/PLED
 - SSD1309: 128 x 64 Dot Matrix OLED/PLED

Add this information to the devices' info structures, and use it set as a
default if not defined in DT rather than hardcoding to an arbitrary value.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/solomon/ssd130x.c | 14 ++++++++++++--
 drivers/gpu/drm/solomon/ssd130x.h |  2 ++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 8cbf5aa66e19..a0e5e26c0bc9 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -99,29 +99,39 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
 		.default_vcomh = 0x40,
 		.default_dclk_div = 1,
 		.default_dclk_frq = 5,
+		.default_width = 132,
+		.default_height = 64,
 		.page_mode_only = 1,
 	},
 	[SSD1305_ID] = {
 		.default_vcomh = 0x34,
 		.default_dclk_div = 1,
 		.default_dclk_frq = 7,
+		.default_width = 132,
+		.default_height = 64,
 	},
 	[SSD1306_ID] = {
 		.default_vcomh = 0x20,
 		.default_dclk_div = 1,
 		.default_dclk_frq = 8,
 		.need_chargepump = 1,
+		.default_width = 128,
+		.default_height = 64,
 	},
 	[SSD1307_ID] = {
 		.default_vcomh = 0x20,
 		.default_dclk_div = 2,
 		.default_dclk_frq = 12,
 		.need_pwm = 1,
+		.default_width = 128,
+		.default_height = 39,
 	},
 	[SSD1309_ID] = {
 		.default_vcomh = 0x34,
 		.default_dclk_div = 1,
 		.default_dclk_frq = 10,
+		.default_width = 128,
+		.default_height = 64,
 	}
 };
 EXPORT_SYMBOL_NS_GPL(ssd130x_variants, DRM_SSD130X);
@@ -798,10 +808,10 @@ static void ssd130x_parse_properties(struct ssd130x_device *ssd130x)
 	struct device *dev = ssd130x->dev;
 
 	if (device_property_read_u32(dev, "solomon,width", &ssd130x->width))
-		ssd130x->width = 96;
+		ssd130x->width = ssd130x->device_info->default_width;
 
 	if (device_property_read_u32(dev, "solomon,height", &ssd130x->height))
-		ssd130x->height = 16;
+		ssd130x->height = ssd130x->device_info->default_height;
 
 	if (device_property_read_u32(dev, "solomon,page-offset", &ssd130x->page_offset))
 		ssd130x->page_offset = 1;
diff --git a/drivers/gpu/drm/solomon/ssd130x.h b/drivers/gpu/drm/solomon/ssd130x.h
index db03ee5db392..a2bc8d75078b 100644
--- a/drivers/gpu/drm/solomon/ssd130x.h
+++ b/drivers/gpu/drm/solomon/ssd130x.h
@@ -37,6 +37,8 @@ struct ssd130x_deviceinfo {
 	u32 default_vcomh;
 	u32 default_dclk_div;
 	u32 default_dclk_frq;
+	u32 default_width;
+	u32 default_height;
 	int need_pwm;
 	int need_chargepump;
 	bool page_mode_only;
-- 
2.40.1

