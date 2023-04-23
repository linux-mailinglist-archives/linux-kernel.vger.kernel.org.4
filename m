Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242396EBEFF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 13:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjDWLCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 07:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDWLCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 07:02:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E1810C6;
        Sun, 23 Apr 2023 04:02:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B36A9617FF;
        Sun, 23 Apr 2023 11:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294BFC433EF;
        Sun, 23 Apr 2023 11:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682247759;
        bh=GX1de5r1lc7chFfHwbNfKnZQbeGh9zCZWq0u2Y+/t+4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WXQqerra0HmGng85won5kV2jSz3jMJ4U4hGX5Y4dBCirGjswBdQq9FMrdF48UHMQo
         5sX5T//Nyp0CHd/kQ9dxUGj8A8mGDlRLB0gljHvslxAPXPwpgU+/8gfO7LJ4gAow7A
         GRAl5bSpOkJF0Sx5ZnHFTgCtntL+sD3MDUY3pIPhXk5Cc3NJ2vU3saRrh+ni7fKgX2
         ObRs0AzOjfkiLTK86dyk2Cjevt+luzfouEGhFckNok6eay/IZvAuFflDyBKc9TSYzo
         Pn680k02Z29Wm1/gDgpP+xgBVRX6IXkMawh7aDTc80ATzAvvzBJ0niU773TsOLi94H
         XTPSrKHhndJEw==
Date:   Sun, 23 Apr 2023 12:18:15 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: gts-helpers: fix integration time units
Message-ID: <20230423121815.6d7c8039@jic23-huawei>
In-Reply-To: <eeacd192c259e885850b5a2dd8b776bccfc44fa8.1681722914.git.mazziesaccount@gmail.com>
References: <cover.1681722914.git.mazziesaccount@gmail.com>
        <eeacd192c259e885850b5a2dd8b776bccfc44fa8.1681722914.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Mon, 17 Apr 2023 12:20:18 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The IIO ABI mandates expressing integration times in seconds. The GTS
> helper errorneously uses micro seconds in integration_times_available.
> Fix this by converting the lists to IIO_VAL_INT_PLUS_MICRO.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  drivers/iio/industrialio-gts-helper.c | 43 ++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> index 8bb68975b259..2ab8d2dce019 100644
> --- a/drivers/iio/industrialio-gts-helper.c
> +++ b/drivers/iio/industrialio-gts-helper.c
> @@ -337,6 +337,17 @@ static int iio_gts_build_avail_scale_table(struct iio_gts *gts)
>  	return ret;
>  }
>  
> +static void iio_gts_us_to_int_micro(int *time_us, int *int_micro_times,
> +				    int num_times)
> +{
> +	int i;
> +
> +	for (i = 0; i < num_times; i++) {
> +		int_micro_times[i * 2] = time_us[i] / 1000000;
> +		int_micro_times[i * 2 + 1] = time_us[i] % 1000000;
> +	}
> +}
> +
>  /**
>   * iio_gts_build_avail_time_table - build table of available integration times
>   * @gts:	Gain time scale descriptor
> @@ -351,7 +362,7 @@ static int iio_gts_build_avail_scale_table(struct iio_gts *gts)
>   */
>  static int iio_gts_build_avail_time_table(struct iio_gts *gts)
>  {
> -	int *times, i, j, idx = 0;
> +	int *times, i, j, idx = 0, *int_micro_times;
>  
>  	if (!gts->num_itime)
>  		return 0;
> @@ -360,6 +371,7 @@ static int iio_gts_build_avail_time_table(struct iio_gts *gts)
>  	if (!times)
>  		return -ENOMEM;
>  
> +

Grumble.

If nothing else comes up I'll tidy that stray line up when applying.

Note that these will need to wait for after rc1 now so my fixes branch
has moved on to include the code being fixed.

>  	/* Sort times from all tables to one and remove duplicates */
>  	for (i = gts->num_itime - 1; i >= 0; i--) {
>  		int new = gts->itime_table[i].time_us;
> @@ -378,13 +390,24 @@ static int iio_gts_build_avail_time_table(struct iio_gts *gts)
>  			}
>  		}
>  	}
> -	gts->avail_time_tables = times;
> -	/*
> -	 * This is just to survive a unlikely corner-case where times in the
> -	 * given time table were not unique. Else we could just trust the
> -	 * gts->num_itime.
> -	 */
> -	gts->num_avail_time_tables = idx;
> +
> +	/* create a list of times formatted as list of IIO_VAL_INT_PLUS_MICRO */
> +	int_micro_times = kcalloc(idx, sizeof(int) * 2, GFP_KERNEL);
> +	if (int_micro_times) {
> +		/*
> +		 * This is just to survive a unlikely corner-case where times in
> +		 * the given time table were not unique. Else we could just
> +		 * trust the gts->num_itime.
> +		 */
> +		gts->num_avail_time_tables = idx;
> +		iio_gts_us_to_int_micro(times, int_micro_times, idx);
> +	}
> +
> +	gts->avail_time_tables = int_micro_times;
> +	kfree(times);
> +
> +	if (!int_micro_times)
> +		return -ENOMEM;
>  
>  	return 0;
>  }
> @@ -683,8 +706,8 @@ int iio_gts_avail_times(struct iio_gts *gts,  const int **vals, int *type,
>  		return -EINVAL;
>  
>  	*vals = gts->avail_time_tables;
> -	*type = IIO_VAL_INT;
> -	*length = gts->num_avail_time_tables;
> +	*type = IIO_VAL_INT_PLUS_MICRO;
> +	*length = gts->num_avail_time_tables * 2;
>  
>  	return IIO_AVAIL_LIST;
>  }

