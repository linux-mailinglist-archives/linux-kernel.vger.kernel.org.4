Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237276939FC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 21:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBLUq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 15:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBLUq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 15:46:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75D7F757
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 12:46:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F2C9B80D3A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB937C433D2;
        Sun, 12 Feb 2023 20:46:22 +0000 (UTC)
Date:   Sun, 12 Feb 2023 15:46:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Qais Yousef <qyousef@layalina.io>,
        John Stultz <jstultz@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [GIT PULL] tracing: Fix TASK_COMM_LEN in trace event format file
Message-ID: <20230212154620.4d8fe033@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

tracing: Fix showing of TASK_COMM_LEN instead of its value

The TASK_COMM_LEN was converted from a macro into an enum so that BTF
would have access to it. But this unfortunately caused TASK_COMM_LEN to
display in the format fields of trace events, as they are created by the
TRACE_EVENT() macro and such, macros convert to their values, where as
enums do not (breaking some user space tooling).

To handle this, instead of using the field itself to be display, save the
value of the array size as another field in the trace_event_fields
structure, and use that instead. Not only does this fix the issue, but
also converts the other trace events that have this same problem (but were
not breaking tooling). With this change, the original work around for this
type of issue: b3bc8547d3be6 ("tracing: Have TRACE_DEFINE_ENUM affect trace
event types as well") could be reverted (but that should be done in the
merge window).


Please pull the latest trace-v6.2-rc7 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.2-rc7

Tag SHA1: 4729ba3e09c8eda3e2d2e9a7b36be14c4d644931
Head SHA1: b6c7abd1c28a63ad633433d037ee15a1bc3023ba


Yafang Shao (1):
      tracing: Fix TASK_COMM_LEN in trace event format file

----
 include/linux/trace_events.h               |  1 +
 include/trace/stages/stage4_event_fields.h |  3 ++-
 kernel/trace/trace.h                       |  1 +
 kernel/trace/trace_events.c                | 39 +++++++++++++++++++++++-------
 kernel/trace/trace_export.c                |  3 ++-
 5 files changed, 36 insertions(+), 11 deletions(-)
---------------------------
commit b6c7abd1c28a63ad633433d037ee15a1bc3023ba
Author: Yafang Shao <laoar.shao@gmail.com>
Date:   Sun Feb 12 15:13:03 2023 +0000

    tracing: Fix TASK_COMM_LEN in trace event format file
    
    After commit 3087c61ed2c4 ("tools/testing/selftests/bpf: replace open-coded 16 with TASK_COMM_LEN"),
    the content of the format file under
    /sys/kernel/tracing/events/task/task_newtask was changed from
      field:char comm[16];    offset:12;    size:16;    signed:0;
    to
      field:char comm[TASK_COMM_LEN];    offset:12;    size:16;    signed:0;
    
    John reported that this change breaks older versions of perfetto.
    Then Mathieu pointed out that this behavioral change was caused by the
    use of __stringify(_len), which happens to work on macros, but not on enum
    labels. And he also gave the suggestion on how to fix it:
      :One possible solution to make this more robust would be to extend
      :struct trace_event_fields with one more field that indicates the length
      :of an array as an actual integer, without storing it in its stringified
      :form in the type, and do the formatting in f_show where it belongs.
    
    The result as follows after this change,
    $ cat /sys/kernel/tracing/events/task/task_newtask/format
            field:char comm[16];    offset:12;      size:16;        signed:0;
    
    Link: https://lore.kernel.org/lkml/Y+QaZtz55LIirsUO@google.com/
    Link: https://lore.kernel.org/linux-trace-kernel/20230210155921.4610-1-laoar.shao@gmail.com/
    Link: https://lore.kernel.org/linux-trace-kernel/20230212151303.12353-1-laoar.shao@gmail.com
    
    Cc: stable@vger.kernel.org
    Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
    Cc: Kajetan Puchalski <kajetan.puchalski@arm.com>
    CC: Qais Yousef <qyousef@layalina.io>
    Fixes: 3087c61ed2c4 ("tools/testing/selftests/bpf: replace open-coded 16 with TASK_COMM_LEN")
    Reported-by: John Stultz <jstultz@google.com>
    Debugged-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Suggested-by: Steven Rostedt <rostedt@goodmis.org>
    Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 4342e996bcdb..0e373222a6df 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -270,6 +270,7 @@ struct trace_event_fields {
 			const int  align;
 			const int  is_signed;
 			const int  filter_type;
+			const int  len;
 		};
 		int (*define_fields)(struct trace_event_call *);
 	};
diff --git a/include/trace/stages/stage4_event_fields.h b/include/trace/stages/stage4_event_fields.h
index affd541fd25e..b6f679ae21aa 100644
--- a/include/trace/stages/stage4_event_fields.h
+++ b/include/trace/stages/stage4_event_fields.h
@@ -26,7 +26,8 @@
 #define __array(_type, _item, _len) {					\
 	.type = #_type"["__stringify(_len)"]", .name = #_item,		\
 	.size = sizeof(_type[_len]), .align = ALIGN_STRUCTFIELD(_type),	\
