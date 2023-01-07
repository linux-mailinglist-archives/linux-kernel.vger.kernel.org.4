Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7890B661067
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 18:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjAGRS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 12:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjAGRSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 12:18:46 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D669445657;
        Sat,  7 Jan 2023 09:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=ApdrS3tSWj75Jx4ozDcfURvKE8QjJ1d5AVnSBy/AzuQ=; b=c2T+A4Qv0SjXNNHpM3dbOAlQfA
        Dbolq53uUXvu8D6DU5Y/CydTxr0o3b4/oo3V2H2vz1fZ5KxB4iTRi981LfK+n7sbTr5OfouKAva1t
        /sND2MtNQLPAfaenVae4HskA/G89pIJCp6FCpZhiigxJUpw5AGK3VAMj+WCnfn4fbz5w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pECps-001R2T-1u; Sat, 07 Jan 2023 18:18:24 +0100
Date:   Sat, 7 Jan 2023 18:18:24 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Klaus Kudielka <klaus.kudielka@gmail.com>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Revert "ARM: dts: armada-38x: Fix compatible
 string for gpios"
Message-ID: <Y7mpYFsvLrqpEp7W@lunn.ch>
References: <20230107144149.5743-1-klaus.kudielka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230107144149.5743-1-klaus.kudielka@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2023 at 03:41:48PM +0100, Klaus Kudielka wrote:
> This reverts commit c4de4667f15d04ef5920bacf41e514ec7d1ef03d, which causes
> a regression on Turris Omnia (Armada 385): GPIO interrupts cease to work,
> ending up in the DSA switch being non-functional.
> 
> The blamed commit is incorrect in the first place:
> If compatible = "marvell,armadaxp-gpio", the second (address, size) pair
> of the reg property must to point to the per-CPU interrupt registers
> <0x18800 0x30> / <0x18840 0x30>, and not to the blink enable registers
> <0x181c0 0x08> / <0x181c8 0x08>.
> 
> But even fixing that leaves the GPIO interrupts broken on the Omnia.
> 
> Furthermore:
> Commit 5f79c651e81e explains very well, why the gpio-mvebu driver does not
> work reliably with per-CPU interrupts.
> Commit 988c8c0cd04d deprecates compatible = marvell,armadaxp-gpio for this
> reason.
> 
> Fixes: c4de4667f15d ("ARM: dts: armada-38x: Fix compatible string for gpios")
> Reported-by: Klaus Kudielka <klaus.kudielka@gmail.com>
> Link: https://lore.kernel.org/r/f24474e70c1a4e9692bd596ef6d97ceda9511245.camel@gmail.com/
> 
> Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>

Hi Klaus

I was hoping Pali would comment, maybe fix it. But i think enough time
has passed, we should accept your reverts.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
