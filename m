Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D834621D92
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 21:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiKHUXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 15:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKHUXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 15:23:11 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E7F69DE0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 12:23:09 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so17530282fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 12:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+8jJ7o1CwaCZwEmxeyjCFUIZlvLhXfNevYOHkTkoHvM=;
        b=TBNoyWUezq+wxdG94aaW1hH2NdaBhFRKfO1R1/yN1mS1tuc/evfkkttg8W7qwMb/AF
         iw+p1BAu1s0HisIhBQEqx3XWmvYBgTtUSXuY6RsEtRsMAI17X5bpvBv0eZB2CwWJf3W6
         rbiwbzhTy4QSEZ10zSb2L5NnsJ+6gT0ZeCIZ74ujJqIRbxP3ovE8WjFkrM19TomdXMb0
         xkGnQGK3U9VhNt8GtL9vN9n+lCIe+t6M7Ge+befCMy6EuJMrE33E9VgJuIsoOHeaSdOE
         /wSEfIoB5EJibHYaCIsPC3BuL/4XvoRntgBy1BHTzGFnfHU58seOgm1Pe1U7aaLrTAa3
         e0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8jJ7o1CwaCZwEmxeyjCFUIZlvLhXfNevYOHkTkoHvM=;
        b=3fxfKrsJ8ucTG0//OlVumieINXPu16LdH3J7NrMqiCVyqC/v6QwHt+mXPRild/elnG
         cG/aEf8mc3k1wAcQhnpcsqLeV4IwLbsu+zoxqhBJE4tT7yzYJx1c8vvW4HWKW4I9O9Pu
         fVITCm6P6Hdi9qdTsqCatLhcqGNwu7BIBDKDpbGlPpS5KyTS3eO02lKnB4Jk0bKE+V9T
         wLDxtuXSj7zICdgRnneLY5obC5xnj8UoI/XGL63JNuC9FPsN7mGFejGM5L4gTOhxT1DO
         7bRNxYRUoWyDRFws6ZJmwfueH+eOw9TprOSPbmOMWWP4DzRixAiyLUJY+SP3yDh7jDWM
         EX4w==
X-Gm-Message-State: ACrzQf0IGEbubH42n/u2xP+fC1YROYxbwQFz19aOfQMDQEIvwG/f3ibo
        qWuBFIb+B2wVa5QlB8YnBMw=
X-Google-Smtp-Source: AMsMyM4B3/C+JiJK67VpNHSLf69wLcwZ7XBPaslzJDMBzwPKP1cy+2/pPDaRmTWlzy8RIYnZbAr/7w==
X-Received: by 2002:a05:6871:794:b0:12c:4bff:341d with SMTP id o20-20020a056871079400b0012c4bff341dmr32220734oap.127.1667938987650;
        Tue, 08 Nov 2022 12:23:07 -0800 (PST)
Received: from macondo.. ([2804:431:e7cc:805:20d8:ca0b:7b1e:63d3])
        by smtp.gmail.com with ESMTPSA id o30-20020a056870911e00b0012779ba00fesm5121861oae.2.2022.11.08.12.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 12:23:07 -0800 (PST)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tracing/eprobe: Fix warning in filter creation
Date:   Tue,  8 Nov 2022 17:21:47 -0300
Message-Id: <20221108202148.1020111-1-rafaelmendsr@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The filter pointer (filterp) passed to create_filter() function must be a
pointer that references a NULL pointer, otherwise, we get a warning when
adding a filter option to the event probe:

root@localhost:/sys/kernel/tracing# echo 'e:egroup/stat_runtime_4core sched/sched_stat_runtime \
        runtime=$runtime:u32 if cpu < 4' >> dynamic_events
