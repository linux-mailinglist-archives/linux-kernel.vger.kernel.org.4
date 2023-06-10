Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F1372A8E4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 05:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjFJDvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 23:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjFJDvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 23:51:00 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F308135B1;
        Fri,  9 Jun 2023 20:50:58 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-75d509d425eso241033985a.1;
        Fri, 09 Jun 2023 20:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686369058; x=1688961058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwoULZs5X3hMJWti4aKL+kX48d28ami6bZcIsL0hjWs=;
        b=aTQJSp4ituCCarOfAFDblDb7ono+/JhfldNXC43+ftR9Ic/QHSvbPTBNntWm5gOO3E
         PjLn1TBEUllRpU3qaZsk4MofvgKHQa31VU1099izRpWrUddNm3ea8fElA/7qyQvAvWvt
         K6QXzuCs1WvvA8gdrIoijeueMX9fWlYdE9XEhlJHFZWciYHnWFibU/gHtR6kNMzZzYOS
         hopZ9wlxpSZWls5NA2F4EkVnql6y6kNNGoOjWG5e/d1bBiC4WdVW2bKi0GkoFomKa2gV
         V0tm+KT4hpA0aXUZ2Ht/68CqFn+T897UqUJZNY1fYF/iHWVzeOH6jvS97LrjtLZuJcW4
         DCgw==
X-Gm-Message-State: AC+VfDxvMwAGVrLfqjr8mcwT776Xx2ee29RTg93lGS+GXBDPFo7NoaRu
        BTf8qvYpquwAXdTTI+HGsuXuc19Y28jn36cE
X-Google-Smtp-Source: ACHHUZ4sdQKmNUSd7a8r0tncq0vc8Yv/3/SAgOUW5ETyOSIw6hCW7N1/mzDH2J6bMR3M3CerqsRchg==
X-Received: by 2002:a05:620a:8884:b0:75d:4fb8:e219 with SMTP id qk4-20020a05620a888400b0075d4fb8e219mr2571323qkn.36.1686369057575;
        Fri, 09 Jun 2023 20:50:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:81d3])
        by smtp.gmail.com with ESMTPSA id w13-20020a05620a148d00b0075914b01c10sm1456322qkj.85.2023.06.09.20.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 20:50:57 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
Subject: [PATCH bpf-next 2/5] selftests/bpf: Add test for new bpf_cpumask_first_and() kfunc
Date:   Fri,  9 Jun 2023 22:50:50 -0500
Message-Id: <20230610035053.117605-2-void@manifault.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610035053.117605-1-void@manifault.com>
References: <20230610035053.117605-1-void@manifault.com>
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

A prior patch added a new kfunc called bpf_cpumask_first_and() which
wraps cpumask_first_and(). This patch adds a selftest to validate its
behavior.

Signed-off-by: David Vernet <void@manifault.com>
---
 .../selftests/bpf/prog_tests/cpumask.c        |  1 +
 .../selftests/bpf/progs/cpumask_common.h      |  2 ++
 .../selftests/bpf/progs/cpumask_success.c     | 32 +++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask.c b/tools/testing/selftests/bpf/prog_tests/cpumask.c
index d89191440fb1..756ea8b590b6 100644
--- a/tools/testing/selftests/bpf/prog_tests/cpumask.c
+++ b/tools/testing/selftests/bpf/prog_tests/cpumask.c
@@ -10,6 +10,7 @@ static const char * const cpumask_success_testcases[] = {
 	"test_set_clear_cpu",
 	"test_setall_clear_cpu",
 	"test_first_firstzero_cpu",
+	"test_firstand_nocpu",
 	"test_test_and_set_clear",
 	"test_and_or_xor",
 	"test_intersects_subset",
diff --git a/tools/testing/selftests/bpf/progs/cpumask_common.h b/tools/testing/selftests/bpf/progs/cpumask_common.h
index 0c5b785a93e4..b3493d5d263e 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_common.h
+++ b/tools/testing/selftests/bpf/progs/cpumask_common.h
@@ -28,6 +28,8 @@ void bpf_cpumask_release(struct bpf_cpumask *cpumask) __ksym;
 struct bpf_cpumask *bpf_cpumask_acquire(struct bpf_cpumask *cpumask) __ksym;
 u32 bpf_cpumask_first(const struct cpumask *cpumask) __ksym;
 u32 bpf_cpumask_first_zero(const struct cpumask *cpumask) __ksym;
+u32 bpf_cpumask_first_and(const struct cpumask *src1,
+			  const struct cpumask *src2) __ksym;
 void bpf_cpumask_set_cpu(u32 cpu, struct bpf_cpumask *cpumask) __ksym;
 void bpf_cpumask_clear_cpu(u32 cpu, struct bpf_cpumask *cpumask) __ksym;
 bool bpf_cpumask_test_cpu(u32 cpu, const struct cpumask *cpumask) __ksym;
diff --git a/tools/testing/selftests/bpf/progs/cpumask_success.c b/tools/testing/selftests/bpf/progs/cpumask_success.c
index 602a88b03dbc..fbaf510f4ab5 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_success.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_success.c
@@ -175,6 +175,38 @@ int BPF_PROG(test_first_firstzero_cpu, struct task_struct *task, u64 clone_flags
 	return 0;
 }
 
+SEC("tp_btf/task_newtask")
+int BPF_PROG(test_firstand_nocpu, struct task_struct *task, u64 clone_flags)
+{
+	struct bpf_cpumask *mask1, *mask2;
+	u32 first;
+
+	if (!is_test_task())
+		return 0;
+
+	mask1 = create_cpumask();
+	if (!mask1)
+		return 0;
+
+	mask2 = create_cpumask();
+	if (!mask2)
+		goto release_exit;
+
+	bpf_cpumask_set_cpu(0, mask1);
+	bpf_cpumask_set_cpu(1, mask2);
+
+	first = bpf_cpumask_first_and(cast(mask1), cast(mask2));
+	if (first <= 1)
+		err = 3;
+
+release_exit:
+	if (mask1)
+		bpf_cpumask_release(mask1);
+	if (mask2)
+		bpf_cpumask_release(mask2);
+	return 0;
+}
+
 SEC("tp_btf/task_newtask")
 int BPF_PROG(test_test_and_set_clear, struct task_struct *task, u64 clone_flags)
 {
-- 
2.40.1

