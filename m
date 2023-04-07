Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0258C6DB18E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjDGRUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDGRU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:20:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B16BB47A;
        Fri,  7 Apr 2023 10:19:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBC846123B;
        Fri,  7 Apr 2023 17:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8837BC433D2;
        Fri,  7 Apr 2023 17:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680887988;
        bh=foqUkwZm3EuRyXVukmP9rMPCXOVz33XiOfrZ3D5l0js=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ntoqChZoGbJUv6RePRKfwjmsa00B+kL3m69KpxmqusWu5XSqj8lNbi6yZh3TKfCxs
         mRvoo0lQl0lOyITTHySnggfcbk5FfocwqSGt1IoCCmUMqL5ue5TGf+sFHIAJJdo9+f
         64D3hNNyKTAc8urutR63szSX7OWi6s1nwvnu0TNmoiEi5uHEVYHgqz87ys2NDcrl7k
         PS2G3SdDqGHARALenl/y4EpKdE5Q7A5ZryZbSZiojWoRAJPomUAvc3/xFsNaDYGDF6
         C0HEqtSoZMMTFtKxwKK6AQyGv5wDV+pf/FoxFFcrMJO25R0QY2wkhyR56NfawUZE85
         uOOvDizBsT03w==
Date:   Fri, 7 Apr 2023 18:35:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: dac: mcp4922: add support for mcp48xx series
 chips
Message-ID: <20230407183504.54706458@jic23-huawei>
In-Reply-To: <9a203f56-c19a-48f2-f10c-ca0794ce79ed@metafoo.de>
References: <20230405140114.99011-1-frattaroli.nicolas@gmail.com>
        <20230405140114.99011-5-frattaroli.nicolas@gmail.com>
        <9a203f56-c19a-48f2-f10c-ca0794ce79ed@metafoo.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2023 07:18:46 -0700
Lars-Peter Clausen <lars@metafoo.de> wrote:

> Hi,
> 
> Looks very good. A few small comments inline.
> [...]
> > @@ -50,6 +58,35 @@ struct mcp4922_state {
> >   	},						\
> >   }
> >   
> > +static bool mcp4922_needs_vref(int device_id)  
> 
> `enum mcp4922_supported_device_ids` instead of `int`. Same for num_channels() below.
> 
> > +{
> > +	switch (device_id) {
> > +	case ID_MCP4902:
> > +	case ID_MCP4912:
> > +	case ID_MCP4921:
> > +	case ID_MCP4922:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > [...]
> >   static int mcp4922_spi_write(struct mcp4922_state *state, u8 addr, u32 val)
> >   {
> >   	state->mosi[1] = val & 0xff;
> > @@ -108,11 +145,17 @@ static int mcp4922_write_raw(struct iio_dev *indio_dev,
> >   	}
> >   }
> >   
> > -static const struct iio_chan_spec mcp4922_channels[4][MCP4922_NUM_CHANNELS] = {
> > +static const struct iio_chan_spec mcp4922_channels[10][MCP4922_NUM_CHANNELS] = {  
> 
> mcp4922_channels[][MCP4922_NUM_CHANNELS]
> 
> So it does not have to be changed again when adding additional devices 
> in the future.
> 
> > [...]
> > @@ -197,11 +244,14 @@ static void mcp4922_remove(struct spi_device *spi)
> >   {
> >   	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> >   	struct mcp4922_state *state;
> > +	const struct spi_device_id *id = spi_get_device_id(spi);
> >   
> >   	iio_device_unregister(indio_dev);
> >   	state = iio_priv(indio_dev);
> >   	regulator_disable(state->vdd_reg);
> > -	regulator_disable(state->vref_reg);
> > +	if (mcp4922_needs_vref(id->driver_data)) {  
> Could be `if (state->vref_reg)`, this way you don't need to lookup the 
> spi_device_id. But either way is fine.

Even better would be to make this driver use devm_ for all unwinding.
That way the regulator_disable() callback registered via
devm_add_action_or_reset() will only be registered if you enabled such
a regulator in the first place.

The rest of this remove is trivial so it would be a nice addition to this
series to get rid of the need to have it at all.

> > +		regulator_disable(state->vref_reg);
> > +	}
> >   }
> >   
> > [...]  
> 
> 

