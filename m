Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F68860549F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 02:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiJTA4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 20:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiJTA4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 20:56:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0EF15F328;
        Wed, 19 Oct 2022 17:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666227391; x=1697763391;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=io+z4s6zqp/Slsj06uti7z0TY8ItxriCHMukm1AYoAA=;
  b=Qu0iEj0VHg/QHdL3yAwiQEalHmPKDqJ7+LwY1hhz7mh4oYksHnAE8ilj
   Ww+jSPyy44hOPt1B4GMgFNkSs4E28YDiX5nRMxyRzUgDTWr0SHmtvJ/V+
   ifnTpx4NYYgELzkEdTKl404a2LFmDU0VDz7TlFpVrrMPVCEobPQ4NeUQj
   9NzMqt0U3PjrMMy81Ya3OOVVRFH/gmSw8luJAcoKeNGVEQl4iYkdumnQ3
   SWxEjsmLiJ8JmWLvHzGW5sLMzc2zQ3FyrakLhrjxjaY08ZuY7llQ+Vw2d
   eVd/okD8SeC0225oF2FuF8f/RGYB84YwMFTE0ro4QWb+IoerTG1h+xd/P
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="305306830"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="305306830"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 17:56:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="580603751"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="580603751"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 17:56:27 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] rcu: Make call_rcu() lazy only when CONFIG_RCU_LAZY is enabled
Date:   Thu, 20 Oct 2022 09:02:42 +0800
Message-Id: <20221020010242.453121-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 v1->v2->v3:
 Use IS_ENABLED(CONFIG_RCU_LAZY) to the existing function of the same name. 

 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index abc615808b6e..1f6a4b2b13da 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2887,7 +2887,7 @@ EXPORT_SYMBOL_GPL(call_rcu_flush);
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-	return __call_rcu_common(head, func, true);
+	return __call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY));
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
-- 
2.25.1

