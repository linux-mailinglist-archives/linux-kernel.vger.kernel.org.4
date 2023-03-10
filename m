Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A836B5429
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjCJWTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjCJWTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:19:37 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFF810E586
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:19:35 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id z10so3903599pgr.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678486775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvsKBaDtD3EgyaQ1Xn4Hp5jthv3TczAQ07c2Q2VYcmA=;
        b=EDcj9YtfpjXPb0sCaWDI/UU3RxulYbBu2xP+2ycNiJVm7/G3WPH9L5qAmIYXoX2pU4
         Rm4sHjPDjkt1x9fZJPlphxqIzTIYQlfQKt7WOsw1ucu6oqV1iU0Nxs9ChlotNB0h3Tae
         BqDqTtWIKPDko3VrjcuiXbrdEAdC0/yAiBm3xV3l0lXAnbmYfCzeF+GWJGIoSppy/Aw8
         UQrZeVZl3dUTBSekGJCCAV5V6Axfo+n4FLPzHSS142p0xWZY4vqIlDssGxt6Xh5mX1qk
         xJo+O+O6/9lkRewVEMYQlJH7V2shnYhk4Ma8XJT0/2jPD+vxPld7gGlP1DuJw1dtC2R3
         Go4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678486775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvsKBaDtD3EgyaQ1Xn4Hp5jthv3TczAQ07c2Q2VYcmA=;
        b=zvtZ663fuQlVFX05zQ0dWZtw8utgGtdgTSwRU+9qudNFQOEv92NTiJQGPGdEtURR1d
         pnB+jKiZz3wMM4yMqdP6wGTyT5TClAQkDVzh+zYc0hD8qua9/LgxLKlWBIaNNBqpyXwo
         FHF6WI8JZ8Px12asXj1Y2OOfO5BSDxzWQzlR3zx34WO9tG6auSoRXOFaKt8TF8CtqsWT
         TJ4qyLKM2ILoRR6VpAxIROfqgjaMx6DjxM7X1HAa6JtuduFBhIq9F1AP+11XTxuzvgM5
         4OAkuMg6aPJCY7XwiLWUjeuCycub9zsnwkdwrPYc5xVnCx5a6+kbjfeanFeZr1BAgzzm
         jgzg==
X-Gm-Message-State: AO0yUKU8UHRAOxIlmawky1RUu+PHrAtpPmAuVikP9gACtSFY0aKtXjZM
        ENjnz1MXe8mBJyMpZNFansjn+Z7TGyVOF0f17qHLKA==
X-Google-Smtp-Source: AK7set/USztulmyfgqBjR02RNa4Xnjc4nNPPs5JX1UrT5r/Ag+00Y+mH/CDAByF59LR1QkDW5SAWGfzqGZZDNhPswZ4=
X-Received: by 2002:a63:7356:0:b0:507:8088:9e0d with SMTP id
 d22-20020a637356000000b0050780889e0dmr3571131pgn.7.1678486774869; Fri, 10 Mar
 2023 14:19:34 -0800 (PST)
MIME-Version: 1.0
References: <20230301214952.2190757-1-saravanak@google.com>
 <2a8e407f4f18c9350f8629a2b5fa18673355b2ae.camel@puri.sm> <e65e08c13885468675af527ffa2ab882cc9e682d.camel@puri.sm>
 <CAGETcx93K1VjAosX9NDEyLVLPK2utPSUV6dwzdAT-Dc5BfmhzQ@mail.gmail.com> <4e8d00617de0c25dcf84847c3d3ad3f2d76ee5b9.camel@puri.sm>
