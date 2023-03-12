Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEFF6B6762
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 15:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCLO5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 10:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjCLO5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 10:57:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563F94DBF7;
        Sun, 12 Mar 2023 07:57:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 953DE60F08;
        Sun, 12 Mar 2023 14:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729A3C433EF;
        Sun, 12 Mar 2023 14:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678633063;
        bh=hmVluJ74k9bGf2V4XsDxkL3lSx2FrFjREzIKR1behe4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C2uMZjFY9Qo9l03SuD3KNdLQAnlh5SDgGjOfoyOmeWoVI+EcBooXbuYxFl0bVZNbz
         1Rzas8k2/l/uRJHC1AqD3iRaJLYdJFwe5GDTr+mxG8u1gt4n519SC9G0kPRNwxWpmP
         KcJG3GkYmaEt68iep8TfWD16mT8W9UUZDpDDl2IUx5P18bpkT3NcEFTIDIyXhzz5zu
         /cvkf4ue8TwzgtS2AfUWwQl/NFjeMgyMK8IOyB8FiV7N3rQ5pQmlX1wm8trqGXb+QH
         /duw+awxONvqQKd904mqWyKx+l5sCZjnYsiczCgLvpC5tYvtZi0bUCqLwbQLEATJHv
         qzi4dB2BqSoOw==
Date:   Sun, 12 Mar 2023 14:57:47 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: adc: Add TI ADS1100 and ADS1000
Message-ID: <20230312145747.268ae10a@jic23-huawei>
In-Reply-To: <ZActDOEsT+tNMfZ1@smile.fi.intel.com>
References: <20230307065535.7927-1-mike.looijmans@topic.nl>
        <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.812861c4-ffbd-402e-bb22-77232c1fbafb@emailsignatures365.codetwo.com>
        <20230307065535.7927-2-mike.looijmans@topic.nl>
        <ZActDOEsT+tNMfZ1@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Tue, 7 Mar 2023 14:24:44 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, Mar 07, 2023 at 07:55:34AM +0100, Mike Looijmans wrote:
> > The ADS1100 is a 16-bit ADC (at 8 samples per second).
> > The ADS1000 is similar, but has a fixed data rate.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> But see below.

I tidied that up and made a few other trivial whitespace tweaks whilst
applying.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to see if it can find anything we missed.

Thanks,

Jonathan

> 
> > Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

> > +
> > +static int ads1100_set_scale(struct ads1100_data *data, int val, int val2)
> > +{
> > +	int microvolts;
> > +	int gain;
> > +
> > +	/* With Vdd between 2.7 and 5V, the scale is always below 1 */
> > +	if (val)
> > +		return -EINVAL;
> > +
> > +	if (!val2)
> > +		return -EINVAL;
> > +
> > +	microvolts = regulator_get_voltage(data->reg_vdd);
> > +	/*
> > +	 * val2 is in 'micro' units, n = val2 / 1000000
> > +	 * result must be millivolts, d = microvolts / 1000
> > +	 * the full-scale value is d/n, corresponds to 2^15,
> > +	 * hence the gain = (d / n) >> 15, factoring out the 1000 and moving the
> > +	 * bitshift so everything fits in 32-bits yields this formula.
> > +	 */
> > +	gain = DIV_ROUND_CLOSEST(microvolts, BIT(15)) * MILLI / val2;
> > +	if (gain < BIT(0) || gain > BIT(3))
> > +		return -EINVAL;
> > +
> > +	ads1100_set_config_bits(data, ADS1100_PGA_MASK, ffs(gain) - 1);

I added a blank line here and in one other place for consistency + I like
them before simple return statements.

> > +	return 0;
> > +}
> > +
> > +static int ads1100_set_data_rate(struct ads1100_data *data, int chan, int rate)
> > +{
> > +	unsigned int i;
> > +	unsigned int size;
> > +
> > +	size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
> > +	for (i = 0; i < size; i++) {
> > +		if (ads1100_data_rate[i] == rate)
> > +			return ads1100_set_config_bits(data, ADS1100_DR_MASK,  
> 
> > +						       FIELD_PREP
> > +						       (ADS1100_DR_MASK, i));  
> 
> This is better on a single line.

Fixed up whilst applying.

> 
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +


