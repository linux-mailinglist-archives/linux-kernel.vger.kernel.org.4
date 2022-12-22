Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE1F654804
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 22:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiLVVqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 16:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiLVVqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 16:46:19 -0500
Received: from gw.red-soft.ru (red-soft.ru [188.246.186.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE596DF3F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 13:46:16 -0800 (PST)
Received: from localhost.biz (unknown [10.81.81.211])
        by gw.red-soft.ru (Postfix) with ESMTPA id 5B6473E00DC;
        Fri, 23 Dec 2022 00:46:14 +0300 (MSK)
From:   Artem Chernyshev <artem.chernyshev@red-soft.ru>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Artem Chernyshev <artem.chernyshev@red-soft.ru>,
        Michael Krufky <mkrufky@linuxtv.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] [media] mxl111sf: Check return value in mxl111sf_config_mpeg_in
Date:   Fri, 23 Dec 2022 00:46:07 +0300
Message-Id: <20221222214607.39737-1-artem.chernyshev@red-soft.ru>
X-Mailer: git-send-email 2.30.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 174354 [Dec 22 2022]
X-KLMS-AntiSpam-Version: 5.9.59.0
X-KLMS-AntiSpam-Envelope-From: artem.chernyshev@red-soft.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 502 502 69dee8ef46717dd3cb3eeb129cb7cc8dab9e30f6, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;localhost.biz:7.1.1;red-soft.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2022/12/22 20:41:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2022/12/22 19:14:00 #20697826
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Error check after mxl111sf_read_reg

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 4c66c9205c07 ("[media] dvb-usb: add ATSC support for the Hauppauge WinTV-Aero-M")
Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
---
 drivers/media/usb/dvb-usb-v2/mxl111sf-phy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb-v2/mxl111sf-phy.c b/drivers/media/usb/dvb-usb-v2/mxl111sf-phy.c
index 40b26712ba4c..ad1888514bd0 100644
--- a/drivers/media/usb/dvb-usb-v2/mxl111sf-phy.c
+++ b/drivers/media/usb/dvb-usb-v2/mxl111sf-phy.c
@@ -121,7 +121,8 @@ int mxl111sf_config_mpeg_in(struct mxl111sf_state *state,
 	mxl_fail(ret);
 
 	/* Configure MPEG Clock phase */
-	mxl111sf_read_reg(state, V6_MPEG_IN_CLK_INV_REG, &mode);
+	ret = mxl111sf_read_reg(state, V6_MPEG_IN_CLK_INV_REG, &mode);
+	mxl_fail(ret);
 
 	if (clock_phase == TSIF_NORMAL)
 		mode &= ~V6_INVERTED_CLK_PHASE;
-- 
2.30.3

