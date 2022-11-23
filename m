Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6259B6359F4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbiKWKbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236834AbiKWKav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:30:51 -0500
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7EF12294D;
        Wed, 23 Nov 2022 02:13:45 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id h7so11249056qvs.3;
        Wed, 23 Nov 2022 02:13:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1J1/Dk89lTEXUaWgB7PSlowyLzY8WAPYmQ4lIK/72+8=;
        b=MVWl9JHFuL2lc+s1+HJdbHS8/dX2EQbXoX/yMwXWry9nV83l3kIFK9J2NbD8G8ksK7
         vKWQVhdYEc0jbEyzk+M5ZnIJ7Ktaet+C+XJBIDIkV9aM2N2h5S2baPiYA6V2t0PSal35
         bUF35z9wxqyNqqDTLmaavKxJLg5aMVatIdEZ7P/aDx2wmxvAO9UGJHT/AL0OPsaGuT3C
         6OzsIwUzXOjJjVput1wGYQg4sL6j/3mmemYnwERJqFDoTPatfxVq/g/HgNoi1BctD6yM
         v+tmKQLFdQ9pOkCuQnxYwp4JunOd0sIfr84WO09tkqCRwf/ULYQjidb7oBeRyeCaZhdw
         RPxw==
X-Gm-Message-State: ANoB5pkRMLrZnKmK7eC9qju88lreIPjBeL95myKnVwM2/PqsWRIYrACi
        3FGYNqJPKiebGugOqJnoP6zSQKEN2jUtbA==
X-Google-Smtp-Source: AA0mqf7B09LUkeAyo/gD39xh+jGigjeZU8wlH5Mw5bvBWprw/17e7pDva275Zrue7vnVQQBhF6dADA==
X-Received: by 2002:a05:6214:4290:b0:4bb:5d3a:bdad with SMTP id og16-20020a056214429000b004bb5d3abdadmr7798908qvb.26.1669198424729;
        Wed, 23 Nov 2022 02:13:44 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id ey10-20020a05622a4c0a00b003a5fb681ae7sm9573050qtb.3.2022.11.23.02.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 02:13:43 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-3691e040abaso169719247b3.9;
        Wed, 23 Nov 2022 02:13:42 -0800 (PST)
X-Received: by 2002:a05:690c:b01:b0:370:202b:f085 with SMTP id
 cj1-20020a05690c0b0100b00370202bf085mr25967882ywb.502.1669198422650; Wed, 23
 Nov 2022 02:13:42 -0800 (PST)
MIME-Version: 1.0
References: <a50fa46075fb760d8409ff6ea2232b2ddb7a102b.1669046259.git.geert+renesas@glider.be>
 <20221123100831.GE39395@tom-ThinkPad-T14s-Gen-2i>
In-Reply-To: <20221123100831.GE39395@tom-ThinkPad-T14s-Gen-2i>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Nov 2022 11:13:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUW8iKFjDj4fPtWfPvyQ1sjGcAy1Kz5j-osz9F4pdA47Q@mail.gmail.com>
Message-ID: <CAMuHMdUW8iKFjDj4fPtWfPvyQ1sjGcAy1Kz5j-osz9F4pdA47Q@mail.gmail.com>
Subject: Re: [PATCH resend] media: staging: stkwebcam: Restore
 MEDIA_{USB,CAMERA}_SUPPORT dependencies
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

On Wed, Nov 23, 2022 at 11:08 AM Tommaso Merciai
<tommaso.merciai@amarulasolutions.com> wrote:
> On Mon, Nov 21, 2022 at 04:58:33PM +0100, Geert Uytterhoeven wrote:
> > By moving support for the USB Syntek DC1125 Camera to staging, the
> > dependencies on MEDIA_USB_SUPPORT and MEDIA_CAMERA_SUPPORT were lost.
> >
> > Fixes: 56280c64ecacc971 ("media: stkwebcam: deprecate driver, move to staging")
>
> Patch itself looks good but we have some style issue. Applying this
> patch I got the following warning from checkpatchl:
>
> WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: 56280c64ecac ("media: stkwebcam: deprecate driver, move to staging")'
> #10:
>
> You have to pass only the first 12 chars of the sha1 commit into Fixes
> msg:
>
> Use:
>
>  Fixes: 56280c64ecac ("media: stkwebcam: deprecate driver, move to staging")
>
> Instead of:
>
>  Fixes: 56280c64ecacc971 ("media: stkwebcam: deprecate driver, move to staging")

I always use 16 chars, to avoid these becoming ambiguous in a few years.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
