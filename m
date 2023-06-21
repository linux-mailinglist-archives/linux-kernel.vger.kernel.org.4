Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496047383A1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjFUMWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjFUMWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:22:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EEC1718
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687350149; x=1718886149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PxrG7SFhXzSn4raQBGerOrXRroeYuO9/VMUGq89WOlM=;
  b=EE3rqI8LbKdp6TGGgcyQ9iO6LM5XIU4GfX32AzOmiJbRjcWI73me/lKJ
   zrrqfkfgBESP5kKsXzDr1Outx/xgQyMt6+UFwIRuE00YuVsMxaElrv0en
   p87fxIv4ZOHC/D77FUk/DVYsqUi5g5DtUI6nMlePruQiaJaVoYRMlOa6G
   0Fj7WrhY6FFS8XCuG/5QTUpUOrwo6mUwiV7jAOdtQo5yQRAzG530BrOhP
   Dnarh1Fg0oATAJ2Zh5BAgUolh6wtC+CZdvVeu0tk7CSWw5S/C3v1sN3qn
   cJ6kj9ju3Pz9/YxT4Frm8PuQYlZjB8aJ9Ob3+ULNlNb4bVdMZzedfzRgK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="360165707"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="360165707"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 05:22:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="888638358"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="888638358"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga005.jf.intel.com with ESMTP; 21 Jun 2023 05:22:28 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        andrew.cooper3@citrix.com, chang.seok.bae@intel.com
Subject: [PATCH v1 4/4] x86/fpu: Remove the unnecessary fpstate_reset() invocation
Date:   Wed, 21 Jun 2023 05:09:42 -0700
Message-Id: <20230621120942.121822-5-chang.seok.bae@intel.com>
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

fpstate_reset() initializes the fpstate container. But, when no state
has been established yet, calling this is not meaningful. In the
fpu__init_system() function, it is called immediately after the legacy
FPU size is determined. So, remove it as not causing any issues.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---

The change made by fpstate_reset() can be measured with this:

static struct fpstate fps;

void __init fpu__init_system(struct cpuinfo_x86 *c)
{
	memcpy(&fps, &current->thread.fpu.__fpstate, sizeof(struct fpstate));
	fpstate_reset(&current->thread.fpu);
	if (memcmp(&fps, &current->thread.fpu.__fpstate, sizeof(struct fpstate)))
		pr_info("fpstate has reason to be inited at %s\n", __func__);
	else
		pr_info("fpstate has no reason to be inited at %s\n", __func__);
	...
}

Although it looks to be a no-op, there might be some unknown
intention behind it. If there is a specific reason for invoking
fpstate_reset() at that point, this should be documented properly
instead of removing it.
---
 arch/x86/kernel/fpu/init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 998a08f17e33..95af3084c4cf 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -213,7 +213,6 @@ static void __init fpu__init_system_xstate_size_legacy(void)
  */
 void __init fpu__init_system(void)
 {
-	fpstate_reset(&current->thread.fpu);
 	fpu__init_system_early_generic();
 
 	/*
-- 
2.34.1

