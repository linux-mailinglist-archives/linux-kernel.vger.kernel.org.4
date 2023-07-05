Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68B3748E76
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjGET42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbjGET4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:56:22 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200F9172B;
        Wed,  5 Jul 2023 12:56:21 -0700 (PDT)
Received: from p5dcc37f0.dip0.t-ipconnect.de ([93.204.55.240] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qH8bl-0017gV-0E; Wed, 05 Jul 2023 21:56:13 +0200
Date:   Wed, 5 Jul 2023 21:56:11 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Mark Brown <broonie@kernel.org>
Cc:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        peter.ujfalusi@gmail.com, jarkko.nikula@bitmer.com,
        dmitry.torokhov@gmail.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 2/3] ASoC: tlv320aic3x: use BCLK instead of MCLK if not
 in master mode
Message-ID: <20230705215611.5f96584e@aktux>
In-Reply-To: <15d3fc6e-d294-4968-bc7d-66307efc92db@sirena.org.uk>
References: <20230705190324.355282-1-andreas@kemnade.info>
        <20230705190324.355282-3-andreas@kemnade.info>
        <15d3fc6e-d294-4968-bc7d-66307efc92db@sirena.org.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2023 20:21:58 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Jul 05, 2023 at 09:03:23PM +0200, Andreas Kemnade wrote:
> 
> > +	/* probably no mclk if not master, so rely on bitclk */
> > +	if (!aic3x->master)
> > +		clk_id = 2;
> > +  
> 
> This is fairly clearly a massive hack, we're just silently ignoring the
> clock we were asked to configure and choosing another one which is
> likely at a different rate to that we were expecting and sadly the
> driver didn't provide an automatic mode due to how old it is.  We also
> appear to try to use the configured clock rate during PLL setup which
> still happens in hw_params() even with this change which is a bit of a
> concern here.  Are you sure hw_params ends up doing the right thing, and
> that there are no other systems that get broken by this (perhaps ones
> sending a lower BCLK for example)?

Yes, I am not that happy myself with that one. Possible victim is
keystone-k2g-evm.dts. 
I looked for if (master) things and found the pll enable/disable connected to it.
But that is not the whole story...
> 
> It would be nicer to set the clock via the DT bindings, ideally with the
> clock bindings...

I found no path from these simple-audio-card things to provide a clk_id 
to set_dai_sysclk. I would of course prefer such a thing. Do I have overlooked
something?

Regards,
Andreas
