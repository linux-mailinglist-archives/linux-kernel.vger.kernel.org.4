Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD096BEF75
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjCQRTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjCQRTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:19:34 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0E072A9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:19:33 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id m22so2598271ioy.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679073572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZ1jfFaVI6yh/37IHeoLsAnsMSdzqOsbZaMRVGssD1U=;
        b=BsAbRnkM6qn7OVPAhdQZsax2D7QZoj0xaj0pSluv7758cMzZ9eJ5IsMbmRfBdkp1dc
         UgTxWu2ccQut1F4ZnLvN2zX7USa9t4uvEanwBcKDmTXKAwFBre4yU6boWzEyTTe5TCpB
         pOXbT3GYMZIiNnpmL7IuzQNxonvIxXvpmqKSawN84zylpQLdR6KuHSOlb86k6ZK0U0q9
         Tavtmqflj2sqr+yxQ/e5Rh6jXFutZNqPF6aqAlqEHBLMjflzwmbMI/qWtkZ0AdgmA2v7
         AGHQhr3wLIPAdAIAbbV/Xbb96/oOQa76cdkiWGQYaF+7EiLo8z3YezP3w7M8S/HUt6jr
         LrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679073572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZ1jfFaVI6yh/37IHeoLsAnsMSdzqOsbZaMRVGssD1U=;
        b=IUe0n5lEhJVZ6kLkQTCQ2kGRZ9kZuXE5w1Wl9iIUrXgak78WBzQ8+wc95nGAsgW31O
         a3dhOLOXC6q177PUyyx48/iOvdP8WH3f4tPST2peqIJE4/xUKa3X8EiuWVKmzI5XhU3U
         VescAkgz+Xc0EX7Fnz6CHpIFDi6b04teH87Ep0l3LZa0lWuWKVykwQSGtlGywkF/S6CJ
         qcHSBhzBFNGaviQSChxKFdBkz9b5URj8BgjFYneXi91i8OPpcsDqepzOPMMx5hbFD+a6
         ARcGWv8hybst+MV7Ry9Rz36eAuIWYMX0Twc5OBZn7YFKPQetPm1oeO1WP4WfN1Imrnjr
         i4JQ==
X-Gm-Message-State: AO0yUKWLcZDRm6onWIP1sfoRwp94A5t46znEizsdm4ijWsPheR04RzH+
        l+CEMsQ9u9plYsvd5qQigVkwSk1XZcGhRpZydQi+9Q==
X-Google-Smtp-Source: AK7set9ZkmPhByF2aaxm+U5uE9Zmao/FLOBaByI68TINytAeD2dV0Dg7XbZOP8QJFS/VIKn1sXMSml5Id3DPtpub+K0=
X-Received: by 2002:a5e:8a0d:0:b0:74c:97ee:4e56 with SMTP id
 d13-20020a5e8a0d000000b0074c97ee4e56mr211043iok.3.1679073572221; Fri, 17 Mar
 2023 10:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230312112612.31869-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20230312112612.31869-1-kirill.shutemov@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 17 Mar 2023 18:18:55 +0100
Message-ID: <CAG_fn=UHz93odccvRFo5H2yKq9URTcQs2jWWc5Yehioq-QC8hA@mail.gmail.com>
Subject: Re: [PATCHv16 00/17] Linear Address Masking enabling
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear x86 maintainers,

the series looks pretty mature now, any chance it can be considered
for upstream?

On Sun, Mar 12, 2023 at 12:26=E2=80=AFPM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Linear Address Masking[1] (LAM) modifies the checking that is applied to
> 64-bit linear addresses, allowing software to use of the untranslated
> address bits for metadata.
>
> The capability can be used for efficient address sanitizers (ASAN)
> implementation and for optimizations in JITs and virtual machines.
>
> The patchset brings support for LAM for userspace addresses. Only LAM_U57=
 at
