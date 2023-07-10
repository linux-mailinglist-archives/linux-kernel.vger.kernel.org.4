Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7456674D7DA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 15:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjGJNg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 09:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjGJNgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:36:23 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43A610D;
        Mon, 10 Jul 2023 06:36:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98de21518fbso595384366b.0;
        Mon, 10 Jul 2023 06:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688996172; x=1691588172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzB1344x1aSgFNmePFVwYnD9Wb81Hy/qqdEvyIqJYAg=;
        b=gx+KZazoQ94QLEEVg0QCy5AAuCO0yARIo0VKRKGK6DbuLgwt4GoatCvZX1XHej38ut
         iPGnRYa/H1GVx4G35MjYmaODAOqdjXzeI0TTowuBpzy4EbqhoFqypeOTclOir1iim+QI
         wOcfOCs8GwNF/7P6eScqbnERFrcxXwEJ8Xc0SpozR0tzZb2rjZJzdUo/FlSvwtoLKItB
         mKrBrCscLtlE/cwFEPSwehl2uhssgTkSjsqWurvhPu2//9/inZuKaa5Q7VxitOdUcGY1
         MJMEKaUMvi7BXb/C4QaesjzA+NTVyreXYJihBISmA7+1yQtw/ZGFh7crUpAdQqrSCR+D
         lqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688996172; x=1691588172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzB1344x1aSgFNmePFVwYnD9Wb81Hy/qqdEvyIqJYAg=;
        b=jPQ1u8tGiQw0ZWb8s5zWATpzufvG8j+rOdpsDnSEIzTbVX/tm82QEQ4J4U5GksCkuu
         3q2YYBxaKu3e8wAscocn/e7CIdV0+BnXb78ToHF8MLJusztUfpsh4Vc3alm+/0M6qwBM
         1gEq84rxzV1UxtoshC5Hy4DOEtbcI4LN5rIuuANSEIptFmkXqH4KloFtp/0QP4snjk79
         lfEXoBflDBGdRDz1tKYxshVhPpv7Nj8dL0OTHEyJ0KhJlE1FzM2KoCLlrCw8gvhAW59C
         eeq2wit8ZidJGi4Qi+QSq9xDZIWn1j83RpI6sP4qHTWRGkqlwt7YgowJeQCH4i4E2kdm
         3hfQ==
X-Gm-Message-State: ABy/qLbQiqE24Ym2SHPUKDhfWzrOPZKu5HVSZb0EODitG1wNlZit8/qR
        H737Sl0qzYt0LJSsARsWqCAJuls4gEiAsyPMmFk=
X-Google-Smtp-Source: APBJJlFr7GD9lhqeTV55DH+8pXU4lbtOaxkaGKYqONoSddT1x7Tz1KFZPJlgiecEOrGwIoWpI3KGzATFBlzP3WIWIFo=
X-Received: by 2002:a17:906:1ecf:b0:982:30e3:ddcb with SMTP id
 m15-20020a1709061ecf00b0098230e3ddcbmr9072831ejj.65.1688996171889; Mon, 10
 Jul 2023 06:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230710033234.28641-1-di.shen@unisoc.com> <6d3f24a4-ae70-49eb-6e41-86baa1db6bed@linaro.org>
In-Reply-To: <6d3f24a4-ae70-49eb-6e41-86baa1db6bed@linaro.org>
From:   Di Shen <cindygm567@gmail.com>
Date:   Mon, 10 Jul 2023 21:36:00 +0800
Message-ID: <CAHYJL4og14kQ4ev6QtDQeknJELME7URTN_HmR01P5+2RhpthzQ@mail.gmail.com>
Subject: Re: [PATCH V5] thermal/core/power_allocator: reset thermal governor
 when trip point is changed
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Di Shen <di.shen@unisoc.com>, lukasz.luba@arm.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuewen.yan@unisoc.com, jeson.gao@unisoc.com, orsonzhai@gmail.com,
        zhanglyra@gmail.com
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

