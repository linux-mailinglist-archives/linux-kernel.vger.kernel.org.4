Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759F85FD80E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 13:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJMLEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 07:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJMLEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 07:04:33 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B687710CFB9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 04:04:31 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so1622053pjl.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 04:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yF0qS9tpjnO5hKItBT5kTiggjtXt00AKvk0lGYLixs=;
        b=lBd+WLazCAhdHwvY2Ydhae9hCVMbvMx0M3hb3hy0vujF2bvWl0gPMyEqZGHGXh6OVj
         sUYmtigt3bUR5i8ZVQ/KOl9sCb04tIaF2JW0rkmxBPvMGSHvtV2TTinTDMwaqiOky0cf
         +FVbSuyM3Ll7gEXcjrLD37S0ElVORRerxb+R8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yF0qS9tpjnO5hKItBT5kTiggjtXt00AKvk0lGYLixs=;
        b=fSr8f22TxnGgiZBbprOvGqXIgqhFZ55VedIlfLz/jlK5frIwVH5DqFkc4q5qxVy+OJ
         rvHeuIuq+z9B3LKzrMwHYlFqOtnl5f7sjPa2kj8thYCIIS3QV7xIHAou1KsJ7rjdSVmV
         NmyWx7qAMxyKr8c1NxUM84z7TV73mI18g+kjn4o3VJ3NcAfoSha3WAZZuobCqLRiy/IM
         H2FG2VFrtOvlHO9XsqKqwcNhvzRuL3LDtgpsaneQZqnGWycCMe/wueWbPuhj6+x1K8z0
         oiNJ7WZ40d/vqEbAOPGxZxq/1Mx2Dygbx+aVGnWwFOZjRsdwDiy/Ntscmn8xy1ZHpxsl
         HsFg==
X-Gm-Message-State: ACrzQf0UUwSRge+PK+pKdiD5oJTVa3woOsAyR0RWoDBxT4YELJ3GMHQD
        nctrX7Ht9zMqZEwisHiGsUYn4nPdlvdIoQ==
X-Google-Smtp-Source: AMsMyM5n8b4kdcavLxHUEz7UcQdZzikHP9Q/BHDphy9Lvrobv7/aRxwlsifSGGLCA2RYZPw8FkPXcQ==
X-Received: by 2002:a17:90b:4b8b:b0:20d:ac2f:8bb2 with SMTP id lr11-20020a17090b4b8b00b0020dac2f8bb2mr1353420pjb.194.1665659070952;
        Thu, 13 Oct 2022 04:04:30 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:4b90:18ed:8d41:7622])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090ab88b00b0020af2411721sm2914794pjr.34.2022.10.13.04.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 04:04:30 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Pin-yen Lin <treapking@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] drm/bridge: it6505: Improve synchronization between extcon subsystem
Date:   Thu, 13 Oct 2022 19:04:10 +0800
Message-Id: <20221013110411.1674359-4-treapking@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221013110411.1674359-1-treapking@chromium.org>
References: <20221013110411.1674359-1-treapking@chromium.org>
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

Originally, the it6505 relies on a short sleep in the IRQ handler and a
long sleep to make sure it6505->lane_swap and it6505->lane_count is
configured in it6505_extcon_work and it6505_detect, respectively.

Use completion and additional DPCD read to remove the unnecessary waits,
and use a different lock for it6505_extcon_work and the threaded IRQ
handler because they no longer need to run exclusively.

The wait time of the completion is usually less than 10ms in local
experiments, but leave it larger here just in case.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

Changes in v2:
- Add the empty line back

 drivers/gpu/drm/bridge/ite-it6505.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 4b6061272599..0de44c651c60 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -412,6 +412,7 @@ struct it6505 {
 	 * Mutex protects extcon and interrupt functions from interfering
 	 * each other.
 	 */
+	struct mutex irq_lock;
 	struct mutex extcon_lock;
 	struct mutex mode_lock; /* used to bridge_detect */
 	struct mutex aux_lock; /* used to aux data transfers */
@@ -440,7 +441,7 @@ struct it6505 {
 	enum hdcp_state hdcp_status;
 	struct delayed_work hdcp_work;
 	struct work_struct hdcp_wait_ksv_list;
-	struct completion wait_edid_complete;
+	struct completion extcon_completion;
 	u8 auto_train_retry;
 	bool hdcp_desired;
 	bool is_repeater;
@@ -2316,8 +2317,8 @@ static void it6505_irq_hpd(struct it6505 *it6505)
 			     it6505->hpd_state ? "high" : "low");
 
 	if (it6505->hpd_state) {
-		wait_for_completion_timeout(&it6505->wait_edid_complete,
-					    msecs_to_jiffies(6000));
+		wait_for_completion_timeout(&it6505->extcon_completion,
+					    msecs_to_jiffies(1000));
 		it6505_aux_on(it6505);
 		if (it6505->dpcd[0] == 0) {
 			it6505_get_dpcd(it6505, DP_DPCD_REV, it6505->dpcd,
@@ -2493,8 +2494,7 @@ static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
 	};
 	int int_status[3], i;
 
-	msleep(100);
-	mutex_lock(&it6505->extcon_lock);
+	mutex_lock(&it6505->irq_lock);
 
 	if (it6505->enable_drv_hold || !it6505->powered)
 		goto unlock;
@@ -2524,7 +2524,7 @@ static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
 	}
 
 unlock:
-	mutex_unlock(&it6505->extcon_lock);
+	mutex_unlock(&it6505->irq_lock);
 
 	return IRQ_HANDLED;
 }
@@ -2701,9 +2701,12 @@ static void it6505_extcon_work(struct work_struct *work)
 		 */
 		if (ret)
 			it6505_poweron(it6505);
+
+		complete_all(&it6505->extcon_completion);
 	} else {
 		DRM_DEV_DEBUG_DRIVER(dev, "start to power off");
 		pm_runtime_put_sync(dev);
+		reinit_completion(&it6505->extcon_completion);
 
 		drm_helper_hpd_irq_event(it6505->bridge.dev);
 		memset(it6505->dpcd, 0, sizeof(it6505->dpcd));
@@ -3274,6 +3277,7 @@ static int it6505_i2c_probe(struct i2c_client *client,
 	if (!it6505)
 		return -ENOMEM;
 
+	mutex_init(&it6505->irq_lock);
 	mutex_init(&it6505->extcon_lock);
 	mutex_init(&it6505->mode_lock);
 	mutex_init(&it6505->aux_lock);
@@ -3329,7 +3333,7 @@ static int it6505_i2c_probe(struct i2c_client *client,
 	INIT_WORK(&it6505->link_works, it6505_link_training_work);
 	INIT_WORK(&it6505->hdcp_wait_ksv_list, it6505_hdcp_wait_ksv_list);
 	INIT_DELAYED_WORK(&it6505->hdcp_work, it6505_hdcp_work);
-	init_completion(&it6505->wait_edid_complete);
+	init_completion(&it6505->extcon_completion);
 	memset(it6505->dpcd, 0, sizeof(it6505->dpcd));
 	it6505->powered = false;
 	it6505->enable_drv_hold = DEFAULT_DRV_HOLD;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

