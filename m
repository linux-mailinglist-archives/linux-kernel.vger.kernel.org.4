Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BFC5E5FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiIVKeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiIVKeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:34:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 861F3D6916;
        Thu, 22 Sep 2022 03:33:58 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28MAXKAK0024191, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28MAXKAK0024191
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 22 Sep 2022 18:33:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 22 Sep 2022 18:33:43 +0800
Received: from localhost.localdomain (172.21.132.192) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 22 Sep 2022 18:33:42 +0800
From:   <hildawu@realtek.com>
To:     <marcel@holtmann.org>
CC:     <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mmandlik@google.com>, <max.chou@realtek.com>,
        <alex_lu@realsil.com.cn>, <kidman@realtek.com>
Subject: [PATCH] Bluetooth: btusb: Add Realtek devcoredump support
Date:   Thu, 22 Sep 2022 18:33:37 +0800
Message-ID: <20220922103337.26167-1-hildawu@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.132.192]
X-ClientProxiedBy: RTEXH36504.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/22/2022 10:20:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMjIgpFekyCAwODo1MzowMA==?=
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

From: Alex Lu <alex_lu@realsil.com.cn>

Catch debug exception from controller and driver, and trigger a
devcoredump using hci devcoredump APIs. The debug exception data will be
parsed in userspace.

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
The patch need to work on the top of the patch provided
from Manish Mandlik and Abhishek Pandit-Subedi
in https://patchwork.kernel.org/patch/12940740
---
---
 drivers/bluetooth/btrtl.c | 134 ++++++++++++++++++++++++++++++++------
 drivers/bluetooth/btrtl.h |   6 ++
 drivers/bluetooth/btusb.c |  75 +++++++++++++++++++++
 3 files changed, 194 insertions(+), 21 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index fb52313a1d45..94200cdcf1e2 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -64,6 +64,7 @@ struct id_table {
 	bool has_msft_ext;
 	char *fw_name;
 	char *cfg_name;
+	char *hw_info;
 };
 
 struct btrtl_device_info {
@@ -83,42 +84,48 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = false,
 	  .has_rom_version = false,
 	  .fw_name = "rtl_bt/rtl8723a_fw.bin",
-	  .cfg_name = NULL },
+	  .cfg_name = NULL,
+	  .hw_info = "rtl8723au" },
 
 	/* 8723BS */
 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xb, 0x6, HCI_UART),
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8723bs_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8723bs_config" },
+	  .cfg_name = "rtl_bt/rtl8723bs_config",
+	  .hw_info  = "rtl8723bs" },
 
 	/* 8723B */
 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xb, 0x6, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8723b_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8723b_config" },
+	  .cfg_name = "rtl_bt/rtl8723b_config",
+	  .hw_info  = "rtl8723bu" },
 
 	/* 8723D */
 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xd, 0x8, HCI_USB),
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8723d_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8723d_config" },
+	  .cfg_name = "rtl_bt/rtl8723d_config",
+	  .hw_info  = "rtl8723du" },
 
 	/* 8723DS */
 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xd, 0x8, HCI_UART),
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8723ds_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8723ds_config" },
+	  .cfg_name = "rtl_bt/rtl8723ds_config",
+	  .hw_info  = "rtl8723ds" },
 
 	/* 8821A */
 	{ IC_INFO(RTL_ROM_LMP_8821A, 0xa, 0x6, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8821a_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8821a_config" },
+	  .cfg_name = "rtl_bt/rtl8821a_config",
+	  .hw_info  = "rtl8821au" },
 
 	/* 8821C */
 	{ IC_INFO(RTL_ROM_LMP_8821A, 0xc, 0x8, HCI_USB),
@@ -126,14 +133,16 @@ static const struct id_table ic_id_table[] = {
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
 	  .fw_name  = "rtl_bt/rtl8821c_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8821c_config" },
+	  .cfg_name = "rtl_bt/rtl8821c_config",
+	  .hw_info  = "rtl8821cu"},
 
 	/* 8761A */
 	{ IC_INFO(RTL_ROM_LMP_8761A, 0xa, 0x6, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8761a_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8761a_config" },
+	  .cfg_name = "rtl_bt/rtl8761a_config",
+	  .hw_info  = "rtl8761au" },
 
 	/* 8761B */
 	{ IC_INFO(RTL_ROM_LMP_8761A, 0xb, 0xa, HCI_UART),
@@ -141,14 +150,16 @@ static const struct id_table ic_id_table[] = {
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
 	  .fw_name  = "rtl_bt/rtl8761b_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8761b_config" },
+	  .cfg_name = "rtl_bt/rtl8761b_config",
+	  .hw_info  = "rtl8761bs" },
 
 	/* 8761BU */
 	{ IC_INFO(RTL_ROM_LMP_8761A, 0xb, 0xa, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8761bu_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8761bu_config" },
+	  .cfg_name = "rtl_bt/rtl8761bu_config",
+	  .hw_info  = "rtl8761bu" },
 
 	/* 8822C with UART interface */
 	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0x8, HCI_UART),
@@ -156,7 +167,8 @@ static const struct id_table ic_id_table[] = {
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
 	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8822cs_config" },
+	  .cfg_name = "rtl_bt/rtl8822cs_config",
+	  .hw_info  = "rtl8822cs" },
 
 	/* 8822C with UART interface */
 	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0xa, HCI_UART),
@@ -164,7 +176,8 @@ static const struct id_table ic_id_table[] = {
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
 	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8822cs_config" },
+	  .cfg_name = "rtl_bt/rtl8822cs_config",
+	  .hw_info  = "rtl8822cs" },
 
 	/* 8822C with USB interface */
 	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0xa, HCI_USB),
