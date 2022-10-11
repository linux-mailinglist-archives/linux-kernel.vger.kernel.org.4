Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50DD5FAE8A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiJKIgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiJKIgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:36:35 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCC17F249;
        Tue, 11 Oct 2022 01:36:32 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g27so19062627edf.11;
        Tue, 11 Oct 2022 01:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HFDwQOJAiprdmj4ETcja9MgyFLdTSO0oL4mXH3CxXYQ=;
        b=OfXM+Qf0kEf2xHt2VPZ0rr1RuWoQbgh/6wd2ucw8oeILIH9sFhcDRkotAm7v6Kd9Xc
         hOOLBPFGCVt0C6rCcubXTLmsY8nSlmLghwZ0gzhjymLSNAc3kEJYiu1aM3w4EJwg5Pwv
         lTSpETpyq9U9tlQzRB8p455LwE2ufeITFzUntOcgKNJEO71/gv4Cm9UPiB4ZrDUBFYKF
         q88ufrq6iyadwQ9S8VJf77meI78gM6uvHJdZRCIZyp3fWFW+GZa+Olg8Fq8ySHgTEiZb
         UgtbCkW0TCZWytbxXKEhzPDUCc8d+t4sXBiSxC3JVSjqsEkEQ43uzGyvpUXnyac4+GOm
         nsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HFDwQOJAiprdmj4ETcja9MgyFLdTSO0oL4mXH3CxXYQ=;
        b=Jx5AOpl2k9iHgI471hsVCX3VrBnMED7jNtLklKvWocpfC/DxsuZLga/ZnEPz1E/dnz
         cwV3GkyHSjN5FGKfkrj0XZVUTrkufuVowA0r2zNeP9Bty41QIR3+nwPLoYCx6IWBbI5D
         ZaYiJOrFYr09huvrf49KerrYkN4hnegq/pcfigqZ4be1/05asDaoQ9pd+D6pUu077Bv0
         8Mn/m+FnNppK5STyjS8Kx5MBuK23GrnhYddJct5I+am0P3jO2alK9pwXGUNi6+P976yP
         UgwdIsRxExtMmETqEjKi1UccXqBafC4nddS7EDShJ6vasKz46urVU0CzJ3Fxi7rnWLBc
         YswQ==
X-Gm-Message-State: ACrzQf10yCJXiwgwPESLVSzqRkyN9pWGMEtpD4gqHMJLsRAJsQWTa63Z
        YHSFWEr7WrFC1bQASrBS8UqSbH6oe8Z1WHNI6qI=
X-Google-Smtp-Source: AMsMyM7SmYmE6jQjvo4BbSE7hlFDgUVMTlEUJdPNLxwCXMY+JGJcn1DvM4fvq/1TQGC9DMUxymB5PUrXF1Mx2ahhQGo=
X-Received: by 2002:a05:6402:5255:b0:459:ebaa:c2b8 with SMTP id
 t21-20020a056402525500b00459ebaac2b8mr21635661edd.150.1665477390530; Tue, 11
 Oct 2022 01:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220927201634.750141-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <Y0Ulvmyg8rBOPbRF@paasikivi.fi.intel.com>
In-Reply-To: <Y0Ulvmyg8rBOPbRF@paasikivi.fi.intel.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 11 Oct 2022 09:36:03 +0100
Message-ID: <CA+V-a8v6ZGC7Ea6zdWGcLVyyq2Q=pUb0C_OwHWjFqSmuo5f-ZA@mail.gmail.com>
Subject: Re: [PATCH] media: i2c: ov5645: Use runtime PM
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

Thanks for the review. That was quick.

