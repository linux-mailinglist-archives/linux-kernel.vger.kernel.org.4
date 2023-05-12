Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BCF700176
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240256AbjELH1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240187AbjELH1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:27:05 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C74D2682;
        Fri, 12 May 2023 00:27:02 -0700 (PDT)
Received: (Authenticated sender: alexis.lothore@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6704E40002;
        Fri, 12 May 2023 07:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683876421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bmtlXGdOHO94cG8DR+uqpMutmdfZo2YRa5/V158ipOc=;
        b=kh1zoRLIESw6azS6mRfebl2H/asab2IUPYPzLteUPSLmVbNQHJzq+19sKJnmSAUSlQTBNu
        Vut7EfG/vubT8cqUR/PGe6D4UXolPu7n7S2hi3wv6GW5zF/B60u1T0NL9TqrloiL/7SenW
        Me45ijs5oGj78RV3Hcpa97edYcUIVB2zYQ1UMZfObSHSqIBer4hkZtEEg1H0ZO6vG0R7U2
        K/H7MD7vHu5H6FcAxHq/JcLcycUa39b4qEUyaimvCqpOTW/RgtZWYzeVfWsxU/nHYsUaXQ
        EPsU9s3YFufVPS8xnoYH+kiMKBa7xgdpe2DhJYWobKEXwkHGyCt6Oq5VOn42bQ==
From:   alexis.lothore@bootlin.com
To:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        herve.codina@bootlin.com, miquel.raynal@bootlin.com,
        milan.stevanovic@se.com, jimmy.lalande@se.com,
        pascal.eberhard@se.com
Subject: [PATCH net v3 3/3] net: dsa: rzn1-a5psw: disable learning for standalone ports
Date:   Fri, 12 May 2023 09:27:12 +0200
Message-Id: <20230512072712.82694-4-alexis.lothore@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512072712.82694-1-alexis.lothore@bootlin.com>
References: <20230512072712.82694-1-alexis.lothore@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clément Léger <clement.leger@bootlin.com>

When ports are in standalone mode, they should have learning disabled to
avoid adding new entries in the MAC lookup table which might be used by
other bridge ports to forward packets. While adding that, also make sure
learning is enabled for CPU port.

Fixes: 888cdb892b61 ("net: dsa: rzn1-a5psw: add Renesas RZ/N1 advanced 5 port switch driver")
Signed-off-by: Clément Léger <clement.leger@bootlin.com>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/dsa/rzn1_a5psw.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index e2549cb31d00..c37d2e537230 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -340,6 +340,14 @@ static void a5psw_flooding_set_resolution(struct a5psw *a5psw, int port,
 		a5psw_reg_writel(a5psw, offsets[i], a5psw->bridged_ports);
 }
 
+static void a5psw_port_set_standalone(struct a5psw *a5psw, int port,
+				      bool standalone)
+{
+	a5psw_port_learning_set(a5psw, port, !standalone);
+	a5psw_flooding_set_resolution(a5psw, port, !standalone);
+	a5psw_port_mgmtfwd_set(a5psw, port, standalone);
+}
+
 static int a5psw_port_bridge_join(struct dsa_switch *ds, int port,
 				  struct dsa_bridge bridge,
 				  bool *tx_fwd_offload,
@@ -355,8 +363,7 @@ static int a5psw_port_bridge_join(struct dsa_switch *ds, int port,
 	}
 
 	a5psw->br_dev = bridge.dev;
-	a5psw_flooding_set_resolution(a5psw, port, true);
-	a5psw_port_mgmtfwd_set(a5psw, port, false);
+	a5psw_port_set_standalone(a5psw, port, false);
 
 	return 0;
 }
@@ -366,8 +373,7 @@ static void a5psw_port_bridge_leave(struct dsa_switch *ds, int port,
 {
 	struct a5psw *a5psw = ds->priv;
 
-	a5psw_flooding_set_resolution(a5psw, port, false);
-	a5psw_port_mgmtfwd_set(a5psw, port, true);
+	a5psw_port_set_standalone(a5psw, port, true);
 
 	/* No more ports bridged */
 	if (a5psw->bridged_ports == BIT(A5PSW_CPU_PORT))
@@ -761,13 +767,15 @@ static int a5psw_setup(struct dsa_switch *ds)
 		if (dsa_port_is_unused(dp))
 			continue;
 
-		/* Enable egress flooding for CPU port */
-		if (dsa_port_is_cpu(dp))
+		/* Enable egress flooding and learning for CPU port */
+		if (dsa_port_is_cpu(dp)) {
 			a5psw_flooding_set_resolution(a5psw, port, true);
+			a5psw_port_learning_set(a5psw, port, true);
+		}
 
-		/* Enable management forward only for user ports */
+		/* Enable standalone mode for user ports */
 		if (dsa_port_is_user(dp))
-			a5psw_port_mgmtfwd_set(a5psw, port, true);
+			a5psw_port_set_standalone(a5psw, port, true);
 	}
 
 	return 0;
-- 
2.40.1

