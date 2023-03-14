Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5256B9BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjCNQg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjCNQgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:36:10 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F10B6911
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:35:43 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id r4so2948197ilt.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678811742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApsQvwPpKOH6tJA3sPlEE18fDN0OorqnVlX4IZOYXXE=;
        b=goUpJfLeAxzj1G9nxeSaTpQJK+9CdcLJ+cN1A5h0+/DUnzF0NMU+936wxOiPsWWM61
         EzcuQrlia9nWIUOBnx8NHy+t0+zeFY8XAB/iB8wUDx6eoeyMLjCgo1254/CVRkv9JjmD
         Zb6+aVK9wELqz9R8iqDW+kE+isMjV2f1VBSIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678811742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApsQvwPpKOH6tJA3sPlEE18fDN0OorqnVlX4IZOYXXE=;
        b=QzehrUzwqljOgIMJoMXXqiYzR/T0PWS+VK86iUFovSXkF7hVdoVtPP5bBVsfTPy2JS
         gvMJcobedmMKBTHAGKNWDVB1JIwJ51xUcEdKuweu5+Pn5hBMIfcsKrDwK7aXRJ1hiBKe
         ZyHDnl+wcjs4JMnwULTvXb3ekWb64GUt1CBv1U9bgoeGzqcZBOeoLu4IL3DDIdK7D54l
         8pyhhCluV8HOp04W+EZSEhs7MB8oK64QcQZQMd8rGBJXj/XXbJ9q2TttiYg3rVra50Me
         Eqj3jjj/C3PMoVb8baGVzsNqCdnu5ayXCb5HmozHEdViIR3TeLrS4QBnDjvcZpwxr7a4
         n+0Q==
X-Gm-Message-State: AO0yUKXGxnLnD9B+sn8V0227tljUx9c+oOdlM8juBes/rYWwRDB/rozC
        NryL2juBXnPUf5GJP/UqU+9P92qdz3b0OfWnLko=
X-Google-Smtp-Source: AK7set9d9smdJpSZgBrUv9iOsiqM5UrPuT2YE0CSzQNLH3LuKYOTM+cq9O7D3IHAJCIIpiWJR9LYQQ==
X-Received: by 2002:a92:d1c3:0:b0:318:d56e:9efa with SMTP id u3-20020a92d1c3000000b00318d56e9efamr2739582ilg.24.1678811742033;
        Tue, 14 Mar 2023 09:35:42 -0700 (PDT)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id x19-20020a029713000000b0039ea34dffcdsm916063jai.129.2023.03.14.09.35.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 09:35:41 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id v10so135297iol.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:35:40 -0700 (PDT)
X-Received: by 2002:a6b:fd0d:0:b0:745:6b06:6736 with SMTP id
 c13-20020a6bfd0d000000b007456b066736mr17295940ioi.1.1678811740525; Tue, 14
 Mar 2023 09:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230313181820.2482385-1-dianders@chromium.org>
 <20230313111806.2.Iee214b2dd184cb19197db8f97fad7e4adca273be@changeid>
 <89bf362b-6c63-447a-ad4b-91385bf26dab@sirena.org.uk> <CAD=FV=XWaWfDy+ZFjwq6hK4ssTtGjxRePzF2DooMAOg3fziZvw@mail.gmail.com>
 <f76b82ef-bece-4eee-8711-ceb2f77b1c6f@sirena.org.uk>
In-Reply-To: <f76b82ef-bece-4eee-8711-ceb2f77b1c6f@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Mar 2023 09:35:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xtrka6tyJNfeZkPgNUDED2+ZJG06f4e_AP3RO1PdLfJA@mail.gmail.com>
Message-ID: <CAD=FV=Xtrka6tyJNfeZkPgNUDED2+ZJG06f4e_AP3RO1PdLfJA@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: fixed: Set PROBE_PREFER_ASYNCHRONOUS
To:     Mark Brown <broonie@kernel.org>
Cc:     mka@chromium.org, christian@kohlschutter.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 14, 2023 at 6:29=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Mon, Mar 13, 2023 at 12:49:37PM -0700, Doug Anderson wrote:
> > On Mon, Mar 13, 2023 at 12:05=E2=80=AFPM Mark Brown <broonie@kernel.org=
> wrote:
>
> > > This is going to be true for all regulators...
>
> > Sure, that's true. So what are you suggesting?
>
> That we shouldn't be making this change for just one driver, if you can
> write an identical commit log for most if not all drivers but are just
> making the change for one random driver then that suggests something is
> being missed somewhere.  Either there's something special about this
> driver or we should do things consistently.

