Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF820741CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 02:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjF2AEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 20:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjF2AEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 20:04:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C10AA3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 17:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=341XUYlQT+Azqpuy9Ji2N0NS2+asAFUbdTCMOFlRLZI=; b=1/Z51YgR7SOhtJNUE4BdQlEeWi
        l7Apw8TUndty/z8qW8baYoX2yrOpTkLYpEin2l9VjD9SLGn1bTwLCEwaQU/qHRS6yyA6BRhiU7GYp
        kZNH125gcdUHI/abc+hUszdZGtiRqwqU14JVbUpAF0ggACX7FE1+IPtV4ktnyeMEM1VMIJv8KkCfb
        FQnxSQYelHNF4tukpL4Q5KXwA39rAm1IBkCFdRx3YYyvrBvAmPhIFOFnPKuKyeAVvB70ZMhdhOH+E
        UnWU8tg5GDjiOzfQLfj/k/jdMwL4s8SvxTdhcPSyKTT0bHMmAHh+hlFM6QZSXHHbUIX1A/pBwyOR3
        gKbuNS0A==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEf97-00H5KU-2f;
        Thu, 29 Jun 2023 00:04:25 +0000
Message-ID: <d9edbd66-a418-0e63-15d1-e8a991325543@infradead.org>
Date:   Wed, 28 Jun 2023 17:04:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: ftrace: fix build error with
 CONFIG_FUNCTION_GRAPH_TRACER=n
Content-Language: en-US
To:     Florent Revest <revest@chromium.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Donglin Peng <pengdonglin@sangfor.com.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230623152204.2216297-1-arnd@kernel.org>
 <CABRcYmJcCWTNHZjh2m75wKUzpvH-vkhkOaG87CU=ZXpDCzrZFw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CABRcYmJcCWTNHZjh2m75wKUzpvH-vkhkOaG87CU=ZXpDCzrZFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/23/23 08:35, Florent Revest wrote:
> On Fri, Jun 23, 2023 at 5:22 PM Arnd Bergmann <arnd@kernel.org> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> It appears that a merge conflict ended up hiding a newly added constant
>> in some configurations:
>>
>> arch/arm64/kernel/entry-ftrace.S: Assembler messages:
>> arch/arm64/kernel/entry-ftrace.S:59: Error: undefined symbol FTRACE_OPS_DIRECT_CALL used as an immediate value
>>
>> FTRACE_OPS_DIRECT_CALL is still used when CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>> is enabled, even if CONFIG_FUNCTION_GRAPH_TRACER is disabled, so change the
>> ifdef accordingly.
>>
>> Fixes: 3646970322464 ("arm64: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  arch/arm64/kernel/asm-offsets.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
>> index 757d01a68ffd0..5ff1942b04fcf 100644
>> --- a/arch/arm64/kernel/asm-offsets.c
>> +++ b/arch/arm64/kernel/asm-offsets.c
>> @@ -213,9 +213,9 @@ int main(void)
>>    DEFINE(FGRET_REGS_X7,                        offsetof(struct fgraph_ret_regs, regs[7]));
>>    DEFINE(FGRET_REGS_FP,                        offsetof(struct fgraph_ret_regs, fp));
>>    DEFINE(FGRET_REGS_SIZE,              sizeof(struct fgraph_ret_regs));
>> +#endif
>>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>>    DEFINE(FTRACE_OPS_DIRECT_CALL,       offsetof(struct ftrace_ops, direct_call));
>> -#endif
>>  #endif
>>    return 0;
>>  }
>> --
>> 2.39.2
>>
> 
> Acked-by: Florent Revest <revest@chromium.org>
> 
> Good catch, thank you Arnd!


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

-- 
~Randy
