Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AC96FF5F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238724AbjEKP3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238529AbjEKP3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:29:33 -0400
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B35B19B2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 08:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1683818972; x=1715354972;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yklgg+I1PX9hURyg5UEers4I67XL77IDZYl+G241f/A=;
  b=aIf6H3EfQe6LD9YOUS4yqDvvZnN/i1qtXWD0Fc8wJ+bu1d77c3Cwlc8Y
   kkqUkJZhH6JiWaZUgYuYTB1bscAA+IipE72AIvD+Wy4TP3fDnZiauB7JD
   cpxqHTYr3U+quhS5S3lPDgisfI3+aR6CG2CLBQ57/48+mi1dz/i3xMQTl
   I=;
X-IronPort-AV: E=Sophos;i="5.99,266,1677542400"; 
   d="scan'208";a="2265657"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-b404fda3.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 15:29:29 +0000
Received: from EX19MTAUEA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-m6i4x-b404fda3.us-east-1.amazon.com (Postfix) with ESMTPS id 4B5A983222;
        Thu, 11 May 2023 15:29:26 +0000 (UTC)
Received: from EX19D008UEA004.ant.amazon.com (10.252.134.191) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 11 May 2023 15:29:25 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D008UEA004.ant.amazon.com (10.252.134.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 11 May 2023 15:29:25 +0000
Received: from dev-dsk-attofari-1c-9e00ebdc.eu-west-1.amazon.com
 (10.13.242.123) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26 via Frontend Transport; Thu, 11 May 2023 15:29:24 +0000
From:   Adamos Ttofari <attofari@amazon.de>
CC:     <abusse@amazon.de>, <dwmw@amazon.co.uk>, <hborghor@amazon.de>,
        <sironi@amazon.de>, <attofari@amazon.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Kyle Huey <me@kylehuey.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] fpu: xstate: Keep xfd_state always in-sync with IA32_XFD MSR
Date:   Thu, 11 May 2023 15:28:17 +0000
Message-ID: <20230511152818.13839-1-attofari@amazon.de>
X-Mailer: git-send-email 2.39.2
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
per_cpu variable xfd_state to keep the IA32_XFD MSR value cached. In
order to avoid unnecessary writes to the MSR.

xfd_state might not be always synced with the MSR. Eventually affecting
MSR writes. xfd_state is initialized with 0, meanwhile the MSR is
initialized with the XFEATURE_MASK_USER_DYNAMIC to make XFD fire. Then
later on reschedule to a different CPU, when a process that uses extended
xfeatures and handled the #NM (by allocating the additional space in task's
fpstate for extended xfeatures) it will skip the MSR update in
restore_fpregs_from_fpstate because the value might match to already cached
xfd_state (meanwhile it is not the same with the MSR). Eventually calling a
XRSTOR to set the new state (that caries extended xfeatures) and fire a #NM
from kernel context. The XFD is expected to fire from user-space context,
but not in this case and the kernel crashes.

To address the issue mentioned initialize xfd_state with the current MSR
value and update the XFD MSR always with xfd_update_state to avoid
un-sync cases.

Fixes: 672365477ae8 ("x86/fpu: Update XFD state where required")

Signed-off-by: Adamos Ttofari <attofari@amazon.de>
---
 arch/x86/kernel/fpu/xstate.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 0bab497c9436..36ed27ac0ecd 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -179,8 +179,14 @@ void fpu__init_cpu_xstate(void)
 	 * key as that does not work on the boot CPU. This also ensures
 	 * that any stale state is wiped out from XFD.
 	 */
-	if (cpu_feature_enabled(X86_FEATURE_XFD))
-		wrmsrl(MSR_IA32_XFD, init_fpstate.xfd);
+	if (cpu_feature_enabled(X86_FEATURE_XFD)) {
+		u64 xfd;
+
+		rdmsrl(MSR_IA32_XFD, xfd);
+		__this_cpu_write(xfd_state, xfd);
+
+		xfd_update_state(&init_fpstate);
+	}
 
 	/*
 	 * XCR_XFEATURE_ENABLED_MASK (aka. XCR0) sets user features
@@ -915,7 +921,7 @@ void fpu__resume_cpu(void)
 	}
 
 	if (fpu_state_size_dynamic())
-		wrmsrl(MSR_IA32_XFD, current->thread.fpu.fpstate->xfd);
+		xfd_update_state(&init_fpstate);
 }
 
 /*
-- 
2.39.2




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