Hi Daniel,
Thank you for your reply.
On Mon, Jul 10, 2023 at 4:59=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 10/07/2023 05:32, Di Shen wrote:
> > When the thermal trip point is changed, the governor should
> > be reset so that the policy algorithm can be updated to adapt
> > to the new trip point.
> >
> > 1.Thermal governor is working for the passive trip point or active
> > trip point. Therefore, when the trip point is changed it should
> > reset the governor only for passic/active trip points.
> >
> > 2.For "power_allocator" governor reset, the parameters of pid
> > controller and the states of power cooling devices should be reset.
> >
> > 2.1
> > The IPA controls temperature using PID mechanism. It is a closed-
> > loop feedback monitoring system. It uses the gap between target
> > temperature and current temperature which says "error" as the
> > input of the PID controller:
> >
> > err =3D desired_temperature - current_temperature
> > P_max =3D
> > k_p * err + k_i * err_integral + k_d * diff_err + sustainable_power
> >
> > That algorithm can 'learn' from the 'observed' in the past reaction
> > for it's control decisions and accumulates that information in the
> > I(Integral) part so that it can conpensate for those 'learned'
> > mistakes.
> >
> > Based on the above, the most important is the desired temperature
> > comes from the trip point. When the trip point is changed, all the
> > previous learned errors won't help for the IPA. So the pid parameters
> > should be reset for IPA governor reset.
> >
> > 2.2
> > Other wise, the cooling devices should also be reset when the trip
> > point is changed.
> >
> > This patch adds an ops for the thermal_governor structure to reset
> > the governor and give the 'reset' function definition for power
> > allocator. The ops is called when the trip points are changed via
> > sysfs interface.
> >
> > Signed-off-by: Di Shen <di.shen@unisoc.com>
> > ---
> >   drivers/thermal/gov_power_allocator.c | 9 +++++++++
> >   drivers/thermal/thermal_trip.c        | 5 +++++
> >   include/linux/thermal.h               | 3 +++
> >   3 files changed, 17 insertions(+)
> >
> > diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/go=
v_power_allocator.c
> > index 8642f1096b91..8d17a10671e4 100644
> > --- a/drivers/thermal/gov_power_allocator.c
> > +++ b/drivers/thermal/gov_power_allocator.c
> > @@ -729,10 +729,19 @@ static int power_allocator_throttle(struct therma=
l_zone_device *tz, int trip_id)
> >       return allocate_power(tz, trip.temperature);
> >   }
> >
> > +static void power_allocator_reset(struct thermal_zone_device *tz)
> > +{
> > +     struct power_allocator_params *params =3D tz->governor_data;
> > +
> > +     reset_pid_controller(params);
> > +     allow_maximum_power(tz, true);
>
> Do you really want to allow the maximum power? What about if the trip
> temperature is decreased ?
>
If the trip temperature is decreased, allow_maximum_power will only
be executed once, and then the ipa governor will adapt to the lower trip
temperature and calculate the allocated power for cooling actors again.
Right?

But if the trip temperature is increased, it must allow the maximum power,
otherwise, the Line 723 update flag might be false(see the false example
in patch-v3), the power of cooling devices would be not allowed maximum
for a while unless the current temperature is higher than the new
switch_on_temp. In this situation, for cpufreq cooling devices, it means th=
e
cpu max_freq is limited, which is bad for device performance. The same for
other cooling devices, if not reset the cooling state, it may introduce
unexpected issues.

705 static int power_allocator_throttle(struct thermal_zone_device
*tz, int trip_id)
706 {
707         struct power_allocator_params *params =3D tz->governor_data;
708         struct thermal_trip trip;
709         int ret;
710         bool update;
711
712        //......
721         ret =3D __thermal_zone_get_trip(tz, params->trip_switch_on,
&trip);
722         if (!ret && (tz->temperature < trip.temperature)) {
723                 update =3D (tz->last_temperature >=3D
trip.temperature);
724                 tz->passive =3D 0;
725                 reset_pid_controller(params);
726                 allow_maximum_power(tz, update);
727                 return 0;
728         }
729
730         tz->passive =3D 1;
731          //.......
740 }

> You want maximum power only if the mitigation ends.
>
Yes, you're right, I agree. It's better to do like that, actually,
patch-v3 is in line
with this point I think, but it is not in the thermal core.

Oh, I see!
How about modified like that:
static void power_allocator_reset(struct thermal_zone_device *tz)
{
     struct power_allocator_params *params =3D tz->governor_data;
+   struct thermal_trip trip;
+   int ret;

     reset_pid_controller(params);
+   ret =3D __thermal_zone_get_trip(tz, params->trip_switch_on, &trip);
+   if (!ret && (tz->temperature < trip.temperature))
             allow_maximum_power(tz, true);
}
It seems clearer.

> > +}
> > +
> >   static struct thermal_governor thermal_gov_power_allocator =3D {
> >       .name           =3D "power_allocator",
> >       .bind_to_tz     =3D power_allocator_bind,
> >       .unbind_from_tz =3D power_allocator_unbind,
> >       .throttle       =3D power_allocator_throttle,
> > +     .reset          =3D power_allocator_reset,
> >   };
> >   THERMAL_GOVERNOR_DECLARE(thermal_gov_power_allocator);
> > diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_t=
rip.c
> > index 907f3a4d7bc8..13bbe029c6ab 100644
> > --- a/drivers/thermal/thermal_trip.c
> > +++ b/drivers/thermal/thermal_trip.c
> > @@ -173,6 +173,11 @@ int thermal_zone_set_trip(struct thermal_zone_devi=
ce *tz, int trip_id,
> >       if (tz->trips && (t.temperature !=3D trip->temperature || t.hyste=
resis !=3D trip->hysteresis))
> >               tz->trips[trip_id] =3D *trip;
> >
> > +     /* Reset the governor only when the trip type is active or passiv=
e. */
> > +     ret =3D (trip->type =3D=3D THERMAL_TRIP_PASSIVE || trip->type =3D=
=3D THERMAL_TRIP_ACTIVE);
>
> Actually we have the trip points:
>
> ACTIVE, PASSIVE, HOT and CRITICAL
>
Correct.

> The last two ones should not be writable.
>
> Instead of this test, it would be cleaner to only make the ACTIVE and
> PASSIVE trip point writable when the CONFIG_THERMAL_WRITABLE_TRIPS
> option is set. Consequently, other trip points won't be writable and
> this test can go away as set_trip will be protected by a RO sysfs file
> property.
>
> > +     if (ret && t.temperature !=3D trip->temperature && tz->governor &=
& tz->governor->reset)
>
> The temperature test is duplicated because it is already done in the
> block before.
>
So here you mean two points:
1. Make the HOT and CRITICAL point RO so that it can no trip type test
when gov->reset
2. not do the temperature test twice
Right?

For the first point, it's OK for me. But what if someone wants to
power off the device earlier
or later? I think it should have the access to update the critical
temperature. I'm not really
know about the hot trip temperature. So I'm not sure the real reason
to make them RO
when the trip points are writable. I can't make it RO just because of
the code simplification.

For the second point, that's OK. I will simplify in the next patch
version. Thank you, Daniel.

> > +             tz->governor->reset(tz);
> > +
> >       thermal_notify_tz_trip_change(tz->id, trip_id, trip->type,
> >                                     trip->temperature, trip->hysteresis=
);
> >
> > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > index 87837094d549..d27d053319bf 100644
> > --- a/include/linux/thermal.h
> > +++ b/include/linux/thermal.h
> > @@ -197,6 +197,8 @@ struct thermal_zone_device {
> >    *                  thermal zone.
> >    * @throttle:       callback called for every trip point even if temp=
erature is
> >    *          below the trip point temperature
> > + * @reset:   callback called for governor reset
> > + *
> >    * @governor_list:  node in thermal_governor_list (in thermal_core.c)
> >    */
> >   struct thermal_governor {
> > @@ -204,6 +206,7 @@ struct thermal_governor {
> >       int (*bind_to_tz)(struct thermal_zone_device *tz);
> >       void (*unbind_from_tz)(struct thermal_zone_device *tz);
> >       int (*throttle)(struct thermal_zone_device *tz, int trip);
> > +     void (*reset)(struct thermal_zone_device *tz);
> >       struct list_head        governor_list;
> >   };
> >
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>

Best regards,
Di
