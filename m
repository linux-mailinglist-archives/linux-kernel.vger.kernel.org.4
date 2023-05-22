Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B3D70C5BD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjEVTH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjEVTHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:07:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354F3A7;
        Mon, 22 May 2023 12:07:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D7F7722078;
        Mon, 22 May 2023 19:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684782441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8y2tC91mwddLD+EAwmjuuveG3T7LFdcskOoTa4k2Y3I=;
        b=viHtqttjzWAiJRHnjgzeBYePD6aMwdP47nMsai1gCQj2NaEIRXKjjLW2Y8VovpASzKE0nB
        6dbLknKr8wLZSRBtIYkVMIvbUjX22H0F/16q1SmOMvKg47sI+xpLAQy5Ik5bB68ln2hCL8
        A4H/O2etB8rUPSVQIVZRSJdz5cpfHYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684782441;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8y2tC91mwddLD+EAwmjuuveG3T7LFdcskOoTa4k2Y3I=;
        b=pv1Uuqpr4gscVktfXAwhmoNNv4Ml4Zz+Q+YyVkrm3Pld74yyjxF+FSZmVeuXKmuPvmS8VU
        qyYvN0+nlMLh8AAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 9909A2C141;
        Mon, 22 May 2023 19:07:21 +0000 (UTC)
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] net: mellanox: mlxbf_gige: Fix skb_panic splat under memory pressure
Date:   Mon, 22 May 2023 21:07:13 +0200
Message-Id: <20230522190713.82417-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do skp_put() after a new skb has been successfully allocated otherwise
the reused skb leads to skp_panics or incorrect packet sizes.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c    | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
index afa3b92a6905..2c132849a76d 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
@@ -245,18 +245,19 @@ static bool mlxbf_gige_rx_packet(struct mlxbf_gige *priv, int *rx_pkts)
 
 		skb = priv->rx_skb[rx_pi_rem];
 
-		skb_put(skb, datalen);
-
-		skb->ip_summed = CHECKSUM_NONE; /* device did not checksum packet */
-
-		skb->protocol = eth_type_trans(skb, netdev);
-
 		/* Alloc another RX SKB for this same index */
 		rx_skb = mlxbf_gige_alloc_skb(priv, MLXBF_GIGE_DEFAULT_BUF_SZ,
 					      &rx_buf_dma, DMA_FROM_DEVICE);
 		if (!rx_skb)
 			return false;
 		priv->rx_skb[rx_pi_rem] = rx_skb;
+
+		skb_put(skb, datalen);
+
+		skb->ip_summed = CHECKSUM_NONE; /* device did not checksum packet */
+
+		skb->protocol = eth_type_trans(skb, netdev);
+
 		dma_unmap_single(priv->dev, *rx_wqe_addr,
 				 MLXBF_GIGE_DEFAULT_BUF_SZ, DMA_FROM_DEVICE);
 		*rx_wqe_addr = rx_buf_dma;
-- 
2.35.3

