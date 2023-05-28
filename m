Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2512C713A91
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 18:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjE1Qct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 12:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjE1Qcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 12:32:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A73AA7;
        Sun, 28 May 2023 09:32:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E39EE60EAB;
        Sun, 28 May 2023 16:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81DAC433D2;
        Sun, 28 May 2023 16:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685291564;
        bh=jfZ3hykkOZ0SU4PcgvnvJdy4PZrWwwVhDVQNGCS+xlc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rVIVkMiRdL+FKfQsKdL9k1zOefcA0mufm8J0I6XzvF18Soc3AoTihcWDfTBzApW67
         yvqIs0oAGTQcqNMr1G6JjQONGxfPDrYReWOjDhJ4SFB9s0M/lrAroiCDqSuwtSFiaI
         8viPBDwceK9vbTunyKryFVyJcSO59LvXRwaPPadjvE6gWswxy2Ln9El4I5zDZApslV
         Z40o/6f6GF0mV4ovag4WX9IUSp85kBD4qsBeC26flUKf5uyOHjV3cdXaVdZ/xbJXYo
         j4lnfqjWn2twcimnWXZp2oQ6pCfGrRdlVqVlMcy+DJePuGUFA7Wr31HR/rzRFCF007
         5bAhEmIKRtZJw==
Date:   Sun, 28 May 2023 17:49:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Mehdi Djait <mehdi.djait.k@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 5/7] iio: accel: kionix-kx022a: Refactor driver and
 add chip_info structure
Message-ID: <20230528174903.6a9c2533@jic23-huawei>
In-Reply-To: <682e84b6-9912-ecb9-9ca2-9d96f511c22d@gmail.com>
References: <cover.1685109507.git.mehdi.djait.k@gmail.com>
        <de588a5a3ca311f6dc3a543bfa5cea7b590ae44c.1685109507.git.mehdi.djait.k@gmail.com>
        <682e84b6-9912-ecb9-9ca2-9d96f511c22d@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


...

> > @@ -762,6 +763,8 @@ static int kx022a_fifo_disable(struct kx022a_data *data)
> >   {
> >   	int ret = 0;
> >   
> > +	kfree(data->fifo_buffer);  
> 
> Should we have the kfree only after the sensor is disabled? I wonder if 
> we in theory have here a time window where the buffer is freed but the 
> measurement is still running and - with a lots of bad luck - can result 
> measurement being written to a freed buffer? Perhaps move the kfree to 
> be done only after the measurement has been stopped?
> 
> Other than that, this is looking good to me.
> 
Agreed. Even if it's not a bug as such, it is better to keep the order
of this function as close as possible to the reverse of what happens in
*_fifo_enabled() as easier to reason about if that's the case.

> > +
> >   	ret = kx022a_turn_off_lock(data);
> >   	if (ret)
> >   		return ret;
> > @@ -770,7 +773,7 @@ static int kx022a_fifo_disable(struct kx022a_data *data)
> >   	if (ret)
> >   		goto unlock_out;
> >   
> > -	ret = regmap_clear_bits(data->regmap, KX022A_REG_BUF_CNTL2,
> > +	ret = regmap_clear_bits(data->regmap, data->chip_info->buf_cntl2,
> >   				KX022A_MASK_BUF_EN);
> >   	if (ret)
> >   		goto unlock_out;
> > @@ -801,6 +804,12 @@ static int kx022a_fifo_enable(struct kx022a_data *data)
> >   {
> >   	int ret;
> >   
> > +	data->fifo_buffer = kmalloc(data->chip_info->fifo_length *
> > +				    KX022A_FIFO_SAMPLES_SIZE_BYTES, GFP_KERNEL);
> > +
> > +	if (!data->fifo_buffer)
> > +		return -ENOMEM;
> > +
> >   	ret = kx022a_turn_off_lock(data);
> >   	if (ret)
> >   		return ret;
> > @@ -811,7 +820,7 @@ static int kx022a_fifo_enable(struct kx022a_data *data)
> >   		goto unlock_out;
> >   
> >   	/* Enable buffer */
> > -	ret = regmap_set_bits(data->regmap, KX022A_REG_BUF_CNTL2,
> > +	ret = regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
> >   			      KX022A_MASK_BUF_EN);
> >   	if (ret)
> >   		goto unlock_out;

...


