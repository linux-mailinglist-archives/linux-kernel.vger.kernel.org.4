Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8526F7583
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjEDT6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjEDTzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:55:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE95311DA8;
        Thu,  4 May 2023 12:49:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 648886372C;
        Thu,  4 May 2023 19:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B736BC433D2;
        Thu,  4 May 2023 19:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229691;
        bh=9JU9pw9oTzvj/jkVvJN66Q1cT8/IItWH2OPQk3PlVK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HYZoNGaiV7Tpm4HbqtvgwZpBW0dV+IpPsxAoFVnj2VQRGHxN2o74bo+MwNiwsWqAl
         49RbFTkzXpFqiMPLkbPDB+SPENrSOHYUiIO4UlhpwXr4AyHFGYuWHLiGwIAFShYlDj
         05LYmAX/81s8sW7N2XWmbbNXlnKmpw5QuBP8qIywaat5Pfw2FNn0aOgn8/ZU5aNh5k
         zdEM7/JFQjZeBcODRDY4R/vuWHR3YE/olvd8HRee4IoWfiHSjiy7pOQuSfzGVUfLIV
         RU5L/tv51KztiHdp0ghGdnLhrdkcjqLBSHO3B4t1vhv9x1VCJPoPOFRaOE405Lzp6Q
         k6EhXKjS+sceg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Bastian Germann <bage@debian.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 42/49] Bluetooth: btrtl: add support for the RTL8723CS
Date:   Thu,  4 May 2023 15:46:19 -0400
Message-Id: <20230504194626.3807438-42-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194626.3807438-1-sashal@kernel.org>
References: <20230504194626.3807438-1-sashal@kernel.org>
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

From: Vasily Khoruzhick <anarsoul@gmail.com>

[ Upstream commit c0123cb6c4c7fc2a42ead6cd7d3e82b8e1c25c6f ]

The Realtek RTL8723CS is a SDIO WiFi chip. It also contains a Bluetooth
module which is connected via UART to the host.

It shares lmp subversion with 8703B, so Realtek's userspace
initialization tool (rtk_hciattach) differentiates varieties of RTL8723CS
(CG, VF, XX) with RTL8703B using vendor's command to read chip type.

Also this chip declares support for some features it doesn't support
so add a quirk to indicate that these features are broken.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Bastian Germann <bage@debian.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btrtl.c  | 120 +++++++++++++++++++++++++++++++++++--
 drivers/bluetooth/btrtl.h  |   5 ++
 drivers/bluetooth/hci_h5.c |   4 ++
 3 files changed, 125 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index fb52313a1d45a..6b3755345427a 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -17,7 +17,11 @@
 
 #define VERSION "0.1"
 
+#define RTL_CHIP_8723CS_CG	3
+#define RTL_CHIP_8723CS_VF	4
+#define RTL_CHIP_8723CS_XX	5
 #define RTL_EPATCH_SIGNATURE	"Realtech"
+#define RTL_ROM_LMP_8703B	0x8703
 #define RTL_ROM_LMP_8723A	0x1200
 #define RTL_ROM_LMP_8723B	0x8723
 #define RTL_ROM_LMP_8821A	0x8821
@@ -30,6 +34,7 @@
 #define IC_MATCH_FL_HCIREV	(1 << 1)
 #define IC_MATCH_FL_HCIVER	(1 << 2)
 #define IC_MATCH_FL_HCIBUS	(1 << 3)
+#define IC_MATCH_FL_CHIP_TYPE	(1 << 4)
 #define IC_INFO(lmps, hcir, hciv, bus) \
 	.match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_HCIREV | \
 		       IC_MATCH_FL_HCIVER | IC_MATCH_FL_HCIBUS, \
