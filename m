Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907D2713B1C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 19:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjE1R0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 13:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjE1R0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 13:26:21 -0400
X-Greylist: delayed 100683 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 28 May 2023 10:26:19 PDT
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AC1B1;
        Sun, 28 May 2023 10:26:19 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4QTltq5jctz9sZJ;
        Sun, 28 May 2023 19:26:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1685294771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANj+Sn4qSAMQRyLYAP3nENDTtacjr1EZwvPAnMBhYsY=;
        b=Ybw4hf/mHfr+Jm/7JyfCMeoI0OVOU1gMo9Gtj8jSay5HVfWNrOYCEk1w19KP2AzZTFE2k+
        PXsWQTD5xr+BvfKtT7L9Mx3y5Jl2gQVdwjjBjFLq8iNUfjlSAc7Wiqaj/eWh2trG+tHAFG
        hARVYBIpjhbyBfzOJnB3UhLCxO+Zghwz7LSizikgdOo1/bvVuTl1kQuNTxXNWAOh6tNjvB
        PhWExZy/fnLsxVjiddhef7GHCGsOMJBMTLTxUWuqZXY2b3q8+lEYl12QBVbzLbXRCcA/g9
        SL0rLWU0GOJCqAsAfT6s6jvHKQjwJtVFlQ3KWGAO7XeX861V+4lf6ZARaT1yZw==
References: <20230527132747.83196-1-frank@oltmanns.dev>
 <20230527132747.83196-3-frank@oltmanns.dev>
 <CAGRGNgWP6McbfORNQrrdvktEOVMgS-KCXuhC5GRYz-+SgsFx1w@mail.gmail.com>
 <87sfbgwyvp.fsf@oltmanns.dev>
 <CAGRGNgW8tTyDksyQszkvavpQk3JGNscgoQsA8oV5xUmsuBbxUw@mail.gmail.com>
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
Date:   Sun, 28 May 2023 19:12:05 +0200
In-reply-to: <CAGRGNgW8tTyDksyQszkvavpQk3JGNscgoQsA8oV5xUmsuBbxUw@mail.gmail.com>
Message-ID: <87h6rwcqqk.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4QTltq5jctz9sZJ
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

On 2023-05-29 at 01:32:02 +1000, Julian Calaby <julian.calaby@gmail.com> wr=
ote:
> Hi Frank,
>
> On Sun, May 28, 2023 at 8:10=E2=80=AFPM Frank Oltmanns <frank@oltmanns.de=
v> wrote:
>>
>> Hi Julian,
>>
>> On 2023-05-28 at 09:19:36 +1000, Julian Calaby <julian.calaby@gmail.com>=
 wrote:
>> > Hi Frank,
>> >
>> > On Sat, May 27, 2023 at 11:37=E2=80=AFPM Frank Oltmanns <frank@oltmann=
s.dev> wrote:
>> >>
>> >> Add a new precalculation method for NKM clock rate selection in the
>> >> sunxi-ng clock driver. Introduce ccu_nkm_find_best_precalc which uses=
 a
