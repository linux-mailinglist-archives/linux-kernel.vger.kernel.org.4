Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A216662C5DC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiKPRFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238523AbiKPRES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:04:18 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB09930541
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:04:08 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id ga41-20020a1709070c2900b007aef14e8fd7so6348315ejc.21
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2vhL44LbdqOgVWXjYXs/R+RvrkDTc1nNNjhLxWfNq64=;
        b=B6euQx31O0Qq0+vxUxqnODx/Pwzm8Qx9pawx2tXdEdDThPUnR6HMP2/HGULWOE/FUC
         +Oy0YBrgjxYxb5kzYFHmq90YIs7TIwtUXvEB7my/htVFKE47pHMdkA+pmxu5ooG7Lr6T
         9NfrKAHk7yp6r2S1HjSM6Ie7C2K8vR+aoLJ+VHsRpYZjgR/SKD8MHNP+F75lrNRugapO
         zqmm0di5Q7hPXgcPl6QzaArBjBpQMmE7NIwWW3IVPbqbMhVhmvfi8qshBRhBHRceZMNL
         CU1eI4ypqprA6wRoShVZPmlmhFYzBeDyRy0EvvA7j6DH+fiHJ30q+RWRgq0gbzsmUnO3
         6xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vhL44LbdqOgVWXjYXs/R+RvrkDTc1nNNjhLxWfNq64=;
        b=dsISmIfEPbnSqOevB0rG1hqJI7XnYma9x0RQ1VqsQwAUP4dUpgfNNqaXxJWhvSeiLR
         jSgqzZ3qYyUHsVih6tFBZfpCWmUIonYJLAsLK8vuJh+xN6BE+IpwKpteuP39e4ONsIXD
         mtl4A1TuuEUFTcYK9EdL/2WtzdTilTDhOoqm6H1ZqEJNh77hsUSjtluS0CtwcRTGRkNP
         tev/uHxhz+NMp7GDp5RoyzYRqLfP3pqDfjZ01ST4IkCAYdezNM5HTJGuZHMwTMnzXQ0E
         riqnyuNerHRsZTIeRCj+GaJOBT2RU9p55HG8K4BNTZZscjVA8pT5CtJSbAcFyTwu0TCA
         /ucg==
X-Gm-Message-State: ANoB5pkg3EvquyM1RB4FKKrEVpXsbZvBmScNEBCAgcBVmC856AGp3S7+
        1Y8HmpCwwtxtxDBnU8EuSQ26+jJdc9pW
X-Google-Smtp-Source: AA0mqf7Ay9pVf6QGl4kascRHqizOu6UZH7SxIZ6c/5/pwuNM2DU6EdaPr04KCji+Os1eJo5HjZwu4tNxaoZp
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a50:ff04:0:b0:462:709:9f7b with SMTP id
 a4-20020a50ff04000000b0046207099f7bmr20712389edu.263.1668618247239; Wed, 16
 Nov 2022 09:04:07 -0800 (PST)
Date:   Wed, 16 Nov 2022 17:03:35 +0000
In-Reply-To: <20221116170335.2341003-1-qperret@google.com>
Mime-Version: 1.0
References: <20221116170335.2341003-1-qperret@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221116170335.2341003-13-qperret@google.com>
Subject: [PATCH 12/12] ANDROID: KVM: arm64: pkvm: Add support for fragmented
 FF-A descriptors
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

FF-A memory descriptors may need to be sent in fragments when they don't
fit in the mailboxes. Doing so involves using the FRAG_TX and FRAG_RX
primitives defined in the FF-A protocol.

Add support in the pKVM FF-A relayer for fragmented descriptors by
monitoring outgoing FRAG_TX transactions and by buffering large
descriptors on the reclaim path.

Co-developed-by: Andrew Walbran <qwandor@google.com>
Signed-off-by: Andrew Walbran <qwandor@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pkvm.h |  17 ++-
 arch/arm64/kvm/hyp/nvhe/ffa.c     | 170 +++++++++++++++++++++++++-----
 2 files changed, 161 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pkvm.h b/arch/arm64/include/asm/kvm_pkvm.h
index 2b495ec59deb..e46250a02017 100644
--- a/arch/arm64/include/asm/kvm_pkvm.h
+++ b/arch/arm64/include/asm/kvm_pkvm.h
@@ -6,7 +6,9 @@
 #ifndef __ARM64_KVM_PKVM_H__
 #define __ARM64_KVM_PKVM_H__
 
