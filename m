Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4145FDACE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJMN1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJMN1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:27:44 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3971A23D;
        Thu, 13 Oct 2022 06:27:43 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id w3so989061qtv.9;
        Thu, 13 Oct 2022 06:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hvCn487RdlqnBhd9yUnGkq9ulo/PaHTDt+MPrUx3vxs=;
        b=t9rwm4mBHL3Qo5c3vNSURRxmDdHLFnz+X26rkW58Zu2fLWk9j5jedkv2aD+5GUsoRS
         aP3br3Z3hKapgIzFBuiCNH0rmg2PtsQeqygte0Ra3C49DXX2mhw2YN48OzVLw1fLuI61
         ACEfrGB5NM8N3rxa7Tm8wJWz2cqH3eGtbCIkCastIkObkXr5C/SM87GVMGiI66QJN/AT
         DY1ff3xRNV1AwPPI6Aj52L2R1ulG/Gvp1AH66Tse2njLH50ITc0l+dKoGdcS8k+56aDG
         WVliW2J4Njeywl/FCCEZ8Z/e/04NWdWOjEx/ZbRvgY3FlZ3+8e/pRlTlC/okUTLnaau0
         3Wdg==
X-Gm-Message-State: ACrzQf3ZfN6OIhqkNtL8Ty3HTh+GTg3A2ZUB1jc8DHbuU6kTw561jLeS
        dHntAQW9OoqxtcA/QPzy8GUI3K6i1ljhuskCUNQ=
X-Google-Smtp-Source: AMsMyM4fMMAcKK5VKaT5UP2rjpMBKCkMXyuRhQ2sXHTcKGXmuzAGds8qZJIHORIKgYkQ186dpuLm74RmsXSxCQNYKxo=
X-Received: by 2002:ac8:5ac1:0:b0:39a:123c:9df5 with SMTP id
 d1-20020ac85ac1000000b0039a123c9df5mr16908127qtd.27.1665667662370; Thu, 13
 Oct 2022 06:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <5633735.DvuYhMxLoT@kreacher> <Y0gOI9hiP9NXsuJP@chenyu5-mobl1>
In-Reply-To: <Y0gOI9hiP9NXsuJP@chenyu5-mobl1>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Oct 2022 15:27:30 +0200
Message-ID: <CAJZ5v0jyYB7PVQm-q3UQAaCu15LbMpfZ+8bCckZWS93w3y2XRA@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel_powerclamp: Use first online CPU as control_cpu
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>
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

On Thu, Oct 13, 2022 at 3:10 PM Chen Yu <yu.c.chen@intel.com> wrote:
>
> On 2022-10-13 at 14:50:28 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 68b99e94a4a2 ("thermal: intel_powerclamp: Use get_cpu() instead
> > of smp_processor_id() to avoid crash") fixed an issue related to using
> > smp_processor_id() in preemptible context by replacing it with a pair
> > of get_cpu()/put_cpu(), but what is needed there really is any online
> > CPU and not necessarily the one currently running the code.  Arguably,
> > getting the one that's running the code in there is confusing.
> >
> > For this reason, simply give the control CPU role to the first online
> > one which automatically will be CPU0 if it is online, so one check
> > can be dropped from the code for an added benefit.
> >
> > Link: https://lore.kernel.org/linux-pm/20221011113646.GA12080@duo.ucw.cz/
> > Fixes: 68b99e94a4a2 ("thermal: intel_powerclamp: Use get_cpu() instead of smp_processor_id() to avoid crash")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/thermal/intel/intel_powerclamp.c |    6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/intel/intel_powerclamp.c
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/intel/intel_powerclamp.c
> > +++ linux-pm/drivers/thermal/intel/intel_powerclamp.c
> > @@ -516,11 +516,7 @@ static int start_power_clamp(void)
> >       cpus_read_lock();
> >
> >       /* prefer BSP */
> Above comment line is not true any more, might delete it as well?

Well, why not?  If CPU0 is the BSP, it is still preferred as before.

> Reviewed-by: Chen Yu <yu.c.chen@intel.com>

Thanks!

> > -     control_cpu = 0;
> > -     if (!cpu_online(control_cpu)) {
> > -             control_cpu = get_cpu();
> > -             put_cpu();
> > -     }
> > +     control_cpu = cpumask_first(cpu_online_mask);
> >
> >       clamping = true;
> >       schedule_delayed_work(&poll_pkg_cstate_work, 0);
> >
> >
> >
