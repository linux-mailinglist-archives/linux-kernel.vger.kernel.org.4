Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A97E6AB102
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 15:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjCEObP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 09:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjCEObN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 09:31:13 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C340510271;
        Sun,  5 Mar 2023 06:31:11 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-172afa7bee2so8716484fac.6;
        Sun, 05 Mar 2023 06:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678026671;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iLNqvkQlPnIR/APHKTv2kM9g4sr2SoXTzXR+UI/Z6gI=;
        b=FmdRV5PKZ//h/svqkuQi4Z3pnEO4T8hnizDPFcF1nb0jbtc1uxvEIGlX6+SDpLCx9N
         gFRhfv1WRdUx02lj7vH5YNdjYSqRuhnV5FclN+0K00i4Kxg6SXtepLQu6GrUY50C832i
         EiF4S+jA1g6KRw6wi3OpA93p9ceu1l+M93NgJBCsrcWAl567xgC9/s0Ff+aCOmdfRuwi
         XzC+LXGQigsKbQZKxgJaYUwS3OnDP9Zr2NEWF57dSY3fSmHX9imWNuhsp6ZOjPIVq5X/
         B0uRWQGZQHP+nUkujCJGH6y/clIR0QpNXqztzMXa184g+LrjlNF5louIAnNGQi3DO8IV
         3YGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678026671;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iLNqvkQlPnIR/APHKTv2kM9g4sr2SoXTzXR+UI/Z6gI=;
        b=wHSrLtxI5mLsZu3P419vHyVGLCDPgQ+KmXtCIzh+RePc3SviOInCjvRiPvQtRUUqM2
         uQ7X/a5gxhRH3ZfwCEjYdfJG+Wc7a7FUWb4hHK6U3z5F0wuD2o9zUxMu6YA/hW0f+Hnp
         Tn9WFsptYL7PPBFTptBE1JlcOmNU3k4Yq8KQT6RIlT+YHY4HzfPu6inwv7FFpXT8eBoE
         l2FjgvwBB6ljE0WT9jyTK6QBQoNWF2ITpq+QeFHczjfxmWOM7w23O3p12B0ZiN0CJJ5K
         m8veODXL15Wi3jpFBglS39yiWxguGnPXDuixCnCKPEc74kVwgiTGckX0nmi92hmyuovi
         G4hw==
X-Gm-Message-State: AO0yUKVb+JMt9xHoP5H0+6yCXRe4d0u+mWFqUsBktm+ftX+jNb17MQpY
        OzrmDpb9HW1LysvUP42jPsU=
X-Google-Smtp-Source: AK7set/T3JLL8ZmcIt8S0a9GBjZH2KGWRQJeefAPX/9NhUh+844MYFCz8o3Zd4hCx0UMawdbkx79CA==
X-Received: by 2002:a05:6870:14d5:b0:172:5a8b:b43c with SMTP id l21-20020a05687014d500b001725a8bb43cmr4834291oab.49.1678026670996;
        Sun, 05 Mar 2023 06:31:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u10-20020a4ae68a000000b00524f47b4682sm2915395oot.10.2023.03.05.06.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 06:31:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 5 Mar 2023 06:31:08 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: s3c2410_wdt: Use Use
 devm_clk_get[_optional]_enabled() helpers
Message-ID: <891023d7-9510-445e-9053-ad5c0398d350@roeck-us.net>
References: <20230304165653.2179835-1-linux@roeck-us.net>
 <93d115a2-702d-7d68-cd88-98f1c9f03f95@wanadoo.fr>
 <431a8ae1-54a7-e71a-484d-cab618a2a1c4@roeck-us.net>
 <20230305111500.jvass6ymkity4nnd@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230305111500.jvass6ymkity4nnd@pengutronix.de>
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

