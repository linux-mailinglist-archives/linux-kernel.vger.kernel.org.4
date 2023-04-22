Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA656EBAA7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 19:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjDVR0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 13:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjDVR0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 13:26:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CD3173B;
        Sat, 22 Apr 2023 10:26:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA59261500;
        Sat, 22 Apr 2023 17:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159CFC433D2;
        Sat, 22 Apr 2023 17:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682184390;
        bh=908yESsoaPLc7cgypkKeeo6watKZDSC4iEEzI6wp4q0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JWsvaA4ffpSRff+QYwDWaIPmEtNhMCt3aR+o2bIA/O1ofSEx1ashHNfBGOZbPHPKn
         96ZWbgr8XZI8Q71Zh77bsJPfKtXHu6RKiTzBbohN5RT0oxLa4UDSu3IMQjoI+5ADXG
         ZgKbPLwB5Xj9NwZHLdOoU3daxovru9vbJxDk4QCc4g1boMES2fEcgeClwNxPTIm9Jb
         r4jFTLdLxOAUS68vLKr1ZxZZQfzPzYFmnl4SBHYwXAjQUCmi73epHYiqkwgHTqsWPS
         diNGPJ609mE26zo6caYhC3NXqzrUZ+TwnK7LhvDVR3iqoTJo8MujpVzNTRmPJxds5g
         33PnGirp17X+A==
Date:   Sat, 22 Apr 2023 18:42:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Mehdi Djait <mehdi.djait.k@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: accel: kionix-kx022a: Add a function to
 retrieve number of bytes in buffer
Message-ID: <20230422184206.39366500@jic23-huawei>
In-Reply-To: <20230422183626.2b351521@jic23-huawei>
References: <cover.1682019544.git.mehdi.djait.k@gmail.com>
        <2c5d71e37fc7e000091189b3c5d66ede1a6015d2.1682019544.git.mehdi.djait.k@gmail.com>
        <93b19237-3afd-461f-bdb3-f2cd09cadd9a@gmail.com>
        <20230422183626.2b351521@jic23-huawei>
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

On Sat, 22 Apr 2023 18:36:26 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 21 Apr 2023 09:14:10 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
> > Hi Mehdi,
> > 
> > Thanks for the v2!
> > 
> > On 4/20/23 23:22, Mehdi Djait wrote:  
> > > Since Kionix accelerometers use various numbers of bits to report data, a
> > > device-specific function is required.    
> > 
> > I think this is the right approach. Thanks for adding this 
> > device-specific function.
> >   
> > > Move the driver's private data to the header file to support the new function.    
> > 
> > Hmm. Why this move is necessary? I didn't immediately spot this struct 
> > being used outside this C-file. I'd rather saw the struct in C-file if 
> > possible.
> >   
> > > Make the allocation of the "buffer" array in the fifo_flush function dynamic
> > > and more generic.
> > > 
> > > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> > > ---
> > > v2:
> > > - separated this change from the chip_info introduction and made it a patch in v2    
> > 
> > I am unsure if this separation was needed. I'd only separate the "naming 
> > changes" which bring no changes to code flow, and then patches which are 
> > fixes and need to be backported (to minimize backporting effort and 
> > impact to stable branches). Well, I am fine with this separation though, 
> > seems like I am just making a noise here :).  
> 
> I prefer them split.  I want to see a noop patch for refactors. It's easier
> to quickly check it really makes no functional change.  Adding new
> structures for a new device just adds noise to checking that.
Oops.  I got the patches confused. Ignore that comment.

> 
> 
> >   
> > > - changed the function from generic implementation for to device-specific one
> > > - removed blank lines pointed out by checkpatch
> > > - changed the allocation of the "buffer" array in __kx022a_fifo_flush
> > > 
> > >   drivers/iio/accel/kionix-kx022a.c | 72 +++++++++++++------------------
> > >   drivers/iio/accel/kionix-kx022a.h | 37 ++++++++++++++++
> > >   2 files changed, 66 insertions(+), 43 deletions(-)
> > > 
> > > diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> > > index 7f9a2c29790b..1c81ea1657b9 100644
> > > --- a/drivers/iio/accel/kionix-kx022a.c
> > > +++ b/drivers/iio/accel/kionix-kx022a.c
> > > @@ -150,36 +150,6 @@ static const struct regmap_config kx022a_regmap_config = {
> > >   	.cache_type = REGCACHE_RBTREE,
> > >   };    
> > 
> > Yours,
> > 	-- Matti
> >   
> 

