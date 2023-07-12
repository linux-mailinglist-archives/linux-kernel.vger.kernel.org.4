Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9EA74FE5B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 06:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjGLEk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 00:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjGLEkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 00:40:22 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71D9E4D;
        Tue, 11 Jul 2023 21:40:18 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4R14mF3hVrz9spD;
        Wed, 12 Jul 2023 06:40:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1689136813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wPfPXLQb0FPa6/TYdfelbJjMFzx6O8tQOlNnIGRmMF4=;
        b=gVkHTO/MT8uczKC+/HuDNuW21dWWhziaMbhWruHjtPVAyMjo7pRb6CA+f5TlqzVNVRQllJ
        QaBAAyQnOXQ/yDkNuxKw0e4p/4jumDz36wx5JNsH0i//ce3NjbqMOblgGxbU/fBvcdIVBC
        6UiRxLQ4XMQjr1DXo+Tl2PkTRZp2yvTs7iJkrgTiP/GhG2Si1G3RGMJWULLsVAx1azB6bs
        loWBiwx/UMzM02hd3CSCxV8h1PgdnPL5BkKI0pbTsv+wpqvQ3bi3a5cyFmT7q1SvtxvfWS
        PsEklZkoFh2QzHOGHTIvmEfinFREp0WstUPYggcIA/lu5pLgiA2uZUUheTQqDA==
References: <20230605190745.366882-1-frank@oltmanns.dev>
 <20230605190745.366882-2-frank@oltmanns.dev>
 <2bvcukogzhcdbfsrruylgw5fbezaqjpcojqaambfoiv5fc2upy@ffumn5sevbeb>
 <875y7y1f0d.fsf@oltmanns.dev>
 <sijbhopoxuw5wodyry3smg7tm4wzoc7k6xakt4qdvxqsok32mv@u7rh4dct5ya6>
 <87a5x41w5r.fsf@oltmanns.dev>
 <unoskbtcteluxj7g3xkwc7ngcmglvcbm5ah25m7huhqxwd4dj3@nmfxbedwyu54>
 <87bkhbhnol.fsf@oltmanns.dev>
 <yj6ss64s7p2uaslodj5zklrwhegz54bgh4l4wmldv6cccggepz@yombds4hij3c>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Roman Beranek <me@crly.cz>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/2] clk: sunxi-ng: nkm: consider alternative parent
 rates when finding rate
In-reply-to: <yj6ss64s7p2uaslodj5zklrwhegz54bgh4l4wmldv6cccggepz@yombds4hij3c>
Date:   Wed, 12 Jul 2023 06:39:56 +0200
Message-ID: <87pm4xg2ub.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
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

