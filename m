Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBFD62DA5D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbiKQML5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239982AbiKQMLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:11:52 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93346E579;
        Thu, 17 Nov 2022 04:11:50 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id a29so2439555lfj.9;
        Thu, 17 Nov 2022 04:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fvAW3QWfUB+ZRXw7GQnabgmGHjk0bbcFTzdS5NeGHzY=;
        b=C7uJ0cx9ggyreToG9gcrAMQhBSyIzs+ls96OriZEul48TPbg1IgQyPPIze5fsrTx84
         7Hj4kz7BsIMz62520ZnJI7gQyy6S7tuv/dKfFFtAPH7GTc3or1R0JN8gQEuwkycNCAN3
         1K/mIN5aOAxCdwoIp5s0HWIeLofo+UyQR01k1m8VMGfU6xbMyUL724myAYKfKyioc+JT
         rDdEsmK9AY64yQy2LshJEuw2scY1Ad8YP0oC9YT4YP027Vf4BC3AOH5ruZmsD9H+Fwfy
         nHmxvR0wRWUpavG8RRu0OMD94GDr8CXAw2yvqyf9PTvNC+ebh7WVNhXtp0v+AMyGaLWJ
         Br8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvAW3QWfUB+ZRXw7GQnabgmGHjk0bbcFTzdS5NeGHzY=;
        b=sWhU8zbMp6p+CIuD3H7s6grIbGXdg4UO3dXO0q018oxQ4oHOflea8WPkyoisGeHPFT
         qJDhbjfLss94jSOUt9jQi40jQepQnCWJxPO/jHmBMeMsdQ1K4O07i+kbSziUmggzFc5G
         OJrs+jBZQc6ESFjegZCMLewlP8L82ADjTTafn7cmjSALtEkPCDRkC8xg3qxRcQC9xCcZ
         Td0D1989p5ty+13DTRSVH3NlL32ITswK43x6DEBl9xQNAHhnUcGvsEgxBUs4w4gu2xwC
         EUX6KibDU/NGld/+N5RxMMudksWm7oKN8Irtwkuqekf2n662eIyJqeckFgWJvZxwdID2
         DNcQ==
X-Gm-Message-State: ANoB5pkroCrLsGMwES0VE3xDhcQ93fddbnBHPeRIiDrck0+gLUpNlGoQ
        V9gK3McieWPHxfdNd2610lw=
X-Google-Smtp-Source: AA0mqf5GhB75MjBiceXBvCuZIH5c3Zh03VDGGyqDfDC8g1rB4okdbuRRnRi+kIpynfNLDfCudrygaA==
X-Received: by 2002:a05:6512:3084:b0:4aa:83e6:53e4 with SMTP id z4-20020a056512308400b004aa83e653e4mr761123lfd.13.1668687109201;
        Thu, 17 Nov 2022 04:11:49 -0800 (PST)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id s15-20020a056512214f00b004a8b9c68735sm121152lfr.102.2022.11.17.04.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 04:11:48 -0800 (PST)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH v2] HID: hid-cmedia: use device managed resources
Date:   Thu, 17 Nov 2022 13:13:04 +0100
Message-Id: <20221117121304.5516-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we do not need to free() any memory in .remove, we can remove
cmhid_remove as well.
hid_device_remove() will call hid_hw_stop() as default .remove function
if no function is specified.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/hid/hid-cmedia.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/hid/hid-cmedia.c b/drivers/hid/hid-cmedia.c
index cab42047bc99..8b0007168afb 100644
--- a/drivers/hid/hid-cmedia.c
+++ b/drivers/hid/hid-cmedia.c
@@ -145,11 +145,9 @@ static int cmhid_probe(struct hid_device *hid, const struct hid_device_id *id)
 	int ret;
 	struct cmhid *cm;
 
-	cm = kzalloc(sizeof(struct cmhid), GFP_KERNEL);
-	if (!cm) {
-		ret = -ENOMEM;
-		goto allocfail;
-	}
+	cm = devm_kzalloc(&hid->dev, sizeof(struct cmhid), GFP_KERNEL);
+	if (!cm)
+		return -ENOMEM;
 
 	cm->hid = hid;
 
@@ -159,30 +157,16 @@ static int cmhid_probe(struct hid_device *hid, const struct hid_device_id *id)
 	ret = hid_parse(hid);
 	if (ret) {
 		hid_err(hid, "parse failed\n");
-		goto fail;
+		return ret;
 	}
 
 	ret = hid_hw_start(hid, HID_CONNECT_DEFAULT | HID_CONNECT_HIDDEV_FORCE);
-	if (ret) {
+	if (ret)
 		hid_err(hid, "hw start failed\n");
-		goto fail;
-	}
 
-	return 0;
-fail:
-	kfree(cm);
-allocfail:
 	return ret;
 }
 
-static void cmhid_remove(struct hid_device *hid)
-{
-	struct cmhid *cm = hid_get_drvdata(hid);
-
-	hid_hw_stop(hid);
-	kfree(cm);
-}
-
 static const struct hid_device_id cmhid_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CMEDIA, USB_DEVICE_ID_CM6533) },
 	{ }
@@ -195,7 +179,6 @@ static struct hid_driver cmhid_driver = {
 	.raw_event = cmhid_raw_event,
 	.input_configured = cmhid_input_configured,
 	.probe = cmhid_probe,
-	.remove = cmhid_remove,
 	.input_mapping = cmhid_input_mapping,
 };
 
-- 
2.38.1

