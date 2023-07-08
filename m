Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B06174BD90
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 15:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGHNDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 09:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGHNDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 09:03:37 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ECC1994;
        Sat,  8 Jul 2023 06:03:35 -0700 (PDT)
Received: from p5dc58ef9.dip0.t-ipconnect.de ([93.197.142.249] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qI7ar-001Dj3-76; Sat, 08 Jul 2023 15:03:21 +0200
Date:   Sat, 8 Jul 2023 15:03:19 +0200
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
Message-ID: <20230708150319.202789c1@aktux>
In-Reply-To: <eeba3297-acdb-45ca-a80d-40d8b3a90231@sirena.org.uk>
References: <20230705190324.355282-1-andreas@kemnade.info>
        <20230705190324.355282-3-andreas@kemnade.info>
        <15d3fc6e-d294-4968-bc7d-66307efc92db@sirena.org.uk>
        <20230705215611.5f96584e@aktux>
        <eeba3297-acdb-45ca-a80d-40d8b3a90231@sirena.org.uk>
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

Hi,

On Thu, 6 Jul 2023 13:02:36 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Jul 05, 2023 at 09:56:11PM +0200, Andreas Kemnade wrote:
> > Mark Brown <broonie@kernel.org> wrote:  
> 
> > > It would be nicer to set the clock via the DT bindings, ideally with the
> > > clock bindings...  
> 
> > I found no path from these simple-audio-card things to provide a clk_id 
> > to set_dai_sysclk. I would of course prefer such a thing. Do I have overlooked
> > something?  
> 
> Since we already have clock bindings we should use those to configure
> the clocks, there's several drivers that have added this support already
> - look for clock providers.

ok, looking around:
Just to make sure I am not running in a bad direction: Do you think
tlv320aic32x4{,-clk}.c is a good example? It is ignoring clk_id. 
I was mentally bound to have to use clk_id there, so I did not found a good
solution.

So I guess I have to configure the chip as a master and using mclk and compare
register dumps with the state we have now and the state after the changes,
additionally to check bclk functionality directly.

Regards,
Andreas
