Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9135764D98B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiLOK2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiLOK21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:28:27 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085E02B637
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:28:27 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id v15-20020a9d69cf000000b006709b5a534aso3305360oto.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LtljAWqATTprBdx/puLbz5M+a12OV6zS3WLjEmNHu0g=;
        b=Ez24esC5a/EJHDAcFcUCcoPyf6nSQvYavzX2fr3fW1qLKEbuL2vEKMqAxm0nB8eop6
         hCOr9sy58ar6xUuMiBPphsM/qEPindCwfln+nmmUbFZNedDDocfwX7h0OeDFxA9wpSB4
         51V+2TVBY5aRgp4EiapRR+XsZuC+ZtgFeqVEwI3RNv+ogOyP4tLaE1bLvtZH9vdhuA1q
         bO+LmleAziTi+A+Ren80+4Y5ZLI1ZBNltDIUkB78A5A16CkZkgHFD0Nc0YnJG9czC8bd
         8a7u7SDf4fSPVnKjoBPwwYpgvc3GUw8psTV65UEbnKW9ah6MGIN3hxE5eJYSahGjCxRo
         A8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LtljAWqATTprBdx/puLbz5M+a12OV6zS3WLjEmNHu0g=;
        b=1MSBzPTnzW8SR6QD+/9pqwtj2k2dT/SLi2pvAd58QrqDKEUWWNt8wc3rROPqbttOIF
         mLOZ1hYCwOfAdBg9IU3XG8RLMMEve8t6/g/IncueTfuXQGIJCFwKp05sJmuAFw4QayUc
         tYZO3gM0uKu+UvBevd8EDuTQwav93GjTlo6DtVZv86p7zWoLBoDtTm0zawbU81QkLenQ
         fsz9lJ4v5AQjMylpce51lKDIO2AAu8lWIKoBergeJzu8TneY52k8+WP/FM7xxiEMoprX
         io6jnr6WXcFqtaws0Ntpoz7FIhxITnLLZ9Mjt9Xouj1izmcJmQwhj1Uj3a3y+1mXc9cx
         JjEQ==
X-Gm-Message-State: ANoB5pmUxOoyaSDImS/8b70YV84ShUCZlkYMaDQQs71wqKLOJg9kDnju
        GBmC8P4KH75pscjrdqOnYkWKfsisBzFjIbEvG7mt6A==
X-Google-Smtp-Source: AA0mqf4gtJ4oe2CfZk2E+pvBi+849dIwpPxXu0vTF/npAndT/NXXThP36dbstmvHpO1keWYrWKjprQq3UsZdljXW8Yo=
X-Received: by 2002:a05:6830:3697:b0:66b:e4f2:7f2a with SMTP id
 bk23-20020a056830369700b0066be4f27f2amr40760256otb.317.1671100106329; Thu, 15
 Dec 2022 02:28:26 -0800 (PST)
MIME-Version: 1.0
References: <20221109095227.3320919-1-treapking@chromium.org> <CAEXTbpf+6n9KWRkQEbQVxsBjd65Rs0voH=JNHk5BaoE_55-yuw@mail.gmail.com>
In-Reply-To: <CAEXTbpf+6n9KWRkQEbQVxsBjd65Rs0voH=JNHk5BaoE_55-yuw@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 15 Dec 2022 11:28:15 +0100
Message-ID: <CAG3jFytMKqGvyn==OZQ_rFZHkfyLtNFNHvj+Ata7D3bgh5JvcQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: it6505: Guard bridge power in IRQ handler
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        allen chen <allen.chen@ite.com.tw>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2022 at 04:30, Pin-yen Lin <treapking@chromium.org> wrote:
>
> Hi all,
>
> Friendly ping on this patch.
>
> Regards,
> Pin-yen
>
> On Wed, Nov 9, 2022 at 5:52 PM Pin-yen Lin <treapking@chromium.org> wrote:
> >
> > Add a pair of pm_runtime_get_if_in_use and pm_runtime_put_sync in the
> > interrupt handler to make sure the bridge won't be powered off during
> > the interrupt handlings. Also remove the irq_lock mutex because it's not
> > guarding anything now.
> >
> > Fixes: ab28896f1a83 ("drm/bridge: it6505: Improve synchronization between extcon subsystem")
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > ---
> >
> >  drivers/gpu/drm/bridge/ite-it6505.c | 22 ++++++++--------------
> >  1 file changed, 8 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> > index 21a9b8422bda..e7f7d0ce1380 100644
> > --- a/drivers/gpu/drm/bridge/ite-it6505.c
> > +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> > @@ -412,7 +412,6 @@ struct it6505 {
> >          * Mutex protects extcon and interrupt functions from interfering
> >          * each other.
> >          */
> > -       struct mutex irq_lock;
> >         struct mutex extcon_lock;
> >         struct mutex mode_lock; /* used to bridge_detect */
> >         struct mutex aux_lock; /* used to aux data transfers */
> > @@ -2494,10 +2493,8 @@ static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
> >         };
> >         int int_status[3], i;
> >
> > -       mutex_lock(&it6505->irq_lock);
> > -
> > -       if (it6505->enable_drv_hold || !it6505->powered)
> > -               goto unlock;
> > +       if (it6505->enable_drv_hold || pm_runtime_get_if_in_use(dev) <= 0)
> > +               return IRQ_HANDLED;
> >
> >         int_status[0] = it6505_read(it6505, INT_STATUS_01);
> >         int_status[1] = it6505_read(it6505, INT_STATUS_02);
> > @@ -2515,16 +2512,14 @@ static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
> >         if (it6505_test_bit(irq_vec[0].bit, (unsigned int *)int_status))
> >                 irq_vec[0].handler(it6505);
> >
> > -       if (!it6505->hpd_state)
> > -               goto unlock;
> > -
> > -       for (i = 1; i < ARRAY_SIZE(irq_vec); i++) {
> > -               if (it6505_test_bit(irq_vec[i].bit, (unsigned int *)int_status))
> > -                       irq_vec[i].handler(it6505);
> > +       if (it6505->hpd_state) {
> > +               for (i = 1; i < ARRAY_SIZE(irq_vec); i++) {
> > +                       if (it6505_test_bit(irq_vec[i].bit, (unsigned int *)int_status))
> > +                               irq_vec[i].handler(it6505);
> > +               }
> >         }
> >
> > -unlock:
> > -       mutex_unlock(&it6505->irq_lock);
> > +       pm_runtime_put_sync(dev);
> >
> >         return IRQ_HANDLED;
> >  }
> > @@ -3277,7 +3272,6 @@ static int it6505_i2c_probe(struct i2c_client *client,
> >         if (!it6505)
> >                 return -ENOMEM;
> >
> > -       mutex_init(&it6505->irq_lock);
> >         mutex_init(&it6505->extcon_lock);
> >         mutex_init(&it6505->mode_lock);
> >         mutex_init(&it6505->aux_lock);
> > --
> > 2.38.1.431.g37b22c650d-goog
> >


Applied to drm-misc-next.


Rob.
