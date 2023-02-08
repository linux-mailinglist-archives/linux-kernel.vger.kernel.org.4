Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1FB68ED2E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBHKnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBHKnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:43:09 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A56A83C8;
        Wed,  8 Feb 2023 02:43:08 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id sa10so19726403ejc.9;
        Wed, 08 Feb 2023 02:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/nhJuICxY8mGv3YNhMXvhgUV0x2GvvCMkLyxMnt13A=;
        b=ndBD4VTFc8oOBSSb3IcmLvP+H4W6gFT97deNp/aHZp21D9ApLweraFdCtWAcZN0UWD
         05aMdB71pyeAe9dSlHY+DGJVY0DT1Y9OxEzz+JG9KlaBJMMj6d6alQDmA3Yd4lPI33xw
         DnCmh+ZF34lbkfuedakKC62VNG7T9oTQDbLzqXXQyIFkWqu+MJTCsXi0tAGld2nyMI1D
         rvwnP15mGMsfsyCLoGywxrXISEKNgkxQ1bNqYQXZXvdi5LOAUkkaRYQWfve2VQ3cnaKg
         K/8Ogl0RRRUgvQkM93+NI9Ci36piuYlx+wVWaKwJIPQg3F0hRDD5sDimU31K2PsPO678
         94VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/nhJuICxY8mGv3YNhMXvhgUV0x2GvvCMkLyxMnt13A=;
        b=Y7dr4Jy/1bzazpcFuYZAwRoBhvejUSqCQN2LTXTxYAWr64SA5oPdpak3+v79gquxjA
         /4RXSvWAlGz+Gg0cmWuBk1xcEXFJJT3gbsTKNrqpCZM6vDJfOHHJlUdb9ecTPNVe++ys
         p2JMs4w0thNV5Agr1S/WwLd1sQYFbgeZevuRKn2xIFIrmYTInouwxUIb4yuwxbkMo006
         Hg9trc4qd9R5mFKv05Ex3TPF1qv+OKnt6aRCLTW5dg5y45G5WOOGzGuoaq1qBcFk1Lhe
         vIkLo8q8QNXMRDCSDLQZVv4Xcnsan5eFhF0RhTcAYxJfdqfij0tidJujGE5gPdQ/XvRq
         RoMQ==
X-Gm-Message-State: AO0yUKW2HyIrf5ScZP3pF5v6hkqNwRlVwHHvC8ob+bxNFtiMbRUi3B/h
        XHauek5dV5X4WRNe7iAFDFk=
X-Google-Smtp-Source: AK7set/LaV94Iy5zaBGCJ/tTh51AJSshN4vTPcS6KAG3q5J0Bo7rjm9ovISagCNj7wPqErcZnMvxww==
X-Received: by 2002:a17:906:3792:b0:88d:5081:e9f8 with SMTP id n18-20020a170906379200b0088d5081e9f8mr6869847ejc.15.1675852986987;
        Wed, 08 Feb 2023 02:43:06 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id s19-20020a056402015300b004a0e2fe619esm7659220edu.39.2023.02.08.02.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 02:43:06 -0800 (PST)
Date:   Wed, 8 Feb 2023 11:43:04 +0100
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
Message-ID: <Y+N8uMO3V5+YNm2E@orome>
References: <20230207135610.3100865-1-cyndis@kapsi.fi>
 <20230207135610.3100865-2-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ew2LPdXyK3eQEa6z"
Content-Disposition: inline
In-Reply-To: <20230207135610.3100865-2-cyndis@kapsi.fi>
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


--ew2LPdXyK3eQEa6z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2023 at 03:56:09PM +0200, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
>=20
> In the rare case that calculation of trip temperatures would result
> in the same trip temperatures that were previously programmed, the
> thermal core skips calling .set_trips.

That seems like an appropriate optimization.

> However, presently, if it is not called, we may end up with no trip
> temperatures programmed at all.

I have a hard time understanding when this would happen. prev_low_trip
and prev_high_trip are -INT_MAX and INT_MAX, respectively, so these are
unlikely to be the result of anything we compute at runtime, based on
temperatures specified in DT, for example.

So I would expect ->set_trips() to get called at least once when the
thermal zones are first registered. Are you saying there are cases where
->set_trips() doesn't get called at all?

> To avoid this, make set_trips a no-op and in places where it would be
> called, instead unconditionally program trip temperatures to the last
> specified temperatures.

Again, this seems more like a workaround for an issue that exists
elsewhere. If ->set_trips() doesn't always get called when it should be,
then that's what we should fix.

> This also fixes the situation where a trip is triggered between
> registering a thermal zone and registering the trip MRQ handler, in
> which case we would also get stuck.

Could this be fixed by requesting the MRQ prior to registering the
zones? That seems like the more appropriate fix for this issue. It's
similar to how we typically register IRQ handlers before enabling a
device to make sure we don't miss any interrupts.

Thierry

--ew2LPdXyK3eQEa6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPjfLYACgkQ3SOs138+
s6GPWxAArhyt+iI02V2C3/Gs+VnqJZUWEYdc3hzIshv4suUyn7d8uPbwddC5nSys
543utlVocIJrGF3YbKVGANp7C01SP7+NXXR/zAMFt7vbNLj8yIg7JYS4AsTr6W/j
N59Bku7wPiPJuHhv30BFfCSjOFUfN+M9HSYAeIp/rLwgtmZCUb1M7JPXIw0rzhty
WLoISXdgdmBBJEsReLqPyBFRsPxpSFI4Yc6HURTYHmSTPmIl6/4cmIQlkKcl/EvA
Id0i+Kd7cx/DWdjIsKOzjRU3ReX1B4pOke2c1Qeq1ZkQ71wurH9m7Q5C4QIYtpG5
lMZ5m99EQBZmjUOMvkW6TZyk0LOGhi5Bd5SJgzw2w7L1i7YVwGaMq2exM5n/PwAp
aHO0ij7v/tNRKFNyI6eDgnd1AaZCwvTqQFahvUSj+TsA4mJDMCWMdeDoQmHFxJC7
WBKjDWD5vp4PSu/Q0leZp3DYcTSlnCm5OHqmQ5kDjdZd20SJU5tXhx44xEgsvSv9
nFTC78C0P1Gzx2dnj033OvKlsVUViX2o/Mx2mHYuJelUvCMS0xreVDBqKP9NTtG7
JFBIYgcDiMAV+k2TfK8FwAPcX826ncl/HdqRL1ODD/QXNSAkPhQ8Ed944TlNkj7X
r5ognsL7VbbzT6KD4ST3MITLj/XSGcdqPr2zXTu/ZPnGN/8xo1g=
=TdpC
-----END PGP SIGNATURE-----

--ew2LPdXyK3eQEa6z--
