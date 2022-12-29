Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530036589A2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 07:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiL2GPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 01:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiL2GPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 01:15:46 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D0623AE
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 22:15:44 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8BxnuuPMK1jHjMJAA--.20817S3;
        Thu, 29 Dec 2022 14:15:43 +0800 (CST)
Received: from localhost.localdomain (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxrb6OMK1jIiYPAA--.24618S2;
        Thu, 29 Dec 2022 14:15:42 +0800 (CST)
From:   Jinyang He <hejinyang@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Qing Zhang <zhangqing@loongson.cn>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 0/5] LoongArch: Some fix and new features for unwinders
Date:   Thu, 29 Dec 2022 14:15:11 +0800
Message-Id: <20221229061516.31671-1-hejinyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxrb6OMK1jIiYPAA--.24618S2
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvdXoWrZry5Xw4fZw4rXF4fuF1Utrb_yoWkKwc_WF
        yxCa4UGrWkWas8J3WDtrWfJw1UXa10qF90kas8Zr4xAFn8AF13JrZxXw13Z34qgr4UWrs8
        J3y0grnY9w1j9jkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        A7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2
        jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262
        kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km
        07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        CVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU0epB3UUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the stacktrace more effective and the codes more clear.

v2:
  Directly use unwinder_guess when regiser unwinder.
  Drop unwind type.
  Drop patch which add raw_show_trace parameter.
  Handle task == NULL case in unwind_start.

  Thanks for Qing and Huacai.

Jinyang He (5):
  LoongArch: Get frame info in unwind_start when regs is not supported
  LoongArch: Use correct sp value to get graph addr in unwinder guess
  LoongArch: Adjust PC value when unwind next frame in prologue unwinder
  LoongArch: Strip guess_unwinder out from prologue_unwinder
  LoongArch: Add generic ex-handler unwind in prologue unwinder

 arch/loongarch/include/asm/ftrace.h     |   2 -
 arch/loongarch/include/asm/unwind.h     |  37 +++-
 arch/loongarch/kernel/Makefile          |   3 +-
 arch/loongarch/kernel/genex.S           |   3 +
 arch/loongarch/kernel/process.c         |  12 +-
 arch/loongarch/kernel/traps.c           |   3 -
 arch/loongarch/kernel/unwind.c          |  52 ++++++
 arch/loongarch/kernel/unwind_guess.c    |  45 ++---
 arch/loongarch/kernel/unwind_prologue.c | 235 ++++++++++++++----------
 arch/loongarch/mm/tlb.c                 |   2 +-
 10 files changed, 242 insertions(+), 152 deletions(-)
 create mode 100644 arch/loongarch/kernel/unwind.c

-- 
2.34.3