@@ -172,7 +185,8 @@ static const struct id_table ic_id_table[] = {
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
 	  .fw_name  = "rtl_bt/rtl8822cu_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8822cu_config" },
+	  .cfg_name = "rtl_bt/rtl8822cu_config",
+	  .hw_info  = "rtl8822cu" },
 
 	/* 8822B */
 	{ IC_INFO(RTL_ROM_LMP_8822B, 0xb, 0x7, HCI_USB),
@@ -180,7 +194,8 @@ static const struct id_table ic_id_table[] = {
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
 	  .fw_name  = "rtl_bt/rtl8822b_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8822b_config" },
+	  .cfg_name = "rtl_bt/rtl8822b_config",
+	  .hw_info  = "rtl8822bu" },
 
 	/* 8852A */
 	{ IC_INFO(RTL_ROM_LMP_8852A, 0xa, 0xb, HCI_USB),
@@ -188,7 +203,8 @@ static const struct id_table ic_id_table[] = {
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
 	  .fw_name  = "rtl_bt/rtl8852au_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8852au_config" },
+	  .cfg_name = "rtl_bt/rtl8852au_config",
+	  .hw_info  = "rtl8852au" },
 
 	/* 8852B */
 	{ IC_INFO(RTL_ROM_LMP_8852A, 0xb, 0xb, HCI_USB),
@@ -196,7 +212,8 @@ static const struct id_table ic_id_table[] = {
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
 	  .fw_name  = "rtl_bt/rtl8852bu_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8852bu_config" },
+	  .cfg_name = "rtl_bt/rtl8852bu_config",
+	  .hw_info  = "rtl8852bu" },
 
 	/* 8852C */
 	{ IC_INFO(RTL_ROM_LMP_8852A, 0xc, 0xc, HCI_USB),
@@ -204,9 +221,17 @@ static const struct id_table ic_id_table[] = {
 	  .has_rom_version = true,
 	  .has_msft_ext = true,
 	  .fw_name  = "rtl_bt/rtl8852cu_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8852cu_config" },
+	  .cfg_name = "rtl_bt/rtl8852cu_config",
+	  .hw_info  = "rtl8852cu" },
 	};
 
