Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB21712AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbjEZQi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjEZQiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:38:24 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828F9BC
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:38:19 -0700 (PDT)
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 01FAF40009;
        Fri, 26 May 2023 16:38:14 +0000 (UTC)
Message-ID: <dc4adf31-e92e-e073-a1ed-2da0015c9de8@ghiti.fr>
Date:   Fri, 26 May 2023 18:38:14 +0200
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
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230526-clergyman-wriggly-accc659a3fad@spud>
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


On 26/05/2023 18:24, Conor Dooley wrote:
> On Fri, May 26, 2023 at 05:46:30PM +0200, Alexandre Ghiti wrote:
>> Early alternatives are called with the mmu disabled, and then should not
>> access any global symbols through the GOT since it requires relocations,
>> relocations that we do before but *virtually*. So only use medany code
>> model for this early code.
>>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>>
>> Note that I'm not very happy with this fix, I think we need to put more
>> effort into "harmonizing" this very early code (ie before the mmu is
>> enabled) as it is spread between different locations and compiled
>> differently.
> Totally & I'll happily spend the time trying to review that work.
>
>> I'll work on that later, but for now, this fix does what is
>> needed to work (from my testing at least). Any Tested-by on the Unmatched
>> and T-head boards is welcome!
> On 6.4-rc1 & v6.4-rc1 + this patch, with CONFIG_RELOCATABLE added to my
> config, my Nezha fails to boot. There is no output whatsoever from the
> kernel. Turning off CONFIG_RELOCATABLE boots again.


Damn, that's going to ruin my long week-end...Thanks though, I'll try to 
figure out what's going on, too bad I don't have any thead boards!

Thanks again,

Alex


> I didn't test on my unmatched.
>
> Thanks,
> Conor.
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
