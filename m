Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE816C8AB1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 04:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjCYDiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 23:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjCYDiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 23:38:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D951BF1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 20:38:07 -0700 (PDT)
Received: from kwepemm600017.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Pk4T80DcSz17PFx;
        Sat, 25 Mar 2023 11:34:52 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 25 Mar 2023 11:38:00 +0800
Message-ID: <0353570f-38bb-ebff-8152-c0d1cfec26f3@huawei.com>
Date:   Sat, 25 Mar 2023 11:38:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v8 0/4]arm64: add machine check safe support
To:     Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>, Xie XiuQi <xiexiuqi@huawei.com>
References: <20221219120008.3818828-1-tongtiangen@huawei.com>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <20221219120008.3818828-1-tongtiangen@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all maintainer,

With the increase of memory capacity and density, the memory error
increases，memory errors is the main factor causing server system
downtime, a statistics from intel [1].

For ARM64 server, it is more serious without mc safe copy feature,
feedback from our products, that is why we want to support it on arm64.

Also some new kind of low-reliable memory like HBM（high bandwidth but
low reliability）was introduced，this becomes more of a problem.

We hope the patch set could be incorporated into the community, can you
give me some follow-up suggestions?

[1] 
https://www.intel.com.tw/content/www/tw/zh/software/intel-memory-failure-prediction-jd-cloud.html

Thanks.
Tong.

在 2022/12/19 20:00, Tong Tiangen 写道:
> With the increase of memory capacity and density, the probability of
> memory error increases. The increasing size and density of server RAM
> in the data center and cloud have shown increased uncorrectable memory
> errors.
> 
> Currently, the kernel has a mechanism to recover from hardware memory
> errors. This patchset provides an new recovery mechanism.
> 
> For arm64, the hardware memory error handling is do_sea() which divided
> into two cases:
>   1. The user state consumed the memory errors, the solution is kill the
>      user process and isolate the error page.
>   2. The kernel state consumed the memory errors, the solution is panic.
> 
> For case 2, Undifferentiated panic maybe not the optimal choice, it can
> be handled better, in some scenarios, we can avoid panic, such as
> uaccess, if the uaccess fails due to memory error, only the user
> process will be affected, kill the user process and isolate the user
> page with hardware memory errors is a better choice.
> 
> Since V7:
>   Currently, there are patches supporting recover from poison
>   consumption for the cow scenario[1]. Therefore, Supporting cow
>   scenario under the arm64 architecture only needs to modify the relevant
>   code under the arch/.
>   [1]https://lore.kernel.org/lkml/20221031201029.102123-1-tony.luck@intel.com/
> 
> Since V6:
>   Resend patches that are not merged into the mainline in V6.
> 
> Since V5:
>   1. Add patch2/3 to add uaccess assembly helpers.
>   2. Optimize the implementation logic of arm64_do_kernel_sea() in patch8.
>   3. Remove kernel access fixup in patch9.
>   All suggestion are from Mark.
> 
> Since V4:
>   1. According Michael's suggestion, add patch5.
>   2. According Mark's suggestiog, do some restructuring to arm64
>   extable, then a new adaptation of machine check safe support is made based
>   on this.
>   3. According Mark's suggestion, support machine check safe in do_mte() in
>   cow scene.
>   4. In V4, two patches have been merged into -next, so V5 not send these
>   two patches.
> 
> Since V3:
>   1. According to Robin's suggestion, direct modify user_ldst and
>   user_ldp in asm-uaccess.h and modify mte.S.
>   2. Add new macro USER_MC in asm-uaccess.h, used in copy_from_user.S
>   and copy_to_user.S.
>   3. According to Robin's suggestion, using micro in copy_page_mc.S to
>   simplify code.
>   4. According to KeFeng's suggestion, modify powerpc code in patch1.
>   5. According to KeFeng's suggestion, modify mm/extable.c and some code
>   optimization.
> 
> Since V2:
>   1. According to Mark's suggestion, all uaccess can be recovered due to
>      memory error.
>   2. Scenario pagecache reading is also supported as part of uaccess
>      (copy_to_user()) and duplication code problem is also solved.
>      Thanks for Robin's suggestion.
>   3. According Mark's suggestion, update commit message of patch 2/5.
>   4. According Borisllav's suggestion, update commit message of patch 1/5.
> 
> Since V1:
>   1.Consistent with PPC/x86, Using CONFIG_ARCH_HAS_COPY_MC instead of
>     ARM64_UCE_KERNEL_RECOVERY.
>   2.Add two new scenes, cow and pagecache reading.
>   3.Fix two small bug(the first two patch).
> 
> V1 in here:
> https://lore.kernel.org/lkml/20220323033705.3966643-1-tongtiangen@huawei.com/
> 
> Tong Tiangen (4):
>    uaccess: add generic fallback version of copy_mc_to_user()
>    arm64: add support for machine check error safe
>    arm64: add uaccess to machine check safe
>    arm64: add cow to machine check safe
> 
>   arch/arm64/Kconfig                   |  1 +
>   arch/arm64/include/asm/asm-extable.h |  5 ++
>   arch/arm64/include/asm/assembler.h   |  4 ++
>   arch/arm64/include/asm/extable.h     |  1 +
>   arch/arm64/include/asm/mte.h         |  4 ++
>   arch/arm64/include/asm/page.h        | 10 ++++
>   arch/arm64/lib/Makefile              |  2 +
>   arch/arm64/lib/copy_mc_page.S        | 82 ++++++++++++++++++++++++++++
>   arch/arm64/lib/mte.S                 | 19 +++++++
>   arch/arm64/mm/copypage.c             | 42 ++++++++++++--
>   arch/arm64/mm/extable.c              | 25 +++++++++
>   arch/arm64/mm/fault.c                | 29 +++++++++-
>   arch/powerpc/include/asm/uaccess.h   |  1 +
>   arch/x86/include/asm/uaccess.h       |  1 +
>   include/linux/highmem.h              |  2 +
>   include/linux/uaccess.h              |  9 +++
>   16 files changed, 230 insertions(+), 7 deletions(-)
>   create mode 100644 arch/arm64/lib/copy_mc_page.S
> 
