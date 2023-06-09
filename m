Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FACB729BBB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239971AbjFINkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjFINkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:40:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6808B30F1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 06:40:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q7cL5-00015c-Ly; Fri, 09 Jun 2023 15:39:39 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q7cL2-006DQG-Iv; Fri, 09 Jun 2023 15:39:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q7cL1-00CbLA-Tk; Fri, 09 Jun 2023 15:39:35 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rob Herring <robh@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Liang He <windhl@126.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v4 1/2] powerpc/legacy_serial: Handle SERIAL_8250_FSL=n build failures
Date:   Fri,  9 Jun 2023 15:39:31 +0200
Message-Id: <20230609133932.786117-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230609133932.786117-1-u.kleine-koenig@pengutronix.de>
References: <20230609133932.786117-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=UaetvPn93yjffnvRpl05XP9ES/YlsYyRkVTXp98DFLg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkgyuPTpnk3tAaU03gC4tcNyer+VWIXMkAUiNKc HgxNljHuy2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZIMrjwAKCRCPgPtYfRL+ TjC6B/9zeis0/Hsbg7mICcaw8jshAoTaOCKLITarBQvJoy4Nb5Hw7DfNETfz++t9Is22wt/mU2A VOivO/vxkzDxL6vyRZA5qXQIKs5XUMYrMcWZipTltj/SlD9TtmHZuGMcSHFllbNhfc+BaZASspf /SkuBf0luljF/Hsu942HEm64CDQmtpDHdSU0blz50GQaW1vYp68q6Hne6Z5IAixcoB+Tmq9JbLW zmPqv9bgtJMVb1tIEL/iSVC9M7q7EX531/lSkErdRjbFtYYUIgKUwI9IGBTEfaLiVn4LT9QK1Rb I1aVrbuc7xwtYXaVc3oXrEQD5cKgZWsItmLFDqT3GWW+Cseh
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With SERIAL_8250=y and SERIAL_8250_FSL_CONSOLE=n the both
IS_ENABLED(CONFIG_SERIAL_8250) and IS_REACHABLE(CONFIG_SERIAL_8250)
evaluate to true and so fsl8250_handle_irq() is used. However this
function is only available if CONFIG_SERIAL_8250_CONSOLE=y (and thus
SERIAL_8250_FSL=y).

To prepare SERIAL_8250_FSL becoming tristate and being enabled in more
cases, check for IS_REACHABLE(CONFIG_SERIAL_8250_FSL) before making use
of fsl8250_handle_irq(). This check is correct with and without the
change to make SERIAL_8250_FSL modular.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: 66eff0ef528b ("powerpc/legacy_serial: Warn about 8250 devices operated without active FSL workarounds")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/powerpc/kernel/legacy_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index fdbd85aafeb1..6ee65741dbd5 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -510,7 +510,7 @@ static void __init fixup_port_irq(int index,
 
 	if (IS_ENABLED(CONFIG_SERIAL_8250) &&
 	    of_device_is_compatible(np, "fsl,ns16550")) {
-		if (IS_REACHABLE(CONFIG_SERIAL_8250)) {
+		if (IS_REACHABLE(CONFIG_SERIAL_8250_FSL)) {
 			port->handle_irq = fsl8250_handle_irq;
 			port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE);
 		} else {
-- 
2.39.2

