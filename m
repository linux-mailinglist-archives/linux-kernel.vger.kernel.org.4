Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB9B62E682
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240612AbiKQVMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240736AbiKQVL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:11:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7DE22283
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:11:56 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovmAp-0007On-Uh; Thu, 17 Nov 2022 22:11:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovmAo-004v5m-6M; Thu, 17 Nov 2022 22:11:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovmAo-00HN0F-Dh; Thu, 17 Nov 2022 22:11:50 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 1/4] pwm: Document variables protected by pwm_lock
Date:   Thu, 17 Nov 2022 22:11:40 +0100
Message-Id: <20221117211143.3817381-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117211143.3817381-1-u.kleine-koenig@pengutronix.de>
References: <20221117211143.3817381-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1336; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=gVppIEf/lpbSlfN4FOCkWayRJhongp4knJTqk4NtP9Q=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjdqN+8HG4Bay2je5Xh/cc1bSrfdvdcwF88fPwunKV FGDfVEKJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY3ajfgAKCRDB/BR4rcrsCZV5B/ 9+W4jlFDJayYkJPKxcszuItsiylo7wpidxU8YNXE9cYbwpw9aXu/eJ8gOOAjfs5i6/+QoofiLTTGkt 5CYqgvRLMpgvNir2eQKwgkINkJIvlzJQUzmnTTFJeTbpgi/RgfHDUszIXPQyEbgCXAXMDgiLo4UUBr c5kcgAICd0yyNvgELU6yXEzSvrUTNx3AXKzIhCl+Xsd81KTD/thUy6CqvlVYwEN3AAdlMs37u1lwkU cbsGobvw+yqbpoVuZ3+RHpOEZuyx+vjQ5VBsWSbLoKiFlxngfmULjIYCVWHfXVTBaLcl3ygzE/Y5ja Ieu0+bMI2x6YndkGlNKIHmqZPv+XNh
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

To simplify validation of the used locking, document for the global pwm
mutex what it actually protects against concurrent access. Also note for
two functions modifying these that pwm_lock is held by the caller.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index d333e7422f4a..ebe06efe9de5 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -27,7 +27,10 @@
 
 static DEFINE_MUTEX(pwm_lookup_lock);
 static LIST_HEAD(pwm_lookup_list);
+
+/* protects access to pwm_chips, allocated_pwms, and pwm_tree */
 static DEFINE_MUTEX(pwm_lock);
+
 static LIST_HEAD(pwm_chips);
 static DECLARE_BITMAP(allocated_pwms, MAX_PWMS);
 static RADIX_TREE(pwm_tree, GFP_KERNEL);
@@ -37,6 +40,7 @@ static struct pwm_device *pwm_to_device(unsigned int pwm)
 	return radix_tree_lookup(&pwm_tree, pwm);
 }
 
+/* Called with pwm_lock held */
 static int alloc_pwms(unsigned int count)
 {
 	unsigned int start;
@@ -50,6 +54,7 @@ static int alloc_pwms(unsigned int count)
 	return start;
 }
 
+/* Called with pwm_lock held */
 static void free_pwms(struct pwm_chip *chip)
 {
 	unsigned int i;
-- 
2.38.1

