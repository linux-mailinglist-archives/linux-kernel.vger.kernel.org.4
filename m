Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178826426A6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiLEKYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiLEKXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:23:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5689518E24
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 02:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670235719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Tz1CTZfjZXf6X6nP9mO/30eW25Wox/j1ITKdav6l++Y=;
        b=P7PVDssqdGKNEZQSNptGjJKUOUggBJeuoiPBPiLNpFuPZsVEj7gBBFUrqb41r71qhff4f8
        GcMKao8xNYs+I6ed6eRS7REcmTXWUfTC2zXvz1tqmTGBWP6syMF3RhmqlZ5b3zeWdy2khA
        waGJ/0q4EzxWroeskHleE0O9MPatlvw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-328-hPQmErVbOWqpoDTAgFsznA-1; Mon, 05 Dec 2022 05:21:56 -0500
X-MC-Unique: hPQmErVbOWqpoDTAgFsznA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E849E101A52A;
        Mon,  5 Dec 2022 10:21:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66D1AC19145;
        Mon,  5 Dec 2022 10:21:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2] trace: Fix some checker warnings
From:   David Howells <dhowells@redhat.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org
Date:   Mon, 05 Dec 2022 10:21:52 +0000
Message-ID: <167023571258.382307.15314866482834835192.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some checker warnings in the trace code by adding __printf attributes
to a number of trace functions and their declarations.

Changes:
========
ver #2)
 - Dropped the fix for the unconditional tracing_max_lat_fops decl[1].

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steven Rostedt <rostedt@goodmis.org>
cc: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20221205180617.9b9d3971cbe06ee536603523@kernel.org/ [1]
Link: https://lore.kernel.org/r/166992525941.1716618.13740663757583361463.stgit@warthog.procyon.org.uk/ # v1
---

 include/linux/trace_events.h |    3 ++-
 include/linux/trace_seq.h    |    3 ++-
 kernel/trace/trace.h         |    2 +-
 kernel/trace/trace_output.c  |    5 +++--
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 20749bd9db71..112b08ca2c5c 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -235,7 +235,8 @@ void tracing_record_taskinfo_sched_switch(struct task_struct *prev,
 void tracing_record_cmdline(struct task_struct *task);
 void tracing_record_tgid(struct task_struct *task);
 
-int trace_output_call(struct trace_iterator *iter, char *name, char *fmt, ...);
+int trace_output_call(struct trace_iterator *iter, char *name, char *fmt, ...)
+	 __printf(3, 4);
 
 struct event_filter;
 
diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 5a2c650d9e1c..0c4c7587d6c3 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -97,7 +97,8 @@ extern int trace_seq_hex_dump(struct trace_seq *s, const char *prefix_str,
 			      const void *buf, size_t len, bool ascii);
 
 #else /* CONFIG_TRACING */
-static inline void trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
+static inline __printf(2, 3)
+void trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
 {
 }
 static inline void
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index d42e24507152..ecc6120116da 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -615,7 +615,7 @@ void trace_buffer_unlock_commit_nostack(struct trace_buffer *buffer,
 bool trace_is_tracepoint_string(const char *str);
 const char *trace_event_format(struct trace_iterator *iter, const char *fmt);
 void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
-			 va_list ap);
+			 va_list ap) __printf(2, 0);
 
 int trace_empty(struct trace_iterator *iter);
 
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 67f47ea27921..7039cd883c8b 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -323,8 +323,9 @@ void trace_event_printf(struct trace_iterator *iter, const char *fmt, ...)
 }
 EXPORT_SYMBOL(trace_event_printf);
 
-static int trace_output_raw(struct trace_iterator *iter, char *name,
-			    char *fmt, va_list ap)
+static __printf(3, 0)
+int trace_output_raw(struct trace_iterator *iter, char *name,
+		     char *fmt, va_list ap)
 {
 	struct trace_seq *s = &iter->seq;
 