On 2023-06-19 at 20:05:44 +0200, Maxime Ripard <maxime@cerno.tech> wrote:
> [[PGP Signed Part:Undecided]]
> On Mon, Jun 19, 2023 at 10:16:26AM +0200, Frank Oltmanns wrote:
>> Hi Maxime,
>>
>> the essence of my following ramblings:
>>  - I do think it is reasonable that nkm is asking its parent for the
>>    rate that nkm actually needs from said parent to fulfill the request.
>>  - I don't think nkm should make assumptions about the rounding
>>    behaviour of the parent.
>
> I guess we agree :)
>
> And I would go even further and say that we shouldn't make *any*
> assumption about the behaviour of the parent.
>
>> The reason is, that I want to prevent users of ccu_nkm from making
>> mistakes when defining their clocks (which includes the parent of their
>> nkm clock).
>>
>> Please read below the details on why I think that.
>>
>> [...]
>>
>> >> No. I didn't. My assumption is: If ccu_nkm_find_best is asked for the
>> >> best rate for rate = 449035712, it should try to include 449035712 in
>> >> its candidates, agreed?
>> >>
>> >> Example 1:
>> >> ==========
>> >> rate=449035712, n=11, k=3, m=16:
>> >> We should as for a parent rate of 217714285, because:
>> >> 217714285 * 11 * 3 / 16 = 449035712
>> >>
>> >> How do we get from 449035712 to 217714285, you ask?
>> >>
>> >>       DIV_ROUND_UP(rate * m, n * k)
>> >
>> > Why are we rounding up? I don't think the hardware will round up there.
>>
>> Being a "software guy" it is also my understanding that the hardware
>> does not round up here (or round down for that matter).
>
> That's my understanding as well.
>
>> But anyway, my concern is the rate's representation *in software*. The
>> clk drivers are using unsigned long to represent the actual rate. This
>> is not a lossless representation. In other words, the value (i.e. the
>> software representation) of that rate is, of course, a "lie". The
>> hardware clock is running at some rate that is hopefully close to what
>> we represent in software, but still it's an abstraction.
>>
>> For example, the user (e.g. in my example a panel) asks us for a rate
>> that is represented in softwares as 449035712. Given the values n=11,
>> k=3, m=16, we can *only* represent this value in software if the parent
>> gives us a rate that is represented in software as 217714285. Therefore,
>> I think it is reasonable to ask the parent for that rate (217714285).
>
> I somewhat agree, but I still don't think it's worth rounding up.
>
> If we don't round up (and assuming the parent itself won't round the
> clock), we end up with a rate of 449035710 using the dividers you
> mentioned. It's a .0000005% deviation (I hope I didn't screw up the
> number of 0s). It's negligible for all practical purposes, and it's not
> worth making the code inconsistent and eyebrow raising.
>
>> >> Do you agree that we should ask the parent for 217714285 in case we want
>> >> a rate of 449035712 and we're currently evaluating the case n=11, k=3,
>> >> m=16?
>> >>
>> >> We should not ask for a parent rate of 217714284, because:
>> >> 217714284 * 11 * 3 / 16 = 449035710
>> >>
>> >> Example 2:
>> >> ==========
>> >> rate=500000000, n=11, k=3, m=16:
>> >> Here we should not ask the parent for
>> >>       DIV_ROUND_UP(rate * m, n * k)
>> >> because that would be 242424243.
>> >>
>> >> 242424243 * 11 * 3 / 16 = 500000001
>> >>
>> >> We (the NKM clock, not the parent!) would overshoot (please see at the
>> >> end of this mail, why (for now) I don't want to support overshooting in
>> >> the NKM clock).
>> >>
>> >> Instead we should as for a parent rate of 242424242, because:
>> >> 242424242 * 11 * 3 / 16 = 499999999
>> >>
>> >> In conclusion, there are cases, where we (the NKM clock) have to ask the
>> >> parent for
>> >>       DIV_ROUND_UP(rate * m, n * k)
>> >> And there are also cases, where we have to ask the parent for
>> >>       rate * m / (n * k)
>> >
>> > I mean, I think you're overthinking this.
>> >
>> > If you never round up and mimic how the hardware behaves, and test all
>> > combination, then eventually you'll find the closest rate.
>> >
>> > If you don't because the parent doesn't look for the closest rate, then
>> > the parent should be changed too.
>> >
>> > It really is that simple.
>> >
>> >> This is what the code is trying to do. Maybe it's easier to look at V2
>> >> because I extracted the calcultion of the optimal parent rate into a
>> >> separate function hoping that this makes things clearer.
>> >>
>> >> Let me stress this: When calculating the optimal rate for the parent,
>> >> I'm not making any assumptions here about how the PARENT clock rounds.
>> >> In fact, I assume that the parent could be perfect and always provides
>> >> the rate it is asked for. I only take into account how the nkm clock
>> >> rounds.
>> >
>> > At the very least, you assume that the parent rounding can be "wrong"
>> > and try to work around that.
>>
>> No. I'm not assuming anything about the parent. But I *know* that if we
>> (nkm) want to get a rate that is represented in softwares as 449035712
>> and given the values n=11, k=3, m=16, we (nkm) must get the rate from
>> the parent that the parent represents in software as 217714285, because
>> I know that we (nkm) calculate *our* (nkm) rate using
>>     parent * n * k / m
>>
>> So if (!) we want to give the user the rate that they ask for, why not
>> ask the parent for the rate that we need (217714285)?
>>
>> I admit that I'm making assumptions here. My assumptions are that we
>>  a. want to at least try to give the user what they asked for
>>  b. without making assumptions about the parent's behaviour.
>>
>> Those assumptions could of course be wrong, but, honestly, I would find
>> that confusing.
>
> I guess my point leans more towards the "social" side than the
> mathematical one. If I followed you so far, the precision you expect to
> gain is in the <1Hz range (and I've been in sick leave for a while, so
> sorry if I didn't before). The rate is in the 100MHz range.
>
> So the precision gain is pretty much nothing. Sure, it's closer from a
> mathematical standpoint. But there's zero benefit from it.
>
> However, it comes at the cost of a code that is definitely more
> complicated (or less naive, depending on how you look at it I guess :))
> and will be harder to figure out for someone that jumps into the driver.
>
> So the trade-off doesn't really make fixing it worth it to me.
>
>> >> > you ask the parent to compute whatever is closest to that optimal parent
>> >> > rate.
>> >> >
>> >> > It's the parent responsibility now. It's the parent decision to figure
>> >> > out what "the closest" means, if it can change rate, if it has any range
>> >> > limitation, etc. You can't work around that.
>> >> >
>> >> > What you actually want there is the parent to actually provide the
>> >> > closest rate, even if it means overshooting.
>> >> >
>> >>
>> >> I want to ask the parent for a rate, that would actually result in the
>> >> rate that nkm_find_best was asked for. Are you asking me to instead ask
>> >> the parent for a rate that doesn't fit that criterion?
>> >
>> > No. I'm asking to call clk_hw_round_rate(parent_hw, rate * m / (n * k))
>> > and use whatever value it returned.
>> >
>> > If it requires changing the parent clock to improve its round_rate
>> > behaviour, then do that too.
>> >
>>
>> Hmmm... Okay. So you *are* saying, that I should make changes to the
>> parent so that we do not need to request the exact rate we want from the
>> parent. But I really don't understand why.
>
> No, sorry. I initially thought that you were working around "divider"
> rounding issue (as opposed to integer like you mentionned above) with
> the parent not providing its optimal rate, and you adjusting based on
> that offset.
>
>> As I wrote above, I'm not making any assumptions of how and if the
>> parent rounds. My code is rounding *prior* to asking the parent. Your
>> proposal on the other hand *requires* changing the parent to round
>> closest where mine does not.
>>
>> My concern is, that we could then end up with the situation that someone
>> defines an nkm clock in their SoC which has CLK_SET_RATE_PARENT set, but
>> does not set the ROUND_CLOSEST flag on the parent, because it's not
>> immediately apparent why they should do that.
>
> It's going to happen, and probably happens at the moment already,
> because not only the NKM clocks are affected, but virtually all of them,
> and most don't use ROUND_CLOSEST.
>
> And to some extent, it's fine. We would handle it like any other bug: if
> we ever encounter one, we'll write a fix, backport it to stable and all
> will be fine.
>
> You can't figure out all the use-cases we'll require in the future
> anyway.
>
>> Let's assume that hypothetical board were the A64, the nkm clock were pll-mipi,
>> and the parent were pll-video0 and we "forget" to set ROUND_CLOSEST on
>> pll-video0:
>>
>> When pll-mipi nkm clock is asked via determine_rate() for a rate of
>> 449064000 it would return 449035712 and a parent rate of 217714285
>> (using n=11, k=3, m=16, but those details aren't returned by
>> determine_rate()).
>>
>> Eventually, determine_rate() will be called again, but this time for a
>> rate of 449035712. The user already knows that we can provide that,
>> because we told them (see previous paragraph). But since we're
>> truncating when calculating the rate that we'd like the parent to
>> provide, we end up asking the parent for 217714284 when we actually need
>> it to provide 217714285. So we now *require* the parent to find the
>> closest and additionally we must *hope* that the parent is incapable of
>> providing the rate that we asked for.
>
> I mean... yeah. It's what abstraction is all about. For all we know, the
> parent to pll-mipi could be a crystal that can't change its frequency
> and we should deal with that. Or it could be an ideal clock that always
> returns the rate you ask for. Or a firmware clock that behaves like an
> ideal clock but lies about it :)
>
> It's that clock responsibility to do its best to provide the rate we ask
> for.
>
> And if we need to make it behave better, then it's fine too. So your
> example is indeed true, but it's more of a case of "let's send another
> patch" rather than trying to figure out all possible cases and try to
> figure things out accordingly. Because you won't be able to figure out
> all possible cases for the current SoCs and the next ones, and the
> workloads that people are going to run on those SoCs anyway.
>
>> >> If you carefully look at ccu_mp, you will see that it would ignore
>> >> cases when its parent had rounded up. ccu_nkm is no different.
>> >> Teaching all of sunxi-ng's clocks to respect ROUND_CLOSEST is a
>> >> totally different beast. For now, sunxi-ng always expects rounding
>> >> down.
>> >
>> > Then change that?
>>
>> You told me that both over- and undershooting are fine when
>> determining the rate, *but also* "it's a bit context specific which one
>> we should favour. If we were to do anything, it would be to support both
>> and let the clock driver select which behaviour it wants." (see
>> https://lore.kernel.org/all/flngzi4henkzcpzwdexencdkw77h52g3nduup7pwctpwfiuznk@eewnnut5mvsq/)
>>
>> So, I can't just change NKM's parent's default behavior (which is an NM
>> clock in my case), because, if I understand correctly, I would have to
>> introduce a "ROUND_CLOSEST" flag for NM clocks.
>
> Sure
>
>> But then I feel like I would have to document somewhere that when
>> setting CLK_SET_RATE_PARENT for an NKM clock, that the parent clock
>> needs to ROUND_CLOSEST, in order to avoid drifting away from the
>> requested rate in the successive calls that are made to
>> ccu_nkm_determine_rate(), which I tried to explain above and in previous
>> messages.
>
> That's kind of what I meant too. Whether "drifting away" is an issue is
> context specific too. for some clocks it just doesn't matter. Nobody
> ever complained that the register clock of the MMC controller was
> drifting away, because it doesn't affect the system in the slightest.
>
> The video clock tree (and possibly others) will be affected though, and
> we'll indeed need to add that flag. But we're doing it all the time (and
> sometimes get it wrong) for things like which clocks should be left
> enabled for example.

