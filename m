Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1576225FE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiKII7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKII7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:59:30 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EC0BF5F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 00:59:29 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id bj12so44785670ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 00:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BHMYDAB7SOPCsQhVODz+CSzsPNokxJ6rB45utAOxtxs=;
        b=vXrbkeONuoJyhqmlNVGaLNPuKfYxVdBOcdsdOM5KpWrBZMTOEJa2qtDG4hDZ/O6AA0
         Tr0ukvFb+r4I7ZqlXqJjyZviweqjNwFbPPtGuCCkpkyyM9uu4UdciR5w8dmp+AAywY/D
         e82EfSvtqY0YyGIOsEQ85oNDYCGwpf+ZaNnu3QTyKFjE1pkOYwwN4yJQq5lil6MMQ0BB
         sG/dMEwjhXDvxH7hzM9G9Q7NaNXThhlLsfXI6n4mg8Skg0gGcsUdh8YXOqR4YSnfKDfq
         /LD9anszmbF5lRIqS0OZ5uVbNiSEyau3f8QtV40SKsolDTtywbu2aIWYsL9fOExxxNk+
         2SKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BHMYDAB7SOPCsQhVODz+CSzsPNokxJ6rB45utAOxtxs=;
        b=uydubNDriRdJojUMJWTaVhswcthvta3s88SD9wNKrsEXONYPZWzaFJ3AwrbHSuqNZe
         Pv0JX2npP9bpSKUvnfmKi6T6+W/4ogOKVrqfLMAjEnNZJBgeefppPWSHB69V0b96/XnR
         rviS0wtQ+5Pq/Y9/wlN1BbLsnSVt0FS+0FLSpfRZ6SxG8cjwHMbd9M/F9f074Ks7pahl
         m80xeWqWsgRqwpKEbw2URMOfkwl3TZAp9tNtVqJ1xVVclSgxPCm28OCLodgvOJNdZEDJ
         PCf6VAfT5GmBKkwEcvZu0LYiVvWHlQcL6N8Dd5mrIEAog4R/Tg6cdASd/lxqL99t99y4
         MD6Q==
X-Gm-Message-State: ACrzQf0NzHEiRgz6h+YKxNAIsyis+kqyayw1BizIgg+/A4BKoPMeqYgC
        zXQNlVk4xLFZYn4tYieLQa0j4akgnpKBOqq1AnVifg==
X-Google-Smtp-Source: AMsMyM4RDdhbWZObgw8kP219Q81vEJT7t01J1Sturs5XpQarS4SsdU5TER14TE9q0WEfUDHDYApBivGySl5+HBgwOmk=
X-Received: by 2002:a17:906:4c4b:b0:7ad:a197:b58e with SMTP id
 d11-20020a1709064c4b00b007ada197b58emr57345528ejw.203.1667984367884; Wed, 09
 Nov 2022 00:59:27 -0800 (PST)
MIME-Version: 1.0
References: <20221108133853.61884-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221108133853.61884-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Nov 2022 09:59:16 +0100
Message-ID: <CACRpkda=Jd_627OZSq1LkVp=6CcOVXvuLPY-5i9HrWXn68-nkA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpiolib: of: Prepare of_gpiochip_add() /
 of_gpiochip_remove() for fwnode
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 8, 2022 at 2:38 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> GPIO library is getting rid of of_node, fwnode should be utilized instead.
> Prepare of_gpiochip_add() / of_gpiochip_remove() for fwnode.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
