Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A069A714F75
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 20:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjE2SwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 14:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjE2SwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 14:52:10 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFD6C4
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 11:52:07 -0700 (PDT)
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id CFB821BF203;
        Mon, 29 May 2023 18:52:00 +0000 (UTC)
Message-ID: <b71dc2f5-fdc0-2a8d-e1f9-696cd9a1529e@ghiti.fr>
Date:   Mon, 29 May 2023 20:51:57 +0200
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
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230528-uneatable-earpiece-3f8673548863@spud>
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


On 28/05/2023 15:56, Conor Dooley wrote:
> On Sun, May 28, 2023 at 03:42:59PM +0200, Alexandre Ghiti wrote:
>> Hmmm, it still works for me with both clang and gcc-9.
> gcc-9 is a bit of a relic, do you have more recent compilers lying
> around? If not, I can try some older compilers at some point.
>
>> You don't have to do that now but is there a way I could get your compiled
>> image? With the sha1 used to build it? Sorry, I don't see what happens, I
>> need to get my hands dirty in some debug!
> What do you mean by "sha1"? It falls with v6.4-rc1 which is a stable
> hash, if that's what you're looking for.
>
> Otherwise,
> https://github.com/ConchuOD/riscv-env/releases/download/v2022.03/vmlinux.bin
> (ignore the release crap haha, too lazy to find a proper hosting
> mechanism)


Ok, I don't get much info without the symbols, can you also provide the 
vmlinux please? But at least your image does not boot, not during the 
early boot though because the mmu is enabled.

I tried with gcc-12 and it still works fine on my end, so frustrating!


> | git show
> | commit 3bd124485ed55d8ee6c1ff3532c8f617b24aa6ef (HEAD)
> | Author: Alexandre Ghiti <alexghiti@rivosinc.com>
> | Date:   Fri May 26 17:46:30 2023 +0200
> |
> |     riscv: Fix relocatable kernels with early alternatives using -fno-pie
> |
> |     Early alternatives are called with the mmu disabled, and then should not
> |     access any global symbols through the GOT since it requires relocations,
> |     relocations that we do before but *virtually*. So only use medany code
> |     model for this early code.
> |
> |     Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> |     Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> |
> | diff --git a/arch/riscv/errata/Makefile b/arch/riscv/errata/Makefile
> | index a1055965fbee..7b2637c8c332 100644
> | --- a/arch/riscv/errata/Makefile
> | +++ b/arch/riscv/errata/Makefile
> | @@ -1,2 +1,6 @@
> | +ifdef CONFIG_RELOCATABLE
> | +KBUILD_CFLAGS += -fno-pie
> | +endif
> | +
> |  obj-$(CONFIG_ERRATA_SIFIVE) += sifive/
> |  obj-$(CONFIG_ERRATA_THEAD) += thead/
> | diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> | index fbdccc21418a..153864e4f399 100644
> | --- a/arch/riscv/kernel/Makefile
> | +++ b/arch/riscv/kernel/Makefile
> | @@ -23,6 +23,10 @@ ifdef CONFIG_FTRACE
> |  CFLAGS_REMOVE_alternative.o = $(CC_FLAGS_FTRACE)
> |  CFLAGS_REMOVE_cpufeature.o = $(CC_FLAGS_FTRACE)
> |  endif
> | +ifdef CONFIG_RELOCATABLE
> | +CFLAGS_alternative.o += -fno-pie
> | +CFLAGS_cpufeature.o += -fno-pie
> | +endif
> |  ifdef CONFIG_KASAN
> |  KASAN_SANITIZE_alternative.o := n
> |  KASAN_SANITIZE_cpufeature.o := n
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