In-Reply-To: <4e8d00617de0c25dcf84847c3d3ad3f2d76ee5b9.camel@puri.sm>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 10 Mar 2023 14:18:58 -0800
Message-ID: <CAGETcx_CDBf3eTgTkUCwYoyvXk4L7hJBDKj6rwow6k=EdbZpqA@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Remove use of fw_devlink_purge_absent_suppliers()
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 2:07=E2=80=AFAM Martin Kepplinger
<martin.kepplinger@puri.sm> wrote:
>
> Am Donnerstag, dem 09.03.2023 um 16:24 -0800 schrieb Saravana Kannan:
> > On Thu, Mar 2, 2023 at 1:41=E2=80=AFAM Martin Kepplinger
> > <martin.kepplinger@puri.sm> wrote:
> > >
> > > Am Donnerstag, dem 02.03.2023 um 10:12 +0100 schrieb Martin
> > > Kepplinger:
> > > > Am Mittwoch, dem 01.03.2023 um 13:49 -0800 schrieb Saravana
> > > > Kannan:
> > > > > Yongqin, Martin, Amelie,
> > > > >
> > > > > We recent refactor of fw_devlink that ends with commit
> > > > > fb42378dcc7f
> > > > > ("mtd: mtdpart: Don't create platform device that'll never
> > > > > probe"),
> > > > > fw_devlink is smarter and doesn't depend on compatible
> > > > > property.
> > > > > So,
> > > > > I
> > > > > don't think these calls are needed anymore. But I don't have
> > > > > these
> > > > > devices to test on and be sure and the hardware I use to test
> > > > > changes
> > > > > doesn't have this issue either.
> > > > >
> > > > > Can you please test these changes on the hardware where you hit
> > > > > the
> > > > > issue to make sure things work as expected?
> > > > >
> > > > > Yongqin, If you didn't have the context, this affected
> > > > > hikey960.
> > > > >
> > > > > Greg,
> > > > >
> > > > > Let's wait for some tests before we land these.
> > > > >
> > > > > Thanks,
> > > > > Saravana
> > > >
> > > > hi Sravana,
> > > >
> > > > I picked the 12 commits leading up to commit fb42378dcc7f ("mtd:
> > > > mtdpart: Don't create platform device that'll never probe") (
> > > > https://source.puri.sm/martin.kepplinger/linux-next/-/commits/test_=
fw_devlink
> > > > ) and included the tipd patch below to test it.
> > > >
> > > > With that, I get the following errors:
> > > >
> > > > [    0.237931] imx-uart 30890000.serial: Failed to create device
> > > > link
> > > > with regulator-gnss
> > > > [    0.334054] nwl-dsi 30a00000.mipi-dsi: Failed to create device
> > > > link
> > > > with regulator-lcd-1v8
> > > > [    0.346964] nwl-dsi 30a00000.mipi-dsi: Failed to create device
> > > > link
> > > > with backlight-dsi
> > > >
> > > > but they are independent of this final tipd patch below. I'll
> > > > test a
> > > > real linux-next tree soon, for completeness, maybe I missed
> > > > something?
> > > >
> > > > Anyways, on that tree, your tipd removal patch breaks type-c
> > > > still
> > > > for
> > > > me, imx8mq-librem5.dtsi
> > > >
> > > > just to give a first reply quickly... thanks,
> > > >
> > > >                              martin
> > > >
> > >
> > > just confirming: it's the same as above on next-20230302 + this
> > > patch (
> > > https://source.puri.sm/martin.kepplinger/linux-next/-/commits/test_fw=
_devlink_next-20230302
> > > ) with the errors already independent from the patch. I should have
> > > tested earlier patches -.-
> >
> > Thanks a lot for testing Martin!
> >
> > Your email is a little ambiguous to me. With the 12 refactor commits
> > +
> > the 4 patches in this series, things are breaking for you. But if you
> > drop the 4 patches in this series, things work again. Is that right?
>
> no. Sorry if I wasn't clear. I can't justify to block these 4 patches.
> they *themselves* don't break anything.
>
> Something broke *earlier* than these 4 patches in one of the other 12.

If you find out it's one of the other 12 patches in the refactor that
broke things for you, can you please reply to the right email in that
series[1] and let me know which patch broke things for you and provide
the debug details there? I don't want to mix issues with unrelated
threads -- I want them to be easy to find in the future.

[1] -  https://lore.kernel.org/lkml/20230207014207.1678715-1-saravanak@goog=
le.com/

For all my questions below, you don't need to reply here. Just reply
to the right thread.

> As to *what* broke: The error messages during boot,

The error messages, is it anything other than the "Failed to create
device link"?

> and the charger and
> fuel gauge don't work anymore, I see:
>
> # cat /sys/kernel/debug/devices_deferred
> 3-0036  max17042: failed: power supply register
> 0-003f

This seems to be the main culprit. That 0-003f isn't probing. It's
surprising that the reason is empty too. IIRC that means it didn't do
deferred probing, but rather failed with an error. Wild guess .... Try
increasing the deferred_probe_timeout to see if it helps?

> 38100000.usb    platform: wait for supplier endpoint
> 32c00000.hdmi   platform: supplier 0-003f not ready
> 3-006a  bq25890-charger: registering power supply
>
>
> I haven't had time to track it down and see where the issue is. Could
> be one of the 12 patches, could be a wrong description for my board:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
> or something else (an i2c issue?).
>
> (for completeness, the exact tree I ran:
> https://source.puri.sm/martin.kepplinger/linux-next/-/commits/test_fw_dev=
link
> )
>
> >
> > Let's ignore the "Failed to create device link" errors for now --
> > it's
> > not related to this usb-c-connector series. It's basically pointing
> > out issues that we ignored silently in the past -- it's basically
> > pointing out holes in fw_devlink's visibility of devices. I'll get to
> > them later.
>
> ok. good to know. please do.

Here's a fix for the Failed to create device link issues.
https://lore.kernel.org/lkml/20230310063910.2474472-1-saravanak@google.com/

> And since I'm the only one seeing an issue, please move the patches
> forward. I'll need to fix this after the fact and hope to have time for
> it next week.

I'd rather wait for you than rush these patches in. The patches are
just removing what I expect to be cruft. I'd rather confirm that first
than break anything.

-Saravana
