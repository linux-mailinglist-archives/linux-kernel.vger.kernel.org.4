Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28548747D4C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjGEGrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjGEGrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:47:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33A91700;
        Tue,  4 Jul 2023 23:47:43 -0700 (PDT)
Received: from kwepemi500019.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qwqrp1gTbzMq8h;
        Wed,  5 Jul 2023 14:44:26 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemi500019.china.huawei.com (7.221.188.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 14:47:39 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <stable@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <mhiramat@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <sashal@kernel.org>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <xukuohai@huawei.com>, <natechancellor@gmail.com>,
        <ndesaulniers@google.com>, <rostedt@goodmis.org>,
        <weiyongjun1@huawei.com>, <gustavoars@kernel.org>,
        <namit@vmware.com>, <laijs@linux.alibaba.com>,
        <clang-built-linux@googlegroups.com>, <lihuafei1@huawei.com>
Subject: [PATCH 5.10 0/9] x86/kprobes: Fix kprobe debug exception handling logic
Date:   Wed, 5 Jul 2023 14:46:44 +0800
Message-ID: <20230705064653.226811-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500019.china.huawei.com (7.221.188.117)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found an issue with null pointer access due to kprobe debug exception
error handling on 5.10, and I proposed a separate fix patch for 5.10,
see [1]. But as Greg gave advice, we always choose to backport relevant
patches from upstream to fix issues with stable kernels, so I made this
patch set.

The main one we need to backport is patch 5, which uses int3 instead of
debug trap for single-stepping, thus avoiding the problems we
encountered with kprobe debug exception error handling. Patches 1-4 are
pre-patches, and patches 6-9 are fixes for patch 5. The major
modifications are patch 2 and patch 5. Patch 2 optimizes
resume_execution() to avoid repeated instruction decoding, and patch 5
uses int3 instead of debug trap, and as Masami said in the commit
message this patch will change some behavior of kprobe, but it has
almost no effect on the actual usage.

Please let me know if there are any problems, thanks!

[1] https://lore.kernel.org/lkml/20230630020845.227939-1-lihuafei1@huawei.com/

Gustavo A. R. Silva (1):
  kprobes/x86: Fix fall-through warnings for Clang

Masami Hiramatsu (5):
  x86/kprobes: Do not decode opcode in resume_execution()
  x86/kprobes: Retrieve correct opcode for group instruction
  x86/kprobes: Identify far indirect JMP correctly
  x86/kprobes: Use int3 instead of debug trap for single-step
  x86/kprobes: Fix to identify indirect jmp and others using range case

Masami Hiramatsu (Google) (1):
  x86/kprobes: Update kcb status flag after singlestepping

Nadav Amit (1):
  x86/kprobes: Fix JNG/JNLE emulation

Wei Yongjun (1):
  x86/kprobes: Move 'inline' to the beginning of the kprobe_is_ss()
    declaration

 arch/x86/include/asm/kprobes.h |  24 +-
 arch/x86/kernel/kprobes/core.c | 639 ++++++++++++++++++++-------------
 arch/x86/kernel/traps.c        |   3 -
 3 files changed, 409 insertions(+), 257 deletions(-)

-- 
2.17.1

