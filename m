Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0510962A3D5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiKOVPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiKOVPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:15:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5A212AB1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:15:37 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ov3HJ-0005Bk-2N; Tue, 15 Nov 2022 22:15:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ov3HG-004WcG-RW; Tue, 15 Nov 2022 22:15:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ov3HG-00Gujz-QU; Tue, 15 Nov 2022 22:15:30 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 0/4] pwm: Some refactoring of pwmchip_add()
Date:   Tue, 15 Nov 2022 22:15:11 +0100
Message-Id: <20221115211515.3750209-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=667; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=0l8GjUOKXyVW17IqypTgxp8Q0d3CEr4Pa1Jd2q/39Ak=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjdAFSuzLoZlcGLYYKt+aaok0zUOh2X79fYygUs//G URksLayJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY3QBUgAKCRDB/BR4rcrsCdd1B/ 9QHrIme09VpIhmD36p9UgPj/qugY2SjkNBHPZ0FXiDzGwd0QSYvdCJJJr08CFGGEbgA70Q1PaqbRXp q+RtwLQYPYPC57nC6NqJ/PSeWkM8gETjcf2Ksbpf1X0pC94fPGnUtxgLw0t6oI+bgDdHPF7xVzUaRO f6V0TgKcsZjVp/BPwWBJS1mobGI8fBFVmR6wPwkuhZODAfYxC834vrwArUzftr7kyTuWS8qnZspi2u U/Gcn3ypIDKU00MuqOIFEdHfNrJvo3cAm6Y1S5xpz1mSaSamRpqdNLfUFZrnA4cCZ4lsSCZrXZCway kQpOju+dSNTtR9EoWnI7folfIx2ri7
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

this is inspired by a patch suggested by Andy Shevchenko[1] and so it
conflicts with his patch.

Best regards
Uwe

[1] https://lore.kernel.org/linux-pwm/20221114170006.61751-1-andriy.shevchenko@linux.intel.com

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

