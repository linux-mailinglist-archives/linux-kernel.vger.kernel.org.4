Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0B7616C38
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiKBScn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiKBSch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E102F650
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667413853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tyAZWmuLvFOiDOkNrWMPPNPYxM5JhhrbgvDpf3th3RA=;
        b=D/HcUfyrvcQZpoyw1ArXMDKWAL0x3lO8eHyMJqVCbBkwHdUOl3NUl/3HPefpklFhVD/3Kj
        hB89O78xVrFj8yZ9RUvQULaQ0qVzfb1RquKXFfRWH+uJWi0QxAS1thDgfrbsfKfAAgZZSJ
        2YTEpqFhQzAAy/cBNrQHcW1kc6RZE8w=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-641-Udxn5D9uM-SMeTIyHmwEUA-1; Wed, 02 Nov 2022 14:30:49 -0400
X-MC-Unique: Udxn5D9uM-SMeTIyHmwEUA-1
Received: by mail-qv1-f70.google.com with SMTP id q17-20020a056214019100b004b1d3c9f3acso10372511qvr.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 11:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyAZWmuLvFOiDOkNrWMPPNPYxM5JhhrbgvDpf3th3RA=;
        b=CuEeyMoRU9oFkmbj1PfUcbug7fR2N/aiXqvU5EpI6odyTsgVxE8ceX6AwnwRdPmWyU
         klL28VxcEMXCJfuFojomg+Mw4Z0vJiMRwoyazaehi+Qjfxj23+nJ4M6fFz5B0//ml/HT
         0mBXETr+pSSH9K7mZCqMyvj+tVh7bs6rzpNFCSSSV0ZvLCdkuLZBINKZX388L13FrVId
         Wa2oUMqU+Q1ki7ORVVkpoaRfu7ED73+wATaV1aNZIh8QeKSDgjwbd0LjHuRjqft5MRLK
         XEd+KlAprnUo8nRIjOFuqGCdc5pkuSlEpLav24YKJ19ZifhetkVZVbNmeHLApZF6OeZA
         ZZ7g==
X-Gm-Message-State: ACrzQf2nhKL0mx+mkMgRmN4Q/MRWRR3Y11EBk8PztLYiGQn5D9bHukXY
        9OejTTF9g9iObMmQrVUZx+yzQDudYNEH8qD8dNI1f2jokNLQf7NZ8Sp1h2gvZk+2oGrNa637o6i
        waTkxP8RCxC8bZHIA1rLJqcbT
X-Received: by 2002:a05:620a:b86:b0:6fa:1516:13da with SMTP id k6-20020a05620a0b8600b006fa151613damr17826895qkh.339.1667413846551;
        Wed, 02 Nov 2022 11:30:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7ulamBGOfYW7ZQO0WW9shmYY3Yv46ZF/uWw8RVtTehKgltnR9GB/SwI1/pU3/2wscWxucApg==
X-Received: by 2002:a05:620a:b86:b0:6fa:1516:13da with SMTP id k6-20020a05620a0b8600b006fa151613damr17826862qkh.339.1667413846256;
        Wed, 02 Nov 2022 11:30:46 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id s16-20020a05620a29d000b006cec8001bf4sm9133847qkp.26.2022.11.02.11.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:30:45 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org
Cc:     "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RFC PATCH v2 1/8] DO-NOT-MERGE: tracing: Add __cpumask to denote a trace event field that is a cpumask_t
Date:   Wed,  2 Nov 2022 18:29:42 +0000
Message-Id: <20221102182949.3119584-2-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221102182949.3119584-1-vschneid@redhat.com>
References: <20221102182949.3119584-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

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

Valentin added changes to remove the need of passing in "nr_bits" and the
__cpumask will always use nr_cpumask_bits as its size.

