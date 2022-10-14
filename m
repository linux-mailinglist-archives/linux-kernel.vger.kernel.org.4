Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0AD5FF45A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiJNUK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiJNUJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:09:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C93460EE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665778180; x=1697314180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CBz/7lxJZaflX3sQlihmPqqyt+MkEvJf/otWozrj7fk=;
  b=V9KTCQuz8d9ofFEBI16HrYXUKXuVfvSanQ/KvBTH0SU2oE7ss4E92VDd
   BzTCUmh7Xhspu8WZcqQ4Fqi69sxBSpu1mXw16strCP13PMvbhQ/iEpWPk
   8sAN2quna93/ligMJAvM+FxzSVdD73MlN8CY7YL8SmKQbYGsfv051xynl
   3or7E98/0WUEot8QsXTtsw4IlDF+P9nNTAd3o7S6SlQBhjM5myRlh6u16
   MP4BA4ImxdkFHX+RTsWAIRIoHoRyx9GaYKNwT6AVYcVbVI8kpVeLF7hgL
   Dvutkg+9r59s9wX8+sGGgo+TBcxQoSPKJPGD2/jZg+sWLJhTfCMkTxqL+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="304202165"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="304202165"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 13:09:30 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="716870174"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="716870174"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 13:09:29 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH 12/13] x86/mce: Warn of a microcode update is in progress when MCE arrives
Date:   Fri, 14 Oct 2022 13:09:12 -0700
Message-Id: <20221014200913.14644-13-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221014200913.14644-1-ashok.raj@intel.com>
References: <20221014200913.14644-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the nature of microcode updates to long flow instructions, its
possible if an MCE is taken when microcode update is in progress could be
dangerous. There is nothing the kernel can do to mitigate safely.

Drop some bread crumbs to note that a MCE happened while a microcode update
is also in progress.

Suggested-by: Boris Petkov <bp@alien8.de>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/include/asm/microcode.h     | 1 +
 arch/x86/kernel/cpu/mce/core.c       | 5 +++++
 arch/x86/kernel/cpu/microcode/core.c | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 0c0bbc26560f..38b501d842de 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -41,6 +41,7 @@ struct ucode_patch {
 };
 
 extern struct list_head microcode_cache;
+extern int ucode_updating;
 
 struct cpu_signature {
 	unsigned int sig;
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2c8ec5c71712..1f05aec9880f 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -46,6 +46,7 @@
 #include <linux/hardirq.h>
 
 #include <asm/intel-family.h>
+#include <asm/microcode.h>
 #include <asm/processor.h>
 #include <asm/traps.h>
 #include <asm/tlbflush.h>
@@ -1425,6 +1426,10 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	else if (unlikely(!mca_cfg.initialized))
 		return unexpected_machine_check(regs);
 
+	instrumentation_begin();
+	if (unlikely(ucode_updating))
+		pr_warn("MCE triggered while microcode update is in progress\n");
+	instrumentation_end();
 	if (mce_flags.skx_repmov_quirk && quirk_skylake_repmov())
 		goto clear;
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index c6cd815190b1..eb2caa74de01 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -49,6 +49,8 @@ static bool dis_ucode_ldr = true;
 
 bool initrd_gone;
 
+int ucode_updating;
+
 LIST_HEAD(microcode_cache);
 
 /*
@@ -586,7 +588,9 @@ static int microcode_reload_late(void)
 		goto done;
 	}
 
+	ucode_updating = 1;
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
+	ucode_updating = 0;
 	if (ret == 0)
 		microcode_check();
 
-- 
2.34.1

