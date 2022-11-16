Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B696B62C5D6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbiKPREW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbiKPREG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:04:06 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCD1391F7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:03:57 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id v18-20020a056402349200b004622e273bbbso12863605edc.14
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dKmpRv9oYnAFUmNC2vB3bCF8nzlsd9JVBa/slHAfN6o=;
        b=CLgMgrrcH6xqRvc7dNBg0nJ8Wy/hwMjHvKv0ZdsqRx0VWo1ppcKFPZv2Vl4sa0XbtH
         /P+9e75YOS4CES7toeMWS2XqDGWw2Z3dMQdTpDFU4FAf1tVxHg+cuaMV7tj9ZMu+1OBg
         t03GWHD0qg+0WLX9IUBrp0PplHDIIjODI5JSf1ne+yIq5pX7WNxv/XcfUbmi4uPmiP46
         zo3d9hT6Mmqv4/GR8dFrNTdkA0OhSPHHFc/ja6tobeTaN4+SJDAYgxlvz5BifkAg8D66
         FTLFI4W7VlXvmtTFQVki2oNpx+mfi8yCGf3HOcE4PZfLM7CtWsjWfMS6WfWM2UNLipL4
         BD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dKmpRv9oYnAFUmNC2vB3bCF8nzlsd9JVBa/slHAfN6o=;
        b=UwVAKhEEZ1yZejbCoXpRPvuNJOcoNaAcH2V7VDvKddavijmo/bsBOfiEx3vji0CZ+W
         wVvHljOIkNwYlI81iSe1QfNKXKKgaosT1+YORizao4NHtSuWQ15aRZVL4N1bKB3PwSG/
         Su1inOobAFlZqsdT+WLaLDZ5s2GXWwLhKjm7pRByYL0EiLz2Fv+AUshA1WuGlnn2h3YK
         8yE0Vo5MMgxCRYaQW/UvBGBanayQwDCANYwsjIhSGLyl5lrmMGLgLeEoOvxrq0pgZ4f5
         ZRixcSvXohRqkxAh+6ZIiYaPjZITGU7xZaWDIuUPVR2wCuKmvZLyZl+Mdmwn+3Pc2eVW
         thxQ==
X-Gm-Message-State: ANoB5pnLMq/uAIRp+hLQ3v/cwLDYKN0yaxucrGQz7/ekR5J9TMlWwi8o
        XvVyipfYpf68U58VMLQ61AZbhrmMvHdq
X-Google-Smtp-Source: AA0mqf5Zh1E2Jq1JH4007iv1JNaQg8tonRvU0GAtnvQjndQkafqFq3DeYbzdetpEQAWaQCv6X1dKLc90yop4
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a05:6402:b61:b0:461:ed40:c2f2 with SMTP id
 cb1-20020a0564020b6100b00461ed40c2f2mr19383579edb.404.1668618235659; Wed, 16
 Nov 2022 09:03:55 -0800 (PST)
Date:   Wed, 16 Nov 2022 17:03:30 +0000
In-Reply-To: <20221116170335.2341003-1-qperret@google.com>
Mime-Version: 1.0
References: <20221116170335.2341003-1-qperret@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221116170335.2341003-8-qperret@google.com>
Subject: [PATCH 07/12] KVM: arm64: Handle FFA_RXTX_MAP and FFA_RXTX_UNMAP
 calls from the host
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

Handle FFA_RXTX_MAP and FFA_RXTX_UNMAP calls from the host by sharing
the host's mailbox memory with the hypervisor and establishing a
separate pair of mailboxes between the hypervisor and the SPMD at EL3.

Co-developed-by: Andrew Walbran <qwandor@google.com>
Signed-off-by: Andrew Walbran <qwandor@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 173 ++++++++++++++++++++++++++++++++++
 include/linux/arm_ffa.h       |   8 ++
 2 files changed, 181 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 7cb9095e00ff..8388cc901c97 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -31,6 +31,8 @@
 #include <asm/kvm_pkvm.h>
 
 #include <nvhe/ffa.h>
+#include <nvhe/mem_protect.h>
+#include <nvhe/memory.h>
 #include <nvhe/trap_handler.h>
 #include <nvhe/spinlock.h>
 