+#define DRIVER_NAME_LEN		16
+static struct {
+	char driver_name[DRIVER_NAME_LEN];
+	char *controller;
+	u32  fw_version;
+} coredump_info;
+
 static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev,
 					     u8 hci_ver, u8 hci_bus)
 {
@@ -391,6 +416,7 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 	num_patches = le16_to_cpu(epatch_info->num_patches);
 	BT_DBG("fw_version=%x, num_patches=%d",
 	       le32_to_cpu(epatch_info->fw_version), num_patches);
+	coredump_info.fw_version = le32_to_cpu(epatch_info->fw_version);
 
 	/* After the rtl_epatch_header there is a funky patch metadata section.
 	 * Assuming 2 patches, the layout is:
@@ -587,6 +613,59 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev,
 	return ret;
 }
 
+static void btrtl_coredump(struct hci_dev *hdev)
+{
+	static const u8 param[] = { 0x00, 0x00 };
+
+	__hci_cmd_send(hdev, 0xfcff, sizeof(param), param);
+}
+
+static int btrtl_dmp_hdr(struct hci_dev *hdev, char *buf, size_t size)
+{
+	char *ptr = buf;
+	size_t rem = size;
+	size_t read = 0;
+
+	if (coredump_info.controller)
+		read = snprintf(ptr, rem, "Controller Name: %s\n",
+				coredump_info.controller);
+	else
+		read = snprintf(ptr, rem, "Controller Name: Unknown\n");
+	rem -= read;
+	ptr += read;
+
+	read = snprintf(ptr, rem, "Firmware Version: 0x%X\n",
+			coredump_info.fw_version);
+	rem -= read;
+	ptr += read;
+
+	read = snprintf(ptr, rem, "Driver: %s\n", coredump_info.driver_name);
+	rem -= read;
+	ptr += read;
+
+	read = snprintf(ptr, rem, "Vendor: Realtek\n");
+	rem -= read;
+	ptr += read;
+
+	return size - rem;
+}
+
+static int btrtl_register_devcoredump_support(struct hci_dev *hdev)
+{
+	int err;
+
+	err = hci_devcoredump_register(hdev, btrtl_coredump, btrtl_dmp_hdr,
+				       NULL);
+
+	return err;
+}
+
+void btrtl_set_driver_name(struct hci_dev *hdev, const char *driver_name)
+{
+	strncpy(coredump_info.driver_name, driver_name, DRIVER_NAME_LEN - 1);
+}
+EXPORT_SYMBOL_GPL(btrtl_set_driver_name);
+
 void btrtl_free(struct btrtl_device_info *btrtl_dev)
 {
 	kvfree(btrtl_dev->fw_data);
@@ -724,6 +803,9 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	if (btrtl_dev->ic_info->has_msft_ext)
 		hci_set_msft_opcode(hdev, 0xFCF0);
 
+	if (btrtl_dev->ic_info)
+		coredump_info.controller = btrtl_dev->ic_info->hw_info;
+
 	return btrtl_dev;
 
 err_free:
@@ -736,6 +818,8 @@ EXPORT_SYMBOL_GPL(btrtl_initialize);
 int btrtl_download_firmware(struct hci_dev *hdev,
 			    struct btrtl_device_info *btrtl_dev)
 {
+	int err;
+
 	/* Match a set of subver values that correspond to stock firmware,
 	 * which is not compatible with standard btusb.
 	 * If matched, upload an alternative firmware that does conform to
@@ -744,22 +828,30 @@ int btrtl_download_firmware(struct hci_dev *hdev,
 	 */
 	if (!btrtl_dev->ic_info) {
 		rtl_dev_info(hdev, "assuming no firmware upload needed");
-		return 0;
+		err = 0;
+		goto done;
 	}
 
 	switch (btrtl_dev->ic_info->lmp_subver) {
 	case RTL_ROM_LMP_8723A:
-		return btrtl_setup_rtl8723a(hdev, btrtl_dev);
+		err = btrtl_setup_rtl8723a(hdev, btrtl_dev);
+		break;
 	case RTL_ROM_LMP_8723B:
 	case RTL_ROM_LMP_8821A:
 	case RTL_ROM_LMP_8761A:
 	case RTL_ROM_LMP_8822B:
 	case RTL_ROM_LMP_8852A:
-		return btrtl_setup_rtl8723b(hdev, btrtl_dev);
+		err = btrtl_setup_rtl8723b(hdev, btrtl_dev);
+		break;
 	default:
+		err = 0;
 		rtl_dev_info(hdev, "assuming no firmware upload needed");
-		return 0;
+		break;
 	}
+done:
+	if (!err)
+		btrtl_register_devcoredump_support(hdev);
+	return err;
 }
 EXPORT_SYMBOL_GPL(btrtl_download_firmware);
 
diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
index 2c441bda390a..455ccdd17cc4 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -62,6 +62,7 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 			    struct btrtl_device_info *btrtl_dev,
 			    unsigned int *controller_baudrate,
 			    u32 *device_baudrate, bool *flow_control);
+void btrtl_set_driver_name(struct hci_dev *hdev, const char *driver_name);
 
 #else
 
@@ -105,4 +106,9 @@ static inline int btrtl_get_uart_settings(struct hci_dev *hdev,
 	return -ENOENT;
 }
 
+static inline void btrtl_set_driver_name(struct hci_dev *hdev, const char *driver_name)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 271963805a38..5b1245c6f8cf 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -36,6 +36,10 @@ static bool reset = true;
 
 static struct usb_driver btusb_driver;
 
+#define DEVCOREDUMP_CODE_MEMDUMP	0x01
+#define DEVCOREDUMP_CODE_HW_ERR		0x02
+#define DEVCOREDUMP_CODE_CMD_TIMEOUT	0x03
+
 #define BTUSB_IGNORE			BIT(0)
 #define BTUSB_DIGIANSWER		BIT(1)
 #define BTUSB_CSR			BIT(2)
