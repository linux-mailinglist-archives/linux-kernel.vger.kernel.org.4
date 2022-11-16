Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADF562C5D4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbiKPREN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiKPREF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:04:05 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5FB31DDC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:03:54 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id gt15-20020a1709072d8f00b007aaac7973fbso10390198ejc.23
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0LlpT1W08zY22OCiDAwClvJgtb8njE0sgiclRnNk7ts=;
        b=IwxAxakegBQOgyJGsYpp+ASfbDtVEt5WMACVRGDXdmLQXiC8ZToNpp61u1Rm/tFx+M
         KxKmHNKOzX2sToMMDg91OZstw/12M6mKO7AHGymmTVGeafUcUG9Z12Mhzt3AoltQvZ8v
         T4TOR3SmN6ZmJbNbqO4V6jU5wLIMvMPc9IfXOqN0M7UEXssEKMCgK/3KdXb376zsAIlO
         HyDjwIJQ3V8DkhaZwLec5MmHcq05/zwgtm3lAJHgWGa+ATdLeeZlRO47UrkIeWQcypSz
         zznJZ1VpqxZ0KtBLMdLbaVvlK1E9gyXEabCpWdwF6nt4YIppsiEDvYFphlS43wH9RDOc
         Ia5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0LlpT1W08zY22OCiDAwClvJgtb8njE0sgiclRnNk7ts=;
        b=vKNUE+wVwlID6sjLHViSIQhOKl/i+RwMpVrG3V+kv9fq16S28g18n3yiOFOBfvKHz7
         V7Qva7GkrSOj1We5Gg68ce8HJP87O3CM9eYW/aHDsre7kzRhUoH08FerrZKf8twSZwVc
         X07t01rmlmNKZtUswNO6AAu38CjGBuRaShRlIUts6U02AiRqeXZGWXVf06Zv+Sq5QWrR
         I244YEBql2pww6FjjJS91MqCCAXDCyn/U29Z5BOTvbJp1DFBAXqoVAFcndK3/Q9HkQhd
         3KUKA/08SCabPNoUEdHtRpjpwEhVfrKpvbaYgf6NyLl10nejH0C5bBLu6kU4e2nxAKPH
         OLyw==
X-Gm-Message-State: ANoB5pnWlOKnLvfYW0P9nqI1T5Zx9MQnsiwbDAGxeZaNEu7awzjYBP4m
        na+8tcvox5gzGaDH2hvwPn3WK1rYlXzm
X-Google-Smtp-Source: AA0mqf7LiyM1OOZAZnzmGJvXdG5RpxJwLRiG734YUmTJYGUEmVuB0iMzwkb6TaTUw12Rf5eWxXiepqlITevJ
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a17:907:cc8a:b0:7ae:f6e8:2502 with SMTP id
 up10-20020a170907cc8a00b007aef6e82502mr12271658ejc.157.1668618233461; Wed, 16
 Nov 2022 09:03:53 -0800 (PST)
Date:   Wed, 16 Nov 2022 17:03:29 +0000
In-Reply-To: <20221116170335.2341003-1-qperret@google.com>
Mime-Version: 1.0
References: <20221116170335.2341003-1-qperret@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221116170335.2341003-7-qperret@google.com>
Subject: [PATCH 06/12] KVM: arm64: Allocate pages for hypervisor FF-A mailboxes
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andrew Walbran <qwandor@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        kernel-team@android.com, qperret@google.com
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

From: Will Deacon <will@kernel.org>

The FF-A proxy code needs to allocate its own buffer pair for
communication with EL3 and for forwarding calls from the host at EL1.

Reserve a couple of pages for this purpose and use them to initialise
the hypervisor's FF-A buffer structure.

Co-developed-by: Andrew Walbran <qwandor@google.com>
Signed-off-by: Andrew Walbran <qwandor@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pkvm.h     |  8 ++++++++
 arch/arm64/kvm/hyp/include/nvhe/ffa.h |  2 +-
 arch/arm64/kvm/hyp/nvhe/ffa.c         | 24 +++++++++++++++++++++++-
 arch/arm64/kvm/hyp/nvhe/setup.c       |  8 +++++++-
 arch/arm64/kvm/pkvm.c                 |  1 +
 5 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pkvm.h b/arch/arm64/include/asm/kvm_pkvm.h
