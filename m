Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4C06287D4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbiKNSFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237427AbiKNSEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:04:41 -0500
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473742C111;
        Mon, 14 Nov 2022 10:04:22 -0800 (PST)
Received: from [IPV6:2a01:e35:39f2:1220:da6c:81de:7fd7:e3eb] (unknown [IPv6:2a01:e35:39f2:1220:da6c:81de:7fd7:e3eb])
        by smtp2-g21.free.fr (Postfix) with ESMTPS id EC9A52003D0;
        Mon, 14 Nov 2022 19:04:13 +0100 (CET)
Message-ID: <60574e8f-20ff-0996-5558-e9bd35e42681@opteya.com>
Date:   Mon, 14 Nov 2022 19:04:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Yann Droneaud <ydroneaud@opteya.com>
Subject: Re: [PATCH v1 3/5] random: add helpers for random numbers with given
 floor or range
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Theodore Ts'o <tytso@mit.edu>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221022014403.3881893-1-Jason@zx2c4.com>
 <20221022014403.3881893-4-Jason@zx2c4.com>
Content-Language: fr-FR
Organization: OPTEYA
In-Reply-To: <20221022014403.3881893-4-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[resent in text only]

Hi,


Le 22/10/2022 à 03:44, Jason A. Donenfeld a écrit :
> Now that we have get_random_u32_below(), it's trivial to make inline
> helpers to compute get_random_u32_above() and get_random_u32_between(),
> which will help clean up open coded loops and manual computations
> throughout the tree.
>
> Signed-off-by: Jason A. Donenfeld<Jason@zx2c4.com>
> ---
>   include/linux/random.h | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>
> diff --git a/include/linux/random.h b/include/linux/random.h
> index 3a82c0a8bc46..92188a74e50e 100644
> --- a/include/linux/random.h
> +++ b/include/linux/random.h
> @@ -91,6 +91,30 @@ static inline u32 get_random_u32_below(u32 ceil)
>   	}
>   }
>   
> +/*
> + * Returns a random integer in the interval (floor, U32_MAX], with uniform
> + * distribution, suitable for all uses. Fastest when floor is a constant, but
> + * still fast for variable floor as well.
> + */
> +static inline u32 get_random_u32_above(u32 floor)
> +{
> +	BUILD_BUG_ON_MSG(__builtin_constant_p(floor) && floor == U32_MAX,
> +			 "get_random_u32_above() must take floor < U32_MAX");
> +	return floor + 1 + get_random_u32_below(U32_MAX - floor);
> +}
> +
> +/*
> + * Returns a random integer in the interval [floor, ceil), with uniform
> + * distribution, suitable for all uses. Fastest when floor and ceil are
> + * constant, but still fast for variable floor and ceil as well.
> + */
> +static inline u32 get_random_u32_between(u32 floor, u32 ceil)
> +{
> +	BUILD_BUG_ON_MSG(__builtin_constant_p(floor) && __builtin_constant_p(ceil) &&
> +			 floor >= ceil, "get_random_u32_above() must take floor < ceil");
> +	return floor + get_random_u32_below(ceil - floor);
> +}

I have a bad feeling about this one, and can't help but thinking it's going
to bite someone: when asked to pick a number *between* 0 and 10,
I usually think I'm allowed to pick 10 (even if I'm going to answer 7 as it should).

Also, regardinghttps://lore.kernel.org/lkml/20221114164558.1180362-4-Jason@zx2c4.com/
where there's a lot of such changes:

- seqno = get_random_u32_below(data->fc.chain_length) + 1; + seqno = 
get_random_u32_between(1, data->fc.chain_length + 1); IMHO, having the 
function returning a value in range [floor, ceil] would simplify the 
patch: - seqno = get_random_u32_below(data->fc.chain_length) + 1; + 
seqno = get_random_u32_between(1, data->fc.chain_length);

Regards.

-- 
Yann Droneaud
OPTEYA

