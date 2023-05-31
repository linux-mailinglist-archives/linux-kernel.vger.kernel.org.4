Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9C8717D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbjEaLED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235358AbjEaLDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:03:46 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27A5E4B
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 04:03:30 -0700 (PDT)
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9E54DC0006;
        Wed, 31 May 2023 11:03:26 +0000 (UTC)
Message-ID: <9a94446d-bc6c-6272-8101-d1adeec3d672@ghiti.fr>
Date:   Wed, 31 May 2023 13:03:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH -fixes] riscv: Fix relocatable kernels with early
 alternatives using -fno-pie
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230528-uneatable-earpiece-3f8673548863@spud>
 <b71dc2f5-fdc0-2a8d-e1f9-696cd9a1529e@ghiti.fr>
 <20230529-skillet-quarters-3fbc3b6edb3a@spud>
 <41e57bb9-ce0c-7772-abeb-5c01d5ec19bb@ghiti.fr>
 <20230530-polka-trifle-7ccd7a093099@wendy>
 <92d4aaa8-a1ed-74e1-3a22-df9be1ca1e4a@ghiti.fr>
 <20230530-hatchery-unifier-64d7a2ffe0d0@spud>
 <CAHVXubgG31moSNOe3fRqFzUSJK9tRWKH1KPP_BO7wRNC4WzxTQ@mail.gmail.com>
 <20230530-atrocious-control-bcb37de558fc@spud>
 <0068add0-8949-11b7-a864-2ef8bed00809@ghiti.fr>
 <20230531-staff-pampers-0250f7f6026a@spud>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230531-staff-pampers-0250f7f6026a@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31/05/2023 11:32, Conor Dooley wrote:
> On Wed, May 31, 2023 at 09:26:27AM +0200, Alexandre Ghiti wrote:
>> On 30/05/2023 22:22, Conor Dooley wrote:
>>> On Tue, May 30, 2023 at 08:04:17PM +0200, Alexandre Ghiti wrote:
>>>> Ahah, I think we found the culprit!
>>>>
>>>> With CONFIG_RELOCATABLE, vmlinux is actually stripped from all the
>>>> relocations (so that it can be shipped) and vmlinux.relocs is what you
>>>> should use instead, since it is just a copy of vmlinux before the
>>>> removal of the relocations!
>>> That probably makes us both eejits for not realising sooner...
>> Ahah, TIL a new word, thanks :)
>>
>>> Tested-by: Conor Dooley <conor.dooley@microchip.com> # booted on nezha & unmatched
>>>
>>> Thanks for your patience here Alex.
>> So I checked again if the -fno-pie should be applied to mm/dma-noncoherent.c
>> as I suggested, but actually no: errata/thead/errata.c never reaches
>> riscv_noncoherent_supported() in early boot (you can see how 'fragile' it is
>> though and why something needs to be done...).
> I did make sure to check this patch itself, without the additional bit,
> to see if it was needed.
> But yeah, it is going to be super fragile - do you have any ideas about
> how to circumvent that?


Yes, I was thinking about multiple solutions:

- All the early code could go into kernel/pi: all the dependencies of 
the early code is built in its own way (the symbols are actually 
'duplicated'). I see that a bit like the EFI stub. My first try failed 
with !CONFIG_RELOCATABLE, I have to dig further.

- Simply do a physical relocation before any early code, execute the 
early code, and then do the virtual relocation. But that does not solve 
the issue fixed by kernel/pi which allows to recompile standard 
functions (like the string ones) without any instrumentation and have 
the versions with the instrumentation for normal execution.

- Compile relocatable kernels without -fPIE (why can't we just use 
medany actually?). That won't fix certain types of situations where we 
need relocations, but that will limit the number of outliers that need 
to be compiled with -fno-pie and it will be easier to spot (we'll still 
have to be very careful though)

- Be very strict about what can/cannot be done in this pre-mmu stage, 
and document that...

The best solution would be the first I guess. Any other ideas welcome :)


>
>> Oh and I realized that I forgot the Reported-by from Andreas and the Fixes
>> tags, so here they are:
>>
>> Fixes: 39b33072941f ("riscv: Introduce CONFIG_RELOCATABLE")
>> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
>>
>>
>> Thank you too for your patience and your quick answers!
>>
>> Alex
>>
>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
