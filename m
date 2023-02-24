Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999666A19AE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjBXKLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjBXKLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:11:25 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E674B173D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:10:46 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8CxC9oljfhje6QEAA--.9425S3;
        Fri, 24 Feb 2023 18:10:45 +0800 (CST)
Received: from localhost.localdomain (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxX+QjjfhjNH86AA--.6368S2;
        Fri, 24 Feb 2023 18:10:44 +0800 (CST)
From:   Jinyang He <hejinyang@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Xi Ruoyao <xry111@xry111.site>,
        Youling Tang <tangyouling@loongson.cn>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Drop the per-node-mode exception handlers
Date:   Fri, 24 Feb 2023 18:10:07 +0800
Message-Id: <20230224101013.26971-1-hejinyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxX+QjjfhjNH86AA--.6368S2
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Ww1DJrW3AFy5ZF48Xw45GFg_yoW8Zr48pr
        9xZF93Jr48Gr9avw13t34Uurn8Jrn7Kr12qanFk348Cw12vr1UWr18JrWkXFyjq3y8Jr40
        qF1rJw1jgF1Dt37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
        0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series drops the per-node-mode exception handlers.

The UnixBench test results are as follows, Loongson-3C5000L-LL, CLFS7.1,

a, DYNAMIC_FTRACE enabled, KASLR disabled, no-pernode
b, DYNAMIC_FTRACE enabled, KASLR disabled, pernode
c, DYNAMIC_FTRACE enabled, KASLR enabled, no-pernode
       1 cpu     16 cpus
  a-1, 782.6     4025.1
  a-2, 783.3     3994.5
  a-3, 784.2     4045.5
  b-1, 775.5     3913.0
  b-2, 763.9     3833.8
  b-3, 777.7     3930.4
  c-1, 811.0     3950.4
  c-2, 795.7     3952.9

The results were almost identical, as Huacai said, the performance
difference between pernode and nopernode is negligible

Jinyang He (6):
  LoongArch: Rename handle_syscall to handle_sys
  LoongArch: Move the content defined by SYM_DATA to data or rodata
    section
  LoongArch: Create a exception handlers section
  LoongArch: Drop pernode exception handlers
  LoongArch: Fix up the prologue unwinder unwind exception frame
  LoongArch: Clean up la_abs macro

 arch/loongarch/include/asm/asmmacro.h   | 17 -----
 arch/loongarch/include/asm/setup.h      | 14 ----
 arch/loongarch/include/asm/stackframe.h |  2 +-
 arch/loongarch/include/asm/traps.h      | 81 ++++++++++++++++++++++
 arch/loongarch/include/asm/unwind.h     |  2 +-
 arch/loongarch/kernel/entry.S           | 16 +++--
 arch/loongarch/kernel/genex.S           | 73 +++++++++++++-------
 arch/loongarch/kernel/head.S            |  2 +
 arch/loongarch/kernel/mcount_dyn.S      |  2 +
 arch/loongarch/kernel/relocate.c        | 28 --------
 arch/loongarch/kernel/traps.c           | 74 +-------------------
 arch/loongarch/kernel/unwind_prologue.c | 91 +++----------------------
 arch/loongarch/kernel/vmlinux.lds.S     | 37 +++++++---
 arch/loongarch/mm/cache.c               |  6 --
 arch/loongarch/mm/tlb.c                 | 40 -----------
 arch/loongarch/mm/tlbex.S               | 67 +++++++++++-------
 arch/loongarch/power/suspend.c          |  5 +-
 17 files changed, 231 insertions(+), 326 deletions(-)
 create mode 100644 arch/loongarch/include/asm/traps.h

-- 
2.34.3

