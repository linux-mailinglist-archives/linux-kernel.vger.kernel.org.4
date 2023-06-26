Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E821573EBFF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 22:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjFZUmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 16:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjFZUl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:41:58 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA03E74;
        Mon, 26 Jun 2023 13:41:50 -0700 (PDT)
X-UUID: dc9a2f94146111eeb20a276fd37b9834-20230627
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PZC0t64Ob4JraVS9DGN0FkfHd055RgXVfPCCR576qLc=;
        b=czUN2puKRu8JOiHte4ZIDgrhe5AqLH/oGdcfUbWyPkNx1PaLvwSzRrQhYiRW7zu/cVIGvU4nake/4JO1LUBl9EJGErkM0dWsei43AV8LJViBoZ2WROsluOMSscRvzYItJnu+UPSkK4tqhCVmUNOwm0NDjVEz46vNqBB+Y6r/yvs=;
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.27,REQID:30d5e843-a268-4e7a-ba96-aa5751e10c8a,IP:0,U
        RL:0,TC:0,Content:0,EDM:25,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS6885AD,ACT
        ION:quarantine,TS:120
X-CID-INFO: VERSION:1.1.27,REQID:30d5e843-a268-4e7a-ba96-aa5751e10c8a,IP:0,URL
        :0,TC:0,Content:0,EDM:25,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:120
X-CID-META: VersionHash:01c9525,CLOUDID:d592883f-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230627044146BOA3J9F9,BulkQuantity:1,Recheck:0,SF:19|48|38|29|28|17,T
        C:nil,Content:0,EDM:5,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:
        0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD,TF_CID_SPAM_ULN
X-UUID: dc9a2f94146111eeb20a276fd37b9834-20230627
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1524004245; Tue, 27 Jun 2023 04:41:44 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 27 Jun 2023 04:41:43 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 27 Jun 2023 04:41:43 +0800
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
Subject: [PATCH v7 3/3] Bluetooth: btusb: mediatek: add MediaTek devcoredump support
Date:   Tue, 27 Jun 2023 04:41:39 +0800
Message-ID: <ed1d0e9fe7758dac8a05dcff97c7dcb8e9b0be39.1687565769.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <2d7bef70b876e4cbd447c5109956f716bad5bc2d.1687565769.git.objelf@gmail.com>
References: <2d7bef70b876e4cbd447c5109956f716bad5bc2d.1687565769.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
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
v7: rebase ontto the latest codebase and refine the check if
    we are reaching the end of the coredump
---
 drivers/bluetooth/btmtk.c | 112 ++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btmtk.h |  28 ++++++++++
 drivers/bluetooth/btusb.c |  14 +++++
 3 files changed, 154 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index b8678b75276e..8fe1b7e7255c 100644
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
+	struct btmediatek_data *data = hci_get_priv(hdev);
+	char buf[80];
+
+	snprintf(buf, sizeof(buf), "Controller Name: 0x%X\n",
+		 data->dev_id);
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
+	struct btmediatek_data *data = hci_get_priv(hdev);
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
@@ -295,6 +345,68 @@ void btmtk_reset_sync(struct hci_dev *hdev)
 }
 EXPORT_SYMBOL_GPL(btmtk_reset_sync);
 
+int btmtk_register_coredump(struct hci_dev *hdev, const char *name,
+			    u32 fw_version)
+{
+	struct btmediatek_data *data = hci_get_priv(hdev);
+
+	if (!IS_ENABLED(CONFIG_DEV_COREDUMP))
+		return -EOPNOTSUPP;
+
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
+	struct btmediatek_data *data = hci_get_priv(hdev);
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
+		data->cd_info.cnt = 0;
+
+		/* It is supposed coredump can be done within 5 seconds */
+		schedule_delayed_work(&hdev->dump.dump_timeout,
+				      msecs_to_jiffies(5000));
+		fallthrough;
+	case HCI_DEVCOREDUMP_ACTIVE:
+	default:
+		err = hci_devcd_append(hdev, skb);
+		if (err < 0)
+			break;
+		data->cd_info.cnt++;
+
+		/* Mediatek coredump data would be more than MTK_COREDUMP_NUM */
+		if (data->cd_info.cnt > MTK_COREDUMP_NUM &&
+		    skb->len > sizeof(MTK_COREDUMP_END) &&
+		    !memcmp((char *)&skb->data[skb->len - sizeof(MTK_COREDUMP_END)],
+			    MTK_COREDUMP_END, sizeof(MTK_COREDUMP_END) - 1)) {
+			bt_dev_info(hdev, "Mediatek coredump end");
+			hci_devcd_complete(hdev);
+		}
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
index 75d8e71efcd3..68309dfe076a 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -22,6 +22,10 @@
 #define MT7921_DLSTATUS 0x7c053c10
 #define BT_DL_STATE BIT(1)
 
+#define MTK_COREDUMP_SIZE		(1024 * 1000)
+#define MTK_COREDUMP_END		"coredump end"
+#define MTK_COREDUMP_NUM		255
+
 enum {
 	BTMTK_WMT_PATCH_DWNLD = 0x1,
 	BTMTK_WMT_TEST = 0x2,
@@ -122,9 +126,17 @@ struct btmtk_hci_wmt_params {
 
 typedef int (*btmtk_reset_sync_func_t)(struct hci_dev *, void *);
 
+struct btmtk_coredump_info {
+	const char *driver_name;
+	u32 fw_version;
+	u16 cnt;
+	int state;
+};
+
 struct btmediatek_data {
 	u32 dev_id;
 	btmtk_reset_sync_func_t reset_sync;
+	struct btmtk_coredump_info cd_info;
 };
 
 typedef int (*wmt_cmd_sync_func_t)(struct hci_dev *,
@@ -141,6 +153,11 @@ int btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,
 			 wmt_cmd_sync_func_t wmt_cmd_sync);
 
 void btmtk_reset_sync(struct hci_dev *hdev);
+
+int btmtk_register_coredump(struct hci_dev *hdev, const char *name,
+			    u32 fw_version);
+
+int btmtk_process_coredump(struct hci_dev *hdev, struct sk_buff *skb);
 #else
 
 static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
@@ -164,4 +181,15 @@ static int btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,
 static void btmtk_reset_sync(struct hci_dev *hdev)
 {
 }
+
+static int btmtk_register_coredump(struct hci_dev *hdev, const char *name,
+				   u32 fw_version)
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
index 4ebab61c288c..729445ef3871 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3150,6 +3150,10 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 	mediatek->dev_id = dev_id;
 	mediatek->reset_sync = btusb_mtk_reset_work;
 
+	err = btmtk_register_coredump(hdev, btusb_driver.name, fw_version);
+	if (err < 0)
+		bt_dev_err(hdev, "Failed to register coredump (%d)", err);
+
 	switch (dev_id) {
 	case 0x7663:
 		fwname = FIRMWARE_MT7663;
@@ -3310,6 +3314,7 @@ static int btusb_recv_acl_mtk(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	u16 handle = le16_to_cpu(hci_acl_hdr(skb)->handle);
+	struct sk_buff *skb_cd;
 
 	switch (handle) {
 	case 0xfc6f:		/* Firmware dump from device */
@@ -3317,6 +3322,15 @@ static int btusb_recv_acl_mtk(struct hci_dev *hdev, struct sk_buff *skb)
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