I'm afraid we have to re-visit this decision. I found a case, where the
drifting causes a problem.

Setting pll-mipi's SET_PARENT_RATE flag, but not setting the tree's
CCU_FEATURE_CLOSEST_RATE flag results in the following tree:

    clock                     rate
    -----------------------------------
    pll-video0                201000000
       hdmi-phy-clk            50250000
       hdmi                   201000000
       tcon1                  201000000
       pll-mipi               414562500
          tcon0               414562500
             tcon-data-clock  138187500

Note, that tcon-data-clock's rate is garbage. It should be tcon0/4, but
it is tcon0/3.

I added some logging to ccu_find_best*() to understand, as to why that
is:

    ccu_nkm_find_best_with_parent_adj: rate=414600000, best_rate=414577776, best_parent_rate=282666666, n=11, k=2, m=15
    ccu_nkm_find_best_with_parent_adj: rate=414600000, best_rate=414577776, best_parent_rate=282666666, n=11, k=2, m=15
    ccu_nkm_find_best_with_parent_adj: rate=414577776, best_rate=414562500, best_parent_rate=201000000, n=11, k=3, m=16
    ccu_nkm_find_best_with_parent_adj: rate=414562500, best_rate=414562500, best_parent_rate=201000000, n=11, k=3, m=16
    ccu_nkm_find_best: rate=414562500, best_rate=414562500, parent_rate=201000000, n=11, k=3, m=16

