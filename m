Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602DF62C8E9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 20:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbiKPT0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 14:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiKPT0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 14:26:10 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294E42E9C3;
        Wed, 16 Nov 2022 11:26:09 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-141ca09c2fbso11679606fac.6;
        Wed, 16 Nov 2022 11:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N0wiStqSoT+QOxZQv7R/HenLizI45o2PTA9zLLh/ev8=;
        b=gGbUWPpAiVSwFwgF33WUTuRMAtG+O8HEFi2Dv7Cx6iUghNNBAhk/JvuPhj92J37CqX
         jQF/Japrf7u5hsfz+DO6SpWbAOYRgkMYxDft5ItE/0bzc53bicX1KLW04oRYyP2sKk7b
         rVPGpbYnRAyrJ8vpwFPwCFfr9GlhQT/CDdiGh2rUaRT+OD2F90koTCObzxunoz7oaXjZ
         IMIgXDPU9gBnB2Tqs3sUr8d2MsDS0cIj4UYuaBn3duyHkP3I+rXwt+S0dT+BHDFwXjH+
         nuMH0YDWIhiz0947sJZBt4pPVFQCMOpLpmK39FETeWqp/3wse1AZh03CKFqShlWjIHl6
         BKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0wiStqSoT+QOxZQv7R/HenLizI45o2PTA9zLLh/ev8=;
        b=E74QYsnIkwgeD8ibnF9vn54wejLQB6t8LFmeuZWeXFh3S7umbtP8s4FRxtFusQNLNj
         tzTblgG7ywFe7jNk60IFdXHUoHjf+zmAM6i0AzAjJrDY5wBFWvZcbZb0DLzGcbbAaRTJ
         0hoMT752GSolNu7oLH9jyaLAHa0yLxKjGvauEGr3hzoBtbwK+htawLVVYV9mydAOuvPm
         /1bU26UHQxPZ/r9bRYC4GTBBKBnwmZmBcvTwQI8A49EhRr9MHWy6SaKqL/okI0SvRD5j
         i7oGMiFISoqnQZ/E60heCJT6ITWi5Lwh+jglUfLDxpZ+uPJOAEcmE3NbU28/iyM3W2iJ
         orGw==
X-Gm-Message-State: ANoB5pkKYinZeRUioNCYKpBU9kX8PEubkEi8s6AvjuAtfZsuSewQGpvy
        wJEmzYFlxXZkgOL+vM1Y9jU=
X-Google-Smtp-Source: AA0mqf6e8KWVX57BFNmqwgQtDKRztmzPjrRNugGMRBST+LLVavvr9EUnVvuFGkZV2aZDO3fgGqSiTQ==
X-Received: by 2002:a05:6870:5b96:b0:132:2bef:f802 with SMTP id em22-20020a0568705b9600b001322beff802mr2715192oab.249.1668626767405;
        Wed, 16 Nov 2022 11:26:07 -0800 (PST)
Received: from macondo.. ([2804:431:e7cc:5fdd:4ced:7530:d9f1:360b])
        by smtp.gmail.com with ESMTPSA id o39-20020a056870912700b0012d939eb0bfsm8414531oae.34.2022.11.16.11.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 11:26:06 -0800 (PST)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/eprobe: Update cond flag before enabling trigger
Date:   Wed, 16 Nov 2022 16:25:51 -0300
Message-Id: <20221116192552.1066630-1-rafaelmendsr@gmail.com>
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

The eprobe's trigger, for the event it is attached to, needs access to the
trace record in order to perform its function. This need is indicated by
the TRIGGER_COND flag and properly set by the update_cond_flag() function.
Currently, the cond flag is set after calling
trace_event_trigger_enable_disable(), which leaves a small time gap in
which the eprobe's trigger could be invoked without a trace record, causing
a NULL pointer dereference issue.

This issue can be easily reproduced by enabling an event probe for
kmem/mm_page_alloc using any of its fields as such:

