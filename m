Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1C368F2A9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjBHQCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBHQCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:02:38 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF8A2B635;
        Wed,  8 Feb 2023 08:02:37 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id a10so14035016edu.9;
        Wed, 08 Feb 2023 08:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKyil8IbId0kexGvkgY1HOtPSwl714eSaF9A1N7I3XI=;
        b=TAf99v4TaLYlkdOtj0H1I61dJZ3D7krkZ8fFgDshCFTOkK6G/HsPafvr+O3sHFRfz6
         7qnZvGm3YJxy2rxYUCur4RGk9EeRu3Qqa4WDyn+1fiHXa6YlIoWIvAOvMQui7muyo3/P
         fTjr+v90xFMPs1y5EHmSpTLBxKtC8+g4r4fLY+KnvIlK3VPGxsMUiMshkq3ia8k3Gint
         scSwpw87loOnPZGEqbFWbBfsACwsTqBAooXVp6q7e4+wTDj4+Jvq4yjFIvQ6YdaQpw/L
         nyXpT7SGxRu9evldj0DYTfJ7KUCJXQfBlkp1m4b0wKoRW9mx51/Ah8Rsc4LTMzTJMb6F
         dpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKyil8IbId0kexGvkgY1HOtPSwl714eSaF9A1N7I3XI=;
        b=25InE+5hj6qoYJSUpnQTLXDm2JxKSFFyGfr2uSYHVO9XfZZyqoFfLBxC3W5q2sJItn
         YEtgtHUjaj/mPgBQoIQEYlKcCCdlbrgYw0CTrrXgnAblvEsTehgVje8MjNrVjVgTXyww
         NJ3E8mijSYr+lG3JdeOnLbjUV5yVXDVI6IWQCt7JdxQWhCHV9ACsh4bSw0djHyqLiN9Q
         1zCjgkt68YVF4lMcrssvY9va0Jmq4PV9Z+Rj2kE7RO6wLn/9IhbmolK6eAp+p4BEx3mU
         tDfTKJ1cUe85IJ6G2FP4xyyMx5rJuE4eQiYENIzGxjGQNgM5tx5Mq99qrBMyDFpheNhk
         x+3Q==
X-Gm-Message-State: AO0yUKXv684MwnEZ0R5DfmGET8jNMUbDXZGvzmYEys6oNP8tRzfCUmiU
        tuPImqADg+9ggS0ATk7T5Ck=
X-Google-Smtp-Source: AK7set9ik7jw7lT/vGBewMMSVZ9klDDjd4LcOUdKBag4qpRWRUErjugptHMaNael4Rj5wIRV5tIzHg==
X-Received: by 2002:a50:d09d:0:b0:4a2:6d1c:fb38 with SMTP id v29-20020a50d09d000000b004a26d1cfb38mr7928629edd.10.1675872155761;
        Wed, 08 Feb 2023 08:02:35 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id fd8-20020a056402388800b004a245350e0fsm8058786edb.36.2023.02.08.08.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 08:02:35 -0800 (PST)
Date:   Wed, 8 Feb 2023 17:02:33 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Srikar Srimath Tirumala <srikars@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Timo Alho <talho@nvidia.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] thermal: tegra-bpmp: Always (re)program trip
 temperatures
Message-ID: <Y+PHmeQbFLNqlzOj@orome>
References: <20230207135610.3100865-1-cyndis@kapsi.fi>
 <20230207135610.3100865-2-cyndis@kapsi.fi>
 <Y+N8uMO3V5+YNm2E@orome>
 <d6a2a1d5-fc3b-2510-e5e8-e3f36f1652d5@kapsi.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KVkfM7mbh/4l5fR6"
Content-Disposition: inline
In-Reply-To: <d6a2a1d5-fc3b-2510-e5e8-e3f36f1652d5@kapsi.fi>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KVkfM7mbh/4l5fR6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2023 at 05:35:22PM +0200, Mikko Perttunen wrote:
> On 2/8/23 12:43, Thierry Reding wrote:
> > On Tue, Feb 07, 2023 at 03:56:09PM +0200, Mikko Perttunen wrote:
> > > From: Mikko Perttunen <mperttunen@nvidia.com>
> > >=20
> > > In the rare case that calculation of trip temperatures would result
> > > in the same trip temperatures that were previously programmed, the
> > > thermal core skips calling .set_trips.
> >=20
> > That seems like an appropriate optimization.
> >=20
> > > However, presently, if it is not called, we may end up with no trip
> > > temperatures programmed at all.
> >=20
> > I have a hard time understanding when this would happen. prev_low_trip
> > and prev_high_trip are -INT_MAX and INT_MAX, respectively, so these are
> > unlikely to be the result of anything we compute at runtime, based on
> > temperatures specified in DT, for example.
>=20
> Consider:
>=20
> Temperature is 45C.
> set_trips is called with low=3D40C high=3D50C. We program accordingly.
> Temperature goes to 55C. Trip point triggers.
> Before execution gets to CPU, temperature returns to 45C.
> CPU gets the MRQ, calls into thermal core to update.
> Thermal core notices that temperature is 45C and sets again the same low=
=3D40C
> high=3D50C trip points, does not call set_trips.
> No trip point is programmed to BPMP and we never get trips again.

