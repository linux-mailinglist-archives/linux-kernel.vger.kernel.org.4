Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205DC724E50
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 22:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbjFFUvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 16:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbjFFUvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 16:51:51 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC8C10DE;
        Tue,  6 Jun 2023 13:51:47 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4QbN1r1d2hz9sSV;
        Tue,  6 Jun 2023 22:51:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1686084704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LQ1VExHjUHPg8qjJw8lNmVscRJc2LmnWsKi2h9s6YQY=;
        b=e6tZNYMkN1hFNmeQpyDcoOkKAXzrGL/e/2fpntfHPxIh4/BLJ0+vAG4w1nlmBtGMHTF4V3
        yUEk4p2yuyhERLxtOFsrP2777zWy2mKxjoB65tbEMnwO88OAsNrXGfD2EkiV9WPJTlzkyA
        qQAu7WLfSKdjWqMy3lhw4LF6uXIOG7ZmS0msXixZB/u2JL2wv9bxYCLsMCQdrP23gXet/G
        g8EnpQ5jFo4UX2P1YMODBatH8yVKUEDVW63KM6QdBFLMNcQfM4XoUnvhnKXrM3TFWrHzBe
        iTaCGLMFaCxDethm+PrMrko7L5mA/O7Lzc6ejHMT/bHpobM1ARVq023Ii0UbYQ==
References: <20230527132747.83196-1-frank@oltmanns.dev>
 <flngzi4henkzcpzwdexencdkw77h52g3nduup7pwctpwfiuznk@eewnnut5mvsq>
 <87mt1jbf18.fsf@oltmanns.dev>
 <uvjlkaq4drqsndpwwflmbfnxseiftkrhq5qqmpfx5vfmduazed@wcohoxcd23wc>
 <87edmq9m2m.fsf@oltmanns.dev>
 <xcgmqvdoip53yao4sfoznnppauhmsmdablwoewh43zjv3bhidp@d7pxqohxydve>
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
Date:   Tue, 06 Jun 2023 22:40:34 +0200
In-reply-to: <xcgmqvdoip53yao4sfoznnppauhmsmdablwoewh43zjv3bhidp@d7pxqohxydve>
Message-ID: <87sfb41fhl.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4QbN1r1d2hz9sSV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On 2023-06-06 at 16:02:58 +0200, Maxime Ripard <mripard@kernel.org> wrote:
> [[PGP Signed Part:Undecided]]
> On Mon, Jun 05, 2023 at 12:31:41PM +0200, Frank Oltmanns wrote:
>> Hi Maxime,
>>
>> On 2023-06-02 at 09:31:59 +0200, Maxime Ripard <mripard@kernel.org> wrote:
>> > [[PGP Signed Part:Undecided]]
>> > Hi,
>> >
>> > On Thu, Jun 01, 2023 at 07:16:45AM +0200, Frank Oltmanns wrote:
>> >> On 2023-05-31 at 15:48:43 +0200, Maxime Ripard <mripard@kernel.org> wrote:
>> >> > [[PGP Signed Part:Undecided]]
>> >> > Hi Frank,
>> >> >
>> >> > On Sat, May 27, 2023 at 03:27:44PM +0200, Frank Oltmanns wrote:
>> >> >> I would like to bring your attention to the current process of setting
>> >> >> the rate of an NKM clock. As it stands, when setting the rate of an
>> >> >> NKM clock, the rate nearest but less than or equal to the requested
>> >> >> rate is found, instead of the nearest rate.
>> >> >
>> >> > Yeah, it's actually pretty common, see clk_mux_determine_rate_flags()
>> >> > for example. Some devices require that we don't overshoot, while some
>> >> > prefer to have the closest rate.
>> >> >
>> >> > Both are fine, and it's a bit context specific which one we should
>> >> > favour. If we were to do anything, it would be to support both and let
>> >> > the clock driver select which behaviour it wants.
>> >> >
>> >>
>> >> Ok, understood. Thank you for the explanation! Now, I'm wondering if
>> >> anyone would be using such a flag, if I added it.
>> >
>> > I guess that's another thing :) If no-one is going to use it, why should
>> > we do it in the first place?
>> >
>> > But most likely the display and audio clocks are usually fairly ok with
>> > overshooting a bit, and a closest rate is usually better.
>>
>> Ok, I dived a bit deeper into this, but, as far as I can tell, the
>> closest rate is not used anywhere in the sunxi-ng ccu driver. So, when
>> extending, e.g., the NM or NKM clock to support, one must also extend at
>> least the mux clocks, because they expect rates less than the requested
>> rate. That seems to be quite the undertaking for only a small gain in
>> precision.
>
> mux clocks are using __clk_mux_determine_rate which should have the
> behaviour you want when CLK_MUX_ROUND_CLOSEST is set.

