Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1172B7432B1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 04:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjF3CUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 22:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjF3CU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 22:20:28 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CBA358A;
        Thu, 29 Jun 2023 19:20:24 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-39ca48cd4c6so1007870b6e.0;
        Thu, 29 Jun 2023 19:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688091623; x=1690683623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ta4EJbZZ0uV3MxaQXraN6HqKk8GzjbnpNw8IbX9ky+g=;
        b=TPV5PImZsHzOznLksdHPnIn+FCKyQmrTmJtjsgRrJQQr/WiyaQMA0Lq58dokiR0rKN
         uJH3mNfiuKKAK6fF1kCpYdoQ7G1Ma+oP2O+3YD+lUXwSdzitKiKrc+3vYPwOtH5tiAfm
         25/hXKSfUD7kDWtFc3Nt6Ocx6S2q9nq2IHEZuWezVBUTmJWj65DbdOOIVnujI9Zdbnqm
         opLSeLa3iSMK3r1AgkjFDY565wz3iYJ6KN8MplPXB+cU122BpSvl0DWPbFstcszqnfKx
         jGIOQVUvC41C/n9Hbcdibn30pEDRuVjk3Dnolg3ZruHYoTtMF+fU1wl+q6Jz1HlelJjo
         x6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688091623; x=1690683623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ta4EJbZZ0uV3MxaQXraN6HqKk8GzjbnpNw8IbX9ky+g=;
        b=ZyE1CHS9yLGqsTqPBRS1OI3D02ztBS+xQPBXlNDVRcAINaj0Su4rxz0zCPZ7xhTzVB
         WOE92Q+zUMorhtJo8sqBdJoTa9EWgdwDxfoBR4hsuENmS63mfdMaKObeKC0SOqzoGnnf
         vgn/CF/QddukRHWM8UrpXkR/Go2umLHyTHAY7cTVEkPgCCisdtMI/Ho40dpCgnj60t+N
         Rervh8s16ZQCCerUZX0q9PNFjd5dxm5oPzpGhMi/0li4M2k3PmewJmVQVc898IN1zXaa
         6gkfepqMF/mlGW3yuBHXm43EYbSau6nR9p/UtueL3GDTmqizbEGXOm5z2VQdKt81EEby
         MhQw==
X-Gm-Message-State: AC+VfDz+qLUJTcMagqtlD/BnVaz/1cQ0xTjbwzALHuYqT4vVp+RYTnEV
        Q1BzHtbRF+qYgc1ZYsuZLz4RPEsr4sMSDw==
X-Google-Smtp-Source: ACHHUZ44vTUV957qp9+DnLN4eNNEpL6MTmRnTy+8ptocJfF63+XpjMn4jsXa4h2C+NbR++rf1zLuxw==
X-Received: by 2002:a05:6808:6295:b0:3a3:76d4:b506 with SMTP id du21-20020a056808629500b003a376d4b506mr1091901oib.20.1688091623504;
        Thu, 29 Jun 2023 19:20:23 -0700 (PDT)
Received: from oslab-pc.tsinghua.edu.cn ([166.111.139.122])
        by smtp.gmail.com with ESMTPSA id t18-20020aa79392000000b0063d24fcc2b7sm3055384pfe.1.2023.06.29.19.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 19:20:23 -0700 (PDT)
From:   Tuo Li <islituo@gmail.com>
To:     inki.dae@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, airlied@gmail.com, daniel@ffwll.ch,
        krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@outlook.com, Tuo Li <islituo@gmail.com>,
        BassCheck <bass@buaa.edu.cn>
Subject: [PATCH] drm/exynos: fix a possible null-pointer dereference due to data race in exynos_drm_crtc_atomic_disable()
Date:   Fri, 30 Jun 2023 10:19:06 +0800
Message-Id: <20230630021906.1035115-1-islituo@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable crtc->state->event is often protected by the lock 
crtc->dev->event_lock when is accessed. However, it is accessed as a 
condition of an if statement in exynos_drm_crtc_atomic_disable() without
holding the lock:

  if (crtc->state->event && !crtc->state->active)

However, if crtc->state->event is changed to NULL by another thread right
after the conditions of the if statement is checked to be true, a
null-pointer dereference can occur in drm_crtc_send_vblank_event():

  e->pipe = pipe;

To fix this possible null-pointer dereference caused by data race, the 
spin lock coverage is extended to protect the if statement as well as the 
function call to drm_crtc_send_vblank_event().

Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_drm_crtc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_crtc.c b/drivers/gpu/drm/exynos/exynos_drm_crtc.c
index 4153f302de7c..d19e796c2061 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_crtc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_crtc.c
@@ -39,13 +39,12 @@ static void exynos_drm_crtc_atomic_disable(struct drm_crtc *crtc,
 	if (exynos_crtc->ops->atomic_disable)
 		exynos_crtc->ops->atomic_disable(exynos_crtc);
 
+	spin_lock_irq(&crtc->dev->event_lock);
 	if (crtc->state->event && !crtc->state->active) {
-		spin_lock_irq(&crtc->dev->event_lock);
 		drm_crtc_send_vblank_event(crtc, crtc->state->event);
-		spin_unlock_irq(&crtc->dev->event_lock);
-
 		crtc->state->event = NULL;
 	}
+	spin_unlock_irq(&crtc->dev->event_lock);
 }
 
 static int exynos_crtc_atomic_check(struct drm_crtc *crtc,
-- 
2.34.1

