Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8256E676CE6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 13:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjAVMf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 07:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjAVMf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 07:35:26 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C535FC9;
        Sun, 22 Jan 2023 04:35:25 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pJZZC-003o23-CL; Sun, 22 Jan 2023 13:35:22 +0100
Received: from dynamic-078-055-164-239.78.55.pool.telefonica.de ([78.55.164.239] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pJZZC-003qgy-64; Sun, 22 Jan 2023 13:35:22 +0100
Message-ID: <eee8f8c8-6a5a-4ec3-e1e7-1103da7bb7ae@physik.fu-berlin.de>
Date:   Sun, 22 Jan 2023 13:35:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH: 1/1] sh4: avoid spurious gcc warning
To:     "Michael.Karcher" <Michael.Karcher@fu-berlin.de>,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     jakub@gcc.gnu.org
References: <52952170-f1a9-89a0-e307-f974ce2b7977@fu-berlin.de>
Content-Language: en-US
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <52952170-f1a9-89a0-e307-f974ce2b7977@fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 78.55.164.239
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael!

On 1/22/23 01:15, Michael.Karcher wrote:
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
>       unsigned int nr_subgroups;
>   };
> 
> -#define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
> +#define _INTC_ARRAY(a) a, sizeof(a)/(_Generic((a), typeof(NULL): 0xFFFFFFFFU, default: sizeof(*a)))
> 
>   #define INTC_HW_DESC(vectors, groups, mask_regs,    \
>                prio_regs,    sense_regs, ack_regs)    \

The title should probably be "arch/sh: avoid spurious gcc warning" since it's not
a problem special to sh4 but affects the whole arch/sh sub-folder which covers
all SuperH and J-Core targets.

Can you rephrase the title accordingly?

Adrian

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

