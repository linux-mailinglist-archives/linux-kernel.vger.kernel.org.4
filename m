Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00998734D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjFSIQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjFSIQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:16:42 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C15791;
        Mon, 19 Jun 2023 01:16:39 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Ql2fW2XSMz9sSV;
        Mon, 19 Jun 2023 10:16:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1687162595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aaIMsxmE6FtMMQFljYc5ebI9ZJdcQuqJvK1xaj3y+bE=;
        b=pGJYnJ0EuoYUVJQ+RCChbJlS47bRjk9R2/2LrSiX9Idy6oCFsyEDnJQawYVme5/5bStAYw
        T2FueK7swbXX88No8CEj2FTwU+C/+VzJ/ff/h+1Ls080gRDzBnFr4odcO/RrLhd0AkVZ52
        nf+0/dOPjYKcj61RJ85qYv8tGIn4vqmft0JLnnyjnXhclaAdBGM4GDhK+BC9OqzqUMrEzG
        zSUtp1bNungE40/YDvdfGSLf8mZJRl3YAYmN+9dKYt8yc98DCmbAJiToRMFqso4IdQvUJP
        4FNwKZP4OcEhLWEYObR6zdo44NLg5oA6EtvpxZo1MAArpuYrHVbtxIgNk/CDsw==
References: <20230605190745.366882-1-frank@oltmanns.dev>
 <20230605190745.366882-2-frank@oltmanns.dev>
 <2bvcukogzhcdbfsrruylgw5fbezaqjpcojqaambfoiv5fc2upy@ffumn5sevbeb>
 <875y7y1f0d.fsf@oltmanns.dev>
 <sijbhopoxuw5wodyry3smg7tm4wzoc7k6xakt4qdvxqsok32mv@u7rh4dct5ya6>
 <87a5x41w5r.fsf@oltmanns.dev>
 <unoskbtcteluxj7g3xkwc7ngcmglvcbm5ah25m7huhqxwd4dj3@nmfxbedwyu54>
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
In-reply-to: <unoskbtcteluxj7g3xkwc7ngcmglvcbm5ah25m7huhqxwd4dj3@nmfxbedwyu54>
Date:   Mon, 19 Jun 2023 10:16:26 +0200
Message-ID: <87bkhbhnol.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4Ql2fW2XSMz9sSV
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

the essence of my following ramblings:
 - I do think it is reasonable that nkm is asking its parent for the
   rate that nkm actually needs from said parent to fulfill the request.
 - I don't think nkm should make assumptions about the rounding
   behaviour of the parent.

The reason is, that I want to prevent users of ccu_nkm from making
mistakes when defining their clocks (which includes the parent of their
nkm clock).

Please read below the details on why I think that.