We can see that the rate is drifting over the successive calls. We've
seen it before and deemed it no big deal.

To highlight the issue a bit more, I added some logging at the end of
sun4i_dclk_round_rate() and sun4i_dclk_set_rate.

    ccu_nkm_find_best_with_parent_adj: rate=414600000, best_rate=414577776, best_parent_rate=282666666, n=11, k=2, m=15
    sun4i_dclk_round_rate: rate=103650000, best_rate=103644444, best_parent=414577776, best_div=4
    ccu_nkm_find_best_with_parent_adj: rate=414600000, best_rate=414577776, best_parent_rate=282666666, n=11, k=2, m=15
    sun4i_dclk_round_rate: rate=103650000, best_rate=103644444, best_parent=414577776, best_div=4

Here we can see that sun4i_dclk now has determined that 103644444 is its
best rate, based on the parent rate of 414577776.

But now, the nkm clock pll-mipi changes its mind and thinks that it
cannot provide 414577776 any more, instead it wants to provide
414562500. Unfortunately, the dclk is never informed about this
new rate...

    ccu_nkm_find_best_with_parent_adj: rate=414577776, best_rate=414562500, best_parent_rate=201000000, n=11, k=3, m=16
    ccu_nkm_find_best_with_parent_adj: rate=414562500, best_rate=414562500, best_parent_rate=201000000, n=11, k=3, m=16
    ccu_nkm_find_best: rate=414562500, best_rate=414562500, parent_rate=201000000, n=11, k=3, m=16
    sun4i_dclk_set_rate: rate=103644444, parent=414562500, div=3