On Tue, Oct 11, 2022 at 9:14 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Prabhakar,
>
> Thanks for the patch. It's great to see drivers moving to runtime PM!
>
> On Tue, Sep 27, 2022 at 09:16:34PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Switch to using runtime PM for power management.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/media/i2c/Kconfig  |   2 +-
> >  drivers/media/i2c/ov5645.c | 135 +++++++++++++++++++------------------
> >  2 files changed, 69 insertions(+), 68 deletions(-)
> >
> > diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> > index 7806d4b81716..c0edd1017fe8 100644
> > --- a/drivers/media/i2c/Kconfig
> > +++ b/drivers/media/i2c/Kconfig
> > @@ -459,7 +459,7 @@ config VIDEO_OV5640
> >  config VIDEO_OV5645
> >       tristate "OmniVision OV5645 sensor support"
> >       depends on OF
> > -     depends on I2C && VIDEO_DEV
> > +     depends on I2C && PM && VIDEO_DEV
> >       select MEDIA_CONTROLLER
> >       select VIDEO_V4L2_SUBDEV_API
> >       select V4L2_FWNODE
> > diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
> > index 81e4e87e1821..3c3b30338328 100644
> > --- a/drivers/media/i2c/ov5645.c
> > +++ b/drivers/media/i2c/ov5645.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_graph.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/slab.h>
> >  #include <linux/types.h>
> > @@ -108,7 +109,6 @@ struct ov5645 {
> >       u8 timing_tc_reg21;
> >
> >       struct mutex power_lock; /* lock to protect power state */
> > -     int power_count;
> >
> >       struct gpio_desc *enable_gpio;
> >       struct gpio_desc *rst_gpio;
> > @@ -635,8 +635,24 @@ static int ov5645_set_register_array(struct ov5645 *ov5645,
> >       return 0;
> >  }
> >
> > -static int ov5645_set_power_on(struct ov5645 *ov5645)
> > +static int ov5645_set_power_off(struct device *dev)
> >  {
> > +     struct v4l2_subdev *sd = dev_get_drvdata(dev);
> > +     struct ov5645 *ov5645 = to_ov5645(sd);
> > +
> > +     ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x58);
> > +     gpiod_set_value_cansleep(ov5645->rst_gpio, 1);
> > +     gpiod_set_value_cansleep(ov5645->enable_gpio, 0);
> > +     clk_disable_unprepare(ov5645->xclk);
> > +     regulator_bulk_disable(OV5645_NUM_SUPPLIES, ov5645->supplies);
> > +
> > +     return 0;
> > +}
> > +
> > +static int ov5645_set_power_on(struct device *dev)
> > +{
> > +     struct v4l2_subdev *sd = dev_get_drvdata(dev);
> > +     struct ov5645 *ov5645 = to_ov5645(sd);
> >       int ret;
> >
> >       ret = regulator_bulk_enable(OV5645_NUM_SUPPLIES, ov5645->supplies);
> > @@ -658,57 +674,19 @@ static int ov5645_set_power_on(struct ov5645 *ov5645)
> >
> >       msleep(20);
> >
> > -     return 0;
> > -}
> > -
> > -static void ov5645_set_power_off(struct ov5645 *ov5645)
> > -{
> > -     gpiod_set_value_cansleep(ov5645->rst_gpio, 1);
> > -     gpiod_set_value_cansleep(ov5645->enable_gpio, 0);
> > -     clk_disable_unprepare(ov5645->xclk);
> > -     regulator_bulk_disable(OV5645_NUM_SUPPLIES, ov5645->supplies);
> > -}
> > -
> > -static int ov5645_s_power(struct v4l2_subdev *sd, int on)
> > -{
> > -     struct ov5645 *ov5645 = to_ov5645(sd);
> > -     int ret = 0;
> > -
> > -     mutex_lock(&ov5645->power_lock);
> > -
> > -     /* If the power count is modified from 0 to != 0 or from != 0 to 0,
> > -      * update the power state.
> > -      */
> > -     if (ov5645->power_count == !on) {
> > -             if (on) {
> > -                     ret = ov5645_set_power_on(ov5645);
> > -                     if (ret < 0)
> > -                             goto exit;
> > -
> > -                     ret = ov5645_set_register_array(ov5645,
> > -                                     ov5645_global_init_setting,
> > +     ret = ov5645_set_register_array(ov5645, ov5645_global_init_setting,
> >                                       ARRAY_SIZE(ov5645_global_init_setting));
> > -                     if (ret < 0) {
> > -                             dev_err(ov5645->dev,
> > -                                     "could not set init registers\n");
> > -                             ov5645_set_power_off(ov5645);
> > -                             goto exit;
> > -                     }
> > -
> > -                     usleep_range(500, 1000);
> > -             } else {
> > -                     ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x58);
> > -                     ov5645_set_power_off(ov5645);
> > -             }
> > +     if (ret < 0) {
> > +             dev_err(ov5645->dev, "could not set init registers\n");
> > +             goto exit;
> >       }
> >
> > -     /* Update the power count. */
> > -     ov5645->power_count += on ? 1 : -1;
> > -     WARN_ON(ov5645->power_count < 0);
> > +     usleep_range(500, 1000);
> >
> > -exit:
> > -     mutex_unlock(&ov5645->power_lock);
> > +     return 0;
> >
> > +exit:
> > +     ov5645_set_power_off(dev);
> >       return ret;
> >  }
> >
> > @@ -795,7 +773,7 @@ static int ov5645_s_ctrl(struct v4l2_ctrl *ctrl)
> >       int ret;
> >
> >       mutex_lock(&ov5645->power_lock);
> > -     if (!ov5645->power_count) {
> > +     if (!pm_runtime_get_if_in_use(ov5645->dev)) {
> >               mutex_unlock(&ov5645->power_lock);
> >               return 0;
> >       }
> > @@ -827,6 +805,7 @@ static int ov5645_s_ctrl(struct v4l2_ctrl *ctrl)
> >               break;
> >       }
> >
> > +     pm_runtime_put_autosuspend(ov5645->dev);
> >       mutex_unlock(&ov5645->power_lock);
> >
> >       return ret;
> > @@ -991,6 +970,10 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
> >       int ret;
> >
> >       if (enable) {
> > +             ret = pm_runtime_resume_and_get(ov5645->dev);
> > +             if (ret < 0)
> > +                     return ret;
> > +
> >               ret = ov5645_set_register_array(ov5645,
> >                                       ov5645->current_mode->data,
> >                                       ov5645->current_mode->data_size);
> > @@ -998,22 +981,22 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
> >                       dev_err(ov5645->dev, "could not set mode %dx%d\n",
> >                               ov5645->current_mode->width,
> >                               ov5645->current_mode->height);
> > -                     return ret;
> > +                     goto err_rpm_put;
> >               }
> >               ret = v4l2_ctrl_handler_setup(&ov5645->ctrls);
> >               if (ret < 0) {
> >                       dev_err(ov5645->dev, "could not sync v4l2 controls\n");
> > -                     return ret;
> > +                     goto err_rpm_put;
> >               }
> >
> >               ret = ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x45);
> >               if (ret < 0)
> > -                     return ret;
> > +                     goto err_rpm_put;
> >
> >               ret = ov5645_write_reg(ov5645, OV5645_SYSTEM_CTRL0,
> >                                      OV5645_SYSTEM_CTRL0_START);
> >               if (ret < 0)
> > -                     return ret;
> > +                     goto err_rpm_put;
> >       } else {
> >               ret = ov5645_write_reg(ov5645, OV5645_IO_MIPI_CTRL00, 0x40);
> >               if (ret < 0)
> > @@ -1023,14 +1006,15 @@ static int ov5645_s_stream(struct v4l2_subdev *subdev, int enable)
> >                                      OV5645_SYSTEM_CTRL0_STOP);
> >               if (ret < 0)
> >                       return ret;
>
> Not a problem with this patch and should be addressed separately, but the
> caller will just call s_stream(0) and will ignore the return value. You
> could complain about the error but still should return 0 when disabling
> streaming.
>
OK, I will create a separate patch on top of this.

