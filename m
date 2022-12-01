Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F57563F82A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiLAT2m convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Dec 2022 14:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiLAT2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:28:38 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A4AC5E32;
        Thu,  1 Dec 2022 11:28:37 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id y15so2184156qtv.5;
        Thu, 01 Dec 2022 11:28:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MgxVjr37axlTfgKOduJn6x/gthSur1b3/et+b9tLAg=;
        b=ffHEe1zfAh6XnVbL2NljlVFE7VLz4+Fgsu6v0hThYpab0cRZhP8sJSu73S7fL5CJXX
         t0nlPX+63KSfioTYjIPkVPhV+jyVAbfFIKHXyuS5nkdPNluPyfaqrgQX7jA5YYi8H/Hm
         DFPbQUjHZ850QcPfEKvHDGCpvFIoizsKDXgd0t+TiPN7u+CHEAQvNS+n9T6IoL31T482
         Bc9y4IVMMzp7glMnRAYfmPmRCPdlA+HID13BMpbeo2/KQcyf6mEXECia6k8gg36LUHyI
         JmrxXR5KT8fOzr6CgKTJSGvbn92dsdmmdROBUkI01xQRJ40atZXdymeK80NW+zLwV+9r
         8RQw==
X-Gm-Message-State: ANoB5pnAb1QF13bizqXpfppqM6dLaLZQDKpzm8AqIwe07kPUNFR06ujO
        6piUouF4yfm5hX5rh5KDZIgQ8tYD4ozLezKY6ZYcrLPS
X-Google-Smtp-Source: AA0mqf6FO1DQrtwcXa2dpAVNgsu4BOIjaR2sDee9u7dsmopUPESwEnGgd79eheoZBvUdU/jLNLLrd+dnHDRmIJzjdmQ=
X-Received: by 2002:a37:ad0c:0:b0:6ee:91b3:2484 with SMTP id
 f12-20020a37ad0c000000b006ee91b32484mr58800326qkm.648.1669922916665; Thu, 01
 Dec 2022 11:28:36 -0800 (PST)
MIME-Version: 1.0
References: <36aed941-a73e-d937-2721-4f0decd61ce0@quicinc.com>
 <8c0a715a-d626-aa70-15f1-79f1e23fbc67@quicinc.com> <a5e2aab6-7f0e-7f3b-f34b-6d222450c97d@intel.com>
 <8ca27fcb-b146-3ea7-a042-55f99e0ae3fb@quicinc.com> <2a1047a7-3121-6cbe-d4c5-46bbff0c5cc5@quicinc.com>
 <20aae21e-62d2-8fdb-b57a-7b5a180266d8@intel.com>
In-Reply-To: <20aae21e-62d2-8fdb-b57a-7b5a180266d8@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 1 Dec 2022 20:28:25 +0100
Message-ID: <CAJZ5v0gdg=PUz-j0yd_QJRPmjhZ7pCuRrHt30U60H4QyTHCmdA@mail.gmail.com>
Subject: Re: PM-runtime: supplier looses track of consumer during probe
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Nitin Rawat <quic_nitirawa@quicinc.com>,
        Tushar Nimkar <quic_tnimkar@quicinc.com>,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        bjorn.andersson@kernel.org, quic_mkshah@quicinc.com,
        quic_lsrao@quicinc.com, bvanassche@acm.org,
        Peter Wang <peter.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 2:10 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 29/11/22 18:56, Nitin Rawat wrote:
