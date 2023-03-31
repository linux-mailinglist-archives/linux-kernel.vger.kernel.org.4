Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC8F6D27C6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjCaS0F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 14:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjCaS0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:26:04 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCB01BF4C;
        Fri, 31 Mar 2023 11:26:03 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id er13so52176144edb.9;
        Fri, 31 Mar 2023 11:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680287161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RaB5p8dANCz2nc2jG5lwXWHNdu974YJYtJWNgZD8A8M=;
        b=CCZN5FF3/Ox0z+h8BWZVY6/HoRSeD1i1u16vmqKTicuMWY++c3ywrBgQiWz0tsdTtJ
         AUx/um1OdzrqWczZomQsFxFvWtQ8YgGtays5Z92yeEMSAi8Ab+IgnMm1ZhcUBz+QuqNc
         t7EXkeqqkWIidhoz8y7PIklVMPemnXVQhueMyVY4BNDpl+ANtqiYQ0/P5D7Gkd3m6RJm
         d8Zlvnd4wIGt0XDu1oSyVd11op324SMA98I4MTZ8U1j/cBOmAtY6Ue0cwWusn8lZSjjS
         IlE+L2Lm6PDRPDOygCs7NnNEStmPeCVd0nEvFi10TmJdMancdDvcDrgSPXLQzo4cCy20
         JgSQ==
X-Gm-Message-State: AAQBX9cyv+bilD0bZXUrPpvDpA/rN84+8gI/pykm6ru+kAZZ1bvUnDdW
        5ng1PJ4DUDcm/W0DTUbsne1hBczrtOfCb3bmA0s=
X-Google-Smtp-Source: AKy350adaPntcUkPWxFx1duflu6YE6LOfmcIB7o/QroDfpS7WhdUUDgFayI/MvYK8jxyM1CnjZnJ4ixoynkk5RoXGTU=
X-Received: by 2002:a50:d49e:0:b0:4fc:ebe2:2fc9 with SMTP id
 s30-20020a50d49e000000b004fcebe22fc9mr13651347edi.3.1680287161357; Fri, 31
 Mar 2023 11:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230330194439.14361-1-mario.limonciello@amd.com>
 <20230330194439.14361-2-mario.limonciello@amd.com> <CAJZ5v0jbMXk5k_KG19bQnffhCkGnu=MQXjGrBPipZxA_Cg8O9w@mail.gmail.com>
 <2676888c-e93f-53aa-a4f7-e85b66f351c8@amd.com> <CAJZ5v0iia9__-jWmawvsxninoTM5ZRtqhyUJme=noZMZJdUBrA@mail.gmail.com>
 <8a04da89-1c98-8b29-bf96-1e8d0ed47e58@amd.com>
In-Reply-To: <8a04da89-1c98-8b29-bf96-1e8d0ed47e58@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Mar 2023 20:25:50 +0200
Message-ID: <CAJZ5v0j-uMmi7QmC3XhtNbc+aroBkexriLQWfnyCrjBMf70Z=w@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] PM: Add a sysfs file to represent time spent in
 hardware sleep state
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sven van Ashbrook <svenva@chromium.org>,
        John Stultz <jstultz@google.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Raul Rangel <rrangel@chromium.org>,
        David E Box <david.e.box@intel.com>,
        Rajat Jain <rajatja@google.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 8:13 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 3/31/2023 13:07, Rafael J. Wysocki wrote:
> > On Fri, Mar 31, 2023 at 8:05 PM Limonciello, Mario
> > <mario.limonciello@amd.com> wrote:
> >>
> >> On 3/31/2023 13:01, Rafael J. Wysocki wrote:
> >>> On Thu, Mar 30, 2023 at 9:45 PM Mario Limonciello
> >>> <mario.limonciello@amd.com> wrote:
> >>>>
> >>>> Userspace can't easily discover how much of a sleep cycle was spent in a
> >>>> hardware sleep state without using kernel tracing and vendor specific sysfs
> >>>> or debugfs files.
> >>>>
> >>>> To make this information more discoverable, introduce a new sysfs file
> >>>> to represent the time spent in a sleep state.
> >>>
> >>> This is only in the most recent suspend-resume cycle, isn't it?
> >>
> >> Yes; that's correct.
> >>
> >>>
> >>> Wouldn't it be useful to have another attribute printing the
> >>> accumulated total HW sleep time?
> >>>
> >>
> >> I had considered this; but I didn't think it was actually very useful
> >> because userspace will get control at the end of every cycle and can
> >> accumulate those numbers if desirable.
> >
> > Unless "user space" in question is actually a human, that is.
>
> This is what I envisioned:
>
> * In traditional Linux some software like systemd could capture this and
> log it.
> It could subtract at the time the suspend started from the time it ended
> and use that to calculate a percentage of time in hardware sleep state
> and then put that percentage in the system journal.
>
> * In ChromeOS something like powerd would be the only thing reading this
> number and it could be adding it up during dark resume until the system
> gets to a full resume.
>
> * If a human is manually capturing these values they'll be most
> interested in whether an individual cycle reached hardware sleep.

Or whether or not it has been reached in any cycle so far?  Or in the
most recent 10 cycles?  Or similar?

Or how much time the system spent in HW sleep in general?

> If it didn't they'll want to look at debug data from that cycle.
> The aggregate will be noise.

Not necessarily and the point is that you can relatively easily
provide both values, the one from the most recent cycle and the grand
total.

> Do you think of another use case?

Well, if the kernel can easily compute and expose the grand total
value, why is it better to offload that to user space, possibly in
different ways in different system configurations?  What if somebody
runs a minimum user space?
