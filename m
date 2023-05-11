Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEC56FFD99
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 02:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239654AbjELAAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 20:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239696AbjEKX7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 19:59:42 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC158A7E
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 16:59:33 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-24e4531d571so5135547a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 16:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683849571; x=1686441571;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cjA+0mSTLh3yCMsGFKEfBNcNTT0A0nkYa87zKPgDSZA=;
        b=HN5fg1TcfLW1GSMIq1qurpY6RT1MqPzo8sehXms4OzfTNvmXjZfLujx3S1VqvYHNTY
         fIIVjvido5iXylJ1btxzXdDI8yd5o1+kGrYyGOSJE2KesbbdtMQhkuKjm4ZovfIhsPWg
         ttqpocKZBKrG2aXudd7T6pSdIqNvlURaLQV3R7GJ3KW7f/I1u6Dsj7LY3YIqabmJbYol
         3GCVV/ow1MWhY4j92o5CR+4Yu58vgJ7MWNjKyYV5Xp65FsZeurXCc8LiMx2MZoFCNBhx
         FGdOP0HpWUJGN91HXEGI9pCKp2yL+amhf7Y6f1vNXUCMAEUVVW2XUq0j9aiP8qZekuBe
         Giag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683849571; x=1686441571;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjA+0mSTLh3yCMsGFKEfBNcNTT0A0nkYa87zKPgDSZA=;
        b=e9xsZ2wAZ8OoiEXWBIp1kz5hWZ36kPDQNsSQkp68o508vbeTAfGydGFmH3XuO+y0aK
         wNlTGigMLhQorekXEcDFDtnAi6SZTCCdF8FaNAk6Xa48h1cATcl8uoCoEzE/8eyEX9Kw
         qIGVUMzrVZ4HRgMkgopoOWKb99MZdDRnWPxaq/nZQ3G1bHQP/ne83kNzwYqR92AvGkR1
         OE/ITN9MBMCB1VVFRyC08aKoya1P1/JTVwPg6CSuGompTXo2gg5kObI+198xIv0mVWYh
         o3YNNdRZ/VD65PIaWCh6o9hr4f8q8dupk1avL3v0pigiOGfOJOfy08+AX2j5kItQ9QpH
         6+kQ==
X-Gm-Message-State: AC+VfDxxcytpA0Kmi2b9H8YGZNe/2d0MIk1hz1a6Qbv1aSHgVfcuzwrG
        wkv9GyOzok0wI2kpCpBKKH/BbPN8c4I=
X-Google-Smtp-Source: ACHHUZ52hND3kQfsuqaR24n4SBVr5xhmzHxWfDp7/xsaI/5up5YSws+O7uE9UrE0UTjUIeaPSDpMjLAk8tE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:f989:b0:246:6a3a:6aec with SMTP id
 cq9-20020a17090af98900b002466a3a6aecmr6656579pjb.4.1683849571640; Thu, 11 May
 2023 16:59:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 11 May 2023 16:59:15 -0700
In-Reply-To: <20230511235917.639770-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230511235917.639770-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230511235917.639770-8-seanjc@google.com>
Subject: [PATCH 7/9] KVM: x86/mmu: Replace MMU_DEBUG with proper KVM_PROVE_MMU Kconfig
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mingwei Zhang <mizhang@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace MMU_DEBUG, which requires manually modifying KVM to enable the
macro, with a proper Kconfig, KVM_PROVE_MMU.  Now that pgprintk() and
rmap_printk() are gone, i.e. the macro guards only KVM_MMU_WARN_ON() and
won't flood the kernel logs, enabling the option for debug kernels is both
desirable and feasible.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/Kconfig            | 13 +++++++++++++
 arch/x86/kvm/mmu/mmu.c          |  4 ++--
 arch/x86/kvm/mmu/mmu_internal.h |  4 +---
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 8e578311ca9d..cccedb424324 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -139,6 +139,19 @@ config KVM_XEN
 
 	  If in doubt, say "N".
 
+config KVM_PROVE_MMU
+	bool "Prove KVM MMU correctness"
+	depends on DEBUG_KERNEL
+	depends on KVM
+	depends on EXPERT
+	help
+	  Enables runtime assertions in KVM's MMU that are too costly to enable
+	  in anything remotely resembling a production environment, e.g. this
+	  gates code that verifies a to-be-freed page table doesn't have any
+	  present SPTEs.
+
+	  If in doubt, say "N".
+
 config KVM_EXTERNAL_WRITE_TRACKING
 	bool
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 4731d2bf5af6..d209d466d58f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1686,7 +1686,7 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 	return young;
 }
 
-#ifdef MMU_DEBUG
+#ifdef CONFIG_KVM_PROVE_MMU
 static int is_empty_shadow_page(u64 *spt)
 {
 	u64 *pos;
@@ -1700,7 +1700,7 @@ static int is_empty_shadow_page(u64 *spt)
 		}
 	return 1;
 }
-#endif
+#endif /* CONFIG_KVM_PROVE_MMU */
 
 /*
  * This value is the sum of all of the kvm instances's
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index cfe925fefa68..40e74db6a7d5 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -6,9 +6,7 @@
 #include <linux/kvm_host.h>
 #include <asm/kvm_host.h>
 
-#undef MMU_DEBUG
-
-#ifdef MMU_DEBUG
+#ifdef CONFIG_KVM_PROVE_MMU
 #define KVM_MMU_WARN_ON(x) WARN_ON_ONCE(x)
 #else
 #define KVM_MMU_WARN_ON(x) do { } while (0)
-- 
2.40.1.606.ga4b1b128d6-goog

