Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC84273B66F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 13:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjFWLkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 07:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFWLkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:40:36 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF48E65;
        Fri, 23 Jun 2023 04:40:31 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-311153ec442so529993f8f.1;
        Fri, 23 Jun 2023 04:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687520430; x=1690112430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=J/u0R3l9zBf01BjxNH8vuW4kixZhC6G1lWgIfS9JJbg=;
        b=VXsbLpkseTtrpPd4T7qF6FRW4cQlJgmBd2UNomC0GfcTT8wzO9fme3BhauIQmkbEaW
         Eenl7lfXVplVmXJqtbDHGidGt31tvVUIKX022yNwnIynto43faf6KSczDFyP4jHuMzrp
         juVGJhNsZ45lGf13d0Sd27gMajOQELyAoq/PrsgzorvdnsCAhrq9oev1gu8xAbvL8gM1
         JWRiQy2ARKUMxpqUM47EeS8yQr6qpeI5fYMpR5yGkZtMHqg2QkeQKoYyMm1kpDwSU9B1
         PeX4pEpGlL/2y3jaavMwBP/FU66A+sGixOAh1Mu8avjAsPDo0ivtVEyAiMpy5yv4W5gJ
         IYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687520430; x=1690112430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J/u0R3l9zBf01BjxNH8vuW4kixZhC6G1lWgIfS9JJbg=;
        b=X7+nrxu2ErZsUtoAXvzWOd0B3BfKA5pAiF6gqtdhVfcDgaHH3UWuuSk+iiEu/kzO5/
         qIJT7LcTeohJ51bPQZzuIlB5fHXKPyC+OHKfZUSx0D8ZuuECTB9/wCOL6682bZNwQPXo
         lhs2wqh0DDO4zc/+/3sD08ETdkZTgYUxanDD54475bcP4mHTp94GYPrPnKP1GksLBTdG
         d6S2SVl8BlfTklsSeXdstnlYXONAzMds0SLGO7DF8DrfkQwi29GUqhUnBm/eE0VIZlTV
         TwIIrRgpHjN46bSJxZ0rZaUkzwHg+l8O3WtnZJTxFjugeooZZkr/UsN3lNzDtYg/j/z+
         LURA==
X-Gm-Message-State: AC+VfDzzB3D7glOWpNx/DXmYooUtec4k+qu+Smo3nV0m6Q4VW7BzK6b8
        1ktPNtRHcLGTJIxs+cSYKQE=
X-Google-Smtp-Source: ACHHUZ57ynlFQos8HrnDPX9BQ5G5TQxYOMuoG6agYBqEx7AQa1LgSwQUYhHC6AAv3Ix8OvhXhHMQmw==
X-Received: by 2002:a5d:40c5:0:b0:311:133c:2903 with SMTP id b5-20020a5d40c5000000b00311133c2903mr17879799wrq.15.1687520429713;
        Fri, 23 Jun 2023 04:40:29 -0700 (PDT)
