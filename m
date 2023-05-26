Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CF6711EBF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 06:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjEZES0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 00:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbjEZESQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 00:18:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D3A1A8;
        Thu, 25 May 2023 21:18:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6F2964CB4;
        Fri, 26 May 2023 04:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD55EC433EF;
        Fri, 26 May 2023 04:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685074692;
        bh=iB6U30XiVWAQS2p/KZ8B8h9IpEUiIb2rQrKOiT2f/z0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o2wAT523ZgtvcL1RB07VAZfXZMzhmHMnf6rQJEm6GQ+dZqCqqqtP6ehqsnzLT7i7t
         fh46HthVaDMIfAP0+Zchp2m8u6kpa+PV/89OZB4qOL16Pkkvr/fh78FHRqpDLBGZj9
         H2S+6QlEQ5uYTRp79+baLf2jdyCI98s8t0v6aYVuTs0WHqqD6X8RPbYt7a/usPxRFk
         iRhWOVbo7fgBCV3L2l0hl7FLeDBsjG8gbfn9dEFZRCTuvh9FkYK6LqVouyWSK0p8uc
         08zMhG2dBbsIrVnahIBddDziIjKQTDeU3RQvEwoH8xVI75CIUKKw1UucwXuBRItYVO
         zjEzT9gUek8TA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v13 02/12] tracing/probes: Avoid setting TPARG_FL_FENTRY and TPARG_FL_RETURN
Date:   Fri, 26 May 2023 12:18:07 +0800
Message-ID:  <168507468731.913472.11354553441385410734.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To:  <168507466597.913472.10572827237387849017.stgit@mhiramat.roam.corp.google.com>
References:  <168507466597.913472.10572827237387849017.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

When parsing a kprobe event, the return probe always sets both
TPARG_FL_RETURN and TPARG_FL_FENTRY, but this is not useful because
some fetchargs are only for return probe and some others only for
function entry. Make it obviously mutual exclusive.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |    2 +-
 kernel/trace/trace_probe.h  |    5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 59cda19a9033..867ffb7ee31d 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -825,7 +825,7 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		if (is_return)
 			flags |= TPARG_FL_RETURN;
 		ret = kprobe_on_func_entry(NULL, symbol, offset);
-		if (ret == 0)
+		if (ret == 0 && !is_return)
 			flags |= TPARG_FL_FENTRY;
 		/* Defer the ENOENT case until register kprobe */
 		if (ret == -EINVAL && is_return) {
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index ef8ed3b65d05..752a08fcf0be 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -357,6 +357,11 @@ int trace_probe_print_args(struct trace_seq *s, struct probe_arg *args, int nr_a
 #define trace_probe_for_each_link_rcu(pos, tp)	\
 	list_for_each_entry_rcu(pos, &(tp)->event->files, list)
 
+/*
+ * The flags used for parsing trace_probe arguments.
+ * TPARG_FL_RETURN, TPARG_FL_FENTRY and TPARG_FL_TPOINT are mutually exclusive.
+ * TPARG_FL_KERNEL and TPARG_FL_USER are also mutually exclusive.
+ */
 #define TPARG_FL_RETURN BIT(0)
 #define TPARG_FL_KERNEL BIT(1)
 #define TPARG_FL_FENTRY BIT(2)

