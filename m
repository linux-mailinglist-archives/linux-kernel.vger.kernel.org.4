Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05D45F2810
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 07:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiJCFD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 01:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJCFDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 01:03:54 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2F926579
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 22:03:52 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id j71so2641767pge.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 22:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=aBBW7OEU3Jgfto9gKhCEsUvgKLnU3sOd14ZwKXmRCUU=;
        b=VOs7XxzGPKi8k8vLT++EXRfoNjCuEcMwGNH7k6UOdHcoLaHmZOyxPkgLqMtDa3ocaj
         INMu6y/TvmRJOKFZl8pMwl2Wi5dYSKawjc07YqUiryTmLxVviffpXJWYMXY9azqCWste
         qdgJC/Q8mKo19TX+ujvqHl63YHyazDU4W5yi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=aBBW7OEU3Jgfto9gKhCEsUvgKLnU3sOd14ZwKXmRCUU=;
        b=t2HTqouWf4S55QGBVlfZo/pOa/hnKBHHccTRJHiznsNa2zcRaiv/J+UZT0H9ElURje
         QKdVs2h9ZuWMW0DfJJF1vvcci1a11fX/FCk7/SoNRYSr+9qfbmbIvVPhP0fbg38JWXHP
         5MjeieeQjRk5GM7f4BgXORGCpUIUUPBjnoqbiDDEzvBhLCGh1evWf8QPd05NWK5cNcXY
         TsWERmqwNtb6Ouro4RytVJOyVf0uq4ZzpnxpM5ts7ZisTFbc5qrybScf6e+QmAeuQcsK
         a+okGxb5V6gs1w+WARn3QoHxfvkQ7jTUtCUteEC1Xm6w0RNxsknXysyWuv60f9kNzD3N
         2m9g==
X-Gm-Message-State: ACrzQf3lcA8EfwnNYyOHUmKIL0cxzoRfx33Cxweu0Y1nJaUpJOf/SQEi
        kZB4zGtI6ialTfilPfjABOGt4w==
X-Google-Smtp-Source: AMsMyM4JnYlktQ8B8Bmm6tGapdzDSy19ilVqdF8e9ZTCi3eSy74kgYRGZfNK3k+jqcqm8iFkKmP8lQ==
X-Received: by 2002:a63:1210:0:b0:435:60d2:b953 with SMTP id h16-20020a631210000000b0043560d2b953mr17385550pgl.459.1664773432289;
        Sun, 02 Oct 2022 22:03:52 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:dfa6:5a1a:b35a:db69])
        by smtp.gmail.com with ESMTPSA id y8-20020a170902b48800b0017680faa1a8sm6174628plr.112.2022.10.02.22.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 22:03:51 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, Hermes Wu <hermes.wu@ite.com.tw>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen Chen <allen.chen@ite.com.tw>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v2 1/2] drm/bridge: it6505: Adapt runtime power management framework
Date:   Mon,  3 Oct 2022 13:03:34 +0800
Message-Id: <20221003050335.1007931-2-treapking@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221003050335.1007931-1-treapking@chromium.org>
References: <20221003050335.1007931-1-treapking@chromium.org>
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

Use pm_runtime_(get|put)_sync to control the bridge power, and add
SET_SYSTEM_SLEEP_PM_OPS with pm_runtime_force_(suspend|resume) to it6505
driver. Without SET_SYSTEM_SLEEP_PM_OPS, the bridge will be powered on
unnecessarily when no external display is connected.

Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

Changes in v2:
- Handle the error from pm_runtime_get_sync in it6505_extcon_work

 drivers/gpu/drm/bridge/ite-it6505.c | 33 +++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 2bb957cffd94..685d8e750b12 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -421,6 +421,7 @@ struct it6505 {
 	struct notifier_block event_nb;
 	struct extcon_dev *extcon;
 	struct work_struct extcon_wq;
+	int extcon_state;
 	enum drm_connector_status connector_status;
 	enum link_train_status link_state;
 	struct work_struct link_works;
@@ -2685,31 +2686,42 @@ static void it6505_extcon_work(struct work_struct *work)
 {
 	struct it6505 *it6505 = container_of(work, struct it6505, extcon_wq);
 	struct device *dev = &it6505->client->dev;
-	int state = extcon_get_state(it6505->extcon, EXTCON_DISP_DP);
-	unsigned int pwroffretry = 0;
+	int state, ret;
 
 	if (it6505->enable_drv_hold)
 		return;
 
 	mutex_lock(&it6505->extcon_lock);
 
+	state = extcon_get_state(it6505->extcon, EXTCON_DISP_DP);
 	DRM_DEV_DEBUG_DRIVER(dev, "EXTCON_DISP_DP = 0x%02x", state);
+
+	if (state == it6505->extcon_state)
+		goto unlock;
+
 	if (state > 0) {
 		DRM_DEV_DEBUG_DRIVER(dev, "start to power on");
 		msleep(100);
-		it6505_poweron(it6505);
+		ret = pm_runtime_get_sync(dev);
+
+		/*
+		 * On system resume, extcon_work can be triggered before
+		 * pm_runtime_force_resume re-enables runtime power management.
+		 * Handling the error here to make sure the bridge is powered on.
+		 */
+		if (ret)
+			it6505_poweron(it6505);
 	} else {
 		DRM_DEV_DEBUG_DRIVER(dev, "start to power off");
-		while (it6505_poweroff(it6505) && pwroffretry++ < 5) {
-			DRM_DEV_DEBUG_DRIVER(dev, "power off fail %d times",
-					     pwroffretry);
-		}
+		pm_runtime_put_sync(dev);
 
 		drm_helper_hpd_irq_event(it6505->bridge.dev);
 		memset(it6505->dpcd, 0, sizeof(it6505->dpcd));
 		DRM_DEV_DEBUG_DRIVER(dev, "power off it6505 success!");
 	}
+	it6505->extcon_state = state;
 
+unlock:
 	mutex_unlock(&it6505->extcon_lock);
 }
 
@@ -3032,8 +3044,10 @@ static __maybe_unused int it6505_bridge_suspend(struct device *dev)
 	return it6505_poweroff(it6505);
 }
 
-static SIMPLE_DEV_PM_OPS(it6505_bridge_pm_ops, it6505_bridge_suspend,
-			 it6505_bridge_resume);
+static const struct dev_pm_ops it6505_bridge_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(it6505_bridge_suspend, it6505_bridge_resume, NULL)
+};
 
 static int it6505_init_pdata(struct it6505 *it6505)
 {
@@ -3315,6 +3329,7 @@ static int it6505_i2c_probe(struct i2c_client *client,
 
 	DRM_DEV_DEBUG_DRIVER(dev, "it6505 device name: %s", dev_name(dev));
 	debugfs_init(it6505);
+	pm_runtime_enable(dev);
 
 	it6505->bridge.funcs = &it6505_bridge_funcs;
 	it6505->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

