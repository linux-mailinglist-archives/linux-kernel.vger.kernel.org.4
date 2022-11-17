Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6453B62E687
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiKQVMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240742AbiKQVL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:11:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080CD61505
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:11:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovmAq-0007PE-MB; Thu, 17 Nov 2022 22:11:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovmAp-004v5y-5E; Thu, 17 Nov 2022 22:11:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovmAp-00HN0P-3H; Thu, 17 Nov 2022 22:11:51 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 4/4] pwm: Don't initialize list head before calling list_add()
Date:   Thu, 17 Nov 2022 22:11:43 +0100
Message-Id: <20221117211143.3817381-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117211143.3817381-1-u.kleine-koenig@pengutronix.de>
References: <20221117211143.3817381-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=754; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=K9jS1ZpU4xG3DAU/vPGftlodsO7fioNr3gh5KvNrnro=; b=owGbwMvMwMV48I9IxdpTbzgZT6slMSSXLe7M+hkc9qOvk/3InQeV8Sbtn0wv7nQSmCmkdkzfo3jR 2T19nYzGLAyMXAyyYoosdUVaYhMk1vy3K1nCDTOIlQlkCgMXpwBMJKyQg6HNZY6umEDMrI1ar2YY3H 5/6rjQrqpd845qHl8lp8bzyHhJYXpAWb+bfGez/vup2RetS1Q/fZ+QO71lqRZ/40aXt7lbtKqqbyb+ XbHS6Nfqn/vXW278w7NHQWrheS61yshil7jAvytu5Pv3H1M8NN3wpmpOYr1zzNX3X794bTHUOCEx5V iLUJHRamWja4uXWxRHGWzdziQVn3B12qtri7otDmkZtCxy2uAXe5w5XlRUe32h9ll9ebOvJj9T/rzz STviU5wh+mb6Yi6/+fy6Gn25VtWWnc37vP5F30ha2ldbdo7Bp5vz336jGuWIyyy5/Gp3zytUaRlmre 5dMj89Ro5JatrdTvHnpbGRaad5AQ==
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

list_add() just overwrites the members of the element to add (here:
chip->list) without any checks, even in the DEBUG_LIST case. So save the
effort to initialize the list.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index b43b24bd3c9f..61bacd8d9b44 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -299,7 +299,6 @@ int pwmchip_add(struct pwm_chip *chip)
 		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
 	}
 
-	INIT_LIST_HEAD(&chip->list);
 	list_add(&chip->list, &pwm_chips);
 
 	mutex_unlock(&pwm_lock);
-- 
2.38.1

