Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3B46A5A6C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjB1Nz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjB1NzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:55:25 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930A91EBEF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:55:24 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pX0Rs-0007wu-FG; Tue, 28 Feb 2023 14:55:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pX0Rr-000sd9-QY; Tue, 28 Feb 2023 14:55:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pX0Rr-0011dj-61; Tue, 28 Feb 2023 14:55:19 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Munehisa Kamata <kamatam@amazon.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 3/4] pwm: iqs620a: Explicitly set .polarity in .get_state()
Date:   Tue, 28 Feb 2023 14:55:07 +0100
Message-Id: <20230228135508.1798428-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230228135508.1798428-1-u.kleine-koenig@pengutronix.de>
References: <20230228135508.1798428-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=695; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=oFx9sWQeOcwK9tph3SLBT8A0PAe+uJ+yMPKcDB2SV6g=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBj/gezGzP7hFeDYYO3McBYrDAocsVr1s8ooAAwU 72jqr0StXGJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY/4HswAKCRDB/BR4rcrs CTM8B/96zKiaRWSNjbH003KQRBpIIUk86CaI410ZsKGBCyV0v6djqh/onhyaXAYC+W4nqNVMXLz mxQ24yUJjuQ12Lp9ZjG0NwkuCXQtgQ9Ob1HeqgWwaojpVWV0y0hQPo3s0Pip3SdJAe26QmPsTX7 Thfbp3kCQ3QH7keDvzkuU9eceLmtH5RdHFjKHsHLjloTbMNfH2/Fj3AxsMF3ZnUkL5elLKX+5NB YV/mnpLa85ujstFIAT08S6efYP2TwSz/2OBwvLl48h3tRkO1RmwX3Ckk3ElqzJ9/YbqziRfYjsI lWAaKOx6GRUApZFTmhVMAgeb+M6sMDEvq5k0YU4YIfK4l1U5
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
 drivers/pwm/pwm-iqs620a.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
index 8362b4870c66..47b3141135f3 100644
--- a/drivers/pwm/pwm-iqs620a.c
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -126,6 +126,7 @@ static int iqs620_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	mutex_unlock(&iqs620_pwm->lock);
 
 	state->period = IQS620_PWM_PERIOD_NS;
+	state->polarity = PWM_POLARITY_NORMAL;
 
 	return 0;
 }
-- 
2.39.1

