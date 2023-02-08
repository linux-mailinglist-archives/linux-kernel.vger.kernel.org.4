Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E8668EC55
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjBHKIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBHKIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:08:42 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05DE9125A8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:08:39 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxGuqmdONjwOwPAA--.31469S3;
        Wed, 08 Feb 2023 18:08:38 +0800 (CST)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxtOWldONjv1gtAA--.52925S2;
        Wed, 08 Feb 2023 18:08:37 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] LoongArch: Add hardware breakpoints/watchpoints support
Date:   Wed,  8 Feb 2023 18:08:35 +0800
Message-Id: <20230208100837.2451-1-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxtOWldONjv1gtAA--.52925S2
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7uF4DWw1DKr45tFyxGFWfZrb_yoW8try3pF
        ZI9rn5Kr4DKrZ3Xwsrt3y8uryrGFn7C3yaq3W7t342ywnFqF1FvrsakryDXa45J3yfJ340
        qr1rWw4Fga1UAaUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b3xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2
        jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20x
        vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s02
        6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF
        0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
        c7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
        v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7I
        U8hiSPUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use perf framework to manage hardware instruction and data breakpoints.
LoongArch defines hardware watchpoint functions for instruction fetch
and load/store operations, after the software configures hardware watchpoints
for instruction fetch and load/store operations. The processor hardware will
monitor the access address of the instruction fetch and load/store operation,
and will trigger the exception of the watchpoint when it meets the conditions
set by the watchpoint.

The hardware monitoring points for instruction fetching and load/store operations
each have a register for the overall configuration of all monitoring points,
a register for recording the status of all monitoring points, and four registers
required for configuration of each watchpoint individually.

Watchpoint related control status register chapters:
https://github.com/loongson/LoongArch-Documentation/releases/download/2022.08.12/
LoongArch-Vol1-v1.02-CN.pdf

Initial version has the following limitations:
- userspace debug is not yet enabled: work on ptrace/gdb is in progress
- no support for virtualization

Can be tested: e.g.
1. see samples/hw_breakpoint and register_wide_hw_breakpoint.
2. ptrace(PTRACE_SINGLESTEP/..., pid, NULL, NULL)

TODO:
- Add hardware breakpoints/watchpoints for gdb, kgdb

Qing Zhang (2):
  LoongArch: Add hardware breakpoints/watchpoints support
  LoongArch: Add ptrace single step support

 arch/loongarch/Kconfig                     |   1 +
 arch/loongarch/include/asm/hw_breakpoint.h | 145 ++++++
 arch/loongarch/include/asm/loongarch.h     |  32 +-
 arch/loongarch/include/asm/processor.h     |  11 +-
 arch/loongarch/include/asm/ptrace.h        |   2 +
 arch/loongarch/include/asm/switch_to.h     |   1 +
 arch/loongarch/kernel/Makefile             |   1 +
 arch/loongarch/kernel/hw_breakpoint.c      | 525 +++++++++++++++++++++
 arch/loongarch/kernel/process.c            |   7 +
 arch/loongarch/kernel/ptrace.c             |  68 +++
 arch/loongarch/kernel/traps.c              |  31 +-
 11 files changed, 803 insertions(+), 21 deletions(-)
 create mode 100644 arch/loongarch/include/asm/hw_breakpoint.h
 create mode 100644 arch/loongarch/kernel/hw_breakpoint.c

-- 
2.36.0

