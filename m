Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793FF6A5412
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjB1IDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjB1IDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:03:15 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89159103
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:03:13 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8DxE4RAtf1jsmUGAA--.6442S3;
        Tue, 28 Feb 2023 16:03:12 +0800 (CST)
Received: from localhost.localdomain (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxB707tf1jb3tAAA--.49681S2;
        Tue, 28 Feb 2023 16:03:09 +0800 (CST)
From:   Jinyang He <hejinyang@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Xi Ruoyao <xry111@xry111.site>,
        Youling Tang <tangyouling@loongson.cn>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] Drop the per-node-mode exception handlers
Date:   Tue, 28 Feb 2023 16:02:51 +0800
Message-Id: <20230228080257.28807-1-hejinyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxB707tf1jb3tAAA--.49681S2
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Ww1DJrW3AFy5ZF48Xw45GFg_yoW8ZFy5pr
        9xZF93Jr48Gr9avw13t34Uurn8Jws7Kr12qanFk348C3Wavr1UWr18trWkXFyjq3yrJr40
        qFn5Jw1agF1qq37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r
        4UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXUUUUU=
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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

v2:
  Directly call rather than using jirl.

Thanks for Ruoyao.

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
 arch/loongarch/kernel/entry.S           | 15 ++--
 arch/loongarch/kernel/genex.S           | 75 ++++++++++++--------
 arch/loongarch/kernel/head.S            |  2 +
 arch/loongarch/kernel/mcount_dyn.S      |  2 +
 arch/loongarch/kernel/relocate.c        | 28 --------
 arch/loongarch/kernel/traps.c           | 74 +-------------------
 arch/loongarch/kernel/unwind_prologue.c | 91 +++----------------------
 arch/loongarch/kernel/vmlinux.lds.S     | 37 +++++++---
 arch/loongarch/mm/cache.c               |  6 --
 arch/loongarch/mm/tlb.c                 | 40 -----------
 arch/loongarch/mm/tlbex.S               | 71 +++++++++++--------
 arch/loongarch/power/suspend.c          |  5 +-
 17 files changed, 230 insertions(+), 332 deletions(-)
 create mode 100644 arch/loongarch/include/asm/traps.h

-- 
2.34.3

