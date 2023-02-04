Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1924768A7DD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 03:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjBDCmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 21:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjBDCl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 21:41:57 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F1A84B7B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 18:41:56 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id f15-20020a62380f000000b0058db55a8d7aso3591137pfa.21
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 18:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Eyl2Gk2q9T1eV7DI0p9mlIb5badihX418MuNkpKYmVo=;
        b=X+PPV3u2X+lZn6gVhql6yyg3YYD18L1CfE5YmtH30dolLF/MohybzVOpvnJB6DhBP2
         2wMUXINioM9SxHAybahNJuG4Sd8GIXZ43LUikBMqVcX2a2rJN/jgSGfvS9gTDmiCR1wU
         GWEc3RJMJnIoJ9+MJ06dhIYPfLk5mGwXF9fLq39fXHuX7tVu3wQ4SazrLSoDMHrBxfr6
         7sRZgbr7NgWbT/fqMnSMKzSxDvf380XFuSnqku8bkXMfHmihwzPh00nMLwa3RPOeu2+8
         ig8wNpMUagGEKSE+ZDeZl3Sp6NIvtwEvQrRWif03v8jpgCYao39junVVVs+1toqRnOzg
         Ivvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eyl2Gk2q9T1eV7DI0p9mlIb5badihX418MuNkpKYmVo=;
        b=RlulIcymDIPrazO8L0BXSvawDn/xzBbW3MND/NILQVzeunu5SlptN3AwGQahtw2d5p
         RFrq1tKa7YPFfB1V2DoL74CQF0/HSZpdj9GW+xggIOBxxMoUf2OBCV7NzHaekj+kNakx
         RkBExDRHivfgxwlVg8TSitijg+jDMusEjmYmlHYKXCV15CoC8uzbQHGaPHJOBzXSiXu0
         MMkAgv+PEgudQsVumFKj/hp/wf7ONIwjR5lxqyw0r/xCspBZNncIyYcmhhaIm4bkkXCp
         CXjPJhwWA8K7jAnrwUQLOYejFzJe455C9WF3aqp++hVFcQ+zjp5uJOmFc1hT8l7TC1b5
         xh8A==
X-Gm-Message-State: AO0yUKVEqU/KPHhfJUxtDLZv08IW6g9Axl37MVMaRByvawuuLPZMCGBI
        FqwsltRjanIhiy1tbsP5YnyKeNtbjvI=
X-Google-Smtp-Source: AK7set90nfjdbCTcrhj0tNGUc1jPfWUpaqVgb4EofrmYsOkqTBbxA9PgM7T1eMjDyE5iVxtC2ozEI8uUHm8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:9285:b0:22b:b89b:b9da with SMTP id
 n5-20020a17090a928500b0022bb89bb9damr1922344pjo.41.1675478516072; Fri, 03 Feb
 2023 18:41:56 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  4 Feb 2023 02:41:48 +0000
In-Reply-To: <20230204024151.1373296-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230204024151.1373296-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230204024151.1373296-2-seanjc@google.com>
Subject: [PATCH v2 1/4] KVM: selftests: Move the guts of kvm_hypercall() to a
 separate macro
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        David Woodhouse <dwmw@amazon.co.uk>
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

Extract the guts of kvm_hypercall() to a macro so that Xen hypercalls,
which have a different register ABI, can reuse the VMCALL vs. VMMCALL
logic.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/lib/x86_64/processor.c      | 29 +++++++++++--------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index ae1e573d94ce..ff901cb47ffc 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1139,21 +1139,26 @@ const struct kvm_cpuid_entry2 *get_cpuid_entry(const struct kvm_cpuid2 *cpuid,
 	return NULL;
 }
 
+#define X86_HYPERCALL(inputs...)					\
+({									\
+	uint64_t r;							\
+									\
+	asm volatile("test %[use_vmmcall], %[use_vmmcall]\n\t"		\
+		     "jnz 1f\n\t"					\
+		     "vmcall\n\t"					\
+		     "jmp 2f\n\t"					\
+		     "1: vmmcall\n\t"					\
+		     "2:"						\
+		     : "=a"(r)						\
+		     : [use_vmmcall] "r" (host_cpu_is_amd), inputs);	\
+									\
+	r;								\
+})
+
 uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
 		       uint64_t a3)
 {
-	uint64_t r;
-
-	asm volatile("test %[use_vmmcall], %[use_vmmcall]\n\t"
-		     "jnz 1f\n\t"
-		     "vmcall\n\t"
-		     "jmp 2f\n\t"
-		     "1: vmmcall\n\t"
-		     "2:"
-		     : "=a"(r)
-		     : "a"(nr), "b"(a0), "c"(a1), "d"(a2), "S"(a3),
-		       [use_vmmcall] "r" (host_cpu_is_amd));
-	return r;
+	return X86_HYPERCALL("a"(nr), "b"(a0), "c"(a1), "d"(a2), "S"(a3));
 }
 
 const struct kvm_cpuid2 *kvm_get_supported_hv_cpuid(void)
-- 
2.39.1.519.gcb327c4b5f-goog

