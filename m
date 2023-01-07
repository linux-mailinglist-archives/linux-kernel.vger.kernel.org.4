Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD17661156
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 20:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjAGTUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 14:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjAGTUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 14:20:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBDA35901
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 11:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673119127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ohrbxQv6h3PG5DHv8u6fpyUTGyDJJgNcSIIf21QBvAc=;
        b=Sk6xWTxOCE/lbZAuyksFGdT39jdKFnAxiBwuzBLeQrN3lv2ZyEVdDkSSpetmozqN8dg0hg
        5Rr+3t78axKE+fIeUvOMmo91alz5SifYTboi+SOmDRZZ3vT6Pi+3hDeG/IXdIK1tTxL0aU
        ZH1NoQE3GqczVkuvAgeVqrtGpQ7fiRE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-344-IKfAC2AWMru2UPmY3y6QNw-1; Sat, 07 Jan 2023 14:18:46 -0500
X-MC-Unique: IKfAC2AWMru2UPmY3y6QNw-1
Received: by mail-wm1-f71.google.com with SMTP id l17-20020a05600c1d1100b003d9a145366cso2712298wms.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 11:18:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohrbxQv6h3PG5DHv8u6fpyUTGyDJJgNcSIIf21QBvAc=;
        b=g4WnbfoU2Cz6iLetcdW/zwdQfKB3zv8c2MQpd/9PoaCZYHAfQ89sHZmGPRDafv/UMU
         lS4QZNVJssKUnHW1A1PHPyFF3TtBTuyX0EBuaXJ+mazunxzdd3HIAnekmpYU8f9N8prx
         HLXXWoLDGlU0iMivowAqSB6Y1Av+6kdw35Gy841kgM/Rr/5/gdSWkde5BJFl8cbkcPK4
         c1hbv5kAIIk2OVSqQFGrW5+BFM1DsqmZHlRmU9aPiCM8uK43MyigzScJ8o6kYXqKCZb4
         tfzLWmnsP4XxzKyal8iHAEOtKim1jJENHVFLC7zQHdxkOp8tz6N8r27O68xIAIEZhMl/
         BWLg==
X-Gm-Message-State: AFqh2koDmtgaVUAFIEV9wKkJIwNoW8ixN+X5PUeov6L/009793G9syJU
        WXSrPmBy0pcRyGO8X3isj66LLaLGowxN1oHsAPyoUmHx7vjHruuF+zy25JoJBOwLI/OCyn4BXKv
        OsZHzOXMsyOVTkhE7QdHPd8v2BG00HXrRhXwf993L051mM1+RmWvD+ISsiWYP+12Y4B+6FUxG6T
        0=
X-Received: by 2002:adf:f701:0:b0:2bb:1b2f:a1c0 with SMTP id r1-20020adff701000000b002bb1b2fa1c0mr3257695wrp.3.1673119124650;
        Sat, 07 Jan 2023 11:18:44 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsevxsa04SlPZ2Vk1dvrP8Hj/YN2EMVPmlBsTKISQMZmGZE2TJABC9oo+kDkGHsmPPutOYx8Q==
X-Received: by 2002:adf:f701:0:b0:2bb:1b2f:a1c0 with SMTP id r1-20020adff701000000b002bb1b2fa1c0mr3257680wrp.3.1673119124343;
        Sat, 07 Jan 2023 11:18:44 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bp28-20020a5d5a9c000000b00273cd321a1bsm4553900wrb.107.2023.01.07.11.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 11:18:44 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 10/13] drm/panel-sharp-ls060t1sx01: Drop custom DSI write macro
Date:   Sat,  7 Jan 2023 20:18:19 +0100
Message-Id: <20230107191822.3787147-11-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230107191822.3787147-1-javierm@redhat.com>
References: <20230107191822.3787147-1-javierm@redhat.com>
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
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---

Changes in v2:
- Add Sam Ravnborg's Reviewed-by tag.

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

