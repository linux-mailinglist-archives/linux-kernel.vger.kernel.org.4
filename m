Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632D2661153
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 20:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjAGTUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 14:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjAGTUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 14:20:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FE235904
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 11:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673119120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/yoKSXDDHkpi6+VOPGkCgVQ6U98e6W0DrE5kW1/2nkA=;
        b=WWFBxzccCB88w9aY7TQUwQHmUoOc5s+dRcvS7L+4NsMN4xtFqwKUIp7GQZwzGQolG5WaDi
        7ZQ/2+HadyoNRl3seRACiBsTwHqm7dg079L18gIKQvjYfUF2BDWOj5XCLOzFxNq56Oh/kN
        N4aB/qf/k9W9AS52QKNb5RbXHfvMm6k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-249-5sv9XBBNMFm_Ssbtkl9INQ-1; Sat, 07 Jan 2023 14:18:39 -0500
X-MC-Unique: 5sv9XBBNMFm_Ssbtkl9INQ-1
Received: by mail-wm1-f69.google.com with SMTP id p34-20020a05600c1da200b003d990064285so4636326wms.8
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 11:18:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yoKSXDDHkpi6+VOPGkCgVQ6U98e6W0DrE5kW1/2nkA=;
        b=CpRR/Q0s6DENEojje6mMmndQktwIFSrYRAjkl2XPyn02Y1PQ+QOTks1nDSFtILdqqi
         2V4VGiDspGseU6czUMqbci3zcarL2rOpf0r20hsjHQCFjmZsV26OKtzOzlGfDeqUkgCJ
         a0YkmOEaD/MqpdTGR2kExhRE9DExFLwnyjZhfn1GAnfn1neqBU5gHFvnEYLfViqR8tqi
         K09s0henti6dYzB/Kt0Cab78nZjQEJCfywYgSQvDayPbcXgwSxN+h95053Pl8VTsIpMq
         f4tPAJ4K8S+ue9lelhwFkKjUMJD1PJKBe8PfuaR09JgR/dflyp7B2LVo4nXt4DkHbyJ4
         +dJw==
X-Gm-Message-State: AFqh2koMxRiPlR39OZczg8kAbHigfnSu566xFuZuAkncrf2hUH3EDAZr
        LpLhZgnHXoWK3lo7M7fxt6AEKWHkiHvSRE4WNJJZ+5hCxkuNMVV/7U8Wo6SaHt578zzOmdb/StL
        /lSjZW8xP+Dfkd6lOpOd7Ay0pjXWpZo+aDTzDvW//zWsGm9jJz6owCBPp8oD1dYfhAzudIgxboj
        I=
X-Received: by 2002:a05:6000:148:b0:2bb:dc79:17dc with SMTP id r8-20020a056000014800b002bbdc7917dcmr930673wrx.19.1673119118280;
        Sat, 07 Jan 2023 11:18:38 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsN7RFr9GVqAykpRx1qFnkQH7qdpKJfYHGcL1pyJ908saGljyN3gg3+TocfMBpzxjktCTQJJw==
X-Received: by 2002:a05:6000:148:b0:2bb:dc79:17dc with SMTP id r8-20020a056000014800b002bbdc7917dcmr930658wrx.19.1673119118030;
        Sat, 07 Jan 2023 11:18:38 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bp28-20020a5d5a9c000000b00273cd321a1bsm4553900wrb.107.2023.01.07.11.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 11:18:37 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 05/13] drm/panel-boe-bf060y8m-aj0: Drop custom DSI write macro
Date:   Sat,  7 Jan 2023 20:18:14 +0100
Message-Id: <20230107191822.3787147-6-javierm@redhat.com>
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
- Fix identation on macro usage (Sam Ravnborg).

 .../gpu/drm/panel/panel-boe-bf060y8m-aj0.c    | 42 ++++++++-----------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