https://elixir.bootlin.com/linux/v6.3.6/source/drivers/clk/sunxi-ng/ccu-sun50i-a64.c#L539
is one example of a mux clock combined with a divider that is a bit more
complex. I didn't look too deeply, but it seemed to me, that it would
require two separate flags: One for the mux component and one for the
div component. Maybe I'm mistaken, but it seems to me that the concept
of having selected rates always be equal to or less than requested
rates, seems to be deeply ingrained in the sunxi-ng driver. I'm afraid
that I might miss some parts, therefore I abandoned that idea for now
(especially since I have only one board for testing).

>> >> >> Moreover, ccu_nkm_find_best() is called multiple times (footnote [1])
>> >> >> when setting a rate, each time iterating over all combinations of n,
>> >> >> k, and m.
>> >> >
>> >> > Yeah, that's expected as well.
>> >>
>> >> I'm wondering though, if iterating over all combinations is set in
>> >> stone, or if some kind of optimization would be in order.
>> >
>> > The thing with optimization is that you need to optimize for something.
>> > So you need to show that this code is suboptimal (by whatever metric you
>> > want to optimize for), and that your code is more optimal that it used
>> > to be.
>> >
>> > It means identifying a problem, writing benchmarks, and showing that the
>> > new code performs better there.
>> >
>> > For example, your code might very well be faster, but it will increase
>> > the kernel image (and thus the RAM usage). One is not more optimal than
>> > the other in absolute, they both are, using a different metric.
>>
>> Sure, I get that. I'll submit a patchset that adds the functionality to
>> NKM clocks to set the rate of their parents.
>>
>> With the new patchset, the time for, e.g. setting DCLK increases from
>> ~0.5 ms to a whopping 30 - 37 ms. Those times were taken
>> unscientifically on my pinephone, i.e. kernel logging and a couple of
>> re-boots. But I think that still might give an idea of why I thought
>> about the need to increase performance.
>>
>> The reason for this massive increase is, that the patch iterates over
>> all combinations of NKM for pll-mipi, and for each combination it
>> iterates over all combinations of NM for pll-video0.
>>
>> Nevertheless, following your and Jernej's advice, I'll submit the
>> patchset first and then we can discuss if speed optimizations are needed
>> and what cost is acceptable.
>
> Honestly, for 40ms, it will be a hard sell :)

I'm not sure what part you think is the "hard-sell":
 a. the patch itself because 30 to 40 ms is way too much
 b. the optimization, because 30 to 40 ms isn't all that much.
I honestly don't know.

BTW, this is the patchset in case you missed it:
https://lore.kernel.org/lkml/20230605190745.366882-1-frank@oltmanns.dev/

Note, that I have a patch in the works, which is similar to the one in
this thread, but for ccu_nm. Doing a binary search for finding the
parent rate of pll-mipi, i.e., pll-video0, reduces the time from ~30 ms
to less than 2 ms. If combined with only iterating through meaningful
nkm combinations for pll-mipi, this should bring the time under 1 ms
again.

>
>> >> or that pll-mipi should try to set the *requested* rate instead of the
>> >> previous rate when the pll-video0 changes.
>> >
>> > It's not clear to me what is the distinction you make here between the
>> > requested rate and the previous rate?
>>
>> This is quite a de-tour from the original discussion, so I'm sorry for
>> the confusion.
>>
>> By requested rate I mean the rate that the user (DCLK) requested. But
>> this is not necessarily the rate that the clock is using in the end,
>> because of its parent's rate.
>>
>> So, when the pll-video0 changes rate from 294 MHz to 297MHz (upon
>> plugging in HDMI), pll-mipi does not know any longer what the requested
>> rate (let's say 432MHz) was.
>
> It does, it's struct clk_core's req_rate. It doesn't look like it's
> available to clk_hw users, but given the rest of your explanation, I
> guess you have a compelling use case to make it available.

Oh, thank you for making me aware of that! I'll surely look into it.

Thanks,
  Frank

>
> Maxime
>
> [[End of PGP Signed Part]]
