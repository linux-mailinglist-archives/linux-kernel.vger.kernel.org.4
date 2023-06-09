Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7F272A26C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 20:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjFIShe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 14:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbjFIShZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 14:37:25 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2793ABF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 11:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686335832; x=1717871832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jwp2HjzYTo7V1oc3MvCqOYLHYFthgPfSLKoKbfmVBTI=;
  b=NjzZInySB9HgOhCIiP8pcWuNdaboqXoixvdOPMDviVqYfaBOjMZ6pup4
   U6C9sfDfqQtyHUP7Iq5n5DkuD0BX+dkoVa40YSMOuv9bd6iJzXsK5Ar6g
   gQmp4GNNLegUJLnWNdS1ZsWmEOKa2njb7kbUA3jOvJojwMV9AdzfBfngA
   DTgVwK2p7zG7vBThoCT5y70maXfCs9p57IRCwU3gZiK39kqqbU5gld2V3
   b36ByPgcZRJ+B+9RChiXorlYGxsGFymEap3cBzbo5E9q6Ivky32/GFaKZ
   jR3HaNmm6jgmE+9nRDqw6mYS8XEGBwm3okA+8t9jRPupP0VZNAgF5wiaZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="338022169"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="338022169"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 11:37:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="710444055"
X-IronPort-AV: E=Sophos;i="6.00,230,1681196400"; 
   d="scan'208";a="710444055"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 09 Jun 2023 11:37:09 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v3 07/12] x86/traps: Consolidate user fixups in exc_general_protection()
Date:   Fri,  9 Jun 2023 21:36:27 +0300
Message-Id: <20230609183632.48706-8-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230609183632.48706-1-alexander.shishkin@linux.intel.com>
References: <20230609183632.48706-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sohil Mehta <sohil.mehta@intel.com>

Move the UMIP exception fixup along with the other user mode fixups.

No functional change intended.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/kernel/traps.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 58b1f208eff5..f3e619ce9fbd 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -736,11 +736,6 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 
 	cond_local_irq_enable(regs);
 
-	if (static_cpu_has(X86_FEATURE_UMIP)) {
-		if (user_mode(regs) && fixup_umip_exception(regs))
-			goto exit;
-	}
-
 	if (v8086_mode(regs)) {
 		local_irq_enable();
 		handle_vm86_fault((struct kernel_vm86_regs *) regs, error_code);
@@ -755,6 +750,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		if (fixup_vdso_exception(regs, X86_TRAP_GP, error_code, 0))
 			goto exit;
 
+		if (cpu_feature_enabled(X86_FEATURE_UMIP) && fixup_umip_exception(regs))
+			goto exit;
+
 		gp_user_force_sig_segv(regs, X86_TRAP_GP, error_code, desc);
 		goto exit;
 	}
-- 
2.39.2

