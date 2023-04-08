Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90FB6DBB8E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 16:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjDHOYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 10:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjDHOYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 10:24:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F95C64A;
        Sat,  8 Apr 2023 07:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680963878; x=1712499878;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1/EFS4qTJgUjgKWW6wh9rSkbnbQnihJy1r+mSbHPrws=;
  b=h3cG+kBRw1/u2i4vwy2nE9rjhZVPBwAjLzWjmW4YjxLxPSxj1VpZI74G
   pcvQU3gJRt762vUNx2f7CvRcHgMuamsO1ZhcuTtQk3X0ZtdfancbVtz3k
   CZhuHgVLUPZ4Nx/qDrsSmptpFtKjwPj5J4K5rqL4FX4pMoHDTMRz/hogf
   aGtNT0mMqnxnzKTjmRYasz+LBo45OETDcrXAq/c4CLN08lsTY9f1W8X+y
   UuJf4lcIrqgaba+QFlMKMlRjF3x/vIyZh2xQcTV++M8gYQyw8763mVCxD
   QlvH5MZn8mCBanjCFRoNJ5oJfiBBIVlsCBuFsaZqHqbD0dJ38qBUeVjMn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10674"; a="343147974"
X-IronPort-AV: E=Sophos;i="5.98,329,1673942400"; 
   d="scan'208";a="343147974"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2023 07:24:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10674"; a="831461577"
X-IronPort-AV: E=Sophos;i="5.98,329,1673942400"; 
   d="scan'208";a="831461577"
Received: from ubuntu.bj.intel.com ([10.238.155.108])
  by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2023 07:24:35 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     urezki@gmail.com, paulmck@kernel.org, frederic@kernel.org,
        joel@joelfernandes.org, qiang1.zhang@intel.com
Cc:     qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] rcu/kvfree: Prevents cache growing when the backoff_page_cache_fill is set
Date:   Sat,  8 Apr 2023 22:25:17 +0800
Message-Id: <20230408142517.800549-1-qiang1.zhang@intel.com>
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
executed before kfree_rcu_monitor() to drain page cache, if the bnode
structure's->gp_snap has done, the kvfree_rcu_bulk() will fill the
page cache again in kfree_rcu_monitor(), this commit add a check
for krcp structure's->backoff_page_cache_fill in put_cached_bnode(),
if the krcp structure's->backoff_page_cache_fill is set, prevent page
cache growing and disable allocated page in fill_page_cache_func().

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cc34d13be181..9d9d3772cc45 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2908,6 +2908,8 @@ static inline bool
 put_cached_bnode(struct kfree_rcu_cpu *krcp,
 	struct kvfree_rcu_bulk_data *bnode)
 {
+	if (atomic_read(&krcp->backoff_page_cache_fill))
+		return false;
 	// Check the limit.
 	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
 		return false;
@@ -3221,7 +3223,7 @@ static void fill_page_cache_func(struct work_struct *work)
 	int i;
 
 	nr_pages = atomic_read(&krcp->backoff_page_cache_fill) ?
-		1 : rcu_min_cached_objs;
+		0 : rcu_min_cached_objs;
 
 	for (i = 0; i < nr_pages; i++) {
 		bnode = (struct kvfree_rcu_bulk_data *)
-- 
2.32.0

