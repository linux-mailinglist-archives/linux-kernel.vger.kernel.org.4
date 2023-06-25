Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2500173CF74
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 10:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjFYIpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 04:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjFYIp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 04:45:28 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B3B1AE;
        Sun, 25 Jun 2023 01:45:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vlro46n_1687682714;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Vlro46n_1687682714)
          by smtp.aliyun-inc.com;
          Sun, 25 Jun 2023 16:45:24 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] Bluetooth: hci_conn: Use kmemdup() to replace kzalloc + memcpy
Date:   Sun, 25 Jun 2023 16:45:13 +0800
Message-Id: <20230625084513.6319-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kmemdup rather than duplicating its implementation.

./net/bluetooth/hci_conn.c:1880:7-14: WARNING opportunity for kmemdup.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5597
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 net/bluetooth/hci_conn.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 62a7ccfdfe63..47e7aa4d63a9 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1877,12 +1877,10 @@ static bool hci_le_set_cig_params(struct hci_conn *conn, struct bt_iso_qos *qos)
 	if (qos->ucast.cis == BT_ISO_QOS_CIS_UNSET || !data.pdu.cp.num_cis)
 		return false;
 
-	pdu = kzalloc(sizeof(*pdu), GFP_KERNEL);
+	pdu = kmemdup(&data.pdu, sizeof(*pdu), GFP_KERNEL);
 	if (!pdu)
 		return false;
 
-	memcpy(pdu, &data.pdu, sizeof(*pdu));
-
 	if (hci_cmd_sync_queue(hdev, set_cig_params_sync, pdu,
 			       set_cig_params_complete) < 0) {
 		kfree(pdu);
-- 
2.20.1.7.g153144c

