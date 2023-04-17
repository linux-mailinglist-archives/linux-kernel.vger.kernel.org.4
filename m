Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007336E3D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 04:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjDQCeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 22:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDQCeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 22:34:23 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAC31FF3;
        Sun, 16 Apr 2023 19:34:20 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33H2XgC02013780, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33H2XgC02013780
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 17 Apr 2023 10:33:42 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 17 Apr 2023 10:34:05 +0800
Received: from localhost (172.21.132.123) by RTEXMBS03.realtek.com.tw
 (172.21.6.96) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 17 Apr
 2023 10:34:05 +0800
From:   <max.chou@realtek.com>
To:     <marcel@holtmann.org>
CC:     <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alex_lu@realsil.com.cn>, <allen_chen@realsil.com.cn>,
        <hildawu@realtek.com>, <karenhsu@realtek.com>,
        <kidman@realtek.com>, <mmandlik@google.com>,
        <abhishekpandit@chromium.org>, <apusaka@chromium.org>,
        <yinghsu@chromium.org>, <alainmichaud@google.com>,
        <max.chou@realtek.com>
Subject: [PATCH v5] Bluetooth: btrtl: Firmware format v2 support
Date:   Mon, 17 Apr 2023 10:33:58 +0800
Message-ID: <20230417023358.38767-1-max.chou@realtek.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.132.123]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Chou <max.chou@realtek.com>

Realtek changed the format of the firmware file as v2. The driver
should implement the patch to extract the firmware data from the
firmware file. The future chips must apply this patch for firmware loading.
This patch is compatible with the both previous format and v2 as well.

Signed-off-by: Allen Chen <allen_chen@realsil.com.cn>
Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
Tested-by: Hilda Wu <hildawu@realtek.com>
Signed-off-by: Max Chou <max.chou@realtek.com>
---
Changes in v5:
- Remove the redundancy message such as the length of loaded firmware.
Changes in v4:
- Resolve the conflict due to the later commits
Changes in v3:
- Fix sparse check
- Edit commit log
Changes in v2:
- Use iovec pull data function as rtl_iov_pull_data() to parse data.
---
 drivers/bluetooth/btrtl.c | 350 +++++++++++++++++++++++++++++++++-----
 drivers/bluetooth/btrtl.h |  53 +++++-
 2 files changed, 362 insertions(+), 41 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 0f256a8abef4..2ced74f8f87d 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -21,6 +21,7 @@
 #define RTL_CHIP_8723CS_VF	4
 #define RTL_CHIP_8723CS_XX	5
 #define RTL_EPATCH_SIGNATURE	"Realtech"
+#define RTL_EPATCH_SIGNATURE_V2	"RTBTCore"
 #define RTL_ROM_LMP_8703B	0x8703
 #define RTL_ROM_LMP_8723A	0x1200
 #define RTL_ROM_LMP_8723B	0x8723
@@ -43,6 +44,14 @@
 	.hci_ver = (hciv), \
 	.hci_bus = (bus)
 