On 2023-06-13 at 11:10:08 +0200, Maxime Ripard <maxime@cerno.tech> wrote:
> [[PGP Signed Part:Undecided]]
> Hi,
>
> On Mon, Jun 12, 2023 at 06:29:36PM +0200, Frank Oltmanns wrote:
>> Hi Maxime,
>>
>> I'm sorry that the following mail is a bit long. I'm not sure, there is
>> some kind of misunderstanding/miscommunication somewhere, I'm just not
>> sure, where. :)
>>
>> This mail is aiming at finding the exact points where we apparently go
>> down different paths.
>>
>> On 2023-06-12 at 14:19:05 +0200, Maxime Ripard <maxime@cerno.tech> wrote:
>> > [[PGP Signed Part:Undecided]]
>> > On Wed, Jun 07, 2023 at 09:39:35AM +0200, Frank Oltmanns wrote:
>> >> Hi Maxime,
>> >>
>> >> On 2023-06-07 at 08:38:39 +0200, Maxime Ripard <maxime@cerno.tech> wrote:
>> >> > [[PGP Signed Part:Undecided]]
>> >> > On Mon, Jun 05, 2023 at 09:07:44PM +0200, Frank Oltmanns wrote:
>> >> >> In case the CLK_SET_RATE_PARENT flag is set, consider using a different
>> >> >> parent rate when determining a new rate.
>> >> >>
>> >> >> To find the best match for the requested rate, perform the following
>> >> >> steps for each NKM combination:
>> >> >>  - calculate the optimal parent rate,
>> >> >>  - find the best parent rate that the parent clock actually supports
>> >> >>  - use that parent rate to calculate the effective rate.
>> >> >>
>> >> >> In case the clk does not support setting the parent rate, use the same
>> >> >> algorithm as before.
>> >> >>
>> >> >> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
>> >> >> ---
>> >> >>  drivers/clk/sunxi-ng/ccu_nkm.c | 40 ++++++++++++++++++++++++++--------
>> >> >>  1 file changed, 31 insertions(+), 9 deletions(-)
>> >> >>
>> >> >> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
>> >> >> index a0978a50edae..c71e237226f2 100644
>> >> >> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
>> >> >> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
>> >> >> @@ -16,10 +16,10 @@ struct _ccu_nkm {
>> >> >>  	unsigned long	m, min_m, max_m;
>> >> >>  };
>> >> >>
>> >> >> -static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
>> >> >> -				       struct _ccu_nkm *nkm)
>> >> >> +static unsigned long ccu_nkm_find_best(unsigned long *parent, unsigned long rate,
>> >> >> +				       struct _ccu_nkm *nkm, struct clk_hw *parent_hw)
>> >> >>  {
>> >> >> -	unsigned long best_rate = 0;
>> >> >> +	unsigned long best_rate = 0, best_parent_rate = 0, tmp_parent = *parent;
>> >> >>  	unsigned long best_n = 0, best_k = 0, best_m = 0;
>> >> >>  	unsigned long _n, _k, _m;
>> >> >>
>> >> >> @@ -28,12 +28,29 @@ static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
>> >> >>  			for (_m = nkm->min_m; _m <= nkm->max_m; _m++) {
>> >> >>  				unsigned long tmp_rate;
>> >> >>
>> >> >> -				tmp_rate = parent * _n * _k / _m;
>> >> >> +				if (parent_hw) {
>> >> >
>> >> > NKM clocks always have a parent
>> >> >
>> >> > You should test if the CLK_SET_RATE_PARENT flag is set.
>> >>
>> >> ccu_nkm_find_best is called in the following two situations:
>> >>  a. from ccu_nkm_set_rate when setting the rate
>> >>  b. from ccu_nkm_round_rate when determining the rate
>> >>
>> >> In situation a. we never want ccu_nkm_find_best to try different parent
>> >> rates because setting the parent rate is a done deal (at least that's my
>> >> understanding).
>> >>
>> >> In situation b. we only want ccu_nkm_find_best to try different parent
>> >> rates when, as you mentioned, the CLK_SET_RATE_PARENT flag is set.
>> >
>> > It doesn't really matter though. The output of that function must be
>> > stable and must return the same set of factors and parent rate for a
>> > given target rate.
>> >
>>
>> I'm not sure if we're talking about the same thing here. Of course the
>> set of factors and parent rate for a given target rate will be different
>> depending on the fact if we can or cannot adjust the parent rate,
>> agreed?
>
> Yes, but here you also have a different behaviour in clk_round_rate()
> and in clk_set_rate(), which isn't ok.
>
> Basically, clk_set_rate() + clk_get_rate() must be equal to
> clk_round_rate().
>
> If you change if you look for parents depending on whether you're being
> called in clk_round_rate() and clk_set_rate(), then you're breaking that
> expectation.
>
>> Let me compare my implementation to ccu_mp.
>>
>> ccu_mp_round_rate either calls the function ccu_mp_find_best or
>> ccu_mp_find_best_with_parent_adj, depending on CLK_SET_RATE_PARENT.
>
> Yes, and it's fine: the flag is per-clock, and the output is the same
> depending on whether we're being called by clk_round_rate() and
> clk_set_rate().
>
>> I'm basically doing the same thing, but (!) ccu_nkm_find_best and
>> ccu_nkm_find_best_with_parent_adj would be almost identical. Therefore,
>> I opted to extend ccu_nkm_find_best to also support the parent
>> adjustment. If you look at V2 of this patch, you will see that the only
>> diffences are an if statement (if (parent_hw)) with two lines of code in
>> the if's body and the fact that we need to store the best parent rate.
>>
>> If you prefer, I can split this into two separate functions like in
>> ccu_mp. I think all the confusion is coming from the fact that I didn't.
>> So apparently it was not a good idea to keep it as one function.
>>
>> Should I introduce ccu_nkm_find_best_with_parent_adj instead of using
>> ccu_nkm_find_best for both cases?
>>
>> >
>> > So you can call it as many times as you want, it doesn't really matter.
>>
>> Of course! What did I write that made you think, I thought otherwise?
>>
>> >
>> >> So, what this patch does, it provides a NULL pointer as parent_hw when
>> >> we don't want ccu_nkm_find_best to try alternative parent rates.
>> >
>> > At best, the argument is misleading then. You're not passing a pointer
>> > to the parent, you're telling it whether it should look for other
>> > parents or not. And it's not a pointer, it's a boolean.
>>
>> No, I'm using parent_hw and as a pointer a few lines below when calling
>> clk_hw_round_rate. So I'd need a boolean AND a pointer. I always need
>> the pointer if the boolean is true. I never need the pointer when the
>> boolean is false. Therefore, I opted to choose to use the pointer for
>> first being a boolean (in the if) and then being a pointer (when calling
>> clk_hw_round_rate). This is the (hopefully easier to read) code from V2:
>>
>>         if (parent_hw) {
>>                 tmp_parent = optimal_parent_rate(rate, _n, _k, _m);
>>                 tmp_parent = clk_hw_round_rate(parent_hw, tmp_parent);
>>         }
>
> Again, that clock always has a parent. It's not the actual condition:
> what you want to test is whether you want to forward the rate request to
> the parent or not. So that condition is misleading.
>
>> >> Is it ok if I add a comment to ccu_nkm_find_best that explains the
>> >> function and explicitly also the parameters?
>> >
>> > Sure
>>
>> Done in V2.
>>
>> >
>> >> I also thought about using two different functions for the two
>> >> situations. I have no strong opinion which is better.
>> >>
>> >> However, I don't think we should hand over the flags to this function,
>> >> because we'd still only need to provide the parent_hw if we want to
>> >> find the optimal parent rate, so having two parametes for the same
>> >> purpose seems redundant. Unless, there is a rule to not use NULL
>> >> pointers.
>> >
>> > Again, the behaviour must be stable across all calling sites.
>>
>> No argument here.
>>
>> >
>> >> >
>> >> >> +					// We must round up the desired parent rate, because the
>> >> >> +					// rounding down happens when calculating tmp_rate. If we
>> >> >> +					// round down also here, we'd round down twice.
>> >> >> +					unsigned long optimal_parent =
>> >> >> +							(rate * _m + (_n * _k - 1)) / _n / _k;
>> >> >
>> >> > I assume the addition of n * k - 1 is to round up, but I'm not sure we
>> >> > should hack around like that.
>> >> >
>> >> > You should compute the ideal parent rate for a given set of timings, and
>> >> > then just call round_rate on it. If the parent wants to round it one way
>> >> > or another, that's the parent concern.
>> >>
>> >> I admit that the comment explaining this is not doing the complexity of
>> >> this issue any justice. Let me try to explain:
>> >>
>> >> Let's say for our panel the optimal rate for pll-mipi is 449064000. The
>> >> best closest we can get is 449035712 with a parent rate of 217714285
>> >> (n=11, k=3, m=16).
>> >>
>> >> Eventually, ccu_nkm_find_best is going to be called with 449035712 as
>> >> the rate. If we don't round up, like I proposend, but instead calculate:
>> >>   optimal_parent = rate * m / n / k
>> >> (which is, I think, what you you're proposing) leading to an optimal
>> >> parent of 217714284 (!). We can't get 217714284 from the parent (we
>> >> could get 217714285, but we're not asking for that) so the parent rounds
>> >> down.
>> >>
>> >> To make things worse, this story continues for the new "best rate" as
>> >> well.
>> >>
>> >> In the end, ccu_nkm_find_best claims:
>> >>  - the optimal rate for 449064000 is 449035712 (parent=217714285, n=11,
>> >>    k=3, m=16)
>> >>  - but ccu_nkm_find_best would claim that the optimal rate for 449035712
>> >>    is 449018181 (parent=235200000, n=7, k=3, m=11)
>> >>  - and finally, the optimal rate for 449018181 is 449018180
>> >>    (parent=213818181, n=7, k=3, m=10)
>> >>
>> >> This doesn't seem right to me.
>> >>
>> >> But you're also right, in that we can't just always round up. In a
>> >> hypothetical example that we request a parent rate of 450000000. With
>> >> rounding up, we'd get an optimal parent rate of 218181819 for n=11, k=3,
>> >> m=16. And let's now further claim that the parent could provide exactly
>> >> that rate, we'd end up with a rate of 450000001. So, we'd overshoot,
>> >> which (currently) is not acceptable.
>> >>
>> >> Hmm... I currently can't think of a clever way to solve this other than
>> >> this:
>> >>
>> >>     optimal_parent = (rate * _m + (_n * _k - 1)) / _n / _k;
>> >>     tmp_parent = clk_hw_round_rate(parent_hw, optimal_parent);
>> >>     tmp_rate = tmp_parent * _n * _k / _m;
>> >>     if (tmp_rate > rate) {
>> >>         optimal_parent = rate * m / n / k
>> >>         tmp_parent = clk_hw_round_rate(parent_hw, optimal_parent);
>> >>         tmp_rate = tmp_parent * _n * _k / _m;
>> >>     }
>> >>     if (tmp_parent > optimal_parent)
>> >>         continue;
>> >>
>> >> This seems ugly, but at least it should work in all cases. Any opinions?
>> >
>> > Again, you shouldn't work around the issue.
>> >
>> > It's very simple really: you already computed the optimal parent rate,
>>
>> No. I didn't. My assumption is: If ccu_nkm_find_best is asked for the
>> best rate for rate = 449035712, it should try to include 449035712 in
>> its candidates, agreed?
>>
>> Example 1:
>> ==========
>> rate=449035712, n=11, k=3, m=16:
>> We should as for a parent rate of 217714285, because:
>> 217714285 * 11 * 3 / 16 = 449035712
>>
>> How do we get from 449035712 to 217714285, you ask?
>>
>>       DIV_ROUND_UP(rate * m, n * k)
>
> Why are we rounding up? I don't think the hardware will round up there.

Being a "software guy" it is also my understanding that the hardware
does not round up here (or round down for that matter).

But anyway, my concern is the rate's representation *in software*. The
clk drivers are using unsigned long to represent the actual rate. This
is not a lossless representation. In other words, the value (i.e. the
software representation) of that rate is, of course, a "lie". The
hardware clock is running at some rate that is hopefully close to what
we represent in software, but still it's an abstraction.

For example, the user (e.g. in my example a panel) asks us for a rate
that is represented in softwares as 449035712. Given the values n=11,
k=3, m=16, we can *only* represent this value in software if the parent
gives us a rate that is represented in software as 217714285. Therefore,
I think it is reasonable to ask the parent for that rate (217714285).

>
>> Do you agree that we should ask the parent for 217714285 in case we want
>> a rate of 449035712 and we're currently evaluating the case n=11, k=3,
>> m=16?
>>
>> We should not ask for a parent rate of 217714284, because:
>> 217714284 * 11 * 3 / 16 = 449035710
>>
>> Example 2:
>> ==========
>> rate=500000000, n=11, k=3, m=16:
>> Here we should not ask the parent for
>>       DIV_ROUND_UP(rate * m, n * k)
>> because that would be 242424243.
>>
>> 242424243 * 11 * 3 / 16 = 500000001
>>
>> We (the NKM clock, not the parent!) would overshoot (please see at the
>> end of this mail, why (for now) I don't want to support overshooting in
>> the NKM clock).
>>
>> Instead we should as for a parent rate of 242424242, because:
>> 242424242 * 11 * 3 / 16 = 499999999
>>
>> In conclusion, there are cases, where we (the NKM clock) have to ask the
>> parent for
>>       DIV_ROUND_UP(rate * m, n * k)
>> And there are also cases, where we have to ask the parent for
>>       rate * m / (n * k)
>
> I mean, I think you're overthinking this.
>
> If you never round up and mimic how the hardware behaves, and test all
> combination, then eventually you'll find the closest rate.
>
> If you don't because the parent doesn't look for the closest rate, then
> the parent should be changed too.
>
> It really is that simple.
>
>> This is what the code is trying to do. Maybe it's easier to look at V2
>> because I extracted the calcultion of the optimal parent rate into a
>> separate function hoping that this makes things clearer.
>>
>> Let me stress this: When calculating the optimal rate for the parent,
>> I'm not making any assumptions here about how the PARENT clock rounds.
>> In fact, I assume that the parent could be perfect and always provides
>> the rate it is asked for. I only take into account how the nkm clock
>> rounds.
>
> At the very least, you assume that the parent rounding can be "wrong"
> and try to work around that.

No. I'm not assuming anything about the parent. But I *know* that if we
(nkm) want to get a rate that is represented in softwares as 449035712
and given the values n=11, k=3, m=16, we (nkm) must get the rate from
the parent that the parent represents in software as 217714285, because
I know that we (nkm) calculate *our* (nkm) rate using
    parent * n * k / m

So if (!) we want to give the user the rate that they ask for, why not
ask the parent for the rate that we need (217714285)?

I admit that I'm making assumptions here. My assumptions are that we
 a. want to at least try to give the user what they asked for
 b. without making assumptions about the parent's behaviour.

Those assumptions could of course be wrong, but, honestly, I would find
that confusing.

>
>> > you ask the parent to compute whatever is closest to that optimal parent
>> > rate.
>> >
>> > It's the parent responsibility now. It's the parent decision to figure
>> > out what "the closest" means, if it can change rate, if it has any range
>> > limitation, etc. You can't work around that.
>> >
>> > What you actually want there is the parent to actually provide the
>> > closest rate, even if it means overshooting.
>> >
>>
>> I want to ask the parent for a rate, that would actually result in the
>> rate that nkm_find_best was asked for. Are you asking me to instead ask
>> the parent for a rate that doesn't fit that criterion?
>
> No. I'm asking to call clk_hw_round_rate(parent_hw, rate * m / (n * k))
> and use whatever value it returned.
>
> If it requires changing the parent clock to improve its round_rate
> behaviour, then do that too.
>

Hmmm... Okay. So you *are* saying, that I should make changes to the
parent so that we do not need to request the exact rate we want from the
parent. But I really don't understand why.

As I wrote above, I'm not making any assumptions of how and if the
parent rounds. My code is rounding *prior* to asking the parent. Your
proposal on the other hand *requires* changing the parent to round
closest where mine does not.

My concern is, that we could then end up with the situation that someone
defines an nkm clock in their SoC which has CLK_SET_RATE_PARENT set, but
does not set the ROUND_CLOSEST flag on the parent, because it's not
immediately apparent why they should do that.

Let's assume that hypothetical board were the A64, the nkm clock were pll-mipi,
and the parent were pll-video0 and we "forget" to set ROUND_CLOSEST on
pll-video0:

When pll-mipi nkm clock is asked via determine_rate() for a rate of
449064000 it would return 449035712 and a parent rate of 217714285
(using n=11, k=3, m=16, but those details aren't returned by
determine_rate()).

Eventually, determine_rate() will be called again, but this time for a
rate of 449035712. The user already knows that we can provide that,
because we told them (see previous paragraph). But since we're
truncating when calculating the rate that we'd like the parent to
provide, we end up asking the parent for 217714284 when we actually need
it to provide 217714285. So we now *require* the parent to find the
closest and additionally we must *hope* that the parent is incapable of
providing the rate that we asked for.

It's probably a fair hope. And maybe it's a fair requirement. Above you
said "It really is that simple." But in my opinion it's simpler to ask
the parent for the rate that we actually want it to provide, because it
reduces the risk for SoC implementers to introduce undesired behaviour.

>
>> > That's fine, we have a flag
>> > for that: CLK_(MUX|DIVIDER)_ROUND_CLOSEST. We just need to set it on the
>> > parent and be done with it.
>>
>> This is a totally different issue.
>
> Why?
>
>> If you carefully look at ccu_mp, you will see that it would ignore
>> cases when its parent had rounded up. ccu_nkm is no different.
>> Teaching all of sunxi-ng's clocks to respect ROUND_CLOSEST is a
>> totally different beast. For now, sunxi-ng always expects rounding
>> down.
>
> Then change that?

You told me that both over- and undershooting are fine when
determining the rate, *but also* "it's a bit context specific which one
we should favour. If we were to do anything, it would be to support both
and let the clock driver select which behaviour it wants." (see
https://lore.kernel.org/all/flngzi4henkzcpzwdexencdkw77h52g3nduup7pwctpwfiuznk@eewnnut5mvsq/)

So, I can't just change NKM's parent's default behavior (which is an NM
clock in my case), because, if I understand correctly, I would have to
introduce a "ROUND_CLOSEST" flag for NM clocks.

But then I feel like I would have to document somewhere that when
setting CLK_SET_RATE_PARENT for an NKM clock, that the parent clock
needs to ROUND_CLOSEST, in order to avoid drifting away from the
requested rate in the successive calls that are made to
ccu_nkm_determine_rate(), which I tried to explain above and in previous
messages.

Instead we could introduce the following function, like I suggested in
V2 of this patchset. The advantage is that it both *documents* the
dilemma for developers of ccu_nkm and also *avoids* it for users of
ccu_nkm.

static unsigned long optimal_parent_rate(unsigned long rate, unsigned long n,
				 unsigned long k, unsigned long m)
{
	unsigned long _rate, parent;

	// We must first try to find the desired parent rate that is rounded up, because there are
	// cases where truncating makes us miss the requested rate.
	// E.g. rate=449035712, n=11, k=3, m=16
	// When truncating, we'd get parent=217714284 and calculating the rate from that would give
	// us 449035710. When rounding up, we get parent=217714285 which would give us the requested
	// rate of 449035712.
	parent = DIV_ROUND_UP(rate * m, n * k);

	// But there are other cases, where rounding up the parent gives us a too high rate.
	// Therefore, we need to check for this case and, if necessary, truncate the parent rate
	// instead of rounding up.
	_rate = parent * n * k / m;
	if (_rate > rate)
		parent = rate * m / (n * k);
	return parent;
}

And then we ask the parent for that optimal parent rate we just
calculated. I feel like that's an easy thing to do.

Again, I'm sorry for making such a fuss about the whole topic. But I at
least want you to understand my concern.

Which, in essence, is that I do think that asking the parent for the
software represantation of the rate that we actually need is reasonable
and we should not make assumption about the rounding behaviour of the
parent. This is just to avoid future mistakes that users of ccu_nkm
could otherwise run into. That is my only concern.

Please let me know what you think.

Thank you for your patience,
  Frank

>
> It doesn't look that bad to be honest, it's basically change the rate
> comparison check by something like mux_is_better_rate() or
> _is_best_div(). As far as I'm concerned, you can even do that only for
> NKM and MP clocks if you don't want to change everything.
>
>> I do not like mixing the two into one patchset. I hope that's a fair
>> request? I tried to mix it and it was a nightmare! If you want, I can
>> try tackling ROUND_CLOSEST afterwards. But I don't think it would help
>> with this patchset, because we'd need to support both the ROUND_CLOSEST
>> and ~ROUND_CLOSEST case. Covering one case seems already hard enough. :)
>
> That's fair, but then remove the rate rounding handling entirely and
> only deal with forwarding the rate to the parent if SET_RATE_PARENT is
> set.
>
> Maxime
>
> [[End of PGP Signed Part]]
