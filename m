Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445375E734A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 07:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiIWFMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 01:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiIWFMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 01:12:18 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA57A124766
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 22:12:16 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3454647ff7dso97436137b3.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 22:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=6QDS84YgNOtS9DfNn/xeOZxuc59uKzwSeasLVkx8kXg=;
        b=rVrwQwgkoQXurY6/VOLTuFkHfniZKr4ITstv0QUx52o6GQjiLR3bM4JvTy53S9ya5K
         R2YiAlEpN/u2TahKQP4cMGW9uSzwGPQWfLB4VkaLaGgwGCXP2CxVSUBBliz/AwcF2nOP
         rhUWPJAB8gGu7VT/jiaAMP7CJ5/fyapBfeBF59ESSin0lzmRWzNT2UkYuUWdOzbvi3r6
         qlLItfyC+6jrh21+4Z4v0JgvU1jFZd7HhhOWVvNaaCXjijev7/EKzpdbto2iVme7A6LR
         HV2ZZ+/gJsfW5vq9b+jej30QH4huUDD9LjdWv7LjMpfbR7zvtX4alUa2Ea5Ne+mPAbSG
         Zh7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=6QDS84YgNOtS9DfNn/xeOZxuc59uKzwSeasLVkx8kXg=;
        b=ooDDhWH8IEJemzTR3iClZrTGBg+txz5k86uX2Ml0WYilepZAHRYGFT3bG1qFNtsR5b
         TA/Wl4MmuZLaEbeM7TNNsktkpc4XR3+18xAe2iuSyyC2K8fQdMVqopL7czJpqH7VIP7B
         xK8+dMofQXeqDc5hLTjMrFow3wZmMcFhfN1zFMSj3umbI0zjqeMtSKZfrhhc/sp5uuqu
         m2O4w3o3a8Nr/BapLkXgrTAcAwi9jAXZigD23mwAfR6OEO+r+IAeNjzkWJcZi5m7o/UE
         aeO8EJqd88aSCdemOy8EqDdDSerjNW2zerbpKPqohOcCR16gZW5Wn0p/NPkSL7LYt9C+
         EywA==
X-Gm-Message-State: ACrzQf31p167Q5N34SRSQ1Py19YaxLkjjpftSvnwq5TmKncUwtnF8JPf
        jQHfZiYsD4Kz/DCaCQMyOhlBMJgCGj8AEQ==
X-Google-Smtp-Source: AMsMyM7XOAs1HSKzJ97YZGFC1x2wPEvc2ulDJm8hWMrsF//8iujDFKsFEwxI8PwuHnYE5NQGgVvapA5ZrUSL0Q==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:5808:dcfb:1968:5125])
 (user=mmandlik job=sendgmr) by 2002:a5b:583:0:b0:68a:6dc1:dddc with SMTP id
 l3-20020a5b0583000000b0068a6dc1dddcmr7736634ybp.189.1663909935944; Thu, 22
 Sep 2022 22:12:15 -0700 (PDT)
Date:   Thu, 22 Sep 2022 22:12:05 -0700
In-Reply-To: <20220922221037.v6.1.I44a65858f594107d3688087dfbdf669fac450b52@changeid>
Mime-Version: 1.0
References: <20220922221037.v6.1.I44a65858f594107d3688087dfbdf669fac450b52@changeid>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220922221037.v6.3.Iebfe88d3010597b09b1f18adf164062a7696b07f@changeid>
Subject: [PATCH v6 3/3] Bluetooth: btintel: Add Intel devcoredump support
From:   Manish Mandlik <mmandlik@google.com>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Manish Mandlik <mmandlik@google.com>,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

Intercept debug exception events from the controller and put them into
a devcoredump using hci devcoredump APIs. The debug exception contains
data in a TLV format and it will be parsed in userspace.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Manish Mandlik <mmandlik@google.com>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>
---

Changes in v6:
- Implement btintel_coredump()

Changes in v4:
- Add btintel_coredump() placeholder

Changes in v2:
- Create a local struct to store coredump_info in btintel.c
- Call btintel_register_devcoredump_support() from btintel.c
- Fix strncpy() destination bound warning

 drivers/bluetooth/btintel.c | 79 ++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btintel.h | 11 +++++-
 drivers/bluetooth/btusb.c   | 51 ++++++++++++++++++++----
 3 files changed, 131 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a657e9a3e96a..f5e002ab1b0d 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -32,6 +32,13 @@ struct cmd_write_boot_params {
 	u8  fw_build_yy;
 } __packed;
 
+#define DRIVER_NAME_LEN		16
+static struct {
+	char driver_name[DRIVER_NAME_LEN];
+	u8   hw_variant;
+	u32  fw_build_num;
+} coredump_info;
+
 int btintel_check_bdaddr(struct hci_dev *hdev)
 {
 	struct hci_rp_read_bd_addr *bda;
@@ -304,6 +311,9 @@ int btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
 		return -EINVAL;
 	}
 
