Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A89683939
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjAaWVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjAaWU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:20:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC37149026
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:20:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4373561741
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 22:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5015C4339C;
        Tue, 31 Jan 2023 22:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675203656;
        bh=eeqciihnDg2sEO/vf9yVNE4k6Cr0hu6F8Uy6SJu5kEw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=GzUIaeC1G+aXThwpEWPvfSuYozQKYQYujuRGrB8J6iQwoarElqKp56r/6uS1aHv94
         YyP2ldIzMMSzU1QXwm4ADKJgosJKUorP56yzfgcbwNoHuDHdRGsMgdm/TKDF40d1KO
         1ikJiJs+MLXA0eybuul3vj6Q0pitoQcHoVwkszuzDu/5wX1O9uQDPcMsogCMlbkOag
         WHI8d3pXkJScxFvEV+TIpvoESZh+EDIH+jZjZDq+oLiqawD/yCA48eZcvVZK1xdx3g
         x41jjlPCMpYJvbxOHOz3mDK+Fb53kaLPlbrKp9s2jEGSz92TkRPTZ9ZMgUoSPjzN8e
         xaUsVcrdYGIcg==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 31 Jan 2023 22:20:42 +0000
Subject: [PATCH v3 4/7] arm64/signal: Avoid rereading context frame sizes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221212-arm64-signal-cleanup-v3-4-4545c94b20ff@kernel.org>
References: <20221212-arm64-signal-cleanup-v3-0-4545c94b20ff@kernel.org>
In-Reply-To: <20221212-arm64-signal-cleanup-v3-0-4545c94b20ff@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6019; i=broonie@kernel.org;
 h=from:subject:message-id; bh=eeqciihnDg2sEO/vf9yVNE4k6Cr0hu6F8Uy6SJu5kEw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBj2ZQ+3qWgnKCw814R1AN3FG16085v5ma2/mFrqku8
 1QGHOSCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY9mUPgAKCRAk1otyXVSH0LrmB/
 45Lld0chZkMPbu2t2LbbANNnKkUT0l5jF+OopYAKtV+i4DLS0k5uGlRN2bqSOISKDhLkivyi38Zv4/
 HcRuu8xCqd2jolNlBUYuFZK92qpbb5s5gbOCMAh+rKjgl3E/sYYkXNdYxw9FltkFnvoDe/jxxM+KAe
 0S9hnMqEneIgywQ6rlorQ7oxzrheYj8gKwt8uiNfgQb5P6dWgYgkDNi4qWaFCjsCL2MmOG3uAO21rW
 pSC7ChVcfCDFwARnKWb0hO/Mv32YVUq2/UMA89UYcXwyETpnIuDjW2PVjU1SMgaAPacWkEwyygMf+Z
 vqOxlBliOgEHtv4iX4OT+ax2Skezme
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to read the sizes of the signal context frames as part of parsing
the overall signal context in parse_user_sigframe(). In the cases where we
defer frame specific parsing to other functions those functions (other
than the recently added TPIDR2 parser) reread the size and validate the
version they read, opening the possibility that the value may change.
Avoid this possibility by passing the size read in parse_user_sigframe()
through user_ctxs and referring to that.

For consistency we move the size check for the TPIDR2 context into the
TPIDR2 parsing function.

