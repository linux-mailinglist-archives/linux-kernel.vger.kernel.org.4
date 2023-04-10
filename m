Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C636DCDD6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDJXMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjDJXLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:11:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B823F2699;
        Mon, 10 Apr 2023 16:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681168303; x=1712704303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=gGdT5ei86w9Hizyjm1aYXsjM9Us57NAQM61P97l7pFk=;
  b=mezJxstoAG2m6k/+UNrGcnTtbun9WK3YGF54kfGaeAOaCkE/yf+o2IA3
   1wejJBeqqW1XZg72EEU5xjFcOp4Zacn37KgHWbCD4oToBh4kCGkzmnWwP
   AJhC6uRX0lhV08NdSFfUKVuj1fM+5IJoYT5J2WGgWumBjiu22iY8WeA1M
   HY/PoqZ6G9OlSRqwYGqHHxB+ia4cJOoLfMgWx3CJgLLz8W8/RWj7TuswY
   TpEYb9vSQtVZJPA6Za6vTQmpV+SpQucbjJ28kIYcRsmdR8xifcBzvsIxa
   ksq7VTASCNZonqcZMQp//y+QwkM00Bsh0YvsuXuD5S9d5joL0RmRczpV4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="340962575"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="340962575"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 16:11:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="757608015"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="757608015"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga004.fm.intel.com with ESMTP; 10 Apr 2023 16:11:41 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com
Cc:     ebiggers@kernel.org, gmazyland@gmail.com, luto@kernel.org,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@suse.de,
        mingo@kernel.org, x86@kernel.org, herbert@gondor.apana.org.au,
        ardb@kernel.org, dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com, chang.seok.bae@intel.com,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org
Subject: [PATCH v6 09/12] x86/cpu: Add a configuration and command line option for Key Locker
Date:   Mon, 10 Apr 2023 15:59:33 -0700
Message-Id: <20230410225936.8940-10-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230410225936.8940-1-chang.seok.bae@intel.com>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20230410225936.8940-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CONFIG_X86_KEYLOCKER to gate whether Key Locker is initialized at boot.
The option is selected by the Key Locker cipher module CRYPTO_AES_KL (to be
added in a later patch).

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
Changes from RFC v2:
* Make the option selected by CRYPTO_AES_KL. (Dan Williams)
* Massage the changelog and the config option description.
---
 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 arch/x86/Kconfig                                |  3 +++
 arch/x86/kernel/cpu/common.c                    | 16 ++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5f2ec4b0f927..6534e6217e56 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3655,6 +3655,8 @@
 
 	nohugevmalloc	[KNL,X86,PPC,ARM64] Disable kernel huge vmalloc mappings.
 
+	nokeylocker	[X86] Disable Key Locker hardware feature.
+
 	nosmt		[KNL,S390] Disable symmetric multithreading (SMT).
 			Equivalent to smt=1.
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c94297369448..91f2063ab283 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1894,6 +1894,9 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
 
 	  If unsure, say y.
 
+config X86_KEYLOCKER
+	bool
+
 choice
 	prompt "TSX enable mode"
 	depends on CPU_SUP_INTEL
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a1edd5997e0a..c5550b8f030d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -419,6 +419,22 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
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

