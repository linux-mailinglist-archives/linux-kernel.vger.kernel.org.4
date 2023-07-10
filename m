Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4467774CB57
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 06:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjGJElo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 00:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjGJEli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 00:41:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639BA118;
        Sun,  9 Jul 2023 21:41:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-977e0fbd742so508268366b.2;
        Sun, 09 Jul 2023 21:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688964095; x=1691556095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z391P94NK0S4nBbuqojAtmDefeCcZpdE1Zphzj/MvSk=;
        b=aImnPw46wnuPHEgQ/XgQjKcgjdFNtUGKjUiITJoZNMOEw/jEYntShGYVoWs3CrM3CC
         RuFmQDUg3NPsrXnaWKJi1wm2Dasy/6MCsLmIUgt/ZzXMb24cPPZP8iVxOvWke8donDFb
         HTlN59e8okFxvfQw+d7VRmOaYg63iIH6q7DMRAPx9pvZxh9VCLH+xAw6xzm3eytM4Qau
         sdcOjie+im0jh/WBCr+WICUhF8+zkH7gjGFrATnrpDgJbIAaISRIAi830GD1+ULzt1gY
         gM3a63jcE60NdRFqw1+EWUXHyiIkFmxuap0owcv2/y4wtI36n99N5S/7mjvlc9iJLKfF
         pV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688964095; x=1691556095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z391P94NK0S4nBbuqojAtmDefeCcZpdE1Zphzj/MvSk=;
        b=lJX63D7v+YLM/Rck7uxR24bsKOjz4WTpVrrD2FigzVm4ir6uvU56mDRatnZzcu4Oi+
         TWSA4fCiKoNR86MDr1xqdcMFsrHar9qiAhhW0tbe+IUIuV1Wo20n0PFr1JNYvY41FnT5
         5eKgE3fi7hL3TQUfW609GrsB8aC8M0q2WvOnUyiTwQY+NE0HvnRhaIaoZSh+jbUNSjOx
         Kld0CuuizYJcSSoeR1Gf3anB6HyUIzDlM3+/FSiKJZiBql7qNzVaRFFUXNqSHFGt9rXo
         6suVZ6VT1koA6q+brRVz3SwjuMJWLgqnE2VkrFDH+u8fSle9PB5CrM7q4gG5oi6md4Yi
         CLyw==
X-Gm-Message-State: ABy/qLYa0wbOCXGByrQflgSD/KsHTvCsGsGbplUFnGNgDdSserS/M5m6
        vdD1U2ts+VbhC1IXqBb+xU9u+xGwXRt8VzKrD/M=
X-Google-Smtp-Source: APBJJlHBLbBjx6J2P13cloDRN3u+Zd5WxJppiy/1cjTA5AhaLv4eS52ZyWjKALvG8Q5vFr8yBo2QJHzIzi00vBv01no=
X-Received: by 2002:a17:906:3f43:b0:991:e2b6:2189 with SMTP id
 f3-20020a1709063f4300b00991e2b62189mr11740981ejj.43.1688964094607; Sun, 09
 Jul 2023 21:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230710033234.28641-1-di.shen@unisoc.com>
In-Reply-To: <20230710033234.28641-1-di.shen@unisoc.com>
From:   Di Shen <cindygm567@gmail.com>
Date:   Mon, 10 Jul 2023 12:41:23 +0800
Message-ID: <CAHYJL4oQCTpxmON3w17QURCYcE44BLGQCetcDKEPfEJ9OiMZiA@mail.gmail.com>
Subject: Re: [PATCH V5] thermal/core/power_allocator: reset thermal governor
 when trip point is changed
