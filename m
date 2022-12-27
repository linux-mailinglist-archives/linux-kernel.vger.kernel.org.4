Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B8E656CB3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 16:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiL0P65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 10:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiL0P5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 10:57:54 -0500
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F996B4A1;
        Tue, 27 Dec 2022 07:57:53 -0800 (PST)
Received: by mail-qk1-f177.google.com with SMTP id z17so6432729qki.11;
        Tue, 27 Dec 2022 07:57:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVfqQ349jkJ/6PwkDFkW/CEH/+s0QgqVFNP/UFQtyJU=;
        b=j0YzMvgrVQiXiQRrzfz620O0R6xch+XrGd/X8OwkkjYim3GjBg5fT+d+9+zKDFrrrH
         m74XhgE4flZOlcsVw4nW3r3L9hQiYdBa9PbMLhXVTK/Zz02zNNmwvNH0Hw2ai4EkcFXP
         L9f8pI3lWx7V5HA9rTe7ets6sUn20Ow68uY+JJ63ltzICH4EKIn2IWG0bl4UOojq//F5
         LwmzET/z/IwsnuE63ZiPZdNnKaMntAu4+Z43X+JkzDqGnnbglGPaHn0FX2oq7h1TuEFw
         HT2bReRXA03a8qVqY90LqPcRajnQSjkU/oI8Tx7ZNoAmhWBMAbm2Z/ALvW/bjYTuFUIm
         8whA==
X-Gm-Message-State: AFqh2kq1xShMD0msSI/RIUankLcSi02msA91h+WNV2vMWxPx/zunyKkP
        iZtGReOF5UtHgajlldiPa0FWUo0sGp7mWhutGTM=
X-Google-Smtp-Source: AMrXdXuWSRyGJOsZsNbH25nZ1SSGri/E5AKeBrr7xdyHGYUHmDv3d5tO8ZfKKb3GkkvC+47Xz7du/8dYmE+CdrzffgI=
X-Received: by 2002:a05:620a:22b1:b0:702:50ce:e49 with SMTP id
 p17-20020a05620a22b100b0070250ce0e49mr1131505qkh.443.1672156672662; Tue, 27
 Dec 2022 07:57:52 -0800 (PST)
MIME-Version: 1.0
References: <20221221155203.11347-1-ptyadav@amazon.de> <72bcd14eef038ec9181d30b3d196b0a872f47ccb.camel@linux.intel.com>
 <mafs0k02jd8oh.fsf_-_@dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com>
 <2ed9702b67832e3e33ef352808124980206c1e95.camel@linux.intel.com>
 <8e2cc66f7dadcfb04099aac7c4eef0b02075c91b.camel@linux.intel.com> <mafs07cycdfh4.fsf_-_@amazon.de>
In-Reply-To: <mafs07cycdfh4.fsf_-_@amazon.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Dec 2022 16:57:34 +0100
Message-ID: <CAJZ5v0gaMeFmCCJMqg_3n_FkZ4L2J-y8CwgrNxBJiKJd_2e1Vw@mail.gmail.com>
Subject: Re: [PATCH 0/2] intel_pstate: fix turbo not being used after a
 processor is rebooted
To:     Pratyush Yadav <ptyadav@amazon.de>
Cc:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@acpica.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 4:38 PM Pratyush Yadav <ptyadav@amazon.de> wrote:
>
> Hi Srinivas,
>
> On Sat, Dec 24 2022, srinivas pandruvada wrote:
>
> > On Fri, 2022-12-23 at 10:10 -0800, srinivas pandruvada wrote:
> >> Hi Pratyush,
> >>
> >> On Thu, 2022-12-22 at 11:39 +0100, Pratyush Yadav wrote:
> >> >
> >> > Hi Srinivas,
> >> >
> >> > On Wed, Dec 21 2022, srinivas pandruvada wrote:
> >> > > On Wed, 2022-12-21 at 16:52 +0100, Pratyush Yadav wrote:
> >> > > > When a processor is brought offline and online again, it is
> >> > > > unable to
> >> > > > use Turbo mode because the _PSS table does not contain the whole
> >> > > > turbo
> >> > > > frequency range, but only +1 MHz above the max non-turbo
> >> > > > frequency.
> >> > > > This
> >> > > > causes problems when ACPI processor driver tries to set frequency
> >> > > > constraints. See patch 2 for more details.
> >> > > >
> >> I can reproduce on a Broadwell server platform. But not on a client
> >> system with acpi_ppc usage.
> >>
> >> Need to check what change broke this.
> >
> > When PPC limits enforcement changed to PM QOS, this broke. Previously
> > acpi_processor_get_platform_limit() was not enforcing any limits. It
> > was just setting variable. So any update done after
> > acpi_register_performance_state() call to pr->performance-
> >>states[ppc].core_frequency, was effective.
> >
> > We don't really need to call
> >         ret = freq_qos_update_request(&pr->perflib_req,
> >                         pr->performance->states[ppc].core_frequency *
> > 1000);
> >
> > if the PPC is not changed. When PPC is changed, this gets called again,
> > so then we can call the above function to update cpufreq limit.
> >
> > The below change fixed for me.
>
> Right. Should I re-roll my patches with your diff below then? Or do you
> think my patches should be good to merge as-is?

No, they are not good to merge.
