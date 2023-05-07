Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F306F98A0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 15:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjEGNUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 09:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjEGNUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 09:20:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4AF17DDB;
        Sun,  7 May 2023 06:20:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D64D860F00;
        Sun,  7 May 2023 13:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54893C433D2;
        Sun,  7 May 2023 13:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683465608;
        bh=pdWUXTFxaGBXL5nmETXB05yzRkrOrxbyIjOlWPBW3lE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YNUz8OvY9BFlW3UyeIBmIuZCSCBi+iFahEaKdT7HyJpK2PahNJfEkm51m5X0cMvWq
         giBZCanj6VKVsnW8Jp8qcxSnQAvnS6Ggey5TxpXphPAW4EEL2yvV3l12P2M77KGjtW
         24fYBcLv4woY9mPAeiKpXavxnWKDcflcIgcPVB0h13ufuG2QU6RkOb7aLx2MusKO3r
         oBtI4XNtmq6V0lnjATE+JB4fgCmif2K1JANSp1D+x9eORiz//kofjwSXunLRfLhrCh
         2Qn+ugjcv1Nn6fBjVTLaUx4V6zRH+SocLT14CCm1aKrGFKtQCtH2LS+xcacujlH921
         0mAftC/IGMoqg==
Date:   Sun, 7 May 2023 14:36:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: bu27034: Reinit regmap cache after reset
Message-ID: <20230507143602.08a11f12@jic23-huawei>
In-Reply-To: <453da7af-8a83-f302-eea6-159e6222f430@gmail.com>
References: <ZFM7lE4ZuDrUTspH@fedora>
        <20230506190738.0b6e4b45@jic23-huawei>
        <453da7af-8a83-f302-eea6-159e6222f430@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 May 2023 13:16:57 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 5/6/23 21:07, Jonathan Cameron wrote:
> > On Thu, 4 May 2023 07:59:00 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> When BU27034 restores the default register values when SWRESET is
> >> issued. This can cause register cache to be outdated.
> >>
> >> Rebuild register cache after SWRESET.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >> Fixes: e52afbd61039 ("iio: light: ROHM BU27034 Ambient Light Sensor")
> >>
> >> ---
> >> I noticed this was missing while writing driver for another light
> >> sensor. The change is not tested in hardware as I don't have the BU27034
> >> at my hands right now. Careful review would be highly appreciated.
> >>
> >> This change is built on top of the
> >> https://lore.kernel.org/all/ZFIw%2FKdApZe1euN8@fedora/
> >> and could probably be squashed with it. Unfortunately I spotted the
> >> missing cache re-init only after sending the fix linked above.
> >>  
> > 
> > I'm not sure I follow what would be happening here or if this makes sense.
> > 
> > Partly the following is based on my mental image of how regmap caching works
> > and could be completely wrong :)
> > 
> > I don't think it goes off an reads registers until they are actually accessed
> > the first time.  
> 
> I think this is not the absolute truth. AFAIR the regmap_init may lead 
> to regcache_hw_init() - which can read the non volatile registers to the 
> cache. I can't say if this is the case with current bu27034 
> regmap-config without taking a good look at this with some thought :)

I think that's only true if you provide various things you haven't in the
regmap config.

> 
> Nevertheless, we know that _if_ there is anything in cache when we do 
> reset, the cache will most likely be invalid as HW will reset the 
> registers. My thinking was that it is just safest to reinit the cache 
> when this happens, then we do not need to care if regcache was populated 
> when this is called.

True, but that's rather heavy weight when we know we only touched one register.

> 
> >  In this case nothing has been accessed before this point
> > other than the SYSTEM_CONTROL register and that happens to the one that
> > is set to trigger the reset.
> > 
> > So at worst I think the only cache element that will potentially be wrong
> > is the SYSTEM_CONTROL register as the cache will contain the reset bits as set.
> > 
> > That would be a problem if you read it again anywhere in the driver after that
> > point, but you don't so not a 'bug' but perhaps prevention of potential future
> > bugs as this behaviour is odd.  If you were to try setting some other bits
> > then you'd probably accidentally reset the device :)
> > 
> > So, what's the ideal solution.  You could just bypass the regcache initially
> > and turn it on later.  
> 
> I think I've never temporarily bypassed the cache when I've used one :) 
> I need to check how this is done :)
> 

regcache_cache_bypass(map, true / false);

> >  Thus it would never become wrong due to the reset (as nothing
> > would be cached until after that).
> > 
> > Or just leave it as you have it here, but explain why it matters - as prevention
> > of potential issues due to wrong value in that single register.  
> 
> Hm. I'd not limit the potential problems to single register as probe may 
> get changed - or error handling could be added and reset performed after 
> probe. (I was actually thinking of this as the spec states that if VCC 
> drops the sensor may go to undefined state and won't recover unless VCC 
> is turned off for > 1mS. Didn't add this for now as it is not at all 
> obvious the regulator would support detecting under-voltage - or that 
> the sensor could really turn-off the regulator as it might be also 
> supplying something else - so I didn't want to implement some overkill 
> error handling when we might not have hardware which actually benefits 
> from this).

OK. I'm fine with just reinitializing it and paying the penalty of that being
overkill given current code.

Combine this with the other patch into one clean fix / tidy up though.

Jonathan



> 
> Yours,
> 	-- Matti
> 

