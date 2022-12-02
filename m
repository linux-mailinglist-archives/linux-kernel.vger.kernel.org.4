Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594AB6407A3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbiLBNXI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Dec 2022 08:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLBNXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:23:05 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA246723F;
        Fri,  2 Dec 2022 05:23:03 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id e15so5008734qts.1;
        Fri, 02 Dec 2022 05:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uB0EJbwNDLUzHJGWsxp/Ffm7ffwt2LXwWWQALhl5JaM=;
        b=QtP2i+caY+YdEj6OLFTnQKAnZ1DrMryw0+syM2EtnpL70K0ep96nhGBduxTHXUQqTN
         JrEIz58zfzAyoMsoa7SdlnFQDqFNumWjgTrHUoTsvGghuqQjJrcLsv3CWHtqUVZqy9Qv
         xe+mKpnwFBSQXv+LcwEe09JP/1wLYVtPk9KUPwHT1j6Vqh+rjynkhmEH/xI42tPuTDTZ
         5Dl8RSi67sgnt7yuRx2vxegUJa+OUVpRWqHYefCtQwZ31V+Co7iqkVQkf5yP9aBAg4/V
         sUdyu1sLmSgSscB9QAW0CUOLlBFg3h2qsYsuBkR8XZJZAE0fAyjQknedd3HhtDpcRuhQ
         74fQ==
X-Gm-Message-State: ANoB5pmsSw3O5f07ijB8kY6kfJ9A810H2Y+WROpGcm4TeXLn2AfEI9hB
        6xDKuJ0V3W3Z4U7hzR5YBxShTujVJ/iG+a/enSU1RmCu
X-Google-Smtp-Source: AA0mqf55TDX7u9F3kG/xbZtS8Suh1tAWhAP0HJL1HMeiMk0lAXO9Sc6v6x1pGZeNNoHjfCmNzfLF7KGFXrmI1GWKhIk=
X-Received: by 2002:a05:622a:410a:b0:3a5:5987:42c6 with SMTP id
 cc10-20020a05622a410a00b003a5598742c6mr65643174qtb.147.1669987382578; Fri, 02
 Dec 2022 05:23:02 -0800 (PST)
MIME-Version: 1.0
References: <36aed941-a73e-d937-2721-4f0decd61ce0@quicinc.com>
 <20aae21e-62d2-8fdb-b57a-7b5a180266d8@intel.com> <CAJZ5v0gdg=PUz-j0yd_QJRPmjhZ7pCuRrHt30U60H4QyTHCmdA@mail.gmail.com>
 <12104185.O9o76ZdvQC@kreacher> <5f129a61-0311-0b80-2e74-8425650bbd26@quicinc.com>
In-Reply-To: <5f129a61-0311-0b80-2e74-8425650bbd26@quicinc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Dec 2022 14:22:51 +0100
Message-ID: <CAJZ5v0h6wskR+bQPsG3A5xV6kwupoj3XLdLS-FCz0caEGKpXeQ@mail.gmail.com>
Subject: Re: PM-runtime: supplier looses track of consumer during probe
To:     Tushar Nimkar <quic_tnimkar@quicinc.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        bjorn.andersson@kernel.org, quic_mkshah@quicinc.com,
        quic_lsrao@quicinc.com, bvanassche@acm.org,
        Peter Wang <peter.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 2, 2022 at 1:23 PM Tushar Nimkar <quic_tnimkar@quicinc.com> wrote:
>
> Thanks Adrian and Rafael,
> We are trying both patches separately. And will update result once we get.

Thank you!

I'm going to submit the change in rpm_idle() regardless of whether or
not it is sufficient to address the issue, because it is a clear
mistake to still call __rpm_callback() from there after adding the
handling of device links to it.

