Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF31069D90D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 03:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjBUCzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 21:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjBUCzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 21:55:02 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E2523C7A;
        Mon, 20 Feb 2023 18:54:37 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id m3-20020a17090ade0300b00229eec90a7fso2248297pjv.0;
        Mon, 20 Feb 2023 18:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcXznShD1FtIJB6KUgxvv5Wtx04eViDoumkvjfV98AM=;
        b=e+LXwgVnEE30LygaDJpn7nj7LRq/cNtE/do1MAq2rNfjIR/EzlPPcYI/AUYvgCeWH8
         R5EesM/dsgMUNhNY9vKe729qqR+xiUlOw5moNS7OTCkTcb/eQxFduG2T9EM2SPjctGWl
         6ovy2BY0I79PHskVPDCP7paxO6dxRHLFiwGiKH2y7f1Erww/w0Wh0z1YOsoXUhwKUkcB
         6eC/aF+Mty55NZ0L/qO34pE5lXTJCfdV7gMzaHZ8AOtgu98ghpBJt7+tDn69ZablUFY+
         WO6T6udbZQKFFe2PmtWP1mFIm1XfG+IxqT5408pLq2TH5Opsuo0JCY/bZ8/FOFXONZDM
         GiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcXznShD1FtIJB6KUgxvv5Wtx04eViDoumkvjfV98AM=;
        b=ipLXoBawaxl0GzS+CUIY4b503x7qy/vr2PMl606jzXAnPgeIN3xQYneSNoadYcraHp
         mdcy0aYgXJsFEVVMSQ3YZmsH0w3t/DvyPyb6TqT4vxKexPxTLrBYYTM95k1ekq6abBuj
         oKm2QCiDc2H2XyjxosaaBIT0rAiKOqIGxlm6nSwEV/js7uBg5j6TFSbgV3IqJrzJhoBG
         7jvsOrohELQ9BqjvHmGy5dltgEGCj0lreKkHsMuxu7raJaoNqLyspW3YRFxPNFj0Pl96
         XmZnwtJxwHh7WkjJMtof0Sr1fILc0rh8JKCMccam6wpk/TzqybndY2aT0Hwo+Vaq9+vS
         lZ+A==
X-Gm-Message-State: AO0yUKUI17j7TYMd0MxjAhIZlBIs8cNuKBaPyOQxICqyEjOI2x+YTV2R
        UeM2fbeNyLED5qDT73F1uJ8=
X-Google-Smtp-Source: AK7set/axbba478ju+UrCyLS+8F6flBmBJ8DfZZ5n8hvAKP1A5+tXTYrKiOczosPvg+HVlH9FOarRw==
X-Received: by 2002:a17:902:e84b:b0:198:f8c9:7f4b with SMTP id t11-20020a170902e84b00b00198f8c97f4bmr1941907plg.2.1676948075731;
        Mon, 20 Feb 2023 18:54:35 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.16])
        by smtp.gmail.com with ESMTPSA id k3-20020a170902e90300b0019a837be977sm8590156pld.271.2023.02.20.18.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 18:54:35 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     andrii.nakryiko@gmail.com, alan.maguire@oracle.com
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, benbjiang@tencent.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next v3 2/3] selftests/bpf: split test_attach_probe into multi subtests
Date:   Tue, 21 Feb 2023 10:53:46 +0800
Message-Id: <20230221025347.389047-3-imagedong@tencent.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230221025347.389047-1-imagedong@tencent.com>
References: <20230221025347.389047-1-imagedong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Menglong Dong <imagedong@tencent.com>

In order to adapt to the older kernel, now we split the "attach_probe"
testing into multi subtests:

  manual // manual attach tests for kprobe/uprobe
  auto // auto-attach tests for kprobe and uprobe
  kprobe-sleepable // kprobe sleepable test
  uprobe-lib // uprobe tests for library function by name
  uprobe-sleepable // uprobe sleepable test
  uprobe-ref_ctr // uprobe ref_ctr test

As sleepable kprobe needs to set BPF_F_SLEEPABLE flag before loading,
we need to move it to a stand alone skel file, in case of it is not
supported by kernel and make the whole loading fail.

Therefore, we can only enable part of the subtests for older kernel.

