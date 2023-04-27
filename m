Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AD46EFFBF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 05:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242857AbjD0DQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 23:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjD0DQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 23:16:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95D635A6;
        Wed, 26 Apr 2023 20:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=f57Zj/04myr3002sVqcVQkqmm+HfOyku1xoDDfbgmL0=; b=x7j9CudlY7a1euI+PbiS85v+KR
        BRossHnSmCv4GPvBF5aCAXqSRVM31zSZyHrVcYHC82iVfUGEuyNK9Za2v0Hju1HxWyQEazDPe3bzC
        7bvxRd9YHHMDTC85XvT+F494X1E8b9T+6JjOGuFhiYutabbx3TatB9vWgDslKV90qj9+yR+Vc/uJN
        t6X5TMJYzqKvlwf9K6d2xLi0urE5mxhDXeJ2zNY6Eh2BXdHRvE4oWctbDR6Vz/6O91K75RWEWfCHR
        eiDW3bM/tv9Bt0GxqEXmBCUHMBuefOJ0SLDjiEBw34U1sk3K4eoNDyn40Sfx/lGwbYJGMOLNGC4Ta
        MsFj4dpg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1prs7V-005L2i-0H;
        Thu, 27 Apr 2023 03:16:33 +0000
Message-ID: <17660b99-d68d-328e-5fe6-c011709fa3e4@infradead.org>
Date:   Wed, 26 Apr 2023 20:16:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] fix ___SYNC () build error when PROFILE_ALL_BRANCHES is
 enabled
Content-Language: en-US
To:     genjian zhang <zhanggenjian123@gmail.com>,
        tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
References: <20230426124948.1072216-1-zhanggenjian@kylinos.cn>
 <CAOd03yQ98st7KvAkwfFqFvXGBdmWmOZZ-kWAH5DAi7gLd=ngaA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAOd03yQ98st7KvAkwfFqFvXGBdmWmOZZ-kWAH5DAi7gLd=ngaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

> 
> Maybe the readability of this modification is not very good. Any
> comments and suggestions are welcome. Thanks.

Some of the patch description could use some cleaning up,
then I have a question.


On 4/26/23 06:02, genjian zhang wrote:
> On Wed, Apr 26, 2023 at 8:51 PM Genjian <zhanggenjian123@gmail.com> wrote:
>>
>> From: Genjian Zhang <zhanggenjian@kylinos.cn>
>>
>> compiler error (mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110):
>>
>> {standard input}: Assembler messages:
>> {standard input}:171: Error: found '(', expected: ')'
>> {standard input}:171: Error: found '(', expected: ')'
>> {standard input}:171: Error: non-constant expression in ".if" statement
>> {standard input}:171: Error: junk at end of line, first unrecognized
>> character is `('
>>
>> Preprocessor expand ___SYNC () macros.However,'if' will be wrongly

                expands ___SYNC() macros. However, 'if' will be wrongly

>> replaced by C code when PROFILE_ALL_BRANCHES is enabled and ___SYNC
>> is used in inline assembly.This leads to syntax errors in the code.

                     assembly. This

>> Compilers report a lot of errors like the above.
>> Move '.if' into quoted strings to fix it.
>>
>> Reported-by: k2ci <kernel-bot@kylinos.cn>
>> Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
>> ---
>>  arch/mips/include/asm/sync.h | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/mips/include/asm/sync.h b/arch/mips/include/asm/sync.h
>> index aabd097933fe..d9f5a87424e7 100644
>> --- a/arch/mips/include/asm/sync.h
>> +++ b/arch/mips/include/asm/sync.h
>> @@ -175,7 +175,7 @@
>>   */
>>  #ifdef CONFIG_CPU_HAS_SYNC
>>  # define ____SYNC(_type, _reason, _else)                       \
>> -       .if     (( _type ) != -1) && ( _reason );               \
>> +       ((_type) != -1) && (_reason);                           \
>>         .set    push;                                           \
>>         .set    MIPS_ISA_LEVEL_RAW;                             \
>>         .rept   __SYNC_rpt(_type);                              \
>> @@ -192,13 +192,15 @@
>>  /*
>>   * Preprocessor magic to expand macros used as arguments before we insert them
>>   * into assembly code.
>> + * In addition,‘if’ can not be substituted when CONFIG_PROFILE_ALL_BRANCHES is

     * In addition, 'if' cannot be

>> + * enabled.
>>   */
>>  #ifdef __ASSEMBLY__
>>  # define ___SYNC(type, reason, else)                           \
>> -       ____SYNC(type, reason, else)
>> +       .if     ____SYNC(type, reason, else)
>>  #else
>>  # define ___SYNC(type, reason, else)                           \
>> -       __stringify(____SYNC(type, reason, else))
>> +       ".if"   __stringify(____SYNC(type, reason, else))
>>  #endif
>>
>>  #define __SYNC(type, reason)                                   \
>> --
>> 2.25.1


Is this problem that you are fixing being aggravated (caused) by
the #define of if() in include/linux/compiler.h when CONFIG_PROFILE_ALL_BRANCHES
is set?  I suspect that it is.
It wouldn't hurt to mention that (if I am correct).

Thanks.
-- 
~Randy