@@ -731,7 +735,22 @@ static void btusb_rtl_cmd_timeout(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct gpio_desc *reset_gpio = data->reset_gpio;
+	struct sk_buff *skb;
+	u8 code[4] = { DEVCOREDUMP_CODE_CMD_TIMEOUT, 0, 0, 0 };
 
+	skb = alloc_skb(sizeof(code), GFP_ATOMIC);
+	if (!skb)
+		goto timeout_check;
+	skb_put_data(skb, code, sizeof(code));
+	if (!hci_devcoredump_init(hdev, skb->len)) {
+		hci_devcoredump_append(hdev, skb);
+		hci_devcoredump_complete(hdev);
+	} else {
+		bt_dev_err(hdev, "RTL: cmd timeout, failed to devcoredump");
+		kfree_skb(skb);
+	}
+
+timeout_check:
 	if (++data->cmd_timeout_cnt < 5)
 		return;
 
@@ -757,6 +776,26 @@ static void btusb_rtl_cmd_timeout(struct hci_dev *hdev)
 	gpiod_set_value_cansleep(reset_gpio, 0);
 }
 
+static void btusb_rtl_hw_error(struct hci_dev *hdev, u8 code)
+{
+	u8 devcoredump_code[4] = { DEVCOREDUMP_CODE_HW_ERR, code, 0, 0 };
+	struct sk_buff *skb;
+
+	bt_dev_info(hdev, "RTL: hw err, trigger devcoredump");
+
+	skb = alloc_skb(sizeof(devcoredump_code), GFP_ATOMIC);
+	if (!skb)
+		return;
+	skb_put_data(skb, devcoredump_code, sizeof(devcoredump_code));
+	if (!hci_devcoredump_init(hdev, skb->len)) {
+		hci_devcoredump_append(hdev, skb);
+		hci_devcoredump_complete(hdev);
+	} else {
+		bt_dev_err(hdev, "RTL: hw err, failed to generate devcoredump");
+		kfree_skb(skb);
+	}
+}
+
 static void btusb_qca_cmd_timeout(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
@@ -2315,6 +2354,38 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 	return -EILSEQ;
 }
 
+static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btusb_data *data = hci_get_drvdata(hdev);
+
+	if (skb->data[0] == HCI_VENDOR_PKT && skb->data[2] == 0x34) {
+		struct sk_buff *nskb;
+		u8 code[4] = { DEVCOREDUMP_CODE_MEMDUMP, 0, 0, 0 };
+
+		bt_dev_info(hdev, "RTL: received wdg reset vendor evt, len %u",
+			    skb->len);
+
+		nskb = alloc_skb(skb->len + sizeof(code), GFP_ATOMIC);
+		if (!nskb)
+			return -ENOMEM;
+		skb_put_data(nskb, code, sizeof(code));
+		skb_put_data(nskb, skb->data, skb->len);
+		kfree_skb(skb);
+
+		if (!hci_devcoredump_init(hdev, nskb->len)) {
+			hci_devcoredump_append(hdev, nskb);
+			hci_devcoredump_complete(hdev);
+		} else {
+			bt_dev_err(hdev, "Failed to generate devcoredump");
+			kfree_skb(nskb);
+		}
+
+		return 0;
+	}
+
+	return hci_recv_frame(data->hdev, skb);
+}
+
 /* UHW CR mapping */
 #define MTK_BT_MISC		0x70002510
 #define MTK_BT_SUBSYS_RST	0x70002610
@@ -3755,6 +3826,8 @@ static int btusb_probe(struct usb_interface *intf,
 		/* Override the rx handlers */
 		data->recv_event = btusb_recv_event_intel;
 		data->recv_bulk = btusb_recv_bulk_intel;
+	} else if (id->driver_info & BTUSB_REALTEK) {
+		data->recv_event = btusb_recv_event_realtek;
 	}
 
 	data->recv_acl = hci_recv_frame;
@@ -3913,9 +3986,11 @@ static int btusb_probe(struct usb_interface *intf,
 
 	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_RTL) &&
 	    (id->driver_info & BTUSB_REALTEK)) {
+		btrtl_set_driver_name(hdev, btusb_driver.name);
 		hdev->setup = btrtl_setup_realtek;
 		hdev->shutdown = btrtl_shutdown_realtek;
 		hdev->cmd_timeout = btusb_rtl_cmd_timeout;
+		hdev->hw_error = btusb_rtl_hw_error;
 
 		/* Realtek devices need to set remote wakeup on auto-suspend */
 		set_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags);
-- 
2.17.1

