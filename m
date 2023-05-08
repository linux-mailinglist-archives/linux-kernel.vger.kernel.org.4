Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD646F9D7E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 03:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjEHBpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 21:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjEHBo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 21:44:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4714711DA1
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 18:44:56 -0700 (PDT)
Received: from kwepemm600017.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QF3s922mwzpTk1;
        Mon,  8 May 2023 09:40:45 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 09:44:52 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH -next v9 0/5]arm64: add machine check safe support
Date:   Mon, 8 May 2023 09:44:31 +0800
Message-ID: <20230508014436.198717-1-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the increase of memory capacity and density, the probability of memory
error also increases. The increasing size and density of server RAM in data
centers and clouds have shown increased uncorrectable memory errors.

Currently, the kernel has mechanism to recover from hardware memory errors.
This patchset provides a new recovery mechanism.

For arm64, the hardware memory error handling in do_sea(), which is divided
into two cases:
 1. If the user state consumed the memory errors, the solution is to kill
    the user process and isolate the error page.
 2. If the kernel state consumed the memory errors, the solution is to
    panic.

For case 2, Undifferentiated panic may not be the optimal choice, as it can
be handled better. In some scenarios, we can avoid panic, such as uaccess,
if the uaccess fails due to memory error, only the user process will be
affected, killing the user process and isolating the user page with
hardware memory errors is a better choice.

Since V8:
 1. Rebase to latest kernel version and fix topo in some of the patches.
 2. According to the suggestion of Catalin, I attempted to modify the
    return value of function copy_mc_[user]_highpage() to bytes not copied.
    During the modification process, I found that it would be more
    reasonable to return -EFAULT when copy error occurs (referring to the
    newly added patch 4). 

    For ARM64, the implementation of copy_mc_[user]_highpage() needs to
    consider MTE. Considering the scenario where data copying is successful
    but the MTE tag copying fails, it is also not reasonable to return
    bytes not copied.
 3. Considering the recent addition of machine check safe support for
    multiple scenarios, modify commit message for patch 5 (patch 4 for V8).

Since V7:
 Currently, there are patches supporting recover from poison
 consumption for the cow scenario[1]. Therefore, Supporting cow
 scenario under the arm64 architecture only needs to modify the relevant
 code under the arch/.
 [1]https://lore.kernel.org/lkml/20221031201029.102123-1-tony.luck@intel.com/

Since V6:
 Resend patches that are not merged into the mainline in V6.

Since V5:
 1. Add patch2/3 to add uaccess assembly helpers.
 2. Optimize the implementation logic of arm64_do_kernel_sea() in patch8.
 3. Remove kernel access fixup in patch9.
 All suggestion are from Mark. 

Since V4:
 1. According Michael's suggestion, add patch5.
 2. According Mark's suggestiog, do some restructuring to arm64
 extable, then a new adaptation of machine check safe support is made based
 on this.
 3. According Mark's suggestion, support machine check safe in do_mte() in
 cow scene.
 4. In V4, two patches have been merged into -next, so V5 not send these
 two patches.

Since V3:
 1. According to Robin's suggestion, direct modify user_ldst and
 user_ldp in asm-uaccess.h and modify mte.S.
 2. Add new macro USER_MC in asm-uaccess.h, used in copy_from_user.S
 and copy_to_user.S.
 3. According to Robin's suggestion, using micro in copy_page_mc.S to
 simplify code.
 4. According to KeFeng's suggestion, modify powerpc code in patch1.
 5. According to KeFeng's suggestion, modify mm/extable.c and some code
 optimization.

Since V2:
 1. According to Mark's suggestion, all uaccess can be recovered due to
    memory error.
 2. Scenario pagecache reading is also supported as part of uaccess
    (copy_to_user()) and duplication code problem is also solved. 
    Thanks for Robin's suggestion.
 3. According Mark's suggestion, update commit message of patch 2/5.
 4. According Borisllav's suggestion, update commit message of patch 1/5.

Since V1:
 1.Consistent with PPC/x86, Using CONFIG_ARCH_HAS_COPY_MC instead of
   ARM64_UCE_KERNEL_RECOVERY.
 2.Add two new scenes, cow and pagecache reading.
 3.Fix two small bug(the first two patch).

V1 in here:
https://lore.kernel.org/lkml/20220323033705.3966643-1-tongtiangen@huawei.com/

Tong Tiangen (5):
  uaccess: add generic fallback version of copy_mc_to_user()
  arm64: add support for machine check error safe
  arm64: add uaccess to machine check safe
  mm/hwpoison: return -EFAULT when copy fail in
    copy_mc_[user]_highpage()
  arm64: support copy_mc_[user]_highpage()

 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/asm-extable.h | 15 +++++
 arch/arm64/include/asm/assembler.h   |  4 ++
 arch/arm64/include/asm/extable.h     |  1 +
 arch/arm64/include/asm/mte.h         |  5 ++
 arch/arm64/include/asm/page.h        | 10 ++++
 arch/arm64/lib/Makefile              |  2 +
 arch/arm64/lib/copy_mc_page.S        | 89 ++++++++++++++++++++++++++++
 arch/arm64/lib/mte.S                 | 27 +++++++++
 arch/arm64/mm/copypage.c             | 64 +++++++++++++++++---
 arch/arm64/mm/extable.c              | 21 ++++++-
 arch/arm64/mm/fault.c                | 29 ++++++++-
 arch/powerpc/include/asm/uaccess.h   |  1 +
 arch/x86/include/asm/uaccess.h       |  1 +
 include/linux/highmem.h              | 12 ++--
 include/linux/uaccess.h              |  9 +++
 mm/khugepaged.c                      |  4 +-
 17 files changed, 279 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/lib/copy_mc_page.S

-- 
2.25.1

