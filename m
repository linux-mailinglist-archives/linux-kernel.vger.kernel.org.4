Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C595F01C3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 02:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiI3AYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 20:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiI3AYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 20:24:06 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4C6200B37;
        Thu, 29 Sep 2022 17:24:00 -0700 (PDT)
X-UUID: f912db50b0074cefa129b9143915147c-20220930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=seQkg8Lz/XQJdKUNfXFDPMV7HUNf9Xo0G6liQDdyalU=;
        b=kjWosQ2dKlKfNJByUUVenVZ9aDrLYELMyAl8pNeEHl15aUQLT3B/p9iJpGnzMfQuo60D4Kh+rzlQ9jzzeujPs+EZv8YJpHY62d5504ab+QUqsFmJZ5RpPVL+KDboZOA5kXdECatpcIJPEtkwv1SRY9urALroKg8YQ7Bjmd0FDxQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:ec7fe100-4dd3-4b81-ad24-d5d7afb2ad5c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.11,REQID:ec7fe100-4dd3-4b81-ad24-d5d7afb2ad5c,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:39a5ff1,CLOUDID:dc567e07-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:2209300823582B6YSQ8B,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|823|
        824,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:n
        il,COL:0
X-UUID: f912db50b0074cefa129b9143915147c-20220930
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 398339020; Fri, 30 Sep 2022 08:23:57 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 30 Sep 2022 08:23:55 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 30 Sep 2022 08:23:55 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <abhishekpandit@google.com>,
        <michaelfsun@google.com>, <abhishekpandit@chromium.org>,
        <mcchou@chromium.org>, <shawnku@google.com>,
        <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jing Cai <jing.cai@mediatek.com>
Subject: [PATCH v2 3/3] Bluetooth: btusb: mediatek: add MediaTek devcoredump support
Date:   Fri, 30 Sep 2022 08:23:49 +0800
Message-ID: <8130cc14237922f95e852fc14a6f90aed2f1117c.1664497281.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <ab8958da839ecadc0ebff9f0a221ef49a2e5a4cc.1664497281.git.objelf@gmail.com>
References: <ab8958da839ecadc0ebff9f0a221ef49a2e5a4cc.1664497281.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Cai <jing.cai@mediatek.com>

This patch implement function .coredump() and dmp_hdr() in btusb
driver for MediaTek controller.  FW core dump was triggered by FW
specific event to show something unexpected happened in the controller.

The driver would be responsible for collecting and uploading the device
core dump pieces in hci driver using core dump API. Once we finished
the whole process, the driver would reset the controller to recover the
kind of fatal error.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Jing Cai <jing.cai@mediatek.com>
---
The patch is built and tested on the top of the patches
[v6,1/3] Bluetooth: Add support for hci devcoredump
[v6,2/3] Bluetooth: btusb: Add btusb devcoredump support
[v6,3/3] Bluetooth: btintel: Add Intel devcoredump support
which are contributed from Manish Mandlik

v2: rebase onto the latest codebase
---
 drivers/bluetooth/btmtk.c | 124 ++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btmtk.h |  13 ++++
 drivers/bluetooth/btusb.c |  11 ++++
 3 files changed, 148 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 77df7b5c3ef3..2835ae28ae35 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -18,6 +18,14 @@
 #define MTK_FW_ROM_PATCH_SEC_MAP_SIZE	64
 #define MTK_SEC_MAP_COMMON_SIZE	12
 #define MTK_SEC_MAP_NEED_SEND_SIZE	52
+#define MTK_DRIVER_NAME_LEN		16
+#define MTK_COREDUMP_END		"coredump end"
+
+enum {
+	BTMTK_COREDUMP_INIT,
+	BTMTK_COREDUMP_DISABLED,
+	BTMTK_COREDUMP_ACTIVE,
+};
 
 struct btmtk_patch_header {
 	u8 datetime[16];
@@ -53,8 +61,65 @@ struct btmtk_section_map {
 	};
 } __packed;
 
+static struct btmtk_coredump_info {
+	struct hci_dev *hdev;
+	char driver_name[MTK_DRIVER_NAME_LEN];
+	u32 dev_id;
+	u32 fw_version;
+	int state;
+} coredump_info;
+
 static struct btmtk_reset_work reset_work;
 
