Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938CF72A0F6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjFIRKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFIRKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:10:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012833595
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686330589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WyUw3HGVpJG+fchnm3dK6kO6DBjp5MZOwzGlWiysi+E=;
        b=apb1Q/H8he3G8sf6ufnpJr06HFhj8Qujv+lYzkyDFc3n1vvc92GAaRRC2Z1AL8/58i2av4
        RhZcDIjIsnfiAvDtYxYOG2lmkiOQ4i4YxsavR9uPLzJn/MH+joUG7c/PQLSogAIgQjaoBh
        Bg996tSduQq8Borpzst3rNSLqWveIR4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-FwID7dYfMl2QHCNHNlkzDQ-1; Fri, 09 Jun 2023 13:09:48 -0400
X-MC-Unique: FwID7dYfMl2QHCNHNlkzDQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f41a04a297so9497345e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 10:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686330586; x=1688922586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WyUw3HGVpJG+fchnm3dK6kO6DBjp5MZOwzGlWiysi+E=;
        b=jMEPFE+txvNXVIKNEYutPz2rUzxU/f1prK9VTL1zcweJyAB2N/oCuE7DD7CM63j0g/
         rl6b4To6hVS7EuqWiKRj5H75rmclx0m+e3V/IiRTCLMAFRZeKIwagQUVh5digVunt/nU
         jZ0h2Ea05ItF5pDsLqD92naarFeO9SWZxpJ0NFZjYLJmnEftv2uk2n9AXdv7ceARK+d8
         3yOLj2A0wTtP3U59rK8NsRY7HwNHQWJ6n8Vv+AZVMD+RtIu/cMJ9kYR1UZtLNosT6Jn/
         Hc4fUimYXx03lOKMAf34vOxRaStnSLL/4chxSNI3cHXMwnWkUmLlZx4lVeE+sXDs7+gm
         Zvbg==
X-Gm-Message-State: AC+VfDwUzqmFD1te2h/ACYLxRLmvZv4SyjO2cLv4+KTMhUwuxpXJJSSx
        M9l4D2OwB9279VL+sFF3c/erEXPwUfdxO9kXONiZKoRAAHi0odHnZtKSenK7/uFfLnRqNfrDaC6
        Kz/ITvZKdzPRvD4CQJ+yIE0JxRTAGzcIHmFIsKYOploOqobIiWd9OeKsWSRN5nBmcLGF9Pr72t9
        QDqGNLIAw=
X-Received: by 2002:a05:600c:290:b0:3f7:3991:e128 with SMTP id 16-20020a05600c029000b003f73991e128mr1326611wmk.2.1686330586505;
        Fri, 09 Jun 2023 10:09:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ51Knv7YYXW5GlVPILA+9vWmLaHs5+7B5mf3yOpG4486+5qa9z2I++cts1m4DF0h0c19d7abA==
X-Received: by 2002:a05:600c:290:b0:3f7:3991:e128 with SMTP id 16-20020a05600c029000b003f73991e128mr1326590wmk.2.1686330586233;
        Fri, 09 Jun 2023 10:09:46 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0ad500b003f7310a3ffasm3265526wmr.2.2023.06.09.10.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 10:09:45 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/5] drm/ssd130x: Make default width and height to be controller dependent
Date:   Fri,  9 Jun 2023 19:09:36 +0200
Message-Id: <20230609170941.1150941-2-javierm@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609170941.1150941-1-javierm@redhat.com>
References: <20230609170941.1150941-1-javierm@redhat.com>
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
 - SSD1305: 132 x 64 Dot Matrix OLED/PLED
 - SSD1306: 128 x 64 Dot Matrix OLED/PLED
 - SSD1307: 128 x 39 Dot Matrix OLED/PLED
 - SSD1309: 128 x 64 Dot Matrix OLED/PLED

Add this information to the devices' info structures, and use it set as a
default if not defined in DT rather than hardcoding to an arbitrary value.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

(no changes since v1)

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

