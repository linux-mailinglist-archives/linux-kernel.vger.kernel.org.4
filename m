Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68A467E6DB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbjA0Ng3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjA0Ng1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:36:27 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C02416AE2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:36:25 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-50660e2d2ffso67386197b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lm/eKWA7nHZbFTBeP8HSFE1ZhC80UbaJbWzWM/DYvEY=;
        b=BisZtvp+WU+ShLvP3I22aaq18YE/l/TkOw+2mCy4ukjPx6MncMr3F9Daz1CCvviroc
         iXvzrCfp3Xi7y6KwebzWm/c2OkAk2REum6hp9Z5cRuZOe8WHWSHG62dgDgu2EY0QBjtU
         gGHj1fHgzErEQ0A59YAzSnD6gjCdGpwr7IAiN0xyfXAwgLDcBS5YZVH7Ln/mjEwRXzGG
         0G+7uw3p/BamzKZyP9Jk3FUU4maF5JVmRlFe9qAbVAndg706C5knJw68LFlcaDjSGX2r
         VW6QCPJ9QpxRGV+P3FyDncclkjGaXfpCfPBk5yqdtpTZrbE8dGHNatviN9MhYlsY+yOE
         WOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lm/eKWA7nHZbFTBeP8HSFE1ZhC80UbaJbWzWM/DYvEY=;
        b=6IFYzF6E5NeMfn11M5WTmP5MAesZipw/k8Ys5qYMRvvQMIhEnmgy2xXWQ1oBeNjURN
         08pFG6NeWXeA/ugzOpb+oiVeUd2eeHrqT16OMCgi4kRD869XwjzsJR4ncA/GiQoUabX0
         wTe+r20Qz+F/bTi5S8AgmGlgjTLtwJ9xO4Mllr0vhcnWzOdD6aYyEVH259j3QaV9WTSI
         m01gBvn/+4Rf9jKe2hoDFS2QdKtPlnKNaHcboHQVwVfJ3U4mUiFioYrCZptmfKf6oJL9
         Ju8IK+ev3Xl8EmstCoVm6uxV9lIAAA+GAv7BTyJ4bq3132j+ZFtmtyaWI92mkCb8ff+X
         mTMg==
X-Gm-Message-State: AFqh2kr3aw7rqbR2vVXAwDCka0BLS98QseYTb2yiKbWspN8fFRbM3wEu
        7zqvQB3EliovXmX/UrGVL/6SFmcW8MotKGUveou8qA==
X-Google-Smtp-Source: AMrXdXsvsMo+RSYvpOF8LTfpgwn21rd/yE1KiL3zhHjBbnv+ngzGNNuYOcljzya2rYscdB+tNAcQ8WeslCISgqryo9I=
X-Received: by 2002:a81:6842:0:b0:4ff:e4bc:b56f with SMTP id
 d63-20020a816842000000b004ffe4bcb56fmr3635887ywc.488.1674826584821; Fri, 27
 Jan 2023 05:36:24 -0800 (PST)
MIME-Version: 1.0
References: <20230127101149.3475929-1-arnd@kernel.org> <20230127101149.3475929-6-arnd@kernel.org>
In-Reply-To: <20230127101149.3475929-6-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Jan 2023 14:36:13 +0100
Message-ID: <CACRpkdaUfjWp=DFajpacyfK7vi==r1YSZ27m3ERiuZj7SB7Dww@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] gpiolib: remove legacy gpio_export
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:12 AM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> There are only a handful of users of gpio_export() and
> related functions.
>
> As these are just wrappers around the modern gpiod_export()
> helper, remove the wrappers and open-code the gpio_to_desc
> in all callers to shrink the legacy API.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
