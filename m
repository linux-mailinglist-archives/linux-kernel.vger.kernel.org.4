Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4994D6186CF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKCSAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbiKCR73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:59:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672FC2BC7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667498360; x=1699034360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EQQs2oxMSF89nE0NdVO0VqxxpugPawYi9iOrJgEYQNQ=;
  b=fQxmtkdqLVlYUQtPsURxuiyIf8W2S/AVNxtMigVguLW0bGGZvd7q5pq3
   ur6A4f9CaEZeu2LyHF4kh6lmv3UBXvVNRlccNjvJXhzFr5tSn5mGUsuKK
   6I1msJSoLFsE6lwGeLFslrxV9f+l+cPh71wIW59M5+m1rcMJptssygFcs
   /5S6rfE5FxyLWq4Mr8QKFfX3oHb6D72wfMhwu16dXVpdxHRXmO+qtshka
   T7icyB4rP0JJa0PCJgiuIfCwmAlB7Bk0rXhG2DDZaonTKNZoAy9AVUzEo
   o/2FEpn4ItWoLPsMTfAEj1qvqLexQmK6STAqzOhc3xE0XhKn+ZBKiP05g
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="308476966"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="308476966"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:59:18 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="809762547"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="809762547"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:59:17 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [v2 03/13] x86/microcode/intel: Fix a hang if early loading microcode fails
Date:   Thu,  3 Nov 2022 17:58:51 +0000
Message-Id: <20221103175901.164783-4-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103175901.164783-1-ashok.raj@intel.com>
References: <20221103175901.164783-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When early loading of microcode fails for any reason other than the wrong
family-model-stepping, Linux can get into an infinite loop retrying the
same failed load.

A single retry is needed to handle any mixed stepping case.

Assume we have a microcode that fails to load for some reason.
load_ucode_ap() seems to retry if the loading fails. But it searches for
a new rev, but ends up finding the same copy. Hence it appears to repeat
the same load, retry loop for ever.

load_ucode_intel_ap()
{
..
reget:
        if (!*iup) {
                patch = __load_ucode_intel(&uci);
		^^^^^ Finds the same patch every time.

                if (!patch)
                        return;

                *iup = patch;
        }

        uci.mc = *iup;

        if (apply_microcode_early(&uci, true)) {
	^^^^^^^^^^^^ apply fails
              /* Mixed-silicon system? Try to refetch the proper patch: */
              *iup = NULL;

              goto reget;
	      ^^^^^ Rince repeat.
        }

}

Fixes: 06b8534cb728 ("x86/microcode: Rework microcode loading")
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/cpu/microcode/intel.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 733b5eac0444..8ef04447fcf0 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -606,6 +606,7 @@ void __init load_ucode_intel_bsp(void)
 {
 	struct microcode_intel *patch;
 	struct ucode_cpu_info uci;
+	int rev, ret;
 
 	patch = __load_ucode_intel(&uci);
 	if (!patch)
@@ -613,13 +614,18 @@ void __init load_ucode_intel_bsp(void)
 
 	uci.mc = patch;
 
-	apply_microcode_early(&uci, true);
+	ret = apply_microcode_early(&uci, true);
+	if (ret) {
+		rev = patch->hdr.rev;
+		pr_err("Revision 0x%x failed during early loading\n", rev);
+	}
 }
 
 void load_ucode_intel_ap(void)
 {
 	struct microcode_intel *patch, **iup;
 	struct ucode_cpu_info uci;
+	bool retried = false;
 
 	if (IS_ENABLED(CONFIG_X86_32))
 		iup = (struct microcode_intel **) __pa_nodebug(&intel_ucode_patch);
@@ -638,9 +644,13 @@ void load_ucode_intel_ap(void)
 	uci.mc = *iup;
 
 	if (apply_microcode_early(&uci, true)) {
+		if (retried)
+			return;
+
 		/* Mixed-silicon system? Try to refetch the proper patch: */
 		*iup = NULL;
 
+		retried = true;
 		goto reget;
 	}
 }
-- 
2.34.1

