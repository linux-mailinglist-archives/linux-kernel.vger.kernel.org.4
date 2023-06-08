Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8C572745C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjFHBf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFHBf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:35:56 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787B710DE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 18:35:54 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30ad8f33f1aso48468f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 18:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686188153; x=1688780153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIIs8Bl/Zb02fsb4pJ0+krcZSj+FHqr04BDqt1I1KSI=;
        b=5zdQKgFzvMSn0rrQtNuQSO3c4IjcZxz0Uw2rZlRstpGTpnyQxIzEKF6qdEG+DfRKSg
         Q/dHvxIVx80UdvmPlSQP2rJcCOIkD1ZETRk9Hv8LmsqqDQyTLpqTava9xYduK8fWU9W7
         YAdQ310YuSjpg/eZRaEq1x6zdsNiQXFBBA0uscqM6U1FznVW2q2mO+yv1yptyYHI6c31
         Bj0OHB3AkjtHLu0BwvBxtX9RBYDbplauWDZEzByDUnNtfXVkca78KIT6jA5hSv4LzKak
         87Ld7lAXeGGdRrkm5gQUPdaqeUxXxeBkakhpKDK1hxK29oo8HZ4rSTAiquLWbiX4/wN4
         KCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686188153; x=1688780153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIIs8Bl/Zb02fsb4pJ0+krcZSj+FHqr04BDqt1I1KSI=;
        b=jVC4iUS51cn1DNxQ0Azrva7pQ93+3DTDDU/4IktOZhDJC4W8p3gL8CRr4Tev+APOGL
         7Av+N7HQZ0N06/ywI2QGwY2919rAaR9YQtJT3sB09VWZcJhCiszatS1O23xFh0Pe8+0a
         P6iAHWrTQ7CrXS989agX9cAtufeG+CwNd1pCPNuGrZyfDiF32voVvE7rT+SZsW6iJaIl
         4/RoSqd6bJp7OWikU27Cl1NYRs+p+FKtG5uPohNMkor/bCcxV0wdTl+Kjlc0klnQKtfX
         pD6pCgRNBQ6TgFtgbqUyRM7XSJ424gc3C/PzcDBPZCNdkXVpt109NlgcHSKs6sBjcS+a
         aQ3Q==
X-Gm-Message-State: AC+VfDxbLjrqtrrpRRNbE7DOY09GhNfKX0DYxCeKaWXSMiPC+LEy0MLW
        AzZ/kxIs4QtihmR1qMdYJW2GwrIGDK4yr4eLvhcIOg==
X-Google-Smtp-Source: ACHHUZ7P4o+pD+YygZYubeEHDKDtWhE8KsLcuZGWs+Pj6B9xaDl8BZILIS49uA6hiWf7vjmKGT5MDEPb6pL3AFizHTQ=
X-Received: by 2002:adf:ed8a:0:b0:306:2a42:d23b with SMTP id
 c10-20020adfed8a000000b003062a42d23bmr4801123wro.6.1686188152747; Wed, 07 Jun
 2023 18:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230605215529.195045-1-royluo@google.com> <2023060734-survey-shady-f025@gregkh>
In-Reply-To: <2023060734-survey-shady-f025@gregkh>
From:   Roy Luo <royluo@google.com>
Date:   Wed, 7 Jun 2023 18:35:16 -0700
Message-ID: <CA+zupgy1WCh8Z6cKo1No5k4PcsFFpEDBXW-rTZVih7bfASAZDA@mail.gmail.com>
Subject: Re: [PATCH v3] usb: core: add sysfs entry for usb device state
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     raychi@google.com, badhri@google.com,
        Alan Stern <stern@rowland.harvard.edu>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bastien Nocera <hadess@hadess.net>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Douglas Anderson <dianders@chromium.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 12:06=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 05, 2023 at 09:55:28PM +0000, Roy Luo wrote:
