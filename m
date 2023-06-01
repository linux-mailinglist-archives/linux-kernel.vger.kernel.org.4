Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0611C7197DA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjFAJ4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjFAJyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:54:52 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2475E4A;
        Thu,  1 Jun 2023 02:54:25 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-ba827a34ba8so650563276.0;
        Thu, 01 Jun 2023 02:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685613257; x=1688205257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zaH3llwLH0tAOqLtLRXczT3GUAsS7Y/IWF3335BIolY=;
        b=hjXp5ZbI1tlJjDcPbCXmNufvqRSSz3s4oTdiksj4GKMDFAgA7NKlJNKqPq194EcYFX
         agZT+MCKNKTvwbDDwgys8q4pNgJYLaP2eDUbQI88Z+CVwNKP4TDaXJXoBGW12S4Ves/b
         8vQuXF6i8vcvWMuu/FwL9oVdtr8Kser1Q+PoN7o9Ww3DJZIpXh0OEHwbWM03uxW3T/Ne
         1aomh4hVxP7CLPShRYeWyyzWZyP82SY6We9BVv6KE0NdgF5qfQad4wZpddgFXMsu8TcB
         c0MOhAsYNk7ot4/OGY5EsRvtKUMtTdaUeV0r7LBot3cxhXCePo2qDw2j3lrYjh0cpS7r
         4Fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613257; x=1688205257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zaH3llwLH0tAOqLtLRXczT3GUAsS7Y/IWF3335BIolY=;
        b=bQjVcxDia4jXiwgEVz4ptryAXXgpBDSneiSHH5OUuRBJ6FxEYdpLw943uvWHhbUE5x
         zwO30kt571bRbVQXiD91mc4gopzSmP38IJPZF8zD0Swf0fulEZmHWEHQ/iu0HlrUumDi
         bZjovT1clHGOK8qyI0TWnXd0B8HwwXDscZ1IcflWxeWvux4EeSpy8Ix1b4jZ8Bky/dIh
         54YcofU6ZEGKi5Qsz2tc11GJ4IskO5GOgxZDp+IurlxbIaylZYIp4wnthOgLjCDeNuVr
         rgJl3r7yhcWUX1sGqmH8/h4ckrD1X6gjCPI2lhCy/qECXolaM04LR7D+t1cnc513eXVw
         k1/w==
X-Gm-Message-State: AC+VfDyrLFMc7jNbHnOZEjKL21Vs6QdwNEH6zyzHil3aHe08xcHwwjVb
        TgMlGVc0HpTMhp3BPm5nyNk=
X-Google-Smtp-Source: ACHHUZ550rvMwrfRHsgbKHeknHaOLsAcymRaAlrrMsiLxm58P0Ro0s262Yno9vUoRwSdC02V4Zp48A==
X-Received: by 2002:a25:db83:0:b0:b9e:6d83:7bcf with SMTP id g125-20020a25db83000000b00b9e6d837bcfmr8351546ybf.27.1685613257117;
        Thu, 01 Jun 2023 02:54:17 -0700 (PDT)
Received: from ism-manjaro.realtek.com.tw (125-227-180-151.hinet-ip.hinet.net. [125.227.180.151])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090276ca00b0019a5aa7eab0sm3030356plt.54.2023.06.01.02.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 02:54:16 -0700 (PDT)
From:   Ism Hong <ism.hong@gmail.com>
To:     ism.hong@realtek.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Ism Hong <ism.hong@gmail.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: perf: Fix callchain parse error with kernel tracepoint events
Date:   Thu,  1 Jun 2023 17:53:55 +0800
Message-Id: <20230601095355.1168910-1-ism.hong@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For RISC-V, when tracing with tracepoint events, the IP and status are
set to 0, preventing the perf code parsing the callchain and resolving
the symbols correctly.

 ./ply 'tracepoint:kmem/kmem_cache_alloc { @[stack]=count(); }'
 @:
 { <STACKID4294967282> }: 1

The fix is to implement perf_arch_fetch_caller_regs for riscv, which
fills several necessary registers used for callchain unwinding,
including epc, sp, s0 and status. It's similar to commit b3eac0265bf6
("arm: perf: Fix callchain parse error with kernel tracepoint events")
and commit 5b09a094f2fb ("arm64: perf: Fix callchain parse error with
kernel tracepoint events").

With this patch, callchain can be parsed correctly as:

 ./ply 'tracepoint:kmem/kmem_cache_alloc { @[stack]=count(); }'
 @:
 {
         __traceiter_kmem_cache_alloc+68
         __traceiter_kmem_cache_alloc+68
         kmem_cache_alloc+354
         __sigqueue_alloc+94
         __send_signal_locked+646
         send_signal_locked+154
         do_send_sig_info+84
         __kill_pgrp_info+130
         kill_pgrp+60
         isig+150
         n_tty_receive_signal_char+36
         n_tty_receive_buf_standard+2214
         n_tty_receive_buf_common+280
         n_tty_receive_buf2+26
         tty_ldisc_receive_buf+34
         tty_port_default_receive_buf+62
         flush_to_ldisc+158
         process_one_work+458
         worker_thread+138
         kthread+178
         riscv_cpufeature_patch_func+832
  }: 1

This patch works both on RV32/RV64.

Signed-off-by: Ism Hong <ism.hong@gmail.com>
---
 arch/riscv/include/asm/perf_event.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/include/asm/perf_event.h b/arch/riscv/include/asm/perf_event.h
index d42c901f9a97..665bbc9b2f84 100644
--- a/arch/riscv/include/asm/perf_event.h
+++ b/arch/riscv/include/asm/perf_event.h
@@ -10,4 +10,11 @@
 
 #include <linux/perf_event.h>
 #define perf_arch_bpf_user_pt_regs(regs) (struct user_regs_struct *)regs
+
+#define perf_arch_fetch_caller_regs(regs, __ip) { \
+	(regs)->epc = (__ip); \
+	(regs)->s0 = (unsigned long) __builtin_frame_address(0); \
+	(regs)->sp = current_stack_pointer; \
+	(regs)->status = SR_PP; \
+}
 #endif /* _ASM_RISCV_PERF_EVENT_H */
-- 
2.37.2

