Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EE07276B1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 07:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbjFHFbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 01:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbjFHFay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 01:30:54 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B847A26B6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 22:30:51 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b2a8e0306eso131249a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 22:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686202250; x=1688794250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=in3/WtqsgTwPEpzF5ceM0F5Df9m1naK1uamfx90MmFE=;
        b=Ks6zwliHPUOkny2ramP0X8XM6KwPvszSjbRasoHyw9lQs9anxYU8srbRn2/RpqPjEG
         5Qug322Pr+QOkay8Gc/FrmVV9j+3hvOEgWatQ+nnV0Scz8m7mf3VU1+wXZAywTwWACMU
         hy5VT3h1zfpYuUdMFdguXYQCwoIIhbRVet4Ja0TQ+OwBu2o2HND2Pzc1IJe+m+u8T1Nv
         3SAgJi4DY/DCSUs6zWyEr3RuhNc13xht62MYtDWTrc92REw505JAuVb+sj9Ujk8RwzR5
         udzn0NfHf5OLAvEiuIm8f8EJ34dMtcgSAUlrxFENt+kSktaDvi8Ri1Ju+bBTOcgTS5kv
         pFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686202250; x=1688794250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=in3/WtqsgTwPEpzF5ceM0F5Df9m1naK1uamfx90MmFE=;
        b=ftbbZhA6WaupGcxqlQGeOFhPx15xoNlNqOQVS6TCPFRROt6bRDWs8BPX7PJFBOaKqj
         dHrqRP+vISgK7YFkz+ce45y7118UMXqwqazYnGBqB6GMoD3C8dl54FvY1u29uQ4GxeYK
         AX7CE6pEeIxG1tUuLAjfL6o+edtnngdiCYMIOja5kUcMC3beVYMaE10SiEL7POdEKS99
         MtZ9ZSjEWJG9IiU2riWrhJGNdk1ByHtjNriup08aoKL1IshJ1JHPfDb7ZeuEOA9o+KMf
         Pfc/y/AF+3ZqN14IiEX1qKkhU1nkp1ya76FwFhmZJyTZyImBl+Y/+ZqmO0dkzciwUswF
         81IQ==
X-Gm-Message-State: AC+VfDxLouP/7MNGWWKAJ50ZrwHJvcrUmzIybW+dQkDFcRhWdyQMfvOy
        vj8QzTdNWj69XJoM8KlHwClCCcywtsUjnWoJYGj5SQ==
X-Google-Smtp-Source: ACHHUZ6Nh58lqxkqV7k/9eYCgEbdkbU+3Oa8bo2rQp9KKhbfdNfNXytpD00uFpt1lYwNxt4qSRX7Zp3RdzRlJhCdmOI=
X-Received: by 2002:aca:2811:0:b0:39c:7749:74b4 with SMTP id
 17-20020aca2811000000b0039c774974b4mr1894045oix.17.1686202249731; Wed, 07 Jun
 2023 22:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230601031028.544244-1-badhri@google.com> <20230601031028.544244-2-badhri@google.com>
 <0bea99f1-cf66-4e80-b89b-41007c2ccfee@rowland.harvard.edu>
In-Reply-To: <0bea99f1-cf66-4e80-b89b-41007c2ccfee@rowland.harvard.edu>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Wed, 7 Jun 2023 22:30:12 -0700
Message-ID: <CAPTae5K9vyezSqCwBH7wui3GQ8uzAjp561+bNCNSefvdyeCWBg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] usb: gadget: udc: core: Prevent
 soft_connect_store() race
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, peter.chen@freescale.com,
        balbi@ti.com, francesco@dolcini.it, alistair@alistair23.me,
        stephan@gerhold.net, bagasdotme@gmail.com, luca@z3ntu.xyz,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 11:26=E2=80=AFAM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> This patch looks basically okay.  Most of the comments below are
