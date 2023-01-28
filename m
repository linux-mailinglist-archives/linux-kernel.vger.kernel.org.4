Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B0467FA0E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 18:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjA1Rqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 12:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjA1Rqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 12:46:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4749E869D;
        Sat, 28 Jan 2023 09:46:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1D75B80B84;
        Sat, 28 Jan 2023 17:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F632C433D2;
        Sat, 28 Jan 2023 17:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674927998;
        bh=0R15xDhUHxZm1GRhQ1Or408b9q0z8ZJYYQso4uUb2Gw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fbl8AmxUCHOMI1LzXcgu0qNUny7ZUxSOTpK/Sy4cP+46WOdwp66rzE5YDnnKTbwn4
         vmsWsnlHwU9ikdBhb49AXJnHqwUlsX3kMksHC8/F05ZssyuyMP/cwJONDZHRpWT+15
         Hw3F4IbFzV3il20ziYUe0ck6dL0sGbZjJGCN88sp7HgVhjTi1VogKF0bSmZSzDdNLm
         lPc9H03v9POjMk/6Qu4QCNy0hL1AfiiCutfQ6/mb4QAyHTbdq4C0x8A0mOpggRhK5y
         xZz78cLU5m+p4yX4zSSBQQ05w1OXGrOYp5LBca0ILNtFz+FruzzNSrCS+Srvp+HwQI
         FylVTwQhFpqKw==
Date:   Sat, 28 Jan 2023 18:00:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Ian Ray <ian.ray@ge.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] drivers: iio: adc: ltc2497: fix LSB shift
Message-ID: <20230128180032.2905cee7@jic23-huawei>
In-Reply-To: <20230127174756.00007299@Huawei.com>
References: <20230127125714.44608-1-ian.ray@ge.com>
        <20230127174756.00007299@Huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 17:47:56 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Fri, 27 Jan 2023 14:57:14 +0200
> Ian Ray <ian.ray@ge.com> wrote:
> 
> > Correct the "sub_lsb" shift for both ltc2497 and ltc2499.  

I dropped the ltc2499 mention here as that one seems to be unaffected
by this patch (beyond as a simplification)

> 
> Hi Iain, Thanks for the patch.
> 
> > 
> > An earlier version of the code shifted by 14 but this was a consequence
> > of reading three bytes into a __be32 buffer and using be32_to_cpu(), so
> > eight extra bits needed to be skipped.  Now we use get_unaligned_be24()
> > and thus the additional skip is wrong.
> > 
> > Fixes 2187cfe ("drivers: iio: adc: ltc2497: LTC2499 support")  
> 
> This isn't in standard Fixes tag format.  If nothing else comes
> up I'll fix up whilst applying.
> 
> > Signed-off-by: Ian Ray <ian.ray@ge.com>

Fix looks good to me.  (I noted my reasoning below on basis someone might
find it useful) 

Applied to the fixes-togreg branch of iio.git with fixes tag fixed and
marked for stable.

Please take a look at:
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=fixes-togreg&id=6327a930ab7bfa1ab33bcdffd5f5f4b1e7131504
to check I didn't mess anything up.

Thanks,

Jonathan


> > ---
> >  drivers/iio/adc/ltc2497.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> > index 17370c5..ec198c6 100644
> > --- a/drivers/iio/adc/ltc2497.c
> > +++ b/drivers/iio/adc/ltc2497.c
> > @@ -28,7 +28,6 @@ struct ltc2497_driverdata {
> >  	struct ltc2497core_driverdata common_ddata;
> >  	struct i2c_client *client;
> >  	u32 recv_size;
> > -	u32 sub_lsb;
> >  	/*
> >  	 * DMA (thus cache coherency maintenance) may require the
> >  	 * transfer buffers to live in their own cache lines.
> > @@ -65,10 +64,10 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
> >  		 * equivalent to a sign extension.
> >  		 */
> >  		if (st->recv_size == 3) {
> > -			*val = (get_unaligned_be24(st->data.d8) >> st->sub_lsb)
> > +			*val = (get_unaligned_be24(st->data.d8) >> 6)
Prior to the buggy patch.

1) Read into top 3 bytes of BE32 which corresponds to 8 bits high.
2) Shift by 14.

Before this patch
1) Read only 3 bytes
2) shift by  (31 - (resolution + 1) where resolution is 16 so shift by 14.
Indeed bug.

After this patch.
1) Read 3 bytes
2) shift by 6 

Matches original behaviour - fix is correct.


> >  				- BIT(ddata->chip_info->resolution + 1);
> >  		} else {
> > -			*val = (be32_to_cpu(st->data.d32) >> st->sub_lsb)
> > +			*val = (be32_to_cpu(st->data.d32) >> 6)

Prior to this patch
sub_lsb = 31 - (resolution + 1) where in this case resolution is 24
31 - 25 = 6 so this change is a noop change, so this is good.

> >  				- BIT(ddata->chip_info->resolution + 1);
> >  		}
> >  
> > @@ -122,7 +121,6 @@ static int ltc2497_probe(struct i2c_client *client)
> >  	st->common_ddata.chip_info = chip_info;
> >  
> >  	resolution = chip_info->resolution;
> > -	st->sub_lsb = 31 - (resolution + 1);
> >  	st->recv_size = BITS_TO_BYTES(resolution) + 1;
> >  
> >  	return ltc2497core_probe(dev, indio_dev);  
> 