+	coredump_info.hw_variant = ver->hw_variant;
+	coredump_info.fw_build_num = ver->fw_build_num;
+
 	bt_dev_info(hdev, "%s revision %u.%u build %u week %u %u",
 		    variant, ver->fw_revision >> 4, ver->fw_revision & 0x0f,
 		    ver->fw_build_num, ver->fw_build_ww,
@@ -498,6 +508,9 @@ static int btintel_version_info_tlv(struct hci_dev *hdev,
 		return -EINVAL;
 	}
 
+	coredump_info.hw_variant = INTEL_HW_VARIANT(version->cnvi_bt);
+	coredump_info.fw_build_num = version->build_num;
+
 	bt_dev_info(hdev, "%s timestamp %u.%u buildtype %u build %u", variant,
 		    2000 + (version->timestamp >> 8), version->timestamp & 0xff,
 		    version->build_type, version->build_num);
@@ -1392,6 +1405,65 @@ int btintel_set_quality_report(struct hci_dev *hdev, bool enable)
 }
 EXPORT_SYMBOL_GPL(btintel_set_quality_report);
 
+static void btintel_coredump(struct hci_dev *hdev)
+{
+	static const u8 param[] = { 0x00, 0x00 };
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, 0xfc4d, 2, param, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb))
+		bt_dev_err(hdev, "Coredump failed (%ld)", PTR_ERR(skb));
+	kfree_skb(skb);
+}
+
+static int btintel_dmp_hdr(struct hci_dev *hdev, char *buf, size_t size)
+{
+	char *ptr = buf;
+	size_t rem = size;
+	size_t read = 0;
+
+	read = snprintf(ptr, rem, "Controller Name: 0x%X\n",
+			coredump_info.hw_variant);
+	rem -= read;
+	ptr += read;
+
+	read = snprintf(ptr, rem, "Firmware Version: 0x%X\n",
+			coredump_info.fw_build_num);
+	rem -= read;
+	ptr += read;
+
+	read = snprintf(ptr, rem, "Driver: %s\n", coredump_info.driver_name);
+	rem -= read;
+	ptr += read;
+
+	read = snprintf(ptr, rem, "Vendor: Intel\n");
+	rem -= read;
+	ptr += read;
+
+	return size - rem;
+}
+
+static int btintel_register_devcoredump_support(struct hci_dev *hdev)
+{
+	struct intel_debug_features features;
+	int err;
+
+	err = btintel_read_debug_features(hdev, &features);
+	if (err) {
+		bt_dev_info(hdev, "Error reading debug features");
+		return err;
+	}
+
+	if (!(features.page1[0] & 0x3f)) {
+		bt_dev_info(hdev, "Telemetry exception format not supported");
+		return -EOPNOTSUPP;
+	}
+
+	hci_devcoredump_register(hdev, btintel_coredump, btintel_dmp_hdr, NULL);
+
+	return err;
+}
+
 static const struct firmware *btintel_legacy_rom_get_fw(struct hci_dev *hdev,
 					       struct intel_version *ver)
 {
@@ -2466,6 +2538,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 			btintel_set_msft_opcode(hdev, ver.hw_variant);
 
 			err = btintel_bootloader_setup(hdev, &ver);
+			btintel_register_devcoredump_support(hdev);
 			break;
 		default:
 			bt_dev_err(hdev, "Unsupported Intel hw variant (%u)",
@@ -2539,6 +2612,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		btintel_set_msft_opcode(hdev, ver.hw_variant);
 
 		err = btintel_bootloader_setup(hdev, &ver);
+		btintel_register_devcoredump_support(hdev);
 		break;
 	case 0x17:
 	case 0x18:
@@ -2562,6 +2636,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 					INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
 
 		err = btintel_bootloader_setup_tlv(hdev, &ver_tlv);
+		btintel_register_devcoredump_support(hdev);
 		break;
 	default:
 		bt_dev_err(hdev, "Unsupported Intel hw variant (%u)",
@@ -2610,7 +2685,7 @@ static int btintel_shutdown_combined(struct hci_dev *hdev)
 	return 0;
 }
 
-int btintel_configure_setup(struct hci_dev *hdev)
+int btintel_configure_setup(struct hci_dev *hdev, const char *driver_name)
 {
 	hdev->manufacturer = 2;
 	hdev->setup = btintel_setup_combined;
@@ -2619,6 +2694,8 @@ int btintel_configure_setup(struct hci_dev *hdev)
 	hdev->set_diag = btintel_set_diag_combined;
 	hdev->set_bdaddr = btintel_set_bdaddr;
 
+	strncpy(coredump_info.driver_name, driver_name, DRIVER_NAME_LEN - 1);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(btintel_configure_setup);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index e0060e58573c..8e72e59b5bde 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -137,6 +137,12 @@ struct intel_offload_use_cases {
 	__u8	preset[8];
 } __packed;
 
+#define INTEL_TLV_TYPE_ID		0x1
+
+#define INTEL_TLV_SYSTEM_EXCEPTION	0x0
+#define INTEL_TLV_FATAL_EXCEPTION	0x1
+#define INTEL_TLV_DEBUG_EXCEPTION	0x2
+
 #define INTEL_HW_PLATFORM(cnvx_bt)	((u8)(((cnvx_bt) & 0x0000ff00) >> 8))
 #define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) & 0x003f0000) >> 16))
 #define INTEL_CNVX_TOP_TYPE(cnvx_top)	((cnvx_top) & 0x00000fff)
@@ -206,7 +212,7 @@ int btintel_read_boot_params(struct hci_dev *hdev,
 			     struct intel_boot_params *params);
 int btintel_download_firmware(struct hci_dev *dev, struct intel_version *ver,
 			      const struct firmware *fw, u32 *boot_param);
-int btintel_configure_setup(struct hci_dev *hdev);
+int btintel_configure_setup(struct hci_dev *hdev, const char *driver_name);
 void btintel_bootup(struct hci_dev *hdev, const void *ptr, unsigned int len);
 void btintel_secure_send_result(struct hci_dev *hdev,
 				const void *ptr, unsigned int len);
@@ -287,7 +293,8 @@ static inline int btintel_download_firmware(struct hci_dev *dev,
 	return -EOPNOTSUPP;
 }
 
-static inline int btintel_configure_setup(struct hci_dev *hdev)
+static inline int btintel_configure_setup(struct hci_dev *hdev,
+					  const char *driver_name)
 {
 	return -ENODEV;
 }
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e9052779f4f8..4eb79e88f1d9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2215,16 +2215,44 @@ static int btusb_recv_bulk_intel(struct btusb_data *data, void *buffer,
 	return btusb_recv_bulk(data, buffer, count);
 }
 
+static int btusb_intel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct intel_tlv *tlv = (void *)&skb->data[5];
+
+	/* The first event is always an event type TLV */
+	if (tlv->type != INTEL_TLV_TYPE_ID)
+		goto recv_frame;
+
+	switch (tlv->val[0]) {
+	case INTEL_TLV_SYSTEM_EXCEPTION:
+	case INTEL_TLV_FATAL_EXCEPTION:
+	case INTEL_TLV_DEBUG_EXCEPTION:
+		/* Generate devcoredump from exception */
+		if (!hci_devcoredump_init(hdev, skb->len)) {
+			hci_devcoredump_append(hdev, skb);
+			hci_devcoredump_complete(hdev);
+		} else {
+			bt_dev_err(hdev, "Failed to generate devcoredump");
+			kfree_skb(skb);
+		}
+		return 0;
+	}
+
+recv_frame:
+	return hci_recv_frame(hdev, skb);
+}
+
 static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	if (btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
-		struct hci_event_hdr *hdr = (void *)skb->data;
+	struct hci_event_hdr *hdr = (void *)skb->data;
+	const char diagnostics_hdr[] = { 0x87, 0x80, 0x03 };
 
-		if (skb->len > HCI_EVENT_HDR_SIZE && hdr->evt == 0xff &&
-		    hdr->plen > 0) {
-			const void *ptr = skb->data + HCI_EVENT_HDR_SIZE + 1;
-			unsigned int len = skb->len - HCI_EVENT_HDR_SIZE - 1;
+	if (skb->len > HCI_EVENT_HDR_SIZE && hdr->evt == 0xff &&
+	    hdr->plen > 0) {
+		const void *ptr = skb->data + HCI_EVENT_HDR_SIZE + 1;
+		unsigned int len = skb->len - HCI_EVENT_HDR_SIZE - 1;
 
+		if (btintel_test_flag(hdev, INTEL_BOOTLOADER)) {
 			switch (skb->data[2]) {
 			case 0x02:
 				/* When switching to the operational firmware
@@ -2243,6 +2271,15 @@ static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
 				break;
 			}
 		}
+
+		/* Handle all diagnostics events separately. May still call
+		 * hci_recv_frame.
+		 */
+		if (len >= sizeof(diagnostics_hdr) &&
+		    memcmp(&skb->data[2], diagnostics_hdr,
+			   sizeof(diagnostics_hdr)) == 0) {
+			return btusb_intel_diagnostics(hdev, skb);
+		}
 	}
 
 	return hci_recv_frame(hdev, skb);
@@ -3835,7 +3872,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	/* Combined Intel Device setup to support multiple setup routine */
 	if (id->driver_info & BTUSB_INTEL_COMBINED) {
-		err = btintel_configure_setup(hdev);
+		err = btintel_configure_setup(hdev, btusb_driver.name);
 		if (err)
 			goto out_free_dev;
 
-- 
2.37.3.998.g577e59143f-goog

