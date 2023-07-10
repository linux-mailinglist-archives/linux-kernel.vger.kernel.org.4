Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C175774D0BB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjGJI7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjGJI7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:59:30 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F83F9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 01:59:28 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6687096c6ddso2177549b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 01:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688979567; x=1691571567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2OanSTpq1Hu+eB1tq8Ra7sloAy2DlkjuZwNNKykIg+Y=;
        b=N80NZ44X0t7thJJ0vLDqvr4zKutEVaCwMMFAPELtgteYsbDVFii3DI0Cx8z9T7Aacg
         +qdAnK579GkxHladVU00spflDJwR44Mdob9ep2ghfszyHQrUZiZzbDd+9J5A7fvaDZN9
         LIoqCRPzLjQw0Avyf6rcTyZs01pPkLs9Os4Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688979567; x=1691571567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2OanSTpq1Hu+eB1tq8Ra7sloAy2DlkjuZwNNKykIg+Y=;
        b=ewKJnoq1vUiZ0lz3oriBEOoWXMLCK916tpk0xdeFWf1zSbLyFWCrlR+tfc+y5IXCaC
         PqP+zb/TJ14lOGRwTiqp0OttCdG1C0S4ocpnfIv6GrF6mR1P/q2qCRXUqAgqr8ATg1RO
         GM1KaxzHJDe82cuu5/Wn4AdxFCSslXnWBkg6xN0PN0Fs7Gl089Z7lGf8q5PG/ITL+YMn
         WvesPhO5ELA162L7toASc0eU55VrxVo8/IdbSDAdZFEbhgZVOe8U+SNXzbqVRlYXe4mI
         BOHLbF5envVKwPN6L8FlooCfn8zxDSqvTENgk6u0LROOWVynvpbpc1ETcmbiaH3mpmt+
         jYjw==
X-Gm-Message-State: ABy/qLYly8DcCcNXQMLh3SShwQr/q5Moz0gCSGrcp4VTpFn5xf+X8R+0
        Gi9pdXFqaTydO/ZsEsiaEmO1PQ==
X-Google-Smtp-Source: APBJJlFY3VjxNMecfVD5N/oZbTxkxOx3DlD/D4Wh64sajE5X05MzrcSz0Ig3kMHdNwy6WaRwDMTCQw==
X-Received: by 2002:a05:6a20:a11f:b0:12c:dac0:a9a4 with SMTP id q31-20020a056a20a11f00b0012cdac0a9a4mr11924214pzk.5.1688979567468;
        Mon, 10 Jul 2023 01:59:27 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:be97:1d05:f9b6:36a6])
        by smtp.gmail.com with ESMTPSA id o7-20020a170902778700b001b8b3108292sm7750701pll.12.2023.07.10.01.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 01:59:27 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Xin Ji <xji@analogixsemi.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/bridge: anx7625: Drop device lock before drm_helper_hpd_irq_event()
Date:   Mon, 10 Jul 2023 16:59:21 +0800
Message-ID: <20230710085922.1871465-1-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
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

The device lock is used to serialize the low level power sequencing
operations. Since drm_helper_hpd_irq_event() could end up calling
.atomic_enable, which also calls power sequencing functions through
runtime PM, this results in a real deadlock. This was observed on an
MT8192-based Chromebook's external display (with appropriate patches [1]
and DT changes applied).

Move the drm_helper_hpd_irq_event() call outside of the lock range. The
lock only needs to be held so that the device status can be read back.
This is the bare minimum change to avoid the deadlock. The lock could
be dropped completely and have pm_runtime_get_if_in_use() increase the
reference count, but this is not the same as pm_runtime_suspended().

Dropping the lock completely also causes the internal display of the
same device to not function correctly if the internal bridge's
interrupt line is added in the device tree. Both the internal and
external display of said device each use one anx7625 bridge.

[1] https://lore.kernel.org/dri-devel/20230112042104.4107253-1-treapking@chromium.org/

Fixes: 60487584a79a ("drm/bridge: anx7625: refactor power control to use runtime PM framework")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- restore early return if event < 0

 drivers/gpu/drm/bridge/analogix/anx7625.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 866d018f4bb1..e93eba89d5ee 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1593,18 +1593,20 @@ static void anx7625_work_func(struct work_struct *work)
 
 	mutex_lock(&ctx->lock);
 
-	if (pm_runtime_suspended(&ctx->client->dev))
-		goto unlock;
+	if (pm_runtime_suspended(&ctx->client->dev)) {
+		mutex_unlock(&ctx->lock);
+		return;
+	}
 
 	event = anx7625_hpd_change_detect(ctx);
+
+	mutex_unlock(&ctx->lock);
+
 	if (event < 0)
-		goto unlock;
+		return;
 
 	if (ctx->bridge_attached)
 		drm_helper_hpd_irq_event(ctx->bridge.dev);
-
-unlock:
-	mutex_unlock(&ctx->lock);
 }
 
 static irqreturn_t anx7625_intr_hpd_isr(int irq, void *data)
-- 
2.41.0.255.g8b1d071c50-goog

