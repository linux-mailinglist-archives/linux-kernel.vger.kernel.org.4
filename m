Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD04266A20C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjAMS2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjAMS14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:27:56 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F23653284
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 10:24:35 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pGOjA-0001QP-Ba; Fri, 13 Jan 2023 19:24:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pGOj9-005pId-GZ; Fri, 13 Jan 2023 19:24:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pGOj8-00Cahr-Nu; Fri, 13 Jan 2023 19:24:30 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-leds@vger.kernel.org
Subject: [PATCH 0/2] mfd: Make .disable() callback and mfd_cell_disable() return void
Date:   Fri, 13 Jan 2023 19:24:25 +0100
Message-Id: <20230113182427.257484-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=sH19ddRIBynGBnEgR6eY66v7FT/OtOzi3iYGutPYY0o=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjwaHRRbXtm6vuCP13QM9v3s+F8ovBVohPIsU3N6HT DE8FJnCJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY8Gh0QAKCRDB/BR4rcrsCbiqCA CGSoo9DXMra9dLWTe0JAJJxX9hbmCFi1SVKtiVltd1OiOGenavWetInvFBW2CowNjpDoMPQhB0eJO+ sYmCCKByHX63jnQK8TSwFx4Xrp61nM1rMLgg8RFg16WJGfapO1NIbCFOqQSuthxzWTi5umlsAVk3A3 yqDbSx9QzT3bbgjAV7xbKI+BQCeoN3BH+XBHDctlg+D60u4I/4yaO9L5LAl74NiBKT35KPeyQ1yM/w 7A/RbKcj2d0ndzcvW2Pf0TPVESPODLMkcsrns05uWcrqjeOax/E8j0cdWBwI0LxNhht53lMPkeU0D1 dyJq+YbgH+2KmwwhS1PUtdeKbUpAgP
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series eventually changes mfd_cell_disable() to return void. Before it
returned an int and always 0. The motivation is to not force drivers to do
error handling that is never hit. Here only a single driver did that:
leds-asic3. For that driver this is a nice improvement because a platform
driver's remove callback is not supposed to return an error code.

This serves as a preparation for the quest to make struct
platform_driver::remove return void, too.

This series is build-tested (using allmodconfig) on arm64, m68k, powerpc,
riscv, s390, sparc64 and x86_64.

I suggest to let this series go into mainline via the mfd tree. So an Ack by
Pavel for the led bits would be nice to let Lee pick it up in good conscience.

Best regards
Uwe

Uwe Kleine-König (2):
  mfd: Make .disable() callback return void
  mfd: Make mfd_cell_disable() return void

 drivers/leds/leds-asic3.c |  6 ++++--
 drivers/mfd/asic3.c       | 17 +++++++++--------
 drivers/mfd/htc-pasic3.c  |  3 +--
 drivers/mfd/mfd-core.c    | 10 ++++------
 drivers/mfd/t7l66xb.c     |  4 +---
 drivers/mfd/tc6387xb.c    |  4 +---
 drivers/mfd/tc6393xb.c    | 16 ++++++++++------
 include/linux/mfd/core.h  |  4 ++--
 8 files changed, 32 insertions(+), 32 deletions(-)

base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
-- 
2.39.0