... so, when setting the rate, the dclk still thinks it should set to
103644444, but with a parent of 414562500 instead of 414577776 this
results in a divisor of 3 instead of 4.

The worst part is: Even though you and me discussed in length about how
the nkm's parent must support rounding to the closest rate, I still
didn't realize that this was the reason that tcon-data-clock was so far
from it's target rate. Luckily, I knew where to add my debug statements,
because I knew what I changed. I would expect someone else, who wasn't
involved in this, to waste hours on finding "their" mistake (I really
think it's *our* mistake).

I guess, what I'm trying to say here is: I *really*, *really* think that
setting an nkm clock's SET_PARENT_RATE flag should not depend on the
parent to have CCU_FEATURE_CLOSEST_RATE set. Instead we should use the
function optimal_parent_rate() that I proposed below - or something with
the same effect.

Best regards,
  Frank

>
>> Instead we could introduce the following function, like I suggested in
>> V2 of this patchset. The advantage is that it both *documents* the
>> dilemma for developers of ccu_nkm and also *avoids* it for users of
>> ccu_nkm.
>>
>> static unsigned long optimal_parent_rate(unsigned long rate, unsigned long n,
>> 				 unsigned long k, unsigned long m)
>> {
>> 	unsigned long _rate, parent;
>>
>> 	// We must first try to find the desired parent rate that is rounded up, because there are
>> 	// cases where truncating makes us miss the requested rate.
>> 	// E.g. rate=449035712, n=11, k=3, m=16
>> 	// When truncating, we'd get parent=217714284 and calculating the rate from that would give
>> 	// us 449035710. When rounding up, we get parent=217714285 which would give us the requested
>> 	// rate of 449035712.
>> 	parent = DIV_ROUND_UP(rate * m, n * k);
>>
>> 	// But there are other cases, where rounding up the parent gives us a too high rate.
>> 	// Therefore, we need to check for this case and, if necessary, truncate the parent rate
>> 	// instead of rounding up.
>> 	_rate = parent * n * k / m;
>> 	if (_rate > rate)
>> 		parent = rate * m / (n * k);
>> 	return parent;
>> }
>>
>> And then we ask the parent for that optimal parent rate we just
>> calculated. I feel like that's an easy thing to do.
>
> We're back to the trade-off I was mentioning earlier. I'm not against it
> on principle. However, if it's not absolutely required, then I don't
> think it's a good idea to merge it.
>
> Especially if it's to workaround a parent flag missing. A clock flag
> patch is easy to read, write, understand, review, merge and maintain.
> It's basically a nop to merge provided the commit log is decent enough.
>
> That function is none of those things.
>
> Maxime
>
> [[End of PGP Signed Part]]
