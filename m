Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95798622797
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiKIJwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiKIJwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:52:36 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D8C140A8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:52:35 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id v17so16627215plo.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 01:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YEXz8R79xCCKZ4gVi6aoWaOP0hM45EJ4HRkKfzYJXp4=;
        b=NvKJw3vSpw0gSIPYrmfre5lT1Ej0yLqmGwo9XHTV8Rak9f9TXnaRzZoOC86GOIaxzY
         /nTZp1KpZJpMypci4dNTl63IUjmo8rewgMsXklH6hQCxcRgQ3FUdvhnL9mG8i51T3Pn0
         jpYaEWMVgL9LJBZlAc1o8j6DWaVxp6u87INvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YEXz8R79xCCKZ4gVi6aoWaOP0hM45EJ4HRkKfzYJXp4=;
        b=zydPoP8Q1eRtsKbRz7b5bgZ/rYal/p/viP+jIB99xtIE4WYSfBTwHjP+Kl1p3xpMVO
         iRbLgFho58jsG8MTcIK5TFGM7/7Xa37zhwjI0uNkyF3j0mMIiGtd7GIybNl7xUZKBq2D
         eGi11IvosU15aB42YsBygLPEGMg0Dvrv6E59opKZlxYXVGYE1VsbqJARKFeH2nSJJIlq
         cRQtHoJF6WSptUx1qC3jS/zC90RYqS2PVdph6GWK6StZqr582UDha/XNfaYJkdUL9L/+
         jYMYvFnlGv7B/oPFfzeFLBR/mKPJYTFuOqAk4Xp0GpIcZFgvTePAV+CC88Pi3SNE37nj
         Q3uA==
X-Gm-Message-State: ACrzQf1kx0ceXn68yAQ7QYWsiw8POAK901DqU1AUZ9g2gTADBd+4yjcs
        7BMm0gGMsATqFI3sZ7HGZct290QGdOBhVw==
X-Google-Smtp-Source: AMsMyM6BTP/7DJCEJ/RVYkzPkgRF/C6XyYOT/qqSROs8Uxm/w+ujOHPLWPiwVW50amm8sRoZmMJc8A==
X-Received: by 2002:a17:90b:33c7:b0:214:1ddc:c6bd with SMTP id lk7-20020a17090b33c700b002141ddcc6bdmr43100808pjb.151.1667987555062;
        Wed, 09 Nov 2022 01:52:35 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:1a4f:384c:38ff:a6ae])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b00186e34524e3sm8561909plk.136.2022.11.09.01.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 01:52:34 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Pin-yen Lin <treapking@chromium.org>,
        allen chen <allen.chen@ite.com.tw>
Subject: [PATCH] drm/bridge: it6505: Guard bridge power in IRQ handler
Date:   Wed,  9 Nov 2022 17:52:27 +0800
Message-Id: <20221109095227.3320919-1-treapking@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
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

Add a pair of pm_runtime_get_if_in_use and pm_runtime_put_sync in the
interrupt handler to make sure the bridge won't be powered off during
the interrupt handlings. Also remove the irq_lock mutex because it's not
guarding anything now.

Fixes: ab28896f1a83 ("drm/bridge: it6505: Improve synchronization between extcon subsystem")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

 drivers/gpu/drm/bridge/ite-it6505.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 21a9b8422bda..e7f7d0ce1380 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -412,7 +412,6 @@ struct it6505 {
 	 * Mutex protects extcon and interrupt functions from interfering
 	 * each other.
 	 */
-	struct mutex irq_lock;
 	struct mutex extcon_lock;
 	struct mutex mode_lock; /* used to bridge_detect */
 	struct mutex aux_lock; /* used to aux data transfers */
@@ -2494,10 +2493,8 @@ static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
 	};
 	int int_status[3], i;
 
-	mutex_lock(&it6505->irq_lock);
-
-	if (it6505->enable_drv_hold || !it6505->powered)
-		goto unlock;
+	if (it6505->enable_drv_hold || pm_runtime_get_if_in_use(dev) <= 0)
+		return IRQ_HANDLED;
 
 	int_status[0] = it6505_read(it6505, INT_STATUS_01);
 	int_status[1] = it6505_read(it6505, INT_STATUS_02);
@@ -2515,16 +2512,14 @@ static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
 	if (it6505_test_bit(irq_vec[0].bit, (unsigned int *)int_status))
 		irq_vec[0].handler(it6505);
 
-	if (!it6505->hpd_state)
-		goto unlock;
-
-	for (i = 1; i < ARRAY_SIZE(irq_vec); i++) {
-		if (it6505_test_bit(irq_vec[i].bit, (unsigned int *)int_status))
-			irq_vec[i].handler(it6505);
+	if (it6505->hpd_state) {
+		for (i = 1; i < ARRAY_SIZE(irq_vec); i++) {
+			if (it6505_test_bit(irq_vec[i].bit, (unsigned int *)int_status))
+				irq_vec[i].handler(it6505);
+		}
 	}
 
-unlock:
-	mutex_unlock(&it6505->irq_lock);
+	pm_runtime_put_sync(dev);
 
 	return IRQ_HANDLED;
 }
@@ -3277,7 +3272,6 @@ static int it6505_i2c_probe(struct i2c_client *client,
 	if (!it6505)
 		return -ENOMEM;
 
-	mutex_init(&it6505->irq_lock);
 	mutex_init(&it6505->extcon_lock);
 	mutex_init(&it6505->mode_lock);
 	mutex_init(&it6505->aux_lock);
-- 
2.38.1.431.g37b22c650d-goog

