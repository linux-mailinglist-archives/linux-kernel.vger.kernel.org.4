Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F08770110A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 23:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240347AbjELVUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 17:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239485AbjELVU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 17:20:26 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B740DAD;
        Fri, 12 May 2023 14:20:23 -0700 (PDT)
X-UUID: c9bb79f2f10a11edb20a276fd37b9834-20230513
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=2y69ufMAqUYfVUbII4JxVwe9FvW7v4sAn6IsWvtVGOs=;
        b=Be5jqB8eF7A0jkCPxRgVmL3pxXhwYoI23jljbMkQKQ19DAALpLm6dk+jh2gt5NnMASKocWXoy06H1Mg6+fv8+/RPMIqHz0I9OjsK4UmhAhAuAVihwTNw77+fpP1lI+4v6dXmFse6LEPmUljoQ+kH5wo4Dq2EcmNhwye7w7RiIh4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:93ad1c50-0684-42bf-baa9-e345a14c2ff2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.24,REQID:93ad1c50-0684-42bf-baa9-e345a14c2ff2,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:178d4d4,CLOUDID:a728a86b-2f20-4998-991c-3b78627e4938,B
        ulkID:23051305201733QEI01H,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: c9bb79f2f10a11edb20a276fd37b9834-20230513
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 118793442; Sat, 13 May 2023 05:20:15 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 13 May 2023 05:20:14 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 13 May 2023 05:20:14 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>
CC:     <sean.wang@mediatek.com>, <chris.lu@mediatek.com>,
        <Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <jenhao.yang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <abhishekpandit@google.com>,
        <michaelfsun@google.com>, <abhishekpandit@chromium.org>,
        <mcchou@chromium.org>, <shawnku@google.com>,
        <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jing Cai <jing.cai@mediatek.com>
Subject: [PATCH v6 3/3] Bluetooth: btusb: mediatek: add MediaTek devcoredump support
Date:   Sat, 13 May 2023 05:20:09 +0800
Message-ID: <850ac832598f9d8558996fade7f7db0c0cf73521.1683925801.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cc4ae6f7545cdf0615279890521b11774f062add.1683925801.git.objelf@gmail.com>
References: <cc4ae6f7545cdf0615279890521b11774f062add.1683925801.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Co-developed-by: Chris Lu <chris.lu@mediatek.com>
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Jing Cai <jing.cai@mediatek.com>
---
v2, v3: rebase onto the latest codebase
v4: update the newest API usage for the coredump which was already
    into the upstream
v5: support devcoredump on hdev basis
v6: reuse the coredump state HCI_DEVCOREDUMP_* in driver
    and drop the driver name copying
---
 drivers/bluetooth/btmtk.c | 106 ++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btmtk.h |  27 ++++++++++
 drivers/bluetooth/btusb.c |  14 +++++
 3 files changed, 147 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index ac2fac7e3c5f..60233afc0a9c 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -53,6 +53,56 @@ struct btmtk_section_map {
 	};
 } __packed;
 
