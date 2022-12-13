Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D39A64AF9F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 07:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbiLMGJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 01:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbiLMGJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 01:09:23 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171BC1AD80
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 22:09:22 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id md9-20020a17090b23c900b00218fa3308a9so1317925pjb.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 22:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=vIlOHydaCh0ao3eFY0wKJPSpCdXFKH/dETpychmunOk=;
        b=VPMI9+ZU1BsAAUUeJUhhb/vSZ0K6O7FxmmGujRXdbsYFdCthw2opRpUDUo05tgMl7/
         UAXsgfaJIDtdQjv0gQWhKHu7t1Kb3ZKBGBmDp8R+/uaRObMKKI/qIHywslWfBcWugzQn
         X74V27+dpXTJKwaD3we+FcosDS3oA++Kx3Y5XTdoNLdjVoW+r5wWOm1m3KrNXUi79VnS
         pQXShGI/HjzdNdcN2abo9e0E6uGUbGF6MR8/oAW1BUnD3OnSR4SgSNWgY3ti+j7/SNLo
         ffA6rdN9rF8+xRcUjWLRIXuiBPJyLExE6DrezUnktN5GHRdKPbbIcG+J/VJARYXR7x58
         lk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vIlOHydaCh0ao3eFY0wKJPSpCdXFKH/dETpychmunOk=;
        b=YhVqOJYzqYYWlxBDH5SPtQ7L2gM88fwa7xpBySIQWv6CAvydWDYv6sHkjPMh4epIRs
         I4cXnOCD1TNgp+Vo08y7ncby5fcosK3FCv77bJM6lwE4t/HWuyy6ja/LUUxltPxOP16V
         vivV48+1GCjncFbgXVqdPtFOt8c8eJIbxhGDUKsl5vnFvc3h6aGhR0kNFQThRckqqmak
         hiUEaY9FPEhtD4aKcuti4+dDwfZx9RM3ut7ai9DXBGF+bFjauynlIZvblOVWl0nqUz/0
         AXyGa9YrikIA8c9TxgbV8nI8CTMrGiTWSfoXRLIamVir+DPztaD8Kgg0o7WslS4Iws0w
         J/nw==
X-Gm-Message-State: ANoB5plrYGcBWFS7DcMIqWQmmBNCTOvx5pTqqTkucbzA5wAiPHke1BWp
        iP8xA3lXDLbUFNKRr+1m5uSz17CxQ+4=
X-Google-Smtp-Source: AA0mqf4OZ8bwKNFcvO4cMdVPaYXvqgT+KB2K18aKoB1pDt/JKnnFLVYK8XvS1wDohZTUf7y+iIpDvVlrKBE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:181:b0:189:8f11:f2f with SMTP id
 z1-20020a170903018100b001898f110f2fmr53434946plg.133.1670911761544; Mon, 12
 Dec 2022 22:09:21 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Dec 2022 06:09:08 +0000
In-Reply-To: <20221213060912.654668-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221213060912.654668-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221213060912.654668-4-seanjc@google.com>
Subject: [PATCH 3/7] KVM: VMX: Always inline eVMCS read/write helpers
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tag all evmcs_{read,write}() helpers __always_inline so that they can be
freely used in noinstr sections, e.g. to get the VM-Exit reason in
vcpu_vmx_enter_exit() (in a future patch).  For consistency and to avoid
more spot fixes in the future, e.g. see commit 010050a86393 ("x86/kvm:
Always inline evmcs_write64()"), tag all accessors even though
evmcs_read32() is the only anticipated use case in the near future.  In
practice, non-KASAN builds are all but guaranteed to inline the helpers
anyways.

  vmlinux.o: warning: objtool: vmx_vcpu_enter_exit+0x107: call to evmcs_read32()
                               leaves .noinstr.text section

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/hyperv.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/vmx/hyperv.h b/arch/x86/kvm/vmx/hyperv.h
index 571e7929d14e..3f4049e4f35d 100644
--- a/arch/x86/kvm/vmx/hyperv.h
+++ b/arch/x86/kvm/vmx/hyperv.h
@@ -136,7 +136,7 @@ static __always_inline void evmcs_write64(unsigned long field, u64 value)
 	current_evmcs->hv_clean_fields &= ~clean_field;
 }
 
-static inline void evmcs_write32(unsigned long field, u32 value)
+static __always_inline void evmcs_write32(unsigned long field, u32 value)
 {
 	u16 clean_field;
 	int offset = get_evmcs_offset(field, &clean_field);
@@ -148,7 +148,7 @@ static inline void evmcs_write32(unsigned long field, u32 value)
 	current_evmcs->hv_clean_fields &= ~clean_field;
 }
 
-static inline void evmcs_write16(unsigned long field, u16 value)
+static __always_inline void evmcs_write16(unsigned long field, u16 value)
 {
 	u16 clean_field;
 	int offset = get_evmcs_offset(field, &clean_field);
@@ -160,7 +160,7 @@ static inline void evmcs_write16(unsigned long field, u16 value)
 	current_evmcs->hv_clean_fields &= ~clean_field;
 }
 
-static inline u64 evmcs_read64(unsigned long field)
+static __always_inline u64 evmcs_read64(unsigned long field)
 {
 	int offset = get_evmcs_offset(field, NULL);
 
@@ -170,7 +170,7 @@ static inline u64 evmcs_read64(unsigned long field)
 	return *(u64 *)((char *)current_evmcs + offset);
 }
 
-static inline u32 evmcs_read32(unsigned long field)
+static __always_inline u32 evmcs_read32(unsigned long field)
 {
 	int offset = get_evmcs_offset(field, NULL);
 
@@ -180,7 +180,7 @@ static inline u32 evmcs_read32(unsigned long field)
 	return *(u32 *)((char *)current_evmcs + offset);
 }
 
-static inline u16 evmcs_read16(unsigned long field)
+static __always_inline u16 evmcs_read16(unsigned long field)
 {
 	int offset = get_evmcs_offset(field, NULL);
 
@@ -213,11 +213,11 @@ static inline void evmcs_load(u64 phys_addr)
 
 #else /* !IS_ENABLED(CONFIG_HYPERV) */
 static __always_inline void evmcs_write64(unsigned long field, u64 value) {}
-static inline void evmcs_write32(unsigned long field, u32 value) {}
-static inline void evmcs_write16(unsigned long field, u16 value) {}
-static inline u64 evmcs_read64(unsigned long field) { return 0; }
-static inline u32 evmcs_read32(unsigned long field) { return 0; }
-static inline u16 evmcs_read16(unsigned long field) { return 0; }
+static __always_inline void evmcs_write32(unsigned long field, u32 value) {}
+static __always_inline void evmcs_write16(unsigned long field, u16 value) {}
+static __always_inline u64 evmcs_read64(unsigned long field) { return 0; }
+static __always_inline u32 evmcs_read32(unsigned long field) { return 0; }
+static __always_inline u16 evmcs_read16(unsigned long field) { return 0; }
 static inline void evmcs_load(u64 phys_addr) {}
 static inline void evmcs_touch_msr_bitmap(void) {}
 #endif /* IS_ENABLED(CONFIG_HYPERV) */
-- 
2.39.0.rc1.256.g54fd8350bd-goog

