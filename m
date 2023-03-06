Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095796AB6B7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 07:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCFG6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 01:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCFG57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 01:57:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC59B5BA3
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 22:57:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ4n1-0003SS-ND; Mon, 06 Mar 2023 07:57:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ4mz-002BSE-UH; Mon, 06 Mar 2023 07:57:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ4mz-002a93-9A; Mon, 06 Mar 2023 07:57:41 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] spi: imx: Fix cleanup in remove and convert to .remove_new()
Date:   Mon,  6 Mar 2023 07:57:31 +0100
Message-Id: <20230306065733.2170662-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=716; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=iiPlfkNGTQtHIdeLCyT911x4K26qGgM1r4nTBJQWiAs=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkBY7RTAkRL5NRvNzODTQz/oDx232L+yMCPvB+G /3cNhC3I1SJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAWO0QAKCRDB/BR4rcrs CTqTB/9WGavBEyJ/eKFU/UHp4ITgLOMqrkH3F7uS/dOK47YGSJlJZCziLGICdP4xF+roi5Ef9XN HPiLSdYK7kox26FREe0eHj+Jnr2/DRd/PUb5AnQ0pTOVFr1AQKQhQ6oyQwK7E6HLgjlc1tFrWmF SMnjnPIvenR8m2h9Ag/ka3nOep7ZYwU2u2AurLaGu1k8t635PK+sn+zMqaXetXDRCqjFAsCcMwH zaCkXZb/6I8OkDljDajb1yuvaAp3HaWgXNnhPMjxaiX901Chq3+TRMlSxDQ854h7AIEzWP1tJss aHX1L4DNRCRoJ5rMXjGr+gT8AtJDBjjkf/+pBizH69PDt3DG
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

From: Uwe Kleine-König <uwe@kleine-koenig.org>

Hello,

this small series converts the spi-imx driver to .remove_new(). The
motivation for this tree-wide effort are drivers that don't properly
cleanup and return an error code. This is broken as this results in
resource leaks. The spi-imx driver is such a driver. The idea is that if
the remove callback returns void it's obvious that an early error return
is wrong.

Best regards
Uwe

Uwe Kleine-König (2):
  spi: imx: Don't skip cleanup in remove's error path
  spi: imx: Convert to platform remove callback returning void

 drivers/spi/spi-imx.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)


base-commit: b01fe98d34f3bed944a93bd8119fed80c856fad8
-- 
2.39.1

