Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EA174C540
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 17:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjGIPPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 11:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbjGIPOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 11:14:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE0A18B;
        Sun,  9 Jul 2023 08:14:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D66560C20;
        Sun,  9 Jul 2023 15:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A70BC433CB;
        Sun,  9 Jul 2023 15:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688915652;
        bh=c/oKHJLpim/+iwBeTdXgaVi2oIrILGGaF+iWrRNLqME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gR0Sb7c+an+Phf6Zihxjy/IDQL6QYccdRqpirfuaCd9ae8vn2VlnztWPGQPx/I+Mi
         6Uf4yjGb8gOwAJSojgSJb5nstbEYTe7ihEDJM3UZ+as1NHB13cydi4Jb08gyLFPlE0
         mYdCf1T/+XHWV5rlj8cJbBMp/7oEdtEm4O9inVpC5kmr6LrR99WXspRWeaHcH9O/qK
         4KPQot6IDiT2gWCjpjOpp2QHSgXD/XVuhB6NzYLuP74IAMjNF8RSL6aq3GSErAazLU
         IQvPSXRO3VxoCOtqe50lSfxfuHTX+kkhWFox8rAK5c/TqoFtJVOZAh7NrccCbE7n1F
         UbLeP5NsDN6Vw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Gong <quic_wgong@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 09/22] wifi: ath11k: add support default regdb while searching board-2.bin for WCN6855
Date:   Sun,  9 Jul 2023 11:13:43 -0400
Message-Id: <20230709151356.513279-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151356.513279-1-sashal@kernel.org>
References: <20230709151356.513279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.12
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Gong <quic_wgong@quicinc.com>

[ Upstream commit 88ca89202f8e8afb5225eb5244d79cd67c15d744 ]

Sometimes board-2.bin does not have the regdb data which matched the
parameters such as vendor, device, subsystem-vendor, subsystem-device
and etc. Add default regdb data with 'bus=%s' into board-2.bin for
WCN6855, then ath11k use 'bus=pci' to search regdb data in board-2.bin
for WCN6855.

kernel: [  122.515808] ath11k_pci 0000:03:00.0: boot using board name 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262'
kernel: [  122.517240] ath11k_pci 0000:03:00.0: boot firmware request ath11k/WCN6855/hw2.0/board-2.bin size 6179564
kernel: [  122.517280] ath11k_pci 0000:03:00.0: failed to fetch regdb data for bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=262 from ath11k/WCN6855/hw2.0/board-2.bin
kernel: [  122.517464] ath11k_pci 0000:03:00.0: boot using board name 'bus=pci'
kernel: [  122.518901] ath11k_pci 0000:03:00.0: boot firmware request ath11k/WCN6855/hw2.0/board-2.bin size 6179564
kernel: [  122.518915] ath11k_pci 0000:03:00.0: board name
kernel: [  122.518917] ath11k_pci 0000:03:00.0: 00000000: 62 75 73 3d 70 63 69                             bus=pci
kernel: [  122.518918] ath11k_pci 0000:03:00.0: boot found match regdb data for name 'bus=pci'
kernel: [  122.518920] ath11k_pci 0000:03:00.0: boot found regdb data for 'bus=pci'
kernel: [  122.518921] ath11k_pci 0000:03:00.0: fetched regdb

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230517133959.8224-1-quic_wgong@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 53 +++++++++++++++++++-------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 75fdbe4ef83a4..455141a8f0ff6 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -969,7 +969,8 @@ int ath11k_core_check_dt(struct ath11k_base *ab)
 }
 
 static int __ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
