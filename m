Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6604F6A5A73
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjB1N4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjB1N4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:56:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782CF303E0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:55:51 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pX0Ru-0007wr-FS; Tue, 28 Feb 2023 14:55:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pX0Rr-000sd5-Fv; Tue, 28 Feb 2023 14:55:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pX0Rq-0011dd-QM; Tue, 28 Feb 2023 14:55:18 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Munehisa Kamata <kamatam@amazon.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        yuanjian <yuanjian12@hisilicon.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 1/4] pwm: hibvt: Explicitly set .polarity in .get_state()
Date:   Tue, 28 Feb 2023 14:55:05 +0100
Message-Id: <20230228135508.1798428-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230228135508.1798428-1-u.kleine-koenig@pengutronix.de>
References: <20230228135508.1798428-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=851; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=wc4XckGFK16wdwJ/Xdl4epfiuvV/IHKkEC7JDlgUzKg=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBj/ges5DcD7InG+a9Dcii0vkRG0Z2rq8uudNNyL 1Dofr+8NjmJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY/4HrAAKCRDB/BR4rcrs CTpaB/9LfzC8uQW9dLE0QEXLyQCUYsDAve9IntGqd6uLK6z8NZWmNYwkIkLnjwGQwqfIhpFtqp6 Xnc1NpZ0eQ5nAt2aPVu1lQRlXyI68NBtxE/xNf3sOpgrXpEU8CrGcSZ6BIiQ15g89hDuJAE/Bo1 vv76KL8LkxsVwcKgkTmBsKvhtNTZt+z0mC+6qCy+H9IIZZNfI0exVgaqF6OdjkEnJxz37AihCQf BJCrCJpn/98xLdjb08QXoRntq11gc4c7LU13hCJTPuQpkvQPqmqgS7FRLjjPp856CDHszepDKBp 7u17LXuJL6J6y2+sXxOnD3qxOrzjdnsblZ9FVgRlbt/iD0AQ
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

The driver only both polarities. Complete the implementation of
.get_state() by setting .polarity according to the configured hardware
state.

Fixes: d09f00810850 ("pwm: Add PWM driver for HiSilicon BVT SOCs")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-hibvt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index 12c05c155cab..1b9274c5ad87 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -146,6 +146,7 @@ static int hibvt_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	value = readl(base + PWM_CTRL_ADDR(pwm->hwpwm));
 	state->enabled = (PWM_ENABLE_MASK & value);
+	state->polarity = (PWM_POLARITY_MASK & value) ? PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
 
 	return 0;
 }
-- 
2.39.1

