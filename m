Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9BE7138F3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 12:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjE1KKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 06:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjE1KKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 06:10:21 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35CFBB;
        Sun, 28 May 2023 03:10:18 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4QTZCg2x5sz9sbf;
        Sun, 28 May 2023 12:10:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1685268607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ecNLW5aHDmQUNWlbObUxJA9/xvuYkyqh/+NvM+Nhxg=;
        b=zMEdO4IjgGb158eTzzQZZnLzSITWQoQMH1N3+CqXcStzA+XStYm3cHRQjbgVFk4CpmNYm5
        6BY3UfkEQvcLQgTaH7Zp6gbKKOXvCqER8/oYKlt7eTPj39A9e4JEAUtdKK1aS1wKvebmPB
        MQx8WLTbb1TczJMmmUSIgb86mSwHqlQTUbJ1zw1DjsFqggfKP1p9X7Cw9QzJGXkx6Vzr1/
        /JX0jkYrQ/9IqnwFuVn0L0QnTUSK5VkAmYemxVczCLHOlwKnlHFB/gU7owX+b0Q0PAYqeR
        qwYsBUpR5WQ9barq+0iPVgd9inUHdjE1HjSOdMoG6iUWNiy7gR30Xa/m0WDGcA==
References: <20230527132747.83196-1-frank@oltmanns.dev>
 <20230527132747.83196-3-frank@oltmanns.dev>
 <CAGRGNgWP6McbfORNQrrdvktEOVMgS-KCXuhC5GRYz-+SgsFx1w@mail.gmail.com>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Julian Calaby <julian.calaby@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC PATCH 2/3] clk: sunxi-ng: Implement precalculated NKM rate
 selection
Date:   Sun, 28 May 2023 11:12:19 +0200
In-reply-to: <CAGRGNgWP6McbfORNQrrdvktEOVMgS-KCXuhC5GRYz-+SgsFx1w@mail.gmail.com>
Message-ID: <87sfbgwyvp.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4QTZCg2x5sz9sbf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julian,

