Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1CA73B328
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 11:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjFWJBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 05:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjFWJAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 05:00:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C010F30D2;
        Fri, 23 Jun 2023 02:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687510822; x=1719046822;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HWj1VSHjeQifGegDV6SwXxM3IwTPiL+2f0IbuRC5FmI=;
  b=K9HVQBUPwviHju8xiOJzhGOM9OrQ6EtxZXQ3PKAnayHY8kkaOOeUMK8n
   DEVPu60SuTrwfLuS3g1bkrGsA5eNoAEVcPIIcueQXSj/sQ9Wi6PqeJiwS
   sMIIgfs60B0yyjuGlul8RQDPDA+asj3QTnn8QMCwV2Tuc15h92gUHy2/0
   pIz3wB96dudeK6Y/qWh1MaE+vzce0ToU/sFik/0xaH+I3X7byDV9Vx6KG
   y4N9vfoZ+dcnH/yM7inA+YY05e0U6u/2eTmdKoQW38FXm2PxjLslUTAhr
   sZMwvvDMhFMzuskwf+9luET8mjX82LDHr7IQt+nEr5wdxa8Cv6rqHqMf6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="345477332"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="345477332"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 01:59:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="961901236"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="961901236"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jun 2023 01:59:23 -0700
Received: from inlubt0246.localdomain (inlubt0246.iind.intel.com [10.67.198.165])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id C345515B53;
        Fri, 23 Jun 2023 14:29:22 +0530 (IST)
Received: by inlubt0246.localdomain (Postfix, from userid 12088949)
        id B8C965F772; Fri, 23 Jun 2023 14:29:22 +0530 (IST)
From:   Kumari Pallavi <kumari.pallavi@intel.com>
To:     rcsekar@samsung.com, wg@grandegger.com, mkl@pengutronix.de,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mallikarjunappa.sangannavar@intel.com, jarkko.nikula@intel.com,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kumari Pallavi <kumari.pallavi@intel.com>,
        Srikanth Thokala <srikanth.thokala@intel.com>
Subject: [RESEND] [PATCH 1/1] can: m_can: Control tx and rx flow to avoid communication stall
Date:   Fri, 23 Jun 2023 14:29:20 +0530
Message-Id: <20230623085920.12904-1-kumari.pallavi@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In bi-directional CAN transfer using M_CAN IP, with
the frame gap being set to '0', it leads to Protocol
error in Arbitration phase resulting in communication
stall.
Discussed with Bosch M_CAN IP team and the stall issue
can only be overcome by controlling the tx and rx 
packets flow as done by the patch.

Rx packets would also be serviced when there is a tx 
interrupt. The solution has been tested extensively for
more than 10 days, and no issues has been observed.

Setup that is used to reproduce the issue: 

+---------------------+		+----------------------+
|Intel ElkhartLake    |		|Intel ElkhartLake     |		
|	+--------+    |		|	+--------+     |
|	|m_can 0 |    |<=======>|	|m_can 0 |     |		    
|	+--------+    |		|	+--------+     |		 
+---------------------+		+----------------------+           

Steps to be run on the two Elkhartlake HW:

1. ip link set can0 type can bitrate 1000000
2. ip link set can0 txqueuelen 2048
3. ip link set can0 up
4. cangen -g 0 can0
5. candump can0

cangen -g 0 can0 & candump can0 commands are used for transmit and 
receive on both the m_can HW simultaneously where -g is the frame gap 
between two frames.

Signed-off-by: Kumari Pallavi <kumari.pallavi@intel.com>
Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
---
 drivers/net/can/m_can/m_can.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a5003435802b..94aa0ba89202 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1118,7 +1118,7 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 			/* New TX FIFO Element arrived */
 			if (m_can_echo_tx_event(dev) != 0)
 				goto out_fail;
-
+			m_can_write(cdev, M_CAN_IE, IR_ALL_INT & ~(IR_TEFN));
 			if (netif_queue_stopped(dev) &&
 			    !m_can_tx_fifo_full(cdev))
 				netif_wake_queue(dev);
@@ -1787,6 +1787,7 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 		}
 	} else {
 		cdev->tx_skb = skb;
+		m_can_write(cdev, M_CAN_IE, IR_ALL_INT & (IR_TEFN));
 		return m_can_tx_handler(cdev);
 	}
 
-- 
2.17.1

