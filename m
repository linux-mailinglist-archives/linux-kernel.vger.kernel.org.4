Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCC66FB9A6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjEHV2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjEHV2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:28:22 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536461BC9;
        Mon,  8 May 2023 14:28:08 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-51452556acdso3269664a12.2;
        Mon, 08 May 2023 14:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683581287; x=1686173287;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CBp9p/uYaxi06hfRt45Jfs/gvw/XMrWCbWQr51fRckI=;
        b=G+jtUkmJEGKtOIVlB1RLnusjVD7s5WH8jEykBI3T+p3wREB6Hz7cddVts23Rk9aenL
         XoXxoQOKK5CspEKZ9YgTwXtSX8Ggara9foZC11GZhmPDCJzrWCRYWXSwyubdOXzVSHWM
         ftnwFgcGAeyMrP1VA51kR5vUlAxFvsbXBQ+ogyCGSfzGTAyTHlc3a85ujRd0nP/Akg+g
         hUDc8bgPWakGrLPBIdziZpqnPp2aPO6qHtY5LskY1H9Ufzo/7if59XlgnH2qU8lGU7E2
         1OSxXrsAUX80sO1KkU8iUVZVxcGQJLG/dBQs3GODDg1tYGRPXThJN5QAfwPxUStfyJZ+
         euxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683581287; x=1686173287;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBp9p/uYaxi06hfRt45Jfs/gvw/XMrWCbWQr51fRckI=;
        b=XCV4yPKsTkjV48tAZ6fI6GviEc2eDSzv+vZpX3e8+Hx+GYZrAdT81eQ6iH3PUlxBLM
         1YoVSLp8eMFzg0704oxhM212kXZK00N44pK+6XheLb9AbUaWVfR9Jzau3IQPNy+FB1HC
         SBQtunBpOAH8J7CYblPoOcZLxtqx8/ZuKiVr9SE7OoDKiM4FWYuvImh/n/hmPmtqh2/a
         Q2KJCzwYieV+up2RO2J/f74BBNZvAkwhhqK5js0e56LSqSAXKUI4JpKSPm/uCRjwUr7n
         Fqo44hKsKyqjp+nY03nyJHV7b7Q18zhFG212ZPKtodx02QHu3kMHktgEyWgmBbKivOBL
         IMGA==
X-Gm-Message-State: AC+VfDz7XZPFc5h6FgH4GTvAo4zzKvA2hkCYvhg6vMURVWWuLKPu3FxJ
        LOwqoq2XsMzJ9msajfihzJA=
X-Google-Smtp-Source: ACHHUZ4SKZcFOEk4rh3wU8Xlt4Wg/5LelB0TU7HIWEOKGANquhYmCFYPj5iGkqtKuBTaj8e5e9UbBQ==
X-Received: by 2002:a17:90a:b401:b0:23b:2c51:6e7 with SMTP id f1-20020a17090ab40100b0023b2c5106e7mr12079044pjr.21.1683581287314;
        Mon, 08 May 2023 14:28:07 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:4d1:db5a:dbba:cd34])
        by smtp.gmail.com with ESMTPSA id g24-20020a17090a579800b0024dee5cbe29sm14992974pji.27.2023.05.08.14.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 14:28:05 -0700 (PDT)
Date:   Mon, 8 May 2023 14:28:01 -0700
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
Subject: Re: [PATCH v3 1/3] Input: ads7846 - Convert to use software nodes
Message-ID: <ZFlpYff6I5V6JiH1@google.com>
References: <20230430-nokia770-regression-v3-0-a6d0a89ffa8b@linaro.org>
 <20230430-nokia770-regression-v3-1-a6d0a89ffa8b@linaro.org>
 <ZFVGMiuRT+e2eVXw@google.com>
 <CACRpkdZUXOTOK9CObdXuHQx4PMD3ykMKco8X5ijchkZ8cEmQvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZUXOTOK9CObdXuHQx4PMD3ykMKco8X5ijchkZ8cEmQvA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 11:23:44PM +0200, Linus Walleij wrote:
> On Fri, May 5, 2023 at 8:08 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> 
> > > -     return !gpio_get_value(ts->gpio_pendown);
> > > +     return !gpiod_get_value(ts->gpio_pendown);
> >
> > This needs to be
> >
> >         return !gpiod_get_value_raw(ts->gpio_pendown);
> 
> There is no such function. The gpio descriptor runpath simply assumes that
> device trees can be trusted.

Sorry, this was supposed to be gpiod_get_raw_value():

https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib.c#L2854

> 
> > I looked at various DTSes we have and they use a mix of active high and
> > active low annotations, so we have to go with the "raw" variant for now,
> > and then update to normal one once we update bad DTSes.
> 
> I just sighed and fixed all the device trees :D

Yeah, we we can land the DT fixes ahead of the driver change that would
be great. Otherwise we need a temporary application of
gpiod_get_raw_value().

> 
> Yours,
> Linus Walleij

-- 
Dmitry