index ad58840eda41..90098b753e3b 100644
--- a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
+++ b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
@@ -43,14 +43,6 @@ struct boe_bf060y8m_aj0 *to_boe_bf060y8m_aj0(struct drm_panel *panel)
 	return container_of(panel, struct boe_bf060y8m_aj0, panel);
 }
 
-#define dsi_dcs_write_seq(dsi, seq...) do {				\
-		static const u8 d[] = { seq };				\
-		int ret;						\
-		ret = mipi_dsi_dcs_write_buffer(dsi, d, ARRAY_SIZE(d));	\
-		if (ret < 0)						\
-			return ret;					\
-	} while (0)
-
 static void boe_bf060y8m_aj0_reset(struct boe_bf060y8m_aj0 *boe)
 {
 	gpiod_set_value_cansleep(boe->reset_gpio, 0);
@@ -67,12 +59,12 @@ static int boe_bf060y8m_aj0_on(struct boe_bf060y8m_aj0 *boe)
 	struct device *dev = &dsi->dev;
 	int ret;
 
-	dsi_dcs_write_seq(dsi, 0xb0, 0xa5, 0x00);
-	dsi_dcs_write_seq(dsi, 0xb2, 0x00, 0x4c);
-	dsi_dcs_write_seq(dsi, MIPI_DCS_SET_3D_CONTROL, 0x10);
-	dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, DCS_ALLOW_HBM_RANGE);
-	dsi_dcs_write_seq(dsi, 0xf8,
-			  0x00, 0x08, 0x10, 0x00, 0x22, 0x00, 0x00, 0x2d);
+	mipi_dsi_dcs_write_seq(dsi, 0xb0, 0xa5, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, 0xb2, 0x00, 0x4c);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_3D_CONTROL, 0x10);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, DCS_ALLOW_HBM_RANGE);
+	mipi_dsi_dcs_write_seq(dsi, 0xf8,
+			       0x00, 0x08, 0x10, 0x00, 0x22, 0x00, 0x00, 0x2d);
 
 	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
 	if (ret < 0) {
@@ -81,17 +73,17 @@ static int boe_bf060y8m_aj0_on(struct boe_bf060y8m_aj0 *boe)
 	}
 	msleep(30);
 
-	dsi_dcs_write_seq(dsi, 0xb0, 0xa5, 0x00);
-	dsi_dcs_write_seq(dsi, 0xc0,
-			  0x08, 0x48, 0x65, 0x33, 0x33, 0x33,
-			  0x2a, 0x31, 0x39, 0x20, 0x09);
-	dsi_dcs_write_seq(dsi, 0xc1, 0x00, 0x00, 0x00, 0x1f, 0x1f,
-			  0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f,
-			  0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f);
-	dsi_dcs_write_seq(dsi, 0xe2, 0x20, 0x04, 0x10, 0x12, 0x92,
-			  0x4f, 0x8f, 0x44, 0x84, 0x83, 0x83, 0x83,
-			  0x5c, 0x5c, 0x5c);
-	dsi_dcs_write_seq(dsi, 0xde, 0x01, 0x2c, 0x00, 0x77, 0x3e);
+	mipi_dsi_dcs_write_seq(dsi, 0xb0, 0xa5, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, 0xc0,
+			       0x08, 0x48, 0x65, 0x33, 0x33, 0x33,
+			       0x2a, 0x31, 0x39, 0x20, 0x09);
+	mipi_dsi_dcs_write_seq(dsi, 0xc1, 0x00, 0x00, 0x00, 0x1f, 0x1f,
+			       0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f,
+			       0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f);
+	mipi_dsi_dcs_write_seq(dsi, 0xe2, 0x20, 0x04, 0x10, 0x12, 0x92,
+			       0x4f, 0x8f, 0x44, 0x84, 0x83, 0x83, 0x83,
+			       0x5c, 0x5c, 0x5c);
+	mipi_dsi_dcs_write_seq(dsi, 0xde, 0x01, 0x2c, 0x00, 0x77, 0x3e);
 
 	msleep(30);
 
-- 
2.38.1

