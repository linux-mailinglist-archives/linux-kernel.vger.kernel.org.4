Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64D55FAB9A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 06:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiJKEVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 00:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJKEVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 00:21:32 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B387EFD0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 21:21:30 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 29B4L1Ve321458
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 10 Oct 2022 21:21:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 29B4L1Ve321458
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022100601; t=1665462062;
        bh=a3OMU9lJ42ZHrJIUvjnlMOAcxBXBlLJbaIsAmYxBCJQ=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=n/Gbhd19mfq6n9xRqjydqU9iwtV7vqprX6YqmAKWCY8MdLIafbOxXdzuz1j6cHT+g
         wMoc2zJ1tmjs0bvba3Ja/Jmb9A6WmAhvgKOE7O8HKFuR+wlhYBP00NIAoadSSXFf8y
         yU663ty8rSvS/BhujlWzLEY/GuJNR+0pXK/n27uD5jtWqKyi1MS/dB7au99hhxB/Hm
         +BJPTlb3Fka1AjipeRb6DrHlDfXysIXmOp8+RNi/tjEO6VlgKcroPWohE+UHI2ZmPU
         oXhBew7793kbIohQpKWdxU0+zv76ubAWYlkM0N2BoqGUwz4G0Dv2N7BpUZgxAgSp0i
         DxacqnCtyuSgg==
Date:   Mon, 10 Oct 2022 21:20:58 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Brian Gerst <brgerst@gmail.com>, Xin Li <xin3.li@intel.com>
CC:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        peterz@infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_6/6=5D_x86/gsseg=3A_use_the_LKGS_?= =?US-ASCII?Q?instruction_if_available_for_load=5Fgs=5Findex=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMzpN2hKr-=9sP=_VjGdsJDX5Pzdr9WAsSs77s_5yPJeqi728g@mail.gmail.com>
References: <20221010190159.11920-1-xin3.li@intel.com> <20221010190159.11920-7-xin3.li@intel.com> <CAMzpN2hKr-=9sP=_VjGdsJDX5Pzdr9WAsSs77s_5yPJeqi728g@mail.gmail.com>
Message-ID: <0BA29DAE-370F-4D57-8187-D87863AB1B16@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 10, 2022 8:51:33 PM PDT, Brian Gerst <brgerst@gmail=2Ecom> wrote=
:
>On Mon, Oct 10, 2022 at 3:46 PM Xin Li <xin3=2Eli@intel=2Ecom> wrote:
>>
>> From: "H=2E Peter Anvin (Intel)" <hpa@zytor=2Ecom>
>>
>> The LKGS instruction atomically loads a segment descriptor into the
>> %gs descriptor registers, *except* that %gs=2Ebase is unchanged, and th=
e
>> base is instead loaded into MSR_IA32_KERNEL_GS_BASE, which is exactly
>> what we want this function to do=2E
>>
>> Signed-off-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead=2Eorg>
>> Signed-off-by: Xin Li <xin3=2Eli@intel=2Ecom>
>> link: https://lkml=2Eorg/lkml/2022/10/7/352
>> link: https://lkml=2Eorg/lkml/2022/10/7/373
>> ---
>>  arch/x86/include/asm/gsseg=2Eh | 27 ++++++++++++++++++++++++++-
>>  1 file changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/gsseg=2Eh b/arch/x86/include/asm/gsse=
g=2Eh
>> index 5e3b56a17098=2E=2E4aaef7a1d68f 100644
>> --- a/arch/x86/include/asm/gsseg=2Eh
>> +++ b/arch/x86/include/asm/gsseg=2Eh
>> @@ -3,15 +3,40 @@
>>  #define _ASM_X86_GSSEG_H
>>
>>  #include <linux/types=2Eh>
>> +
>> +#include <asm/asm=2Eh>
>> +#include <asm/cpufeature=2Eh>
>> +#include <asm/alternative=2Eh>
>>  #include <asm/processor=2Eh>
>> +#include <asm/nops=2Eh>
>>
>>  #ifdef CONFIG_X86_64
>>
>>  extern asmlinkage void asm_load_gs_index(u16 selector);
>>
>> +/* Replace with "lkgs %di" once binutils support LKGS instruction */
>> +#define LKGS_DI _ASM_BYTES(0xf2,0x0f,0x00,0xf7)
>> +
>>  static inline void native_load_gs_index(unsigned int selector)
>>  {
>> -       asm_load_gs_index(selector);
>> +       u16 sel =3D selector;
>> +
>> +       /*
>> +        * Note: the fixup is used for the LKGS instruction, but
>> +        * it needs to be attached to the primary instruction sequence
>> +        * as it isn't something that gets patched=2E
>> +        *
>> +        * %rax is provided to the assembly routine as a scratch
>> +        * register=2E
>> +        */
>> +       asm_inline volatile("1:\n"
>> +                           ALTERNATIVE("call asm_load_gs_index\n",
>> +                                       _ASM_BYTES(0x3e) LKGS_DI,
>> +                                       X86_FEATURE_LKGS)
>> +                           _ASM_EXTABLE_TYPE_REG(1b, 1b, EX_TYPE_ZERO_=
REG, %k[sel])
>> +                           : ASM_CALL_CONSTRAINT
>> +                           : [sel] "D" (sel)
>
>DI needs to be marked as input and output (+D), since the exception
>handler modifies it=2E
>
>> +                           : "memory", _ASM_AX);
>
>_ASM_AX is only needed for code that is used by both 32 and 64-bit=2E
>Since this is 64-bit only, "rax" would be appropriate=2E
>
>--
>Brian Gerst

The practice seems to have been to prefer the macros for consistency=2E
