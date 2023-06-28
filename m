Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA8C740CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbjF1J3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:29:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37354 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237733AbjF1JMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:12:18 -0400
From:   Florian Kauer <florian.kauer@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687943536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=X0JATWY5yUrknqFueeslFGrqKTA/ehIMFyfgxm0DAko=;
        b=YT9A2pkisAHULoNDuMKgcxtJ/xLDjo8Bji2K++hZQNxvSUA9Yt1sDoySb7tQwt3nCLFUkZ
        i7qA9QV5sRrnTFoqj8oMLSZgCRsCILUuN4H3TWzwZ835PP+BwbXkusjYU9TmbtxXANKTfJ
        klzqc21STP4LUko/26fsAXqo1FBnGRxEdLWyv450KjemJzKGytKDMMc710ONfVJVVn65By
        3cVyQVB6WzZJC4MfoyIVEjgUxZXZ/C78HIICOIkxdapUWP2t7LiBXAZxvRQDpH8ZnSMCQK
        2jU5xsCh+oGfBl4+chOwBxyquamM2SCYDC/8VQxKLg7nm+m2WdwWUR6Ooz+oDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687943536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=X0JATWY5yUrknqFueeslFGrqKTA/ehIMFyfgxm0DAko=;
        b=OtN3jhn7DV6ojc3N9cWFAKUT7L1z6nG/35cXsR33QVH1cCOhcf5Xgc+kYT2B3SmUgaY2LR
        Xg1eWIYpRhIzVqDg==
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
        florian.kauer@linutronix.de
Subject: [PATCH net v2] igc: Prevent garbled TX queue with XDP ZEROCOPY
Date:   Wed, 28 Jun 2023 11:11:48 +0200
Message-Id: <20230628091148.62256-1-florian.kauer@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
---

v1 -> v2:
I added some more context for further clarification,
but it is also just how I interpret the code.
Also the typo is fixed and it is reverse christmas again ;-)

---
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index eb4f0e562f60..1cb1df613d27 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2791,15 +2791,15 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
 	struct netdev_queue *nq = txring_txq(ring);
 	union igc_adv_tx_desc *tx_desc = NULL;
 	int cpu = smp_processor_id();
-	u16 ntu = ring->next_to_use;
 	struct xdp_desc xdp_desc;
-	u16 budget;
+	u16 budget, ntu;
 
 	if (!netif_carrier_ok(ring->netdev))
 		return;
 
 	__netif_tx_lock(nq, cpu);
 
+	ntu = ring->next_to_use;
 	budget = igc_desc_unused(ring);
 
 	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
-- 
2.39.2

