Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86446FDAD1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbjEJJek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjEJJej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:34:39 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624E73A89;
        Wed, 10 May 2023 02:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1683711275; bh=CVCNr+jiCPA9b+x0610c9UfH/6p5CPr9D1Yj681oIcw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HxkXA9XPuRLHE/D3W2hj/JAI8D5u3GtMSwd65oBRjmoscxxo8G6e1ZomdRhVk+C+B
         dY7CwJH+NAIkL1y6WKINQhtUUffDkKB+Tz+n8jGuEwIQEgAdW9RaxmaSMMPG4NAooq
         Z8HEk/JVknqNUGJoj4132JZcc5vWyL+/rRDt2NxM=
Received: from [100.100.57.122] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 7BDC96014E;
        Wed, 10 May 2023 17:34:34 +0800 (CST)
Message-ID: <15594820-0a95-94bb-132f-5008d31c041f@xen0n.name>
Date:   Wed, 10 May 2023 17:34:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v2] LoongArch: Add jump-label implementation
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Youling Tang <tangyouling@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Zhangjin Wu <falcon@tinylab.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
References: <1683710206-23905-1-git-send-email-tangyouling@loongson.cn>
 <20230510092723.GK4253@hirez.programming.kicks-ass.net>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230510092723.GK4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

My 2 cents:

On 2023/5/10 17:27, Peter Zijlstra wrote:
> On Wed, May 10, 2023 at 05:16:46PM +0800, Youling Tang wrote:
>> Add jump-label implementation based on the ARM64 version.
>>
>> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> 
>> <snip>
>>
>> +	if (type == JUMP_LABEL_JMP)
>> +		insn = larch_insn_gen_b(jump_entry_code(entry), jump_entry_target(entry));
>> +	else
>> +		insn = larch_insn_gen_nop();
>> +
>> +	larch_insn_patch_text(addr, insn);
>> +}
> 
> This all implies Loongarch is fine with the nop<->b transition (much
> like arm64 is), but I found no actual mention of what transitions are
> valid for the architecture in your inst.c file -- perhaps you could put
> a small comment there to elucidate the occasional reader that doesn't
> have your arch manual memorized?

Do you mean by "valid transition" something like "what kind of 
self-modification is architecturally sound, taking ICache / 
micro-architecture behavior etc. into consideration"? If so, I'd say 
things would be fine in LoongArch as long as an instruction fetch 
barrier is used. Maybe Youling can confirm and mention this in the next 
revision.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

