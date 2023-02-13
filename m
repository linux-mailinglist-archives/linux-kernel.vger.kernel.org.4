Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A3869414A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjBMJec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjBMJeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:34:12 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9081AC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:32:25 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id h29so3114064ila.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HBz92z5A8CZa/xH83NbuX5+91oG8R3c7gdeOhlTDlKA=;
        b=PTUc3vXyXoqSkn9BsgwWHkXFDBT0xwJkWyWTC06HDyAu0xsxh3wUGX1fSckmu64gDn
         LfMFHtwdZRRgfR2hl26pjCvG/Ptp6QdqNgWxQ1gq26Hz8QeF6ieFlTzuwqSmNr9IozIn
         ObSkHz1bBsm/sdePESII2BNovcKIPjnreiVQMuRpiHH4IP6f2gOqcLxpP5IDQJaGK32f
         Ww9Yz2RNxx0wdfykTiuZUIOrbHK/nvix7akhBdZ80wmN8muS7F635m61YLYj1141VZj0
         z6/fqyMlVSyfHKvl9FlRRZ3gUAhCTY6bo4hssX+Uz1pBn0FvI66VijCs6UBbg76vEke3
         fgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBz92z5A8CZa/xH83NbuX5+91oG8R3c7gdeOhlTDlKA=;
        b=NLNuElQ2MRjmCJ8bWq5+HEKbkSyJarwdPYB/PD7sFXxudT/HBOeMVL29UKNCoC9Tp/
         478dFz0mFuQ3uB+ci3tPyZFdYTMYVpCSuMOAKokTaRO271UtrfJ+n1vSkxb9ke7j3s2J
         2WhWNfYlEGtZ2GafFw/hjIdJ+N9dS5KJIRSAgLKZCFy3S4DJcZP+oDKSPUa86Z92R+Mv
         k20WHDLEX82Fns2oi4/3hVMq8EJm4Pa+fh18ug69eFWITmVLnpN01xYYJfXPJ4Ykbv2j
         8YI13byh9/ZxByhGzFToYggqswF70erBRQEIuNFSiBuZGNbQbiBjc/tTOpsdNj7Z3jKF
         BDUQ==
X-Gm-Message-State: AO0yUKUxDUn5a6sYSMdlMFt2mHmsvs8Zpa+pkVqPY9adlPrQ0VpqaUTg
        QJHCDuF93pI9gZ+tGcERdNJIcw==
X-Google-Smtp-Source: AK7set+hjjq9yGMomTKRGA59ne7HDilQggjbF/jlQkSZf17NedHYh2S0uP13f98jIUFirkZ0Z844Gg==
X-Received: by 2002:a05:6e02:2143:b0:315:35d4:1d28 with SMTP id d3-20020a056e02214300b0031535d41d28mr6432722ilv.8.1676280744277;
        Mon, 13 Feb 2023 01:32:24 -0800 (PST)
Received: from [127.0.1.1] ([2a0e:41a:894f:0:2487:f87c:fb5b:9046])
        by smtp.gmail.com with ESMTPSA id v14-20020a02b90e000000b003a0565a5750sm3695383jan.119.2023.02.13.01.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 01:32:23 -0800 (PST)
From:   Carlo Caione <ccaione@baylibre.com>
Date:   Mon, 13 Feb 2023 10:32:09 +0100
Subject: [PATCH v2] drm/meson/meson_venc: Relax the supported mode checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230210-relax_dmt_limits-v2-1-318913f08121@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAJgD6mMC/32NXQrCMBCEr1L22UiSthZ88h4iZZOudiE/kNRgK
 bm7wQP4NHwD38wBmRJThmt3QKLCmWNooE8d2BXDiwQvjUFL3UutpEjk8DMvfpsde96y6MeRNCo
 7WfuEphnMJEzCYNcmhrdzrVw5bzHtv5uiWtz/LBYlpEA1TMNFD8vYy5vB3bFJdLbRw6PW+gVai
 TTvuAAAAA==
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Da Xue <da@lessconfused.com>
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relax a bit the supported modes list by including also 480x1920 and
400x1280. This was actually tested on real hardware and it works
correctly.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
In particular relax the resolution checks to allow more resolutions like
480x1920 and 400x1280.
---
Changes in v2:
- Lower the hdisplay limit to support 400x1280 as well.
- Link to v1: https://lore.kernel.org/r/20230210-relax_dmt_limits-v1-0-a1474624d530@baylibre.com
---
 drivers/gpu/drm/meson/meson_venc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index 3c55ed003359..fcd532db19c1 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -866,10 +866,10 @@ meson_venc_hdmi_supported_mode(const struct drm_display_mode *mode)
 			    DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC))
 		return MODE_BAD;
 
-	if (mode->hdisplay < 640 || mode->hdisplay > 1920)
+	if (mode->hdisplay < 400 || mode->hdisplay > 1920)
 		return MODE_BAD_HVALUE;
 
-	if (mode->vdisplay < 480 || mode->vdisplay > 1200)
+	if (mode->vdisplay < 480 || mode->vdisplay > 1920)
 		return MODE_BAD_VVALUE;
 
 	return MODE_OK;

---
base-commit: 38c1e0c65865426676123cc9a127526fa02bcac6
change-id: 20230210-relax_dmt_limits-355e2a1c7ccf

Best regards,
-- 
Carlo Caione

