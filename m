Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5AB6EE2FC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjDYN2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbjDYN2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:28:36 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81217CC20
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1682429304; bh=fto49mKsONy93CZBngA/x8zbePY/8ToUDvSihHTfkN8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bKMZcH1/A1WohwTLZazwlB41Yp7AlxwebCyztci2IRrlKzyi4iP1M3z2rse5sjz6A
         Lax7lnr2WDaPLRykuZmYk5Ynoo2TcDvQti2sr4TEvkBC4Sy89zS2TpWOvpn0Fvxt8E
         qs7ncYRjWws/zhJRTo2BdNHdfL2eco5P1hkJlMm8=
Received: from [100.100.57.122] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id CD5C46011B;
        Tue, 25 Apr 2023 21:28:23 +0800 (CST)
Message-ID: <d9c9b2cb-dd5e-03dd-9a7e-27938af96aaf@xen0n.name>
Date:   Tue, 25 Apr 2023 21:28:23 +0800
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
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <5ba79220-683f-a78a-8c3b-bc0b118226f8@loongson.cn>
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

On 2023/4/25 21:25, maobibo wrote:
> 
> 
> 在 2023/4/25 19:49, Peter Zijlstra 写道:

<snip>

>>
>> diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
>> index 44ff1ff64260..3c8a6bab98fe 100644
>> --- a/arch/loongarch/kernel/genex.S
>> +++ b/arch/loongarch/kernel/genex.S
>> @@ -18,27 +18,31 @@
>>   
>>   	.align	5
>>   SYM_FUNC_START(__arch_cpu_idle)
>> -	/* start of rollback region */
>> -	LONG_L	t0, tp, TI_FLAGS
>> -	nop
>> -	andi	t0, t0, _TIF_NEED_RESCHED
>> -	bnez	t0, 1f
>> -	nop
>> -	nop
>> -	nop
>> +	/* start of idle interrupt region */
>> +	move	t0, CSR_CRMD_IE
> addi.d  t0, zero, CSR_CRMD_IE can be used here, move is used for reg to reg

Or better: li.d t0, CSR_CRMD_IE (prefer pseudo-instruction over concrete 
ones whenever it helps readability). We don't need to support ancient 
in-house toolchains without support for even li. ;-)

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

