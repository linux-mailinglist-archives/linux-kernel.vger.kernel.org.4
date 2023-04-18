Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521296E61D0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjDRM2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjDRM2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:28:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19348AD2F;
        Tue, 18 Apr 2023 05:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681820853; x=1713356853;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZoBHkceirvJNWzt8LE9+6lPalvhAJ4iyS7QP1CpAK54=;
  b=I7pBlM3vWZiYJFp3mmdhtoYSpfUnINuMjEojGVhZb5ZSdlNObLGH3vGj
   lZpgyXTPrXOQeeFm7c9XSS/EFa/k4V6lEFp2EunLAdyjxKH5NDL19ltqi
   Vfua2M63anawzKe41k+09tg1LleqvAcWLWtkc1jFW+U3yeO/HpkIwo+dH
   oTbwlF926Hz4q6V94Y/AAE3wIZAz8I25aHlNp6+C9sDqp96VDDmOrkfSO
   YC6RHctxkrrZqeiTZdZXaeOtZznUfC7ADW4BATHCjJCxhilhHTQojiSbM
   hcVoak47P3oZP/zL00kwFZ+1FWpkTZhlWZA/yjeMsvgP+OqA7dWwqgzYt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="408055609"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="408055609"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 05:26:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723607627"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="723607627"
Received: from ubuntu.bj.intel.com ([10.238.155.108])
  by orsmga001.jf.intel.com with ESMTP; 18 Apr 2023 05:26:26 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     urezki@gmail.com, paulmck@kernel.org, frederic@kernel.org,
        joel@joelfernandes.org, qiang1.zhang@intel.com
Cc:     qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcu/kvfree: Make drain_page_cache() call return directly if cache is disabled
Date:   Tue, 18 Apr 2023 20:27:02 +0800
Message-Id: <20230418122702.1378299-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the rcu_min_cached_objs is set to zero at boot params, the
krcp->page_cache_work will not be triggered to fill page cache,
and the put_cached_bnode() also does not fill page cache, this
also means the krcp->bkvcache is always empty, so not need to
acquire unnecessary krcp->lock to get page from krcp->bkvcache,
this commit therefore make drain_page_cache() return directly if
the rcu_min_cached_objs is zero.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 93faf9f5c58f..00620a2117de 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2924,6 +2924,9 @@ drain_page_cache(struct kfree_rcu_cpu *krcp)
 	struct llist_node *page_list, *pos, *n;
 	int freed = 0;
 
+	if (!rcu_min_cached_objs)
+		return 0;
+
 	raw_spin_lock_irqsave(&krcp->lock, flags);
 	page_list = llist_del_all(&krcp->bkvcache);
 	WRITE_ONCE(krcp->nr_bkv_objs, 0);
-- 
2.32.0

