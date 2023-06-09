Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7F5729C93
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241034AbjFIOSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239945AbjFIOSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:18:20 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6808135A9;
        Fri,  9 Jun 2023 07:18:16 -0700 (PDT)
X-GND-Sasl: alexis.lothore@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686320295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W+Vlu9friBOCTMyp0uxc69MbnwzC+52I1B39QfhvQrM=;
        b=jzDyozm7zpvmi82J9hKpAKqzzqfwHe7ZYnDNt5Qb04+YhXrwFdn7HmQS/sD9/A3LKcjKoS
        4ZdYB86q01msP2HC7CyBdh80PTT2G2bkFQZVISZ9Cg1NXqP6SsFZWVXbfLgkN50hDFI4zJ
        Uvxlqfrm9zvoiGSeTnRRWMINU+I3Pw6BzUNITpAOO750HHkE5BDgIYCYmzp8yL4l+1/iRC
        FOONZ93DpegAVftJWq1aXmpjbmbKfFauWc623kGMVn+uB9w43PNa+LYzXdWLzDh66THmkO
        rY4RyDeDVzblzTPrVBpAqnk3FpnDL9gZ53mCaP4Warrrj44joSt5x93s8/b9UA==
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3C60120011;
        Fri,  9 Jun 2023 14:18:14 +0000 (UTC)
From:   alexis.lothore@bootlin.com
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        paul.arola@telus.com, scott.roberts@telus.com
Subject: [PATCH net-next 1/2] net: dsa: mv88e6xxx: allow driver to hook TC callback
Date:   Fri,  9 Jun 2023 16:18:11 +0200
Message-ID: <20230609141812.297521-2-alexis.lothore@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230609141812.297521-1-alexis.lothore@bootlin.com>
References: <20230609141812.297521-1-alexis.lothore@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexis Lothoré <alexis.lothore@bootlin.com>

Marvell switches have some traffic control offloading capabilities, like
for example per-port rate limiting. Allow driver to benefit from this
offloading by hooking TC setup callback in DSA

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 17 +++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h |  3 ++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 8b51756bd805..0f1ae2aeaf00 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -7091,6 +7091,22 @@ static int mv88e6xxx_crosschip_lag_leave(struct dsa_switch *ds, int sw_index,
 	return err_sync ? : err_pvt;
 }
 
+static int mv88e6xxx_port_setup_tc(struct dsa_switch *ds, int port,
+				   enum tc_setup_type type, void *type_data)
+{
+	struct mv88e6xxx_chip *chip = ds->priv;
+	int err;
+
+	if (!chip->info->ops->port_setup_tc)
+		return -EOPNOTSUPP;
+
+	mv88e6xxx_reg_lock(chip);
+	err = chip->info->ops->port_setup_tc(ds, port, type, type_data);
+	mv88e6xxx_reg_unlock(chip);
+
+	return err;
+}
+
 static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.get_tag_protocol	= mv88e6xxx_get_tag_protocol,
 	.change_tag_protocol	= mv88e6xxx_change_tag_protocol,
@@ -7158,6 +7174,7 @@ static const struct dsa_switch_ops mv88e6xxx_switch_ops = {
 	.crosschip_lag_change	= mv88e6xxx_crosschip_lag_change,
 	.crosschip_lag_join	= mv88e6xxx_crosschip_lag_join,
 	.crosschip_lag_leave	= mv88e6xxx_crosschip_lag_leave,
+	.port_setup_tc		= mv88e6xxx_port_setup_tc,
 };
 
 static int mv88e6xxx_register_switch(struct mv88e6xxx_chip *chip)
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 0ad34b2d8913..b259671b2cd7 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -560,7 +560,8 @@ struct mv88e6xxx_ops {
 	 */
 	int (*port_set_upstream_port)(struct mv88e6xxx_chip *chip, int port,
 				      int upstream_port);
-
+	int (*port_setup_tc)(struct dsa_switch *ds, int port,
+			     enum tc_setup_type type, void *type_data);
 	/* Snapshot the statistics for a port. The statistics can then
 	 * be read back a leisure but still with a consistent view.
 	 */
-- 
2.41.0

