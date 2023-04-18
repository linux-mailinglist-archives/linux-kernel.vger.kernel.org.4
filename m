Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63036E5BA3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjDRIJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjDRIJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:09:05 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9D67ABC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:08:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VgOfNHv_1681805096;
Received: from 30.221.131.28(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VgOfNHv_1681805096)
          by smtp.aliyun-inc.com;
          Tue, 18 Apr 2023 16:04:57 +0800
Message-ID: <b6214ee7-3fa0-7363-f320-153b6daad2c0@linux.alibaba.com>
Date:   Tue, 18 Apr 2023 16:04:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] x86/alternatives: fix build issue with binutils before
 2.28
To:     Willy Tarreau <w@1wt.eu>, Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <20230418064228.21577-1-w@1wt.eu>
Content-Language: en-US
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230418064228.21577-1-w@1wt.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/23 2:42 PM, Willy Tarreau wrote:
> The usage of the BIT() macro in asm code was introduced in 6.3 in by
> commit 5d1dd961e743 ("x86/alternatives: Add alt_instr.flags") but this
> macro uses "1UL" in the shift operations, while gas before 2.28 do not
> support the "L" suffix after a number, and those before 2.27 do not
> support the "U" suffix, resulting in build errors such as the following
> with such versions:
> 
>   ./arch/x86/include/asm/uaccess_64.h:124: Error: found 'L', expected: ')'
>   ./arch/x86/include/asm/uaccess_64.h:124: Error: junk at end of line,
>   first unrecognized character is `L'
> 
> There's a single use of this macro here, let's revert to (1 << 0) that
> works with such older binutils.
> 
> Cc: Jingbo Xu <jefflexu@linux.alibaba.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Link: https://lore.kernel.org/lkml/a9aae568-3046-306c-bd71-92c1fc8eeddc@linux.alibaba.com/
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> ---
> 
> Boris, I understood from your message that 2.28 was the first working version,
> so that's what I mentioned here. My tests showed that 2.27 wasn't sufficient
> and that 2.29 was OK. If I was wrong and it's 2.29 instead, feel free to edit
> the subject line, description and the comment, I'm totally fine with this!
> 
> 
>  arch/x86/include/asm/alternative.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
> index e2975a32d443..b119685c0b31 100644
> --- a/arch/x86/include/asm/alternative.h
> +++ b/arch/x86/include/asm/alternative.h
> @@ -8,7 +8,7 @@
>  
>  #define ALT_FLAGS_SHIFT		16
>  
> -#define ALT_FLAG_NOT		BIT(0)
> +#define ALT_FLAG_NOT		(1 << 0) /* note: gas < 2.28 can't use BIT(0) */
>  #define ALT_NOT(feature)	((ALT_FLAG_NOT << ALT_FLAGS_SHIFT) | (feature))
>  
>  #ifndef __ASSEMBLY__

It works for me.

Tested-by: Jingbo Xu <jefflexu@linux.alibaba.com>


-- 
Thanks,
Jingbo
