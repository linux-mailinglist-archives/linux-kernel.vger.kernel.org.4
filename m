Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC36D738B2D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjFUQaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjFUQ3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:29:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252F91996
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:29:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5C53615FA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 16:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5F2C433CD;
        Wed, 21 Jun 2023 16:29:46 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qC0iH-001yjy-0K;
        Wed, 21 Jun 2023 12:29:45 -0400
Message-ID: <20230621162944.916952813@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 21 Jun 2023 12:29:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Donglin Peng <pengdonglin@sangfor.com.cn>
Subject: [for-next][PATCH 03/13] tracing: Add documentation for funcgraph-retval and
 funcgraph-retval-hex
References: <20230621162923.953123395@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Donglin Peng <pengdonglin@sangfor.com.cn>

Add documentation for the two newly introduced options for the
function_graph tracer. The funcgraph-retval option is used to
control whether or not to display the return value, while the
funcgraph-retval-hex option is used to control the display
format of the return value.

Link: https://lkml.kernel.org/r/2b5635f05146161b54c9ea6307e25efe5ccebdad.1680954589.git.pengdonglin@sangfor.com.cn

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.rst | 126 +++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 027437b745a0..df2d3e57a83f 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1359,6 +1359,19 @@ Options for function_graph tracer:
 	only a closing curly bracket "}" is displayed for
 	the return of a function.
 
+  funcgraph-retval
+	When set, the return value of each traced function
+	will be printed after an equal sign "=". By default
+	this is off.
+
+  funcgraph-retval-hex
+	When set, the return value will always be printed
+	in hexadecimal format. If the option is not set and
+	the return value is an error code, it will be printed
+	in signed decimal format; otherwise it will also be
+	printed in hexadecimal format. By default, this option
+	is off.
+
   sleep-time
 	When running function graph tracer, to include
 	the time a task schedules out in its function.
@@ -2704,6 +2717,119 @@ It is default disabled.
     0)   1.757 us    |        } /* kmem_cache_free() */
     0)   2.861 us    |      } /* putname() */
 
+The return value of each traced function can be displayed after
+an equal sign "=". When encountering system call failures, it
+can be verfy helpful to quickly locate the function that first
+returns an error code.
+
+	- hide: echo nofuncgraph-retval > trace_options
+	- show: echo funcgraph-retval > trace_options
+
+  Example with funcgraph-retval::
+
+    1)               |    cgroup_migrate() {
+    1)   0.651 us    |      cgroup_migrate_add_task(); /* = 0xffff93fcfd346c00 */
+    1)               |      cgroup_migrate_execute() {
+    1)               |        cpu_cgroup_can_attach() {
+    1)               |          cgroup_taskset_first() {
+    1)   0.732 us    |            cgroup_taskset_next(); /* = 0xffff93fc8fb20000 */
+    1)   1.232 us    |          } /* cgroup_taskset_first = 0xffff93fc8fb20000 */
+    1)   0.380 us    |          sched_rt_can_attach(); /* = 0x0 */
+    1)   2.335 us    |        } /* cpu_cgroup_can_attach = -22 */
+    1)   4.369 us    |      } /* cgroup_migrate_execute = -22 */
+    1)   7.143 us    |    } /* cgroup_migrate = -22 */
+
+The above example shows that the function cpu_cgroup_can_attach
+returned the error code -22 firstly, then we can read the code
+of this function to get the root cause.
+
+When the option funcgraph-retval-hex is not set, the return value can
+be displayed in a smart way. Specifically, if it is an error code,
+it will be printed in signed decimal format, otherwise it will
+printed in hexadecimal format.
+
+	- smart: echo nofuncgraph-retval-hex > trace_options
+	- hexadecimal: echo funcgraph-retval-hex > trace_options
+
+  Example with funcgraph-retval-hex::
+
+    1)               |      cgroup_migrate() {
+    1)   0.651 us    |        cgroup_migrate_add_task(); /* = 0xffff93fcfd346c00 */
+    1)               |        cgroup_migrate_execute() {
+    1)               |          cpu_cgroup_can_attach() {
+    1)               |            cgroup_taskset_first() {
+    1)   0.732 us    |              cgroup_taskset_next(); /* = 0xffff93fc8fb20000 */
+    1)   1.232 us    |            } /* cgroup_taskset_first = 0xffff93fc8fb20000 */
+    1)   0.380 us    |            sched_rt_can_attach(); /* = 0x0 */
+    1)   2.335 us    |          } /* cpu_cgroup_can_attach = 0xffffffea */
+    1)   4.369 us    |        } /* cgroup_migrate_execute = 0xffffffea */
+    1)   7.143 us    |      } /* cgroup_migrate = 0xffffffea */
+
+At present, there are some limitations when using the funcgraph-retval
+option, and these limitations will be eliminated in the future:
+
+- Even if the function return type is void, a return value will still
+  be printed, and you can just ignore it.
+
+- Even if return values are stored in multiple registers, only the
+  value contained in the first register will be recorded and printed.
+  To illustrate, in the x86 architecture, eax and edx are used to store
+  a 64-bit return value, with the lower 32 bits saved in eax and the
+  upper 32 bits saved in edx. However, only the value stored in eax
+  will be recorded and printed.
+
+- In certain procedure call standards, such as arm64's AAPCS64, when a
+  type is smaller than a GPR, it is the responsibility of the consumer
+  to perform the narrowing, and the upper bits may contain UNKNOWN values.
+  Therefore, it is advisable to check the code for such cases. For instance,
+  when using a u8 in a 64-bit GPR, bits [63:8] may contain arbitrary values,
+  especially when larger types are truncated, whether explicitly or implicitly.
+  Here are some specific cases to illustrate this point:
+
+  **Case One**::
+
+  The function narrow_to_u8 is defined as follows::
+
+	u8 narrow_to_u8(u64 val)
+	{
+		// implicitly truncated
+		return val;
+	}
+
+  It may be compiled to::
+
+	narrow_to_u8:
+		< ... ftrace instrumentation ... >
+		RET
+
+  If you pass 0x123456789abcdef to this function and want to narrow it,
+  it may be recorded as 0x123456789abcdef instead of 0xef.
+
+  **Case Two**::
+
+  The function error_if_not_4g_aligned is defined as follows::
+
+	int error_if_not_4g_aligned(u64 val)
+	{
+		if (val & GENMASK(31, 0))
+			return -EINVAL;
+
+		return 0;
+	}
+
+  It could be compiled to::
+
+	error_if_not_4g_aligned:
+		CBNZ    w0, .Lnot_aligned
+		RET			// bits [31:0] are zero, bits
+					// [63:32] are UNKNOWN
+	.Lnot_aligned:
+		MOV    x0, #-EINVAL
+		RET
+
+  When passing 0x2_0000_0000 to it, the return value may be recorded as
+  0x2_0000_0000 instead of 0.
+
 You can put some comments on specific functions by using
 trace_printk() For example, if you want to put a comment inside
 the __might_sleep() function, you just have to include
-- 
2.39.2
