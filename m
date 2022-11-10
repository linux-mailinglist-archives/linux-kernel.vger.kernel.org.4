Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117E3624D50
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiKJVv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiKJVv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:51:57 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B335547329
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:51:56 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id e189so2372967iof.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g8xedc8fxi7Oy16t91/IwJKkMU3Vs8EWKD/qEznIlb8=;
        b=H6NyUOm0AbZkDaNkaLeJnr4J6eNslle8QEnwGkCsIc506Gkt8D9PxdaZWLFX05g60M
         RUiwxwgYUDNLWSY+yBK65p6rRPrxwHmgwhc4HYNv96+OL3GbuqXeObbh/nVpwfqq0Erw
         m1keT3DTD8rfvrZBGU87Bi6Mf4NKViG8XFZmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g8xedc8fxi7Oy16t91/IwJKkMU3Vs8EWKD/qEznIlb8=;
        b=gnKwUTAiQC9KaMhZ7eZpL0mm50q3NV/ItROOYdwC8IBvcuPdVgtmJxnV26Z1URV1Gh
         gRMPCrpxssbJyAJWIyOx0fz55LrbP1tM31WuicAQcv5YntnDzMNWBxrA4o3l/NX+J52w
         0KjX7SOocl9+V2aO/g6TS5ycljpbCUbN9eGyMSnAhosVEVQOPSiFNoWsCQObvQ7f52ab
         RjEpF+D4JBIF43BRf9lqX/oJHWtwOHxASyaAiWA3fCtz21YUmxKkGFGy17QK4dRuIex+
         nucBoT+nZdebrgdQXHC9HGRmzFM9KtXQeBcsx343x0IPme4BLpkB7MCZ6dkf5OdHcs8G
         sSGw==
X-Gm-Message-State: ANoB5pkYF8tRx4Im6Gv7Xyba7McfePuhewO2DUraa1fLoEdaB0dFMFDa
        rA1A5z4UOH+FD9IvmmukL7+0Dw==
X-Google-Smtp-Source: AA0mqf4TRie33rF/wj+ylHAB2svpRQGImmoYU6TxD3zeVtzwd9csitWfe0srFuqjJuNMqM/bufN49A==
X-Received: by 2002:a5e:a908:0:b0:6dd:813a:bfaa with SMTP id c8-20020a5ea908000000b006dd813abfaamr2839325iod.146.1668117116136;
        Thu, 10 Nov 2022 13:51:56 -0800 (PST)
Received: from midworld.bld.corp.google.com ([2620:15c:183:200:7240:bc49:e595:2755])
        by smtp.gmail.com with ESMTPSA id j15-20020a0566022ccf00b006ce94d987a3sm109371iow.30.2022.11.10.13.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 13:51:55 -0800 (PST)
From:   Drew Davenport <ddavenport@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Drew Davenport <ddavenport@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel-edp: Use ktime_get_boottime for delays
Date:   Thu, 10 Nov 2022 14:51:39 -0700
Message-Id: <20221110145102.1.I51639dc112bbbe27259df6bdad56dbabd655d91a@changeid>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ktime_get is based on CLOCK_MONOTONIC which stops on suspend. On
suspend, the time that the panel was powerd off is recorded with
ktime_get, and on resume this time is compared to the current ktime_get
time to determine if the driver should wait for the panel to power down
completely before re-enabling it.

Because we're using ktime_get, this delay doesn't account for the time
that the device is suspended, during which the power down delay may have
already elapsed.

Change to use ktime_get_boottime throughout, which uses CLOCK_BOOTTIME
which does not stop when suspended. This ensures that the resume path
will not be delayed if the power off delay has already been met while
the device is suspended.

Signed-off-by: Drew Davenport <ddavenport@chromium.org>

---

 drivers/gpu/drm/panel/panel-edp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 5cb8dc2ebe184..a0a7ab35e08c9 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -351,7 +351,7 @@ static void panel_edp_wait(ktime_t start_ktime, unsigned int min_ms)
 		return;
 
 	min_ktime = ktime_add(start_ktime, ms_to_ktime(min_ms));
-	now_ktime = ktime_get();
+	now_ktime = ktime_get_boottime();
 
 	if (ktime_before(now_ktime, min_ktime))
 		msleep(ktime_to_ms(ktime_sub(min_ktime, now_ktime)) + 1);
@@ -378,7 +378,7 @@ static int panel_edp_suspend(struct device *dev)
 
 	gpiod_set_value_cansleep(p->enable_gpio, 0);
 	regulator_disable(p->supply);
-	p->unprepared_time = ktime_get();
+	p->unprepared_time = ktime_get_boottime();
 
 	return 0;
 }
@@ -464,14 +464,14 @@ static int panel_edp_prepare_once(struct panel_edp *p)
 		}
 	}
 
-	p->prepared_time = ktime_get();
+	p->prepared_time = ktime_get_boottime();
 
 	return 0;
 
 error:
 	gpiod_set_value_cansleep(p->enable_gpio, 0);
 	regulator_disable(p->supply);
-	p->unprepared_time = ktime_get();
+	p->unprepared_time = ktime_get_boottime();
 
 	return err;
 }
-- 
2.38.1.493.g58b659f92b-goog

