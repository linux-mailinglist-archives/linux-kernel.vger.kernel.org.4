Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193976A5A6F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjB1Nze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjB1Nza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:55:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF482305FE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:55:28 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pX0Rt-0007wy-2Z; Tue, 28 Feb 2023 14:55:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pX0Rs-000sdF-0S; Tue, 28 Feb 2023 14:55:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pX0Rr-0011e4-CB; Tue, 28 Feb 2023 14:55:19 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Munehisa Kamata <kamatam@amazon.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 4/4] pwm: sprd: Explicitly set .polarity in .get_state()
Date:   Tue, 28 Feb 2023 14:55:08 +0100
Message-Id: <20230228135508.1798428-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230228135508.1798428-1-u.kleine-koenig@pengutronix.de>
References: <20230228135508.1798428-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=824; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=bmf2HoXP9Rt5LT3z0AtFgY3qIfAp4/hwx1OXH8EwlFw=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBj/ge2KHuAInQ+QDahQS2YY03DGST7KS6YuYIAG cCGk1az48GJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY/4HtgAKCRDB/BR4rcrs CbNsB/9xAqs3WfLL+n74CI2B0P7vOauSZIUEMz7vuNJ1o8YDjSnmlkDtdJr4LA7olD3QWLXFyG2 QzZJSGsglYbR8rn87eemML3a8r3wiDlqeInSg4C1Ol5U9vDQLlOijd3c4BwWuKDDJCgzCt05Adi fVkCwABcaQteeTcFE3bwoLhFk14vTzmoGtp8Lb5teawf22xNNDd45/vAolptfbuFSv1s2qHKRP6 gT9zP4OIVm/x2QRC0/aH/tzfBI1zTQy6G55Az274UHAktxCPGvZmh3KM6KCC6ngEmfDXR99MF3w Q0DwLe7vriTk0Gly0sx2tEe9u84tUscrbYL3+Uh6Q88FCDR8
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver only supports normal polarity. Complete the implementation of
.get_state() by setting .polarity accordingly.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sprd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
index d866ce345f97..bde579a338c2 100644
--- a/drivers/pwm/pwm-sprd.c
+++ b/drivers/pwm/pwm-sprd.c
@@ -109,6 +109,7 @@ static int sprd_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	duty = val & SPRD_PWM_DUTY_MSK;
 	tmp = (prescale + 1) * NSEC_PER_SEC * duty;
 	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, chn->clk_rate);
+	state->polarity = PWM_POLARITY_NORMAL;
 
 	/* Disable PWM clocks if the PWM channel is not in enable state. */
 	if (!state->enabled)
-- 
2.39.1

