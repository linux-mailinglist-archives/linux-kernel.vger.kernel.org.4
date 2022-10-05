Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBD85F5114
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 10:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiJEIny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 04:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiJEInt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 04:43:49 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BA1A754A2;
        Wed,  5 Oct 2022 01:43:47 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2958h9fL5022996, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2958h9fL5022996
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 5 Oct 2022 16:43:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 5 Oct 2022 16:43:37 +0800
Received: from localhost.localdomain (172.21.132.192) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 5 Oct 2022 16:43:36 +0800
From:   <hildawu@realtek.com>
To:     <marcel@holtmann.org>
CC:     <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <apusaka@chromium.org>, <yinghsu@chromium.org>,
        <max.chou@realtek.com>, <alex_lu@realsil.com.cn>,
        <kidman@realtek.com>
Subject: [PATCH v4 1/2] Bluetooth: btrtl: Add btrealtek data struct
Date:   Wed, 5 Oct 2022 16:43:30 +0800
Message-ID: <20221005084331.1001-2-hildawu@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221005084331.1001-1-hildawu@realtek.com>
References: <20221005084331.1001-1-hildawu@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.132.192]
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/05/2022 03:37:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzUgpFekyCAwMjo1OTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hilda Wu <hildawu@realtek.com>

This patch adds a data structure for btrealtek object, and the
definition of vendor behavior flags. It also adds macros to set/test/get
the flags.

Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
Changes in v4:
 - Since the original 0002 patch has no dependency with this 0001 patch.
   So let the 0002 patch submit another.

Changes in v3:
 - Update private flag.

Changes in v2:
 - Set the proper priv_size to hci_alloc_dev_priv().
 - Separate commits for functions.
---
---
 drivers/bluetooth/btrtl.h | 21 +++++++++++++++++++++
 drivers/bluetooth/btusb.c |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
index 2c441bda390a..ebf0101c959b 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -47,6 +47,27 @@ struct rtl_vendor_config {
 	struct rtl_vendor_config_entry entry[];
 } __packed;
 
+enum {
+	REALTEK_ALT6_CONTINUOUS_TX_CHIP,
+
+	__REALTEK_NUM_FLAGS,
+};
+
+struct btrealtek_data {
+	DECLARE_BITMAP(flags, __REALTEK_NUM_FLAGS);
+};
+
+#define btrealtek_set_flag(hdev, nr)					\
+	do {								\
+		struct btrealtek_data *realtek = hci_get_priv((hdev));	\
+		set_bit((nr), realtek->flags);				\
+	} while (0)
+
+#define btrealtek_get_flag(hdev)					\
+	(((struct btrealtek_data *)hci_get_priv(hdev))->flags)
+
+#define btrealtek_test_flag(hdev, nr)	test_bit((nr), btrealtek_get_flag(hdev))
+
 #if IS_ENABLED(CONFIG_BT_RTL)
 
 struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 271963805a38..4243936c0583 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3755,6 +3755,9 @@ static int btusb_probe(struct usb_interface *intf,
 		/* Override the rx handlers */
 		data->recv_event = btusb_recv_event_intel;
 		data->recv_bulk = btusb_recv_bulk_intel;
+	} else if (id->driver_info & BTUSB_REALTEK) {
+		/* Allocate extra space for Realtek device */
+		priv_size += sizeof(struct btrealtek_data);
 	}
 
 	data->recv_acl = hci_recv_frame;
-- 
2.17.1

