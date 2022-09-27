Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A245EC9B1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiI0Qi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiI0Qiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:38:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815151DADCD
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:38:20 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 23so1068196edw.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=XJ5DOi4w2Bm5/vGpgX33cF5eAL7ftLXCxeZavj2rG2w=;
        b=eAz+RMgix3caXa5Yn+RFr9DflkEA799ongaDNvEaVVsx7oGIdtnStyk+p9hS9Vf2gZ
         7bxbASJmAEhixCQWSowMeNPhJ7wq0gyLxsZEmYsJEDlrMfjKmQAxB3xWq3DZa1yyh+x+
         iOEEsbcF4ZLgPUE0mCMalKURXZ7UjwMSPvtq9DXqPz7EBRTXwQXBCPFcbdUSIOchAZIL
         IrrHq5Isrm5rbdpLD0BBbq4iYL4r0m1TeMyyQsom18FJs8Mf4Yg3JKKVPt679LI8KG5H
         WVpwmjc4LoH1hhx9OjiYjVqnT/zA31qnooF/PcBNU8J6J6b/QkOJsT+OCIB/0P2P9L7J
         dIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=XJ5DOi4w2Bm5/vGpgX33cF5eAL7ftLXCxeZavj2rG2w=;
        b=zrLqTnglOBp3CeGPUkhOokGcD2LcN6mBc7NWFGFklWjWn/xEyB/DuWZRycR7GVKybX
         XyIzvUZ7jbaPS1Z/HVTVrV1KcEXguxUgYt9M/ijdEwF6ExeNxVJ4QahbmhmVL+cmuK6E
         kYajxO37ZLZoZp9nhI6jA6rt2B/aTcKgS2hYOm36eHwHpTlfZRrH8kevz8D1QFGTpmRy
         MOEG0fi53RNgdc/gFgI40mEq/b9rzYJyp6ehXb18ZZiqO5TUBNn2ffVCmV3ThLcZDJOH
         HID+Gny3mR8H8tsNSxclojJziSHClkDGQqZeTeNuoTCb5U+6gab9Lj2GE2xLbyHUdEiS
         PYBw==
X-Gm-Message-State: ACrzQf3Z4TnaNbD2l8syRmyJWv+aWiRR79QZUh4INmuDE5TbuHipTgsh
        pw2+RobYNf3QtkC0TDqANhR0VHrU7n5FJmiiRwaqaQ==
X-Google-Smtp-Source: AMsMyM7y0MSqI81cXR8a2r95J0Fv1Qezk2TQReCTPwrSThnmTgtfMmv2drleEexAd1vMnjHk/Fb9w9lzeWNqpGH6rOk=
X-Received: by 2002:a05:6402:3211:b0:453:ba03:9dee with SMTP id
 g17-20020a056402321100b00453ba039deemr29043085eda.351.1664296686682; Tue, 27
 Sep 2022 09:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220908104019.3080989-1-raychi@google.com> <YyxP2/GLgyp5Cq66@kroah.com>
 <Yyx8BbxM97FeNwJ7@rowland.harvard.edu>
In-Reply-To: <Yyx8BbxM97FeNwJ7@rowland.harvard.edu>
From:   Ray Chi <raychi@google.com>
Date:   Wed, 28 Sep 2022 00:37:55 +0800
Message-ID: <CAPBYUsA8gs82kk1b6Hee94P+hEut=RY9NQci4NTNTuOKOvVY+g@mail.gmail.com>
Subject: Re: [Patch v3] usb: core: stop USB enumeration if too many retries
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>, mchehab+huawei@kernel.org,
        Albert Wang <albertccwang@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Puma Hsu <pumahsu@google.com>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 11:15 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> Sorry I forgot about this patch.
>
> On Thu, Sep 22, 2022 at 02:06:51PM +0200, Greg KH wrote:
> > On Thu, Sep 08, 2022 at 06:40:19PM +0800, Ray Chi wrote:
> > > When a broken USB accessory connects to a USB host, usbcore might
> > > keep doing enumeration retries. If the host has a watchdog mechanism,
> > > the kernel panic will happen on the host.
> > >
> > > The patch provide a attribute to limit the numbers of retries and
> > > timeout lengths.
> >
> > This is per-port, right?  Please say that here.
>
> Also, the patch does not limit any timeout lengths -- just the number of
> retries.  Maybe you want to make it limit the timeouts also.

I modified the changelog.

