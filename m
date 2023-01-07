Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91E3661152
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 20:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjAGTTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 14:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjAGTTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 14:19:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A05434D77
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 11:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673119118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3zYg/QL5tJjzhXTn4477dEVWRyv2kVQSAl3jZfVLzv0=;
        b=hmwacKNFr9UQKUHmFXqcGkL1q+rY4M6oH8j0rc5nru6PJOQYusr22XiFQ3UiQVTJ6Dbknv
        7kKktg3BhruvSFyRRCfQk1YMGfvJRP96CYlQFYBvcRcwbfzyicF4Wdsoh+mfU877rsgKs5
        lodEuEvd/N13EuVTr1PPQUuzv3vY7Ig=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-103-qF6hG8ChMcSAKKBMqPC1Ww-1; Sat, 07 Jan 2023 14:18:36 -0500
X-MC-Unique: qF6hG8ChMcSAKKBMqPC1Ww-1
Received: by mail-wm1-f69.google.com with SMTP id bi18-20020a05600c3d9200b003d991844dbcso4646714wmb.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 11:18:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zYg/QL5tJjzhXTn4477dEVWRyv2kVQSAl3jZfVLzv0=;
        b=PXr8kViT0bQGtEL1Zv4SofTl7y+d7rqN4jNQoOxaj1/CvzkNwTiAM46ohMmd9DkwFw
         WV3WNlDNEX/DNf67+ER08/YV2Gj/SyilJ5alxIQDH3DBAj0BSRGSDzmc4jIZo5wBpbvE
         j6/s4wo08cAprDRZvQnsBJCJ/gIzyXlUUK2YBio5GdkOavwcHvcxonas4IgIqoj5zg5i
         I5XQSggknpaOGjhi+aYMKFS9B0K5ngdDhHL+u+VnUXf1dERzH8vQiTpnK5HN8Q7fzt4K
         osTZLmfUEYwl1uoSnmzsQlz4CF60q92cwmTZUBzc1lAYleCWqqR/+MGDKM10ghGLK7Wj
         9Pnw==
X-Gm-Message-State: AFqh2kpU4hYsufxLk/RRHb4JzX9/juv1D81VLnRdSHhRIWEfQ2u4hIRX
        JxhcdXSEX/22iN4JVjCfKX6UEcytdIvN89p9N7L3RMzgKAjV+q8B4H70dKxi93U9XOUAyleszQc
        mR2rFd4X0DkB5umWdEvZ3tjUGTxAWhv7FVFEv8DvjINEZOMDvUGbtSRTmIUWgcI47oOQ7zQO2rz
        4=
X-Received: by 2002:a5d:610c:0:b0:298:4baf:ac90 with SMTP id v12-20020a5d610c000000b002984bafac90mr13475573wrt.57.1673119115392;
        Sat, 07 Jan 2023 11:18:35 -0800 (PST)
X-Google-Smtp-Source: AMrXdXua74oQHWAH/8OePWJMn+DrJj0yE1hc3dEeBReQXZp1oaElN/Pj5AFK5B1cutcQrisGMyzEYg==
X-Received: by 2002:a5d:610c:0:b0:298:4baf:ac90 with SMTP id v12-20020a5d610c000000b002984bafac90mr13475562wrt.57.1673119115128;
        Sat, 07 Jan 2023 11:18:35 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bp28-20020a5d5a9c000000b00273cd321a1bsm4553900wrb.107.2023.01.07.11.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 11:18:34 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 03/13] drm/panel-leadtek-ltk050h3146w: Drop custom DSI write macro
Date:   Sat,  7 Jan 2023 20:18:12 +0100
Message-Id: <20230107191822.3787147-4-javierm@redhat.com>
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

 .../drm/panel/panel-leadtek-ltk050h3146w.c    | 106 ++++++++----------
 1 file changed, 49 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
index 5619f186d28c..d2efd887484b 100644
--- a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
+++ b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
@@ -244,14 +244,6 @@ struct ltk050h3146w *panel_to_ltk050h3146w(struct drm_panel *panel)
 	return container_of(panel, struct ltk050h3146w, panel);
 }
 
