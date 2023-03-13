Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488756B80F4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjCMSnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjCMSnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:43:14 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5F484F79
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:42:48 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id t4so12958773ybg.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678732947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hc4qD0dBROAsSu6VxDvfykn2MYkacMKgknIXt+XjvfU=;
        b=saN7elFeQznmtibfBOSiIjhNuxMhg6FimCIcq7r61bXo9mayiTUp8DD1+iJU3EYbku
         GbAGT2GRb4pp97mkR59CDQm7f0/WR08TKmAQ27JQCQtUrvvsDirBdCLyeNOouJ7YPLvx
         Fc2bQ+Aym34eOGQeZnPM4vp4Sf6J+XX6cpaYCyH+3SW+b8zMfVRCdBXu/nSSSVoSYrr9
         eOcnpfaYqgqMFPDFPOJaGwMiZNUD9qT+p3SVy/cxflC2BF1zYKq0XgMD03ITU1yaurZq
         PWtFPq6B5fAt8O2VK5uha7qGmM6sUWOU43l534/ddSPiElS377MFfIcVGvEnHfDQA2F0
         qo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678732947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hc4qD0dBROAsSu6VxDvfykn2MYkacMKgknIXt+XjvfU=;
        b=3PROCzLz7W7hffyk5nv6+Tl3jvH/ec8Qco4+t1Lsw1JrqSE5VScCDrezEi4b6RJ7Ll
         0SXEkDJ/OLhOtmIoD5zgh68QN35Q/N8q2w04QwdjfsrxaE8JnjQjyiPztGaw++ajhrUD
         PniS/qEsv6s/FK+2aLphD4qBwaDgYMpLfsvDJeTRTAS9TuU4BAdkkA7h1GCfHG6f+Ti0
         0sWKvjyxHrLmcF9uFXPc6DRwo2cYnjsst7aCcMSpQFxHKPCrUByZQfrZTpHtPbN183lx
         o2sgLsB9VlvI55w3Qt9frFr0iWyK1sbluR7tpT5L+qnCNdA0tZ7UfCH8Dp9KmaGrhWtq
         /NWA==
X-Gm-Message-State: AO0yUKVe6AR+cBc0Xyhsf9IsaC3IpqHNB0A6MsIeSxYj1SBItH6mTL3Q
        gG1E7NtqyEq7dux8bPIheJftp6gRKuwLdDR5GJbMnQ==
X-Google-Smtp-Source: AK7set+75k/6wpJlLHYeLR6WsdbBWu8a19iQ5MMCLCjF+dE6M/z3ppb7dxMGbQzvpWjm9q+hhYVvtEFgNX9klTn9usU=
X-Received: by 2002:a05:6902:cf:b0:a02:a44e:585c with SMTP id
 i15-20020a05690200cf00b00a02a44e585cmr21945010ybs.1.1678732947713; Mon, 13
 Mar 2023 11:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230301214952.2190757-1-saravanak@google.com>
 <CAGETcx_DTHW4-WMK4qRhvhxiunUB2f79cpXSfQ1x-hifZQ+tgw@mail.gmail.com>
 <CAMSo37XuNaV4Y3+ExrUjNzPDRD_BNSn1258Ve3We+qtbsO7qEw@mail.gmail.com> <CAGETcx8qKCNuD5p=e-f-T93VstptPWHq2gVzmghkQucNyhwocA@mail.gmail.com>
In-Reply-To: <CAGETcx8qKCNuD5p=e-f-T93VstptPWHq2gVzmghkQucNyhwocA@mail.gmail.com>
From:   Yongqin Liu <yongqin.liu@linaro.org>
Date:   Tue, 14 Mar 2023 02:42:16 +0800
Message-ID: <CAMSo37UyDWB5dfTo91Y_de3de1gYActdKj4fsu==eW90kuHjyw@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Remove use of fw_devlink_purge_absent_suppliers()
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Saravana