root@localhost:/sys/kernel/tracing# echo 'e kmem/mm_page_alloc $gfp_flags' > dynamic_events
root@localhost:/sys/kernel/tracing# echo 1 > events/eprobes/enable
[   30.847000] general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN PTI
[   30.848618] KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
[   30.849498] CPU: 0 PID: 223 Comm: bash Not tainted 6.1.0-rc5+ #98
[...] stripped
[   30.850623] RIP: 0010:get_event_field.isra.0+0x1b8/0x3f0
[...] stripped
[   30.856173] Call Trace:
[   30.856340]  <TASK>
[   30.856489]  process_fetch_insn+0x1289/0x19b0
[   30.856789]  ? write_comp_data+0x2f/0x90
[   30.857061]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   30.857379]  ? __trace_eprobe_create+0x1d30/0x1d30
[   30.857701]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   30.858019]  ? write_comp_data+0x2f/0x90
[   30.858289]  ? write_comp_data+0x2f/0x90
[   30.858562]  eprobe_trigger_func+0x1253/0x2180
[   30.858867]  ? kasan_poison.part.0+0x3c/0x50
[   30.859165]  ? process_fetch_insn+0x19b0/0x19b0
[   30.859473]  ? get_page_from_freelist+0x10c1/0x29c0
[   30.859806]  ? rcu_read_lock_bh_held+0xd0/0xd0
[   30.860114]  ? write_comp_data+0x2f/0x90
[   30.860387]  event_triggers_call+0x293/0x410
[   30.860683]  __trace_trigger_soft_disabled+0xbb/0xe0
[   30.861019]  trace_event_raw_event_mm_page_alloc+0xb5/0xc0
[   30.861389]  __alloc_pages+0x4cd/0x760
[   30.861651]  ? __alloc_pages_slowpath.constprop.0+0x2480/0x2480
[   30.862047]  ? tracepoint_probe_register_prio_may_exist+0x100/0x100
[   30.862464]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   30.862780]  ? write_comp_data+0x2f/0x90
[   30.863055]  trace_buffered_event_enable+0xc6/0x440
[   30.863381]  __ftrace_event_enable_disable+0x16a/0x880
[   30.863728]  trace_event_enable_disable+0x2a/0x40
[   30.864043]  trace_event_trigger_enable_disable.part.0+0x70/0x90
[   30.864446]  trace_event_trigger_enable_disable+0x31/0xc0
[   30.864806]  eprobe_register+0x49a/0xdf0
[   30.865080]  ? disable_eprobe+0x370/0x370
[   30.865360]  ? mutex_unlock+0x16/0x20
[   30.865618]  ? write_comp_data+0x2f/0x90
[   30.865897]  __ftrace_event_enable_disable+0x4c1/0x880
[   30.866247]  __ftrace_set_clr_event_nolock+0x297/0x390
[   30.866598]  __ftrace_set_clr_event+0x43/0x70
[   30.866901]  system_enable_write+0x1f7/0x2a0
[   30.867214]  ? event_enable_write+0x290/0x290
[   30.867521]  ? rcu_read_lock_held+0xc0/0xc0
[   30.867842]  ? write_comp_data+0x2f/0x90
[   30.868176]  ? write_comp_data+0x2f/0x90
[   30.868467]  vfs_write+0x311/0xe50
[   30.868752]  ? event_enable_write+0x290/0x290
[   30.869067]  ? kernel_write+0x5b0/0x5b0
[   30.869329]  ? lockdep_hardirqs_on_prepare+0x410/0x410
[   30.869675]  ? lock_is_held_type+0xaf/0x120
[   30.869954]  ? close_fd+0x6e/0xb0
[   30.870182]  ? write_comp_data+0x2f/0x90
[   30.870453]  ? __sanitizer_cov_trace_pc+0x25/0x60
[   30.870772]  ? write_comp_data+0x2f/0x90
[   30.871043]  ? write_comp_data+0x2f/0x90
[   30.871315]  ksys_write+0x158/0x2a0
[   30.871558]  ? __ia32_sys_read+0xc0/0xc0
[   30.871827]  ? syscall_enter_from_user_mode+0x25/0x70
[   30.872169]  ? do_syscall_64+0x3b/0x90
[   30.872432]  __x64_sys_write+0x7c/0xc0
[   30.872691]  ? syscall_enter_from_user_mode+0x25/0x70
[   30.873028]  do_syscall_64+0x60/0x90
[   30.873279]  ? syscall_exit_to_user_mode+0x4a/0x60
[   30.873597]  ? do_syscall_64+0x6d/0x90
[   30.873857]  ? fpregs_assert_state_consistent+0x90/0xf0
[   30.874214]  ? syscall_exit_to_user_mode+0x4a/0x60
[   30.874535]  ? do_syscall_64+0x6d/0x90
[   30.874794]  ? do_syscall_64+0x6d/0x90
[   30.875118]  ? do_syscall_64+0x6d/0x90
[   30.875379]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   30.875712] RIP: 0033:0x7f7cc14da8f3
[...] stripped
[   30.879875]  </TASK>
[...] stripped
[   30.881930] ---[ end trace 0000000000000000 ]---
[   30.882237] RIP: 0010:get_event_field.isra.0+0x1b8/0x3f0
[...] stripped
[   30.887734] note: bash[223] exited with preempt_count 2

That happens because enable_eprobe() will eventually trigger the
kmem/mm_page_alloc trace event:

- enable_eprobe [trace_eprobe.c]
  - trace_event_trigger_enable_disable [trace_events_trigger.c]
    - trace_event_enable_disable [trace_events.c]
      - __ftrace_event_enable_disable [trace_events.c]
        - trace_buffered_event_enable [trace.c]
          - alloc_pages_node [gfp.h]
	   ...
            - __alloc_pages [page_alloc.c]
              - trace_mm_page_alloc // eprobe event file without TRIGGER_COND bit set

By the time kmem/mm_page_alloc trace event is hit, the eprobe event file
does not have the TRIGGER_COND flag set yet, which causes the eprobe's
trigger to be invoked (through the trace_trigger_soft_disabled() path)
without a trace record, causing a NULL pointer dereference when fetching
the event fields.

Fix this by setting the cond flag beforehand when enabling the eprobe's
trigger.

Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
---
 kernel/trace/trace_eprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 5dd0617e5df6..5004c6f6f232 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -677,8 +677,8 @@ static int enable_eprobe(struct trace_eprobe *ep,
 
 	list_add_tail_rcu(&trigger->list, &file->triggers);
 
-	trace_event_trigger_enable_disable(file, 1);
 	update_cond_flag(file);
+	trace_event_trigger_enable_disable(file, 1);
 
 	return 0;
 }

