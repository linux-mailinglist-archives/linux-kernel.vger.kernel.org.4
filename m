Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687C572CD04
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjFLRh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbjFLRgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:36:55 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83B6210E;
        Mon, 12 Jun 2023 10:36:00 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-977e7d6945aso819257566b.2;
        Mon, 12 Jun 2023 10:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686591359; x=1689183359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4XDj0zSgyyWltCqtBRmREw0UunfagEPZkjaup8ya13g=;
        b=OEE9t8mkolbA2bxjRz0u79syIYRXmQRjrKXXm4nvmkx2/LQOlzy0G2WORRDLu0P1Yg
         UG3COTziDEQjkN//x1Do3difKdNzbSZ3ATlTLK4c6fklP2FWWkaXhF68SjdQxsS4ELBb
         u4koSKGLAZV6WpCmb80iqlcrz3hxGtuUubNEGRophrtSqIEC7A3zsWGivKcaZqO1f5xV
         6dMr0d8YcblEQe0L7HVNXtluynM2Qkd3IM1QLaQv1Ked+5H5KppJNb7LZBgGe70NheM8
         YjGBFX4kI+SJQDj5zAZzxZbxyjNKyqYvwL9juq5klVubEQHZHXwJGNj4ac1SkHAjLiJj
         d2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686591359; x=1689183359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XDj0zSgyyWltCqtBRmREw0UunfagEPZkjaup8ya13g=;
        b=L3b7eFM9Sk8NJOd4UWJB2EcMelOHKStByAKJDjiSGmcQ48Q/xVrOv1OlbCy/wfNbip
         xh0rSU/Uj7Rh6KZHaEK7DpPuz2EYf/h4U5vkLFC3Z2Gk7J3XPhYHnRE4fxf/3a3OoGp5
         GKdH294Og0uWFYcBSwSCwyamFlo6IE55Q+xt3586DGYTb4I0r5pPbQFB5fZZeQnLHEex
         oXQ4jZl3JR7pzqBR+8XqFSMZ8jXz7K3eWI1nK5XvmIDOqL+sMnPqLjjkaSVPBkVa4Acc
         jY3eJM1M0+4c7qhaD1FVBRhOTsGFYLCxGuwfEpcf4/5OwrmQEXOeeT0v4um73WPgVEkW
         H+tw==
X-Gm-Message-State: AC+VfDwdfcMSRhWuf/M167k/yG4rSVOhmjLKJ5o4InqFAvYY4wpbp+wT
        Bcy4zLJsbxqxpkHtIUkxCEo=
X-Google-Smtp-Source: ACHHUZ6vyqc25p9VU9PLZgYtZKTHZniKLYJtpRY1meHbFdhDlnXCdjSYu09LpXCSJhbmGUr7b859fQ==
X-Received: by 2002:a17:906:9b84:b0:982:227e:1a16 with SMTP id dd4-20020a1709069b8400b00982227e1a16mr2643834ejc.13.1686591358861;
        Mon, 12 Jun 2023 10:35:58 -0700 (PDT)
Received: from carbian ([2a02:8109:aa3f:ead8::d8a0])
        by smtp.gmail.com with ESMTPSA id i25-20020a170906265900b00977ca5de275sm5600669ejc.13.2023.06.12.10.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 10:35:58 -0700 (PDT)
Date:   Mon, 12 Jun 2023 19:35:55 +0200
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     jic23@kernel.org, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/7] iio: accel: kionix-kx022a: Refactor driver and
 add chip_info structure
Message-ID: <ZIdXe3Vp4uHEGeRr@carbian>
References: <cover.1686578553.git.mehdi.djait.k@gmail.com>
 <3a41a5ae9857cacdb062c398715a5938ccd47014.1686578554.git.mehdi.djait.k@gmail.com>
 <ZIc/uvB1zxNRnuRS@smile.fi.intel.com>
 <ZIdIev+evQUvX5Rg@carbian>
 <ZIdSO7MGk3K/R2u1@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIdSO7MGk3K/R2u1@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

On Mon, Jun 12, 2023 at 08:13:31PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 12, 2023 at 06:31:54PM +0200, Mehdi Djait wrote:
> > On Mon, Jun 12, 2023 at 06:54:34PM +0300, Andy Shevchenko wrote:
> > > On Mon, Jun 12, 2023 at 04:22:08PM +0200, Mehdi Djait wrote:
> 
> ...
> 
> > > >  struct kx022a_data {
> > > > +	const struct kx022a_chip_info *chip_info;
> > > >  	struct regmap *regmap;
> > > 
> > > I would suggest to run bloat-o-meter with this version and if you place
> > > chip_info after regmap. Does it gain us some memory?
> > 
> > I used the bloat-o-meter on the two .ko files (this version and the the
> > one where chip_info after regamp) Is this what you asked for ?
> 
> Yes. I assume the old one is the current as in this patch?

Yes

> If so, you know what to do in the next version :-)

Yes, I will change it in the next version :)

--
Kind Regards
Mehdi Djait
