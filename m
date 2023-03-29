Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0591F6CD7FD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjC2K4D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 06:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjC2K4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:56:02 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4601FDA;
        Wed, 29 Mar 2023 03:56:01 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id eh3so61360827edb.11;
        Wed, 29 Mar 2023 03:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680087360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60MFOnOMzhKutMqhUhC/XDEFJcDrJox6s7Cc5/xbTOU=;
        b=5/wgTTYLagH3fdNOkK/D2Nd11ZF1NXbr9JqTn7w6nGi0QZRRrhF45yF5rfB9Ap3C5C
         veB729RXyJtd9Pv/6p/mDL0kbyyI8KFQesBcCDTvFKdSAEYvGrFxVRIc1a/VOLSAxbaw
         M8A1HunOHfsFyrdj6xXBYnLrvE0IrLfpvaA6QNfK1ZkBNqx7/saWT/7ZN4cdVMdvG3EA
         NhTOV+mxQO8mkIw+hFbeDBZ89udO8uLZdELudyv0EBlxPN6tk5/WmyujddBNPszR3tw2
         BnY4y2pLwcgm3MmA4J25ooVCeMUGm0FBkrmJ4M22t7CMza+k3/fCDdDJdj3QiEsFDcs6
         WQXw==
X-Gm-Message-State: AAQBX9cbMFWbNWvmliZdAG+/wtqZZAX3D4hxmoG23cYYAQdYa+AZKT8F
        liq1fgCSZagrUMujm1PCoi4MmiEpL+ASkoC/kh0=
X-Google-Smtp-Source: AKy350ZroOYiUyj3bHI+fbjU8MrFNJ7zh+fyN1BgN6AQd9U5ZmfpZPI7EkeJLNi2YORdQgB+WBGrPaY0bXYwl15FyL0=
X-Received: by 2002:a17:907:160e:b0:946:a095:b314 with SMTP id
 hb14-20020a170907160e00b00946a095b314mr3284928ejc.2.1680087359772; Wed, 29
 Mar 2023 03:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230329090055.7537-1-rui.zhang@intel.com> <08aee7fe-eddc-7841-2539-16ae43fd8d66@linaro.org>
In-Reply-To: <08aee7fe-eddc-7841-2539-16ae43fd8d66@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Mar 2023 12:55:47 +0200
Message-ID: <CAJZ5v0hasj4-XmWTGPehqQFW91WG+n5LgEhMp=ziXL=C7mv9nQ@mail.gmail.com>
Subject: Re: [PATCH -next] thermal/drivers/thermal_hwmon: Fix a kernel NULL
 pointer dereference
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org
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

On Wed, Mar 29, 2023 at 11:57 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 29/03/2023 11:00, Zhang Rui wrote:
> > When the hwmon device node of a thermal zone device is not found,
> > using hwmon->device causes a kernel NULL pointer dereference.
> >
> > Reported-by: Preble Adam C <adam.c.preble@intel.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> > Fixes: dec07d399cc8 ("thermal: Don't use 'device' internal thermal zone structure field")
> > dec07d399cc8 is a commit in the linux-next branch of linux-pm repo.
> > I'm not sure if the Fix tag applies to such commit or not.
>
> Actually it reverts the work done to encapsulate the thermal zone device
> structure.
>
> > ---
> >   drivers/thermal/thermal_hwmon.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
> > index c59db17dddd6..261743f461be 100644
> > --- a/drivers/thermal/thermal_hwmon.c
> > +++ b/drivers/thermal/thermal_hwmon.c
> > @@ -229,7 +229,7 @@ void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
> >       hwmon = thermal_hwmon_lookup_by_type(tz);
> >       if (unlikely(!hwmon)) {
> >               /* Should never happen... */
> > -             dev_dbg(hwmon->device, "hwmon device lookup failed!\n");
> > +             dev_dbg(&tz->device, "hwmon device lookup failed!\n");
>
> As it 'Should never happen', I would replace that by:
>
>         if (WARN_ON(!hwmon))
>                 /* Should never happen... */
>                 return;
>

Or just use pr_debug() instead of dev_dbg().

>
> >               return;
> >       }
> >
