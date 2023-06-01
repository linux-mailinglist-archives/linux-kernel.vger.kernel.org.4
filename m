Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69806719AF1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjFALZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjFALZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:25:39 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12234123;
        Thu,  1 Jun 2023 04:25:37 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4QX3hr1bhPz9scT;
        Thu,  1 Jun 2023 13:25:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1685618732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pwp2W8cQUmBk1nwG6nolUJv04uH+qo31sa1TLF5qFwQ=;
        b=LRylmHsg4FUbZTcfmCgHjVYLcjWKChNx7sUBgD/hPw17j7dcrd6xCcnFTR6vSzqy96k0i5
        IeEMLETJObiBboemmSJwvzag/ItT4bFc7WalRWUjTJLG7G6EFmlrDMG41JVck/IWpuX3+n
        j82eUbYLdooxtcdFg6tPjysXRRNND5XACZBJ6OEPkVghyJZNsnDM4gPYKJdAjTZqHJ+oQa
        jRGqOPpYe+nRXEW92IAUeP+NlEY2UoICqF4kaAzPtdDBKBo5647B8JJjmoaZ5U6Vz7fR6W
        tsBiPWo8E0lCI9Jpixu+eVQ9RYRDVK8dAtDj0ZZu1MBfFhDAd097q4AadxAiwg==
References: <20230527132747.83196-1-frank@oltmanns.dev>
 <flngzi4henkzcpzwdexencdkw77h52g3nduup7pwctpwfiuznk@eewnnut5mvsq>
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
Date:   Thu, 01 Jun 2023 07:16:45 +0200
In-reply-to: <flngzi4henkzcpzwdexencdkw77h52g3nduup7pwctpwfiuznk@eewnnut5mvsq>
Message-ID: <87mt1jbf18.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4QX3hr1bhPz9scT
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On 2023-05-31 at 15:48:43 +0200, Maxime Ripard <mripard@kernel.org> wrote:
> [[PGP Signed Part:Undecided]]
> Hi Frank,
>
> On Sat, May 27, 2023 at 03:27:44PM +0200, Frank Oltmanns wrote:
>> I would like to bring your attention to the current process of setting
>> the rate of an NKM clock. As it stands, when setting the rate of an
>> NKM clock, the rate nearest but less than or equal to the requested
>> rate is found, instead of the nearest rate.
>
> Yeah, it's actually pretty common, see clk_mux_determine_rate_flags()
> for example. Some devices require that we don't overshoot, while some
> prefer to have the closest rate.
>
> Both are fine, and it's a bit context specific which one we should
> favour. If we were to do anything, it would be to support both and let
> the clock driver select which behaviour it wants.
>

Ok, understood. Thank you for the explanation! Now, I'm wondering if
anyone would be using such a flag, if I added it.

>
>> Moreover, ccu_nkm_find_best() is called multiple times (footnote [1])
>> when setting a rate, each time iterating over all combinations of n,
>> k, and m.
>
> Yeah, that's expected as well.

I'm wondering though, if iterating over all combinations is set in
stone, or if some kind of optimization would be in order.

>
>> In response to this, I propose the following refinements to optimize the NKM
>> clock setting:
>>  a. when finding the best rate use the nearest rate, even if it is greater than
>>     the requested rate (PATCH 1)
>>  b. utilize binary search to find the best rate by going through a
>>     precalculated, ordered list of all meaningful combinations of n, k, and m
>>     (PATCH 2)
>
> One thing you haven't really addressed is why we would be doing this? Is
> there some clocks that require a more precise clock and don't? Is the
> factor calculation a bottleneck for some workloads?

Background
==========
I'm a pinephone user (ccu-sun50i-a64). I'm using U-Boot which sets the
pll-video0 to 294 MHz on boot. The phone's panel requires DCLK to run at
108 MHz to get a nice 60 Hz vertical refresh rate. The clock structure
is this:

    clock                       clock type
    --------------------------------------
    pll-video0                  ccu_nm
       pll-mipi                 ccu_nkm
          tcon0                 ccu_mux
             tcon-data-clock    sun4i_dclk

The divider between tcon0 and tcon-data-clock is fixed at 4. So, I need
pll-mipi to run at 432 MHz to get the desired vertical refresh rate.
When pll-vdeo0 is at 294 MHz this is that rate cannot be matched exactly
with any combination. The best we can get is 431.2 MHz (n=11, k=2,
m=15).

The pinephone has some "vendor" patches (megi kernel) that
 a. add HDMI
 b. allow re-setting pll-mipi's rate when pll-video0 changes

Re: Who needs a more precise clock?
===================================
When plugging in HDMI, pll-video's rate is set to 297 MHz, which - in
the vendor kernel, not mainline - triggers recalculation of pll-mipi
(trying to set it to 431.2 MHz). It ends up with a rate of 424.285714
MHz, because this is the nearest, but less than 431.2 MHz (n=5, k=2,
m=7). The nearest rate would be 432 MHz.

So, while analyzing the whole situation that I described above, I found
out that the NKM clocks are not set to the closest rate and wondered why
that is. Hence my request for comments.

Now, one could argue that pll-video0 should be set to 297MHz at boot or
that pll-mipi should try to set the *requested* rate instead of the
previous rate when the pll-video0 changes. And I think that both are
valid or even better approaches than my proposal in this RFC to address
this specific problem and I'll probably sent patches to discuss this as
well.


Re: Why speed up factor calculation?
====================================
I'm not aware that the current implementation of calculating n, k, and m
poses a bottleneck in any situation. Again, while going through the
code, I wondered why not save a few CPU cycles by precalculating the
meaningful combinations. In my opinion, it does not have any side
effects, so we might as well do it. (There is of course the side effect
of using a higher rate, but this is unrelated to precalculation as I
could as well employ a rate comparison that only allows lower rates, or
only optionally higher rates.)

> Clocks in general are very regression-prone, so I'd rather be a bit
> conservative there, and "if it ain't broke, don't fix it".

Sure, I get that.

As I stated in my cover letter:
"The motivation for these proposed changes lies in the current behavior
of rate selection for NKM clocks, which doesn't observe the
CLK_SET_RATE_PARENT flag. I.e. it does not select a different rate for
the parent clock to find the optimal rate."

I thought that this required this optimization to be implemented, but by
now, I'm no longer sure. I'll probably continue investigating different
paths for CLK_SET_RATE_PARENT for NKM clocks and follow up with new
findings.

Thanks,
  Frank

>
> Maxime
>
> [[End of PGP Signed Part]]
