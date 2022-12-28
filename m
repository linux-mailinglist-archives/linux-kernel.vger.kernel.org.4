Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BAB6571D3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiL1BuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbiL1Btf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:49:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2FDF7D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672192095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oXfjPPHZw4rW2dJuaHE6vMotKORYIvVnfzyhFGZZlV4=;
        b=MG19vtPCGNTS5y57GbNgPbAuLUKWoEf93aiyBgYLjtClgu2dytqTodpEg2VOVXgKlhrPyv
        RwyVlW7ZLPEJWbXNYejiciXPk4KbgBQLrEFJYAy/zxgQ9GQAjJUi7w+B0xueXau+LnskWt
        OGzxzijZt9h8de0QfKB042e2xhX3eGs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-190-F5kss6DwPQexjtSAH-E1mA-1; Tue, 27 Dec 2022 20:48:14 -0500
X-MC-Unique: F5kss6DwPQexjtSAH-E1mA-1
Received: by mail-wm1-f69.google.com with SMTP id fl12-20020a05600c0b8c00b003d96f0a7f36so6181166wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 17:48:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXfjPPHZw4rW2dJuaHE6vMotKORYIvVnfzyhFGZZlV4=;
        b=sVbzY7jOGqi5bHk5cA8IMhfoYYv+6E4KXNzgqK1dQBdlrwoXQi0Gy8HqQdcYY4flC1
         iPh+3A3EbApi62nPFnpHCjvanX1hrZGLgShdof5LJtpj6f2elcXLiPu5mzZMakAEPZP0
         CfzZpmT2M8QgcVd5m41QK3qDIFeeOodJTCYe2BV8cpgWpJFBHWHqM04ZGm7MNUAkiqNr
         fLeNP/eNeBRGeLk991Y90rYBwrnlfQrRjS4q3WkLWr7V9590NO8T9JuTWnWBcdRSE13R
         uaGG8T5RWiEZaSmZGfGSzNQBD9srplOKzEtPFATUEgMWncXOWRfHAEW4jDl0QDkUxh9d
         WzCg==
X-Gm-Message-State: AFqh2kpx84Y3+ZWT8/yx+WCs169YniykcLVMsPQ9jmmCtokPGPwGO/+y
        A5G2TIyzrwUbysMwuDtsaEuQ113kw2X7xMj9oZWg5GkquwUg739OEXp5kt4ZWZ5MUUd2nYboKsr
        5MqNyd9cBMhOxapTs2pxBw1DB3kXhbUpPpK99HzJ71osiirOo0aDhRht7Nrq30vrBaZWPR6DN1B
        w=
X-Received: by 2002:adf:ce0a:0:b0:242:4dd8:a7ee with SMTP id p10-20020adfce0a000000b002424dd8a7eemr14834784wrn.12.1672192093017;
        Tue, 27 Dec 2022 17:48:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuVU0qxNP41uhFQe4//isG5cOB01i4P/PiMbpSj6Lb6FnL/80fWWAMgOyG8kmuuxs2KNRpt/Q==
X-Received: by 2002:adf:ce0a:0:b0:242:4dd8:a7ee with SMTP id p10-20020adfce0a000000b002424dd8a7eemr14834772wrn.12.1672192092735;
        Tue, 27 Dec 2022 17:48:12 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k16-20020a056000005000b002258235bda3sm14158873wrx.61.2022.12.27.17.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 17:48:12 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 06/14] drm/panel-boe-bf060y8m-aj0: Drop custom DSI write macro
Date:   Wed, 28 Dec 2022 02:47:49 +0100
Message-Id: <20221228014757.3170486-7-javierm@redhat.com>
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

 .../gpu/drm/panel/panel-boe-bf060y8m-aj0.c    | 28 +++++++------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
index ad58840eda41..7fff89cb1cd3 100644
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
@@ -67,11 +59,11 @@ static int boe_bf060y8m_aj0_on(struct boe_bf060y8m_aj0 *boe)
 	struct device *dev = &dsi->dev;
 	int ret;
 
-	dsi_dcs_write_seq(dsi, 0xb0, 0xa5, 0x00);
-	dsi_dcs_write_seq(dsi, 0xb2, 0x00, 0x4c);
-	dsi_dcs_write_seq(dsi, MIPI_DCS_SET_3D_CONTROL, 0x10);
-	dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, DCS_ALLOW_HBM_RANGE);
-	dsi_dcs_write_seq(dsi, 0xf8,
+	mipi_dsi_dcs_write_seq(dsi, 0xb0, 0xa5, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, 0xb2, 0x00, 0x4c);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_3D_CONTROL, 0x10);
+	mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, DCS_ALLOW_HBM_RANGE);
+	mipi_dsi_dcs_write_seq(dsi, 0xf8,
 			  0x00, 0x08, 0x10, 0x00, 0x22, 0x00, 0x00, 0x2d);
 
 	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
@@ -81,17 +73,17 @@ static int boe_bf060y8m_aj0_on(struct boe_bf060y8m_aj0 *boe)
 	}
 	msleep(30);
 
-	dsi_dcs_write_seq(dsi, 0xb0, 0xa5, 0x00);
-	dsi_dcs_write_seq(dsi, 0xc0,
+	mipi_dsi_dcs_write_seq(dsi, 0xb0, 0xa5, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, 0xc0,
 			  0x08, 0x48, 0x65, 0x33, 0x33, 0x33,
 			  0x2a, 0x31, 0x39, 0x20, 0x09);
-	dsi_dcs_write_seq(dsi, 0xc1, 0x00, 0x00, 0x00, 0x1f, 0x1f,
+	mipi_dsi_dcs_write_seq(dsi, 0xc1, 0x00, 0x00, 0x00, 0x1f, 0x1f,
 			  0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f,
 			  0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f);
-	dsi_dcs_write_seq(dsi, 0xe2, 0x20, 0x04, 0x10, 0x12, 0x92,
+	mipi_dsi_dcs_write_seq(dsi, 0xe2, 0x20, 0x04, 0x10, 0x12, 0x92,
 			  0x4f, 0x8f, 0x44, 0x84, 0x83, 0x83, 0x83,
 			  0x5c, 0x5c, 0x5c);
-	dsi_dcs_write_seq(dsi, 0xde, 0x01, 0x2c, 0x00, 0x77, 0x3e);
+	mipi_dsi_dcs_write_seq(dsi, 0xde, 0x01, 0x2c, 0x00, 0x77, 0x3e);
 
 	msleep(30);
 
-- 
2.38.1

