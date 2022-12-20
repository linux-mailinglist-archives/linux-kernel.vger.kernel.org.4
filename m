Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E7F652642
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiLTS34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbiLTS30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:29:26 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5315B1E3CE;
        Tue, 20 Dec 2022 10:29:10 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so17338853pje.5;
        Tue, 20 Dec 2022 10:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=18M+bnidS9gbp3O+Lgyd3nc6n99jiuwuByOHfklyIeY=;
        b=jJMGzq9o67HGY4eYH55ebzeww9nPj/VgiZQTWEh3LKIy5Lwz8cRHWZ/AU1g+GnChgs
         95U8jsf0wlPDY5nZjo+wK63g0G1+ggSuiSTvLdJ73yaggyqsRxcJe3Lici10EehClS9J
         OGmZWPSA+FMgped0pHPpReRwR6egbFXws+uDoMDzzF4WHHgW2jb5gRb2jg+H0X+E2eHd
         /buajIwTXzYsoCykxXF8QT0ijiZQqAPbvqIPIsRsukFhc3/Y3I4MMobqhr+24G3qqH9y
         DqVeArmGKT0m+aCGXirlhN9XkCpSXOP0SOFlxa/dNjgtxwsweC93HeteFOyzf9wzWqIl
         ZH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18M+bnidS9gbp3O+Lgyd3nc6n99jiuwuByOHfklyIeY=;
        b=tkq06MvBSjZQT/KTS9BHXQmkmiWdaLUUGqLqre+9Wj1SnkIbmiIdfrx5kPhFa0YWmR
         iuid0hhIcVP1r7Hfvvk7lZGNGLD++f/98q/54QJpnoF4Orfkuo4gXAQKZfgQ7x6SurM2
         7AxcOrPYWqyEPw5jNCWNV7TgWilQUwrFyaCZWYYrQ9AFOHd5E9C41bwwfiRiGBHTWdgV
         N/JyV95bS/K1rxo+CYr0F4GNLWYkQvPO06lb97UwEpZHb21/4iQUGViClSFvNeia+/Gu
         vphLVB8TmoDhcbow2t7TSoVTtXgU2sX64HuIgwkh9LBx2OfCTPi63ex6QaLG26Y37swO
         157g==
X-Gm-Message-State: ANoB5pkhR1D6aqBVEfrZ6VMvAYeNlo6OhJ46bOy4kmmvgijXdbMD2WgQ
        r3aF1+oVrbALdeJLYfkSRnQ=
X-Google-Smtp-Source: AA0mqf6Dc//fU/JVzBWR0T4cb8gfkyuykpSic50xjHo4VhUwC9Me8j5xU6hpWOHZZ6UyWT6KPht1nQ==
X-Received: by 2002:a05:6a21:158a:b0:9d:efbe:a116 with SMTP id nr10-20020a056a21158a00b0009defbea116mr29986227pzb.38.1671560949650;
        Tue, 20 Dec 2022 10:29:09 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:7206:404e:4820:d175])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902710900b0019117164732sm6014437pll.213.2022.12.20.10.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 10:29:09 -0800 (PST)
Date:   Tue, 20 Dec 2022 10:29:06 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] gpiolib: of: remove of_get_gpio[_flags]() and
 of_get_named_gpio_flags()
Message-ID: <Y6H+8vss7YPgOrMF@google.com>
References: <20221219192016.1396950-1-dmitry.torokhov@gmail.com>
 <20221219192016.1396950-4-dmitry.torokhov@gmail.com>
 <Y6G/cypRVrpmjeqI@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6G/cypRVrpmjeqI@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 03:58:11PM +0200, Andy Shevchenko wrote:
> On Mon, Dec 19, 2022 at 11:20:15AM -0800, Dmitry Torokhov wrote:
> > There are no more users of these APIs in the mainline kernel, remove
> > them. This leaves of_get_named_gpio() as the only legacy OF-specific
> > API.
> 
> ...
> 
> > -	desc = of_get_named_gpiod_flags(np, list_name, index, flags);
> > +	desc = of_get_named_gpiod_flags(np, propname, index, NULL);
> 
> I didn't get it. The commit message and the subject says there are no more
> users of these APIs, why is it still here? How is it compiled?

gpio vs gpiod strikes again ;) We are removing
of_get_named_gpio_flags(), but of_get_named_gpiod_flags() is a local
helper in gpiolib-of.c and is still very much in use there and I have no
plans removing it.

Thanks.

-- 
Dmitry