Reviewed-by: Biao Jiang <benbjiang@tencent.com>
Signed-off-by: Menglong Dong <imagedong@tencent.com>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
---
v3:
- rename test_uporbe_ref_ctr() to test_uprobe_ref_ctr() to fix the
  typo
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 268 +++++++++++-------
 .../bpf/progs/test_attach_kprobe_sleepable.c  |  23 ++
 .../selftests/bpf/progs/test_attach_probe.c   |  23 +-
 3 files changed, 208 insertions(+), 106 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_attach_kprobe_sleepable.c

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 56374c8b5436..8afd3e6066b8 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include "test_attach_kprobe_sleepable.skel.h"
 #include "test_attach_probe.skel.h"
 
 /* this is how USDT semaphore is actually defined, except volatile modifier */
@@ -23,110 +24,63 @@ static noinline void trigger_func3(void)
 	asm volatile ("");
 }
 
+/* attach point for ref_ctr */
+static noinline void trigger_func4(void)
+{
+	asm volatile ("");
+}
+
 static char test_data[] = "test_data";
 
-void test_attach_probe(void)
+/* manual attach kprobe/kretprobe/uprobe/uretprobe testings */
+static void test_attach_probe_manual(struct test_attach_probe *skel)
 {
 	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
 	struct bpf_link *kprobe_link, *kretprobe_link;
 	struct bpf_link *uprobe_link, *uretprobe_link;
-	struct test_attach_probe* skel;
-	ssize_t uprobe_offset, ref_ctr_offset;
-	struct bpf_link *uprobe_err_link;
-	FILE *devnull;
-	bool legacy;
-
-	/* Check if new-style kprobe/uprobe API is supported.
-	 * Kernels that support new FD-based kprobe and uprobe BPF attachment
-	 * through perf_event_open() syscall expose
-	 * /sys/bus/event_source/devices/kprobe/type and
-	 * /sys/bus/event_source/devices/uprobe/type files, respectively. They
-	 * contain magic numbers that are passed as "type" field of
-	 * perf_event_attr. Lack of such file in the system indicates legacy
-	 * kernel with old-style kprobe/uprobe attach interface through
-	 * creating per-probe event through tracefs. For such cases
-	 * ref_ctr_offset feature is not supported, so we don't test it.
-	 */
-	legacy = access("/sys/bus/event_source/devices/kprobe/type", F_OK) != 0;
+	ssize_t uprobe_offset;
 
 	uprobe_offset = get_uprobe_offset(&trigger_func);
 	if (!ASSERT_GE(uprobe_offset, 0, "uprobe_offset"))
 		return;
 
-	ref_ctr_offset = get_rel_offset((uintptr_t)&uprobe_ref_ctr);
-	if (!ASSERT_GE(ref_ctr_offset, 0, "ref_ctr_offset"))
-		return;
-
-	skel = test_attach_probe__open();
-	if (!ASSERT_OK_PTR(skel, "skel_open"))
-		return;
-
-	/* sleepable kprobe test case needs flags set before loading */
-	if (!ASSERT_OK(bpf_program__set_flags(skel->progs.handle_kprobe_sleepable,
-		BPF_F_SLEEPABLE), "kprobe_sleepable_flags"))
-		goto cleanup;
-
-	if (!ASSERT_OK(test_attach_probe__load(skel), "skel_load"))
-		goto cleanup;
-	if (!ASSERT_OK_PTR(skel->bss, "check_bss"))
-		goto cleanup;
-
 	/* manual-attach kprobe/kretprobe */
 	kprobe_link = bpf_program__attach_kprobe(skel->progs.handle_kprobe,
 						 false /* retprobe */,
 						 SYS_NANOSLEEP_KPROBE_NAME);
 	if (!ASSERT_OK_PTR(kprobe_link, "attach_kprobe"))
-		goto cleanup;
+		return;
 	skel->links.handle_kprobe = kprobe_link;
 
 	kretprobe_link = bpf_program__attach_kprobe(skel->progs.handle_kretprobe,
 						    true /* retprobe */,
 						    SYS_NANOSLEEP_KPROBE_NAME);
 	if (!ASSERT_OK_PTR(kretprobe_link, "attach_kretprobe"))
-		goto cleanup;
+		return;
 	skel->links.handle_kretprobe = kretprobe_link;
 
-	/* auto-attachable kprobe and kretprobe */
-	skel->links.handle_kprobe_auto = bpf_program__attach(skel->progs.handle_kprobe_auto);
-	ASSERT_OK_PTR(skel->links.handle_kprobe_auto, "attach_kprobe_auto");
-
-	skel->links.handle_kretprobe_auto = bpf_program__attach(skel->progs.handle_kretprobe_auto);
-	ASSERT_OK_PTR(skel->links.handle_kretprobe_auto, "attach_kretprobe_auto");
-
-	if (!legacy)
-		ASSERT_EQ(uprobe_ref_ctr, 0, "uprobe_ref_ctr_before");
-
+	/* manual-attach uprobe/uretprobe */
+	uprobe_opts.ref_ctr_offset = 0;
 	uprobe_opts.retprobe = false;
-	uprobe_opts.ref_ctr_offset = legacy ? 0 : ref_ctr_offset;
 	uprobe_link = bpf_program__attach_uprobe_opts(skel->progs.handle_uprobe,
 						      0 /* self pid */,
 						      "/proc/self/exe",
 						      uprobe_offset,
 						      &uprobe_opts);
 	if (!ASSERT_OK_PTR(uprobe_link, "attach_uprobe"))
-		goto cleanup;
+		return;
 	skel->links.handle_uprobe = uprobe_link;
 
-	if (!legacy)
-		ASSERT_GT(uprobe_ref_ctr, 0, "uprobe_ref_ctr_after");
-
-	/* if uprobe uses ref_ctr, uretprobe has to use ref_ctr as well */
 	uprobe_opts.retprobe = true;
-	uprobe_opts.ref_ctr_offset = legacy ? 0 : ref_ctr_offset;
 	uretprobe_link = bpf_program__attach_uprobe_opts(skel->progs.handle_uretprobe,
 							 -1 /* any pid */,
 							 "/proc/self/exe",
 							 uprobe_offset, &uprobe_opts);
 	if (!ASSERT_OK_PTR(uretprobe_link, "attach_uretprobe"))
-		goto cleanup;
+		return;
 	skel->links.handle_uretprobe = uretprobe_link;
 
-	/* verify auto-attach fails for old-style uprobe definition */
-	uprobe_err_link = bpf_program__attach(skel->progs.handle_uprobe_byname);
-	if (!ASSERT_EQ(libbpf_get_error(uprobe_err_link), -EOPNOTSUPP,
-		       "auto-attach should fail for old-style name"))
-		goto cleanup;
-
+	/* attach uprobe by function name manually */
 	uprobe_opts.func_name = "trigger_func2";
 	uprobe_opts.retprobe = false;
 	uprobe_opts.ref_ctr_offset = 0;
@@ -136,13 +90,62 @@ void test_attach_probe(void)
 							"/proc/self/exe",
 							0, &uprobe_opts);
 	if (!ASSERT_OK_PTR(skel->links.handle_uprobe_byname, "attach_uprobe_byname"))
