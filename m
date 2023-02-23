Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D565B6A0706
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 12:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjBWLGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 06:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbjBWLGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 06:06:36 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D85B053EEC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 03:06:33 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxWNm4SPdjEBsEAA--.8360S3;
        Thu, 23 Feb 2023 19:06:32 +0800 (CST)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxK763SPdjgJg5AA--.39214S2;
        Thu, 23 Feb 2023 19:06:32 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] LoongArch: Add single kernel image implementation for kdump
Date:   Thu, 23 Feb 2023 19:06:29 +0800
Message-Id: <1677150391-12838-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8DxK763SPdjgJg5AA--.39214S2
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvdXoWrZw15JFykJFWrXrW7Cr43Awb_yoWfuFg_ua
        s3J34UGw48XFWvyw42qw4fXa4akay8ZFn0yF1qqrW3Wwn3Jrn8Jrs8X3Wrur1qgay8trs8
        JrWvqF9YyrnFvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        j7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7
        xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWle2I2
        62IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxV
        CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
        6r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
        WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG
        6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_Gr
        UvcSsGvfC2KfnxnUUI43ZEXa7IU83UUUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add single kernel image implementation for kdump.

kexec-tools needs to be updated to make sure it jumps to the correct
kernel entry.

When kaslr is enabled, it is best to add the "nokaslr" parameter when
performing kdump operations to ensure that the randomized kernel
position conflicts with other segments (such as initrd loading
position).
eg: sudo kexec -p vmlinux.efi --reuse-cmdline --append="nokaslr"

Changes from v1 to v2:

- Rewrite commit message.

Youling Tang (2):
  LoongArch: kdump: Add single kernel image implementation
  LoongArch: kdump: Add crashkernel=YM handling

 arch/loongarch/Kconfig                     | 12 +-----------
 arch/loongarch/Makefile                    |  4 ----
 arch/loongarch/configs/loongson3_defconfig |  1 +
 arch/loongarch/include/asm/addrspace.h     |  2 ++
 arch/loongarch/kernel/head.S               |  2 +-
 arch/loongarch/kernel/setup.c              | 15 ++++++++++++---
 6 files changed, 17 insertions(+), 19 deletions(-)

-- 
2.37.3

