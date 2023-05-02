Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D866F3B40
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 02:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbjEBAO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 20:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEBAO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 20:14:58 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EADD26BC;
        Mon,  1 May 2023 17:14:57 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b5c830d5eso2220564b3a.2;
        Mon, 01 May 2023 17:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682986497; x=1685578497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DlmkpCTJAM9m+WaxmUGgbBJffV5nwdaVwcHKWpPpodo=;
        b=VZBFcACTB0mSB95izkTXcw3w90PVe4FSt6irvY3YD36Kh3sdEHLu+XCqrisqdiqX8u
         ASb717w/1oPNoi/qHwYdiaBhvdVZuimYQQWx8Ka/j2C+x+hotUcGlIT8myXkN/B8+/Qj
         wYd2C5wgWHlsBQstMS59HXSMQ+nZnYju/z5WVaRo9nhEhfJ+IJBG9q0sHXmvEe1a73y3
         VX4L85OIAjA3FoZaUp3idjOjr+bHVDf6IBdnbLlEE0H1heo7NydXVoEBq67rgwcBnW/W
         T5y4Z/30aPoJ1GefmOeNObiLYQ9oBrwZ0C1aBok42Ycm7iB2v4BeH/Vra5FaG70avltG
         gZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682986497; x=1685578497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DlmkpCTJAM9m+WaxmUGgbBJffV5nwdaVwcHKWpPpodo=;
        b=YJEtV8GYRqNwBd2muxlily5VWCIals7PDcx3PRP1iwpHk6Qx9mDlRe5Lsu/G2NhhXu
         6qTLowcbW7T0lG1vCG0MWmj2rB3hKDrZKOXNFE985T15cmSvDj6JQt+ukoKEKKrh5gaP
         uT0CcUwLUs9VFTgOriM4K1fGVtCD/DcnYcVYFQcnOWF7l4fa1bM6dD9u0cLPfSQ3S6uq
         MLQGkZN11kT23ganRpQWsEFE6vT5x5hKa+fYmInkM7Ujte/H74FyI/3aiWqW1h5Ykls4
         7eqL4s2NrSWqhwSjZgh1eufe+FsSI4il8AExbvJ3Ip2LYw67iXkkpJ2/84znAqit+hGb
         Lwfg==
X-Gm-Message-State: AC+VfDwHCWqqeH52NwGEG0ysjl7cI8X77lzbwcPbFmSHKcAzCt0/K4pA
        uSmfWpkV8FeLQvcrtC3n528zzK+QZHo=
X-Google-Smtp-Source: ACHHUZ60gWc8pHk/R7OLqH4J/htwyxjd/EDYOz6TmZ13BQIrcUfgUlgu4GkgOm8JZlWoI+JIcEy8iQ==
X-Received: by 2002:a05:6a00:1a88:b0:63b:6149:7ad6 with SMTP id e8-20020a056a001a8800b0063b61497ad6mr19975283pfv.34.1682986496685;
        Mon, 01 May 2023 17:14:56 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b6ce:736b:e4f7:adb])
        by smtp.gmail.com with ESMTPSA id u10-20020a62d44a000000b00637ca3eada8sm20470669pfl.6.2023.05.01.17.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 17:14:56 -0700 (PDT)
Date:   Mon, 1 May 2023 17:14:53 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Maximilian Weigand <mweigand@mweigand.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH v2 4/6] Input: cyttsp5 - properly initialize the device
 as a pm wakeup device
Message-ID: <ZFBV/ZfxumlQZHGk@google.com>
References: <20230501113010.891786-1-mweigand@mweigand.net>
 <20230501113010.891786-5-mweigand@mweigand.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501113010.891786-5-mweigand@mweigand.net>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maximilian,

On Mon, May 01, 2023 at 01:30:08PM +0200, Maximilian Weigand wrote:
> When used as a wakeup source the driver should be properly registered
> with the pm system using device_init_wakeup.

This is an I2C device and I2C core already handles setting up a device
as a wakeup source, this patch is not needed as far as I can tell.

> 
> Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
> Reviewed-by: Alistair Francis <alistair@alistair23.me>
> ---
>  drivers/input/touchscreen/cyttsp5.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
> index 55abf568bdf6..f701125357f0 100644
> --- a/drivers/input/touchscreen/cyttsp5.c
> +++ b/drivers/input/touchscreen/cyttsp5.c
> @@ -830,6 +830,9 @@ static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
>  		return error;
>  	}
>  
> +	if (device_property_read_bool(dev, "wakeup-source"))
> +		device_init_wakeup(dev, true);
> +
>  	error = cyttsp5_startup(ts);
>  	if (error) {
>  		dev_err(ts->dev, "Fail initial startup r=%d\n", error);
> -- 
> 2.39.2
> 

Thanks.

-- 
Dmitry