> > +             pm_runtime_put(ov5645->dev);
> >       }
> >
> >       return 0;
> > -}
> >
> > -static const struct v4l2_subdev_core_ops ov5645_core_ops = {
> > -     .s_power = ov5645_s_power,
> > -};
> > +err_rpm_put:
> > +     pm_runtime_put(ov5645->dev);
> > +     return ret;
> > +}
> >
> >  static const struct v4l2_subdev_video_ops ov5645_video_ops = {
> >       .s_stream = ov5645_s_stream,
> > @@ -1046,7 +1030,6 @@ static const struct v4l2_subdev_pad_ops ov5645_subdev_pad_ops = {
> >  };
> >
> >  static const struct v4l2_subdev_ops ov5645_subdev_ops = {
> > -     .core = &ov5645_core_ops,
> >       .video = &ov5645_video_ops,
> >       .pad = &ov5645_subdev_pad_ops,
> >  };
> > @@ -1188,11 +1171,9 @@ static int ov5645_probe(struct i2c_client *client)
> >               goto free_ctrl;
> >       }
> >
> > -     ret = ov5645_s_power(&ov5645->sd, true);
> > -     if (ret < 0) {
> > -             dev_err(dev, "could not power up OV5645\n");
> > +     ret = ov5645_set_power_on(dev);
> > +     if (ret)
> >               goto free_entity;
> > -     }
> >
> >       ret = ov5645_read_reg(ov5645, OV5645_CHIP_ID_HIGH, &chip_id_high);
> >       if (ret < 0 || chip_id_high != OV5645_CHIP_ID_HIGH_BYTE) {
> > @@ -1209,12 +1190,16 @@ static int ov5645_probe(struct i2c_client *client)
> >
> >       dev_info(dev, "OV5645 detected at address 0x%02x\n", client->addr);
> >
> > +     pm_runtime_set_active(dev);
> > +     pm_runtime_get_noresume(dev);
> > +     pm_runtime_enable(dev);
> > +
> >       ret = ov5645_read_reg(ov5645, OV5645_AEC_PK_MANUAL,
> >                             &ov5645->aec_pk_manual);
> >       if (ret < 0) {
> >               dev_err(dev, "could not read AEC/AGC mode\n");
> >               ret = -ENODEV;
> > -             goto power_down;
> > +             goto err_pm_runtime;
> >       }
> >
> >       ret = ov5645_read_reg(ov5645, OV5645_TIMING_TC_REG20,
> > @@ -1222,7 +1207,7 @@ static int ov5645_probe(struct i2c_client *client)
> >       if (ret < 0) {
> >               dev_err(dev, "could not read vflip value\n");
> >               ret = -ENODEV;
> > -             goto power_down;
> > +             goto err_pm_runtime;
> >       }
> >
> >       ret = ov5645_read_reg(ov5645, OV5645_TIMING_TC_REG21,
> > @@ -1230,14 +1215,18 @@ static int ov5645_probe(struct i2c_client *client)
> >       if (ret < 0) {
> >               dev_err(dev, "could not read hflip value\n");
> >               ret = -ENODEV;
> > -             goto power_down;
> > +             goto err_pm_runtime;
> >       }
> >
> > -     ov5645_s_power(&ov5645->sd, false);
> > +     pm_runtime_set_autosuspend_delay(dev, 1000);
> > +     pm_runtime_use_autosuspend(dev);
> > +     pm_runtime_put_autosuspend(dev);
>
> You can also do this after registering async subdev. That allows removing
> err_pm_runtime label and the two lines below it.
>
Agreed, I'll move this after registering the subdev.

> >
> >       ret = v4l2_async_register_subdev(&ov5645->sd);
> >       if (ret < 0) {
> >               dev_err(dev, "could not register v4l2 device\n");
> > +             pm_runtime_disable(dev);
> > +             pm_runtime_set_suspended(dev);
> >               goto free_entity;
> >       }
> >
> > @@ -1245,8 +1234,11 @@ static int ov5645_probe(struct i2c_client *client)
>
> Again not a problem in this patch, but ov5645_entity_init_cfg() call here
> needs to be done before registering the async subdev.
>
> This could be addressed in a separate patch. Up to you.
>
OK, I'll create a seperate patch for this.

Cheers,
Prabhakar
