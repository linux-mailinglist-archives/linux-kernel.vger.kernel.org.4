Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFF970967A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 13:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjESLZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 07:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjESLYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:24:49 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FBE10DC
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 04:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1684495485; x=1716031485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DJEkgdbDwAplEONKdRUjU0FV8ZN9Nm0azo2uUq8WYdE=;
  b=PD4e5jaYzygGbs4zCEkFLCb0Kcm4fRit4RhC26E9QmFovM2FvJjzSpoN
   8Jheg0b/ohnqpDtWeivWUukT30+tME03W+usN3WhZcghtvyPqZcKxPoiL
   K8YKhosBUYffxzwWfKnKEOYqRwaFdZG6Jh3xiI3zcZWdv23koOh3IWgQJ
   E=;
X-IronPort-AV: E=Sophos;i="6.00,176,1681171200"; 
   d="scan'208";a="333499146"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 11:24:40 +0000
Received: from EX19D002EUA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com (Postfix) with ESMTPS id 8480B40D3C;
        Fri, 19 May 2023 11:24:38 +0000 (UTC)
Received: from EX19D048EUC002.ant.amazon.com (10.252.61.160) by
 EX19D002EUA002.ant.amazon.com (10.252.50.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 19 May 2023 11:24:37 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D048EUC002.ant.amazon.com (10.252.61.160) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 19 May 2023 11:24:36 +0000
Received: from dev-dsk-attofari-1c-9e00ebdc.eu-west-1.amazon.com
 (10.13.242.123) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26 via Frontend Transport; Fri, 19 May 2023 11:24:34 +0000
From:   Adamos Ttofari <attofari@amazon.de>
To:     <chang.seok.bae@intel.com>, <tglx@linutronix.de>
CC:     <attofari@amazon.de>, <abusse@amazon.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Kyle Huey <me@kylehuey.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] x86: fpu: Keep xfd_state always in sync with MSR_IA32_XFD
Date:   Fri, 19 May 2023 11:23:12 +0000
Message-ID: <20230519112315.30616-1-attofari@amazon.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <87y1ltbtkh.ffs@tglx>
References: <87y1ltbtkh.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
MSR_IA32_XFD.

Fixes: 672365477ae8 ("x86/fpu: Update XFD state where required")

Signed-off-by: Adamos Ttofari <attofari@amazon.de>
---
 arch/x86/kernel/fpu/xstate.c |  5 +++--
 arch/x86/kernel/fpu/xstate.h | 14 ++++++++++----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 0bab497c9436..9bff4f07358d 100644
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



