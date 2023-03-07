Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0229D6AD90F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjCGISJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjCGIR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:17:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5B34FF02
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:17:49 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZSVk-0003g3-IZ; Tue, 07 Mar 2023 09:17:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZRF5-002Q7E-4V; Tue, 07 Mar 2023 07:56:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZRF4-002uCb-Ap; Tue, 07 Mar 2023 07:56:10 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 0/2] watchdog: s3c2410_wdt: Simplify using dev_err_probe()
Date:   Tue,  7 Mar 2023 07:56:01 +0100
Message-Id: <20230307065603.2253054-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1505; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=3sAJvEw7NUBqpA5/z9WbVZ+NLIWBt2CTWqjU090NkEs=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkBt/23ZqoKD56fHAi1FMi7zJtN+UfwgOMebeP3 SGR63M+fEeJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAbf9gAKCRDB/BR4rcrs CU/+B/9thet8egko24kA9dERLG7fYtwz7nxG4auEGQ+twbgp4hyF1Ln/nZBwmyv4kLCaaz0mJt2 5AWRQeW/E2BSwsPe+jlwa4GJSYdZQP5gltoenX0wImvxu09aW1Iwa/HEDq2XhCZVRtZFm8uVAKB bConPUuDyqDou6h3xLesQhcWToGrhx/6Kn9PGmTHBdxKxeTQJxlXXHAuweMXCO8/HlYhqfdpGPh n7EW3j257N9/TyiZw8SpRRBU2lmj9eemIHpYu0U1IweoYClDBPMnWGX5z7Ys2KDrOc+/RWyd0KN S1yUYouls9BPjM6TtrHp5HfQFaGeZPlm5rDZLAzhT23vwZNS
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

changes since (implicit) v1, sent with Message-Id:
20230306090919.2206871-1-u.kleine-koenig@pengutronix.de:

 - Rework patch #1 to keep s3c2410_get_wdt_drv_data() as a separate
   function. The return value has to change however to make effective
   use of dev_err_probe(). (I thought about using

   	return ERR_PTR(dev_err_probe(...));

   but this looks too ugly and that's less effective because then
   dev_err_probe cannot be compiled into a tail call.)

 - Squash patches #2 and #3. This destroys the pretty bloatometer
   statistic, in fact bloatometer diagnoses that the code gets bigger.
   I'm a bit surprised but didn't try to understand it. I assume that's
   because the additional parameter that dev_err_probe has to get over
   dev_err is the culprit. Still given that the error code is now
   included in the error message this is an IMHO nice patch.

Now that Gunter likes patch #1 better than the one from v1, I wonder
about his position about patch #2.

Best regards
Uwe

Uwe Kleine-König (2):
  watchdog: s3c2410: Make s3c2410_get_wdt_drv_data() return an int
  watchdog: s3c2410_wdt: Simplify using dev_err_probe()

 drivers/watchdog/s3c2410_wdt.c | 47 +++++++++++++++-------------------
 1 file changed, 20 insertions(+), 27 deletions(-)


base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
prerequisite-patch-id: 775bdd863307268e1ef16250bf2f40862637b453
prerequisite-patch-id: 924ddfbe583e97e7c9a46c2460ecbc88c29ee319
-- 
2.39.1

