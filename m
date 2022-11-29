Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE5463CA17
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 22:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbiK2VJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 16:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236084AbiK2VJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:09:06 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7919F55A0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 13:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669756144; x=1701292144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CQp4qbII0DlxhRkqqCYEfCUWHdc6N9otPMAR1s7O/AM=;
  b=TY4QdO1TM6rxlpJvouVXEdRgnA/UyPI1zFZCbd17oChagrx9LnKEI4+E
   lJIvy7TrR0GpwxiMolddOJnTQ+Dhd/haAHRvG0jpqldFvtkLXZDSvSy4H
   LsrHNPpaRAFVN1Tn2Gud0+N+VGI9zxxLUVNrfuT1mwhSbIqFWb5/QwZe5
   BKD2OmNKM7IoTVcu4fH+k2+rUb6NknL0tPZkpnfRb7wRABSnZ/aLVM/oj
   Y2SH1cmJBGNIa8HqwzTXDEjUt99mT6shePwY+4IeX9hDAOcOWD3tVG7DJ
   SMX9T3Ri7/XUfo+wUquFOL/40HjsFNsQjLPonNbfF/KbT3+YD/LF4MMfo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="317083131"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="317083131"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 13:09:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="646066205"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="646066205"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 13:09:03 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, alison.schofield@intel.com,
        reinette.chatre@intel.com
Subject: [Patch V1 2/7] x86/microcode/intel: Remove retries on early microcode load
Date:   Tue, 29 Nov 2022 13:08:27 -0800
Message-Id: <20221129210832.107850-3-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221129210832.107850-1-ashok.raj@intel.com>
References: <20221129210832.107850-1-ashok.raj@intel.com>
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

Microcode loading can fail. This happens today when handling mixed
steppings. But it can also happen for other reasons such as corrupted
image, Security Version Number (SVN) preventing anti-rollback,
dependencies on BIOS loaded microcode image for some capabilities.

When the microcode loading fails, the kernel will quietly hang at boot.
This has been observed by end users (Links below) who had to revert their
microcode packages in order to boot again.

The hang is due to an infinite retry loop. The retries were in place to
support systems with mixed steppings. Now that mixed steppings are no
longer supported, there is only one microcode image at a time. Any retries
will simply reattempt to apply the same image over and over without making
progress.

Some possible past bugs that could be due to this bug are below.

There is no direct evidence that these end user issues were caused by this
retry loop. However, the early boot hangs along with reverting the
microcode update workaround provide strong circumstantial evidence to
support the theory that they are linked.

Remove the retry loop and only attempt to apply microcode once.

Link: https://bugs.launchpad.net/ubuntu/+source/intel-microcode/+bug/1911959
Link: https://forums.linuxmint.com/viewtopic.php?p=1827032#1827032
Link: https://askubuntu.com/questions/1291486/boot-crash-after-latest-update-of-intel-microcode-nov-11-2020
Fixes: 06b8534cb728 ("x86/microcode: Rework microcode loading")
Cc: stable@vger.kernel.org
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/cpu/microcode/intel.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 4f93875f57b4..d68b084a17e7 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -495,7 +495,6 @@ void load_ucode_intel_ap(void)
 	else
 		iup = &intel_ucode_patch;
 
-reget:
 	if (!*iup) {
 		patch = __load_ucode_intel(&uci);
 		if (!patch)
@@ -505,13 +504,7 @@ void load_ucode_intel_ap(void)
 	}
 
 	uci.mc = *iup;
-
-	if (apply_microcode_early(&uci, true)) {
-		/* Mixed-silicon system? Try to refetch the proper patch: */
-		*iup = NULL;
-
-		goto reget;
-	}
+	apply_microcode_early(&uci, true);
 }
 
 static struct microcode_intel *find_patch(struct ucode_cpu_info *uci)
-- 
2.34.1

