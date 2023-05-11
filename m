Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692B76FF4E8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238733AbjEKOsy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 May 2023 10:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238576AbjEKOsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:48:36 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D761209C
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:46:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96a6c0cc0fbso22333066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683816277; x=1686408277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqnzDi/QVRxp6pm0Q1uEB35bmvt0vbCJeerKcS3+I5Y=;
        b=R1J6jICva01Pb9sk/aUHmEBl15H8FXkeE/3BGmxS1sFN1HHICwUNUyXetji/8mmwRh
         bHALemUKcJTsQNXKLgFzC0ksZ1aMS6yIlvGKejOAd75ArU3Ukb3UT2a5qIX/zHvWt8FR
         buVRkxzvpE7m3iUi1WbhuNkzJEVXJJ3hZvwz5nlQXccqNKFnUTm/NRAhXdjccGhvf/vP
         ll1QXdpQVvDN1RPnJki3QdS4vFAhNAokm2ydsJoOqgMuYiyoU1lOlm5ly0UPJID5kqAV
         GPxwHNRUhTk61ENsNTqZXe/O4dhcsaXRLUujKfV3DD7VgxLSgMfNKWOKmXBMI4wi08yP
         a8FA==
X-Gm-Message-State: AC+VfDynEJTheqEhpZyo3D6qiMw+Xb60yr60dN9q+dBCqKt8rzWLvT2z
        QI78xfO+K2LwDitWbm5uQw05jhVSBh9i44hEkMA=
X-Google-Smtp-Source: ACHHUZ7kVmxFjn8hGdcEbBHs94OVz+dr/DfEq/F3nggD/KZssGYogqYjWz7l7gUGsui2Ont51ntEorcShjRw9AonTkc=
X-Received: by 2002:a17:906:7a45:b0:92e:f520:7762 with SMTP id
 i5-20020a1709067a4500b0092ef5207762mr18357728ejo.6.1683816276914; Thu, 11 May
 2023 07:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230511073428.10264-1-u.kleine-koenig@pengutronix.de>
 <CAJZ5v0gNPt=rq+pQtmoGL5nxzDQboOK4d6h7=NoY=LueVhZjAQ@mail.gmail.com>
 <20230511103923.hvibdyo5ges4bab2@pengutronix.de> <ZFzWCey825wSlr2v@hovoldconsulting.com>
In-Reply-To: <ZFzWCey825wSlr2v@hovoldconsulting.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 11 May 2023 16:44:25 +0200
Message-ID: <CAJZ5v0jvJT4JkHtO3RCUEzkfawxLCwR=QO2Y2CsL=cYN9s4hXw@mail.gmail.com>
Subject: Re: [PATCH] driver core: Call pm_runtime_put_sync() only after device_remove()
To:     Johan Hovold <johan@kernel.org>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 1:48 PM Johan Hovold <johan@kernel.org> wrote:
>
> On Thu, May 11, 2023 at 12:39:23PM +0200, Uwe Kleine-König wrote:
> > On Thu, May 11, 2023 at 12:18:09PM +0200, Rafael J. Wysocki wrote:
> > > On Thu, May 11, 2023 at 9:34 AM Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > >
> > > > Many drivers that use runtime PM call pm_runtime_get_sync() or one of
> > > > its variants in their remove callback. So calling pm_runtime_put_sync()
> > > > directly before calling the remove callback results (under some
> > > > conditions) in the driver's suspend routine being called just to resume
> > > > it again afterwards.
> > > >
> > > > So delay the pm_runtime_put_sync() call until after device_remove().
> > > >
> > > > Confirmed on a stm32mp157a that doing
> > > >
> > > >         echo 4400e000.can > /sys/bus/platform/drivers/m_can_platform/unbind
> > > >
> > > > (starting with a runtime-pm suspended 4400e000.can) results in one call
> > > > less of m_can_runtime_resume() and m_can_runtime_suspend() each after
> > > > this change was applied.
> > > >
> > > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > >
> > > I'm not against this change, although I kind of expect it to trigger
> > > some fallout that will need to be addressed.  So caveat emtor.
> > >
> > > Anyway
> > >
> > > Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
> >
> > Thanks for your review tag. I wondered if there will be some fallout,
> > and don't know what to expect yet. Sounds like getting it into next soon
> > is a good idea?!
>
> No, this seems like very bad idea and even violates the documentation
> which clearly states that the usage counter is balanced before calling
> remove() so that drivers can use pm_runtime_suspend() to put devices
> into suspended state.

I missed that, sorry.

> There's is really no good reason to even try to change as this is in no
> way a fast path.

Still, I think that while the "put" part needs to be done before
device_remove(), the actual state change can be carried out later.

So something like

    pm_runtime_put_noidle(dev);

    device_remove(dev);

    pm_runtime_suspend(dev);

would generally work, wouldn't it?