-		goto cleanup;
+		return;
+
+	/* trigger & validate kprobe && kretprobe */
+	usleep(1);
+
+	/* trigger & validate uprobe & uretprobe */
+	trigger_func();
+
+	/* trigger & validate uprobe attached by name */
+	trigger_func2();
+
+	ASSERT_EQ(skel->bss->kprobe_res, 1, "check_kprobe_res");
+	ASSERT_EQ(skel->bss->kretprobe_res, 2, "check_kretprobe_res");
+	ASSERT_EQ(skel->bss->uprobe_res, 3, "check_uprobe_res");
+	ASSERT_EQ(skel->bss->uretprobe_res, 4, "check_uretprobe_res");
+	ASSERT_EQ(skel->bss->uprobe_byname_res, 5, "check_uprobe_byname_res");
+}
+
+static void test_attach_probe_auto(struct test_attach_probe *skel)
+{
+	struct bpf_link *uprobe_err_link;
+
+	/* auto-attachable kprobe and kretprobe */
+	skel->links.handle_kprobe_auto = bpf_program__attach(skel->progs.handle_kprobe_auto);
+	ASSERT_OK_PTR(skel->links.handle_kprobe_auto, "attach_kprobe_auto");
+
+	skel->links.handle_kretprobe_auto = bpf_program__attach(skel->progs.handle_kretprobe_auto);
+	ASSERT_OK_PTR(skel->links.handle_kretprobe_auto, "attach_kretprobe_auto");
+
+	/* verify auto-attach fails for old-style uprobe definition */
+	uprobe_err_link = bpf_program__attach(skel->progs.handle_uprobe_byname);
+	if (!ASSERT_EQ(libbpf_get_error(uprobe_err_link), -EOPNOTSUPP,
+		       "auto-attach should fail for old-style name"))
+		return;
 
 	/* verify auto-attach works */
 	skel->links.handle_uretprobe_byname =
 			bpf_program__attach(skel->progs.handle_uretprobe_byname);
 	if (!ASSERT_OK_PTR(skel->links.handle_uretprobe_byname, "attach_uretprobe_byname"))
-		goto cleanup;
+		return;
+
+	/* trigger & validate kprobe && kretprobe */
+	usleep(1);
+
+	/* trigger & validate uprobe attached by name */
+	trigger_func2();
+
+	ASSERT_EQ(skel->bss->kprobe2_res, 11, "check_kprobe_auto_res");
+	ASSERT_EQ(skel->bss->kretprobe2_res, 22, "check_kretprobe_auto_res");
+	ASSERT_EQ(skel->bss->uretprobe_byname_res, 6, "check_uretprobe_byname_res");
+}
+
+static void test_uprobe_lib(struct test_attach_probe *skel)
+{
+	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
+	FILE *devnull;
 
 	/* test attach by name for a library function, using the library
 	 * as the binary argument. libc.so.6 will be resolved via dlopen()/dlinfo().
@@ -155,7 +158,7 @@ void test_attach_probe(void)
 							"libc.so.6",
 							0, &uprobe_opts);
 	if (!ASSERT_OK_PTR(skel->links.handle_uprobe_byname2, "attach_uprobe_byname2"))
-		goto cleanup;
+		return;
 
 	uprobe_opts.func_name = "fclose";
 	uprobe_opts.retprobe = true;
@@ -165,62 +168,137 @@ void test_attach_probe(void)
 							"libc.so.6",
 							0, &uprobe_opts);
 	if (!ASSERT_OK_PTR(skel->links.handle_uretprobe_byname2, "attach_uretprobe_byname2"))
+		return;
+
+	/* trigger & validate shared library u[ret]probes attached by name */
+	devnull = fopen("/dev/null", "r");
+	fclose(devnull);
+
+	ASSERT_EQ(skel->bss->uprobe_byname2_res, 7, "check_uprobe_byname2_res");
+	ASSERT_EQ(skel->bss->uretprobe_byname2_res, 8, "check_uretprobe_byname2_res");
+}
+
+static void test_uprobe_ref_ctr(struct test_attach_probe *skel)
+{
+	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
+	struct bpf_link *uprobe_link, *uretprobe_link;
+	ssize_t uprobe_offset, ref_ctr_offset;
+
+	uprobe_offset = get_uprobe_offset(&trigger_func4);
+	if (!ASSERT_GE(uprobe_offset, 0, "uprobe_offset_ref_ctr"))
+		return;
+
+	ref_ctr_offset = get_rel_offset((uintptr_t)&uprobe_ref_ctr);
+	if (!ASSERT_GE(ref_ctr_offset, 0, "ref_ctr_offset"))
+		return;
+
+	ASSERT_EQ(uprobe_ref_ctr, 0, "uprobe_ref_ctr_before");
+
+	uprobe_opts.retprobe = false;
+	uprobe_opts.ref_ctr_offset = ref_ctr_offset;
+	uprobe_link = bpf_program__attach_uprobe_opts(skel->progs.handle_uprobe_ref_ctr,
+						      0 /* self pid */,
+						      "/proc/self/exe",
+						      uprobe_offset,
+						      &uprobe_opts);
+	if (!ASSERT_OK_PTR(uprobe_link, "attach_uprobe_ref_ctr"))
+		return;
+	skel->links.handle_uprobe_ref_ctr = uprobe_link;
+
+	ASSERT_GT(uprobe_ref_ctr, 0, "uprobe_ref_ctr_after");
+
+	/* if uprobe uses ref_ctr, uretprobe has to use ref_ctr as well */
+	uprobe_opts.retprobe = true;
+	uprobe_opts.ref_ctr_offset = ref_ctr_offset;
+	uretprobe_link = bpf_program__attach_uprobe_opts(skel->progs.handle_uretprobe_ref_ctr,
+							 -1 /* any pid */,
+							 "/proc/self/exe",
+							 uprobe_offset, &uprobe_opts);
+	if (!ASSERT_OK_PTR(uretprobe_link, "attach_uretprobe_ref_ctr"))
+		return;
+	skel->links.handle_uretprobe_ref_ctr = uretprobe_link;
+}
+
+static void test_kprobe_sleepable(void)
+{
+	struct test_attach_kprobe_sleepable *skel;
+
+	skel = test_attach_kprobe_sleepable__open();
+	if (!ASSERT_OK_PTR(skel, "skel_kprobe_sleepable_open"))
+		return;
+
+	/* sleepable kprobe test case needs flags set before loading */
+	if (!ASSERT_OK(bpf_program__set_flags(skel->progs.handle_kprobe_sleepable,
+		BPF_F_SLEEPABLE), "kprobe_sleepable_flags"))
+		goto cleanup;
+
+	if (!ASSERT_OK(test_attach_kprobe_sleepable__load(skel),
+		       "skel_kprobe_sleepable_load"))
 		goto cleanup;
 
 	/* sleepable kprobes should not attach successfully */
 	skel->links.handle_kprobe_sleepable = bpf_program__attach(skel->progs.handle_kprobe_sleepable);
-	if (!ASSERT_ERR_PTR(skel->links.handle_kprobe_sleepable, "attach_kprobe_sleepable"))
-		goto cleanup;
+	ASSERT_ERR_PTR(skel->links.handle_kprobe_sleepable, "attach_kprobe_sleepable");
+
+cleanup:
+	test_attach_kprobe_sleepable__destroy(skel);
+}
 
