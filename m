Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2E6732CE9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244419AbjFPKFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjFPKFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:05:38 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8DB2D69;
        Fri, 16 Jun 2023 03:05:36 -0700 (PDT)
X-GND-Sasl: alexis.lothore@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686909935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQbCjIioSzpbvbd6fIl1lAwDG3upjPsirLpyT1TX/+k=;
        b=FwY8GMlD/bBWxk8342rA6F1IqDZ1jjrj++Nq7MUtdB9mGuU2C72330sqMSEubUgeEIby8G
        /FuksITI31BlpVpofEogiJe3NdE4Z6hwTtxfe3ErdY5NALmv5t5hivLA/jaS8xC1mvMdkd
        e5uSI0AB5xO0bjjobDQqbRV55DjeDv6ZmqFrijmS+caeeq2xP72H2zv8CeFzAlmQgfAPhc
        L1S5kQ8TPNghKGkjm3xR+xQX4NL9Uumb8MGH9pOAS30gyGcKbq0nZBbk+KfGxcd1+6mzkq
        nI8ebkmz5rZgSV/WTqv7Bark6usUQJnoutNBXNcICbmq3FNiSLzngxksao9tEA==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6708420002;
        Fri, 16 Jun 2023 10:05:34 +0000 (UTC)
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
Subject: [PATCH net-next 4/8] net: stmmac: move common defines in stmmac_ptp.h
Date:   Fri, 16 Jun 2023 12:04:05 +0200
Message-ID: <20230616100409.164583-5-alexis.lothore@bootlin.com>
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

Even if the address of registers containing statuses is not the same
between dwamc4 and dwmac 1000, the offsets of interest inside those
register are the same regarding auxiliary snapshots. As a consequence, move
those offset definitions in stmmac_ptp.h

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h     | 5 -----
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h | 4 +++-
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index 9e7ba5f2e53a..32a15c020a43 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -313,11 +313,6 @@ enum power_event {
 #define GMAC_L4DP0_SHIFT		16
 #define GMAC_L4SP0			GENMASK(15, 0)
 
-/* MAC Timestamp Status */
-#define GMAC_TIMESTAMP_AUXTSTRIG	BIT(2)
-#define GMAC_TIMESTAMP_ATSNS_MASK	GENMASK(29, 25)
-#define GMAC_TIMESTAMP_ATSNS_SHIFT	25
-
 /*  MTL registers */
 #define MTL_OPERATION_MODE		0x00000c00
 #define MTL_FRPE			BIT(15)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
index 92ed421702b9..04bbf12dfd4b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h
@@ -64,6 +64,8 @@
 #define	PTP_SSIR_SSINC_MAX		0xff
 #define	GMAC4_PTP_SSIR_SSINC_SHIFT	16
 
-
+/* MAC Timestamp Status */
+#define GMAC_TIMESTAMP_ATSNS_MASK	GENMASK(29, 25)
+#define GMAC_TIMESTAMP_ATSNS_SHIFT	25
 
 #endif	/* __STMMAC_PTP_H__ */
-- 
2.41.0

