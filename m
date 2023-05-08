Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E3B6FB555
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjEHQjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234487AbjEHQjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:39:15 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 871E67D90;
        Mon,  8 May 2023 09:38:42 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9D0A020EAB61;
        Mon,  8 May 2023 09:37:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9D0A020EAB61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1683563875;
        bh=619vZH/u8ZKHe8WztDOCegjG93XriIN5oN4z6sx0MF0=;
        h=From:To:Cc:Subject:Date:From;
        b=hS+pwD/Coaj8gv1/NN07JyrdxPohkxinxTv26gL7xRww7K8yGVMHJfpkjkbGO3mII
         yfCCnBvoMomuZPmqr4e8UElDQpwov7kCzTooBMVCD4R0TkdFf7rgkSc+7+L1OxrvpX
         NfSSTp7WNgTnND0Knnql4o0G76ZIV8bRekJ0S5sQ=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH] tracing/user_events: Run BPF program if attached
Date:   Mon,  8 May 2023 09:37:51 -0700
Message-Id: <20230508163751.841-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Programs that utilize user_events today only get the event payloads via
perf or ftrace when writing event data. When BPF programs are attached
to tracepoints created by user_events the BPF programs do not get run
even though the attach succeeds. This causes confusion by the users of
the programs, as they expect the data to be available via BPF programs
they write. We have several projects that have hit this and requested
BPF program support when publishing data via user_events from their
user processes in production.

Swap out perf_trace_buf_submit() for perf_trace_run_bpf_submit() to
ensure BPF programs that are attached are run in addition to writing to
perf or ftrace buffers. This requires no changes to the BPF infrastructure
and only utilizes the GPL exported function that modules and other
components may use for the same purpose. This keeps user_events consistent
with how other kernel, modules, and probes expose tracepoint data to allow
attachment of a BPF program.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index b1ecd7677642..838fced40a41 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1422,11 +1422,12 @@ static void user_event_ftrace(struct user_event *user, struct iov_iter *i,
 static void user_event_perf(struct user_event *user, struct iov_iter *i,
 			    void *tpdata, bool *faulted)
 {
+	bool bpf_prog = bpf_prog_array_valid(&user->call);
 	struct hlist_head *perf_head;
 
 	perf_head = this_cpu_ptr(user->call.perf_events);
 
-	if (perf_head && !hlist_empty(perf_head)) {
+	if (perf_head && (!hlist_empty(perf_head) || bpf_prog)) {
 		struct trace_entry *perf_entry;
 		struct pt_regs *regs;
 		size_t size = sizeof(*perf_entry) + i->count;
@@ -1447,9 +1448,9 @@ static void user_event_perf(struct user_event *user, struct iov_iter *i,
 		    unlikely(user_event_validate(user, perf_entry, size)))
 			goto discard;
 
-		perf_trace_buf_submit(perf_entry, size, context,
-				      user->call.event.type, 1, regs,
-				      perf_head, NULL);
+		perf_trace_run_bpf_submit(perf_entry, size, context,
+					  &user->call, 1, regs,
+					  perf_head, NULL);
 
 		return;
 discard:

base-commit: 3862f86c1529fa0016de6344eb974877b4cd3838
-- 
2.25.1

