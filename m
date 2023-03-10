Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917BA6B3765
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 08:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjCJHcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 02:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjCJHb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:31:56 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8A61086BE;
        Thu,  9 Mar 2023 23:31:54 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id s1so3897797vsk.5;
        Thu, 09 Mar 2023 23:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678433514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zgaBrfuxjPtbIjdylDdCVaG0UoLraQvsCumXAEZE+8=;
        b=T7A/U0JLQgu3j2YgKoFcm/om5r8lRlPG1q82AArEiiaK5Jza8BCSz1dIwzuwKy1DDh
         SZ3hvEP6jfKjPOJzlakPV2uH/fOU1SAJau/JPjFcqaS42+WOOz9Jg47s1YfMkigzHneE
         nwHVMf3BuSlyJQdxEyDlryAkCq04LYQQxg51xk8SEEQevHnEjQ71l/0KaxT1aCoujynI
         9jc93haVofRl4ZW4OAGwrvnXi96qqQ+8geSoZpzFFBSdTIpHCq6C+BfAS+NEKyh663Ah
         j/239jMH7gEh6iRbcTz+Jcf3LEftjaiJrdamJKq+8NnE4Jw8bLAFPO8sIeRt4VpH0Mql
         2nXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678433514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zgaBrfuxjPtbIjdylDdCVaG0UoLraQvsCumXAEZE+8=;
        b=zFQvL3+WR/+TXjv4d4am6rQQU97PyP9XAG3r4t7CPE/ehaBw7PprL8DtPNoBQBOu7F
         r1frWlm8iQ5i6oKBukP6ggV4e/RpwO83dxk0M035z31ivDakuTcy/xBKPVFJGpD4Q7GY
         sH3iy6+Rk3iW34SI6J2kIKKLW9nsEOxyfzH/NP05GN4flxL/wSvTh9F6FiS8kaPCOqLV
         bA6LvxGO23hXlAMXFED/Ix9ChjuqcBDtL7fcbV3iEOP9cQ5pxpJOp1tJ7LDMRdrHH06u
         QETX7f3QUg715oT+IpuIbhxNMFSPISNUdGXAMY2R9u995q7MQytH91qhXiM7ik9yD7c7
         9cXg==
X-Gm-Message-State: AO0yUKWRR41E2m8GZxcmPcKLmKdPzk2diUlw1OQpwHwCiq75hUQYVo4n
        aWxjK5yGwxHnhT70/3G3xMkc0hmULQflsbILW8w=
X-Google-Smtp-Source: AK7set/O+WO8AVZWJt5jQhaL0UIgl1btiTS/k6+n1hTTPXVq4rPSBIbc7YHI0AOMu7UnENJIzazejkRU2Q64HGkFR4U=
X-Received: by 2002:a05:6102:913:b0:421:eabb:cd6a with SMTP id
 x19-20020a056102091300b00421eabbcd6amr9505922vsh.7.1678433499605; Thu, 09 Mar
 2023 23:31:39 -0800 (PST)
MIME-Version: 1.0
References: <20230309135515.1232-1-di.shen@unisoc.com>
In-Reply-To: <20230309135515.1232-1-di.shen@unisoc.com>
From:   Di Shen <cindygm567@gmail.com>
Date:   Fri, 10 Mar 2023 15:31:28 +0800
Message-ID: <CAHYJL4obTjdYny4vGTfo89gmv7oKD8e=FzSdvDsL=Q+Z+cz_6g@mail.gmail.com>
Subject: Re: [PATCH] thermal/core/power_allocator: avoid cdev->state can not
 be reset
To:     Di Shen <di.shen@unisoc.com>
Cc:     lukasz.luba@arm.com, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        "qyousef@layalina.io" <qyousef@layalina.io>
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

Hi all,
any comments for this patch? Looking forward to your reply. Thank you.

--=20
di



On Thu, Mar 9, 2023 at 10:05=E2=80=AFPM Di Shen <di.shen@unisoc.com> wrote:
>
> Commit 0952177f2a1f (thermal/core/power_allocator: Update once cooling de=
vices when temp is low)
> add a update flag to update cooling device only once when temp is low.
> But when the switch_on_temp is set to be a higher value, the cooling devi=
ce state
> may not be reset to max, because the last_temp is smaller than the switch=
_on_temp.
>
> For example:
> First:
> swicth_on_temp=3D70 control_temp=3D85;
>
> Then userspace change the trip_temp:
> swicth_on_temp=3D45 control_temp=3D55 cur_temp=3D54
>
> Then userspace reset the trip_temp:
> swicth_on_temp=3D70 control_temp=3D85 cur_temp=3D57 last_temp=3D54
>
> At this time, the cooling device state should be reset to be max.
> However, because cur_temp(57) < switch_on_temp(70)
> last_temp(54) < swicth_on_temp(70) --> update =3D false
> When update is false, the cooling device state can not be reset.
>
> So delete the update condition, so that the cooling device state
> could be reset.
>
> Fixes: 0952177f2a1f (thermal/core/power_allocator: Update once cooling de=
vices when temp is low)
> Signed-off-by: Di Shen <di.shen@unisoc.com>
> ---
>  drivers/thermal/gov_power_allocator.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_=
power_allocator.c
> index 0eaf1527d3e3..153bf528b98c 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -560,7 +560,7 @@ static void reset_pid_controller(struct power_allocat=
or_params *params)
>         params->prev_err =3D 0;
>  }
>
> -static void allow_maximum_power(struct thermal_zone_device *tz, bool upd=
ate)
> +static void allow_maximum_power(struct thermal_zone_device *tz)
>  {
>         struct thermal_instance *instance;
>         struct power_allocator_params *params =3D tz->governor_data;
> @@ -582,8 +582,7 @@ static void allow_maximum_power(struct thermal_zone_d=
evice *tz, bool update)
>                  */
>                 cdev->ops->get_requested_power(cdev, &req_power);
>
> -               if (update)
> -                       __thermal_cdev_update(instance->cdev);
> +               __thermal_cdev_update(instance->cdev);
>
>                 mutex_unlock(&instance->cdev->lock);
>         }
> @@ -697,7 +696,6 @@ static int power_allocator_throttle(struct thermal_zo=
ne_device *tz, int trip_id)
>         struct power_allocator_params *params =3D tz->governor_data;
>         struct thermal_trip trip;
>         int ret;
> -       bool update;
>
>         lockdep_assert_held(&tz->lock);
>
> @@ -710,10 +708,9 @@ static int power_allocator_throttle(struct thermal_z=
one_device *tz, int trip_id)
>
>         ret =3D __thermal_zone_get_trip(tz, params->trip_switch_on, &trip=
);
>         if (!ret && (tz->temperature < trip.temperature)) {
> -               update =3D (tz->last_temperature >=3D trip.temperature);
>                 tz->passive =3D 0;
>                 reset_pid_controller(params);
> -               allow_maximum_power(tz, update);
> +               allow_maximum_power(tz);
>                 return 0;
>         }
>
> --
> 2.17.1
>
