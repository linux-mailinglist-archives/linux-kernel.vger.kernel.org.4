Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338C570E596
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238432AbjEWTcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238405AbjEWTb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:31:59 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C0FE45
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:31:31 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2533b600d35so81836a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684870285; x=1687462285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=op3rjFIJK/G9SNN79lGhiUqi1w2mTlKVdZk1BckkQF0=;
        b=iZIs4UHnjY3vorngte3ZhnAZ8Wacu4ZILkY03JYuq9YY0p1IKzrhkIN7lcochBBA/K
         mzhnGtgfxNEFLTi5Io1SgJWb8B1k4S87J5t76ciW0EqGdX0A+ntuKA6l2vA0LOoIdFYI
         vLGsrgX/SzpeveZsaAqsAUY983U8YLapwwfsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684870285; x=1687462285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=op3rjFIJK/G9SNN79lGhiUqi1w2mTlKVdZk1BckkQF0=;
        b=eEowPFGRYhPEEa75WCtnRkRUWTWXOMMxpjmBaPPqlMCJoWqJnRgp0mD4YM5ohSjtBs
         93CDUWfk2t6eOXm3RywR73pIQmqpfYyoL7VL+VP2jb0D99WZztZEfZIomSzI6zReDuX2
         MLh0r6BdxEQ59IykA0wb1IbVsWgVehBXxXUF6i0KT0rp18Obza7x9pWr8KFPOZ9amdXo
         KUO41SIgwAPxmryD48ULm6j+/dTzsJG9dTkspgnr2w9OWBdxc10Ld2MwQ4XfB4A6Qrzr
         1Nd6zN5Ee/XmV8CjEY2u/EpN+LxUjZKadekrJzltubeD6/AeR2wwxvPb4C3+sKeCgYrh
         jxMA==
X-Gm-Message-State: AC+VfDxqwLfW5+n7yFDNmmVEgxRgH3o1sSPQC1SfMH6B9D+PzgnCxrHr
        /e5SznRkUdDkJbEV/KWZ9ooH2Q==
X-Google-Smtp-Source: ACHHUZ59R/VZKaFBBuQCIrfYdSblmP+QUBFpk+quHC1m5oJIuUo32z8/y3nkQfaFsLE5wZiywnekqg==
X-Received: by 2002:a17:90b:46d1:b0:247:529f:92d7 with SMTP id jx17-20020a17090b46d100b00247529f92d7mr15761298pjb.8.1684870285561;
        Tue, 23 May 2023 12:31:25 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:af98:af9d:ed15:f8b3])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902b49200b001aaef9d0102sm7109947plr.197.2023.05.23.12.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 12:31:24 -0700 (PDT)
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
Subject: [PATCH 7/9] HID: i2c-hid: Support being a panel follower
Date:   Tue, 23 May 2023 12:28:01 -0700
Message-ID: <20230523122802.7.Ib1a98309c455cd7e26b931c69993d4fba33bbe15@changeid>
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

