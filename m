Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0E9746AE4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjGDHnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjGDHnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:43:09 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23841A7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:43:07 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 2adb3069b0e04-4fb9ae4cef6so8280622e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 00:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688456586; x=1691048586;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8PNt5BONlCpcQDBGJ6fMDygaaIUGiLYcCMkBrinaEjg=;
        b=KDifR/7Eq6Pi2rfuDKb19tFkyikOfvSsNc64b0XCFmA1+T87fADOCDH++DdkkDerLu
         DJgVoMhd6R7/09kp7W4MyvMqKzCMvsSHMdDMjvq2fk10P1RqDSJRyT6xHZmE/VZA4Yvo
         L6DwLhnlR2IoA/lw4nMiBcFQCHfiMidfDQQO9AIAurFnw75+wAB2Lv+LjjvKsDe+D4+q
         Rpyex70sADadsXR6sHOV3korXf9ejHdqnXEr5mulVkF3NdQH9yAXgDKZpGUr3kuLBLi3
         AwjHZx2qpxU+Fx9s1RynQOf7Hp+kA7OrAz6TrIIXLG32f3DLNC40fJLpTBr0CIkaikkx
         43gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688456586; x=1691048586;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8PNt5BONlCpcQDBGJ6fMDygaaIUGiLYcCMkBrinaEjg=;
        b=dVZSgCKokmdJ0hWc+kHZbjDJzT8xZQo1D/f3vuEA3ewupTs7I3VYMEmvVYlS+jGznl
         mt5SnIaI6QU6V8xtRCaRtTzJvKF+GRsm0qRse+IPlVmBWJJMjbMqQWyi3/fdyCfo0pFS
         v42+lJI8kUmDJ/mdUMUwgNpiupmUF79QnNpNrp3FWMblKI70BQjAY+kzO+VZGTJcv0Au
         06JpUrqdH8QjMB0tNZRwGw0lbOVPeIkKO4ugNwukZ76Y0TF4m4+2WpWm0556BKiXygJx
         VJhtL5k3ux1q7dxFXzkKUVnoTPcgWQA0+uewtRWWI2bjFUtouQtIGcqkDDkUgztYMWvD
         YqVw==
X-Gm-Message-State: ABy/qLYExPQBt4IDDOeAqajC7KbhX7d0+IZWV/UhN0fYRQelWgmEXvp/
        GiEGCWBZVjkajeULLDZWHSA=
X-Google-Smtp-Source: APBJJlFh5ji9Dq9VEO/P5f7uoSN10XuXyXbVYqgR4BUEqh5rMo0qV/rxvDto94Xk/ltn0LgvufUvkQ==
X-Received: by 2002:a05:6512:4028:b0:4f9:69b8:1e7c with SMTP id br40-20020a056512402800b004f969b81e7cmr9738387lfb.46.1688456585748;
        Tue, 04 Jul 2023 00:43:05 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id f27-20020ac2533b000000b004fb2244563fsm4570530lfh.289.2023.07.04.00.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 00:43:05 -0700 (PDT)
Date:   Tue, 4 Jul 2023 10:42:56 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc:     Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
        pierre-eric.pelloux-prayer@amd.com,
        Sebastian Wick <sebastian.wick@redhat.com>,
        Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>,
        amd-gfx@lists.freedesktop.org,
        Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alexander.deucher@amd.com,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        kernel-dev@igalia.com, christian.koenig@amd.com
