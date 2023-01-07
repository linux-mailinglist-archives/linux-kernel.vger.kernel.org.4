Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EEE660B75
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 02:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbjAGBYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 20:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbjAGBX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 20:23:57 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A4D6DB9B
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 17:23:55 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v23so3177213pju.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 17:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mePU1ZAhSqo8qTV2sJWgAIGRWTZTuG5GYl0yO3MCKB4=;
        b=ORZnF9sbfKyWHytaUFPFsZGI7BSTg4M86QZcVlCqdAZbjZp7JQXb4WEWzUjS8C30u4
         VaGo9gRMDcaYwofVZlwp5RmXD0B/i9+aoHyJfYZ6zNok7RDhn8WtyBqNfAhy3WexA6FE
         oUbbMZcyraLMbrTbAf9ex4fX4I6dAu8TWyEYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mePU1ZAhSqo8qTV2sJWgAIGRWTZTuG5GYl0yO3MCKB4=;
        b=0Cp53CdsMF0sj5texNXDOkGbTMsaFd+5vkS53Ez6C7FLKtG6QxpGndg8Zd4smAJfT8
         04935bh+0Lb3A19VPSo5yZ6b4kNGpsggdlfGEWhsloKkI+akh/bKW3eX7Rn6r1776yTe
         JLQYERRgw3BanCQ8taSDjvso2Lk9W3LhjULanTJ7p//qdZmbWZr/jPKBb5N+ouD1Okbo
         XBiJr4nekx895thq+oCCq9vUJXtQGJnMmLL+B3UPNMh/CwwQoXZNoTWFUIEeCN4Upm9g
         UmkfujXJXfKfmTKtMdYjAdjdqlmbzAN3/xB0TrllM0fFvrdAolNCuCxWY7S1xPeZ4TYM
         AdRA==
X-Gm-Message-State: AFqh2koO8ABmVK2VNYwgYcmCoptugNsrB0aqyiVD9RJVHnZy5JjEOaGS
        x0hV81C8ekUG2yGSb4wsbrqd3Q==
X-Google-Smtp-Source: AMrXdXvVILC1sku5q0Ao6IUCbaJtDoD3exxH985nTWiQEplQABh9TP8ue13rxf2FJyS7lDBveGM2MQ==
X-Received: by 2002:a05:6a20:4f88:b0:ac:5a0c:32ad with SMTP id gh8-20020a056a204f8800b000ac5a0c32admr55348750pzb.53.1673054634879;
        Fri, 06 Jan 2023 17:23:54 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:bc4e:2cc9:68b3:15dc])
        by smtp.gmail.com with UTF8SMTPSA id q3-20020a17090311c300b0018c990ce7fesm1492103plh.239.2023.01.06.17.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 17:23:54 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>
Cc:     =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Sandy Huang <hjc@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>, stable@vger.kernel.org
Subject: [PATCH v2 1/2] drm/atomic: Allow vblank-enabled + self-refresh "disable"
Date:   Fri,  6 Jan 2023 17:23:22 -0800
Message-Id: <20230106172310.v2.1.I3904f697863649eb1be540ecca147a66e42bfad7@changeid>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
vblank enabled.

Add a different expectation: that CRTCs *should* leave vblank enabled
when going into self-refresh.

This patch is preparation for another patch -- "drm/rockchip: vop: Leave
vblank enabled in self-refresh" -- which resolves conflicts between the
above self-refresh behavior and the API tests in IGT's kms_vblank test
module.

v2:
 * add 'ret != 0' warning case for self-refresh
 * describe failing test case and relation to drm/rockchip patch better

Cc: <stable@vger.kernel.org> # dependency for "drm/rockchip: vop: Leave
                             # vblank enabled in self-refresh"
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index d579fd8f7cb8..a22485e3e924 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1209,7 +1209,16 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
 			continue;
 
 		ret = drm_crtc_vblank_get(crtc);
-		WARN_ONCE(ret != -EINVAL, "driver forgot to call drm_crtc_vblank_off()\n");
+		/*
+		 * Self-refresh is not a true "disable"; ensure vblank remains
+		 * enabled.
+		 */
+		if (new_crtc_state->self_refresh_active)
+			WARN_ONCE(ret != 0,
+				  "driver disabled vblank in self-refresh\n");
+		else
+			WARN_ONCE(ret != -EINVAL,
+				  "driver forgot to call drm_crtc_vblank_off()\n");
 		if (ret == 0)
 			drm_crtc_vblank_put(crtc);
 	}
-- 
2.39.0.314.g84b9a713c41-goog

