Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D4173BDA1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjFWRQV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 13:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjFWRQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:16:15 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5256E26B0;
        Fri, 23 Jun 2023 10:16:11 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-97ea801b0d0so18431166b.1;
        Fri, 23 Jun 2023 10:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687540570; x=1690132570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++I0bwtrHbKq/ScVaI2y/wuFflAnqwfHn5bGDDiyGlI=;
        b=jXXi2SdYecLvzVElNuZwoNI1N03atft4Xnx6F7tlW9k2s37WyP4sgcd3LkOqB/VYYh
         72mrftUIQpN6kzY/vTG+XNBpK1QLu0q8cvHB2ej601wPQspgmKFJMRrRvL3eCPu+f843
         CMm+BBd36D5MJzDa5KcQZdTKRUy07jdPwMIUFhh/hdXN6qxiE/4MOz82Qja8VbD5NUwB
         OVMZeAcZrZW3LsE83cycD6CuLbPjid7y4Mx8ffkYwI3mnl1zMyZbAzmqEiM2PAEkEyrd
         kaBRpLz3ZZGd4+Dk9eJduD9J6SEnZ1PRq4l4TsBjWYPXO5UEYMc8+BN9nvCvOSARDUB/
         v40w==
X-Gm-Message-State: AC+VfDxoxrOWDfeKeFjPwenlSlR1PaY/GFq/xDS06eXxalsdAA5SPJIK
        xM7h04r4MEMv8vzvib2Fw5Z/6s5Bvsxz3PgO/XA=
X-Google-Smtp-Source: ACHHUZ5US9J/ZgCAFTh5AYOguizpGxZnLeJHo3AK7Wd3X9ovii63C+dm6Qk1WKxgnt2LMEl9QMec3C8Z8RMvEXNgmWA=
X-Received: by 2002:a17:906:73dd:b0:989:1ed3:d00b with SMTP id
 n29-20020a17090673dd00b009891ed3d00bmr9073854ejl.4.1687540569572; Fri, 23 Jun
 2023 10:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230621054603.1262299-1-evan.quan@amd.com> <20230621054603.1262299-2-evan.quan@amd.com>
 <CAJZ5v0iqy0yMJP5H7ub67R8R6i42=TcS_6+VF-+fWrM-9tYFQA@mail.gmail.com>
 <c518da2a-5ba5-af7e-e26d-1973db7b4c9e@amd.com> <CAJZ5v0gnTt0pV4nF+jcYCyZuZXDNuRn3mS0bDoAv-ZDpetyxVg@mail.gmail.com>
 <5d6f6a89-1c7f-3763-8616-b80fdc301603@amd.com>
In-Reply-To: <5d6f6a89-1c7f-3763-8616-b80fdc301603@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Jun 2023 19:15:57 +0200
Message-ID: <CAJZ5v0iwPqD5PhQ8OcXO_xncFwH824h=U7W50pyPMBqtPSpP=g@mail.gmail.com>
Subject: Re: [PATCH V4 1/8] drivers/acpi: Add support for Wifi band RF mitigations
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Evan Quan <evan.quan@amd.com>, lenb@kernel.org,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mdaenzer@redhat.com, maarten.lankhorst@linux.intel.com,
        tzimmermann@suse.de, hdegoede@redhat.com, jingyuwang_vip@163.com,
        lijo.lazar@amd.com, jim.cromie@gmail.com, bellosilicio@gmail.com,
        andrealmeid@igalia.com, trix@redhat.com, jsg@jsg.id.au,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
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

