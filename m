Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E11E6EFF3E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 04:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242876AbjD0CNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 22:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242763AbjD0CNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 22:13:41 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C726349DB;
        Wed, 26 Apr 2023 19:12:39 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Cxe+oW2klky14BAA--.2406S3;
        Thu, 27 Apr 2023 10:12:38 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxqrYQ2klkZ_U9AA--.18515S2;
        Thu, 27 Apr 2023 10:12:33 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v2 0/5] LoongArch: ftrace: Add direct call support and code simplification
Date:   Thu, 27 Apr 2023 10:12:27 +0800
Message-Id: <1682561552-32324-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxqrYQ2klkZ_U9AA--.18515S2
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7uFWUJFWrWF4kJr1xXF15twb_yoW8tFW5pr
        W3uasrGF48AFsxWwsI9a45WF13t34xAFyDZa15CryYkFyDur4UZrsayFZxG343J3s5G3y2
        qFnrJw18KF13ZaDanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JF0_JFyl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxV
        Aaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
        O2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
        JbIYCTnIWIevJa73UjIFyTuYvjxU4eMKDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Patch 1-2]: Fix build errors and simplify code.

[Patch 3-4]:
This series adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for LoongArch.
SAMPLE_FTRACE_DIRECT and SAMPLE_FTRACE_DIRECT_MULTI are also included
here as the samples for testing DIRECT_CALLS related interface.

Part of the code refers to arm64 and riscv.

The following tests have been passed in my local 3A5000 machine.
 - ftrace*.ko
 - tools/testing/selftests/ftrace/

eg:
[loongson@linux linux]$ sudo insmod samples/ftrace/ftrace-direct-too.ko
[root@linux linux]# cat /sys/kernel/debug/tracing/trace | tail
           rmmod-4552    [001] .....  3166.654540: 0xffff800002094040: handle mm fault vma=00000000d0dbdb16 address=7ffff2a793e8 flags=254
           rmmod-4552    [001] .....  3166.654550: 0xffff800002094040: handle mm fault vma=0000000047694d8b address=555570700008 flags=255
           rmmod-4552    [001] .....  3166.654557: 0xffff800002094040: handle mm fault vma=00000000d0dbdb16 address=7ffff29e6eb0 flags=254
           rmmod-4552    [001] .....  3166.654561: 0xffff800002094040: handle mm fault vma=00000000d0dbdb16 address=7ffff297d480 flags=254

[Patch 5]: Abstract DYNAMIC_FTRACE_WITH_ARGS accesses.
Note: This patch depends on regs_set_return_value() in the patch
"LoongArch: Add support for function error injection".


Changes in v2:
 - Rewrite commit message.

Qing Zhang (1):
  LoongArch: Abstract DYNAMIC_FTRACE_WITH_ARGS accesses

Youling Tang (4):
  LoongArch: Fix build error if CONFIG_DYNAMIC_FTRACE_WITH_REGS is not
    set
  LoongArch: ftrace: Implement ftrace_find_callable_addr() to simplify
    code
  LoongArch: ftrace: Add direct call support
  LoongArch: ftrace: Add direct call trampoline samples support

 arch/loongarch/Kconfig                      |   3 +
 arch/loongarch/include/asm/ftrace.h         |  37 ++++++
 arch/loongarch/kernel/ftrace_dyn.c          | 132 +++++++++++---------
 arch/loongarch/kernel/mcount_dyn.S          |   7 +-
 samples/ftrace/ftrace-direct-modify.c       |  34 +++++
 samples/ftrace/ftrace-direct-multi-modify.c |  41 ++++++
 samples/ftrace/ftrace-direct-multi.c        |  25 ++++
 samples/ftrace/ftrace-direct-too.c          |  27 ++++
 samples/ftrace/ftrace-direct.c              |  23 ++++
 9 files changed, 266 insertions(+), 63 deletions(-)

-- 
2.37.1

