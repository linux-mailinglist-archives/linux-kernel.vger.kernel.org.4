Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC3A7383A0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjFUMWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjFUMW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:22:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CB69B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687350149; x=1718886149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t4zNUfsUfdiWgC9xVUBFnZiyusneatQsxuKrxZmd51w=;
  b=B/U+F9Rqf5RQ7GgP9Q95TZ3IOdMDAufARnQyDeYx6mSCahY7P1N1DsIL
   KE8OEnLUGiwrzj/m/bTMcKotnnrdMWlKcz24L0lGEIVzJH66rzy+5wlkn
   1AD+cXklFdGOPuq35cqthghPzE0OYusDue4tFXBFytORRquBSTA7M8QKD
   bv+PD5H4sI96c8Wfx0wqutlR8xunf4l/9pJjyvMccRQmZ9hcwFoG6Y46U
   AcSpke0xcM5WBzYLS0I5xMlcBhhOjQn6R9eJpSS6VygYkoDvyxI4u1bBi
   lEhOQbpm3YTV0Vej5P2m1Tgpw0pnFKUB5MmFww6D8+FYgKevrDsaBKCmu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="360165691"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="360165691"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 05:22:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="888638350"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="888638350"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga005.jf.intel.com with ESMTP; 21 Jun 2023 05:22:27 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        andrew.cooper3@citrix.com, chang.seok.bae@intel.com
Subject: [PATCH v1 2/4] x86/fpu/xstate: Simplify xstate_calculate_size()
Date:   Wed, 21 Jun 2023 05:09:40 -0700
Message-Id: <20230621120942.121822-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621120942.121822-1-chang.seok.bae@intel.com>
References: <20230621120942.121822-1-chang.seok.bae@intel.com>
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

This size calculation code uses xfeatures_get_offset() only for the
compacted format. But, it is capable of handling both formats. Use it
for simpler and more concise code.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/fpu/xstate.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 2f03acc47f62..d488621b280e 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -563,14 +563,11 @@ static bool __init check_xstate_against_struct(int nr)
 static unsigned int xstate_calculate_size(u64 xfeatures, bool compacted)
 {
 	unsigned int topmost = fls64(xfeatures) -  1;
-	unsigned int offset = xstate_offsets[topmost];
 
 	if (topmost <= XFEATURE_SSE)
 		return sizeof(struct xregs_state);
 
-	if (compacted)
-		offset = xfeature_get_offset(xfeatures, topmost);
-	return offset + xstate_sizes[topmost];
+	return xfeature_get_offset(xfeatures, topmost) + xstate_sizes[topmost];
 }
 
 /*
-- 
2.34.1

