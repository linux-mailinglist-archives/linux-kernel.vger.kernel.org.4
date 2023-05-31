Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907C5718B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 22:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjEaUcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 16:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEaUcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 16:32:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F56A121;
        Wed, 31 May 2023 13:32:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2563ca70f64so3506559a91.0;
        Wed, 31 May 2023 13:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685565158; x=1688157158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BDeWfB4xjTkyjMadKYZ6fSoKNmRXb/Jhz3U7/1RbuHU=;
        b=LxUuGyHqh6epH41m7zvafxG1By7DF4yth9KckI+v2cYmO6NIG7nCFopDVVmndfIUtg
         +Q1bZWCbE/YVr4py3+irwKdC22FfWSO6EkUbpD6NidoTlXAehPU1GS64VrjNZCXzQb45
         e1j0vqV+4WBu4SR1w0Rn9cpGzWgd6nGCLzLnYkngaD4n+7FVmQit+4xS3a8O1Z18Bneb
         ubzJ0W4S//6EKMiej2DicpzVc7Rbub+1kYz3auvCds17220IJ0xENMD8kEL32ymgMz4j
         2BGaUDj/ho8Dv2cuoFpMqXyrgHoUobe8yj9Zo6a6f8Oh/amnukcDZnyNVvljBuB9pd6r
         ay3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685565158; x=1688157158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDeWfB4xjTkyjMadKYZ6fSoKNmRXb/Jhz3U7/1RbuHU=;
        b=SB37w6nJ8Pmdo6dWuy7Irw8oMUfDXabsrjjteKHaK2C2k/X65M5w3tiiXsFMBwerRK
         i4YFxc1zrxp7FrYe9aAM8nMh/WF0fZ8e/VjE2NvOS+o40e6oe/nZGecbninAjeKfoQXr
         qdCqjIsE0qTilcvyAPn4t6IFeVrEwqBwtORhp4QngqUquguNqAIFydMkJNHXeI+3IEhD
         bt3gobSAuWxuOWxXCjedu5LsJrzhWUUJ4s4c6pTyLZ3xSFdkodJEKMivNUNzhU87hbQS
         5lbNvvN77mCyNTmnd2H6+T/31ZhZQN+zLceGF6RxMdmovrtOOXrrEbQ8xKW/Q96j7ywL
         7ssw==
X-Gm-Message-State: AC+VfDzMwY3BbFHbuYz8rKRLnO647gAcvmW/7ZpdVxYUFNOajiDGZC86
        p84TcBCVKS2TLpG7nC08BTQ=
X-Google-Smtp-Source: ACHHUZ7LSH2pI8sroJzw926L/WGgPkgJbF8dfNbOJHH2X5WS+TvZDRTY5eJ6+2vb50wJCO1hRcblfw==
X-Received: by 2002:a17:90a:5081:b0:256:82c0:8120 with SMTP id s1-20020a17090a508100b0025682c08120mr5351254pjh.13.1685565157857;
        Wed, 31 May 2023 13:32:37 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6700:7f00:ba31:75fe:e7e6:ccf7])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090a49c900b002508d73f4e8sm1611472pjm.57.2023.05.31.13.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 13:32:37 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf script: Increase PID/TID width for output
Date:   Wed, 31 May 2023 13:32:36 -0700
Message-ID: <20230531203236.1602054-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On large systems, it's common that PID/TID is bigger than 5-digit and it
makes the output unaligned.  Let's increase the width to 7.

Before:

  $ perf script
  ...
           swapper     0 [006] 1540823.803935:    1369324 cycles:P:  ffffffff9c755588 ktime_get+0x18 ([kernel.kallsyms])
       gvfsd-dnssd 95114 [004] 1540823.804164:    1643871 cycles:P:  ffffffff9cfdca5c __get_user_8+0x1c ([kernel.kallsyms])
         perf-exec 1558582 [000] 1540823.804209:    1018714 cycles:P:  ffffffff9c924ab9 __slab_free+0x9 ([kernel.kallsyms])
             nmcli 1558589 [007] 1540823.804384:    1859212 cycles:P:      7f70537a8ad8 __strchrnul_evex+0x18 (/usr/lib/x86_64-linux-gnu/libc.so.6>
             sleep 1558582 [000] 1540823.804456:     987425 cycles:P:      7fd35bb27b30 _dl_init+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2>
       dbus-daemon  3043 [003] 1540823.804575:    1564465 cycles:P:  ffffffff9cb2bb70 llist_add_batch+0x0 ([kernel.kallsyms])
             gdbus 1558592 [001] 1540823.804766:    1315219 cycles:P:  ffffffff9c797b2e audit_filter_syscall+0x9e ([kernel.kallsyms])
    NetworkManager  3452 [005] 1540823.805301:    1558782 cycles:P:      7fa957737748 g_bit_lock+0x58 (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.5>

After:

  $ perf script
  ...
           swapper       0 [006] 1540823.803935:    1369324 cycles:P:  ffffffff9c755588 ktime_get+0x18 ([kernel.kallsyms])
       gvfsd-dnssd   95114 [004] 1540823.804164:    1643871 cycles:P:  ffffffff9cfdca5c __get_user_8+0x1c ([kernel.kallsyms])
         perf-exec 1558582 [000] 1540823.804209:    1018714 cycles:P:  ffffffff9c924ab9 __slab_free+0x9 ([kernel.kallsyms])
             nmcli 1558589 [007] 1540823.804384:    1859212 cycles:P:      7f70537a8ad8 __strchrnul_evex+0x18 (/usr/lib/x86_64-linux-gnu/libc.so.6>
             sleep 1558582 [000] 1540823.804456:     987425 cycles:P:      7fd35bb27b30 _dl_init+0x0 (/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2>
       dbus-daemon    3043 [003] 1540823.804575:    1564465 cycles:P:  ffffffff9cb2bb70 llist_add_batch+0x0 ([kernel.kallsyms])
             gdbus 1558592 [001] 1540823.804766:    1315219 cycles:P:  ffffffff9c797b2e audit_filter_syscall+0x9e ([kernel.kallsyms])
    NetworkManager    3452 [005] 1540823.805301:    1558782 cycles:P:      7fa957737748 g_bit_lock+0x58 (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.5>

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-script.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 029d5a597233..70549fc93b12 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -801,11 +801,11 @@ static int perf_sample__fprintf_start(struct perf_script *script,
 	}
 
 	if (PRINT_FIELD(PID) && PRINT_FIELD(TID))
-		printed += fprintf(fp, "%5d/%-5d ", sample->pid, sample->tid);
+		printed += fprintf(fp, "%7d/%-7d ", sample->pid, sample->tid);
 	else if (PRINT_FIELD(PID))
-		printed += fprintf(fp, "%5d ", sample->pid);
+		printed += fprintf(fp, "%7d ", sample->pid);
 	else if (PRINT_FIELD(TID))
-		printed += fprintf(fp, "%5d ", sample->tid);
+		printed += fprintf(fp, "%7d ", sample->tid);
 
 	if (PRINT_FIELD(CPU)) {
 		if (latency_format)
-- 
2.41.0.rc0.172.g3f132b7071-goog

