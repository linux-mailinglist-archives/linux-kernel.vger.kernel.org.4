Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F24678680
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjAWThm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjAWThk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:37:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2933132509;
        Mon, 23 Jan 2023 11:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=0CYw3B5fdHcp1ceWLR2TGwnczmcK5NwFJMrherQyT+0=; b=rmWQL+X2VlIJUup29Jr8b5fAMJ
        N6ktNo4AWzidXdzef7YpALZJD1PJoasnizlhOGjR/0IPvB24T4/ThnKZPiFlyIXvZ97Av7gJpDuiH
        nkrdLMTI89nlIfR6BbAS79rLTP+KfEa4+V6SKa3n2EK6vy52dFR7YQxwxMldZegXJ8+uyZuygeClE
        DaPeEhN72RWxTbwXOQbVD+znpuCQSr4vJBUObNPXKdukQ+YpnvLDy3x4zj6I+oSjAuWnZtz+skibM
        WN+bGj0nCkyrKizbqHMvzwGGMhxFVyx6AUZm2dvuvPROca6ukASYDQCnokeQNu9f07+hI772g0mv0
        ewFwYMGw==;
Received: from [2601:1c2:d80:3110::9307]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK2dK-001CMB-01; Mon, 23 Jan 2023 19:37:34 +0000
Message-ID: <f540c26e-baa8-5c18-9502-622a4091b675@infradead.org>
Date:   Mon, 23 Jan 2023 11:37:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 1/1] arch/sh: avoid spurious sizeof-pointer-div warning
Content-Language: en-US
To:     Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <b41ea008-d9c4-fd76-a5ce-00fe435deed5@mkarcher.dialup.fu-berlin.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <b41ea008-d9c4-fd76-a5ce-00fe435deed5@mkarcher.dialup.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm curious how you generated this patch.
'patch' complains:

patch: **** malformed patch at line 53:                prio_regs,    sense_regs, ack_regs)    \

(more below)

On 1/23/23 10:48, Michael Karcher wrote:
> Gcc warns about the pattern sizeof(void*)/sizeof(void), as it looks like
> the abuse of a pattern to calculate the array size. This pattern appears
> in the unevaluated part of the ternary operator in _INTC_ARRAY if the
> parameter is NULL.
> 
> The replacement uses an alternate approach to return 0 in case of NULL
> which does not generate the pattern sizeof(void*)/sizeof(void), but still
> emits the warning if _INTC_ARRAY is called with a nonarray parameter.
> 
> This patch is required for successful compilation with -Werror enabled.
> 
> The idea to use _Generic for type distinction is taken from Comment #7
> in https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108483 by Jakub Jelinek
> 
> Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> ---
> This edition of the mail has the correct "v4" designation in the subject.
> 
> History:
> v4:
>   - Put the case distinction into the numerator instead of the denominator
>   - Refactor the case disctinction into a second macro
> v3:
>   - I had a stern discussion with Thunderbird about not mangling the
>     space characters in my email, and I hope spaces get sent as standard
>     spaces now
> v2:
>   - improve title and remove mostly redundant first sentence of the
>     description
>   - adjust formatting of the _Generic construction
> 
> diff --git a/include/linux/sh_intc.h b/include/linux/sh_intc.h
> index c255273b0281..98d1da0d8e36 100644
> --- a/include/linux/sh_intc.h
> +++ b/include/linux/sh_intc.h
> @@ -97,7 +97,9 @@ struct intc_hw_desc {

That ,9 should be ,10.

With that change:

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

>      unsigned int nr_subgroups;
>  };
> 
> -#define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
> +#define _INTC_SIZEOF_OR_ZERO(a) (_Generic(a,                 \
> +                                 typeof(NULL):  0,           \
> +                                 default:       sizeof(a)))
> +#define _INTC_ARRAY(a) a, _INTC_SIZEOF_OR_ZERO(a)/sizeof(*a)
> 
>  #define INTC_HW_DESC(vectors, groups, mask_regs,    \
>               prio_regs,    sense_regs, ack_regs)    \
> 
> 

-- 
~Randy