> > Expose usb device state to userland as the information is useful in
> > detecting non-compliant setups and diagnosing enumeration failures.
> > For example:
> > - End-to-end signal integrity issues: the device would fail port reset
> >   repeatedly and thus be stuck in POWERED state.
> > - Charge-only cables (missing D+/D- lines): the device would never ente=
r
> >   POWERED state as the HC would not see any pullup.
> >
> > What's the status quo?
> > We do have error logs such as "Cannot enable. Maybe the USB cable is ba=
d?"
> > to flag potential setup issues, but there's no good way to expose them =
to
> > userspace.
> >
> > Why add a sysfs entry in struct usb_port instead of struct usb_device?
> > The struct usb_device is not device_add() to the system until it's in
> > ADDRESS state hence we would miss the first two states. The struct
> > usb_port is a better place to keep the information because its life
> > cycle is longer than the struct usb_device that is attached to the port=
.
> >
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202306042228.e532af6e-oliver.san=
g@intel.com
> > Signed-off-by: Roy Luo <royluo@google.com>
> > ---
> > This patch comes directly from RFC v2 after being reviewed by Alan Ster=
n
> > Link: https://lore.kernel.org/all/20230531010134.1092942-1-royluo@googl=
e.com/
> > More discussion about implementation options is in RFC v1
> > Link: https://lore.kernel.org/all/20230525173818.219633-1-royluo@google=
.com/
> >
> > Changes since v1:
> > * Address Alan Stern's comment: remove redundant NULL initializers in
> >   update_port_device_state().
> >
> > Changes since v2:
> > * Fix "BUG: sleeping function called from invalid context" caught by
> >   kernel test robot. Move sleeping function sysfs_get_dirent to port
> >   initiailzation and keep the kernfs_node for future reference.
> >   (Reviewed-by tag is reset as this patch involves more code changes)
> > ---
> >  Documentation/ABI/testing/sysfs-bus-usb |  9 +++++++
> >  drivers/usb/core/hub.c                  | 15 ++++++++++++
> >  drivers/usb/core/hub.h                  |  4 ++++
> >  drivers/usb/core/port.c                 | 32 +++++++++++++++++++++----
> >  4 files changed, 56 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/AB=
I/testing/sysfs-bus-usb
> > index cb172db41b34..155770f18f9c 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-usb
> > +++ b/Documentation/ABI/testing/sysfs-bus-usb
> > @@ -292,6 +292,15 @@ Description:
> >               which is marked with early_stop has failed to initialize,=
 it will ignore
> >               all future connections until this attribute is clear.
> >
> > +What:                /sys/bus/usb/devices/.../<hub_interface>/port<X>/=
state
> > +Date:                May 2023
>
> It's June :)

Oh I literally lost track of time.. will correct it in the next version.

>
> > +Contact:     Roy Luo <royluo@google.com>
> > +Description:
> > +             Indicates current state of the USB device attached to the=
 port. Valid
> > +             states are: 'not-attached', 'attached', 'powered',
> > +             'reconnecting', 'unauthenticated', 'default', 'addressed'=
,
> > +             'configured', and 'suspended'.
>
> No mentioning that you can poll on this file?  You went through a lot of
> work to add that feature, right?  Or am I mistaking why you added the
> sysfs_notify_dirent() calls?  Are they really not needed?  Or are they
> needed?
>
> Actually why are they needed?  This is a state change, can't you emit
> uevents saying the state changed and if userspace wants to re-read it,
> it will?  Or is that too noisy?
>
> Or is any of this needed at all, and you just want to read the file
> every once in a while from userspace to see what is going on?
>
> Do you have a pointer to any userspace code that is using this new
> interface?
>

Yes, I intentionally make the file pollable because it would be more
useful that way. I can give you a concrete example: when there's a
signal integrity issue during enumeration, the usb device state would
likely be repeatedly switching between POWERED and DEFAULT
state as the usb core goes through different levels of retry loops.
User space programs can poll the sysfs attribute to detect the state
changes and eventually recognize the pattern, which isn't possible
without the attribute being pollable. Right now I don't have anything
available for public review as the userspace part is still in development
and is dependent on this kernel patch.
Using uevent should also work, but I would argue that having the interested
parties to poll the sysfs attribute might be more efficient.
I will explicitly state that the file is pollable in the description
in the next patch.

