Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADC471F3BB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjFAUTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjFAUTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:19:05 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C908189;
        Thu,  1 Jun 2023 13:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fISA+M83zRFEgKAdJUAq2HgGHBk9L99uymCON8uLsVo=; b=FYMQTKBjoNVaDM9a+tAIAyrw1X
        mMUS0palNJwjZcR42ck977uBOFvJQDnK8jSByhkWjnwB3/LIiTWmoupP6Tv/D6PX+I6QeHlgurJDm
        Nq5qkKQd3KXYkmNnFhMYy8f35yiJk7ynfq1vLE8mGSVlb+GhU+3CJ/tMSmAjAjMtuUuQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:39204 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q4ol8-000686-Qz; Thu, 01 Jun 2023 16:18:59 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
Date:   Thu,  1 Jun 2023 16:18:43 -0400
Message-Id: <20230601201844.3739926-9-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230601201844.3739926-1-hugo@hugovil.com>
References: <20230601201844.3739926-1-hugo@hugovil.com>
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
Subject: [PATCH v6 8/9] serial: sc16is7xx: add post reset delay
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Make sure we wait at least 3us before initiating communication with
the device after reset.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
---
 drivers/tty/serial/sc16is7xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 388c1d490853..9b2d58023c55 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1521,6 +1521,12 @@ static int sc16is7xx_probe(struct device *dev,
 	regmap_write(s->regmap, SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
 			SC16IS7XX_IOCONTROL_SRESET_BIT);
 
+	/*
+	 * After reset, the host must wait at least 3us before initializing a
+	 * communication with the device.
+	 */
+	usleep_range(5, 10);
+
 	for (i = 0; i < devtype->nr_uart; ++i) {
 		s->p[i].line		= i;
 		/* Initialize port data */
-- 
2.30.2

