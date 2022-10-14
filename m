Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A435FF458
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiJNUKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiJNUJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:09:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2FB31F8E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665778173; x=1697314173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2pjEdcguM+RaAzdUc4p+bz90Q4KG/RsiJEhTjRZleaQ=;
  b=npHVmWxfTdptITY47HoMqIntmM7g1nVijUfHg1VqaDEolGt0oKbtYJTN
   g1K+pfLj5hFMbMWojG4mOTozkHKVPi0AxjJ1h2hjyNhit9OpW1/HVlU8L
   fdLKTlDPVzU/3UA3XT3pQ58miwuEYF/WMmRgL7iBiiSIAjoJXq8SgDPkO
   C/TjI0IYNhkShJiYD6ECoIjN4TZoyY4zWsSPpfmVTbPZlMMSxUhI2agl6
   N7JItK5ldqimjAtQ9JAVMYYUZVsUjVG+QqlXeC87O/g4Q1dVZJLS46JKW
   e/SREhT00iqMtJebf1Ug9IwQWQrPRPtlVfrFJF7wBGH2ipHARi6qrrgUw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="304202163"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="304202163"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 13:09:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="716870168"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="716870168"
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
Subject: [PATCH 10/13] x86/microcode/intel: Drop wbinvd() from microcode loading
Date:   Fri, 14 Oct 2022 13:09:10 -0700
Message-Id: <20221014200913.14644-11-ashok.raj@intel.com>
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

Some older processors had a bad interaction when updating microcode if the
caches were dirty causing machine checks. The wbinvd() was added to
mitigate that before performing microcode updates. Now that Linux checks
for the minimum version before performing an update, those microcode
revisions can't be loaded. Remove calls to wbinvd().

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/kernel/cpu/microcode/intel.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index c8ee53fcf04d..c61aa661ac2f 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -541,11 +541,6 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 	}
 
 	old_rev = rev;
-	/*
-	 * Writeback and invalidate caches before updating microcode to avoid
-	 * internal issues depending on what the microcode is updating.
-	 */
-	native_wbinvd();
 
 	/* write microcode via MSR 0x79 */
 	native_wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
@@ -773,12 +768,6 @@ static enum ucode_state apply_microcode_intel(int cpu)
 		goto out;
 	}
 
-	/*
-	 * Writeback and invalidate caches before updating microcode to avoid
-	 * internal issues depending on what the microcode is updating.
-	 */
-	native_wbinvd();
-
 	/* write microcode via MSR 0x79 */
 	wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
-- 
2.34.1

