Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C44B735198
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjFSKJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjFSKJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:09:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA4AE68;
        Mon, 19 Jun 2023 03:09:09 -0700 (PDT)
From:   Florian Kauer <florian.kauer@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687169347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kb+TqQuWpDSxFnkQigH0nioPHCD+14Ykg/2LIhh5iUw=;
        b=yW64DHUBzxEmuMXFo0JTz6YkbpHoLbvW3P34PXtXuLlZNU8hHvqe/Uxoa+/sKZsEgmEsaC
        Q4+03OkVbEEPN/UEwyLRclVUiLlpyWCWntilqzaCOzU32ZcX7S4bh/9KghEkwmr6dLUDXW
        XvEkdeO1qUHKOgUpxStMaKQtO5qevP/Bf9GvAswGaoFPDPy+rHXHDDbQB2jkmBOfQGn0Fn
        Ey7dlqWWurfGpzU2c/zTn40HHS/J+BCV3FA0iuLthpPHVCqvSgkPqIRV/7KpnGFkO/XCps
        q2dujlvvVYRTp3yCCZxc5IVci+JJPJLwk0lkql9VFBQwWdkZPi9tPNmH8bFMjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687169347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kb+TqQuWpDSxFnkQigH0nioPHCD+14Ykg/2LIhh5iUw=;
        b=urX7V1JW2N8R2tILbg5vLqusqxZBEQa4IqBUYrr9PPbYX/Dv8dHPeWbanH1iHvZB6nA++R
        NAR3yrSbh+95/ZCw==
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
Subject: [PATCH net v2 3/6] igc: Handle already enabled taprio offload for basetime 0
Date:   Mon, 19 Jun 2023 12:08:55 +0200
Message-Id: <20230619100858.116286-4-florian.kauer@linutronix.de>
In-Reply-To: <20230619100858.116286-1-florian.kauer@linutronix.de>
References: <20230619100858.116286-1-florian.kauer@linutronix.de>
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

Since commit e17090eb2494 ("igc: allow BaseTime 0 enrollment for Qbv")
it is possible to enable taprio offload with a basetime of 0.
However, the check if taprio offload is already enabled for i225
(and thus -EALREADY should be returned for igc_save_qbv_schedule)
still relied on adapter->base_time > 0.

This can be reproduced as follows:

    # TAPRIO offload (flags == 0x2) and base-time = 0
    sudo tc qdisc replace dev enp1s0 parent root handle 100 stab overhead 24 taprio \
	    num_tc 1 \
	    map 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 \
	    queues 1@0 \
	    base-time 0 \
	    sched-entry S 01 300000 \
	    flags 0x2

    # The second call should fail with "Error: Device failed to setup taprio offload."
    # But that only happens if base-time was != 0
    sudo tc qdisc replace dev enp1s0 parent root handle 100 stab overhead 24 taprio \
	    num_tc 1 \
	    map 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 \
	    queues 1@0 \
	    base-time 0 \
	    sched-entry S 01 300000 \
	    flags 0x2

Fixes: e17090eb2494 ("igc: allow BaseTime 0 enrollment for Qbv")
Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 290daa5827f0..9c04df900b59 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6082,7 +6082,7 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	if (qopt->base_time < 0)
 		return -ERANGE;
 
-	if (igc_is_device_id_i225(hw) && adapter->base_time)
+	if (igc_is_device_id_i225(hw) && adapter->taprio_offload_enable)
 		return -EALREADY;
 
 	if (!validate_schedule(adapter, qopt))
-- 
2.39.2

