Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C7962BC70
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbiKPLsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238984AbiKPLr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:47:59 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7326720984
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:34:47 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id q71so16380887pgq.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GdCAa7K7DpxQCHLJzzUvovjinqpUndXrecJwIijz2vQ=;
        b=dw1O2udg2QI9VOP1TCM5Vih67cp/9mpyxnn8xiB14IMfm5vhkK6xmJH4i+X73rFtXv
         jUM3kxB/1XzlXDsEdlLaG4RCySNWjqYgDGPYxvll5iTAR/6CP3IOGlKsgLhcmggLQ0yI
         AEf+MBzMC2DYsDASPOvfAbRwWIoYCxqmjsJxU5H+oJhBP3w7wG/t00yOZcudSw8tNT/s
         YhZhFUPPS+zXtJ1o3Wl2BFfXNn0Gifi1QP37A0ifm1M3ljMbfyWg53EEt6JZjcNqqdKb
         zjKW/jt7tfD3lZs9oZ//z7z8V/+QiDTFZpSc3kzKGPMAl6Lkp4uiul2rJWwckI+HW09j
         RqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GdCAa7K7DpxQCHLJzzUvovjinqpUndXrecJwIijz2vQ=;
        b=YtXdt81B4HzOxcSyfHoEWk/8eJ/I3iIgC1501oSQDWmGBOVm158oIw40FOWcyvtjWF
         G9soIilqs2KFTMDPco4ryIwO5iEYJjTFfTzaMU6CNTyI+l46em2tTz6HUbQqc+z+A1p6
         8uQxJhKVPY9Be6p90T/TfUP7FqRW/DDA2IUD3pTpXQs7Y68axvcSkzM344H4IARFrAA9
         sy5sS5aaW0bN1hXZwkE5BFt0YOnnsEuqtMgOJNsxxMP2HAmHu5K/oFFUewxr9XOFiPFX
         iwzO8/ahGcdMivZDnKYkKgyi/nbApdAF5ivdi3WQAjfQF7R9ZWeTf6igd4n3FCpR+Qc5
         fIOQ==
X-Gm-Message-State: ANoB5pk/k/1o0dvMZ8u//FHxPqqAl00prQbPfF9j82W3D6WJRJsE6LED
        zL30+H3LDamd2K157VCkQ1MyNVlTW7CtTm+HDZJysM9iFCA=
X-Google-Smtp-Source: AA0mqf6zJoGirhigKD2kDvLydGV2Js8wZTzDP2PmwKIEDjisKeGR+HGvUm+duDEidzaBoUk7Fs/yq4fvk7fY1+c1Ar4=
X-Received: by 2002:a63:224b:0:b0:45c:562f:b2b9 with SMTP id
 t11-20020a63224b000000b0045c562fb2b9mr19864447pgm.245.1668598486574; Wed, 16
 Nov 2022 03:34:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1668129763.git.william.gray@linaro.org> <1805d1ddb5bbce8e86164e66421ddde481cce4f9.1668129763.git.william.gray@linaro.org>
 <Y3DlsTAQMi6kKObJ@smile.fi.intel.com> <Y3DvUaA7YYAsypGv@fedora>
In-Reply-To: <Y3DvUaA7YYAsypGv@fedora>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Wed, 16 Nov 2022 12:34:35 +0100
Message-ID: <CA+HBbNHs+RJ_AwUP-8Ju=-HF-4sO=dKcrDUu1BfbE7Pb4kVeLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] gpio: regmap: Always set gpio_chip get_direction
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        michael@walle.cc, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 2:21 PM William Breathitt Gray
<william.gray@linaro.org> wrote:
>
> On Sun, Nov 13, 2022 at 02:40:17PM +0200, Andy Shevchenko wrote:
> > On Thu, Nov 10, 2022 at 08:55:50PM -0500, William Breathitt Gray wrote:
> > > If you only have reg_dat_base set, then it is input-only; if you only
> > > have reg_set_base set, then it is output-only. Thus, we can always set
> > > gpio_chip get_direction to gpio_regmap_get_direction and return
> > > GPIO_LINE_DIRECTION_IN/GPIO_LINE_DIRECTION_OUT given the respective
> > > register base addresses configuration.
> >
> > Seems legit to me. Have you checked if we have any gpio-regmap drivers that
> > have something like this in their configuration already? In such cases we need
> > to be sure they behave as expected.
> >
> > From the code perspective:
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> I see gpio-sl28cpld has two device types SL28CPLD_GPO (output-only) and
> SL28CPLD_GPI (input-only); gpio-tn48m similarly has two device types
> TN48M_GPO (output-only) and TN48M_GPI (input-only). It doesn't look like
> the change in this patch will cause problems for them, but I'll let
> Michael Walle and Robert Marko comment if they see issues here.

Hi, sorry for the late reply.
This should work fine for TN48M.

Regards,
Robert
>
> William Breathitt Gray
>
> > > Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> > > ---
> > >  drivers/gpio/gpio-regmap.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
> > > index 6383136cbe59..f907c9c19fce 100644
> > > --- a/drivers/gpio/gpio-regmap.c
> > > +++ b/drivers/gpio/gpio-regmap.c
> > > @@ -111,6 +111,11 @@ static int gpio_regmap_get_direction(struct gpio_chip *chip,
> > >     unsigned int base, val, reg, mask;
> > >     int invert, ret;
> > >
> > > +   if (gpio->reg_dat_base && !gpio->reg_set_base)
> > > +           return GPIO_LINE_DIRECTION_IN;
> > > +   if (gpio->reg_set_base && !gpio->reg_dat_base)
> > > +           return GPIO_LINE_DIRECTION_OUT;
> > > +
> > >     if (gpio->reg_dir_out_base) {
> > >             base = gpio_regmap_addr(gpio->reg_dir_out_base);
> > >             invert = 0;
> > > @@ -265,8 +270,8 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
> > >     else if (gpio->reg_set_base)
> > >             chip->set = gpio_regmap_set;
> > >
> > > +   chip->get_direction = gpio_regmap_get_direction;
> > >     if (gpio->reg_dir_in_base || gpio->reg_dir_out_base) {
> > > -           chip->get_direction = gpio_regmap_get_direction;
> > >             chip->direction_input = gpio_regmap_direction_input;
> > >             chip->direction_output = gpio_regmap_direction_output;
> > >     }
> > > --
> > > 2.38.1
> > >
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >



-- 
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
