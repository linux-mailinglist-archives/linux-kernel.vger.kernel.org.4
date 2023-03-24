Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5736C7B46
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjCXJ0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjCXJZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:25:58 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E63233D1;
        Fri, 24 Mar 2023 02:25:56 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id cn12so5287013edb.4;
        Fri, 24 Mar 2023 02:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679649955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcCl5sc+j3IMfbUjl4CDmD357jwtZ469Lo5ySWTEjOU=;
        b=LzVzu8f/aM6P108G/bMabhIJ01zrRiiqgdW1OWDw11RAIhCW1zh4s1G4SP1oG/2zn+
         QfatooAsH+lgIhEPjDca0dB5aGn6WDG9z4KfN9viYmiJEdnp+aRf6+JClgILAV25xjDQ
         ZAwkF2ed/eokvZIHP5LltaTHlB4kLsptLaVxASS1jVOqN77tPkVoVcTKm3mBGmmCA0Aw
         VOxLPhaEe9ANpOJrj0E9pCO2DsuoIBiUPazwEJ+bUT4FDCwM9Waq+bvi1ngt2mW9IhpR
         To1fY2C+mUJ8sNOOl5Et1wgOli9Isn/EtOhvee9T8RWkX8RoP34RlTotuJjk4pZGreJh
         qqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679649955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcCl5sc+j3IMfbUjl4CDmD357jwtZ469Lo5ySWTEjOU=;
        b=ybXDSN9k8CssqKo3CDBPoPnPRjvPsbRL/HSWA1An7BhfebH9CZ/eHaaOGrT8iD/RRF
         OqI8qUcWeapwP49zOhzl7n6WF8X7QeznXZtIM380kpXCHD9ufA+Ao5VxNceE0a39bYFx
         7xFWOZQqgEvy0tQ/KCxDcuPoykog5udc90PBTFioo4G5ovZacb0yRaDLgtAcentnX4KS
         Cql2KwPOR33Ah+vzhqPaWysH49tM1ZEq5EmfAZuXGbS2QbWKTwYdwWqToKbeduyRGojh
         E8+oMxSlqQqrWkQhLO33Q4wiUQdJyntFAzXwfMdPoxpKNA05W+Oclc6psXnF4F+6AdVp
         4CAQ==
X-Gm-Message-State: AO0yUKVsPDjFn+KxvUGJD05zISuVV6LMf5EQqw5yeZKAroBJq0pc4mio
        MVS53px05gzEDSsJgWM+N+y5eVdu3th66rLMZBA=
X-Google-Smtp-Source: AK7set/Yxupl4tVMQ7EWq+XrpLRbHsLGaTSlG2NHJPepGUqS2rL9HaCERXA8RoBXevKlEzCMBusGL5WrghCzQMyxXmw=
X-Received: by 2002:a05:6402:3510:b0:4af:62ad:6099 with SMTP id
 b16-20020a056402351000b004af62ad6099mr6653339edd.2.1679649955024; Fri, 24 Mar
 2023 02:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230323051241.24841-1-lukas.bulwahn@gmail.com> <CAHC9VhQ7O-qSb18HeG3wjeYC97sQNd1dSYHqTncAcZK3mSPGrQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQ7O-qSb18HeG3wjeYC97sQNd1dSYHqTncAcZK3mSPGrQ@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 24 Mar 2023 10:25:43 +0100
Message-ID: <CAKXUXMyj0kHj=5ifgrajy1bcZzTLk3iVsnRxLA_VEnjpu5WOpQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: clean up dead code after removing runtime disable
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 3:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Mar 23, 2023 at 1:12=E2=80=AFAM Lukas Bulwahn <lukas.bulwahn@gmai=
l.com> wrote:
> >
> > Commit f22f9aaf6c3d ("selinux: remove the runtime disable functionality=
")
> > removes the config SECURITY_SELINUX_DISABLE. This results in some dead =
code
> > in lsm_hooks.h and a reference in the ABI documentation leading nowhere=
 as
> > the help text is simply gone.
> >
> > Remove the dead code and dead reference.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > Paul, please pick this minor cleanup patch on top of your commit above.
>
> Hi Lukas, thanks for catching this and sending a patch!  For future
> reference, you don't need to add a note asking me to pick up this
> patch, as long as you send it to the right mailing list - you did -
> I'll see it and you'll either get a quick reply when I merge it or a
> longer reply with comments/feedback.
>
> One comment below ...
>
> > diff --git a/Documentation/ABI/removed/sysfs-selinux-disable b/Document=
ation/ABI/removed/sysfs-selinux-disable
> > index cb783c64cab3..1ae9587231e1 100644
> > --- a/Documentation/ABI/removed/sysfs-selinux-disable
> > +++ b/Documentation/ABI/removed/sysfs-selinux-disable
> > @@ -24,6 +24,3 @@ Description:
> >         SELinux at runtime.  Fedora is in the process of removing the
> >         selinuxfs "disable" node and once that is complete we will star=
t the
> >         slow process of removing this code from the kernel.
> > -
> > -       More information on /sys/fs/selinux/disable can be found under =
the
> > -       CONFIG_SECURITY_SELINUX_DISABLE Kconfig option.
>
> When I moved the deprecation notice from the "obsolete" to the
> "removed" directory I added a note at the top which read:
>
>   "REMOVAL UPDATE: The SELinux checkreqprot functionality was
>    removed in March 2023, the original deprecation notice is
>    shown below."
>
> My goal was to preserve the original notice as much as possible,
> including the references to the now defunct Kconfig option, to help
> people who are trying to understand how things worked prior to the
> removal.
>
> If you can remove this part of your patch and resubmit I'll happily
> merge it into the selinux/next tree.
>

Okay, I reworked the patch as requested and sent out a PATCH v2:

https://lore.kernel.org/all/20230324092114.13907-1-lukas.bulwahn@gmail.com/=
T/#u

Thanks,

Lukas
