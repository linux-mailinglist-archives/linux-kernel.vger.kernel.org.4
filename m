Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35F374F2D2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjGKOz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjGKOz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:55:56 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E63EE5C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:55:52 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-345df4e68afso22490785ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689087351; x=1691679351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NOHj/qmcYw6nskkjE8RKDb9CPghG0QuzHmlycmErO7k=;
        b=UAqGemQ5+fR3NqE1iuHNZOYmiRCYtr+lfFL/vlAa543KS13WS3iNlyK260KwuyvrJQ
         oDQLBIWWtOAGxsz1EPlMPeNGOdAUixriKE2ItDSySz8c0lU+mLjKVsYDAcGWhwK8/CkS
         7PiX/dORprzdKayTOhfCChPNll0xVQ08X3v/mkcbzQGA6cPo7/KuIBTGyC1CpB6xCFm0
         F2EiqxlHeQnMw6DnvmXGIUyyjyAYvNUWlZWoYooym3r3QsguLK64Pqsdgz+aoWy9hyFu
         UTUsFzNW9YnuvSxDab/nBF9V/lzVJU+/kJNw2dUz2+6qfFjugcTqHOCpQj6H2YjqcVvl
         oFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689087351; x=1691679351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOHj/qmcYw6nskkjE8RKDb9CPghG0QuzHmlycmErO7k=;
        b=K5x326s+yY/w8GGrePT0VSL6JN0IsoSBqLLwAWslwF9cHaS+Nrbw0aKlL9Ap8XIga+
         ine4Kf2bR1DnO1BvBLOyX1G6JjvZlHG9XvNvveKYO0lA8/ioPS/jw4km6sMMy+Qajc3w
         r2iEp40BJ5MH9U2mFplbaGgmq6gdEF4uTer3RgBL+YKPDMnUuNQvV5ILz4D+K1dKF2vN
         4oWV34khEAOkTwoOlK3z3mb/vSJ2JIrYzPefoyqSdQXAFHOccDagOFsx+0nLaJV97Fyq
         ojWqyeM0ikHaqdjg6u9uBfOCOpL1rUt6k4yyi8lbuoi/6rtZwrp1ObMLzB7zQUoURRH8
         Ol3w==
X-Gm-Message-State: ABy/qLatT2UkNLdkdnxM/wOdwT8dpY9oyiDowcPR+ix81+Wp7J9e5sYt
        1FNJRKgy1GvULTX1LZMmYgB0d4c6yVD07GdMOpXyow==
X-Google-Smtp-Source: APBJJlF+eJdBZOlOB49QOJ5FpF5SkOggxkdoD6E1mtnuZ4LSL2JTrp8Pbfbcny9ON0zp5Ijoyl87nE15mEOaswTpBSA=
X-Received: by 2002:a92:da86:0:b0:346:6dc2:997b with SMTP id
 u6-20020a92da86000000b003466dc2997bmr2950323iln.23.1689087351401; Tue, 11 Jul
 2023 07:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230710162724.827833-1-Naresh.Solanki@9elements.com> <1f4c500b-e706-a090-516d-992b68f44f0d@roeck-us.net>
In-Reply-To: <1f4c500b-e706-a090-516d-992b68f44f0d@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Tue, 11 Jul 2023 16:55:39 +0200
Message-ID: <CABqG17jU8HYzOx=OCH6=shJo37MZWRBPydOQsrnDBk3xNaQE5w@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (peci/cputemp) Add Intel Sapphire Rapids support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Mon, 10 Jul 2023 at 19:43, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 7/10/23 09:27, Naresh Solanki wrote:
> > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> >
> > Add support to read DTS for reading Intel Sapphire Rapids platform.
> >
> > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>
> This patch touches code outside the hwmon subsystem, so I won't be able
> to apply it without Ack from a maintainer.
Yes.  I'll split the patch & resubmit.
~Naresh
>
> Guenter
>
> > ---
> >   drivers/hwmon/peci/cputemp.c | 18 ++++++++++++++++++
> >   drivers/peci/cpu.c           |  5 +++++
> >   2 files changed, 23 insertions(+)
> >
> > diff --git a/drivers/hwmon/peci/cputemp.c b/drivers/hwmon/peci/cputemp.c
> > index e5b65a382772..a812c15948d9 100644
> > --- a/drivers/hwmon/peci/cputemp.c
> > +++ b/drivers/hwmon/peci/cputemp.c
> > @@ -363,6 +363,7 @@ static int init_core_mask(struct peci_cputemp *priv)
> >       switch (peci_dev->info.model) {
> >       case INTEL_FAM6_ICELAKE_X:
> >       case INTEL_FAM6_ICELAKE_D:
> > +     case INTEL_FAM6_SAPPHIRERAPIDS_X:
> >               ret = peci_ep_pci_local_read(peci_dev, 0, reg->bus, reg->dev,
> >                                            reg->func, reg->offset + 4, &data);
> >               if (ret)
> > @@ -531,6 +532,13 @@ static struct resolved_cores_reg resolved_cores_reg_icx = {
> >       .offset = 0xd0,
> >   };
> >
> > +static struct resolved_cores_reg resolved_cores_reg_spr = {
> > +     .bus = 31,
> > +     .dev = 30,
> > +     .func = 6,
> > +     .offset = 0x80,
> > +};
> > +
> >   static const struct cpu_info cpu_hsx = {
> >       .reg            = &resolved_cores_reg_hsx,
> >       .min_peci_revision = 0x33,
> > @@ -549,6 +557,12 @@ static const struct cpu_info cpu_icx = {
> >       .thermal_margin_to_millidegree = &dts_ten_dot_six_to_millidegree,
> >   };
> >
> > +static const struct cpu_info cpu_spr = {
> > +     .reg            = &resolved_cores_reg_spr,
> > +     .min_peci_revision = 0x40,
> > +     .thermal_margin_to_millidegree = &dts_ten_dot_six_to_millidegree,
> > +};
> > +
> >   static const struct auxiliary_device_id peci_cputemp_ids[] = {
> >       {
> >               .name = "peci_cpu.cputemp.hsx",
> > @@ -574,6 +588,10 @@ static const struct auxiliary_device_id peci_cputemp_ids[] = {
> >               .name = "peci_cpu.cputemp.icxd",
> >               .driver_data = (kernel_ulong_t)&cpu_icx,
> >       },
> > +     {
> > +             .name = "peci_cpu.cputemp.spr",
> > +             .driver_data = (kernel_ulong_t)&cpu_spr,
> > +     },
> >       { }
> >   };
> >   MODULE_DEVICE_TABLE(auxiliary, peci_cputemp_ids);
> > diff --git a/drivers/peci/cpu.c b/drivers/peci/cpu.c
> > index de4a7b3e5966..3668a908d259 100644
> > --- a/drivers/peci/cpu.c
> > +++ b/drivers/peci/cpu.c
> > @@ -318,6 +318,11 @@ static const struct peci_device_id peci_cpu_device_ids[] = {
> >               .model  = INTEL_FAM6_ICELAKE_X,
> >               .data   = "icx",
> >       },
> > +     { /* Sapphire Rapids Xeon */
> > +             .family = 6,
> > +             .model  = INTEL_FAM6_SAPPHIRERAPIDS_X,
> > +             .data   = "spr",
> > +     },
> >       { /* Icelake Xeon D */
> >               .family = 6,
> >               .model  = INTEL_FAM6_ICELAKE_D,
> >
> > base-commit: 4dbbaf8fbdbd13adc80731b2452257857e4c2d8b
>
