Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293A15B92C7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 04:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiIOCyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 22:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiIOCyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 22:54:06 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32D498C477
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 19:54:04 -0700 (PDT)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxrmu6kyJjTa8ZAA--.20455S2;
        Thu, 15 Sep 2022 10:53:46 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>, Baoquan He <bhe@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kexec@lists.infradead.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] LoongArch: Add kexec/kdump support
Date:   Thu, 15 Sep 2022 10:53:43 +0800
Message-Id: <1663210426-15446-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8Cxrmu6kyJjTa8ZAA--.20455S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFW3Xw4rCFWkZF1kWrWDtwb_yoW5WFyfpF
        1Uurn8Kr4kGFn3tws3Jwnrury5Gwn7Gw43W3ZFy348ZF12qr1UArnYqF9rZF1Dtw4fKr40
        qF1Fg34293WUJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc2xSY4AK67AK6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
        UI43ZEXa7IU5sTmPUUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series to support kexec/kdump (only 64bit).

Kexec is a system call that enables you to load and boot into another kernel
from the currently running kernel. This is useful for kernel developers or
other people who need to reboot very quickly without waiting for the whole
BIOS boot process to finish.

Kdump uses kexec to quickly boot to a dump-capture kernel whenever a
dump of the system kernel's memory needs to be taken (for example, when
the system panics). The system kernel's memory image is preserved across
the reboot and is accessible to the dump-capture kernel.

For details, see Documentation/admin-guide/kdump/kdump.rst.

User tools kexec-tools see link [1].

TODO:
Currently kdump does not support the same binary image, the production kernel
and the capture kernel will be generated with different configurations. I will
support kernel relocation support in the near future. Then will go to implement
the same binary support based on kernel relocation support.

[1] Link: https://github.com/tangyouling/kexec-tools

Changes in v3:
 - Adjust the PE header (note that kexec-tools needs to be updated).
 - Add ibar in kexec_reboot().
 - boot_flag is replaced by efi_boot.
 - Adjust do_kexec parameter passing order.
 - Adjust the order of static variables to be consistent with do_kexec.
 - Remove a-series register save.
 - Some comments and register usage modification.
 - Add the opening and closing of the cpu core state.
 - Add a call to cpu_device_up to turn it on when the cpu core state is offline.

Changes in v2:
 - Add ibar.
 - Access via IOCSR.
 - Remove the settings of the tp, sp registers.
 - Remove the crash.c file and merge the relevant code into machine_kexec.c.
 - Adjust the use of CONFIG_SMP macro to avoid build errors under !SMP
   configuration.
 - Change the default value of PHYSICAL_START of the capture kernel to
   0x90000000a0000000.

Youling Tang (3):
  LoongArch: Add kexec support
  LoongArch: Add kdump support
  LoongArch: Enable CONFIG_KEXEC

 arch/loongarch/Kconfig                     |  33 +++
 arch/loongarch/Makefile                    |   4 +
 arch/loongarch/configs/loongson3_defconfig |   1 +
 arch/loongarch/include/asm/kexec.h         |  58 ++++
 arch/loongarch/kernel/Makefile             |   3 +
 arch/loongarch/kernel/crash_dump.c         |  19 ++
 arch/loongarch/kernel/head.S               |   6 +-
 arch/loongarch/kernel/machine_kexec.c      | 295 +++++++++++++++++++++
 arch/loongarch/kernel/mem.c                |   6 +
 arch/loongarch/kernel/relocate_kernel.S    | 111 ++++++++
 arch/loongarch/kernel/setup.c              |  49 ++++
 arch/loongarch/kernel/traps.c              |   4 +
 12 files changed, 588 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/include/asm/kexec.h
 create mode 100644 arch/loongarch/kernel/crash_dump.c
 create mode 100644 arch/loongarch/kernel/machine_kexec.c
 create mode 100644 arch/loongarch/kernel/relocate_kernel.S

-- 
2.36.0

