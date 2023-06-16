Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D87732CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjFPKFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjFPKFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:05:34 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3168C2137;
        Fri, 16 Jun 2023 03:05:33 -0700 (PDT)
X-GND-Sasl: alexis.lothore@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686909931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZQ1+xbvMnidBmGeXT0nP+KHmlPyfa+N1kU3ye5N9Y2M=;
        b=Sicjf9ks2PJoF/K2iAiEzxbRBrNIvgpB0mTA1GqD4eEWaZ/tLOB7KOSnyaLhISAEocTwyv
        RPPNUS3DqAW37JRUxacbu68edCx2UY30ktDi8ZHWIPaU3ya2meksVLKyBsbYx8Z9NbUvDu
        TufohlkapBs05jQMj4Z1KYsaobvwW/QyXoaLG2TKo6rfGryl2XQ/dTwFIZfZAjjr+0dl3Z
        uho3Q9qfYJAsLMrKUaCReSYe1T/RMrWJp3tNl2W3+RR20V7o1YE5iN3C/mCGPEeHFOqnDc
        FRadOLh+++SFziNFZf4WOF9z9MFgLm/RUxOx94IdYHQeAe/56hJzx92ZbJ5n1w==
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
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 83BF520003;
        Fri, 16 Jun 2023 10:05:30 +0000 (UTC)
From:   alexis.lothore@bootlin.com
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nicolas Carrier <nicolas.carrier@nav-timing.safrangroup.com>
Subject: [PATCH net-next 1/8] net: stmmac: add IP-specific callbacks for auxiliary snapshot
Date:   Fri, 16 Jun 2023 12:04:02 +0200
Message-ID: <20230616100409.164583-2-alexis.lothore@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230616100409.164583-1-alexis.lothore@bootlin.com>
References: <20230616100409.164583-1-alexis.lothore@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexis Lothoré <alexis.lothore@bootlin.com>

Since auxiliary snapshots configuration registers may be different
depending the DWMAC IP, we need a specific set of callbacks to
- configure timestamp snapshot triggers
- clear the snapshots FIFO

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 6ee7cf07cfd7..d0b2f13510aa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -419,6 +419,10 @@ struct stmmac_ops {
 	void (*fpe_send_mpacket)(void __iomem *ioaddr,
 				 enum stmmac_mpacket_type type);
 	int (*fpe_irq_status)(void __iomem *ioaddr, struct net_device *dev);
+	/* Auxiliary snapshots */
+	void (*extts_configure)(void __iomem *ioaddr, int ext_snapshot_num,
+				bool on, struct net_device *dev);
+	int (*clear_snapshot_fifo)(void __iomem *ioaddr);
 };
 
 #define stmmac_core_init(__priv, __args...) \
@@ -523,6 +527,10 @@ struct stmmac_ops {
 	stmmac_do_void_callback(__priv, mac, fpe_send_mpacket, __args)
 #define stmmac_fpe_irq_status(__priv, __args...) \
 	stmmac_do_callback(__priv, mac, fpe_irq_status, __args)
+#define stmmac_extts_configure(__priv, __args...) \
+	stmmac_do_void_callback(__priv, mac, extts_configure, __args)
+#define stmmac_clear_snapshot_fifo(__priv, __args...) \
+	stmmac_do_callback(__priv, mac, clear_snapshot_fifo, __args)
 
 /* PTP and HW Timer helpers */
 struct stmmac_hwtimestamp {
-- 
2.41.0

