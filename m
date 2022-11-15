Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F81762A3D8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiKOVPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbiKOVPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:15:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8AB1E3CF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:15:37 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ov3HJ-0005C2-FR; Tue, 15 Nov 2022 22:15:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ov3HH-004WcV-Tr; Tue, 15 Nov 2022 22:15:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ov3HI-00GukD-2s; Tue, 15 Nov 2022 22:15:32 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 4/4] pwm: Don't initialize list head before calling list_add()
Date:   Tue, 15 Nov 2022 22:15:15 +0100
Message-Id: <20221115211515.3750209-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115211515.3750209-1-u.kleine-koenig@pengutronix.de>
References: <20221115211515.3750209-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1012; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=YW3mBqZ7La41Wb9SLeoLhl8wDMBGwJ2RzU7YOl5SQBE=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjdAFgbOa95Z13KU1LcmxBWu5VVZjas+KtO3JBsMPy r20F8yeJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY3QBYAAKCRDB/BR4rcrsCRwQB/ 938DL+ClTjEMeI52IZYFZL9fNc3sjnhVOmJbLUpSL+Wv++06cCZ6hGinZZ8eeWHQDz816frRz0igny oJVKSvPnO7Ofr6UJLBtVgmlDAELssuh3NgOJ1McbjxlTRvwz3EMfK8hZlWGSEsWVyN5Kb4RCZKogEm x4t2kXSLwlZgQCUC0MNe+ZgKU++fVlU5ZDGX5pydpN0bxPAPCQud4lgnKitu2EZSB+/ODU9YVZAhCg XMPni2CEu9CtncF2CnSSlcrc+srROSJhZ3aXHDwYFSQVANzRwMLwELA0kG8dbKIGIpS1THCY+K6Fi+ HNeeWQYngSsa3XPhuJsYrqVGFMVvyl
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

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this patch I'm not sure about. A quick grep shows there are (only?) 40
more code locations that call INIT_LIST_HEAD just before list_add().
In my understanding INIT_LIST_HEAD is only to initialize lists, but
chip->list is not a list, but the data needed to track chip as a list
member.

Best regards
Uwe

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

