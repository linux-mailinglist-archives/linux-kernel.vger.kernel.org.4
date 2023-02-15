Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D64B698137
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjBOQs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBOQsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:48:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3378685;
        Wed, 15 Feb 2023 08:48:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A67A61CBC;
        Wed, 15 Feb 2023 16:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D23FBC433D2;
        Wed, 15 Feb 2023 16:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676479732;
        bh=vExtuAthxfCRzwSuy6MlSMGY3hLpzHHXxS5asALtauE=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=pu0lsh3DhDBLoTy7xD5Z6YuVK4b/NV6u1ZnB/P7cHyzEGx1xoo5xJGYPilSctt4mq
         VV3DyM3jraXkTOFPyCGyN+uw07P6VNncCyNydw2s3xVEJhAbFFKx0cOv7AlIsscxen
         ByBltL0y6cMB+vtZxdu8F7pp7ddz3EzlNQHmS3igGjCDKalhhWSW6EonLAABd1L5li
         F0SArS78kXizbuRSHG4HoZlmx/E95Z1SFnqjeuLSvhg5m7OLvnK9ruY5uYYK+YKRyO
         IO8qDMkSmft9WjuFDZHqR2y/19cYEJB+hekEjHNgNGAq1mHK5ttml1aH4ssSPdtSep
         Yr5J4FEdxeZWA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id BEF39C636CC;
        Wed, 15 Feb 2023 16:48:52 +0000 (UTC)
From:   Benjamin Tissoires via B4 Submission Endpoint 
        <devnull+benjamin.tissoires.redhat.com@kernel.org>
Date:   Wed, 15 Feb 2023 17:48:36 +0100
Subject: [PATCH] HID: mcp-2221: prevent UAF in delayed work
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-wip-mcp2221-v1-1-d7d1da261a5c@redhat.com>
X-B4-Tracking: v=1; b=H4sIAOMM7WMC/x2NywqDMBAAf0X23AV3bRD9ldJDEldd0DQk9AHiv
 7v0OAPDHFClqFQYmwOKfLTqKxnQrYG4+rQI6mQM3HLXMjn8asY9ZmYmHPphuhM5mYMDK4KvgqH
 4FFdr0nvbTOYis/7+i8fzPC9zHK4GcgAAAA==
To:     Rishi Gupta <gupt21@gmail.com>, Jiri Kosina <jikos@kernel.org>,
        Pietro Borrello <borrello@diag.uniroma1.it>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676479731; l=2755;
 i=benjamin.tissoires@redhat.com; s=20230215; h=from:subject:message-id;
 bh=ZAV9AC74hbxWCBTTNRrOTw2lYGjCcjlsI2cLyvC0tkA=;
 b=E4ih/2BE+S5H93iNdEsJpXCj47czOefRfS92Rf51/q8F5Neke3bwRdncxQL3Enm/A2fo4dU8W
 vnJd4ic/7AnABiMd5nULcqmerv48V8UwhSSpIDRBwe4Oaq18tv+7UuK
X-Developer-Key: i=benjamin.tissoires@redhat.com; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=
X-Endpoint-Received: by B4 Submission Endpoint for
 benjamin.tissoires@redhat.com/20230215 with auth_id=29
X-Original-From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Reply-To: <benjamin.tissoires@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

If the device is plugged/unplugged without giving time for mcp_init_work()
to complete, we might kick in the devm free code path and thus have
unavailable struct mcp_2221 while in delayed work.

Add a boolean and a spinlock to prevent scheduling the deleyed work if
we are in the operation of removing the device.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
Similar to Pietro's series, we can see the pattern in hid-mcp2221,
except that this time the ledclass is not involved.

Link: https://lore.kernel.org/linux-input/20230125-hid-unregister-leds-v4-5-7860c5763c38@diag.uniroma1.it/
---
 drivers/hid/hid-mcp2221.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index e61dd039354b..de8b988f4a48 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -95,6 +95,8 @@ struct mcp2221 {
 	struct mutex lock;
 	struct completion wait_in_report;
 	struct delayed_work init_work;
+	spinlock_t init_work_lock;
+	bool removing;
 	u8 *rxbuf;
 	u8 txbuf[64];
 	int rxbuf_idx;
@@ -922,6 +924,14 @@ static void mcp2221_hid_unregister(void *ptr)
 /* This is needed to be sure hid_hw_stop() isn't called twice by the subsystem */
 static void mcp2221_remove(struct hid_device *hdev)
 {
+	struct mcp2221 *mcp = hid_get_drvdata(hdev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&mcp->init_work_lock, flags);
+	mcp->removing = true;
+	spin_unlock_irqrestore(&mcp->init_work_lock, flags);
+
+	cancel_delayed_work_sync(&mcp->init_work);
 }
 
 #if IS_REACHABLE(CONFIG_IIO)
@@ -1040,6 +1050,7 @@ static void mcp_init_work(struct work_struct *work)
 	struct mcp2221_iio *data;
 	static int retries = 5;
 	int ret, num_channels;
+	unsigned long flags;
 
 	hid_hw_power(mcp->hdev, PM_HINT_FULLON);
 	mutex_lock(&mcp->lock);
@@ -1090,7 +1101,10 @@ static void mcp_init_work(struct work_struct *work)
 		return;
 
 	/* Device is not ready to read SRAM or FLASH data, try again */
-	schedule_delayed_work(&mcp->init_work, msecs_to_jiffies(100));
+	spin_lock_irqsave(&mcp->init_work_lock, flags);
+	if (!mcp->removing)
+		schedule_delayed_work(&mcp->init_work, msecs_to_jiffies(100));
+	spin_unlock_irqrestore(&mcp->init_work_lock, flags);
 }
 #endif
 
@@ -1131,6 +1145,7 @@ static int mcp2221_probe(struct hid_device *hdev,
 	}
 
 	mutex_init(&mcp->lock);
+	spin_lock_init(&mcp->init_work_lock);
 	init_completion(&mcp->wait_in_report);
 	hid_set_drvdata(hdev, mcp);
 	mcp->hdev = hdev;

---
base-commit: d883fd110dc17308a1506c5bf17e00ce9fe7b2a2
change-id: 20230215-wip-mcp2221-979d4115efb5

Best regards,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

