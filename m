Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBC365497B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 00:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiLVXnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 18:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiLVXnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 18:43:41 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B305B252B9;
        Thu, 22 Dec 2022 15:43:39 -0800 (PST)
From:   Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1671752617;
        bh=YRRtbOkriQD0uKrpVN2szj1ZKTRTVm9GYpCO/Afsh8Y=;
        h=From:Date:Subject:To:Cc:From;
        b=VP0YdWbZMOG03Jh/TA3q3/ODmilc4hcQMMv/h9CqKbBY4/reriRjMfLY2aeu0/tQ/
         UgK6LD47BkV00q0b44SH56mohfAI560cMfpbJGL3uyd8aaJAVvGu45Enkuwl+J2W3V
         3IehfX5SmwvNoEfqEXno6J6twzug4y9WlMk0t8cQ=
Date:   Thu, 22 Dec 2022 23:43:31 +0000
Subject: [PATCH] watchdog: wdat_wdt: Avoid unimplemented get_timeleft
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <20221221-wdat_wdt-timeleft-v1-1-8e8a314c36cc@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAKPrpGMC/x2NQQqDMBBFryKz7oDGjfYqUkqSmehAGksSa0G8u
 4PwN+/D4x1QOAsXeDYHZP5JkTUpdI8G/GLTzCikDKY1ptPhTra+d6pY5cORQ0XXD9SS60caA6jn
 bGF02Sa/qJm2GPX8Zg7yv0PT6zwvXmsYlHgAAAA=
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas =?utf-8?q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.11.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671752614; l=1576;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=YRRtbOkriQD0uKrpVN2szj1ZKTRTVm9GYpCO/Afsh8Y=;
 b=kvC/KSiNttft91T/0qKLG3LekEaI63wN2JlXt1gan6g7uCqBxD28XSIGvODJHCJ6LBT+5MvWK7vt
 SgjgSpFpCYVQTvOD1IZtkbLc7/hKMHN0Lt5w2QV1rNpwv4MQ6Ywu
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the specification the action QUERY_COUNTDOWN_PERIOD is optional.
If the action is not implemented by the physical device the driver would
always report "0" from get_timeleft().
Avoid confusing userspace by only providing get_timeleft() when
implemented by the hardware.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/watchdog/wdat_wdt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
index ce7a4a9e4b03..0ba99bed59fc 100644
--- a/drivers/watchdog/wdat_wdt.c
+++ b/drivers/watchdog/wdat_wdt.c
@@ -301,13 +301,12 @@ static const struct watchdog_info wdat_wdt_info = {
 	.identity = "wdat_wdt",
 };
 
-static const struct watchdog_ops wdat_wdt_ops = {
+static struct watchdog_ops wdat_wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = wdat_wdt_start,
 	.stop = wdat_wdt_stop,
 	.ping = wdat_wdt_ping,
 	.set_timeout = wdat_wdt_set_timeout,
-	.get_timeleft = wdat_wdt_get_timeleft,
 };
 
 static int wdat_wdt_probe(struct platform_device *pdev)
@@ -436,6 +435,9 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 		list_add_tail(&instr->node, instructions);
 	}
 
+	if (wdat->instructions[ACPI_WDAT_GET_CURRENT_COUNTDOWN])
+		wdat_wdt_ops.get_timeleft = wdat_wdt_get_timeleft;
+
 	wdat_wdt_boot_status(wdat);
 	wdat_wdt_set_running(wdat);
 

---
base-commit: 0a924817d2ed9396401e0557c6134276d2e26382
change-id: 20221221-wdat_wdt-timeleft-b38d0db39d9f

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>
