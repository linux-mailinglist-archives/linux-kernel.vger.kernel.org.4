Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB9D6CF9EB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjC3ECD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjC3ECA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:02:00 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0199110A;
        Wed, 29 Mar 2023 21:01:56 -0700 (PDT)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 35151100005;
        Thu, 30 Mar 2023 04:01:51 +0000 (UTC)
Message-ID: <6931ad6c-8183-33ef-5127-815cd5d84f17@ghiti.fr>
Date:   Thu, 30 Mar 2023 06:01:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v8 0/1] riscv: Allow to downgrade paging mode from the
 command line
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>, alexghiti@rivosinc.com
Cc:     corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Conor Dooley <conor@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, bjorn@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <mhng-4507ad68-27bd-4d29-bb72-8d8f5bc27e34@palmer-ri-x1c9a>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <mhng-4507ad68-27bd-4d29-bb72-8d8f5bc27e34@palmer-ri-x1c9a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/23 19:59, Palmer Dabbelt wrote:
> On Tue, 28 Feb 2023 07:46:28 PST (-0800), alexghiti@rivosinc.com wrote:
>> This new version gets rid of the limitation that prevented KASAN kernels
>> to use the newly introduced parameters.
>>
>> While looking into KASLR, I fell onto commit aacd149b6238 ("arm64: head:
>> avoid relocating the kernel twice for KASLR"): it allows to use the fdt
>> functions very early in the boot process with KASAN enabled by simply
>> compiling a new version of those functions without instrumentation.
>>
>> I had to change the handling of the command line parsing to make the
>> code self-contained in kernel/pi/cmd_early.c to avoid calling too many
>> __pi prefixed functions from outside this file.
>>
>> I'll use this approach like arm64 to handle the extraction of the random
>> seedi from the device tree for KASLR.
>>
>> base-commit: eb9be8310c58 ("RISC-V: add a spin_shadow_stack 
>> declaration")
>
> I have that in my tree, I'm still getting a bunch of boot failures 
> though.  I can try to get a list if you're not seeing any, but I'm 
> kind of stuck on some other stuff for a bit...


I sent yesterday a v9 which fixes the medlow boot issues you mentioned, 
I did not have any boot failures after that on my side.


>
>> v8:
>> - Fix LLVM ld warning by moving the section .init.sdata from
>>   kernel/pi/string.c into the newly created section .init.pidata
>>
>> v7:
>> - Rebased on top of for-next which introduces lots of errors (thanks to
>>   the patchwork CI)
>> - Add __NO_FORTIFY to avoid undefined __pi_fortify_panic
>> - Add an alias to our newly introduced strlen
>> - Remove __init as sections are already prefixed in the Makefile
>> - Introduce new section for kernel/pi/string.c to quiet the following
>>   warnings (once we have all the string functions, we'll be able to get
>>   rid of this):
>>
>> warning: orphan section `.init__bug_table' from 
>> `arch/riscv/kernel/pi/string.pi.o' being placed in section 
>> `.init__bug_table'
>> warning: orphan section `.init.srodata.cst8' from 
>> `arch/riscv/kernel/pi/string.pi.o' being placed in section 
>> `.init.srodata.cst8'
>>
>> v6:
>> - Fix llvm warning by forward declaring set_satp_mode_from_cmdline
>>
>> v5:
>> - Handle null command line, Thanks Björn!
>> - Add RB/TB from Björn
>>
>> v4:
>> - Introduce pi/ for KASAN to work
>>
>> v3:
>> - Massage commit log to make no4lvl clearer, as asked by Conor
>> - Add a note to kernel-parameters.txt regarding the impossibility to use
>>   those parameters when KASAN is enabled, as suggested by Conor
>> - Add RB from Björn
>>
>> v2:
>> - Honor CMDLINE_EXTEND and CMDLINE_FORCE as noticed by Björn
>>
>>
>> Alexandre Ghiti (1):
>>   riscv: Allow to downgrade paging mode from the command line
>>
>>  .../admin-guide/kernel-parameters.txt         |  5 +-
>>  arch/riscv/kernel/Makefile                    |  2 +
>>  arch/riscv/kernel/pi/Makefile                 | 37 +++++++++++
>>  arch/riscv/kernel/pi/cmdline_early.c          | 62 +++++++++++++++++++
>>  arch/riscv/kernel/vmlinux.lds.S               |  8 +++
>>  arch/riscv/lib/memcpy.S                       |  2 +
>>  arch/riscv/lib/memmove.S                      |  2 +
>>  arch/riscv/lib/strlen.S                       |  1 +
>>  arch/riscv/mm/init.c                          | 36 +++++++++--
>>  9 files changed, 148 insertions(+), 7 deletions(-)
>>  create mode 100644 arch/riscv/kernel/pi/Makefile
>>  create mode 100644 arch/riscv/kernel/pi/cmdline_early.c
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