> On 12/2/2022 1:14 AM, Rafael J. Wysocki wrote:
> > On Thursday, December 1, 2022 8:28:25 PM CET Rafael J. Wysocki wrote:
> >> On Thu, Dec 1, 2022 at 2:10 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>
> >>> On 29/11/22 18:56, Nitin Rawat wrote:
> >>>> Hi Adrian,
> >>>>
> >>>> On 11/21/2022 11:38 AM, Tushar Nimkar wrote:
> >>>>> Hi Adrian,
> >>>>>
> >>>>> On 11/18/2022 8:25 PM, Adrian Hunter wrote:
> >>>>>> On 4/11/22 11:19, Tushar Nimkar wrote:
> >>>>>>> Hi linux-pm/linux-scsi,
> >>>>>
> >>>>>>>> Process -1
> >>>>>>>> ufshcd_async_scan context (process 1)
> >>>>>>>> scsi_autopm_put_device() //0:0:0:0
> >>>>>>
> >>>>>> I am having trouble following your description.  What function is calling
> >>>>>> scsi_autopm_put_device() here?
> >>>>>>
> >>>>> Below is flow which calls scsi_autopm_put_device()
> >>>>> Process -1
> >>>>> ufshcd_async_scan()
> >>>>>       scsi_probe_and_add_lun()
> >>>>>           scsi_add_lun()
> >>>>>               slave_configure()
> >>>>>                   scsi_sysfs_add_sdev()
> >>>>>                       scsi_autopm_get_device()
> >>>>>                           device_add()     <- invoked [Process 2] sd_probe()
> >>>>>                               scsi_autopm_put_device()
> >>>>>
> >>>>>>>> pm_runtime_put_sync()
> >>>>>>>> __pm_runtime_idle()
> >>>>>>>> rpm_idle() -- RPM_GET_PUT(4)
> >>>>>>>>        __rpm_callback
> >>>>>>>>            scsi_runtime_idle()
> >>>>>>>>                pm_runtime_mark_last_busy()
> >>>>>>>>                pm_runtime_autosuspend()  --[A]
> >>>>>>>>                    rpm_suspend() -- RPM_AUTO(8)
> >>>>>>>>                        pm_runtime_autosuspend_expiration() use_autosuspend    is false return 0   --- [B]
> >>>>>>>>                            __update_runtime_status to RPM_SUSPENDING
> >>>>>>>>                        __rpm_callback()
> >>>>>>>>                            __rpm_put_suppliers(dev, false)
> >>>>>>>>                        __update_runtime_status to RPM_SUSPENDED
> >>>>>>>>                    rpm_suspend_suppliers()
> >>>>>>>>                        rpm_idle() for supplier -- RPM_ASYNC(1) return (-EAGAIN) [ Other consumer active for supplier]
> >>>>>>>>                    rpm_suspend() – END with return=0
> >>>>>>>>            scsi_runtime_idle() END return (-EBUSY) always.
> >>>>>>
> >>>>>> Not following here either.  Which device is EBUSY and why?
> >>>>>
> >>>>> scsi_runtime_idle() return -EBUSY always [3]
> >>>>> Storage/scsi team can better explain -EBUSY implementation.
> >>>>
> >>>> EBUSY is returned from below code for consumer dev 0:0:0:0.
> >>>> scsi_runtime_idle is called from scsi_autopm_put_device which inturn is called from ufshcd_async_scan (Process 1 as per above call stack)
> >>>> static int scsi_runtime_idle(struct device *dev)
> >>>> {
> >>>>      :
> >>>>
> >>>>      if (scsi_is_sdev_device(dev)) {
> >>>>          pm_runtime_mark_last_busy(dev);
> >>>>          pm_runtime_autosuspend(dev);
> >>>>          return -EBUSY; ---> EBUSY returned from here.
> >>>>      }
> >>>>
> >>>>
> >>>> }
> >>>>
> >>>>>
> >>>>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/scsi/scsi_pm.c?h=next-20221118#n210
> >>>>>
> >>>>>
> >>>>>>>>
> >>>>>>>> [1]: https://lore.kernel.org/lkml/4748074.GXAFRqVoOG@kreacher/T/
> >>>>>>>> [2]: https://lkml.org/lkml/2022/10/12/259
> >>>
> >>> It looks to me like __rpm_callback() makes assumptions about
> >>> dev->power.runtime_status that are not necessarily true because
> >>> dev->power.lock is dropped.
> >>
> >> Well, this happens because rpm_idle() calls __rpm_callback() and
> >> allows it to run concurrently with rpm_suspend() and rpm_resume(), so
> >> one of them may change runtime_status to RPM_SUSPENDING or
> >> RPM_RESUMING while __rpm_callback() is running.
> >>
> >> It is somewhat questionable whether or not this should be allowed to
> >> happen, but since it is generally allowed to suspend the device from
> >> its .runtime_idle callback, there is not too much that can be done
> >> about it.
> >
> > But this means that the patch below should help too.
> >
> > I actually think that we can do both, because rpm_idle() doesn't have to do
> > the whole device links dance and the fact that it still calls __rpm_callback()
> > is a clear oversight.
> >
> > ---
> >   drivers/base/power/runtime.c |   12 +++++++++++-
> >   1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > Index: linux-pm/drivers/base/power/runtime.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/power/runtime.c
> > +++ linux-pm/drivers/base/power/runtime.c
> > @@ -484,7 +484,17 @@ static int rpm_idle(struct device *dev,
> >
> >       dev->power.idle_notification = true;
> >
> > -     retval = __rpm_callback(callback, dev);
> > +     if (dev->power.irq_safe)
> > +             spin_unlock(&dev->power.lock);
> > +     else
> > +             spin_unlock_irq(&dev->power.lock);
> > +
> > +     retval = callback(dev);
> > +
> > +     if (dev->power.irq_safe)
> > +             spin_lock(&dev->power.lock);
> > +     else
> > +             spin_lock_irq(&dev->power.lock);
> >
> >       dev->power.idle_notification = false;
> >       wake_up_all(&dev->power.wait_queue);
> >
> >
> >
