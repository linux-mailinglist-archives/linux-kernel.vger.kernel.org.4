Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D959B63164B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 21:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiKTUMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 15:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiKTUMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 15:12:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276A9F2F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 12:12:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C85CFB80B7F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 20:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CEBC4314D;
        Sun, 20 Nov 2022 20:12:23 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1owqfu-00DiYX-2R;
        Sun, 20 Nov 2022 15:12:22 -0500
Message-ID: <20221120201222.632754356@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 20 Nov 2022 15:12:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rafael Mendonca <rafaelmendsr@gmail.com>
Subject: [for-linus][PATCH 6/7] tracing/eprobe: Fix warning in filter creation
References: <20221120201156.868430827@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael Mendonca <rafaelmendsr@gmail.com>

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

Link: https://lore.kernel.org/all/20221108202148.1020111-1-rafaelmendsr@gmail.com/

Fixes: 752be5c5c910 ("tracing/eprobe: Add eprobe filter support")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_eprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index fe4833a7b7b3..e888446d80fa 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -901,7 +901,7 @@ static int trace_eprobe_tp_update_arg(struct trace_eprobe *ep, const char *argv[
 
 static int trace_eprobe_parse_filter(struct trace_eprobe *ep, int argc, const char *argv[])
 {
-	struct event_filter *dummy;
+	struct event_filter *dummy = NULL;
 	int i, ret, len = 0;
 	char *p;
 
-- 
2.35.1


