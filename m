Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2436AC970
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjCFRKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCFRKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:10:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8C3AD0E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:10:01 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZEKi-0004gX-8n; Mon, 06 Mar 2023 18:09:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZEKh-002IfX-2T; Mon, 06 Mar 2023 18:09:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZEKg-002kzu-0t; Mon, 06 Mar 2023 18:09:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, kernel@pengutronix.de
Subject: [PATCH 0/3] watchdog: Simplify using devm_watchdog_register_device()
Date:   Mon,  6 Mar 2023 18:08:58 +0100
Message-Id: <20230306170901.2232323-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=660; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=6EtYMqi1fiROjY+lQ+pajMbUbJLefC0foXaL6QV83mQ=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkBh4bwGrLG15FzeO0fAFcq2Ni0hVbnG+KiqcKn dRSargLaqSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAYeGwAKCRDB/BR4rcrs CZ75B/9UVWrm3WUTgoOPxmbIxxh0MRzudotrTjOICBkSgWfJ5etf0PkEEOADba79JicslaPcXbO 4Yvo5Mzxu/Lv2llE1mZuloVoGB6tGR1mM+bbb+cabgEA2pIpgwzP2T4dNzKcCRBHEu/i38lXYxg 7pQLi3O/nZWq484anLxAwUGPA6QSysBx2IJlihX1oBbgg2tk5/eRzHnH0nalO4Hq5oQihj3d0tG N4cUnzjoeH5c7SJw/PyXSmebJ75TBEWnn54M67rco70v/cFAhGf0kYE7+fHSXMxYKjwAsc6L2+U 1at+k1XU1qdIKo1ErhM+S3A97IS2EeFhcfJj2H70Ic82ohvv
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

this series converts three drivers to use
devm_watchdog_register_device(). This allows to drop their remove
callback.

Best regards
Uwe

Uwe Kleine-König (3):
  watchdog: bcm47xx: Simplify using devm_watchdog_register_device()
  watchdog: rn5t618: Simplify using devm_watchdog_register_device()
  watchdog: wm8350: Simplify using devm_watchdog_register_device()

 drivers/watchdog/bcm47xx_wdt.c | 12 +-----------
 drivers/watchdog/rn5t618_wdt.c | 12 +-----------
 drivers/watchdog/wm8350_wdt.c  |  9 +--------
 3 files changed, 3 insertions(+), 30 deletions(-)


base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.1

