Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A62676B60
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 08:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjAVHAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 02:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVHAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 02:00:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7D12197F;
        Sat, 21 Jan 2023 23:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Zrb5LiNepXhvHeP/iXlU4FC0LzbmvuhWYAC688JzxQg=; b=qfaK9D9YSNmkicVKVPLd3xgB00
        vFUlTCfCCKMETPyRIZlQ8xaNRupQLhMMYQFWsLpg8d6J3QpvM5DBulGn1Pd4HoX7hAEaPZYodAVtj
        10DzHFGa93ocjwUwEAG9kWIEQ/D4f1/UG7OZk1+nxa/18ncot8Q4xIPObuVwaZXGTLT9aBSWFmQY+
        W1nJ9E8jyO2I+YbI3YBzEy3tygpk9iz01RHG4e6sZl2gxG8PmPVsgBLC1UH+ojQSwFC29HFP+cN/0
        YokSRmhDsbgTh9MiQ7jD5j4whREtyq3fxrfChfORFnnL25PyvwgMDD8JKllhs3HPuJNHx/6ftSnAl
        b6Ysj+OA==;
Received: from [2601:1c2:d80:3110::9307]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJULK-00EwfE-04; Sun, 22 Jan 2023 07:00:42 +0000
Message-ID: <2085aec3-796b-71c3-7cb2-d4103d3b6175@infradead.org>
Date:   Sat, 21 Jan 2023 23:00:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH: 1/1] sh4: avoid spurious gcc warning
To:     "Michael.Karcher" <Michael.Karcher@fu-berlin.de>,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     jakub@gcc.gnu.org
References: <52952170-f1a9-89a0-e307-f974ce2b7977@fu-berlin.de>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <52952170-f1a9-89a0-e307-f974ce2b7977@fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

It's just sh: AFAICT. The patch fixes the build error for me on sh2,
using gcc 12.1.0 from the kernel.org crosstool builds.

On 1/21/23 16:15, Michael.Karcher wrote:
> Prevent sizeof-pointer-div warning in SH4 intc macros
> 
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
> 
> diff --git a/include/linux/sh_intc.h b/include/linux/sh_intc.h
> index c255273b0281..d7a7ffb60a34 100644
> --- a/include/linux/sh_intc.h
> +++ b/include/linux/sh_intc.h
> @@ -97,7 +97,7 @@ struct intc_hw_desc {
>      unsigned int nr_subgroups;
>  };
> 
> -#define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
> +#define _INTC_ARRAY(a) a, sizeof(a)/(_Generic((a), typeof(NULL): 0xFFFFFFFFU, default: sizeof(*a)))

s/: / : / in 2 places.

Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

How far back in gcc versions does this work?

Thanks.

> 
>  #define INTC_HW_DESC(vectors, groups, mask_regs,    \
>               prio_regs,    sense_regs, ack_regs)    \
> 

-- 
~Randy
