Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C7A68A6CE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 00:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjBCXLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 18:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjBCXLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 18:11:12 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C5C7BE73;
        Fri,  3 Feb 2023 15:11:10 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id k4so19530233eje.1;
        Fri, 03 Feb 2023 15:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S4kT4lUgvezB9PVw7db1Dvk1buBeLiCC8+GU/OROilk=;
        b=a70hqnijk1JW+BcyT5BmUGve0dzrG+/RmhwfUBqZnw0RxWEe1FpGeD9/pLE2GKwybo
         ypgHQXXZHUfq4x4W58bnfPU/l2Z1YEDOWA8lC1qihyo7QWHAo15dKD/UcBFW4/n6SRAR
         Xob2r54DMgRLxQEKeXNgiPZ1tNHArv/OPkwAu1O5YJefeb9AxeL8ow51RNJc8ATM3AKN
         0z+tF9yDFkx6uSHHPhaMNxoscjF/FwhNGw3FaVaEb1XEOHk8j1ornAppfGjBPU2ceUP8
         +iWt2UURkb5Cov50jPsgME6KWihBlfxjcSoPDJB369lEEelgfdE+64SKHalA6i0o6pv5
         1/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S4kT4lUgvezB9PVw7db1Dvk1buBeLiCC8+GU/OROilk=;
        b=yelRN6a2HXQd6uwuE7t++SMdQsaahlAxjf2kuVd0dcqNNb2ySfPaowXfjuvKkjSuH5
         QE6dKAmUbFJwAwkBVH5zusswVTDrWLwXJOG83ewBtUOOfhUrl7Pn0YdS9QVdb5KXXKD3
         T3u6L7nGDhWB2o7gOAGH7/pXBk7JoEk77yzVHZ82OIODaFXa/kAjSlu72nzMKTaiX6HI
         GQr7AhNai3hoa5jN58QosCuOvDR5XOD899v0EVlviYEWQgf76OHpgUH+d/uJnZraHu2/
         2U2RII2l2SShu2MSFir5NE8F+3NPF8h7GwvDtoVVQbOnrjL9GQWWB4a49K8JvwNDAJ5H
         W9mQ==
X-Gm-Message-State: AO0yUKXZRXlhz4lSRDQrNMCooMY4XBsUSZ5iup5xgPTkuNQDp8m5yOzW
        Eozz5qfYov99qRmMa0fjJ0hZnp2ZLk9VNkhzKg4=
X-Google-Smtp-Source: AK7set/oe2Xl6fQyM1SDHpSLzd6OFhgado9BSZqsGTsaWjZmZWneEWHlWtsW6WKvP3YjD+GbwQqu4VQahfZMbcYiPd0=
X-Received: by 2002:a17:906:3957:b0:870:5fc6:210c with SMTP id
 g23-20020a170906395700b008705fc6210cmr3313204eje.257.1675465868661; Fri, 03
 Feb 2023 15:11:08 -0800 (PST)
MIME-Version: 1.0
References: <20230130131003.668888-1-arnd@kernel.org> <Y9f7/q3aS5nlY7nJ@smile.fi.intel.com>
 <14e7d2ba-1a24-42a1-b19e-842e0fd8286e@app.fastmail.com>
In-Reply-To: <14e7d2ba-1a24-42a1-b19e-842e0fd8286e@app.fastmail.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Fri, 3 Feb 2023 15:10:55 -0800
Message-ID: <CAKdAkRRA7XATxHBALDf8Pd2SWQX_OPAYgCQmtJi5H1so_EJ7VA@mail.gmail.com>
Subject: Re: [PATCH] media: c8sectpfe: convert to gpio descriptors
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 10:19 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Jan 30, 2023, at 18:18, Andy Shevchenko wrote:
> > On Mon, Jan 30, 2023 at 02:09:47PM +0100, Arnd Bergmann wrote:
>
> >> +            ret = PTR_ERR_OR_ZERO(tsin->rst_gpio);
> >>              if (ret && ret != -EBUSY) {
> >> -                    dev_err(dev, "Can't request tsin%d reset gpio\n"
> >> -                            , fei->channel_data[index]->tsin_id);
> >> +                    dev_err_probe(dev, ret,
> >> +                                  "reset gpio for tsin%d not valid\n",
> >> +                                  tsin->tsin_id);
> >>                      goto err_node_put;
> >>              }
> >>
> >>              if (!ret) {
> >
> > Can be
> >
> >       if (IS_ERR() && PTR_ERR() != -EBUSY) {
> >               ret = dev_err_probe(dev, PTR_ERR(), ...);
> >               ...
> >       }
> >
> >       if (!IS_ERR())
> >
> > (Up to you)
>
> I prefer the version that only has one PTR_ERR(), but
> either way is fine with me.
>
> > But -EBUSY check seems strange to me. What was the motivation behind?
> > (As far as I can read the code the possibility to get this if and only
> >  if we have requested GPIO too early at initcall level. Would it be
> >  ever a possibility to get it in real life?)
>
> I noticed this part as being odd as well, no idea why the
> code is like this. I just left the logic unchanged here.

It could be they were trying to account for the possibility of the
reset line being shared between several blocks, and so the first one
to initialize would grab it and reset all chips, and the followers
would be skipping the reset logic.

-- 
Dmitry
