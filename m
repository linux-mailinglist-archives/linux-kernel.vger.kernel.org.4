Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A396731B29
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344448AbjFOOVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240067AbjFOOVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:21:16 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5129C272D;
        Thu, 15 Jun 2023 07:21:10 -0700 (PDT)
Received: from workstation5.fritz.box (ip-084-119-033-219.um24.pools.vodafone-ip.de [84.119.33.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id F093C3F259;
        Thu, 15 Jun 2023 14:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686838868;
        bh=eC5qQ/JyyQIBjyDctp6iNTZGn5tmDA+jJ9lX2qPLCSs=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=DyGjdr2VWuhQZPV2BO2ZzF8oIPnQEjxWRusqkHpuVFQcFbsnlhnqeTunI6nCZnLLp
         LMuvc2JwNIKkomRJfbKjn7xv7JLZ3lwFLzbqWuGPNElnDzddzqNWGpk6mdD5DzObqJ
         4k+Y7pzkPNlHg5X8a4r/hgRRoYQLTO3yKdPdeX1l45iEkhI8ufY2WgQis4m7PMR3jl
         cbM0jBGIbderK19ulb/HB9etrPjGwxoG8ol2fKgP5XiNFqKfQY8B3gQgjR5KHtNtrr
         rcrndIiQG8px7L+LCxtuKE1RVA1mXKnGfubAqvYa3VJgMZV6XNby1yvsqpP7J1QiS6
         ztW2U/YXSW94A==
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To:     Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Ping-Ke Shih <pkshih@realtek.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 1/1] wifi: rtw88: Add support for the SDIO based RTL8723DS chipset
Date:   Thu, 15 Jun 2023 16:20:44 +0200
Message-Id: <20230615142044.1357257-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wire up RTL8723DS chipset support using the rtw88 SDIO HCI code as
well as the existing RTL8723D chipset code.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---

On my Lichee RV Dock board this patch is enough to make The RTL8723DS
work. But unfortunately after running some time the driver crashes.
My impression is that the crash is not specific to my patch but must
be hidden in one of the existing functions it is invoking.

This seems to be related to not checking pkt_stat->pkt_len.

My kernel was built against v6.4-rc6.

Best regards

Heinrich


[ 1276.644590] rtw_sdio_rx_skb: pkt_stat->pkt_len = 385
[ 1276.747000] rtw_sdio_rx_skb: pkt_stat->pkt_len = 385
[ 1276.951761] rtw_sdio_rx_skb: pkt_stat->pkt_len = 385
[ 1277.054174] rtw_sdio_rx_skb: pkt_stat->pkt_len = 385
[ 1277.160354] rtw_sdio_rx_skb: pkt_stat->pkt_len = 436
[ 1277.259033] rtw_sdio_rx_skb: pkt_stat->pkt_len = 385
[ 1277.264710] rtw_sdio_rx_skb: pkt_stat->pkt_len = 437
[ 1277.270457] rtw_sdio_rx_skb: pkt_stat->pkt_len = 471
[ 1277.276234] rtw_sdio_rx_skb: pkt_stat->pkt_len = 3338
[ 1277.281557] skbuff: skb_over_panic: text:ffffffff052a1ea2 len:3338 put:3338
head:ffffffd81146fa80 data:ffffffd81146fac0 tail:0xd4a end:0x440 dev:<NULL>
[ 1277.295471] ------------[ cut here ]------------
[ 1277.295485] kernel BUG at net/core/skbuff.c:200!
[ 1277.295507] Kernel BUG [#1]
[ 1277.295520] Modules linked in: ccm rtw88_8723ds rtw88_8723d rtw88_sdio
rtw88_core mac80211 hci_uart btqca btrtl sr9700 btbcm dm9601 btintel usbnet mii
bluetooth libarc4 snd_soc_simple_card snd_soc_simple_card_utils sun50i_dmic
snd_soc_dmic cfg80211 snd_soc_core pwrseq_simple sun8i_mixer sun4i_tcon
drm_dma_helper drm_kms_helper sunxi snd_compress phy_generic ac97_bus
snd_pcm_dmaengine musb_hdrc sun8i_tcon_top snd_pcm syscopyarea sysfillrect
sysimgblt ohci_platform ehci_platform udc_core ecdh_generic snd_timer sun8i_ce
ecc crypto_engine snd sun6i_dma virt_dma soundcore leds_gpio cpufreq_dt
binfmt_misc nls_iso8859_1 drm dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua
backlight efi_pstore ip_tables x_tables autofs4 raid10 raid456 libcrc32c
async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq raid1
raid0 multipath linear sunxi_mmc phy_sun4i_usb phy_sun6i_mipi_dphy
uio_pdrv_genirq uio
[ 1277.296331] CPU: 0 PID: 464 Comm: ksdioirqd/mmc1 Tainted: G        W          6.4.0-rc6 #118
[ 1277.296361] Hardware name: Sipeed Lichee RV Dock (DT)
[ 1277.296373] epc : skb_panic+0x4e/0x50
[ 1277.296422]  ra : skb_panic+0x4e/0x50
[ 1277.296454] epc : ffffffff80ba3be4 ra : ffffffff80ba3be4 sp : ffffffd804c9fc70
[ 1277.296475]  gp : ffffffff81e4dff0 tp : ffffffd81230cf80 t0 : ffffffff80b96a1c
[ 1277.296495]  t1 : 0000000000000000 t2 : 73203a666675626b s0 : ffffffd804c9fc90
[ 1277.296514]  s1 : ffffffd804cb8b00 a0 : 000000000000008b a1 : 0000000000000000
[ 1277.296531]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
[ 1277.296548]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000000000000
[ 1277.296564]  s2 : ffffffd804c9fd08 s3 : 000000000000006b s4 : ffffffd804c8a040
[ 1277.296584]  s5 : 0000000000000018 s6 : 0000000000000820 s7 : ffffffff053324b0
[ 1277.296602]  s8 : 000000000000006b s9 : 0000000000000400 s10: 000000000000e002
[ 1277.296619]  s11: ffffffd81146fac0 t3 : ffffffd802504f00 t4 : ffffffd802504f00
[ 1277.296639]  t5 : ffffffd802504000 t6 : ffffffd804c9fa78
[ 1277.296655] status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
[ 1277.296675] [<ffffffff80ba3be4>] skb_panic+0x4e/0x50
[ 1277.296713] [<ffffffff80975156>] warn_crc32c_csum_combine+0x0/0x40
[ 1277.296774] [<ffffffff052a1ea2>] rtw_sdio_rx_skb+0x80/0x11de [rtw88_sdio]
[ 1277.297363] [<ffffffff052a0460>] rtw_sdio_rxfifo_recv+0x1ce/0x270 [rtw88_sdio]
[ 1277.297944] [<ffffffff052a05c6>] rtw_sdio_handle_interrupt+0xc4/0xec [rtw88_sdio]
[ 1277.298521] [<ffffffff80932454>] process_sdio_pending_irqs+0xde/0x18c
[ 1277.298567] [<ffffffff80932578>] sdio_irq_thread+0x76/0x196
[ 1277.298602] [<ffffffff800410c4>] kthread+0xc4/0xe4
[ 1277.298654] [<ffffffff800040d6>] ret_from_fork+0xe/0x20
[ 1277.298720] Code: e076 86f2 b517 0084 0513 c945 4097 ffff 80e7 7940 (9002) 4603 
[ 1277.560399] ---[ end trace 0000000000000000 ]---
[ 1277.560417] Kernel panic - not syncing: Fatal exception in interrupt
[ 1277.571501] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

---
 drivers/net/wireless/realtek/rtw88/Kconfig    | 11 ++++++
 drivers/net/wireless/realtek/rtw88/Makefile   |  3 ++
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  9 +++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.h |  6 ++++
 .../net/wireless/realtek/rtw88/rtw8723ds.c    | 36 +++++++++++++++++++
 5 files changed, 65 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723ds.c

diff --git a/drivers/net/wireless/realtek/rtw88/Kconfig b/drivers/net/wireless/realtek/rtw88/Kconfig
index 29eb2f8e0eb7..4f0d301230fb 100644
--- a/drivers/net/wireless/realtek/rtw88/Kconfig
+++ b/drivers/net/wireless/realtek/rtw88/Kconfig
@@ -111,6 +111,17 @@ config RTW88_8723DE
 
 	  802.11n PCIe wireless network adapter
 
+config RTW88_8723DS
+	tristate "Realtek 8723DS SDIO wireless network adapter"
+	depends on PCI
+	select RTW88_CORE
+	select RTW88_SDIO
+	select RTW88_8723D
+	help
+	  Selecting this option will enable support for the 8723DS chipset.
+
+	  802.11n SDIO wireless network adapter
+
 config RTW88_8723DU
 	tristate "Realtek 8723DU USB wireless network adapter"
 	depends on USB
diff --git a/drivers/net/wireless/realtek/rtw88/Makefile b/drivers/net/wireless/realtek/rtw88/Makefile
index 82979b30ae8d..fd212c09d88a 100644
--- a/drivers/net/wireless/realtek/rtw88/Makefile
+++ b/drivers/net/wireless/realtek/rtw88/Makefile
@@ -50,6 +50,9 @@ rtw88_8723d-objs		:= rtw8723d.o rtw8723d_table.o
 obj-$(CONFIG_RTW88_8723DE)	+= rtw88_8723de.o
 rtw88_8723de-objs		:= rtw8723de.o
 
+obj-$(CONFIG_RTW88_8723DS)	+= rtw88_8723ds.o
+rtw88_8723ds-objs		:= rtw8723ds.o
+
 obj-$(CONFIG_RTW88_8723DU)	+= rtw88_8723du.o
 rtw88_8723du-objs		:= rtw8723du.o
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 06e7454c9ca6..2545daddceba 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -210,6 +210,12 @@ static void rtw8723de_efuse_parsing(struct rtw_efuse *efuse,
 	ether_addr_copy(efuse->addr, map->e.mac_addr);
 }
 
+static void rtw8723ds_efuse_parsing(struct rtw_efuse *efuse,
+				    struct rtw8723d_efuse *map)
+{
+	ether_addr_copy(efuse->addr, map->s.mac_addr);
+}
+
 static void rtw8723du_efuse_parsing(struct rtw_efuse *efuse,
 				    struct rtw8723d_efuse *map)
 {
@@ -245,6 +251,9 @@ static int rtw8723d_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 	case RTW_HCI_TYPE_PCIE:
 		rtw8723de_efuse_parsing(efuse, map);
 		break;
+	case RTW_HCI_TYPE_SDIO:
+		rtw8723ds_efuse_parsing(efuse, map);
+		break;
 	case RTW_HCI_TYPE_USB:
 		rtw8723du_efuse_parsing(efuse, map);
 		break;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.h b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
index a356318a5c15..c510a0f76dcd 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
@@ -41,6 +41,11 @@ struct rtw8723de_efuse {
 	u8 sub_device_id[2];
 };
 
+struct rtw8723ds_efuse {
+	u8 res4[0x4a];			/* 0xd0 */
+	u8 mac_addr[ETH_ALEN];		/* 0x11a */
+};
+
 struct rtw8723du_efuse {
 	u8 res4[48];                    /* 0xd0 */
 	u8 vender_id[2];                /* 0x100 */
@@ -79,6 +84,7 @@ struct rtw8723d_efuse {
 	u8 res[3];
 	union {
 		struct rtw8723de_efuse e;
+		struct rtw8723ds_efuse s;
 		struct rtw8723du_efuse u;
 	};
 };
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723ds.c b/drivers/net/wireless/realtek/rtw88/rtw8723ds.c
new file mode 100644
index 000000000000..679a9f50cfad
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723ds.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
+ */
+
+#include <linux/mmc/sdio_func.h>
+#include <linux/mmc/sdio_ids.h>
+#include <linux/module.h>
+#include "main.h"
+#include "rtw8723d.h"
+#include "sdio.h"
+
+static const struct sdio_device_id rtw_8723ds_id_table[] =  {
+	{
+		SDIO_DEVICE(SDIO_VENDOR_ID_REALTEK,
+			    SDIO_DEVICE_ID_REALTEK_RTW8723DS),
+		.driver_data = (kernel_ulong_t)&rtw8723d_hw_spec,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(sdio, rtw_8723ds_id_table);
+
+static struct sdio_driver rtw_8723ds_driver = {
+	.name = "rtw_8723ds",
+	.probe = rtw_sdio_probe,
+	.remove = rtw_sdio_remove,
+	.id_table = rtw_8723ds_id_table,
+	.drv = {
+		.pm = &rtw_sdio_pm_ops,
+		.shutdown = rtw_sdio_shutdown,
+	}
+};
+module_sdio_driver(rtw_8723ds_driver);
+
+MODULE_AUTHOR("Heinrich Schuchardt <heinrich.schuchardt@canonical.com>");
+MODULE_DESCRIPTION("Realtek 802.11n wireless 8723ds driver");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.40.1

