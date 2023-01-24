Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD3567A348
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjAXTp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjAXTpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:45:23 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5CCDBF5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 11:45:22 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id om10-20020a17090b3a8a00b002299e350deaso11639321pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 11:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USNWk+Qxjgo3umRedhMn/QAIQIzxZYzD/tWnvSQKHkw=;
        b=r0FFBZVQjGwcJ1LQQs62+DYzdrhRTW+QrdEQLcWcstKwnpsxRyoCCM8TAQcWeVItSo
         jNhidYnB7IPneWrh2QRjojwjV7WEZ3a9ppWput8J3bg2yVWW6dQlppet/wqnRTdC4Ecz
         fFLVPncaFHsN3rkU7OV2nwO5hOJ31MRFGm3bnIPqQmoeDLT/hVPIkRgo5ABbHInkm1GI
         gPOyPIqjK3gej2ohT+U85PORkyLXpA2bkk1yEvjaxbXiA3kClmBhsomkvXl6S4/g3FJh
         hYJMPv9pnu153tdi6kSVLb6KJ34bq7CzbF/O+bhGWW+7KN5QVIy9LN1iN0PXmrTkma9L
         UrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=USNWk+Qxjgo3umRedhMn/QAIQIzxZYzD/tWnvSQKHkw=;
        b=MrYbtsAtHqb9J4GOwtH+5QthJfaEDu4pe2jcsLo4QANe4csHPKD20fUaLRRAt63LiZ
         NUSe/kMOZHEEfrYYOyXsOqA/iFeDfYm9nsCKbj0+jA0segBwa/A9Ihdp6ipSjG++/k2K
         +94CHzMtdozCsIoDGxDsA6wzt6lFCJzqSPM579f1vm4G7DHDouUJJBeosJJCXFE32lPV
         RJ4QnRFUHfwWbKv4HZiClob1pgdhp05P0FEPw/ejZiGGPSElK5r42j9vZOwNMQIeedat
         Y36SgnmCe2dYM3+4eSR5Oj80t02gc8NBE43y1Lgfs/UN9I9gvIMYEMmOInxp06gL7OMk
         akXw==
X-Gm-Message-State: AFqh2kp2X1RDfJWVVvifJwI5/XU1tVNfmbOssWT2BleaNS9/kwdd3pGj
        EHWPNLDhyLlFcTgxdj/QTE7BZqLTa4I=
X-Google-Smtp-Source: AMrXdXsnz8aqR5AF7+0mOZduumfT7i98bKywokhetIKEYIhxbfEUv4j/kXx51gTxEfaY5QazuCNvf1m7Jx0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:4c0b:b0:588:d6c1:66fd with SMTP id
 ea11-20020a056a004c0b00b00588d6c166fdmr3211713pfb.70.1674589521831; Tue, 24
 Jan 2023 11:45:21 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 24 Jan 2023 19:45:19 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230124194519.2893234-1-seanjc@google.com>
Subject: [PATCH] x86: KVM: Add common feature flag for AMD's PSFD
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a common X86_FEATURE_* flag for AMD's PSFD, and suppress it from
/proc/cpuinfo via the standard method of an empty string instead of
hacking in a one-off "private" #define in KVM.  The request that led to
KVM defining its own flag was really just that the feature not show up
in /proc/cpuinfo, and additional patches+discussions in the interim have
clarified that defining flags in cpufeatures.h purely so that KVM can
advertise features to userspace is ok so long as the kernel already uses
a word to track the associated CPUID leaf.

No functional change intended.

Link: https://lore.kernel.org/all/d1b1e0da-29f0-c443-6c86-9549bbe1c79d@redhat.como
Link: https://lore.kernel.org/all/YxGZH7aOXQF7Pu5q@nazgul.tnic
Link: https://lore.kernel.org/all/Y3O7UYWfOLfJkwM%2F@zn.tnic
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kvm/cpuid.c               | 8 +-------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 61012476d66e..2acaebc7bb76 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -330,6 +330,7 @@
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 #define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
 #define X86_FEATURE_CPPC		(13*32+27) /* Collaborative Processor Performance Control */
+#define X86_FEATURE_AMD_PSFD            (13*32+28) /* "" Predictive Store Forwarding Disable */
 #define X86_FEATURE_BTC_NO		(13*32+29) /* "" Not vulnerable to Branch Type Confusion */
 #define X86_FEATURE_BRS			(13*32+31) /* Branch Sampling available */
 
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 2a9f1e200dbc..fb2b0e3ecce1 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -59,12 +59,6 @@ u32 xstate_required_size(u64 xstate_bv, bool compacted)
 	return ret;
 }
 
-/*
- * This one is tied to SSB in the user API, and not
- * visible in /proc/cpuinfo.
- */
-#define KVM_X86_FEATURE_AMD_PSFD	(13*32+28) /* Predictive Store Forwarding Disable */
-
 #define F feature_bit
 
 /* Scattered Flag - For features that are scattered by cpufeatures.h. */
@@ -710,7 +704,7 @@ void kvm_set_cpu_caps(void)
 		F(CLZERO) | F(XSAVEERPTR) |
 		F(WBNOINVD) | F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) | F(VIRT_SSBD) |
 		F(AMD_SSB_NO) | F(AMD_STIBP) | F(AMD_STIBP_ALWAYS_ON) |
-		__feature_bit(KVM_X86_FEATURE_AMD_PSFD)
+		F(AMD_PSFD)
 	);
 
 	/*

base-commit: 7cb79f433e75b05d1635aefaa851cfcd1cb7dc4f
-- 
2.39.1.456.gfc5497dd1b-goog

