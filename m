Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8A370FC5A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbjEXRKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 13:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235414AbjEXRKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:10:24 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F59ABB;
        Wed, 24 May 2023 10:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684948223; x=1716484223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+YuUSbnWKYlNrEuY9wZwu6rqIXV81jiJurK8saoa8ho=;
  b=PMF2gEbvIbagokWkViQWbp84stDhh3SsejV4F9LLuzMaPn+mDgsOdKzt
   KJOncQvORfliKZkoKh88CzQDGtSsx1X/RsF4uvzp/GFq14o0jxUwDy1+0
   09xjR88IQROTk1Iyume+rUoGf85PNoxHe15VQqBp3QZQcx0R3SPQzirhs
   sCTrEjHfpmalO3HQYI/mnIE5Y+s2WLs0yo+z+GYNksSi7Mw9pngHr0pEJ
   9Fv1nt0UlvKmLXdFGd29IQBvPqkAIErFEPymys68jHe+aHlkV2K6IgGpi
   oVgWK5BtUn40ahBxacgtB6ZNgsTKqY7wMcku/a4WBdJzdCj9eWQNa52cT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="338206726"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="338206726"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:09:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="704427352"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="704427352"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga002.jf.intel.com with ESMTP; 24 May 2023 10:09:53 -0700
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
        chang.seok.bae@intel.com, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v7 06/12] x86/keylocker: Define Key Locker CPUID leaf
Date:   Wed, 24 May 2023 09:57:11 -0700
Message-Id: <20230524165717.14062-7-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230524165717.14062-1-chang.seok.bae@intel.com>
References: <20230410225936.8940-1-chang.seok.bae@intel.com>
 <20230524165717.14062-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both Key Locker enabling code in the x86 core and AES Key Locker code
in the crypto library will need to reference some CPUID bits. Define
these feature-specific CPUID leaf and bits.

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
Changes from v6:
* Tweak the changelog -- comment the reason first and then brief the
  change.

Changes from RFC v2:
* Separate out the code as a new patch.
---
 arch/x86/include/asm/keylocker.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/keylocker.h b/arch/x86/include/asm/keylocker.h
index 9b3bec452b31..1717e0866254 100644
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

