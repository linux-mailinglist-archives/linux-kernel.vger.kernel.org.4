Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D426D20E5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjCaMuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjCaMt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:49:27 -0400
Received: from mail-m118111.qiye.163.com (mail-m118111.qiye.163.com [115.236.118.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D021F1F7B0;
        Fri, 31 Mar 2023 05:49:07 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [117.133.56.22])
        by mail-m118111.qiye.163.com (Hmail) with ESMTPA id B18E058035E;
        Fri, 31 Mar 2023 20:48:00 +0800 (CST)
From:   Donglin Peng <pengdonglin@sangfor.com.cn>
To:     mhiramat@kernel.org, rostedt@goodmis.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        rmk+kernel@armlinux.org.uk, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
        bp@alien8.de, hpa@zytor.com, chenhuacai@kernel.org,
        zhangqing@loongson.cn, kernel@xen0n.name, mingo@redhat.com,
        peterz@infradead.org, xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com
Cc:     linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Donglin Peng <pengdonglin@sangfor.com.cn>
Subject: [PATCH v10 0/8] function_graph: Support recording and printing the return value of function
Date:   Fri, 31 Mar 2023 05:47:36 -0700
Message-Id: <cover.1680265828.git.pengdonglin@sangfor.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHU9PVkJCGBpCSx0aQ09OHVUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKTFVKSEhVTk1VSUlZV1kWGg8SFR0UWUFZT0tIVUpISkJIT1VKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MhQ6OTo6NT0OPU0BKzgQITIL
        Hz0aCwlVSlVKTUNLSU1NQ0NJT0xDVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSkpMVUpISFVOTVVJSVlXWQgBWUFCTkhONwY+
X-HM-Tid: 0a8737b5eb4f2eb7kusnb18e058035e
X-HM-MType: 1
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using the function_graph tracer to analyze system call failures,
it can be time-consuming to analyze the trace logs and locate the kernel
function that first returns an error. This change aims to simplify the
process by recording the function return value to the 'retval' member of
'ftrace_graph_ent' and printing it when outputing the trace log.

Note that even if a function's return type is void, a return value will
still be printed, so it should be ignored. If you care about this, the
BTF file can be used to obtain the details of function return type. We
can implement a tool to process the trace log and display the return
value based on its actual type.

Here is an example:

...

 1)               |  cgroup_attach_task() {
 1)               |    cgroup_migrate_add_src() {
 1)   1.403 us    |      cset_cgroup_from_root(); /* = 0xffff93fc86f58010 */
 1)   2.154 us    |    } /* cgroup_migrate_add_src = 0xffffb286c1297d00 */
 1) ! 386.538 us  |    cgroup_migrate_prepare_dst(); /* = 0x0 */
 1)               |    cgroup_migrate() {
 1)   0.651 us    |      cgroup_migrate_add_task(); /* = 0xffff93fcfd346c00 */
 1)               |      cgroup_migrate_execute() {
 1)               |        cpu_cgroup_can_attach() {
 1)               |          cgroup_taskset_first() {
 1)   0.732 us    |            cgroup_taskset_next(); /* = 0xffff93fc8fb20000 */
 1)   1.232 us    |          } /* cgroup_taskset_first = 0xffff93fc8fb20000 */
 1)   0.380 us    |          sched_rt_can_attach(); /* = 0x0 */
 1)   2.335 us    |        } /* cpu_cgroup_can_attach = -22 */
 1)   4.369 us    |      } /* cgroup_migrate_execute = -22 */
 1)   7.143 us    |    } /* cgroup_migrate = -22 */
 1)               |    cgroup_migrate_finish() {
 1)   0.411 us    |      put_css_set_locked(); /* = 0x8 */
 1) + 62.397 us   |      put_css_set_locked(); /* = 0x80000001 */
 1) + 64.742 us   |    } /* cgroup_migrate_finish = 0x80000000 */
 1) ! 465.605 us  |  } /* cgroup_attach_task = -22 */

...

After processing the above trace logs using BTF information:

...

 1)               |  cgroup_attach_task() {
 1)               |    cgroup_migrate_add_src() {
 1)   1.403 us    |      cset_cgroup_from_root(); /* = 0xffff93fc86f58010 */
 1)   2.154 us    |    } /* cgroup_migrate_add_src */
 1) ! 386.538 us  |    cgroup_migrate_prepare_dst(); /* = 0 */
 1)               |    cgroup_migrate() {
 1)   0.651 us    |      cgroup_migrate_add_task();
 1)               |      cgroup_migrate_execute() {
 1)               |        cpu_cgroup_can_attach() {
 1)               |          cgroup_taskset_first() {
 1)   0.732 us    |            cgroup_taskset_next(); /* = 0xffff93fc8fb20000 */
 1)   1.232 us    |          } /* cgroup_taskset_first = 0xffff93fc8fb20000 */
 1)   0.380 us    |          sched_rt_can_attach(); /* = 0 */
 1)   2.335 us    |        } /* cpu_cgroup_can_attach = -22 */
 1)   4.369 us    |      } /* cgroup_migrate_execute = -22 */
 1)   7.143 us    |    } /* cgroup_migrate = -22 */
 1)               |    cgroup_migrate_finish() {
 1)   0.411 us    |      put_css_set_locked();
 1) + 62.397 us   |      put_css_set_locked();
 1) + 64.742 us   |    } /* cgroup_migrate_finish */
 1) ! 465.605 us  |  } /* cgroup_attach_task = -22 */