>> >> precalculated table of valid NKM combinations (struct clk_nkm_table a=
nd
>> >> struct clk_nkm_combo) to find the best rate. This approach provides
>> >> faster rate selection by searching a table of valid combinations rath=
er
>> >> than calculating for all possible combinations.
>> >>
>> >> The table of NKM combinations needs to be initialized with meaningful
>> >> combinations only, i.e. removing redundant combinations that result in
>> >> the same rate.
>> >>
>> >> Keep the existing ccu_nkm_find_best function in place and use it as a
>> >> fallback if no precalculated table is provided.
>> >>
>> >> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
>> >> ---
>> >>  drivers/clk/sunxi-ng/ccu_nkm.c | 84 +++++++++++++++++++++++++++-----=
--
>> >>  drivers/clk/sunxi-ng/ccu_nkm.h | 26 +++++++++++
>> >>  2 files changed, 94 insertions(+), 16 deletions(-)
>> >>
>> >> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/cc=
u_nkm.c
>> >> index 94d2a83992b2..9652f6df17bd 100644
>> >> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
>> >> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
>> >> @@ -54,6 +54,49 @@ static unsigned long ccu_nkm_find_best(unsigned lo=
ng parent, unsigned long rate,
>> >>         return best_rate;
>> >>  }
>> >>
>> >> +static unsigned long ccu_nkm_find_best_precalc(unsigned long parent,
>> >> +                                              unsigned long rate,
>> >> +                                              struct _ccu_nkm *nkm,
>> >> +                                              struct clk_nkm_table *=
table)
>> >> +{
>> >> +       unsigned long best_rate =3D 0, best_diff =3D ULONG_MAX;
>> >> +       unsigned long best_n =3D 0, best_k =3D 0, best_m =3D 0;
>> >> +       int start =3D 0, end =3D table->num - 1, mid;
>> >> +
>> >> +       while (start <=3D end) {
>> >> +               unsigned long tmp_rate;
>> >> +               unsigned long tmp_diff;
>> >> +
>> >> +               mid =3D (start + end) / 2;
>> >> +
>> >> +               tmp_rate =3D parent * table->combos[mid].n * table->c=
ombos[mid].k /
>> >> +                          table->combos[mid].m;
>> >> +
>> >> +               tmp_diff =3D abs(rate - tmp_rate);
>> >> +
>> >> +               if (tmp_diff < best_diff) {
>> >> +                       best_rate =3D tmp_rate;
>> >> +                       best_diff =3D tmp_diff;
>> >> +                       best_n =3D table->combos[mid].n;
>> >> +                       best_k =3D table->combos[mid].k;
>> >> +                       best_m =3D table->combos[mid].m;
>> >> +                       if (best_diff =3D=3D 0)
>> >> +                               goto out;
>> >> +               }
>> >
>>
>> Thank you for your feedback!
>>
>> In my proposal, the code performs a binary search by
>>  1. taking the element in the middle (mid)
>>  2. calculating the rate of the element (tmp_rate)
>>  3. calculating the difference to the requested rate (tmp_diff)
>>  4. if the diff is better than the best_diff making it the new best
>>     n-k-m-combo (the if block)
>
> I'm so sorry, I thought that this was still doing a linear search as
> it's so close to the original code.
>
>>
>> > If the table was sorted by n * k / m, this could just be a process of
>>
>> Please note, the table already has to be sorted for the function to
>> work, as is the nature of a binary search. I should definitely add
>> comments. I'm sorry, the code was intended more as a basis to discuss
>> the general idea that I described in the cover letter. I should have
>> made that clearer.
>>
>> > searching through until we either:
>> > - find that the first rate in the table is too high
>>
>> I could see that I could add two steps in the beginning, before the loop:
>>  - Take the first element and see if its rate is greater than the
>>    requested rate, if so immediatly return it
>>  - Take the last element and see if its rate is less than the requested
>>    rate, if so immediatly return it
>>
>> Is that what you mean? I'd have to run some simulations to see, if this
>> is a real improvement, because we would need two additional rate
>> calculations. Worst case would therefore be 2+log(n) calculations
>> instead of log(n) and the code would be slightly more complicated in my
>> opinion. But if we run this function with all possible parents rate (as
>> suggested in the end of my cover letter) these two special cases could
>> very well be often applicable. Thanks!
>>
>> > - find an exact rate
>>
>> What do you mean by "exact rate"? Do you mean a rate that matches the
>> requested rate exactly. This is what the code is already trying to do.
>> But, as this is not always possible, in cases where it does not find an
>> exact match, it takes the closest match instead.
>>
>> > - go above the requested rate, then there's only two to compare: our
>> > current rate and the previous one
>>
>> Sorry, you've lost me here. How would I go above the requested rate? You
>> would have to do the binary search to find that rate, but then why not
>> search the closest rate directly (as the code does) instead of searching
>> the closest rate above the requested (as you proposed). I feel like
>> either one of us is missing something. :)
>
> What we're missing is that I'm not explaining this well.
>
> Let's take a very simple table: (value =3D parent * n * k / m)
>
> 0. 100
> 1. 200
> 2. 300
> 3. 400
>
> If we search for 50, our closest is the first rate, so index 0: this
> is the "find that the first rate in the table is too high" case.
>
> If we search for 300, we'll converge on index 2: this is the "exact
> rate" situation.
>
> If we search for 275, then we'll converge on either 200 or 300: this
> is the "two to compare" situation: if we converge until we get to the
> lowest rate above our target, we only need to check the rate
> immediately before it in the table and the one we converged on to find
> the closest.
>
> So in pseudo-code, we'd end up with something like this:
>
> --------
>
> start =3D 0;
>
> cur_rate =3D parent * table[start].n * table[start].k / table[start].m;
>
> if (cur_rate >=3D target)
>     return table[start];
>
> while (start <=3D end) {
>     mid =3D (start + end) / 2;

Thanks for the thorough explanation!

This needs to be (start + end + 1) / 2

Otherwise, if we extend your hypothetical list above with another item,
let's say 500 and look for 199, this would result in the loop finishing
with mid =3D 0, if I'm not mistaken, and hence an access to table[-1] when
calculating prev_rate below. Not good.

But I *think*, with (start + end + 1) / 2 it works in all cases.

>
>     cur_rate =3D parent * table[mid].n * table[mid].k / table[mid].m;
>
>     if (cur_rate =3D=3D target)
>         return table[mid];
>
>    if (target < cur_rate)
>        end =3D mid - 1;
>    else
>        start =3D mid + 1;
> }
>
> prev_rate =3D parent * table[mid - 1].n * table[mid - 1].k / table[mid - =
1].m;
>
> if (abs(target - prev_rate) < abs(target - cur_rate))
>     return table[mid - 1];
>
> return table[mid];
>
> --------
>
> Which seems simpler to my eye and moves all the difference
> calculations out of the loop so they only have to be done once,
> effectively trading a difference calculation on each checked rate for
> a rate calculation, and dropping some variables in the process.

At least it's shorter. I'm not sure it's simpler (after all it contained
a mistake, I think ;-)). Still, it looks neat, so I might still use your
(revised) algorithm.

Thanks,
  Frank
>
> Thanks,
