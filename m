Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848EF6638F1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 06:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjAJF5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 00:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbjAJF4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 00:56:19 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CFC3A1
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 21:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673330151; x=1704866151;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=4Rwgi+OKzj2DOZptaBAy1t4dcVeX1NSbFy3ySQuJdfs=;
  b=lOZAkj8TRLY+vA+brpUAZJ9/hla4vgGB4WjLEOUxXhtjifY0QNAXE1Ux
   SL+m5WpwZlHWH20Xi77XY5p6B+HVATgTKX/wnZvwX42rcOHUCykFCkCOA
   LiclG8a5Oq2xOFeXfOqJFU9c9/WAXyPz/0Su2fIziobVAk40hNT7ASdxa
   HZgWeQg62QGmfo9Nq8pVYGq6fyf1y1+ddxJpnQczwLqWGEv8ZgEshC+J9
   If6iRdFNayLA3OaoEDcEOvChrwRA4IzHp+HjE2Jd8H9vscGJ1Gps9tF6D
   N6zMivVa6yjiz55d/WwLwzU0SUr/HS3+rGE9/+Z44HbAKThnXK9meWnAT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="350289961"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="350289961"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 21:55:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="634483745"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="634483745"
Received: from oux.sc.intel.com ([10.3.52.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 21:55:40 -0800
From:   Yian Chen <yian.chen@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Paul Lai <paul.c.lai@intel.com>,
        Yian Chen <yian.chen@intel.com>
Subject: [PATCH 4/7] x86/vsyscall: Setup vsyscall to compromise LASS protection
Date:   Mon,  9 Jan 2023 21:52:01 -0800
Message-Id: <20230110055204.3227669-5-yian.chen@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230110055204.3227669-1-yian.chen@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel enables LASS automatically at starting time in LASS
capable platforms. Any access to kernel addresses
or upper half addresses from user space triggers a #GP
fault.

Legacy vsyscall does not comply with LASS, because
the vsyscall functions are mapped in the range
0xffffffffff600000-0xffffffffff601000.

In theory, it would be possible to write a #GP fault handler
to emulate the old vsyscall behavior, but vsyscall has been
deprecated for some time, so this has not been done.

Therefore, when kernel enforces LASS, vsyscall does not work
and should be disabled. On the other hand, the user can relax
the enforcement by clearing lass cpu id (clearcpuid=lass/390)
or enabling vsyscall (vsyscall=xxx) from kernel command line.
The user can also opt-out LASS in config file to build kernel
binary.

Signed-off-by: Yian Chen <yian.chen@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++----
 arch/x86/entry/vsyscall/vsyscall_64.c           | 14 ++++++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6cfa6e3996cf..3988e0c8c175 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6755,10 +6755,14 @@
 			versions of glibc use these calls.  Because these
 			functions are at fixed addresses, they make nice
 			targets for exploits that can control RIP.
-
-			emulate     [default] Vsyscalls turn into traps and are
-			            emulated reasonably safely.  The vsyscall
-				    page is readable.
+			In newer versions of Intel platforms that come with
+			LASS(Linear Address Space separation) protection,
+			vsyscall is disabled by default. Enabling vsyscall
+			via the parameter overrides LASS protection.
+
+			emulate     [default if not LASS capable] Vsyscalls
+				    turn into traps and are emulated reasonably
+				    safely.  The vsyscall page is readable.
 
 			xonly       Vsyscalls turn into traps and are
 			            emulated reasonably safely.  The vsyscall
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 4af81df133ee..2691f26835d1 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -63,6 +63,12 @@ static int __init vsyscall_setup(char *str)
 		else
 			return -EINVAL;
 
+		if (cpu_feature_enabled(X86_FEATURE_LASS) &&
+		    vsyscall_mode != NONE) {
+			setup_clear_cpu_cap(X86_FEATURE_LASS);
+			pr_warn("LASS disabled by command line enabling vsyscall\n");
+		}
+
 		return 0;
 	}
 
@@ -379,6 +385,14 @@ void __init map_vsyscall(void)
 	extern char __vsyscall_page;
 	unsigned long physaddr_vsyscall = __pa_symbol(&__vsyscall_page);
 
+	/*
+	 * When LASS is on, vsyscall triggers a #GP fault,
+	 * so that force vsyscall_mode to NONE.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_LASS)) {
+		vsyscall_mode = NONE;
+		return;
+	}
 	/*
 	 * For full emulation, the page needs to exist for real.  In
 	 * execute-only mode, there is no PTE at all backing the vsyscall
-- 
2.34.1

