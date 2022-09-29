Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629755EED78
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 08:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiI2GDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 02:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiI2GDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:03:35 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC8F12C683
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 23:03:33 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 54FBC3F133
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 06:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1664431411;
        bh=k6b2K4E94ZEhD8vRDR4/zvr1vdGBEPqs0TlnA04+ktw=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=StCyqOIg5KgQ6seUEPBVfWtXmpyh8w56XynvNKeukrZ0LfYFfHKQOACLpz4vhTLnQ
         USfGSAbIfFzfDyjJwVmJAX4oSW+8STd8ooEfR35Jjht79S38C54W0Ib4g6Udry4iZx
         GO69vb9RfZnhJ632ooVmK4pSXARvd3hS0dbWgmM4Rd7T/XKb5MBo10teO42ejRD+3F
         1MtHLCwWCJWg+aLkbZURUR2I99ywgO83vpNV9ys5rWPyFtVTP+gJHmKbG3ZVk9SniO
         wVBQMUgzAHQ02J2/Z37v1E4B6GAGt8yjApxeFumCG7B4Ttz2FxVdVZEF2f3GNjYGem
         kinsB2BaAxV3g==
Received: by mail-ed1-f70.google.com with SMTP id w17-20020a056402269100b0045249bc17a9so447104edd.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 23:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=k6b2K4E94ZEhD8vRDR4/zvr1vdGBEPqs0TlnA04+ktw=;
        b=NVDaEBUHKIHXyIfzZ/5yKKHqRwnZTRQh/e1MzBrKHN4Gwk8ps8v4GvymRTqXkliooZ
         kZD1RYDOfDUb0O/HMctfFHZtcMagGHzyndCWZ7ec80ilbD0tvW6nTg5IO1ks4QZ4Z0s1
         59rs9L1N44Hok2hF0VQJiy8ya+sgLXU7glx9lNwONgyde+ZUi7AmESyXgnwPfpmzA3Ny
         R61d4AagvVCIkWZPg7xM3bRSV9q4JLNkBfzw3op5Sfeqq4OUKAYGe+gyyfqqyBBegNon
         YLQwEdiiv3uW41MGrkPc6aBTENsBF4Lqd95OmLJac8bE6EYLHnKEI6rsGYfwacqg6+z4
         t08Q==
X-Gm-Message-State: ACrzQf3rAZ60j7J52EUWR0YAG+Ccxrzo41TsyiG0qCdpd6oKjPqQOSKT
        YRTiZGd92Nz7AMmzBBZXaVIYs2Emf/cw4JbEfwffctK88KUS02WJWfbHbKufoU7Qg8cG4SRhsRK
        yqAmlI93BZTjeOZaOF7PMKxEdl6CbuE74a/z4vrvvxm7hgLCt35YA5zting==
X-Received: by 2002:a17:907:3e86:b0:6f5:917:10cc with SMTP id hs6-20020a1709073e8600b006f5091710ccmr1274373ejc.53.1664431410895;
        Wed, 28 Sep 2022 23:03:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM49aMII/RF5CDfCDWMJusejDjYSmDmGPGUnyaMKVN7/Jxn+5q8qbK5cUzcUQzHG2kfpdbehnn4ldGjBc+CUz40=
X-Received: by 2002:a17:907:3e86:b0:6f5:917:10cc with SMTP id
 hs6-20020a1709073e8600b006f5091710ccmr1274357ejc.53.1664431410635; Wed, 28
 Sep 2022 23:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220916043319.119716-1-kai.heng.feng@canonical.com>
 <20220916043319.119716-2-kai.heng.feng@canonical.com> <CAJZ5v0gTEkZkyKkrjDZk0s+UVR9yPTtBJ_nzG40ZO9kgikFdqw@mail.gmail.com>
 <CAJZ5v0h+3ez6=Hf7iJOAv1T7vs9qXudt90iuccDx84gGN=rbcA@mail.gmail.com>
In-Reply-To: <CAJZ5v0h+3ez6=Hf7iJOAv1T7vs9qXudt90iuccDx84gGN=rbcA@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 29 Sep 2022 14:03:18 +0800
Message-ID: <CAAd53p4oOL6ZyCxvneea2VZGDibb7+RkhWfsyyXQuBhjno3VtA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PM: ACPI: reboot: Reinstate S5 for reboot
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 11:50 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, Sep 24, 2022 at 6:19 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Fri, Sep 16, 2022 at 6:33 AM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> > >
> > > Commit d60cd06331a3 ("PM: ACPI: reboot: Use S5 for reboot") caused Dell
> > > PowerEdge r440 hangs at reboot.
> > >
> > > The issue is fixed by commit 2ca1c94ce0b6 ("tg3: Disable tg3 device on
> > > system reboot to avoid triggering AER"), so use the new sysoff API to
> > > reinstate S5 for reboot on ACPI-based systems.
> > >
> > > Using S5 for reboot is default behavior under Windows, "A full shutdown
> > > (S5) occurs when a system restart is requested" [1].
> > >
> > > [1] https://docs.microsoft.com/en-us/windows/win32/power/system-power-state
> > >
> > > Cc: Josef Bacik <josef@toxicpanda.com>
> > > Suggested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > > v4:
> > >  - Add comment and add more info to commit message.
> > > v3:
> > >  - Use new API to invoke ACPI S5.
> > > v2:
> > >  - Use do_kernel_power_off_prepare() instead.
> > >
> > >  drivers/acpi/sleep.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> > > index ad4b2987b3d6e..0b557c0d405ef 100644
> > > --- a/drivers/acpi/sleep.c
> > > +++ b/drivers/acpi/sleep.c
> > > @@ -1088,6 +1088,14 @@ int __init acpi_sleep_init(void)
> > >                 register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
> > >                                          SYS_OFF_PRIO_FIRMWARE,
> > >                                          acpi_power_off, NULL);
> > > +
> > > +               /*
> > > +                * Windows uses S5 for reboot, so some BIOSes depend on it to
> > > +                * perform proper reboot.
> > > +                */
> > > +               register_sys_off_handler(SYS_OFF_MODE_RESTART_PREPARE,
> > > +                                        SYS_OFF_PRIO_FIRMWARE,
> > > +                                        acpi_power_off_prepare, NULL);
> > >         } else {
> > >                 acpi_no_s5 = true;
> > >         }
> > > --
> >
> > Applied as 6.1 material with some edits in the changelog, thanks!
>
> And dropped due to a build failure.
>
> It looks like it depends on patch [1/2], but I haven't seen that one.

Sorry about that, let me resend it to linux-pm too.

Kai-Heng
