Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB01D66AC5E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 16:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjANP6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 10:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjANP6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 10:58:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E3B7ED9;
        Sat, 14 Jan 2023 07:58:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB94F60B43;
        Sat, 14 Jan 2023 15:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35B9C433EF;
        Sat, 14 Jan 2023 15:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673711928;
        bh=aDORqP9NjKfZkBNp4szM8Th6ZZuUUWf4np00b/w8nqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BWYvaNW5fnMGht88+8sryV9z2Tc3ZP3M+X70YFgLphufOzWLP8KFSn0vwzVB8fynx
         urmMjKPwnHb71JnrOQFkTs1tzduopE0jZGlZyenfz6/2rDs4XOElztw9v9pSEr5eIq
         vPREJ2vpyugjZv72kFipWY8T+tRW5NYiBTa7Qp1+8nlhkRki+WvmQW2YBZewVc9pwa
         d9yuBU6meAlWwfaCY8/rQYh3D/DcQNeMmTFfjDTwlCttYgpqMtHIVFFXgfJog7ur2n
         IMmJYwCDbtODoVFWzzRGf2CzKY5BITAryVf3WR1JppmWvfUmcex1Dzcminqd/38zNa
         IGRYuMrHP97OA==
Received: by pali.im (Postfix)
        id 40D45650; Sat, 14 Jan 2023 16:58:44 +0100 (CET)
Date:   Sat, 14 Jan 2023 16:58:44 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Klaus Kudielka <klaus.kudielka@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Revert "ARM: dts: armada-38x: Fix compatible
 string for gpios"
Message-ID: <20230114155844.amu3qb4hfgrhn3nu@pali>
References: <20230107144149.5743-1-klaus.kudielka@gmail.com>
 <Y7mpYFsvLrqpEp7W@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7mpYFsvLrqpEp7W@lunn.ch>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 January 2023 18:18:24 Andrew Lunn wrote:
> On Sat, Jan 07, 2023 at 03:41:48PM +0100, Klaus Kudielka wrote:
> > This reverts commit c4de4667f15d04ef5920bacf41e514ec7d1ef03d, which causes
> > a regression on Turris Omnia (Armada 385): GPIO interrupts cease to work,
> > ending up in the DSA switch being non-functional.
> > 
> > The blamed commit is incorrect in the first place:
> > If compatible = "marvell,armadaxp-gpio", the second (address, size) pair
> > of the reg property must to point to the per-CPU interrupt registers
> > <0x18800 0x30> / <0x18840 0x30>, and not to the blink enable registers
> > <0x181c0 0x08> / <0x181c8 0x08>.
> > 
> > But even fixing that leaves the GPIO interrupts broken on the Omnia.
> > 
> > Furthermore:
> > Commit 5f79c651e81e explains very well, why the gpio-mvebu driver does not
> > work reliably with per-CPU interrupts.
> > Commit 988c8c0cd04d deprecates compatible = marvell,armadaxp-gpio for this
> > reason.
> > 
> > Fixes: c4de4667f15d ("ARM: dts: armada-38x: Fix compatible string for gpios")
> > Reported-by: Klaus Kudielka <klaus.kudielka@gmail.com>
> > Link: https://lore.kernel.org/r/f24474e70c1a4e9692bd596ef6d97ceda9511245.camel@gmail.com/
> > 
> > Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>
> 
> Hi Klaus
> 
> I was hoping Pali would comment, maybe fix it. But i think enough time
> has passed, we should accept your reverts.

Well, enough time for sure has not passed as I'm waiting for other
reviews and comments for more than half of year, reminding them, and
there is no input. So why should I react quickly in few days?

And why should fix it? Just prepare another patch and wait another year
until somebody notice it and merge it? I really do not have motivation
here. I have already spent too much time on this stuff, sent lot of
changes for which nobody cares.

> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
>     Andrew
