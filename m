Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147997068BC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjEQM4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjEQM4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:56:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819E26E8E
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:56:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18D42646CD
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 12:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61242C433EF;
        Wed, 17 May 2023 12:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684328194;
        bh=N5w8zSa8G+0c9DkpbjE5wIaKBUm//T9/7Q6k5MttMfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uchGo/0hNRi3WLSo7De+RlxONVgD8OJPqYVjxWuzaj2A9/g+DTrC/u2XF3QdKsCqp
         xiODetgRLJ0K1RrqEUwzh77ytfS219TLPWyOQoinx4clc4O0qkeZ93kIuk2KeuRzw/
         ry2g0IvnbkmEgNL8KBD9F+JTdQAO99ZI1TnWacdtPnq/jG5cqG26On1N0cQruzK2dh
         i6gX9tgaDXTR1mXBu3e9V1k/hqB5Bck/7b/lQvZpcuhrj3spgl8Tmis4wlSxneZmND
         eXF+r1mtAWkZE5DLxiSdfSe4Z8x1YjoQtOHm/+RHhzX5MO9c8A0Bth6m7q6dbdhgyI
         Qcv54fzjRhIwQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Delyan Kratunov <delyank@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Menglong Dong <imagedong@tencent.com>,
        Yafang Shao <laoar.shao@gmail.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] bpf: add bpf_probe_read_kernel declaration
Date:   Wed, 17 May 2023 14:56:09 +0200
Message-Id: <20230517125617.931437-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230517125617.931437-1-arnd@kernel.org>
References: <20230517125617.931437-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

bpf_probe_read_kernel() has a __weak definition in core.c and another
definition with an incompatible prototype in kernel/trace/bpf_trace.c,
when CONFIG_BPF_EVENTS is enabled.

Since the two are incompatible, there cannot be a shared declaration
in a header file, but the lack of a prototype causes a W=1 warning:

kernel/bpf/core.c:1638:12: error: no previous prototype for 'bpf_probe_read_kernel' [-Werror=missing-prototypes]

Add a prototype directly in front of the function instead to shut
up the warning. Also, to avoid having an incompatible function override
the __weak definition, use an #ifdef to ensure that only one of the
two is ever defined.

I'm not sure what can be done to make the two prototypes match.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/bpf/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 6f5ede31e471..38762a784b86 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1635,11 +1635,14 @@ bool bpf_opcode_in_insntable(u8 code)
 }
 
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
-u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
+u64 bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr);
+#ifndef CONFIG_BPF_EVENTS
+u64 bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
 {
 	memset(dst, 0, size);
 	return -EFAULT;
 }
+#endif
 
 /**
  *	___bpf_prog_run - run eBPF program on a given context
-- 
2.39.2