Subject: Re: [PATCH v5 1/1] drm/doc: Document DRM device reset expectations
Message-ID: <20230704104256.658b259d@eldfell>
In-Reply-To: <cedc57a5-779a-3ec6-cfbd-f51dfb17f2dc@igalia.com>
References: <20230627132323.115440-1-andrealmeid@igalia.com>
        <CA+hFU4z1pc=KUVVqyqfXEceUqMXQgh-qUnuB=1nkPELghvQO7w@mail.gmail.com>
        <CADnq5_MNVdtdcWKSz6dgmsjg+kEu8p5FVE+fkw_5BaXeG3QGow@mail.gmail.com>
        <afab1f5a-e581-3416-e2c2-238ea120655b@mailbox.org>
        <CAAxE2A5C96k5ua+r938VA_+w7gHHNTdF3n8LwDb98W0Bf9wCVA@mail.gmail.com>
        <7c1e6df5-1ad4-be3c-b95d-92dc62a8c537@mailbox.org>
        <20230703114949.796c7498@eldfell>
        <cedc57a5-779a-3ec6-cfbd-f51dfb17f2dc@igalia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RCI7vH8+GJgozl35i2VP416";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RCI7vH8+GJgozl35i2VP416
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Jul 2023 12:00:22 -0300
Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:

> Em 03/07/2023 05:49, Pekka Paalanen escreveu:

> > If an application freezes, that's "no problem"; the end user can just
> > continue using everything else. Alt-tab away etc. if the app was
> > fullscreen. I do that already with games on even Xorg.
> >=20
> > If a display server freezes, that's a desktop-wide problem, but so is
> > killing it.
> >  =20
>=20
> Interesting, what GPU do you use? In my experience (AMD RX 5600 XT),=20
> hanging the GPU usually means that the rest of applications/compositor=20
> can't use the GPU either, freezing all user interactions. So killing the=
=20
> guilty app is one effective solution currently, but ignoring calls may=20
> help as well.

I don't know if what I'm seeing is a GPU hang or just e.g. Proton
getting somehow stuck, all I see is a game freezing. I just Alt+tab
back to Steam, force-stop it, and then all is fine again. This is how
it should work regardless of why a game freezes.

However, even if it was a GPU hang, if I am on a display server that
actually handles GPU resets, I don't see why the rest of the desktop
would not be able to recover. Individual apps are each to their own,
but at the very least non-GPU apps and the DE itself should not have
any problem (DE components can simply be restarted automatically).


Thanks,
pq

--Sig_/RCI7vH8+GJgozl35i2VP416
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmSjzYAACgkQI1/ltBGq
qqf57A/+J9tI4ULUUgQi0CJRxT3WNlOsijGRclBAEoWzrasxH0/0DgqoITAq9ne4
Jbsk87BP90f1h8m6c3Y/sVN13jf7tA6v2PmPs7oxGp1c4tfaNq12I9a9/+eQTCwy
LW4/S+WN32sYXkf1pEcEd+wNav/MpmGu+LlxEUy7pGZYKP3FHJgScBBqzUnlapzJ
QM+I8VeAAyvQIUm8+PgAPjdOueBk8oGXNitShieCH3Y2foxFTG/Uc5s7dOduZ60z
vPOMdsSfCp276P759G94rg+RlQSsfrjmXTurFOvrdozQRdBAGR4aQQbCN8czmGAD
e3PFKY/Cl7vpJI31wyt+r0CzB28eBm6lEsmDKcLzrX9AhywyWTlmCK48bzb+076L
7fwsjZdEm6zsAtmNv4QvGj91UHDd2G9nQpPiSzWudLM5KTBA2zLSfgQXUrcbsQzh
euVwnBi0tIQgdXZBmMF0+xLiFmBke9+UfrIMZZNLyW/crVxKVvkma6qn7VUVrmCk
5IES1FCoQ9C3uqTneBKnLs3nxgKuQsynFP6UEzjU46EQjC5WN/8gdl0nrpRAKVa0
+KKsLE2j5m9+B4nE6BX0iavPSGVSM6DQjQl5hIsHE0x4hfLfmd5AnXxPzaAKGd8T
cdb+nEpiJrEvOFpNN7RlW/FdaD54aO2U0lcGyfIe0vKiGSeXXzw=
=VVvG
-----END PGP SIGNATURE-----

--Sig_/RCI7vH8+GJgozl35i2VP416--
