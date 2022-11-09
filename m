Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F53B622609
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiKIJAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiKIJAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:00:02 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FDB1D0C4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:00:00 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z18so26191152edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 01:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Iz+r9yqo9SHV/VNe1RJb+OqpuJmkL2QTLiZG/HMqVuo=;
        b=fgPFGw3I4+H4BjIYJeO6KSbdY2q9VQrkYFbqHjam53bHZTvmpbpXvR+42GyawpNieE
         2+DEO9edMRhiGD6wx3MjrNVNQfcehxnq75dQaiOXKtknBJycGDIdrQUDtI9O9fLm+WP5
         iPalMCT8ONGg5pvFVSXsNrwmXbHEUuFaCcl/H0G6tEoKn/UrG4vC20tvlnPFIiNUMf+g
         d35v6J5Kju+0t1pM6bQXAgKyJ0j5mIMSbO1HvtRc90/6fQ8FcnP99bvzMe48G5I8UBUE
         K1rQCbx9Nz3VQoAsvrLae1WKL/Z0+Q3NUzqIQP0CtQaLdYeHIGg49w5RJUfha+VpBXnL
         rEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iz+r9yqo9SHV/VNe1RJb+OqpuJmkL2QTLiZG/HMqVuo=;
        b=v5+mNSHjnftXHKDUOAkHoD8g6pV9s+s4nbQcT5kvDKuyvcn9DrJMa3nbhEFeQ9iMZ9
         CNhxBkYEVfVTYn2qJFSoStAhy8iJA5ONw/UwItniGhptefa/uPU/twGYrJjuuvTZfWiu
         E/4TTMVqsiDyzbtcPZJr7uCXixJ1xlIQXo2S0n9Eke+lxRi2Sqq9yywpjjmcGZPN2U4C
         fkLRGeZFn191AyLQnPE0Za7S2xIBOALI9czGdWTvmrqHGlysEube2pTF2yz+U1pJfQqB
         BFxM08AbNTA5buUPY4NMs/f2YI1LE1UrFj78pYkiFqfLZeA+7aUxy65CoirUZQ040kIh
         E/fw==
X-Gm-Message-State: ACrzQf0iqTr84JYeD36efF5DDeGd0SCk5czpvLi4FHg+YQGP4H9tWsZQ
        yAOdqhbLJwRxdmgorHZYLBvKVeeepMjwIik5oB4VoAldad4=
X-Google-Smtp-Source: AMsMyM5G7pSTQw6/ibxoxNJ3eAwaFwzhpNv7niA7XULqY84ZqtquUHbyz68wB1vWoJv6Zuv3jFWoewxekHU0hLQ+eWA=
X-Received: by 2002:a05:6402:d0b:b0:458:a244:4e99 with SMTP id
 eb11-20020a0564020d0b00b00458a2444e99mr59365805edb.46.1667984398730; Wed, 09
 Nov 2022 00:59:58 -0800 (PST)
MIME-Version: 1.0
References: <20221108133853.61884-1-andriy.shevchenko@linux.intel.com> <20221108133853.61884-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221108133853.61884-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Nov 2022 09:59:47 +0100
Message-ID: <CACRpkdYEB7e9ADKmrLN2fOG7oQCh2M6YUcEriQTiXufzFhWo2Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpiolib: of: Integrate of_gpiochip_init_valid_mask()
 into gpiochip_init_valid_mask()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 8, 2022 at 2:38 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> In preparation to complete fwnode switch, integrate
> of_gpiochip_init_valid_mask() into gpiochip_init_valid_mask().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