+static void test_uprobe_sleepable(struct test_attach_probe *skel)
+{
 	/* test sleepable uprobe and uretprobe variants */
 	skel->links.handle_uprobe_byname3_sleepable = bpf_program__attach(skel->progs.handle_uprobe_byname3_sleepable);
 	if (!ASSERT_OK_PTR(skel->links.handle_uprobe_byname3_sleepable, "attach_uprobe_byname3_sleepable"))
-		goto cleanup;
+		return;
 
 	skel->links.handle_uprobe_byname3 = bpf_program__attach(skel->progs.handle_uprobe_byname3);
 	if (!ASSERT_OK_PTR(skel->links.handle_uprobe_byname3, "attach_uprobe_byname3"))
-		goto cleanup;
+		return;
 
 	skel->links.handle_uretprobe_byname3_sleepable = bpf_program__attach(skel->progs.handle_uretprobe_byname3_sleepable);
 	if (!ASSERT_OK_PTR(skel->links.handle_uretprobe_byname3_sleepable, "attach_uretprobe_byname3_sleepable"))
-		goto cleanup;
+		return;
 
 	skel->links.handle_uretprobe_byname3 = bpf_program__attach(skel->progs.handle_uretprobe_byname3);
 	if (!ASSERT_OK_PTR(skel->links.handle_uretprobe_byname3, "attach_uretprobe_byname3"))
-		goto cleanup;
+		return;
 
 	skel->bss->user_ptr = test_data;
 
-	/* trigger & validate kprobe && kretprobe */
-	usleep(1);
-
-	/* trigger & validate shared library u[ret]probes attached by name */
-	devnull = fopen("/dev/null", "r");
-	fclose(devnull);
-
-	/* trigger & validate uprobe & uretprobe */
-	trigger_func();
-
-	/* trigger & validate uprobe attached by name */
-	trigger_func2();
-
 	/* trigger & validate sleepable uprobe attached by name */
 	trigger_func3();
 
-	ASSERT_EQ(skel->bss->kprobe_res, 1, "check_kprobe_res");
-	ASSERT_EQ(skel->bss->kprobe2_res, 11, "check_kprobe_auto_res");
-	ASSERT_EQ(skel->bss->kretprobe_res, 2, "check_kretprobe_res");
-	ASSERT_EQ(skel->bss->kretprobe2_res, 22, "check_kretprobe_auto_res");
-	ASSERT_EQ(skel->bss->uprobe_res, 3, "check_uprobe_res");
-	ASSERT_EQ(skel->bss->uretprobe_res, 4, "check_uretprobe_res");
-	ASSERT_EQ(skel->bss->uprobe_byname_res, 5, "check_uprobe_byname_res");
-	ASSERT_EQ(skel->bss->uretprobe_byname_res, 6, "check_uretprobe_byname_res");
-	ASSERT_EQ(skel->bss->uprobe_byname2_res, 7, "check_uprobe_byname2_res");
-	ASSERT_EQ(skel->bss->uretprobe_byname2_res, 8, "check_uretprobe_byname2_res");
 	ASSERT_EQ(skel->bss->uprobe_byname3_sleepable_res, 9, "check_uprobe_byname3_sleepable_res");
 	ASSERT_EQ(skel->bss->uprobe_byname3_res, 10, "check_uprobe_byname3_res");
 	ASSERT_EQ(skel->bss->uretprobe_byname3_sleepable_res, 11, "check_uretprobe_byname3_sleepable_res");
 	ASSERT_EQ(skel->bss->uretprobe_byname3_res, 12, "check_uretprobe_byname3_res");
+}
+
+void test_attach_probe(void)
+{
+	struct test_attach_probe *skel;
+
+	skel = test_attach_probe__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	if (!ASSERT_OK(test_attach_probe__load(skel), "skel_load"))
+		goto cleanup;
+	if (!ASSERT_OK_PTR(skel->bss, "check_bss"))
+		goto cleanup;
+
+	if (test__start_subtest("manual"))
+		test_attach_probe_manual(skel);
+	if (test__start_subtest("auto"))
+		test_attach_probe_auto(skel);
+	if (test__start_subtest("kprobe-sleepable"))
+		test_kprobe_sleepable();
+	if (test__start_subtest("uprobe-lib"))
+		test_uprobe_lib(skel);
+	if (test__start_subtest("uprobe-sleepable"))
+		test_uprobe_sleepable(skel);
+	if (test__start_subtest("uprobe-ref_ctr"))
+		test_uprobe_ref_ctr(skel);
 
 cleanup:
 	test_attach_probe__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/test_attach_kprobe_sleepable.c b/tools/testing/selftests/bpf/progs/test_attach_kprobe_sleepable.c
new file mode 100644
index 000000000000..f548b7446218
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_attach_kprobe_sleepable.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2017 Facebook
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+
+int kprobe_res = 0;
+
+/**
+ * This program will be manually made sleepable on the userspace side
+ * and should thus be unattachable.
+ */
+SEC("kprobe/" SYS_PREFIX "sys_nanosleep")
+int handle_kprobe_sleepable(struct pt_regs *ctx)
+{
+	kprobe_res = 1;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_attach_probe.c b/tools/testing/selftests/bpf/progs/test_attach_probe.c
index 3b5dc34d23e9..9e1e7163bb67 100644
--- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
+++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
@@ -37,17 +37,6 @@ int BPF_KSYSCALL(handle_kprobe_auto, struct __kernel_timespec *req, struct __ker
 	return 0;
 }
 
-/**
- * This program will be manually made sleepable on the userspace side
- * and should thus be unattachable.
- */
-SEC("kprobe/" SYS_PREFIX "sys_nanosleep")
-int handle_kprobe_sleepable(struct pt_regs *ctx)
-{
-	kprobe_res = 2;
-	return 0;
-}
-
 SEC("kretprobe")
 int handle_kretprobe(struct pt_regs *ctx)
 {
@@ -76,6 +65,18 @@ int handle_uretprobe(struct pt_regs *ctx)
 	return 0;
 }
 
+SEC("uprobe")
+int handle_uprobe_ref_ctr(struct pt_regs *ctx)
+{
+	return 0;
+}
+
+SEC("uretprobe")
+int handle_uretprobe_ref_ctr(struct pt_regs *ctx)
+{
+	return 0;
+}
+
 SEC("uprobe")
 int handle_uprobe_byname(struct pt_regs *ctx)
 {
-- 
2.39.0