>
> > > In addition, it also adds a function to stop the
> > > port initialization and ignore events on the port if the broken
> > > accessory is still connected.
> >
> > So this should be 2 patches?  Remember, only do one logical thing per
> > patch please.
>
> The "adding a function" part is unimportant; we can see the function
> simply by reading the patch.  The main points here, which you have not
> explained clearly, are:
>
>     1.  If a port is marked with the quick_init attribute, unsuccessful
>         connection attempts will fail quickly.
>
>     2.  Once a quick_init port has failed to initialize, it will ignore
>         all future connections until the quick_init attribute is turned
>         off.
>

The changelog is modified.

> > > Signed-off-by: Ray Chi <raychi@google.com>
> > > ---
> > > Changes since v2:
> > >  - replace the quirk with the attribute
> > >  - Document the attribute
> > >  - modify hub_port_stop_enumerate() position in port_event()
> > >  - modify the changelog
> > >
> > > Changes since v1:
> > >  - remove usb_hub_set_port_power()
> > >  - add a variable ignore_connect into struct port_dev
> > >  - modify hub_port_stop_enumerate() and set ignore_connect in
> > >    this function
> > >  - avoid calling hub_port_connect_change() in port_event()
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-usb |  9 ++++++
> > >  drivers/usb/core/hub.c                  | 39 +++++++++++++++++++++++++
> > >  drivers/usb/core/hub.h                  |  4 +++
> > >  drivers/usb/core/port.c                 | 23 +++++++++++++++
> > >  4 files changed, 75 insertions(+)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
> > > index 568103d3376e..d44c8aaef929 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-usb
> > > +++ b/Documentation/ABI/testing/sysfs-bus-usb
> > > @@ -264,6 +264,15 @@ Description:
> > >             attached to the port will not be detected, initialized,
> > >             or enumerated.
> > >
> > > +What:              /sys/bus/usb/devices/.../<hub_interface>/port<X>/quick_init
> > > +Date:              Sep 2022
> > > +Contact:   Ray Chi <raychi@google.com>
> > > +Description:
> > > +           Some USB hosts have some watchdog mechanisms so that the device
> > > +           may enter ramdump if it takes a long time during port initialization.
> > > +           This attribute limits the numbers of retries and timeout lengths once
> > > +           an initialization of the port meets failures.
> >
> > The text here is very odd, maybe it's just a translation issue.  A port
> > can not "meet" a failure.  And this really has nothing to do with any
> > watchdog, it's just a "we want to fail broken devices quickly instead of
> > giving them lots of time to connect" type of issue, right?
> >
> > And we already have different init schemes, "quick" is an odd way to
> > phrase this, but I can't think of anything else at the moment.
>
> "fail-fast" gives the idea better, but it's more awkward.
>

The documentation is modified and I rename the sysfs node from quick_init to
early_stop. I think it would be better.

> > > +
> > >  What:              /sys/bus/usb/devices/.../power/usb2_lpm_l1_timeout
> > >  Date:              May 2013
> > >  Contact:   Mathias Nyman <mathias.nyman@linux.intel.com>
> > > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > > index d4b1e70d1498..f22caa133274 100644
> > > --- a/drivers/usb/core/hub.c
> > > +++ b/drivers/usb/core/hub.c
> > > @@ -3081,6 +3081,29 @@ static int hub_port_reset(struct usb_hub *hub, int port1,
> > >     return status;
> > >  }
> > >
> > > +/* Check whether a hub would stop enumeration or ignore events on the port. */
> >
> > Based on what?  Retries?  Time of day?  Phase of moon?  :)
> >

I added more comments to explain the details.

