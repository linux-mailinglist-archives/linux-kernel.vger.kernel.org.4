Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D32604294
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiJSLHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbiJSLGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:06:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9917102DE8;
        Wed, 19 Oct 2022 03:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666175742; x=1697711742;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+Z1UQaZoC71MDvVH2UIbpGIxKwdpGYtiyrhpruzz4ZI=;
  b=lYoVsCXtzewdeWgEtzSywYxcbIEq/prA64yAzTp3JbD2qxKgkJwUpsmq
   bCq7MuEW8FGZMJ6NUuKFqXHVGksys/+9yGLZ0kaKq20YIv3t9j6iK49j5
   PAIxhXoqDs9u67xNuMILQm+1/pwOtvP0Exa1Y8cZSOdDoVnYWdqrAb4cT
   AY64h+swjm/Sh6djBO5WuLqnqO9iWzxoSDtKpiFDu4o3OJLk3GKrT3vs2
   l1fxUZxVKEmp9vkQfbgl2GHt2Q/A6mpp8sUtbaT3iUuuPL43SozA3bS7x
   J1AH1uMkNQBA7Njj7fJZl44DK/O+NtPp3HQ1zGtUXeMJPfJdnc1U4x8vE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="303989043"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="303989043"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 03:34:31 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="607034094"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="607034094"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 03:34:29 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Make call_rcu() lazy only when CONFIG_RCU_LAZY is enabled
Date:   Wed, 19 Oct 2022 18:40:45 +0800
Message-Id: <20221019104045.160283-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, regardless of whether the CONFIG_RCU_LAZY is enabled,
invoke the call_rcu() is always lazy, it also means that when
CONFIG_RCU_LAZY is disabled, invoke the call_rcu_flush() is also
lazy. therefore, this commit make call_rcu() lazy only when
CONFIG_RCU_LAZY is enabled.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index abc615808b6e..97ef602da3d5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2839,7 +2839,6 @@ void call_rcu_flush(struct rcu_head *head, rcu_callback_t func)
 	return __call_rcu_common(head, func, false);
 }
 EXPORT_SYMBOL_GPL(call_rcu_flush);
-#endif
 
 /**
  * call_rcu() - Queue an RCU callback for invocation after a grace period.
@@ -2890,6 +2889,13 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 	return __call_rcu_common(head, func, true);
 }
 EXPORT_SYMBOL_GPL(call_rcu);
+#else
+void call_rcu(struct rcu_head *head, rcu_callback_t func)
+{
+	return __call_rcu_common(head, func, false);
+}
+EXPORT_SYMBOL_GPL(call_rcu);
+#endif
 
 /* Maximum number of jiffies to wait before draining a batch. */
 #define KFREE_DRAIN_JIFFIES (5 * HZ)
-- 
2.25.1

