Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F455735783
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjFSNAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjFSNAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:00:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17A401738;
        Mon, 19 Jun 2023 06:00:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B3BE12FC;
        Mon, 19 Jun 2023 06:01:20 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.36.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03FA23F663;
        Mon, 19 Jun 2023 06:00:34 -0700 (PDT)
Date:   Mon, 19 Jun 2023 14:00:32 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Anup Patel <anup@brainfault.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        lkft-triage@lists.linaro.org, Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: next: arch/riscv/kvm/aia_imsic.c:237:9: error: call to
 undeclared function  'arch_atomic_long_fetch_or'
Message-ID: <ZJBRcG4gPA2wzgax@FVFF77S0Q05N.cambridge.arm.com>
References: <CA+G9fYvtPPhG6w8Ge2_YOdQ6F0nSNA1q-2JLej=6gsyoCT-0ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvtPPhG6w8Ge2_YOdQ6F0nSNA1q-2JLej=6gsyoCT-0ag@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 03:27:47PM +0530, Naresh Kamboju wrote:
> Following build regressions noticed on Linux next-20230619.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Regressions found on riscv:
> 
>  - build/rv32-clang-16-lkftconfig
>  - build/rv32-clang-16-tinyconfig
>  - build/rv32-clang-nightly-defconfig
>  - build/rv32-clang-16-allnoconfig
>  - build/gcc-12-defconfig
>  - build/gcc-11-lkftconfig
>  - build/clang-16-lkftconfig
>  - build/rv32-clang-16-defconfig
>  - build/gcc-8-defconfig
>  - build/rv32-gcc-11-lkftconfig
>  - build/clang-16-defconfig
>  - build/rv32-clang-nightly-allnoconfig
>  - build/rv32-clang-nightly-tinyconfig
>  - build/clang-nightly-defconfig
> 
> 
> arch/riscv/kvm/aia_imsic.c:237:9: error: call to undeclared function
>  'arch_atomic_long_fetch_or'; ISO C99 and later do not support implicit
>     function declarations [-Wimplicit-function-declaration]
>         return arch_atomic_long_fetch_or(val, (atomic_long_t *)ptr);
>                ^
> arch/riscv/kvm/aia_imsic.c:237:9: note: did you mean 'raw_atomic_long_fetch_or'?
> include/linux/atomic/atomic-long.h:1087:1: note:
> 'raw_atomic_long_fetch_or' declared here
> raw_atomic_long_fetch_or(long i, atomic_long_t *v)
> ^
> 1 error generated.

It looks like this is because:

  2f68d5420412040e ("RISC-V: KVM: Add in-kernel virtualization of AIA IMSIC")

... added a call to arch_atomic_long_fetch_or(), but we've reworked the atomics
in the tip locking/core branch such that arch_atomic_long_fetch_or() doesn't
exist unless provided directly by the architecture.

Does this actually need to be arch_atomic_long_fetch_or(), i.e. was there a
specific reason not to use atomic_long_fetch_or() here?

If not, then please use atomic_long_fetch_or() -- that'll work before and after
the locking/core changes.

Otherwise we'll need to figure out how to handle the transient breakage.

Thanks,
Mark.
