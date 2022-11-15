Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E375462A1AC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKOTJO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Nov 2022 14:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiKOTI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:08:57 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A277E1C92B;
        Tue, 15 Nov 2022 11:08:56 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id hh9so9331133qtb.13;
        Tue, 15 Nov 2022 11:08:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFZ8dudx9EF4uCNjqFqde5lndvaDlMv+g/5bjdCUGCk=;
        b=yoIqjopElMPYDEdwzs5+k85RFLOVszFpdwewLysnyz0fp5CQXzYvFrjssSHnMmAqUV
         ysBR15WwG/OC8UUxf6q+21gmlAX/1wZDJcW+k5ASHV8u3ORu1ddarDB/nuguVOfRrxH7
         bSfN8Vz3w8DgoE2DEH3S5lDjfAhwpJITbC9FlBdpvufx0rJIv3nS4te7+tFnbkJCwq/e
         E6r76g/++B05A5xgjlc0V/OOimoCJc5/t+DfGOkj9yGHmcSFUIvZ2NO4ZuUXRbPuTWO6
         PwBM17OedY78RqZM7KGk+R7OBeBPn9xDaZuLWEXbg0P03xQNC4Q7RkIRg+jvgHp/mZeh
         Qx4Q==
X-Gm-Message-State: ANoB5pnyjK/tbvDoGWOqVDZAfK4dm/1t+FQ+0MJeR1jOj655Q+gTlibH
        yHZd6B0/UFVZk3E4BIz9kEiGJS5jeyBshKtmQdY=
X-Google-Smtp-Source: AA0mqf4WM944gHcNZDF9dIemmwrnq4gzVf9OyCcBUNttENaOo/MQ6+LBypj7D4ATcgcqjc/wNGPhn6wBX4pjJCnQK08=
X-Received: by 2002:ac8:5198:0:b0:3a5:1e6f:7e05 with SMTP id
 c24-20020ac85198000000b003a51e6f7e05mr18018747qtn.357.1668539335590; Tue, 15
 Nov 2022 11:08:55 -0800 (PST)
MIME-Version: 1.0
References: <20221110064723.8882-1-mario.limonciello@amd.com>
 <20221110064723.8882-2-mario.limonciello@amd.com> <CAJZ5v0iwpSkd_8CS1dq6+rkszeKGygBbeifvugAEEKqA0w1s7w@mail.gmail.com>
 <460b23ee-16ed-f1e3-0e14-35051c908671@amd.com> <CAJZ5v0id3atXfu1OAsr4kWNwYgyMVo90u9Lu2j4ZNFWQX+QX0g@mail.gmail.com>
 <CAHQZ30BCXtyJ9qqHHX5eztXbgA_A8yH48+AQVMCB64CXjqE+hQ@mail.gmail.com>
 <bb86ba1f-c0cd-ae71-520c-b94d4d71b261@amd.com> <CAJZ5v0hj1yc8JZTD+_WfG0FZPPne41uw1RLj06FECzgSZSNuHw@mail.gmail.com>
 <f003be5b-2770-11e1-fa4e-2431a7588d5d@amd.com>
In-Reply-To: <f003be5b-2770-11e1-fa4e-2431a7588d5d@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 15 Nov 2022 20:08:43 +0100
Message-ID: <CAJZ5v0iZOUUnrpKL3DjVrQS5RFeBUZKTM_Q2CSCmo2o3sCijcw@mail.gmail.com>
Subject: Re: [RFC v2 1/3] PM: Add a sysfs files to represent sleep duration
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Sven van Ashbrook <svenva@chromium.org>,
        linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
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

