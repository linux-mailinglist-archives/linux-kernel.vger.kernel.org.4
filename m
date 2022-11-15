Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AA162A446
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbiKOVjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238816AbiKOVjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:39:00 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB472871B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:38:56 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k7-20020a256f07000000b006cbcc030bc8so14331632ybc.18
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aQ7ZnbgmkJrVlWH5xbfOVSLuvcBscmBcOHFm+u9P9Is=;
        b=ab3uRPKYkSxn/QjpN1So1yF1Z1NN2PYbkpgY8mGVjPzZ9MqLZaGWAVnsdWE2RsXjEc
         8El0iBvxFpuy6viBm2Pm7wUcr+FJHIA2Wsw8Yvg1dmPT7dAY1ezhWWTpdWHpyRYCM8kY
         A5Ejqaam5XT87aJsHHP5vsZEPik7JgXJkqgeu/AMlfWWqw8e3BgDtTdB9AKMjB16m50c
         UIikOys1nEgQQMR5T6jK0mylJFSMO2EeW1WmF7exlaik5bq7UQqSYurk5yF14puo5rMg
         XzgXo100/d1jQrL63t9IhZctr/AGW5/NI/PsirTxQT1Fcnk9tDrNSXRn94cFyTUp4+qF
         qZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQ7ZnbgmkJrVlWH5xbfOVSLuvcBscmBcOHFm+u9P9Is=;
        b=z63CM8CMFaF16vJm/2Q8yb9TsE89doOAa/P9DLIGjE0w8YUH9Ee5awRDeHFCDxTyXo
         NPLRWM1rxq1XXZSdxThHNkZG/P/1okMOhpew011eWvROSsnsnD6xSvyN0HPRaTKE/YeG
         TcPYPgVwpYJpdyGYtlZDcXYkaCQ6ouwdKtXqa9shM1weBPddYibII9Me1xjE8T688xSP
         vwwy+3ayD9jvckKYBP4ZzINo5PscB2xJWi+0ZCS/qa+/S9BHnE2zf+WRQItppGStiCOk
         MmABX8gH38+zVjnQ3beWzenN0vw5l3K7Wh7ThI9EdDopZwOKz6SfBZnPyCRWTkZrDF4s
         0c0Q==
X-Gm-Message-State: ANoB5pkIdJ2Pvy3wLcPJqdsGiFhyxzdysWffGtuzSjIazRZt1ogShqgD
        TCVMruCImLHTW6umCrExWVKLTLqZp/UQKyrj
X-Google-Smtp-Source: AA0mqf44WZQSn2ofSKhxuYlXbV0gsnelihomPaefr5UbU5tGVPfiQ4QL7tIx01rfuoC7phPo9KvKtDEV0YERWjyx
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a81:1c41:0:b0:36a:31c2:7acb with SMTP
 id c62-20020a811c41000000b0036a31c27acbmr20565473ywc.426.1668548335967; Tue,
 15 Nov 2022 13:38:55 -0800 (PST)
Date:   Tue, 15 Nov 2022 21:38:45 +0000
In-Reply-To: <20221115213845.3348210-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221115213845.3348210-1-vannapurve@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221115213845.3348210-4-vannapurve@google.com>
Subject: [V4 PATCH 3/3] KVM: selftests: Add arch specific post vm creation hook
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, shuah@kernel.org, bgardon@google.com,
        seanjc@google.com, oupton@google.com, peterx@redhat.com,
        vkuznets@redhat.com, dmatlack@google.com, pgonda@google.com,
        andrew.jones@linux.dev, Vishal Annapurve <vannapurve@google.com>
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

Add arch specific API kvm_arch_vm_post_create to perform any required setup
after VM creation.

Suggested-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
Reviewed-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util_base.h | 4 ++++
 tools/testing/selftests/kvm/lib/kvm_util.c          | 9 ++++++---
 tools/testing/selftests/kvm/lib/x86_64/processor.c  | 6 ++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index eec0e4898efe..1e7d3eae8c91 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -843,4 +843,8 @@ static inline int __vm_disable_nx_huge_pages(struct kvm_vm *vm)
  */
 void kvm_selftest_arch_init(void);
 
+/*
+ * API to execute architecture specific setup after creating the VM.
+ */
+void kvm_arch_vm_post_create(struct kvm_vm *vm);
 #endif /* SELFTEST_KVM_UTIL_BASE_H */
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index deb4c731b9fa..3ed72980c996 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -340,9 +340,8 @@ struct kvm_vm *__vm_create(enum vm_guest_mode mode, uint32_t nr_runnable_vcpus,
 
 	kvm_vm_elf_load(vm, program_invocation_name);
 
-#ifdef __x86_64__
-	vm_create_irqchip(vm);
-#endif
+	kvm_arch_vm_post_create(vm);
+
 	return vm;
 }
 
@@ -2022,6 +2021,10 @@ void __vm_get_stat(struct kvm_vm *vm, const char *stat_name, uint64_t *data,
 	}
 }
 
+__weak void kvm_arch_vm_post_create(struct kvm_vm *vm)
+{
+}
+
 __weak void kvm_selftest_arch_init(void)
 {
 }
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 39c4409ef56a..fa65e8142c16 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1327,3 +1327,9 @@ bool vm_is_unrestricted_guest(struct kvm_vm *vm)
 
 	return get_kvm_intel_param_bool("unrestricted_guest");
 }
+
+
+void kvm_arch_vm_post_create(struct kvm_vm *vm)
+{
+	vm_create_irqchip(vm);
+}
-- 
2.38.1.431.g37b22c650d-goog