+#define	RTL_CHIP_SUBVER (&(struct rtl_vendor_cmd) {{0x10, 0x38, 0x04, 0x28, 0x80}})
+#define	RTL_CHIP_REV    (&(struct rtl_vendor_cmd) {{0x10, 0x3A, 0x04, 0x28, 0x80}})
+#define	RTL_SEC_PROJ    (&(struct rtl_vendor_cmd) {{0x10, 0xA4, 0x0D, 0x00, 0xb0}})
+
+#define RTL_PATCH_SNIPPETS		0x01
+#define RTL_PATCH_DUMMY_HEADER		0x02
+#define RTL_PATCH_SECURITY_HEADER	0x03
+
 enum btrtl_chip_id {
 	CHIP_ID_8723A,
 	CHIP_ID_8723B,
@@ -81,6 +90,8 @@ struct btrtl_device_info {
 	int cfg_len;
 	bool drop_fw;
 	int project_id;
+	u8 key_id;
+	struct list_head patch_subsecs;
 };
 
 static const struct id_table ic_id_table[] = {
@@ -343,6 +354,227 @@ static int rtl_read_rom_version(struct hci_dev *hdev, u8 *version)
 	return 0;
 }
 
+static int btrtl_vendor_read_reg16(struct hci_dev *hdev,
+				   struct rtl_vendor_cmd *cmd, u8 *rp)
+{
+	struct sk_buff *skb;
+	int err = 0;
+
+	skb = __hci_cmd_sync(hdev, 0xfc61, sizeof(*cmd), cmd,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		rtl_dev_err(hdev, "RTL: Read reg16 failed (%d)", err);
+		return err;
+	}
+
+	if (skb->len != 3 || skb->data[0]) {
+		bt_dev_err(hdev, "RTL: Read reg16 length mismatch");
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	if (rp)
+		memcpy(rp, skb->data + 1, 2);
+
+	kfree_skb(skb);
+
+	return 0;
+}
+
+static void *rtl_iov_pull_data(struct rtl_iovec *iov, u32 len)
+{
+	void *data = iov->data;
+
+	if (iov->len < len)
+		return NULL;
+
+	iov->data += len;
+	iov->len  -= len;
+
+	return data;
+}
+
+static void btrtl_insert_ordered_subsec(struct rtl_subsection *node,
+					struct btrtl_device_info *btrtl_dev)
+{
+	struct list_head *pos;
+	struct list_head *next;
+	struct rtl_subsection *subsec;
+
+	list_for_each_safe(pos, next, &btrtl_dev->patch_subsecs) {
+		subsec = list_entry(pos, struct rtl_subsection, list);
+		if (subsec->prio >= node->prio)
+			break;
+	}
+	__list_add(&node->list, pos->prev, pos);
+}
+
+static int btrtl_parse_section(struct hci_dev *hdev,
+			       struct btrtl_device_info *btrtl_dev, u32 opcode,
+			       u8 *data, u32 len)
+{
+	struct rtl_section_hdr *hdr;
+	struct rtl_subsection *subsec;
+	struct rtl_common_subsec *common_subsec;
+	struct rtl_sec_hdr *sec_hdr;
+	int i;
+	u8 *ptr;
+	u16 num_subsecs;
+	u32 subsec_len;
+	int rc = 0;
+	struct rtl_iovec iov = {
+		.data = data,
+		.len  = len,
+	};
+
+	hdr = rtl_iov_pull_data(&iov, sizeof(*hdr));
+	if (!hdr)
+		return -EINVAL;
+	num_subsecs = le16_to_cpu(hdr->num);
+
+	for (i = 0; i < num_subsecs; i++) {
+		common_subsec = rtl_iov_pull_data(&iov, sizeof(*common_subsec));
+		if (!common_subsec)
+			break;
+		subsec_len = le32_to_cpu(common_subsec->len);
+
+		rtl_dev_dbg(hdev, "subsec, eco 0x%02x, len %08x",
+			    common_subsec->eco, subsec_len);
+
+		ptr = rtl_iov_pull_data(&iov, subsec_len);
+		if (!ptr)
+			break;
+
+		if (common_subsec->eco != btrtl_dev->rom_version + 1)
+			continue;
+
+		switch (opcode) {
+		case RTL_PATCH_SECURITY_HEADER:
+			sec_hdr = (void *)common_subsec;
+			if (sec_hdr->key_id != btrtl_dev->key_id)
+				continue;
+			break;
+		}
+
+		subsec = kzalloc(sizeof(*subsec), GFP_KERNEL);
+		if (!subsec)
+			return -ENOMEM;
+		subsec->opcode = opcode;
+		subsec->prio = common_subsec->prio;
+		subsec->len  = subsec_len;
+		subsec->data = ptr;
+		btrtl_insert_ordered_subsec(subsec, btrtl_dev);
+		rc  += subsec_len;
+	}
+
+	return rc;
+}
+
+static int rtlbt_parse_firmware_v2(struct hci_dev *hdev,
+				   struct btrtl_device_info *btrtl_dev,
+				   unsigned char **_buf)
+{
+	struct rtl_epatch_header_v2 *hdr;
+	int rc;
+	u8 reg_val[2];
+	u8 key_id;
+	u32 num_sections;
+	struct rtl_section *section;
+	struct rtl_subsection *entry, *tmp;
+	u32 section_len;
+	u32 opcode;
+	int len = 0;
+	int i;
+	u8 *ptr;
+	struct rtl_iovec iov = {
+		.data = btrtl_dev->fw_data,
+		.len  = btrtl_dev->fw_len - 7, /* Cut the tail */
+	};
+
+	rc = btrtl_vendor_read_reg16(hdev, RTL_SEC_PROJ, reg_val);
+	if (rc < 0)
+		return -EIO;
+	key_id = reg_val[0];
+
+	rtl_dev_dbg(hdev, "%s: key id %u", __func__, key_id);
+
+	btrtl_dev->key_id = key_id;
+
+	hdr = rtl_iov_pull_data(&iov, sizeof(*hdr));
+	if (!hdr)
+		return -EINVAL;
+	num_sections = le32_to_cpu(hdr->num_sections);
+
+	rtl_dev_dbg(hdev, "FW version %08x-%08x", *((u32 *)hdr->fw_version),
+		    *((u32 *)(hdr->fw_version + 4)));
+
+	for (i = 0; i < num_sections; i++) {
+		section = rtl_iov_pull_data(&iov, sizeof(*section));
+		if (!section)
+			break;
+		section_len = le32_to_cpu(section->len);
+		opcode      = le32_to_cpu(section->opcode);
+
+		rtl_dev_dbg(hdev, "opcode 0x%04x", section->opcode);
+
+		ptr = rtl_iov_pull_data(&iov, section_len);
+		if (!ptr)
+			break;
+
+		switch (opcode) {
+		case RTL_PATCH_SNIPPETS:
+			rc = btrtl_parse_section(hdev, btrtl_dev, opcode,
+						 ptr, section_len);
+			break;
+		case RTL_PATCH_SECURITY_HEADER:
+			/* If key_id from chip is zero, ignore all security
+			 * headers.
+			 */
+			if (!key_id)
+				break;
+			rc = btrtl_parse_section(hdev, btrtl_dev, opcode,
+						 ptr, section_len);
+			break;
+		case RTL_PATCH_DUMMY_HEADER:
+			rc = btrtl_parse_section(hdev, btrtl_dev, opcode,
+						 ptr, section_len);
+			break;
+		default:
+			rc = 0;
+			break;
+		}
+		if (rc < 0) {
+			rtl_dev_err(hdev, "RTL: Parse section (%u) err %d",
+				    opcode, rc);
+			return rc;
+		}
+		len += rc;
+	}
+
+	if (!len)
+		return -ENODATA;
+
+	/* Allocate mem and copy all found subsecs. */
+	ptr = kvmalloc(len, GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	len = 0;
+	list_for_each_entry_safe(entry, tmp, &btrtl_dev->patch_subsecs, list) {
+		rtl_dev_dbg(hdev, "RTL: opcode %08x, addr %p, len 0x%x",
+			    entry->opcode, entry->data, entry->len);
+		memcpy(ptr + len, entry->data, entry->len);
+		len += entry->len;
+	}
+
+	if (!len)
+		return -EPERM;
+
+	*_buf = ptr;
+	return len;
+}
+
 static int rtlbt_parse_firmware(struct hci_dev *hdev,
 				struct btrtl_device_info *btrtl_dev,
 				unsigned char **_buf)
@@ -377,7 +609,18 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 		{ RTL_ROM_LMP_8852A, 25 },	/* 8852C */
 	};
 
-	min_size = sizeof(struct rtl_epatch_header) + sizeof(extension_sig) + 3;
+	if (btrtl_dev->fw_len <= 8)
+		return -EINVAL;
+
+	if (!memcmp(btrtl_dev->fw_data, RTL_EPATCH_SIGNATURE, 8))
+		min_size = sizeof(struct rtl_epatch_header) +
+				sizeof(extension_sig) + 3;
+	else if (!memcmp(btrtl_dev->fw_data, RTL_EPATCH_SIGNATURE_V2, 8))
+		min_size = sizeof(struct rtl_epatch_header_v2) +
+				sizeof(extension_sig) + 3;
+	else
+		return -EINVAL;
+
 	if (btrtl_dev->fw_len < min_size)
 		return -EINVAL;
 
@@ -442,12 +685,14 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 		return -EINVAL;
 	}
 
-	epatch_info = (struct rtl_epatch_header *)btrtl_dev->fw_data;
-	if (memcmp(epatch_info->signature, RTL_EPATCH_SIGNATURE, 8) != 0) {
+	if (memcmp(btrtl_dev->fw_data, RTL_EPATCH_SIGNATURE, 8) != 0) {
+		if (!memcmp(btrtl_dev->fw_data, RTL_EPATCH_SIGNATURE_V2, 8))
+			return rtlbt_parse_firmware_v2(hdev, btrtl_dev, _buf);
 		rtl_dev_err(hdev, "bad EPATCH signature");
 		return -EINVAL;
 	}
 
+	epatch_info = (struct rtl_epatch_header *)btrtl_dev->fw_data;
 	num_patches = le16_to_cpu(epatch_info->num_patches);
 	BT_DBG("fw_version=%x, num_patches=%d",
 	       le32_to_cpu(epatch_info->fw_version), num_patches);
@@ -511,6 +756,7 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 	int frag_len = RTL_FRAG_LEN;
 	int ret = 0;
 	int i;
+	int j = 0;
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *rp;
 
@@ -521,17 +767,16 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 	for (i = 0; i < frag_num; i++) {
 		struct sk_buff *skb;
 
-		BT_DBG("download fw (%d/%d)", i, frag_num);
-
-		if (i > 0x7f)
-			dl_cmd->index = (i & 0x7f) + 1;
-		else
-			dl_cmd->index = i;
+		dl_cmd->index = j++;
+		if (dl_cmd->index == 0x7f)
+			j = 1;
 
 		if (i == (frag_num - 1)) {
 			dl_cmd->index |= 0x80; /* data end */
 			frag_len = fw_len % RTL_FRAG_LEN;
 		}
+		rtl_dev_dbg(hdev, "download fw (%d/%d). index = %d", i,
+				frag_num, dl_cmd->index);
 		memcpy(dl_cmd->data, data, frag_len);
 
 		/* Send download command */
@@ -691,8 +936,16 @@ static int rtl_read_chip_type(struct hci_dev *hdev, u8 *type)
 
 void btrtl_free(struct btrtl_device_info *btrtl_dev)
 {
+	struct rtl_subsection *entry, *tmp;
+
 	kvfree(btrtl_dev->fw_data);
 	kvfree(btrtl_dev->cfg_data);
+
+	list_for_each_entry_safe(entry, tmp, &btrtl_dev->patch_subsecs, list) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+
 	kfree(btrtl_dev);
 }
 EXPORT_SYMBOL_GPL(btrtl_free);
@@ -705,10 +958,11 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	struct hci_rp_read_local_version *resp;
 	char cfg_name[40];
 	u16 hci_rev, lmp_subver;
-	u8 hci_ver, chip_type = 0;
+	u8 hci_ver, lmp_ver, chip_type = 0;
 	int ret;
 	u16 opcode;
 	u8 cmd[2];
+	u8 reg_val[2];
 
 	btrtl_dev = kzalloc(sizeof(*btrtl_dev), GFP_KERNEL);
 	if (!btrtl_dev) {
@@ -716,6 +970,31 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 		goto err_alloc;
 	}
 
+	INIT_LIST_HEAD(&btrtl_dev->patch_subsecs);
+
+check_version:
+	ret = btrtl_vendor_read_reg16(hdev, RTL_CHIP_SUBVER, reg_val);
+	if (ret < 0)
+		goto err_free;
+	lmp_subver = get_unaligned_le16(reg_val);
+
+	if (lmp_subver == RTL_ROM_LMP_8822B) {
+		ret = btrtl_vendor_read_reg16(hdev, RTL_CHIP_REV, reg_val);
+		if (ret < 0)
+			goto err_free;
+		hci_rev = get_unaligned_le16(reg_val);
+
+		/* 8822E */
+		if (hci_rev == 0x000e) {
+			hci_ver = 0x0c;
+			lmp_ver = 0x0c;
+			btrtl_dev->ic_info = btrtl_match_ic(lmp_subver, hci_rev,
+							    hci_ver, hdev->bus,
+							    chip_type);
+			goto next;
+		}
+	}
+
 	skb = btrtl_read_local_version(hdev);
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
@@ -723,14 +1002,14 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	}
 
 	resp = (struct hci_rp_read_local_version *)skb->data;
-	rtl_dev_info(hdev, "examining hci_ver=%02x hci_rev=%04x lmp_ver=%02x lmp_subver=%04x",
-		     resp->hci_ver, resp->hci_rev,
-		     resp->lmp_ver, resp->lmp_subver);
 
-	hci_ver = resp->hci_ver;
-	hci_rev = le16_to_cpu(resp->hci_rev);
+	hci_ver    = resp->hci_ver;
+	hci_rev    = le16_to_cpu(resp->hci_rev);
+	lmp_ver    = resp->lmp_ver;
 	lmp_subver = le16_to_cpu(resp->lmp_subver);
 
+	kfree_skb(skb);
+
 	if (rtl_has_chip_type(lmp_subver)) {
 		ret = rtl_read_chip_type(hdev, &chip_type);
 		if (ret)
@@ -740,8 +1019,15 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	btrtl_dev->ic_info = btrtl_match_ic(lmp_subver, hci_rev, hci_ver,
 					    hdev->bus, chip_type);
 
-	if (!btrtl_dev->ic_info)
+next:
+	rtl_dev_info(hdev, "examining hci_ver=%02x hci_rev=%04x lmp_ver=%02x lmp_subver=%04x",
+		     hci_ver, hci_rev,
+		     lmp_ver, lmp_subver);
+
+	if (!btrtl_dev->ic_info && !btrtl_dev->drop_fw)
 		btrtl_dev->drop_fw = true;
+	else
+		btrtl_dev->drop_fw = false;
 
 	if (btrtl_dev->drop_fw) {
 		opcode = hci_opcode_pack(0x3f, 0x66);
@@ -750,41 +1036,25 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 
 		skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
 		if (!skb)
-			goto out_free;
+			goto err_free;
 
 		skb_put_data(skb, cmd, sizeof(cmd));
 		hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
 
-		hdev->send(hdev, skb);
+		ret = hdev->send(hdev, skb);
+		if (ret < 0) {
+			bt_dev_err(hdev, "sending frame failed (%d)", ret);
+			kfree_skb(skb);
+			goto err_free;
+		}
 
 		/* Ensure the above vendor command is sent to controller and
 		 * process has done.
 		 */
 		msleep(200);
 
-		/* Read the local version again. Expect to have the vanilla
-		 * version as cold boot.
-		 */
-		skb = btrtl_read_local_version(hdev);
-		if (IS_ERR(skb)) {
-			ret = PTR_ERR(skb);
-			goto err_free;
-		}
-
-		resp = (struct hci_rp_read_local_version *)skb->data;
-		rtl_dev_info(hdev, "examining hci_ver=%02x hci_rev=%04x lmp_ver=%02x lmp_subver=%04x",
-			     resp->hci_ver, resp->hci_rev,
-			     resp->lmp_ver, resp->lmp_subver);
-
-		hci_ver = resp->hci_ver;
-		hci_rev = le16_to_cpu(resp->hci_rev);
-		lmp_subver = le16_to_cpu(resp->lmp_subver);
-
-		btrtl_dev->ic_info = btrtl_match_ic(lmp_subver, hci_rev, hci_ver,
-						    hdev->bus, chip_type);
+		goto check_version;
 	}
-out_free:
-	kfree_skb(skb);
 
 	if (!btrtl_dev->ic_info) {
 		rtl_dev_info(hdev, "unknown IC info, lmp subver %04x, hci rev %04x, hci ver %04x",
diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
index 349d72ee571b..adb4c2c9abc5 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -49,7 +49,58 @@ struct rtl_vendor_config_entry {
 struct rtl_vendor_config {
 	__le32 signature;
 	__le16 total_len;
-	struct rtl_vendor_config_entry entry[];
+	__u8 entry[];
+} __packed;
+
+struct rtl_epatch_header_v2 {
+	__u8   signature[8];
+	__u8   fw_version[8];
+	__le32 num_sections;
+} __packed;
+
+struct rtl_section {
+	__le32 opcode;
+	__le32 len;
+	u8     data[];
+} __packed;
+
+struct rtl_section_hdr {
+	__le16 num;
+	__le16 reserved;
+} __packed;
+
+struct rtl_common_subsec {
+	__u8   eco;
+	__u8   prio;
+	__u8   cb[2];
+	__le32 len;
+	__u8   data[];
+};
+
+struct rtl_sec_hdr {
+	__u8   eco;
+	__u8   prio;
+	__u8   key_id;
+	__u8   reserved;
+	__le32 len;
+	__u8   data[];
+} __packed;
+
+struct rtl_subsection {
+	struct list_head list;
+	u32 opcode;
+	u32 len;
+	u8 prio;
+	u8 *data;
+};
+
+struct rtl_iovec {
+	u8  *data;
+	u32 len;
+};
+
+struct rtl_vendor_cmd {
+	__u8 param[5];
 } __packed;
 
 enum {
-- 
2.34.1

