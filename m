Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B52705874
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 22:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjEPUOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 16:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjEPUOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:14:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CE29016;
        Tue, 16 May 2023 13:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684268069; x=1715804069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L28G16hJrrLfPktLR0hebItqAWlmJnyqKU55tcFJU2Y=;
  b=vTXKny+/EWrWBmZxCsGc3Y8AMoMSAiT8xW/UfOsWezV4R+J2l6Q6lYM4
   2/MeXro+CgbRBWDNNEjeLBPCzotOSY2tYVZ7HexQSmYVVWX31eso2afan
   KwlSKZji4TIBoZBAd5m2rk54qlvvQ8bJBySaYwAz9wCZo+7vcFawMPdpC
   sDcBrPFraVBD+UmMQ/GdDkQQBAsxI2GYYEnzc01fCMsnoQZzvLtloaJbc
   iCODIPC9/u3miMDRxCZxczvk5RRjXFpDMdOXFyxY7sb8I5unojbeZ03WY
   UKnX+lFukK/AphUKoK36CR8QTv6RVWZp9wq1aUk2E2mH9AOmd0JMnbaVl
   A==;
X-IronPort-AV: E=Sophos;i="5.99,278,1677567600"; 
   d="scan'208";a="213606634"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 May 2023 13:14:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 16 May 2023 13:14:28 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 16 May 2023 13:14:26 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
        <daniel.machon@microchip.com>, <piotr.raczynski@intel.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH net-next v2 5/7] net: lan966x: Add support for offloading default prio
Date:   Tue, 16 May 2023 22:14:06 +0200
Message-ID: <20230516201408.3172428-6-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20230516201408.3172428-1-horatiu.vultur@microchip.com>
References: <20230516201408.3172428-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for offloading default prio.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Piotr Raczynski <piotr.raczynski@intel.com>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../ethernet/microchip/lan966x/lan966x_dcb.c  | 12 +++++++++++
 .../ethernet/microchip/lan966x/lan966x_main.h |  1 +
 .../ethernet/microchip/lan966x/lan966x_port.c | 21 +++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_dcb.c b/drivers/net/ethernet/microchip/lan966x/lan966x_dcb.c
index 17cec9ec5ed25..273e3bfb23897 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_dcb.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_dcb.c
@@ -64,6 +64,11 @@ static void lan966x_dcb_app_update(struct net_device *dev)
 		qos.dscp.map[i] = dcb_getapp(dev, &app_itr);
 	}
 
+	/* Get default prio */
+	qos.default_prio = dcb_ieee_getapp_default_prio_mask(dev);
+	if (qos.default_prio)
+		qos.default_prio = fls(qos.default_prio) - 1;
+
 	/* Enable use of pcp for queue classification */
 	if (lan966x_dcb_apptrust_contains(port->chip_port, DCB_APP_SEL_PCP))
 		qos.pcp.enable = true;
@@ -106,6 +111,13 @@ static int lan966x_dcb_app_validate(struct net_device *dev,
 	int err = 0;
 
 	switch (app->selector) {
+	/* Default priority checks */
+	case IEEE_8021QAZ_APP_SEL_ETHERTYPE:
+		if (app->protocol)
+			err = -EINVAL;
+		else if (app->priority >= NUM_PRIO_QUEUES)
+			err = -ERANGE;
+		break;
 	/* Dscp checks */
 	case IEEE_8021QAZ_APP_SEL_DSCP:
 		if (app->protocol >= LAN966X_PORT_QOS_DSCP_COUNT)
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index 8213440e08672..53711d5380166 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -412,6 +412,7 @@ struct lan966x_port_qos_dscp {
 struct lan966x_port_qos {
 	struct lan966x_port_qos_pcp pcp;
 	struct lan966x_port_qos_dscp dscp;
+	u8 default_prio;
 };
 
 struct lan966x_port {
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_port.c b/drivers/net/ethernet/microchip/lan966x/lan966x_port.c
index 11c552e87ee44..a6608876b71ef 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_port.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_port.c
@@ -443,11 +443,32 @@ static void lan966x_port_qos_dscp_set(struct lan966x_port *port,
 			lan966x, ANA_DSCP_CFG(i));
 }
 
+static int lan966x_port_qos_default_set(struct lan966x_port *port,
+					struct lan966x_port_qos *qos)
+{
+	/* Set default prio and dp level */
+	lan_rmw(ANA_QOS_CFG_DP_DEFAULT_VAL_SET(0) |
+		ANA_QOS_CFG_QOS_DEFAULT_VAL_SET(qos->default_prio),
+		ANA_QOS_CFG_DP_DEFAULT_VAL |
+		ANA_QOS_CFG_QOS_DEFAULT_VAL,
+		port->lan966x, ANA_QOS_CFG(port->chip_port));
+
+	/* Set default pcp and dei for untagged frames */
+	lan_rmw(ANA_VLAN_CFG_VLAN_DEI_SET(0) |
+		ANA_VLAN_CFG_VLAN_PCP_SET(0),
+		ANA_VLAN_CFG_VLAN_DEI |
+		ANA_VLAN_CFG_VLAN_PCP,
+		port->lan966x, ANA_VLAN_CFG(port->chip_port));
+
+	return 0;
+}
+
 void lan966x_port_qos_set(struct lan966x_port *port,
 			  struct lan966x_port_qos *qos)
 {
 	lan966x_port_qos_pcp_set(port, &qos->pcp);
 	lan966x_port_qos_dscp_set(port, &qos->dscp);
+	lan966x_port_qos_default_set(port, qos);
 }
 
 void lan966x_port_init(struct lan966x_port *port)
-- 
2.38.0

