Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44A96FEFA4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbjEKKHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 06:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237549AbjEKKHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:07:34 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A35A1;
        Thu, 11 May 2023 03:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1683799650; bh=VqDgL7HU+yu2cg9LzMt1GR3g7Ypf89l9GP5PH/EG4Zk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ApqH0CwwldgFtdmJItmpSyedxMCa3vdCBBm1hLHAx7rb9nb90/4I4cvWSP/Nzvdic
         RHn1nQZ70lRpD5Hrlx+MpgfGDbhrsk8SCxsJPMPylE6stTj9TDWmjWcZg7snb4OC3H
         ZfLVCSSArHDsVRRb5dReCKL0FPZZ1//ebSGRWyJM=
Received: from [100.100.57.122] (unknown [58.34.185.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id B758360106;
        Thu, 11 May 2023 18:07:29 +0800 (CST)
Message-ID: <160f2a29-e935-143a-cdae-7b3e1f2797f9@xen0n.name>
Date:   Thu, 11 May 2023 18:07:29 +0800
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
 <3b360532-6ad5-b22c-b02a-103be491be4c@xen0n.name>
 <72b6c81a-d4ee-575a-ff48-6be7e034ac96@loongson.cn>
 <20230511074359.GQ4253@hirez.programming.kicks-ass.net>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230511074359.GQ4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/11 15:43, Peter Zijlstra wrote:
> On Thu, May 11, 2023 at 09:33:37AM +0800, Youling Tang wrote:
> 
>>>> +void arch_jump_label_transform(struct jump_entry *entry,
>>>> +                   enum jump_label_type type)
>>>> +{
>>>> +    void *addr = (void *)jump_entry_code(entry);
>>>> +    u32 insn;
>>>> +
>>>> +    if (type == JUMP_LABEL_JMP)
>>>
>>> Please use a switch for dealing with enum-typed values.
>>
>> Because the current type only has JUMP_LABEL_NOP and JUMP_LABEL_JMP,
>> using if may be simpler than switch.
> 
> IIRC we used an enum with descriptive names instead of a boolean because
> true/false just doesn't tell you much.
> 
> The whole thing fundamentally is a boolean descision though, either
> you write a JMP or a NOP, jump-labels don't have more options.

Ah thanks for the background. My previous suggestion is just kinda 
generally applicable software engineering best practice, so if the 
actual enum is unlikely to get >2 variants then it should be fine to 
keep using "if". Youling, feel free to ignore the piece of comment, and 
sorry for not doing my archaeology beforehand. :)

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

