Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BA45FEDD0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 14:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiJNMFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 08:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiJNMF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 08:05:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD082A837D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 05:05:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 059D761AE1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 12:05:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B48CC433C1;
        Fri, 14 Oct 2022 12:04:59 +0000 (UTC)
Date:   Fri, 14 Oct 2022 08:04:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH] tracing: Add __cpumask to denote a trace event field that
 is a cpumask_t
Message-ID: <20221014080456.1d32b989@rorschach.local.home>
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

From: Steven Rostedt (Google) <rostedt@goodmis.org>

The trace events have a __bitmask field that can be used for anything
that requires bitmasks. Although currently it is only used for CPU
masks, it could be used in the future for any type of bitmasks.

There is some user space tooling that wants to know if a field is a CPU
mask and not just some random unsigned long bitmask. Introduce
"__cpumask()" helper functions that work the same as the current
__bitmask() helpers but displays in the format file:

  field:__data_loc cpumask_t *[] mask;    offset:36;      size:4; signed:0;

Instead of:

  field:__data_loc unsigned long[] mask;  offset:32;      size:4; signed:0;

The main difference is the type. Instead of "unsigned long" it is
"cpumask_t *". Note, this type field needs to be a real type in the
__dynamic_array() logic that both __cpumask and__bitmask use, but the
comparison field requires it to be a scalar type whereas cpumask_t is a
structure (non-scalar). But everything works when making it a pointer.

Requested-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index 6a13220d2d27..155c495b89ea 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -21,6 +21,9 @@
 #undef __get_bitmask
 #define __get_bitmask(field) (char *)__get_dynamic_array(field)
 
+#undef __get_cpumask
+#define __get_cpumask(field) (char *)__get_dynamic_array(field)
+
 #undef __get_sockaddr
 #define __get_sockaddr(field) ((struct sockaddr *)__get_dynamic_array(field))
 
@@ -40,6 +43,9 @@
 #undef __get_rel_bitmask
 #define __get_rel_bitmask(field) (char *)__get_rel_dynamic_array(field)
 
+#undef __get_rel_cpumask
+#define __get_rel_cpumask(field) (char *)__get_rel_dynamic_array(field)
+
 #undef __get_rel_sockaddr
 #define __get_rel_sockaddr(field) ((struct sockaddr *)__get_rel_dynamic_array(field))
 
diff --git a/include/trace/perf.h b/include/trace/perf.h
index 5800d13146c3..8f3bf1e17707 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -21,6 +21,9 @@
 #undef __get_bitmask
 #define __get_bitmask(field) (char *)__get_dynamic_array(field)
 
+#undef __get_cpumask
+#define __get_cpumask(field) (char *)__get_dynamic_array(field)
+
 #undef __get_sockaddr
 #define __get_sockaddr(field) ((struct sockaddr *)__get_dynamic_array(field))
 
@@ -41,6 +44,9 @@
 #undef __get_rel_bitmask
 #define __get_rel_bitmask(field) (char *)__get_rel_dynamic_array(field)
 
+#undef __get_rel_cpumask
+#define __get_rel_cpumask(field) (char *)__get_rel_dynamic_array(field)
+
 #undef __get_rel_sockaddr
 #define __get_rel_sockaddr(field) ((struct sockaddr *)__get_rel_dynamic_array(field))
 
diff --git a/include/trace/stages/stage1_struct_define.h b/include/trace/stages/stage1_struct_define.h
index 1b7bab60434c..e1a9b8462b41 100644
--- a/include/trace/stages/stage1_struct_define.h
+++ b/include/trace/stages/stage1_struct_define.h
@@ -32,6 +32,9 @@
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(char, item, -1)
 
+#undef __cpumask
+#define __cpumask(item, nr_bits) __dynamic_array(char, item, -1)
+
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)
 
@@ -47,6 +50,9 @@
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(char, item, -1)
 
+#undef __rel_cpumask
+#define __rel_cpumask(item, nr_bits) __rel_dynamic_array(char, item, -1)
+
 #undef __rel_sockaddr
 #define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
 
diff --git a/include/trace/stages/stage2_data_offsets.h b/include/trace/stages/stage2_data_offsets.h
index 1b7a8f764fdd..4f096c30303b 100644
--- a/include/trace/stages/stage2_data_offsets.h
+++ b/include/trace/stages/stage2_data_offsets.h
@@ -38,6 +38,9 @@
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
+#undef __cpumask
+#define __cpumask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
+
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)
 
@@ -53,5 +56,8 @@
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item, -1)
 
+#undef __rel_cpumask
+#define __rel_cpumask(item, nr_bits) __rel_dynamic_array(unsigned long, item, -1)
+
 #undef __rel_sockaddr
 #define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index e3b183e9d18e..66374df61ed3 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -42,6 +42,9 @@
 		trace_print_bitmask_seq(p, __bitmask, __bitmask_size);	\
 	})
 
