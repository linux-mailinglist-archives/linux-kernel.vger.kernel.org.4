Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F672662119
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjAIJML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236883AbjAIJLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:11:46 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A3DE178AD
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:08:02 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxYvBx2btjdXUAAA--.1873S3;
        Mon, 09 Jan 2023 17:08:01 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxTuRw2btj_6sWAA--.4042S2;
        Mon, 09 Jan 2023 17:08:01 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Xi Ruoyao <xry111@xry111.site>,
        Jinyang He <hejinyang@loongson.cn>
Cc:     Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] LoongArch: Add kernel relocation and KASLR support
Date:   Mon,  9 Jan 2023 17:07:50 +0800
Message-Id: <1673255274-18238-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8DxTuRw2btj_6sWAA--.4042S2
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7uF45CFyfuFWUGr15Ww15Jwb_yoW8KFyUpr
        1Yyrn8GFW8GrnxJrW7ta4fur1rtwn2kF13X3ZxtryruFW3XF1UAw18Zr9rXFyDtw4rKrWI
        qrn5Gw1aq3W5ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
        0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xuctUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series to support kernel relocation and KASLR (only 64bit).

Both old[1] and new[2] toolchains support this feature, and the test results
are as follows:
1) Enable CONFING_RELOCATABLE
 # cat /proc/iomem 
 00000000-0fffffff : System RAM
   00000000-002c3fff : Reserved
   002c4000-008c3fff : Reserved
   02000000-02f4ffff : Kernel code
   02f50000-0381cbff : Kernel data
   0381cc00-0394ae37 : Kernel bss

2) Enable CONFING_RANDOMIZE_BASE (KASLR)
first:
 # cat /proc/iomem 
 00000000-0fffffff : System RAM
   00000000-002c3fff : Reserved
   002c4000-008c3fff : Reserved
   02550000-0349ffff : Kernel code
   034a0000-03d6cbff : Kernel data
   03d6cc00-03e9ae37 : Kernel bss

second:
 # cat /proc/iomem 
 00000000-0fffffff : System RAM
   00000000-002c3fff : Reserved
   002c4000-008c3fff : Reserved
   02ad0000-03a1ffff : Kernel code
   03a20000-042ecbff : Kernel data
   042ecc00-0441ae37 : Kernel bss

Thanks to @Ruoyao's and @Jinyang's for their help and suggestions.

Links:
[1]: https://github.com/sunhaiyong1978/CLFS-for-LoongArch/releases/download/5.0/loongarch64-clfs-5.1-cross-tools-c-only.tar.xz
[2]: https://github.com/sunhaiyong1978/CLFS-for-LoongArch/releases/download/6.0/loongarch64-clfs-6.3-cross-tools-c-only.tar.xz

Xi Ruoyao (1):
  LoongArch: Use trampoline for exception handlers and kill la.abs

Youling Tang (3):
  LoongArch: Add JUMP_LINK_ADDR macro implementation to avoid using
    la.abs
  LoongArch: Add support for kernel relocation
  LoongArch: Add support for kernel address space layout randomization
    (KASLR)

 arch/loongarch/Kconfig                  |  37 +++++
 arch/loongarch/Makefile                 |   5 +
 arch/loongarch/include/asm/page.h       |   6 +
 arch/loongarch/include/asm/stackframe.h |  16 +-
 arch/loongarch/include/asm/uaccess.h    |   1 -
 arch/loongarch/kernel/Makefile          |   2 +
 arch/loongarch/kernel/entry.S           |   6 +-
 arch/loongarch/kernel/genex.S           |  20 +--
 arch/loongarch/kernel/head.S            |  30 +++-
 arch/loongarch/kernel/relocate.c        | 210 ++++++++++++++++++++++++
 arch/loongarch/kernel/setup.c           |   3 +
 arch/loongarch/kernel/traps.c           |   4 +-
 arch/loongarch/kernel/vmlinux.lds.S     |  11 +-
 arch/loongarch/mm/tlbex.S               |  28 +---
 arch/loongarch/power/suspend_asm.S      |   5 +-
 15 files changed, 333 insertions(+), 51 deletions(-)
 create mode 100644 arch/loongarch/kernel/relocate.c

-- 
2.37.1