Note that for SVE, ZA and ZT contexts we still read the size again but
after this change we no longer use the value, further changes will avoid
the read.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/signal.c | 52 ++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 49321871783d..567e8e5b6998 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -172,10 +172,15 @@ static void __user *apply_user_offset(
 
 struct user_ctxs {
 	struct fpsimd_context __user *fpsimd;
+	u32 fpsimd_size;
 	struct sve_context __user *sve;
+	u32 sve_size;
 	struct tpidr2_context __user *tpidr2;
+	u32 tpidr2_size;
 	struct za_context __user *za;
+	u32 za_size;
 	struct zt_context __user *zt;
+	u32 zt_size;
 };
 
 static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
@@ -199,14 +204,10 @@ static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 static int restore_fpsimd_context(struct user_ctxs *user)
 {
 	struct user_fpsimd_state fpsimd;
-	__u32 size;
 	int err = 0;
 
 	/* check the size information */
-	__get_user_error(size, &user->fpsimd->head.size, err);
-	if (err)
-		return -EFAULT;
-	if (size != sizeof(struct fpsimd_context))
+	if (user->fpsimd_size != sizeof(struct fpsimd_context))
 		return -EINVAL;
 
 	/* copy the FP and status/control registers */
@@ -275,12 +276,12 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	struct user_fpsimd_state fpsimd;
 	struct sve_context sve;
 
+	if (user->sve_size < sizeof(*user->sve))
+		return -EINVAL;
+
 	if (__copy_from_user(&sve, user->sve, sizeof(sve)))
 		return -EFAULT;
 
-	if (sve.head.size < sizeof(*user->sve))
-		return -EINVAL;
-
 	if (sve.flags & SVE_SIG_FLAG_SM) {
 		if (!system_supports_sme())
 			return -EINVAL;
@@ -296,7 +297,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	if (sve.vl != vl)
 		return -EINVAL;
 
-	if (sve.head.size == sizeof(*user->sve)) {
+	if (user->sve_size == sizeof(*user->sve)) {
 		clear_thread_flag(TIF_SVE);
 		current->thread.svcr &= ~SVCR_SM_MASK;
 		current->thread.fp_type = FP_STATE_FPSIMD;
@@ -305,7 +306,7 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 
 	vq = sve_vq_from_vl(sve.vl);
 
-	if (sve.head.size < SVE_SIG_CONTEXT_SIZE(vq))
+	if (user->sve_size < SVE_SIG_CONTEXT_SIZE(vq))
 		return -EINVAL;
 
 	/*
@@ -385,7 +386,9 @@ static int restore_tpidr2_context(struct user_ctxs *user)
 	u64 tpidr2_el0;
 	int err = 0;
 
-	/* Magic and size were validated deciding to call this function */
+	if (user->tpidr2_size != sizeof(*user->tpidr2))
+		return -EINVAL;
+
 	__get_user_error(tpidr2_el0, &user->tpidr2->tpidr2, err);
 	if (!err)
 		current->thread.tpidr2_el0 = tpidr2_el0;
@@ -434,23 +437,23 @@ static int restore_za_context(struct user_ctxs *user)
 	unsigned int vq;
 	struct za_context za;
 
+	if (user->za_size < sizeof(*user->za))
+		return -EINVAL;
+
 	if (__copy_from_user(&za, user->za, sizeof(za)))
 		return -EFAULT;
 
-	if (za.head.size < sizeof(*user->za))
-		return -EINVAL;
-
 	if (za.vl != task_get_sme_vl(current))
 		return -EINVAL;
 
-	if (za.head.size == sizeof(*user->za)) {
+	if (user->za_size == sizeof(*user->za)) {
 		current->thread.svcr &= ~SVCR_ZA_MASK;
 		return 0;
 	}
 
 	vq = sve_vq_from_vl(za.vl);
 
-	if (za.head.size < ZA_SIG_CONTEXT_SIZE(vq))
+	if (user->za_size < ZA_SIG_CONTEXT_SIZE(vq))
 		return -EINVAL;
 
 	/*
@@ -521,15 +524,15 @@ static int restore_zt_context(struct user_ctxs *user)
 	if (!thread_za_enabled(&current->thread))
 		return -EINVAL;
 
+	if (user->zt_size != ZT_SIG_CONTEXT_SIZE(1))
+		return -EINVAL;
+
 	if (__copy_from_user(&zt, user->zt, sizeof(zt)))
 		return -EFAULT;
 
 	if (zt.nregs != 1)
 		return -EINVAL;
 
-	if (zt.head.size != ZT_SIG_CONTEXT_SIZE(zt.nregs))
-		return -EINVAL;
-
 	/*
 	 * Careful: we are about __copy_from_user() directly into
 	 * thread.zt_state with preemption enabled, so protection is
@@ -621,6 +624,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 				goto invalid;
 
 			user->fpsimd = (struct fpsimd_context __user *)head;
+			user->fpsimd_size = size;
 			break;
 
 		case ESR_MAGIC:
@@ -635,6 +639,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 				goto invalid;
 
 			user->sve = (struct sve_context __user *)head;
+			user->sve_size = size;
 			break;
 
 		case TPIDR2_MAGIC:
@@ -644,10 +649,8 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			if (user->tpidr2)
 				goto invalid;
 
-			if (size != sizeof(*user->tpidr2))
-				goto invalid;
-
 			user->tpidr2 = (struct tpidr2_context __user *)head;
+			user->tpidr2_size = size;
 			break;
 
 		case ZA_MAGIC:
@@ -658,6 +661,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 				goto invalid;
 
 			user->za = (struct za_context __user *)head;
+			user->za_size = size;
 			break;
 
 		case ZT_MAGIC:
@@ -667,10 +671,8 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			if (user->zt)
 				goto invalid;
 
-			if (size < sizeof(*user->zt))
-				goto invalid;
-
 			user->zt = (struct zt_context __user *)head;
+			user->zt_size = size;
 			break;
 
 		case EXTRA_MAGIC:

-- 
2.30.2