+static void btmtk_coredump(struct hci_dev *hdev)
+{
+	int err;
+
+	err = __hci_cmd_send(hdev, 0xfd5b, 0, NULL);
+	if (err < 0)
+		bt_dev_err(hdev, "Coredump failed (%d)", err);
+}
+
+static int btmtk_coredump_hdr(struct hci_dev *hdev, char *buf, size_t size)
+{
+	char *ptr = buf;
+	size_t rem = size;
+	size_t read = 0;
+
+	read = snprintf(ptr, rem, "Controller Name: 0x%X\n", coredump_info.dev_id);
+	rem -= read;
+	ptr += read;
+
+	read = snprintf(ptr, rem, "Firmware Version: 0x%X\n", coredump_info.fw_version);
+	rem -= read;
+	ptr += read;
+
+	read = snprintf(ptr, rem, "Driver: %s\n", coredump_info.driver_name);
+	rem -= read;
+	ptr += read;
+
+	read = snprintf(ptr, rem, "Vendor: MediaTek\n");
+	rem -= read;
+	ptr += read;
+
+	return size - rem;
+}
+
+static void btmtk_coredump_notify(struct hci_dev *hdev, int state)
+{
+	switch (state) {
+	case HCI_DEVCOREDUMP_ACTIVE:
+		coredump_info.state = BTMTK_COREDUMP_ACTIVE;
+		break;
+	case HCI_DEVCOREDUMP_TIMEOUT:
+	case HCI_DEVCOREDUMP_ABORT:
+	case HCI_DEVCOREDUMP_DONE:
+		coredump_info.state = BTMTK_COREDUMP_INIT;
+		btmtk_reset_sync(coredump_info.hdev);
+		break;
+	}
+}
+
 int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 			      wmt_cmd_sync_func_t wmt_cmd_sync)
 {
@@ -296,6 +361,65 @@ void btmtk_reset_sync(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL_GPL(btmtk_reset_sync);
 
+void btmtk_register_coredump(struct hci_dev *hdev, u32 dev_id,
+			     const char *name, u32 fw_version)
+{
+	if (!IS_ENABLED(CONFIG_DEV_COREDUMP))
+		return;
+
+	coredump_info.hdev = hdev;
+	coredump_info.dev_id = dev_id;
+	coredump_info.fw_version = fw_version;
+	coredump_info.state = BTMTK_COREDUMP_INIT;
+	strncpy(coredump_info.driver_name, name, MTK_DRIVER_NAME_LEN - 1);
+
+	hci_devcoredump_register(hdev, btmtk_coredump, btmtk_coredump_hdr,
+				 btmtk_coredump_notify);
+}
+EXPORT_SYMBOL_GPL(btmtk_register_coredump);
+
+int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	int err;
+
+	if (!IS_ENABLED(CONFIG_DEV_COREDUMP))
+		return 0;
+
+	switch (coredump_info.state) {
+	case BTMTK_COREDUMP_DISABLED:
+		err = -EINVAL;
+		break;
+	case BTMTK_COREDUMP_INIT:
+		err = hci_devcoredump_init(hdev, 1024000);
+		if (err < 0)
+			break;
+		/* It is supposed coredump can be done within 5 seconds */
+		schedule_delayed_work(&hdev->dump.dump_timeout,
+				      msecs_to_jiffies(5000));
+		fallthrough;
+	case BTMTK_COREDUMP_ACTIVE:
+	default:
+		err = hci_devcoredump_append(hdev, skb);
+		if (err < 0)
+			break;
+
+		if (skb->len > 12 &&
+		    !strncmp((char *)&skb->data[skb->len - 13],
+			     MTK_COREDUMP_END, 12))
+			hci_devcoredump_complete(hdev);
+
+		break;
+	}
+
+	if (err < 0) {
+		coredump_info.state = BTMTK_COREDUMP_DISABLED;
+		kfree_skb(skb);
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(btmtk_process_coredump);
+
 MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
 MODULE_AUTHOR("Mark Chen <mark-yw.chen@mediatek.com>");
 MODULE_DESCRIPTION("Bluetooth support for MediaTek devices ver " VERSION);
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index 22d39f637652..faf941ce7ca2 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -138,6 +138,9 @@ int btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,
 			 wmt_cmd_sync_func_t wmt_cmd_sync);
 void btmtk_init_reset_work(struct hci_dev *hdev, work_func_t func);
 void btmtk_reset_sync(struct hci_dev *hdev);
+void btmtk_register_coredump(struct hci_dev *hdev, u32 dev_id, const char *name,
+			     u32 fw_version);
+int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb);
 #else
 
 static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
@@ -165,4 +168,14 @@ static void btmtk_init_reset_work(struct hci_dev *hdev, work_func_t func)
 static void btmtk_reset_sync(struct hci_dev *hdev)
 {
 }
+
+void btmtk_register_coredump(struct hci_dev *hdev, u32 dev_id, const char *name,
+			     u32 fw_version)
+{
+}
+
+static int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	return -EOPNOTSUPP;
+}
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d0130a5b91d6..52c0b6c1c508 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2835,6 +2835,7 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 	}
 
 	btmtk_init_reset_work(hdev, btusb_mtk_reset_work);
+	btmtk_register_coredump(hdev, dev_id, btusb_driver.name, fw_version);
 
 	switch (dev_id) {
 	case 0x7663:
@@ -2989,6 +2990,7 @@ static int btusb_recv_acl_mtk(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	u16 handle = le16_to_cpu(hci_acl_hdr(skb)->handle);
+	struct sk_buff *skb_cd;
 
 	switch (handle) {
 	case 0xfc6f:		/* Firmware dump from device */
@@ -2996,6 +2998,15 @@ static int btusb_recv_acl_mtk(struct hci_dev *hdev, struct sk_buff *skb)
 		 * suspend and thus disable auto-suspend.
 		 */
 		usb_disable_autosuspend(data->udev);
+
+		/* We need to forward the diagnostic packet to userspace daemon
+		 * for backward compatibility, so we have to clone the packet
+		 * extraly for the in-kernel coredump support.
+		 */
+		skb_cd = skb_clone(skb, GFP_ATOMIC);
+		if (skb_cd)
+			btmtk_process_coredump(hdev, skb_cd);
+
 		fallthrough;
 	case 0x05ff:		/* Firmware debug logging 1 */
 	case 0x05fe:		/* Firmware debug logging 2 */
-- 
2.25.1