Requested-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/bpf_probe.h                    |  6 ++++
 include/trace/perf.h                         |  6 ++++
 include/trace/stages/stage1_struct_define.h  |  6 ++++
 include/trace/stages/stage2_data_offsets.h   |  6 ++++
 include/trace/stages/stage3_trace_output.h   |  6 ++++
 include/trace/stages/stage4_event_fields.h   |  6 ++++
 include/trace/stages/stage5_get_offsets.h    |  6 ++++
 include/trace/stages/stage6_event_callback.h | 20 ++++++++++++
 include/trace/stages/stage7_class_define.h   |  2 ++
 samples/trace_events/trace-events-sample.c   |  2 +-
 samples/trace_events/trace-events-sample.h   | 34 +++++++++++++++-----
 11 files changed, 91 insertions(+), 9 deletions(-)

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index 6a13220d2d27b..155c495b89ead 100644
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
index 5800d13146c3d..8f3bf1e177070 100644
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
index 1b7bab60434c1..69e0dae453bfa 100644
--- a/include/trace/stages/stage1_struct_define.h
+++ b/include/trace/stages/stage1_struct_define.h
@@ -32,6 +32,9 @@
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(char, item, -1)

+#undef __cpumask
+#define __cpumask(item) __dynamic_array(char, item, -1)
+
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)

@@ -47,6 +50,9 @@
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(char, item, -1)

+#undef __rel_cpumask
+#define __rel_cpumask(item) __rel_dynamic_array(char, item, -1)
+
 #undef __rel_sockaddr
 #define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)

diff --git a/include/trace/stages/stage2_data_offsets.h b/include/trace/stages/stage2_data_offsets.h
index 1b7a8f764fddd..469b6a64293de 100644
--- a/include/trace/stages/stage2_data_offsets.h
+++ b/include/trace/stages/stage2_data_offsets.h
@@ -38,6 +38,9 @@
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)

+#undef __cpumask
+#define __cpumask(item) __dynamic_array(unsigned long, item, -1)
+
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)

@@ -53,5 +56,8 @@
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item, -1)

+#undef __rel_cpumask
+#define __rel_cpumask(item) __rel_dynamic_array(unsigned long, item, -1)
+
 #undef __rel_sockaddr
 #define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index e3b183e9d18ea..66374df61ed30 100644
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
index a8fb25f39a99d..f2990d22313cf 100644
--- a/include/trace/stages/stage4_event_fields.h
+++ b/include/trace/stages/stage4_event_fields.h
@@ -46,6 +46,9 @@
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)

+#undef __cpumask
+#define __cpumask(item) __dynamic_array(cpumask_t *, item, -1)
+
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)

@@ -64,5 +67,8 @@
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item, -1)

+#undef __rel_cpumask
+#define __rel_cpumask(item) __rel_dynamic_array(cpumask_t *, item, -1)
+
 #undef __rel_sockaddr
 #define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)
diff --git a/include/trace/stages/stage5_get_offsets.h b/include/trace/stages/stage5_get_offsets.h
index fba4c24ed9e60..ac5c24d3beeb2 100644
--- a/include/trace/stages/stage5_get_offsets.h
+++ b/include/trace/stages/stage5_get_offsets.h
@@ -82,10 +82,16 @@
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item,	\
					 __bitmask_size_in_longs(nr_bits))

+#undef __cpumask
+#define __cpumask(item) __bitmask(item, nr_cpumask_bits)
+
 #undef __rel_bitmask
 #define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item,	\
					 __bitmask_size_in_longs(nr_bits))

+#undef __rel_cpumask
+#define __rel_cpumask(item) __rel_bitmask(item, nr_cpumask_bits)
+
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)

diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index 3c554a5853204..49c32394b53fb 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -57,6 +57,16 @@
 #define __assign_bitmask(dst, src, nr_bits)					\
	memcpy(__get_bitmask(dst), (src), __bitmask_size_in_bytes(nr_bits))

+#undef __cpumask
+#define __cpumask(item) __dynamic_array(unsigned long, item, -1)
+
+#undef __get_cpumask
+#define __get_cpumask(field) (char *)__get_dynamic_array(field)
+
+#undef __assign_cpumask
+#define __assign_cpumask(dst, src)					\
+	memcpy(__get_cpumask(dst), (src), __bitmask_size_in_bytes(nr_cpumask_bits))
+
 #undef __sockaddr
 #define __sockaddr(field, len) __dynamic_array(u8, field, len)

