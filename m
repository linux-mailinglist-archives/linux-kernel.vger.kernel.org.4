Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F76562C5DA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238787AbiKPREz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbiKPRES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:04:18 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608202BB33
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:04:06 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id g14-20020a056402090e00b0046790cd9082so8535335edz.21
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UNHIEymVb+XSzDMRY7di2ZGqPLVkyCRzgk1tuxxw7oc=;
        b=ULXXfyFHyQ/ZzVkyLWpxN5DnlpcorBmr7G0YcKEPr2b2mJrX39TIEN9HZ6c0hZDTyx
         329LbDpAKIwekVtzcha75hsVu8Si4bfwJSXe0h7d+t4hQpqKu9yAKDCX0EnQbqn9YLgg
         2Ytm/pKNd6sLkdxUelG6cKU40fEj5vr55vNfLdGYzj9cGjcnS7iFPT6ZfNxCEM1kt0IL
         ngAYqkkEAFKLCS7zC2p+Hd94ACzVr4mUJK6MBaN9BBcH3DaZbgMK73RRoJAG3fXExPE6
         f+egV7/6COHJt96CMB21bc8wKQPQsqc0pI5ORROQnC8W2U5V53bGpF760O2bosKDghWD
         RQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UNHIEymVb+XSzDMRY7di2ZGqPLVkyCRzgk1tuxxw7oc=;
        b=rKXakPIpjm6hBHpV+N58SKuRqiFmsAwWC5fUFYW9T+rYFNowsXg5JAzTtS/uINkjOo
         gRB7vHA1f1M/1AmNcyX8Hnt/ssQViAB5XYosGryyJOvHbCzhgioCvSfYAlOml9+zyT5z
         uESyDfP6L8H5K9MXuxckM+4ZD3gkmspNOLvHlUJiTQ0uX/Nd2BBVkeRS63+QAhgIwjVr
         hkngqxBIt7TXB7udz7t8fhPxwip4FlktHDeTJkr1kPswR2rIBEaZ+WSHHOhLHd+oTd0i
         Fzc051s6H5MsgM12LhPvVWLcSm5GQz6gjz8fnxP8j4KzGwXxahDhKWJmLs3KIxrAw6Ho
         5FNA==
X-Gm-Message-State: ANoB5plRYbpq8wnMUePJhUvnWwrOM1q0eteTDqG/xVMNsyWGOKN3SAR2
        tVutBdeTvOgiYsbc+wIEZuQuEjUViYWc
X-Google-Smtp-Source: AA0mqf7bePVxvTek80mJF7MvMu/XjAXSSdk17HBMIgnsABCOlR0Jqni4M2Ms2XVeDVgnHMr7E43fgsMQt7X3
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a50:d790:0:b0:461:7fe6:9ea7 with SMTP id
 w16-20020a50d790000000b004617fe69ea7mr19716772edi.94.1668618244971; Wed, 16
 Nov 2022 09:04:04 -0800 (PST)
Date:   Wed, 16 Nov 2022 17:03:34 +0000
In-Reply-To: <20221116170335.2341003-1-qperret@google.com>
Mime-Version: 1.0
References: <20221116170335.2341003-1-qperret@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221116170335.2341003-12-qperret@google.com>
Subject: [PATCH 11/12] KVM: arm64: Handle FFA_MEM_LEND calls from the host
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

Handle FFA_MEM_LEND calls from the host by treating them identically to
FFA_MEM_SHARE calls for the purposes of the host stage-2 page-table, but
forwarding on the original request to EL3.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 8f690b80af60..84024cba12ff 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -122,10 +122,10 @@ static int spmd_unmap_ffa_buffers(void)
 	return res.a0 == FFA_SUCCESS ? FFA_RET_SUCCESS : res.a2;
 }
 
-static void spmd_mem_share(struct arm_smccc_res *res, u32 len, u32 fraglen)
+static void spmd_mem_xfer(struct arm_smccc_res *res, u64 func_id, u32 len,
+			  u32 fraglen)
 {
-	arm_smccc_1_1_smc(FFA_FN64_MEM_SHARE,
-			  len, fraglen,
+	arm_smccc_1_1_smc(func_id, len, fraglen,
 			  0, 0, 0, 0, 0,
 			  res);
 }
@@ -323,8 +323,9 @@ static int ffa_host_unshare_ranges(struct ffa_mem_region_addr_range *ranges,
 	return ret;
 }
 
-static void do_ffa_mem_share(struct arm_smccc_res *res,
-			     struct kvm_cpu_context *ctxt)
+static __always_inline void do_ffa_mem_xfer(const u64 func_id,
+					    struct arm_smccc_res *res,
+					    struct kvm_cpu_context *ctxt)
 {
 	DECLARE_REG(u32, len, ctxt, 1);
 	DECLARE_REG(u32, fraglen, ctxt, 2);
@@ -335,6 +336,9 @@ static void do_ffa_mem_share(struct arm_smccc_res *res,
 	int ret = 0;
 	u32 offset;
 
+	BUILD_BUG_ON(func_id != FFA_FN64_MEM_SHARE &&
+		     func_id != FFA_FN64_MEM_LEND);
+
 	if (addr_mbz || npages_mbz || fraglen > len ||
 	    fraglen > KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE) {
 		ret = FFA_RET_INVALID_PARAMETERS;
@@ -384,7 +388,7 @@ static void do_ffa_mem_share(struct arm_smccc_res *res,
 	if (ret)
 		goto out_unlock;
 
-	spmd_mem_share(res, len, fraglen);
+	spmd_mem_xfer(res, func_id, len, fraglen);
 	if (res->a0 != FFA_SUCCESS) {
 		WARN_ON(ffa_host_unshare_ranges(reg->constituents,
 						reg->addr_range_cnt));
@@ -535,13 +539,15 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt)
 		goto out_handled;
 	case FFA_MEM_SHARE:
 	case FFA_FN64_MEM_SHARE:
-		do_ffa_mem_share(&res, host_ctxt);
+		do_ffa_mem_xfer(FFA_FN64_MEM_SHARE, &res, host_ctxt);
 		goto out_handled;
 	case FFA_MEM_RECLAIM:
 		do_ffa_mem_reclaim(&res, host_ctxt);
 		goto out_handled;
 	case FFA_MEM_LEND:
 	case FFA_FN64_MEM_LEND:
+		do_ffa_mem_xfer(FFA_FN64_MEM_LEND, &res, host_ctxt);
+		goto out_handled;
 	case FFA_MEM_FRAG_TX:
 		break;
 	}
-- 
2.38.1.431.g37b22c650d-goog

