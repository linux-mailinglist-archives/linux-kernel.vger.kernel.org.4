Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98997712128
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbjEZHfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjEZHfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:35:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF2DE4F
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:35:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1q2RyL-0005le-Dw; Fri, 26 May 2023 09:34:49 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1q2RyJ-002u70-HD; Fri, 26 May 2023 09:34:47 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1q2RyI-002nu5-7z; Fri, 26 May 2023 09:34:46 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: [PATCH net-next v2 3/5] net: dsa: microchip: remove ksz_port:on variable
Date:   Fri, 26 May 2023 09:34:43 +0200
Message-Id: <20230526073445.668430-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526073445.668430-1-o.rempel@pengutronix.de>
References: <20230526073445.668430-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only place where this variable would be set to false is the
ksz8_config_cpu_port() function. But it is done in a bogus way:

 	for (i = 0; i < dev->phy_port_cnt; i++) {
		if (i == dev->phy_port_cnt) <--- will be never executed.
			break;
		p->on = 1;

So, we never have a situation where p->on = 0. In this case, we can just
remove it.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/microchip/ksz8795.c    | 20 +-------------------
 drivers/net/dsa/microchip/ksz_common.h |  1 -
 2 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index d2f7fa3fbd27..84d502589f8e 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -941,7 +941,6 @@ void ksz8_flush_dyn_mac_table(struct ksz_device *dev, int port)
 {
 	u8 learn[DSA_MAX_PORTS];
 	int first, index, cnt;
-	struct ksz_port *p;
 	const u16 *regs;
 
 	regs = dev->info->regs;
@@ -955,9 +954,6 @@ void ksz8_flush_dyn_mac_table(struct ksz_device *dev, int port)
 		cnt = dev->info->port_cnt;
 	}
 	for (index = first; index < cnt; index++) {
-		p = &dev->ports[index];
-		if (!p->on)
-			continue;
 		ksz_pread8(dev, index, regs[P_STP_CTRL], &learn[index]);
 		if (!(learn[index] & PORT_LEARN_DISABLE))
 			ksz_pwrite8(dev, index, regs[P_STP_CTRL],
@@ -965,9 +961,6 @@ void ksz8_flush_dyn_mac_table(struct ksz_device *dev, int port)
 	}
 	ksz_cfg(dev, S_FLUSH_TABLE_CTRL, SW_FLUSH_DYN_MAC_TABLE, true);
 	for (index = first; index < cnt; index++) {
-		p = &dev->ports[index];
-		if (!p->on)
-			continue;
 		if (!(learn[index] & PORT_LEARN_DISABLE))
 			ksz_pwrite8(dev, index, regs[P_STP_CTRL], learn[index]);
 	}
@@ -1338,25 +1331,14 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
 
 	ksz_cfg(dev, regs[S_TAIL_TAG_CTRL], masks[SW_TAIL_TAG_ENABLE], true);
 
-	p = &dev->ports[dev->cpu_port];
-	p->on = 1;
-
 	ksz8_port_setup(dev, dev->cpu_port, true);
 
 	for (i = 0; i < dev->phy_port_cnt; i++) {
-		p = &dev->ports[i];
-
 		ksz_port_stp_state_set(ds, i, BR_STATE_DISABLED);
-
-		/* Last port may be disabled. */
-		if (i == dev->phy_port_cnt)
-			break;
-		p->on = 1;
 	}
 	for (i = 0; i < dev->phy_port_cnt; i++) {
 		p = &dev->ports[i];
-		if (!p->on)
-			continue;
+
 		if (!ksz_is_ksz88x3(dev)) {
 			ksz_pread8(dev, i, regs[P_REMOTE_STATUS], &remote);
 			if (remote & KSZ8_PORT_FIBER_MODE)
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index f45f5fe11bde..5aa58aac3e07 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -108,7 +108,6 @@ struct ksz_port {
 	int stp_state;
 	struct phy_device phydev;
 
-	u32 on:1;			/* port is not disabled by hardware */
 	u32 fiber:1;			/* port is fiber */
 	u32 force:1;
 	u32 read:1;			/* read MIB counters in background */
-- 
2.39.2

