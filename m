Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7A7731D68
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjFOQFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjFOQFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:05:42 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F3130F2;
        Thu, 15 Jun 2023 09:05:08 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4QhnDp0PwZz9skw;
        Thu, 15 Jun 2023 18:04:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1686845098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aC88dsjwoSfwnwVGDU7JYpF5AgySUHYNoar1O8TxeOk=;
        b=vXRQyeiRbKjGK4w/jCqequdEYj7ujhd0yWghYZ/qpobnURY4LIBcntA47ZkCkus/VBZTGf
        JUWnHf8kPRTyz61jwv7vZkmPlDHfPhFzm54W/jh3zMTFqK74cVmHLhHXBjE+TAsTjlq/m0
        LLiugb++bC872ZSlibQ4D3Es/rkF3LU+yC2mI6jn1GQ8Rtcq/DvalMvcTmTIbTGzwfcvm+
        gmRnS1hYG4y31eXXX74YvQbaz7QHBXUClpIIsvh5lwtSArOKiH6Qb2epCimJ4XPlYQNYda
        UAdwBHkpNW8hosS0UTI5LrCrUhzCaq82XKDy+5+2S4wBUAVjIEUmfqY4wi161w==
Date:   Thu, 15 Jun 2023 18:04:53 +0200 (GMT+02:00)
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Roman Beranek <me@crly.cz>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Message-ID: <d40e94c4-9dab-4511-bd48-1d9081f4262a@oltmanns.dev>
In-Reply-To: <wnxjbbjfcnrg7ogwkfwbnldvyqbpt23b6mnrieb2zffooaojts@sudsbfjbjt64>
References: <20230605190745.366882-1-frank@oltmanns.dev> <20230605190745.366882-2-frank@oltmanns.dev> <2bvcukogzhcdbfsrruylgw5fbezaqjpcojqaambfoiv5fc2upy@ffumn5sevbeb> <875y7y1f0d.fsf@oltmanns.dev> <sijbhopoxuw5wodyry3smg7tm4wzoc7k6xakt4qdvxqsok32mv@u7rh4dct5ya6> <87a5x41w5r.fsf@oltmanns.dev> <unoskbtcteluxj7g3xkwc7ngcmglvcbm5ah25m7huhqxwd4dj3@nmfxbedwyu54> <87wn07zmxp.fsf@oltmanns.dev> <wnxjbbjfcnrg7ogwkfwbnldvyqbpt23b6mnrieb2zffooaojts@sudsbfjbjt64>
Subject: Re: [PATCH 1/2] clk: sunxi-ng: nkm: consider alternative parent
 rates when finding rate
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <d40e94c4-9dab-4511-bd48-1d9081f4262a@oltmanns.dev>
X-Rspamd-Queue-Id: 4QhnDp0PwZz9skw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


15.06.2023 16:47:33 Maxime Ripard <maxime@cerno.tech>:

> On Tue, Jun 13, 2023 at 12:17:06PM +0200, Frank Oltmanns wrote:
>> Hi Maxime,
>>
>> I'll now only respond to one aspect of your mail, because it's the
>> foundation for the whole behaviour.
>>
>> On 2023-06-13 at 11:10:08 +0200, Maxime Ripard <maxime@cerno.tech> wrote=
:
>> [...]
>>>>>> =E2=80=A6
>>>>>
>>>>> It doesn't really matter though. The output of that function must be
>>>>> stable and must return the same set of factors and parent rate for a
>>>>> given target rate.
>>>>>
>>>>
>>>> I'm not sure if we're talking about the same thing here. Of course the
>>>> set of factors and parent rate for a given target rate will be differe=
nt
>>>> depending on the fact if we can or cannot adjust the parent rate,
>>>> agreed?
>>>
>>> Yes, but here you also have a different behaviour in clk_round_rate()
>>> and in clk_set_rate(), which isn't ok.
>>>
>>> Basically, clk_set_rate() + clk_get_rate() must be equal to
>>> clk_round_rate().
>>>
>>> If you change if you look for parents depending on whether you're being
>>> called in clk_round_rate() and clk_set_rate(), then you're breaking tha=
t
>>> expectation.
>>>
>>>> Let me compare my implementation to ccu_mp.
>>>>
>>>> ccu_mp_round_rate either calls the function ccu_mp_find_best or
>>>> ccu_mp_find_best_with_parent_adj, depending on CLK_SET_RATE_PARENT.
>>>
>>> Yes, and it's fine: the flag is per-clock, and the output is the same
>>> depending on whether we're being called by clk_round_rate() and
>>> clk_set_rate().
>>>
>>
>> The output is really not the same.
>>
>> ccu_mp_set_rate() always calls ccu_mp_find_best(). It never (!) consider=
s
>> changing the parent, independent of any flags.
>>
>> ccu_mp_round_rate() is calling ccu_mp_find_best() OR
>> ccu_mp_find_best_with_parent_adj() depending on the flag.
>>
>> If I understand you correctly, you consider that a bug.
>
> No, sorry, you're right.
>
> clk_set_rate will call round_rate first, which will (possibly) pick up a
> new parent, and by the time set_rate is called our parent will have been
> changed already so we will just call find_best again considering only
> that parent.

Ok, no worries. That was my understanding, so your previous statement shatt=
ered my worldview. ;) That's why I may have seemed a bit alarmed.

>
> The set of factors and dividers should remain the same there, but I
> don't think that's a concern.

Ack. The output is stable when called with the same rate.

> That leaves us with the rounding stuff, and the overall function
> arguments. I like the structure of ccu_mp better, is there a reason to
> deviate from it?

I'm still pondering the rounding stuff. I'm just not sure why you are so re=
laxed about the fact that when calling round_rate with 449064000 we get 449=
035712, but when we call get round_rate with 449035712 we get 449018181, an=
d when we call round_rate with 449018181, we get 449018180.

But ultimately, you have the final word, of course. But I need some time to=
 be sure, that this does not become a problem in some cases.

Regarding the arguments, I can adopt ccu_mp's style. The only reason was to=
 avoid code duplication, no other reason.

Thanks,
=C2=A0 Frank

> > Maxime

