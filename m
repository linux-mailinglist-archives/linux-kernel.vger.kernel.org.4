Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE32666BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 08:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbjALHoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 02:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbjALHoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:44:22 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1738340868
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 23:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673509462; x=1705045462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EzHVt8F1T8UDFhdzhWJ2zdQMQeqaau039K2A6FNKHcs=;
  b=mAvLoQyVTKwDKdAUWLMz6f2FKbFxhmYr5iHjufulz6biO6aLXFRqRqO3
   YnujjGjmM1JWKe8P4CR+6t9MmXazFbyNzwAM+YIrJGzAReruGzI2p2APf
   JQS7Bgmha7JQ30TOgwNb5/rnDZXcSqabpbKUCgtfFrLYc2P6/P8hH1zq4
   W7Pcjkq4CkcBv8XcEokcnO1pz0Urb+ug3jfFFDCSBzwFWkBfzTNt4ygw6
   ZR1E3ZivtNH7qwDFMW3A37MDEdYWLKd5Qmap2nreIs6jR1koRkWJxshxD
   IHTTLGN7NyfYgtdVwn5i9C2tYxU6w6gwpZ3Q6TdobjZH7/GUAJgtRprza
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="321328675"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="321328675"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 23:44:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="635283914"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="635283914"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by orsmga006.jf.intel.com with ESMTP; 11 Jan 2023 23:44:20 -0800
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        brgerst@gmail.com, chang.seok.bae@intel.com, jgross@suse.com
Subject: [PATCH v6 1/5] x86/cpufeature: add the cpu feature bit for LKGS
Date:   Wed, 11 Jan 2023 23:20:28 -0800
Message-Id: <20230112072032.35626-2-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230112072032.35626-1-xin3.li@intel.com>
References: <20230112072032.35626-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Add the CPU feature bit for LKGS (Load "Kernel" GS).

LKGS instruction is introduced with Intel FRED (flexible return and
event delivery) specification. Search for the latest FRED spec in most
search engines by doing:
site:intel.com FRED (flexible return and event delivery) specification

LKGS behaves like the MOV to GS instruction except that it loads
the base address into the IA32_KERNEL_GS_BASE MSR instead of the
GS segment’s descriptor cache, which is exactly what Linux kernel
does to load a user level GS base.  Thus, with LKGS, there is no
need to SWAPGS away from the kernel GS base.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---

Changes since v5:
* Recommend to search for the latest FRED spec instead of providing
  a FRED spec URL, which is likely to be unstable (Borislav Petkov).

Changes since v2:
* Add "" not to show "lkgs" in /proc/cpuinfo (Chang S. Bae).
---
 arch/x86/include/asm/cpufeatures.h       | 1 +
 tools/arch/x86/include/asm/cpufeatures.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 61012476d66e..4d93c60407fe 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -312,6 +312,7 @@
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
 #define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* "" CMPccXADD instructions */
+#define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) gs */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
 #define X86_FEATURE_AVX_IFMA            (12*32+23) /* "" Support for VPMADD52[H,L]UQ */
 
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 61012476d66e..4d93c60407fe 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -312,6 +312,7 @@
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
 #define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* "" CMPccXADD instructions */
+#define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) gs */
 #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
 #define X86_FEATURE_AVX_IFMA            (12*32+23) /* "" Support for VPMADD52[H,L]UQ */
 
-- 
2.34.1

