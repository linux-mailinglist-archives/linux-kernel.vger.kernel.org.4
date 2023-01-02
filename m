Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7579265B712
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 21:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjABU0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 15:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjABU0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 15:26:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E885B7C5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 12:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672691151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CBlDHKovYJnwPgpmS84u28pOqrwSgYnv9FJm79/ywfo=;
        b=Ioy/kdx0fZTL8FuNiMEAfWkfo4e60BdlxqLaowt3vXV18pzyO1Aw5oQTZn9TjQmfjx9Mj0
        ak0wv8DthhPpFZlxPBYHdi6njUxYmUzvfJ7SsNVEWBFCr5SCJ2jELLQ+lAW5TuO9egoziq
        wg6+OxECILgu2QqU6NXbqWrpy90gRjs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-198-BJvGdZ8aPQqp1buIXcNKlQ-1; Mon, 02 Jan 2023 15:25:50 -0500
X-MC-Unique: BJvGdZ8aPQqp1buIXcNKlQ-1
Received: by mail-wr1-f71.google.com with SMTP id d28-20020adfa35c000000b00293b14c3868so648099wrb.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 12:25:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBlDHKovYJnwPgpmS84u28pOqrwSgYnv9FJm79/ywfo=;
        b=tVu5h0WUObgy46AxS1q4mCkdr4pTMO6ukWCGPslpmE+gmfLuzvsTfREWAJplF1ofMc
         wZwd9zEDTHAStbQrGzo5hesJGpM9kaLqjyaLH2zyj4/3wC1yOho0OypzJ93HsQueegR8
         sggw2MIW3AvJVIpqHwUNkyGGp5CvU1Mhpz7Xvy2NAcoyi2IqlKSUKekPMo5hKK+Tpo49
         HfvznxiGz7IEvZFqN35MKSlYkg0RuG23/N54J3WqwD5DO4TNJn8nFRARyS5RTUUS8Xgi
         w6OklgTppDv8FPEQukNkv9W7xkw1i3f+eioV3lctRsisQtuRH12tSN401pShOkFmApLg
         rjLw==
X-Gm-Message-State: AFqh2kqM6oIQvg6yDqqEf+9xyln86SvkYqG0NbfxYftcYlpmscwFVsXz
        D/c7UPjUFk1qhbFEcXVtWWl6Omd9TFVlU7aU9YDys1t19at3uHENQEWKQqxIQX0gqjrLtRTHM7J
        puuZWwovYGTRQOLLynuT+jyiPIFRpWlPulVpH3VS9kNx4LievE67bn3spjmm58yayJHspZh2t1z
        M=
X-Received: by 2002:a05:600c:5c8:b0:3d1:4145:b3b with SMTP id p8-20020a05600c05c800b003d141450b3bmr30492724wmd.9.1672691149199;
        Mon, 02 Jan 2023 12:25:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuFSBAgfXtOm8IhviyEQci+lDT3iLsXP7qbucv5WVdjLUibBjrcSUUYhWY1PDUAyK235lJ0ew==
X-Received: by 2002:a05:600c:5c8:b0:3d1:4145:b3b with SMTP id p8-20020a05600c05c800b003d141450b3bmr30492703wmd.9.1672691148924;
        Mon, 02 Jan 2023 12:25:48 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c4e9200b003d35c845cbbsm50061135wmq.21.2023.01.02.12.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 12:25:48 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/2] drm/mipi-dsi: Add a mipi_dsi_dcs_write_seq() macro
Date:   Mon,  2 Jan 2023 21:25:42 +0100
Message-Id: <20230102202542.3494677-2-javierm@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230102202542.3494677-1-javierm@redhat.com>
References: <20230102202542.3494677-1-javierm@redhat.com>
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

Many panel drivers define dsi_dcs_write_seq() and dsi_generic_write_seq()
macros to send DCS commands and generic write packets respectively, with
the payload specified as a list of parameters instead of using arrays.

There's already a macro for the former, introduced by commit 2a9e9daf75231
("drm/mipi-dsi: Introduce mipi_dsi_dcs_write_seq macro") so drivers can be
changed to use that. But there isn't one yet for the latter, let's add it.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---

Changes in v2:
- Fix kernel-doc macro name (kernel test robot, Sam Ravnborg)
- Add Sam Ravnborg's Reviewed-by tag.

 include/drm/drm_mipi_dsi.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index e9d1e8a7fc7e..4f503d99f668 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -297,6 +297,24 @@ int mipi_dsi_dcs_set_display_brightness(struct mipi_dsi_device *dsi,
 int mipi_dsi_dcs_get_display_brightness(struct mipi_dsi_device *dsi,
 					u16 *brightness);
 
+/**
+ * mipi_dsi_generic_write_seq - transmit data using a generic write packet
+ * @dsi: DSI peripheral device
+ * @seq: buffer containing the payload
+ */
+#define mipi_dsi_generic_write_seq(dsi, seq...)                                \
+	do {                                                                   \
+		static const u8 d[] = { seq };                                 \
+		struct device *dev = &dsi->dev;                                \
+		int ret;                                                       \
+		ret = mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));           \
+		if (ret < 0) {                                                 \
+			dev_err_ratelimited(dev, "transmit data failed: %d\n", \
+					    ret);                              \
+			return ret;                                            \
+		}                                                              \
+	} while (0)
+
 /**
  * mipi_dsi_dcs_write_seq - transmit a DCS command with payload
  * @dsi: DSI peripheral device
-- 
2.38.1

