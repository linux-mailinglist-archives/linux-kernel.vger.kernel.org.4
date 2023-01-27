Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBBD67E085
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjA0JmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjA0JmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:42:06 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698805269
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:42:05 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id d66so4704530vsd.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gULpff1yEFxypcWVbV9eKIs2PQqZVvxyOk55T8kYBMc=;
        b=eD5Q8ujbKCRs5MBullvkPZOykA+Fnm49r6YgBuyuJWkHNwVvdaBLz4FWiLjcrMbLM/
         bcUfiwYwPHiEzH6y8rcCG/yNHUn4QHlRKJZwV5HoNqvL9RA51A2poAxDWDXoTNJDDo9i
         8LLdGnowh1ZBuV6ru3zY/5YYdrDjCn8QPPX68quXBYAyEEXtioT2KsxUiI9Z5kxspbFR
         xNzPHknhmQ2eFhBFS5faulU+kRO6W5534pdHDLt1tEKOjMb02ufvmZrKf4KJrsp34KoW
         BUJa/ayYiMRrdDsUUz0BgnFY8ua5KmPQRajBVz7EPn6TVduV7Ha/WpSSqkm2ujap530a
         g7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gULpff1yEFxypcWVbV9eKIs2PQqZVvxyOk55T8kYBMc=;
        b=oqMOMTN7fgVnKWeyr+X6ou3fA1Xd2zlWuGe8LWw49XqzbeVdTSoaddMeh/K99w+h3z
         fW8gLncDC1RtO/p7fZ+eXNJJYas1R2AMf5A7ux0AZno1GNWY0GD39KMYWx1Q9G9aPksl
         S6/J1y7v19eMy6CVv2H+VgklI9+D1khJti/am1imI20DiH89IMvfRnPRtjqSSOjqKrH/
         KkxHK17suvCHHP75FxEAmVG3bege32cOhZsVkPWGmBuQ+hi+OHxQ42rZlyKVH2Us6GFa
         4HLvXOIKYCGL34FqbCbeozV8BGFlhatIFbYTeNrsW9OaRyqM6t7DyP7XeT+5c6ptJspE
         XtPQ==
X-Gm-Message-State: AO0yUKWiIio3MvtInDOFFMEAibfOTzlIAmpJbrwpdnh5RIxw9tKOQpq+
        PN3GW1U6rs0o67VAVWYUnn6jpi49mBXo0NZApMWJhA==
X-Google-Smtp-Source: AK7set80EBj1LKnORUBuFFXM6YAgLbkC+2azZ3LmsGPZpBVs+KQBJkc9P63Tvt9BeCwNQspPz0atAaViqlgsjGuAZw8=
X-Received: by 2002:a67:f114:0:b0:3ed:1e92:a8ab with SMTP id
 n20-20020a67f114000000b003ed1e92a8abmr402277vsk.73.1674812524470; Fri, 27 Jan
 2023 01:42:04 -0800 (PST)
MIME-Version: 1.0
References: <20230126132801.2042371-1-arnd@kernel.org> <20230126132801.2042371-3-arnd@kernel.org>
In-Reply-To: <20230126132801.2042371-3-arnd@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 27 Jan 2023 10:41:53 +0100
Message-ID: <CAMRc=MdY8Dn3-JrhyJ-z432dCz-adRcyUtLGpQP=2c6BBzSfXA@mail.gmail.com>
Subject: Re: [PATCH 2/8] gpiolib: coldfire: remove custom asm/gpio.h
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 2:28 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Now that coldfire is the only user of a custom asm/gpio.h, it seems
> better to remove this as well, and have the same interface everywhere.
>
> For the gpio_get_value()/gpio_set_value()/gpio_to_irq(), gpio_cansleep()
> functions, the custom version is only a micro-optimization to inline the
> function for constant GPIO numbers. However, in the coldfire defconfigs,
> I was unable to find a single instance where this micro-optimization
> was even used, and according to Geert the only user appears to be the
> QSPI chip that is disabled everywhere.
>
> The custom gpio_request_one() function is even less useful, as it is
> guarded by an #ifdef that is never true.
>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
