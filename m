Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85C26A0798
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 12:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbjBWLnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 06:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjBWLnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 06:43:15 -0500
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19F91027B;
        Thu, 23 Feb 2023 03:43:13 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id b12so41008894edd.4;
        Thu, 23 Feb 2023 03:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=syapajUQQKPNTLxoBBob0wJRqUEzcQ+Vd9hvk03JOZ0=;
        b=69OLzTBIZbCWZsBHutrEtEVp08nh2JNsMfOvVXkCM9VxGqjxzU6023wvtqB0lJdyVs
         1pjoQj0hUm8dcV22kt3xJVytga/11JPiARZgFBXkSefOUYEdkmVRomM0R8fjJqFpz3VO
         52GoUw7T/8FJlons9IlVPap0femrcAyTvH2PuSumH+QJ+tLWcd7U6D4rZtr4DaVjzMMd
         /lQ1Zpg8QDGpw+qPaJEZMCnQP4Bw/Xa3nmpqOCwUiAYlcpZECaPe6wDoCW3lZKY/3N9H
         RFVKbFizQScVO/F/7/KvlsPdYm7oAgX9Q6ao4PXkvoZntSWC6FEnnnVryawFx8boBktj
         xisQ==
X-Gm-Message-State: AO0yUKUmuQXfNuvmImVbj0r3/UiiuqKM5kdqLdutLY4b+HJwaGaYS3I/
        DqNNmmpMMOVyTWbuTP+lx5Z/n81e7XUMNWOKizM=
X-Google-Smtp-Source: AK7set9CFmlLdErXJwKuzgfcUTyFMTlrdRel7rfmMsQpqyTEmDHe63bLhlD6rNr8FmT9Lzr1jLyJnQQZtkuVdISeGSw=
X-Received: by 2002:a17:907:7d8d:b0:8ad:d366:54c4 with SMTP id
 oz13-20020a1709077d8d00b008add36654c4mr11083740ejc.4.1677152592060; Thu, 23
 Feb 2023 03:43:12 -0800 (PST)
MIME-Version: 1.0
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
 <20230221180710.2781027-7-daniel.lezcano@linaro.org> <CAJZ5v0gTmi7ZeDDdHWGWju4m3bv2366oVqSP1dGOT+3jLV-jaw@mail.gmail.com>
 <0889767f-d187-0cb4-895e-c149517b6636@linaro.org> <CAJZ5v0h=UCOyJ88UgEdqch4NZK+DaT8jWnDaguQGNx-KOMhPPA@mail.gmail.com>
 <2b843912-cc9b-f1ac-1f81-28e3ecf8daba@linaro.org>
In-Reply-To: <2b843912-cc9b-f1ac-1f81-28e3ecf8daba@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Feb 2023 12:43:00 +0100
Message-ID: <CAJZ5v0g+fkX=ZUJ0MgENy2SmMv98wD0dApVwU352OS4ZXpDDCw@mail.gmail.com>
Subject: Re: [PATCH v2 06/16] thermal: Don't use 'device' internal thermal
 zone structure field
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Balsam CHIHI <bchihi@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 10:56 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 22/02/2023 21:06, Rafael J. Wysocki wrote:
> > On Wed, Feb 22, 2023 at 9:00 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 22/02/2023 20:43, Rafael J. Wysocki wrote:
> >>> On Tue, Feb 21, 2023 at 7:07 PM Daniel Lezcano
> >>> <daniel.lezcano@linaro.org> wrote:
> >>>>
> >>>> Some drivers are directly using the thermal zone's 'device' structure
> >>>> field.
> >>>>
> >>>> Use the driver device pointer instead of the thermal zone device when
> >>>> it is available.
> >>>>
> >>>> Remove the traces when they are duplicate with the traces in the core
> >>>> code.
> >>>>
> >>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>>> Reviewed-by: Balsam CHIHI <bchihi@baylibre.com> #Mediatek LVTS
> >>>> ---
> >>
> >> [ ... ]
> >>
> >>>>           thermal_zone_device_update(data->ti_thermal, THERMAL_EVENT_UNSPECIFIED);
> >>>>
> >>>> -       dev_dbg(&data->ti_thermal->device, "updated thermal zone %s\n",
> >>>> +       dev_dbg(data->bgp->dev, "updated thermal zone %s\n",
> >>>>                   data->ti_thermal->type);
> >>>
> >>> The code before the change is more consistent, because it refers to
> >>> the same object in both instances.
> >>>
> >>> It looks like a type field accessor is needed, eg. thermal_zone_device_type()?
> >>>
> >>> Or move the debug message to thermal_zone_device_update()?
> >>
> >> Actually it is done on purpose because the patch 9 replaces the accesses
> >> to 'type' by 'id', the thermal_zone_device_type() accessor won't be needed.
> >
> > Cool.
> >
> > However, this is a change in behavior (albeit small) which doesn't
> > appear to be necessary.
> >
> > What would be wrong with having a tz->type accessor too?
>
> I can add the 'type' accessor but from my point of view it is not
> correct because the information belongs to the thermal framework and it
> is used to export the information in the sysfs which is along with the
> directory name giving the id of the thermal zone.

I'm not sure what you mean here.

Surely, the 'type' is provided by whoever registers the thermal zone,
so I'm not sure in what way it "belongs" to the framework.

> Actually, the useful information is the id of the thermal zone, not the
> type. This one can be duplicate, for instance:
>
> cat /sys/class/thermal/thermal_zone*/type
> acpitz
> acpitz

That's correct, but in the particular case of DT-based systems it
comes from the DT (AFAICT) and so it allows to connect the kernel
message with the DT contents.  The id could be used for that, but that
involves an extra sysfs lookup.

> Given there are few places where 'type' is used in the drivers, I prefer
> to directly change that to 'id' in the next patch instead of creating
> the accessor for 'type', then send another series removing it.

So you are going to change the behavior of those few places with the
only reason being aesthetics AFAICS.  Is this really a good enough
reason to do that?
