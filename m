Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7044D6CD904
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjC2MBW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 08:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjC2MBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:01:20 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AB5EA;
        Wed, 29 Mar 2023 05:01:19 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id b20so62235563edd.1;
        Wed, 29 Mar 2023 05:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680091278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiCrbsp6PX3orS6Usf/w3A1cmbB/1aAzcIibJJyJkDQ=;
        b=qRYRdWofSOWykGGhZRvyeMI2s/bd3eilTUqI72OjJmjeTSKC6e3G871vTM1UnZnznz
         +OcWMmzwErKGvxEP263qMlo7p/f9P7ZwyBsmeHlxFDX8/CyOZbvmzHY1srajsZe/AbZ5
         iG0KIH/w4CfcdpUfCNHjtfxfBwi27eIO+z4IFHyTfVK94FWq87JtRcKnxG8R310DkgwL
         HM01v8ko/ZKGM3VhLo2btr9MR7EcpfBU8ICKRs/E1niJdpJlNluktwAraxQ5YvaeFMqk
         482taYql/fId7StrUnu0p05GvXCvnnCPeE/jWFa7UwlzFPKL7fyS57oZZFJm2ILXa47H
         OZQw==
X-Gm-Message-State: AAQBX9crRATsAKnegWSiFBoIDWb4IbfxGViqiRQ4xLYHEbktMQgisne4
        70I95l0ylMVG0D7fO0UO3O/3twj9nbohpQnOSaQ=
X-Google-Smtp-Source: AKy350YLwPPG3HzwCJK0wyrGDTPodFs/Gz6f9JQdfVse6ZXLG2XwO5wwfntU+A3uFYgfBhtpi7PqrVyaLdRSxhKJ4QI=
X-Received: by 2002:a17:906:5fca:b0:930:310:abcf with SMTP id
 k10-20020a1709065fca00b009300310abcfmr9625484ejv.2.1680091277922; Wed, 29 Mar
 2023 05:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230329090055.7537-1-rui.zhang@intel.com> <08aee7fe-eddc-7841-2539-16ae43fd8d66@linaro.org>
 <794b4b0eb6a0181b5e01f17e720a56e5ffaaf2e9.camel@intel.com>
In-Reply-To: <794b4b0eb6a0181b5e01f17e720a56e5ffaaf2e9.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Mar 2023 14:01:06 +0200
Message-ID: <CAJZ5v0g=2L1s=uNKoo+-KAV_rU=-XetrLhi50HLVGTTqiKefng@mail.gmail.com>
Subject: Re: [PATCH -next] thermal/drivers/thermal_hwmon: Fix a kernel NULL
 pointer dereference
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Wed, Mar 29, 2023 at 1:24 PM Zhang, Rui <rui.zhang@intel.com> wrote:
>
> On Wed, 2023-03-29 at 11:57 +0200, Daniel Lezcano wrote:
> > On 29/03/2023 11:00, Zhang Rui wrote:
> > > When the hwmon device node of a thermal zone device is not found,
> > > using hwmon->device causes a kernel NULL pointer dereference.
> > >
> > > Reported-by: Preble Adam C <adam.c.preble@intel.com>
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > ---
> > > Fixes: dec07d399cc8 ("thermal: Don't use 'device' internal thermal
> > > zone structure field")
> > > dec07d399cc8 is a commit in the linux-next branch of linux-pm repo.
> > > I'm not sure if the Fix tag applies to such commit or not.
> >
> > Actually it reverts the work done to encapsulate the thermal zone
> > device
> > structure.
> >
> > > ---
> > >   drivers/thermal/thermal_hwmon.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/thermal/thermal_hwmon.c
> > > b/drivers/thermal/thermal_hwmon.c
> > > index c59db17dddd6..261743f461be 100644
> > > --- a/drivers/thermal/thermal_hwmon.c
> > > +++ b/drivers/thermal/thermal_hwmon.c
> > > @@ -229,7 +229,7 @@ void thermal_remove_hwmon_sysfs(struct
> > > thermal_zone_device *tz)
> > >     hwmon = thermal_hwmon_lookup_by_type(tz);
> > >     if (unlikely(!hwmon)) {
> > >             /* Should never happen... */
> > > -           dev_dbg(hwmon->device, "hwmon device lookup
> > > failed!\n");
> > > +           dev_dbg(&tz->device, "hwmon device lookup failed!\n");
> >
> > As it 'Should never happen', I would replace that by:
> >
> >       if (WARN_ON(!hwmon))
> >               /* Should never happen... */
> >               return;
>
> Actually, the comment is wrong.
>
> For thermal zones with tzp->no_hwmon set, this is always true.
>
> We should add an extra check for that.

OK, can you please send a patch fixing all this mess?
