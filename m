Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB315B9C9C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 16:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIOOJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 10:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiIOOJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:09:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B929C1F9;
        Thu, 15 Sep 2022 07:09:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 918F4B81FFC;
        Thu, 15 Sep 2022 14:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D50C433C1;
        Thu, 15 Sep 2022 14:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663250959;
        bh=GMcAFygpn02wMuHN9qhh7DofQWCP/Te3DBCrRfxnY+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iirNTaNhOL9RnFvjCEDLWXoa5W4hRnUPZJaTu/g4Q7WTTHIX2OawA9tErTB/2Vhvh
         j2RTrTbBnxhlNW2PfVqIVD1P5/qxss8mEHCUnf+KECEBed/lmHC5MK+ft2k4vKcaTK
         meKRKJlVyJRbbxqxfLgQzmYYI1KFHN6WUsDXEPU3HNi+ssH3cT5SZF9gdjvRu3sm72
         UUzG5XzMtabOFPfx/eNYKyYOcR9z6Ad9veq8YUQsYASS7Qm7pYQ+PQ5Rar+lRORpQJ
         LZURLBq+Q6KgkmtfmA+efBI7/2wsURUMCBjnXxVDjMM27U1QOoN+DFNKmjw9rFqC5E
         rC+ggAYSQAHDw==
Date:   Thu, 15 Sep 2022 15:09:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Crt Mori <cmo@melexis.com>, linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] iio: temperature: mlx90632 Read sampling
 frequency
Message-ID: <20220915150918.6cdf7586@jic23-huawei>
In-Reply-To: <CAHp75VdF+Qe_QvKqchZPYM4E6oG0=kJcK-32H0hejyT8nJNhdw@mail.gmail.com>
References: <cover.1662454215.git.cmo@melexis.com>
        <8d206235a7241fe764d9d51649061a4fd1b534d6.1662454215.git.cmo@melexis.com>
        <CAHp75VdF+Qe_QvKqchZPYM4E6oG0=kJcK-32H0hejyT8nJNhdw@mail.gmail.com>
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

On Tue, 6 Sep 2022 13:21:36 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Sep 6, 2022 at 12:04 PM <cmo@melexis.com> wrote:
> >
> > From: Crt Mori <cmo@melexis.com>
> >
> > Allow users to read sensor sampling frequency to better plan the
> > application measurement requests.
> >
> > Signed-off-by: Crt Mori <cmo@melexis.com>
> > ---
> >  drivers/iio/temperature/mlx90632.c | 51 ++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >
> > diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
> > index e41a18edbc65..6b33284eb0b6 100644
> > --- a/drivers/iio/temperature/mlx90632.c
> > +++ b/drivers/iio/temperature/mlx90632.c
> > @@ -81,6 +81,9 @@
> >  #define MLX90632_PWR_STATUS_CONTINUOUS MLX90632_PWR_STATUS(3) /* continuous */
> >
> >  #define MLX90632_EE_RR GENMASK(10, 8) /* Only Refresh Rate bits */
> > +#define MLX90632_REFRESH_RATE(ee_val) FIELD_GET(MLX90632_EE_RR, ee_val)
> > +                                       /* Extract Refresh Rate from ee register */
> > +#define MLX90632_REFRESH_RATE_STATUS(refresh_rate) (refresh_rate << 8)
> >
> >  /* Measurement types */
> >  #define MLX90632_MTYP_MEDICAL 0
> > @@ -915,6 +918,24 @@ static int mlx90632_calc_ambient_dsp105(struct mlx90632_data *data, int *val)
> >         return ret;
> >  }
> >
> > +static int mlx90632_get_refresh_rate(struct mlx90632_data *data,
> > +                                    int *refresh_rate)
> > +{
> > +       unsigned int meas1;
> > +       int ret;
> > +
> > +       ret = regmap_read(data->regmap, MLX90632_EE_MEDICAL_MEAS1, &meas1);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       *refresh_rate = MLX90632_REFRESH_RATE(meas1);
> > +
> > +       return ret;
> > +}
> > +
> > +static const int mlx90632_freqs[][2] = { {0, 500000}, {1, 0}, {2, 0}, {4, 0},
> > +                                         {8, 0}, {16, 0}, {32, 0}, {64, 0} };  
> 
> I would indent this as
> _freqs ... = {
>   ...pairs...
> };
> 
As you are going around again, I agree with Andy on this.
Burn a few lines for better readability!

> Either way,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> > +
> >  /**
> >   * mlx90632_pm_interraction_wakeup() - Measure time between user interactions to change powermode
> >   * @data: pointer to mlx90632_data object containing interaction_ts information
> > @@ -993,6 +1014,15 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
> >                 *val = data->object_ambient_temperature;
> >                 ret = IIO_VAL_INT;
> >                 break;
> > +       case IIO_CHAN_INFO_SAMP_FREQ:
> > +               ret = mlx90632_get_refresh_rate(data, &cr);
> > +               if (ret < 0)
> > +                       goto mlx90632_read_raw_pm;
> > +
> > +               *val = mlx90632_freqs[cr][0];
> > +               *val2 = mlx90632_freqs[cr][1];
> > +               ret = IIO_VAL_INT_PLUS_MICRO;
> > +               break;
> >         default:
> >                 ret = -EINVAL;
> >                 break;
> > @@ -1026,12 +1056,30 @@ static int mlx90632_write_raw(struct iio_dev *indio_dev,
> >         }
> >  }
> >
> > +static int mlx90632_read_avail(struct iio_dev *indio_dev,
> > +                              struct iio_chan_spec const *chan,
> > +                              const int **vals, int *type, int *length,
> > +                              long mask)
> > +{
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_SAMP_FREQ:
> > +               *vals = (int *)mlx90632_freqs;
> > +               *type = IIO_VAL_INT_PLUS_MICRO;
> > +               *length = 2 * ARRAY_SIZE(mlx90632_freqs);
> > +               return IIO_AVAIL_LIST;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +
> >  static const struct iio_chan_spec mlx90632_channels[] = {
> >         {
> >                 .type = IIO_TEMP,
> >                 .modified = 1,
> >                 .channel2 = IIO_MOD_TEMP_AMBIENT,
> >                 .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> > +               .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +               .info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> >         },
> >         {
> >                 .type = IIO_TEMP,
> > @@ -1039,12 +1087,15 @@ static const struct iio_chan_spec mlx90632_channels[] = {
> >                 .channel2 = IIO_MOD_TEMP_OBJECT,
> >                 .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> >                         BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) | BIT(IIO_CHAN_INFO_CALIBAMBIENT),
> > +               .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +               .info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> >         },
> >  };
> >
> >  static const struct iio_info mlx90632_info = {
> >         .read_raw = mlx90632_read_raw,
> >         .write_raw = mlx90632_write_raw,
> > +       .read_avail = mlx90632_read_avail,
> >  };
> >
> >  static int mlx90632_sleep(struct mlx90632_data *data)
> > --
> > 2.34.1
> >  
> 
> 