index 01129b0d4c68..2b495ec59deb 100644
--- a/arch/arm64/include/asm/kvm_pkvm.h
+++ b/arch/arm64/include/asm/kvm_pkvm.h
@@ -106,4 +106,12 @@ static inline unsigned long host_s2_pgtable_pages(void)
 	return res;
 }
 
+#define KVM_FFA_MBOX_NR_PAGES	1
+
+static inline unsigned long hyp_ffa_proxy_pages(void)
+{
+	/* A page each for the hypervisor's RX and TX mailboxes. */
+	return 2 * KVM_FFA_MBOX_NR_PAGES;
+}
+
 #endif	/* __ARM64_KVM_PKVM_H__ */
diff --git a/arch/arm64/kvm/hyp/include/nvhe/ffa.h b/arch/arm64/kvm/hyp/include/nvhe/ffa.h
index 5c9b92430ff3..1becb10ecd80 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/ffa.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/ffa.h
@@ -11,7 +11,7 @@
 #define FFA_MIN_FUNC_NUM 0x60
 #define FFA_MAX_FUNC_NUM 0x7F
 
-int hyp_ffa_init(void);
+int hyp_ffa_init(void *pages);
 bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt);
 
 #endif /* __KVM_HYP_FFA_H */
diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index d199f868583e..7cb9095e00ff 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -28,8 +28,11 @@
 
 #include <linux/arm-smccc.h>
 #include <linux/arm_ffa.h>
+#include <asm/kvm_pkvm.h>
+
 #include <nvhe/ffa.h>
 #include <nvhe/trap_handler.h>
+#include <nvhe/spinlock.h>
 
 /*
  * "ID value 0 must be returned at the Non-secure physical FF-A instance"
@@ -37,6 +40,19 @@
  */
 #define HOST_FFA_ID	0
 
+struct kvm_ffa_buffers {
+	hyp_spinlock_t lock;
+	void *tx;
+	void *rx;
+};
+
+/*
+ * Note that we don't currently lock these buffers explicitly, instead
+ * relying on the locking of the host FFA buffers as we only have one
+ * client.
+ */
+static struct kvm_ffa_buffers hyp_buffers;
+
 static void ffa_to_smccc_error(struct arm_smccc_res *res, u64 ffa_errno)
 {
 	*res = (struct arm_smccc_res) {
@@ -162,7 +178,7 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt)
 	return true;
 }
 
-int hyp_ffa_init(void)
+int hyp_ffa_init(void *pages)
 {
 	struct arm_smccc_res res;
 
@@ -183,5 +199,11 @@ int hyp_ffa_init(void)
 	if (res.a2 != HOST_FFA_ID)
 		return -EINVAL;
 
+	hyp_buffers = (struct kvm_ffa_buffers) {
+		.lock	= __HYP_SPIN_LOCK_UNLOCKED,
+		.tx	= pages,
+		.rx	= pages + (KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE),
+	};
+
 	return 0;
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index c4ca174a0592..bb98630dfeaf 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -29,6 +29,7 @@ static void *vmemmap_base;
 static void *vm_table_base;
 static void *hyp_pgt_base;
 static void *host_s2_pgt_base;
+static void *ffa_proxy_pages;
 static struct kvm_pgtable_mm_ops pkvm_pgtable_mm_ops;
 static struct hyp_pool hpool;
 
@@ -58,6 +59,11 @@ static int divide_memory_pool(void *virt, unsigned long size)
 	if (!host_s2_pgt_base)
 		return -ENOMEM;
 
+	nr_pages = hyp_ffa_proxy_pages();
+	ffa_proxy_pages = hyp_early_alloc_contig(nr_pages);
+	if (!ffa_proxy_pages)
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -315,7 +321,7 @@ void __noreturn __pkvm_init_finalise(void)
 	if (ret)
 		goto out;
 
-	ret = hyp_ffa_init();
+	ret = hyp_ffa_init(ffa_proxy_pages);
 	if (ret)
 		goto out;
 
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index cf56958b1492..bb405e274df6 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -74,6 +74,7 @@ void __init kvm_hyp_reserve(void)
 	hyp_mem_pages += host_s2_pgtable_pages();
 	hyp_mem_pages += hyp_vm_table_pages();
 	hyp_mem_pages += hyp_vmemmap_pages(STRUCT_HYP_PAGE_SIZE);
+	hyp_mem_pages += hyp_ffa_proxy_pages();
 
 	/*
 	 * Try to allocate a PMD-aligned region to reduce TLB pressure once
-- 
2.38.1.431.g37b22c650d-goog

