Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1089730143
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245386AbjFNOIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245415AbjFNOHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:07:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D25C1FE5;
        Wed, 14 Jun 2023 07:07:40 -0700 (PDT)
From:   Florian Kauer <florian.kauer@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686751659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q1hYNE6dCTQuk9WVmYS4k1xlOgvvBhb4CT2be2LL7DM=;
        b=ZZvYV1zwPCWYO/QJxWCTeJyNCkmnzf432jgNJvSDhZlVIMN27BnuXbf0i31BtLI3gV/+YA
        FVz6Ic0Y69dCCdRV1A/qfWvkosFGNADeBdWJueyQ1q3kIwsdmNGLKXQrEEVrNum87qnrOn
        dlzBLjNaRmPCAGL1pGEZzrY+4EOtDVdBv7o/B3ClKaJHiRwtEGivNNdv2jm7scRPu9adob
        R9JMzXwSYTxW5qjG+SRx8WWYw8SE0vDm5LtwWT0pkObGsW9ckb6ml+3m5JKtV+Xb6WNue5
        37sEu1gU/uwYLRcNEAG7C72Xb+kpOeavkDFTgRJ3XiMMugOt2xi1+LKVQztVwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686751659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q1hYNE6dCTQuk9WVmYS4k1xlOgvvBhb4CT2be2LL7DM=;
        b=yHOFDzNtJEKU4s4MeGdhgcrNo8WlP4GxqaRe2tJ06SItoPxdsOzaIf8OR6Ie4RfzqKCNtO
        T8JTtGrn54Bj37CA==
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Tan Tee Min <tee.min.tan@linux.intel.com>,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>,
        Malli C <mallikarjuna.chilakala@intel.com>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kurt@linutronix.de,
        florian.kauer@linutronix.de
Subject: [PATCH net-next 6/6] igc: Fix inserting of empty frame for launchtime
Date:   Wed, 14 Jun 2023 16:07:14 +0200
Message-Id: <20230614140714.14443-7-florian.kauer@linutronix.de>
In-Reply-To: <20230614140714.14443-1-florian.kauer@linutronix.de>
References: <20230614140714.14443-1-florian.kauer@linutronix.de>
MIME-Version: 1.0
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

The insertion of an empty frame was introduced with
commit db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag bit")
in order to ensure that the current cycle has at least one packet if
there is some packet to be scheduled for the next cycle.

However, the current implementation does not properly check if
a packet is already scheduled for the current cycle. Currently,
an empty packet is always inserted if and only if
txtime >= end_of_cycle && txtime > last_tx_cycle
but since last_tx_cycle is always either the end of the current
cycle (end_of_cycle) or the end of a previous cycle, the
second part (txtime > last_tx_cycle) is always true unless
txtime == last_tx_cycle.

What actually needs to be checked here is if the last_tx_cycle
was already written within the current cycle, so an empty frame
should only be inserted if and only if
txtime >= end_of_cycle && end_of_cycle > last_tx_cycle.

This patch does not only avoid an unnecessary insertion, but it
can actually be harmful to insert an empty packet if packets
are already scheduled in the current cycle, because it can lead
to a situation where the empty packet is actually processed
as the first packet in the upcoming cycle shifting the packet
with the first_flag even one cycle into the future, finally leading
to a TX hang.

The TX hang can be reproduced on a i225 with:

    sudo tc qdisc replace dev enp1s0 parent root handle 100 taprio \
	    num_tc 1 \
	    map 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 \
	    queues 1@0 \
	    base-time 0 \
	    sched-entry S 01 300000 \
	    flags 0x1 \
	    txtime-delay 500000 \
	    clockid CLOCK_TAI
    sudo tc qdisc replace dev enp1s0 parent 100:1 etf \
	    clockid CLOCK_TAI \
	    delta 500000 \
	    offload \
	    skip_sock_check

and traffic generator

    sudo trafgen -i traffic.cfg -o enp1s0 --cpp -n0 -q -t1400ns

with traffic.cfg

    #define ETH_P_IP        0x0800

    {
      /* Ethernet Header */
      0x30, 0x1f, 0x9a, 0xd0, 0xf0, 0x0e,  # MAC Dest - adapt as needed
      0x24, 0x5e, 0xbe, 0x57, 0x2e, 0x36,  # MAC Src  - adapt as needed
      const16(ETH_P_IP),

      /* IPv4 Header */
      0b01000101, 0,   # IPv4 version, IHL, TOS
      const16(1028),   # IPv4 total length (UDP length + 20 bytes (IP header))
      const16(2),      # IPv4 ident
      0b01000000, 0,   # IPv4 flags, fragmentation off
      64,              # IPv4 TTL
      17,              # Protocol UDP
      csumip(14, 33),  # IPv4 checksum

      /* UDP Header */
      10,  0, 48, 1,   # IP Src - adapt as needed
      10,  0, 48, 10,  # IP Dest - adapt as needed
      const16(5555),   # UDP Src Port
      const16(6666),   # UDP Dest Port
      const16(1008),   # UDP length (UDP header 8 bytes + payload length)
      csumudp(14, 34), # UDP checksum

      /* Payload */
      fill('W', 1000),
    }

and the observed message with that is for example

 igc 0000:01:00.0 enp1s0: Detected Tx Unit Hang
   Tx Queue             <0>
   TDH                  <32>
   TDT                  <3c>
   next_to_use          <3c>
   next_to_clean        <32>
 buffer_info[next_to_clean]
   time_stamp           <ffff26a8>
   next_to_watch        <00000000632a1828>
   jiffies              <ffff27f8>
   desc.status          <1048000>

Fixes: db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag bit")
Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index ec8649751d19..1556beaefbc3 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1023,7 +1023,7 @@ static __le32 igc_tx_launchtime(struct igc_ring *ring, ktime_t txtime,
 			*first_flag = true;
 			ring->last_ff_cycle = baset_est;
 
-			if (ktime_compare(txtime, ring->last_tx_cycle) > 0)
+			if (ktime_compare(end_of_cycle, ring->last_tx_cycle) > 0)
 				*insert_empty = true;
 		}
 	}
-- 
2.39.2

