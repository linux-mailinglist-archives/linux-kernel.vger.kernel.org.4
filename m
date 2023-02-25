Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1F86A2AFC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 18:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBYRIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 12:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBYRIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 12:08:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A53AD30;
        Sat, 25 Feb 2023 09:08:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF87FB80B0E;
        Sat, 25 Feb 2023 17:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19289C433D2;
        Sat, 25 Feb 2023 17:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677344911;
        bh=ikLMsrEU64wodF7au/jYqvWb95JK8EGgRf66RPxtLR4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I9F3do9xW7Gy77Qgdl6xAoFjPTcyRzDve9PjfrsHPG07wtJFL2jSOyCiiorxaBO1T
         7gN6emOTsz0IbnOcfKa2Q2oQmb92iPBGqoxNJ4dI2rbhQBzl58RamVWRuJ0AB8c6O1
         uNQ6dZjaHbsM00f8BP6mNQqVo2mtYcGaspmSfULruuMiAnCWzAa2mJE6upnahzhWAK
         q9CdHCLmKSYku6BUXsDa9cIanzx5hgWGRvTpJ1UAhssM/UFGnMVovEch2RkZIh/WAH
         u/c4ZMQAQY5XoRrSbITmpUhRcb/G3hQ4Me9WtrDInFZ57GNUlo5cF2efjy8vbQ633k
         GmckU4yQH4w3Q==
Date:   Sat, 25 Feb 2023 17:22:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     marius.cristea@microchip.com, lars@metafoo.de, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: adc: adding support for pac193x
Message-ID: <20230225172255.7b79374a@jic23-huawei>
In-Reply-To: <20230225171954.06d396f3@jic23-huawei>
References: <20230220123232.413029-1-marius.cristea@microchip.com>
        <20230220123232.413029-3-marius.cristea@microchip.com>
        <8ad45f24-dc78-dfc4-23d2-ad5a5d0e42d4@kernel.org>
        <20230225171954.06d396f3@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Feb 2023 17:19:54 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 21 Feb 2023 14:46:08 +0100
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
> > On 20/02/2023 13:32, marius.cristea@microchip.com wrote:  
> > > From: Marius Cristea <marius.cristea@microchip.com>
> > > 
> > > This is the iio driver for Microchip
> > > PAC193X series of Power Monitor with Accumulator chip family.
> > > 
> > > Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> > > ---
> > >  MAINTAINERS               |    7 +
> > >  drivers/iio/adc/Kconfig   |   12 +
> > >  drivers/iio/adc/Makefile  |    1 +
> > >  drivers/iio/adc/pac193x.c | 2072 +++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 2092 insertions(+)
> > >  create mode 100644 drivers/iio/adc/pac193x.c
> > >     
> > 
> > 
> > Thank you for your patch. There is something to discuss/improve.
> >   
> > > +
> > > +#define PAC193X_NEG_PWR_CH1_BIDI(x)	((x) ? BIT(7) : 0)
> > > +#define PAC193X_NEG_PWR_CH2_BIDI(x)	((x) ? BIT(6) : 0)
> > > +#define PAC193X_NEG_PWR_CH3_BIDI(x)	((x) ? BIT(5) : 0)
> > > +#define PAC193X_NEG_PWR_CH4_BIDI(x)	((x) ? BIT(4) : 0)
> > > +#define PAC193X_NEG_PWR_CH1_BIDV(x)	((x) ? BIT(3) : 0)
> > > +#define PAC193X_NEG_PWR_CH2_BIDV(x)	((x) ? BIT(2) : 0)
> > > +#define PAC193X_NEG_PWR_CH3_BIDV(x)	((x) ? BIT(1) : 0)
> > > +#define PAC193X_NEG_PWR_CH4_BIDV(x)	((x) ? BIT(0) : 0)
> > > +
> > > +/*
> > > + * Universal Unique Identifier (UUID),
> > > + * 033771E0-1705-47B4-9535-D1BBE14D9A09, is
> > > + * reserved to Microchip for the PAC193X and must not be changed
> > > + */
> > > +#define PAC193X_DSM_UUID		"033771E0-1705-47B4-9535-D1BBE14D9A09"
> > > +
> > > +enum pac193x_ids {
> > > +	pac1934,
> > > +	pac1933,
> > > +	pac1932,
> > > +	pac1931    
> > 
> > Enums are usually uppercase.  
> 
> I'm not sure there is anything in coding standard around that and a grep finds
> a mixture of the two when it comes to ones used for IDs.  Mind you uppercase
> is fine :)
I take it back. Is indeed in coding style doc.  Glad checkpatch doesn't check for
this though as we'd get 1000s of 'fixes' if it did and in most cases it doesn't
hurt readability.  I'll try and be more consistent on this in review going forwards!

Thanks!

Jonathan

> 
> 
> > 
> > 
> > 
> > Best regards,
> > Krzysztof
> >   
> 

