Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EE36D1282
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjC3WsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjC3Wrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:47:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9118612065;
        Thu, 30 Mar 2023 15:47:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B7CE621D6;
        Thu, 30 Mar 2023 22:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7631C433A4;
        Thu, 30 Mar 2023 22:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680216448;
        bh=4BhMmHXcsVssuDv8mvr9qUKP0Q+CWM9BNT8OTVm5zVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l4LApNwbIunXUrlA8TlgsofrLdhDd7b28UtiVrQzYqv+vLoMGhh2XsLDevjs0wOzn
         jg745Rhq6aQCk8+fqX/Ww3p+dgFp7T7cHS7bt894CUCMX1ZVaeebZGTHWfMyppc9B5
         43VZRCIc4z88ga8iIhAWo6tH2xIakLXn7TDCkvh8C0b26kWOPsDeHYQtcvgVs7Gy9I
         XIkxOz8sP5Is8rqKDXbOKkQ8sj/7wiOOCeBVhlNrm5sLO8Xg8W/HwDOzxLsEiFnGra
         MchZ//c2eOKa0vc76AehjBzTUMVV/y2VytOXEkGoZOb45OtIeydd9t5raD+O6NtIt/
         mzCFzm91SNZOw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 181311540484; Thu, 30 Mar 2023 15:47:28 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: [PATCH rcu 08/20] srcu: Move ->lock initialization after srcu_usage allocation
Date:   Thu, 30 Mar 2023 15:47:14 -0700
Message-Id: <20230330224726.662344-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, both __init_srcu_struct() in CONFIG_DEBUG_LOCK_ALLOC=y kernels
and init_srcu_struct() in CONFIG_DEBUG_LOCK_ALLOC=n kernel initialize
the srcu_struct structure's ->lock before the srcu_usage structure has
been allocated.  This of course prevents the ->lock from being moved
to the srcu_usage structure, so this commit moves the initialization
into the init_srcu_struct_fields() after the srcu_usage structure has
been allocated.

Cc: Christoph Hellwig <hch@lst.de>
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Tested-by: "Zhang, Qiang1" <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 1814f3bfc219..c2a024a60f1a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -240,6 +240,8 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 		ssp->srcu_sup = kzalloc(sizeof(*ssp->srcu_sup), GFP_KERNEL);
 	if (!ssp->srcu_sup)
 		return -ENOMEM;
+	if (!is_static)
+		spin_lock_init(&ACCESS_PRIVATE(ssp, lock));
 	ssp->srcu_sup->srcu_size_state = SRCU_SIZE_SMALL;
 	ssp->srcu_sup->node = NULL;
 	mutex_init(&ssp->srcu_sup->srcu_cb_mutex);
@@ -285,7 +287,6 @@ int __init_srcu_struct(struct srcu_struct *ssp, const char *name,
 	/* Don't re-initialize a lock while it is held. */
 	debug_check_no_locks_freed((void *)ssp, sizeof(*ssp));
 	lockdep_init_map(&ssp->dep_map, name, key, 0);
-	spin_lock_init(&ACCESS_PRIVATE(ssp, lock));
 	return init_srcu_struct_fields(ssp, false);
 }
 EXPORT_SYMBOL_GPL(__init_srcu_struct);
@@ -302,7 +303,6 @@ EXPORT_SYMBOL_GPL(__init_srcu_struct);
  */
 int init_srcu_struct(struct srcu_struct *ssp)
 {
-	spin_lock_init(&ACCESS_PRIVATE(ssp, lock));
 	return init_srcu_struct_fields(ssp, false);
 }
 EXPORT_SYMBOL_GPL(init_srcu_struct);
-- 
2.40.0.rc2

