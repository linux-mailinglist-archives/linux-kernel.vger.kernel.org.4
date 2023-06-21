Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7017381B6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjFUJne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjFUJn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:43:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47187DD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687340563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Diofrp0NHoaj7laq9s3ordTMEyCXaD8juDW832/O7Eo=;
        b=PLGFNbAP7wkxSvzu3PjrjD5k9tQvm/H+0Ya+K765u3vdj9RCvpfftxbg4NF3gnaMFLBRcC
        gZ/wIoGI59Zepa7O0C2qdLdcaPZ+UjP+f+Leu4HdS8L5xyMLtMzUum+LvpnJk0MCu306/y
        efekes/8JJ0+zC8p96X1vEgumqPKUXA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-HGWhI5BMPYuDye4tb2GKqA-1; Wed, 21 Jun 2023 05:42:37 -0400
X-MC-Unique: HGWhI5BMPYuDye4tb2GKqA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D67FE3C108C7;
        Wed, 21 Jun 2023 09:42:36 +0000 (UTC)
Received: from xps-13.local (unknown [10.39.193.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B064B492C13;
        Wed, 21 Jun 2023 09:42:35 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 21 Jun 2023 11:42:30 +0200
Subject: [PATCH] HID: logitech-hidpp: rework one more time the retries
 attempts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-logitech-fixes-v1-1-32e70933c0b0@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAXGkmQC/1WLwQrCMBAFfyXs2YU0Sg79Felhmz6bBUlLVkQI/
 XdTPHmbgZlGhqowGl2jireabqXLcHGUspQVrEt3Cj5cfQwDP7dVX0iZH/qBsdySR4yQIAv1aRY
 Dz1VKyuf2X5/BXvHj0d2n4/gCP4LGsIEAAAA=
To:     =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        Jiri Kosina <jikos@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687340555; l=5291;
 i=benjamin.tissoires@redhat.com; s=20230215; h=from:subject:message-id;
 bh=UiFLHp8Bq+QvatTIh2AbpNG2HYSjT6YexmSDYyCrUEI=;
 b=KeKGHpo0AAjoH0Qsj9oVKHMco9aHBn3E18cRfEinhSz88nk6+rbZWg4Lvan7cLxYgeFPsdXhu
 ZavHFrOSuL6DpHgPQp9d00y7PICetBA8nUho1RWGTeEBE01mKfDNwTI
X-Developer-Key: i=benjamin.tissoires@redhat.com; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the code looks less like Pascal.

Extract the internal code inside a helper function, fix the
initialization of the parameters used in the helper function
(`hidpp->answer_available` was not reset and `*response` wasn't too),
and use a `do {...} while();` loop.

Fixes: 586e8fede795 ("HID: logitech-hidpp: Retry commands when device is busy")
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
as requested by https://lore.kernel.org/all/CAHk-=wiMbF38KCNhPFiargenpSBoecSXTLQACKS2UMyo_Vu2ww@mail.gmail.com/
This is a rewrite of that particular piece of code.
---
 drivers/hid/hid-logitech-hidpp.c | 102 +++++++++++++++++++++++----------------
 1 file changed, 61 insertions(+), 41 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index dfe8e09a18de..3d1ffe199f08 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -275,21 +275,20 @@ static int __hidpp_send_report(struct hid_device *hdev,
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
-
-	mutex_lock(&hidpp->send_mutex);
+	int ret;
 
 	hidpp->send_receive_buf = response;
 	hidpp->answer_available = false;
@@ -300,41 +299,62 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
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
+ * - If ' something else' is positive, that means that an error has been raised
+ *   by the protocol itself.
+ * - If ' something else' is negative, that means that we had a classic error
+ *   (-ENOMEM, -EPIPE, etc...)
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

---
base-commit: b98ec211af5508457e2b1c4cc99373630a83fa81
change-id: 20230621-logitech-fixes-a4c0e66ea2ad

Best regards,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

