Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FB2623F3B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiKJJ7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiKJJ7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:59:32 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D43E64;
        Thu, 10 Nov 2022 01:59:30 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id v8so765921qkg.12;
        Thu, 10 Nov 2022 01:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JI7gsZFm9X+F8JKYomVs21XGrqaPCtz3TTsCmMHjVTQ=;
        b=FxSoVL8UJYuQxAdJ54FBUWZefIyQrD7rWyS4I1xw2FEdUwjhvN3k4nKGeIEtjtUEqx
         5dzZflR04XUO+mApPT0/oy4gAdWq2ozW1+kaOClh4s50yamZV1tuRUWW8sCfhJqdIaSg
         0evJGdCNrzWjYsc/puv8TaXSbRt+Eb6TnTyGO2qr9hTsBt8yeglHz8+lGYl7F8ta1w5A
         Bh+YRpaToPgZKE4YEXyo3A5czpgfRuXmku0Kv6ByZehl/VG0brvlS7IlREDjW052Zilm
         8toBNfBTtevjy9kkaXEspYCRK4EO2nAtEl96z0xwAAW79Z/HeFcdYCUTW2UruZdILYLz
         ct7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JI7gsZFm9X+F8JKYomVs21XGrqaPCtz3TTsCmMHjVTQ=;
        b=CCYTFTYtKjybcu3Vuhiel8+Ua3hbF6GIQGIOcMz3n/5eMnsyQp0SeKRhOnCMWkJ+cO
         OGhgKWNaWUJS7FgrZtrGkq9VvaLOtkbb6UNQZz8O/ozoXmjK0UW0MKZerXbhpdQnoUzy
         MmZqb+8leG0ZDsHe96F1MvMkeI400d1UaAHQRl5zpFqtQIqQt6g2YX16awdqEvSN3HQh
         UKNxe7OOZmE/5n5KyYNRQo/MoVebmmFZ0ADvhk3er6tUDMaNxe8trU26EUgFoYJ9Z+6M
         JbJHPXcOLhnS/CiIsORGGLBdJDBc6Yi2A73wWwMbZnyG6S7EkjSEp5MkDp/kJYFMqhYU
         5pkA==
X-Gm-Message-State: ANoB5pkQnGdX5l9218Rjd2FJ675a4qQ1t5XljyOFrYQurK7yhFOyIFvC
        DZ8TmwQ/7BvgRjpT89HvbMxdqRNC4GzlujB3r3M=
X-Google-Smtp-Source: AA0mqf5OH9HhH+tUHp4JJfPzMjxfFfG/7ff8QEuIWMsrXTUnrPSZxu0n667jvCFblq0sQISICDGGY/OUtb61G8CF+pU=
X-Received: by 2002:a37:46d3:0:b0:6fb:1454:e2b8 with SMTP id
 t202-20020a3746d3000000b006fb1454e2b8mr4442050qka.383.1668074369893; Thu, 10
 Nov 2022 01:59:29 -0800 (PST)
MIME-Version: 1.0
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
 <20221108142226.63161-5-andriy.shevchenko@linux.intel.com> <20221110072810.meu3cxh5repuglk3@pengutronix.de>
In-Reply-To: <20221110072810.meu3cxh5repuglk3@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Nov 2022 11:58:53 +0200
Message-ID: <CAHp75VeV+ZBQ2M7xrP8o+KxSg9uXbcsDo5=9sU+=WF9muodDvA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] pwm: lpss: Allow other drivers to enable PWM LPSS
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 9:28 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Tue, Nov 08, 2022 at 04:22:24PM +0200, Andy Shevchenko wrote:
> > The PWM LPSS device can be embedded in another device.
> > In order to enable it, allow that drivers to probe
> > a corresponding device.

...

> Now that pwm_lpss_boardinfo lives in a different file, this makes the
> move of pwm_lpss_chip in patch 3 somewhat redundant.

But they are independent changes. At each stage (after each patch) we
should have a finished step, right? Not touching that makes me feel
that the step is half-baked. If you insist I can drop that move from
the other patch.

--=20
With Best Regards,
Andy Shevchenko
