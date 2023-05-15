Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930D9703445
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242965AbjEOQqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242990AbjEOQqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:46:36 -0400
X-Greylist: delayed 2622 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 May 2023 09:46:30 PDT
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8D25259;
        Mon, 15 May 2023 09:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=XUIEpNRUXpJvYmFAKwBCCJfgCkzLAHM5z0DC/nHI13A=; b=C
        OQJj6sqPxX1Q7FxQhjaUUWeXuw3XXan7JNUCzhueLTvMhc5UVRePxj/9FrhWq8xoK/PYs8Qz6OmsS
        db1EVVcO8JeQ/mCL9KxlCEZB2ew42iYk5ZwNzStoIz1YTCn7Ah3Cchp3zITdcEILi/J9FYpyyEJXx
        +bbtXKn9wrC1d8zM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41230 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1pyaeU-0003GD-Fw; Mon, 15 May 2023 12:02:23 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        =?UTF-8?q?Tomasz=20Mo=C5=84?= <tomasz.mon@camlingroup.com>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 15 May 2023 12:02:07 -0400
Message-Id: <20230515160206.2801991-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [RFC PATCH] Revert "sc16is7xx: Separate GPIOs from modem control lines"
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

This reverts commit 679875d1d8802669590ef4d69b0e7d13207ebd61.

Because of this commit, it is no longer possible to use the 16 GPIO
lines as dedicated GPIOs on the SC16IS752.

Reverting it makes it work again.

The log message of the original commit states:
    "Export only the GPIOs that are not shared with hardware modem
    control lines"

But there is no explanation as to why this decision was taken to
permanently set the function of the GPIO lines as modem control
lines. AFAIK, there is no problem with using these lines as GPIO or modem
control lines.

Maybe after reverting this commit, we could define a new
device-tree property named, for example,
"use-modem-control-lines", so that both options can be supported.

Fixes: 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control
lines")

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 5bd98e4316f5..25f1b2f6ec51 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -306,7 +306,6 @@ struct sc16is7xx_devtype {
 	char	name[10];
 	int	nr_gpio;
 	int	nr_uart;
-	int	has_mctrl;
 };
 
 #define SC16IS7XX_RECONF_MD		(1 << 0)
@@ -447,35 +446,30 @@ static const struct sc16is7xx_devtype sc16is74x_devtype = {
 	.name		= "SC16IS74X",
 	.nr_gpio	= 0,
 	.nr_uart	= 1,
-	.has_mctrl	= 0,
 };
 
 static const struct sc16is7xx_devtype sc16is750_devtype = {
 	.name		= "SC16IS750",
-	.nr_gpio	= 4,
+	.nr_gpio	= 8,
 	.nr_uart	= 1,
-	.has_mctrl	= 1,
 };
 
 static const struct sc16is7xx_devtype sc16is752_devtype = {
 	.name		= "SC16IS752",
-	.nr_gpio	= 0,
+	.nr_gpio	= 8,
 	.nr_uart	= 2,
-	.has_mctrl	= 1,
 };
 
 static const struct sc16is7xx_devtype sc16is760_devtype = {
 	.name		= "SC16IS760",
-	.nr_gpio	= 4,
+	.nr_gpio	= 8,
 	.nr_uart	= 1,
-	.has_mctrl	= 1,
 };
 
 static const struct sc16is7xx_devtype sc16is762_devtype = {
 	.name		= "SC16IS762",
-	.nr_gpio	= 0,
+	.nr_gpio	= 8,
 	.nr_uart	= 2,
-	.has_mctrl	= 1,
 };
 
 static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
-- 
2.30.2

