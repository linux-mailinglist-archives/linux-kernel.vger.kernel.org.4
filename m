Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E657469AFB5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjBQPmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjBQPmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:42:02 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EEC6F3CE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 07:41:59 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-17172b43531so1555501fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 07:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OnUShv/qsWAUV9F/d3j8b7I/+SKaHHXb+u6O+HEKzls=;
        b=RbtqWzn7xoNQQwtVZXN5NjxBw7XqTvqMjQT7A9Uy85lcZnHZTJJIS0VeNTAYV4PTNF
         1jy4uQI3G5QK7FjP5H+BEpZvmqcYMpgCqO8N5CxMwA84b6Fpj5Aky6BSdMe8P0+d9AHC
         GtVScTJLIGXlHhZn0Fq0bMZD7CW3hORR2UWsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OnUShv/qsWAUV9F/d3j8b7I/+SKaHHXb+u6O+HEKzls=;
        b=6nh6OcbsE50LbCS/kSbl1ydoW/cpMBhO2l/ZEndyKLZgkRsV4+Wh/tglxhBH+G/0/J
         2p6TvYDr9MKcHpqYuFkXz5c13a0k2lWTz1gv+LOGeh36s71F5bzre6EWGYE4n7le9CjK
         VPY69A24xslaFyJSdaAPIR43lsbJ8Pzf90IRD3mBYYZL3Bhg3Dftt9yE7fKpG15RrUbq
         ngf2ki7S96MvbSE7vIWmOyjyCO8Am+PZ/ApRkaYu2/6iWPxFEnA/8pSUYfx8aQLvQfs8
         zHKWKk2xBl5jasDT7F9rLbi3xUDEpM08+/HR/Viy2ilDB2DAF1KmTSMrJY1sbCOKp91O
         Pa0g==
X-Gm-Message-State: AO0yUKWP8obKjKDuBejRls9ScoQKsDDaIRC6uSirfjVvH3+DU86j+Gro
        +0Q99AfuCKi1NR40eMBLauY9tkADyhef16D0cRyKnw==
X-Google-Smtp-Source: AK7set/ymXnMI2GPHlf5yoehFffTnCXPRiGP7VIPZAU9KRFd3YQ5Uvtgo5Ia9dmc4tdJ/hSQt0dxaws/S6xTXGW7xU8=
X-Received: by 2002:a05:6871:b12:b0:16e:5f2d:2e55 with SMTP id
 fq18-20020a0568710b1200b0016e5f2d2e55mr463693oab.9.1676648518379; Fri, 17 Feb
 2023 07:41:58 -0800 (PST)
MIME-Version: 1.0
References: <20230217145731.3018148-1-angelo@amarulasolutions.com> <Y++e6IMusukWJNw2@kroah.com>
In-Reply-To: <Y++e6IMusukWJNw2@kroah.com>
From:   Angelo Compagnucci <angelo@amarulasolutions.com>
Date:   Fri, 17 Feb 2023 16:41:22 +0100
Message-ID: <CA+_SqVaTNuco-7re=FQxNiowtWvNgokkXFD3Kmo5U9AFMdz13g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] misc: servo-pwm: driver for controlling servo
 motors via PWM
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 4:36 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 17, 2023 at 03:57:28PM +0100, Angelo Compagnucci wrote:
> > This patch adds a simple driver to control servo motor position via
> > PWM signal.
> > The driver allows to set the angle from userspace, while min/max
> > positions duty cycle and the motor degrees aperture are defined in
> > the dts.
> >
> > Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
> > ---
> >  MAINTAINERS              |   6 ++
> >  drivers/misc/Kconfig     |  11 +++
> >  drivers/misc/Makefile    |   1 +
> >  drivers/misc/servo-pwm.c | 149 +++++++++++++++++++++++++++++++++++++++
>
> You add sysfs files but do not document them in Documentation/ABI/ which
> is required.  Please do so in your next version of this patch.

https://patchwork.ozlabs.org/project/linux-pwm/patch/20230217145731.3018148-2-angelo@amarulasolutions.com/

This patch [2/3] should do what you're asking.

>
> > +static ssize_t degrees_show(struct device *dev, struct device_attribute *attr,
> > +                       char *buf)
> > +{
> > +     struct servo_pwm_data *data = dev_get_drvdata(dev);
> > +
> > +     return snprintf(buf, PAGE_SIZE, "%u\n", data->degrees);
>
> sysfs_emit() please.

Will do.

>
> thanks,
>
> greg k-h



-- 

Angelo Compagnucci

Software Engineer

angelo@amarulasolutions.com
__________________________________
Amarula Solutions SRL

Via le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 (0)42 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

[`as] https://www.amarulasolutions.com|
