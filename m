Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B669D738AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjFUQXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjFUQW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:22:57 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97706E6E;
        Wed, 21 Jun 2023 09:22:56 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b479d53d48so52618831fa.1;
        Wed, 21 Jun 2023 09:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687364575; x=1689956575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mbUIsseJQLcD56nUexXAQssleBbFXq9HDLFNTK6540U=;
        b=sge27uCvgXX/8Df62gKTk54cBqLn4j59/BfRkIX1rNPVXbh5aEauw0V9ewkL4F09SB
         JPsONs3ildeURV0CHLSyqHnZomdLlDvOdn1EaMCfrYO4Ax0bVLL89pDzRlkYfW3+k4xb
         Bd7DvbmpQygGS4YkTEsC5G+8iGlapHW36eqKCgXVhzvigVxspDrQqdDxtnuW9XBpXbj3
         1639Z2m9a59PATglcKzvobinmb6TntuC8pSEUFNouhgR7nq5ryW++aHaOf7xeOYsRoBn
         zLvB8iGOEyTTyVeEMJ/5D6Poudd3KlUthPef7N4UZHNpzsutyApzzvFOAdet1wS0vCEw
         K7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687364575; x=1689956575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbUIsseJQLcD56nUexXAQssleBbFXq9HDLFNTK6540U=;
        b=R7/U+LHmJtZ72EctVZTroNC+9QLEtVaWnKrrot/VclETambkdMXv619e6o1IdA2rng
         rjscKDu06huFgG/orcJ5aochwGbfcNAHL7Lg6zqthcxHXSHwBmwzYHNxV9joab75gsg0
         Us6VwygjbqhDlfs8XCIoPyyqoF6nSTAot4k+2lf47A142bjzJizW6BQlW5i1XN6G/VzR
         Q2WH9aisB2B4q9ANNvLrTGfezCjplXM8kFNpovHXwCeeJaLOnjwuFQ+UNk3Y0Krj9whH
         n/Rq802vVwVXBj89v9Wg1QcqiLk09q57NuRUUE08p7aDyiU+SNlkollqqI2qVPl1wU66
         +XeQ==
X-Gm-Message-State: AC+VfDxwCgb1I7WmnnsTH/wROq4S6pbcAcGV/9Dq/TYxSR3ZubolSlBA
        wlWCyF9NuxTQ+CzdnrhbWpXUC6cfvWR4Cyh5F0I=
X-Google-Smtp-Source: ACHHUZ76EEUwUN3hooyIHI/bSiXV0MfinoZMsCJXcKF26s7jAh7kKSz/R3mjelpjU2Fl35/yLc8YoklRAez3ZrVkWnE=
X-Received: by 2002:a05:651c:1045:b0:2b5:8204:ec9b with SMTP id
 x5-20020a05651c104500b002b58204ec9bmr2454212ljm.43.1687364574666; Wed, 21 Jun
 2023 09:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230620-hx3-v3-0-2acbc03ca949@skidata.com> <20230620-hx3-v3-1-2acbc03ca949@skidata.com>
 <2023062102-booth-glorify-2b09@gregkh>
In-Reply-To: <2023062102-booth-glorify-2b09@gregkh>
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 21 Jun 2023 18:22:41 +0200
Message-ID: <CAJpcXm6fRsonH+ZsA7YTpJGBW348r4ZCVSc1XGyhwajqTnn-Dw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] usb: misc: onboard-hub: support multiple power supplies
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 at 18:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Jun 21, 2023 at 05:58:30PM +0200, Benjamin Bara wrote:
> > From: Benjamin Bara <benjamin.bara@skidata.com>
> >
> > As some of the onboard hubs require multiple power supplies, provide the
> > environment to support them.
> >
> > Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> > ---
> > v3:
> > - fix nits mentioned in v2
> >
> > v2:
> > - replace (err != 0) with (err)
> > ---
> >  drivers/usb/misc/onboard_usb_hub.c | 39 ++++++++++++++++++++++++++++++--------
> >  drivers/usb/misc/onboard_usb_hub.h |  1 +
> >  2 files changed, 32 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
> > index 12fc6eb67c3b..a56e712d3a45 100644
> > --- a/drivers/usb/misc/onboard_usb_hub.c
> > +++ b/drivers/usb/misc/onboard_usb_hub.c
> > @@ -27,6 +27,13 @@
> >
> >  #include "onboard_usb_hub.h"
> >
> > +#define MAX_SUPPLIES 2
>
> Why 2?

I picked 2 because with 3/3, this is the maximum of "required" supplies. The
currently implemented ones require only one (up to now just named "vdd"). The
new one added in 3/3 requires 2, therefore I tried to be generic if some future
hub might require 3 or more.

> > +
> > +static const char * const supply_names[] = {
> > +     "vdd",
> > +     "vdd2",
> > +};
>
> Do those names have anything to do with the number above?  If so, please
> document it!

I picked "vdd" for the first to be compatible with the existing device-trees. As
the actual names differ between hubs, I thought it might be generic to just use
"vdd2" here. If I should add some comment like "if you increase MAX_SUPPLIES,
please also add a supply_name below", I can do that. I could also implement
"vdd${i+1}" for i>0 instead.

>
> >  struct onboard_hub_pdata {
> >       unsigned long reset_us;         /* reset pulse width in us */
> > +     unsigned int num_supplies;      /* number of supplies: 0 considered as 1 */
>
> I can not understand that comment at all :(

This should just indicate that leaving the field empty means one supply is
required. Maybe "defaults to 1" is better?
