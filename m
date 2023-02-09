Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A38690D8C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjBIPtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjBIPtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:49:40 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9F42887C;
        Thu,  9 Feb 2023 07:49:26 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 86D76240005;
        Thu,  9 Feb 2023 15:49:21 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: [PATCH v3 1/2] HID: logitech-hidpp: Retry commands when device is busy
Date:   Thu,  9 Feb 2023 16:49:15 +0100
Message-Id: <20230209154916.462158-1-hadess@hadess.net>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Use a bounded for loop instead of a goto, to avoid infinite loops.

 drivers/hid/hid-logitech-hidpp.c | 54 ++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 1952d8d3b6b2..ff427d7a0fa0 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -283,6 +283,7 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
 	struct hidpp_report *response)
 {
 	int ret;
+	int max_retries = 3;
 
 	mutex_lock(&hidpp->send_mutex);
 
@@ -295,34 +296,39 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
 	 */
 	*response = *message;
 
-	ret = __hidpp_send_report(hidpp->hid_dev, message);
+	for (; max_retries != 0; max_retries--) {
+		ret = __hidpp_send_report(hidpp->hid_dev, message);
 
-	if (ret) {
-		dbg_hid("__hidpp_send_report returned err: %d\n", ret);
-		memset(response, 0, sizeof(struct hidpp_report));
-		goto exit;
-	}
+		if (ret) {
+			dbg_hid("__hidpp_send_report returned err: %d\n", ret);
+			memset(response, 0, sizeof(struct hidpp_report));
+			goto exit;
+		}
 
-	if (!wait_event_timeout(hidpp->wait, hidpp->answer_available,
-				5*HZ)) {
-		dbg_hid("%s:timeout waiting for response\n", __func__);
-		memset(response, 0, sizeof(struct hidpp_report));
-		ret = -ETIMEDOUT;
-	}
+		if (!wait_event_timeout(hidpp->wait, hidpp->answer_available,
+					5*HZ)) {
+			dbg_hid("%s:timeout waiting for response\n", __func__);
+			memset(response, 0, sizeof(struct hidpp_report));
+			ret = -ETIMEDOUT;
+		}
 
-	if (response->report_id == REPORT_ID_HIDPP_SHORT &&
-	    response->rap.sub_id == HIDPP_ERROR) {
-		ret = response->rap.params[1];
-		dbg_hid("%s:got hidpp error %02X\n", __func__, ret);
-		goto exit;
-	}
+		if (response->report_id == REPORT_ID_HIDPP_SHORT &&
+		    response->rap.sub_id == HIDPP_ERROR) {
+			ret = response->rap.params[1];
+			dbg_hid("%s:got hidpp error %02X\n", __func__, ret);
+			goto exit;
+		}
 
-	if ((response->report_id == REPORT_ID_HIDPP_LONG ||
-			response->report_id == REPORT_ID_HIDPP_VERY_LONG) &&
-			response->fap.feature_index == HIDPP20_ERROR) {
-		ret = response->fap.params[1];
-		dbg_hid("%s:got hidpp 2.0 error %02X\n", __func__, ret);
-		goto exit;
+		if ((response->report_id == REPORT_ID_HIDPP_LONG ||
+		     response->report_id == REPORT_ID_HIDPP_VERY_LONG) &&
+		    response->fap.feature_index == HIDPP20_ERROR) {
+			ret = response->fap.params[1];
+			if (ret != HIDPP20_ERROR_BUSY) {
+				dbg_hid("%s:got hidpp 2.0 error %02X\n", __func__, ret);
+				goto exit;
+			}
+			dbg_hid("%s:got busy hidpp 2.0 error %02X, retrying\n", __func__, ret);
+		}
 	}
 
 exit:
-- 
2.39.1

