Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B555EF48E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbiI2LpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbiI2Lor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:44:47 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D61D8303FE;
        Thu, 29 Sep 2022 04:44:42 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28TBi5vY5024861, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28TBi5vY5024861
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 29 Sep 2022 19:44:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 29 Sep 2022 19:44:31 +0800
Received: from localhost.localdomain (172.21.132.192) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 29 Sep 2022 19:44:30 +0800
From:   <hildawu@realtek.com>
To:     <marcel@holtmann.org>
CC:     <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <apusaka@chromium.org>, <yinghsu@chromium.org>,
        <max.chou@realtek.com>, <alex_lu@realsil.com.cn>,
        <kidman@realtek.com>
Subject: [PATCH v3 0/3] Bluetooth: Add btrealtek data struct and improve SCO sound quality of RTK chips
Date:   Thu, 29 Sep 2022 19:44:23 +0800
Message-ID: <20220929114426.4413-1-hildawu@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/29/2022 11:15:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMjkgpFekyCAwODo1NjowMA==?=
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

From: Hilda Wu <hildawu@realtek.com>

Add btrealtek data struct and use definition of vendor flags to manage the
specific chip.

The Bluetooth: btusb: Workaround for spotty SCO quality patch is for
filter out duplicate packet for avoiding spotty SCO quality.
- The comparison of btrtl_usb_recv_isoc here is for invalid handle,
the invalid handle shouldn't appear.
So we try to find out the rule and filter out this.

The Bluetooth: btsub: Ignore zero length of USB packets on ALT 6 patch is
for some Realtek chips need to transmit mSBC data continuously without the
zero length of USB packets.

---
Changes in v3:
 - Use the vendor function to replace btus_recv_isoc.
 - For ignore_usb_alt6_packet_flow, manage the common flag by the vendor private flag.

Changes in v2:
 - Set the proper priv_size to hci_alloc_dev_priv().
 - Separate commits for functions.
---
Thank you for your review and suggestions.

Hilda Wu (3):
  Bluetooth: btrtl: Add btrealtek data struct
  Bluetooth: btusb: Workaround for spotty SCO quality
  Bluetooth:btsub:Ignore zero length of USB packets on ALT 6 for
    specific chip

 drivers/bluetooth/btrtl.c |  34 ++++++++++++
 drivers/bluetooth/btrtl.h |  29 +++++++++++
 drivers/bluetooth/btusb.c | 105 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 165 insertions(+), 3 deletions(-)

-- 
2.17.1

