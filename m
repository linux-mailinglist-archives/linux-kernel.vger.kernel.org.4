Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ED26D724F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 04:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbjDECNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 22:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjDECNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 22:13:05 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B086119BD;
        Tue,  4 Apr 2023 19:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680660784; x=1712196784;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w+JnPxtm7tNsQ6086I9DiyvCHKa0VadIfgzIchRU8KQ=;
  b=jU2CxC9CCUJlzQmSdvA6/Ucg43+0WlDms21Y1WcH7o5KxGH/3yZ6irLX
   u4Y7bYk2FI3LmB2dYUJWgb0N3CObHaHq/5FqXrClYKNr+OcPxRaVgTTDc
   erOVs8wWAWFCZyxKEeOjZH8CpQYmQ1q/tnPJjdcVvqVLZYlj6qHDPS880
   rdI2lsiJW2o4o749VOrs3dEqHCyU4noKAYjeg8MNfsi9DVm9fOV/xVDyr
   hpti8Ye4a8Ahrv2+MH5vS95Luqgn692tZKUi9K3dyCGRn+FSlOlSBh0lz
   yMzB79MqYHyXlX7u38dHjZKghVRI3u3l/pTojHMSisTiCRYUETXjT8iLU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="428637808"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="428637808"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 19:13:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="830198271"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="830198271"
Received: from ubuntu.bj.intel.com ([10.238.155.108])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2023 19:13:02 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     urezki@gmail.com, paulmck@kernel.org, frederic@kernel.org,
        joel@joelfernandes.org, qiang1.zhang@intel.com
Cc:     qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rcu/kvfree: Delay the execution of drain_page_cache()
Date:   Wed,  5 Apr 2023 10:13:42 +0800
Message-Id: <20230405021342.606264-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, in kfree_rcu_shrink_scan(), the drain_page_cache() is
executed before kfree_rcu_monitor() to drain page cache, if the
bnode structure's->gp_snap has done, the kvfree_rcu_bulk() will
fill the page cache again in kfree_rcu_monitor(), this commit
therefore move drain_page_cache() after kfree_rcu_monitor() to
drain page cache.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 35be35f8236b..3461fc2640b9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3424,8 +3424,8 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		count = krc_count(krcp);
-		count += drain_page_cache(krcp);
 		kfree_rcu_monitor(&krcp->monitor_work.work);
+		count += drain_page_cache(krcp);
 
 		sc->nr_to_scan -= count;
 		freed += count;
-- 
2.32.0