Thanks,
Roy




> > +
> >  What:                /sys/bus/usb/devices/.../power/usb2_lpm_l1_timeou=
t
> >  Date:                May 2013
> >  Contact:     Mathias Nyman <mathias.nyman@linux.intel.com>
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 97a0f8faea6e..a739403a9e45 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -2018,6 +2018,19 @@ bool usb_device_is_owned(struct usb_device *udev=
)
> >       return !!hub->ports[udev->portnum - 1]->port_owner;
> >  }
> >
> > +static void update_port_device_state(struct usb_device *udev)
> > +{
> > +     struct usb_hub *hub;
> > +     struct usb_port *port_dev;
> > +
> > +     if (udev->parent) {
> > +             hub =3D usb_hub_to_struct_hub(udev->parent);
> > +             port_dev =3D hub->ports[udev->portnum - 1];
> > +             WRITE_ONCE(port_dev->state, udev->state);
> > +             sysfs_notify_dirent(port_dev->state_kn);
> > +     }
> > +}
> > +
> >  static void recursively_mark_NOTATTACHED(struct usb_device *udev)
> >  {
> >       struct usb_hub *hub =3D usb_hub_to_struct_hub(udev);
> > @@ -2030,6 +2043,7 @@ static void recursively_mark_NOTATTACHED(struct u=
sb_device *udev)
> >       if (udev->state =3D=3D USB_STATE_SUSPENDED)
> >               udev->active_duration -=3D jiffies;
> >       udev->state =3D USB_STATE_NOTATTACHED;
> > +     update_port_device_state(udev);
> >  }
> >
> >  /**
> > @@ -2086,6 +2100,7 @@ void usb_set_device_state(struct usb_device *udev=
,
> >                               udev->state !=3D USB_STATE_SUSPENDED)
> >                       udev->active_duration +=3D jiffies;
> >               udev->state =3D new_state;
> > +             update_port_device_state(udev);
> >       } else
> >               recursively_mark_NOTATTACHED(udev);
> >       spin_unlock_irqrestore(&device_state_lock, flags);
> > diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
> > index e23833562e4f..37897afd1b64 100644
> > --- a/drivers/usb/core/hub.h
> > +++ b/drivers/usb/core/hub.h
> > @@ -84,6 +84,8 @@ struct usb_hub {
> >   * @peer: related usb2 and usb3 ports (share the same connector)
> >   * @req: default pm qos request for hubs without port power control
> >   * @connect_type: port's connect type
> > + * @state: device state of the usb device attached to the port
> > + * @state_kn: kernfs_node of the sysfs attribute that accesses @state
> >   * @location: opaque representation of platform connector location
> >   * @status_lock: synchronize port_event() vs usb_port_{suspend|resume}
> >   * @portnum: port index num based one
> > @@ -100,6 +102,8 @@ struct usb_port {
> >       struct usb_port *peer;
> >       struct dev_pm_qos_request *req;
> >       enum usb_port_connect_type connect_type;
> > +     enum usb_device_state state;
> > +     struct kernfs_node *state_kn;
> >       usb_port_location_t location;
> >       struct mutex status_lock;
> >       u32 over_current_count;
> > diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> > index 06a8f1f84f6f..2f906e89054e 100644
> > --- a/drivers/usb/core/port.c
> > +++ b/drivers/usb/core/port.c
> > @@ -160,6 +160,16 @@ static ssize_t connect_type_show(struct device *de=
v,
> >  }
> >  static DEVICE_ATTR_RO(connect_type);
> >
> > +static ssize_t state_show(struct device *dev,
> > +                       struct device_attribute *attr, char *buf)
> > +{
> > +     struct usb_port *port_dev =3D to_usb_port(dev);
> > +     enum usb_device_state state =3D READ_ONCE(port_dev->state);
> > +
> > +     return sprintf(buf, "%s\n", usb_state_string(state));
>
> I thought checkpatch would warn you that you should be using
> sysfs_emit() here, wonder why it didn't.
>
> thanks,
>
> greg k-h
