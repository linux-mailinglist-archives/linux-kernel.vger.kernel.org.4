Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3185B8B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiINPP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiINPP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:15:27 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EFC7C33F;
        Wed, 14 Sep 2022 08:15:25 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id d64-20020a17090a6f4600b00202ce056566so9897344pjk.4;
        Wed, 14 Sep 2022 08:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=y+CEF9gRDb/EgFNm7dVs85bWtFGbC7pYw1WXkO8Kgic=;
        b=Bx+K1Xd4JdTI+J6lOPG7z14pA2cfGrdc0T58n8zTv46xxhszlhZ9q6Y53j0XSldANR
         9rMJuyyPaCNxRwK1xoF2z3J9wt+2GREEB3tr4KM29ZEpalyNp1lB8DGJMLq/RyKQCE7a
         hO03wveC8kAW5iZ6QCjQS6bD7qPF/zEF+zXaOwURh6Gu0qnwbtOKsglhNOMhy266Q72g
         aixy2IPT7rrvsBy/b89QhYNDXj+pyznynm7Tt/EsGvphPtOEY/ItfxnytpPxwTsGcfWd
         EzIpeAtyB69xA+opVlczX7+xjYE0BSurTIITsKK/9RzscCFZLOpK1mf6nTjFkTZtIW4q
         Y5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=y+CEF9gRDb/EgFNm7dVs85bWtFGbC7pYw1WXkO8Kgic=;
        b=ilC5zeGNuyKdjYQf23ebGDYhoDBRVEfUknIHE3ftT3PfLbPXrytMPmBywwQkA0VSmP
         uXF2zbIIlXAwpiA1F0SpcWLe2mwenUsdvUxNuYSOmntWIK1a2I3y3QvACk5PukGS2Znu
         kk4Q+ZBLHcqoBBQtJaBZ5w2I5znyQSjzQNNfzrilP61W0iBmJdE9hcr1cazX1FOH8JPk
         Bh2GclJGy79F5vdGZliahbe/zPVdA3YEL/2FzksgMGv764Z0/4hqWH81Bf7pa6+PqplG
         ObaovktrC+/USVn8q/wQoAvl+bWQEbO6xJrYfS+9/iBtQ6VUZa4KkQYhsSfYVeiQIuar
         hqzg==
X-Gm-Message-State: ACrzQf0hZUZibedseSK2TEIAFVHAM0J/atAX6s6qzkb3sRKXTebSV+9c
        3yA+zbmjLk1cwbJtqkPzg7DrToen9GVcwQ==
X-Google-Smtp-Source: AMsMyM4FnQudPsz/6Ns3NbXnqQwFSaWR4bLRESzg2I2W7aK2SrNRAlR0goghAKFoeu22XXgNIu+wog==
X-Received: by 2002:a17:90b:1c8e:b0:1f7:524f:bfcc with SMTP id oo14-20020a17090b1c8e00b001f7524fbfccmr5387467pjb.132.1663168524927;
        Wed, 14 Sep 2022 08:15:24 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:2f68:fe7:a2e6:7595])
        by smtp.gmail.com with ESMTPSA id 7-20020a630207000000b0042f62120c1bsm9781769pgc.17.2022.09.14.08.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 08:15:24 -0700 (PDT)
Date:   Wed, 14 Sep 2022 08:15:21 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] Input: auo-pixcir-ts - switch to using gpiod API
Message-ID: <YyHwCSTNK2jCvJyg@google.com>
References: <20220914141428.2201784-1-dmitry.torokhov@gmail.com>
 <20220914141428.2201784-2-dmitry.torokhov@gmail.com>
 <2115487.irdbgypaU6@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2115487.irdbgypaU6@phil>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 05:04:14PM +0200, Heiko Stuebner wrote:
> Am Mittwoch, 14. September 2022, 16:14:25 CEST schrieb Dmitry Torokhov:
> > This switches the driver to gpiod API and drops uses of of_get_gpio() API.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/input/touchscreen/auo-pixcir-ts.c | 47 ++++++++++-------------
> >  1 file changed, 20 insertions(+), 27 deletions(-)
> 
> [...]
> 
> > @@ -578,23 +566,28 @@ static int auo_pixcir_probe(struct i2c_client *client,
> >  
> >  	input_set_drvdata(ts->input, ts);
> >  
> > -	error = devm_gpio_request_one(&client->dev, ts->gpio_int,
> > -				      GPIOF_DIR_IN, "auo_pixcir_ts_int");
> > +	ts->gpio_int = devm_gpiod_get_index(&client->dev, NULL, 0, GPIOD_IN);
> > +	error = PTR_ERR_OR_ZERO(ts->gpio_int);
> >  	if (error) {
> > -		dev_err(&client->dev, "request of gpio %d failed, %d\n",
> > -			ts->gpio_int, error);
> > +		dev_err(&client->dev,
> > +			"request of int gpio failed: %d\n", error);
> >  		return error;
> >  	}
> >  
> > -	error = devm_gpio_request_one(&client->dev, ts->gpio_rst,
> > -				      GPIOF_DIR_OUT | GPIOF_INIT_HIGH,
> > -				      "auo_pixcir_ts_rst");
> > +	gpiod_set_consumer_name(ts->gpio_int, "auo_pixcir_ts_int");
> > +
> > +	/* Take the chip out of reset */
> > +	ts->gpio_rst = devm_gpiod_get_index(&client->dev, NULL, 1,
> > +					    GPIOD_OUT_LOW);
> 
> hmm, is this really equivalent? It looks like above we're startig
> with GPIOF_INIT_HIGH, while here it is LOW?

Yes, I believe the behavior will not change. You need to remember that
legacy gpio API operates on raw line states, whereas gpiod API is
normally logical state that gets converted to raw state (and the
conversion takes into account the polarity).

Here we are dealing with ACTIVE_LOW gpio, so setting it into logical
"low" (== inactive) means that the raw state is "high", as it was with
gpio_request_oneio_request_one(...GPIOF_DIR_OUT | GPIOF_INIT_HIGH, ...);

Thanks.

-- 
Dmitry
