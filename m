Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB9F740FAD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjF1LII convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 28 Jun 2023 07:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjF1LIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:08:02 -0400
Received: from unicorn.mansr.com (unicorn.mansr.com [IPv6:2001:8b0:ca0d:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E41F1FEF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:07:58 -0700 (PDT)
Received: from raven.mansr.com (raven.mansr.com [81.2.72.235])
        by unicorn.mansr.com (Postfix) with ESMTPS id 0B96E15360;
        Wed, 28 Jun 2023 12:07:57 +0100 (BST)
Received: by raven.mansr.com (Postfix, from userid 51770)
        id 81069219FD1; Wed, 28 Jun 2023 12:07:56 +0100 (BST)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] clk: sunxi-ng: Convert early providers to
 platform drivers
References: <20211119033338.25486-1-samuel@sholland.org>
        <20211119033338.25486-4-samuel@sholland.org>
        <yw1xedly2z3m.fsf@mansr.com>
        <maqh4yir66agto4lyulvrqrim7qnixwd246jusvvhsjlhhrmmw@gjbubqc2cv4o>
Date:   Wed, 28 Jun 2023 12:07:56 +0100
In-Reply-To: <maqh4yir66agto4lyulvrqrim7qnixwd246jusvvhsjlhhrmmw@gjbubqc2cv4o>
        (Maxime Ripard's message of "Wed, 28 Jun 2023 09:44:18 +0200")
Message-ID: <yw1xa5wj3kvn.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard <mripard@kernel.org> writes:

> On Mon, Jun 26, 2023 at 01:21:33PM +0100, Måns Rullgård wrote:
>> Samuel Holland <samuel@sholland.org> writes:
>> 
>> > The PRCM CCU drivers depend on clocks provided by other CCU drivers. For
>> > example, the sun8i-r-ccu driver uses the "pll-periph" clock provided by
>> > the SoC's main CCU.
>> >
>> > However, sun8i-r-ccu is an early OF clock provider, and many of the
>> > main CCUs (e.g. sun50i-a64-ccu) use platform drivers. This means that
>> > the consumer clocks will be orphaned until the supplier driver is bound.
>> > This can be avoided by converting the remaining CCUs to use platform
>> > drivers. Then fw_devlink will ensure the drivers are bound in the
>> > optimal order.
>> >
>> > The sun5i CCU is the only one which actually needs to be an early clock
>> > provider, because it provides the clock for the system timer. That one
>> > is left alone.
>> >
>> > Signed-off-by: Samuel Holland <samuel@sholland.org>
>> > ---
>> >
>> > (no changes since v1)
>> >
>> >  drivers/clk/sunxi-ng/Kconfig             | 20 ++++----
>> >  drivers/clk/sunxi-ng/ccu-sun4i-a10.c     | 58 +++++++++++++--------
>> >  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c   | 56 ++++++++++++--------
>> >  drivers/clk/sunxi-ng/ccu-sun50i-h616.c   | 33 ++++++++----
>> >  drivers/clk/sunxi-ng/ccu-sun6i-a31.c     | 40 +++++++++++----
>> >  drivers/clk/sunxi-ng/ccu-sun8i-a23.c     | 35 +++++++++----
>> >  drivers/clk/sunxi-ng/ccu-sun8i-a33.c     | 40 +++++++++++----
>> >  drivers/clk/sunxi-ng/ccu-sun8i-h3.c      | 62 ++++++++++++++--------
>> >  drivers/clk/sunxi-ng/ccu-sun8i-r.c       | 65 ++++++++++++++----------
>> >  drivers/clk/sunxi-ng/ccu-sun8i-v3s.c     | 57 +++++++++++++--------
>> >  drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c | 38 ++++++++++----
>> >  11 files changed, 332 insertions(+), 172 deletions(-)
>> 
>> This broke the hstimer clocksource on A20 since it requires a clock
>> provided by the sun4i ccu driver.
>
> The A10 is probably broken by this, but the A20 should be able to use
> the arch timers just like all the other Cortex-A7-based SoCs.
>
> Do you have a dmesg log that could help debug why it's not working?

The A20 works as such since, as you say, it has other clocksources.
However, the hstimer has become unusable.  If anyone was using, for
whatever reason, it won't be working for them now.

Before this change, the kernel log used include this line:

clocksource: hstimer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370868154 ns

Now there is only a cryptic "Can't get timer clock" in its place.

As it is now, the hstimer driver is nothing but a waste of space.
I figure it ought to be fixed one way or another.

-- 
Måns Rullgård