...

---
v10:
 - Fix code style issues for LoongArch
 - Fix selftest issues
 - Use CONFIG_FUNCTION_GRAPH_TRACER to control fgraph_ret_regs definition

v9:
 - Fix align issues in ARM asm code
 - Fix align issues in LoongArch asm code
 - Update commit messages
 - Update comments for ftrace_return_to_handler

v8:
 - Fix issues in ARM64 asm code
 - Fix issues in selftest
 - Add some comments on CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
 - Make CONFIG_FUNCTION_GRAPH_RETVAL switable
 - Modify the control range of CONFIG_HAVE_FUNCTION_GRAPH_RETVAL

v7:
 - Rename trace option 'graph_retval_hex' to 'funcgraph-retval-hex'
 - Introduce a new structure fgraph_ret_regs for each architecture to
   hold return registers
 - Separate each architecture modification info individual patches
 - Add a test case for funcgraph-retval
 - Update documentation description
 - Support LoongArch

v6:
 - Remove the conversion code for short and char types, because these
   two types are rarely used to store an error code.
 - Modify the limitations for funcgraph-retval
 - Optimize the English expression

v5:
 - Pass both the return values to ftrace_return_to_handler
 - Modify the parameter sequence of ftrace_return_to_handler to
   decrease the modification of assembly code, thanks to Russell King
 - Wrap __ftrace_return_to_handler with ftrace_return_to_handler
   for compatible
 - Describe the limitations of funcgraph-retval

v4:
 - Modify commit message
 - Introduce new option graph_retval_hex to control display format
 - Introduce macro CONFIG_FUNCTION_GRAPH_RETVAL and
   CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
 - Add related arch maintainers to review

v3:
 - Modify the commit message: add trace logs processed with the btf tool

v2:
 - Modify the commit message: use BTF to get the return type of function

Donglin Peng (8):
  function_graph: Support recording and printing the return value of
    function
  tracing: Add documentation for funcgraph-retval and
    funcgraph-retval-hex
  ARM: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
  arm64: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
  riscv: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
  x86/ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
  LoongArch: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
  selftests/ftrace: Add funcgraph-retval test case

 Documentation/trace/ftrace.rst                | 74 +++++++++++++++
 arch/arm/Kconfig                              |  1 +
 arch/arm/include/asm/ftrace.h                 | 22 +++++
 arch/arm/kernel/asm-offsets.c                 |  8 +-
 arch/arm/kernel/entry-ftrace.S                | 10 +-
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/include/asm/ftrace.h               | 22 +++++
 arch/arm64/kernel/asm-offsets.c               | 13 +++
 arch/arm64/kernel/entry-ftrace.S              | 27 +++---
 arch/loongarch/Kconfig                        |  1 +
 arch/loongarch/include/asm/ftrace.h           | 22 +++++
 arch/loongarch/kernel/asm-offsets.c           | 15 ++-
 arch/loongarch/kernel/mcount.S                | 14 +--
 arch/loongarch/kernel/mcount_dyn.S            | 15 +--
 arch/riscv/Kconfig                            |  1 +
 arch/riscv/include/asm/ftrace.h               | 21 +++++
 arch/riscv/kernel/mcount.S                    |  7 +-
 arch/x86/Kconfig                              |  1 +
 arch/x86/include/asm/ftrace.h                 | 20 ++++
 arch/x86/kernel/ftrace_32.S                   |  8 +-
 arch/x86/kernel/ftrace_64.S                   |  7 +-
 include/linux/ftrace.h                        |  3 +
 kernel/trace/Kconfig                          | 15 +++
 kernel/trace/fgraph.c                         | 23 ++++-
 kernel/trace/trace.h                          |  2 +
 kernel/trace/trace_entries.h                  | 26 ++++++
 kernel/trace/trace_functions_graph.c          | 93 +++++++++++++++++--
 .../ftrace/test.d/ftrace/fgraph-retval.tc     | 43 +++++++++
 28 files changed, 460 insertions(+), 55 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/fgraph-retval.tc

-- 
2.25.1

