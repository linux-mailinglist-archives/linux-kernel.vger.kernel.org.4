Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AE66C0B46
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 08:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjCTHVO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Mar 2023 03:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCTHVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 03:21:06 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F01213DDE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 00:21:01 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 16B0A24E263;
        Mon, 20 Mar 2023 15:21:00 +0800 (CST)
Received: from EXMBX163.cuchost.com (172.16.7.73) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 20 Mar
 2023 15:20:58 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX163.cuchost.com
 (172.16.7.73) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 20 Mar
 2023 15:20:58 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Mon, 20 Mar 2023 15:20:58 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: RE: [PATCH v6 0/4] RISC-V Hibernation Support
Thread-Topic: [PATCH v6 0/4] RISC-V Hibernation Support
Thread-Index: AQHZVjJN8ydv64d8Vka8VV2EaIDg/68DSv4g
Date:   Mon, 20 Mar 2023 07:20:58 +0000
Message-ID: <1a2b03d49ce1440b9e50ca8a13320782@EXMBX066.cuchost.com>
References: <20230314050316.31701-1-jeeheng.sia@starfivetech.com>
In-Reply-To: <20230314050316.31701-1-jeeheng.sia@starfivetech.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [202.188.176.82]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I understand that you must be extremely busy, but I was wondering if there are any comments for the below v6 patch series?

Thanks
Regards
Jee Heng

> -----Original Message-----
> From: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Sent: Tuesday, March 14, 2023 1:03 PM
> To: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu
> Cc: linux-riscv@lists.infradead.org; linux-kernel@vger.kernel.org; JeeHeng Sia <jeeheng.sia@starfivetech.com>; Leyfoon Tan
> <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>
> Subject: [PATCH v6 0/4] RISC-V Hibernation Support
> 
> This series adds RISC-V Hibernation/suspend to disk support.
> Low level Arch functions were created to support hibernation.
> swsusp_arch_suspend() relies code from __cpu_suspend_enter() to write
> cpu state onto the stack, then calling swsusp_save() to save the memory
> image.
> 
> Arch specific hibernation header is implemented and is utilized by the
> arch_hibernation_header_restore() and arch_hibernation_header_save()
> functions. The arch specific hibernation header consists of satp, hartid,
> and the cpu_resume address. The kernel built version is also need to be
> saved into the hibernation image header to making sure only the same
> kernel is restore when resume.
> 
> swsusp_arch_resume() creates a temporary page table that covering only
> the linear map. It copies the restore code to a 'safe' page, then start to
> restore the memory image. Once completed, it restores the original
> kernel's page table. It then calls into __hibernate_cpu_resume()
> to restore the CPU context. Finally, it follows the normal hibernation
> path back to the hibernation core.
> 
> To enable hibernation/suspend to disk into RISCV, the below config
> need to be enabled:
> - CONFIG_ARCH_HIBERNATION_HEADER
> - CONFIG_ARCH_HIBERNATION_POSSIBLE
> 
> At high-level, this series includes the following changes:
> 1) Change suspend_save_csrs() and suspend_restore_csrs()
>    to public function as these functions are common to
>    suspend/hibernation. (patch 1)
> 2) Refactor the common code in the __cpu_resume_enter() function and
>    __hibernate_cpu_resume() function. The common code are used by
>    hibernation and suspend. (patch 2)
> 3) Enhance kernel_page_present() function to support huge page. (patch 3)
> 4) Add arch/riscv low level functions to support
>    hibernation/suspend to disk. (patch 4)
> 
> The above patches are based on kernel v6.3-rc2 and are tested on
> StarFive VF2 SBC board and Qemu.
> ACPI platform mode is not supported in this series.
> 
> Changes since v5:
> - Rebased to kernel v6.3-rc2
> - Removed extra line at the commit msg
> - Added comment to describe the reason to map the kernel address
> 
> Changes since v4:
> - Rebased to kernel v6.3-rc1
> - Resolved typo(s)
> - Removed unnecessary helper function
> - Removed unnecessary "addr" local variable
> - Removed typecast of 'int'
> - Used def_bool HIBERNATION
> - Used "mv a0, zero" instead of "add a0, zero, zero"
> - Make linear region as executable and writable when restoring the
>   image
> 
> Changes since v3:
> - Rebased to kernel v6.2
> - Temporary page table code refactoring by reference to ARM64
> - Resolved typo(s) and grammars
> - Resolved documentation errors
> - Resolved clang build issue
> - Removed unnecessary comments
> - Used kzalloc instead of kcalloc
> 
> Changes since v2:
> - Rebased to kernel v6.2-rc5
> - Refactor the common code used by hibernation and suspend
> - Create copy_page macro
> - Solved other comments from Andrew and Conor
> 
> Changes since v1:
> - Rebased to kernel v6.2-rc3
> - Fixed bot's compilation error
> 
> Sia Jee Heng (4):
>   RISC-V: Change suspend_save_csrs and suspend_restore_csrs to public
>     function
>   RISC-V: Factor out common code of __cpu_resume_enter()
>   RISC-V: mm: Enable huge page support to kernel_page_present() function
>   RISC-V: Add arch functions to support hibernation/suspend-to-disk
> 
>  arch/riscv/Kconfig                 |   6 +
>  arch/riscv/include/asm/assembler.h |  82 ++++++
>  arch/riscv/include/asm/suspend.h   |  22 ++
>  arch/riscv/kernel/Makefile         |   1 +
>  arch/riscv/kernel/asm-offsets.c    |   5 +
>  arch/riscv/kernel/hibernate-asm.S  |  77 ++++++
>  arch/riscv/kernel/hibernate.c      | 427 +++++++++++++++++++++++++++++
>  arch/riscv/kernel/suspend.c        |   4 +-
>  arch/riscv/kernel/suspend_entry.S  |  34 +--
>  arch/riscv/mm/pageattr.c           |   8 +
>  10 files changed, 633 insertions(+), 33 deletions(-)
>  create mode 100644 arch/riscv/include/asm/assembler.h
>  create mode 100644 arch/riscv/kernel/hibernate-asm.S
>  create mode 100644 arch/riscv/kernel/hibernate.c
> 
> 
> base-commit: fc89d7fb499b0162e081f434d45e8d1b47e82ece
> --
> 2.34.1

