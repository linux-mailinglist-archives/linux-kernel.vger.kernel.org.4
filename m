Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A83B63914C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 23:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiKYWNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 17:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiKYWNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 17:13:07 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1517842F44;
        Fri, 25 Nov 2022 14:13:06 -0800 (PST)
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1669414385;
        bh=NfUto/kzlGw7QHSzrLivwzsVm6hp5+hYlxlAfPABAnI=;
        h=From:To:Cc:Subject:Date:From;
        b=WWd7lWBvowcsIikThTmnOXlnYwynrPcLwnppPw0yImf4GvfuduUsJmDn1kgCbJznt
         J/ZeY3tMTsq+tIwbOnDIb2cXevzqfubexuvT3Mhq3IbFPUVCblF+VuAq0t0Qg4PU7W
         xQoLKWYMMbQkO4XZsC1ccGowNBsGwlkkGftG/C04=
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: iTCO_wdt: Report firmware_version
Date:   Fri, 25 Nov 2022 23:12:40 +0100
Message-Id: <20221125221240.2818-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1669414358; l=1055; i=linux@weissschuh.net; s=20211113; h=from:subject; bh=NfUto/kzlGw7QHSzrLivwzsVm6hp5+hYlxlAfPABAnI=; b=uNXqCS0UWqAIrG2vVVtC5eltvZg0V3ncodM13d8rBmRdDxpQNf0X7CfA59zsC/6N2t/Fa019XPT6 pw1sOeKCAv42JnYEjiklvvL84B8Vrg6cbIxWNoV7AtiR2lzLEuTA
X-Developer-Key: i=linux@weissschuh.net; a=ed25519; pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synchronize the reported information in dmesg and the watchdog APIs.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/watchdog/iTCO_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 34693f11385f..9b3c9f8b0b93 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -437,11 +437,10 @@ static void iTCO_wdt_set_running(struct iTCO_wdt_private *p)
  *	Kernel Interfaces
  */
 
-static const struct watchdog_info ident = {
+static struct watchdog_info ident = {
 	.options =		WDIOF_SETTIMEOUT |
 				WDIOF_KEEPALIVEPING |
 				WDIOF_MAGICCLOSE,
-	.firmware_version =	0,
 	.identity =		DRV_NAME,
 };
 
@@ -562,6 +561,7 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 		break;
 	}
 
+	ident.firmware_version = p->iTCO_version;
 	p->wddev.info = &ident,
 	p->wddev.ops = &iTCO_wdt_ops,
 	p->wddev.bootstatus = 0;

base-commit: 0b1dcc2cf55ae6523c6fbd0d741b3ac28c9f4536
-- 
2.38.1

