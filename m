Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B924F7226F9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbjFENKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbjFENJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:09:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EF4116
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 06:09:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q69xM-0001WI-KH; Mon, 05 Jun 2023 15:09:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q69xF-005HiM-PH; Mon, 05 Jun 2023 15:09:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q69xF-00BOyL-3v; Mon, 05 Jun 2023 15:09:01 +0200
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
Subject: [PATCH v3 1/2] powerpc/legacy_serial: Warn about 8250 devices operated without active FSL workarounds
Date:   Mon,  5 Jun 2023 15:08:56 +0200
Message-Id: <20230605130857.85543-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230605130857.85543-1-u.kleine-koenig@pengutronix.de>
References: <20230605130857.85543-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1676; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=OtOaPvHV+suEiSPknSI11DIRzLXr23I/hyoeM+NczkQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkfd5llrJCU4sjBgMwgCCNdyx9Kyzm5rtUF5+sf RdKQxmUQbeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZH3eZQAKCRCPgPtYfRL+ Tq7eB/9IStn2Ffu4XF3y20ak+X/QW+d/F/9OSKKrxvbue63tJH1XovgRrOqDXRCPotg42yDFPi5 4QcZBIlNrKxNhMRphq0LBtZVu0j8SpDQkzZ07G1GIst+sSI6e1AFmeg2sy++pKU+ZJE7O8YCwSK ioX/dZcnsbQ8j8ZZJ7oCD+PRUmwuEm7dcCVLFELf4THj/fSde9hLXZJNHCa9cLKr17Nbp/qe0VV W4OAAbiGQkcms4U7LQ6k3E2iYqVa+VAwVo41xada+WXokF676A3FrjUwrsyZhkzHRrVb0b7GmGQ 6ZHbfutMWtjnwG/Uk9lK3rX2n4aVCy7fz7qx/ge5PVsKxKj5
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

If the 8250 driver is built as a module (or built-in without console
support) the Freescale specific workaround were silently not activated.
Add a warning in this case.

Currently CONFIG_SERIAL_8250_FSL=y implies that the function
fsl8250_handle_irq() is built-in and can be used. However with the
changes of the next commit CONFIG_SERIAL_8250_FSL might be enabled also
when the 8250 driver is a module and so more care is needed when
fsl8250_handle_irq() is to be used. The code added here is able to
handle the new situation already.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/powerpc/kernel/legacy_serial.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index c9ad12461d44..fdbd85aafeb1 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -508,12 +508,16 @@ static void __init fixup_port_irq(int index,
 
 	port->irq = virq;
 
-#ifdef CONFIG_SERIAL_8250_FSL
-	if (of_device_is_compatible(np, "fsl,ns16550")) {
-		port->handle_irq = fsl8250_handle_irq;
-		port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
+	if (IS_ENABLED(CONFIG_SERIAL_8250) &&
+	    of_device_is_compatible(np, "fsl,ns16550")) {
+		if (IS_REACHABLE(CONFIG_SERIAL_8250)) {
+			port->handle_irq = fsl8250_handle_irq;
+			port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
+		} else {
+			pr_warn_once("Not activating Freescale specific workaround for device %pOFP\n",
+				     np);
+		}
 	}
-#endif
 }
 
 static void __init fixup_port_pio(int index,
-- 
2.39.2

