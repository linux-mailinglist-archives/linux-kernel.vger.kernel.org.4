Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52A36DB996
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 10:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjDHIUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 04:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDHIUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 04:20:39 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70523C148
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 01:20:38 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 4E41A403B9;
        Sat,  8 Apr 2023 13:20:22 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1680942024; bh=Y181UBUuQt0Yz6wrLdhP3fSIP/gjJyv15QxkjEagobQ=;
        h=From:To:Cc:Subject:Date:From;
        b=3vKEgYBGornwzWMelWt7EtctVaQhOrdarn9z1whe/u/khh7eTECg5YFqUmEcdP3gM
         Mp52s7Co+rpXFfU+/nsApePsmXMAVAK1wlriErVpMYeXdOf1STHQDdtmazfRpxFfg+
         /fd1KYDqR4YavhwXU6JyPNXcQ+KKVECUbj1LYzY2RK0+JUdwnVjasHGP6Q5tUk78bA
         nZkczZqyqtWtJVrpPFbs4AeEaiV9v/h0JlysiMecVCVESrEWEpxloaTT/J55Lva8NF
         buvbimuxWHRZ3gHEzZWysYCp9c1AIdqXrMbCcVfwk9Zc+FTL8lntcX3Pcx7HovGhAI
         hLUJ6jeKkFWDA==
From:   Nikita Travkin <nikita@trvn.ru>
To:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org
Cc:     airlied@gmail.com, daniel@ffwll.ch, dianders@chromium.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH] drm/bridge: ti-sn65dsi86: Implement wait_hpd_asserted
Date:   Sat,  8 Apr 2023 13:20:14 +0500
Message-Id: <20230408082014.235425-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bridge doesn't actually implement HPD due to it being way too slow
but instead expects the panel driver to wait enough to assume HPD is
asserted. However some panels (such as the generic 'edp-panel') expect
the bridge to deal with the delay and pass maximum delay to the aux
instead.

In order to support such panels, add a dummy implementation of wait
that would just sleep the maximum delay and assume no failure has
happened.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
This was suggested in [1] to make sure DT users can be semantically
correct (not adding no-hpd when the line is actually there) while
still using a hard delay to be faster than waiting the long debounce
time.

[1] - https://lore.kernel.org/all/CAD=FV=VR7sKsquE25eF7joc7gPApu-vqwduZzjE=wFCoXjMYnQ@mail.gmail.com/
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 7a748785c545..260cad1fd1da 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -618,6 +618,24 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *aux,
 	return len;
 }
 
+static int ti_sn_aux_wait_hpd_asserted(struct drm_dp_aux *aux, unsigned long wait_us)
+{
+	/*
+	 * The HPD in this chip is a bit useless (See comment in
+	 * ti_sn65dsi86_enable_comms) so if our driver is expected to wait
+	 * for HPD, we just assume it's asserted after the wait_us delay.
+	 *
+	 * In case we are asked to wait forever (wait_us=0) take conservative
+	 * 500ms delay.
+	 */
+	if (wait_us == 0)
+		wait_us = 500000;
+
+	usleep_range(wait_us, wait_us + 1000);
+
+	return 0;
+}
+
 static int ti_sn_aux_probe(struct auxiliary_device *adev,
 			   const struct auxiliary_device_id *id)
 {
@@ -627,6 +645,7 @@ static int ti_sn_aux_probe(struct auxiliary_device *adev,
 	pdata->aux.name = "ti-sn65dsi86-aux";
 	pdata->aux.dev = &adev->dev;
 	pdata->aux.transfer = ti_sn_aux_transfer;
+	pdata->aux.wait_hpd_asserted = ti_sn_aux_wait_hpd_asserted;
 	drm_dp_aux_init(&pdata->aux);
 
 	ret = devm_of_dp_aux_populate_ep_devices(&pdata->aux);
-- 
2.39.2