[ 5034.340439] ------------[ cut here ]------------
[ 5034.341258] WARNING: CPU: 0 PID: 223 at kernel/trace/trace_events_filter.c:1939 create_filter+0x1db/0x250
[...] stripped
[ 5034.345518] RIP: 0010:create_filter+0x1db/0x250
[...] stripped
[ 5034.351604] Call Trace:
[ 5034.351803]  <TASK>
[ 5034.351959]  ? process_preds+0x1b40/0x1b40
[ 5034.352241]  ? rcu_read_lock_bh_held+0xd0/0xd0
[ 5034.352604]  ? kasan_set_track+0x29/0x40
[ 5034.352904]  ? kasan_save_alloc_info+0x1f/0x30
[ 5034.353264]  create_event_filter+0x38/0x50
[ 5034.353573]  __trace_eprobe_create+0x16f4/0x1d20
[ 5034.353964]  ? eprobe_dyn_event_release+0x360/0x360
[ 5034.354363]  ? mark_held_locks+0xa6/0xf0
[ 5034.354684]  ? _raw_spin_unlock_irqrestore+0x35/0x60
[ 5034.355105]  ? trace_hardirqs_on+0x41/0x120
[ 5034.355417]  ? _raw_spin_unlock_irqrestore+0x35/0x60
[ 5034.355751]  ? __create_object+0x5b7/0xcf0
[ 5034.356027]  ? lock_is_held_type+0xaf/0x120
[ 5034.356362]  ? rcu_read_lock_bh_held+0xb0/0xd0
[ 5034.356716]  ? rcu_read_lock_bh_held+0xd0/0xd0
[ 5034.357084]  ? kasan_set_track+0x29/0x40
[ 5034.357411]  ? kasan_save_alloc_info+0x1f/0x30
[ 5034.357715]  ? __kasan_kmalloc+0xb8/0xc0
[ 5034.357985]  ? write_comp_data+0x2f/0x90
[ 5034.358302]  ? __sanitizer_cov_trace_pc+0x25/0x60
[ 5034.358691]  ? argv_split+0x381/0x460
[ 5034.358949]  ? write_comp_data+0x2f/0x90
[ 5034.359240]  ? eprobe_dyn_event_release+0x360/0x360
[ 5034.359620]  trace_probe_create+0xf6/0x110
[ 5034.359940]  ? trace_probe_match_command_args+0x240/0x240
[ 5034.360376]  eprobe_dyn_event_create+0x21/0x30
[ 5034.360709]  create_dyn_event+0xf3/0x1a0
[ 5034.360983]  trace_parse_run_command+0x1a9/0x2e0
[ 5034.361297]  ? dyn_event_release+0x500/0x500
[ 5034.361591]  dyn_event_write+0x39/0x50
[ 5034.361851]  vfs_write+0x311/0xe50
[ 5034.362091]  ? dyn_event_seq_next+0x40/0x40
[ 5034.362376]  ? kernel_write+0x5b0/0x5b0
[ 5034.362637]  ? write_comp_data+0x2f/0x90
[ 5034.362937]  ? __sanitizer_cov_trace_pc+0x25/0x60
[ 5034.363258]  ? ftrace_syscall_enter+0x544/0x840
[ 5034.363563]  ? write_comp_data+0x2f/0x90
[ 5034.363837]  ? __sanitizer_cov_trace_pc+0x25/0x60
[ 5034.364156]  ? write_comp_data+0x2f/0x90
[ 5034.364468]  ? write_comp_data+0x2f/0x90
[ 5034.364770]  ksys_write+0x158/0x2a0
[ 5034.365022]  ? __ia32_sys_read+0xc0/0xc0
[ 5034.365344]  __x64_sys_write+0x7c/0xc0
[ 5034.365669]  ? syscall_enter_from_user_mode+0x53/0x70
[ 5034.366084]  do_syscall_64+0x60/0x90
[ 5034.366356]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[ 5034.366767] RIP: 0033:0x7ff0b43938f3
[...] stripped
[ 5034.371892]  </TASK>
[ 5034.374720] ---[ end trace 0000000000000000 ]---

Fixes: 752be5c5c910 ("tracing/eprobe: Add eprobe filter support")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
---
 kernel/trace/trace_eprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 5dd0617e5df6..c2153bf59936 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -900,7 +900,7 @@ static int trace_eprobe_tp_update_arg(struct trace_eprobe *ep, const char *argv[
 
 static int trace_eprobe_parse_filter(struct trace_eprobe *ep, int argc, const char *argv[])
 {
-	struct event_filter *dummy;
+	struct event_filter *dummy = NULL;
 	int i, ret, len = 0;
 	char *p;
 
-- 
2.34.1

