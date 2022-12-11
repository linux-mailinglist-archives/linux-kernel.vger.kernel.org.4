Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F146496C9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 23:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiLKWgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 17:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiLKWgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 17:36:04 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A1B647A;
        Sun, 11 Dec 2022 14:36:00 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EA8331BF203;
        Sun, 11 Dec 2022 22:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670798159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0KOJ4zXaURWQnHMs6xWhQytHCPi+wcBSN7++KVZzNTo=;
        b=WsR+8U2YYoaDuVTH9ziqyRgpeTA8yZytk7/aT645Mgxo/vWm5ULpphN7rc/EMia058f0fc
        o0vr0grLYLQeQAFEjiMoyWyfXfTnzQZE8n+Ms3v9wYsMt0PgPa5In+wySB4cFnlI9UgAge
        073viXQIRhy/3ZIVmv/e7QTK+CNE9SbbXw7pkIv92W/70JqlAtmq5i+CzhcGEf+9dZ7FNc
        ao8+ouCN4+tEBTqrWsXvMJe4QDB/Kpi0+pLrEabAXjnXYYwCPYVrW0Y6rOKtdUqH55yW7t
        1MPam4omzWoarxbYesoXHHulK/64DbtRpLgxrn/WD9905ihN0+LjxVosPZ9noA==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michael McCormick <michael.mccormick@enatel.net>
Cc:     Janne Terho <janne.terho@ouman.fi>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: pcf85063: fix pcf85063_clkout_control
Date:   Sun, 11 Dec 2022 23:35:53 +0100
Message-Id: <20221211223553.59955-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

pcf85063_clkout_control reads the wrong register but then update the
correct one.

Reported-by: Janne Terho <janne.terho@ouman.fi>
Fixes: 8c229ab6048b ("rtc: pcf85063: Add pcf85063 clkout control to common clock framework")
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf85063.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 99f9cc57c7b3..754e03984f98 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -424,7 +424,7 @@ static int pcf85063_clkout_control(struct clk_hw *hw, bool enable)
 	unsigned int buf;
 	int ret;
 
-	ret = regmap_read(pcf85063->regmap, PCF85063_REG_OFFSET, &buf);
+	ret = regmap_read(pcf85063->regmap, PCF85063_REG_CTRL2, &buf);
 	if (ret < 0)
 		return ret;
 	buf &= PCF85063_REG_CLKO_F_MASK;
-- 
2.38.1