> this time.
>
> Please review and consider applying.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
>
> v16:
>   - Add #include <linux/mmu_context.h> into fs/proc/array.c;
>   - Whitespace fix;
>   - Add Alexander's Tested-bys;
> v15:
>   - Replace static branch in untagged_addr() with alternative;
>   - Drop unneeded READ_ONCE();
>   - Acks from Peter;
> v14:
>   - Rework address range check in get_user() and put_user();
>   - Introduce CONFIG_ADDRESS_MASKING;
>   - Cache untag masking in per-CPU variable;
>   - Reject LAM enabling via PTRACE_ARCH_PRCTL;
>   - Fix locking around untagged_addr_remote();
>   - Fix typo in MM_CONTEXT_ conversion patch;
>   - Fix selftest;
> v13:
>   - Fix race between untagged_addr() and LAM enabling:
>     + Do not allow to enable LAM after the process spawned the second thr=
ead;
>     + untagged_addr() untags the address according to rules of the curren=
t
>       process;
>     + untagged_addr_remote() can be used for untagging addresses for fore=
ign
>       process. It requires mmap lock for the target process to be taken;
> v12:
>   - Rebased onto tip/x86/mm;
>   - Drop VM_WARN_ON() that may produce false-positive on race between con=
text
>     switch and LAM enabling;
>   - Adjust comments explain possible race;
>   - User READ_ONCE() in mm_lam_cr3_mask();
>   - Do not assume &init_mm =3D=3D mm in initialize_tlbstate_and_flush();
>   - Ack by Andy;
> v11:
>   - Move untag_mask to /proc/$PID/status;
>   - s/SVM/SVA/g;
>   - static inline arch_pgtable_dma_compat() instead of macros;
>   - Replace pasid_valid() with mm_valid_pasid();
>   - Acks from Ashok and Jacob (forgot to apply from v9);
> v10:
>   - Rebased to v6.1-rc1;
>   - Add selftest for SVM vs LAM;
> v9:
>   - Fix race between LAM enabling and check that KVM memslot address does=
n't
>     have any tags;
>   - Reduce untagged_addr() overhead until the first LAM user;
>   - Clarify SVM vs. LAM semantics;
>   - Use mmap_lock to serialize LAM enabling;
> v8:
>   - Drop redundant smb_mb() in prctl_enable_tagged_addr();
>   - Cleanup code around build_cr3();
>   - Fix commit messages;
>   - Selftests updates;
>   - Acked/Reviewed/Tested-bys from Alexander and Peter;
> v7:
>   - Drop redundant smb_mb() in prctl_enable_tagged_addr();
>   - Cleanup code around build_cr3();
>   - Fix commit message;
>   - Fix indentation;
> v6:
>   - Rebased onto v6.0-rc1
>   - LAM_U48 excluded from the patchet. Still available in the git tree;
>   - add ARCH_GET_MAX_TAG_BITS;
>   - Fix build without CONFIG_DEBUG_VM;
>   - Update comments;
>   - Reviewed/Tested-by from Alexander;
> v5:
>   - Do not use switch_mm() in enable_lam_func()
>   - Use mb()/READ_ONCE() pair on LAM enabling;
>   - Add self-test by Weihong Zhang;
>   - Add comments;
> v4:
>   - Fix untagged_addr() for LAM_U48;
>   - Remove no-threads restriction on LAM enabling;
>   - Fix mm_struct access from /proc/$PID/arch_status
>   - Fix LAM handling in initialize_tlbstate_and_flush()
>   - Pack tlb_state better;
>   - Comments and commit messages;
> v3:
>   - Rebased onto v5.19-rc1
>   - Per-process enabling;
>   - API overhaul (again);
>   - Avoid branches and costly computations in the fast path;
>   - LAM_U48 is in optional patch.
> v2:
>   - Rebased onto v5.18-rc1
>   - New arch_prctl(2)-based API
>   - Expose status of LAM (or other thread features) in
>     /proc/$PID/arch_status
>
> [1] ISE, Chapter 10. https://cdrdv2.intel.com/v1/dl/getContent/671368
>
> Kirill A. Shutemov (12):
>   x86/mm: Rework address range check in get_user() and put_user()
>   x86: Allow atomic MM_CONTEXT flags setting
>   x86: CPUID and CR3/CR4 flags for Linear Address Masking
>   x86/mm: Handle LAM on context switch
>   mm: Introduce untagged_addr_remote()
>   x86/uaccess: Provide untagged_addr() and remove tags before address
>     check
>   x86/mm: Reduce untagged_addr() overhead for systems without LAM
>   x86/mm: Provide arch_prctl() interface for LAM
>   mm: Expose untagging mask in /proc/$PID/status
>   iommu/sva: Replace pasid_valid() helper with mm_valid_pasid()
>   x86/mm/iommu/sva: Make LAM and SVA mutually exclusive
>   selftests/x86/lam: Add test cases for LAM vs thread creation
>
> Weihong Zhang (5):
>   selftests/x86/lam: Add malloc and tag-bits test cases for
>     linear-address masking
>   selftests/x86/lam: Add mmap and SYSCALL test cases for linear-address
>     masking
>   selftests/x86/lam: Add io_uring test cases for linear-address masking
>   selftests/x86/lam: Add inherit test cases for linear-address masking
>   selftests/x86/lam: Add ARCH_FORCE_TAGGED_SVA test cases for
>     linear-address masking
>
>  arch/arm64/include/asm/mmu_context.h        |    6 +
>  arch/sparc/include/asm/mmu_context_64.h     |    6 +
>  arch/sparc/include/asm/uaccess_64.h         |    2 +
>  arch/x86/Kconfig                            |   11 +
>  arch/x86/entry/vsyscall/vsyscall_64.c       |    2 +-
>  arch/x86/include/asm/cpufeatures.h          |    1 +
>  arch/x86/include/asm/disabled-features.h    |    8 +-
>  arch/x86/include/asm/mmu.h                  |   18 +-
>  arch/x86/include/asm/mmu_context.h          |   49 +-
>  arch/x86/include/asm/processor-flags.h      |    2 +
>  arch/x86/include/asm/tlbflush.h             |   48 +-
>  arch/x86/include/asm/uaccess.h              |   58 +-
>  arch/x86/include/uapi/asm/prctl.h           |    5 +
>  arch/x86/include/uapi/asm/processor-flags.h |    6 +
>  arch/x86/kernel/process.c                   |    6 +
>  arch/x86/kernel/process_64.c                |   66 +-
>  arch/x86/kernel/traps.c                     |    6 +-
>  arch/x86/lib/getuser.S                      |   83 +-
>  arch/x86/lib/putuser.S                      |   54 +-
>  arch/x86/mm/init.c                          |    5 +
>  arch/x86/mm/tlb.c                           |   53 +-
>  drivers/iommu/iommu-sva.c                   |    8 +-
>  drivers/vfio/vfio_iommu_type1.c             |    2 +-
>  fs/proc/array.c                             |    7 +
>  fs/proc/task_mmu.c                          |    9 +-
>  include/linux/ioasid.h                      |    9 -
>  include/linux/mm.h                          |   11 -
>  include/linux/mmu_context.h                 |   14 +
>  include/linux/sched/mm.h                    |    8 +-
>  include/linux/uaccess.h                     |   22 +
>  mm/gup.c                                    |    4 +-
>  mm/madvise.c                                |    5 +-
>  mm/migrate.c                                |   11 +-
>  tools/testing/selftests/x86/Makefile        |    2 +-
>  tools/testing/selftests/x86/lam.c           | 1241 +++++++++++++++++++
>  35 files changed, 1699 insertions(+), 149 deletions(-)
>  create mode 100644 tools/testing/selftests/x86/lam.c
>
> --
> 2.39.2
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
