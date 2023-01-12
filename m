Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7505667807
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240081AbjALOvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240034AbjALOvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:51:06 -0500
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3F213F97;
        Thu, 12 Jan 2023 06:38:04 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id v10so25877051edi.8;
        Thu, 12 Jan 2023 06:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FFSpdMe78nK3l1YFe11xcZzXqYj/l0qc+jemqR1MPsk=;
        b=dTeOl3G7m7n9MPYNgkHsjIc534IOorjwhDQCc9RlcK0Ufy5LnpyKd62DmgZH732rbE
         IRNNqmvudWTGLM+BgzkfBApfjCPHsamnyBeFvn+7ijFCavWXED3g9Ho0NrF1sghCZicm
         kFBszPdBEHLl0NVbaPoIE2SYNnQsuAbgxjLnKmD1FpPfBHaveQJP2eU+VPMw49Ht8hT9
         K1H5610vQd9pSgC1GOAVygnR+T23cWmPtIdBMz4rMFZ1BbZ64Cl4c0CNdahDEPRAKLrI
         uS3mfXCaBqTJeIiFN3blkkXaes4d9CRCG/ZtQV0yHDmeQHVxPviueZJh+B5KKNV966B6
         UClg==
X-Gm-Message-State: AFqh2kqQIxJFTtVUoKdYHL9ub02slrJJBiYG9TwEcHgFGfEYgACyebZV
        0aay5SNpPhM7+/s9xT+ziUmWX0Zu8mFWROgGfbM=
X-Google-Smtp-Source: AMrXdXuQFrQM/eEp39x0D7y1DHfpG8qNEAyV9wY5kgdvXdnEvxaYKwqMREG0+UFK/nIMLHJp16MUdJpWipAxhNT0xEM=
X-Received: by 2002:a05:6402:298b:b0:47f:7465:6e76 with SMTP id
 eq11-20020a056402298b00b0047f74656e76mr7256281edb.181.1673534283121; Thu, 12
 Jan 2023 06:38:03 -0800 (PST)
MIME-Version: 1.0
References: <20221129233419.4022830-1-srinivas.pandruvada@linux.intel.com>
 <20221129233419.4022830-3-srinivas.pandruvada@linux.intel.com>
 <e2af7a4b-99f4-f88e-fbe7-5d3595d6211b@linaro.org> <3e59c5216fad003f079224cd08a7da9b30f6365d.camel@linux.intel.com>
 <de6a5000-260e-bb4a-31c4-a0cfe533fad4@linaro.org> <8d3a9644657c8f0b54dd272fe0a4d640a8a6dfb9.camel@linux.intel.com>
In-Reply-To: <8d3a9644657c8f0b54dd272fe0a4d640a8a6dfb9.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Jan 2023 15:37:51 +0100
Message-ID: <CAJZ5v0jwrqcdG=95QmFCBrr0Ng0gqUXbKPUOk0Hz9wMz7A0HKg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] powercap: idle_inject: Add prepare/complete callbacks
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, amitk@kernel.org
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

On Thu, Dec 22, 2022 at 6:36 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Hi Daniel,
>
> On Thu, 2022-12-22 at 10:50 +0100, Daniel Lezcano wrote:
> >
> > Hi Srinivas,
> >
> >
> > On 21/12/2022 21:58, srinivas pandruvada wrote:
> > > Hi Daniel,
> > >
> > > On Wed, 2022-12-21 at 15:52 +0100, Daniel Lezcano wrote:
> > > >
> > > > Hi Srinivas,
> > > >
> > > > On 30/11/2022 00:34, Srinivas Pandruvada wrote:
> > > > > The actual idle percentage can be less than the desired because
> > > > > of
> > > > > interrupts. Since the objective for CPU Idle injection is for
> > > > > thermal
> > > > > control, there should be some way to compensate for lost idle
> > > > > percentage.
> > > > > Some architectures provide interface to get actual idle percent
> > > > > observed
> > > > > by the hardware. So, the idle percent can be adjusted using the
> > > > > hardware
> > > > > feedback. For example, Intel CPUs provides package idle
> > > > > counters,
> > > > > which
> > > > > is currently used by intel powerclamp driver to adjust idle
> > > > > time.
> > > > Can you provide an example in terms of timings?
> > > >
> > > > I'm not getting how 'prepare' would do by returning a positive
> > > > value
> > > > to
> > > > skip the play_idle_precise() and what will do 'complete' ?
> > > >
> > > intel_powerclamp has a logic where if the current idle percentage
> > > observed from hardware is more than the desired target inject
> > > percent,
> > > it skips calling play_idle().
> > >
> > > For example if you want to inject 50% idle and system is naturally
> > > idle
> > > for 60%, there is no use of calling play_idle in the idle injection
> > > framework to induce more idle. In this way a workload can run
> > > immediately.
> > >
> > > So trying to emulate the same logic by using powercap/idle_inject
> > > framework. So prepare() callback in the intel_powerclamp driver
> > > calls
> > > the existing function to check if idle-inject should skip for this
> > > time
> > > or not.
> >
> > The function 'prepare' has the 'cpu' parameter. How can it compare
> > with
> > the desired idle duration as this information is not passed to the
> > callback ?
> Good question.
>
> Calling driver knows what idle_duration he set.
> In my first version, I passed *idle_duration (with current
> idle_duration set), so the caller can change this for the current
> play_idle call if required for one time.
>
> But in powerclamp case we either skip the whole play_idle or not. It
> doesn't change idle duration. So didn't add.
>
> But we can add this back.

I don't think that it is necessary at this point.

Since powerclamp is the only user and it doesn't need idle_duration, I
would just not add it ATM.

I have a couple of other comments to the patch, but let me send them separately.