On Tue, Nov 15, 2022 at 6:58 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 11/15/2022 11:52, Rafael J. Wysocki wrote:
> > On Tue, Nov 15, 2022 at 6:27 PM Limonciello, Mario
> > <mario.limonciello@amd.com> wrote:
> >>
> >> On 11/15/2022 11:20, Raul Rangel wrote:
> >>>
> >>>
> >>> On Tue, Nov 15, 2022 at 9:35 AM Rafael J. Wysocki <rafael@kernel.org
> >>> <mailto:rafael@kernel.org>> wrote:
> >>>
> >>>      On Tue, Nov 15, 2022 at 4:17 PM Limonciello, Mario
> >>>      <mario.limonciello@amd.com <mailto:mario.limonciello@amd.com>> wrote:
> >>>       >
> >>>       > On 11/15/2022 08:45, Rafael J. Wysocki wrote:
> >>>       > > On Thu, Nov 10, 2022 at 7:49 AM Mario Limonciello
> >>>       > > <mario.limonciello@amd.com <mailto:mario.limonciello@amd.com>>
> >>>      wrote:
> >>>       > >>
> >>>       > >> Both AMD and Intel SoCs have a concept of reporting whether
> >>>      the hardware
> >>>       > >> reached a hardware sleep state over s2idle as well as how much
> >>>       > >> time was spent in such a state.
> >>>       > >>
> >>>       > >> This information is valuable to both chip designers and system
> >>>      designers
> >>>       > >> as it helps to identify when there are problems with power
> >>>      consumption
> >>>       > >> over an s2idle cycle.
> >>>       > >>
> >>>       > >> To make the information discoverable, create a new sysfs file
> >>>      and a symbol
> >>>       > >> that drivers from supported manufacturers can use to advertise
> >>>      this
> >>>       > >> information. This file will only be exported when the system
> >>>      supports low
> >>>       > >> power idle in the ACPI table.
> >>>       > >>
> >>>       > >> In order to effectively use this information you will ideally
> >>>      want to
> >>>       > >> compare against the total duration of sleep, so export a
> >>>      second sysfs file
> >>>       > >> that will show total time. This file will be exported on all
> >>>      systems and
> >>>       > >> used both for s2idle and s3.
> >>>       > >
> >>>       > > Well, my first question would be how this is related to
> >>>       > >
> >>>       > > /sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us
> >>>       > >
> >>>       >
> >>>       > This has a dependency on the platform firmware offering an ACPI LPIT
> >>>       > table.  I don't know how common that is.
> >>>
> >>>      Required for running Windows with Modern Standby AFAICS.
> >>>
> >>>       > As this series started from the needs on ChromeOS I would ask is
> >>>      that typically populated by coreboot?
> >>>
> >>>      It should be, but I'd need to ask for confirmation.
> >>>
> >>>
> >>> It looks like Intel platforms have support for the LPIT table:
> >>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsource.chromium.org%2Fchromiumos%2Fchromiumos%2Fcodesearch%2F%2B%2Fmain%3Asrc%2Fthird_party%2Fcoreboot%2Fsrc%2Fsoc%2Fintel%2Fcommon%2Fblock%2Facpi%2Flpit.c%3Fq%3Df%3ALPIT%2520f%3Acoreboot%26ss%3Dchromiumos&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7C37e6dda56f924fe641f008dac7323c01%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638041315852648377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=PusftlebIMFtbaMy1XkBjHFMXLjdOzt7hA%2Fm3AM7v7A%3D&amp;reserved=0 <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsource.chromium.org%2Fchromiumos%2Fchromiumos%2Fcodesearch%2F%2B%2Fmain%3Asrc%2Fthird_party%2Fcoreboot%2Fsrc%2Fsoc%2Fintel%2Fcommon%2Fblock%2Facpi%2Flpit.c%3Fq%3Df%3ALPIT%2520f%3Acoreboot%26ss%3Dchromiumos&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7C37e6dda56f924fe641f008dac7323c01%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638041315852648377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=PusftlebIMFtbaMy1XkBjHFMXLjdOzt7hA%2Fm3AM7v7A%3D&amp;reserved=0>
> >>>
> >>> For AMD, we had some patches to add _LPIL
> >>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Freview.coreboot.org%2Fc%2Fcoreboot%2F%2B%2F52381%2F1&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7C37e6dda56f924fe641f008dac7323c01%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638041315852648377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=gUYdMWZBNVALF8Xzhgswlyw9hCUv7LQ6eomz6gfIYrk%3D&amp;reserved=0
> >>> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Freview.coreboot.org%2Fc%2Fcoreboot%2F%2B%2F52381%2F1&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7C37e6dda56f924fe641f008dac7323c01%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638041315852648377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=gUYdMWZBNVALF8Xzhgswlyw9hCUv7LQ6eomz6gfIYrk%3D&amp;reserved=0>
> >>> They never got merged though. We could add an LPIT table to coreboot for
> >>> AMD platforms if necessary.
> >>
> >> _LPI I don't think makes a lot of sense on X86 today, which is why this
> >> was sent up:
> >> eb087f305919e ("ACPI: processor idle: Check for architectural support
> >> for LPI")
> >
> > Well, LPI has nothing to do with LPIT.  [I guess this could not be
> > even more confusing, but that's what you get in the world of 4-letter
> > TLAs.]
> >
> >> As for LPIT - I've never seen LPIT on AMD UEFI systems either.  I guess
> >> it's an Intel specific table?
> >
> > It used to be.  The spec is UEFI-hosted now.
> >
>
> Got it.
>
> >>>
> >>>       > I would hope it's the same number that is populated in that file on
> >>>       > supported systems though.
> >>>
> >>>      Well, which is exactly where I'm going.
> >>>
> >>>      Since there is one sysfs file for exposing this value already and it
> >>>      is used (for example, by sleepgraph), perhaps the way to go would be
> >>>      to extend this interface to systems that don't have LPIT instead of
> >>>      introducing a new one possibly exposing the same value?
> >>>
> >>
> >> Ah; so since Raul confirmed coreboot on Chrome exports that maybe we
> >> just need to add another way to populate that sysfs file for systems
> >> without LPIT (IE AMD).  I think that's a very good idea; thanks.
> >>
> >> I think we still probably want to have a way to get the total suspend
> >> time out programmatically though to compare to.  So perhaps the other
> >> sysfs file I had in the RFC v2 makes sense still.
> >
> > Well there are trace points to get that (sleepgraph uses these too),
> > see Documentation/trace/events-power.rst (and you can git grep for
> > "machine_suspend" to find where this comes from).
> >
> > I guess there could be a sysfs file in addition to them, but I'm not
> > sure if the extra overhead would be worth the benefit.
>
> At least the way that I envisioned this all working was that userspace
> software that wanted to could query some sysfs files and figure out a
> percentage of time spent.  If it was below a threshold users could be
> notified, or logs can be sent up to a server for analysis etc.
>
> Trace points would mean that userspace software like systemd and powerd
> would need to turn on the tracing every time to get the raw total
> numbers to do such a comparison.

Fair enough, but there are quite some considerations to be made here
regarding what exactly is included in the "total sleep time" and how
to compare that with the residency value (note: this needs to work
cross-platform).
