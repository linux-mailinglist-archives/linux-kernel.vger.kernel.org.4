Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E943C5EB1C6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiIZUEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiIZUEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:04:31 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A66D97B16;
        Mon, 26 Sep 2022 13:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=BO41jb632AO2Bc9BLgoCYD5efImi2YwyYT9pGgQE7og=; b=P8
        8uiuSD2+ubN4vwqv6s1SPc9Rxq53k4mdI4L3mMk6z78YdQVeiwmkVixTzfuDkJsbnNfd5DQudJiF6
        TF5XCRN/T1P63gzgMhkJAnCjshmQEvssaPnVBRe3I7e6Rt0N/nyyuSAUXlrd0CkA4Aj40A0XZmzkP
        4+eGFSHxDsICwtc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1ocuKz-000L1E-80; Mon, 26 Sep 2022 22:04:21 +0200
Date:   Mon, 26 Sep 2022 22:04:21 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Rob Herring <robh@kernel.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Marcin Wojtas <mw@semihalf.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] ASoC: kirkwood: enable Kirkwood driver for Armada
 38x platforms
Message-ID: <YzIFxWq7Kt0SudLz@lunn.ch>
References: <20220920132648.2008-1-pali@kernel.org>
 <20220920132648.2008-2-pali@kernel.org>
 <20220926194832.GA2668987-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220926194832.GA2668987-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 02:48:32PM -0500, Rob Herring wrote:
> On Tue, Sep 20, 2022 at 03:26:44PM +0200, Pali Rohár wrote:
> > From: Marcin Wojtas <mw@semihalf.com>
> > 
> > The audio unit of Marvell Armada38x SoC is similar to the ones comprised by
> > other Marvell SoCs (Kirkwood, Dove and Armada 370). Therefore KW audio
> > driver can be used to support it and this commit adds new compatible string
> > to identify Armada 38x variant.
> > 
> > Two new memory regions are added: first one for PLL configuration and
> > the second one for choosing one of audio I/O modes (I2S or S/PDIF).
> > For the latter purpose a new optional DT property is added ('spdif-mode').
> > 
> > kirkwood-i2s driver is extended by adding a new init function for Armada
> > 38x flavor and also a routine that enables PLL output (i.e. MCLK)
> > configuration.
> > 
> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> > Tested-by: Star_Automation <star@marvell.com>
> > Reviewed-by: Nadav Haklai <nadavh@marvell.com>
> > Reviewed-by: Lior Amsalem <alior@marvell.com>
> > Tested-by: Lior Amsalem <alior@marvell.com>
> > Signed-off-by: Hezi Shahmoon <hezi@marvell.com>
> > Reviewed-by: Neta Zur Hershkovits <neta@marvell.com>
> > [pali: Fix support for pre-38x SoCs]
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  .../devicetree/bindings/sound/mvebu-audio.txt |  14 +-
> >  sound/soc/kirkwood/kirkwood-i2s.c             | 136 +++++++++++++++++-
> >  sound/soc/kirkwood/kirkwood.h                 |   2 +
> >  3 files changed, 149 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/mvebu-audio.txt b/Documentation/devicetree/bindings/sound/mvebu-audio.txt
> > index cb8c07c81ce4..4f5dec5cb3c2 100644
> > --- a/Documentation/devicetree/bindings/sound/mvebu-audio.txt
> > +++ b/Documentation/devicetree/bindings/sound/mvebu-audio.txt
> > @@ -6,9 +6,14 @@ Required properties:
> >    "marvell,kirkwood-audio" for Kirkwood platforms
> >    "marvell,dove-audio" for Dove platforms
> >    "marvell,armada370-audio" for Armada 370 platforms
> > +  "marvell,armada-380-audio" for Armada 38x platforms
> 
> Perhaps be consistent with the 370 string above it.

Hi Rob

That was something i also considered. But actually, all 380
compatibles use armada-380-FOOBAR. So this is inconsistent with
armada370-audio, but consistent with armada-380 in general.

	 Andrew
