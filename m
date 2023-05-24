Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECEB70FC5D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjEXRKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 13:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbjEXRKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:10:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B312212E;
        Wed, 24 May 2023 10:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684948222; x=1716484222;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=WDTSl+X1XPquNKqotXNY0s7uU9PS6vgLhf4WACna8JI=;
  b=WrlKRdicL43PumcC2o26eSslUaBSm0AYEGCDlCXP8q400wzmattc3dCt
   jHpMqFq6FJl0Tkte5iAnCNy98bpa6Qa+zpdEk+2JQNCSXrdUJNg+A8sMO
   1NGo+1kdK4Q29RlELyPUucFdayd3LoGEOYXwVKtHG6rsgviV8ehaXpHLg
   5AoE+DhgpCREP7dEpFCQoLxRtC3I+bh06Qoo9tmuA+wnku2UavW+9VnI/
   02CfwsnL08jkZ8D9/7BRIw48JhokZOtld5p0dnEXkkieeFzGWLylvqR2h
   k9V9HoqiZkhGCpamENpafujbQjPBigNcBkBCq7iZ13Rl5oAl5snfBfdWz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="338206713"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="338206713"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2023 10:09:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="704427349"
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="704427349"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga002.jf.intel.com with ESMTP; 24 May 2023 10:09:52 -0700
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
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v7 05/12] x86/msr-index: Add MSRs for Key Locker wrapping key
Date:   Wed, 24 May 2023 09:57:10 -0700
Message-Id: <20230524165717.14062-6-chang.seok.bae@intel.com>
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

The CPU state that contains the wrapping key is in the same power
domain as the cache. So any sleep state that would invalidate the
cache (like S3) also invalidates the state of the wrapping key.

But, since the state is inaccessible to software, it needs a special
mechanism to save and restore the key during deep sleep.

A set of new MSRs are provided as an abstract interface to save and
restore the wrapping key, and to check the key status. The wrapping
key is saved in a platform-scoped state of non-volatile media. The
backup itself and its path from the CPU are encrypted and integrity
protected.

Define those MSRs to be used to save and restore the key for S3/4
sleep states.

But the backup storage's non-volatility is not architecturally
guaranteed across off-states, such as S5 and G3. Then, the kernel may
generate a new key on the next boot.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v6:
* Tweak the changelog -- put the last for those about other sleep
  states

Changes from RFC v2:
* Update the changelog. (Dan Williams)
* Rename the MSRs. (Dan Williams)
---
 arch/x86/include/asm/msr-index.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3aedae61af4f..cd8555c0f3c2 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1117,4 +1117,10 @@
 						* a #GP
 						*/
 
+/* MSRs for managing a CPU-internal wrapping key for Key Locker. */
+#define MSR_IA32_IWKEY_COPY_STATUS		0x00000990
+#define MSR_IA32_IWKEY_BACKUP_STATUS		0x00000991
+#define MSR_IA32_BACKUP_IWKEY_TO_PLATFORM	0x00000d91
+#define MSR_IA32_COPY_IWKEY_TO_LOCAL		0x00000d92
+
 #endif /* _ASM_X86_MSR_INDEX_H */
-- 
2.17.1

