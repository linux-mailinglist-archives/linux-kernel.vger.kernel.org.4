Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897036EC0A5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 16:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjDWOye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 10:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjDWOyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 10:54:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2F135A9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682261586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=brUP6Y4+fxRUO3RjcIxh9okEQNw9LLitzlIw6oM9sjU=;
        b=QHuQc6mxxdTRG0MzA/1IeW4fZjj2kX9BAzJrW4KVsl3N+CJ/iHuWA2v8PUj4DWGdM8vluv
        kjxYjm2oYycjQfasDb+Gs5hFbGROT5/DTEDfH3c4IT7Z0k/Iowo6F44gL6ho82tPXuPgWJ
        SXpZzkB/5SkZpGLIS/4RkXLUoLuzqpA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-F9swDheOOLSRIT0Yb5kEew-1; Sun, 23 Apr 2023 10:53:05 -0400
X-MC-Unique: F9swDheOOLSRIT0Yb5kEew-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-3ef34e947edso42710961cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 07:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682261585; x=1684853585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=brUP6Y4+fxRUO3RjcIxh9okEQNw9LLitzlIw6oM9sjU=;
        b=T4KxFKjJt3qTubNAv6AZgTsD4Txx7cHwH8ZQlaSIAaaET54jjtXa75GTegzlgmEFoP
         czjFdKYncBHEda0WATCA4vpYO0gfOPK6YG9VtUDprNTqXa2q+BbjJLpBttsAsxlKePj+
         FnC7cNrvPXfN/9dmdToGo8JCDhEtu9xPyDcBRAHoz5Ia99kgcR262mWADNgib4TMTlNA
         ytaBDAgvQ/KsKHiLMqsJm5eyDvZbaY1ZOjjwdGe9YURnKn7vObrj5Edp6/GP+thZJwgh
         ZqY2xaoHJ6QgJ10HR3XsY8GqEagfwR3KvGrT4brCYcEwK0WUr0+CkGLeB2arXFDykNe1
         zhjw==
X-Gm-Message-State: AAQBX9e5jdifLuiYD87SKFsHV9q0uH1KZNrYFSGejVz9n5XYJXHGpUeT
        r0feQrBZnHT1GYsIEuUANT0FxrYeQYvfYICFEnMl1+/lmWyXVi+cuMOPLzAAdL9ZQs2650JSeEm
        7FepD6AvLR9vNhZFAKyEv3ImP
X-Received: by 2002:ac8:5892:0:b0:3e3:9117:66e8 with SMTP id t18-20020ac85892000000b003e3911766e8mr19520239qta.35.1682261584965;
        Sun, 23 Apr 2023 07:53:04 -0700 (PDT)
X-Google-Smtp-Source: AKy350bmzZ2YfZA9i7Lvmo/Y61N2NeOxSpRotijBmk2JHeQ07QlcP3dqMW3ponYcBCaTHnGgvtlrcg==
X-Received: by 2002:ac8:5892:0:b0:3e3:9117:66e8 with SMTP id t18-20020ac85892000000b003e3911766e8mr19520221qta.35.1682261584717;
        Sun, 23 Apr 2023 07:53:04 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w24-20020a05622a191800b003ef59e2b9a6sm2358221qtc.78.2023.04.23.07.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 07:53:04 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     neil.armstrong@linaro.org, airlied@gmail.com, daniel@ffwll.ch,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/meson: set variables meson_hdmi_* storage-class-specifier to static
Date:   Sun, 23 Apr 2023 10:53:00 -0400
Message-Id: <20230423145300.3937831-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch has several simailar warnings to
drivers/gpu/drm/meson/meson_venc.c:189:28: warning: symbol
  'meson_hdmi_enci_mode_480i' was not declared. Should it be static?

These variables are only used in their defining file so should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/meson/meson_venc.c | 32 +++++++++++++++---------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index fcd532db19c1..27ef9f88e4ff 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -186,7 +186,7 @@ union meson_hdmi_venc_mode {
 	} encp;
 };
 