> concerned only with style or presentation.
>
> On Thu, Jun 01, 2023 at 03:10:28AM +0000, Badhri Jagan Sridharan wrote:
> > usb_udc_connect_control(), soft_connect_store() and
> > usb_gadget_deactivate() can potentialy race against each other to invok=
e
>
> "potentially" has two 'l's.
>
> > usb_gadget_connect()/usb_gadget_disconnect(). To prevent this, guarding
>
> s/guarding/guard/
>
> > udc->vbus, udc->started, gadget->allow_connect, gadget->deactivate with
>
> Insert "and" before "gadget->deactivate".
>
> Also, I don't think the patch guards udc->vbus.  After all, that flag
> can be changed in usb_udc_vbus_handler() without the protection of the
> mutex.
>
> > connect_lock so that ->pullup() is only invoked when gadget driver is
> > bound, not deactivated and started.
>
> "when the gadget", not "when gadget driver".  The driver isn't what gets
> deactivated or started; the gadget is.
>
> This would be easier to understand if the last two items were switched:
>
>         bound, started, and not deactivated.
>
> Also, it would help readers if there were some additional text to help
> separate the end of this sentence from the start of the next one.  For
> example, you might insert "The routines" at the beginning of the next
> sentence.
>
> >  usb_gadget_connect_locked(),
> > usb_gadget_disconnect_locked(), usb_udc_connect_control_locked(),
> > usb_gadget_udc_start_locked(), usb_gadget_udc_stop_locked() are called
> > with this lock held.
> >
> > This commit was reverted due to the crash reported in
>
> An earlier version of this commit...
>
> > https://lore.kernel.org/all/ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.c=
om/.
> > commit 16737e78d190 ("usb: gadget: udc: core: Offload usb_udc_vbus_hand=
ler processing")
> > addresses the crash reported.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 628ef0d273a6 ("usb: udc: add usb_udc_vbus_handler")
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
> > v5 is the first version in this series.
> > Changes since v5:
> > ** Fixed up commit message
> > ** Wrapped comments at 76.
> > ---
> >  drivers/usb/gadget/udc/core.c | 151 ++++++++++++++++++++++++----------
> >  1 file changed, 109 insertions(+), 42 deletions(-)
> >
> > diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/cor=
e.c
> > index d2e4f78c53e3..b53f74fcad60 100644
> > --- a/drivers/usb/gadget/udc/core.c
> > +++ b/drivers/usb/gadget/udc/core.c
> > @@ -40,6 +40,11 @@ static const struct bus_type gadget_bus_type;
> >   * @allow_connect: Indicates whether UDC is allowed to be pulled up.
> >   * Set/cleared by gadget_(un)bind_driver() after gadget driver is boun=
d or
> >   * unbound.
> > + * @connect_lock: protects udc->vbus, udc->started, gadget->connect,
> > + * gadget->deactivate. usb_gadget_connect_locked,
>
> Again, separate the two sentences with some extra text.  Otherwise the
> period looks too much like a comma for people to see it easily.
>
> > + * usb_gadget_disconnect_locked, usb_udc_connect_control_locked,
> > + * usb_gadget_udc_start_locked, usb_gadget_udc_stop_locked are called =
with
> > + * this lock held.
> >   *
> >   * This represents the internal data structure which is used by the UD=
C-class
> >   * to hold information about udc driver and gadget together.
> > @@ -53,6 +58,7 @@ struct usb_udc {
> >       bool                            started;
> >       bool                            allow_connect;
> >       struct work_struct              vbus_work;
> > +     struct mutex                    connect_lock;
> >  };
> >
> >  static struct class *udc_class;
> > @@ -692,17 +698,12 @@ int usb_gadget_vbus_disconnect(struct usb_gadget =
*gadget)
> >  }
> >  EXPORT_SYMBOL_GPL(usb_gadget_vbus_disconnect);
> >
> > -/**
> > - * usb_gadget_connect - software-controlled connect to USB host
> > - * @gadget:the peripheral being connected
> > - *
> > - * Enables the D+ (or potentially D-) pullup.  The host will start
> > - * enumerating this gadget when the pullup is active and a VBUS sessio=
n
> > - * is active (the link is powered).
> > - *
> > - * Returns zero on success, else negative errno.
> > +/*
> > + * Internal version of usb_gadget_connect needs to be called with
> > + * connect_lock held.
>
> I'm not sure you need to say this; it's pretty obvious from the
> __must_hold() annotation a few lines later.  Consider removing this
> paragraph and the similar paragraphs in the other new internal routines.
>
> >   */
> > -int usb_gadget_connect(struct usb_gadget *gadget)
> > +static int usb_gadget_connect_locked(struct usb_gadget *gadget)
> > +     __must_hold(&gadget->udc->connect_lock)
> >  {
> >       int ret =3D 0;
> >
> > @@ -711,10 +712,12 @@ int usb_gadget_connect(struct usb_gadget *gadget)
> >               goto out;
> >       }
> >
> > -     if (gadget->deactivated || !gadget->udc->allow_connect) {
> > +     if (gadget->deactivated || !gadget->udc->allow_connect || !gadget=
->udc->started) {
> >               /*
> >                * If gadget is deactivated we only save new state.
> >                * Gadget will be connected automatically after activatio=
n.
>
> This comment is now inaccurate.  Change it to say:
>
>                  * If the gadget isn't usable (because it is deactivated,
>                  * unbound, or not yet started), we only save the new sta=
te.
>                  * The gadget will be connected automatically when it is
>                  * activated/bound/started.
>
> > +              *
> > +              * udc first needs to be started before gadget can be pul=
led up.
>
> And then this sentence won't be needed.
>
> >                */
> >               gadget->connected =3D true;
> >               goto out;
> > @@ -729,22 +732,35 @@ int usb_gadget_connect(struct usb_gadget *gadget)
> >
> >       return ret;
> >  }
> > -EXPORT_SYMBOL_GPL(usb_gadget_connect);
> >
> >  /**
> > - * usb_gadget_disconnect - software-controlled disconnect from USB hos=
t
> > - * @gadget:the peripheral being disconnected
> > - *
> > - * Disables the D+ (or potentially D-) pullup, which the host may see
> > - * as a disconnect (when a VBUS session is active).  Not all systems
> > - * support software pullup controls.
> > + * usb_gadget_connect - software-controlled connect to USB host
> > + * @gadget:the peripheral being connected
> >   *
> > - * Following a successful disconnect, invoke the ->disconnect() callba=
ck
> > - * for the current gadget driver so that UDC drivers don't need to.
> > + * Enables the D+ (or potentially D-) pullup.  The host will start
> > + * enumerating this gadget when the pullup is active and a VBUS sessio=
n
> > + * is active (the link is powered).
> >   *
> >   * Returns zero on success, else negative errno.
> >   */
> > -int usb_gadget_disconnect(struct usb_gadget *gadget)
> > +int usb_gadget_connect(struct usb_gadget *gadget)
> > +{
> > +     int ret;
> > +
> > +     mutex_lock(&gadget->udc->connect_lock);
> > +     ret =3D usb_gadget_connect_locked(gadget);
> > +     mutex_unlock(&gadget->udc->connect_lock);
> > +
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(usb_gadget_connect);
> > +
> > +/*
> > + * Internal version of usb_gadget_disconnect needs to be called with
> > + * connect_lock held.
> > + */
> > +static int usb_gadget_disconnect_locked(struct usb_gadget *gadget)
> > +     __must_hold(&gadget->udc->connect_lock)
> >  {
> >       int ret =3D 0;
> >
> > @@ -756,10 +772,12 @@ int usb_gadget_disconnect(struct usb_gadget *gadg=
et)
> >       if (!gadget->connected)
> >               goto out;
> >
> > -     if (gadget->deactivated) {
> > +     if (gadget->deactivated || !gadget->udc->started) {
>
> Do you really need to add this extra test?  After all, if the gadget
> isn't started then how could the previous test of gadget->connected
> possibly succeed?
>
> In fact, I suspect this entire section of code was always useless, since
> the gadget couldn't be connected now if it was already deactivated.
>
Thanks Alan ! Will fix all other comments in v7 but not sure about this one=
.
Although the ->pullup() function will not be called,
-> connected flag could actually be set when the gadget is not started.

- if (gadget->deactivated || !gadget->udc->allow_connect) {
+ if (gadget->deactivated || !gadget->udc->allow_connect ||
!gadget->udc->started) {
  /*
  * If gadget is deactivated we only save new state.
  * Gadget will be connected automatically after activation.
+ *
+ * udc first needs to be started before gadget can be pulled up.
  */
  gadget->connected =3D true;

This could happen, for instance, when  usb_udc_vbus_handler()  is
invoked after soft_connect_store() disconnects the gadget.
Same applies to when usb_gadget_connect() is called after the gadget
has been deactivated through usb_gadget_deactivate().

This implies that the checks should be there, right ?

> >               /*
> >                * If gadget is deactivated we only save new state.
> >                * Gadget will stay disconnected after activation.
> > +              *
> > +              * udc should have been started before gadget being pulle=
d down.
>
> No need to mention this.
>
> >                */
> >               gadget->connected =3D false;
> >               goto out;
> > @@ -779,6 +797,30 @@ int usb_gadget_disconnect(struct usb_gadget *gadge=
t)
> >
> >       return ret;
> >  }
> > +
> > +/**
> > + * usb_gadget_disconnect - software-controlled disconnect from USB hos=
t
> > + * @gadget:the peripheral being disconnected
> > + *
> > + * Disables the D+ (or potentially D-) pullup, which the host may see
> > + * as a disconnect (when a VBUS session is active).  Not all systems
> > + * support software pullup controls.
> > + *
> > + * Following a successful disconnect, invoke the ->disconnect() callba=
ck
> > + * for the current gadget driver so that UDC drivers don't need to.
> > + *
> > + * Returns zero on success, else negative errno.
> > + */
> > +int usb_gadget_disconnect(struct usb_gadget *gadget)
> > +{
> > +     int ret;
> > +
> > +     mutex_lock(&gadget->udc->connect_lock);
> > +     ret =3D usb_gadget_disconnect_locked(gadget);
> > +     mutex_unlock(&gadget->udc->connect_lock);
> > +
> > +     return ret;
> > +}
> >  EXPORT_SYMBOL_GPL(usb_gadget_disconnect);
> >
> >  /**
> > @@ -799,10 +841,11 @@ int usb_gadget_deactivate(struct usb_gadget *gadg=
et)
> >       if (gadget->deactivated)
> >               goto out;
> >
> > +     mutex_lock(&gadget->udc->connect_lock);
>
> The mutex should be acquired _before_ the test of gadget->deactivated.
> Otherwise the the state could change between the time of the test and
> the time of the mutex_lock().
>
> >       if (gadget->connected) {
> > -             ret =3D usb_gadget_disconnect(gadget);
> > +             ret =3D usb_gadget_disconnect_locked(gadget);
> >               if (ret)
> > -                     goto out;
> > +                     goto unlock;
> >
> >               /*
> >                * If gadget was being connected before deactivation, we =
want
> > @@ -812,6 +855,8 @@ int usb_gadget_deactivate(struct usb_gadget *gadget=
)
> >       }
> >       gadget->deactivated =3D true;
> >
> > +unlock:
> > +     mutex_unlock(&gadget->udc->connect_lock);
> >  out:
> >       trace_usb_gadget_deactivate(gadget, ret);
> >
> > @@ -835,6 +880,7 @@ int usb_gadget_activate(struct usb_gadget *gadget)
> >       if (!gadget->deactivated)
> >               goto out;
> >
> > +     mutex_lock(&gadget->udc->connect_lock);
> >       gadget->deactivated =3D false;
>
> Again, lock the mutex before testing the flag.
>
> >
> >       /*
> > @@ -842,7 +888,8 @@ int usb_gadget_activate(struct usb_gadget *gadget)
> >        * while it was being deactivated, we call usb_gadget_connect().
> >        */
> >       if (gadget->connected)
> > -             ret =3D usb_gadget_connect(gadget);
> > +             ret =3D usb_gadget_connect_locked(gadget);
> > +     mutex_unlock(&gadget->udc->connect_lock);
> >
> >  out:
> >       trace_usb_gadget_activate(gadget, ret);
> > @@ -1083,19 +1130,22 @@ EXPORT_SYMBOL_GPL(usb_gadget_set_state);
> >
> >  /* -------------------------------------------------------------------=
------ */
> >
> > -static void usb_udc_connect_control(struct usb_udc *udc)
> > +/* Acquire connect_lock before calling this function. */
> > +static void usb_udc_connect_control_locked(struct usb_udc *udc) __must=
_hold(&udc->connect_lock)
> >  {
> >       if (udc->vbus)
> > -             usb_gadget_connect(udc->gadget);
> > +             usb_gadget_connect_locked(udc->gadget);
> >       else
> > -             usb_gadget_disconnect(udc->gadget);
> > +             usb_gadget_disconnect_locked(udc->gadget);
> >  }
> >
> >  static void vbus_event_work(struct work_struct *work)
> >  {
> >       struct usb_udc *udc =3D container_of(work, struct usb_udc, vbus_w=
ork);
> >
> > -     usb_udc_connect_control(udc);
> > +     mutex_lock(&udc->connect_lock);
> > +     usb_udc_connect_control_locked(udc);
> > +     mutex_unlock(&udc->connect_lock);
> >  }
> >
> >  /**
> > @@ -1144,7 +1194,7 @@ void usb_gadget_udc_reset(struct usb_gadget *gadg=
et,
> >  EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
> >
> >  /**
> > - * usb_gadget_udc_start - tells usb device controller to start up
> > + * usb_gadget_udc_start_locked - tells usb device controller to start =
up
> >   * @udc: The UDC to be started
> >   *
> >   * This call is issued by the UDC Class driver when it's about
> > @@ -1155,8 +1205,11 @@ EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
> >   * necessary to have it powered on.
> >   *
> >   * Returns zero on success, else negative errno.
> > + *
> > + * Caller should acquire connect_lock before invoking this function.
> >   */
> > -static inline int usb_gadget_udc_start(struct usb_udc *udc)
> > +static inline int usb_gadget_udc_start_locked(struct usb_udc *udc)
> > +     __must_hold(&udc->connect_lock)
> >  {
> >       int ret;
> >
> > @@ -1173,7 +1226,7 @@ static inline int usb_gadget_udc_start(struct usb=
_udc *udc)
> >  }
> >
> >  /**
> > - * usb_gadget_udc_stop - tells usb device controller we don't need it =
anymore
> > + * usb_gadget_udc_stop_locked - tells usb device controller we don't n=
eed it anymore
> >   * @udc: The UDC to be stopped
> >   *
> >   * This call is issued by the UDC Class driver after calling
> > @@ -1182,8 +1235,11 @@ static inline int usb_gadget_udc_start(struct us=
b_udc *udc)
> >   * The details are implementation specific, but it can go as
> >   * far as powering off UDC completely and disable its data
> >   * line pullups.
> > + *
> > + * Caller should acquire connect lock before invoking this function.
> >   */
> > -static inline void usb_gadget_udc_stop(struct usb_udc *udc)
> > +static inline void usb_gadget_udc_stop_locked(struct usb_udc *udc)
> > +     __must_hold(&udc->connect_lock)
> >  {
> >       if (!udc->started) {
> >               dev_err(&udc->dev, "UDC had already stopped\n");
> > @@ -1342,6 +1398,7 @@ int usb_add_gadget(struct usb_gadget *gadget)
> >
> >       udc->gadget =3D gadget;
> >       gadget->udc =3D udc;
> > +     mutex_init(&udc->connect_lock);
> >
> >       udc->started =3D false;
> >
> > @@ -1545,12 +1602,16 @@ static int gadget_bind_driver(struct device *de=
v)
> >       if (ret)
> >               goto err_bind;
> >
> > -     ret =3D usb_gadget_udc_start(udc);
> > -     if (ret)
> > +     mutex_lock(&udc->connect_lock);
> > +     ret =3D usb_gadget_udc_start_locked(udc);
> > +     if (ret) {
> > +             mutex_unlock(&udc->connect_lock);
> >               goto err_start;
> > +     }
> >       usb_gadget_enable_async_callbacks(udc);
> >       udc->allow_connect =3D true;
> > -     usb_udc_connect_control(udc);
> > +     usb_udc_connect_control_locked(udc);
> > +     mutex_unlock(&udc->connect_lock);
> >
> >       kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
> >       return 0;
> > @@ -1583,12 +1644,14 @@ static void gadget_unbind_driver(struct device =
*dev)
> >
> >       udc->allow_connect =3D false;
> >       cancel_work_sync(&udc->vbus_work);
> > -     usb_gadget_disconnect(gadget);
> > +     mutex_lock(&udc->connect_lock);
> > +     usb_gadget_disconnect_locked(gadget);
> >       usb_gadget_disable_async_callbacks(udc);
> >       if (gadget->irq)
> >               synchronize_irq(gadget->irq);
> >       udc->driver->unbind(gadget);
> > -     usb_gadget_udc_stop(udc);
> > +     usb_gadget_udc_stop_locked(udc);
> > +     mutex_unlock(&udc->connect_lock);
> >
> >       mutex_lock(&udc_lock);
> >       driver->is_bound =3D false;
>
> In both these routines, you are careful not to hold the
> udc->connect_lock and the udc_lock at the same time.  Good.
>
> > @@ -1674,11 +1737,15 @@ static ssize_t soft_connect_store(struct device=
 *dev,
> >       }
> >
> >       if (sysfs_streq(buf, "connect")) {
> > -             usb_gadget_udc_start(udc);
> > -             usb_gadget_connect(udc->gadget);
> > +             mutex_lock(&udc->connect_lock);
> > +             usb_gadget_udc_start_locked(udc);
> > +             usb_gadget_connect_locked(udc->gadget);
>
> Interesting change of behavior here.  Before this patch the connect
> operation would succeed, even if no gadget driver was bound.  Now it
> won't, which is how it ought to behave.
>
> > +             mutex_unlock(&udc->connect_lock);
> >       } else if (sysfs_streq(buf, "disconnect")) {
> > -             usb_gadget_disconnect(udc->gadget);
> > -             usb_gadget_udc_stop(udc);
> > +             mutex_lock(&udc->connect_lock);
> > +             usb_gadget_disconnect_locked(udc->gadget);
> > +             usb_gadget_udc_stop_locked(udc);
> > +             mutex_unlock(&udc->connect_lock);
> >       } else {
> >               dev_err(dev, "unsupported command '%s'\n", buf);
> >               ret =3D -EINVAL;
>
> Alan Stern
