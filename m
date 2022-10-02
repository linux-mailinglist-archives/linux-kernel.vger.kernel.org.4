Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204685F22E0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 13:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiJBLS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 07:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiJBLSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 07:18:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D71727FC6;
        Sun,  2 Oct 2022 04:18:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB95BB80C02;
        Sun,  2 Oct 2022 11:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50665C433C1;
        Sun,  2 Oct 2022 11:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664709522;
        bh=j+gtgh3ieY79gTmWUV5GeaJhlV4vmWO467y9a2eXUxk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lpwVc2fSrNh9T+rPk+KIlM42gF69IsvyphLQig1BrhnQR7qPUZQdxVxbQqQ+KF0Yn
         mupFQ9dLCGQDcNvkPmeadqZzgtrGZOQYTxm3IhLQGTGf6hUR73bPzZ88Fpgag+Ctsq
         aI6u1LaH40etUs9JSXU+w5L8WxhGq0fmMRrfzF7fElnGWTOGbShHc4ycez62EWWkbJ
         cPhrW35l1TrpQwuWeW2UB3ctuZR2I52dO7x6a0hIb92Koc90BKMGDc/pFTyAgeglhU
         3DTYiGKXiStguQw5F+j+918ujZcH4QOX3j18j6Ygg0l/U7nKNRU7BLO35mUzRf9n5i
         E6sRxGI1RufLw==
Date:   Sun, 2 Oct 2022 12:18:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>
Subject: Re: [RFC PATCH 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Message-ID: <20221002121857.3f7d9423@jic23-huawei>
In-Reply-To: <3eea7954-3faf-3fc9-7507-c318488c5524@gmail.com>
References: <cover.1663760018.git.mazziesaccount@gmail.com>
        <fe1088cebb0de70bcb99af517004c1816b696825.1663760018.git.mazziesaccount@gmail.com>
        <20220922180339.30138141@jic23-huawei>
        <3eea7954-3faf-3fc9-7507-c318488c5524@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Wed, 28 Sep 2022 14:14:14 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi Jonathan,
> 
> On 9/22/22 20:03, Jonathan Cameron wrote:
> > On Wed, 21 Sep 2022 14:45:35 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:  
> >> +
> >> +/*
> >> + * The sensor HW can support ODR up to 1600 Hz - which is beyond what most of
> >> + * Linux CPUs can handle w/o dropping samples. Also, the low power mode is not
> >> + * available for higher sample rates. Thus the driver only supports 200 Hz and
> >> + * slower ODRs. Slowest being 0.78 Hz
> >> + */
> >> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("0.78 1.563 3.125 6.25 12.5 25 50 100 200");
> >> +static IIO_CONST_ATTR(scale_available,
> >> +		      "598.550415 1197.10083 2394.20166 4788.40332");
> >> +
> >> +static struct attribute *kx022a_attributes[] = {
> >> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> >> +	&iio_const_attr_scale_available.dev_attr.attr,  
> > 
> > Use the read_avail() callback instead of doing these as attributes.
> > That makes the values available to consumer drivers...  
> 
> Am I correct that populating the read_avail() does not add sysfs entries 
> for available scale/frequency? Eg, if I wish to expose the supported 
> values via sysfs I still need these attributes? Implementing the 
> read_avail() as well is not a problem though.

Need to also set the relevant bit in 
info_mask_shared_by_xxx_avail in the channels for the sysfs files to be created
by calling the read_avail() callback.

When I introduced those I thought about making it mandatory to introduce them
for all the info_mask_shared_by_xxx entries and not having the extra bitmap
but that meant figuring out the relevant entries for a mass of stuff whenever
a driver was converted from the old approach like you've used here.

> 
> >> +static int kx022a_turn_on_unlock(struct kx022a_data *data)
> >> +{
> >> +	int ret;
> >> +  
> > This is not used enough that I can see a strong reason for the
> > wrapper.  Just put the two calls inline and rename the unlocked case.  
> 
> In my opinion the kx022a_turn_on_unlock() and  kx022a_turn_off_lock() do 
> simplify functions. Especially after I started using the 
> iio_device_claim_direct_mode() :) Thus I will leave these for the v2 - 
> please ping me again if you still want to see them removed (but I think 
> the usage of iio_device_claim_direct_mode() changed this to favour the 
> kx022a_turn_on_unlock() and kx022a_turn_off_lock()).
Let's see how it looks in v2.

> 
> >> +static int kx022a_chip_init(struct kx022a_data *data)
> >> +{
> >> +	int ret, dummy;
> >> +
> >> +	/*
> >> +	 * Disable IRQs because if the IRQs are left on (for example by
> >> +	 * a shutdown which did not deactivate the accelerometer) we do
> >> +	 * most probably end up flooding the system with unhandled IRQs
> >> +	 * and get the line disabled from SOC side.
> >> +	 */
> >> +	ret = regmap_write(data->regmap, KX022A_REG_INC4, 0);  
> > 
> > Unusual to do this rather than a reset.  Quick look suggests there is
> > a suitable software reset (CNTL2)  
> 
> I switched to the software reset as you suggested. I am not really 
> convinced it is a better way. It seems the software reset requires us to 
> re-init the regmap cache. 

Yup, though if you've provided the reset defaults that should be quick.

Jonathan


