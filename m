Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF616E76E8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjDSJ52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDSJ5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:57:22 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EE82AF37
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:57:19 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxJDT9uj9k3OEeAA--.49055S3;
        Wed, 19 Apr 2023 17:57:17 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxbb78uj9kXuguAA--.15680S2;
        Wed, 19 Apr 2023 17:57:17 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v3 0/6] Add uprobes support for LoongArch
Date:   Wed, 19 Apr 2023 17:56:55 +0800
Message-Id: <1681898221-27828-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8Bxbb78uj9kXuguAA--.15680S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7tF4kWFyxXr15ZFy3Zw1DJrb_yoW8Ww1xpF
        srursxGr45G34fJr9xta43ur1Yyr4xGrW2q3ZIy34rJr4jqr15JF18KrZ8AF98t3y5KrW0
        q3WrG3yYga1UA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJV
        W8JbIYCTnIWIevJa73UjIFyTuYvjxUzZ2-UUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
  -- Check atomic instructions in insns_not_supported()
  -- Remove five DIE_* definitions in kdebug.h

v2:
  -- Move the functions to inst.c in patch #1
  -- Pass around union for insns_not_supported(),
     insns_need_simulation() and arch_simulate_insn()

v1:
  -- Split the RFC patch #2 into two patches
  -- Use larch_insn_gen_break() to generate break insns
     for kprobes and uprobes
  -- Pass around instruction word instead of union for
     insns_not_supported(), insns_need_simulation() and
     arch_simulate_insn() to avoid type conversion for callers
  -- Add a simple test case for uprobes in the commit message

Tiezhu Yang (6):
  LoongArch: Move three functions from kprobes.c to inst.c
  LoongArch: Add larch_insn_gen_break() to generate break insns
  LoongArch: Use larch_insn_gen_break() for kprobes
  LoongArch: Add uprobes support
  LoongArch: Check atomic instructions in insns_not_supported()
  LoongArch: Remove five DIE_* definitions in kdebug.h

 arch/loongarch/Kconfig               |   3 +
 arch/loongarch/include/asm/inst.h    |  42 ++++++++++
 arch/loongarch/include/asm/kdebug.h  |   5 --
 arch/loongarch/include/asm/kprobes.h |   2 +-
 arch/loongarch/include/asm/uprobes.h |  36 +++++++++
 arch/loongarch/kernel/Makefile       |   1 +
 arch/loongarch/kernel/inst.c         |  54 +++++++++++++
 arch/loongarch/kernel/kprobes.c      |  75 ++++--------------
 arch/loongarch/kernel/traps.c        |   9 +--
 arch/loongarch/kernel/uprobes.c      | 143 +++++++++++++++++++++++++++++++++++
 10 files changed, 298 insertions(+), 72 deletions(-)
 create mode 100644 arch/loongarch/include/asm/uprobes.h
 create mode 100644 arch/loongarch/kernel/uprobes.c

-- 
2.1.0