@@ -59,6 +64,7 @@ struct id_table {
 	__u16 hci_rev;
 	__u8 hci_ver;
 	__u8 hci_bus;
+	__u8 chip_type;
 	bool config_needed;
 	bool has_rom_version;
 	bool has_msft_ext;
@@ -99,6 +105,39 @@ static const struct id_table ic_id_table[] = {
 	  .fw_name  = "rtl_bt/rtl8723b_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8723b_config" },
 
+	/* 8723CS-CG */
+	{ .match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_CHIP_TYPE |
+			 IC_MATCH_FL_HCIBUS,
+	  .lmp_subver = RTL_ROM_LMP_8703B,
+	  .chip_type = RTL_CHIP_8723CS_CG,
+	  .hci_bus = HCI_UART,
+	  .config_needed = true,
+	  .has_rom_version = true,
+	  .fw_name  = "rtl_bt/rtl8723cs_cg_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8723cs_cg_config" },
+
+	/* 8723CS-VF */
+	{ .match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_CHIP_TYPE |
+			 IC_MATCH_FL_HCIBUS,
+	  .lmp_subver = RTL_ROM_LMP_8703B,
+	  .chip_type = RTL_CHIP_8723CS_VF,
+	  .hci_bus = HCI_UART,
+	  .config_needed = true,
+	  .has_rom_version = true,
+	  .fw_name  = "rtl_bt/rtl8723cs_vf_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8723cs_vf_config" },
+
+	/* 8723CS-XX */
+	{ .match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_CHIP_TYPE |
+			 IC_MATCH_FL_HCIBUS,
+	  .lmp_subver = RTL_ROM_LMP_8703B,
+	  .chip_type = RTL_CHIP_8723CS_XX,
+	  .hci_bus = HCI_UART,
+	  .config_needed = true,
+	  .has_rom_version = true,
+	  .fw_name  = "rtl_bt/rtl8723cs_xx_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8723cs_xx_config" },
+
 	/* 8723D */
 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xd, 0x8, HCI_USB),
 	  .config_needed = true,
@@ -208,7 +247,8 @@ static const struct id_table ic_id_table[] = {
 	};
 
 static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev,
-					     u8 hci_ver, u8 hci_bus)
+					     u8 hci_ver, u8 hci_bus,
+					     u8 chip_type)
 {
 	int i;
 
@@ -225,6 +265,9 @@ static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev,
 		if ((ic_id_table[i].match_flags & IC_MATCH_FL_HCIBUS) &&
 		    (ic_id_table[i].hci_bus != hci_bus))
 			continue;
+		if ((ic_id_table[i].match_flags & IC_MATCH_FL_CHIP_TYPE) &&
+		    (ic_id_table[i].chip_type != chip_type))
+			continue;
 
 		break;
 	}
@@ -307,6 +350,7 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 		{ RTL_ROM_LMP_8723B, 1 },
 		{ RTL_ROM_LMP_8821A, 2 },
 		{ RTL_ROM_LMP_8761A, 3 },
+		{ RTL_ROM_LMP_8703B, 7 },
 		{ RTL_ROM_LMP_8822B, 8 },
 		{ RTL_ROM_LMP_8723B, 9 },	/* 8723D */
 		{ RTL_ROM_LMP_8821A, 10 },	/* 8821C */
@@ -587,6 +631,48 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev,
 	return ret;
 }
 
+static bool rtl_has_chip_type(u16 lmp_subver)
+{
+	switch (lmp_subver) {
+	case RTL_ROM_LMP_8703B:
+		return true;
+	default:
+		break;
+	}
+
+	return  false;
+}
+
+static int rtl_read_chip_type(struct hci_dev *hdev, u8 *type)
+{
+	struct rtl_chip_type_evt *chip_type;
+	struct sk_buff *skb;
+	const unsigned char cmd_buf[] = {0x00, 0x94, 0xa0, 0x00, 0xb0};
+
+	/* Read RTL chip type command */
+	skb = __hci_cmd_sync(hdev, 0xfc61, 5, cmd_buf, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		rtl_dev_err(hdev, "Read chip type failed (%ld)",
+			    PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+
+	chip_type = skb_pull_data(skb, sizeof(*chip_type));
+	if (!chip_type) {
+		rtl_dev_err(hdev, "RTL chip type event length mismatch");
+		kfree_skb(skb);
+		return -EIO;
+	}
+
+	rtl_dev_info(hdev, "chip_type status=%x type=%x",
+		     chip_type->status, chip_type->type);
+
+	*type = chip_type->type & 0x0f;
+
+	kfree_skb(skb);
+	return 0;
+}
+
 void btrtl_free(struct btrtl_device_info *btrtl_dev)
 {
 	kvfree(btrtl_dev->fw_data);
@@ -603,7 +689,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	struct hci_rp_read_local_version *resp;
 	char cfg_name[40];
 	u16 hci_rev, lmp_subver;
-	u8 hci_ver;
+	u8 hci_ver, chip_type = 0;
 	int ret;
 	u16 opcode;
 	u8 cmd[2];
@@ -629,8 +715,14 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	hci_rev = le16_to_cpu(resp->hci_rev);
 	lmp_subver = le16_to_cpu(resp->lmp_subver);
 
+	if (rtl_has_chip_type(lmp_subver)) {
+		ret = rtl_read_chip_type(hdev, &chip_type);
+		if (ret)
+			goto err_free;
+	}
+
 	btrtl_dev->ic_info = btrtl_match_ic(lmp_subver, hci_rev, hci_ver,
-					    hdev->bus);
+					    hdev->bus, chip_type);
 
 	if (!btrtl_dev->ic_info)
 		btrtl_dev->drop_fw = true;
@@ -673,7 +765,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 		lmp_subver = le16_to_cpu(resp->lmp_subver);
 
 		btrtl_dev->ic_info = btrtl_match_ic(lmp_subver, hci_rev, hci_ver,
-						    hdev->bus);
+						    hdev->bus, chip_type);
 	}
 out_free:
 	kfree_skb(skb);
