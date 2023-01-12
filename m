Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FF56667D9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 01:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbjALAhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 19:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbjALAhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:37:03 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 214F0DEE4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 16:36:55 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8CxOuomVr9j0xIBAA--.3246S3;
        Thu, 12 Jan 2023 08:36:54 +0800 (CST)
Received: from localhost.localdomain (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxbL4kVr9jLyEYAA--.43573S2;
        Thu, 12 Jan 2023 08:36:54 +0800 (CST)
From:   Jinyang He <hejinyang@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Qing Zhang <zhangqing@loongson.cn>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 0/5] LoongArch: Some fix and new features for unwinders
Date:   Thu, 12 Jan 2023 08:36:22 +0800
Message-Id: <20230112003627.26111-1-hejinyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxbL4kVr9jLyEYAA--.43573S2
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW7WrWruFWxWry3Ww1xKw4kWFg_yoW8Gr1xp3
        yfuFnxXr4rKr9Fqr9Fyw15ur1DJr97G3yaqanIqry8GF12qr17Zr1FvryDZF98t3y8G3y0
        qrn5G3yjgayDtaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bVAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1ln4kS
        14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAq
        x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
        43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
        7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
        WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07je
        pB-UUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the stacktrace more effective and the codes more clear.

v3:
  Make unwind_{guess,prologue}.c as frontend and share unwind.c.
  Drop unwind ops and reenable unwind type for clear logic.

v2:
  Directly use unwinder_guess when register unwinder.
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
 arch/loongarch/include/asm/unwind.h     |  40 +++-
 arch/loongarch/kernel/Makefile          |   2 +-
 arch/loongarch/kernel/genex.S           |   3 +
 arch/loongarch/kernel/process.c         |  12 +-
 arch/loongarch/kernel/traps.c           |   3 -
 arch/loongarch/kernel/unwind.c          |  33 ++++
 arch/loongarch/kernel/unwind_guess.c    |  49 +----
 arch/loongarch/kernel/unwind_prologue.c | 247 ++++++++++++++----------
 arch/loongarch/mm/tlb.c                 |   2 +-
 10 files changed, 232 insertions(+), 161 deletions(-)
 create mode 100644 arch/loongarch/kernel/unwind.c

-- 
2.34.3