+static void btmtk_coredump(struct hci_dev *hdev)
+{
+	int err;
+
+	err = __hci_cmd_send(hdev, 0xfd5b, 0, NULL);
+	if (err < 0)
+		bt_dev_err(hdev, "Coredump failed (%d)", err);
+}
+
+static void btmtk_coredump_hdr(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btmtk_data *data = hci_get_priv(hdev);
+	char buf[80];
+
+	snprintf(buf, sizeof(buf), "Controller Name: 0x%X\n",
+		 data->cd_info.dev_id);
+	skb_put_data(skb, buf, strlen(buf));
+
+	snprintf(buf, sizeof(buf), "Firmware Version: 0x%X\n",
+		 data->cd_info.fw_version);
+	skb_put_data(skb, buf, strlen(buf));
+
+	snprintf(buf, sizeof(buf), "Driver: %s\n",
+		 data->cd_info.driver_name);
+	skb_put_data(skb, buf, strlen(buf));
+
+	snprintf(buf, sizeof(buf), "Vendor: MediaTek\n");
+	skb_put_data(skb, buf, strlen(buf));
+}
+
+static void btmtk_coredump_notify(struct hci_dev *hdev, int state)
+{
+	struct btmtk_data *data = hci_get_priv(hdev);
+
+	switch (state) {
+	case HCI_DEVCOREDUMP_IDLE:
+		data->cd_info.state = HCI_DEVCOREDUMP_IDLE;
+		break;
+	case HCI_DEVCOREDUMP_ACTIVE:
+		data->cd_info.state = HCI_DEVCOREDUMP_ACTIVE;
+		break;
+	case HCI_DEVCOREDUMP_TIMEOUT:
+	case HCI_DEVCOREDUMP_ABORT:
+	case HCI_DEVCOREDUMP_DONE:
+		data->cd_info.state = HCI_DEVCOREDUMP_IDLE;
+		btmtk_reset_sync(hdev);
+		break;
+	}
+}
+
 int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
 			      wmt_cmd_sync_func_t wmt_cmd_sync)
 {
@@ -295,6 +345,62 @@ void btmtk_reset_sync(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL_GPL(btmtk_reset_sync);
 
+int btmtk_register_coredump(struct hci_dev *hdev, u32 dev_id,
+			     const char *name, u32 fw_version)
+{
+	struct btmtk_data *data = hci_get_priv(hdev);
+
+	if (!IS_ENABLED(CONFIG_DEV_COREDUMP))
+		return -EOPNOTSUPP;
+
+	data->cd_info.dev_id = dev_id;
+	data->cd_info.fw_version = fw_version;
+	data->cd_info.state = HCI_DEVCOREDUMP_IDLE;
+	data->cd_info.driver_name = name;
+
+	return hci_devcd_register(hdev, btmtk_coredump, btmtk_coredump_hdr,
+				  btmtk_coredump_notify);
+}
+EXPORT_SYMBOL_GPL(btmtk_register_coredump);
+
+int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btmtk_data *data = hci_get_priv(hdev);
+	int err;
+
+	if (!IS_ENABLED(CONFIG_DEV_COREDUMP))
+		return 0;
+
+	switch (data->cd_info.state) {
+	case HCI_DEVCOREDUMP_IDLE:
+		err = hci_devcd_init(hdev, MTK_COREDUMP_SIZE);
+		if (err < 0)
+			break;
+		/* It is supposed coredump can be done within 5 seconds */
+		schedule_delayed_work(&hdev->dump.dump_timeout,
+				      msecs_to_jiffies(5000));
+		fallthrough;
+	case HCI_DEVCOREDUMP_ACTIVE:
+	default:
+		err = hci_devcd_append(hdev, skb);
+		if (err < 0)
+			break;
+
+		if (skb->len > 12 &&
+		    !strncmp((char *)&skb->data[skb->len - 13],
+			     MTK_COREDUMP_END, 12))
+			hci_devcd_complete(hdev);
+
+		break;
+	}
+
+	if (err < 0)
+		kfree_skb(skb);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(btmtk_process_coredump);
+
 MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
 MODULE_AUTHOR("Mark Chen <mark-yw.chen@mediatek.com>");
 MODULE_DESCRIPTION("Bluetooth support for MediaTek devices ver " VERSION);
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index 6245662f6ccb..852a67db8f80 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -21,6 +21,9 @@
 #define MT7921_DLSTATUS 0x7c053c10
 #define BT_DL_STATE BIT(1)
 
+#define MTK_COREDUMP_SIZE		(1024 * 1000)
+#define MTK_COREDUMP_END		"coredump end"
+
 enum {
 	BTMTK_WMT_PATCH_DWNLD = 0x1,
 	BTMTK_WMT_TEST = 0x2,
@@ -119,12 +122,20 @@ struct btmtk_hci_wmt_params {
 	u32 *status;
 };
 
+struct btmtk_coredump_info {
+	const char *driver_name;
+	u32 dev_id;
+	u32 fw_version;
+	int state;
+};
+
 typedef int (*wmt_cmd_sync_func_t)(struct hci_dev *,
 				   struct btmtk_hci_wmt_params *);
 
 typedef int (*btmtk_reset_sync_func_t)(struct hci_dev *, void *);
 
 struct btmtk_data {
+	struct btmtk_coredump_info cd_info;
 	btmtk_reset_sync_func_t reset_sync;
 };
 
@@ -139,6 +150,11 @@ int btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,
 			 wmt_cmd_sync_func_t wmt_cmd_sync);
 
 void btmtk_reset_sync(struct hci_dev *hdev);
+
+int btmtk_register_coredump(struct hci_dev *hdev, u32 dev_id, const char *name,
+			     u32 fw_version);
+
+int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb);
 #else
 
 static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
@@ -162,4 +178,15 @@ static int btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,
 static void btmtk_reset_sync(struct hci_dev *hdev)
 {
 }
+
+static int btmtk_register_coredump(struct hci_dev *hdev, u32 dev_id, const char *name,
+			     u32 fw_version)
+{
+	return -EOPNOTSUPP;
+}
+
+static int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	return -EOPNOTSUPP;
+}
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 034edd8ad777..1c2a0cbcf62e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3035,6 +3035,10 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 	}
 
 	btmtk_data->reset_sync = btusb_mtk_reset_work;
+	err = btmtk_register_coredump(hdev, dev_id, btusb_driver.name,
+				fw_version);
+	if (err < 0)
+		bt_dev_err(hdev, "Failed to register coredump (%d)", err);
 
 	switch (dev_id) {
 	case 0x7663:
@@ -3189,6 +3193,7 @@ static int btusb_recv_acl_mtk(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	u16 handle = le16_to_cpu(hci_acl_hdr(skb)->handle);
+	struct sk_buff *skb_cd;
 
 	switch (handle) {
 	case 0xfc6f:		/* Firmware dump from device */
@@ -3196,6 +3201,15 @@ static int btusb_recv_acl_mtk(struct hci_dev *hdev, struct sk_buff *skb)
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

