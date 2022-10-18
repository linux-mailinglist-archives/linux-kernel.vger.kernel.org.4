Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC42602C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiJRMrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiJRMrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:47:12 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF93C45A3;
        Tue, 18 Oct 2022 05:47:07 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MsD8B5qhhzJn2r;
        Tue, 18 Oct 2022 20:44:26 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 20:47:04 +0800
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 20:47:03 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <linux@armlinux.org.uk>, <linus.walleij@linaro.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <will@kernel.org>,
        <arnd@arndb.de>, <ardb@kernel.org>, <rmk+kernel@armlinux.org.uk>,
        <geert+renesas@glider.be>, <nick.hawkins@hpe.com>,
        <john@phrozen.org>, <mhiramat@kernel.org>, <lihuafei1@huawei.com>,
        <ast@kernel.org>, <thunder.leizhen@huawei.com>,
        <rostedt@goodmis.org>, <linyujun809@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: [PATCH v4 0/2] ARM: Convert to ARCH_STACKWALK
Date:   Tue, 18 Oct 2022 20:43:37 +0800
Message-ID: <20221018124339.115793-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series mainly updates the ARM stack trace code to use the newer and
simpler arch_stack_walk() interface.

When Russell applied patch 1, the patch tracker complained of a minor
conflict with Lei Zhen's patch (see [1]). Lei Zhen's patch has been
merged into v6.1-rc1. Now rebase to v6.1-rc1 and resend this patch set.

Thanks!

[1] https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9235/1

v4:
 - Rebase to v6.1-rc1.
 - Fix commit log for patch 2: 'arch _stack_walk()' -> 'arch_stack_walk()'.
 - Remove the two bugfix patches that have been merged in:
    ARM: stacktrace: Skip frame pointer boundary check for call_with_stack()
    ARM: stacktrace: Avoid duplicate saving of exception PC value

v3 resend: https://lore.kernel.org/lkml/20220826074047.107357-1-lihuafei1@huawei.com/
 It's been a month since I sent the v3. Linus told me I needed to add the
 patch to Russell's patch tracker myself, rebase to v6.0-rc1 before that.
 Thanks Linus for the tip!

 Since commit af6f23b88e95 ("ARM/dma-mapping: use the generic versions of
 dma_to_phys/phys_to_dma by default") and commit ae626eb97376
 ("ARM/dma-mapping: use dma-direct unconditionally") modified
 arch/arm/Kconfig, there is a minor conflict with patch 4 when rebase.

v3: https://lore.kernel.org/lkml/20220727040022.139387-1-lihuafei1@huawei.com/
 - According to the discussion with Linus and Russell in v1:
   - Add a comment about "regs[1]" in patch 2, and remove the
     unnecessary ternary operator in the initialization of
     "frame->ex_frame".
   - Remove the patch "ARM: stacktrace: Allow stack trace saving for
     non-current tasks", and keep the check for not being able to
     unwind non-current tasks (including tasks running on other CPUs)
     when CONFIG_SMP=y in patch 4.
 - Rebase to linux-5.19-rc8.

v2: https://lore.kernel.org/lkml/20220713110020.85511-1-lihuafei1@huawei.com/
 - As suggested by Mark, the commit logs for patch 4 and 5 were
   refined for easy review.

v1: https://lore.kernel.org/lkml/20220712021527.109921-1-lihuafei1@huawei.com/

Li Huafei (2):
  ARM: stacktrace: Make stack walk callback consistent with generic code
  ARM: stacktrace: Convert stacktrace to generic ARCH_STACKWALK

 arch/arm/Kconfig                  |   1 +
 arch/arm/include/asm/stacktrace.h |   2 +-
 arch/arm/kernel/perf_callchain.c  |   9 +--
 arch/arm/kernel/return_address.c  |   8 +-
 arch/arm/kernel/stacktrace.c      | 119 +++++++++---------------------
 5 files changed, 44 insertions(+), 95 deletions(-)

-- 
2.17.1