> > Hi Adrian,
> >
> > On 11/21/2022 11:38 AM, Tushar Nimkar wrote:
> >> Hi Adrian,
> >>
> >> On 11/18/2022 8:25 PM, Adrian Hunter wrote:
> >>> On 4/11/22 11:19, Tushar Nimkar wrote:
> >>>> Hi linux-pm/linux-scsi,
> >>
> >>>>> Process -1
> >>>>> ufshcd_async_scan context (process 1)
> >>>>> scsi_autopm_put_device() //0:0:0:0
> >>>
> >>> I am having trouble following your description.  What function is calling
> >>> scsi_autopm_put_device() here?
> >>>
> >> Below is flow which calls scsi_autopm_put_device()
> >> Process -1
> >> ufshcd_async_scan()
> >>      scsi_probe_and_add_lun()
> >>          scsi_add_lun()
> >>              slave_configure()
> >>                  scsi_sysfs_add_sdev()
> >>                      scsi_autopm_get_device()
> >>                          device_add()     <- invoked [Process 2] sd_probe()
> >>                              scsi_autopm_put_device()
> >>
> >>>>> pm_runtime_put_sync()
> >>>>> __pm_runtime_idle()
> >>>>> rpm_idle() -- RPM_GET_PUT(4)
> >>>>>       __rpm_callback
> >>>>>           scsi_runtime_idle()
> >>>>>               pm_runtime_mark_last_busy()
> >>>>>               pm_runtime_autosuspend()  --[A]
> >>>>>                   rpm_suspend() -- RPM_AUTO(8)
> >>>>>                       pm_runtime_autosuspend_expiration() use_autosuspend    is false return 0   --- [B]
> >>>>>                           __update_runtime_status to RPM_SUSPENDING
> >>>>>                       __rpm_callback()
> >>>>>                           __rpm_put_suppliers(dev, false)
> >>>>>                       __update_runtime_status to RPM_SUSPENDED
> >>>>>                   rpm_suspend_suppliers()
> >>>>>                       rpm_idle() for supplier -- RPM_ASYNC(1) return (-EAGAIN) [ Other consumer active for supplier]
> >>>>>                   rpm_suspend() – END with return=0
> >>>>>           scsi_runtime_idle() END return (-EBUSY) always.
> >>>
> >>> Not following here either.  Which device is EBUSY and why?
> >>
> >> scsi_runtime_idle() return -EBUSY always [3]
> >> Storage/scsi team can better explain -EBUSY implementation.
> >
> > EBUSY is returned from below code for consumer dev 0:0:0:0.
> > scsi_runtime_idle is called from scsi_autopm_put_device which inturn is called from ufshcd_async_scan (Process 1 as per above call stack)
> > static int scsi_runtime_idle(struct device *dev)
> > {
> >     :
> >
> >     if (scsi_is_sdev_device(dev)) {
> >         pm_runtime_mark_last_busy(dev);
> >         pm_runtime_autosuspend(dev);
> >         return -EBUSY; ---> EBUSY returned from here.
> >     }
> >
> >
> > }
> >
> >>
> >> [3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/scsi/scsi_pm.c?h=next-20221118#n210
> >>
> >>
> >>>>>
> >>>>> [1]: https://lore.kernel.org/lkml/4748074.GXAFRqVoOG@kreacher/T/
> >>>>> [2]: https://lkml.org/lkml/2022/10/12/259
>
> It looks to me like __rpm_callback() makes assumptions about
> dev->power.runtime_status that are not necessarily true because
> dev->power.lock is dropped.

Well, this happens because rpm_idle() calls __rpm_callback() and
allows it to run concurrently with rpm_suspend() and rpm_resume(), so
one of them may change runtime_status to RPM_SUSPENDING or
RPM_RESUMING while __rpm_callback() is running.

It is somewhat questionable whether or not this should be allowed to
happen, but since it is generally allowed to suspend the device from
its .runtime_idle callback, there is not too much that can be done
about it.

>  AFAICT the intention of the code would be fulfilled by instead using the status as it was before
> the lock was dropped.

That's correct, so the patch should help, but it also needs to remove
the comment stating that the runtime status cannot change when
__rpm_callback() is running, which is clearly incorrect.

> Consequently, perhaps you could try this:
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index b52049098d4e..3cf9abc3b2c2 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -365,6 +365,7 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
>  {
>         int retval = 0, idx;
>         bool use_links = dev->power.links_count > 0;
> +       enum rpm_status runtime_status = dev->power.runtime_status;
>
>         if (dev->power.irq_safe) {
>                 spin_unlock(&dev->power.lock);
> @@ -378,7 +379,7 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
>                  * routine returns, so it is safe to read the status outside of
>                  * the lock.
>                  */
> -               if (use_links && dev->power.runtime_status == RPM_RESUMING) {
> +               if (use_links && runtime_status == RPM_RESUMING) {
>                         idx = device_links_read_lock();
>
>                         retval = rpm_get_suppliers(dev);
> @@ -405,8 +406,8 @@ static int __rpm_callback(int (*cb)(struct device *), struct device *dev)
>                  * Do that if resume fails too.
>                  */
>                 if (use_links
> -                   && ((dev->power.runtime_status == RPM_SUSPENDING && !retval)
> -                   || (dev->power.runtime_status == RPM_RESUMING && retval))) {
> +                   && ((runtime_status == RPM_SUSPENDING && !retval)
> +                   || (runtime_status == RPM_RESUMING && retval))) {
>                         idx = device_links_read_lock();
>
>                         __rpm_put_suppliers(dev, false);
>
>
