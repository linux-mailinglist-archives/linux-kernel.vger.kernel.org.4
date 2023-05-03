Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A688D6F57EA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 14:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjECMbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 08:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjECMbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 08:31:13 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B6759CF
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 05:31:11 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-55a5a830238so32139377b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 05:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683117070; x=1685709070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTrT4jPc7J5Eliba/sNg5kwjP6TH6hnGe4LZ/zcsA7o=;
        b=h6CZGQjzmQEBoCydE3tNyOUgkXuZkUfdzrGG9K7kUwAwoLFxNhVXjtbs3lH8tPxDCJ
         lgKRzg/JByUmGYCLL1CBZxXCRwwaP/rcXDhv2Q0GbKNzMw1mD93llA0XuKu/SXVKGhJI
         NHqdGYM/fsJ+Ulf/M1a3wzv1A4ho3F0hcM+YLNZQbZaR4dRxXgizaF3qTwUJMBBb9vk+
         k0MT4rhuEw/bjlFGXI9qtZ70Th89ykZJTxgBlWMLyNPantAaXohSSDpl+SR2KNSQNWyd
         O4ti0OXekeEAAcuBzGV2+JNTOWwwti5A2/r08pux2hZNGEsWdjxGaCG3fEnLYaVTcLex
         f5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683117070; x=1685709070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTrT4jPc7J5Eliba/sNg5kwjP6TH6hnGe4LZ/zcsA7o=;
        b=HwGbEqdMqgS3JEO1/EACI/hK0h5yAh0v6W0H33Upmtw4xuHtz0MsyT6pVce4BqbJWc
         ym7J5e0orqQJH61HdSrUtEalfsoYqAcSQXVnR00P4ZvZwy0KQf0xkGNxFGaFR/HmWVMm
         rA61OXBRL/j0WBcXzEEN/aLpBdZLK8ocURsbHCiNxSsLzHTlXM7Kz/0PZmyvPE4avhTi
         do8lP3Qhq9vdHtC9ptPte7gBB12udHB+6O4MTgECF92swvqVRQge/EKQ0Ztx/ZaD2l0u
         9UNrkolDNizda3zRjKElEJ6a9z5gZXFnkLQ7oPzlxExXWkwmtVR4z+gId8NAvbaQ0BmJ
         chXg==
X-Gm-Message-State: AC+VfDz51dQ4RM7r4BRXiM6vyrllztQZ8CvYTg+cFzP/eWJ7Y07AMjlL
        9+LMvLb99GJdLrUUiB1dWzKcFSHJYlzFhVlKhqqp6g==
X-Google-Smtp-Source: ACHHUZ5Ewu4j5yENuc3yZI5omV8bCwxGXLnezBSGE3w7r+x/XbA+XE92J0DD6UuUftsDizL2fZBuK/upLJL7mLXrYUg=
X-Received: by 2002:a81:4f4f:0:b0:55a:aa57:5660 with SMTP id
 d76-20020a814f4f000000b0055aaa575660mr5037096ywb.20.1683117070218; Wed, 03
 May 2023 05:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230430-nokia770-regression-v1-0-97704e36b094@linaro.org>
 <20230430-nokia770-regression-v1-3-97704e36b094@linaro.org> <CAPDyKFoPa3PZGFBO4njSfEd6H0rdc6KKwPFvE1x6Xx13thKv8g@mail.gmail.com>
In-Reply-To: <CAPDyKFoPa3PZGFBO4njSfEd6H0rdc6KKwPFvE1x6Xx13thKv8g@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 May 2023 14:30:58 +0200
Message-ID: <CACRpkdaXVeFtm1cqgtKsOnVppGC1dKNmdOSN59r97C1u_XTqGw@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARM/mmc: Convert old mmci-omap to GPIO descriptors
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Helge Deller <deller@gmx.de>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-input@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 2, 2023 at 4:26=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
> On Sun, 30 Apr 2023 at 11:22, Linus Walleij <linus.walleij@linaro.org> wr=
ote:

> > Fixes: 92bf78b33b0b ("gpio: omap: use dynamic allocation of base")
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> This looks like it's best funneled through the soc maintainer's tree(s), =
right?
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks, yeah the plan is to wait and see if I get some testing from
the OMAP1/2/3
guys and then collect the lot and put on a branch to SoC unless Tony wants
the job :D

Yours,
Linus Walleij
