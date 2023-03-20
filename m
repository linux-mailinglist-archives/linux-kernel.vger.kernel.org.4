Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01A06C1A12
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjCTPoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjCTPnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:43:46 -0400
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3DF3D92C;
        Mon, 20 Mar 2023 08:34:36 -0700 (PDT)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 20 Mar
 2023 18:34:24 +0300
Received: from localhost (10.0.253.157) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 20 Mar
 2023 18:34:24 +0300
From:   Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To:     David Rheinsberg <david.rheinsberg@gmail.com>
CC:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "David Herrmann" <dh.herrmann@gmail.com>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lvc-project@linuxtesting.org>
Subject: [PATCH] HID: wiimote: check completion in wiimod_battery_get_property
Date:   Mon, 20 Mar 2023 08:34:19 -0700
Message-ID: <20230320153419.9185-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.253.157]
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wiimote_cmd_wait() in wiimod_battery_get_property() may signal that the
task of getting specific battery property was interrupted or timed out.
There is no need to do any further computation in such cases, so just
return the error.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: dcf392313817 ("HID: wiimote: convert BATTERY to module")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 drivers/hid/hid-wiimote-modules.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index dbccdfa63916..9755718d9856 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -220,8 +220,10 @@ static int wiimod_battery_get_property(struct power_supply *psy,
 	wiiproto_req_status(wdata);
 	spin_unlock_irqrestore(&wdata->state.lock, flags);
 
-	wiimote_cmd_wait(wdata);
+	ret = wiimote_cmd_wait(wdata);
 	wiimote_cmd_release(wdata);
+	if (ret)
+		return ret;
 
 	spin_lock_irqsave(&wdata->state.lock, flags);
 	state = wdata->state.cmd_battery;
-- 
2.25.1