The "special" things are:

* It's been confirmed that this one random driver is involved in
slowing down boot a significant amount.

* The fixed regulator driver is among the simplest of the regulators
and doesn't have the complex interactions that are typically
associated with async probe problems.

For reference, some of the problems I'm aware of that have been seen
in the past when trying to enable async probe more broadly:

a) Apparently, on ACPI child devices aren't guaranteed to be probed
before parent devices once you turn on async probe. This is not
typically the case with device-tree probed devices where children show
up due to of_platform_populate() which is called by a parent device.
This can be handled properly but often isn't.

b) Some drivers try to poke directly at other devices and can get
confused if the other device is probing at the same time. One example
was dual-MIPI on Rockchip [1]. Again, this can be handled properly but
often isn't because nobody tested it.

c) Dynamically allocated ID numbers can change unpredictably from boot
to boot with async probe. This showed up on MMC where eMMC and SD
would change each boot between "mmcblk0" and "mmcblk1".

d) Async probe (obviously) changes timing and that can expose latent
bugs. Almost always those bugs should have been fixed anyway.

e) Async probe tends to stress out other driver's (consumers of the
device that's now probing async) error handling (since they are more
likely to see -EPROBE_DEFER) and can expose latent bugs there.


Let's take an example that I have a tiny bit of familiarity with:
max77686. This is not too strange of a device. It's implemented as a
MFD and has sub-drivers for PMIC (regulator), RTC, and clock.

I think we can be pretty confident that a) above isn't a problem. The
MFD driver (the parent) populates the regulator (the child) with
devm_mfd_add_devices() and it won't do that until the (MFD) parent is
ready. So far so good.

I think we can also be fairly certain that c) isn't a problem, and
probably it's not a problem anywhere for regulators. Nobody (that I'm
aware of) relies on the stability of a dynamically allocated number
for a regulator.

Issues d) and e) could be an issue for max77686, but in almost all
cases where they are we'd want to fix those latent bugs anyway since
they could have hit even without async probe.

...but b) _could_ be a problem. Specifically, today I think that
(unless some of its supplies aren't available at probe time) the PMIC
driver will _always_ finish probing before the RTC/clock driver
because of the order specified in the source code:

  { .name =3D "max77686-pmic", },
  { .name =3D "max77686-rtc", },
  { .name =3D "max77686-clk", },

One would need to do deeper code inspection (and, ideally, testing) to
find out if indeed the RTC driver and clock driver will have problems
if the regulator is not finished probing before their probes start.
Hopefully everything here is fine, but it's the kind of place where
maybe somebody was sloppy because, today, the order is guaranteed. In
general drivers for multi-function devices are more likely to interact
directly with sibling drivers outside of the normal driver framework
and (in my experience) are more likely to be relying on probe order.

If someone wanted to carefully inspect the max77686 code (especially
the interactions between all the MFD sub-drivers) and test enabling
async probe there then it would be a nice improvement. ...switching
over and crossing our fingers might work OK but it also might not.


If we look at the fixed regulator driver and compare, we're in a
simpler state. Sure, we could still expose latent timing bugs or
latent wrong error handling in regulator consumers, but those should
be fixed anyway. The fixed regulator driver doesn't reach directly
into other devices through private APIs and pretty much just relies on
the regulator core for most of its work. The regulator core should be
async-robust because of needing to deal with regulators that show up
as modules.


I guess the last thing I'll say is that PROBE_PREFER_ASYNCHRONOUS was
added specifically so that we could enable this on drivers that were
found to be slow to boot and that were tested to work with async
probe. Without being able to add PROBE_PREFER_ASYNCHRONOUS people were
open-coding solutions per driver to speed probe.


[1] https://lore.kernel.org/r/20221019170255.2.I6b985b0ca372b7e35c6d9ea970b=
24bcb262d4fc1@changeid
