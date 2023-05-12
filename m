Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801847006FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240804AbjELLkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240230AbjELLj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:39:59 -0400
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E916BFA
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1683891598; x=1715427598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l1iA6qEQdQZuo8aepsGp3eChy0zgLfi4JYPW6IsDG7I=;
  b=hYfUSLNnGQJbc40lu7MON9SeBfPKaPFjxw9oGi7+XMJc7/4FlbiXoW7Y
   ieoS3hZEaxg+NapIZySTyDVaxSw+z9jow12fwLj0AxcMc1lOYWbWNDmMx
   jAh9GZrt9gSqkAUDju70ChpZSDpzl3580Rzvt6AmYT/2vieHsXOIUYZVD
   I=;
X-IronPort-AV: E=Sophos;i="5.99,269,1677542400"; 
   d="scan'208";a="2487811"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-94edd59b.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 11:39:55 +0000
Received: from EX19D001EUA003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-m6i4x-94edd59b.us-west-2.amazon.com (Postfix) with ESMTPS id 74E2841460;
        Fri, 12 May 2023 11:39:54 +0000 (UTC)
Received: from EX19D039EUA003.ant.amazon.com (10.252.50.203) by
 EX19D001EUA003.ant.amazon.com (10.252.50.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.26;
 Fri, 12 May 2023 11:39:53 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D039EUA003.ant.amazon.com (10.252.50.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 May 2023 11:39:52 +0000
Received: from dev-dsk-attofari-1c-9e00ebdc.eu-west-1.amazon.com
 (10.13.242.123) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26 via Frontend Transport; Fri, 12 May 2023 11:39:51 +0000
From:   Adamos Ttofari <attofari@amazon.de>
CC:     <attofari@amazon.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Kyle Huey <me@kylehuey.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] x86: fpu: Keep xfd_state always in sync with MSR_IA32_XFD
Date:   Fri, 12 May 2023 11:38:58 +0000
Message-ID: <20230512113900.56393-1-attofari@amazon.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230511152818.13839-1-attofari@amazon.de>
References: <20230511152818.13839-1-attofari@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 672365477ae8 ("x86/fpu: Update XFD state where required") and
commit 8bf26758ca96 ("x86/fpu: Add XFD state to fpstate") introduced a
per CPU variable xfd_state to keep the MSR_IA32_XFD value cached. In
order to avoid unnecessary writes to the MSR.

On CPU hotplug MSR_IA32_XFD is reset to the init_fpstate.xfd, which
wipes out any stale state. But the per CPU cached xfd value is not
reset, which brings them out of sync.

As a consequence a subsequent xfd_update_state() might fail to update
the MSR which in turn can result in XRSTOR raising a #NM in kernel
space, which crashes the kernel.

To address the issue mentioned, initialize xfd_state together with
MSR_IA32_XFD and always update MSR_IA32_XFD with xfd_set_state to
avoid out of sync cases.

Fixes: 672365477ae8 ("x86/fpu: Update XFD state where required")

Signed-off-by: Adamos Ttofari <attofari@amazon.de>
---
 arch/x86/kernel/fpu/xstate.c |  8 ++++----
 arch/x86/kernel/fpu/xstate.h | 14 ++++++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 0bab497c9436..d0f151d209d4 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -177,10 +177,11 @@ void fpu__init_cpu_xstate(void)
 	 * Must happen after CR4 setup and before xsetbv() to allow KVM
 	 * lazy passthrough.  Write independent of the dynamic state static
 	 * key as that does not work on the boot CPU. This also ensures
-	 * that any stale state is wiped out from XFD.
+	 * that any stale state is wiped out from XFD. Reset the per CPU
+	 * xfd cache too.
 	 */
 	if (cpu_feature_enabled(X86_FEATURE_XFD))
-		wrmsrl(MSR_IA32_XFD, init_fpstate.xfd);
+		xfd_set_state(init_fpstate.xfd);
 
 	/*
 	 * XCR_XFEATURE_ENABLED_MASK (aka. XCR0) sets user features
@@ -914,8 +915,7 @@ void fpu__resume_cpu(void)
 				     xfeatures_mask_independent());
 	}
 
-	if (fpu_state_size_dynamic())
-		wrmsrl(MSR_IA32_XFD, current->thread.fpu.fpstate->xfd);
+	xfd_update_state(current->thread.fpu.fpstate);
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index a4ecb04d8d64..d272fc214113 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -147,20 +147,26 @@ static inline void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rs
 #endif
 
 #ifdef CONFIG_X86_64
+static inline void xfd_set_state(u64 xfd)
+{
+	wrmsrl(MSR_IA32_XFD, xfd);
+	__this_cpu_write(xfd_state, xfd);
+}
+
 static inline void xfd_update_state(struct fpstate *fpstate)
 {
 	if (fpu_state_size_dynamic()) {
 		u64 xfd = fpstate->xfd;
 
-		if (__this_cpu_read(xfd_state) != xfd) {
-			wrmsrl(MSR_IA32_XFD, xfd);
-			__this_cpu_write(xfd_state, xfd);
-		}
+		if (__this_cpu_read(xfd_state) != xfd)
+			xfd_set_state(xfd);
 	}
 }
 
 extern int __xfd_enable_feature(u64 which, struct fpu_guest *guest_fpu);
 #else
+static inline void xfd_set_state(u64 xfd) { }
+
 static inline void xfd_update_state(struct fpstate *fpstate) { }
 
 static inline int __xfd_enable_feature(u64 which, struct fpu_guest *guest_fpu) {
-- 
2.39.2




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



