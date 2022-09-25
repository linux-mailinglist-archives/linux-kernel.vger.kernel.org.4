Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD435E9419
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 17:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiIYPvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 11:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbiIYPu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 11:50:59 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82632C119;
        Sun, 25 Sep 2022 08:50:58 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id h21so2844223qta.3;
        Sun, 25 Sep 2022 08:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Nxf2CrxXqc9Pl8KiEukPF/0eo12TyS1Rnm/iFQzHhmM=;
        b=uZAdcrJpUrykuv7WmflLaEvEvt+0nC6J4BIv03aZ15yU0GD3IUwzu4UT9d3MphsguQ
         q9BgUBR3Q1vQ0WlcwTwQ76lGVqsTXyAQJXnhWc3W6Kg1SgVTPfL6f8W6jsPIrGN2ZgQ1
         UQRJKc8h1M9yOU0L9a1pOpH+9d3ZAr6wi5Bv1KnY9sX12VZyqkHWnQw9NGDSL7wgfYUh
         6xzVe2NEKOwuDlx4l4lXLENtn9b41A4iE4h+RXQrpvLjt0+3VK39LeB2olyQCOuEWCnb
         97ySbx0+syBo8wa5oqb6rOU0PukBYhkLbMjNdRIOmDRBoo5SDAUWhbrF2MjbNY3PnjyX
         xqDA==
X-Gm-Message-State: ACrzQf2adDzBzVIUBNXGd+OCk+7PBpCZgG0/MMlylOir8XnJm/g7epAH
        uwEkg1OXi0b+GSaFS8Nb11Chip7tRBuD6LsQdWw=
X-Google-Smtp-Source: AMsMyM4F8cbu26Bgthte4Aurv5PJEBVBzXgfaYLN0c4YPu8+mdoV9Zfzz9VmFgNGC+t31Odbjea2oUcyPTrD1AksP6s=
X-Received: by 2002:a05:622a:620a:b0:35c:bf9e:8748 with SMTP id
 hj10-20020a05622a620a00b0035cbf9e8748mr15070340qtb.494.1664121057185; Sun, 25
 Sep 2022 08:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220916043319.119716-1-kai.heng.feng@canonical.com>
 <20220916043319.119716-2-kai.heng.feng@canonical.com> <CAJZ5v0gTEkZkyKkrjDZk0s+UVR9yPTtBJ_nzG40ZO9kgikFdqw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gTEkZkyKkrjDZk0s+UVR9yPTtBJ_nzG40ZO9kgikFdqw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 25 Sep 2022 17:50:45 +0200
Message-ID: <CAJZ5v0h+3ez6=Hf7iJOAv1T7vs9qXudt90iuccDx84gGN=rbcA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PM: ACPI: reboot: Reinstate S5 for reboot
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 6:19 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Sep 16, 2022 at 6:33 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > Commit d60cd06331a3 ("PM: ACPI: reboot: Use S5 for reboot") caused Dell
> > PowerEdge r440 hangs at reboot.
> >
> > The issue is fixed by commit 2ca1c94ce0b6 ("tg3: Disable tg3 device on
> > system reboot to avoid triggering AER"), so use the new sysoff API to
> > reinstate S5 for reboot on ACPI-based systems.
> >
> > Using S5 for reboot is default behavior under Windows, "A full shutdown
> > (S5) occurs when a system restart is requested" [1].
> >
> > [1] https://docs.microsoft.com/en-us/windows/win32/power/system-power-state
> >
> > Cc: Josef Bacik <josef@toxicpanda.com>
> > Suggested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v4:
> >  - Add comment and add more info to commit message.
> > v3:
> >  - Use new API to invoke ACPI S5.
> > v2:
> >  - Use do_kernel_power_off_prepare() instead.
> >
> >  drivers/acpi/sleep.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> > index ad4b2987b3d6e..0b557c0d405ef 100644
> > --- a/drivers/acpi/sleep.c
> > +++ b/drivers/acpi/sleep.c
> > @@ -1088,6 +1088,14 @@ int __init acpi_sleep_init(void)
> >                 register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
> >                                          SYS_OFF_PRIO_FIRMWARE,
> >                                          acpi_power_off, NULL);
> > +
> > +               /*
> > +                * Windows uses S5 for reboot, so some BIOSes depend on it to
> > +                * perform proper reboot.
> > +                */
> > +               register_sys_off_handler(SYS_OFF_MODE_RESTART_PREPARE,
> > +                                        SYS_OFF_PRIO_FIRMWARE,
> > +                                        acpi_power_off_prepare, NULL);
> >         } else {
> >                 acpi_no_s5 = true;
> >         }
> > --
>
> Applied as 6.1 material with some edits in the changelog, thanks!

And dropped due to a build failure.

It looks like it depends on patch [1/2], but I haven't seen that one.
