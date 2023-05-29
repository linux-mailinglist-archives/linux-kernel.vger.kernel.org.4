Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7EC714FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 21:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjE2Thl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 15:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjE2Thj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 15:37:39 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9A7B7
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 12:37:33 -0700 (PDT)
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id D5EEFC0006;
        Mon, 29 May 2023 19:37:28 +0000 (UTC)
Message-ID: <41e57bb9-ce0c-7772-abeb-5c01d5ec19bb@ghiti.fr>
Date:   Mon, 29 May 2023 21:37:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH -fixes] riscv: Fix relocatable kernels with early
 alternatives using -fno-pie
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
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
 <cf0d2d2a-c407-7b3d-a5ab-ea5c19e7b890@ghiti.fr>
 <20230528-uneatable-earpiece-3f8673548863@spud>
 <b71dc2f5-fdc0-2a8d-e1f9-696cd9a1529e@ghiti.fr>
 <20230529-skillet-quarters-3fbc3b6edb3a@spud>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230529-skillet-quarters-3fbc3b6edb3a@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/05/2023 21:06, Conor Dooley wrote:
> On Mon, May 29, 2023 at 08:51:57PM +0200, Alexandre Ghiti wrote:
>> On 28/05/2023 15:56, Conor Dooley wrote:
>>> On Sun, May 28, 2023 at 03:42:59PM +0200, Alexandre Ghiti wrote:
>>>> Hmmm, it still works for me with both clang and gcc-9.
>>> gcc-9 is a bit of a relic, do you have more recent compilers lying
>>> around? If not, I can try some older compilers at some point.
>>>
>>>> You don't have to do that now but is there a way I could get your compiled
>>>> image? With the sha1 used to build it? Sorry, I don't see what happens, I
>>>> need to get my hands dirty in some debug!
>>> What do you mean by "sha1"? It falls with v6.4-rc1 which is a stable
>>> hash, if that's what you're looking for.
>>>
>>> Otherwise,
>>> https://github.com/ConchuOD/riscv-env/releases/download/v2022.03/vmlinux.bin
>>> (ignore the release crap haha, too lazy to find a proper hosting
>>> mechanism)
>>
>> Ok, I don't get much info without the symbols, can you also provide the
>> vmlinux please? But at least your image does not boot, not during the early
>> boot though because the mmu is enabled.
> Do you see anything print when you try it? Cos I do not. Iff I have time
> tomorrow, I'll go poking with gdb. I'm sorry I have not really done any
> investigating, I have been really busy this last week or so with
> dt-binding stuff but I should be freer again from tomorrow.
>
> https://github.com/ConchuOD/riscv-env/releases/download/v2022.03/vmlinux


Better, the trap happens in kasan_early_init() when it tries to access a 
global symbol using the GOT but ends up with a NULL pointer, which is 
weird. So to me, this is not related to kasan, it happens that 
kasan_early_init() is the first function called after enabling the mmu, 
I think you may have an issue with the filling of the relocations. Sorry 
to bother you again, but if at some point you can recompile with 
DEBUG_INFO enabled, that would be perfect! And also provide the 
vmlinux.relocs file. Sorry for all that, too bad I can't reproduce it.


>
>> I tried with gcc-12 and it still works fine on my end, so frustrating!
> Crap! Also, should you not be enjoying a public holiday rather than
> debugging?! Or maybe debugging is enjoyable for you...


Ahah, this is what I enjoy doing when the kids finally sleep :)


Thank you again for your very quick feedback, really appreciated!


>
> Cheers,
> Conor.