+#undef __get_cpumask
+#define __get_cpumask(field) __get_bitmask(field)
+
 #undef __get_rel_bitmask
 #define __get_rel_bitmask(field)						\
 	({								\
@@ -51,6 +54,9 @@
 		trace_print_bitmask_seq(p, __bitmask, __bitmask_size);	\
 	})
 
+#undef __get_rel_cpumask
+#define __get_rel_cpumask(field) __get_rel_bitmask(field)
+
 #undef __get_sockaddr
 #define __get_sockaddr(field)	((struct sockaddr *)__get_dynamic_array(field))
 
diff --git a/include/trace/stages/stage4_event_fields.h b/include/trace/stages/stage4_event_fields.h
index a8fb25f39a99..11cf5550494d 100644
--- a/include/trace/stages/stage4_event_fields.h
+++ b/include/trace/stages/stage4_event_fields.h
@@ -46,6 +46,9 @@
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
+#undef __cpumask
+#define __cpumask(item, nr_bits) __dynamic_array(cpumask_t *, item, -1)
+
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)
 
@@ -64,5 +67,8 @@
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item, -1)
 
+#undef __rel_cpumask
+#define __rel_cpumask(item, nr_bits) __rel_dynamic_array(cpumask_t *, item, -1)
+
 #undef __rel_sockaddr
 #define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
diff --git a/include/trace/stages/stage5_get_offsets.h b/include/trace/stages/stage5_get_offsets.h
index fba4c24ed9e6..0d9386b0d320 100644
--- a/include/trace/stages/stage5_get_offsets.h
+++ b/include/trace/stages/stage5_get_offsets.h
@@ -82,10 +82,16 @@
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item,	\
 					 __bitmask_size_in_longs(nr_bits))
 
+#undef __cpumask
+#define __cpumask(item, nr_bits) __bitmask(item, nr_bits)
+
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item,	\
 					 __bitmask_size_in_longs(nr_bits))
 
+#undef __rel_cpumask
+#define __rel_cpumask(item, nr_bits) __rel_bitmask(item, nr_bits)
+
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)
 
diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index 3c554a585320..76774cb9acc8 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -57,6 +57,16 @@
 #define __assign_bitmask(dst, src, nr_bits)					\
 	memcpy(__get_bitmask(dst), (src), __bitmask_size_in_bytes(nr_bits))
 
+#undef __cpumask
+#define __cpumask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
+
+#undef __get_cpumask
+#define __get_cpumask(field) (char *)__get_dynamic_array(field)
+
+#undef __assign_cpumask
+#define __assign_cpumask(dst, src, nr_bits)					\
+	memcpy(__get_cpumask(dst), (src), __bitmask_size_in_bytes(nr_bits))
+
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)
 
@@ -98,6 +108,16 @@
 #define __assign_rel_bitmask(dst, src, nr_bits)					\
 	memcpy(__get_rel_bitmask(dst), (src), __bitmask_size_in_bytes(nr_bits))
 
+#undef __rel_cpumask
+#define __rel_cpumask(item, nr_bits) __rel_dynamic_array(unsigned long, item, -1)
+
+#undef __get_rel_cpumask
+#define __get_rel_cpumask(field) (char *)__get_rel_dynamic_array(field)
+
+#undef __assign_rel_cpumask
+#define __assign_rel_cpumask(dst, src, nr_bits)					\
+	memcpy(__get_rel_cpumask(dst), (src), __bitmask_size_in_bytes(nr_bits))
+
 #undef __rel_sockaddr
 #define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
 
diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
index 8a7ec24c246d..8795429f388b 100644
--- a/include/trace/stages/stage7_class_define.h
+++ b/include/trace/stages/stage7_class_define.h
@@ -13,11 +13,13 @@
 #undef __get_dynamic_array_len
 #undef __get_str
 #undef __get_bitmask
+#undef __get_cpumask
 #undef __get_sockaddr
 #undef __get_rel_dynamic_array
 #undef __get_rel_dynamic_array_len
 #undef __get_rel_str
 #undef __get_rel_bitmask
+#undef __get_rel_cpumask
 #undef __get_rel_sockaddr
 #undef __print_array
 #undef __print_hex_dump
diff --git a/samples/trace_events/trace-events-sample.c b/samples/trace_events/trace-events-sample.c
index 608c4ae3b08a..ecc7db237f2e 100644
--- a/samples/trace_events/trace-events-sample.c
+++ b/samples/trace_events/trace-events-sample.c
@@ -50,7 +50,7 @@ static void do_simple_thread_func(int cnt, const char *fmt, ...)
 
 	trace_foo_with_template_print("I have to be different", cnt);
 
-	trace_foo_rel_loc("Hello __rel_loc", cnt, bitmask);
+	trace_foo_rel_loc("Hello __rel_loc", cnt, bitmask, current->cpus_ptr);
 }
 
 static void simple_thread_func(int cnt)
diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 1a92226202fc..d0f9b4857601 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -200,6 +200,16 @@
  *
  *         __assign_bitmask(target_cpus, cpumask_bits(bar), nr_cpumask_bits);
  *
+ *   __cpumask: This is pretty much the same as __bitmask but is specific for
+ *         CPU masks. The type displayed to the user via the format files will
+ *         be "cpumaks_t" such that user space may deal with them differently
+ *         if they choose to do so.
+ *
+ *         __cpumask(target_cpu, nr_cpumask_bits)
+ *
+ *         To assign a cpumask, use the __assign_cpumask() helper macro.
+ *
+ *         __assign_cpumask(target_cpus, cpumask_bits(bar), nr_cpumask_bits);
  *
  * fast_assign: This is a C like function that is used to store the items
  *    into the ring buffer. A special variable called "__entry" will be the
@@ -212,8 +222,8 @@
  *    This is also used to print out the data from the trace files.
  *    Again, the __entry macro is used to access the data from the ring buffer.
  *
- *    Note, __dynamic_array, __string, and __bitmask require special helpers
- *       to access the data.
+ *    Note, __dynamic_array, __string, __bitmask and __cpumask require special
+ *       helpers to access the data.
  *
  *      For __dynamic_array(int, foo, bar) use __get_dynamic_array(foo)
  *            Use __get_dynamic_array_len(foo) to get the length of the array
@@ -226,6 +236,8 @@
  *
  *      For __bitmask(target_cpus, nr_cpumask_bits) use __get_bitmask(target_cpus)
  *
+ *      For __cpumask(target_cpus, nr_cpumask_bits) use __get_cpumask(target_cpus)
+ *
  *
  * Note, that for both the assign and the printk, __entry is the handler
  * to the data structure in the ring buffer, and is defined by the
@@ -288,6 +300,7 @@ TRACE_EVENT(foo_bar,
 		__dynamic_array(int,	list,   __length_of(lst))
 		__string(	str,	string			)
 		__bitmask(	cpus,	num_possible_cpus()	)
+		__cpumask(	cpum,	num_possible_cpus()	)
 		__vstring(	vstr,	fmt,	va		)
 	),
 
@@ -299,9 +312,10 @@ TRACE_EVENT(foo_bar,
 		__assign_str(str, string);
 		__assign_vstr(vstr, fmt, va);
 		__assign_bitmask(cpus, cpumask_bits(mask), num_possible_cpus());
+		__assign_cpumask(cpum, cpumask_bits(mask), num_possible_cpus());
 	),
 
-	TP_printk("foo %s %d %s %s %s %s (%s) %s", __entry->foo, __entry->bar,
+	TP_printk("foo %s %d %s %s %s %s (%s) (%s) %s", __entry->foo, __entry->bar,
 
 /*
  * Notice here the use of some helper functions. This includes:
@@ -345,7 +359,8 @@ TRACE_EVENT(foo_bar,
 		  __print_array(__get_dynamic_array(list),
 				__get_dynamic_array_len(list) / sizeof(int),
 				sizeof(int)),
-		  __get_str(str), __get_bitmask(cpus), __get_str(vstr))
+		  __get_str(str), __get_bitmask(cpus), __get_cpumask(cpus),
+		  __get_str(vstr))
 );
 
 /*
@@ -542,15 +557,16 @@ DEFINE_EVENT_PRINT(foo_template, foo_with_template_print,
 
 TRACE_EVENT(foo_rel_loc,
 
-	TP_PROTO(const char *foo, int bar, unsigned long *mask),
+	TP_PROTO(const char *foo, int bar, unsigned long *mask, const cpumask_t *cpus),
 
-	TP_ARGS(foo, bar, mask),
+	TP_ARGS(foo, bar, mask, cpus),
 
 	TP_STRUCT__entry(
 		__rel_string(	foo,	foo	)
 		__field(	int,	bar	)
 		__rel_bitmask(	bitmask,
 			BITS_PER_BYTE * sizeof(unsigned long)	)
+		__rel_cpumask(	cpumask, cpumask_size() )
 	),
 
 	TP_fast_assign(
@@ -558,10 +574,12 @@ TRACE_EVENT(foo_rel_loc,
 		__entry->bar = bar;
 		__assign_rel_bitmask(bitmask, mask,
 			BITS_PER_BYTE * sizeof(unsigned long));
+		__assign_rel_cpumask(cpumask, cpus, cpumask_size());
 	),
 
-	TP_printk("foo_rel_loc %s, %d, %s", __get_rel_str(foo), __entry->bar,
-		  __get_rel_bitmask(bitmask))
+	TP_printk("foo_rel_loc %s, %d, %s, %s", __get_rel_str(foo), __entry->bar,
+		  __get_rel_bitmask(bitmask),
+		  __get_rel_cpumask(cpumask))
 );
 #endif
 
