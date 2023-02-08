Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEF068F7AD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjBHTCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjBHTCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:02:13 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA8F53562;
        Wed,  8 Feb 2023 11:02:11 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1636eae256cso24592350fac.0;
        Wed, 08 Feb 2023 11:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3CkjvttcJxIY0nazJWOz4KtDZYgxDBdSI58VEZSwud8=;
        b=pxWHr3nG0KIfx1ogGNKONGdz9u/uUaUZYqlWVSPIdEbWa/ey1QrYiMoGh3q4GzdLrU
         zQe3lI/4g432PEmyxRwODcBcA2xA5cxmd/FaBttmn6VgPwjiMojaF/PRpm3LgGzFjOCE
         qSdf24qAd8xfmcvA8nO3KeFC+E2KVmLAmAI4ycxINZ8NICnJ0fQEP3S+3XsO3tPGnbqZ
         LjYdYi8pvFMaQOmePncaMPsUw6v3pF0NE0n0Hxd0dWUUTefEHaP9Mra1yGGhc16XA5e6
         GS18pTpdIP8JHvegTJ2VpJQk67hvkL3hBjkZx3XKsejZQxYSgPIEzr0qJ7N1ARl+jbj6
         D2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CkjvttcJxIY0nazJWOz4KtDZYgxDBdSI58VEZSwud8=;
        b=JyUTqSzqWy0kvmtRylKN4omENwqNWw5mNj0yQuvRjLt48mQB5LjODzx9z+Rf6o3Zb4
         dBmd3g1x9dYfBCQXtH4l4o3n4foERhd81Drk4aV8DXJsjGQeNlVhI2spzpcfEFG/Ci3K
         6PrQ3nkjdcT4PtWEcUW0dCz++oM9RZFXyo7Rsv3s9fHekyMI+8jpZhfcQaOndznN4qFK
         svqg8kdykW6z+kdvcSNYlzOt6MD3e6QwMYkgW5L18Nyu1wmwhiLUG2OrWPgLewQj7pED
         2bAvbSuDu70BAM7XWksBiLXjoEkhtMMmIu6U92TPon+nmBAD2lNj0F0VT0nQ3us3IyA/
         3H9w==
X-Gm-Message-State: AO0yUKUJsfFUoXQyKJU61I1A38z+htOq+qVh9pmg8gvoILl24qPX2xSP
        HyTyaMHxgHm/bnaiVY5JK6U4pId6saw=
X-Google-Smtp-Source: AK7set8tCGBAuoF9a2McwSjR8kxrioWJ+OpfXMniaX8Q3L7vkdXy2GZpw94uJr/RuxR4hPOUvCDSDw==
X-Received: by 2002:a05:6870:9106:b0:16a:a68:b6a1 with SMTP id o6-20020a056870910600b0016a0a68b6a1mr4875697oae.50.1675882930451;
        Wed, 08 Feb 2023 11:02:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f4-20020a056870d30400b001631c5f7404sm7152968oag.22.2023.02.08.11.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 11:02:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 8 Feb 2023 11:02:08 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joshua Pius <joshuapius@google.com>
Cc:     Joe Tessler <jrt@google.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: cec: i2c: ch7322: Drop of_match_ptr
Message-ID: <20230208190208.GA3078349@roeck-us.net>
References: <20230208184536.3078001-1-linux@roeck-us.net>
 <CAFs7P=hYUZY5Sx5SMF80e5M-+iH=dOG=ExFOgw+cjOWcGgpg=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFs7P=hYUZY5Sx5SMF80e5M-+iH=dOG=ExFOgw+cjOWcGgpg=w@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joshua,

On Wed, Feb 08, 2023 at 01:54:04PM -0500, Joshua Pius wrote:
> Tested-by: stop cecservice, cec-ctl on endeavour
> 
> 

Ah, no, that should have been

Tested-by: Joshua Pius <joshuapius@google.com>

and please do it inline (after Signed-off-by: or Cc:).
Top-posting is discouraged on kernel mailing lists.

Thanks,
Guenter

> 
> 
> Joshua Pius
> 
> Software Developer
> 
> 
> careers.google.com
> 
> <https://ca.linkedin.com/in/joshua-pius>
> <https://www.youtube.com/user/lifeatgoogle>
> <https://www.facebook.com/lifeatgoogle/> <https://twitter.com/lifeatgoogle>
> <https://www.instagram.com/lifeatgoogle>
> 
> <https://news.engineering.utoronto.ca/grads-to-watch-2022/#row14>
> 
> |Learn more about our candidate privacy policy.|
> <https://careers.google.com/privacy-policy/>
> 
> 
> 
> 
> On Wed, Feb 8, 2023 at 1:45 PM Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > The driver does not instantiate on ACPI based systems if OF is disabled.
> > Fix the problem by dropping of_match_ptr.
> >
> > Cc: Joshua Pius <joshuapius@google.com>
> > Fixes: 21b9a47e0ec7 ("media: cec: i2c: ch7322: Add ch7322 CEC controller
> > driver")
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/media/cec/i2c/ch7322.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/cec/i2c/ch7322.c
> > b/drivers/media/cec/i2c/ch7322.c
> > index 34fad7123704..3c6e6496a001 100644
> > --- a/drivers/media/cec/i2c/ch7322.c
> > +++ b/drivers/media/cec/i2c/ch7322.c
> > @@ -589,7 +589,7 @@ MODULE_DEVICE_TABLE(of, ch7322_of_match);
> >  static struct i2c_driver ch7322_i2c_driver = {
> >         .driver = {
> >                 .name = "ch7322",
> > -               .of_match_table = of_match_ptr(ch7322_of_match),
> > +               .of_match_table = ch7322_of_match,
> >         },
> >         .probe_new      = ch7322_probe,
> >         .remove         = ch7322_remove,
> > --
> > 2.39.1
> >
> >