-	.is_signed = is_signed_type(_type), .filter_type = FILTER_OTHER },
+	.is_signed = is_signed_type(_type), .filter_type = FILTER_OTHER,\
+	.len = _len },
 
 #undef __dynamic_array
 #define __dynamic_array(_type, _item, _len) {				\
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 4eb6d6b97a9f..085a31b978a5 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1282,6 +1282,7 @@ struct ftrace_event_field {
 	int			offset;
 	int			size;
 	int			is_signed;
+	int			len;
 };
 
 struct prog_entry;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 33e0b4f8ebe6..6a4696719297 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -114,7 +114,7 @@ trace_find_event_field(struct trace_event_call *call, char *name)
 
 static int __trace_define_field(struct list_head *head, const char *type,
 				const char *name, int offset, int size,
-				int is_signed, int filter_type)
+				int is_signed, int filter_type, int len)
 {
 	struct ftrace_event_field *field;
 
@@ -133,6 +133,7 @@ static int __trace_define_field(struct list_head *head, const char *type,
 	field->offset = offset;
 	field->size = size;
 	field->is_signed = is_signed;
+	field->len = len;
 
 	list_add(&field->link, head);
 
@@ -150,14 +151,28 @@ int trace_define_field(struct trace_event_call *call, const char *type,
 
 	head = trace_get_fields(call);
 	return __trace_define_field(head, type, name, offset, size,
-				    is_signed, filter_type);
+				    is_signed, filter_type, 0);
 }
 EXPORT_SYMBOL_GPL(trace_define_field);
 
+int trace_define_field_ext(struct trace_event_call *call, const char *type,
+		       const char *name, int offset, int size, int is_signed,
+		       int filter_type, int len)
+{
+	struct list_head *head;
+
+	if (WARN_ON(!call->class))
+		return 0;
+
+	head = trace_get_fields(call);
+	return __trace_define_field(head, type, name, offset, size,
+				    is_signed, filter_type, len);
+}
+
 #define __generic_field(type, item, filter_type)			\
 	ret = __trace_define_field(&ftrace_generic_fields, #type,	\
 				   #item, 0, 0, is_signed_type(type),	\
-				   filter_type);			\
+				   filter_type, 0);			\
 	if (ret)							\
 		return ret;
 
@@ -166,7 +181,7 @@ EXPORT_SYMBOL_GPL(trace_define_field);
 				   "common_" #item,			\
 				   offsetof(typeof(ent), item),		\
 				   sizeof(ent.item),			\
-				   is_signed_type(type), FILTER_OTHER);	\
+				   is_signed_type(type), FILTER_OTHER, 0);	\
 	if (ret)							\
 		return ret;
 
@@ -1588,12 +1603,17 @@ static int f_show(struct seq_file *m, void *v)
 		seq_printf(m, "\tfield:%s %s;\toffset:%u;\tsize:%u;\tsigned:%d;\n",
 			   field->type, field->name, field->offset,
 			   field->size, !!field->is_signed);
-	else
-		seq_printf(m, "\tfield:%.*s %s%s;\toffset:%u;\tsize:%u;\tsigned:%d;\n",
+	else if (field->len)
+		seq_printf(m, "\tfield:%.*s %s[%d];\toffset:%u;\tsize:%u;\tsigned:%d;\n",
 			   (int)(array_descriptor - field->type),
 			   field->type, field->name,
-			   array_descriptor, field->offset,
+			   field->len, field->offset,
 			   field->size, !!field->is_signed);
+	else
+		seq_printf(m, "\tfield:%.*s %s[];\toffset:%u;\tsize:%u;\tsigned:%d;\n",
+				(int)(array_descriptor - field->type),
+				field->type, field->name,
+				field->offset, field->size, !!field->is_signed);
 
 	return 0;
 }
@@ -2379,9 +2399,10 @@ event_define_fields(struct trace_event_call *call)
 			}
 
 			offset = ALIGN(offset, field->align);
-			ret = trace_define_field(call, field->type, field->name,
+			ret = trace_define_field_ext(call, field->type, field->name,
 						 offset, field->size,
-						 field->is_signed, field->filter_type);
+						 field->is_signed, field->filter_type,
+						 field->len);
 			if (WARN_ON_ONCE(ret)) {
 				pr_err("error code is %d\n", ret);
 				break;
diff --git a/kernel/trace/trace_export.c b/kernel/trace/trace_export.c
index d960f6b11b5e..58f3946081e2 100644
--- a/kernel/trace/trace_export.c
+++ b/kernel/trace/trace_export.c
@@ -111,7 +111,8 @@ static void __always_unused ____ftrace_check_##name(void)		\
 #define __array(_type, _item, _len) {					\
 	.type = #_type"["__stringify(_len)"]", .name = #_item,		\
 	.size = sizeof(_type[_len]), .align = __alignof__(_type),	\
-	is_signed_type(_type), .filter_type = FILTER_OTHER },
+	is_signed_type(_type), .filter_type = FILTER_OTHER,			\
+	.len = _len },
 
 #undef __array_desc
 #define __array_desc(_type, _container, _item, _len) __array(_type, _item, _len)
