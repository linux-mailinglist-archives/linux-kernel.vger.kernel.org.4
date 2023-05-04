Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E8C6F748D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjEDTva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjEDTuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:50:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C96317DC5;
        Thu,  4 May 2023 12:46:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C994637BF;
        Thu,  4 May 2023 19:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A83BC4339B;
        Thu,  4 May 2023 19:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229585;
        bh=I2JutGAzKuWJAJo7y+0gfP6gmsAJsCg9iW5zsOlfjuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhZW05Fc+nps5BnPUVXY39CWnDv8NCrkBs+thTf0QGMSr4pFUodsz9zCemyCdCxNR
         psCsmIkupBGM8OwPoKRWnYK6cnEQ9GCXCNZcMrfatkfr6o0YPxZhkZnMR/6wj7HDp9
         PaKmwDy+pGxWv8MV4cpRm/MziAvHtdiQGyGGdCXaPcKolbllteTnOSSNdQcMY/DyqC
         dZgBwe8l0ZvKiRxIEkgpamTv+yqSxX2SlUiRzD4Po+DDxuBVBsSxi0AZ1Y2yn/e/dW
         oRnwBkCh8futFXJ4xLJGwXuokDcmrUNW2pDxloy9g9OCjDY926yZkhC5GA0ZPW5Mp6
         jq99GqH0Bpi3Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Chou <max.chou@realtek.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 53/53] Bluetooth: btrtl: Add the support for RTL8851B
Date:   Thu,  4 May 2023 15:44:13 -0400
Message-Id: <20230504194413.3806354-53-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194413.3806354-1-sashal@kernel.org>
References: <20230504194413.3806354-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Chou <max.chou@realtek.com>

[ Upstream commit 7948fe1c92d92313eea5453f83deb7f0141355e8 ]

Add the support for RTL8851B BT controller on USB interface.
The necessary firmware will be submitted to linux-firmware project.

Note that the Bluetooth devices WITH the VID=0x0bda would be set the
feature quirk in btrtl_setup_realtek(). It's able to ignore the
feature flag set for the specific VID and PID in blacklist_table[] of
btusb.c. (check [1])

If Realtek Bluetooth chips WITHOUT the VID=0x0bda, it shall be added
the feature flag for the specific VID and PID in blacklist_table[] of
btusb.c. (check [2])

[1] '9ab9235fe5cf ("Bluetooth: btrtl: Enable WBS for the specific
    Realtek devices")'
[2] '73280f13c9bb ("Bluetooth: btusb: Add the more support IDs for
    Realtek RTL8822CE")'

The device info from /sys/kernel/debug/usb/devices as below.

T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 33 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0bda ProdID=b851 Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=802.11ax WLAN Adapter
S:  SerialNumber=00E04C885A01
C:* #Ifs= 3 Cfg#= 1 Atr=80 MxPwr=500mA
A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 8 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=09(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0a(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0b(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0c(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Max Chou <max.chou@realtek.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btrtl.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 7061621faeb0c..4fbb282cac4b5 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -28,6 +28,7 @@
 #define RTL_ROM_LMP_8761A	0x8761
 #define RTL_ROM_LMP_8822B	0x8822
 #define RTL_ROM_LMP_8852A	0x8852
+#define RTL_ROM_LMP_8851B	0x8851
 #define RTL_CONFIG_MAGIC	0x8723ab55
 
 #define IC_MATCH_FL_LMPSUBV	(1 << 0)
@@ -56,6 +57,7 @@ enum btrtl_chip_id {
 	CHIP_ID_8852A = 18,
 	CHIP_ID_8852B = 20,
 	CHIP_ID_8852C = 25,
+	CHIP_ID_8851B = 36,
 };
 
 struct id_table {
@@ -244,6 +246,14 @@ static const struct id_table ic_id_table[] = {
 	  .has_msft_ext = true,
 	  .fw_name  = "rtl_bt/rtl8852cu_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8852cu_config" },
+
+	/* 8851B */
+	{ IC_INFO(RTL_ROM_LMP_8851B, 0xb, 0xc, HCI_USB),
+	  .config_needed = false,
+	  .has_rom_version = true,
+	  .has_msft_ext = false,
+	  .fw_name  = "rtl_bt/rtl8851bu_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8851bu_config" },
 	};
 
 static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev,
@@ -359,6 +369,7 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 		{ RTL_ROM_LMP_8852A, 18 },	/* 8852A */
 		{ RTL_ROM_LMP_8852A, 20 },	/* 8852B */
 		{ RTL_ROM_LMP_8852A, 25 },	/* 8852C */
+		{ RTL_ROM_LMP_8851B, 36 },	/* 8851B */
 	};
 
 	min_size = sizeof(struct rtl_epatch_header) + sizeof(extension_sig) + 3;
@@ -848,6 +859,7 @@ int btrtl_download_firmware(struct hci_dev *hdev,
 	case RTL_ROM_LMP_8822B:
 	case RTL_ROM_LMP_8852A:
 	case RTL_ROM_LMP_8703B:
+	case RTL_ROM_LMP_8851B:
 		return btrtl_setup_rtl8723b(hdev, btrtl_dev);
 	default:
 		rtl_dev_info(hdev, "assuming no firmware upload needed");
@@ -872,6 +884,7 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 	case CHIP_ID_8852A:
 	case CHIP_ID_8852B:
 	case CHIP_ID_8852C:
+	case CHIP_ID_8851B:
 		set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
 		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
 
@@ -1082,3 +1095,5 @@ MODULE_FIRMWARE("rtl_bt/rtl8852bu_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852bu_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8851bu_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8851bu_config.bin");
-- 
2.39.2