On 2023-05-28 at 09:19:36 +1000, Julian Calaby <julian.calaby@gmail.com> wr=
ote:
> Hi Frank,
>
> On Sat, May 27, 2023 at 11:37=E2=80=AFPM Frank Oltmanns <frank@oltmanns.d=
ev> wrote:
>>
>> Add a new precalculation method for NKM clock rate selection in the
>> sunxi-ng clock driver. Introduce ccu_nkm_find_best_precalc which uses a
>> precalculated table of valid NKM combinations (struct clk_nkm_table and
>> struct clk_nkm_combo) to find the best rate. This approach provides
>> faster rate selection by searching a table of valid combinations rather
>> than calculating for all possible combinations.
>>
>> The table of NKM combinations needs to be initialized with meaningful
>> combinations only, i.e. removing redundant combinations that result in
>> the same rate.
>>
>> Keep the existing ccu_nkm_find_best function in place and use it as a
>> fallback if no precalculated table is provided.
>>
>> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
>> ---
>>  drivers/clk/sunxi-ng/ccu_nkm.c | 84 +++++++++++++++++++++++++++-------
>>  drivers/clk/sunxi-ng/ccu_nkm.h | 26 +++++++++++
>>  2 files changed, 94 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_n=
km.c
>> index 94d2a83992b2..9652f6df17bd 100644
>> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
>> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
>> @@ -54,6 +54,49 @@ static unsigned long ccu_nkm_find_best(unsigned long =
parent, unsigned long rate,
>>         return best_rate;
>>  }
>>
>> +static unsigned long ccu_nkm_find_best_precalc(unsigned long parent,
>> +                                              unsigned long rate,
>> +                                              struct _ccu_nkm *nkm,
>> +                                              struct clk_nkm_table *tab=
le)
>> +{
>> +       unsigned long best_rate =3D 0, best_diff =3D ULONG_MAX;
>> +       unsigned long best_n =3D 0, best_k =3D 0, best_m =3D 0;
>> +       int start =3D 0, end =3D table->num - 1, mid;
>> +
>> +       while (start <=3D end) {
>> +               unsigned long tmp_rate;
>> +               unsigned long tmp_diff;
>> +
>> +               mid =3D (start + end) / 2;
>> +
>> +               tmp_rate =3D parent * table->combos[mid].n * table->comb=
os[mid].k /
>> +                          table->combos[mid].m;
>> +
>> +               tmp_diff =3D abs(rate - tmp_rate);
>> +
>> +               if (tmp_diff < best_diff) {
>> +                       best_rate =3D tmp_rate;
>> +                       best_diff =3D tmp_diff;
>> +                       best_n =3D table->combos[mid].n;
>> +                       best_k =3D table->combos[mid].k;
>> +                       best_m =3D table->combos[mid].m;
>> +                       if (best_diff =3D=3D 0)
>> +                               goto out;
>> +               }
>

Thank you for your feedback!

In my proposal, the code performs a binary search by
 1. taking the element in the middle (mid)
 2. calculating the rate of the element (tmp_rate)
 3. calculating the difference to the requested rate (tmp_diff)
 4. if the diff is better than the best_diff making it the new best
    n-k-m-combo (the if block)

> If the table was sorted by n * k / m, this could just be a process of

Please note, the table already has to be sorted for the function to
work, as is the nature of a binary search. I should definitely add
comments. I'm sorry, the code was intended more as a basis to discuss
the general idea that I described in the cover letter. I should have
made that clearer.

> searching through until we either:
> - find that the first rate in the table is too high

I could see that I could add two steps in the beginning, before the loop:
 - Take the first element and see if its rate is greater than the
   requested rate, if so immediatly return it
 - Take the last element and see if its rate is less than the requested
   rate, if so immediatly return it

Is that what you mean? I'd have to run some simulations to see, if this
is a real improvement, because we would need two additional rate
calculations. Worst case would therefore be 2+log(n) calculations
instead of log(n) and the code would be slightly more complicated in my
opinion. But if we run this function with all possible parents rate (as
suggested in the end of my cover letter) these two special cases could
very well be often applicable. Thanks!

> - find an exact rate

What do you mean by "exact rate"? Do you mean a rate that matches the
requested rate exactly. This is what the code is already trying to do.
But, as this is not always possible, in cases where it does not find an
exact match, it takes the closest match instead.

> - go above the requested rate, then there's only two to compare: our
> current rate and the previous one

Sorry, you've lost me here. How would I go above the requested rate? You
would have to do the binary search to find that rate, but then why not
search the closest rate directly (as the code does) instead of searching
the closest rate above the requested (as you proposed). I feel like
either one of us is missing something. :)

> This should massively simplify this function and would still work with
> a binary search.

Sidenote, we could store best_index instead of best_n, best_k, best_m,
but for the first iteration I tried to keep it as close as possible to
the original ccu_nkm_find_best() function.

>
>> +               if (rate < tmp_rate)
>> +                       end =3D mid - 1;
>> +               else
>> +                       start =3D mid + 1;
>> +       }
>> +
>> +out:
>> +       nkm->n =3D best_n;
>> +       nkm->k =3D best_k;
>> +       nkm->m =3D best_m;
>> +
>> +       return best_rate;
>> +}
>> +
>>  static void ccu_nkm_disable(struct clk_hw *hw)
>>  {
>>         struct ccu_nkm *nkm =3D hw_to_ccu_nkm(hw);
>> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.h b/drivers/clk/sunxi-ng/ccu_n=
km.h
>> index 6601defb3f38..fa5551724921 100644
>> --- a/drivers/clk/sunxi-ng/ccu_nkm.h
>> +++ b/drivers/clk/sunxi-ng/ccu_nkm.h
>> @@ -12,6 +12,30 @@
>>  #include "ccu_div.h"
>>  #include "ccu_mult.h"
>>
>> +struct clk_nkm_combo {
>> +       u8      n;
>> +       u8      k;
>> +       u8      m;
>> +};
>> +
>> +/**
>> + * struct clk_nkm_table - Table of all meaningful combinations for n, k=
, and m
>> + *
>> + * @num: Number of entries in the table
>> + * @combos: Array of combos (of size num) that are supported by this cl=
ock.
>> + *
>> + * This table shall contain all meaningful combinations of n, k, and m.=
 That
>> + * means that combinations that result in the same clock rate shall onl=
y be
>> + * listed once. For example, if both
>> + * { .n =3D 1, .k =3D 2, .m =3D 2} and  { .n =3D 2, .k =3D 2, .m =3D 4}
>> + * are valid values for n, k, and m, only one of them would be allowed =
because
>> + * both result in a factor of 1.0.
>> + */
>> +struct clk_nkm_table {
>> +       size_t                  num;
>> +       struct clk_nkm_combo    *combos;
>
> Should this be a "flex" array, i.e.
>
> struct clk_nkm_combo combos[]

Thanks, noted. I'll look into that once we have an agreement on the
general concept. I think it depends on the fact if we want to use values
that have been calculated off-line (i.e. prior to compilation) or if we
want to create the table at run-time (i.e. when needed) using kmalloc.
See my alternate proposals in the cover letter for details. I'll need to
check if the run-time approach works with "flex" arrays.

Thanks,
  Frank

>
>> +};
>> +
>>  /*
>>   * struct ccu_nkm - Definition of an N-K-M clock
>>   *
>
> Thanks,