+#include <linux/arm_ffa.h>
 #include <linux/memblock.h>
+#include <linux/scatterlist.h>
 #include <asm/kvm_pgtable.h>
 
 /* Maximum number of VMs that can co-exist under pKVM. */
@@ -110,8 +112,19 @@ static inline unsigned long host_s2_pgtable_pages(void)
 
 static inline unsigned long hyp_ffa_proxy_pages(void)
 {
-	/* A page each for the hypervisor's RX and TX mailboxes. */
-	return 2 * KVM_FFA_MBOX_NR_PAGES;
+	size_t desc_max;
+
+	/*
+	 * The hypervisor FFA proxy needs enough memory to buffer a fragmented
+	 * descriptor returned from EL3 in response to a RETRIEVE_REQ call.
+	 */
+	desc_max = sizeof(struct ffa_mem_region) +
+		   sizeof(struct ffa_mem_region_attributes) +
+		   sizeof(struct ffa_composite_mem_region) +
+		   SG_MAX_SEGMENTS * sizeof(struct ffa_mem_region_addr_range);
+
+	/* Plus a page each for the hypervisor's RX and TX mailboxes. */
+	return (2 * KVM_FFA_MBOX_NR_PAGES) + DIV_ROUND_UP(desc_max, PAGE_SIZE);
 }
 
 #endif	/* __ARM64_KVM_PKVM_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 84024cba12ff..61003c3b6445 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -42,6 +42,18 @@
  */
 #define HOST_FFA_ID	0
 
+/*
+ * A buffer to hold the maximum descriptor size we can see from the host,
+ * which is required when the SPMD returns a fragmented FFA_MEM_RETRIEVE_RESP
+ * when resolving the handle on the reclaim path.
+ */
+struct kvm_ffa_descriptor_buffer {
+	void	*buf;
+	size_t	len;
+};
+
+static struct kvm_ffa_descriptor_buffer ffa_desc_buf;
+
 struct kvm_ffa_buffers {
 	hyp_spinlock_t lock;
 	void *tx;
@@ -122,6 +134,24 @@ static int spmd_unmap_ffa_buffers(void)
 	return res.a0 == FFA_SUCCESS ? FFA_RET_SUCCESS : res.a2;
 }
 
