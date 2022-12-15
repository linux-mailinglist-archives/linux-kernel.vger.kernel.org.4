Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFCE64D867
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiLOJSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiLOJSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:18:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2754732C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:18:02 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1p5kNA-0007jH-PM; Thu, 15 Dec 2022 10:17:48 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1p5kN9-0001pe-Jb; Thu, 15 Dec 2022 10:17:47 +0100
Date:   Thu, 15 Dec 2022 10:17:47 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, kernel@pengutronix.de,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: max98088: fix initial dai mute state
Message-ID: <20221215091747.xn3f7ecrwoc7ssyo@pengutronix.de>
References: <20221213095328.122309-1-r.czerwinski@pengutronix.de>
 <20221213095328.122309-2-r.czerwinski@pengutronix.de>
 <Y5hpqWH2WuSIUHil@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5hpqWH2WuSIUHil@sirena.org.uk>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 22-12-13, Mark Brown wrote:
> On Tue, Dec 13, 2022 at 10:53:28AM +0100, Rouven Czerwinski wrote:
> 
> > To fix that we need to explicit set the mute state. Now the first
> > playback request gets played correctly.
> 
> > +++ b/sound/soc/codecs/max98088.c
> > @@ -1710,6 +1710,11 @@ static int max98088_probe(struct snd_soc_component *component)
> >         snd_soc_component_write(component, M98088_REG_1E_DAI2_IOCFG,
> >                 M98088_S2NORMAL|M98088_SDATA);
> >  
> > +       snd_soc_component_update_bits(component, M98088_REG_2F_LVL_DAI1_PLAY,
> > +               M98088_DAI_MUTE_MASK, M98088_DAI_MUTE);
> > +       snd_soc_component_update_bits(component, M98088_REG_31_LVL_DAI2_PLAY,
> > +               M98088_DAI_MUTE_MASK, M98088_DAI_MUTE);
> > +
> 
> Won't this be broken again after suspend?  The device gets powered off
> over suspend, then when it powers on again with the output unmuted
> nothing will do another write since the register is already in the state
> in the cache.

I didn't found any suspend logic within the driver. Is this handled
within the ASoC core?

Regards,
  Marco