@@ -755,6 +847,7 @@ int btrtl_download_firmware(struct hci_dev *hdev,
 	case RTL_ROM_LMP_8761A:
 	case RTL_ROM_LMP_8822B:
 	case RTL_ROM_LMP_8852A:
+	case RTL_ROM_LMP_8703B:
 		return btrtl_setup_rtl8723b(hdev, btrtl_dev);
 	default:
 		rtl_dev_info(hdev, "assuming no firmware upload needed");
@@ -788,6 +881,19 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 		rtl_dev_dbg(hdev, "WBS supported not enabled.");
 		break;
 	}
+
+	switch (btrtl_dev->ic_info->lmp_subver) {
+	case RTL_ROM_LMP_8703B:
+		/* 8723CS reports two pages for local ext features,
+		 * but it doesn't support any features from page 2 -
+		 * it either responds with garbage or with error status
+		 */
+		set_bit(HCI_QUIRK_BROKEN_LOCAL_EXT_FEATURES_PAGE_2,
+			&hdev->quirks);
+		break;
+	default:
+		break;
+	}
 }
 EXPORT_SYMBOL_GPL(btrtl_set_quirks);
 
@@ -946,6 +1052,12 @@ MODULE_FIRMWARE("rtl_bt/rtl8723b_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723b_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723bs_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723bs_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723cs_cg_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723cs_cg_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723cs_vf_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723cs_vf_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723cs_xx_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723cs_xx_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723ds_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723ds_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8761a_fw.bin");
diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
index 2c441bda390a0..1c6282241d2d2 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -14,6 +14,11 @@
 
 struct btrtl_device_info;
 
+struct rtl_chip_type_evt {
+	__u8 status;
+	__u8 type;
+} __packed;
+
 struct rtl_download_cmd {
 	__u8 index;
 	__u8 data[RTL_FRAG_LEN];
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 6455bc4fb5bb3..e90670955df2c 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -936,6 +936,8 @@ static int h5_btrtl_setup(struct h5 *h5)
 	err = btrtl_download_firmware(h5->hu->hdev, btrtl_dev);
 	/* Give the device some time before the hci-core sends it a reset */
 	usleep_range(10000, 20000);
+	if (err)
+		goto out_free;
 
 	btrtl_set_quirks(h5->hu->hdev, btrtl_dev);
 
@@ -1100,6 +1102,8 @@ static const struct of_device_id rtl_bluetooth_of_match[] = {
 	  .data = (const void *)&h5_data_rtl8822cs },
 	{ .compatible = "realtek,rtl8723bs-bt",
 	  .data = (const void *)&h5_data_rtl8723bs },
+	{ .compatible = "realtek,rtl8723cs-bt",
+	  .data = (const void *)&h5_data_rtl8723bs },
 	{ .compatible = "realtek,rtl8723ds-bt",
 	  .data = (const void *)&h5_data_rtl8723bs },
 #endif
-- 
2.39.2

