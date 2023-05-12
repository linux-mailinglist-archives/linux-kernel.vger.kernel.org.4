Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0FB7009EA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241404AbjELOFS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 12 May 2023 10:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241454AbjELOFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:05:14 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899303C23
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:05:12 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-50a20bfe366so2549089a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683900311; x=1686492311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hAl6gNGfhK2E+/GN178/0RT+nmB4QgOANVUnLmUqRU=;
        b=gQFoVt7RhooowNkAp14o/9vrlzVcpBX4aVfouRrNglOQh+q46EwfR/UJF+IUdFvJl3
         81HVUxMA93EJQ08Ylk9JFoXOOMswNNvRJJRifahIL7kNVfdBQd2jfHlZuuVwNAyOhaWY
         Xt7OdymmKZ4coIiMxW2N8Xl+OTfKCVRT3WNTpnY3iGCexQci17lZIE12AQeL3D5UiVyS
         VQYTQdn5UscPbebV3D7u3AUe2p94MwbicNitGhxgYS5yfisit94mxYgbEOrxBYCSIyUt
         YZWEG/TF84E1Qh6/xTqogE88wrm4kvvBX3ldy6kAIwxh6EDKIQbZTZd6Wis7s25lFIBk
         ZuZw==
X-Gm-Message-State: AC+VfDwTHikmUdLCs0PQH1CjCXLGOaZMxwXqKTYRhxlgTY5S7TbhmsC1
        ct3mwVsCLsjDK5YKA42COcpAEtc5u+N1G7pIGYRQDuhA
X-Google-Smtp-Source: ACHHUZ59HvLuKZfwShYmbYxj9Ay/fX1o+MWwyxmhEh3ZmiDo7yac/kFc6cDoAFPE2VmJFCR7vd4nsHwIdJ6yOKMhV28=
X-Received: by 2002:a17:906:72cd:b0:965:d4a0:85bc with SMTP id
 m13-20020a17090672cd00b00965d4a085bcmr18738119ejl.3.1683900310660; Fri, 12
 May 2023 07:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230511073428.10264-1-u.kleine-koenig@pengutronix.de>
 <CAJZ5v0gNPt=rq+pQtmoGL5nxzDQboOK4d6h7=NoY=LueVhZjAQ@mail.gmail.com>
 <20230511103923.hvibdyo5ges4bab2@pengutronix.de> <ZFzWCey825wSlr2v@hovoldconsulting.com>
 <CAJZ5v0jvJT4JkHtO3RCUEzkfawxLCwR=QO2Y2CsL=cYN9s4hXw@mail.gmail.com> <ZF3tUQFTeILXV_VT@hovoldconsulting.com>
In-Reply-To: <ZF3tUQFTeILXV_VT@hovoldconsulting.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 12 May 2023 16:04:59 +0200
Message-ID: <CAJZ5v0gRcaL5y4nyDcFYfnH8sNYOHSHZN1qwcv+Z7yu4jhSiMA@mail.gmail.com>
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

On Fri, May 12, 2023 at 9:39 AM Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, May 11, 2023 at 04:44:25PM +0200, Rafael J. Wysocki wrote:
> > On Thu, May 11, 2023 at 1:48 PM Johan Hovold <johan@kernel.org> wrote:
>
> > > No, this seems like very bad idea and even violates the documentation
> > > which clearly states that the usage counter is balanced before calling
> > > remove() so that drivers can use pm_runtime_suspend() to put devices
> > > into suspended state.
> >
> > I missed that, sorry.
> >
> > > There's is really no good reason to even try to change as this is in no
> > > way a fast path.
> >
> > Still, I think that while the "put" part needs to be done before
> > device_remove(), the actual state change can be carried out later.
> >
> > So something like
> >
> >     pm_runtime_put_noidle(dev);
> >
> >     device_remove(dev);
> >
> >     pm_runtime_suspend(dev);
> >
> > would generally work, wouldn't it?
>
> No, as drivers typically disable runtime pm in their remove callbacks,

What exactly do you mean by "typically"?  None of the PCI drivers
should do that, for instance.

> that pm_runtime_suspend() would amount to a no-op (and calling the
> driver pm ops post unbind and the driver having freed its data would
> not work either).

Well, not really.

There are drivers and there are bus types/PM domains.  Drivers need
not disable PM-runtime in their "remove" callbacks if they know that
the bus type/PM domain will take care of handling PM-runtime properly
after the driver's remove callback has run and the bus type/PM domain
may very well want its PM-runtime suspend callback to run then (for
example, to remove power from the unused device).  Arguably it can
invoke runtime_suspend() from its "remove" callback, so it's not like
this is a big deal, but IMO it helps if the most general case is
considered.

Anyway, the question here really is: Does it make sense to carry out a
runtime suspend immediately before device_remove()?  Honestly, I'm not
sure about that.
