Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B997729BC2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240102AbjFINkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239524AbjFINkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:40:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6065F3584
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 06:40:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q7cL5-00015b-Sm; Fri, 09 Jun 2023 15:39:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q7cL2-006DQC-9q; Fri, 09 Jun 2023 15:39:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q7cL1-00CbL7-Ms; Fri, 09 Jun 2023 15:39:35 +0200
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
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Helge Deller <deller@gmx.de>,
        James Hilliard <james.hilliard1@gmail.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        linux-serial@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v4 0/2] serial: 8250: Apply FSL workarounds also without SERIAL_8250_CONSOLE
Date:   Fri,  9 Jun 2023 15:39:30 +0200
Message-Id: <20230609133932.786117-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2105; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=+cB9tyShgwjshIjt2kga32Gjjr1RbhwE+cfs5aJ925k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkgyuIVtr7pD4lotNXh/iORjiYvWbBmyyQyJxIF HC1uLy6ba6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZIMriAAKCRCPgPtYfRL+ TpjgB/9KGK9p2YxZnajUVe2pDznpCZz8FORUS0Evd76KrUPGduGFLJTaXwjMMvN0AWuPBzOjtC5 xqiZ2wEdw7JtSVprH6JwO2S3KF3HjiK2t6eNl5zZrOCzOKNxK6HSDqqip6MWzbxVkWLJcU7dFRa ONyMkAAfiuXo0uZ6RrMZ80ZQOPUC/Byk/sK3B7/oFLnHN0ncWRpMT7o7t2sEjfpqCxDgRb/dwsP spJ1I2ZZaXDp0fdkvQLWNcYlg7My48FjhMnpvcTQiXZlXarg3B82UK3THIBIGwQd7ywC1J7IGiJ xJsz1n7YL7m/i2o1q5H4xSbUqWykOxc4UoxUXRsxkI9Irrfg
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

Hello,

this is the fourth iteration of trying to make the FSL workaround code
active even without 8250 console support.

The first patch is a fix for commit 66eff0ef528b (powerpc/legacy_serial:
Warn about 8250 devices operated without active FSL workarounds) that
currently is in tty-next. This patch originates from my v3 that was only
partially applied. (That is a lame excuse though. While the applying the
full series would not have shown this problem, bisection would still
have a problem.)

The second patch makes SERIAL_8250_FSL tristate and thus allows this to
be enabled also with SERIAL_8250=m. This is also the relevant change
since v3, where 8250_fsl.o was linked into 8250-base.ko.

This series is build tested on amd64 and powerpc with all 27 possible
configurations for

	SERIAL_8250={y,m,n}
	SERIAL_8250_FSL={y,m,n}
	SERIAL_OF_PLATFORM={y,m,n}

using:

	choices=(y m n)
	for i in $(seq 0 26); do
		perl -p -e "s/SERIAL_8250=y/SERIAL_8250=${choices[$(((i / 9) % 3))]}/; s/SERIAL_8250_FSL=y/SERIAL_8250_FSL=${choices[$(((i / 3) % 3))]}/; s/SERIAL_OF_PLATFORM=y/SERIAL_OF_PLATFORM=${choices[$((i % 3))]}/;" .config-pre > .config &&
		make -j 12 ||
		break;
	done

with .config-pre having COMPILE_TEST=y so this time there shouldn't be a
build regression. (Not all 27 variants are possible, so some valid
configurations are tested twice or more, but that's still good enough.)

The patches have no strong dependency on each other, so they could go in
via different trees. But given that 66eff0ef528b is in tty-next, taking
both via tty sounds most sensible.

Best regards
Uwe

Uwe Kleine-König (2):
  powerpc/legacy_serial: Handle SERIAL_8250_FSL=n build failures
  serial: 8250: Apply FSL workarounds also without SERIAL_8250_CONSOLE

 arch/powerpc/kernel/legacy_serial.c | 2 +-
 drivers/tty/serial/8250/8250_fsl.c  | 3 +++
 drivers/tty/serial/8250/8250_of.c   | 2 +-
 drivers/tty/serial/8250/Kconfig     | 6 +++---
 4 files changed, 8 insertions(+), 5 deletions(-)


base-commit: 66eff0ef528b6d6e9a45b68f6cd969dcbe7b800a
-- 
2.39.2

