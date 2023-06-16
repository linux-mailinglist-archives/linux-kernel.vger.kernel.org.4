Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB83732CEA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244718AbjFPKF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFPKFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:05:39 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4352B2D67;
        Fri, 16 Jun 2023 03:05:38 -0700 (PDT)
X-GND-Sasl: alexis.lothore@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686909936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TuLT0Dx8INmVuQ+Tjg5nObFk3ZPU55oE6gxmpAOjP2k=;
        b=lzUlV6Vl1+7PGIIxMRVfnCBB6Dz/NpkZawq1V/uJWhuAkOFIuN+draPM1L5Gg566KO4kvF
        z8zjlfLDt8oXatl77D3OHSqS/P5KebT1YLOHsBw2aGvtvFrYeZsNMFFYazPh/h80l8mpzu
        PjKiDGTM7rvRB7E9n7NNjVRH/0TnjV+/oNTag4KyZ4mLPJGNMpdliEy5NXYRM9kHDAAqC1
        NqCggXkU2o8fSr+1asolZiUSSvxvvj1VmoZOTRnkNtWvMgaGMZthqLCU+yZqKtSF6riVM0
        SpxF5DQJi9JFcreWJcbOgVttfiHi08F8TPdlEpG1VL1p168dIPEAdqu27IChVw==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id ADD9920007;
        Fri, 16 Jun 2023 10:05:35 +0000 (UTC)
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
Subject: [PATCH net-next 5/8] net: stmmac: set number of snapshot external triggers for GMAC3
Date:   Fri, 16 Jun 2023 12:04:06 +0200
Message-ID: <20230616100409.164583-6-alexis.lothore@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230616100409.164583-1-alexis.lothore@bootlin.com>
References: <20230616100409.164583-1-alexis.lothore@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexis Lothoré <alexis.lothore@bootlin.com>

While GMAC4 exposes number of available auxiliary snapshots inputs in
MAC_HW_FEATURE2 register, GMAC3 (DWMAC1000) does not expose this
information in its only hardware feature register.
When running on GMAC3, hardcode the value to 1 to allow external trigger
usage

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 167bfbf68911..090a9d803446 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -280,7 +280,10 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
 		priv->plat->cdc_error_adj = (2 * NSEC_PER_SEC) / priv->plat->clk_ptp_rate;
 
 	stmmac_ptp_clock_ops.n_per_out = priv->dma_cap.pps_out_num;
-	stmmac_ptp_clock_ops.n_ext_ts = priv->dma_cap.aux_snapshot_n;
+	/* Number of available external triggers is not provided through a
+	 * hardware capabilities register for GMAC3
+	 */
+	stmmac_ptp_clock_ops.n_ext_ts = priv->plat->has_gmac ? 1 : priv->dma_cap.aux_snapshot_n;
 
 	rwlock_init(&priv->ptp_lock);
 	mutex_init(&priv->aux_ts_lock);
-- 
2.41.0

