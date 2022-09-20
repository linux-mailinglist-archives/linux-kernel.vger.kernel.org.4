Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104CF5BEEDA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 23:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiITVAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 17:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiITU7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:59:50 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614001EEFD
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:59:46 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id il18-20020a17090b165200b002038e81ee7dso4496183pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 13:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=S4qpE6/sC/2d5tmvyz+nC004gomHZT7yMkEkzcmn7Qs=;
        b=KV2g0Dz2GfX4x1uKEAkCQQa7hKSty51eB0dRokh3OTnSc0xKGaQhBCx1iIpBKg1PwU
         b4rsSl2/mCKYUGXMmkUjZaw1+cvIGFerbbJ750rAn2MM7c3WGfro3IwnMtNX0cq7NjiL
         KvijrB1cga2uRYOLcsWs0rXK//8D9fE9+UTxdo2cMQL6fa0YjVN90Lcqu9NPmvMQjoi0
         JNT8hWnsTPC96bQUxfUOnNBvGzs2eiAR3O65iScnH2dQf4XSP7bPWqrMskd9KbAiQ0LS
         zoeDakCySvufbmFwbn0n5RGu2F5Ug+PPRLIZ4gIMdLrRSRVCHsDyi90XFxL0vgbYL6Rp
         Nj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=S4qpE6/sC/2d5tmvyz+nC004gomHZT7yMkEkzcmn7Qs=;
        b=5GmgnP/djL2KDr2felcLawiMUCOVGls5ObnKiZg2LM+i8yGHUDl53U+2yubbNscNcu
         0qE2ekSR83vhiQXp7rSUxg8vkEuYN1ryPzchmrE9rrRv+P7OQARAVyJtdVxBP0jGZVKx
         qBTQScWBbLGcFzC/iO6nMg0h950aylEyll+3gPPQFV9/ykhmch13VVRH+zB4APmUkWfQ
         ped+LTfYzLGOJ9ZB+YATahGBYL2vZhOxUargju8b/Sk3FIPawhsY9+kc+7q7/AJRxak1
         tO9nm4Fo7oi17waxwy5/wexAPerBlpdHSbdNdXb7agR6bAUiII1jY9/jXhoeGqtGSjuS
         zShA==
X-Gm-Message-State: ACrzQf3paXWu1bEMSaVl/mbG+fEpmfHo4EySbtCLZoZEwdWfIRvycAXw
        +3Q2GxmRD4ClWQ3PRHEhBueyE7j5TYGG+g==
X-Google-Smtp-Source: AMsMyM4khVnbndZu+6w0/CQDpavnKKc4VO47ymIsUrhqLy7cu6/Jzmb1yK2mmcxqUEd1o0Kqll9ucz5Hd0gj8A==
X-Received: from loggerhead.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:29a])
 (user=jmattson job=sendgmr) by 2002:a05:6a00:1989:b0:546:410f:bdd2 with SMTP
 id d9-20020a056a00198900b00546410fbdd2mr25806289pfl.83.1663707585943; Tue, 20
 Sep 2022 13:59:45 -0700 (PDT)
Date:   Tue, 20 Sep 2022 13:59:21 -0700
In-Reply-To: <20220920205922.1564814-1-jmattson@google.com>
Mime-Version: 1.0
References: <20220920205922.1564814-1-jmattson@google.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220920205922.1564814-3-jmattson@google.com>
Subject: [PATCH v2 2/3] x86/cpufeatures: Introduce X86_FEATURE_NO_LMSLE
From:   Jim Mattson <jmattson@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
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
reference it when constructing a supported guest CPUID table.

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