Received: from localhost.localdomain (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.googlemail.com with ESMTPSA id k3-20020a5d4283000000b00312780bedc3sm9297384wrq.56.2023.06.23.04.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 04:40:29 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Atin Bainada <hi@atinb.me>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [net-next PATCH RFC] net: dsa: qca8k: make learning configurable and keep off if standalone
Date:   Fri, 23 Jun 2023 13:40:05 +0200
Message-Id: <20230623114005.9680-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address learning should initially be turned off by the driver for port
operation in standalone mode, then the DSA core handles changes to it
via ds->ops->port_bridge_flags().

Currently this is not the case for qca8k where learning is enabled
unconditionally in qca8k_setup for every user port.

Handle ports configured in standalone mode by making the learning
configurable and not enabling it by default.

Implement .port_pre_bridge_flags and .port_bridge_flags dsa ops to
enable learning for bridge that request it and tweak
.port_stp_state_set to correctly disable learning when port is
configured in standalone mode.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---

Posting as RFC as I would love some comments from Vladimir for correct
implementation of this. This was suggested to be on par with offload
bridge API and I used as example [1] (commit that does the same thing
with a microchip switch)

I didn't want to bloat the priv struct with additional info with the
port state and from what I can see it seems using dp->learning is enough
to understand if learning is currently enabled for the port or not but I
would love to have some confirmation about this. (from what I notice
when port is set in standalone mode, flags are cleared so it should be
correct)

I also verified this working by dumping the fdb in a bridge
configuration and in a standalone configuration. Traffic works in both
configuration.

Dump WITH BRIDGE CONFIGURATION:
01:00:5e:00:00:01 dev eth0 self permanent
33:33:00:00:00:02 dev eth0 self permanent
33:33:00:00:00:01 dev eth0 self permanent
33:33:ff:f2:5d:50 dev eth0 self permanent
33:33:ff:00:00:00 dev eth0 self permanent
dc:ef:09:f2:5d:4f dev eth1 self permanent
33:33:00:00:00:01 dev eth1 self permanent
33:33:00:00:00:02 dev eth1 self permanent
01:00:5e:00:00:01 dev eth1 self permanent
33:33:ff:f2:5d:4f dev eth1 self permanent
33:33:ff:00:00:00 dev eth1 self permanent
c0:3e:ba:c1:d7:47 dev lan1 master br-lan
dc:ef:09:f2:5d:4f dev lan1 vlan 1 master br-lan permanent
dc:ef:09:f2:5d:4f dev lan1 master br-lan permanent
c0:3e:ba:c1:d7:47 dev lan1 vlan 1 self
33:33:00:00:00:01 dev wlan0 self permanent
33:33:00:00:00:02 dev wlan0 self permanent
33:33:00:00:00:01 dev wlan1 self permanent
33:33:00:00:00:02 dev wlan1 self permanent
33:33:00:00:00:01 dev br-lan self permanent
33:33:00:00:00:02 dev br-lan self permanent
01:00:5e:00:00:01 dev br-lan self permanent
33:33:ff:00:00:01 dev br-lan self permanent
33:33:ff:f2:5d:4f dev br-lan self permanent
33:33:00:01:00:02 dev br-lan self permanent
33:33:00:01:00:03 dev br-lan self permanent
33:33:ff:00:00:00 dev br-lan self permanent

Dump WITH STANDALONE CONFIGURATION:
01:00:5e:00:00:01 dev eth0 self permanent
33:33:00:00:00:02 dev eth0 self permanent
33:33:00:00:00:01 dev eth0 self permanent
33:33:ff:f2:5d:50 dev eth0 self permanent
33:33:ff:00:00:00 dev eth0 self permanent
33:33:00:00:00:01 dev eth1 self permanent
33:33:00:00:00:02 dev eth1 self permanent
01:00:5e:00:00:01 dev eth1 self permanent
33:33:ff:f2:5d:4f dev eth1 self permanent
33:33:ff:00:00:01 dev eth1 self permanent
33:33:ff:00:00:00 dev eth1 self permanent
33:33:00:01:00:02 dev eth1 self permanent
33:33:00:01:00:03 dev eth1 self permanent
33:33:00:00:00:01 dev wlan0 self permanent
33:33:00:00:00:02 dev wlan0 self permanent
33:33:00:00:00:01 dev wlan1 self permanent
33:33:00:00:00:02 dev wlan1 self permanent

From what I can see there isn't any self entry with the MAC address of
the connected device and this should confirm that learning is actually
disabled.

Hope this is enough to test this feature and I would ask what would be
the next step to reach a point where port_change_master can be
implemented.
(would also love to see what are the criteria to enable offload_fwd_mask
on the targget for rcv and eventually for xmit)

Thanks for any response and sorry for the long comments.


[1] https://github.com/torvalds/linux/commit/15f7cfae912e

 drivers/net/dsa/qca/qca8k-8xxx.c   |  8 ++----
 drivers/net/dsa/qca/qca8k-common.c | 40 ++++++++++++++++++++++++++++++
 drivers/net/dsa/qca/qca8k.h        |  6 +++++
 3 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index f08086ac2261..a9af270a03ce 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1963,12 +1963,6 @@ qca8k_setup(struct dsa_switch *ds)
 			if (ret)
 				return ret;
 
-			/* Enable ARP Auto-learning by default */
-			ret = regmap_set_bits(priv->regmap, QCA8K_PORT_LOOKUP_CTRL(i),
-					      QCA8K_PORT_LOOKUP_LEARN);
-			if (ret)
-				return ret;
-
 			/* For port based vlans to work we need to set the
 			 * default egress vid
 			 */
@@ -2071,6 +2065,8 @@ static const struct dsa_switch_ops qca8k_switch_ops = {
 	.port_change_mtu	= qca8k_port_change_mtu,
 	.port_max_mtu		= qca8k_port_max_mtu,
 	.port_stp_state_set	= qca8k_port_stp_state_set,
+	.port_pre_bridge_flags	= qca8k_port_pre_bridge_flags,
+	.port_bridge_flags	= qca8k_port_bridge_flags,
 	.port_bridge_join	= qca8k_port_bridge_join,
 	.port_bridge_leave	= qca8k_port_bridge_leave,
 	.port_fast_age		= qca8k_port_fast_age,
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
index 8c2dc0e48ff4..f93defbd8b66 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -559,8 +559,24 @@ int qca8k_get_mac_eee(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static int qca8k_port_configure_learning(struct dsa_switch *ds, int port,
+					 bool learning)
+{
+	struct qca8k_priv *priv = ds->priv;
+
+	if (learning)
+		return regmap_set_bits(priv->regmap,
+				       QCA8K_PORT_LOOKUP_CTRL(port),
+				       QCA8K_PORT_LOOKUP_LEARN);
+	else
+		return regmap_clear_bits(priv->regmap,
+					 QCA8K_PORT_LOOKUP_CTRL(port),
+					 QCA8K_PORT_LOOKUP_LEARN);
+}
+
 void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 {
+	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct qca8k_priv *priv = ds->priv;
 	u32 stp_state;
 
@@ -585,6 +601,30 @@ void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 
 	qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
 		  QCA8K_PORT_LOOKUP_STATE_MASK, stp_state);
+
+	qca8k_port_configure_learning(ds, port, dp->learning);
+}
+
+int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
+				struct switchdev_brport_flags flags,
+				struct netlink_ext_ack *extack)
+{
+	if (flags.mask & ~BR_LEARNING)
+		return -EINVAL;
+
+	return 0;
+}
+
+int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
+			    struct switchdev_brport_flags flags,
+			    struct netlink_ext_ack *extack)
+{
+	int ret;
+
+	ret = qca8k_port_configure_learning(ds, port,
+					    flags.mask & ~BR_LEARNING);
+
+	return ret;
 }
 
 int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
index c5cc8a172d65..8f88b7db384d 100644
--- a/drivers/net/dsa/qca/qca8k.h
+++ b/drivers/net/dsa/qca/qca8k.h
@@ -522,6 +522,12 @@ int qca8k_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_eee *e);
 
 /* Common bridge function */
 void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state);
+int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
+				struct switchdev_brport_flags flags,
+				struct netlink_ext_ack *extack);
+int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
+			    struct switchdev_brport_flags flags,
+			    struct netlink_ext_ack *extack);
 int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
 			   struct dsa_bridge bridge,
 			   bool *tx_fwd_offload,
-- 
2.40.1

