Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5556FB996
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjEHVZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbjEHVZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:25:18 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4BA2D53;
        Mon,  8 May 2023 14:24:59 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-643b60855c8so2886029b3a.2;
        Mon, 08 May 2023 14:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683581099; x=1686173099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lY7XNuYMi6d2HpAXFIV2eIcbCwEXTGxuVFXmla1j3I0=;
        b=ldNC1OSRN/AiwY6BBBbtAdCSbMbXQnIYQR4qsbC4raWEeRgeENnMRyFj20zl6m6WFL
         Q6KoS616XvezA0CqW46e0Uf91lNFkKzVnmwaje2Xx+hnQi7x1fesRbLXVe1/62T280Tc
         sDNRIrVPzNkaQzyFwh5aikHQSV0+4+e9iFMDlURjhfyMlfSwz/jRaW+gCMpLu54FNZjV
         QpPe5Oz9noUeKtmAnQwynUBQsUf4AEcllT/v+uN9OpbX9vg2d7fOVF5bcnsfmrHi3UoK
         ZGjOQ027L7W1gSJP3C8+Zy+hTcT84BnPbB2sF6y4GidtBDmcoDg2kCx/mZOzINb0v3ot
         fQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683581099; x=1686173099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lY7XNuYMi6d2HpAXFIV2eIcbCwEXTGxuVFXmla1j3I0=;
        b=OV+Wov1h+KTwjzj9Ho2E2HRDOLk3pKVKjzU46x2UntNf3w3D3nF4Ez9I61JMmDtgo8
         tCwmyFIafDCKhryqB2+GUkw0LQ4a5VAbIYL23eKJAsgHu61avk1yHpGo+UCL6mQRqW/h
         p20qmWOS2JSGlE8O0nKqdqfDDxksgm0eOztD0jyHH0+Mc4c8Mx2tgUkW/uJiOtJFrQtb
         cz0+X1oLdKIbQm3gzSgKQmQUoX+bzkeFwKouCtowVw5MkdC5vqUhszxMKkzEbbaewxV4
         Tgkl9rcp64eJWzw60dyMxE7dC8lTeFUmx9nrI0sM7v3909NHBd5CwJEhOqdllUuSDXvq
         aKKg==
X-Gm-Message-State: AC+VfDwJWMKMacmzsEClCNgh9B1zR/e+Jiscd8NBxnqO2E4XU4FGxZGn
        vbp0v2F6ZAkTYWLswOF+6rI=
X-Google-Smtp-Source: ACHHUZ7+bYJ7TcN4WYYGelZV6DAfXOpZUn5DOVtNMVxidcDjp5pAkqw6xFDgud9wDkc0Wljg420qMg==
X-Received: by 2002:a05:6a00:ad0:b0:63b:8a91:e641 with SMTP id c16-20020a056a000ad000b0063b8a91e641mr14966335pfl.11.1683581099188;
        Mon, 08 May 2023 14:24:59 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:4d1:db5a:dbba:cd34])
        by smtp.gmail.com with ESMTPSA id p8-20020a62ab08000000b0064394c2a1d0sm354851pff.209.2023.05.08.14.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 14:24:58 -0700 (PDT)
Date:   Mon, 8 May 2023 14:24:54 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Helge Deller <deller@gmx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH v4 1/4] Input: ads7846 - Convert to use software nodes
Message-ID: <ZFloppofNNcrQtgv@google.com>
References: <20230430-nokia770-regression-v4-0-9b6dc5536b17@linaro.org>
 <20230430-nokia770-regression-v4-1-9b6dc5536b17@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230430-nokia770-regression-v4-1-9b6dc5536b17@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 11:20:06PM +0200, Linus Walleij wrote:
> The Nokia 770 is using GPIOs from the global numberspace on the
> CBUS node to pass down to the LCD controller. This regresses when we
> let the OMAP GPIO driver use dynamic GPIO base.
> 
> The Nokia 770 now has dynamic allocation of IRQ numbers, so this
> needs to be fixed for it to work.
> 
> As this is the only user of LCD MIPID we can easily augment the
> driver to use a GPIO descriptor instead and resolve the issue.
> 
> The platform data .shutdown() callback wasn't even used in the
> code, but we encode a shutdown asserting RESET in the remove()
> callback for completeness sake.
> 
> The CBUS also has the ADS7846 touchscreen attached.
> 
> Populate the devices on the Nokia 770 CBUS I2C using software
> nodes instead of platform data quirks. This includes the LCD
> and the ADS7846 touchscreen so the conversion just brings the LCD
> along with it as software nodes is an all-or-nothing design
> pattern.
> 
> The ADS7846 has some limited support for using GPIO descriptors,
> let's convert it over completely to using device properties and then
> fix all remaining boardfile users to provide all platform data using
> software nodes.
> 
> Dump the of includes and of_match_ptr() in the ADS7846 driver as part
> of the job.
> 
> Since we have to move ADS7846 over to obtaining the GPIOs it is
> using exclusively from descriptors, we provide descriptor tables
> for the two remaining in-kernel boardfiles using ADS7846:
> 
> - PXA Spitz
> - MIPS Alchemy DB1000 development board
> 
> It was too hard for me to include software node conversion of
> these two remaining users at this time: the spitz is using a
> hscync callback in the platform data that would require further
> GPIO descriptor conversion of the Spitz, and moving the hsync
> callback down into the driver: it will just become too big of
> a job, but it can be done separately.
> 
> The MIPS Alchemy DB1000 is simply something I cannot test, so take
> the easier approach of just providing some GPIO descriptors in
> this case as I don't want the patch to grow too intrusive.
> 
> As we see that several device trees have incorrect polarity flags
> and just expect to bypass the gpiolib polarity handling, fix up
> all device trees too, in a separate patch.
> 
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Fixes: 92bf78b33b0b ("gpio: omap: use dynamic allocation of base")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v4:
> - Fix all board file polarity flags to be active low, because
>   this pendown signal is active low.
> - Fix all erroneous device trees too.
> - Drop some unnecessary commas.
> ChangeLog v2->v3:
> - Drop leftover OF ifdefs no longer needed and causing compile
>   errors.
> ---
>  arch/arm/mach-omap1/board-nokia770.c    |  98 +++++++++++++++++----------
>  arch/arm/mach-pxa/spitz.c               |  11 +++-
>  arch/mips/alchemy/devboards/db1000.c    |  11 +++-
>  drivers/input/touchscreen/ads7846.c     | 113 ++++++++++++--------------------

For input:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

In general:

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
