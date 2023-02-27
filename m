Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAC96A4299
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjB0N1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjB0N1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:27:19 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B734718B0E;
        Mon, 27 Feb 2023 05:27:17 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 275B3E0006;
        Mon, 27 Feb 2023 13:27:11 +0000 (UTC)
Message-ID: <6bd8012a-7311-7956-b0ae-966b8534a64a@ghiti.fr>
Date:   Mon, 27 Feb 2023 14:27:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v7 1/1] riscv: Allow to downgrade paging mode from the
 command line
To:     Ard Biesheuvel <ardb@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        nathan@kernel.org, llvm@lists.linux.dev, ndesaulniers@google.com
References: <20230224100218.1824569-1-alexghiti@rivosinc.com>
 <20230224100218.1824569-2-alexghiti@rivosinc.com> <Y/yilORflGv3vXjX@wendy>
 <CAMj1kXGCkqpHY7rHZv0EFKhPNk6jpbh1OfG_Jm3vSW8c5Y+9_A@mail.gmail.com>
Content-Language: en-US
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <CAMj1kXGCkqpHY7rHZv0EFKhPNk6jpbh1OfG_Jm3vSW8c5Y+9_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/27/23 13:56, Ard Biesheuvel wrote:
> On Mon, 27 Feb 2023 at 13:32, Conor Dooley <conor.dooley@microchip.com> wrote:
>> Hey Alex, clang/llvm folk,
>>
>> On Fri, Feb 24, 2023 at 11:02:18AM +0100, Alexandre Ghiti wrote:
>>> Add 2 early command line parameters that allow to downgrade satp mode
>>> (using the same naming as x86):
>>> - "no5lvl": use a 4-level page table (down from sv57 to sv48)
>>> - "no4lvl": use a 3-level page table (down from sv57/sv48 to sv39)
>>>
>>> Note that going through the device tree to get the kernel command line
>>> works with ACPI too since the efi stub creates a device tree anyway with
>>> the command line.
>>>
>>> In KASAN kernels, we can't use the libfdt that early in the boot process
>>> since we are not ready to execute instrumented functions. So instead of
>>> using the "generic" libfdt, we compile our own versions of those functions
>>> that are not instrumented and that are prefixed so that they do not
>>> conflict with the generic ones. We also need the non-instrumented versions
>>> of the string functions and the prefixed versions of memcpy/memmove.
>>>
>>> This is largely inspired by commit aacd149b6238 ("arm64: head: avoid
>>> relocating the kernel twice for KASLR") from which I removed compilation
>>> flags that were not relevant to RISC-V at the moment (LTO, SCS, pie).
>>>
>>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>> Tested-by: Björn Töpel <bjorn@rivosinc.com>
>>> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
>>> ---
>>>   .../admin-guide/kernel-parameters.txt         |  5 +-
>>>   arch/riscv/kernel/Makefile                    |  2 +
>>>   arch/riscv/kernel/pi/Makefile                 | 37 +++++++++++
>>>   arch/riscv/kernel/pi/cmdline_early.c          | 62 +++++++++++++++++++
>> +      4 ld.lld: warning: vmlinux.a(arch/riscv/kernel/pi/string.pi.o):(.init.sdata) is being placed in '.init.sdata'
>>
>> I'm getting 4 new linker warnings with LLVM=1 clang-15 allmodconfig
>> builds - but I don't really understand this issue.
>> Is this spurious, and a just consequence of...
>>
>>> diff --git a/arch/riscv/kernel/pi/Makefile b/arch/riscv/kernel/pi/Makefile
>>> new file mode 100644
>>> index 000000000000..4002ed94b6d3
>>> --- /dev/null
>>> +++ b/arch/riscv/kernel/pi/Makefile
>>> @@ -0,0 +1,37 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# This file was copied from arm64/kernel/pi/Makefile.
>>> +
>>> +KBUILD_CFLAGS        := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
>>> +                -Os -DDISABLE_BRANCH_PROFILING $(DISABLE_STACKLEAK_PLUGIN) \
>>> +                $(call cc-option,-mbranch-protection=none) \
>>> +                -I$(srctree)/scripts/dtc/libfdt -fno-stack-protector \
>>> +                -D__DISABLE_EXPORTS -ffreestanding \
>>> +                -fno-asynchronous-unwind-tables -fno-unwind-tables \
>>> +                $(call cc-option,-fno-addrsig)
>>> +
>>> +CFLAGS_cmdline_early.o += -D__NO_FORTIFY
>>> +CFLAGS_lib-fdt_ro.o += -D__NO_FORTIFY
>>> +
>>> +GCOV_PROFILE := n
>>> +KASAN_SANITIZE       := n
>>> +KCSAN_SANITIZE       := n
>>> +UBSAN_SANITIZE       := n
>>> +KCOV_INSTRUMENT      := n
>>> +
>>> +$(obj)/%.pi.o: OBJCOPYFLAGS := --prefix-symbols=__pi_ \
>>> +                            --remove-section=.note.gnu.property \
>>> +                            --prefix-alloc-sections=.init
>> ...this?
>>
> Yes. if the input object has a .sdata section, the output .pi.o object
> will have a .init.sdata section, and if the common linker script does
> not place it explicitly, you will get a warning. Note that we switched
> to --orphan-handling=error on other arches, as the linker sometimes


It seems orphan-handling is set to "error" only when WERROR is set (see 
CONFIG_LD_ORPHAN_WARN_LEVEL).


> does unexpected things with sections it doesn't know about.
>
> I'd imagine this needs to be combined with .init.data


Yes, gcc does not produce this section but others that I placed in a new 
section called .init.pidata: I did not want to expand INIT_DATA_SECTION 
macro because we won't need that anymore when we implement all the 
string functions.

So I'll add this new .init.sdata section to .init.pidata in the v8!

Thanks,


>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
