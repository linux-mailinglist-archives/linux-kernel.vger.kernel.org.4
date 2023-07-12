Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15167750BAA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjGLPCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjGLPCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:02:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3561BC6;
        Wed, 12 Jul 2023 08:02:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D4EB61838;
        Wed, 12 Jul 2023 15:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7B0C433C7;
        Wed, 12 Jul 2023 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689174166;
        bh=6Xg22ZHymwYTmng19kOz5rdixVHrp7FECHVhi5ZVNRY=;
        h=From:Date:Subject:To:Cc:From;
        b=RkS9IpV+zDCLI/qcDefAVyreomkcdm4E/iiUhgVEcqGYlU6WR81R4FlrKnfdSn48B
         QY43TuYTGy7XFAkKfsDb1/oHWn+rYAUHQxfezHdxG/qzeU5lpSRcnYOWGcRA9jtGUX
         Dk3HbZGDpKp3Bu8EBY7uDDrO6tRgoRMWRcq7dGoWYbV9hyxVey7eRkLZsDBzHbo0q8
         1NXCLt3mrK8YNy94XyMUtq+Yg+kyq3KxWwBW/vTtMOfibzBq0q8+p8Qcefm4ZiWdey
         SDh7Cb5SR1nCHYEdWWEZUCISIRfwtzcSRuI6ZFFPT4yGKz5vcE2FsBc0RZz+KEF2p9
         fCSYxWW4CzhAA==
From:   bentiss@kernel.org
Date:   Wed, 12 Jul 2023 17:02:34 +0200
Subject: [PATCH v2] HID: logitech-hidpp: rework one more time the retries
 attempts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-logitech-fixes-v2-1-3635f7f9c8af@kernel.org>
X-B4-Tracking: v=1; b=H4sIAInArmQC/3WOzQrCMBCEX6Xs2ZX8SMSefA/pYZuuzYI2kpSil
 L67iZ48eJtvmGFmhcxJOEPbrJB4kSxxKmB2DfhA08goQ2EwyljljMZbHGVmH/AqT85IB6/YOSZ
 DA5RST5mxTzT5UGu/6Rp4JP7qtrl0hYPkOabX58Ciq/t3a9Go0Ro+qpO1XvXqnHgINO99vEO3b
 dsbEOsRNM4AAAA=
