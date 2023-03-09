Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2160A6B1877
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 02:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCIBFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 20:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjCIBFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 20:05:32 -0500
Received: from mx.dolansoft.org (s2.dolansoft.org [212.51.146.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2EBC1C3D;
        Wed,  8 Mar 2023 17:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=brun.one;
        s=s1; h=MIME-Version:Message-Id:Date:Subject:Cc:To:From:In-Reply-To:
        References:From:To:Subject:Date:Message-ID:Reply-To;
        bh=q7r5ddN92A+gb/JSXPLt/QT21LW9kefr3aC+Q48S/lc=; b=pkDYxYF9MAOcCpo6lZKnuimK2r
        kmS6NSQX1tzVZ/kGYQ2UDoAKPMn5lbx4DpcbG3r/Y8QS3VMcGlSu61mTTmyvu9d2uBv2ySzSnQaiS
        Ck0bCPiqZ+6G/Ml8i0FgIuPRrzeeLRwNNe6qqiLyxJZ2CDgutqqEOzYR5P/06uwPDBn4fLjBGPZip
        3OYMTF6Ve+sDIBevMZj+3QMyBpO6yGsOCoWYR5j+z+Zy0WJUrxgOtBFneGSpaFffmsMtx4lVzg+E6
        E5/ZufKv1A+LTK0hvL3PK7FOnptK9WM9K3OjSUmd3xaWEWDvKOVJqhGb4ot72mkLWISpZ3PAe7qbA
        nmtlSdNA==;
Received: from [212.51.153.89] (helo=blacklava.cluster.local)
        by mx.dolansoft.org with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <lorenz@dolansoft.org>)
        id 1pa4hn-001JTb-1d;
        Thu, 09 Mar 2023 01:04:27 +0000
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
Subject: [PATCH v2] pwm: mediatek: support inverted polarity
Date:   Thu,  9 Mar 2023 02:04:10 +0100
Message-Id: <20230309010410.2106525-1-lorenz@brun.one>
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

According to the MT7986 Reference Manual the Mediatek PWM controller
doesn't appear to have support for inverted polarity.

To still support inverted PWM for common use cases, this relaxes the
check for inverted polarity within the driver to allow it to work in
case usage_power is set to true, i.e. the exact waveform does not
matter. If usage_power is true and the polarity is inverted the duty
cycle is mathematically inverted before being applied to the hardware.

Signed-off-by: Lorenz Brun <lorenz@brun.one>
---
V2: Only allow mathematically inverted PWM if usage_power is true
---
 drivers/pwm/pwm-mediatek.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 5b5eeaff35da..18791304d1ca 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -202,8 +202,16 @@ static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			      const struct pwm_state *state)
 {
 	int err;
-
-	if (state->polarity != PWM_POLARITY_NORMAL)
+	u64 duty_cycle;
+
+	/* According to the MT7986 Reference Manual the peripheral does not
+	 * appear to have the capability to invert the output.
+	 * This means that inverted mode can not be fully supported as the
+	 * waveform will always start with the low period and end with the high
+	 * period. Thus reject non-normal polarity if the shape of the waveform
+	 * matters, i.e. usage_power is not set.
+	 */
+	if (state->polarity != PWM_POLARITY_NORMAL && !state->usage_power)
 		return -EINVAL;
 
 	if (!state->enabled) {
@@ -213,7 +221,11 @@ static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	err = pwm_mediatek_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	duty_cycle = state->duty_cycle;
+	if (state->polarity == PWM_POLARITY_INVERSED)
+		duty_cycle = state->period - state->duty_cycle;
+
+	err = pwm_mediatek_config(pwm->chip, pwm, duty_cycle, state->period);
 	if (err)
 		return err;
 
-- 
2.39.2

