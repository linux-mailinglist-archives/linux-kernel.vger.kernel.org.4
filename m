Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA2B6DF882
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjDLOa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjDLOax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:30:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00716EAD;
        Wed, 12 Apr 2023 07:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681309852; x=1712845852;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MUukx+elsmvY2w1rcta7R5fVF5p3q8+K1K014A88sno=;
  b=L/pe34kgCBec6QV4EQerm1bvhXkppEHCDTtTVkHWq9V8gwZzsLaVP+PE
   yaLRhV9goW7YwAxhwyM7hDTuC1/6QtjN6i552TmtC85U/Z/Mwj0guWbBO
   qp7RpTmdiPQ5xmikuAnph4hWOoCeEqAE2jJtfE+Z75rAA99Q7d5AgL+Ug
   nRakgM3FAs3B6z5rLjtrmbBggXgGGcorJM6ZGlVSXP6qKz4T06RbE7LnD
   pv2TXXilBrB2OIbVPdjSDyOhhmjAIMZtnBiz5CIn4VOwOqpawr+zZe0m/
   oWGxDtX8u9xM8aHzMCVSJcHjBD51oIDAkYSBE34uOFvP7kL5n72SRRDKI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323537702"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="323537702"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 07:30:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="778316338"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="778316338"
Received: from ubuntu.bj.intel.com ([10.238.155.108])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Apr 2023 07:30:48 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     urezki@gmail.com, paulmck@kernel.org, frederic@kernel.org,
        joel@joelfernandes.org, qiang1.zhang@intel.com
Cc:     qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rcu/kvfree: Make fill page cache start from krcp->nr_bkv_objs
Date:   Wed, 12 Apr 2023 22:31:27 +0800
Message-Id: <20230412143127.1062367-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fill_page_cache_func() is invoked and start from zero to
allocate nr_pages of page, if the kfree_rcu_work() executes before
the fill_page_cache_func(), the krcp->nr_bkv_objs is updated before
enter for-loop and equal to nr_pages, since the page is allocated
first, and then check the krcp->nr_bkv_objs in put_cached_bnode(),
this produces a meaningless __get_free_page() call, this commit
therefore make allocate page start from krcp->nr_bkv_objs and
check krcp->nr_bkv_objs before allocate page.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 41daae3239b5..dcb86f9f2dd6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3223,7 +3223,7 @@ static void fill_page_cache_func(struct work_struct *work)
 	nr_pages = atomic_read(&krcp->backoff_page_cache_fill) ?
 		1 : rcu_min_cached_objs;
 
-	for (i = 0; i < nr_pages; i++) {
+	for (i = READ_ONCE(krcp->nr_bkv_objs); i < nr_pages; i++) {
 		bnode = (struct kvfree_rcu_bulk_data *)
 			__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
 
-- 
2.32.0

