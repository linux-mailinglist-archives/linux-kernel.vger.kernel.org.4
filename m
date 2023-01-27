Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC81E67DB11
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 02:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjA0BJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 20:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjA0BJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 20:09:34 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D7A50840
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 17:09:32 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id m7-20020a17090a71c700b0022c0c070f2eso6406470pjs.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 17:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uORFmtwf+WIQa4zOQDY675hMQt16yP5oZ3IJbiKasy0=;
        b=cy4ezLsgrRklfSsdqOdGdWX5lEWLqYyxBbiuayCxSoCVZxvsNERAEbRDC6sIO8N0SP
         5t8NR2mH7YDnmFBcLlXAnK3ACyXGW+i4Xbh4FpIIkeZf4UoWg0RjnTxyciPChZrzfO2i
         rm3+Ik9KgiFSAolP2dlfyisJFU/KEPyCQcD+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uORFmtwf+WIQa4zOQDY675hMQt16yP5oZ3IJbiKasy0=;
        b=mk2BPOw70Od8B6CFpyhMDAARsXqWQf/fEXFgt+E19bks+ZGNbRtqbd2ZMIEsg/hFp5
         OHtO1jk7+sv3Kdv6uEJdYwuCH+hVe0O9ihyz/eHOmtC22aUpCQ+uhI9nX0eVrsri7Nr3
         RKIgiKc0bi2lm/s1L8tgrUWIVi3YTck2zk1qOJ1gfS8fu0NHEZRobA0Y3pS6dGuvPhFm
         W0Cf6RHops4lPrgn06/qfPfe3kze4DxLj3Bj2Q1TPyASjb+lFh/OXrVjeYu7h3wUokuE
         3lNtrcXaNDIMgR14LPUm9e7xKi//2fyBW+6RzZZj2WyQn2lhO+pCzU5i19zKpK+dDs6Q
         6rqw==
X-Gm-Message-State: AO0yUKXdRowyVw6yKfNq9mTYHdj3mGX0u78KMMCJe/TgBRi84orhDnqZ
        N+fyV0rd0x+e6Dcb0KPyECduQg==
X-Google-Smtp-Source: AK7set8kBA9xN88GbvXCLUMiaJzbtATe4aJ6bx8xM9K5BXIVMOQOziSXvCSOt+tC3QvT5JHScBunow==
X-Received: by 2002:a17:90b:3806:b0:22c:3052:47dd with SMTP id mq6-20020a17090b380600b0022c305247ddmr3446534pjb.17.1674781772234;
        Thu, 26 Jan 2023 17:09:32 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:d3b5:7433:dc03:ca1f])
        by smtp.gmail.com with ESMTPSA id s10-20020a17090a760a00b0022bbbba9801sm3843981pjk.37.2023.01.26.17.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 17:09:31 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] drm/msm/dp: Clean up handling of DP AUX interrupts
Date:   Thu, 26 Jan 2023 17:09:12 -0800
Message-Id: <20230126170745.v2.1.I90ffed3ddd21e818ae534f820cb4d6d8638859ab@changeid>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DP AUX interrupt handling was a bit of a mess.
* There were two functions (one for "native" transfers and one for
  "i2c" transfers) that were quite similar. It was hard to say how
  many of the differences between the two functions were on purpose
  and how many of them were just an accident of how they were coded.
* Each function sometimes used "else if" to test for error bits and
  sometimes didn't and again it was hard to say if this was on purpose
  or just an accident.
* The two functions wouldn't notice whether "unknown" bits were
  set. For instance, there seems to be a bit "DP_INTR_PLL_UNLOCKED"
  and if it was set there would be no indication.
* The two functions wouldn't notice if more than one error was set.

Let's fix this by being more consistent / explicit about what we're
doing.

By design this could cause different handling for AUX transfers,
though I'm not actually aware of any bug fixed as a result of
this patch (this patch was created because we simply noticed how odd
the old code was by code inspection). Specific notes here:
1. In the old native transfer case if we got "done + wrong address"
   we'd ignore the "wrong address" (because of the "else if"). Now we
   won't.
2. In the old native transfer case if we got "done + timeout" we'd
   ignore the "timeout" (because of the "else if"). Now we won't.
