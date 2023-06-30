Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46133743B67
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjF3MDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjF3MDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:03:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8C73AB1;
        Fri, 30 Jun 2023 05:03:13 -0700 (PDT)
From:   Florian Kauer <florian.kauer@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688126591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XZbPTleH8tvt6ILWOyc607090QYMkQzPFfKhUGy2cko=;
        b=uRmnxtDn3mLSSk1VRWVUabR3L6Cb6skeKPeVT8tsuZlMtQ0m9othNXwcY+wxZk2osYh2zu
        dtZTwk+Y8lLzDTe3O1qRy72VcVaZVWLwQoMocvOjyGsmQstf22NxkcJu15BIOkEZYulvNp
        vlbZv6/FdZvx1fi/EXz4XtwwbuBclM6BKA7okoxJTej9DWqlLsm+0j3eS3vIk40Grjx4xD
        VoHycBNcC9hfbdgImTYcTfxF3HWVQd62uWpZfy4yZc/WJgwDtbFasFjJVGu08bnRzHkfob
        bcxEpXz4Y8V63upjEwaaJ86rdOWm4oxqlHvmU27bD/vXqS8GU25IPhU92n/inQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688126591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XZbPTleH8tvt6ILWOyc607090QYMkQzPFfKhUGy2cko=;
        b=7upiJJkMkWVEEcvMAtbhIM5502wHHDPKdKUndgk2PG6bRQmzDUchv9yucRd8kCUPjWBTiC
        otEXzvc7s7aDk4Cw==
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vedang Patel <vedang.patel@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Andre Guedes <andre.guedes@intel.com>,
        Simon Horman <simon.horman@corigine.com>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kurt@linutronix.de,
        florian.kauer@linutronix.de,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH net v3] igc: Prevent garbled TX queue with XDP ZEROCOPY
Date:   Fri, 30 Jun 2023 14:03:06 +0200
Message-Id: <20230630120306.8534-1-florian.kauer@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In normal operation, each populated queue item has
next_to_watch pointing to the last TX desc of the packet,
while each cleaned item has it set to 0. In particular,
next_to_use that points to the next (necessarily clean)
item to use has next_to_watch set to 0.

When the TX queue is used both by an application using
AF_XDP with ZEROCOPY as well as a second non-XDP application
generating high traffic, the queue pointers can get in
an invalid state where next_to_use points to an item
where next_to_watch is NOT set to 0.

However, the implementation assumes at several places
that this is never the case, so if it does hold,
bad things happen. In particular, within the loop inside
of igc_clean_tx_irq(), next_to_clean can overtake next_to_use.
Finally, this prevents any further transmission via
this queue and it never gets unblocked or signaled.
Secondly, if the queue is in this garbled state,
the inner loop of igc_clean_tx_ring() will never terminate,
completely hogging a CPU core.

The reason is that igc_xdp_xmit_zc() reads next_to_use
before acquiring the lock, and writing it back
(potentially unmodified) later. If it got modified
before locking, the outdated next_to_use is written
pointing to an item that was already used elsewhere
(and thus next_to_watch got written).

Fixes: 9acf59a752d4 ("igc: Enable TX via AF_XDP zero-copy")
Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Kurt Kanzenbach <kurt@linutronix.de>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---

v2 -> v3:
Resolve merge conflict

v1 -> v2:
I added some more context for further clarification,
but it is also just how I interpret the code.
Also the typo is fixed and it is reverse christmas again 😉

---
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 019ce91c45aa..722ffcc319f0 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2833,9 +2833,8 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 	struct netdev_queue *nq = txring_txq(ring);
 	union igc_adv_tx_desc *tx_desc = NULL;
 	int cpu = smp_processor_id();
-	u16 ntu = ring->next_to_use;
 	struct xdp_desc xdp_desc;
-	u16 budget;
+	u16 budget, ntu;
 
 	if (!netif_carrier_ok(ring->netdev))
 		return;
@@ -2845,6 +2844,7 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 	/* Avoid transmit queue timeout since we share it with the slow path */
 	txq_trans_cond_update(nq);
 
+	ntu = ring->next_to_use;
 	budget = igc_desc_unused(ring);
 
 	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
-- 
2.39.2

