Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE7870B4FF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjEVG0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjEVG0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:26:38 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FC3CF;
        Sun, 21 May 2023 23:26:34 -0700 (PDT)
Received: (Authenticated sender: maxime.chevallier@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CE96E1C0009;
        Mon, 22 May 2023 06:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684736793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sN1QWpfpHy8cNcjsRVZzqXdY8AI3d4MDJODKixCnXtM=;
        b=NOWCdjpDRBpl2l9+f2j+0EsICTY4iJr6jKkd5EYo/+LckGTWJhKxRSeZclfPlgSVN6j+T8
        X17XHut4y1Dc/wHRjQ8Vz8EDqkKEnMYhZYlnQuRo66CM63abG9QNEuPgzjnox38RWZJ8w8
        P3v1uhOjZog00r6uLCczONUEj07tmuYP46w0HNTHW+/0KaYQWfNS0a84qMCDRzlLuefKgw
        yCnpu++EIHs6HzDeSjbE1yxUcChPAweDy7jt4d5xD5Sq/zwKC6CGFWqwCCqZMwjTa+WGQV
        r+OgadK1wX0PUtLC09o7+R+Ox16Irlx5FFnKJN4xcMDjQkGOwSozcsFU6VmH9g==
Date:   Mon, 22 May 2023 08:26:29 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, Colin Foster <colin.foster@in-advantage.com>,
        Lee Jones <lee@kernel.org>, davem@davemloft.net,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [RFC 7/7] net: pcs: Drop the TSE PCS driver
Message-ID: <20230522082629.7fe93534@pc-7.home>
In-Reply-To: <20230515114809.d4jzhiazymfqajbj@skbuf>
References: <20230324093644.464704-1-maxime.chevallier@bootlin.com>
        <20230324093644.464704-8-maxime.chevallier@bootlin.com>
        <20230515114809.d4jzhiazymfqajbj@skbuf>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vlad,

On Mon, 15 May 2023 14:48:09 +0300
Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

> Hi Maxime,
> 
> On Fri, Mar 24, 2023 at 10:36:44AM +0100, Maxime Chevallier wrote:
> > Now that we can easily create a mdio-device that represents a
> > memory-mapped device that exposes an MDIO-like register layout, we
> > don't need the Altera TSE PCS anymore, since we can use the Lynx
> > PCS instead.
> > 
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > ---
> > -static int tse_pcs_reset(struct altera_tse_pcs *tse_pcs)
> > -{
> > -	u16 bmcr;
> > -
> > -	/* Reset PCS block */
> > -	bmcr = tse_pcs_read(tse_pcs, MII_BMCR);
> > -	bmcr |= BMCR_RESET;
> > -	tse_pcs_write(tse_pcs, MII_BMCR, bmcr);
> > -
> > -	return read_poll_timeout(tse_pcs_read, bmcr, (bmcr &
> > BMCR_RESET),
> > -				 10, SGMII_PCS_SW_RESET_TIMEOUT, 1,
> > -				 tse_pcs, MII_BMCR);
> > -}  
> 
> I just noticed this difference between the Lynx PCS and Altera TSE PCS
> drivers. The Lynx driver doesn't reset the PCS, and if it did, it
> would wait until the opposite condition from yours would be true:
> BMCR_RESET should clear: "!(bmcr & BMCR_RESET)".
> 
> Is your reset procedure correct, I wonder?

I also wonder... My understanding from the documentation I had is that
the PCS needed to be reset every time a major configuration was
changed, as the reset would put the internal state machines back to
their init condition, but without resetting the whole IP.
When performing my initial tests, this was indeed necessary. However
when porting to Lynx and running tests, it pretty much worked out of the
box, and I'm quite happy with it being that way. So I didn't dig much
deeper on why the reset was needed with the TSE PCS in the first place.

On a side note, the final dependencies for the final removal of TSE
were merged into the regmap tree, I'll therefore send a new version of
that series shortly.

Thanks for the review Vlad,

Best Regards,

Maxime
