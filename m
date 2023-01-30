Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851D068065D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 08:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbjA3HMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 02:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjA3HMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 02:12:45 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4789824136;
        Sun, 29 Jan 2023 23:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675062765; x=1706598765;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/kRsQekL3gSMu+18072dhX1Nw5f8rt/kMTmhQ4446YE=;
  b=QD7fF2CzV/2V0wocD7Hkq2P+6lR63CBBut84CQ1lmcjpMnTPOtRjAA0a
   cRS4yw8ZB51Xq5XgDS3JCR/M2Gt5dk8k9DXJoDa1fihN8CzRAjwqVtwT7
   +byw4pCrfE3O2sxI/yM8RxWCWNB4Vm1EgUWo2ljZpJlu76xcTQ1jfEN5E
   Vi5mgRuCdgE/TudoSFuhyTiBZI2KavnB4ztXCRXOVaZtmMnwjyfXkpnTK
   8r/zf5WEBZelxQBQ+BROiodoAPhoc296XZg8FMXTpjhcrWmywHG1+vpU2
   ywq33jjzP1xEMtfoIuEXbsgyXWEAxIBrZSQES5uNrFsfWq82ABryi4zBt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="327505407"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="327505407"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 23:12:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="787914039"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="787914039"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 23:12:28 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Register rcu-lazy shrinker only CONFIG_RCU_LAZY is enabled
Date:   Mon, 30 Jan 2023 15:17:37 +0800
Message-Id: <20230130071737.2806534-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcu-lazy shrinker is registered without CONFIG_RCU_LAZY enabled
is meaningless, this commit therefore make rcu-lazy shrinker is
registered only when CONFIG_RCU_LAZY is enabled.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_nocb.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 9e1c8caec5ce..28c1c092817b 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1312,6 +1312,7 @@ int rcu_nocb_cpu_offload(int cpu)
 }
 EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
 
+#ifdef CONFIG_RCU_LAZY
 static unsigned long
 lazy_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
@@ -1360,6 +1361,7 @@ static struct shrinker lazy_rcu_shrinker = {
 	.batch = 0,
 	.seeks = DEFAULT_SEEKS,
 };
+#endif
 
 void __init rcu_init_nohz(void)
 {
@@ -1391,8 +1393,10 @@ void __init rcu_init_nohz(void)
 	if (!rcu_state.nocb_is_setup)
 		return;
 
+#ifdef CONFIG_RCU_LAZY
 	if (register_shrinker(&lazy_rcu_shrinker, "rcu-lazy"))
 		pr_err("Failed to register lazy_rcu shrinker!\n");
+#endif
 
 	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
 		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
-- 
2.25.1

