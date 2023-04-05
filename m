Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DA46D7250
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 04:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbjDECNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 22:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbjDECNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 22:13:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D794224;
        Tue,  4 Apr 2023 19:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680660800; x=1712196800;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mmL48LghRvNIccOP+XTDg1agIHo//2sNs+v9zg/WcTA=;
  b=mhUkZy75hQqo6gekgZJTx1BcMiCd5mgnnz+KR4uprqRgs8MhoAT0DkmS
   9NiUwefC58Xx4jSkkntEQiILaH7zHHlOkhNiuUBuekYjeRthrbBcKbp0n
   gU7KpEE3MpgX7kLtPJvKJ+wu0QgVGz/7nvN+jSURBZQWawqE17rohKyIK
   w+noHGNO1/NQE8Yj8O0n1Yt5vI02ARiKNORplLOdnT7v+RbXVCzkC9xdq
   pANhTUM4Z1bXZH/ZPbHRqY6VzBTngsGddWpJXcPqBWS36g3qV3tMnWuxt
   GJ44hmglmJzwEz90Qp4FEe7XW9DWexNTHpcS5cdVQ5NWpcEN7B58fpKHr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="428637835"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="428637835"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 19:13:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10670"; a="830198297"
X-IronPort-AV: E=Sophos;i="5.98,319,1673942400"; 
   d="scan'208";a="830198297"
Received: from ubuntu.bj.intel.com ([10.238.155.108])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2023 19:13:17 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     urezki@gmail.com, paulmck@kernel.org, frederic@kernel.org,
        joel@joelfernandes.org, qiang1.zhang@intel.com
Cc:     qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rcu/kvfree: Invoke debug_rcu_bhead_unqueue() with check bnode->snap is done
Date:   Wed,  5 Apr 2023 10:13:59 +0800
Message-Id: <20230405021359.606321-1-qiang1.zhang@intel.com>
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

This commit make debug_rcu_bhead_unqueue() be invoked with check
the bnode structure's->snap is done in kvfree_rcu_bulk().

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3461fc2640b9..17b5d115aec1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2943,8 +2943,8 @@ kvfree_rcu_bulk(struct kfree_rcu_cpu *krcp,
 	unsigned long flags;
 	int i;
 
-	debug_rcu_bhead_unqueue(bnode);
 	if (!WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&bnode->gp_snap))) {
+		debug_rcu_bhead_unqueue(bnode);
 		rcu_lock_acquire(&rcu_callback_map);
 		if (idx == 0) { // kmalloc() / kfree().
 			trace_rcu_invoke_kfree_bulk_callback(
-- 
2.32.0

