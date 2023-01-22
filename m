Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FAC677135
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 18:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjAVRsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 12:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjAVRsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 12:48:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2794614225;
        Sun, 22 Jan 2023 09:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=oXtBqKfAb6gZ3tfQ3MgNrobjUHttHMBBPKyoKiY0e9A=; b=pD0Uesoxqm2xQl1fk3S3Me5tn1
        b8oWklAcDw8AFfeAsYPt30rC86t9LVTXdBJ8/pHQdeZPj9ZK6XseI9SpCs3/5sCjzqQ8IwWQh3A/L
        3fqHnOw0Lm4j9vW32DKtrDavYcBPyUv//xnR2TBbmsb4LlhwF6kcM+cEst5QgfJW4JZeCA3lws+cG
        jkkbw0qVFyZZCDvP+vvN/VlJN3+BKemek1SOMUWpHvttaLsF5fqV3WSGacmVww52iYeQFLBVb5dKc
        Uy1G14gkXL7W2TEZBxAzF8aWw2YmJTZB6V5Des09z0/x2FmjkYHlyxeYmBWreuOY0p3ucawDpSicV
        1vGVBPGg==;
Received: from [2601:1c2:d80:3110::9307]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJeRn-00FbxX-JN; Sun, 22 Jan 2023 17:48:04 +0000
Message-ID: <bc5e2e96-e674-0f12-38e4-84af67135db8@infradead.org>
Date:   Sun, 22 Jan 2023 09:48:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/1] arch/sh: avoid spurious sizeof-pointer-div warning
Content-Language: en-US
To:     Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <563ff850-9966-b790-96d4-bb0557e1152c@mkarcher.dialup.fu-berlin.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <563ff850-9966-b790-96d4-bb0557e1152c@mkarcher.dialup.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/22/23 08:27, Michael Karcher wrote:
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

There are lots of non-ASCII characters in the new patch. This is one example
from over 20,000 lines of warnings:

../include/linux/sh_intc.h:102:27: error: stray '\302' in program
  102 | <U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0> default:<U+00A0><U+00A0><U+00A0><U+00A0><U+00A0><U+00A0> sizeof(*a)))
      |                                                                                                                                                                                                                 ^~~~~~~~

With all of those changed to tabs or spaces:

Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
> History:
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
>      unsigned int nr_subgroups;
>  };
> 
> -#define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
> +#define _INTC_ARRAY(a) a, sizeof(a) / (_Generic(a, \
> +                                       typeof(NULL):  (size_t)-1, \
> +                                       default:       sizeof(*a)))
> 
>  #define INTC_HW_DESC(vectors, groups, mask_regs,    \
>               prio_regs,    sense_regs, ack_regs)    \
> 

-- 
~Randy
