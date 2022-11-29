Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF25163CA16
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 22:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbiK2VJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 16:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236761AbiK2VJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:09:05 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04B8116E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 13:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669756143; x=1701292143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=niny0WNbiHjtWmixHGOged4GvvPKSLIrCEDitMSqwFg=;
  b=FNGLCYj4i35hwjjS1y6iTxBpIlA1agriDPHy8G085RPdNfJAa+sjV3gJ
   P3r+dyqGc/ted7IUccgk4LpdFB9kFI8YvC0YtVuaR4L4elTVFBqZ8duLw
   g/49BmxDFks4QNYHKpwsuMHIGeu8ehaCTTLrFeV5Lo98qhM4d3SRWw4AX
   Xf9Yb/csGF50Xn0s+663RGV0dF6rQgg4+GTmji2RlpOwjJ3QdGcs7hQHs
   0KxE55Inkp8NDjDaiyDQUIJTluZ6xqeXxly7GEoPeRVcwzmnV+om+eYPG
   t4VHr/JKKhH91EVI4CV9cHY7W+9Ftc3izQko18oNq+eJNLo3S6MqKfCi9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="317083127"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="317083127"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 13:09:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="646066201"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="646066201"
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
Subject: [Patch V1 1/7] x86/microcode/intel: Remove redundant microcode rev pr_info()s
Date:   Tue, 29 Nov 2022 13:08:26 -0800
Message-Id: <20221129210832.107850-2-ashok.raj@intel.com>
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

There is a pr_info() to dump information about newly loaded microcode.
The code intends this pr_info() to be just once, but the check to ensure
is racy. Unfortunately this happens quite often in with this new change
resulting in multiple redundant prints on the console.

microcode_init()->schedule_on_each_cpu(setup_online_cpu)->collect_cpu_info

[   33.688639] microcode: sig=0x50654, pf=0x80, revision=0x2006e05
[   33.688659] microcode: sig=0x50654, pf=0x80, revision=0x2006e05
[   33.688660] microcode: sig=0x50654, pf=0x80, revision=0x2006e05

There is already a pr_info() in microcode/core.c as shown below:

microcode: Reload completed, microcode revision: 0x2b000041 -> 0x2b000070

The sig and pf aren't that useful to end user, they are available via
/proc/cpuinfo and this never changes between microcode loads.

Remove the redundant pr_info() and the racy single print checks. This
removes the race entirely, zap the duplicated pr_info() spam and
simplify the code.

Fixes: b6f86689d5b7 ("x86/microcode: Rip out the subsys interface gunk")
Reported-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/cpu/microcode/intel.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index c4a00fb97f61..4f93875f57b4 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -554,7 +554,6 @@ void reload_ucode_intel(void)
 
 static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
 {
-	static struct cpu_signature prev;
 	struct cpuinfo_x86 *c = &cpu_data(cpu_num);
 	unsigned int val[2];
 
@@ -570,13 +569,6 @@ static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
 
 	csig->rev = c->microcode;
 
-	/* No extra locking on prev, races are harmless. */
-	if (csig->sig != prev.sig || csig->pf != prev.pf || csig->rev != prev.rev) {
-		pr_info("sig=0x%x, pf=0x%x, revision=0x%x\n",
-			csig->sig, csig->pf, csig->rev);
-		prev = *csig;
-	}
-
 	return 0;
 }
 
-- 
2.34.1

