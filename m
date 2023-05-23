Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B631A70E59B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238411AbjEWTcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238377AbjEWTb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:31:59 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C570EE4C
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:31:31 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ae3f6e5d70so380895ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684870288; x=1687462288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39PsOXs9zk855s8jQNy2CTlBaJON6A8TZDNhmmH/46Q=;
        b=GhI0C1TWak8+SbPb8fwi5YtahbPMUZ0q/xInXun3S9DYRbA5Ge3H9tdwPIREn6nwjE
         P0NSDWJJsCFsCfBimENA7d99Zzn2dZ0qOatCq9UiE4ucZ+9HBcsBrd0zPUL/yqHrtfyh
         UoSylkf8Zht+WYlD2AUIAy3mU3mfinXBoQVvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684870288; x=1687462288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39PsOXs9zk855s8jQNy2CTlBaJON6A8TZDNhmmH/46Q=;
        b=PC0dIPclsMOId0qqxlJy44b17Dk3MKWAd5GGPwqt3P2j2rDuObpEMD64W/sQRUJRBm
         j5JasjQ9NQjMVs19mwIiPWXmz3pGhx1U8Y23gmQ/KQYEhZULjyuxoxb/mWIZ7gGMVYR+
         wib99xCa9cDKaRkIsTqx/drtEQmfgYrwH2uFymvHHOU3LJ2ibfYm7/XiYNPAGBYBAlzf
         2nJSNrQVOd3GFRzOhAikeD9JbMEjhPFyD2WNZ15bR1BT6rg/Z0u71xB6l7Hf/xyV0mUq
         QjFXHv3FkCaQ8yxSR6kizBoW9Tw2qcQDvy+mr8ZDnh0gV/fWezr4ndxO1dSWBTZ6xL3x
         vbEQ==
X-Gm-Message-State: AC+VfDwtuKeLWQT+CHHqppgPont32+Fw34npa4TOtHaj8yA+RR7H/clr
        7uX1mT8qNzLqDrqBMsr8xbCgsw==
X-Google-Smtp-Source: ACHHUZ4fsf7entq/TqQHyVWqJq0weOB/V/hoJn2umvRJrVqBR2ysA/a7Oxt/kBOm+TCRkfQxrBtHdQ==
X-Received: by 2002:a17:902:ea08:b0:1af:cbb6:61ff with SMTP id s8-20020a170902ea0800b001afcbb661ffmr3900923plg.64.1684870287842;
        Tue, 23 May 2023 12:31:27 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:af98:af9d:ed15:f8b3])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902b49200b001aaef9d0102sm7109947plr.197.2023.05.23.12.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 12:31:27 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>, hsinyi@google.com,
        devicetree@vger.kernel.org,
        yangcong5@huaqin.corp-partner.google.com,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 8/9] HID: i2c-hid: Do panel follower work on the system_wq
Date:   Tue, 23 May 2023 12:28:02 -0700
Message-ID: <20230523122802.8.I962bb462ede779005341c49320740ed95810021d@changeid>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230523193017.4109557-1-dianders@chromium.org>
References: <20230523193017.4109557-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turning on an i2c-hid device can be a slow process. This is why
i2c-hid devices use PROBE_PREFER_ASYNCHRONOUS. Unfortunately, when
we're a panel follower the i2c-hid power up sequence now blocks the
power on of the panel. Let's fix that by scheduling the work on the
system_wq.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/hid/i2c-hid/i2c-hid-core.c | 42 +++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index f1bb89377e8d..800f0dc6f6cf 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -110,7 +110,9 @@ struct i2c_hid {
 
 	struct i2chid_ops	*ops;
 	struct drm_panel_follower panel_follower;
+	struct work_struct	panel_follower_prepare_work;
 	bool			is_panel_follower;
+	bool			prepare_work_finished;
 };
 
 static const struct i2c_hid_quirks {
@@ -1062,10 +1064,12 @@ int i2c_hid_core_initial_power_up(struct i2c_hid *ihid)
 	return ret;
 }
 
-int i2c_hid_core_panel_prepared(struct drm_panel_follower *follower)
+void ihid_core_panel_prepare_work(struct work_struct *work)
 {
-	struct i2c_hid *ihid = container_of(follower, struct i2c_hid, panel_follower);
+	struct i2c_hid *ihid = container_of(work, struct i2c_hid,
+					    panel_follower_prepare_work);
 	struct hid_device *hid = ihid->hid;
+	int ret;
 
 	/*
 	 * hid->version is set on the first power up. If it's still zero then
@@ -1073,15 +1077,44 @@ int i2c_hid_core_panel_prepared(struct drm_panel_follower *follower)
 	 * steps.
 	 */
 	if (!hid->version)
-		return i2c_hid_core_initial_power_up(ihid);
+		ret = i2c_hid_core_initial_power_up(ihid);
+	else
+		ret = i2c_hid_core_resume(ihid);
 
-	return i2c_hid_core_resume(ihid);
+	if (ret)
+		dev_warn(&ihid->client->dev, "Power on failed: %d\n", ret);
+	else
+		WRITE_ONCE(ihid->prepare_work_finished, true);
+
+	/* Match with i2c_hid_core_panel_unpreparing() */
+	smp_wmb();
+}
+
+int i2c_hid_core_panel_prepared(struct drm_panel_follower *follower)
+{
+	struct i2c_hid *ihid = container_of(follower, struct i2c_hid, panel_follower);
+
+	/*
+	 * Powering on a touchscreen can be a slow process. Queue the work to
+	 * the system workqueue so we don't block the panel's power up.
+	 */
+	WRITE_ONCE(ihid->prepare_work_finished, false);
+	schedule_work(&ihid->panel_follower_prepare_work);
+
+	return 0;
 }
 
 int i2c_hid_core_panel_unpreparing(struct drm_panel_follower *follower)
 {
 	struct i2c_hid *ihid = container_of(follower, struct i2c_hid, panel_follower);
 
+	cancel_work_sync(&ihid->panel_follower_prepare_work);
+
+	/* Match with ihid_core_panel_prepare_work() */
+	smp_rmb();
+	if (!READ_ONCE(ihid->prepare_work_finished))
+		return 0;
+
 	return i2c_hid_core_suspend(ihid);
 }
 
@@ -1124,6 +1157,7 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
 
 	init_waitqueue_head(&ihid->wait);
 	mutex_init(&ihid->reset_lock);
+	INIT_WORK(&ihid->panel_follower_prepare_work, ihid_core_panel_prepare_work);
 
 	/* we need to allocate the command buffer without knowing the maximum
 	 * size of the reports. Let's use HID_MIN_BUFFER_SIZE, then we do the
-- 
2.40.1.698.g37aff9b760-goog

