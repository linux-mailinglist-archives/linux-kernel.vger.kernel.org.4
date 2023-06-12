Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101FF72CA7E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239266AbjFLPnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbjFLPnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:43:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2422610C7;
        Mon, 12 Jun 2023 08:42:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD27B60C78;
        Mon, 12 Jun 2023 15:42:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E05C433A0;
        Mon, 12 Jun 2023 15:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686584578;
        bh=V+v277y/LQOz1Bd9zPL2sVCJjEZLpKCmRiZipD29G+Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nV8jgN32EqcJ+FTLKjKQrdO+6UGgsibH0hBgFrN3I6uszPhudDY8fexRMZ/07CnjD
         lw3+Zkm13jI3yKUkZjoMGfJ5pOyDmBMs5gf3zBW4D+b/N9gPaFIlklW/M1AXPbIuHi
         lVO0uJpbVnBMPt0l1oOh8+Mn4xkaXfq7/BZ/WA2gDZ+YKD/68mkWciuq/aAA1ZQC8Z
         XNXVERcMaX8v7+avRuFwq04OcQYlfy+QWbhL1dCi9y3fTIaweLBKD4Km0w0kHhGqJc
         zkHM8IZbVti8WBdKOmSeBxI3JVIYXsaBs6M07c2k182ldn5Jb1SPHTdNQ+TRETs3PE
         3hUWZDrc3poZg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4f642a24555so5375902e87.3;
        Mon, 12 Jun 2023 08:42:57 -0700 (PDT)
X-Gm-Message-State: AC+VfDwaeYwc9Fybhw004xuKb5HGn8yzJ0n57AtvcvcmH+FiT7NCNhPg
        SiHS+kb9Smf9gyOuoEOEXkQ021rqlupQPIZEPA==
X-Google-Smtp-Source: ACHHUZ6nK/lGP80l1yVoeQh4mg6RqY5XjAR5DaGsogZyrQ2YZ6G1K4uViCXSD8gcr66iTuqg+9qD1vtGZ+/MAR57VpI=
X-Received: by 2002:a2e:b618:0:b0:2a8:eee0:59f3 with SMTP id
 r24-20020a2eb618000000b002a8eee059f3mr3172291ljn.41.1686584576044; Mon, 12
 Jun 2023 08:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230605125248.279921-1-brgl@bgdev.pl> <CAL_JsqKczF9yYHWjqneBv-y+Qv+O7AkX4gwVG87+aPPazKxtDw@mail.gmail.com>
 <22a21176-f2e2-bce5-2223-97cb095162c5@gmail.com> <98a35030-6dd3-795c-4381-1db4e94a18e4@gmail.com>
In-Reply-To: <98a35030-6dd3-795c-4381-1db4e94a18e4@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 12 Jun 2023 09:42:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKDQy+tq7uDJ9impTr+uetkb7vz-K4BYX8bZBkpvZ=8uQ@mail.gmail.com>
Message-ID: <CAL_JsqKDQy+tq7uDJ9impTr+uetkb7vz-K4BYX8bZBkpvZ=8uQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: demote the hogging log messages to debug
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 11, 2023 at 6:48=E2=80=AFAM Frank Rowand <frowand.list@gmail.co=
m> wrote:
>
> On 6/11/23 07:39, Frank Rowand wrote:
> > On 6/9/23 08:47, Rob Herring wrote:
> >> On Mon, Jun 5, 2023 at 6:53=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
> >>>
> >>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>
> >>> Drivers should be silent when they work correctly. There's no reason =
to
> >>> emit info messages when GPIO lines are hogged. Demote the message to
> >>> debug.
> >>>
> >>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>> Suggested-by: Kent Gibson <warthog618@gmail.com>
> >>> ---
> >>>  drivers/gpio/gpiolib.c |  2 +-
> >>>  drivers/of/unittest.c  | 16 ++++++++--------
> >>>  2 files changed, 9 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> >>> index a7220e04a93e..e4515bda8915 100644
> >>> --- a/drivers/gpio/gpiolib.c
> >>> +++ b/drivers/gpio/gpiolib.c
> >>> @@ -4243,7 +4243,7 @@ int gpiod_hog(struct gpio_desc *desc, const cha=
r *name,
> >>>         /* Mark GPIO as hogged so it can be identified and removed la=
ter */
> >>>         set_bit(FLAG_IS_HOGGED, &desc->flags);
> >>>
> >>> -       gpiod_info(desc, "hogged as %s%s\n",
> >>> +       gpiod_dbg(desc, "hogged as %s%s\n",
> >>>                 (dflags & GPIOD_FLAGS_BIT_DIR_OUT) ? "output" : "inpu=
t",
> >>>                 (dflags & GPIOD_FLAGS_BIT_DIR_OUT) ?
> >>>                   (dflags & GPIOD_FLAGS_BIT_DIR_VAL) ? "/high" : "/lo=
w" : "");
> >>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> >>> index 2191c0136531..0060334a98a7 100644
> >>> --- a/drivers/of/unittest.c
> >>> +++ b/drivers/of/unittest.c
> >>> @@ -1849,19 +1849,19 @@ static void __init of_unittest_overlay_gpio(v=
oid)
> >>>          * driver is registered
> >>>          */
> >>>
> >>> -       EXPECT_BEGIN(KERN_INFO,
> >>> +       EXPECT_BEGIN(KERN_DEBUG,
> >>>                      "gpio-<<int>> (line-B-input): hogged as input\n"=
);
> >>
> >> As debug messages are normally off, I think you can just remove these.
> >
> > This patch is an example of exactly why the message level is the first =
parameter
> > passed to EXPECT_*().  The test results are then _always_ valid, not ju=
st
> > _normally_.
>
> One should never say never.  One should never say always. :-)
>
> Yes, there is still the exception where debug can be enabled independentl=
y
> for drivers/gpio/gpiolib.c  vs for drivers/of/unittest.c.  And dynamic
> debug can make things even more wonky.

If we turned on debug messages for drivers/of/, the unittest would be
hopelessly broken.

Debug messages are special compared to all the other levels as they
are normally off whereas the rest are always on. For the unittest we
should assume they are off.

Rob
