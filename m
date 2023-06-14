Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40265730137
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245395AbjFNOHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245365AbjFNOHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:07:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3974B19B5;
        Wed, 14 Jun 2023 07:07:32 -0700 (PDT)
From:   Florian Kauer <florian.kauer@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686751650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E4YEaT+aOUEFj7DigAgxbM4RznI4oXWfWpU3L2Qmto8=;
        b=rjLACA+DkXLZcQ8DPRtCD+qKMo3cdMoczMFVfOTbljMvVI1NcqDBFtd1CowbR+vc9Lw1nl
        OQkVYe86r2bM7oUXQD+jXcV2R4KHwEDFHofHRoc8wMTSoia3jYXGYDGItfXxntszkKP2i1
        Smg0tlGgkA9aIgQrr/BZrDg3UDYZa1Si2zxbqKlJHKFDb6r9vpiqdcaUqZBPeQcvMRbUKm
        YICM057FYGS7+a/ioswIVImlEwWUL2neuYHYuwVwRd0hqUnjL3UKdJqaVWWN+iQSBDpOhs
        UikjIFKnD4IVL3sIYWttT4bpp+92PiK7nM5osOMOfpRihV02MAF+c3nk7cYbqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686751650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E4YEaT+aOUEFj7DigAgxbM4RznI4oXWfWpU3L2Qmto8=;
        b=CW5qpZOAMqDU1sPWk664/S4CRHxPNDe9AjuXmorNFQopfnw+ZTuA7G8d5OIaYDMVmiuVo9
        tpyerRmHrWiRV7CQ==
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
Subject: [PATCH net-next 2/6] igc: Do not enable taprio offload for invalid arguments
Date:   Wed, 14 Jun 2023 16:07:10 +0200
Message-Id: <20230614140714.14443-3-florian.kauer@linutronix.de>
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

Only set adapter->taprio_offload_enable after validating the arguments.
Otherwise, it stays set even if the offload was not enabled.
Since the subsequent code does not get executed in case of invalid
arguments, it will not be read at first.
However, by activating and then deactivating another offload
(e.g. ETF/TX launchtime offload), taprio_offload_enable is read
and erroneously keeps the offload feature of the NIC enabled.

This can be reproduced as follows:

    # TAPRIO offload (flags == 0x2) and negative base-time leading to expected -ERANGE
    sudo tc qdisc replace dev enp1s0 parent root handle 100 stab overhead 24 taprio \
	    num_tc 1 \
	    map 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 \
	    queues 1@0 \
	    base-time -1000 \
	    sched-entry S 01 300000 \
	    flags 0x2

    # IGC_TQAVCTRL is 0x0 as expected (iomem=relaxed for reading register)
    sudo pcimem /sys/bus/pci/devices/0000:01:00.0/resource0 0x3570 w*1

    # Activate ETF offload
    sudo tc qdisc replace dev enp1s0 parent root handle 6666 mqprio \
	    num_tc 3 \
	    map 2 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 \
	    queues 1@0 1@1 2@2 \
	    hw 0
    sudo tc qdisc add dev enp1s0 parent 6666:1 etf \
	    clockid CLOCK_TAI \
	    delta 500000 \
	    offload

    # IGC_TQAVCTRL is 0x9 as expected
    sudo pcimem /sys/bus/pci/devices/0000:01:00.0/resource0 0x3570 w*1

    # Deactivate ETF offload again
    sudo tc qdisc delete dev enp1s0 parent 6666:1

    # IGC_TQAVCTRL should now be 0x0 again, but is observed as 0x9
    sudo pcimem /sys/bus/pci/devices/0000:01:00.0/resource0 0x3570 w*1

Fixes: e17090eb2494 ("igc: allow BaseTime 0 enrollment for Qbv")
Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 56117846b8da..122158b321d5 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6091,6 +6091,7 @@ static int igc_tsn_clear_schedule(struct igc_adapter *adapter)
 
 	adapter->base_time = 0;
 	adapter->cycle_time = NSEC_PER_SEC;
+	adapter->taprio_offload_enable = false;
 	adapter->qbv_config_change_errors = 0;
 
 	for (i = 0; i < adapter->num_tx_queues; i++) {
@@ -6113,20 +6114,12 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	size_t n;
 	int i;
 
-	switch (qopt->cmd) {
-	case TAPRIO_CMD_REPLACE:
-		adapter->taprio_offload_enable = true;
-		break;
-	case TAPRIO_CMD_DESTROY:
-		adapter->taprio_offload_enable = false;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	if (!adapter->taprio_offload_enable)
+	if (qopt->cmd == TAPRIO_CMD_DESTROY)
 		return igc_tsn_clear_schedule(adapter);
 
+	if (qopt->cmd != TAPRIO_CMD_REPLACE)
+		return -EOPNOTSUPP;
+
 	if (qopt->base_time < 0)
 		return -ERANGE;
 
@@ -6138,6 +6131,7 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 
 	adapter->cycle_time = qopt->cycle_time;
 	adapter->base_time = qopt->base_time;
+	adapter->taprio_offload_enable = true;
 
 	for (n = 0; n < qopt->num_entries; n++) {
 		struct tc_taprio_sched_entry *e = &qopt->entries[n];
-- 
2.39.2

