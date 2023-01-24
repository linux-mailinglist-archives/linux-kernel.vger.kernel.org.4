Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDFE67A59C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjAXWWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjAXWWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:22:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BB52ED7B;
        Tue, 24 Jan 2023 14:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=85wQJ1T0FgB7jdbTAIU4N89j02y6DNu0JcJ0cGxxy/A=; b=sP25CJ0IW8VYRwPigUMtcw6N9b
        phVCeLBV2z+P9cMTFXxAlmba0Vjjmh1WFbZ5R8A8gRkskiSlcXjmGs72zROWoH6Ca4+W5ZQc+bdGo
        M1f+aikAxcdjR34nquiiyaaw99/q7xYBX4848Z4Q+LBWlP6sU6jhc5hkIYGZf3tGmKlFemHDEKKDP
        3kDIRghGi55JsYE1wAS6DiDgtHqtCIdC7u00Ohd/jULdmCD9I4pXno4BhSKsoO8tYa5B4/8f/cqWe
        2aUP1is/8cFIu2ZxMhkZCBa0BfB8z0iR8fPizEOZpz/QavfaKheLfIWYPEmNiCaDzt31rbAtNknmT
        Nb6athTg==;
Received: from [2601:1c2:d80:3110::9307]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKRgF-005UY3-L9; Tue, 24 Jan 2023 22:22:15 +0000
Message-ID: <9cce70d9-bbcc-0026-d872-f4d1f90148be@infradead.org>
Date:   Tue, 24 Jan 2023 14:22:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 1/1] arch/sh: avoid spurious sizeof-pointer-div warning
Content-Language: en-US
To:     Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <619fa552-c988-35e5-b1d7-fe256c46a272@mkarcher.dialup.fu-berlin.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <619fa552-c988-35e5-b1d7-fe256c46a272@mkarcher.dialup.fu-berlin.de>
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

Hi--

On 1/24/23 13:48, Michael Karcher wrote:
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
> inhttps://gcc.gnu.org/bugzilla/show_bug.cgi?id=108483  by Jakub Jelinek
> 
> Signed-off-by: Michael Karcher<kernel@mkarcher.dialup.fu-berlin.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
> (resend of the mail as plaintext only instead of multipart/alternative)
> History:
> v5:
>   - Cleanly generated the patch
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
> index c255273b0281..37ad81058d6a 100644
> --- a/include/linux/sh_intc.h
> +++ b/include/linux/sh_intc.h
> @@ -97,7 +97,10 @@ struct intc_hw_desc {
>         unsigned int nr_subgroups;
>  };
> 
> -#define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
> +#define _INTC_SIZEOF_OR_ZERO(a) (_Generic(a,                 \
> +                                 typeof(NULL):  0,           \
> +                                 default:       sizeof(a)))
> +#define _INTC_ARRAY(a) a, _INTC_SIZEOF_OR_ZERO(a)/sizeof(*a)
> 
>  #define INTC_HW_DESC(vectors, groups, mask_regs,       \
>                      prio_regs, sense_regs, ack_regs)   \
> 
> 
> 

-- 
~Randy