As talked about in the patch ("drm/panel: Add a way for other devices
to follow panel state"), we really want to keep the power states of a
touchscreen and the panel it's attached to in sync with each other. In
that spirit, add support to i2c-hid to be a panel follower. This will
let the i2c-hid driver get informed when the panel is powered on and
off. From there we can match the i2c-hid device's power state to that
of the panel.

NOTE: this patch specifically _doesn't_ use pm_runtime to keep track
of / manage the power state of the i2c-hid device, even though my
first instinct said that would be the way to go. Specific problems
with using pm_runtime():
* The initial power up couldn't happen in a runtime resume function
  since it create sub-devices and, apparently, that's not good to do
  in your resume function.
* Managing our power state with pm_runtime meant fighting to make the
  right thing happen at system suspend to prevent the system from
  trying to resume us only to suspend us again. While this might be
  able to be solved, it added complexity.
Overall the code without pm_runtime() ended up being smaller and
easier to understand.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/hid/i2c-hid/i2c-hid-core.c | 82 +++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 34c0d98b4976..f1bb89377e8d 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -38,6 +38,8 @@
 #include <linux/mutex.h>
 #include <asm/unaligned.h>
 
+#include <drm/drm_panel.h>
+
 #include "../hid-ids.h"
 #include "i2c-hid.h"
 
@@ -107,6 +109,8 @@ struct i2c_hid {
 	struct mutex		reset_lock;
 
 	struct i2chid_ops	*ops;
+	struct drm_panel_follower panel_follower;
+	bool			is_panel_follower;
 };
 
 static const struct i2c_hid_quirks {
@@ -1058,6 +1062,34 @@ int i2c_hid_core_initial_power_up(struct i2c_hid *ihid)
 	return ret;
 }
 
+int i2c_hid_core_panel_prepared(struct drm_panel_follower *follower)
+{
+	struct i2c_hid *ihid = container_of(follower, struct i2c_hid, panel_follower);
+	struct hid_device *hid = ihid->hid;
+
+	/*
+	 * hid->version is set on the first power up. If it's still zero then
+	 * this is the first power on so we should perform initial power up
+	 * steps.
+	 */
+	if (!hid->version)
+		return i2c_hid_core_initial_power_up(ihid);
+
+	return i2c_hid_core_resume(ihid);
+}
+
+int i2c_hid_core_panel_unpreparing(struct drm_panel_follower *follower)
+{
+	struct i2c_hid *ihid = container_of(follower, struct i2c_hid, panel_follower);
+
+	return i2c_hid_core_suspend(ihid);
+}
+
+static const struct drm_panel_follower_funcs i2c_hid_core_panel_follower_funcs = {
+	.panel_prepared = i2c_hid_core_panel_prepared,
+	.panel_unpreparing = i2c_hid_core_panel_unpreparing,
+};
+
 int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
 		       u16 hid_descriptor_address, u32 quirks)
 {
@@ -1119,6 +1151,41 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
 	hid->bus = BUS_I2C;
 	hid->initial_quirks = quirks;
 
+	/*
+	 * See if we're following a panel. If drm_panel_add_follower()
+	 * returns no error then we are.
+	 */
+	ihid->panel_follower.funcs = &i2c_hid_core_panel_follower_funcs;
+	ret = drm_panel_add_follower(&client->dev, &ihid->panel_follower);
+	if (!ret) {
+		/* We're a follower. That means we'll power things up later. */
+		ihid->is_panel_follower = true;
+
+		/*
+		 * If we're not in control of our own power up/power down then
+		 * we can't do the logic to manage wakeups. Give a warning if
+		 * a user thought that was possible then force the capability
+		 * off.
+		 */
+		if (device_can_wakeup(&client->dev)) {
+			dev_warn(&client->dev, "Can't wakeup if following panel\n");
+			device_set_wakeup_capable(&client->dev, false);
+		}
+
+		return 0;
+	}
+
+	/*
+	 * -ENODEV means that we're not following a panel, so any other error
+	 * is a real problem (like -EPROBE_DEFER, -ENOMEM, ...).
+	 */
+	if (ret != -ENODEV)
+		goto err_mem_free;
+
+	/*
+	 * We're not following a panel. That's fine and means that we
+	 * can power up right away.
+	 */
 	ret = i2c_hid_core_initial_power_up(ihid);
 	if (ret)
 		goto err_mem_free;
@@ -1143,7 +1210,14 @@ void i2c_hid_core_remove(struct i2c_client *client)
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 	struct hid_device *hid;
 
-	i2c_hid_core_power_down(ihid);
+	/*
+	 * If we're a follower, the act of unfollowing will cause us to be
+	 * powered down. Otherwise we need to manually do it.
+	 */
+	if (ihid->is_panel_follower)
+		drm_panel_remove_follower(&ihid->panel_follower);
+	else
+		i2c_hid_core_power_down(ihid);
 
 	hid = ihid->hid;
 	hid_destroy_device(hid);
@@ -1171,6 +1245,9 @@ static int i2c_hid_core_pm_suspend(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 
+	if (ihid->is_panel_follower)
+		return 0;
+
 	return i2c_hid_core_suspend(ihid);
 }
 
@@ -1179,6 +1256,9 @@ static int i2c_hid_core_pm_resume(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct i2c_hid *ihid = i2c_get_clientdata(client);
 
+	if (ihid->is_panel_follower)
+		return 0;
+
 	return i2c_hid_core_resume(ihid);
 }
 
-- 
2.40.1.698.g37aff9b760-goog