-					   size_t name_len, bool with_variant)
+					   size_t name_len, bool with_variant,
+					   bool bus_type_mode)
 {
 	/* strlen(',variant=') + strlen(ab->qmi.target.bdf_ext) */
 	char variant[9 + ATH11K_QMI_BDF_EXT_STR_LENGTH] = { 0 };
@@ -980,15 +981,20 @@ static int __ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
 
 	switch (ab->id.bdf_search) {
 	case ATH11K_BDF_SEARCH_BUS_AND_BOARD:
-		scnprintf(name, name_len,
-			  "bus=%s,vendor=%04x,device=%04x,subsystem-vendor=%04x,subsystem-device=%04x,qmi-chip-id=%d,qmi-board-id=%d%s",
-			  ath11k_bus_str(ab->hif.bus),
-			  ab->id.vendor, ab->id.device,
-			  ab->id.subsystem_vendor,
-			  ab->id.subsystem_device,
-			  ab->qmi.target.chip_id,
-			  ab->qmi.target.board_id,
-			  variant);
+		if (bus_type_mode)
+			scnprintf(name, name_len,
+				  "bus=%s",
+				  ath11k_bus_str(ab->hif.bus));
+		else
+			scnprintf(name, name_len,
+				  "bus=%s,vendor=%04x,device=%04x,subsystem-vendor=%04x,subsystem-device=%04x,qmi-chip-id=%d,qmi-board-id=%d%s",
+				  ath11k_bus_str(ab->hif.bus),
+				  ab->id.vendor, ab->id.device,
+				  ab->id.subsystem_vendor,
+				  ab->id.subsystem_device,
+				  ab->qmi.target.chip_id,
+				  ab->qmi.target.board_id,
+				  variant);
 		break;
 	default:
 		scnprintf(name, name_len,
@@ -1007,13 +1013,19 @@ static int __ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
 static int ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
 					 size_t name_len)
 {
-	return __ath11k_core_create_board_name(ab, name, name_len, true);
+	return __ath11k_core_create_board_name(ab, name, name_len, true, false);
 }
 
 static int ath11k_core_create_fallback_board_name(struct ath11k_base *ab, char *name,
 						  size_t name_len)
 {
-	return __ath11k_core_create_board_name(ab, name, name_len, false);
+	return __ath11k_core_create_board_name(ab, name, name_len, false, false);
+}
+
+static int ath11k_core_create_bus_type_board_name(struct ath11k_base *ab, char *name,
+						  size_t name_len)
+{
+	return __ath11k_core_create_board_name(ab, name, name_len, false, true);
 }
 
 const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
@@ -1317,7 +1329,7 @@ int ath11k_core_fetch_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd)
 
 int ath11k_core_fetch_regdb(struct ath11k_base *ab, struct ath11k_board_data *bd)
 {
-	char boardname[BOARD_NAME_SIZE];
+	char boardname[BOARD_NAME_SIZE], default_boardname[BOARD_NAME_SIZE];
 	int ret;
 
 	ret = ath11k_core_create_board_name(ab, boardname, BOARD_NAME_SIZE);
@@ -1334,6 +1346,21 @@ int ath11k_core_fetch_regdb(struct ath11k_base *ab, struct ath11k_board_data *bd
 	if (!ret)
 		goto exit;
 
+	ret = ath11k_core_create_bus_type_board_name(ab, default_boardname,
+						     BOARD_NAME_SIZE);
+	if (ret) {
+		ath11k_dbg(ab, ATH11K_DBG_BOOT,
+			   "failed to create default board name for regdb: %d", ret);
+		goto exit;
+	}
+
+	ret = ath11k_core_fetch_board_data_api_n(ab, bd, default_boardname,
+						 ATH11K_BD_IE_REGDB,
+						 ATH11K_BD_IE_REGDB_NAME,
+						 ATH11K_BD_IE_REGDB_DATA);
+	if (!ret)
+		goto exit;
+
 	ret = ath11k_core_fetch_board_data_api_1(ab, bd, ATH11K_REGDB_FILE_NAME);
 	if (ret)
 		ath11k_dbg(ab, ATH11K_DBG_BOOT, "failed to fetch %s from %s\n",
-- 
2.39.2