+static void spmd_mem_frag_tx(struct arm_smccc_res *res, u32 handle_lo,
+			     u32 handle_hi, u32 fraglen, u32 endpoint_id)
+{
+	arm_smccc_1_1_smc(FFA_MEM_FRAG_TX,
+			  handle_lo, handle_hi, fraglen, endpoint_id,
+			  0, 0, 0,
+			  res);
+}
+
+static void spmd_mem_frag_rx(struct arm_smccc_res *res, u32 handle_lo,
+			     u32 handle_hi, u32 fragoff)
+{
+	arm_smccc_1_1_smc(FFA_MEM_FRAG_RX,
+			  handle_lo, handle_hi, fragoff, HOST_FFA_ID,
+			  0, 0, 0,
+			  res);
+}
+
 static void spmd_mem_xfer(struct arm_smccc_res *res, u64 func_id, u32 len,
 			  u32 fraglen)
 {
@@ -323,6 +353,64 @@ static int ffa_host_unshare_ranges(struct ffa_mem_region_addr_range *ranges,
 	return ret;
 }
 
+static void do_ffa_mem_frag_tx(struct arm_smccc_res *res,
+			       struct kvm_cpu_context *ctxt)
+{
+	DECLARE_REG(u32, handle_lo, ctxt, 1);
+	DECLARE_REG(u32, handle_hi, ctxt, 2);
+	DECLARE_REG(u32, fraglen, ctxt, 3);
+	DECLARE_REG(u32, endpoint_id, ctxt, 4);
+	struct ffa_mem_region_addr_range *buf;
+	int ret = FFA_RET_INVALID_PARAMETERS;
+	u32 nr_ranges;
+
+	if (fraglen > KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE)
+		goto out;
+
+	if (fraglen % sizeof(*buf))
+		goto out;
+
+	hyp_spin_lock(&host_buffers.lock);
+	if (!host_buffers.tx)
+		goto out_unlock;
+
+	buf = hyp_buffers.tx;
+	memcpy(buf, host_buffers.tx, fraglen);
+	nr_ranges = fraglen / sizeof(*buf);
+
+	ret = ffa_host_share_ranges(buf, nr_ranges);
+	if (ret) {
+		/*
+		 * We're effectively aborting the transaction, so we need
+		 * to restore the global state back to what it was prior to
+		 * transmission of the first fragment.
+		 */
+		spmd_mem_reclaim(res, handle_lo, handle_hi, 0);
+		WARN_ON(res->a0 != FFA_SUCCESS);
+		goto out_unlock;
+	}
+
+	spmd_mem_frag_tx(res, handle_lo, handle_hi, fraglen, endpoint_id);
+	if (res->a0 != FFA_SUCCESS && res->a0 != FFA_MEM_FRAG_RX)
+		WARN_ON(ffa_host_unshare_ranges(buf, nr_ranges));
+
+out_unlock:
+	hyp_spin_unlock(&host_buffers.lock);
+out:
+	if (ret)
+		ffa_to_smccc_res(res, ret);
+
+	/*
+	 * If for any reason this did not succeed, we're in trouble as we have
+	 * now lost the content of the previous fragments and we can't rollback
+	 * the host stage-2 changes. The pages previously marked as shared will
+	 * remain stuck in that state forever, hence preventing the host from
+	 * sharing/donating them again and may possibly lead to subsequent
+	 * failures, but this will not compromise confidentiality.
+	 */
+	return;
+}
+
 static __always_inline void do_ffa_mem_xfer(const u64 func_id,
 					    struct arm_smccc_res *res,
 					    struct kvm_cpu_context *ctxt)
@@ -333,8 +421,8 @@ static __always_inline void do_ffa_mem_xfer(const u64 func_id,
 	DECLARE_REG(u32, npages_mbz, ctxt, 4);
 	struct ffa_composite_mem_region *reg;
 	struct ffa_mem_region *buf;
+	u32 offset, nr_ranges;
 	int ret = 0;
-	u32 offset;
 
 	BUILD_BUG_ON(func_id != FFA_FN64_MEM_SHARE &&
 		     func_id != FFA_FN64_MEM_LEND);
@@ -345,11 +433,6 @@ static __always_inline void do_ffa_mem_xfer(const u64 func_id,
 		goto out;
 	}
 
-	if (fraglen < len) {
-		ret = FFA_RET_ABORTED;
-		goto out;
-	}
-
 	if (fraglen < sizeof(struct ffa_mem_region) +
 		      sizeof(struct ffa_mem_region_attributes)) {
 		ret = FFA_RET_INVALID_PARAMETERS;
@@ -377,21 +460,26 @@ static __always_inline void do_ffa_mem_xfer(const u64 func_id,
 	}
 
 	reg = (void *)buf + offset;
-	if (fraglen < offset + sizeof(struct ffa_composite_mem_region) +
-		      reg->addr_range_cnt *
-		      sizeof(struct ffa_mem_region_addr_range)) {
+	nr_ranges = ((void *)buf + fraglen) - (void *)reg->constituents;
+	if (nr_ranges % sizeof(reg->constituents[0])) {
 		ret = FFA_RET_INVALID_PARAMETERS;
 		goto out_unlock;
 	}
 
-	ret = ffa_host_share_ranges(reg->constituents, reg->addr_range_cnt);
+	nr_ranges /= sizeof(reg->constituents[0]);
+	ret = ffa_host_share_ranges(reg->constituents, nr_ranges);
 	if (ret)
 		goto out_unlock;
 
 	spmd_mem_xfer(res, func_id, len, fraglen);
-	if (res->a0 != FFA_SUCCESS) {
-		WARN_ON(ffa_host_unshare_ranges(reg->constituents,
-						reg->addr_range_cnt));
+	if (fraglen != len) {
+		if (res->a0 != FFA_MEM_FRAG_RX)
+			goto err_unshare;
+
+		if (res->a3 != fraglen)
+			goto err_unshare;
+	} else if (res->a0 != FFA_SUCCESS) {
+		goto err_unshare;
 	}
 
 out_unlock:
@@ -400,6 +488,10 @@ static __always_inline void do_ffa_mem_xfer(const u64 func_id,
 	if (ret)
 		ffa_to_smccc_res(res, ret);
 	return;
+
+err_unshare:
+	WARN_ON(ffa_host_unshare_ranges(reg->constituents, nr_ranges));
+	goto out_unlock;
 }
 
 static void do_ffa_mem_reclaim(struct arm_smccc_res *res,
@@ -409,9 +501,9 @@ static void do_ffa_mem_reclaim(struct arm_smccc_res *res,
 	DECLARE_REG(u32, handle_hi, ctxt, 2);
 	DECLARE_REG(u32, flags, ctxt, 3);
 	struct ffa_composite_mem_region *reg;
+	u32 offset, len, fraglen, fragoff;
 	struct ffa_mem_region *buf;
 	int ret = 0;
-	u32 offset;
 	u64 handle;
 
 	handle = PACK_HANDLE(handle_lo, handle_hi);
@@ -429,11 +521,8 @@ static void do_ffa_mem_reclaim(struct arm_smccc_res *res,
 	if (res->a0 != FFA_MEM_RETRIEVE_RESP)
 		goto out_unlock;
 
-	/* Check for fragmentation */
-	if (res->a1 != res->a2) {
-		ret = FFA_RET_ABORTED;
-		goto out_unlock;
-	}
+	len = res->a1;
+	fraglen = res->a2;
 
 	offset = buf->ep_mem_access[0].composite_off;
 	/*
@@ -441,16 +530,36 @@ static void do_ffa_mem_reclaim(struct arm_smccc_res *res,
 	 * check that we end up with something that doesn't look _completely_
 	 * bogus.
 	 */
-	if (WARN_ON(offset > KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE)) {
+	if (WARN_ON(offset > len ||
+		    fraglen > KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE)) {
 		ret = FFA_RET_ABORTED;
 		goto out_unlock;
 	}
 
-	reg = (void *)buf + offset;
+	if (len > ffa_desc_buf.len) {
+		ret = FFA_RET_NO_MEMORY;
+		goto out_unlock;
+	}
+
+	buf = ffa_desc_buf.buf;
+	memcpy(buf, hyp_buffers.rx, fraglen);
+
+	for (fragoff = fraglen; fragoff < len; fragoff += fraglen) {
+		spmd_mem_frag_rx(res, handle_lo, handle_hi, fragoff);
+		if (res->a0 != FFA_MEM_FRAG_TX) {
+			ret = FFA_RET_INVALID_PARAMETERS;
+			goto out_unlock;
+		}
+
+		fraglen = res->a3;
+		memcpy((void *)buf + fragoff, hyp_buffers.rx, fraglen);
+	}
+
 	spmd_mem_reclaim(res, handle_lo, handle_hi, flags);
 	if (res->a0 != FFA_SUCCESS)
 		goto out_unlock;
 
+	reg = (void *)buf + offset;
 	/* If the SPMD was happy, then we should be too. */
 	WARN_ON(ffa_host_unshare_ranges(reg->constituents,
 					reg->addr_range_cnt));
@@ -549,7 +658,8 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt)
 		do_ffa_mem_xfer(FFA_FN64_MEM_LEND, &res, host_ctxt);
 		goto out_handled;
 	case FFA_MEM_FRAG_TX:
-		break;
+		do_ffa_mem_frag_tx(&res, host_ctxt);
+		goto out_handled;
 	}
 
 	if (!ffa_call_unsupported(func_id))
@@ -565,6 +675,7 @@ int hyp_ffa_init(void *pages)
 {
 	struct arm_smccc_res res;
 	size_t min_rxtx_sz;
+	void *tx, *rx;
 
 	if (kvm_host_psci_config.smccc_version < ARM_SMCCC_VERSION_1_2)
 		return 0;
@@ -605,10 +716,21 @@ int hyp_ffa_init(void *pages)
 	if (min_rxtx_sz > PAGE_SIZE)
 		return -EOPNOTSUPP;
 
+	tx = pages;
+	pages += KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE;
+	rx = pages;
+	pages += KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE;
+
+	ffa_desc_buf = (struct kvm_ffa_descriptor_buffer) {
+		.buf	= pages,
+		.len	= PAGE_SIZE *
+			  (hyp_ffa_proxy_pages() - (2 * KVM_FFA_MBOX_NR_PAGES)),
+	};
+
 	hyp_buffers = (struct kvm_ffa_buffers) {
 		.lock	= __HYP_SPIN_LOCK_UNLOCKED,
-		.tx	= pages,
-		.rx	= pages + (KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE),
+		.tx	= tx,
+		.rx	= rx,
 	};
 
 	host_buffers = (struct kvm_ffa_buffers) {
-- 
2.38.1.431.g37b22c650d-goog

