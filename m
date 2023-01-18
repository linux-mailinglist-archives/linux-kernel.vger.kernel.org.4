Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A954C672217
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjARPvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjARPuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:50:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCA3366A5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:48:26 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pIAfo-0000Ak-3e; Wed, 18 Jan 2023 16:48:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pIAfm-006wQ3-Vy; Wed, 18 Jan 2023 16:48:22 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pIAfm-00Du2d-DP; Wed, 18 Jan 2023 16:48:22 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] pwm: ab8500: Fix .apply() and implement .get_state()
Date:   Wed, 18 Jan 2023 16:48:15 +0100
Message-Id: <20230118154817.97364-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=809; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=YAs5YAq6L7laZZa7NvQbZ3lbUvzorsFuGiH7G8PtkAk=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjyBS0DS/Lc7+pPhOwGoTq6ziMwIifwC/BcMZ9ZThi jIIvMVWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY8gUtAAKCRDB/BR4rcrsCcM+B/ 9F35rkNzyK4z7CSA3dVCnWn7JNPBT9C4Rz8jWnqRMR9MrYKC3GfBK9hDljY25RGoOErIY90UErRZu0 dpbZYMR+dJXrXchxCpivTJYLkN/8yFIVVXNmQSUm0m5G4JEmjXUsxkcSDNNcCGY8RZmRFvMiCBcbZw tOsZkxgMkM4QUbPWCknxQtd2KpUn0TmoSIT8yfvAn2rYbZCSfBSaEHtzL01SqF4E0wvpaxE2OVOKrM XUxke+ZhAky6ExClZ2vAdqQwKXxrLFwgkPO/Rr4GGkslvbclhYkw5k0wnjyizAk4JYIQBpKVJhCONO Sc+POkVTO3pfQB1S7irJ1luReKvBRq
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

Hello,

during review of my previous pwm-ab8500 patch I learned that there is a
(somewhat) publically available reference manual. Reading in it showed
that .apply() is still more broken that I assumed by just reading the
code.

This series first fixes .apply() to not be off by a factor of ~3000 and
then adds a .get_state() callback.

Note this is only compile tested as I don't have the hardware.
Also note this breaks all consumers that relied on the previously broken
behaviour.

Uwe Kleine-König (2):
  pwm: ab8500: Fix calculation of duty and period
  pwm: ab8500: Implement .get_state()

 drivers/pwm/pwm-ab8500.c | 112 +++++++++++++++++++++++++++++++++++----
 1 file changed, 103 insertions(+), 9 deletions(-)

base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
-- 
2.39.0

