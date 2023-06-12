Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E826772C8FD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbjFLOxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjFLOxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:53:39 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 89FFFC5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 07:53:37 -0700 (PDT)
Received: (qmail 394521 invoked by uid 1000); 12 Jun 2023 10:33:35 -0400
Date:   Mon, 12 Jun 2023 10:33:35 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hannes Reinecke <hare@suse.de>,
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
        Joe Breuer <linux-kernel@jmbreuer.net>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Hardening <linux-hardening@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux SCSI <linux-scsi@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Hannes Reinecke <hare@suse.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: Re: Fwd: Waking up from resume locks up on sr device
Message-ID: <1bc3eff1-6f86-4546-9360-19b6d0236bc4@rowland.harvard.edu>
References: <2d1fdf6d-682c-a18d-2260-5c5ee7097f7d@gmail.com>
 <5513e29d-955a-f795-21d6-ec02a2e2e128@gmail.com>
 <ZIQ6bkau3j6qGef8@duo.ucw.cz>
 <07d6e2e7-a50a-8cf4-5c5d-200551bd6687@gmail.com>
 <02e4f87a-80e8-dc5d-0d6e-46939f2c74ac@acm.org>
 <4005a768-9e45-0707-509d-98ce0d2769bd@kernel.org>
 <0505654c-e487-6b91-57cf-fa7996f5c738@suse.de>
 <6957a93c-b933-9b08-2f9f-901c4782cd40@kernel.org>
 <CAAd53p5CsAAX5G1J2WH5N5JT5dZB_BD2AW8WL-S=pHZtGXr1sw@mail.gmail.com>
 <433015f6-9ca6-e4ce-e070-a75378419564@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <433015f6-9ca6-e4ce-e070-a75378419564@kernel.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 04:47:09PM +0900, Damien Le Moal wrote:
> On 6/12/23 16:36, Kai-Heng Feng wrote:
> > On Mon, Jun 12, 2023 at 3:22 PM Damien Le Moal <dlemoal@kernel.org> wrote:
> >>
> >> On 6/12/23 15:09, Hannes Reinecke wrote:
> >>> On 6/12/23 05:09, Damien Le Moal wrote:
> >>>> On 6/11/23 00:03, Bart Van Assche wrote:
> >>>>> On 6/10/23 06:27, Bagas Sanjaya wrote:
> >>>>>> On 6/10/23 15:55, Pavel Machek wrote:
> >>>>>>>>> #regzbot introduced: v5.0..v6.4-rc5 https://bugzilla.kernel.org/show_bug.cgi?id=217530
> >>>>>>>>> #regzbot title: Waking up from resume locks up on SCSI CD/DVD drive
> >>>>>>>>>
> >>>>>>>> The reporter had found the culprit (via bisection), so:
> >>>>>>>>
> >>>>>>>> #regzbot introduced: a19a93e4c6a98c
> >>>>>>> Maybe cc the authors of that commit?
> >>>>>>
> >>>>>> Ah! I forgot to do that! Thanks anyway.
> >>>>>
> >>>>> Hi Damien,
> >>>>>
> >>>>> Why does the ATA code call scsi_rescan_device() before system resume has
> >>>>> finished? Would ATA devices still work with the patch below applied?
> >>>>
> >>>> I do not know the PM code well at all, need to dig into it. But your patch
> >>>> worries me as it seems it would prevent rescan of the device on a resume, which
> >>>> can be an issue if the device has changed.
> >>>>
> >>>> I am not yet 100% clear on the root cause for this, but I think it comes from
> >>>> the fact that ata_port_pm_resume() runs before the sci device resume is done, so
> >>>> with scsi_dev->power.is_suspended still true. And ata_port_pm_resume() calls
> >>>> ata_port_resume_async() which triggers EH (which will do reset + rescan)
> >>>> asynchronously. So it looks like we have scsi device resume and libata EH for
> >>>> rescan fighting each others for the scan mutex and device lock, leading to deadlock.
> >>>>
> >>>> Trying to recreate this issue now to confirm and debug further. But I suspect
> >>>> the solution to this may be best implemented in libata, not in scsi.
> >>>> This looks definitely related to this thread:
> >>>>
> >>>> https://lore.kernel.org/linux-scsi/7b553268-69d3-913a-f9de-28f8d45bdb1e@acm.org/
> >>>>
> >>>> Similaraly to your comment on that thread, having to look at
> >>>> dev->power.is_suspended is not ideal I think. What we need is to have ata and
> >>>> scsi pm resume be synchronized, but I am not yet 100% clear on the scsi layer side.
> >>>>
> >>> Which is my feeling, too.
> >>> libata runs rescan as part of the device discovery, so really it will
> >>> run after resume. And consequently resume really cannot wait for rescan
> >>> to finish.
> >>>
> >>> What I would be looking at is to decouple resume from libata device
> >>> rescan, and have resume to complete before libata EH runs.
> >>
> >> That is the case now, for the ata port at least, even though that is not super
> >> explicit, and not reliable. See ata_port_pm_resume(): I think that the call to
> >> EH in ata_port_pm_resume() -> ata_port_resume_async() -> ata_port_request_pm()
> >> -> ata_port_schedule_eh() should instead use a sync resume, leading to a sync EH
> >> call.
> >>
> >> That EH execution essentially does ata_eh_handle_port_resume(), which calls into
> >> the adapter resume operation. That in itself does not do much beside some
> >> registers accesses to wakeup the port. There should be no issues doing that
> >> synchronously.
> >>
> >> The problem is that after that is done, ata EH calls ata_std_error_handler() ->
> >> ata_do_eh() -> ata_eh_recover() -> ata_eh_revalidate_and_attach() ->
> >> schedule_work(&(ap->scsi_rescan_task)). And the rescan work calls
> >> scsi_rescan_device() (yet in another context than EH) which causes the problem
> >> when the scsi disk device has not been resumed yet (dev->power_is_suspended
> >> still true).
> >>
> >> So it really looks like the solution should be to have ata_scsi_dev_rescan()
> >> wait for the scsi device to resume first, but not sure how to do that with the
> >> pm API. Digging...
> > 
> > Probably use dpm_wait_for_children()? Right now it's an internal PM API.
> 
> But I am not sure if there is a relationship between ata_device and its
> scsi_device (dev->sdev)... Need to clarify that.
> > 
> > Rafael,
> > What do you think?

Look into the device_pm_wait_for_dev() API.  It's the appropriate thing 
to use when you want to wait for another device to complete a system PM 
transition.  (However, it's not appropriate for runtime PM.)

Of course, if there is a parent-child relationship between two devices 
then waiting is never necessary.  The PM core guarantees that a parent 
will always be at full power when a child changes its power state, 
unless pm_suspend_ignore_children() has been called for the parent 
device.

Alan Stern
