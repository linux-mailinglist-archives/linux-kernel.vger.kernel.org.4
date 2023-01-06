Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6A365F93F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 02:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjAFBki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 20:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjAFBka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 20:40:30 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8C23224A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 17:40:29 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 18so94611pfx.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 17:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8gCbSML/p6Kr09DdbXaCD2bHHww6ZP3H/AZnf3Fw7g=;
        b=glG7tzqprNLpK21tSwouvhh29Ru3oQMMT++WF/8EdyAe9E16EXDVV2gQ7MgD/YLbfD
         7i5ORFsmWI/15TfC6bE9Zh+BDD8BK7F3Cr25qWSmjIrnEIqHKvXKZPM93FIz7er9IXb9
         P09kmLdjasAmuSD6VJ5W6wIZSgZ1vfi8G3Cak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8gCbSML/p6Kr09DdbXaCD2bHHww6ZP3H/AZnf3Fw7g=;
        b=uY3AgYzRpeUUsgUzXpNLKG2woRw/0IAVbTBwzLnluSc6+E84RK0264MSTucU0AlTAK
         woZbzNJrUOTWGLK5nU46exT0TjC+daZBuRMlT0CMI7PCqAMy6bGSKnsOB6/w5xDWe0kE
         ejXXUFjSZ1eM5RwcbzV7o/fuOcE2Py1oE541MQXVb8KYf+6qTPKJ4Nsx3ec7Ytz4C5Lz
         +6O/yDlNSGKGkv2AA97+dL8AXFJpddC6I293q3CcNZyHeMZQaMQqlMfRErf7YKJiYsow
         snrlbUBrt0oS9Z3CRNI0GKXuvsXBEbNSK5iH2v3m7UFlUzFhx8dl2las24nTq6B95F5u
         UaZA==
X-Gm-Message-State: AFqh2krvnYTU5RWzhQrXELTm9c4ltkjQok/FLW8GUCTRe8XYLgpSbcCt
        fYbUQ4BybexfljuK4cLK696sRg==
X-Google-Smtp-Source: AMrXdXvC7oDu6YyGV+8jfSbsR7fE2kCUxk5coKNVNbu0UAKMzyqM7NgLBCShEMc/OPWHessmN1xdtQ==
X-Received: by 2002:a62:e510:0:b0:582:5b8d:52be with SMTP id n16-20020a62e510000000b005825b8d52bemr19080880pff.8.1672969229354;
        Thu, 05 Jan 2023 17:40:29 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:5567:fb20:aa4f:352])
        by smtp.gmail.com with UTF8SMTPSA id 142-20020a621994000000b00575caf80d08sm17868008pfz.31.2023.01.05.17.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 17:40:28 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>
Cc:     Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Brian Norris <briannorris@chromium.org>,
        stable@vger.kernel.org, "kernelci.org bot" <bot@kernelci.org>
Subject: [PATCH 2/2] drm/rockchip: vop: Leave vblank enabled in self-refresh
Date:   Thu,  5 Jan 2023 17:40:18 -0800
Message-Id: <20230105174001.2.Ic07cba4ab9a7bd3618a9e4258b8f92ea7d10ae5a@changeid>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230105174001.1.I3904f697863649eb1be540ecca147a66e42bfad7@changeid>
References: <20230105174001.1.I3904f697863649eb1be540ecca147a66e42bfad7@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we disable vblank when entering self-refresh, vblank APIs (like
DRM_IOCTL_WAIT_VBLANK) no longer work. But user space is not aware when
we enter self-refresh, so this appears to be an API violation -- that
DRM_IOCTL_WAIT_VBLANK fails with EINVAL whenever the display is idle and
enters self-refresh.

The downstream driver used by many of these systems never used to
disable vblank for PSR, and in fact, even upstream, we didn't do that
until radically redesigning the state machine in commit 6c836d965bad
("drm/rockchip: Use the helpers for PSR").

Thus, it seems like a reasonable API fix to simply restore that
behavior, and leave vblank enabled.

Note that this appears to potentially unbalance the
drm_crtc_vblank_{off,on}() calls in some cases, but:
(a) drm_crtc_vblank_on() documents this as OK and
(b) if I do the naive balancing, I find state machine issues such that
    we're not in sync properly; so it's easier to take advantage of (a).

Backporting notes:
Marking as 'Fixes' commit 6c836d965bad ("drm/rockchip: Use the helpers
for PSR"), but it probably depends on commit bed030a49f3e
("drm/rockchip: Don't fully disable vop on self refresh") as well.

We also need the previous patch ("drm/atomic: Allow vblank-enabled +
self-refresh "disable""), of course.

Fixes: 6c836d965bad ("drm/rockchip: Use the helpers for PSR")
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/dri-devel/Y5itf0+yNIQa6fU4@sirena.org.uk/
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index fa1f4ee6d195..c541967114b4 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -719,11 +719,11 @@ static void vop_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	mutex_lock(&vop->vop_lock);
 
-	drm_crtc_vblank_off(crtc);
-
 	if (crtc->state->self_refresh_active)
 		goto out;
 
+	drm_crtc_vblank_off(crtc);
+
 	/*
 	 * Vop standby will take effect at end of current frame,
 	 * if dsp hold valid irq happen, it means standby complete.
-- 
2.39.0.314.g84b9a713c41-goog

