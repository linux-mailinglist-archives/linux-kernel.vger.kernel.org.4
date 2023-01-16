Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E0566B824
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 08:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjAPHYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 02:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjAPHYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 02:24:12 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8762C650
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 23:24:11 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id q23-20020a17090a065700b002290913a521so10775564pje.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 23:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ni4uZerb82m6sG9PyWeah+pcBmtj9ALkxTiSi64ZLJA=;
        b=eZ0C9MzdHljfc0iZikOy6ACBmYGakhCzHaNk+ISGQS/AYhTbmGS85Ocf4VdKXS6J6g
         I8zU46FOzy8IxXnyZ7mDRivZNDcKEQIcnAXAcjLCxGynqMBM3tHGhMxMG7EjLWC8rewr
         r81qcBuGrWNd2j42VFSgoeflk+AUpWpe9KCFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ni4uZerb82m6sG9PyWeah+pcBmtj9ALkxTiSi64ZLJA=;
        b=HUKZs2HEI3/rdWfaD0aAT9hxA+FBwhzV9tZsAmFLkfcnWB3lOeVQ257hFcxzgkwKIu
         ebCnRatgFaUWaI7TINVPvKcGs9xyDqsp00IHy5pvMdsZ/cMcgZC9Iyag2eIkIux5vJ7r
         +ml2F3dowmoITewkfG8Rc6Ir1mB6rkYT6OXJMnmYn8/QqeZ3FYGylYn7dWqvKJQ/SUfY
         9RM0VDUc/XW30ac1z2/zT6y6Y8kwybvSXzqLereVXC9ezL4UdFOk1OJsKGG4XopvO8e0
         WyKTGu9IAGpqYF/kjI4C2uCRWZfeX+oolHdjFghGtCJKIhxQLJPhFOdG35cZXvt7EVgG
         vVTg==
X-Gm-Message-State: AFqh2krm9lLQTpCRir4DIMcsQIa0U2vYsrs3P3ApnGhU1X87Ak8FAY9G
        vpmJOy4YaQ5aheuR3MEcfcq25w==
X-Google-Smtp-Source: AMrXdXvp3DxYbsTR9t8SKnjeLZd9dx6QUSRcZFMtY8RTBxIAJJIMAA4cE/tATX0KFnsHYmpOptOIKQ==
X-Received: by 2002:a17:902:b608:b0:192:babc:20df with SMTP id b8-20020a170902b60800b00192babc20dfmr55147480pls.58.1673853851445;
        Sun, 15 Jan 2023 23:24:11 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:1d4f:b969:9e53:5eb0])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902ea0100b001913c5fc051sm7415541plg.274.2023.01.15.23.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 23:24:11 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, Xin Ji <xji@analogixsemi.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: anx7625: Use common macros for DP power sequencing commands
Date:   Mon, 16 Jan 2023 15:24:06 +0800
Message-Id: <20230116072406.3971025-1-wenst@chromium.org>
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

The DRM DP code has macros for the DP power sequencing commands. Use
them in the anx7625 driver instead of raw numbers.

Fixes: 548b512e144f ("drm/bridge: anx7625: send DPCD command to downstream")
Fixes: 27f26359de9b ("drm/bridge: anx7625: Set downstream sink into normal status")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
This is a minor cleanup. No functional changes.

 drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 808dbf79d209..7e1fb93a6ce4 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -935,8 +935,8 @@ static void anx7625_dp_start(struct anx7625_data *ctx)
 
 	dev_dbg(dev, "set downstream sink into normal\n");
 	/* Downstream sink enter into normal mode */
-	data = 1;
-	ret = anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, 0x000600, 1, &data);
+	data = DP_SET_POWER_D0;
+	ret = anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, DP_SET_POWER, 1, &data);
 	if (ret < 0)
 		dev_err(dev, "IO error : set sink into normal mode fail\n");
 
@@ -975,8 +975,8 @@ static void anx7625_dp_stop(struct anx7625_data *ctx)
 
 	dev_dbg(dev, "notify downstream enter into standby\n");
 	/* Downstream monitor enter into standby mode */
-	data = 2;
-	ret |= anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, 0x000600, 1, &data);
+	data = DP_SET_POWER_D3;
+	ret |= anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, DP_SET_POWER, 1, &data);
 	if (ret < 0)
 		DRM_DEV_ERROR(dev, "IO error : mute video fail\n");
 
-- 
2.39.0.314.g84b9a713c41-goog

