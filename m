Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45B16C30C7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjCULsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjCULsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:48:45 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189BDA253;
        Tue, 21 Mar 2023 04:48:40 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32LBmHC61013171, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32LBmHC61013171
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 21 Mar 2023 19:48:17 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 21 Mar 2023 19:48:31 +0800
Received: from localhost (172.21.132.123) by RTEXMBS03.realtek.com.tw
 (172.21.6.96) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 21 Mar
 2023 19:48:31 +0800
From:   <max.chou@realtek.com>
To:     <marcel@holtmann.org>
CC:     <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alex_lu@realsil.com.cn>, <hildawu@realtek.com>,
        <max.chou@realtek.com>
Subject: [PATCH 1/1] Bluetooth: btrtl: check for NULL in btrtl_set_quirks()
Date:   Tue, 21 Mar 2023 19:48:26 +0800
Message-ID: <20230321114826.3544-1-max.chou@realtek.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.132.123]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/21/2023 11:30:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzMvMjEgpFekyCAwOTowNDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Chou <max.chou@realtek.com>

The btrtl_set_quirks() has accessed btrtl_dev->ic_info->lmp_subver since
b8e482d02513. However, if installing a Realtek Bluetooth controller
without the driver supported, it will hit the NULL point accessed.

Add a check for NULL to avoid the Kernel Oops.

Signed-off-by: Max Chou <max.chou@realtek.com>
---
 drivers/bluetooth/btrtl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 8fa7733812ad..0f256a8abef4 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -905,6 +905,9 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 		break;
 	}
 
+	if (!btrtl_dev->ic_info)
+		return;
+
 	switch (btrtl_dev->ic_info->lmp_subver) {
 	case RTL_ROM_LMP_8703B:
 		/* 8723CS reports two pages for local ext features,
-- 
2.34.1

