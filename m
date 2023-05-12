Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A4F700AF5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241690AbjELPEX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 12 May 2023 11:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241670AbjELPEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:04:21 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BB22D60
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 08:04:20 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-50d8d4efd13so1794312a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 08:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683903859; x=1686495859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8r8EIzdiXeXG/Z0ECjEsALK1soC+rf/Zy6+YvirHCY=;
        b=gkIGnebHLXVYcubZfxuDYjPZsQ3QSgd9q+VoAc9Sqi+gxO3vwcCKqFQ74lVLsYDn0u
         rJ265Yf4CajzLJaMgIKlLqmWz4lwj7mJ3dcxRPUbiqbbTUZlDGwSNhFm7pYiVbcnKv8D
         CAiwp+sIimLNw+O2K3ILzbcCYhfGX7X0PyOf10U/TSfe8jFVh3qE8X+/ot3Uh8HjQuRx
         vBCScFVhOfC0TDXFI+SnXLXm25o1nbrEkXBLkqX3MhDEU5HQplin26EadLPksFF2OKdQ
         gXGxL9ZcbYUdG6E6JxyIFkg1uXHtKPm6QG+BdRnxhWAV4aq/2ZznYHssVlUjmHVurcWI
         7CHg==
X-Gm-Message-State: AC+VfDxbN1I8vJuyuwXy+qiddyA/ls/2hz7zOgaVUguKrQDyOIqTESxZ
        NL23m6HiviHrJk0iUp1T+tidxYfcMR0nj/O1ieMDbpuu
X-Google-Smtp-Source: ACHHUZ4Fi1WViOnDPHVoEZjlRHXOAYSggSu7/u1p1qyqKPCznxTUPFZhL8UgpViTVQ+v9eAUuZmsa31pUoQh4xSn7kQ=
X-Received: by 2002:a17:906:2252:b0:965:bc62:fe38 with SMTP id
 18-20020a170906225200b00965bc62fe38mr21176956ejr.7.1683903858828; Fri, 12 May
 2023 08:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230511073428.10264-1-u.kleine-koenig@pengutronix.de>
 <CAJZ5v0gNPt=rq+pQtmoGL5nxzDQboOK4d6h7=NoY=LueVhZjAQ@mail.gmail.com>
 <20230511103923.hvibdyo5ges4bab2@pengutronix.de> <ZFzWCey825wSlr2v@hovoldconsulting.com>
 <CAJZ5v0jvJT4JkHtO3RCUEzkfawxLCwR=QO2Y2CsL=cYN9s4hXw@mail.gmail.com>
 <ZF3tUQFTeILXV_VT@hovoldconsulting.com> <CAJZ5v0gRcaL5y4nyDcFYfnH8sNYOHSHZN1qwcv+Z7yu4jhSiMA@mail.gmail.com>
 <ZF5UpOzmvXLX-056@hovoldconsulting.com>
In-Reply-To: <ZF5UpOzmvXLX-056@hovoldconsulting.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 12 May 2023 17:04:07 +0200
Message-ID: <CAJZ5v0j14X2SweUds+dT3pGsWC79xGR6s8jguPseFVLmftK9wg@mail.gmail.com>
Subject: Re: [PATCH] driver core: Call pm_runtime_put_sync() only after device_remove()
To:     Johan Hovold <johan@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 5:00 PM Johan Hovold <johan@kernel.org> wrote:
>
> On Fri, May 12, 2023 at 04:04:59PM +0200, Rafael J. Wysocki wrote:
> > On Fri, May 12, 2023 at 9:39 AM Johan Hovold <johan@kernel.org> wrote:
> > >
> > > On Thu, May 11, 2023 at 04:44:25PM +0200, Rafael J. Wysocki wrote:
> > > > On Thu, May 11, 2023 at 1:48 PM Johan Hovold <johan@kernel.org> wrote:
> > >
> > > > > No, this seems like very bad idea and even violates the documentation
> > > > > which clearly states that the usage counter is balanced before calling
> > > > > remove() so that drivers can use pm_runtime_suspend() to put devices
> > > > > into suspended state.
> > > >
> > > > I missed that, sorry.
> > > >
> > > > > There's is really no good reason to even try to change as this is in no
> > > > > way a fast path.
> > > >
> > > > Still, I think that while the "put" part needs to be done before
> > > > device_remove(), the actual state change can be carried out later.
> > > >
> > > > So something like
> > > >
> > > >     pm_runtime_put_noidle(dev);
> > > >
> > > >     device_remove(dev);
> > > >
> > > >     pm_runtime_suspend(dev);
> > > >
> > > > would generally work, wouldn't it?
> > >
> > > No, as drivers typically disable runtime pm in their remove callbacks,
> >
> > What exactly do you mean by "typically"?  None of the PCI drivers
> > should do that, for instance.
>
> I had platform drivers in mind, but so do i2c drivers for example.
>
> > > that pm_runtime_suspend() would amount to a no-op (and calling the
> > > driver pm ops post unbind and the driver having freed its data would
> > > not work either).
> >
> > Well, not really.
> >
> > There are drivers and there are bus types/PM domains.  Drivers need
> > not disable PM-runtime in their "remove" callbacks if they know that
> > the bus type/PM domain will take care of handling PM-runtime properly
> > after the driver's remove callback has run and the bus type/PM domain
> > may very well want its PM-runtime suspend callback to run then (for
> > example, to remove power from the unused device).  Arguably it can
> > invoke runtime_suspend() from its "remove" callback, so it's not like
> > this is a big deal, but IMO it helps if the most general case is
> > considered.
>
> My point was that hundreds of drivers do and for these this call becomes
> a no-op. Same for buses that disable runtime pm at remove.
>
> > Anyway, the question here really is: Does it make sense to carry out a
> > runtime suspend immediately before device_remove()?  Honestly, I'm not
> > sure about that.
>
> I'd say it doesn't really matter as driver unbind is not a common
> operation and drivers using autosuspend would generally not be affected
> either.
>
> You can try to rework this, but clearly it needs more thought than
> simply moving the put sync and some drivers may also be relying on the
> current behaviour.
>
> A quick grep reveals a few which would be left active if you change
> pm_runtime_put_sync() to pm_runtime_put_noidle(), even if that could be
> fixed driver by driver of course.

OK, fair enough.
