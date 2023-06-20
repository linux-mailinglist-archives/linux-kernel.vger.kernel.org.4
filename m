Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A63737493
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjFTSv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFTSv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:51:57 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323E610FB;
        Tue, 20 Jun 2023 11:51:50 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Qlwhz1WbRz9sq3;
        Tue, 20 Jun 2023 20:51:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1687287107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gmtvlt8CaUWNmLspCeUPNIAxC/gKRGbQulSUlu4qCtQ=;
        b=qbSngYdoAF5fECKs3p6b8U9xEr4TS+tZxln0nkzNXVlZ1HISVPUgyvZFAn/R9GWib7ZFyB
        fSqBvudjnuUGzDZqWn3MhSlmHxsU/nwjKmVDl+QMaczd0E77gdbu6aBm3udx8NueBFdosZ
        QrJvlEftZWXTHoGUHbUSkL5E5nlSV3XcbPQCc/3nrU+Fz78ieK0NmUgz+3BWSrVxFab/wl
        ITCYsXyAimFs/oI9Gl6k2X88s42317cY3rZFUXA2WMYj0D7t8ubLA/1vfmP0/44d13qbO/
        pJZP5eTDY3RpvosqQ8XidrGVmqaa6sdWHNDVa+UA2adxaE8FrZKggZOfMPk6Rg==
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
Subject: Re: [PATCH 1/2] clk: sunxi-ng: nkm: consider alternative parent
 rates when finding rate
In-reply-to: <yj6ss64s7p2uaslodj5zklrwhegz54bgh4l4wmldv6cccggepz@yombds4hij3c>
Date:   Tue, 20 Jun 2023 20:51:27 +0200
Message-ID: <87jzvyotlc.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4Qlwhz1WbRz9sq3
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

thank you for your detailed response. I really appreciate it!

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
> gain is in the <1Hz range

Ok, just for the sake of correctness: Actually, I'm concerned with the
fact what happens, if someone "forgets" or doesn't know they have to set
the flag and what happens when calling round rate. Because then in the
end we get 449018180 instead of 449035712. That's more than 1 Hz. But
anyway, I understand your point that a gain of precision of the
approximately 0,004% is not worth the additional code. (Actually, I
don't know how precise the clocks are, but I'd guess it could easily be
lower than 99,996%.)

> (and I've been in sick leave for a while, so
> sorry if I didn't before).

I hope you feel better.

> The rate is in the 100MHz range.
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

Ok, understood.

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

Ok, understood.

>
> You can't figure out all the use-cases we'll require in the future
> anyway.

Well, that much is certain. :)

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

Ok, thank you for all the explanations! I now feel, we have a common
understanding and that's great.

I will proceed with preparing a V3 of this patchset, that will also
introduce CCU_FEATURE_CLOSEST_RATE and an implementation for ccu_nm,
ccu_nkm and the necessary updates on the (combined) mux clocks and
divisor clocks. The flag will be used in pll-video0 of the A64 and all
of its descendents.

That version will also have a separate function
ccu_nkm_find_best_with_parent_adj, so that it's more similar to the
implementation of e.g. ccu_mp.

Thanks,
  Frank

>
> Maxime
>
> [[End of PGP Signed Part]]
