Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A507139B0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 15:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjE1NnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 09:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjE1NnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 09:43:08 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2F6B1
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 06:43:06 -0700 (PDT)
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 928C6240002;
        Sun, 28 May 2023 13:43:00 +0000 (UTC)
Message-ID: <cf0d2d2a-c407-7b3d-a5ab-ea5c19e7b890@ghiti.fr>
Date:   Sun, 28 May 2023 15:42:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH -fixes] riscv: Fix relocatable kernels with early
 alternatives using -fno-pie
To:     Conor Dooley <conor@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230526154630.289374-1-alexghiti@rivosinc.com>
 <20230526-clergyman-wriggly-accc659a3fad@spud>
 <20230526-rockfish-moody-f6d3e71f9d24@spud>
 <f6522c82-01bd-8a03-579d-a5b294784480@ghiti.fr>
 <20230527-hyperlink-doctrine-ef22cfcb508a@spud>
 <CAHVXubgx3uBEjMLHXTxr0192ZHbSb=qK4NggZyWQTDfgrJt2-g@mail.gmail.com>
 <20230528-darkness-grandly-6cb9e014391d@spud>
Content-Language: en-US
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230528-darkness-grandly-6cb9e014391d@spud>
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


On 28/05/2023 15:12, Conor Dooley wrote:
> On Sun, May 28, 2023 at 03:00:57PM +0200, Alexandre Ghiti wrote:
>> On Sat, May 27, 2023 at 12:02 PM Conor Dooley <conor@kernel.org> wrote:
>>> On Sat, May 27, 2023 at 11:13:18AM +0200, Alexandre Ghiti wrote:
>>>> On 26/05/2023 18:35, Conor Dooley wrote:
>>>>> On Fri, May 26, 2023 at 05:24:41PM +0100, Conor Dooley wrote:
>>>>>> On Fri, May 26, 2023 at 05:46:30PM +0200, Alexandre Ghiti wrote:
>>>>>>> Early alternatives are called with the mmu disabled, and then should not
>>>>>>> access any global symbols through the GOT since it requires relocations,
>>>>>>> relocations that we do before but *virtually*. So only use medany code
>>>>>>> model for this early code.
>>>>>>>
>>>>>>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>>>>>> ---
>>>>>>>
>>>>>>> Note that I'm not very happy with this fix, I think we need to put more
>>>>>>> effort into "harmonizing" this very early code (ie before the mmu is
>>>>>>> enabled) as it is spread between different locations and compiled
>>>>>>> differently.
>>>>>> Totally & I'll happily spend the time trying to review that work.
>>>>>>
>>>>>>> I'll work on that later, but for now, this fix does what is
>>>>>>> needed to work (from my testing at least). Any Tested-by on the Unmatched
>>>>>>> and T-head boards is welcome!
>>>>>> On 6.4-rc1 & v6.4-rc1 + this patch, with CONFIG_RELOCATABLE added to my
>>>>>> config, my Nezha fails to boot. There is no output whatsoever from the
>>>>>> kernel. Turning off CONFIG_RELOCATABLE boots again.
>>>>> I don't know if this is better or worse news, but same thing happens on
>>>>> an icicle kit. What systems, other than QEMU, has the relocatable
>>>>> eries been tested with, btw?
>>>>
>>>> I tested it on the Unmatched (Andreas did too).
>>> Cool. I cracked out my unmatched and it has the same issue as the
>>> icicle. Ditto my Visionfive v2. Here's my config.
>>> https://raw.githubusercontent.com/ConchuOD/riscv-env/dev/conf/defconfig
>>>
>>> A ~default qemu virt doesn't work either. (-m 2G -smp 5)
>> I can boot with this config using:
>>
>> $ sudo ~/qemu/build/qemu-system-riscv64 -machine virt -cpu
>> rv64,sv48=off -nographic -m 2G -smp 5 -kernel
>> build_conor/arch/riscv/boot/Image -s
> Just in case, that is my normal config that I use for testing random
> stuff on LKML, I added CONFIG_RELOCATABLE in addition to that.
>
>> I noticed when trying to add this to our internal CI that I had local
>> failures that did not happen in the CI because the CI was not using
>> the same toolchain: can you give me the full .config? So that I can
>> see if the compiler added stack guards or some other things I did not
>> think of.
> https://gist.githubusercontent.com/ConchuOD/655f9cc19fb3be63f1c9da7e7e3ab717/raw/a1aad3c0d307609b2062fd3a66705166aede9f9f/.config
>
> 90% of what I test for upstream stuff uses clang, since clang appears to
> be a minority choice - but I could reproduce this with gcc-12 as well,
> using the same defconfig as linked above + CONFIG_RELOCATABLE.


Hmmm, it still works for me with both clang and gcc-9.


You don't have to do that now but is there a way I could get your 
compiled image? With the sha1 used to build it? Sorry, I don't see what 
happens, I need to get my hands dirty in some debug!


Thanks for being so quick Conor!


> Cheers,
> Conor.
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