On Sun, Mar 05, 2023 at 12:15:00PM +0100, Uwe Kleine-König wrote:
> Hello Guenter,
> 
> On Sat, Mar 04, 2023 at 02:10:47PM -0800, Guenter Roeck wrote:
> > On 3/4/23 13:46, Christophe JAILLET wrote:
> > > Le 04/03/2023 à 17:56, Guenter Roeck a écrit :
> > > > The devm_clk_get[_optional]_enabled() helpers:
> > > >      - call devm_clk_get[_optional]()
> > > >      - call clk_prepare_enable() and register what is needed in order to
> > > >        call clk_disable_unprepare() when needed, as a managed resource.
> > > > 
> > > > This simplifies the code and avoids the calls to clk_disable_unprepare().
> > > > 
> > > > While at it, use dev_err_probe consistently, and use its return value
> > > > to return the error code.
> > > > 
> > > > Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > > ---
> > > >   drivers/watchdog/s3c2410_wdt.c | 45 +++++++---------------------------
> > > >   1 file changed, 9 insertions(+), 36 deletions(-)
> > > > 
> > > > diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> > > > index 200ba236a72e..a1fcb79b0b7c 100644
> > > > --- a/drivers/watchdog/s3c2410_wdt.c
> > > > +++ b/drivers/watchdog/s3c2410_wdt.c
> > > > @@ -661,35 +661,17 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
> > > >       if (IS_ERR(wdt->reg_base))
> > > >           return PTR_ERR(wdt->reg_base);
> > > > -    wdt->bus_clk = devm_clk_get(dev, "watchdog");
> > > > -    if (IS_ERR(wdt->bus_clk)) {
> > > > -        dev_err(dev, "failed to find bus clock\n");
> > > > -        return PTR_ERR(wdt->bus_clk);
> > > > -    }
> > > > -
> > > > -    ret = clk_prepare_enable(wdt->bus_clk);
> > > > -    if (ret < 0) {
> > > > -        dev_err(dev, "failed to enable bus clock\n");
> > > > -        return ret;
> > > > -    }
> > > > +    wdt->bus_clk = devm_clk_get_enabled(dev, "watchdog");
> > > > +    if (IS_ERR(wdt->bus_clk))
> > > > +        return dev_err_probe(dev, PTR_ERR(wdt->bus_clk), "failed to get bus clock\n");
> > > >       /*
> > > >        * "watchdog_src" clock is optional; if it's not present -- just skip it
> > > >        * and use "watchdog" clock as both bus and source clock.
> > > >        */
> > > > -    wdt->src_clk = devm_clk_get_optional(dev, "watchdog_src");
> > > > -    if (IS_ERR(wdt->src_clk)) {
> > > > -        dev_err_probe(dev, PTR_ERR(wdt->src_clk),
> > > > -                  "failed to get source clock\n");
> > > > -        ret = PTR_ERR(wdt->src_clk);
> > > > -        goto err_bus_clk;
> > > > -    }
> > > > -
> > > > -    ret = clk_prepare_enable(wdt->src_clk);
> > > > -    if (ret) {
> > > > -        dev_err(dev, "failed to enable source clock\n");
> > > > -        goto err_bus_clk;
> > > > -    }
> > > > +    wdt->src_clk = devm_clk_get_optional_enabled(dev, "watchdog_src");
> > > > +    if (IS_ERR(wdt->src_clk))
> > > > +        return dev_err_probe(dev, PTR_ERR(wdt->src_clk), "failed to get source clock\n");
> > > >       wdt->wdt_device.min_timeout = 1;
> > > >       wdt->wdt_device.max_timeout = s3c2410wdt_max_timeout(wdt);
> > > > @@ -710,7 +692,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
> > > >                    S3C2410_WATCHDOG_DEFAULT_TIME);
> > > >           } else {
> > > >               dev_err(dev, "failed to use default timeout\n");
> > > > -            goto err_src_clk;
> > > > +            return ret;
> > > 
> > > Hi,
> > > 
> > > Nit: this also could be "return dev_err_probe()"
> > > 
> > > >           }
> > > >       }
> > > > @@ -718,7 +700,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
> > > >                      pdev->name, pdev);
> > > >       if (ret != 0) {
> > > >           dev_err(dev, "failed to install irq (%d)\n", ret);
> > > > -        goto err_src_clk;
> > > > +        return ret;
> > > 
> > > Nit: this also could be "return dev_err_probe()"
> > > 
> > 
> > The primary reason to call dev_err_probe() is that the error may be
> > -EPROBE_DEFER, in which case the error message is suppressed.
> > That is not the case for those two functions; they never return
> > -EPROBE_DEFER. Calling dev_err_probe() would give the false impression
> > that the functions _might_ return -EPROBE_DEFER.
> 
> That is subjective. In my book dev_err_probe() handling -EPROBE_DEFER is
> only one aspect. Another is that using it allows to have return and error
> message in a single line and also that if already other exit paths use
> it to get a consistent style for the emitted messages. Having said that
> *I* wouldn't assume that the previous call might return -EPROBE_DEFER
> just because dev_err_probe() is used.
> 
> Having said that, I also don't think there is much harm if someone
> thinks that a given function (here devm_request_irq()) might return
> -EPROBE_DEFER.
> 

I guess we'll have to agree to disagree.

Guenter
