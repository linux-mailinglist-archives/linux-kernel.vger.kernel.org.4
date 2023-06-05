Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22037226F6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjFENKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbjFENJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:09:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC0611A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 06:09:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q69xM-0001WH-KH; Mon, 05 Jun 2023 15:09:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q69xF-005HiL-NM; Mon, 05 Jun 2023 15:09:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q69xE-00BOyI-UI; Mon, 05 Jun 2023 15:09:00 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     kernel@pengutronix.de, Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Rob Herring <robh@kernel.org>, Helge Deller <deller@gmx.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Liang He <windhl@126.com>, linuxppc-dev@lists.ozlabs.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] serial: 8250: Apply FSL workarounds also without SERIAL_8250_CONSOLE
Date:   Mon,  5 Jun 2023 15:08:55 +0200
Message-Id: <20230605130857.85543-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1598; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=efED1NBBshJCjtXaXpvTEIOYQwFkMPcUlShlRdzjsnY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkfd5jaEVvCEZommSXyTG8Eotcw/vYwgq1ooqwJ +LAQzQ3pFmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZH3eYwAKCRCPgPtYfRL+ TmwrCACC5YJ4ou0Bm0/ZORk01u+NPrk7NEQRTwKiRveCNvUqIgkJq5nkbm4JH/fUBh8nt6j8Sog y5Fm+vyV2+4B8hY4dmrRXD3GYbJzpbmBklsuWSiLE8xJvmXJAWyfcn3JiOaiwQwdtyAETBCaqTJ DIK4OX5t9hevZ1Zy0hQbvhL+rIn28McI95kOHiwXlm0AiH0uNzfomg+thLKcIhPfkWaYbiLShxo X5oKuhC2OvdjB6E++At3yQPVM0/InkgF/Uw1Q/vaFgQOL8cgn4V+wIDz5aIXX1J22l+vJGh+mFT kyuN8lADoLdvK3avgRsPKqAn0R5Fsn7Drbm1zUPU/eCfDxTa
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is v3 of the series that now also copes for
arch/powerpc/kernel/legacy_serial.c using fsl8250_handle_irq().

For kernel configurations that already before were correctly using the
Freescale workarounds, this is the case with this series applied, too.
So in all cases the situation doesn't get worse. The upside is that even
with the 8250 driver compiled as a module (or built-in but without
console support) the workarounds are now applied for all devices but for
the ones instantiated in arch/powerpc/kernel/legacy_serial.c. (And even
for these there might not be a problem as they might benefit from
enabling the workarounds in drivers/tty/serial/8250/8250_of.c. Not sure
though.)

Patch #1 is new here. Patch #2 only changed lightly: I restored
alphabetic order in drivers/tty/serial/8250/Kconfig.

As patch #1 is needed for patch #2 to not introduce a build failure,
both patches should be taken together. I suggest to add them to Greg's
serial tree, but the changes pending there should not conflict with this
series such that taking them both via powerpc works, too.

Best regards
Uwe

Uwe Kleine-König (2):
  powerpc/legacy_serial: Warn about 8250 devices operated without active
    FSL workarounds
  serial: 8250: Apply FSL workarounds also without SERIAL_8250_CONSOLE

 arch/powerpc/kernel/legacy_serial.c | 14 +++++++++-----
 drivers/tty/serial/8250/Kconfig     |  2 +-
 drivers/tty/serial/8250/Makefile    |  2 +-
 3 files changed, 11 insertions(+), 7 deletions(-)


base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.39.2