@@ -52,6 +54,7 @@ struct kvm_ffa_buffers {
  * client.
  */
 static struct kvm_ffa_buffers hyp_buffers;
+static struct kvm_ffa_buffers host_buffers;
 
 static void ffa_to_smccc_error(struct arm_smccc_res *res, u64 ffa_errno)
 {
@@ -71,6 +74,11 @@ static void ffa_to_smccc_res_prop(struct arm_smccc_res *res, int ret, u64 prop)
 	}
 }
 
+static void ffa_to_smccc_res(struct arm_smccc_res *res, int ret)
+{
+	ffa_to_smccc_res_prop(res, ret, 0);
+}
+
 static void ffa_set_retval(struct kvm_cpu_context *ctxt,
 			   struct arm_smccc_res *res)
 {
@@ -88,6 +96,140 @@ static bool is_ffa_call(u64 func_id)
 	       ARM_SMCCC_FUNC_NUM(func_id) <= FFA_MAX_FUNC_NUM;
 }
 
+static int spmd_map_ffa_buffers(u64 ffa_page_count)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_smc(FFA_FN64_RXTX_MAP,
+			  hyp_virt_to_phys(hyp_buffers.tx),
+			  hyp_virt_to_phys(hyp_buffers.rx),
+			  ffa_page_count,
+			  0, 0, 0, 0,
+			  &res);
+
+	return res.a0 == FFA_SUCCESS ? FFA_RET_SUCCESS : res.a2;
+}
+
+static int spmd_unmap_ffa_buffers(void)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_smc(FFA_RXTX_UNMAP,
+			  HOST_FFA_ID,
+			  0, 0, 0, 0, 0, 0,
+			  &res);
+
+	return res.a0 == FFA_SUCCESS ? FFA_RET_SUCCESS : res.a2;
+}
+
+static void do_ffa_rxtx_map(struct arm_smccc_res *res,
+			    struct kvm_cpu_context *ctxt)
+{
+	DECLARE_REG(phys_addr_t, tx, ctxt, 1);
+	DECLARE_REG(phys_addr_t, rx, ctxt, 2);
+	DECLARE_REG(u32, npages, ctxt, 3);
+	int ret = 0;
+	void *rx_virt, *tx_virt;
+
+	if (npages != (KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE) / FFA_PAGE_SIZE) {
+		ret = FFA_RET_INVALID_PARAMETERS;
+		goto out;
+	}
+
+	if (!PAGE_ALIGNED(tx) || !PAGE_ALIGNED(rx)) {
+		ret = FFA_RET_INVALID_PARAMETERS;
+		goto out;
+	}
+
+	hyp_spin_lock(&host_buffers.lock);
+	if (host_buffers.tx) {
+		ret = FFA_RET_DENIED;
+		goto out_unlock;
+	}
+
+	ret = spmd_map_ffa_buffers(npages);
+	if (ret)
+		goto out_unlock;
+
+	ret = __pkvm_host_share_hyp(hyp_phys_to_pfn(tx));
+	if (ret) {
+		ret = FFA_RET_INVALID_PARAMETERS;
+		goto err_unmap;
+	}
+
+	ret = __pkvm_host_share_hyp(hyp_phys_to_pfn(rx));
+	if (ret) {
+		ret = FFA_RET_INVALID_PARAMETERS;
+		goto err_unshare_tx;
+	}
+
+	tx_virt = hyp_phys_to_virt(tx);
+	ret = hyp_pin_shared_mem(tx_virt, tx_virt + 1);
+	if (ret) {
+		ret = FFA_RET_INVALID_PARAMETERS;
+		goto err_unshare_rx;
+	}
+
+	rx_virt = hyp_phys_to_virt(rx);
+	ret = hyp_pin_shared_mem(rx_virt, rx_virt + 1);
+	if (ret) {
+		ret = FFA_RET_INVALID_PARAMETERS;
+		goto err_unpin_tx;
+	}
+
+	host_buffers.tx = tx_virt;
+	host_buffers.rx = rx_virt;
+
+out_unlock:
+	hyp_spin_unlock(&host_buffers.lock);
+out:
+	ffa_to_smccc_res(res, ret);
+	return;
+
+err_unpin_tx:
+	hyp_unpin_shared_mem(tx_virt, tx_virt + 1);
+err_unshare_rx:
+	__pkvm_host_unshare_hyp(hyp_phys_to_pfn(rx));
+err_unshare_tx:
+	__pkvm_host_unshare_hyp(hyp_phys_to_pfn(tx));
+err_unmap:
+	spmd_unmap_ffa_buffers();
+	goto out_unlock;
+}
+
+static void do_ffa_rxtx_unmap(struct arm_smccc_res *res,
+			      struct kvm_cpu_context *ctxt)
+{
+	DECLARE_REG(u32, id, ctxt, 1);
+	int ret = 0;
+
+	if (id != HOST_FFA_ID) {
+		ret = FFA_RET_INVALID_PARAMETERS;
+		goto out;
+	}
+
+	hyp_spin_lock(&host_buffers.lock);
+	if (!host_buffers.tx) {
+		ret = FFA_RET_INVALID_PARAMETERS;
+		goto out_unlock;
+	}
+
+	hyp_unpin_shared_mem(host_buffers.tx, host_buffers.tx + 1);
+	WARN_ON(__pkvm_host_unshare_hyp(hyp_virt_to_pfn(host_buffers.tx)));
+	host_buffers.tx = NULL;
+
+	hyp_unpin_shared_mem(host_buffers.rx, host_buffers.rx + 1);
+	WARN_ON(__pkvm_host_unshare_hyp(hyp_virt_to_pfn(host_buffers.rx)));
+	host_buffers.rx = NULL;
+
+	spmd_unmap_ffa_buffers();
+
+out_unlock:
+	hyp_spin_unlock(&host_buffers.lock);
+out:
+	ffa_to_smccc_res(res, ret);
+}
+
 static bool ffa_call_unsupported(u64 func_id)
 {
 	switch (func_id) {
@@ -159,7 +301,11 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt)
 		goto out_handled;
 	/* Memory management */
 	case FFA_FN64_RXTX_MAP:
+		do_ffa_rxtx_map(&res, host_ctxt);
+		goto out_handled;
 	case FFA_RXTX_UNMAP:
+		do_ffa_rxtx_unmap(&res, host_ctxt);
+		goto out_handled;
 	case FFA_MEM_SHARE:
 	case FFA_FN64_MEM_SHARE:
 	case FFA_MEM_LEND:
@@ -181,6 +327,7 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt)
 int hyp_ffa_init(void *pages)
 {
 	struct arm_smccc_res res;
+	size_t min_rxtx_sz;
 
 	if (kvm_host_psci_config.smccc_version < ARM_SMCCC_VERSION_1_2)
 		return 0;
@@ -199,11 +346,37 @@ int hyp_ffa_init(void *pages)
 	if (res.a2 != HOST_FFA_ID)
 		return -EINVAL;
 
+	arm_smccc_1_1_smc(FFA_FEATURES, FFA_FN64_RXTX_MAP,
+			  0, 0, 0, 0, 0, 0, &res);
+	if (res.a0 != FFA_SUCCESS)
+		return -EOPNOTSUPP;
+
+	switch (res.a2) {
+	case FFA_FEAT_RXTX_MIN_SZ_4K:
+		min_rxtx_sz = SZ_4K;
+		break;
+	case FFA_FEAT_RXTX_MIN_SZ_16K:
+		min_rxtx_sz = SZ_16K;
+		break;
+	case FFA_FEAT_RXTX_MIN_SZ_64K:
+		min_rxtx_sz = SZ_64K;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (min_rxtx_sz > PAGE_SIZE)
+		return -EOPNOTSUPP;
+
 	hyp_buffers = (struct kvm_ffa_buffers) {
 		.lock	= __HYP_SPIN_LOCK_UNLOCKED,
 		.tx	= pages,
 		.rx	= pages + (KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE),
 	};
 
+	host_buffers = (struct kvm_ffa_buffers) {
+		.lock	= __HYP_SPIN_LOCK_UNLOCKED,
+	};
+
 	return 0;
 }
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index c87aeecaa9b2..b9f81035eb41 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -94,6 +94,14 @@
  */
 #define FFA_PAGE_SIZE		SZ_4K
 
+/*
+ * Minimum buffer size/alignment encodings returned by an FFA_FEATURES
+ * query for FFA_RXTX_MAP.
+ */
+#define FFA_FEAT_RXTX_MIN_SZ_4K		0
+#define FFA_FEAT_RXTX_MIN_SZ_64K	1
+#define FFA_FEAT_RXTX_MIN_SZ_16K	2
+
 /* FFA Bus/Device/Driver related */
 struct ffa_device {
 	int vm_id;
-- 
2.38.1.431.g37b22c650d-goog

