Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA806B6D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 02:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjCMBlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 21:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCMBlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 21:41:12 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E6835257;
        Sun, 12 Mar 2023 18:41:11 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-176b48a9a05so12340988fac.0;
        Sun, 12 Mar 2023 18:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678671670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0q2mm8WiyPEsQVto2sWAylICahAVbX9i3qYH81Jwvc=;
        b=ie72lzfMAkLWH7aHcqP1OIVnaORmum6T3R/mE4N4JuF8AnYDh9snj3OmCq7F8RlyQZ
         /G9OI8dXhIy2kzoUXnM6ScP5QVAzsOacIFBJJxR30ZSPNlC/DSheGAHkUUPeFScHvmJe
         WDVsEnRXWLxXRvfq3oAFpPUvdMeKsPUD8mCFBlNxdfht4RqFt6irzLBHQCxHyEYVJXdi
         zBYlR6tWaEYoNX1x0FpL1hlpPkQdeTxh3rtyozWGEHIGsrboCPL8xfoHvcEK+LJTJ7Bd
         FljYC2PHuoKS3gnkRhm54x8ewBvdr+IePRbuq7ciBT9QFzsi3fP1QTaE7DGenGClBh93
         wHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678671670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0q2mm8WiyPEsQVto2sWAylICahAVbX9i3qYH81Jwvc=;
        b=rGVSM0uQ3UzBoQ+1ABLsIvzhQI4oOW2CBlCgnHlR5D0rWH/yQ8hax3KIQFI0Jn5O2L
         0owtwxdzvd/4q7v+ybBN/SxCtkqc1cdvxcXHTd71DryBuk6fAAKbJcZjp5rdMw9fLwei
         bbgqB1y+oa2ArAdCWECxee8b8R5zCeCytLioLtbzrC+ISUUTiSMfpMVca9DlXkFBBfCB
         nsdu5VOx6dPHWZlQO/5cneMJKu+e7aA2U44/jC8ubhoaHkB8vyyBajfFr6vqSZhjzVMI
         q7wD0gTHPcFsQlspEgx1MyTEtHEulmlc/NMkQYHKrObtTyXbO0pC2Y6/2vg8gX+R7035
         TOtw==
X-Gm-Message-State: AO0yUKUcNzqeUUZvtxParmwU8itGKunVLLkrJguWBubTdm5WKHj18cLM
        F5++3RI2/EHtbWuiXpq2Xb2qJLHoPYzNodymMuI=
X-Google-Smtp-Source: AK7set+/X/6iAbOva6ckym6jFXiN+VQllZzdlR+0RbWk7Op6fbeeG0ER8X0U7OgS03iS3EqqdRwi263sT1m+TJMxeOA=
X-Received: by 2002:a05:6870:c384:b0:176:3e1e:7e95 with SMTP id
 g4-20020a056870c38400b001763e1e7e95mr11497845oao.6.1678671670257; Sun, 12 Mar
 2023 18:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230309135515.1232-1-di.shen@unisoc.com> <db539c1e-22d5-2261-1248-07883dac12ee@arm.com>
In-Reply-To: <db539c1e-22d5-2261-1248-07883dac12ee@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Mon, 13 Mar 2023 09:40:58 +0800
Message-ID: <CAB8ipk_T5RUZxD42d9wg_i8-3UXHFP=4Ffa_NH8Nm7FnyW2Ppw@mail.gmail.com>
Subject: Re: [PATCH] thermal/core/power_allocator: avoid cdev->state can not
 be reset
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Di Shen <di.shen@unisoc.com>, daniel.lezcano@linaro.org,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuewen.yan@unisoc.com, Qais Yousef <qyousef@layalina.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz

On Fri, Mar 10, 2023 at 11:56=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
> Hi Di,
>
> On 3/9/23 13:55, Di Shen wrote:
> > Commit 0952177f2a1f (thermal/core/power_allocator: Update once cooling =
devices when temp is low)
> > add a update flag to update cooling device only once when temp is low.
> > But when the switch_on_temp is set to be a higher value, the cooling de=
vice state
> > may not be reset to max, because the last_temp is smaller than the swit=
ch_on_temp.
> >
> > For example:
> > First:
> > swicth_on_temp=3D70 control_temp=3D85;
> >
> > Then userspace change the trip_temp:
> > swicth_on_temp=3D45 control_temp=3D55 cur_temp=3D54
> >
> > Then userspace reset the trip_temp:
> > swicth_on_temp=3D70 control_temp=3D85 cur_temp=3D57 last_temp=3D54
> >
> > At this time, the cooling device state should be reset to be max.
> > However, because cur_temp(57) < switch_on_temp(70)
> > last_temp(54) < swicth_on_temp(70) --> update =3D false
> > When update is false, the cooling device state can not be reset.
>
> That's a tricky use case. How is that now possible,

We use the trip_temp in the Android System. Often, we set different
control temperatures in different scenarios,
and when we change the switch_on_temp from small to bigger, we find
the power can not be reset to be max.


> >
> > So delete the update condition, so that the cooling device state
> > could be reset.
>
> IMO this is not the desired solution. Daniel reported the issue that
> IPA triggers the event sent to user-space even when there is no need.
> That's the motivation for the 0952177f2a1f change.
>
> To address your scenario properly, we need an interface which allows
> to respond properly for such situation when someone from user-space
> writes a new value to something fundamental as trip point.
>
> You also have a kernel config enabled:
> CONFIG_THERMAL_WRITABLE_TRIPS
> which IMO is only for debug kernels for system integrator (according
> to the Kconfig description).

 Yes, we use it to meet the temperature control needs of different scenario=
s.
And now in android with google's GKI2.0, the config must be opened.

>
> When you disable this config in your deploy/product kernel
> than this issue would disappear.
>
> >
> > Fixes: 0952177f2a1f (thermal/core/power_allocator: Update once cooling =
devices when temp is low)
> > Signed-off-by: Di Shen <di.shen@unisoc.com>
> > ---
> >   drivers/thermal/gov_power_allocator.c | 9 +++------
> >   1 file changed, 3 insertions(+), 6 deletions(-)
> >
>
> That's why IMO this is not the solution.

Yes, but I think we should fix the bug, although the
CONFIG_THERMAL_WRITABLE_TRIPS is just for debugging.
How about record the last_trip_temp, and when the last_temp >
last_trip_temp, set the update tobe true?

Thanks!
BR,
xuewen

>
> Regards,
> Lukasz
