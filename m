Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7663B6AA6AB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 01:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCDAx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 19:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCDAx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 19:53:27 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAD514229
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 16:53:25 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id n6so4572626plf.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 16:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677891204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGsWNoxQhLEIuoH+IcalS1+Vd2/Gu57sEbt0Nb6KdpE=;
        b=LzTNgRuz0e2d/eLT3OBZGzppncwyCA9lU1SzoKid6iIewIx4/w+OVU0laJm+GY4zVa
         5s3lELHiW0PEZR42Q55BdQc6bPZZoM28txj1key/Sh5OC/Kx8ig4Qt/m9hj6BuqXylJR
         919umJWKbMgnWsvoVEm+cHReEWLm1c2c4cdHkZK5kwSePwH7CNEARGGQriHQM9GHN7GV
         3UnLVKE/dxsqG3h9nnTcmSqQCVqCRrzPAFYTYS5LJTdIFS6yfTGE/yCvEYt5f3VBZnhM
         PGCiqdLY5MoImhYQ4+pJXg5wZXM7EbpUvJwuFk1DF+lRpft/NydrbSgPK2UrnoSNaHND
         eUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677891204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGsWNoxQhLEIuoH+IcalS1+Vd2/Gu57sEbt0Nb6KdpE=;
        b=t2rPkVNP/HV1BOsupoF60I76GQ4JagLET9yy4wISV80oAfnNVtBhsZOW0zATnT5an9
         0dCDgUlKk+t6D7YyIPntBSlSpGAc+P+be7FbkN6ztVxU6C6muQvb2BWDTOyplCpvVIKn
         lx8HfiqzB/5LgFqSpDdgLr2aDlLscPAUFyiesiZDMyucFv/5ZnVpoOU5CgqgJs9aNWqt
         pMLpGKMrtFA/APu03AL+YwvnsZMs7LnzeDYFUpfsI75NtRKoUAq+pNgt2oKMBXEjlpmX
         6Qe5LE8sJEWOMWrroM5jr0fUdur9nGwh+wepRdmJQeGWhvLygYXy7Ri1auD49bLtPkUF
         yAVQ==
X-Gm-Message-State: AO0yUKWiRfaQMJyST6cHWkmnAxlw4xOqt7Me+Cmqawxte1FiwNxsJKkD
        P3LQSjicDyqi1nAKcpwJGpeKK/f2IMV+wT5MHHEaIQ==
X-Google-Smtp-Source: AK7set/rPxl6cUEydcfuKiyw/MiYqdYjF69kKuLl2afD4bT6uJ8PK04lavACc4+fkOdsg677Px3qnNBe4rzS++HZtTc=
X-Received: by 2002:a17:903:2681:b0:19b:c212:b2eb with SMTP id
 jf1-20020a170903268100b0019bc212b2ebmr1423528plb.10.1677891204327; Fri, 03
 Mar 2023 16:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20230224070506.4157738-1-saravanak@google.com>
 <20230224070506.4157738-2-saravanak@google.com> <CAD=FV=XQnLpD1P8sRBcizTMjCQyHTjaiNvjcPdgyZc5JCzvOtw@mail.gmail.com>
In-Reply-To: <CAD=FV=XQnLpD1P8sRBcizTMjCQyHTjaiNvjcPdgyZc5JCzvOtw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 3 Mar 2023 16:52:47 -0800
Message-ID: <CAGETcx9aRPEU3pW4Dtn_pp5c7dKd7ZhyyKWF6XnfLp+aCxo=OA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] driver core: Add fw_devlink.sync_state command
 line param
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Feb 28, 2023 at 2:33=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Thu, Feb 23, 2023 at 11:05=E2=80=AFPM Saravana Kannan <saravanak@googl=
e.com> wrote:
> >
> > When all devices that could probe have finished probing, this parameter
> > controls what to do with devices that haven't yet received their
> > sync_state() calls.
> >
> > fw_devlink.sync_state=3Dstrict is the default and the driver core will
> > continue waiting on consumers to probe successfully in the future.
>
> This description is misleading / borderline wrong.

I definitely disagree on this being borderline wrong -- it's
definitely correct. I'm open to suggestions for clarification. I've
tweaked the commit text for clarity for v2.

> You say that when
> "sync_state=3Dstrict" that you'll wait on consumers to probe
> successfully in the future.

This is very true. I'll add "before sync_state() is called" to the end
of the sentence if that'll clarify things.

