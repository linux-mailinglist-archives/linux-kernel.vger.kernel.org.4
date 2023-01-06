Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429A565F93C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjAFBkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjAFBk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:40:28 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CFB3227F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 17:40:27 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id cl14so119010pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 17:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vd1mAgVVTT449fHfx2SSArigVZjhQAUUxQLxBkWmUZY=;
        b=DPHGui8QRmvaHU3DjCknrlpCldx/5v2OWyAyXICYBob9XLXk8DRWNug04ad+L+D6QF
         yQtKJe2REavJ/0MCusreMlT5MSx/4G0eq24SxO0ufeBTun+1XdP7BTN6KqtS2fV34YPD
         cvqScEg2/NatNc3sAr34tTgsDmpFnKUJ2dcqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vd1mAgVVTT449fHfx2SSArigVZjhQAUUxQLxBkWmUZY=;
        b=muC7MHnrlj62OtnGQSwg7xVlYjUyWfXH1WaCoVp6nB/hYC3UKdiwm6faK7es/Mr43u
         B+9FKVsMri9iaLftCDaRovYw7qJxeeAD34P8i1YCAd5GBhwpORBcaSGPtBJvp0b0giA/
         waWnATcdoCvUTB0wW2h+wTAPf9hXT5NrDgfD6563olIGvNd3LVJMif8P/1QNGVOq0k1m
         rvxmyg/P44379q+SA/vduQmMN0N747FC+YkizRlp+0CAJp4yQHa9NFNYvMwKI0SI+Y7t
         i3FuPtLRfBdMYFiCeJLodAqMx9IbSN55f0n+U3mFuSza7T4+ExPEoHBLmvT9hYjfmhgi
         v3Jw==
X-Gm-Message-State: AFqh2kpNOx0/0RURJqO/x8TmloRfNjaUToMLMHjxoTHPOuSIGzyNdFHf
        yMs4fl0eJHHmE4tGHUawVS3umQ==
X-Google-Smtp-Source: AMrXdXuA+H0C6hhXoQgKWSW+0hWutAD/Rw5+F2uGIQXQ1RV5rw8QgVaH85iAhFDqCwDsueI7WxmVcw==
X-Received: by 2002:a05:6a20:429f:b0:ad:bd55:6dcf with SMTP id o31-20020a056a20429f00b000adbd556dcfmr79280084pzj.28.1672969227205;
        Thu, 05 Jan 2023 17:40:27 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:5567:fb20:aa4f:352])
        by smtp.gmail.com with UTF8SMTPSA id i1-20020a6551c1000000b00478f87eaa44sm22461638pgq.35.2023.01.05.17.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 17:40:26 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>
Cc:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Brian Norris <briannorris@chromium.org>, stable@vger.kernel.org
Subject: [PATCH 1/2] drm/atomic: Allow vblank-enabled + self-refresh "disable"
Date:   Thu,  5 Jan 2023 17:40:17 -0800
Message-Id: <20230105174001.1.I3904f697863649eb1be540ecca147a66e42bfad7@changeid>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The self-refresh helper framework overloads "disable" to sometimes mean
"go into self-refresh mode," and this mode activates automatically
(e.g., after some period of unchanging display output). In such cases,
the display pipe is still considered "on", and user-space is not aware
that we went into self-refresh mode. Thus, users may expect that
vblank-related features (such as DRM_IOCTL_WAIT_VBLANK) still work
properly.

However, we trigger the WARN_ONCE() here if a CRTC driver tries to leave
vblank enabled here.

Add a new exception, such that we allow CRTCs to be "disabled" (with
self-refresh active) with vblank interrupts still enabled.

Cc: <stable@vger.kernel.org> # dependency for subsequent patch
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/gpu/drm/drm_atomic_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index d579fd8f7cb8..7b5eddadebd5 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1207,6 +1207,12 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
 
 		if (!drm_dev_has_vblank(dev))
 			continue;
+		/*
+		 * Self-refresh is not a true "disable"; let vblank remain
+		 * enabled.
+		 */
+		if (new_crtc_state->self_refresh_active)
+			continue;
 
 		ret = drm_crtc_vblank_get(crtc);
 		WARN_ONCE(ret != -EINVAL, "driver forgot to call drm_crtc_vblank_off()\n");
-- 
2.39.0.314.g84b9a713c41-goog

