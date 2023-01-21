Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7F3676844
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 20:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjAUTKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 14:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjAUTKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 14:10:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7E246B9
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 11:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674328178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NPIxC6UFVdw/MjrtfcvzuLHufLGHSjfY7C1EvrBunNo=;
        b=K5Zqt0VSIac18zslftA3/mLwz4M9LH+6BblFAXh/0jfoMbBx0DufS4bMgXlOJppDQ2kYAt
        T+X1wsPgzUSe7QSOWFW0noZ+xBJRYCer421ywjHKxJ1s++B/4OfM5hywoa78VqFCUJE5g0
        0nyRYsQFLPS7At9s+bTY0zDnxJ21kSc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-396-BcgOs6STOOW9pVO0nN0cCQ-1; Sat, 21 Jan 2023 14:09:37 -0500
X-MC-Unique: BcgOs6STOOW9pVO0nN0cCQ-1
Received: by mail-wm1-f72.google.com with SMTP id k34-20020a05600c1ca200b003db30c3ed63so3128877wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 11:09:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPIxC6UFVdw/MjrtfcvzuLHufLGHSjfY7C1EvrBunNo=;
        b=7MT55+Qk+Puff5Zk/EWpteOr0I1yD7dt2xsZlAyW52iivokd4B77krYyYQvpzfnN93
         0Lsmz0bb9W1P7VYWZRtVtt0ZrN9zMsvFzHckZpMxtPRgQjzoThuwwlflDOsW7i7gF5up
         qPd5hDeyj7ZJNxO+OdMQNzFThJ7hjYe+5SNK+g6kicTEkaA59X9zT19aJkEuisDmrQbB
         Ik4oMJCh8NyQng0V1dO7WsAhYtEXpS3W/ti8cnEvrTF3Jw1nKacjsBBc3V+cd3zO8Rx7
         9an0OzusMr674tZxf0/A1fjz2g4g5VX1Cvyt6nXfq34TbeMsmJ/MAQ9tb02wKk4kd9pJ
         lAiA==
X-Gm-Message-State: AFqh2kqmUqKUZ6nGt01MoL/x8QATK20vHZFZFUr6jDYtt4WaU+KZhabl
        ZMwrzvU4MAmfjklFwIP+kS/OyDXVrONQAR0YSDdtY3y9vTggcjLZKDA/ksCJzZWUxwrHsM7WIou
        L8VfWcam5Q503FpaNysE7Aw7IIMITpJVmo4scsSCyshuUZFFgVNfciizPh/dDaC/twoDP6eQbSE
        s=
X-Received: by 2002:a05:6000:79d:b0:2bf:95cc:7447 with SMTP id bu29-20020a056000079d00b002bf95cc7447mr4039186wrb.32.1674328175960;
        Sat, 21 Jan 2023 11:09:35 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs01wKQXxokiKiCqH3FkcFM0EKVJSqBjYCIdWWOsWkHS1xKlwhPbFZ792GvPLrzWlGVivQDBQ==
X-Received: by 2002:a05:6000:79d:b0:2bf:95cc:7447 with SMTP id bu29-20020a056000079d00b002bf95cc7447mr4039169wrb.32.1674328175669;
        Sat, 21 Jan 2023 11:09:35 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k5-20020adfd845000000b002bdd96d88b4sm23716899wrl.75.2023.01.21.11.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 11:09:35 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/ssd130x: Silence a `dubious: x & !y` warning
Date:   Sat, 21 Jan 2023 20:09:30 +0100
Message-Id: <20230121190930.2804224-1-javierm@redhat.com>
X-Mailer: git-send-email 2.39.0
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

The sparse tool complains with the following warning:

$ make M=drivers/gpu/drm/solomon/ C=2
  CC [M]  drivers/gpu/drm/solomon/ssd130x.o
  CHECK   drivers/gpu/drm/solomon/ssd130x.c
drivers/gpu/drm/solomon/ssd130x.c:363:21: warning: dubious: x & !y

This seems to be a false positive in my opinion but still we can silence
the tool while making the code easier to read. Let's also add a comment,
to explain why the "com_seq" logical not is used rather than its value.

Reported-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

 drivers/gpu/drm/solomon/ssd130x.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index c3bf3a18302e..b16330a8b624 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -81,7 +81,7 @@
 #define SSD130X_SET_PRECHARGE_PERIOD2_MASK	GENMASK(7, 4)
 #define SSD130X_SET_PRECHARGE_PERIOD2_SET(val)	FIELD_PREP(SSD130X_SET_PRECHARGE_PERIOD2_MASK, (val))
 #define SSD130X_SET_COM_PINS_CONFIG1_MASK	GENMASK(4, 4)
-#define SSD130X_SET_COM_PINS_CONFIG1_SET(val)	FIELD_PREP(SSD130X_SET_COM_PINS_CONFIG1_MASK, !(val))
+#define SSD130X_SET_COM_PINS_CONFIG1_SET(val)	FIELD_PREP(SSD130X_SET_COM_PINS_CONFIG1_MASK, (val))
 #define SSD130X_SET_COM_PINS_CONFIG2_MASK	GENMASK(5, 5)
 #define SSD130X_SET_COM_PINS_CONFIG2_SET(val)	FIELD_PREP(SSD130X_SET_COM_PINS_CONFIG2_MASK, (val))
 
@@ -298,6 +298,7 @@ static void ssd130x_power_off(struct ssd130x_device *ssd130x)
 static int ssd130x_init(struct ssd130x_device *ssd130x)
 {
 	u32 precharge, dclk, com_invdir, compins, chargepump, seg_remap;
+	bool scan_mode;
 	int ret;
 
 	/* Set initial contrast */
@@ -360,7 +361,13 @@ static int ssd130x_init(struct ssd130x_device *ssd130x)
 
 	/* Set COM pins configuration */
 	compins = BIT(1);
-	compins |= (SSD130X_SET_COM_PINS_CONFIG1_SET(ssd130x->com_seq) |
+	/*
+	 * The COM scan mode field values are the inverse of the boolean DT
+	 * property "solomon,com-seq". The value 0b means scan from COM0 to
+	 * COM[N - 1] while 1b means scan from COM[N - 1] to COM0.
+	 */
+	scan_mode = !ssd130x->com_seq;
+	compins |= (SSD130X_SET_COM_PINS_CONFIG1_SET(scan_mode) |
 		    SSD130X_SET_COM_PINS_CONFIG2_SET(ssd130x->com_lrremap));
 	ret = ssd130x_write_cmd(ssd130x, 2, SSD130X_SET_COM_PINS_CONFIG, compins);
 	if (ret < 0)
-- 
2.39.0