@@ -98,6 +108,16 @@
 #define __assign_rel_bitmask(dst, src, nr_bits)					\
	memcpy(__get_rel_bitmask(dst), (src), __bitmask_size_in_bytes(nr_bits))

+#undef __rel_cpumask
+#define __rel_cpumask(item) __rel_dynamic_array(unsigned long, item, -1)
+
+#undef __get_rel_cpumask
+#define __get_rel_cpumask(field) (char *)__get_rel_dynamic_array(field)
+
+#undef __assign_rel_cpumask
+#define __assign_rel_cpumask(dst, src)					\
+	memcpy(__get_rel_cpumask(dst), (src), __bitmask_size_in_bytes(nr_cpumask_bits))
+
 #undef __rel_sockaddr
 #define __rel_sockaddr(field, len) __rel_dynamic_array(u8, field, len)

diff --git a/include/trace/stages/stage7_class_define.h b/include/trace/stages/stage7_class_define.h
index 8a7ec24c246dd..8795429f388b0 100644
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
index 608c4ae3b08a3..ecc7db237f2ef 100644
--- a/samples/trace_events/trace-events-sample.c
+++ b/samples/trace_events/trace-events-sample.c
@@ -50,7 +50,7 @@ static void do_simple_thread_func(int cnt, const char *fmt, ...)

	trace_foo_with_template_print("I have to be different", cnt);

-	trace_foo_rel_loc("Hello __rel_loc", cnt, bitmask);
+	trace_foo_rel_loc("Hello __rel_loc", cnt, bitmask, current->cpus_ptr);
 }

 static void simple_thread_func(int cnt)
diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 1a92226202fc5..fb4548a44153c 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -200,6 +200,16 @@
  *
  *         __assign_bitmask(target_cpus, cpumask_bits(bar), nr_cpumask_bits);
  *
+ *   __cpumask: This is pretty much the same as __bitmask but is specific for
+ *         CPU masks. The type displayed to the user via the format files will
+ *         be "cpumaks_t" such that user space may deal with them differently
+ *         if they choose to do so, and the bits is always set to nr_cpumask_bits.
+ *
+ *         __cpumask(target_cpu)
+ *
+ *         To assign a cpumask, use the __assign_cpumask() helper macro.
+ *
+ *         __assign_cpumask(target_cpus, cpumask_bits(bar));
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
+ *      For __cpumask(target_cpus) use __get_cpumask(target_cpus)
+ *
  *
  * Note, that for both the assign and the printk, __entry is the handler
  * to the data structure in the ring buffer, and is defined by the
@@ -288,6 +300,7 @@ TRACE_EVENT(foo_bar,
		__dynamic_array(int,	list,   __length_of(lst))
		__string(	str,	string			)
		__bitmask(	cpus,	num_possible_cpus()	)
+		__cpumask(	cpum				)
		__vstring(	vstr,	fmt,	va		)
	),

@@ -299,9 +312,10 @@ TRACE_EVENT(foo_bar,
		__assign_str(str, string);
		__assign_vstr(vstr, fmt, va);
		__assign_bitmask(cpus, cpumask_bits(mask), num_possible_cpus());
+		__assign_cpumask(cpum, cpumask_bits(mask));
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
+		__rel_cpumask(	cpumask )
	),

	TP_fast_assign(
@@ -558,10 +574,12 @@ TRACE_EVENT(foo_rel_loc,
		__entry->bar = bar;
		__assign_rel_bitmask(bitmask, mask,
			BITS_PER_BYTE * sizeof(unsigned long));
+		__assign_rel_cpumask(cpumask, cpus);
	),

-	TP_printk("foo_rel_loc %s, %d, %s", __get_rel_str(foo), __entry->bar,
-		  __get_rel_bitmask(bitmask))
+	TP_printk("foo_rel_loc %s, %d, %s, %s", __get_rel_str(foo), __entry->bar,
+		  __get_rel_bitmask(bitmask),
+		  __get_rel_cpumask(cpumask))
 );
 #endif

--
2.31.1

