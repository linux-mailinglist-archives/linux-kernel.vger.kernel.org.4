Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6260E73839E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjFUMWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjFUMW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:22:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98C51718
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687350148; x=1718886148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PmT32/vt4ethKYYTdguD5n3hD6F8WduFRTRcW71c8DQ=;
  b=Os1x4E6oZMqeSd1H3Zx35T/L0AM7LhdL6b2t8VWGqPRx4DDe9apfQzi2
   D/GHVQ6z2gmNSdQELd2x6kWLrd08FYiIKXRS+/5KO5UtvDLG/9b0SMS/x
   tifTgOCXj6MnB7SYBge46+ny2sM37HciLIP59sLTu4tA5rexK1ErOYYgh
   fZbf0+y1DJPy6c00BaDTKaxpgfJSRg5WPpZzPDQYnmBFFvDg8LA5XQs+F
   U4OhqK99hmtE5AMdGF5j1WnMUt6AmgYbbzFGgK4PjLWj10ACvizacKtZM
   OimMfTxhjVtIMVPQq+tJl1CE0/RFTQ+bFuaS7DUm/kGXzKHN6SqRuK5C8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="360165682"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="360165682"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 05:22:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="888638343"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="888638343"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga005.jf.intel.com with ESMTP; 21 Jun 2023 05:22:27 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        andrew.cooper3@citrix.com, chang.seok.bae@intel.com
Subject: [PATCH v1 1/4] x86/fpu/xstate: Convert get_xsave_addr() to a static function
Date:   Wed, 21 Jun 2023 05:09:39 -0700
Message-Id: <20230621120942.121822-2-chang.seok.bae@intel.com>
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

The function is defined as global but is not invoked anywhere else.
Switch it a local (static) function.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/fpu/xstate.c | 2 +-
 arch/x86/kernel/fpu/xstate.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 0bab497c9436..2f03acc47f62 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -956,7 +956,7 @@ static void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
  *	address of the state in the xsave area, or NULL if the
  *	field is not present in the xsave buffer.
  */
-void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
+static void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 {
 	/*
 	 * Do we even *have* xsave state?
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index a4ecb04d8d64..82f2d3c41298 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -53,8 +53,6 @@ extern int copy_sigframe_from_user_to_xstate(struct task_struct *tsk, const void
 extern void fpu__init_cpu_xstate(void);
 extern void fpu__init_system_xstate(unsigned int legacy_size);
 
-extern void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
-
 static inline u64 xfeatures_mask_supervisor(void)
 {
 	return fpu_kernel_cfg.max_features & XFEATURE_MASK_SUPERVISOR_SUPPORTED;
-- 
2.34.1

