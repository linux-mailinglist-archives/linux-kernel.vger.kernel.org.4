Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D7568E738
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 05:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjBHEoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 23:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjBHEod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 23:44:33 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13F31ADE2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 20:44:24 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w7so604287pfu.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 20:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asus-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJ7yIiNmxy2KVInIF+Vk3HIxzGj3yaMUNFlUJEi5vOo=;
        b=e/V0Go6Ui5JzuqZ41s94m6vD4AUjhbNQt221LoVAtFnlWQG4GpsHd1Gp+jT9TafAQO
         DjO4/qKLVBkwMmT7413q3nWQ6saRUhuHvKmDKKaJXj2dRRz0PSM+VJ+wG5ReEzP5EBFJ
         thmdqOIATe3WFocqGMo5FUwcVPxgDO0lXvvNsOtkU9lDvDhRzx10NHoW9P3M4C5+mEca
         tuuY0k8rUy5ezM3W1aFPjO8ee9ruRkvLkcbuBVA3zeL8c3rXyrjFaRGpP4EkrETD+uRR
         rRDdvyqSsH5TFUulmeOzzhmXz7LIyp8/QxCGiebhar6bV4Gx71JU4rD7npzSil5Wm006
         vQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJ7yIiNmxy2KVInIF+Vk3HIxzGj3yaMUNFlUJEi5vOo=;
        b=HvGWyH8PQZYJXcF9kCjbnauWHKIu7xAUVfOaSF8bMDz/E47LrZk8Y2qzfchFP8G4BO
         lDnLF+8a3BLpvq60wHUfCI6W4lDYQWl/Yzmakf9jw1z93EwSK/57puRBx8PaJzVzpQEK
         NLnagHJuKDza270/aE7MgtFZK5nPzVzkukaTLZ2BfAX5VziWbkixk48sdElzhIxQaIQ2
         Rpbn68o+h9ukDuEr4fIjo4J2y1gLBV1mNnSTMGNyJG/O2fOlCol/BpSZTyGFTkSPUfrB
         fGqKpGkFxRO9ZxVIsh0iF1Il/Dj4t8bUQvsc0FY1EWF+n40+fKmq6jeNLhhYkyxntmEX
         MudA==
X-Gm-Message-State: AO0yUKX+qUACDLtvdDhNcLli1wqk2edyiyE94ZPWt8Kdrj9+X47ueNd7
        2GtPRoY4zkUZRKaVhu52fcPC6Q==
X-Google-Smtp-Source: AK7set+25XveFeJPmWK20Z1eYLgFDVPE5ZOqAOgucJmOUwYXpqmTY6XfHyTZaN97R8Ae0nnXJUqWgA==
X-Received: by 2002:aa7:983d:0:b0:593:cdc7:5dd3 with SMTP id q29-20020aa7983d000000b00593cdc75dd3mr5478121pfl.4.1675831464382;
        Tue, 07 Feb 2023 20:44:24 -0800 (PST)
Received: from ken-ASUS-EXPERTBOOK-B1500CBA-B1500CBA.. (61-216-65-192.hinet-ip.hinet.net. [61.216.65.192])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7850e000000b005a81885f342sm637156pfn.21.2023.02.07.20.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 20:44:24 -0800 (PST)
From:   Kencp huang <kencp_huang@asus.corp-partner.google.com>
To:     kencp_huang@asus.corp-partner.google.com
Cc:     Laurent.pinchart@ideasonboard.com, andrzej.hajda@intel.com,
        airlied@gmail.com, neil.armstrong@linaro.org,
        briannorris@chromium.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, hoegsberg@chromium.org,
        jernej.skrabec@gmail.com, jonas@kwiboo.se, kencp_huang@asus.com,
        linux-kernel@vger.kernel.org, rfoss@kernel.org,
        seanpaul@chromium.org, wzz@rock-chips.com, zyw@rock-chips.com
Subject: [PATCH 1/1] drm/bridge: analogix_dp: add a quirk for Bob panel
Date:   Wed,  8 Feb 2023 12:44:06 +0800
Message-Id: <20230208044406.8280-1-kencp_huang@asus.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230208031519.7440-1-kencp_huang@asus.corp-partner.google.com>
References: <20230208031519.7440-1-kencp_huang@asus.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zain wang <wzz@rock-chips.com>

