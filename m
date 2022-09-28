Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD0D5ED23A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbiI1Aun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiI1AuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:50:19 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30A2412385B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 17:50:17 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxvmtBmjNjVwIjAA--.53900S2;
        Wed, 28 Sep 2022 08:50:09 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Add kprobe and kretprobe support for LoongArch
Date:   Wed, 28 Sep 2022 08:50:04 +0800
Message-Id: <1664326209-13995-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8DxvmtBmjNjVwIjAA--.53900S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFyUKF17KF17ArWfJrWxCrg_yoWkCFb_A3
        W3t348CrW8JayUXa4qqw4fJrWqyr48KFnYkF9rXr4xuF15Xr17tw4kWa4Yva97Ka4DXFZ8
        JrWFgr95uF1jvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb28YjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_twCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jIZXrUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
  -- Split simu_branch() and simu_pc() into a single patch
  -- Call kprobe_page_fault() in do_page_fault()
  -- Add kprobes_trampoline.S for kretprobe

Tiezhu Yang (5):
  LoongArch: Simulate branch and PC instructions
  LoongArch: Add kprobe support
  LoongArch: Add kretprobe support
  samples/kprobes: Add LoongArch support
  LoongArch: Enable KPROBES in default config

 arch/loongarch/Kconfig                     |   2 +
 arch/loongarch/configs/loongson3_defconfig |   1 +
 arch/loongarch/include/asm/inst.h          |  31 +++
 arch/loongarch/include/asm/kprobes.h       |  44 ++++
 arch/loongarch/include/asm/ptrace.h        |   1 +
 arch/loongarch/kernel/Makefile             |   2 +
 arch/loongarch/kernel/inst.c               | 113 ++++++++++
 arch/loongarch/kernel/kprobes.c            | 336 +++++++++++++++++++++++++++++
 arch/loongarch/kernel/kprobes_trampoline.S |  97 +++++++++
 arch/loongarch/mm/fault.c                  |   3 +
 samples/kprobes/kprobe_example.c           |   8 +
 11 files changed, 638 insertions(+)
 create mode 100644 arch/loongarch/include/asm/kprobes.h
 create mode 100644 arch/loongarch/kernel/kprobes.c
 create mode 100644 arch/loongarch/kernel/kprobes_trampoline.S

-- 
2.1.0

