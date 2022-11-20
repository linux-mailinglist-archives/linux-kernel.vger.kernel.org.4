Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB99631339
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 10:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiKTJih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 04:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKTJig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 04:38:36 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C156DFC2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 01:38:35 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id g62so8806589pfb.10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 01:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xdh47TdFCyP5Jo4EkJC1KVjModNAx4vFEonjM44Yfks=;
        b=iTynN8pTjr1cJvnkG7ZDVL9dN9LVoZhndKazXeJQj3Y7O2nWU3LFSGIj2ZFc/IYFtv
         6Up6UKsociYSjVOPCjiEqm5c1SUa0WPa6gC2KzKtSnmyvOnv1/rLY+tSITrAy7JT8Obb
         2JAHYHiVVC/ms0529NZlmf1NFId2N01IjlCiixgZYC8/i2L7HCfSazGkDVh4VdHbiZyx
         x2U50tl11xKKEyXB4+IJgXSVduiGeK4d9wDphdDlU6YIaSwLpaxfSoSYq9fr/+LE4DAL
         SSuaA5yuyjZuU0vmZGxp1hezo1hCnKisL9iCC+5EOyziXjBA4IjU0v/pbBhcfEnCBsDq
         xrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xdh47TdFCyP5Jo4EkJC1KVjModNAx4vFEonjM44Yfks=;
        b=3GNIDljgGrWB1s+YU2zT1m/TcBcst9tEKjF5ymsWIJJEcV+xNxUKCbGto6gAlOIpY8
         hjQkZk8VsopiLjsfw7He7ENX3lazlPZmhmvzn1jfjS0wZGJN/4p/x8ZjzxKBtpJyzBWS
         9b2b/OUvGLzRNqMgzaQVUJE/f4xYuntbC6su+iliqW+FLP/9//d44/OphD3IgixOw+zK
         qx2ZF420dD913XDcqZoKkq1Im5bfPGiBRwvB7d+wyEXOBfyp+FbIBusfpA6P+aovuELl
         43RGN/ilLgJdBkevudqBSBWqcd0XBU2AUvpv3qXP0ACeny4SxaUQYyDOT+n60O1EvkyE
         Ba5A==
X-Gm-Message-State: ANoB5pkiBZdtETGCB1ja6lIyO9rGQNpkWe/RWxOXsI0ZRsqj6S6P2oAf
        NNDeV9OWts/YKQO+j9WQ6oo53VWQoSxfsA==
X-Google-Smtp-Source: AA0mqf7Qb9yKGUq/bxq6PgPcQNj/9pksYDg4DDniOo2q/02PSfI5myWZHtCS0qzL+zASzr55fhwVDQ==
X-Received: by 2002:a62:5f46:0:b0:56b:cc74:4bd5 with SMTP id t67-20020a625f46000000b0056bcc744bd5mr2154127pfb.79.1668937115008;
        Sun, 20 Nov 2022 01:38:35 -0800 (PST)
Received: from 167-179-157-192.a7b39d.syd.nbn.aussiebb.net (167-179-157-192.a7b39d.syd.nbn.aussiebb.net. [167.179.157.192])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902da8700b00176a6ba5969sm7161109plx.98.2022.11.20.01.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 01:38:34 -0800 (PST)
From:   Jonathan Liu <net147@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     Jonathan Liu <net147@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/modes: Fix outdated drm_mode_vrefresh return value documentation
Date:   Sun, 20 Nov 2022 20:38:29 +1100
Message-Id: <20221120093830.47225-1-net147@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vrefresh field in drm_display_mode struct was removed so the
function no longer checks if it is set before calculating it.

Fixes: 0425662fdf05 ("drm: Nuke mode->vrefresh")
Signed-off-by: Jonathan Liu <net147@gmail.com>
---
 drivers/gpu/drm/drm_modes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 3c8034a8c27b..2d51ab2734a0 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -803,8 +803,7 @@ EXPORT_SYMBOL(drm_mode_set_name);
  * @mode: mode
  *
  * Returns:
- * @modes's vrefresh rate in Hz, rounded to the nearest integer. Calculates the
- * value first if it is not yet set.
+ * @modes's vrefresh rate in Hz, rounded to the nearest integer.
  */
 int drm_mode_vrefresh(const struct drm_display_mode *mode)
 {
-- 
2.38.1

