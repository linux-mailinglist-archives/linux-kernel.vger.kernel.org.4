Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E3E5F5E0C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 02:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJFAv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 20:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiJFAvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 20:51:42 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E7C46601
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 17:51:36 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id a20-20020a17090acb9400b0020aff595f9eso177086pju.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 17:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KXQHf4GGreclJV8UKG8o93Lp2p7h1XuOoBqM1BAPjfg=;
        b=MsxFUJnJbSr31qkjxrcQS41clk5/JoUKMdvBOwVkSaF+YTh6E39DA5Ov5XjXyxzv74
         GgpHQzEE1F9MUE+h6qnMxBLSo+RdoIBQwA4pICJTn+AH2MbIxuOTy4/RCskc2kChcZbK
         owZXXUOah/47VaAYjbLFEoDOuAR34Nm+rTKWPjG9FTYd/ZgSoHJYdTi06swsHJQRPSko
         /NwPDXQfmnSp683jgo3l/QjJ/nsFxLL5IZuPT1qYqEz3EvMWJC8nIsby4Hl9/kLHVaZD
         t1xO3UOa6hZ2H3Qi/pUtQkFOkfu3K1qHpIxLFhLMsWYyIYoYYBAf2lkJ7xclW7rSCTLt
         C/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXQHf4GGreclJV8UKG8o93Lp2p7h1XuOoBqM1BAPjfg=;
        b=EpQmvBBOWPSJ/HHUcuR3MM4VrFdp1YVgpAG/aksUkgDL1ZcRL/UjH3LaV9pwnm8GNr
         VRUjrRcB0IzL7g8mFM3jU2AgxG+PbPkONShNq6gQfVRBz7XT+lWUCAWF/VrbONvwAdQY
         rhQXA1ZyAxibQS1J47sG28QxjcZVAKSuHDnmJqAFRRbSfw+BMa0Z+g8BYTJYhW2iD6NN
         Qp1S5j/6vIgjsQcR83+CGVERNM8dj+RS+S3Alj0FdFi95UpId74RnX82LI76MeoO2zVH
         7hNIj8zMUoGbl1v7oosI5bVobGIAZLm/0EheDHJ/b+cnv8rGCPxR0CYUChakxOc7G5Gu
         H+Ug==
X-Gm-Message-State: ACrzQf3l32JpcEelKQa4jkF13DSpqcEAPyQwZQmXsb0x4qqEeYGrnqLa
        RKmXuAuNh8MuqdUGtU52UuUiuzWnv24=
X-Google-Smtp-Source: AMsMyM7OC3MEsHGB3Bg35pHH2zXARp4iXQExj7zSOZlcCvThVuxdWQkBKMUyTkqasS1rlmF0ClAmLoOPCHU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2412:b0:178:796d:c694 with SMTP id
 e18-20020a170903241200b00178796dc694mr2113381plo.42.1665017496375; Wed, 05
 Oct 2022 17:51:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  6 Oct 2022 00:51:18 +0000
In-Reply-To: <20221006005125.680782-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221006005125.680782-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006005125.680782-6-seanjc@google.com>
Subject: [PATCH 05/12] KVM: selftests: Refactor kvm_cpuid_has() to prep for
 X86_PROPERTY_* support
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
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

Refactor kvm_cpuid_has() to prepare for extending X86_PROPERTY_* support
to KVM as well as "this CPU".

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/lib/x86_64/processor.c      | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index fb9e90d25b60..30e8dfe2111e 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -700,8 +700,9 @@ const struct kvm_cpuid2 *kvm_get_supported_cpuid(void)
 	return cpuid;
 }
 
-bool kvm_cpuid_has(const struct kvm_cpuid2 *cpuid,
-		   struct kvm_x86_cpu_feature feature)
+static uint32_t __kvm_cpu_has(const struct kvm_cpuid2 *cpuid,
+			      uint32_t function, uint32_t index,
+			      uint8_t reg, uint8_t lo, uint8_t hi)
 {
 	const struct kvm_cpuid_entry2 *entry;
 	int i;
@@ -714,12 +715,18 @@ bool kvm_cpuid_has(const struct kvm_cpuid2 *cpuid,
 		 * order, but kvm_x86_cpu_feature matches that mess, so yay
 		 * pointer shenanigans!
 		 */
-		if (entry->function == feature.function &&
-		    entry->index == feature.index)
-			return (&entry->eax)[feature.reg] & BIT(feature.bit);
+		if (entry->function == function && entry->index == index)
+			return ((&entry->eax)[reg] & GENMASK(hi, lo)) >> lo;
 	}
 
-	return false;
+	return 0;
+}
+
+bool kvm_cpuid_has(const struct kvm_cpuid2 *cpuid,
+		   struct kvm_x86_cpu_feature feature)
+{
+	return __kvm_cpu_has(cpuid, feature.function, feature.index,
+			     feature.reg, feature.bit, feature.bit);
 }
 
 uint64_t kvm_get_feature_msr(uint64_t msr_index)
-- 
2.38.0.rc1.362.ged0d419d3c-goog

