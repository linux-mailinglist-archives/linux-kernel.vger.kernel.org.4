Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2AB62C5CF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbiKPREJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbiKPRDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:03:54 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8A42C66E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:03:51 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j132-20020a25238a000000b006da635e2073so16462991ybj.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IGAnxq8TxsaiJ4rE+mUN7BVSpa7cDNjlDGASV4bWpCs=;
        b=WJwAIwpyllGWtU5Y33F3Liqf/YIvtoOmru97wtImoiBp3Nn+xEqI6tv0y2+K8Y7cd8
         YfsCJHf+g7pz4Ql+A0xh0aj+hrJ3JREtrpdk3cKf9lbVimZUCy1iAsJ5cwZHBLNJRolK
         5jQqTJEtMgZ86xyOJjcSpBktYOO7HT4+lfBK2eT41evfRAQV5Cf+m1iZqzrGhPIW8RVp
         aEvLZXtdDp8b0NVmT8T9eYdv5M0+GP80sE6m6X621AVRDbLPf0YYJdjQI5PwhOf6h3Kz
         88A+3FNo2ZLDA3i4G6zrNrfv1BzdATpngxJnltogw/VIaQjQM3T2MaxhaGjR9j0UuV7A
         0l0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGAnxq8TxsaiJ4rE+mUN7BVSpa7cDNjlDGASV4bWpCs=;
        b=w9FBY+bOmNM9aLYG49FHoNhJdBObDOGGEvOyLp7IrI7WQ6XA1ad4gyV5c0aZK9aOB5
         z7Vp18sRjoaKG3x28HV06isevTIFSYOJzJ1dVlelt1XtRpldkAg2RP0+YKN5rNsaEaat
         29CK+s7qVxaiEsWrtCKK2l5TKiUwrvskuQOtjIJ2cb8e7Ak0NVZkIGb6oA4i5CEOoa5y
         v7JSTE/6hQFIVpw+XySIbrRetwNwgsfZ7t77e3K0KYDyrZsvfavLgpvF2DLzbTrfUuUi
         8bmxonOY3kU0b8RlG/jpk9ASRMg9X80It8zYS0R/okd25EZ0/TePElR+xkdNJ8kFcHDA
         1rVw==
X-Gm-Message-State: ACrzQf16P4lI+XkeMPVw0XnNZbEoa5X6BzODVrAcK7evKjpTthjD+r3U
        N/7IRFok/P/DK4DKNteLTzydXUNn+/g+
X-Google-Smtp-Source: AMsMyM6LpibcCa3tAvXcPcc9JdUaf9/9fnPypWpp5sDfstjX9mSh84f9tOoNKg6gUA/4AaKj5a/N2Zknhusm
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a0d:f647:0:b0:36f:f93c:c543 with SMTP id
 g68-20020a0df647000000b0036ff93cc543mr60967412ywf.325.1668618230643; Wed, 16
 Nov 2022 09:03:50 -0800 (PST)
Date:   Wed, 16 Nov 2022 17:03:28 +0000
In-Reply-To: <20221116170335.2341003-1-qperret@google.com>
Mime-Version: 1.0
References: <20221116170335.2341003-1-qperret@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221116170335.2341003-6-qperret@google.com>
Subject: [PATCH 05/12] KVM: arm64: Handle FFA_FEATURES call from the host
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

From: Fuad Tabba <tabba@google.com>

Filter out advertising unsupported features, and only advertise
features and properties that are supported by the hypervisor proxy.

Signed-off-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 44 +++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 969d72390844..d199f868583e 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -45,6 +45,16 @@ static void ffa_to_smccc_error(struct arm_smccc_res *res, u64 ffa_errno)
 	};
 }
 
+static void ffa_to_smccc_res_prop(struct arm_smccc_res *res, int ret, u64 prop)
+{
+	if (ret == FFA_RET_SUCCESS) {
+		*res = (struct arm_smccc_res) { .a0 = FFA_SUCCESS,
+						.a2 = prop };
+	} else {
+		ffa_to_smccc_error(res, ret);
+	}
+}
+
 static void ffa_set_retval(struct kvm_cpu_context *ctxt,
 			   struct arm_smccc_res *res)
 {
@@ -89,6 +99,35 @@ static bool ffa_call_unsupported(u64 func_id)
 	return false;
 }
 
+static bool do_ffa_features(struct arm_smccc_res *res,
+			    struct kvm_cpu_context *ctxt)
+{
+	DECLARE_REG(u32, id, ctxt, 1);
+	u64 prop = 0;
+	int ret = 0;
+
+	if (ffa_call_unsupported(id)) {
+		ret = FFA_RET_NOT_SUPPORTED;
+		goto out_handled;
+	}
+
+	switch (id) {
+	case FFA_MEM_SHARE:
+	case FFA_FN64_MEM_SHARE:
+	case FFA_MEM_LEND:
+	case FFA_FN64_MEM_LEND:
+		ret = FFA_RET_SUCCESS;
+		prop = 0; /* No support for dynamic buffers */
+		goto out_handled;
+	default:
+		return false;
+	}
+
+out_handled:
+	ffa_to_smccc_res_prop(res, ret, prop);
+	return true;
+}
+
 bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(u64, func_id, host_ctxt, 0);
@@ -98,6 +137,10 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt)
 		return false;
 
 	switch (func_id) {
+	case FFA_FEATURES:
+		if (!do_ffa_features(&res, host_ctxt))
+			return false;
+		goto out_handled;
 	/* Memory management */
 	case FFA_FN64_RXTX_MAP:
 	case FFA_RXTX_UNMAP:
@@ -114,6 +157,7 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt)
 		return false; /* Pass through */
 
 	ffa_to_smccc_error(&res, FFA_RET_NOT_SUPPORTED);
+out_handled:
 	ffa_set_retval(host_ctxt, &res);
 	return true;
 }
-- 
2.38.1.431.g37b22c650d-goog

