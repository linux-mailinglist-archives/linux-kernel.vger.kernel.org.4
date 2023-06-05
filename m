Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA567224C1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjFELiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjFELh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:37:58 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30844103;
        Mon,  5 Jun 2023 04:37:50 -0700 (PDT)
Received: from smtp1.mailbox.org (unknown [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4QZWn74RF8z9sTZ;
        Mon,  5 Jun 2023 13:37:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1685965067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jcHhH/zRv8wNAE/JoAKaMzjUE+cSexIZRjod8l3CvqE=;
        b=H8SpsXdl1fhnJ0o98TPnJD1bZ8bfi/iEvsxQherlcJMQBXZKIKBzE29Tmmrt1pU3L/NdEI
        nmKtqewOeBlUqOnAY6GYeWyrWcCEtRyI78Ycom7ZJx7L6/af8YBtKFRpRwgTnDnq0X4os7
        tjQr069Z6WYlt/RoU8A07XNHaaB3tYCV5/+Rf8lSOU9FfzwuqzmB2ecbWbY6YkUaG4s8Vm
        FtCCMZVMR55K2NiDAirrDzOyu4mF76ndIQq8Ai17iwLXuVsBVpFRRZRPKidpY/UlM1QiJ/
        ftVQlYbsvFU5BAqxz0M1yCJw0SoUXEkBOO+lPS1TDrvtoNb1lgZGunUAYIGT2g==
References: <20230527132747.83196-1-frank@oltmanns.dev>
 <flngzi4henkzcpzwdexencdkw77h52g3nduup7pwctpwfiuznk@eewnnut5mvsq>
 <87mt1jbf18.fsf@oltmanns.dev>
 <uvjlkaq4drqsndpwwflmbfnxseiftkrhq5qqmpfx5vfmduazed@wcohoxcd23wc>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC PATCH 0/3] clk: sunxi-ng: Optimize rate selection for NKM
 clocks
Date:   Mon, 05 Jun 2023 12:31:41 +0200
In-reply-to: <uvjlkaq4drqsndpwwflmbfnxseiftkrhq5qqmpfx5vfmduazed@wcohoxcd23wc>
Message-ID: <87edmq9m2m.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On 2023-06-02 at 09:31:59 +0200, Maxime Ripard <mripard@kernel.org> wrote:
> [[PGP Signed Part:Undecided]]
> Hi,
>
> On Thu, Jun 01, 2023 at 07:16:45AM +0200, Frank Oltmanns wrote:
>> On 2023-05-31 at 15:48:43 +0200, Maxime Ripard <mripard@kernel.org> wrote:
>> > [[PGP Signed Part:Undecided]]
>> > Hi Frank,
>> >
>> > On Sat, May 27, 2023 at 03:27:44PM +0200, Frank Oltmanns wrote:
>> >> I would like to bring your attention to the current process of setting
>> >> the rate of an NKM clock. As it stands, when setting the rate of an
>> >> NKM clock, the rate nearest but less than or equal to the requested
>> >> rate is found, instead of the nearest rate.
>> >
>> > Yeah, it's actually pretty common, see clk_mux_determine_rate_flags()
>> > for example. Some devices require that we don't overshoot, while some
>> > prefer to have the closest rate.
>> >
>> > Both are fine, and it's a bit context specific which one we should
>> > favour. If we were to do anything, it would be to support both and let
>> > the clock driver select which behaviour it wants.
>> >
>>
>> Ok, understood. Thank you for the explanation! Now, I'm wondering if
>> anyone would be using such a flag, if I added it.
>
> I guess that's another thing :) If no-one is going to use it, why should
> we do it in the first place?
>
> But most likely the display and audio clocks are usually fairly ok with
> overshooting a bit, and a closest rate is usually better.

Ok, I dived a bit deeper into this, but, as far as I can tell, the
closest rate is not used anywhere in the sunxi-ng ccu driver. So, when
extending, e.g., the NM or NKM clock to support, one must also extend at
least the mux clocks, because they expect rates less than the requested
rate. That seems to be quite the undertaking for only a small gain in
precision.

>> >> Moreover, ccu_nkm_find_best() is called multiple times (footnote [1])
>> >> when setting a rate, each time iterating over all combinations of n,
>> >> k, and m.
>> >
>> > Yeah, that's expected as well.
>>
>> I'm wondering though, if iterating over all combinations is set in
>> stone, or if some kind of optimization would be in order.
>
> The thing with optimization is that you need to optimize for something.
> So you need to show that this code is suboptimal (by whatever metric you
> want to optimize for), and that your code is more optimal that it used
> to be.
>
> It means identifying a problem, writing benchmarks, and showing that the
> new code performs better there.
>
> For example, your code might very well be faster, but it will increase
> the kernel image (and thus the RAM usage). One is not more optimal than
> the other in absolute, they both are, using a different metric.

Sure, I get that. I'll submit a patchset that adds the functionality to
NKM clocks to set the rate of their parents.

With the new patchset, the time for, e.g. setting DCLK increases from
~0.5 ms to a whopping 30 - 37 ms. Those times were taken
unscientifically on my pinephone, i.e. kernel logging and a couple of
re-boots. But I think that still might give an idea of why I thought
about the need to increase performance.

The reason for this massive increase is, that the patch iterates over
all combinations of NKM for pll-mipi, and for each combination it
iterates over all combinations of NM for pll-video0.

Nevertheless, following your and Jernej's advice, I'll submit the
patchset first and then we can discuss if speed optimizations are needed
and what cost is acceptable.

> And then you have the more social factors that play a huge part too:
> readibility, maintainability, etc.
>
>> >> In response to this, I propose the following refinements to optimize the NKM
>> >> clock setting:
>> >>  a. when finding the best rate use the nearest rate, even if it is greater than
>> >>     the requested rate (PATCH 1)
>> >>  b. utilize binary search to find the best rate by going through a
>> >>     precalculated, ordered list of all meaningful combinations of n, k, and m
>> >>     (PATCH 2)
>> >
>> > One thing you haven't really addressed is why we would be doing this? Is
>> > there some clocks that require a more precise clock and don't? Is the
>> > factor calculation a bottleneck for some workloads?
>>
>> Background
>> ==========
>> I'm a pinephone user (ccu-sun50i-a64). I'm using U-Boot which sets the
>> pll-video0 to 294 MHz on boot. The phone's panel requires DCLK to run at
>> 108 MHz to get a nice 60 Hz vertical refresh rate. The clock structure
>> is this:
>>
>>     clock                       clock type
>>     --------------------------------------
>>     pll-video0                  ccu_nm
>>        pll-mipi                 ccu_nkm
>>           tcon0                 ccu_mux
>>              tcon-data-clock    sun4i_dclk
>>
>> The divider between tcon0 and tcon-data-clock is fixed at 4. So, I need
>> pll-mipi to run at 432 MHz to get the desired vertical refresh rate.
>> When pll-vdeo0 is at 294 MHz this is that rate cannot be matched exactly
>> with any combination. The best we can get is 431.2 MHz (n=11, k=2,
>> m=15).
>>
>> The pinephone has some "vendor" patches (megi kernel) that
>>  a. add HDMI
>>  b. allow re-setting pll-mipi's rate when pll-video0 changes
>>
>> Re: Who needs a more precise clock?
>> ===================================
>> When plugging in HDMI, pll-video's rate is set to 297 MHz, which - in
>> the vendor kernel, not mainline - triggers recalculation of pll-mipi
>> (trying to set it to 431.2 MHz). It ends up with a rate of 424.285714
>> MHz, because this is the nearest, but less than 431.2 MHz (n=5, k=2,
>> m=7). The nearest rate would be 432 MHz.
>>
>> So, while analyzing the whole situation that I described above, I found
>> out that the NKM clocks are not set to the closest rate and wondered why
>> that is. Hence my request for comments.
>
> It all makes sense, but I'm not sure why it requires a complete rewrite
> of the factor calculation algo?

You are absolutely right! It does not! Here, I was talking about the
reasons why a more precise clock might be desirable (PATCH 1), which
touches very few lines.

I tried to explain the reasons for the algo change further below in the
"Re: Why speed up factor calculation?" part of my mail that was cut off
in your response.

>
>> Now, one could argue that pll-video0 should be set to 297MHz at boot
>
> Not really no, we should strive to be as immune as possible from the
> boot state.

Agreed.

>> or that pll-mipi should try to set the *requested* rate instead of the
>> previous rate when the pll-video0 changes.
>
> It's not clear to me what is the distinction you make here between the
> requested rate and the previous rate?

This is quite a de-tour from the original discussion, so I'm sorry for
the confusion.

By requested rate I mean the rate that the user (DCLK) requested. But
this is not necessarily the rate that the clock is using in the end,
because of its parent's rate.

So, when the pll-video0 changes rate from 294 MHz to 297MHz (upon
plugging in HDMI), pll-mipi does not know any longer what the requested
rate (let's say 432MHz) was. It only knows the rate it had before the
rate change of pll-video0 (431.2MHz in that case). Now with the new
parent rate, it tries to find a new rate that's close to (but less than)
431.2 MHz instead of 432 MHz. And since with the new clock rate of 297
MHz for pll-video0, it cannot set to 431.2 MHz, so it rounds down again
(to 424.285714 MHz). That means it rounded down twice and is now quite
far from the originally requested 432 MHz.

So, whenever the parent rate changes, we always round down and move
further away from the rate that the user originally requested for our
clock. This could be mitigated by storing the requested rate (i.e. 432
MHz instead of 431.2 MHz). However, I don't know if that's possible. I'm
simply stating my observations. No call for action is implied in that
statement.

> Do you mean that you have two clk_set_rate in sequence, with the first
> one on pll-mipi (or one of its child clocks), and the second one on
> pll-video0 (but on a different sub-tree than pll-mipi) and thus pll-mipi
> has its rate changed by the second, but doesn't match the previous rate
> enforced?
>
> If so, that's kind of expected: clk_set_rate doesn't provide any
> warranty on for how long the rate is going to stay there. There's two
> way to prevent that. Either we call clk_set_rate_exclusive (on the
> first) instead, but it will effectively lock a clock subtree and prevent
> any rate change which is a pretty big constraint.

This is actually the current constraint in mainline. sun40i_tcon locks
pll-video0's tree.

> Or you add a notifier
> to adjust to the parent clock rate change and still provide the same
> output rate, with a different set of parameters.

This is what the "vendor" kernel (megi kernel) tries to do. It patches
the locking away and uses a notifier to react to pll-video0's rate
changes. With the caveat that it does not save the requested rate, which
I tried to explain above.

Anyhow, thank you for this detailed discussion! I really appreciate it!
Let me send my new patchset and see what everyone thinks.

Thanks,
  Frank

>
> Maxime
>
> [[End of PGP Signed Part]]
