Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5E46B54C2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjCJWpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjCJWpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:45:20 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84715105F05
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:44:52 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id y144so6802687yby.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678488292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yiatag0HBPlssT6lLHj1B1HKa5gHM0ni9RfFjV/A3Bw=;
        b=QZ3qQGl3ysCLYqc3+BIcJrkcZY3w56sert/WwHUWbfS/p8AQ9DaVUlS5eXZe4EBqVP
         9c9luQSVcOprbIBmT4aoo7qrOkqr6Of+9Q3dpcAurxosNUrUcxJ2ue80KuwxUHWbkLAD
         tW3n+zTvB7W+Mprlb3opzUwh3KimYqnigLOSovXrnjqyEFOQgL9RKx3OJ3GNyqaf6nRz
         uX8XydJa1GbBI2q6lG8NRTB71u+mvJGjxLA0Kh5EYyQdo+5l3bo2aFUo4u7ADFj3Nwaq
         zK9xR5f3b7lIyuSPqZXSZfVIaOEauYBccbtrSkZCYwSgbPaKaN14l5ul1WUuLxf8Emx3
         7WUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678488292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yiatag0HBPlssT6lLHj1B1HKa5gHM0ni9RfFjV/A3Bw=;
        b=MFuZ17C4TLPBeeYpo3dC3dpiHqm9frauAfB9mvsu/giIMFB40AOzBrDZqrXme5qbWr
         1/SzciChAunAB84YtRc2fcqeoY+mdKzAAGmKK6b7/WmTkIR/9qqOkB9/p47DNKaa5n0c
         HrG2VHqVAs0wOATqSJbhUJiu79e5I0Q04W6KFSt24+vjcqXsGNA8OL3+gLd3RY4sNy31
         /D3tNHYI5oJEzwr3txxjFeSbY7Pn0TRpoiRU1k2qeOJzl/nr5sTnjiVl5srLVVAnSsU6
         5IQhbEY1CdYJXMcXGdEsZHE3rKrzJ1hwUN7Kon40yRsezOIvtDg/kR9Jw8Vm21ml5XwO
         7Yvg==
X-Gm-Message-State: AO0yUKVYlKZAvS6e6UFoFmWmYkCNuAvVUAcmquIOov2AVot+/+OrAiNb
        aeKbrnSGkkH3UZYMsN1inHQqtcR3k8Pba0yjLaMaaQ==
X-Google-Smtp-Source: AK7set9IjziFhtMIyDmTbNJQeJUGfaU6EwLqgkuRD5zd8aQOX/4BVX9GyyO8rgzvXcYU5bs7/TQU+5AK438In//pe/w=
X-Received: by 2002:a25:3f01:0:b0:b26:884:c35e with SMTP id
 m1-20020a253f01000000b00b260884c35emr2340474yba.4.1678488291762; Fri, 10 Mar
 2023 14:44:51 -0800 (PST)
MIME-Version: 1.0
References: <20230215-immutable-chips-v3-0-972542092a77@linaro.org> <CAMRc=MdyjQDEMNxGYOKwWHry7MnEFMHYZSg=-FPohNwn6dxjaQ@mail.gmail.com>
In-Reply-To: <CAMRc=MdyjQDEMNxGYOKwWHry7MnEFMHYZSg=-FPohNwn6dxjaQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Mar 2023 23:44:40 +0100
Message-ID: <CACRpkdYZvvPRgdctcFo+o24+PEWaz-dpPd0ntFg7qWQDYNPKsA@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] Mass convert GPIO IRQ chips to be immutable
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Mun Yew Tham <mun.yew.tham@intel.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, Alban Bedel <albeu@free.fr>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Jay Fang <f.fangjian@huawei.com>,
        Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-omap@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>
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

On Fri, Mar 10, 2023 at 4:25=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
> On Thu, Mar 9, 2023 at 8:45=E2=80=AFAM Linus Walleij <linus.walleij@linar=
o.org> wrote:
> >
> > We are getting tired of these irq_chips not getting converted
> > to be immutable, so I just take out the big hammer and fix
> > some that I deem not too complex as best I can.
> >
> > I stopped after doing some, I will take another sweep at some
> > point I guess.

> Normally these irq_chip conversions would go upstream as fixes but
> this time there are too many at once. I applied them to my
> gpio/for-next branch. Let's give them some time in next and later we
> can backport them if necessary.

That's fine since the maintainers didn't get around to fixing it themselves
yet anyway it can't be that important to them.

I will try to take a second sweep and see what is left on the floor, and
then I guess a sweep over the gpio_chips in pinctrl as well.

Yours,
Linus Walleij
