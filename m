Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F04D6AE09C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjCGNcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjCGNbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:31:49 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB0158C33
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:31:23 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-536c02c9dfbso244205777b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678195881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qZDlZ4nvcYqnA7rrOlrlk7Ib6bN2Rj+gic41qjc6Sk=;
        b=csz6D+7qw4ihr/1Q1hYTSkqILMOaSoUsowp1U7h/ni56nX/+aBQoIiHoWIlKyKl8X4
         zq+xVwxcBDGzSLtahMpQOBACWxrveOj/+ArcjOvPNLoL0suTP+ukwNGwF136A4Dayybp
         GWm/DvqIfyJp/htKSqEncFX+eZbRZ7sSzAtOJDXWcHuMpJniKM4HOecz5cJlcIlcoeZT
         NwRGshB2J6j7TBILMDdY18XXPwOTMabvfG94WLpgb8pygXE7oNNk/bXcz1yPfurDwS5F
         iqZzm32yEqVrCiIJ73X4pZARre+jNFfGwBUYO1Yj7dANhtHMb8RORDzGtnlY+SUL820M
         2BEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678195881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qZDlZ4nvcYqnA7rrOlrlk7Ib6bN2Rj+gic41qjc6Sk=;
        b=OehSShilkB+mqzmrnZoxs3J4G0KKCC9J4ffiWmwGBL0vuNak4pWRvC9mZ1OKGAxz7k
         IW5klQP05ZzAsu7PTpxDhqmxE5+7XB37q2NQg4rRa0CtQjq26RT+FQ4KpWcAKxPGdf8X
         6vtdEV9Qgs4PQPzMW4rtsTE+lguywspXd2zP8iGPivDpzbplaaC5DHEi/GQf9W7lEwYP
         1RyHoXSmM5Lk3L+bxadapBBXOS40LctEHFYMCCgnL5iqzGeOc0XmsCp3AdIQPlm6S3Xf
         lCULkdDvFw5nwKb+EXRSMZns4V6WztAU8Mnp9didtwktuRJcNJJGZ58mdo/k65YmxkTx
         8Kkw==
X-Gm-Message-State: AO0yUKU2C8IuGL4pPaXfOMcnj/qPZk50K+VSViny4DgwzAZW0yKQD5lc
        60u2Ekcx4B3wLEG8JasWEvRxPDGJ4DLYHsbbvPpA6A==
X-Google-Smtp-Source: AK7set9E8w0pJh0BVoOHhtl6CYrFbDwMltsJpSZJqp2AS97HPe+ed7p/77Kqwpjgt1kY1eeDT2PPd1l/BExC7pyIBuc=
X-Received: by 2002:a81:ad24:0:b0:52e:bb2d:2841 with SMTP id
 l36-20020a81ad24000000b0052ebb2d2841mr8676951ywh.10.1678195881039; Tue, 07
 Mar 2023 05:31:21 -0800 (PST)
MIME-Version: 1.0
References: <20230302125215.214014-1-keguang.zhang@gmail.com>
 <20230302125215.214014-2-keguang.zhang@gmail.com> <CAMRc=Me=Yrr5BuRaMd4r91URzmdYHWUvVGvLL9YFuZPaV0WYFA@mail.gmail.com>
 <CAJhJPsVf8EvFc9N8eMtc8Qu2BhODv7PzZm9C5ePR+GdTFiAY1w@mail.gmail.com>
In-Reply-To: <CAJhJPsVf8EvFc9N8eMtc8Qu2BhODv7PzZm9C5ePR+GdTFiAY1w@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Mar 2023 14:31:09 +0100
Message-ID: <CACRpkda_y1Hz69XyDjcDPd=gEi_n2PChJOgKsonXcvYyxQzg4w@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] gpio: loongson1: Convert to SPDX identifier
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 3:25 AM Keguang Zhang <keguang.zhang@gmail.com> wrot=
e:
> On Mon, Mar 6, 2023 at 5:29=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
> > On Thu, Mar 2, 2023 at 1:52=E2=80=AFPM Keguang Zhang <keguang.zhang@gma=
il.com> wrote:
> > >
> > > Use SPDX-License-Identifier instead of the license text and
> > > update the author information.
> > >
> > > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>

> > Why are you removing credits of the old author?

> Kelvin Cheung and Keguang Zhang are the same person.
> This change is to keep pace with the related entry of MAINTAINERS.

That's a pretty interesting change!

Is Kelvin Cheung the "westernized" name and Keguang Zhang the
closer to the real name, such as pinyin form? That would make
a lot of sense.

I think some authors even use the native characters these days,
as git and all tools and terminals should support Unicode now.
It might make it hard for us to answer mails (not knowing which
characters to refer to as given name) but I kind of like it when I
see it.

Yours,
Linus Walleij
