Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A996B689C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCLRGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCLRGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:06:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5D1410A7;
        Sun, 12 Mar 2023 10:06:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A5DCB80D17;
        Sun, 12 Mar 2023 17:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5F7C433EF;
        Sun, 12 Mar 2023 17:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678640793;
        bh=PyzYRS0ls4ILE+hD0pkd/YVTfhoqLZM/cvnCV4lSPrY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MHwlfP0cweWalrF6xXdAoED9oZiW8B66o5aABsaYlBWYUfVQzTJ0ocea0erWvXyV8
         gH5E9fw8Jy0bysQoHpy7q46XaexEUhq60iWp/yxcRVnotoHavXAxQlfujQ6n1HjK0B
         c5wxDjbWJ3u/vB4MZCB9/fZ49wOJRw+yLu7V20eQ6Nhz1OCpUF98BW0fZrt+WTJ/qs
         C7oYVLlWfetMfW1uB9ed3QW28gsJTKvOIYFcc/9MspcutnfgK9QM+sCtdkY1EB0Bei
         1lxpWwGLsahbszvKhvajJZwkKQ8J3dhI6In0LjFGDSl3T095mtyqH1S3I8C6Dm95dj
         FGZtab8v7t3kA==
Date:   Sun, 12 Mar 2023 17:06:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/6] iio: light: Add gain-time-scale helpers
Message-ID: <20230312170638.3e6807b7@jic23-huawei>
In-Reply-To: <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
References: <cover.1678093787.git.mazziesaccount@gmail.com>
        <a4cb9a34ca027867ac014ffe93ca7e8245ce263f.1678093787.git.mazziesaccount@gmail.com>
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

On Mon, 6 Mar 2023 11:17:15 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Some light sensors can adjust both the HW-gain and integration time.
> There are cases where adjusting the integration time has similar impact
> to the scale of the reported values as gain setting has.
> 
> IIO users do typically expect to handle scale by a single writable 'scale'
> entry. Driver should then adjust the gain/time accordingly.
> 
> It however is difficult for a driver to know whether it should change
> gain or integration time to meet the requested scale. Usually it is
> preferred to have longer integration time which usually improves
> accuracy, but there may be use-cases where long measurement times can be
> an issue. Thus it can be preferable to allow also changing the
> integration time - but mitigate the scale impact by also changing the gain
> underneath. Eg, if integration time change doubles the measured values,
> the driver can reduce the HW-gain to half.
> 
> The theory of the computations of gain-time-scale is simple. However,
> some people (undersigned) got that implemented wrong for more than once.
> 
> Add some gain-time-scale helpers in order to not dublicate errors in all
> drivers needing these computations.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Trying not to duplicate what Andy has raised...


At some stage I want to go through the maths very carefully but it's
not happening today and I don't want to delay resolving other remaining comments
so that can wait for a later version. I'm sure it's fine but I like to be
paranoid :)

> +int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time)
> +{
> +	const struct iio_itime_sel_mul *itime;
> +
> +	if (!iio_gts_valid_gain(gts, gain))
> +		return -EINVAL;
> +
> +	if (!gts->num_itime)
> +		return gain;
> +
> +	itime = iio_gts_find_itime_by_time(gts, time);
> +	if (!itime)
> +		return -EINVAL;
> +
> +	return gain * itime->mul;
> +}
> +EXPORT_SYMBOL(iio_gts_get_total_gain);

All of them want to be in the namespace.



> diff --git a/drivers/iio/light/iio-gts-helper.h b/drivers/iio/light/iio-gts-helper.h
> new file mode 100644
> index 000000000000..4b5a417946f4
> --- /dev/null
> +++ b/drivers/iio/light/iio-gts-helper.h

...

> +int iio_gts_find_new_gain_sel_by_old_gain_time(struct iio_gts *gts,
> +					       int old_gain, int old_time_sel,
> +					       int new_time_sel, int *new_gain);
> +int iio_gts_build_avail_tables(struct iio_gts *gts);
> +int devm_iio_gts_build_avail_tables(struct device *dev, struct iio_gts *gts);
> +int iio_gts_build_avail_scale_table(struct iio_gts *gts);
> +int devm_iio_gts_build_avail_scale_table(struct device *dev, struct iio_gts *gts);
> +int iio_gts_build_avail_time_table(struct iio_gts *gts);
> +int devm_iio_gts_build_avail_time_table(struct device *dev, struct iio_gts *gts);

Given most modern IIO drivers use fully devm_ based probing, for now I would not
expose anything else.  That will reduce the interface a lot which I think
is probably a good thing at this stage. 

Keep the non devm stuff internally though as it is a nice structure to have
an I can see we may want some of these in non devm form in the future.

Similarly - for now don't expose the individual table building functions
as we may never need them in drivers.  We (more or less) only support interfaces
that are used and so far they aren't.

For other functions it's worth thinking about whether to not export them
initially. I haven't been through them all to figure out what is not currently used.

> +void iio_gts_purge_avail_scale_table(struct iio_gts *gts);
> +void iio_gts_purge_avail_time_table(struct iio_gts *gts);
> +void iio_gts_purge_avail_tables(struct iio_gts *gts);
> +int iio_gts_avail_times(struct iio_gts *gts,  const int **vals, int *type,
> +			int *length);
> +int iio_gts_all_avail_scales(struct iio_gts *gts, const int **vals, int *type,
> +			     int *length);
> +int iio_gts_avail_scales_for_time(struct iio_gts *gts, int time,
> +				  const int **vals, int *type, int *length);
> +
> +#endif

