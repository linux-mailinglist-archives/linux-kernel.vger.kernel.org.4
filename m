Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878AE6DCDCB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjDJXLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjDJXLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:11:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA528210D;
        Mon, 10 Apr 2023 16:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681168301; x=1712704301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=JnGN/QzStCZJLTyrQM3ya368mjdTMP3eVWxv2wk0pgc=;
  b=HnwJ5GPCbD48vmZL4KHROKap7Qjx8FWF9mTTLFLXbMkDjHEYptk/xSgv
   WupexBecF/v/S4I6cBTIXfmsjDMOwXbqENbVHYcfuXKnxN618/D31FDWD
   Yb5UFLKfY5LaJA8uq5NOFRyuIJfyYy8VV+g7jQXEeuKrXi5+AIQBFe/xs
   sBh9+PidNRxVk6MoPfxFCTSNerAZrlbo78qip8L2+J4MJvCIjtENpTDwC
   7aBGzYNjgCxKinrcdyw/BlWQAWhgKwahtFf9sBjNL4inmzYBuKC5C4VcS
   SDpdIA+boDiVVx99SA+/3iv1LnOia1TiuvFU+nITLh1VdSJMrzbYdOMHW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="340962548"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="340962548"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 16:11:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="757608005"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="757608005"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga004.fm.intel.com with ESMTP; 10 Apr 2023 16:11:40 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com
Cc:     ebiggers@kernel.org, gmazyland@gmail.com, luto@kernel.org,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@suse.de,
        mingo@kernel.org, x86@kernel.org, herbert@gondor.apana.org.au,
        ardb@kernel.org, dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com, chang.seok.bae@intel.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v6 06/12] x86/keylocker: Define Key Locker CPUID leaf
Date:   Mon, 10 Apr 2023 15:59:30 -0700
Message-Id: <20230410225936.8940-7-chang.seok.bae@intel.com>
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

Define the feature-specific CPUID leaf and bits. Both Key Locker enabling
code in the x86 core and AES Key Locker code in the crypto library will
reference them.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from RFC v2:
* Separate out the code as a new patch.
---
 arch/x86/include/asm/keylocker.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/keylocker.h b/arch/x86/include/asm/keylocker.h
index df84c83228a1..e85dfb6c1524 100644
--- a/arch/x86/include/asm/keylocker.h
+++ b/arch/x86/include/asm/keylocker.h
@@ -5,6 +5,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/bits.h>
 #include <asm/fpu/types.h>
 
 /**
@@ -21,5 +22,11 @@ struct iwkey {
 	struct reg_128_bit encryption_key[2];
 };
 
+#define KEYLOCKER_CPUID			0x019
+#define KEYLOCKER_CPUID_EAX_SUPERVISOR	BIT(0)
+#define KEYLOCKER_CPUID_EBX_AESKLE	BIT(0)
+#define KEYLOCKER_CPUID_EBX_WIDE	BIT(2)
+#define KEYLOCKER_CPUID_EBX_BACKUP	BIT(4)
+
 #endif /*__ASSEMBLY__ */
 #endif /* _ASM_KEYLOCKER_H */
-- 
2.17.1

