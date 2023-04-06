Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA17F6D8B7E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjDFAMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjDFAL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:11:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5441C1FEF;
        Wed,  5 Apr 2023 17:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680739918; x=1712275918;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k6oD4P8JJ+4H32PsjW+MjsBEPTQQ7vjSmhcQyi0h7h8=;
  b=F1UxUV1o8gqpsUdoDb3zoWx9G9ADb4GUeq8SnSvZuUq+/sTDEejOcXEo
   yR2pGp7s0GT43Tu/BsWKI1BlfMaHOC4OepVpXgzo85L83X5zLDY2BWM2W
   5OwNYzgW+5Am5tG/BH+odW0Q6U0yFJQRt2+BPr12TwRpTYFoWdk7OoluC
   yKuGW8ujfdzJ2OBA5kkDzwt+kOMndI+9X2BVR2+7d3y1HE5SP5x/LLYIR
   j4doxXXc/EIn94g/xXvxenITjYJ/DuJGGPaMjXLI1B/z2lZT0ocJBh5L7
   e9WOCLHmVI3RBI4bQK86xu8sSQOVwVJ/PlSjxb/LjDwy03DzlqguVQd1c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="340092781"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="340092781"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 17:11:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="717238781"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="717238781"
Received: from ubuntu.bj.intel.com ([10.238.155.108])
  by orsmga008.jf.intel.com with ESMTP; 05 Apr 2023 17:11:55 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     urezki@gmail.com, paulmck@kernel.org, frederic@kernel.org,
        joel@joelfernandes.org, qiang1.zhang@intel.com
Cc:     qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcu/kvfree: Prevents cache growing when the backoff_page_cache_fill is set
Date:   Thu,  6 Apr 2023 08:12:38 +0800
Message-Id: <20230406001238.647536-1-qiang1.zhang@intel.com>
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
cache growing.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9cc0a7766fd2..f25430ae1936 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2907,6 +2907,8 @@ static inline bool
 put_cached_bnode(struct kfree_rcu_cpu *krcp,
 	struct kvfree_rcu_bulk_data *bnode)
 {
+	if (atomic_read(&krcp->backoff_page_cache_fill))
+		return false;
 	// Check the limit.
 	if (krcp->nr_bkv_objs >= rcu_min_cached_objs)
 		return false;
-- 
2.32.0

