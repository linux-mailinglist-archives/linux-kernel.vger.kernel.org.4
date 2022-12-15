Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993F164D4D5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 01:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiLOAxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 19:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiLOAxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 19:53:44 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C77E31EDC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 16:53:43 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id x17-20020a17090a8a9100b002196a3b190cso624550pjn.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 16:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rBQYa4W8A+AJiUwNOuc8Q7CyuPP2yMOoaSr+CBtkpMs=;
        b=GdN50OAHp+Whl7EboNBqIJn7oMiw0wMD07/V3yhXDi6aM7BuLjNewzP+7YDBpsBJ+t
         tJUZGFjcK+BXqCOAE5KeHD+NIjcRVsaGFUAxZJcZjE0kPoWv8u59DtRW6I8kOtHpzhKI
         +HhVWr7TCZM6RyQbe9z3q6nIWW96S2SgUnyv9GkLnPtSFh5MypWdIpt4l4MHD59sm8FZ
         QMDrkivQiAhZ7MHgT89D20umdttHAvZUFQnvyhXjR4PPagWsOwQTtnNLKHUibA4PzFgJ
         qqP9K1gIEbt5z5ffT3bfajfodA37Rs56abzXE28EyLy3FX/hlHtL5BQcqPHbupdC2HdE
         9PuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rBQYa4W8A+AJiUwNOuc8Q7CyuPP2yMOoaSr+CBtkpMs=;
        b=o3OocnuIV8YZEJiJwTXsgw5YzoEKKjf3q0+c8XlUmWZd62oNKUUbp2O/kFFeie3XgV
         mGAkFdtss8vUR54QCW6Rx5xtyGtm/KCNkF9lJreGh5DZla8wUWfp7JGARDieacnMA1Lq
         kunLUayQal5Czf+jBPDIvaK9BtHOvTVWcjvbXqUZAsY0DgNUXgvibEhBrjJp4f4sUPrR
         ssiHSHiQA8fefXiOyzJxY2QV6dTTtVUBKgririmwcd86TxAsuuvtDQ6wOINmC5O0smOk
         zoTBaT/ezwE9jZ8ByCgGYCmFSRvkrNzMDMbJR59k0a4iXpEbVJZEW/3WUuOtSDyb4nW4
         Js3w==
X-Gm-Message-State: ANoB5pmyF509uNXy3BxkjBx8yRwgsBEbwSv/4eqJ/jpzfgQTro3tvQB2
        rnv1/7HW50mpKVYaM1R8XpmIFW3+JpJK
X-Google-Smtp-Source: AA0mqf7OAlNT6gA4JXc8GJ23UMKYjJ0gPupRWtT35R7PXd2xP7OzGAUljthjq0ETxT5v0v7oNQM8JmyAjrnD
X-Received: from connoro.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:a99])
 (user=connoro job=sendgmr) by 2002:a05:6a00:e17:b0:576:1d9e:caa0 with SMTP id
 bq23-20020a056a000e1700b005761d9ecaa0mr35297738pfb.81.1671065622919; Wed, 14
 Dec 2022 16:53:42 -0800 (PST)
Date:   Thu, 15 Dec 2022 00:53:15 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221215005315.186787-1-connoro@google.com>
Subject: [PATCH bpf-next v2] bpf: btf: limit logging of ignored BTF mismatches
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
---
v2:
- Use pr_warn_once instead of skipping logging entirely
- Also skip btf verifier logs for ignored mismatches

v1: https://lore.kernel.org/bpf/20221109024155.2810410-1-connoro@google.com/
---
 kernel/bpf/btf.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f7dd8af06413..16b959b49595 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1404,6 +1404,13 @@ __printf(4, 5) static void __btf_verifier_log_type(struct btf_verifier_env *env,
 	if (log->level == BPF_LOG_KERNEL && !fmt)
 		return;
 
+	/*
+	 * Skip logging when loading module BTF with mismatches permitted
+	 */
+	if (env->btf->base_btf && env->btf->kernel_btf &&
+	    IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH))
+		return;
+
 	__btf_verifier_log(log, "[%u] %s %s%s",
 			   env->log_type_id,
 			   btf_type_str(t),
@@ -1443,6 +1450,14 @@ static void btf_verifier_log_member(struct btf_verifier_env *env,
 
 	if (log->level == BPF_LOG_KERNEL && !fmt)
 		return;
+
+	/*
+	 * Skip logging when loading module BTF with mismatches permitted
+	 */
+	if (env->btf->base_btf && env->btf->kernel_btf &&
+	    IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH))
+		return;
+
 	/* The CHECK_META phase already did a btf dump.
 	 *
 	 * If member is logged again, it must hit an error in
@@ -7260,11 +7275,14 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
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
2.39.0.rc1.256.g54fd8350bd-goog

