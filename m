Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78058678719
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjAWUDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjAWUC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:02:56 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DD0367C0;
        Mon, 23 Jan 2023 12:02:34 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 220932000A;
        Mon, 23 Jan 2023 20:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674504153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/DvFjwH0rtf/vONiwh3u+FyqUYVxFWWjs2YdFUIg4mw=;
        b=KTaEwkLts11ezfeabW/K8PoDih+yQw/eDcSXN9lgezdqpFKAv3wCsWFeVou4A7nNBzUo1+
        H6VbaIVybhBo5XiAObdisldpMIye1FLhYmruiDxIPsBDRXmGtmTXOmkJSUWSh/bqydGpLc
        0/YXxWhszlnd7wbNfV+b3KQ1+RXm17hVS3mafCa18ko0BcgOOyba95ZgencKkYDh0T6dvM
        ipeKhcCcpNKQlp46+4ezokKwSwQ9NnUs++dr0liT9jp0NatX9Pp8tz0d/JhI5q09L+rdJ+
        Z2ltA4KbMfsm0ALKkAxelfVY7GGlleC5w5JaldIXh18m5Fi62DcHGbldaiPQog==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] rtc: rv8803: use IRQ flags obtained from fwnode
Date:   Mon, 23 Jan 2023 21:02:17 +0100
Message-Id: <20230123200217.1236011-12-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123200217.1236011-1-alexandre.belloni@bootlin.com>
References: <20230123200217.1236011-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Allow the IRQ type to be passed from the device tree if available as there
may be components changing the trigger type of the interrupt between the
RTC and the IRQ controller.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rv8803.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index b581b6d5ad73..53d1de01b719 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -641,9 +641,14 @@ static int rv8803_probe(struct i2c_client *client)
 		return PTR_ERR(rv8803->rtc);
 
 	if (client->irq > 0) {
+		unsigned long irqflags = IRQF_TRIGGER_LOW;
+
+		if (dev_fwnode(&client->dev))
+			irqflags = 0;
+
 		err = devm_request_threaded_irq(&client->dev, client->irq,
 						NULL, rv8803_handle_irq,
-						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						irqflags | IRQF_ONESHOT,
 						"rv8803", client);
 		if (err) {
 			dev_warn(&client->dev, "unable to request IRQ, alarms disabled\n");
-- 
2.39.1

