Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F3F7210EE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 17:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237123AbjFCPfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 11:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjFCPfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 11:35:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C425194;
        Sat,  3 Jun 2023 08:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685806509; x=1717342509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=59alQ36GnfZiWbiOj/6mr9HkoxqD3DcjLyz1IMSV1Bk=;
  b=ItxcU203tDi1MPA7M3Yr2Mpmyz17AbqLtqufhUdiv4NiCLsibBfw2VAX
   j3IwwNAAnt8V6XxOKcNgSlDqirUL0c+tL2ejGpzwOqbKSQlVhTItyRafZ
   kYlrr9jk7faq6c9CFjCSNCkJTV3mKnoY5E3llr0GN97vIPSg0MV7vUp8w
   0X630Bs9cVN0sn32syQ6eIipt+PU0x1DBrZmgbsffgRFJvBfqj5WPmEds
   mC2XlsBH8zPADwnEr4X3XiI254CkHFAbyTusFNGqvB2+8ZsIk5XBVhK/h
   BfrPWk9uNnHIuZYOpLa30ByIirwx/kh+6yU4NWe9970AHlRitPHzC89Ui
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="356097489"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="356097489"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2023 08:35:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="702274274"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="702274274"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga007.jf.intel.com with ESMTP; 03 Jun 2023 08:35:07 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com
Cc:     ebiggers@kernel.org, elliott@hpe.com, gmazyland@gmail.com,
        luto@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        bp@alien8.de, mingo@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au, ardb@kernel.org,
        dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com, nhuck@google.com,
        chang.seok.bae@intel.com, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org
Subject: [PATCH v8 09/12] x86/cpu: Add a configuration and command line option for Key Locker
Date:   Sat,  3 Jun 2023 08:22:24 -0700
Message-Id: <20230603152227.12335-10-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230603152227.12335-1-chang.seok.bae@intel.com>
References: <20230524165717.14062-1-chang.seok.bae@intel.com>
 <20230603152227.12335-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CONFIG_X86_KEYLOCKER to gate whether Key Locker is initialized at
boot. The option is selected by the Key Locker cipher module
CRYPTO_AES_KL (to be added in a later patch).

Add a new command line option "nokeylocker" to optionally override the
default CONFIG_X86_KEYLOCKER=y behavior.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v6:
* Rebase on the upstream: commit a894a8a56b57 ("Documentation:
  kernel-parameters: sort all "no..." parameters")

Changes from RFC v2:
* Make the option selected by CRYPTO_AES_KL. (Dan Williams)
* Massage the changelog and the config option description.
---
 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 arch/x86/Kconfig                                |  3 +++
 arch/x86/kernel/cpu/common.c                    | 16 ++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c1247ec4589a..b42fc53cbcf9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3749,6 +3749,8 @@
 			kernel and module base offset ASLR (Address Space
 			Layout Randomization).
 
+	nokeylocker     [X86] Disable Key Locker hardware feature.
+
 	no-kvmapf	[X86,KVM] Disable paravirtualized asynchronous page
 			fault handling.
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a98c5f82be48..f9788b477db1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1879,6 +1879,9 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
 
 	  If unsure, say y.
 
+config X86_KEYLOCKER
+	bool
+
 choice
 	prompt "TSX enable mode"
 	depends on CPU_SUP_INTEL
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 5882ff6e3c6b..718ff1b1d6dd 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -402,6 +402,22 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 static const unsigned long cr4_pinned_mask =
 	X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
 	X86_CR4_FSGSBASE | X86_CR4_CET;
+
+static __init int x86_nokeylocker_setup(char *arg)
+{
+	/* Expect an exact match without trailing characters. */
+	if (strlen(arg))
+		return 0;
+
+	if (!cpu_feature_enabled(X86_FEATURE_KEYLOCKER))
+		return 1;
+
+	setup_clear_cpu_cap(X86_FEATURE_KEYLOCKER);
+	pr_info("x86/keylocker: Disabled by kernel command line.\n");
+	return 1;
+}
+__setup("nokeylocker", x86_nokeylocker_setup);
+
 static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
 static unsigned long cr4_pinned_bits __ro_after_init;
 
-- 
2.17.1

