Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B376AA75A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 02:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCDBhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 20:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCDBhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 20:37:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619D41498E;
        Fri,  3 Mar 2023 17:37:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F125761994;
        Sat,  4 Mar 2023 01:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C878C4339B;
        Sat,  4 Mar 2023 01:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677893826;
        bh=w8npa/QcPOc0QlQAvkCwaGie8TZIB3LxWhBhOAvXSzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XZa46LcJX87tM6P7SzLSI88luVTcrpsAblVKrw2UaHI5qOIVaFaFA6hgsPANm6Z8Y
         WGL1/d4IgFbEV4SQGx3VLaX2DddxtDC0FG+1XY4N48gp2WoTOpL1jJmKYP7rijoKs6
         NAlNXOqYrQOy/LPZu4FAYj8/7tt4zANJKtwsZqAqXHeYFsLZ5UjAS6LpRQDIsVWKJO
         2tspWAoNT1fgCkZ4apb2BIE9OF4kr1HGWs+bWLHXZ7QrtHCo0/C9P/sLahASoQ+y2h
         s3QVlP0MlsjGfZWSUAbaOIOtmIvl3ZZ6chRfkwYQ6w3PVcRIPwTwv4Ddr2oY0dPczt
         P0FieekOkSN9Q==
Received: by mercury (Postfix, from userid 1000)
        id 45DD610609DD; Sat,  4 Mar 2023 02:37:03 +0100 (CET)
Date:   Sat, 4 Mar 2023 02:37:03 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: qcom_battmgr: remove bogus do_div()
Message-ID: <c65e2dbc-c8f9-4481-85f1-4d1eb140a05f@mercury.local>
References: <20230214132052.1556699-1-arnd@kernel.org>
 <Y/+WghSbz3l6uipn@dev-arch.thelio-3990X>
 <CAHk-=wj+O8OqVD36P+1cbe-B3wbB9BwfwtM1E6evObs9VpYz3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ptb2hduxh2c7hxd4"
Content-Disposition: inline
In-Reply-To: <CAHk-=wj+O8OqVD36P+1cbe-B3wbB9BwfwtM1E6evObs9VpYz3A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ptb2hduxh2c7hxd4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 01, 2023 at 10:50:33AM -0800, Linus Torvalds wrote:
> On Wed, Mar 1, 2023 at 10:16=E2=80=AFAM Nathan Chancellor <nathan@kernel.=
org> wrote:
> > Would you be able to take this patch directly? It seems obviously
> > correctTM, has an ack from Sebastian [1], and without it, 32-bit
> > allmodconfig builds are broken [2] (the other warning in that log has a
> > fix on the way to you soon).
>=20
> Ok, I've taken it directly.
>=20
> However, the whole "seems obviously correct" is true in the sense that
> it now doesn't complain (and doesn't overwrite an "int" with a 64-bit
> value.
>=20
> The actual code still looks odd. Is that return value for
> BATT_CAPACITY truly in that odd "hundredths of percent" format,
> where dividing it by 100 gives you whole percent?
>=20
> Because "hundredths of percent" strikes me as a very odd interface.
> Even for some firmware interface. I realize that anything is possible
> with strange firmware, but still...

I don't have the documentation for this Qualcomm interface, but I
remember somebody from Qualcomm asking for a power-supply property
exposing "hundredths of percent" to userspace some years ago (with
the rationale, that percent was not precise enough).

For reference: The upstream solution for that is exposing ENERGY_NOW
and ENERGY_FULL in =C2=B5Wh (or CHARGE_NOW + CHARGE_FULL in =C2=B5Ah depend=
ing
on the fuel-gauge's capabilities), which is even more precise.

-- Sebastian

--ptb2hduxh2c7hxd4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQCoLIACgkQ2O7X88g7
+pppCQ/9H/HYIEK4zvLcjjYOWK2EZdthvqhwrOrVHBDCAIrocPDIaTxK+gdv54KO
Z3h6ab+h4RISbO7B5Uef4A1AjB03tWaa9Y8GkBikqhZsvqy/dwbfB9imF598pe7o
t9DzfO4hWw5rmgArRVEPPmSIT9gdjCsI9/NwxDc3TDvDwy4PE5p7tsAmXckGUv+a
w8anDtbI3AcuNI7oflLkE0yLknQAYKLzoYn+e/hyaDau1GOc/kyG5YrH+yar0iHh
ksWt75CD4EzfMg+Kh3aWCz9sM0lAWVpeGH82w+wLqd+hadC14lF96C0bgGlsIqRl
gYy/jXgqi8JcsNhRi1k6Jw5doB+7rSytevfREDI399j+St9kkOJ4va7GSIFMUDO1
IfU6QPX5XNrvP8roI68bFRqelUJgJPlLGRLzUPaJgvB8DIUrGbjDFHqLuDbqrzw2
B3lINUFBzEfiWPT65rt1KIU3uAMx4eZ5vOaDKY509TQF0g4Y7X08UG1WqGRFi1cb
wgK2tbyWzbOnG8PSyKTMmSNwaNUg9pEiumdqqnKMtwBvpJ0OzxbGzAQfm20y/lI5
T7aUqan9dtcFyiGJioqQFs5D9ziua6Y7thKpFlbJou8vbTjwqOmiazOtjJXpq8GH
N5UcLb9hPTfa1cp3wD/GfWul+4io+OReUWyQjfXEucbKSKv4iZw=
=ehxW
-----END PGP SIGNATURE-----

--ptb2hduxh2c7hxd4--
