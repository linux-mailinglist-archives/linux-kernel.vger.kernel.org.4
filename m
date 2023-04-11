Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A20B6DDDD8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjDKO1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjDKO1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:27:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6733259C7;
        Tue, 11 Apr 2023 07:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681223221; x=1712759221;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D+lwxEBI11azd214/0YlxBDefvmnj9OAR5+LS8svKZY=;
  b=GojyjcZCUGkSIO0w3goaYVnvvJ9HF10X8Z3RogtqJ47kbW1g7DWs726z
   SKGEpRXQ7X+N4R+QYFVxJRaUzM92inobsnJupVsTMntgsu49sArI8S8Th
   1U7fgax0/eJOgLnTg2abzpGrteiaXpmF/yw6cXJ08QUZ3BiiMkFkC0GpN
   TW05M9y9SFQjyynQUX049/JI9ODzuno1N8EuKtHqtqHoBaxxTLgNu7jXs
   wCygWcQWjMgleQViLw01PBk9xW5N4mdP21vcwtht1d5t0sFlVaP+sbLkC
   1hb9ToN4MV9Eo1WCTcVOFLHukAe8zaClOZ4kjJE0fHpaf9tgeEEQ99dWQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="346300492"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="346300492"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 07:26:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="682097229"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="682097229"
Received: from ubuntu.bj.intel.com ([10.238.155.108])
  by orsmga007.jf.intel.com with ESMTP; 11 Apr 2023 07:26:53 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     urezki@gmail.com, paulmck@kernel.org, frederic@kernel.org,
        joel@joelfernandes.org, qiang1.zhang@intel.com
Cc:     qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHi v4] rcu/kvfree: Prevents cache growing when the backoff_page_cache_fill is set
Date:   Tue, 11 Apr 2023 22:27:33 +0800
Message-Id: <20230411142733.1011223-1-qiang1.zhang@intel.com>
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
cache growing and start fill page from krcp->nr_bkv_objs, if the
krcp->nr_bkv_objs is greater or equal to nr_pages, not alloc page,
avoid unnecessary __get_free_page() calls.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 41daae3239b5..d5639025bd1a 100644
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
@@ -3223,7 +3225,7 @@ static void fill_page_cache_func(struct work_struct *work)
 	nr_pages = atomic_read(&krcp->backoff_page_cache_fill) ?
 		1 : rcu_min_cached_objs;
 
-	for (i = 0; i < nr_pages; i++) {
+	for (i = krcp->nr_bkv_objs; i < nr_pages; i++) {
 		bnode = (struct kvfree_rcu_bulk_data *)
 			__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
 
-- 
2.32.0

