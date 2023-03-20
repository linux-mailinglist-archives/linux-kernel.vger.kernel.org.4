Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740006C1311
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjCTNSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjCTNSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:18:09 -0400
Received: from mail-m118111.qiye.163.com (mail-m118111.qiye.163.com [115.236.118.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93D723A64;
        Mon, 20 Mar 2023 06:17:50 -0700 (PDT)
Received: from localhost.localdomain (unknown [117.133.56.22])
        by mail-m118111.qiye.163.com (Hmail) with ESMTPA id 5AFCC5801D9;
        Mon, 20 Mar 2023 21:17:35 +0800 (CST)
From:   Donglin Peng <pengdonglin@sangfor.com.cn>
To:     mhiramat@kernel.org, rostedt@goodmis.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com
Cc:     linux-trace-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Donglin Peng <pengdonglin@sangfor.com.cn>
Subject: [PATCH v5 0/2] function_graph: Support recording and printing the return value of function
Date:   Mon, 20 Mar 2023 06:16:48 -0700
Message-Id: <20230320131650.482594-1-pengdonglin@sangfor.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTE5CVk1MHklMSU5PTk5MSVUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKTFVKSEhVTk1VSUlZV1kWGg8SFR0UWUFZT0tIVUpISkJIT1VKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NxQ6OCo5Cj0QCxEeNwkNGCMr
        ASkaCUNVSlVKTUxCSEpDSU5NTElDVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSkpMVUpISFVOTVVJSVlXWQgBWUFNS01DNwY+
X-HM-Tid: 0a86ff2b0a2a2eb7kusn5afcc5801d9
X-HM-MType: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

Donglin Peng (2):
  function_graph: Support recording and printing the return value of
    function
  tracing: Add documentation for funcgraph-retval and graph_retval_hex

 Documentation/trace/ftrace.rst       | 75 ++++++++++++++++++++++
 arch/arm/Kconfig                     |  1 +
 arch/arm/kernel/entry-ftrace.S       |  8 +++
 arch/arm64/Kconfig                   |  1 +
 arch/arm64/kernel/entry-ftrace.S     |  8 +++
 arch/riscv/Kconfig                   |  1 +
 arch/riscv/kernel/mcount.S           | 12 +++-
 arch/x86/Kconfig                     |  1 +
 arch/x86/kernel/ftrace_32.S          |  8 +++
 arch/x86/kernel/ftrace_64.S          | 10 +++
 include/linux/ftrace.h               |  3 +
 kernel/trace/Kconfig                 |  8 +++
 kernel/trace/fgraph.c                | 25 +++++++-
 kernel/trace/trace.h                 |  2 +
 kernel/trace/trace_entries.h         | 26 ++++++++
 kernel/trace/trace_functions_graph.c | 95 +++++++++++++++++++++++++---
 16 files changed, 272 insertions(+), 12 deletions(-)

-- 
2.25.1

