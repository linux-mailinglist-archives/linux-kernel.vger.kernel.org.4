Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B67730220
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244482AbjFNOka convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Jun 2023 10:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjFNOk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:40:28 -0400
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FD6E4D;
        Wed, 14 Jun 2023 07:40:27 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4f14e14dc00so1371921e87.1;
        Wed, 14 Jun 2023 07:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686753625; x=1689345625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g894SGD07dfqJJ+MtGFhfdGTCWqxxXM/s25cbYKPMv8=;
        b=Ay1m8eau4lXXcGFuPkGmIguKWh2m2bdEqeNPZ+OMGKWzhW4KN8yjj/jzVVHtbmEPlZ
         7aSMsabKtVOeNX6ahFYwj5lcNPtAWPVmjWhnzzhAkqq0/cQvlTg8IohL166NuicaFYyJ
         fImlmxKZMg7mkPz0C0lr0BD+1bkSZPGTyigjYnxR0rd/Ga1CsrxygbEb/e53/hH79yHy
         sHojmwXCIYT6VHfIInOJO7vEA+NtadR/2iTJrIZmFNR/8jLaA9P37l8RGNuPs4oovGIM
         6fSnMsNXT7NRALaykQkfZMKC+RdkhVSoEziH5oIcZhvXBCuHtEedTv2EYvsMGJeDTLkc
         z+Sw==
X-Gm-Message-State: AC+VfDx4vAuVevi57LDuZ9ydGui8fwuiajs82k9foNubPuu9FXnkOleg
        JLWgoR8Sd7RTqkYyR+iOYsekqcTgGSpVN1KzUfE=
X-Google-Smtp-Source: ACHHUZ4o73V3wQze63bDqYQ3KTcFZJXRWIPaSoYNRjWPeQCkTYyLLlGkBjPM1R34bqfc6bfFM40T34R1JGMAikSPPco=
X-Received: by 2002:ac2:4101:0:b0:4f6:a2f:beb with SMTP id b1-20020ac24101000000b004f60a2f0bebmr6476641lfi.5.1686753625036;
 Wed, 14 Jun 2023 07:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <2d1fdf6d-682c-a18d-2260-5c5ee7097f7d@gmail.com>
 <5513e29d-955a-f795-21d6-ec02a2e2e128@gmail.com> <ZIQ6bkau3j6qGef8@duo.ucw.cz>
 <07d6e2e7-a50a-8cf4-5c5d-200551bd6687@gmail.com> <02e4f87a-80e8-dc5d-0d6e-46939f2c74ac@acm.org>
 <b2cf6d96-a55a-d444-d22e-e9b3945ba43f@jmbreuer.net> <84f1c51c-86f9-04b3-0cd1-f685ebee7592@kernel.org>
 <37ed36f0-6f72-115c-85fb-62ef5ad72e76@suse.de> <b0fdf454-b2f7-c273-66f5-efe42fbc2807@kernel.org>
 <859f0eda-4984-4489-9851-c9f6ec454a88@rowland.harvard.edu>
In-Reply-To: <859f0eda-4984-4489-9851-c9f6ec454a88@rowland.harvard.edu>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Jun 2023 16:40:13 +0200
Message-ID: <CAJZ5v0hLkVLfWLRgU1HLjWZ_wxtUTECNHB_W_ab3KHKQz_U8-Q@mail.gmail.com>
Subject: Re: Fwd: Waking up from resume locks up on sr device
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Joe Breuer <linux-kernel@jmbreuer.net>,
        Bart Van Assche <bvanassche@acm.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Hardening <linux-hardening@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux SCSI <linux-scsi@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Hannes Reinecke <hare@suse.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
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

