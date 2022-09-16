Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3C85BA629
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 06:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiIPE7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 00:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiIPE6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 00:58:54 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD4E77550
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 21:58:54 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id z8-20020a17090a014800b001fac4204c7eso8987857pje.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 21:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=7KmHy9e59eVoSueoxg3f9FMizbHT1R3TBZY/FxQb18o=;
        b=S0kR8aRqGLfIuoWgSOPCbfay9hkfcmLaJTniiEy8SDMIt3AsSBj2kdLam9OSWlg/FA
         7CznN2UhCf9KQ1eIdy7rZKlSY5BSgQ9SYhGwBbT5xLDf0Xk82IVJcmo9zqzh3x0qhA+5
         XIyYGtQKLvlJs8tYP/FtjCXKQr88TIScLm43ZQZbh0nFoCxgh+WiNAWVi7EaULaljSJs
         dpw4KL/TYMyQJxOd7EksHiEFP7kHByD6FFdiUU8g62fhU5HUYIiCs+Z2D96prdBoUhLB
         ihG+zkzTaKW3wvp2YcweEab6HHxLdq32RMhqWlL1LHvqGoIQDccc8CO1zdRevLlvIGYb
         Bzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=7KmHy9e59eVoSueoxg3f9FMizbHT1R3TBZY/FxQb18o=;
        b=glUMyujqDB/A00QkvB/49E67DDDABtmtDmawErLNVDgxlU3ziTBbRcHuOw3I+M6N5k
         c/VRZGjEFOCCDAYwuKxAkSNwW+s/ehprkbM16chtEWAVDH2PQJEpli5TFXo9OCqRmXc8
         qaRxX6TXo82Vp3vK60jDfzxG/TfRP2iN5DEM96fERaXDRU7Wrd9E0aBDyFLQ3qr8r+2Q
         f9B5JptCsrj0OkC9Cg1uzsF+aTVCydkbatEqC3sayt83rCWi9Qbo/fKou2rz5L1m2Kee
         qbyATh0RD6qFSA3SY1sc19IqAczUiKtgD9OWVb+qI7bo7W8mR4g3W/SI5fqtyiW1oopk
         SsUA==
X-Gm-Message-State: ACrzQf04c+Ot0nyzvWuNGOvFbCvpZOglY0K2qyUWBI4rftOucaKxNbJW
        eddh/PUYKsU2rITMs6zd1wt2RuG/nfs7Tg==
X-Google-Smtp-Source: AMsMyM6vsC5QW2H5IDtqxbXq4QQ2j9p2rtYA2Rsx+YLBuIJm3SCXsGpJ4JdVKURzJ37B6CRXcLGs+UH/oA5vJA==
X-Received: from loggerhead.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:29a])
 (user=jmattson job=sendgmr) by 2002:a17:903:11d2:b0:172:6ea1:b6e6 with SMTP
 id q18-20020a17090311d200b001726ea1b6e6mr3047392plh.72.1663304333667; Thu, 15
 Sep 2022 21:58:53 -0700 (PDT)
Date:   Thu, 15 Sep 2022 21:58:28 -0700
In-Reply-To: <20220916045832.461395-1-jmattson@google.com>
Mime-Version: 1.0
References: <20220916045832.461395-1-jmattson@google.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220916045832.461395-2-jmattson@google.com>
Subject: [PATCH 1/5] x86/cpufeatures: Introduce X86_FEATURE_NO_LMSLE
From:   Jim Mattson <jmattson@google.com>
To:     Avi Kivity <avi@redhat.com>, Babu Moger <babu.moger@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joerg Roedel <joerg.roedel@amd.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wyes Karny <wyes.karny@amd.com>, x86@kernel.org
Cc:     Jim Mattson <jmattson@google.com>
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

When AMD introduced "Long Mode Segment Limit Enable" (a.k.a. "VMware
mode"), the feature was not enumerated by a CPUID bit. Now that VMware
has abandoned binary translation, AMD has deprecated EFER.LMSLE.

The absence of the feature *is* now enumerated by a CPUID bit (a la
Intel's X86_FEATURE_ZERO_FCS_DCS and X86_FEATURE_FDP_EXCPTN_ONLY).

This defeature bit is already present in feature word 13, but it was
previously anonymous. Name it X86_FEATURE_NO_LMSLE, so that KVM can
reference it when deciding whether or not EFER.LMSLE should be a
reserved bit in a KVM guest.

Since this bit indicates the absence of a feature, don't enumerate it
in /proc/cpuinfo.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index ef4775c6db01..0f5a3285d8d8 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -319,6 +319,7 @@
 #define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted Speculation */
 #define X86_FEATURE_AMD_STIBP		(13*32+15) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_AMD_STIBP_ALWAYS_ON	(13*32+17) /* "" Single Thread Indirect Branch Predictors always-on preferred */
+#define X86_FEATURE_NO_LMSLE		(13*32+20) /* "" EFER_LMSLE is unsupported */
 #define X86_FEATURE_AMD_PPIN		(13*32+23) /* Protected Processor Inventory Number */
 #define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
 #define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
-- 
2.37.3.968.ga6b4b080e4-goog

