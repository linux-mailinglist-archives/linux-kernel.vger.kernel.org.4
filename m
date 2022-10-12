Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB2B5FC37C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 12:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJLKKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 06:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJLKKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 06:10:10 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5208D2F002
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:10:05 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id w2so16117862pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 03:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Ldwvi/6+WpjkFB34Wr6wWsgreWRXiHPDgevaXrBBZI=;
        b=RaFpALgtowsu6Bkd9rKpn7h03KNbXqbnKGe0rAl8lZDuXRbNU6nnjMu4wDilW9vTy+
         y1JjbuaObbzQbyEWIsKNhBUuCgOQreVFgmSVsAkSGxspgskSVKcj+f9y+7rhEO3vC0a+
         NyRz1QPjlaF7hsaugq/ujebXPNJFSPiDXvEmVFYPUCo9R253n3oWavycY9HKF1FcXbOB
         /FnW4qirR0PPLbQzXouQF9+X/RkLXexkrn8Q/sVis5M8DbL0pc2JNWGTHDVv4rdXPa5o
         12UbiA2JnHNU4q5Z0+z6jweUiceFrqawiJQbyMGY5+7LfO9FaqZvpBjoBGoqfla9FY05
         en1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Ldwvi/6+WpjkFB34Wr6wWsgreWRXiHPDgevaXrBBZI=;
        b=vMdwAqgQIANHEugrGAODEa/cifEjsTfHe8TudzrAWbmekQ2jDKVZpVXPf5MUTFu6gy
         rTS2pDZiKYlItKTv8DWhSUlIQRA6qqoYsumxyW8yd3Ik9dv0yPr2NchNjLU5ZWpvQpDn
         2IH6CWweCEU/uM7Nio37o7d3WYvSLfnTNKePqTV2pDFhqiLNr6Gv0Px9ciN4u7yR7gor
         cKnC4KoDMOoP3ZgdTos1t+ihmxf0u7rJEQ96pYf8Y/KdIL8eCmEV2V/YgFslBenMhhW6
         zc5d/H4rLJvHHmVIoKU94+M4qTEiSPmKoyGMqUO28KPedx0yKLDmI23ub6OfM7FsDPr2
         Z9Eg==
X-Gm-Message-State: ACrzQf1KjtkLaoSq/lI4FIormGKgI6b4NbBFNWWHMXlso7q6tIbd11UZ
        kTPiMKkFIteFqbiXeXxam5yM7QOctXNguILpzfNipA==
X-Google-Smtp-Source: AMsMyM5oK7jjHhPEPgQH7kLlzd58EEB42gbebUVhWGMNvpnL46vX8hb4YJRA8SkZ+eCwTdRvv0AioottysFC+9cOS7o=
X-Received: by 2002:a05:6a00:181c:b0:563:2c6c:2a7a with SMTP id
 y28-20020a056a00181c00b005632c6c2a7amr18816296pfa.28.1665569405415; Wed, 12
 Oct 2022 03:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <67f722b4bfe84b01bbbf37258a278a68@zeku.com>
In-Reply-To: <67f722b4bfe84b01bbbf37258a278a68@zeku.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 12 Oct 2022 12:09:27 +0200
Message-ID: <CAPDyKFpfm2i2u3BKCxFEA=qZ8GiOOryhHYKNt_yyMA51sxSLJw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdio: fix kernel panic when remove non-standard SDIO card
To:     =?UTF-8?B?5qyn6Ziz54Kc6ZKKKFdlaXpoYW8gT3V5YW5nKQ==?= 
        <ouyangweizhao@zeku.com>
Cc:     =?UTF-8?B?546L5aSn5a6HKEpvaG4gV2FuZyk=?= <wangdayu@zeku.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        =?UTF-8?B?6ams5a6P5LyfKE1hdHRoZXcgTWEp?= <mahongwei@zeku.com>,
        Pierre Ossman <drzeus@drzeus.cx>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022 at 03:50, =E6=AC=A7=E9=98=B3=E7=82=9C=E9=92=8A(Weizhao =
Ouyang)
<ouyangweizhao@zeku.com> wrote:
>
> 2022=E5=B9=B410=E6=9C=8811=E6=97=A5 22:41, Ulf Hansson <ulf.hansson@linar=
o.org> wrote:
> >
> > On Tue, 27 Sept 2022 at 04:04, Weizhao Ouyang <ouyangweizhao@zeku.com>
> > wrote:
> > >
> > > From: Matthew Ma <mahongwei@zeku.com>
> > >
> > > SDIO tuple is only allocated for standard SDIO card, especially it
> > > causes memory corruption issues when the non-standard SDIO card has
> > > removed since the card device's reference counter does not increase f=
or
> > > it at sdio_init_func(), but all SDIO card device reference counter ha=
s
> > > decreased at sdio_release_func().
> > >
> > > Fixes: 1a632f8cdc33 ("sdio: split up common and function CIS parsing"=
)
> > > Signed-off-by: Matthew Ma <mahongwei@zeku.com>
> > > Reviewed-by: Weizhao Ouyang <ouyangweizhao@zeku.com>
> > > Reviewed-by: John Wang <wangdayu@zeku.com>
> >
> > Apologize for the delay!
> >
> > Wow, that's a very old bug you fixed! However, it looks like the fixed
> > commit should be changed to 6f51be3d37df ("sdio: allow non-standard
> > SDIO cards").
>
> Thanks, I messed the tag.
>
> >
> > I tried to apply the patch, but the patch format seems to be corrupt.
> > Did you use git format-patch and did run ./scripts/checkpatch.pl on
> > it?
> >
>
> Yeah I used checkpatch.pl with strict mode to check this patch, and it
> has no obvious style problems. What's the format error you got?

ERROR: patch seems to be corrupt (line wrapped?)
#130: FILE: drivers/mmc/core/sdio_bus.c:291:
struct sdio_func *func =3D dev_to_sdio_func(dev);

total: 1 errors, 0 warnings, 9 lines checked

If you haven't read the submitting-patches guidelines [1], I strongly
recommend you to have a look.
For example, it explains why you should use git send-email, if you
aren't doing that already.

Kind regards
Uffe

[1]
https://www.kernel.org/doc/html/v6.0/process/submitting-patches.html
