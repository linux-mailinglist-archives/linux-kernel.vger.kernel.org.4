Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CC46AA0C4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 21:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjCCU6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 15:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjCCU6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 15:58:46 -0500
Received: from mx.dolansoft.org (s2.dolansoft.org [212.51.146.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C63144B2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 12:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=brun.one;
        s=s1; h=MIME-Version:Message-Id:Date:Subject:Cc:To:From:In-Reply-To:
        References:From:To:Subject:Date:Message-ID:Reply-To;
        bh=ujEZ6ExOsdh6hl+KaXU2L5kIkg0VilRWgkdQvPvZgAA=; b=HfaLr0SW+VLWr8EL7YPdwlHKkD
        DY5UNw4wKhVRHP1TgIfGKhoJkMgOd/Ocs85vFb6eqqzpDDlj5E9RTV9totxL8CwaFOpysU3yfN1Xe
        wYKX4/2sRorPuN6F7WeN64YG18ZJYhKvoJZ+qtgYf9hDN6ShtS+ojHdBtidyF8+Ogdv8h2uXgNWih
        pRmqVOnj+RzNnLWv4zPVvJzf88Dd2Xq0Bw1bHZvEM1u0Dsezylhlp2h4FRywBypiZGlaoeng6MJF4
        8qdD45DeZ95kis7Qy02L/LPntKQEa1/HNk9Wlm/781Q+LVkn/ZzBNwtg4wC3X/f9o5MYHXcVbWpgq
        DDrrDUCg==;
Received: from [212.51.153.89] (helo=blacklava.cluster.local)
        by mx.dolansoft.org with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <lorenz@dolansoft.org>)
        id 1pYCU2-0015v2-1I;
        Fri, 03 Mar 2023 20:58:30 +0000
From:   Lorenz Brun <lorenz@brun.one>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] pwm: mediatek: support inverted polarity
Date:   Fri,  3 Mar 2023 21:58:21 +0100
Message-Id: <20230303205821.2285418-1-lorenz@brun.one>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: lorenz@dolansoft.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the MT7986 Reference Manual the Mediatek  PWM controller
doesn't appear to have support for inverted polarity.

This implements the same solution as in pwm-meson and just inverts the
duty cycle instead, which results in the same outcome.

Signed-off-by: Lorenz Brun <lorenz@brun.one>
---
 drivers/pwm/pwm-mediatek.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 5b5eeaff35da..6f4a54c8299f 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -202,9 +202,7 @@ static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			      const struct pwm_state *state)
 {
 	int err;
-
-	if (state->polarity != PWM_POLARITY_NORMAL)
-		return -EINVAL;
+	u64 duty_cycle;
 
 	if (!state->enabled) {
 		if (pwm->state.enabled)
@@ -213,7 +211,14 @@ static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	err = pwm_mediatek_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	// According to the MT7986 Reference Manual the peripheral does not
+	// appear to have the capability to invert the output. Instead just
+	// invert the duty cycle.
+	duty_cycle = state->duty_cycle;
+	if (state->polarity == PWM_POLARITY_INVERSED)
+		duty_cycle = state->period - state->duty_cycle;
+
+	err = pwm_mediatek_config(pwm->chip, pwm, duty_cycle, state->period);
 	if (err)
 		return err;
 
-- 
2.39.1

