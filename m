Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9523A74D11C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjGJJK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjGJJKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:10:50 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FA4127
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:10:49 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a1ebb79579so3263154b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688980248; x=1691572248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+G6rw6Lzr4S57ts7YP1ylMlTPk8hLpi7yHWyU7B67Pk=;
        b=WA5KTELETcwWf6w/I55emKwkPdPD6iqH5cMo+ztoYJPOEhyW0/lxNunr71IJJgEdb0
         2BuAPcAN8UtUjVLClL3O/XIk22Ql1QD0X5B5mVXbPp4K8te5CPBCi5/r5a9c/0yAbs0M
         TXWfi6YXFEVwT9ToCZShEm1GhLQTa1PFXALAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688980248; x=1691572248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+G6rw6Lzr4S57ts7YP1ylMlTPk8hLpi7yHWyU7B67Pk=;
        b=BNCknR9mbVHnsaI0VnUjNW9ZZh5H+Pm5UHJkSrv/WTAVtRMpu27tUFX4K5jH18hodX
         txt5SGdcjDnSUwfteFqEJweBKIjxaPQlbEbSjCqG7pqiupoMcgbpLO8oOLbjopFdsOyD
         DxHXlsSsrZirWAOMu0y5dDucS61ngliT/Q6zjWX6R/MTF/v4zQn274gcKHQ5Drzyu01Y
         3kaRXrP6RjOjXbaPSWwNXjcMUOxTXsNNoYn0Mtd/mimzhbuLOU0B00yiUIQVRGork14a
         qbkvAAb0hZlerOtncMLaRc1WG+IAbnudYmYHQHfb0RKGQ9pRmIkC4KblftbRXENfd+iW
         GfoQ==
X-Gm-Message-State: ABy/qLbr2fNH9e2k3jr7UBahtBAKcwRCqXNUe8ButecrFnTk9rHksUtC
        enKD1rn0l/2N2oOyhTw6RQQfxA==
X-Google-Smtp-Source: APBJJlEpqaHHC1IrHo+NkQBReIWnVoPc8td0Q6Q/LlodZF7TnbCM+J5/LE3j7wJfL6wk0SQ9tHt8Bw==
X-Received: by 2002:a05:6358:52ca:b0:135:3f00:b8de with SMTP id z10-20020a05635852ca00b001353f00b8demr11516209rwz.17.1688980248710;
        Mon, 10 Jul 2023 02:10:48 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:be97:1d05:f9b6:36a6])
        by smtp.gmail.com with ESMTPSA id w27-20020a637b1b000000b0053f06d09725sm6997574pgc.32.2023.07.10.02.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 02:10:48 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Xin Ji <xji@analogixsemi.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] drm/bridge: anx7625: Use common macros for DP power sequencing commands
Date:   Mon, 10 Jul 2023 17:09:27 +0800
Message-ID: <20230710090929.1873646-1-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Collected tags and rebased on v6.5-rc1.

 drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 8b985efdc086..9db3784cb554 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -931,8 +931,8 @@ static void anx7625_dp_start(struct anx7625_data *ctx)
 
 	dev_dbg(dev, "set downstream sink into normal\n");
 	/* Downstream sink enter into normal mode */
-	data = 1;
-	ret = anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, 0x000600, 1, &data);
+	data = DP_SET_POWER_D0;
+	ret = anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, DP_SET_POWER, 1, &data);
 	if (ret < 0)
 		dev_err(dev, "IO error : set sink into normal mode fail\n");
 
@@ -971,8 +971,8 @@ static void anx7625_dp_stop(struct anx7625_data *ctx)
 
 	dev_dbg(dev, "notify downstream enter into standby\n");
 	/* Downstream monitor enter into standby mode */
-	data = 2;
-	ret |= anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, 0x000600, 1, &data);
+	data = DP_SET_POWER_D3;
+	ret |= anx7625_aux_trans(ctx, DP_AUX_NATIVE_WRITE, DP_SET_POWER, 1, &data);
 	if (ret < 0)
 		DRM_DEV_ERROR(dev, "IO error : mute video fail\n");
 
-- 
2.41.0.255.g8b1d071c50-goog

