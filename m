Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E735F675703
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjATOZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjATOYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:24:50 -0500
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD41CE215;
        Fri, 20 Jan 2023 06:24:33 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id rl14so11027497ejb.2;
        Fri, 20 Jan 2023 06:24:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DdfwY1ZCUGNm1TC4PybUHmSBv1sQgFPf3UXbHXulzOQ=;
        b=04MxUF7U/5u1Ufg07sNJZ8vrzOJacMtiqDX8IBUaFMGAHRVOLfGPc7/BkvsOS39SSZ
         5BkjAiTysXwTgeLZAqypzL0GRBbnvjy60IIJrg0pNU0EtU7nDmXYDXOxttcMUEqkh8u0
         Zop3bxil1YdLOV1q6QKMHnPRZsv+AmOw1RS1CkB4eufgeN+lJ+oz3aTWwE6R/BI86l9i
         0Qn6v4c6aBAkuV1GTb8kSMwand7O9FycoYpFY95cHJ3ooug7B9wsj6OUzlU9yQ3RyoQx
         AH8UbzQQFMUvk5EYXFV48R3pjsg9se/Er1R0xi6yTd0HVZoadFN9es+cxehWMXQASrwC
         tWiw==
X-Gm-Message-State: AFqh2kqwO+Q7w9MjTtU1++IotjYQsJYgm87jYe1+W4e7qRnbwTXeHVCl
        lVRtuliluABUV4vKdWMsEEecEh55bA6EAPy1y5hr7bMX
X-Google-Smtp-Source: AMrXdXsr7bguEIeDU06rlqYGR2KGEYyYa1luvqE4Xdl8XhFn+cU3UuYsR6w2eBH9Bpq9DGjUZEofBCL3iEfO9oqbTV4=
X-Received: by 2002:a17:906:2c4b:b0:870:3557:160e with SMTP id
 f11-20020a1709062c4b00b008703557160emr1166751ejh.78.1674224016899; Fri, 20
 Jan 2023 06:13:36 -0800 (PST)
MIME-Version: 1.0
References: <20230118211123.111493-1-daniel.lezcano@linaro.org>
 <CAJZ5v0icp3nH+3-timEh2o8kxXpe4O2uMdJ8pSwe8fmY_OW4zA@mail.gmail.com>
 <54674d67-7be3-0abc-4252-e7f4158f56f2@linaro.org> <12134920.O9o76ZdvQC@kreacher>
 <356516181c0f7a6ed1e4e97aabe12d50c7a51bc4.camel@intel.com>
In-Reply-To: <356516181c0f7a6ed1e4e97aabe12d50c7a51bc4.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Jan 2023 15:13:25 +0100
Message-ID: <CAJZ5v0iDwdsg0ThC8hU7huVQQUL0e0KX-R8GK5FHe5Q7SG7TRA@mail.gmail.com>
Subject: Re: [PATCH 3/5] thermal/core: Remove unneeded mutex_destroy()
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>
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

On Fri, Jan 20, 2023 at 3:10 PM Zhang, Rui <rui.zhang@intel.com> wrote:
>
> On Thu, 2023-01-19 at 18:21 +0100, Rafael J. Wysocki wrote:
> > On Thursday, January 19, 2023 5:39:29 PM CET Daniel Lezcano wrote:
> > > On 19/01/2023 16:05, Rafael J. Wysocki wrote:
> > > > On Thu, Jan 19, 2023 at 3:13 PM Daniel Lezcano
> > > > <daniel.lezcano@linaro.org> wrote:
> > > > > On 19/01/2023 14:24, Rafael J. Wysocki wrote:
> > > > > > On Thu, Jan 19, 2023 at 1:48 PM Daniel Lezcano
> > > > > > <daniel.lezcano@linaro.org> wrote:
> > > > > > > On 19/01/2023 13:11, Rafael J. Wysocki wrote:
> > > > > > > > On Thu, Jan 19, 2023 at 10:30 AM Daniel Lezcano
> > > > > > > > <daniel.lezcano@linaro.org> wrote:
> > > > > > > > > On 19/01/2023 08:41, Zhang, Rui wrote:
> > > > > > > > > > On Wed, 2023-01-18 at 22:11 +0100, Daniel Lezcano
> > > > > > > > > > wrote:
> > > > > > > > > > > If the thermal framework fails to initialize, the
> > > > > > > > > > > mutex can be used
> > > > > > > > > > > by
> > > > > > > > > > > the different functions registering a thermal zone
> > > > > > > > > > > anyway.
> > > > > > > > > >
> > > > > > > > > > Hmm, even with no governors and unregistered thermal
> > > > > > > > > > sysfs class?
> > > > > > > > > >
> > > > > > > > > > IMO, thermal APIs for registering a
> > > > > > > > > > thermal_zone/cooling_device should
> > > > > > > > > > yield early if thermal_init fails.
> > > > > > > > > > For other APIs that relies on a valid
> > > > > > > > > > thermal_zone_device/thermal_cooling_device pointer,
> > > > > > > > > > nothing needs to
> > > > > > > > > > be changed.
> > > > > > > > > >
> > > > > > > > > > what do you think?
> > > > > > > > >
> > > > > > > > > I think you are right.
> > > > > > > > >
> > > > > > > > > It would be nice if we can check if the thermal class
> > > > > > > > > is registered and
> > > > > > > > > bail out if not. But there is no function to check that
> > > > > > > > > AFAICS.
> > > > > > > > >
> > > > > > > > > Alternatively we can convert the thermal class static
> > > > > > > > > structure to a
> > > > > > > > > pointer and set it to NULL in case of error in
> > > > > > > > > thermal_init() ?
> > > > > > > >
> > > > > > > > It doesn't matter if this is a NULL pointer or a static
> > > > > > > > object that's
> > > > > > > > clearly marked as unused.
> > > > > > >
> > > > > > > Without introducing another global variable, is it possible
> > > > > > > to know if
> > > > > > > the class is used or not ?
> > > > > >
> > > > > > If thermal_class.p is cleared to NULL on class_register()
> > > > > > failures in
> > > > > > thermal_init() (unfortunately, the driver core doesn't do
> > > > > > that, but
> > > > > > maybe it should - let me cut a patch for that), then it can
> > > > > > be used
> > > > > > for that.
> > > > >
> > > > > It should be in class_unregister() too, right ?
> > > > >
> > > > > And is it possible to add a class_is_registered() ? in order to
> > > > > prevent
> > > > > accessing class structure internals ?
> > > >
> > > > I suppose so.
> > > >
> > > > And we'd like it to be used some places like
> > > > thermal_zone_device_register_with_trips(), wouldn't we?
> > >
> > > Yes, in thermal_zone_device_register_with_trips() and
> > > thermal_cooling_device_register().
> >
> > Something like the patch below I think, because
> > thermal_cooling_device_register()
> > is a wrapper around thermal_zone_device_register_with_trips().
> >
>
> thermal_zone_device_register() is a wrapper around
> thermal_zone_device_register_with_trips(), but
> thermal_cooling_device_register() is not. :)
>
> thermal_cooling_device_register() registers a cooling device to thermal
> class so the class_is_registered() check is still needed.

OK, thanks!