Some panels' DP_PSR_STATUS (DPCD 0x2008) may be unstable when we
enable psr. If we get the unexpected psr state, We need try the
debounce to ensure the panel was in PSR

Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Chris Zhong <zyw@rock-chips.com>
Commit-Ready: Kristian H. Kristensen <hoegsberg@chromium.org>
Tested-by: Kristian H. Kristensen <hoegsberg@chromium.org>
Reviewed-by: Kristian H. Kristensen <hoegsberg@chromium.org>
Tested-by: Kencp huang <kencp_huang@asus.corp-partner.google.com>
Signed-off-by: Kencp huang <kencp_huang@asus.corp-partner.google.com>
---
 .../gpu/drm/bridge/analogix/analogix_dp_reg.c | 71 +++++++++++--------
 1 file changed, 42 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index 6a4f20fccf84..7b6e3f8f85b0 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -935,25 +935,54 @@ void analogix_dp_enable_psr_crc(struct analogix_dp_device *dp)
 	writel(PSR_VID_CRC_ENABLE, dp->reg_base + ANALOGIX_DP_CRC_CON);
 }
 
-static ssize_t analogix_dp_get_psr_status(struct analogix_dp_device *dp)
+static int analogix_dp_get_psr_status(struct analogix_dp_device *dp,
+				      int status)
 {
 	ssize_t val;
-	u8 status;
+	u8 reg, store = 0;
+	int cnt = 0;
+
+	/* About 3ms for a loop */
+	while (cnt < 100) {
+		/* Read operation would takes 900us */
+		val = drm_dp_dpcd_readb(&dp->aux, DP_PSR_STATUS, &reg);
+		if (val < 0) {
+			dev_err(dp->dev, "PSR_STATUS read failed ret=%zd", val);
+			return val;
+		}
+
+		/*
+		 * Ensure the PSR_STATE should go to DP_PSR_SINK_ACTIVE_RFB
+		 * from DP_PSR_SINK_ACTIVE_SINK_SYNCED or
+		 * DP_PSR_SINK_ACTIVE_SRC_SYNCED.
+		 * Otherwise, if we get DP_PSR_SINK_ACTIVE_RFB twice in
+		 * succession, it show the Panel is stable PSR enabled state.
+		 */
+		if (status == DP_PSR_SINK_ACTIVE_RFB) {
+			if ((reg == DP_PSR_SINK_ACTIVE_RFB) &&
+			    ((store == DP_PSR_SINK_ACTIVE_SINK_SYNCED) ||
+			     (store == DP_PSR_SINK_ACTIVE_SRC_SYNCED) ||
+			     (store == DP_PSR_SINK_ACTIVE_RFB)))
+				return 0;
+			else
+				store = reg;
+		} else {
+			if ((reg == DP_PSR_SINK_INACTIVE) ||
+			    (reg == DP_PSR_SINK_ACTIVE_RESYNC))
+				return 0;
+		}
 
-	val = drm_dp_dpcd_readb(&dp->aux, DP_PSR_STATUS, &status);
-	if (val < 0) {
-		dev_err(dp->dev, "PSR_STATUS read failed ret=%zd", val);
-		return val;
+		usleep_range(2100, 2200);
+		cnt++;
 	}
-	return status;
+
+	return -ETIMEDOUT;
 }
 
 int analogix_dp_send_psr_spd(struct analogix_dp_device *dp,
 			     struct dp_sdp *vsc, bool blocking)
 {
 	unsigned int val;
-	int ret;
-	ssize_t psr_status;
 
 	/* don't send info frame */
 	val = readl(dp->reg_base + ANALOGIX_DP_PKT_SEND_CTL);
@@ -998,26 +1027,10 @@ int analogix_dp_send_psr_spd(struct analogix_dp_device *dp,
 	if (!blocking)
 		return 0;
 
-	/*
-	 * db[1]!=0: entering PSR, wait for fully active remote frame buffer.
-	 * db[1]==0: exiting PSR, wait for either
-	 *  (a) ACTIVE_RESYNC - the sink "must display the
-	 *      incoming active frames from the Source device with no visible
-	 *      glitches and/or artifacts", even though timings may still be
-	 *      re-synchronizing; or
-	 *  (b) INACTIVE - the transition is fully complete.
-	 */
-	ret = readx_poll_timeout(analogix_dp_get_psr_status, dp, psr_status,
-		psr_status >= 0 &&
-		((vsc->db[1] && psr_status == DP_PSR_SINK_ACTIVE_RFB) ||
-		(!vsc->db[1] && (psr_status == DP_PSR_SINK_ACTIVE_RESYNC ||
-				 psr_status == DP_PSR_SINK_INACTIVE))),
-		1500, DP_TIMEOUT_PSR_LOOP_MS * 1000);
-	if (ret) {
-		dev_warn(dp->dev, "Failed to apply PSR %d\n", ret);
-		return ret;
-	}
-	return 0;
+	if (vsc->db[1])
+		return analogix_dp_get_psr_status(dp, DP_PSR_SINK_ACTIVE_RFB);
+	else
+		return analogix_dp_get_psr_status(dp, 0);
 }
 
 ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
-- 
2.34.1

