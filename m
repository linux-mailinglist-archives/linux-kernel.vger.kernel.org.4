Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FFC6CD91C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjC2MHI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 08:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjC2MHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:07:05 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018354EDC;
        Wed, 29 Mar 2023 05:06:49 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id ek18so62284488edb.6;
        Wed, 29 Mar 2023 05:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680091605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBKTbYlgw1SWLsizAbyAtonV/EpLz0QgLlpYGjBRVus=;
        b=QKkbD/d+pHU3WigOE8TdfQbxCJtb9jW9qDBNgkL2Wwx9KZOTJaBE44DWC5QgqJg63m
         T2PxeC43NB1RO+FXuLyYB4ij4PocPdxoQ0eBjw76NzGLumyMI21j6TBcSPHZAMXMRzuj
         Q07G7OoLzYj0oXJp14aOI0arZl+DovZrN3A/zNhSB/11x/VES83b4MlrfMYzfrrdMo+j
         WAWAxHjwtHCdl2nBLX7cWpcGL0MdyZ8D8wMlHnDoTSXNIifTnDdBjq88CFJ6cpGEs5j5
         TmMKe2qupu7wP6IqiA6XxUC55HDDQOna07+nz3W3LqT+Nv//xSETvzWldhbUEAjF+tEh
         5tyQ==
X-Gm-Message-State: AAQBX9cjJWLx/7H6Sj3MCxcpFlSu3u6GDbR+2jpTA2H/fVICeRbgiAxg
        QRezgRgSyW50hUOGjYQVNTjwXdVGJtWsAZjEKbo=
X-Google-Smtp-Source: AKy350bZkFgLT7HSJQhwKWGP/IfIKc/U8VtH9WDXl9TfWiQBUMX1mQd7/sJBo2HipPiF7lDRaDT/eXIj/sfgCyZ4/Hc=
X-Received: by 2002:a17:906:5fca:b0:930:310:abcf with SMTP id
 k10-20020a1709065fca00b009300310abcfmr9635227ejv.2.1680091605284; Wed, 29 Mar
 2023 05:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230329090055.7537-1-rui.zhang@intel.com> <08aee7fe-eddc-7841-2539-16ae43fd8d66@linaro.org>
In-Reply-To: <08aee7fe-eddc-7841-2539-16ae43fd8d66@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Mar 2023 14:06:34 +0200
Message-ID: <CAJZ5v0hGnoEhYadoK-KPTvMtvviOrGqbY9jrmOUzTjOGe_rB_A@mail.gmail.com>
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

So maybe instead of the wholesale switch to using "driver-specific"
device pointers for printing messages, something like
thermal_zone_debug/info/warn/error() taking a thermal zone pointer as
the first argument can be defined?

At least this particular bug could be avoided this way.

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
>
>
> >               return;
> >       }
> >
>
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
