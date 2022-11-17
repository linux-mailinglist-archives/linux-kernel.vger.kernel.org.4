Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C448C62E686
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240809AbiKQVMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240719AbiKQVL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:11:56 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1921005D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:11:56 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovmAp-0007Om-Uf; Thu, 17 Nov 2022 22:11:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovmAn-004v5i-VG; Thu, 17 Nov 2022 22:11:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovmAo-00HN0C-7m; Thu, 17 Nov 2022 22:11:50 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 0/4] pwm: Some refactoring of pwmchip_add()
Date:   Thu, 17 Nov 2022 22:11:39 +0100
Message-Id: <20221117211143.3817381-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=597; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=aKdTZtwl9XGWY0ES2jremYshZeBwEU3FkygP8AbmADQ=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjdqN6vngz0LjirqUblfu69s/DY/NTHk0KMrteH8pI EuwuFHyJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY3ajegAKCRDB/BR4rcrsCSFSB/ 9RWVXu+0qWl4ouuFja11ps95FnIX5u8L9NUNBjAE0yDr8LumSchx92oac19awp16Tlwjy783qXOU9i KNcqht6N6z0w3IiSORqntZ11WvqAgVQCtY98V2o9QYCPlZCPyq1x5goLGdspO/gxHyFqrODvi2Jw7c tQQ161wyuFGgjRVt2WipsAo2+5sDOet14cr3DU+FPTWDZjtgquvVap9XJquE8ipb6pJGOsPXdDmVKZ YODB3xKIMU1pWOm8QuX0is2Vp7+J82x+h1eoTjGBweUt9OXHDhlJQjBKMj18B7jNO8fT5lFSQ59cPd ruPasoIwNqKJYrV9YqlGdZFDPp6gwm
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

Compared to (implicit) v1, this amends the commit log as agreed upon
with Andy and adds his tags.

Thanks for the review!

Best regards
Uwe

Uwe Kleine-König (4):
  pwm: Document variables protected by pwm_lock
  pwm: Reduce time the pwm_lock mutex is held in pwmchip_add()
  pwm: Mark free pwm IDs as used in alloc_pwms()
  pwm: Don't initialize list head before calling list_add()

 drivers/pwm/core.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)


base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.38.1

