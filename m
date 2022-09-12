Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53E35B6442
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 01:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiILXkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 19:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiILXku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 19:40:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C40A1F61A;
        Mon, 12 Sep 2022 16:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663026048; x=1694562048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+dtGZjW57M0hat+ZUG/jaW87qoe8VIUQMNFQTveaduk=;
  b=Hg7wpjVg2fwjXsbwenIFoBtEJ1REhq+buDd4hlOZKsXPYlZVmet1SrMZ
   Bz5Fi0LYWTr3kPe8RFA/2jmWCz8EU7F4G1jM9GiSEN2H1qMk83b71whwJ
   VsF1/3bd0QFDBzgWMhMar8ecfZ2npX9KemiXhCm5AXGjjx9Xej88/6w6/
   GYpu2wH8/wW2zBmT/Y1ZopxI8imT/OYQtWikXO62TDLhgSN77DI0802nP
   H34ZBxE2eRJB9bSs/6KStQCcjTnb7Ge+qZP4LrtRhIKSJWgC5Ge+heF5C
   CH0WqAt0E+c9cPSt3wPsQMWdCS497Ws7IwB5JtQMR1D7bh51Te47rPbjZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="324235685"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="324235685"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 16:40:48 -0700
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="616247550"
Received: from sho10-mobl1.amr.corp.intel.com (HELO desk) ([10.251.9.78])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 16:40:47 -0700
Date:   Mon, 12 Sep 2022 16:40:47 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>, degoede@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com
Subject: [PATCH 2/3] x86/cpu/amd: Add feature bit for MSR_AMD64_LS_CFG
 enumeration
Message-ID: <034c7f5ac243ee7b40ba1a8cc3f9b10b1e380674.1663025154.git.pawan.kumar.gupta@linux.intel.com>
References: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is no easy way to enumerate MSR_AMD64_LS_CFG. As this
MSR is supported on AMD CPU families 10h to 18h, set a new feature bit
on these CPU families. The new bit can be used to detect the MSR
support.

Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/amd.c          | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dd173733e40d..90bdb1d98531 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -305,6 +305,7 @@
 #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime firmware calls */
 #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit when EIBRS is enabled */
 #define X86_FEATURE_MSR_TSX_CTRL	(11*32+18) /* "" MSR IA32_TSX_CTRL */
+#define X86_FEATURE_MSR_LS_CFG		(11*32+19) /* "" MSR AMD64_LS_CFG */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 48276c0e479d..88f59d630826 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -521,6 +521,9 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 		__max_die_per_package = nodes_per_socket = ((value >> 3) & 7) + 1;
 	}
 
+	if (c->x86 >= 0x10 && c->x86 <= 0x18)
+		setup_force_cpu_cap(X86_FEATURE_MSR_LS_CFG);
+
 	if (!boot_cpu_has(X86_FEATURE_AMD_SSBD) &&
 	    !boot_cpu_has(X86_FEATURE_VIRT_SSBD) &&
 	    c->x86 >= 0x15 && c->x86 <= 0x17) {
-- 
2.37.2