> > > +static bool hub_port_stop_enumerate(struct usb_hub *hub, int port1, int retries)
> > > +{
> > > +   struct usb_port *port_dev = hub->ports[port1 - 1];
> > > +
> > > +   if (port_dev->quick_init) {
> > > +           if (port_dev->ignore_connect)
> > > +                   return true;
> > > +
> > > +           /*
> > > +            * Since some normal devices will be timeout in the first attempt,
> > > +            * set the condition to half of the retries
> > > +            */
> > > +           if (retries < (PORT_INIT_TRIES - 1) / 2)
> > > +                   return false;
>
> This is not a good test.  You shouldn't rely on PORT_INIT_TRIES having
> any particular value or being used in any particular way.  You should
> just something like:
>
>                 /*
>                  * We want unsuccessful attempts to fail quickly.
>                  * Therefore allow three tries but no more.
>                  */
>                 if (retries < 3)
>

It is modified.

> > > +
> > > +           port_dev->ignore_connect = true;
> > > +   } else
> > > +           port_dev->ignore_connect = false;
> >
> > So this function modifies a port_dev value, AND returns it to the
> > caller?  Why not document that somewhere?  Why do both?
> >

I add the comments to explain the details.

> > And if quick_init is false then it always set ignore_connect to false
> > and returns false always?
>
> As mentioned above, the goal is to limit the number of retries if
> quick_init is set and prevent all connection attempts once one has
> failed, without changing anything if quick_init is not set.
>
> >
> > > +
> > > +   return port_dev->ignore_connect;
> > > +}
> > > +
> > >  /* Check if a port is power on */
> > >  int usb_port_is_power_on(struct usb_hub *hub, unsigned int portstatus)
> > >  {
> > > @@ -4855,6 +4878,11 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
> > >                                     buf->bMaxPacketSize0;
> > >                     kfree(buf);
> > >
> > > +                   if (r < 0 && port_dev->quick_init) {
> > > +                           retval = r;
> > > +                           goto fail;
>
> I still think you should test hub_port_stop_enumeration() here.  It
> doesn't make sense that you allow a few retries for other types of
> errors but not for this one.
>
> Alan Stern
>
It is modified.

> > > +                   }
> > > +
> > >                     retval = hub_port_reset(hub, port1, udev, delay, false);
> > >                     if (retval < 0)         /* error or disconnect */
> > >                             goto fail;
> > > @@ -5387,6 +5415,9 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
> > >             if ((status == -ENOTCONN) || (status == -ENOTSUPP))
> > >                     break;
> > >
> > > +           if (hub_port_stop_enumerate(hub, port1, i))
> > > +                   break;
> > > +
> > >             /* When halfway through our retry count, power-cycle the port */
> > >             if (i == (PORT_INIT_TRIES - 1) / 2) {
> > >                     dev_info(&port_dev->dev, "attempt power cycle\n");
> > > @@ -5614,6 +5645,9 @@ static void port_event(struct usb_hub *hub, int port1)
> > >     if (!pm_runtime_active(&port_dev->dev))
> > >             return;
> > >
> > > +   if (hub_port_stop_enumerate(hub, port1, 0))
> > > +           return;
> > > +
> > >     if (hub_handle_remote_wakeup(hub, port1, portstatus, portchange))
> > >             connect_change = 1;
> > >
> > > @@ -5934,6 +5968,9 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
> > >             ret = hub_port_init(parent_hub, udev, port1, i);
> > >             if (ret >= 0 || ret == -ENOTCONN || ret == -ENODEV)
> > >                     break;
> > > +
> > > +           if (hub_port_stop_enumerate(parent_hub, port1, i))
> > > +                   goto stop_enumerate;
> > >     }
> > >     mutex_unlock(hcd->address0_mutex);
> > >
> > > @@ -6022,6 +6059,8 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
> > >     udev->bos = bos;
> > >     return 0;
> > >
> > > +stop_enumerate:
> > > +   mutex_unlock(hcd->address0_mutex);
> > >  re_enumerate:
> > >     usb_release_bos_descriptor(udev);
> > >     udev->bos = bos;
> > > diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
> > > index b2925856b4cb..57995ec3af58 100644
> > > --- a/drivers/usb/core/hub.h
> > > +++ b/drivers/usb/core/hub.h
> > > @@ -90,6 +90,8 @@ struct usb_hub {
> > >   * @is_superspeed cache super-speed status
> > >   * @usb3_lpm_u1_permit: whether USB3 U1 LPM is permitted.
> > >   * @usb3_lpm_u2_permit: whether USB3 U2 LPM is permitted.
> > > + * @ignore_connect: ignore the connection or not.
> >
> > Which connection?  Any future connection?  Or the one that is currently
> > connected?
> >
> > > + * @quick_init: limit the numbers of retries for port initialization
> >
> > Limit it to what?
> >
> > >   */
> > >  struct usb_port {
> > >     struct usb_device *child;
> > > @@ -103,6 +105,8 @@ struct usb_port {
> > >     u32 over_current_count;
> > >     u8 portnum;
> > >     u32 quirks;
> > > +   bool ignore_connect;
> > > +   bool quick_init;
> >
> > Why are these bool, when:
> >
> > >     unsigned int is_superspeed:1;
> > >     unsigned int usb3_lpm_u1_permit:1;
> > >     unsigned int usb3_lpm_u2_permit:1;
> >
> > Those are all bits?
> >
> > Be consistent please.
> >
> > thanks,
> >
> > greg k-h

BTW, I found a new mail tree is created after the patch v4 is
uploaded, but the patch is downloaded by mbox.
What do I do if I want to keep the original mail tree?

Thanks,
Ray
