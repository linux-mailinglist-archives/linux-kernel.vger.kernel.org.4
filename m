Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7F962E685
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240671AbiKQVMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240721AbiKQVL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:11:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551C620182
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:11:56 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovmAp-0007Oo-Uf; Thu, 17 Nov 2022 22:11:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovmAo-004v5p-80; Thu, 17 Nov 2022 22:11:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovmAo-00HN0I-Km; Thu, 17 Nov 2022 22:11:50 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 2/4] pwm: Reduce time the pwm_lock mutex is held in pwmchip_add()
Date:   Thu, 17 Nov 2022 22:11:41 +0100
Message-Id: <20221117211143.3817381-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117211143.3817381-1-u.kleine-koenig@pengutronix.de>
References: <20221117211143.3817381-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1801; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=W5msw8zxagwiJj6hJi4SU67DWQ0AjhZfTFm/qYmXeAw=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjdqOBYckSnoEgissL+BaN7xiZzh9ivhj1/pMXWrvx 7N8xgGaJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY3ajgQAKCRDB/BR4rcrsCXo5B/ 0dktt/af+nBKYFHSIzUWzlrkfNaF39SwKZymqqNFesWnRgx5Bme1h08zFbNC/AiGiSHNoO0ZLUqWvD wSwuRbHHcanZJzaITHzqoKV1LB0HQP5+czqi39f1uyXmDd7zzNf7MVPsHU9KSBRv+VJeq1Nf2OCelT Dp5XHO6a1Eq/oLfVtkOu1Fejl47Hn9yUjFgjYDYcx9g4r8Fl11kzajFwA3A4/1hIXbe6qXg3U7n9QO atAsT6jYdTRua1p3eY7s/nsD6RbMruUuhkUMlYhlfwJ2b1ejYAgK83zp47LjivQN617DWai9oolwqz e+0PtbpKksP+vwSwf6Tu25N2pAWeyO
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

This simplifies error handling as the need for goto error handling goes
away and at the end of the function the code can be simplified as this
code isn't used in the error case any more.

Now memory allocation and the call to of_pwmchip_add() are done without
holding the lock. Both don't access the data structures protected by
&pwm_lock.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index ebe06efe9de5..2338119a09d8 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -272,20 +272,21 @@ int pwmchip_add(struct pwm_chip *chip)
 	if (!pwm_ops_check(chip))
 		return -EINVAL;
 
+	chip->pwms = kcalloc(chip->npwm, sizeof(*pwm), GFP_KERNEL);
+	if (!chip->pwms)
+		return -ENOMEM;
+
 	mutex_lock(&pwm_lock);
 
 	ret = alloc_pwms(chip->npwm);
-	if (ret < 0)
-		goto out;
+	if (ret < 0) {
+		mutex_unlock(&pwm_lock);
+		kfree(chip->pwms);
+		return ret;
+	}
 
 	chip->base = ret;
 
-	chip->pwms = kcalloc(chip->npwm, sizeof(*pwm), GFP_KERNEL);
-	if (!chip->pwms) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
 	for (i = 0; i < chip->npwm; i++) {
 		pwm = &chip->pwms[i];
 
@@ -301,18 +302,14 @@ int pwmchip_add(struct pwm_chip *chip)
 	INIT_LIST_HEAD(&chip->list);
 	list_add(&chip->list, &pwm_chips);
 
-	ret = 0;
+	mutex_unlock(&pwm_lock);
 
 	if (IS_ENABLED(CONFIG_OF))
 		of_pwmchip_add(chip);
 
-out:
-	mutex_unlock(&pwm_lock);
-
-	if (!ret)
-		pwmchip_sysfs_export(chip);
+	pwmchip_sysfs_export(chip);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pwmchip_add);
 
-- 
2.38.1