> As talked about below, I think that when
> the pre-existing "deferred_probe_timeout" (which you're tying into)
> expires, it's unlikely that devices will probe successfully in the
> future. Sure, it's possible, but in general once the
> "deferred_probe_timeout" expires then the system is done waiting for
> new devices to show up. While it's still _possible_ to add new
> devices, you need to take care to deal with the fact that some
> important devices might have already given up and also that you're
> adding these new devices in strict dependency order...

But after all this, it's still possible for consumers to probe and
that's what the "strict" option is doing and that's what I'm saying in
the commit text.

> IMO better would be to say something like when sync_state=3Dstrict that
> you'll just leave resources in a high power state

But this statement is not true either. Just because a device driver
has a sync_state() doesn't mean the device was left in a powered on
state by the bootloader.

> if not all devices
> have shown up and the system thinks probing is done.

And this isn't true either. It's not "all devices have shown up". It's
"all consumers have shown up".

> > This
> > is the default behavior since calling sync_state() when all the
> > consumers haven't probed could make some systems unusable/unstable.
> >
> > fw_devlink.sync_state=3Dtimeout will cause the driver core to give up
> > waiting on consumers and call sync_state() on any devices that haven't
> > yet received their sync_state() calls. This option is provided for
> > systems that won't become unusable/unstable as they might be able to
> > save power (depends on state of hardware before kernel starts) if all
> > devices get their sync_state().

I've tried to be equally "could" about both options -- because that's
the reality. So you could have a system where you won't have any power
saving or have any stability issues independent of strict/timeout.

> While I don't object to this being a kernel command line flag, the
> default should also be a Kconfig option. The kernel command line is
> not a great place for general configuration. As we jam too much stuff
> in the kernel command line it gets unwieldy quickly. IMO:
>
> * Kconfig: the right place for stuff for config options that a person
> building the kernel might want to tweak.
>
> * Kernel command line: the right place for a user of a pre-built
> kernel to tweak; also (sometimes) the right place for the bootloader
> to pass info to the kernel; also a good place for debug options that a
> kernel engineer might want to tweak w/out rebuilding the kernel.
>
> In this case it makes sense for the person building the kernel to
> choose a default that makes sense for the hardware that their kernel
> is targetting. It can also make sense for a user of a pre-built kernel
> to tweak this if their hardware isn't working correctly. Thus it makes
> sense for Kconfig to choose the default and the kernel command line to
> override.

I don't mind adding a Kconfig to select the default behavior, but
maybe as a separate patch in the future so if there's any debate about
that, you'll at least get this option.

> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  .../admin-guide/kernel-parameters.txt         | 12 ++++
> >  drivers/base/base.h                           |  1 +
> >  drivers/base/core.c                           | 58 +++++++++++++++++++
> >  drivers/base/dd.c                             |  6 ++
> >  4 files changed, 77 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index 6cfa6e3996cf..f0bf2f40af64 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1594,6 +1594,18 @@
> >                         dependencies. This only applies for fw_devlink=
=3Don|rpm.
> >                         Format: <bool>
> >
> > +       fw_devlink.sync_state =3D
>
> Is there a reason this is nested under "fw_devlink"? The sysfs
> attribute "sync_state" that you modify in patch #2 doesn't reference
> "fw_devlink" at all.

Because one of the main reasons for writing fw_devlink is for
sync_state() to be meaningful. Without fw_devlink, sync_state()
happens right after probe() or late_initcall() whichever is later. So,
it's effectively pointless for any module without fw_devlink.
sync_state() documentation also says that it's based on device links.
So they are both very closely tied to each other.

> > +                       [KNL] When all devices that could probe have fi=
nished
> > +                       probing, this parameter controls what to do wit=
h
> > +                       devices that haven't yet received their sync_st=
ate()
> > +                       calls.
> > +                       Format: { strict | timeout }
> > +                       strict -- Default. Continue waiting on consumer=
s to
> > +                               probe successfully.
> > +                       timeout -- Give up waiting on consumers and cal=
l
> > +                               sync_state() on any devices that haven'=
t yet
> > +                               received their sync_state() calls.
>
> Some description needs to be included about how long the timeout is.
> Specifically, tie it into the "deferred_probe_timeout" feature since
> that's what you're using.

Thanks! I meant to do this, but forgot.

> > +
> >         gamecon.map[2|3]=3D
> >                         [HW,JOY] Multisystem joystick and NES/SNES/PSX =
pad
> >                         support via parallel port (up to 5 devices per =
port)
> > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > index 726a12a244c0..6fcd71803d35 100644
> > --- a/drivers/base/base.h
> > +++ b/drivers/base/base.h
> > @@ -209,6 +209,7 @@ extern void device_links_no_driver(struct device *d=
ev);
> >  extern bool device_links_busy(struct device *dev);
> >  extern void device_links_unbind_consumers(struct device *dev);
> >  extern void fw_devlink_drivers_done(void);
> > +extern void fw_devlink_probing_done(void);
> >
> >  /* device pm support */
> >  void device_pm_move_to_tail(struct device *dev);
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index f9297c68214a..929ec218f180 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -1727,6 +1727,26 @@ static int __init fw_devlink_strict_setup(char *=
arg)
> >  }
> >  early_param("fw_devlink.strict", fw_devlink_strict_setup);
> >
> > +#define FW_DEVLINK_SYNC_STATE_STRICT   0
> > +#define FW_DEVLINK_SYNC_STATE_TIMEOUT  1
>
> I don't care tons, but I feel like this should be an enum, or a bool.
>
>
> > +
> > +static int fw_devlink_sync_state;
> > +static int __init fw_devlink_sync_state_setup(char *arg)
> > +{
> > +       if (!arg)
> > +               return -EINVAL;
> > +
> > +       if (strcmp(arg, "strict") =3D=3D 0) {
> > +               fw_devlink_sync_state =3D FW_DEVLINK_SYNC_STATE_STRICT;
> > +               return 0;
> > +       } else if (strcmp(arg, "timeout") =3D=3D 0) {
> > +               fw_devlink_sync_state =3D FW_DEVLINK_SYNC_STATE_TIMEOUT=
;
> > +               return 0;
> > +       }
> > +       return -EINVAL;
> > +}
> > +early_param("fw_devlink.sync_state", fw_devlink_sync_state_setup);
> > +
> >  static inline u32 fw_devlink_get_flags(u8 fwlink_flags)
> >  {
> >         if (fwlink_flags & FWLINK_FLAG_CYCLE)
> > @@ -1797,6 +1817,44 @@ void fw_devlink_drivers_done(void)
> >         device_links_write_unlock();
> >  }
> >
> > +static int fw_devlink_dev_sync_state(struct device *dev, void *data)
> > +{
> > +       struct device_link *link =3D to_devlink(dev);
> > +       struct device *sup =3D link->supplier;
> > +
> > +       if (!(link->flags & DL_FLAG_MANAGED) ||
> > +           link->status =3D=3D DL_STATE_ACTIVE || sup->state_synced ||
> > +           !dev_has_sync_state(sup))
> > +               return 0;
> > +
> > +       if (fw_devlink_sync_state =3D=3D FW_DEVLINK_SYNC_STATE_STRICT) =
{
> > +               dev_warn(sup, "sync_state() pending due to %s\n",
> > +                        dev_name(link->consumer));
>
> This warning message is (IMO) an important feature of your patch. IMO
> it deserves a mention in the commit message

Sure, I can mention it in the commit text.

> and even if (for some
> reason) we decide we don't like the concept of forcing sync_state
> after a timeout then we should still find a way to get this warning
> message printed out. Maybe promote it to its own patch?

ehhh...

> Specifically, I think this warning message gets printed out after
> we've given up waiting for devices to show up. At this point
> -EPROBE_DEFER becomes an error that we won't retry.

This is not true. We will always retry on an -EPROBE_DEFER, even after time=
out.

> That means that we
> expect that sync state will _never_ be called in the future

Not true. I can be called after the timeout.

> and that
> resources will be left enabled / in a higher power state than needed.

Higher power state is also not always true (as described earlier).

> I would perhaps also make it sound a little scarier since,

I definitely don't want to make it sound scarier and get everyone to
enable the timeout by default without actually knowing if it has a
power impact on their system.

> IMO, this
> is a problem that really shouldn't be "shipped" if this is an embedded
> kernel. Maybe something like:

This is how it's shipped on all Android devices in the past 2 years.
So it's not a global problem like you make it to be.

>
>   sync_state pending (%s); resources left in high power state

I don't want to be alarmist. But I also agree that it's worth
highlighting. And I think the current message is the best compromise.
I even made it a dev_warn() instead of dev_info() or dev_dbg() just to
keep you happy :)

>
> > +               return 0;
> > +       }
> > +
> > +       if (!list_empty(&sup->links.defer_sync))
> > +               return 0;
> > +
> > +       dev_warn(sup, "Timed out. Calling sync_state()\n");
>
> nit: since you aren't directly calling it after this print (you're
> adding it to the queue), maybe change to "Forcing sync_state()".

Thanks. Will do.


-Saravana
