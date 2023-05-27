Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3043713395
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 11:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjE0JN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 05:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjE0JN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 05:13:27 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694BBE3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 02:13:25 -0700 (PDT)
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 336871C0004;
        Sat, 27 May 2023 09:13:20 +0000 (UTC)
Message-ID: <f6522c82-01bd-8a03-579d-a5b294784480@ghiti.fr>
Date:   Sat, 27 May 2023 11:13:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH -fixes] riscv: Fix relocatable kernels with early
 alternatives using -fno-pie
Content-Language: en-US
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
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230526-rockfish-moody-f6d3e71f9d24@spud>
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


On 26/05/2023 18:35, Conor Dooley wrote:
> On Fri, May 26, 2023 at 05:24:41PM +0100, Conor Dooley wrote:
>> On Fri, May 26, 2023 at 05:46:30PM +0200, Alexandre Ghiti wrote:
>>> Early alternatives are called with the mmu disabled, and then should not
>>> access any global symbols through the GOT since it requires relocations,
>>> relocations that we do before but *virtually*. So only use medany code
>>> model for this early code.
>>>
>>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>> ---
>>>
>>> Note that I'm not very happy with this fix, I think we need to put more
>>> effort into "harmonizing" this very early code (ie before the mmu is
>>> enabled) as it is spread between different locations and compiled
>>> differently.
>> Totally & I'll happily spend the time trying to review that work.
>>
>>> I'll work on that later, but for now, this fix does what is
>>> needed to work (from my testing at least). Any Tested-by on the Unmatched
>>> and T-head boards is welcome!
>> On 6.4-rc1 & v6.4-rc1 + this patch, with CONFIG_RELOCATABLE added to my
>> config, my Nezha fails to boot. There is no output whatsoever from the
>> kernel. Turning off CONFIG_RELOCATABLE boots again.
> I don't know if this is better or worse news, but same thing happens on
> an icicle kit. What systems, other than QEMU, has the relocatable
> eries been tested with, btw?


I tested it on the Unmatched (Andreas did too).

Very weird it does not work on the icicle kit, there is no errata for 
this soc, so what gets executed this early for this soc? Do you know 
where it fails to boot? If you can debug, you should break on the 
address of the entry point (usually 0x8020_0000) since this is the stvec 
address, so when you get a trap, you will branch there, and then could 
you dump $sepc, $ra and $stval when you get there?

Regarding the thead issue, I think the following should fix it:

diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index b85e9e82f082..a9bf3f8c7cb4 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -3,6 +3,7 @@
  CFLAGS_init.o := -mcmodel=medany
  ifdef CONFIG_RELOCATABLE
  CFLAGS_init.o += -fno-pie
+CFLAGS_dma-noncoherent.o += -fno-pie
  endif

  ifdef CONFIG_FTRACE


>
> Cheers,
> Conor.
>
>> I didn't test on my unmatched.
>>
>> Thanks,
>> Conor.
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
