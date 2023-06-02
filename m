Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A44720537
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbjFBPCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbjFBPBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:01:49 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8382E5A;
        Fri,  2 Jun 2023 08:01:47 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-5ed99ebe076so21300266d6.2;
        Fri, 02 Jun 2023 08:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685718107; x=1688310107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRAU68UeuXK18E4EeqM4miubTOqC0hPyuU/RpS6y6BQ=;
        b=cG4Eopy6qPKwheYmxCPCLf4fetz017uQKj/QORKW30EZuVJU8G002LyDMjE1SKm94q
         fu7/RIAzybqdhNqstRab5nB+H/fuFgWZBU8wSoIRdk+3w+nckoi1YaVK8uZ7vzJ4fJCd
         n2R75tuo6izqDBf/+kp62hqw3oW82gU29SPloOqpAihJ4YrXq5SfuBwY5n/Vk0yu4LlN
         t7bMujMh9BFwvnPZ2Zd2oOTmncTycTzhNR94pvoxheN0o+XsHJQRximLwZ2urIDkeCSC
         bRMBHCwocQmoh3nKkDhU3DV9nCdbVnfOvnoK1lRLS/8q2TbSILu0kUnjwsuEwBb9gKBt
         Zs9A==
X-Gm-Message-State: AC+VfDwkGKC1ZpkPw1iVQJ22mDlhaZuAMeFZKPcOD/Cs8WW0WZ2xZmWM
        jDHW6JZ2fmYTepV8m1JNtc32G9Enrldpo61x
X-Google-Smtp-Source: ACHHUZ6tzHm/VV4i6hYVt0H6zPcEtE79GJL+QoC9i9K41llRWjGeaKOzZgoggzZS3ZBIiU6V57I4GQ==
X-Received: by 2002:a05:6214:2487:b0:625:775e:8802 with SMTP id gi7-20020a056214248700b00625775e8802mr18589429qvb.18.1685718106532;
        Fri, 02 Jun 2023 08:01:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:1317])
        by smtp.gmail.com with ESMTPSA id d5-20020a0cea85000000b006286334f999sm897345qvp.78.2023.06.02.08.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 08:01:32 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test for non-NULLable PTR_TO_BTF_IDs
Date:   Fri,  2 Jun 2023 10:01:12 -0500
Message-Id: <20230602150112.1494194-2-void@manifault.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602150112.1494194-1-void@manifault.com>
References: <20230602150112.1494194-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a recent patch, we taught the verifier that trusted PTR_TO_BTF_ID can
never be NULL. This prevents the verifier from incorrectly failing to
load certain programs where it gets confused and thinks a reference
isn't dropped because it incorrectly assumes that a branch exists in
which a NULL PTR_TO_BTF_ID pointer is never released.

This patch adds a testcase that verifies this cannot happen.

Signed-off-by: David Vernet <void@manifault.com>
---
 .../selftests/bpf/prog_tests/cpumask.c        |  1 +
 .../selftests/bpf/progs/cpumask_success.c     | 24 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask.c b/tools/testing/selftests/bpf/prog_tests/cpumask.c
index cdf4acc18e4c..d89191440fb1 100644
--- a/tools/testing/selftests/bpf/prog_tests/cpumask.c
+++ b/tools/testing/selftests/bpf/prog_tests/cpumask.c
@@ -70,5 +70,6 @@ void test_cpumask(void)
 		verify_success(cpumask_success_testcases[i]);
 	}
 
+	RUN_TESTS(cpumask_success);
 	RUN_TESTS(cpumask_failure);
 }
diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
index 2fcdd7f68ac7..602a88b03dbc 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -5,6 +5,7 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
 
+#include "bpf_misc.h"
 #include "cpumask_common.h"
 
 char _license[] SEC("license") = "GPL";
@@ -426,3 +427,26 @@ int BPF_PROG(test_global_mask_rcu, struct task_struct *task, u64 clone_flags)
 
 	return 0;
 }
+
+SEC("tp_btf/task_newtask")
+__success
+int BPF_PROG(test_refcount_null_tracking, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *mask1, *mask2;
+
+	mask1 = bpf_cpumask_create();
+	mask2 = bpf_cpumask_create();
+
+	if (!mask1 || !mask2)
+		goto free_masks_return;
+
+	bpf_cpumask_test_cpu(0, (const struct cpumask *)mask1);
+	bpf_cpumask_test_cpu(0, (const struct cpumask *)mask2);
+
+free_masks_return:
+	if (mask1)
+		bpf_cpumask_release(mask1);
+	if (mask2)
+		bpf_cpumask_release(mask2);
+	return 0;
+}
-- 
2.40.1