On Fri, 10 Mar 2023 at 08:17, Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Mar 9, 2023 at 10:53=E2=80=AFAM Yongqin Liu <yongqin.liu@linaro.o=
rg> wrote:
> >
> > Hi, Saravana
> >
> > Sorry for the lateness, I was just aware of this today.
>
> No worries.
>
> > I tested with the ACK android-mainline branch + the 12 commits ending
> > with fb42378dcc7f
> > + the 4 commits of this series + hikey960 AOSP Master userspace.
> > The hikey960 Android build could boot to the home screen, no stuck ther=
e,
>
> Thanks for testing! Can you confirm what happens if you drop the "12
> commits ending with fb42378dcc7f" ? Does it get stuck at boot or have
> some limited functionality?

I tried to only apply the 4 commits of this series, but that would cause bu=
ild
error as the commit here:
https://lore.kernel.org/all/20210205222644.2357303-2-saravanak@google.com/

so I need to apply the first commit of the "12 commits ending with fb42378d=
cc7f"
here as well:
https://lore.kernel.org/all/20230207014207.1678715-2-saravanak@google.com/

With the 5 commits applied on the android-mainline branch, the build could =
boot
to the home screen, but the adb connection could not be created.
For details please check here https://termbin.com/wf9hj.

Thanks,
Yongqin Liu
>
> It's surprising that for the same type of DT node, in your case
> fw_devlink is able to handle it
> correctly, but no so for Martin's case.
>
> -Saravana
>
> >
> > Here is the link of the logat in case you want to check some message he=
re:
> > https://gist.github.com/liuyq/6525af08c547cd2e494af5d1c8b181b5
> >
> > Thanks,
> > Yongqin Liu
> > On Fri, 10 Mar 2023 at 02:05, Saravana Kannan <saravanak@google.com> wr=
ote:
> > >
> > > Greg,
> > >
> > > Don't pull in this series please. It needs more testing from the folk=
s
> > > I cc'ed and it's already breaking things for Martin. This needs more
> > > revisions.
> > >
> > > -Saravana
> > >
> > > On Wed, Mar 1, 2023 at 1:49=E2=80=AFPM Saravana Kannan <saravanak@goo=
gle.com> wrote:
> > > >
> > > > Yongqin, Martin, Amelie,
> > > >
> > > > We recent refactor of fw_devlink that ends with commit fb42378dcc7f
> > > > ("mtd: mtdpart: Don't create platform device that'll never probe"),
> > > > fw_devlink is smarter and doesn't depend on compatible property. So=
, I
> > > > don't think these calls are needed anymore. But I don't have these
> > > > devices to test on and be sure and the hardware I use to test chang=
es
> > > > doesn't have this issue either.
> > > >
> > > > Can you please test these changes on the hardware where you hit the
> > > > issue to make sure things work as expected?
> > > >
> > > > Yongqin, If you didn't have the context, this affected hikey960.
> > > >
> > > > Greg,
> > > >
> > > > Let's wait for some tests before we land these.
> > > >
> > > > Thanks,
> > > > Saravana
> > > >
> > > > Cc: Yongqin Liu <yongqin.liu@linaro.org>
> > > > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > > > Cc: Martin Kepplinger <martin.kepplinger@puri.sm>
> > > > Cc: Amelie Delaunay <amelie.delaunay@foss.st.com>
> > > >
> > > > Saravana Kannan (4):
> > > >   usb: typec: stusb160x: Remove use of
> > > >     fw_devlink_purge_absent_suppliers()
> > > >   usb: typec: tipd: Remove use of fw_devlink_purge_absent_suppliers=
()
> > > >   usb: typec: tcpm: Remove use of fw_devlink_purge_absent_suppliers=
()
> > > >   driver core: Delete fw_devlink_purge_absent_suppliers()
> > > >
> > > >  drivers/base/core.c           | 16 ----------------
> > > >  drivers/usb/typec/stusb160x.c |  9 ---------
> > > >  drivers/usb/typec/tcpm/tcpm.c |  9 ---------
> > > >  drivers/usb/typec/tipd/core.c |  9 ---------
> > > >  include/linux/fwnode.h        |  1 -
> > > >  5 files changed, 44 deletions(-)
> > > >
> > > > --
> > > > 2.39.2.722.g9855ee24e9-goog
> > > >
> >
> >
> >
> > --
> > Best Regards,
> > Yongqin Liu
> > ---------------------------------------------------------------
> > #mailing list
> > linaro-android@lists.linaro.org
> > http://lists.linaro.org/mailman/listinfo/linaro-android



--
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android
