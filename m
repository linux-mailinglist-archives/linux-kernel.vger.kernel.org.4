Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B81F70BA4F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 12:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjEVKsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 06:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjEVKs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 06:48:27 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F86B3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 03:48:25 -0700 (PDT)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 7904B1BF204;
        Mon, 22 May 2023 10:48:20 +0000 (UTC)
Message-ID: <3022ab59-02f8-6f95-c7a1-b4c271729120@ghiti.fr>
Date:   Mon, 22 May 2023 12:48:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 1/3] riscv: Introduce CONFIG_RELOCATABLE
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>, schwab@linux-m68k.org
Cc:     alexghiti@rivosinc.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <mhng-d3720bcf-5eda-46da-b640-0606ef3a60e2@palmer-ri-x1c9a>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <mhng-d3720bcf-5eda-46da-b640-0606ef3a60e2@palmer-ri-x1c9a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/05/2023 23:55, Palmer Dabbelt wrote:
> On Fri, 19 May 2023 14:48:59 PDT (-0700), schwab@linux-m68k.org wrote:
>> On Mai 19 2023, Alexandre Ghiti wrote:
>>
>>> I have tested the following patch successfully, can you give it a try
>>> while I make sure this is the only place I forgot to add the -fno-pie
>>> flag?
>>>
>>> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>>> index fbdccc21418a..153864e4f399 100644
>>> --- a/arch/riscv/kernel/Makefile
>>> +++ b/arch/riscv/kernel/Makefile
>>> @@ -23,6 +23,10 @@ ifdef CONFIG_FTRACE
>>>  CFLAGS_REMOVE_alternative.o = $(CC_FLAGS_FTRACE)
>>>  CFLAGS_REMOVE_cpufeature.o = $(CC_FLAGS_FTRACE)
>>>  endif
>>> +ifdef CONFIG_RELOCATABLE
>>> +CFLAGS_alternative.o += -fno-pie
>>> +CFLAGS_cpufeature.o += -fno-pie
>>> +endif
>>>  ifdef CONFIG_KASAN
>>>  KASAN_SANITIZE_alternative.o := n
>>>  KASAN_SANITIZE_cpufeature.o := n
>>
>> I can confirm that this fixes the crash.
>
> Thanks.  Alex: can you send a patch?


I don't think this patch alone will work, all the code in early 
alternatives must be compiled with -fno-pie, but I'm a bit scared that's 
a "big" constraint. For now, I see 2 solutions:

- Document somewhere the fact that anything called from early 
alternatives must be compiled with -fno-pie
- Or relocate once with physical address, call early alternatives, and 
then do the final virtual relocation

Both options can be cumbersome in their own way, if anyone has an 
opinion, I'd be happy to discuss that :)


