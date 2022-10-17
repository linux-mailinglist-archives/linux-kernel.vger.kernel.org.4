Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16679601739
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiJQTTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiJQTTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:19:47 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F2013E36
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 12:19:40 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y8so11950456pfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 12:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gAApYXxRSlYHmUzAYpnouM31FqnGx/GLsXZXGjgii3c=;
        b=hU2Jw/WwCvDgac3p1KYfwXyW0I9wrOGHxfyUunyVwVUvMY+H6RNCXmhgMvqZQjL4fK
         u0Jvq3KPFU4uTC0j2s6K0s32cw9UHBjVn+MzbYL2ltlE3bgVfU4yq8uksIH+JHeJ1nwG
         dY72nDk62FiVziHRoZ9Gk45hfBkenTjm/UW9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAApYXxRSlYHmUzAYpnouM31FqnGx/GLsXZXGjgii3c=;
        b=Ccw1qKs7TyTTwvBgZZuLbSbEYpsbuakj7jmflK40IU3CoCUAqTbowI/QSJkY2qd0ZU
         T5jlfEykhZfDmiwWCLYleEW3NOYEe8lUZ/+RBGCTEoja/oy4jVSS+mOflWH0T3ZKm2bI
         P+9AvC3TpWfcqXGYgwCUCis8OIzfEdpU/yVY856KWFclRLNQXwsJCmNmwOtImeRlfxmW
         eSk8MJO848QAt6d5TNNByE3wwBMkQ2kMqinGK81SBRjWq7okqBR6so8NOj8YxssazThG
         hmOTLeLLnVfGXkCeAw+IwR7p0FZk43Kp1moPpWCvvmB5E1NOsQBa5m5rbSjQBbZlQ+S1
         vHgA==
X-Gm-Message-State: ACrzQf3T/OWgnMAxSA7neoHf1Wi6HipOiYKtr6VlWwpEV4dlpCDMRXdj
        sYEG4X0otOiAVV8m/WJpa4nh2w==
X-Google-Smtp-Source: AMsMyM4fFNt5FqXCKAqgfh46u9c+xfxYoLcVEQ/ABcHPcPS/0RHkfVQcB6lFFlZuIhQYjhu6w/itAg==
X-Received: by 2002:a65:5a0b:0:b0:46b:158e:ad7c with SMTP id y11-20020a655a0b000000b0046b158ead7cmr12196753pgs.272.1666034378945;
        Mon, 17 Oct 2022 12:19:38 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:5562:6ef6:c80b:1268])
        by smtp.gmail.com with ESMTPSA id y2-20020a170902864200b001754cfb5e21sm6980225plt.96.2022.10.17.12.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:19:38 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Rock Chiu <rock.chiu@paradetech.corp-partner.google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jason Yen <jason.yen@paradetech.corp-partner.google.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Philip Chen <philipchen@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: ps8640: Add back the 50 ms mystery delay after HPD
Date:   Mon, 17 Oct 2022 12:18:51 -0700
Message-Id: <20221017121813.1.I59700c745fbc31559a5d5c8e2a960279c751dbd5@changeid>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back in commit 826cff3f7ebb ("drm/bridge: parade-ps8640: Enable
runtime power management") we removed a mysterious 50 ms delay because
"Parade's support [couldn't] explain what the delay [was] for".

While I'm always a fan of removing mysterious delays, I suspect that
we need this mysterious delay to avoid some problems.

Specifically, what I found recently is that on sc7180-trogdor-homestar
sometimes the AUX backlight wasn't initializing properly. Some
debugging showed that the drm_dp_dpcd_read() function that the AUX
backlight driver was calling was returning bogus data about 1% of the
time when I booted up. This confused
drm_panel_dp_aux_backlight(). From continued debugging:
- If I retried the read then the read worked just fine.
- If I added a loop to perform the same read that
  drm_panel_dp_aux_backlight() was doing 30 times at bootup I could
  see that some percentage of the time the first read would give bogus
  data but all 29 additional reads would always be fine.
- If I added a large delay _after_ powering on the panel but before
  powering on PS8640 I could still reproduce the problem.
- If I added a delay after PS8640 powered on then I couldn't reproduce
  the problem.
- I couldn't reproduce the problem on a board with the same panel but
  the ti-sn65dsi86 bridge chip.

To me, the above indicated that there was a problem with PS8640 and
not the panel.

I don't really have any insight into what's going on in the MCU, but
my best guess is that when the MCU itself sees the HPD go high that it
does some AUX transfers itself and this is confusing things.

Let's go back and add back in the mysterious 50 ms delay. We only want
to do this the first time we see HPD go high after booting the MCU,
not every time we double-check HPD.

With this, the backlight initializes reliably on homestar.

Fixes: 826cff3f7ebb ("drm/bridge: parade-ps8640: Enable runtime power management")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/bridge/parade-ps8640.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index 5be6562c2a19..6a614e54b383 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -105,6 +105,7 @@ struct ps8640 {
 	struct gpio_desc *gpio_powerdown;
 	struct device_link *link;
 	bool pre_enabled;
+	bool need_post_hpd_delay;
 };
 
 static const struct regmap_config ps8640_regmap_config[] = {
@@ -173,14 +174,31 @@ static int _ps8640_wait_hpd_asserted(struct ps8640 *ps_bridge, unsigned long wai
 {
 	struct regmap *map = ps_bridge->regmap[PAGE2_TOP_CNTL];
 	int status;
+	int ret;
 
 	/*
 	 * Apparently something about the firmware in the chip signals that
 	 * HPD goes high by reporting GPIO9 as high (even though HPD isn't
 	 * actually connected to GPIO9).
 	 */
-	return regmap_read_poll_timeout(map, PAGE2_GPIO_H, status,
-					status & PS_GPIO9, wait_us / 10, wait_us);
+	ret = regmap_read_poll_timeout(map, PAGE2_GPIO_H, status,
+				       status & PS_GPIO9, wait_us / 10, wait_us);
+
+	/*
+	 * The first time we see HPD go high after a reset we delay an extra
+	 * 50 ms. The best guess is that the MCU is doing "stuff" during this
+	 * time (maybe talking to the panel) and we don't want to interrupt it.
+	 *
+	 * No locking is done around "need_post_hpd_delay". If we're here we
+	 * know we're holding a PM Runtime reference and the only other place
+	 * that touches this is PM Runtime resume.
+	 */
+	if (!ret && ps_bridge->need_post_hpd_delay) {
+		ps_bridge->need_post_hpd_delay = false;
+		msleep(50);
+	}
+
+	return ret;
 }
 
 static int ps8640_wait_hpd_asserted(struct drm_dp_aux *aux, unsigned long wait_us)
@@ -388,6 +406,9 @@ static int __maybe_unused ps8640_resume(struct device *dev)
 	msleep(50);
 	gpiod_set_value(ps_bridge->gpio_reset, 0);
 
+	/* We just reset things, so we need a delay after the first HPD */
+	ps_bridge->need_post_hpd_delay = true;
+
 	/*
 	 * Mystery 200 ms delay for the "MCU to be ready". It's unclear if
 	 * this is truly necessary since the MCU will already signal that
-- 
2.38.0.413.g74048e4d9e-goog