3. In the old native transfer case we'd see "nack_defer" and translate
   it to the error number for "nack". This differed from the i2c
   transfer case where "nack_defer" was given the error number for
   "nack_defer". This 100% can't matter because the only user of this
   error number treats "nack defer" the same as "nack", so it's clear
   that the difference between the "native" and "i2c" was pointless
   here.
4. In the old i2c transfer case if we got "done" plus any error
   besides "nack" or "defer" then we'd ignore the error. Now we don't.
5. If there is more than one error signaled by the hardware it's
   possible that we'll report a different one than we used to. I don't
   know if this matters. If someone is aware of a case this matters we
   should document it and change the code to make it explicit.
6. One quirk we keep (I don't know if this is important) is that in
   the i2c transfer case if we see "done + defer" we report that as a
   "nack". That seemed too intentional in the old code to just drop.

After this change we will add extra logging, including:
* A warning if we see more than one error bit set.
* A warning if we see an unexpected interrupt.
* A warning if we get an AUX transfer interrupt when shouldn't.

It actually turns out that as a result of this change then at boot we
sometimes see an error:
  [drm:dp_aux_isr] *ERROR* Unexpected DP AUX IRQ 0x01000000 when not busy
That means that, during init, we are seeing DP_INTR_PLL_UNLOCKED. For
now I'm going to say that leaving this error reported in the logs is
OK-ish and hopefully it will encourage someone to track down what's
going on at init time.

One last note here is that this change renames one of the interrupt
bits. The bit named "i2c done" clearly was used for native transfers
being done too, so I renamed it to indicate this.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I don't have good test coverage for this change and it does have the
potential to change behavior. I confirmed that eDP and DP still
continue to work OK on one machine. Hopefully folks can test it more.

Changes in v2:
- Moved DP_INTR_AUX_XFER_DONE to the end of the if else chain.

 drivers/gpu/drm/msm/dp/dp_aux.c     | 80 ++++++++++++-----------------
 drivers/gpu/drm/msm/dp/dp_catalog.c |  2 +-
 drivers/gpu/drm/msm/dp/dp_catalog.h |  2 +-
 3 files changed, 36 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
index cc3efed593aa..84f9e3e5f964 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.c
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c
@@ -162,47 +162,6 @@ static ssize_t dp_aux_cmd_fifo_rx(struct dp_aux_private *aux,
 	return i;
 }
 
-static void dp_aux_native_handler(struct dp_aux_private *aux, u32 isr)
-{
-	if (isr & DP_INTR_AUX_I2C_DONE)
-		aux->aux_error_num = DP_AUX_ERR_NONE;
-	else if (isr & DP_INTR_WRONG_ADDR)
-		aux->aux_error_num = DP_AUX_ERR_ADDR;
-	else if (isr & DP_INTR_TIMEOUT)
-		aux->aux_error_num = DP_AUX_ERR_TOUT;
-	if (isr & DP_INTR_NACK_DEFER)
-		aux->aux_error_num = DP_AUX_ERR_NACK;
-	if (isr & DP_INTR_AUX_ERROR) {
-		aux->aux_error_num = DP_AUX_ERR_PHY;
-		dp_catalog_aux_clear_hw_interrupts(aux->catalog);
-	}
-}
-
-static void dp_aux_i2c_handler(struct dp_aux_private *aux, u32 isr)
-{
-	if (isr & DP_INTR_AUX_I2C_DONE) {
-		if (isr & (DP_INTR_I2C_NACK | DP_INTR_I2C_DEFER))
-			aux->aux_error_num = DP_AUX_ERR_NACK;
-		else
-			aux->aux_error_num = DP_AUX_ERR_NONE;
-	} else {
-		if (isr & DP_INTR_WRONG_ADDR)
-			aux->aux_error_num = DP_AUX_ERR_ADDR;
-		else if (isr & DP_INTR_TIMEOUT)
-			aux->aux_error_num = DP_AUX_ERR_TOUT;
-		if (isr & DP_INTR_NACK_DEFER)
-			aux->aux_error_num = DP_AUX_ERR_NACK_DEFER;
-		if (isr & DP_INTR_I2C_NACK)
-			aux->aux_error_num = DP_AUX_ERR_NACK;
-		if (isr & DP_INTR_I2C_DEFER)
-			aux->aux_error_num = DP_AUX_ERR_DEFER;
-		if (isr & DP_INTR_AUX_ERROR) {
-			aux->aux_error_num = DP_AUX_ERR_PHY;
-			dp_catalog_aux_clear_hw_interrupts(aux->catalog);
-		}
-	}
-}
-
 static void dp_aux_update_offset_and_segment(struct dp_aux_private *aux,
 					     struct drm_dp_aux_msg *input_msg)
 {
@@ -427,13 +386,42 @@ void dp_aux_isr(struct drm_dp_aux *dp_aux)
 	if (!isr)
 		return;
 
-	if (!aux->cmd_busy)
+	if (!aux->cmd_busy) {
+		DRM_ERROR("Unexpected DP AUX IRQ %#010x when not busy\n", isr);
 		return;
+	}
 
-	if (aux->native)
-		dp_aux_native_handler(aux, isr);
-	else
-		dp_aux_i2c_handler(aux, isr);
+	/*
+	 * The logic below assumes only one error bit is set (other than "done"
+	 * which can apparently be set at the same time as some of the other
+	 * bits). Warn if more than one get set so we know we need to improve
+	 * the logic.
+	 */
+	if (hweight32(isr & ~DP_INTR_AUX_XFER_DONE) > 1)
+		DRM_WARN("Some DP AUX interrupts unhandled: %#010x\n", isr);
+
+	if (isr & DP_INTR_AUX_ERROR) {
+		aux->aux_error_num = DP_AUX_ERR_PHY;
+		dp_catalog_aux_clear_hw_interrupts(aux->catalog);
+	} else if (isr & DP_INTR_NACK_DEFER) {
+		aux->aux_error_num = DP_AUX_ERR_NACK_DEFER;
+	} else if (isr & DP_INTR_WRONG_ADDR) {
+		aux->aux_error_num = DP_AUX_ERR_ADDR;
+	} else if (isr & DP_INTR_TIMEOUT) {
+		aux->aux_error_num = DP_AUX_ERR_TOUT;
+	} else if (!aux->native && (isr & DP_INTR_I2C_NACK)) {
+		aux->aux_error_num = DP_AUX_ERR_NACK;
+	} else if (!aux->native && (isr & DP_INTR_I2C_DEFER)) {
+		if (isr & DP_INTR_AUX_XFER_DONE)
+			aux->aux_error_num = DP_AUX_ERR_NACK;
+		else
+			aux->aux_error_num = DP_AUX_ERR_DEFER;
+	} else if (isr & DP_INTR_AUX_XFER_DONE) {
+		aux->aux_error_num = DP_AUX_ERR_NONE;
+	} else {
+		DRM_WARN("Unexpected interrupt: %#010x\n", isr);
+		return;
+	}
 
 	complete(&aux->comp);
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index 676279d0ca8d..421391755427 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -27,7 +27,7 @@
 #define DP_INTF_CONFIG_DATABUS_WIDEN     BIT(4)
 
 #define DP_INTERRUPT_STATUS1 \
-	(DP_INTR_AUX_I2C_DONE| \
+	(DP_INTR_AUX_XFER_DONE| \
 	DP_INTR_WRONG_ADDR | DP_INTR_TIMEOUT | \
 	DP_INTR_NACK_DEFER | DP_INTR_WRONG_DATA_CNT | \
 	DP_INTR_I2C_NACK | DP_INTR_I2C_DEFER | \
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
index 1f717f45c115..f36b7b372a06 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.h
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
@@ -13,7 +13,7 @@
 
 /* interrupts */
 #define DP_INTR_HPD		BIT(0)
-#define DP_INTR_AUX_I2C_DONE	BIT(3)
+#define DP_INTR_AUX_XFER_DONE	BIT(3)
 #define DP_INTR_WRONG_ADDR	BIT(6)
 #define DP_INTR_TIMEOUT		BIT(9)
 #define DP_INTR_NACK_DEFER	BIT(12)
-- 
2.39.1.456.gfc5497dd1b-goog

