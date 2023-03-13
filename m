Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9636B6DEE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 04:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjCMDYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 23:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCMDYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 23:24:05 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA902B9E4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 20:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678677843; x=1710213843;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=27FvXAAxEp2El8sKAUFSCBz/DlxIShXqrOYAjOcmstY=;
  b=m6bsuvQHEIvE9ZY8PN+GSUXxE4PhvLe1xrTGop+qDcvSUWEHjrMIi4tU
   2uefJE+q5Us4PZS33ClRrwiSyLckGvfqJSfjSwN+X5Q+Y61C+uqbOeY6E
   +EWEXFgstVafhQT/uIUVB0F7IMTLX/T1fRDNNl7dm2ACf57pRuvWv+Riy
   o7B1WW080YJ2AR762rDZCtMKi82TPwOo5lYlk3fXYA5sajImw+EI/Ftwb
   GbvmFPXLL2CsG9PvvySH+BU2f0hIL6r5/tJMbVZHuOehb9bz9Ey/xYz5J
   EPjy4K3tnxAQiKtC5D8s9PvEs2Dyv5UEQohLAbUvoP7jgm7l1f214Xgb7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="423316305"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="423316305"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 20:24:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10647"; a="671747371"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="671747371"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.238.1.34]) ([10.238.1.34])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 20:23:58 -0700
Message-ID: <66bf51ab-15bd-7988-77c6-8776ac9755d4@linux.intel.com>
Date:   Mon, 13 Mar 2023 11:23:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCHv15 00/17] Linear Address Masking enabling
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230123220500.21077-1-kirill.shutemov@linux.intel.com>
From:   Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20230123220500.21077-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/24/2023 6:04 AM, Kirill A. Shutemov wrote:
> Linear Address Masking[1] (LAM) modifies the checking that is applied to
> 64-bit linear addresses, allowing software to use of the untranslated
> address bits for metadata.
>
> The capability can be used for efficient address sanitizers (ASAN)
> implementation and for optimizations in JITs and virtual machines.
>
> The patchset brings support for LAM for userspace addresses. Only LAM_U57 at
> this time.
>
> Please review and consider applying.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
>
...
>
> [1] ISE, Chapter 10. https://cdrdv2.intel.com/v1/dl/getContent/671368

It is Chapter 7. Or maybe use the name of the chapter instead.


> Kirill A. Shutemov (12):
>    x86/mm: Rework address range check in get_user() and put_user()
>    x86: Allow atomic MM_CONTEXT flags setting
>    x86: CPUID and CR3/CR4 flags for Linear Address Masking
>    x86/mm: Handle LAM on context switch
>    mm: Introduce untagged_addr_remote()
>    x86/uaccess: Provide untagged_addr() and remove tags before address
>      check
>    x86/mm: Reduce untagged_addr() overhead for systems without LAM
>    x86/mm: Provide arch_prctl() interface for LAM
>    mm: Expose untagging mask in /proc/$PID/status
>    iommu/sva: Replace pasid_valid() helper with mm_valid_pasid()
>    x86/mm/iommu/sva: Make LAM and SVA mutually exclusive
>    selftests/x86/lam: Add test cases for LAM vs thread creation
>
> Weihong Zhang (5):
>    selftests/x86/lam: Add malloc and tag-bits test cases for
>      linear-address masking
>    selftests/x86/lam: Add mmap and SYSCALL test cases for linear-address
>      masking
>    selftests/x86/lam: Add io_uring test cases for linear-address masking
>    selftests/x86/lam: Add inherit test cases for linear-address masking
>    selftests/x86/lam: Add ARCH_FORCE_TAGGED_SVA test cases for
>      linear-address masking
>
>   arch/arm64/include/asm/mmu_context.h        |    6 +
>   arch/sparc/include/asm/mmu_context_64.h     |    6 +
>   arch/sparc/include/asm/uaccess_64.h         |    2 +
>   arch/x86/Kconfig                            |   11 +
>   arch/x86/entry/vsyscall/vsyscall_64.c       |    2 +-
>   arch/x86/include/asm/cpufeatures.h          |    1 +
>   arch/x86/include/asm/disabled-features.h    |    8 +-
>   arch/x86/include/asm/mmu.h                  |   18 +-
>   arch/x86/include/asm/mmu_context.h          |   49 +-
>   arch/x86/include/asm/processor-flags.h      |    2 +
>   arch/x86/include/asm/tlbflush.h             |   48 +-
>   arch/x86/include/asm/uaccess.h              |   58 +-
>   arch/x86/include/uapi/asm/prctl.h           |    5 +
>   arch/x86/include/uapi/asm/processor-flags.h |    6 +
>   arch/x86/kernel/process.c                   |    6 +
>   arch/x86/kernel/process_64.c                |   66 +-
>   arch/x86/kernel/traps.c                     |    6 +-
>   arch/x86/lib/getuser.S                      |   83 +-
>   arch/x86/lib/putuser.S                      |   54 +-
>   arch/x86/mm/init.c                          |    5 +
>   arch/x86/mm/tlb.c                           |   53 +-
>   drivers/iommu/iommu-sva.c                   |    8 +-
>   drivers/vfio/vfio_iommu_type1.c             |    2 +-
>   fs/proc/array.c                             |    6 +
>   fs/proc/task_mmu.c                          |    9 +-
>   include/linux/ioasid.h                      |    9 -
>   include/linux/mm.h                          |   11 -
>   include/linux/mmu_context.h                 |   14 +
>   include/linux/sched/mm.h                    |    8 +-
>   include/linux/uaccess.h                     |   22 +
>   mm/debug.c                                  |    1 +
>   mm/gup.c                                    |    4 +-
>   mm/madvise.c                                |    5 +-
>   mm/migrate.c                                |   11 +-
>   tools/testing/selftests/x86/Makefile        |    2 +-
>   tools/testing/selftests/x86/lam.c           | 1241 +++++++++++++++++++
>   36 files changed, 1699 insertions(+), 149 deletions(-)
>   create mode 100644 tools/testing/selftests/x86/lam.c
>
> --
> 2.39.1
>
