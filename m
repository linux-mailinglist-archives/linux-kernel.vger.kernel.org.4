Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE806CEEA4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjC2QGJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 12:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjC2QFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:05:48 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2485E65B4;
        Wed, 29 Mar 2023 09:04:49 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id eg48so65292785edb.13;
        Wed, 29 Mar 2023 09:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680105818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T06f8oc4KixBkG6GFlvqArSOU9shv9azMw2lKiK7zrw=;
        b=uF+gd3kVF1bTnItzDEqIPNDssSaTkxAKeFyy0Wt5cIIm7g10whWShyqPx884oWrivL
         xWFrj7FJdZZLjlkyuBzHJtN4MOrQb8FkRKCJQsqnTZqGbE2XtE4pnPythx+gcaSHEhvX
         mDDNdKajDIeb3LMDGw+E58o+8hRo+q6kvX3r9hDEtMdUyKAwMAw128ARTT+SqIzH0iHR
         /Zq0JWzJW3itCo2Ak6PrDWFwIN8nF2LJQAGR/QGRhXl1YJWRDoOV0qE2N7rvIWIYKhDB
         6iTphzJtIFvtaD8pcQrVkTe2NKu+JWpJcQeHfksoqYOF60oz3ttXUeIerRQ7L4gGDDbt
         B4Ig==
X-Gm-Message-State: AAQBX9eKiV/Prbw/R6N2Fb+rFO0q6uCjHl3vc3XsVtnqSSlWpTUnTtny
        wH0t3t3Tujv/9L2j46chTnOOboSa9qiQDZKbiac=
X-Google-Smtp-Source: AKy350Z9Z9VNsJGdfr8uQy58DZn/2sSrUtK2PTbpcbTqhixcAkGE3mVpmZ08UHuLBv0l2C4H65SdKJN1kpXFY7SZu9s=
X-Received: by 2002:a50:9f82:0:b0:4fa:3c0b:74b with SMTP id
 c2-20020a509f82000000b004fa3c0b074bmr10183827edf.3.1680105818183; Wed, 29 Mar
 2023 09:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230329090055.7537-1-rui.zhang@intel.com> <08aee7fe-eddc-7841-2539-16ae43fd8d66@linaro.org>
 <CAJZ5v0hGnoEhYadoK-KPTvMtvviOrGqbY9jrmOUzTjOGe_rB_A@mail.gmail.com>
 <016dc073-c9a3-4b96-6c58-7b21e0f998a5@linaro.org> <CAJZ5v0jmo_bj4iMVe9ARei4-oyP3TdD+FXiiu+-g55FqJxLJsg@mail.gmail.com>
 <c1c0945b-4772-e6b1-e662-d9901d224f6a@linaro.org>
In-Reply-To: <c1c0945b-4772-e6b1-e662-d9901d224f6a@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Mar 2023 18:03:26 +0200
Message-ID: <CAJZ5v0iMAT_1cQorTqK4xRTjD3a_s=Vf3OJYy3hi7=pAekLv+g@mail.gmail.com>
Subject: Re: [PATCH -next] thermal/drivers/thermal_hwmon: Fix a kernel NULL
 pointer dereference
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
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

On Wed, Mar 29, 2023 at 5:59 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 29/03/2023 16:38, Rafael J. Wysocki wrote:
> > On Wed, Mar 29, 2023 at 4:16 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 29/03/2023 14:06, Rafael J. Wysocki wrote:
> >>> On Wed, Mar 29, 2023 at 11:57 AM Daniel Lezcano
> >>> <daniel.lezcano@linaro.org> wrote:
> >>>>
> >>>> On 29/03/2023 11:00, Zhang Rui wrote:
> >>>>> When the hwmon device node of a thermal zone device is not found,
> >>>>> using hwmon->device causes a kernel NULL pointer dereference.
> >>>>>
> >>>>> Reported-by: Preble Adam C <adam.c.preble@intel.com>
> >>>>> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> >>>>> ---
> >>>>> Fixes: dec07d399cc8 ("thermal: Don't use 'device' internal thermal zone structure field")
> >>>>> dec07d399cc8 is a commit in the linux-next branch of linux-pm repo.
> >>>>> I'm not sure if the Fix tag applies to such commit or not.
> >>>>
> >>>> Actually it reverts the work done to encapsulate the thermal zone device
> >>>> structure.
> >>>
> >>> So maybe instead of the wholesale switch to using "driver-specific"
> >>> device pointers for printing messages, something like
> >>> thermal_zone_debug/info/warn/error() taking a thermal zone pointer as
> >>> the first argument can be defined?
> >>>
> >>> At least this particular bug could be avoided this way.
> >>
> >> Actually we previously said the thermal_hwmon can be considered as part
> >> of the thermal core code, so we can keep using tz->device.
> >>
> >> I'll drop this change from the series.
> >
> > But it's there in my thermal branch already.
> >
> > Do you want to revert the thermal_hwmon.c part of commit dec07d399cc8?
>
> Oh, right. Fair enough.
>
> I think Rui's patch is fine then.

I guess you mean the $subject one, that is:

https://patchwork.kernel.org/project/linux-pm/patch/20230329090055.7537-1-rui.zhang@intel.com

What about the message printed when temp is NULL.  Should the original
form of it be restored too?


> >> On the other side, adding more thermal_zone_debug/info.. gives
> >> opportunities to external components of the core thermal framework to
> >> write thermal zone device related message. I'm not sure that is a good
> >> thing, each writer should stay in its namespace, no ?
> >
> > IMV whoever is allowed to use a thermal zone pointer should also be
> > allowed to print messages related to its use, especially debug ones.
> >
> > "Encapsulation" means that the members of a thermal zone device object
> > should not be accessed directly by its users other than the core, not
> > that it cannot be used as a message tag.
>
> Actually it is not about the encapsulation but the namespace of the
> messages. If a driver has an issue, IMO it is better it uses the device
> related messages and let thermal zone messages to be related to what is
> happening in the thermal framework, not in the back end.
>
>
>
> --
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
