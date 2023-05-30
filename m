Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF7B7158A7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjE3Iei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjE3Iee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:34:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14A6A8;
        Tue, 30 May 2023 01:34:33 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34U8YB0V0016942, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34U8YB0V0016942
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 30 May 2023 16:34:11 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 30 May 2023 16:34:25 +0800
Received: from localhost.localhost (172.21.132.123) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 30 May 2023 16:34:24 +0800
From:   <max.chou@realtek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alex_lu@realsil.com.cn>, <hildawu@realtek.com>,
        <max.chou@realtek.com>
Subject: [PATCH] Bluetooth: btrtl: Correct the length of the HCI command for drop fw
Date:   Tue, 30 May 2023 16:34:20 +0800
Message-ID: <20230530083420.6876-1-max.chou@realtek.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.132.123]
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
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

The original code did not determine the length value of the HCI command
for drop fw even there's no parameter needed. In this commit, use struct
hci_command_hdr to manage opcode and length. It would be more regular and
more readable.

Suggested-by: Alex Lu <alex_lu@realsil.com.cn>
Signed-off-by: Max Chou <max.chou@realtek.com>
---
 drivers/bluetooth/btrtl.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 9a6ae8a2adfc..04399b3c39a0 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1044,12 +1044,11 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	struct btrtl_device_info *btrtl_dev;
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *resp;
+	struct hci_command_hdr *cmd;
 	char cfg_name[40];
 	u16 hci_rev, lmp_subver;
 	u8 hci_ver, lmp_ver, chip_type = 0;
 	int ret;
-	u16 opcode;
-	u8 cmd[2];
 	u8 reg_val[2];
 
 	btrtl_dev = kzalloc(sizeof(*btrtl_dev), GFP_KERNEL);
@@ -1118,15 +1117,14 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 		btrtl_dev->drop_fw = false;
 
 	if (btrtl_dev->drop_fw) {
-		opcode = hci_opcode_pack(0x3f, 0x66);
-		cmd[0] = opcode & 0xff;
-		cmd[1] = opcode >> 8;
-
-		skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
+		skb = bt_skb_alloc(sizeof(*cmd), GFP_KERNEL);
 		if (!skb)
 			goto err_free;
 
-		skb_put_data(skb, cmd, sizeof(cmd));
+		cmd = skb_put(skb, HCI_COMMAND_HDR_SIZE);
+		cmd->opcode = cpu_to_le16(0xfc66);
+		cmd->plen = 0;
+
 		hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
 
 		ret = hdev->send(hdev, skb);
-- 
2.34.1

