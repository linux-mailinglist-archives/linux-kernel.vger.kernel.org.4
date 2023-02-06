Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B522968BF0A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjBFN7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjBFN7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:59:04 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B7B212BA;
        Mon,  6 Feb 2023 05:58:19 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id D244E60005;
        Mon,  6 Feb 2023 13:58:14 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: [PATCH 2/3] HID: logitech-hidpp: Retry commands when device is busy
Date:   Mon,  6 Feb 2023 14:58:07 +0100
Message-Id: <20230206135808.8840-2-hadess@hadess.net>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206135808.8840-1-hadess@hadess.net>
References: <20230206135808.8840-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle the busy error coming from the device or receiver. The
documentation says a busy error can be returned when:
"
Device (or receiver) cannot answer immediately to this request
for any reason i.e:
- already processing a request from the same or another SW
- pipe full
"

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/hid/hid-logitech-hidpp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 6386d3f023ca..ef497a82fe4e 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -295,6 +295,7 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
 	 */
 	*response = *message;
 
+retry:
 	ret = __hidpp_send_report(hidpp->hid_dev, message);
 
 	if (ret) {
@@ -321,6 +322,10 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
 			response->report_id == REPORT_ID_HIDPP_VERY_LONG) &&
 			response->fap.feature_index == HIDPP20_ERROR) {
 		ret = response->fap.params[1];
+		if (ret == HIDPP20_ERROR_BUSY) {
+			dbg_hid("%s:got busy hidpp 2.0 error %02X, retrying\n", __func__, ret);
+			goto retry;
+		}
 		dbg_hid("%s:got hidpp 2.0 error %02X\n", __func__, ret);
 		goto exit;
 	}
-- 
2.39.1