To:     Di Shen <di.shen@unisoc.com>
Cc:     lukasz.luba@arm.com, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        jeson.gao@unisoc.com, orsonzhai@gmail.com, zhanglyra@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 11:38=E2=80=AFAM Di Shen <di.shen@unisoc.com> wrote=
:
>
> When the thermal trip point is changed, the governor should
> be reset so that the policy algorithm can be updated to adapt
> to the new trip point.
>
> 1.Thermal governor is working for the passive trip point or active
> trip point. Therefore, when the trip point is changed it should
> reset the governor only for passic/active trip points.
>
> 2.For "power_allocator" governor reset, the parameters of pid
> controller and the states of power cooling devices should be reset.
>
> 2.1
> The IPA controls temperature using PID mechanism. It is a closed-
> loop feedback monitoring system. It uses the gap between target
> temperature and current temperature which says "error" as the
> input of the PID controller:
>
> err =3D desired_temperature - current_temperature
> P_max =3D
> k_p * err + k_i * err_integral + k_d * diff_err + sustainable_power
>
> That algorithm can 'learn' from the 'observed' in the past reaction
> for it's control decisions and accumulates that information in the
> I(Integral) part so that it can conpensate for those 'learned'
> mistakes.
>
> Based on the above, the most important is the desired temperature
> comes from the trip point. When the trip point is changed, all the
> previous learned errors won't help for the IPA. So the pid parameters
> should be reset for IPA governor reset.
>
> 2.2
> Other wise, the cooling devices should also be reset when the trip
> point is changed.
>
> This patch adds an ops for the thermal_governor structure to reset
> the governor and give the 'reset' function definition for power
> allocator. The ops is called when the trip points are changed via
> sysfs interface.
>
> Signed-off-by: Di Shen <di.shen@unisoc.com>
> ---
>  drivers/thermal/gov_power_allocator.c | 9 +++++++++
>  drivers/thermal/thermal_trip.c        | 5 +++++
>  include/linux/thermal.h               | 3 +++
>  3 files changed, 17 insertions(+)
>
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_=
power_allocator.c
> index 8642f1096b91..8d17a10671e4 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -729,10 +729,19 @@ static int power_allocator_throttle(struct thermal_=
zone_device *tz, int trip_id)
>         return allocate_power(tz, trip.temperature);
>  }
>
> +static void power_allocator_reset(struct thermal_zone_device *tz)
> +{
> +       struct power_allocator_params *params =3D tz->governor_data;
> +
> +       reset_pid_controller(params);
> +       allow_maximum_power(tz, true);
> +}
> +
>  static struct thermal_governor thermal_gov_power_allocator =3D {
>         .name           =3D "power_allocator",
>         .bind_to_tz     =3D power_allocator_bind,
>         .unbind_from_tz =3D power_allocator_unbind,
>         .throttle       =3D power_allocator_throttle,
> +       .reset          =3D power_allocator_reset,
>  };
>  THERMAL_GOVERNOR_DECLARE(thermal_gov_power_allocator);
> diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_tri=
p.c
> index 907f3a4d7bc8..13bbe029c6ab 100644
> --- a/drivers/thermal/thermal_trip.c
> +++ b/drivers/thermal/thermal_trip.c
> @@ -173,6 +173,11 @@ int thermal_zone_set_trip(struct thermal_zone_device=
 *tz, int trip_id,
>         if (tz->trips && (t.temperature !=3D trip->temperature || t.hyste=
resis !=3D trip->hysteresis))
>                 tz->trips[trip_id] =3D *trip;
>
> +       /* Reset the governor only when the trip type is active or passiv=
e. */
> +       ret =3D (trip->type =3D=3D THERMAL_TRIP_PASSIVE || trip->type =3D=
=3D THERMAL_TRIP_ACTIVE);
> +       if (ret && t.temperature !=3D trip->temperature && tz->governor &=
& tz->governor->reset)
> +               tz->governor->reset(tz);
> +
>         thermal_notify_tz_trip_change(tz->id, trip_id, trip->type,
>                                       trip->temperature, trip->hysteresis=
);
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 87837094d549..d27d053319bf 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -197,6 +197,8 @@ struct thermal_zone_device {
>   *                     thermal zone.
>   * @throttle:  callback called for every trip point even if temperature =
is
>   *             below the trip point temperature
> + * @reset:     callback called for governor reset
> + *
>   * @governor_list:     node in thermal_governor_list (in thermal_core.c)
>   */
>  struct thermal_governor {
> @@ -204,6 +206,7 @@ struct thermal_governor {
>         int (*bind_to_tz)(struct thermal_zone_device *tz);
>         void (*unbind_from_tz)(struct thermal_zone_device *tz);
>         int (*throttle)(struct thermal_zone_device *tz, int trip);
> +       void (*reset)(struct thermal_zone_device *tz);
>         struct list_head        governor_list;
>  };
>
> --
> 2.17.1
>

Sorry, the change log was not successfully saved to the commit message.
Add it as following here:
---
V5:
- Simplify the reset ops, make it no return value and no specific
  trip ID as argument.
- Extend the commit message.

V4: [4]
- Compared to V3, handle it in thermal core instead of in governor.
- Add an ops to the governor structure, and call it when a trip
  point is changed
- Define reset ops for power allocator.

V3: [3]
- Add fix tag.

V2: [2]
- Compared to v1, do not revert.
- Add a variable(last_switch_on_temp) in power_allocator_params
  to record the last switch_on_temp value.
- Adds a function to renew the update flag and update the
  last_switch_on_temp when thermal trips are writable.

V1: [1]
- Revert commit 0952177f2a1f.

[1] https://lore.kernel.org/all/20230309135515.1232-1-di.shen@unisoc.com/
[2] https://lore.kernel.org/all/20230315093008.17489-1-di.shen@unisoc.com/
[3] https://lore.kernel.org/all/20230320095620.7480-1-di.shen@unisoc.com/
[4] https://lore.kernel.org/all/20230619063534.12831-1-di.shen@unisoc.com/
---
