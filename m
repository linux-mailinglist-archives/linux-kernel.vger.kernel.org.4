Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4354F6F958B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 02:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjEGAer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 20:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjEGAeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 20:34:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82341A4A6;
        Sat,  6 May 2023 17:33:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8FE86137B;
        Sun,  7 May 2023 00:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F54C4339B;
        Sun,  7 May 2023 00:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683419616;
        bh=0QX/meDyfmoM/Y67RPO4VB4YiTpG5JcPS1RmpJ97ARE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U8pIxFx2MFz7dpvB8m1DE0QM18gWZmjnjnCdWb+A1Zi31eLGcTFmWlu1rFyvPrzSk
         GuXm9weHP+lp6M2qcC4vqALN2voXF3WPqcpJgEH3wP8RRI3QNzeLG4qpWuGr50xSln
         pekwlIBPudvaCU3n+veeW+j3GJnoMMnGdpMMadxLkqcQEYHbvvAeXmIfQaZe7Q+2Aa
         9yGnC9s/SFYLBC7LkeIpFZzLmBNCQd5kcISOvrQvqk70b5XZJd7WI/wWZrB7qQkwAZ
         69XWrWc/f5Qy/894rydyLsF3jkCUMo54+HbcubRSDmaEUlTG2RAt0Buw1AoWNC02wc
         3fUL+h07gQZGA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     weiliang1503 <weiliang1503@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sasha Levin <sashal@kernel.org>, jikos@kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 16/20] HID: Ignore battery for ELAN touchscreen on ROG Flow X13 GV301RA
Date:   Sat,  6 May 2023 20:32:31 -0400
Message-Id: <20230507003237.4074305-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507003237.4074305-1-sashal@kernel.org>
References: <20230507003237.4074305-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: weiliang1503 <weiliang1503@gmail.com>

[ Upstream commit 35903009dbde804a1565dc89e431c0f15179f054 ]

Ignore the reported battery level of the built-in touchscreen to suppress
battery warnings when a stylus is used. The device ID was added and the
battery ignore quirk was enabled.

Signed-off-by: weiliang1503 <weiliang1503@gmail.com>
Link: https://lore.kernel.org/r/20230330115638.16146-1-weiliang1503@gmail.com
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h   | 1 +
 drivers/hid/hid-input.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 2235d78784b1b..53c6692d77714 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -415,6 +415,7 @@
 #define I2C_DEVICE_ID_HP_SPECTRE_X360_15	0x2817
 #define I2C_DEVICE_ID_HP_SPECTRE_X360_13_AW0020NG  0x29DF
 #define I2C_DEVICE_ID_ASUS_TP420IA_TOUCHSCREEN 0x2BC8
+#define I2C_DEVICE_ID_ASUS_GV301RA_TOUCHSCREEN 0x2C82
 #define USB_DEVICE_ID_ASUS_UX550VE_TOUCHSCREEN	0x2544
 #define USB_DEVICE_ID_ASUS_UX550_TOUCHSCREEN	0x2706
 #define I2C_DEVICE_ID_SURFACE_GO_TOUCHSCREEN	0x261A
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index c3c7d0abb01ad..071d2f3aaf27f 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -372,6 +372,8 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_ASUS_TP420IA_TOUCHSCREEN),
 	  HID_BATTERY_QUIRK_IGNORE },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_ASUS_GV301RA_TOUCHSCREEN),
+	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ASUS_UX550_TOUCHSCREEN),
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ASUS_UX550VE_TOUCHSCREEN),
-- 
2.39.2