On Wed, Jun 14, 2023 at 4:26 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, Jun 14, 2023 at 04:35:50PM +0900, Damien Le Moal wrote:
> > On 6/14/23 15:57, Hannes Reinecke wrote:
> > > On 6/14/23 06:49, Damien Le Moal wrote:
> > >> On 6/11/23 18:05, Joe Breuer wrote:
> > >>> I'm the reporter of this issue.
> > >>>
> > >>> I just tried this patch against 6.3.4, and it completely fixes my
> > >>> suspend/resume issue.
> > >>>
> > >>> The optical drive stays usable after resume, even suspending/resuming
> > >>> during playback of CDDA content works flawlessly and playback resumes
> > >>> seamlessly after system resume.
> > >>>
> > >>> So, from my perspective: Good one!
> > >>
> > >> In place of Bart's fix, could you please try this patch ?
> > >>
> > >> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> > >> index b80e68000dd3..a81eb4f882ab 100644
> > >> --- a/drivers/ata/libata-eh.c
> > >> +++ b/drivers/ata/libata-eh.c
> > >> @@ -4006,9 +4006,32 @@ static void ata_eh_handle_port_resume(struct
> > >> ata_port *ap)
> > >>          /* tell ACPI that we're resuming */
> > >>          ata_acpi_on_resume(ap);
> > >>
> > >> -       /* update the flags */
> > >>          spin_lock_irqsave(ap->lock, flags);
> > >> +
> > >> +       /* Update the flags */
> > >>          ap->pflags &= ~(ATA_PFLAG_PM_PENDING | ATA_PFLAG_SUSPENDED);
> > >> +
> > >> +       /*
> > >> +        * Resuming the port will trigger a rescan of the ATA device(s)
> > >> +        * connected to it. Before scheduling the rescan, make sure that
> > >> +        * the associated scsi device(s) are fully resumed as well.
> > >> +        */
> > >> +       ata_for_each_link(link, ap, HOST_FIRST) {
> > >> +               ata_for_each_dev(dev, link, ENABLED) {
> > >> +                       struct scsi_device *sdev = dev->sdev;
> > >> +
> > >> +                       if (!sdev)
> > >> +                               continue;
> > >> +                       if (scsi_device_get(sdev))
> > >> +                               continue;
> > >> +
> > >> +                       spin_unlock_irqrestore(ap->lock, flags);
> > >> +                       device_pm_wait_for_dev(&ap->tdev,
> > >> +                                              &sdev->sdev_gendev);
> > >> +                       scsi_device_put(sdev);
> > >> +                       spin_lock_irqsave(ap->lock, flags);
> > >> +               }
> > >> +       }
> > >>          spin_unlock_irqrestore(ap->lock, flags);
> > >>   }
> > >>   #endif /* CONFIG_PM */
> > >>
> > >> Thanks !
> > >>
> > > Well; not sure if that'll work out.
> > > The whole reason why we initial a rescan is that we need to check if the
> > > ports are still connected, and whether the devices react.
> > > So we can't iterate the ports here as this is the very thing which gets
> > > checked during EH.
> >
> > Hmmm... Right. So we need to move that loop into ata_scsi_dev_rescan(),
> > which itself already loops over the port devices anyway.
> >
> > > We really should claim resume to be finished as soon as we can talk with
> > > the HBA, and kick off EH asynchronously to let it finish the job after
> > > resume has completed.
> >
> > That is what's done already:
> >
> > static int ata_port_pm_resume(struct device *dev)
> > {
> >       ata_port_resume_async(to_ata_port(dev), PMSG_RESUME);
> >       pm_runtime_disable(dev);
> >       pm_runtime_set_active(dev);
> >       pm_runtime_enable(dev);
> >       return 0;
> > }
> >
> > EH is kicked by ata_port_resume_async() -> ata_port_request_pm() and it
> > is async. There is no synchronization in EH with the PM side though. We
> > probably should have EH check that the port resume is done first, which
> > can be done in ata_eh_handle_port_resume() since that is the first thing
> > done when entering EH.
> >
> > The problem remains though that we *must* wait for the scsi device
> > resume to be done before calling scsi_rescan_device(), which is done
> > asynchronously from EH, as a different work. So that one needs to wait
> > for the scsi side resume to be done.
> >
> > I also thought of trigerring the rescan from the scsi side, but since
> > the resume may be asynchronous, we could endup trigerring it with the
> > ata side not yet resumed... That would only turn the problem around
> > instead of solving it.
>
> The order in which devices get resumed isn't arbitrary.  If the system
> is set up not to use async suspends/resumes then the order is always the
> same as the order in which the devices were originally registered (for
> resume, that is -- suspend obviously takes place in the reverse order).
>
> So if you're trying to perform an action that requires two devices to be
> active, you must not do it in the resume handler for the device that was
> registered first.  I don't know how the ATA and SCSI pieces interact
> here, but regardless, this is a pretty strict requirement.
>
> It should be okay to perform the action in the resume handler for the
> device that was registered second.  But if the two devices aren't in an
> ancestor-descendant relationship then you also have to call
> device_pm_wait_for_dev() (or use device links as Rafael mentioned) to
> handle the async case properly.

Note that the bare device_pm_wait_for_dev() is a bit risky though,
because in the sync case it will deadlock if dpm_list is not ordered
properly.

One of the things taken care of by device_link_add() is to ensure that
the ordering of dpm_list will reflect the dependency represented by
the given new device link.

> > Or... Why the heck scsi_rescan_device() is calling device_lock() ? This
> > is the only place in scsi code I can see that takes this lock. I suspect
> > this is to serialize either rescans, or serialize with resume, or both.
> > For serializing rescans, we can use another lock. For serializing with
> > PM, we should wait for PM transitions...
> > Something is not right here.
>
> Here's what commit e27829dc92e5 ("scsi: serialize ->rescan against
> ->remove", written by Christoph Hellwig) says:
>
>     Lock the device embedded in the scsi_device to protect against
>     concurrent calls to ->remove.
>
> That's the commit which added the device_lock() call.
>
> Alan Stern