To:     =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        Jiri Kosina <jikos@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689174165; l=6340;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=2070mtrzbWq9KfMRTaYvRvQiS5vfxAiTPm79NPC/Fuo=;
 b=Q5UUrM9a43lmJebEn1JjZ1ypKSXWU+c4okJDTVF7PoOOff95alcWbFUJaS86JAgqvChxHRKpL
 Sj7/1yD/h1NDwLEQpDL7l6nYdVdkdFFtFih0r0bsoCBURXehwLJleWX
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Extract the internal code inside a helper function, fix the
initialization of the parameters used in the helper function
(`hidpp->answer_available` was not reset and `*response` wasn't either),
and use a `do {...} while();` loop.

Fixes: 586e8fede795 ("HID: logitech-hidpp: Retry commands when device is busy")
Cc: stable@vger.kernel.org
Reviewed-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
as requested by https://lore.kernel.org/all/CAHk-=wiMbF38KCNhPFiargenpSBoecSXTLQACKS2UMyo_Vu2ww@mail.gmail.com/
This is a rewrite of that particular piece of code.
---
Changes in v2:
- added __must_hold() for KASAN
- Reworked the comment describing the functions and their return values
- Link to v1: https://lore.kernel.org/r/20230621-logitech-fixes-v1-1-32e70933c0b0@redhat.com
---
 drivers/hid/hid-logitech-hidpp.c | 115 +++++++++++++++++++++++++--------------
 1 file changed, 75 insertions(+), 40 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 129b01be488d..09ba2086c95c 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -275,21 +275,22 @@ static int __hidpp_send_report(struct hid_device *hdev,
 }
 
 /*
- * hidpp_send_message_sync() returns 0 in case of success, and something else
- * in case of a failure.
- * - If ' something else' is positive, that means that an error has been raised
- *   by the protocol itself.
- * - If ' something else' is negative, that means that we had a classic error
- *   (-ENOMEM, -EPIPE, etc...)
+ * Effectively send the message to the device, waiting for its answer.
+ *
+ * Must be called with hidpp->send_mutex locked
+ *
+ * Same return protocol than hidpp_send_message_sync():
+ * - success on 0
+ * - negative error means transport error
+ * - positive value means protocol error
  */
-static int hidpp_send_message_sync(struct hidpp_device *hidpp,
+static int __do_hidpp_send_message_sync(struct hidpp_device *hidpp,
 	struct hidpp_report *message,
 	struct hidpp_report *response)
 {
-	int ret = -1;
-	int max_retries = 3;
+	int ret;
 
-	mutex_lock(&hidpp->send_mutex);
+	__must_hold(&hidpp->send_mutex);
 
 	hidpp->send_receive_buf = response;
 	hidpp->answer_available = false;
@@ -300,47 +301,74 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
 	 */
 	*response = *message;
 
-	for (; max_retries != 0 && ret; max_retries--) {
-		ret = __hidpp_send_report(hidpp->hid_dev, message);
+	ret = __hidpp_send_report(hidpp->hid_dev, message);
+	if (ret) {
+		dbg_hid("__hidpp_send_report returned err: %d\n", ret);
+		memset(response, 0, sizeof(struct hidpp_report));
+		return ret;
+	}
 
-		if (ret) {
-			dbg_hid("__hidpp_send_report returned err: %d\n", ret);
-			memset(response, 0, sizeof(struct hidpp_report));
-			break;
-		}
+	if (!wait_event_timeout(hidpp->wait, hidpp->answer_available,
+				5*HZ)) {
+		dbg_hid("%s:timeout waiting for response\n", __func__);
+		memset(response, 0, sizeof(struct hidpp_report));
+		return -ETIMEDOUT;
+	}
 
-		if (!wait_event_timeout(hidpp->wait, hidpp->answer_available,
-					5*HZ)) {
-			dbg_hid("%s:timeout waiting for response\n", __func__);
-			memset(response, 0, sizeof(struct hidpp_report));
-			ret = -ETIMEDOUT;
-			break;
-		}
+	if (response->report_id == REPORT_ID_HIDPP_SHORT &&
+	    response->rap.sub_id == HIDPP_ERROR) {
+		ret = response->rap.params[1];
+		dbg_hid("%s:got hidpp error %02X\n", __func__, ret);
+		return ret;
+	}
 
-		if (response->report_id == REPORT_ID_HIDPP_SHORT &&
-		    response->rap.sub_id == HIDPP_ERROR) {
-			ret = response->rap.params[1];
-			dbg_hid("%s:got hidpp error %02X\n", __func__, ret);
+	if ((response->report_id == REPORT_ID_HIDPP_LONG ||
+	     response->report_id == REPORT_ID_HIDPP_VERY_LONG) &&
+	    response->fap.feature_index == HIDPP20_ERROR) {
+		ret = response->fap.params[1];
+		dbg_hid("%s:got hidpp 2.0 error %02X\n", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * hidpp_send_message_sync() returns 0 in case of success, and something else
+ * in case of a failure.
+ *
+ * See __do_hidpp_send_message_sync() for a detailed explanation of the returned
+ * value.
+ */
+static int hidpp_send_message_sync(struct hidpp_device *hidpp,
+	struct hidpp_report *message,
+	struct hidpp_report *response)
+{
+	int ret;
+	int max_retries = 3;
+
+	mutex_lock(&hidpp->send_mutex);
+
+	do {
+		ret = __do_hidpp_send_message_sync(hidpp, message, response);
+		if (ret != HIDPP20_ERROR_BUSY)
 			break;
-		}
 
-		if ((response->report_id == REPORT_ID_HIDPP_LONG ||
-		     response->report_id == REPORT_ID_HIDPP_VERY_LONG) &&
-		    response->fap.feature_index == HIDPP20_ERROR) {
-			ret = response->fap.params[1];
-			if (ret != HIDPP20_ERROR_BUSY) {
-				dbg_hid("%s:got hidpp 2.0 error %02X\n", __func__, ret);
-				break;
-			}
-			dbg_hid("%s:got busy hidpp 2.0 error %02X, retrying\n", __func__, ret);
-		}
-	}
+		dbg_hid("%s:got busy hidpp 2.0 error %02X, retrying\n", __func__, ret);
+	} while (--max_retries);
 
 	mutex_unlock(&hidpp->send_mutex);
 	return ret;
 
 }
 
+/*
+ * hidpp_send_fap_command_sync() returns 0 in case of success, and something else
+ * in case of a failure.
+ *
+ * See __do_hidpp_send_message_sync() for a detailed explanation of the returned
+ * value.
+ */
 static int hidpp_send_fap_command_sync(struct hidpp_device *hidpp,
 	u8 feat_index, u8 funcindex_clientid, u8 *params, int param_count,
 	struct hidpp_report *response)
@@ -373,6 +401,13 @@ static int hidpp_send_fap_command_sync(struct hidpp_device *hidpp,
 	return ret;
 }
 
+/*
+ * hidpp_send_rap_command_sync() returns 0 in case of success, and something else
+ * in case of a failure.
+ *
+ * See __do_hidpp_send_message_sync() for a detailed explanation of the returned
+ * value.
+ */
 static int hidpp_send_rap_command_sync(struct hidpp_device *hidpp_dev,
 	u8 report_id, u8 sub_id, u8 reg_address, u8 *params, int param_count,
 	struct hidpp_report *response)

---
base-commit: 87854366176403438d01f368b09de3ec2234e0f5
change-id: 20230621-logitech-fixes-a4c0e66ea2ad

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>