On Fri, Jun 23, 2023 at 6:48 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
>
> On 6/23/2023 11:28 AM, Rafael J. Wysocki wrote:
> > On Fri, Jun 23, 2023 at 5:57 PM Limonciello, Mario
> > <mario.limonciello@amd.com> wrote:
> >>
> >> On 6/23/2023 9:52 AM, Rafael J. Wysocki wrote:
> >>> On Wed, Jun 21, 2023 at 7:47 AM Evan Quan <evan.quan@amd.com> wrote:
> >>>> From: Mario Limonciello <mario.limonciello@amd.com>
> >>>>
> >>>> Due to electrical and mechanical constraints in certain platform designs
> >>>> there may be likely interference of relatively high-powered harmonics of
> >>>> the (G-)DDR memory clocks with local radio module frequency bands used
> >>>> by Wifi 6/6e/7.
> >>>>
> >>>> To mitigate this, AMD has introduced an ACPI based mechanism that
> >>>> devices can use to notify active use of particular frequencies so
> >>>> that devices can make relative internal adjustments as necessary
> >>>> to avoid this resonance.
> >>>>
> >>>> In order for a device to support this, the expected flow for device
> >>>> driver or subsystems:
> >>>>
> >>>> Drivers/subsystems contributing frequencies:
> >>>>
> >>>> 1) During probe, check `wbrf_supported_producer` to see if WBRF supported
> >>> The prefix should be acpi_wbrf_ or acpi_amd_wbrf_ even, so it is clear
> >>> that this uses ACPI and is AMD-specific.
> >> I guess if we end up with an intermediary library approach
> >> wbrf_supported_producer makes sense and that could call acpi_wbrf_*.
> >>
> >> But with no intermediate library your suggestion makes sense.
> >>
> >> I would prefer not to make it acpi_amd as there is no reason that
> >> this exact same problem couldn't happen on an
> >> Wifi 6e + Intel SOC + AMD dGPU design too and OEMs could use the
> >> same mitigation mechanism as Wifi6e + AMD SOC + AMD dGPU too.
> > The mitigation mechanism might be the same, but the AML interface very
> > well may be different.
>
>
> Right.  I suppose right now we should keep it prefixed as "amd",
> and if it later is promoted as a standard it can be renamed.
>
>
> >
> > My point is that this particular interface is AMD-specific ATM and I'm
> > not aware of any plans to make it "standard" in some way.
>
>
> Yeah; this implementation is currently AMD specific AML, but I
> expect the exact same AML would be delivered to OEMs using the
> dGPUs.
>
>
> >
> > Also if the given interface is specified somewhere, it would be good
> > to have a pointer to that place.
>
>
> It's a code first implementation.  I'm discussing with the
> owners when they will release it.
>
>
> >
> >>> Whether or not there needs to be an intermediate library wrapped
> >>> around this is a different matter.
> > IMO individual drivers should not be expected to use this interface
> > directly, as that would add to boilerplate code and overall bloat.
>
> The thing is the ACPI method is not a platform method.  It's
> a function of the device (_DSM).

_DSM is an interface to the platform like any other AML, so I'm not
really sure what you mean.

> The reason for having acpi_wbrf.c in the first place is to
> avoid the boilerplate of the _DSM implementation across multiple
> drivers.

Absolutely, drivers should not be bothered with having to use _DSM in
any case.  However, they may not even realize that they are running on
a system using ACPI and I'm not sure if they really should care.

> >
> > Also whoever uses it, would first need to check if the device in
> > question has an ACPI companion.
>
>
> Which comes back to Andrew's point.
> Either we:
>
> Have a generic wbrf_ helper that takes struct *device and
> internally checks if there is an ACPI companion and support.
>
> or
>
> Do the check for support in mac80211 + applicable drivers
> and only call the AMD WBRF ACPI method in those drivers in
> those cases.

Either of the above has problems IMO.

The problem with the wbrf_ helper approach is that it adds
(potentially) several pieces of interaction with the platform,
potentially for every driver, in places where drivers don't do such
things as a rule.

The problem with the other approach is that the drivers in question
now need to be aware of ACPI in general and the AMD WBRF interface in
particular and if other similar interfaces are added by other vendors,
they will have to learn about those as well.

I think that we need to start over with a general problem statement
that in some cases the platform needs to be consulted regarding radio
frequencies that drivers would like to use, because it may need to
adjust or simply say which ranges are "noisy" (or even completely
unusable for that matter).  That should allow us to figure out how the
interface should look like from the driver side and it should be
possible to hook up the existing platform interface to that.