-union meson_hdmi_venc_mode meson_hdmi_enci_mode_480i = {
+static union meson_hdmi_venc_mode meson_hdmi_enci_mode_480i = {
 	.enci = {
 		.hso_begin = 5,
 		.hso_end = 129,
@@ -206,7 +206,7 @@ union meson_hdmi_venc_mode meson_hdmi_enci_mode_480i = {
 	},
 };
 
-union meson_hdmi_venc_mode meson_hdmi_enci_mode_576i = {
+static union meson_hdmi_venc_mode meson_hdmi_enci_mode_576i = {
 	.enci = {
 		.hso_begin = 3,
 		.hso_end = 129,
@@ -226,7 +226,7 @@ union meson_hdmi_venc_mode meson_hdmi_enci_mode_576i = {
 	},
 };
 
-union meson_hdmi_venc_mode meson_hdmi_encp_mode_480p = {
+static union meson_hdmi_venc_mode meson_hdmi_encp_mode_480p = {
 	.encp = {
 		.dvi_settings = 0x21,
 		.video_mode = 0x4000,
@@ -272,7 +272,7 @@ union meson_hdmi_venc_mode meson_hdmi_encp_mode_480p = {
 	},
 };
 
-union meson_hdmi_venc_mode meson_hdmi_encp_mode_576p = {
+static union meson_hdmi_venc_mode meson_hdmi_encp_mode_576p = {
 	.encp = {
 		.dvi_settings = 0x21,
 		.video_mode = 0x4000,
@@ -318,7 +318,7 @@ union meson_hdmi_venc_mode meson_hdmi_encp_mode_576p = {
 	},
 };
 
-union meson_hdmi_venc_mode meson_hdmi_encp_mode_720p60 = {
+static union meson_hdmi_venc_mode meson_hdmi_encp_mode_720p60 = {
 	.encp = {
 		.dvi_settings = 0x2029,
 		.video_mode = 0x4040,
@@ -360,7 +360,7 @@ union meson_hdmi_venc_mode meson_hdmi_encp_mode_720p60 = {
 	},
 };
 
-union meson_hdmi_venc_mode meson_hdmi_encp_mode_720p50 = {
+static union meson_hdmi_venc_mode meson_hdmi_encp_mode_720p50 = {
 	.encp = {
 		.dvi_settings = 0x202d,
 		.video_mode = 0x4040,
@@ -405,7 +405,7 @@ union meson_hdmi_venc_mode meson_hdmi_encp_mode_720p50 = {
 	},
 };
 
-union meson_hdmi_venc_mode meson_hdmi_encp_mode_1080i60 = {
+static union meson_hdmi_venc_mode meson_hdmi_encp_mode_1080i60 = {
 	.encp = {
 		.dvi_settings = 0x2029,
 		.video_mode = 0x5ffc,
@@ -454,7 +454,7 @@ union meson_hdmi_venc_mode meson_hdmi_encp_mode_1080i60 = {
 	},
 };
 
-union meson_hdmi_venc_mode meson_hdmi_encp_mode_1080i50 = {
+static union meson_hdmi_venc_mode meson_hdmi_encp_mode_1080i50 = {
 	.encp = {
 		.dvi_settings = 0x202d,
 		.video_mode = 0x5ffc,
@@ -503,7 +503,7 @@ union meson_hdmi_venc_mode meson_hdmi_encp_mode_1080i50 = {
 	},
 };
 
-union meson_hdmi_venc_mode meson_hdmi_encp_mode_1080p24 = {
+static union meson_hdmi_venc_mode meson_hdmi_encp_mode_1080p24 = {
 	.encp = {
 		.dvi_settings = 0xd,
 		.video_mode = 0x4040,
@@ -552,7 +552,7 @@ union meson_hdmi_venc_mode meson_hdmi_encp_mode_1080p24 = {
 	},
 };
 
-union meson_hdmi_venc_mode meson_hdmi_encp_mode_1080p30 = {
+static union meson_hdmi_venc_mode meson_hdmi_encp_mode_1080p30 = {
 	.encp = {
 		.dvi_settings = 0x1,
 		.video_mode = 0x4040,
@@ -596,7 +596,7 @@ union meson_hdmi_venc_mode meson_hdmi_encp_mode_1080p30 = {
 	},
 };
 
-union meson_hdmi_venc_mode meson_hdmi_encp_mode_1080p50 = {
+static union meson_hdmi_venc_mode meson_hdmi_encp_mode_1080p50 = {
 	.encp = {
 		.dvi_settings = 0xd,
 		.video_mode = 0x4040,
@@ -644,7 +644,7 @@ union meson_hdmi_venc_mode meson_hdmi_encp_mode_1080p50 = {
 	},
 };
 
-union meson_hdmi_venc_mode meson_hdmi_encp_mode_1080p60 = {
+static union meson_hdmi_venc_mode meson_hdmi_encp_mode_1080p60 = {
 	.encp = {
 		.dvi_settings = 0x1,
 		.video_mode = 0x4040,
@@ -688,7 +688,7 @@ union meson_hdmi_venc_mode meson_hdmi_encp_mode_1080p60 = {
 	},
 };
 
-union meson_hdmi_venc_mode meson_hdmi_encp_mode_2160p24 = {
+static union meson_hdmi_venc_mode meson_hdmi_encp_mode_2160p24 = {
 	.encp = {
 		.dvi_settings = 0x1,
 		.video_mode = 0x4040,
@@ -730,7 +730,7 @@ union meson_hdmi_venc_mode meson_hdmi_encp_mode_2160p24 = {
 	},
 };
 
-union meson_hdmi_venc_mode meson_hdmi_encp_mode_2160p25 = {
+static union meson_hdmi_venc_mode meson_hdmi_encp_mode_2160p25 = {
 	.encp = {
 		.dvi_settings = 0x1,
 		.video_mode = 0x4040,
@@ -772,7 +772,7 @@ union meson_hdmi_venc_mode meson_hdmi_encp_mode_2160p25 = {
 	},
 };
 
-union meson_hdmi_venc_mode meson_hdmi_encp_mode_2160p30 = {
+static union meson_hdmi_venc_mode meson_hdmi_encp_mode_2160p30 = {
 	.encp = {
 		.dvi_settings = 0x1,
 		.video_mode = 0x4040,
@@ -814,7 +814,7 @@ union meson_hdmi_venc_mode meson_hdmi_encp_mode_2160p30 = {
 	},
 };
 
-struct meson_hdmi_venc_vic_mode {
+static struct meson_hdmi_venc_vic_mode {
 	unsigned int vic;
 	union meson_hdmi_venc_mode *mode;
 } meson_hdmi_venc_vic_modes[] = {
-- 
2.27.0

