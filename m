Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E205B469E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 16:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiIJOYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 10:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiIJOYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 10:24:39 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322C7767F
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 07:24:34 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1280590722dso11415024fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 07:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=GiOhVG3ujs/wYxW3Ud9mBhfYhrEQMhzbaVm7PnWrb8Y=;
        b=qSMB8KcEPdfdEwBYz2utVel9t5WluRsaCvrxg5+geK0WmvMZZEOWtQoN9B3O47ZM+l
         bQrasPX7QvE7wmeAkw9b4C7C3NJTwKfh8E01My/3g+OjkMm3JF8UP4Ad1tf0L/dAwhfz
         R89NZfE9qgCJS9tyYhEGF1Y3mK5qY4T5UEqt6yfNqpTtvsgPFcXuBf0AopCHp4WD0Rfk
         U7c9vOjJlUwL83enEq2K6wAv5fiz7vj4ifw103lIOtuqcYUoGXK40Di+yHN1LbyByisN
         HfLuBMnqOe8M93U8B/DLzlMEsoDlFwAFFDHE4HdIQx0gJNtVkYgYHvKFCzB4YD0LEwMr
         AvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GiOhVG3ujs/wYxW3Ud9mBhfYhrEQMhzbaVm7PnWrb8Y=;
        b=aVteQfd39CoEnWMkvmAwyVXVyiZIszFtl++kypF2dtTKXme2EiwlP65Q7K3/Afs3KG
         IqCY3dt56uSKcOg4agkxrx8+iFWMAHfKtNUm0HBJMC9pC93tKpXYAzDV6sVRioACLsw6
         Md4DxWB4RD3O7FP5X/kpyA+7B1AJ8k0rpJfXENzDIIUvsulq9seMO2DipibP0IlHyYn1
         q5Tt53fOOdQ+2qGq0YZTFUPmqxG7ex41z9qRsN9eYQ3E86r4mlH5vk/dTeZ5cgkHUzLR
         M6n7U4sijxOOxnUbBNBHtyNc0Xs1O2+RB3C03zE2c67rcc1y0v7rmv1ZIZPAZRtfI9Is
         Ii+w==
X-Gm-Message-State: ACgBeo26wFF8z2/VePbAwjXffK74F7vbhH7V6BC0kieNUlwofVUnVclk
        +za4ueTJ1deWKg37okS2mVqjOkBvNojzeamxMewJ0G7tTbs=
X-Google-Smtp-Source: AA6agR6vIaq0f/r/utZkUYu0gDJNrlwWgZC8AGjHZvaqlWhoaXmVr0Gm7EFX/CIq/FqUGTwPAd2IPFI7RzMQEiCR0xY=
X-Received: by 2002:a05:6870:2052:b0:11d:fbeb:b3c with SMTP id
 l18-20020a056870205200b0011dfbeb0b3cmr7773166oad.167.1662819873559; Sat, 10
 Sep 2022 07:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220909101025.82955-1-wuchi.zero@gmail.com> <20220909144813.bb6d71b9de0206cf7fb62d22@linux-foundation.org>
In-Reply-To: <20220909144813.bb6d71b9de0206cf7fb62d22@linux-foundation.org>
From:   chi wu <wuchi.zero@gmail.com>
Date:   Sat, 10 Sep 2022 22:24:22 +0800
Message-ID: <CA+tQmHAzoBAvMHWGyTxzeNP6ghK6MAkPMfW0UhpE7so-ibb8uQ@mail.gmail.com>
Subject: Re: [PATCH] relay: use kvcalloc to alloc page array in relay_alloc_page_array
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     hch@lst.de, axboe@kernel.dk, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> =E4=BA=8E2022=E5=B9=B49=E6=9C=881=
0=E6=97=A5=E5=91=A8=E5=85=AD 05:48=E5=86=99=E9=81=93=EF=BC=9A

>
> On Fri,  9 Sep 2022 18:10:25 +0800 wuchi <wuchi.zero@gmail.com> wrote:
>
> > The kvcalloc is safer because it will check the integer overflows,
> > and using it will simple the logic of allocation size.
> >
> > ...
> >
> > --- a/kernel/relay.c
> > +++ b/kernel/relay.c
> > @@ -60,10 +60,7 @@ static const struct vm_operations_struct relay_file_=
mmap_ops =3D {
> >   */
> >  static struct page **relay_alloc_page_array(unsigned int n_pages)
> >  {
> > -     const size_t pa_size =3D n_pages * sizeof(struct page *);
> > -     if (pa_size > PAGE_SIZE)
> > -             return vzalloc(pa_size);
> > -     return kzalloc(pa_size, GFP_KERNEL);
> > +     return kvcalloc(n_pages, sizeof(struct page *), GFP_KERNEL);
> >  }
>
> It isn't really equivalent because kvcalloc() may attempt a large
> kmalloc() request, whereas the current relay_alloc_page_array()
> implementation avoids this by choosing vmalloc() instead.
>
> But I doubt if it matters - kvcalloc()->kvmalloc_node() does take some
> care to prevent that large kmalloc() request from being too disruptive.
>
Thanks very much=EF=BC=8Cgot it.
