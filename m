Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED766DBB8F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 16:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjDHOY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 10:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjDHOYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 10:24:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A4BC640;
        Sat,  8 Apr 2023 07:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680963891; x=1712499891;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ReZriI51GMtfmI0Pc8bW8jknlkpzYTRVOz7nIwwjg4M=;
  b=a/rpi5K+JiWEX7VSZd8sleEXNVdgd2Kp9OuXmc0yzi/DwiCYviYA5MtF
   P90BYhQWX1KdAPojBpaOY8bsEt7/LQIieFEZKof5c80dQk4B6H70wNBYO
   kz8hbr5sZciSf5imkatH5sHzTMOVNwNpsKH7nbAZdlzb8D2Q+ORKrYZrr
   xhLpod+6bMftfzNOJMu/WxWfiyIiQfPmq/PCxKJBs255qKWnEqg/NDuv4
   Z+cRTCJqhDCWmho6yK5IhPS66g+yimYPlEwvr9dtqSTQg1L18gIyBxaj+
   RlIcbS1PvRIEIR6z3HEAEPtPBd2e7HlS30tb3tNaTlvABXMHDVln1Pa+Q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10674"; a="343147993"
X-IronPort-AV: E=Sophos;i="5.98,329,1673942400"; 
   d="scan'208";a="343147993"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2023 07:24:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10674"; a="831461615"
X-IronPort-AV: E=Sophos;i="5.98,329,1673942400"; 
   d="scan'208";a="831461615"
Received: from ubuntu.bj.intel.com ([10.238.155.108])
  by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2023 07:24:48 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     urezki@gmail.com, paulmck@kernel.org, frederic@kernel.org,
        joel@joelfernandes.org, qiang1.zhang@intel.com
Cc:     qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rcu/kvfree: Make page cache growing happen on the correct krcp
Date:   Sat,  8 Apr 2023 22:25:30 +0800
Message-Id: <20230408142530.800612-1-qiang1.zhang@intel.com>
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

When invoke add_ptr_to_bulk_krc_lock() to queue ptr, will invoke
krc_this_cpu_lock() return current CPU's krcp structure and get a
bnode object from the krcp structure's ->bulk_head, if return is
empty or the returned bnode object's nr_records is KVFREE_BULK_MAX_ENTR,
when the can_alloc is set, will unlock current CPU's krcp->lock and
allocate bnode, after that, will invoke krc_this_cpu_lock() again to
return current CPU's krcp structure, if the CPU migration occurs,
the krcp obtained at this time will not be consistent with the previous
one, this causes the bnode will be added to the wrong krcp structure's
->bulk_head or trigger fill page work on wrong krcp.

This commit therefore re-hold krcp->lock after allocated page instead
of re-call krc_this_cpu_lock() to ensure the consistency of krcp.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9d9d3772cc45..c9076fa0a954 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3303,7 +3303,7 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 			// scenarios.
 			bnode = (struct kvfree_rcu_bulk_data *)
 				__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
-			*krcp = krc_this_cpu_lock(flags);
+			raw_spin_lock_irqsave(&(*krcp)->lock, *flags);
 		}
 
 		if (!bnode)
-- 
2.32.0

