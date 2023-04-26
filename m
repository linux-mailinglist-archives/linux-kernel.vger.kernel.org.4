Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F206EEC3D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 04:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239146AbjDZCKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 22:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238440AbjDZCKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 22:10:47 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869D68699
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 19:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1682475043; bh=I4+WTwpJpG+gq3nJRV2vaRoj4MZKnpy9sosOXV2D/j8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YMKsjpU2on/guZTk7uBIzlkb71uOkLwkNhgcX6icve1/bKv3Lz7jD+PXyIWqFzc/e
         IoedT7juvcYfsVz3TQ2afvuSz+FvpAJxV8Xsw/mIngNgYiIYxfweKdpbUP3FuxAW1r
         zfdlyaNXO2+51GW4OLuUlz8ST08sAg2eDXQt16pI=
Received: from [100.100.57.122] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id C2824600A6;
        Wed, 26 Apr 2023 10:10:42 +0800 (CST)
Message-ID: <b882eb61-d783-985e-7687-386f9e03235d@xen0n.name>
Date:   Wed, 26 Apr 2023 10:10:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: Loongson (and other $ARCHs?) idle VS timer enqueue
Content-Language: en-US
To:     maobibo <maobibo@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <ZEKDZEQmKExv0O7Q@lothringen> <87leil2r7v.ffs@tglx>
 <20230422081700.GB1214746@hirez.programming.kicks-ass.net>
 <ZEPteS82TbIhMQxe@lothringen>
 <20230422150409.GL1214746@hirez.programming.kicks-ass.net>
 <7d91fa2a-57c5-6c78-8e2d-7fbdd6a11cba@loongson.cn>
 <20230425114937.GC1335080@hirez.programming.kicks-ass.net>
 <5ba79220-683f-a78a-8c3b-bc0b118226f8@loongson.cn>
 <d9c9b2cb-dd5e-03dd-9a7e-27938af96aaf@xen0n.name>
 <f0f029c5-b095-d713-114f-dc7d5c092d8a@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <f0f029c5-b095-d713-114f-dc7d5c092d8a@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/26 08:46, maobibo wrote:
> 
> 
> 在 2023/4/25 21:28, WANG Xuerui 写道:
>> On 2023/4/25 21:25, maobibo wrote:
>>>
>>>
>>> 在 2023/4/25 19:49, Peter Zijlstra 写道:
>>
>> <snip>
>>
>>>>
>>>> diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
>>>> index 44ff1ff64260..3c8a6bab98fe 100644
>>>> --- a/arch/loongarch/kernel/genex.S
>>>> +++ b/arch/loongarch/kernel/genex.S
>>>> @@ -18,27 +18,31 @@
>>>>          .align    5
>>>>    SYM_FUNC_START(__arch_cpu_idle)
>>>> -    /* start of rollback region */
>>>> -    LONG_L    t0, tp, TI_FLAGS
>>>> -    nop
>>>> -    andi    t0, t0, _TIF_NEED_RESCHED
>>>> -    bnez    t0, 1f
>>>> -    nop
>>>> -    nop
>>>> -    nop
>>>> +    /* start of idle interrupt region */
>>>> +    move    t0, CSR_CRMD_IE
>>> addi.d  t0, zero, CSR_CRMD_IE can be used here, move is used for reg to reg
>>
>> Or better: li.d t0, CSR_CRMD_IE (prefer pseudo-instruction over concrete ones whenever it helps readability). We don't need to support ancient in-house toolchains without support for even li. ;-)
>    
> I am not familiar with compiler:(, how many actual instructions does
> pseudo-instr li.d takes? It will be ok if it uses only one intr, else
> there will be problem.

It's just `ori $t0, $zero, 4` no matter which of li.w or li.d is used. 
It only matters when the immediate to load is bigger. Given CSR_CRMD_IE 
is just 4 (1<<2) you can definitely say `li.w` if you want to be extra 
cautious and it won't hurt. ;-)

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