-#define dsi_dcs_write_seq(dsi, cmd, seq...) do {			\
-		static const u8 b[] = { cmd, seq };			\
-		int ret;						\
-		ret = mipi_dsi_dcs_write_buffer(dsi, b, ARRAY_SIZE(b));	\
-		if (ret < 0)						\
-			return ret;					\
-	} while (0)
-
 static int ltk050h3146w_init_sequence(struct ltk050h3146w *ctx)
 {
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
@@ -261,55 +253,55 @@ static int ltk050h3146w_init_sequence(struct ltk050h3146w *ctx)
 	 * Init sequence was supplied by the panel vendor without much
 	 * documentation.
 	 */
-	dsi_dcs_write_seq(dsi, 0xdf, 0x93, 0x65, 0xf8);
-	dsi_dcs_write_seq(dsi, 0xb0, 0x01, 0x03, 0x02, 0x00, 0x64, 0x06,
-			  0x01);
-	dsi_dcs_write_seq(dsi, 0xb2, 0x00, 0xb5);
-	dsi_dcs_write_seq(dsi, 0xb3, 0x00, 0xb5);
-	dsi_dcs_write_seq(dsi, 0xb7, 0x00, 0xbf, 0x00, 0x00, 0xbf, 0x00);
-
-	dsi_dcs_write_seq(dsi, 0xb9, 0x00, 0xc4, 0x23, 0x07);
-	dsi_dcs_write_seq(dsi, 0xbb, 0x02, 0x01, 0x24, 0x00, 0x28, 0x0f,
-			  0x28, 0x04, 0xcc, 0xcc, 0xcc);
-	dsi_dcs_write_seq(dsi, 0xbc, 0x0f, 0x04);
-	dsi_dcs_write_seq(dsi, 0xbe, 0x1e, 0xf2);
-	dsi_dcs_write_seq(dsi, 0xc0, 0x26, 0x03);
-	dsi_dcs_write_seq(dsi, 0xc1, 0x00, 0x12);
-	dsi_dcs_write_seq(dsi, 0xc3, 0x04, 0x02, 0x02, 0x76, 0x01, 0x80,
-			  0x80);
-	dsi_dcs_write_seq(dsi, 0xc4, 0x24, 0x80, 0xb4, 0x81, 0x12, 0x0f,
-			  0x16, 0x00, 0x00);
-	dsi_dcs_write_seq(dsi, 0xc8, 0x7f, 0x72, 0x67, 0x5d, 0x5d, 0x50,
-			  0x56, 0x41, 0x59, 0x57, 0x55, 0x70, 0x5b, 0x5f,
-			  0x4f, 0x47, 0x38, 0x23, 0x08, 0x7f, 0x72, 0x67,
-			  0x5d, 0x5d, 0x50, 0x56, 0x41, 0x59, 0x57, 0x55,
-			  0x70, 0x5b, 0x5f, 0x4f, 0x47, 0x38, 0x23, 0x08);
-	dsi_dcs_write_seq(dsi, 0xd0, 0x1e, 0x1f, 0x57, 0x58, 0x48, 0x4a,
-			  0x44, 0x46, 0x40, 0x1f, 0x42, 0x1f, 0x1f, 0x1f,
-			  0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f);
-	dsi_dcs_write_seq(dsi, 0xd1, 0x1e, 0x1f, 0x57, 0x58, 0x49, 0x4b,
-			  0x45, 0x47, 0x41, 0x1f, 0x43, 0x1f, 0x1f, 0x1f,
-			  0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f);
-	dsi_dcs_write_seq(dsi, 0xd2, 0x1f, 0x1e, 0x17, 0x18, 0x07, 0x05,
-			  0x0b, 0x09, 0x03, 0x1f, 0x01, 0x1f, 0x1f, 0x1f,
-			  0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f);
-	dsi_dcs_write_seq(dsi, 0xd3, 0x1f, 0x1e, 0x17, 0x18, 0x06, 0x04,
-			  0x0a, 0x08, 0x02, 0x1f, 0x00, 0x1f, 0x1f, 0x1f,
-			  0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f);
-	dsi_dcs_write_seq(dsi, 0xd4, 0x00, 0x00, 0x00, 0x0c, 0x06, 0x20,
-			  0x01, 0x02, 0x00, 0x60, 0x15, 0xb0, 0x30, 0x03,
-			  0x04, 0x00, 0x60, 0x72, 0x0a, 0x00, 0x60, 0x08);
-	dsi_dcs_write_seq(dsi, 0xd5, 0x00, 0x06, 0x06, 0x00, 0x30, 0x00,
-			  0x00, 0x00, 0x00, 0x00, 0xbc, 0x50, 0x00, 0x05,
-			  0x21, 0x00, 0x60);
-	dsi_dcs_write_seq(dsi, 0xdd, 0x2c, 0xa3, 0x00);
-	dsi_dcs_write_seq(dsi, 0xde, 0x02);
-	dsi_dcs_write_seq(dsi, 0xb2, 0x32, 0x1c);
-	dsi_dcs_write_seq(dsi, 0xb7, 0x3b, 0x70, 0x00, 0x04);
-	dsi_dcs_write_seq(dsi, 0xc1, 0x11);
-	dsi_dcs_write_seq(dsi, 0xbb, 0x21, 0x22, 0x23, 0x24, 0x36, 0x37);
-	dsi_dcs_write_seq(dsi, 0xc2, 0x20, 0x38, 0x1e, 0x84);
-	dsi_dcs_write_seq(dsi, 0xde, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, 0xdf, 0x93, 0x65, 0xf8);
+	mipi_dsi_dcs_write_seq(dsi, 0xb0, 0x01, 0x03, 0x02, 0x00, 0x64, 0x06,
+			       0x01);
+	mipi_dsi_dcs_write_seq(dsi, 0xb2, 0x00, 0xb5);
+	mipi_dsi_dcs_write_seq(dsi, 0xb3, 0x00, 0xb5);
+	mipi_dsi_dcs_write_seq(dsi, 0xb7, 0x00, 0xbf, 0x00, 0x00, 0xbf, 0x00);
+
+	mipi_dsi_dcs_write_seq(dsi, 0xb9, 0x00, 0xc4, 0x23, 0x07);
+	mipi_dsi_dcs_write_seq(dsi, 0xbb, 0x02, 0x01, 0x24, 0x00, 0x28, 0x0f,
+			       0x28, 0x04, 0xcc, 0xcc, 0xcc);
+	mipi_dsi_dcs_write_seq(dsi, 0xbc, 0x0f, 0x04);
+	mipi_dsi_dcs_write_seq(dsi, 0xbe, 0x1e, 0xf2);
+	mipi_dsi_dcs_write_seq(dsi, 0xc0, 0x26, 0x03);
+	mipi_dsi_dcs_write_seq(dsi, 0xc1, 0x00, 0x12);
+	mipi_dsi_dcs_write_seq(dsi, 0xc3, 0x04, 0x02, 0x02, 0x76, 0x01, 0x80,
+			       0x80);
+	mipi_dsi_dcs_write_seq(dsi, 0xc4, 0x24, 0x80, 0xb4, 0x81, 0x12, 0x0f,
+			       0x16, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, 0xc8, 0x7f, 0x72, 0x67, 0x5d, 0x5d, 0x50,
+			       0x56, 0x41, 0x59, 0x57, 0x55, 0x70, 0x5b, 0x5f,
+			       0x4f, 0x47, 0x38, 0x23, 0x08, 0x7f, 0x72, 0x67,
+			       0x5d, 0x5d, 0x50, 0x56, 0x41, 0x59, 0x57, 0x55,
+			       0x70, 0x5b, 0x5f, 0x4f, 0x47, 0x38, 0x23, 0x08);
+	mipi_dsi_dcs_write_seq(dsi, 0xd0, 0x1e, 0x1f, 0x57, 0x58, 0x48, 0x4a,
+			       0x44, 0x46, 0x40, 0x1f, 0x42, 0x1f, 0x1f, 0x1f,
+			       0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f);
+	mipi_dsi_dcs_write_seq(dsi, 0xd1, 0x1e, 0x1f, 0x57, 0x58, 0x49, 0x4b,
+			       0x45, 0x47, 0x41, 0x1f, 0x43, 0x1f, 0x1f, 0x1f,
+			       0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f);
+	mipi_dsi_dcs_write_seq(dsi, 0xd2, 0x1f, 0x1e, 0x17, 0x18, 0x07, 0x05,
+			       0x0b, 0x09, 0x03, 0x1f, 0x01, 0x1f, 0x1f, 0x1f,
+			       0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f);
+	mipi_dsi_dcs_write_seq(dsi, 0xd3, 0x1f, 0x1e, 0x17, 0x18, 0x06, 0x04,
+			       0x0a, 0x08, 0x02, 0x1f, 0x00, 0x1f, 0x1f, 0x1f,
+			       0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f);
+	mipi_dsi_dcs_write_seq(dsi, 0xd4, 0x00, 0x00, 0x00, 0x0c, 0x06, 0x20,
+			       0x01, 0x02, 0x00, 0x60, 0x15, 0xb0, 0x30, 0x03,
+			       0x04, 0x00, 0x60, 0x72, 0x0a, 0x00, 0x60, 0x08);
+	mipi_dsi_dcs_write_seq(dsi, 0xd5, 0x00, 0x06, 0x06, 0x00, 0x30, 0x00,
+			       0x00, 0x00, 0x00, 0x00, 0xbc, 0x50, 0x00, 0x05,
+			       0x21, 0x00, 0x60);
+	mipi_dsi_dcs_write_seq(dsi, 0xdd, 0x2c, 0xa3, 0x00);
+	mipi_dsi_dcs_write_seq(dsi, 0xde, 0x02);
+	mipi_dsi_dcs_write_seq(dsi, 0xb2, 0x32, 0x1c);
+	mipi_dsi_dcs_write_seq(dsi, 0xb7, 0x3b, 0x70, 0x00, 0x04);
+	mipi_dsi_dcs_write_seq(dsi, 0xc1, 0x11);
+	mipi_dsi_dcs_write_seq(dsi, 0xbb, 0x21, 0x22, 0x23, 0x24, 0x36, 0x37);
+	mipi_dsi_dcs_write_seq(dsi, 0xc2, 0x20, 0x38, 0x1e, 0x84);
+	mipi_dsi_dcs_write_seq(dsi, 0xde, 0x00);
 
 	ret = mipi_dsi_dcs_set_tear_on(dsi, 1);
 	if (ret < 0) {
-- 
2.38.1

