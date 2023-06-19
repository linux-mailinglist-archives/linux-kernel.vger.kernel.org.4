Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678BC73518C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjFSKJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjFSKJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:09:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C99BE66;
        Mon, 19 Jun 2023 03:09:08 -0700 (PDT)
From:   Florian Kauer <florian.kauer@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687169346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1jNWX8QcZCpCofdya0P9KDQCt/K+OixGuaqVhm+2fOU=;
        b=YVMVtPVYbpoT+azuBmYHugphzeY68s7BUuMWyI3DgMGZ99jjxK46dBcZsi8Z2j2V/O96kd
        E2481yjeU6MJi8Bg+pqkOLeZYfZanzSTjJDW4wrKVO4yCaLQqkOputF+Ah2OMlN0PZLz/S
        7AJ8r4PsTkXIYL5sQJDzBe3lxiUeAJKLIiwmtzEp1DvyIDoCKerJbRA8YRS/6N6XHeMs2o
        xVCaiFjwuLjexJ4JtzNVz4zpKEY5g7eGS5DCR1bQWSBBCfVW4FCnqLKEMJ2H7NTXVtRkLw
        hCQHKQ6tz6QFYzZFgHK1wFWwK0MDROoVYL+B1xj45X3P4H0w1BncY4K9DW0wLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687169346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1jNWX8QcZCpCofdya0P9KDQCt/K+OixGuaqVhm+2fOU=;
        b=Z4AJ1A2N5oEYHXaIWPstAh0ZgB+yJXiZwgZ2+f8ePvcJ7XvTHngj12+2wiKH3OyriKNOlq
        q+K5upR1BRZbzaBA==
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
Subject: [PATCH net v2 1/6] igc: Rename qbv_enable to taprio_offload_enable
Date:   Mon, 19 Jun 2023 12:08:53 +0200
Message-Id: <20230619100858.116286-2-florian.kauer@linutronix.de>
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

In the current implementation the flags adapter->qbv_enable
and IGC_FLAG_TSN_QBV_ENABLED have a similar name, but do not
have the same meaning. The first one is used only to indicate
taprio offload (i.e. when igc_save_qbv_schedule was called),
while the second one corresponds to the Qbv mode of the hardware.
However, the second one is also used to support the TX launchtime
feature, i.e. ETF qdisc offload. This leads to situations where
adapter->qbv_enable is false, but the flag IGC_FLAG_TSN_QBV_ENABLED
is set. This is prone to confusion.

The rename should reduce this confusion. Since it is a pure
rename, it has no impact on functionality.

Fixes: e17090eb2494 ("igc: allow BaseTime 0 enrollment for Qbv")
Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igc/igc.h      | 2 +-
 drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
 drivers/net/ethernet/intel/igc/igc_tsn.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 34aebf00a512..4c7a1e92ce4c 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -185,7 +185,7 @@ struct igc_adapter {
 
 	ktime_t base_time;
 	ktime_t cycle_time;
-	bool qbv_enable;
+	bool taprio_offload_enable;
 	u32 qbv_config_change_errors;
 
 	/* OS defined structs */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index fa764190f270..dda057a3b5e3 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6075,7 +6075,7 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	size_t n;
 	int i;
 
-	adapter->qbv_enable = qopt->enable;
+	adapter->taprio_offload_enable = qopt->enable;
 
 	if (!qopt->enable)
 		return igc_tsn_clear_schedule(adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 94a2b0dfb54d..c6636a7264d5 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -37,7 +37,7 @@ static unsigned int igc_tsn_new_flags(struct igc_adapter *adapter)
 {
 	unsigned int new_flags = adapter->flags & ~IGC_FLAG_TSN_ANY_ENABLED;
 
-	if (adapter->qbv_enable)
+	if (adapter->taprio_offload_enable)
 		new_flags |= IGC_FLAG_TSN_QBV_ENABLED;
 
 	if (is_any_launchtime(adapter))
-- 
2.39.2

