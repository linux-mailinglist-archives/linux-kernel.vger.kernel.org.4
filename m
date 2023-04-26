Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8806EF430
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240833AbjDZMUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240825AbjDZMUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:20:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F532D4D;
        Wed, 26 Apr 2023 05:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DCC46360B;
        Wed, 26 Apr 2023 12:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE4BC433D2;
        Wed, 26 Apr 2023 12:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682511619;
        bh=h0nRMWPoGQqkJ4NDfxVJAfIigEC6h2l9uWX/mE+tGq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bO2BF27iPTlxgZd0xaXcmeqM7enzth+WOM1pHdJzKtXRcprW/zJQQmzuUZ1jqHJxe
         jB3MWD/ikdcmj++LPDAI5ePRxC9NIHGxJg6M5O07fZnsWdb3sOOm5PLdlr4KCH/dQa
         aaqWPZT3RsFiLhGcuqx1mMm/rU2oflv3+iAqH99zNLF0ms+9GPPvtxVWRx/C4tkT6l
         oOU9aPJJRUqzFC24HGZhJZ7uIiP/G3kRhCvk3IjamwkVB21EnqPwXOMfE4+kwDanWU
         92akijLK8Xe2LlDAZqUHWJ3etuBy9gi0MAOuXpEp9+bWnGnQc1JKzTGWczw8lJCG7f
         wNad+9ffDlgiQ==
Date:   Wed, 26 Apr 2023 14:20:15 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: light: ROHM BU27008 color sensor
Message-ID: <20230426122015.cilet7diaxapgbim@intel.intel>
References: <cover.1682340947.git.mazziesaccount@gmail.com>
 <d51d5e2b3eff65fd86aeb47840db9cd413d96668.1682340947.git.mazziesaccount@gmail.com>
 <20230425164522.sljcniui5ox5yx3l@intel.intel>
 <102a1605-d6dc-80c7-2075-212569c97042@gmail.com>
 <20230426101200.7czyp6nlg44tweyb@intel.intel>
 <d1121acc-6300-011f-caa2-0ddc01c46e91@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1121acc-6300-011f-caa2-0ddc01c46e91@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

> > > > > +static int bu27008_chip_init(struct bu27008_data *data)
> > > > > +{
> > > > > +	int ret;
> > > > > +
> > > > > +	ret = regmap_update_bits(data->regmap, BU27008_REG_SYSTEM_CONTROL,
> > > > > +			   BU27008_MASK_SW_RESET, BU27008_MASK_SW_RESET);
> > > > > +	if (ret)
> > > > > +		return dev_err_probe(data->dev, ret, "Sensor reset failed\n");
> > > > > +
> > > > > +	/*
> > > > > +	 * The data-sheet does not tell how long performing the IC reset takes.
> > > > > +	 * However, the data-sheet says the minimum time it takes the IC to be
> > > > > +	 * able to take inputs after power is applied, is 100 uS. I'd assume
> > > > > +	 * > 1 mS is enough.
> > > > > +	 */
> > > > > +	msleep(1);
> > > > 
> > > > please use usleep_range().
> > > 
> > > I prefer to not require setting up hrtimers as we have no real requirements
> > > for the duration of this sleep. I know the msleep() is likely to exceed the
> > > 1 mS, potentially a lot if there is things to do - but we don't really care
> > > at this point. The main thing is to give the HW time to reset while allowing
> > > other things to be scheduled.
> > 
> > For the reason above, msleep(1) is quite a meaningless
> > instruction. If you need to wait around 1ms, then usleep_range is
> > the function to be used.
> > 
> > Refer, also, to the Documentation/timers/timers-howto.rst
> 
> I know the msleep() may sleep much longer. It still is not meaningless. Here
> we use the msleep() in a purpose:
> 
> "Sleep at least 1 mS, but actually I don't care if that is 20 mS or more -
> as long as you allow scheduling other things with as little overhead as
> possible".
> 
> For that purpose msleep() works just perfectly :)
> 
> I actually had a comment clarifying this in previous IIO driver I wrote
> (just to avoid confusing reviewers) but Jonathan asked me to remove the
> comment ;)

OK... ok... you convinced me :)

Thanks, will check soon your v3.
Andi