So does this mean that trip points in BPMP are "one-shot". That is, once
they are triggered, BPMP will automatically delete them? And we actively
need to reprogram them to trigger again?

Perhaps a better alternative would be to force the previous temperatures
to be invalid when the trip point triggers to ensure they always get
reprogrammed. Or perhaps we could add a flag to the thermal subsystem to
mark "one-shot" triggers so that the core skips over the temperature
check and always reprograms.

> The above, of course, is rather unlikely to happen, but theoretically
> possible nevertheless.
>=20
> Alternatively, where I discovered the issue originally, was the issue
> described in the last paragraph of the commit message; see below.
>=20
> >=20
> > So I would expect ->set_trips() to get called at least once when the
> > thermal zones are first registered. Are you saying there are cases where
> > ->set_trips() doesn't get called at all?
>=20
> No, not saying that. It will get called when registering the zone initial=
ly,
> but see below.
>=20
> >=20
> > > To avoid this, make set_trips a no-op and in places where it would be
> > > called, instead unconditionally program trip temperatures to the last
> > > specified temperatures.
> >=20
> > Again, this seems more like a workaround for an issue that exists
> > elsewhere. If ->set_trips() doesn't always get called when it should be,
> > then that's what we should fix.
>=20
> I think it depends on what the interpretation is with set_trips. If the
> interpretation is that the the trips configured in the hardware are
> persistent (not disabled when a trip occurs), then the current
> implementation and this patch make sense. Otherwise a change in the therm=
al
> core would make sense.
>=20
> >=20
> > > This also fixes the situation where a trip is triggered between
> > > registering a thermal zone and registering the trip MRQ handler, in
> > > which case we would also get stuck.
> >=20
> > Could this be fixed by requesting the MRQ prior to registering the
> > zones? That seems like the more appropriate fix for this issue. It's
> > similar to how we typically register IRQ handlers before enabling a
> > device to make sure we don't miss any interrupts.
>=20
> I considered that -- there are two reasons I didn't go for it:
>=20
> 1. It doesn't solve the race condition described in the first part of the
> message

These are two different problems, though, so trying to swat them with
the same fix is not likely the best solution.

> 2. To handle the incoming MRQ, zone->tzd needs to be set. But we only get
> tzd from the zone registration call, and already before that call returns,
> set_trips has been called and we might have received an MRQ. I tested usi=
ng
> a completion object to block in the MRQ handler until the initialization
> completes, but that's pretty ugly as well.

Sounds to me like we may need to split the registration and activation
steps. I recall discussions about similar issues in other subsystems.

With interrupts this can sometimes be worked around by installing
handlers and keeping interrupts masked and once unmasked they will
immediately trigger and cause the handler to run. We probably don't
want that for BPMP MRQs, though.

Thierry

--KVkfM7mbh/4l5fR6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPjx5cACgkQ3SOs138+
s6GsFhAAtSJMUUImi9We74FEg1E641VIsMpdKUZcFJIM35g6AYVagW8BRYBT+ICR
Kwa3tz4mP7Jt2CbajkYXqk2weHL2p4f+mO2TJ8kmyy00jUhMuW20yPrSqE3WhmBY
kr17m6rw0MeAlO4hNpsO5/PYKTk1UsVRJU6fosTxJzx+aLGd8v5LsRxTsvzlcoyD
VsB+/POapWfFj2ZGQGOPuR2AlBOy9spTTc4lZjUuGGKMISzWrHlS74GNVrnzzSZZ
ArW/yo7463jeVUVGtk8STFJdaByDm64xDVK1jR40nV4WbPMpF1A4BQNk81MF44+G
MoXEc2NX3loLKuoTtoK89q8ZMIL17Vvx36iUkAqcvPCzup//5Pl6LuTo4V9dfPH2
GODb/VmgsLFUbroLL4onU0edKbeuFfJS9c8h7wFU4E8Vtk2SDC3a13ywqNUro6yM
fObDKsk8hBb5G1haV9QQpQuTxKPO62yX245ttLR0z2qIKh8If2dTZJqXFzNutZI2
JpKwbOOi4uTw1KsUVNYG1f27Qfjlve8PEsk50QwCqzQctlF2m3F2eHoY3evw96ce
X/BRYCYW98jqrkCoZEske0RHzgH7cJyz80/x1UYd32no7EXTVg7BWyONDc5fumx4
NR0bUA2MUVbXVzaXMfXBgDSuSnzXlbK8k64UTodPfhhIyCsbHPU=
=9isT
-----END PGP SIGNATURE-----

--KVkfM7mbh/4l5fR6--
