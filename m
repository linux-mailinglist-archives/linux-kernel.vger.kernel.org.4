Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EAB660C11
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 03:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbjAGCyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 21:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjAGCyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 21:54:43 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484A28B538
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 18:54:41 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id y8-20020a170902b48800b00192a600df83so2353736plr.15
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 18:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/LXD7bWn6Jkwh9hHWJBLtYnysPLbu62uMIUKDSw+zHg=;
        b=D/axEx4FkjtSzhj6GtMgJ/eJNW2W8y+wGrdJ6WK+JKRibRRQcNB02GD5Ej+HMaYzOn
         I4r8jetP7aQCigvNTyA+nvW63VqQ2V6lagidpSk2Wc6g3eMvIVBCfLScXdMjhdGhYnS2
         gZdq4p+zvacBigitPU1lyIDbtuDurtbuBWboWKzVSJylU00HTdVPoEFrfKombEw7cYgp
         fkl7HePlLnEugAAkQqbvJFIge9bxGIJIlNcDBXdTB4qpZZSDOGPLVcMmn64hFW/w8vgf
         8UdkiTCNLip4UgwFTTGJyht9/eGWnzVCemsh9yUucwUUbZONP3ieq5KhQWJigpJdk5M1
         VWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/LXD7bWn6Jkwh9hHWJBLtYnysPLbu62uMIUKDSw+zHg=;
        b=AhUw+VtgoFQTpvgWyScEDx6P1nxEAU+x/ozLM1JE1BISfYE2+r/4kns1D4nLwovLT3
         hesacZ+1BL5z1/qWycZlvaOQcVNONudjWyVOwNtvOZvBumWXBVVciGqlSXJo/KzbG84q
         J7KgWTvtY4tmrHfY7OXou3G/V5IDR1VC+qI2i3mBrDt8cpRol5TCAVBZqViPOUJvDv1w
         CZbrBdclOMATwkbQk5OQr7hp17XfJDyhxtX06+gI03uGb9tU+5Ll0AkyNMDRDq7PQGoZ
         WZaeb3N1mxMxkaA6UNy9Rza/RY80c0clT4d81Jq9er/1TetcsdgVbMBCr5fcceHaGLIj
         q9mQ==
X-Gm-Message-State: AFqh2kqcfSiU8m87x8otJYXF/2S6wYGGcKujkC1fMev86KulAmq1DniW
        +MBfXi5dbhqg9F6N5G5r7Mq6AX2nqgrm
X-Google-Smtp-Source: AMrXdXuGpkSqOris5d+pibbC28QA9/oo3sbz/IB0DzZeTVqkNYBWIuBFM7QwHx+JujDwlaS/nrNsSF5P8JLU
X-Received: from connoro.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:a99])
 (user=connoro job=sendgmr) by 2002:a05:6a00:440b:b0:583:860:7a30 with SMTP id
 br11-20020a056a00440b00b0058308607a30mr906809pfb.1.1673060080726; Fri, 06 Jan
 2023 18:54:40 -0800 (PST)
Date:   Sat,  7 Jan 2023 02:53:31 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230107025331.3240536-1-connoro@google.com>
Subject: [PATCH bpf-next v3] bpf: btf: limit logging of ignored BTF mismatches
From:   "Connor O'Brien" <connoro@google.com>
To:     bpf@vger.kernel.org
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org, "Connor O'Brien" <connoro@google.com>
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

Enabling CONFIG_MODULE_ALLOW_BTF_MISMATCH is an indication that BTF
mismatches are expected and module loading should proceed
anyway. Logging with pr_warn() on every one of these "benign"
mismatches creates unnecessary noise when many such modules are
loaded. Instead, handle this case with a single log warning that BTF
info may be unavailable.

Mismatches also result in calls to __btf_verifier_log() via
__btf_verifier_log_type() or btf_verifier_log_member(), adding several
additional lines of logging per mismatched module. Add checks to these
paths to skip logging for module BTF mismatches in the "allow
mismatch" case.

All existing logging behavior is preserved in the default
CONFIG_MODULE_ALLOW_BTF_MISMATCH=n case.

Signed-off-by: Connor O'Brien <connoro@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
v3:
- fix commenting style
- reuse existing "log->level == BPF_LOG_KERNEL" check for kernel BTF

v2:
- Use pr_warn_once instead of skipping logging entirely
- Also skip btf verifier logs for ignored mismatches

v1: https://lore.kernel.org/bpf/20221109024155.2810410-1-connoro@google.com/
---
 kernel/bpf/btf.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f7dd8af06413..67eee2d83dc8 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1397,12 +1397,18 @@ __printf(4, 5) static void __btf_verifier_log_type(struct btf_verifier_env *env,
 	if (!bpf_verifier_log_needed(log))
 		return;
 
-	/* btf verifier prints all types it is processing via
-	 * btf_verifier_log_type(..., fmt = NULL).
-	 * Skip those prints for in-kernel BTF verification.
-	 */
-	if (log->level == BPF_LOG_KERNEL && !fmt)
-		return;
+	if (log->level == BPF_LOG_KERNEL) {
+		/* btf verifier prints all types it is processing via
+		 * btf_verifier_log_type(..., fmt = NULL).
+		 * Skip those prints for in-kernel BTF verification.
+		 */
+		if (!fmt)
+			return;
+
+		/* Skip logging when loading module BTF with mismatches permitted */
+		if (env->btf->base_btf && IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH))
+			return;
+	}
 
 	__btf_verifier_log(log, "[%u] %s %s%s",
 			   env->log_type_id,
@@ -1441,8 +1447,15 @@ static void btf_verifier_log_member(struct btf_verifier_env *env,
 	if (!bpf_verifier_log_needed(log))
 		return;
 
-	if (log->level == BPF_LOG_KERNEL && !fmt)
-		return;
+	if (log->level == BPF_LOG_KERNEL) {
+		if (!fmt)
+			return;
+
+		/* Skip logging when loading module BTF with mismatches permitted */
+		if (env->btf->base_btf && IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH))
+			return;
+	}
+
 	/* The CHECK_META phase already did a btf dump.
 	 *
 	 * If member is logged again, it must hit an error in
@@ -7260,11 +7273,14 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
 		}
 		btf = btf_parse_module(mod->name, mod->btf_data, mod->btf_data_size);
 		if (IS_ERR(btf)) {
-			pr_warn("failed to validate module [%s] BTF: %ld\n",
-				mod->name, PTR_ERR(btf));
 			kfree(btf_mod);
-			if (!IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH))
+			if (!IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
+				pr_warn("failed to validate module [%s] BTF: %ld\n",
+					mod->name, PTR_ERR(btf));
 				err = PTR_ERR(btf);
+			} else {
+				pr_warn_once("Kernel module BTF mismatch detected, BTF debug info may be unavailable for some modules\n");
+			}
 			goto out;
 		}
 		err = btf_alloc_id(btf);
-- 
2.39.0.314.g84b9a713c41-goog

