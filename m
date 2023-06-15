Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AE3731058
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244113AbjFOHRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243699AbjFOHQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:16:20 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D77A1BE8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:14:19 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f60a27c4a2so9480054e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686813257; x=1689405257;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yrFsUwF67Fg92S5lQoOceMy81c5+nhthL7wyuVRyQwI=;
        b=l7O/k6m7lZxgyJOgSVKmyFvmsyb26EbUAyLUMbruiN1aDbjnqavPDFDXwdfwJ8SJBX
         x/KTt0Vg/K+3JKv0KCgCcANYQPhw4k9w+4COSO4JoHaWRWN/c/NB/JjXelWf/83oXqS8
         IHNwLU9Id40IiKfC+LbXO+yWmJnH5S2XHL1H3EUVwcMEA3jVvmUvdgLTQZ/GNRXZo9xl
         CurGeerQbdgqCo2yCUpQR69Vz081X10SJXQ6JOQHhDFV7eMj/x2W90/cDMOYQp7CsOLB
         tXvAFFq8uAHksnGvueKfitQ6eV3qkEoBUNZNgaGADKDjngwDngIIN6ri3USBiKki4xS0
         slzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686813257; x=1689405257;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrFsUwF67Fg92S5lQoOceMy81c5+nhthL7wyuVRyQwI=;
        b=fq8mb6FfJxyH2JWPZE4qkslZN9xJNy6Wdnl5OR273nOVKcok4ZKfWzE4qg/URDoN+D
         RauuDaSuQCds6KTcWB8U3iZwr4U1MPIGgair3D2SGDLEfvG6fTizZk3dl/dnpoV5dVkO
         zVDD48l6Ru4EMuG9nxvns0tDV/Iu3tEJ2a/EmJayzzU1Q+0AbxIs87V0S2K0oxySrnrV
         stw32PBfuzc+jUhtuQy/3BammxqnhEmn2JbZOkh9c0r2ZEVTPwviyvQxLfe/CAKtDR5+
         pshsiDmEg4M0rxaLydYZyq6j9argvvi22RT18MZ59ABfovvUYLYvyelZGljPiSyFfsYd
         /iFQ==
X-Gm-Message-State: AC+VfDyejonKWre6AgzdEgS6xFSBM4KCpCHjjWGz5+Wl+W82/rFCmM3t
        tbAwcycX4FTTv2sqgPdTg/4=
X-Google-Smtp-Source: ACHHUZ5RbtwEJAok/7HhXLJoZhHmPaOYEWl1U2NUdMpfWofqrKc3wvOdyWOTaOJET6g6sFwGkBanfg==
X-Received: by 2002:a19:6602:0:b0:4f5:1ca1:30ce with SMTP id a2-20020a196602000000b004f51ca130cemr8518099lfc.47.1686813257053;
        Thu, 15 Jun 2023 00:14:17 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id w12-20020ac254ac000000b004db51387ad6sm2458666lfk.129.2023.06.15.00.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 00:14:16 -0700 (PDT)
Date:   Thu, 15 Jun 2023 10:14:05 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        daniel@ffwll.ch, harry.wentland@amd.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        Rodrigo.Siqueira@amd.com, sunpeng.li@amd.com, tzimmermann@suse.de,
        Xinhui.Pan@amd.com, laurent.pinchart+renesas@ideasonboard.com,
        Shashank Sharma <shashank.sharma@amd.com>, alex.hung@amd.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, seanpaul@chromium.org,
        kernel-dev@igalia.com, bhawanpreet.lakha@amd.com,
        nicholas.kazlauskas@amd.com, Joshua Ashton <joshua@froggi.es>,
        sungjoon.kim@amd.com
Subject: Re: [RFC PATCH v2 00/18] Add DRM CRTC 3D LUT interface
Message-ID: <20230615101405.09745e65@eldfell>
In-Reply-To: <yevhvooznvpqbuybp7tmbo6qgrbxzqrs4y2k4onrjnfbcz42et@hmiwqw74dhgc>
References: <20230109143846.1966301-1-mwen@igalia.com>
        <yevhvooznvpqbuybp7tmbo6qgrbxzqrs4y2k4onrjnfbcz42et@hmiwqw74dhgc>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.24; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rJjznHK9PsJ_u9hxzrsX5CV";
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

--Sig_/rJjznHK9PsJ_u9hxzrsX5CV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Jun 2023 17:43:55 +0200
Jacopo Mondi <jacopo.mondi@ideasonboard.com> wrote:

> Hello
>=20
>    I'm completing the support for 3D LUT on R-Car DU peripheral
> and I have used this series as a base.
>=20
> I'm wondering, since quite some time has passed without any update if
> this series is still a thing and it makes any sense for me to try to
> bring it forward.
>=20
> I'm asking as I've noticed:
> "[PATCH 00/36] drm/amd/display: add AMD driver-specific properties for co=
lor mgmt"
>=20
> which seems to supersede this proposal with driver-specific
> properties.
>=20
> I asked Melissa privately but I wasn't able to get an hold of her, so
> if anyone has any clue feel free to reply :)

Hi,

since no-one else replied, I'll point you to the thread starting at
https://lists.freedesktop.org/archives/dri-devel/2023-May/403173.html
and continuing to June. That is the plan of getting a common UAPI for
these things.


Thanks,
pq


>=20
> Thanks
>   j
>=20
> On Mon, Jan 09, 2023 at 01:38:28PM -0100, Melissa Wen wrote:
> > Hi,
> >
> > After collecting comments in different places, here is a second version
> > of the work on adding DRM CRTC 3D LUT support to the current DRM color
> > mgmt interface. In comparison to previous proposals [1][2][3], here we
> > add 3D LUT before gamma 1D LUT, but also a shaper 1D LUT before 3D LUT,
> > that means the following DRM CRTC color correction pipeline:
> >
> > Blend -> Degamma 1D LUT -> CTM -> Shaper 1D LUT -> 3D LUT -> Gamma 1D L=
UT
> >
> > and we also add a DRM CRTC LUT3D_MODE property, based on Alex Hung
> > proposal for pre-blending 3D LUT [4] (Thanks!), instead of just a
> > LUT3D_SIZE, that allows userspace to use different supported settings of
> > 3D LUT, fitting VA-API and new color API better. In this sense, I
> > adjusted the pre-blending proposal for post-blending usage.
> >
> > Patches 1-6 targets the addition of shaper LUT and 3D LUT properties to
> > the current DRM CRTC color mgmt pipeline. Patch 6 can be considered an
> > extra/optional patch to define a default value for LUT3D_MODE, inspired
> > by what we do for the plane blend mode property (pre-multiplied).
> >
> > Patches 7-18 targets AMD display code to enable shaper and 3D LUT usage
> > on DCN 301 (our HW case). Patches 7-9 performs code cleanups on current
> > AMD DM colors code, patch 10 updates AMD stream in case of user 3D LUT
> > changes, patch 11/12 rework AMD MPC 3D LUT resource handling by context
> > for DCN 301 (easily extendible to other DCN families). Finally, from
> > 13-18, we wire up SHAPER LUT, LUT3D and LUT3D MODE to AMD display
> > driver, exposing modes supported by HW and programming user shaper and
> > 3D LUT accordingly.
> >
> > Our target userspace is Gamescope/SteamOS.
> >
> > Basic IGT tests were based on [5][6] and are available here (in-progres=
s):
> > https://gitlab.freedesktop.org/mwen/igt-gpu-tools/-/commits/crtc-lut3d-=
api
> >
> > [1] https://lore.kernel.org/all/20201221015730.28333-1-laurent.pinchart=
+renesas@ideasonboard.com/
> > [2] https://github.com/vsyrjala/linux/commit/4d28e8ddf2a076f30f9e5bdc17=
cbb4656fe23e69
> > [3] https://lore.kernel.org/amd-gfx/20220619223104.667413-1-mwen@igalia=
.com/
> > [4] https://lore.kernel.org/dri-devel/20221004211451.1475215-1-alex.hun=
g@amd.com/
> > [5] https://patchwork.freedesktop.org/series/90165/
> > [6] https://patchwork.freedesktop.org/series/109402/
> > [VA_API] http://intel.github.io/libva/structVAProcFilterParameterBuffer=
3DLUT.html
> > [KMS_pipe_API] https://gitlab.freedesktop.org/pq/color-and-hdr/-/issues=
/11
> >
> > Let me know your thoughts.
> >
> > Thanks,
> >
> > Melissa
> >
> > Alex Hung (2):
> >   drm: Add 3D LUT mode and its attributes
> >   drm/amd/display: Define 3D LUT struct for HDR planes
> >
> > Melissa Wen (16):
> >   drm/drm_color_mgmt: add shaper LUT to color mgmt properties
> >   drm/drm_color_mgmt: add 3D LUT props to DRM color mgmt
> >   drm/drm_color_mgmt: add function to create 3D LUT modes supported
> >   drm/drm_color_mgmt: add function to attach 3D LUT props
> >   drm/drm_color_mgmt: set first lut3d mode as default
> >   drm/amd/display: remove unused regamma condition
> >   drm/amd/display: add comments to describe DM crtc color mgmt behavior
> >   drm/amd/display: encapsulate atomic regamma operation
> >   drm/amd/display: update lut3d and shaper lut to stream
> >   drm/amd/display: handle MPC 3D LUT resources for a given context
> >   drm/amd/display: acquire/release 3D LUT resources for ctx on DCN301
> >   drm/amd/display: expand array of supported 3D LUT modes
> >   drm/amd/display: enable 3D-LUT DRM properties if supported
> >   drm/amd/display: add user 3D LUT support to the amdgpu_dm color
> >     pipeline
> >   drm/amd/display: decouple steps to reuse in shaper LUT support
> >   drm/amd/display: add user shaper LUT support to amdgpu_dm color
> >     pipeline
> >
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   6 +
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   3 +
> >  .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 370 ++++++++++++++++--
> >  .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   2 +
> >  drivers/gpu/drm/amd/display/dc/core/dc.c      |  49 ++-
> >  drivers/gpu/drm/amd/display/dc/dc.h           |   8 +
> >  .../amd/display/dc/dcn301/dcn301_resource.c   |  47 ++-
> >  .../amd/display/modules/color/color_gamma.h   |  43 ++
> >  drivers/gpu/drm/drm_atomic_state_helper.c     |   7 +
> >  drivers/gpu/drm/drm_atomic_uapi.c             |  24 ++
> >  drivers/gpu/drm/drm_color_mgmt.c              | 127 ++++++
> >  drivers/gpu/drm/drm_fb_helper.c               |   5 +
> >  drivers/gpu/drm/drm_mode_config.c             |  21 +
> >  include/drm/drm_color_mgmt.h                  |   8 +
> >  include/drm/drm_crtc.h                        |  32 +-
> >  include/drm/drm_mode_config.h                 |  25 ++
> >  include/drm/drm_mode_object.h                 |   2 +-
> >  include/uapi/drm/drm_mode.h                   |  17 +
> >  18 files changed, 757 insertions(+), 39 deletions(-)
> >
> > --
> > 2.35.1
> > =20


--Sig_/rJjznHK9PsJ_u9hxzrsX5CV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmSKuj0ACgkQI1/ltBGq
qqe8XA//XCXGFNkvRIsziHo93leKthmBCKTNSiMFZW0hyDvtXE0HQpfYDyt9acqi
zbR0XS9uvR2pMU1FiwD24RJ6oM6KNg3dmpAcd+Ge7CsNzthu4LqOAOw5XC6P5lDE
R0uADPC7zYeyiQcptVYLxdbTfZHJKPgy2mylpkr98RmErYl9SCY/g8rONGLzAc0p
tAhBKpKpqlbQXHdr+RWFheqTCe3XvPoXAUmJHOHlW11WiSmFWis5/yyEh/6qQwc5
syBtsuyt55HWHZWtOo9ZeJzhicR163cgQdKlcJM0ybtn6+sBGoghrpyjAWy+nWEY
WEIQDJ7USEIUMLWXR1usMklb5bIcaDhHbQW0Uu/oFzyKRRbjLgTCiryXcyzIhKqj
wOQsdtS3xQP0WxbYLrV3CrMUIj9bxAXwefNXrfiRbqZVhJknwUUFYLVlw8FZnrbl
mrWCZI0T9420x0i7HGFGSFNOogYdnyhLonToK1QM/yGsdwaVjS7NqrTV5N421SFT
nr8nM8HZ6ujjnKZGhuLBeHOxOdMbqaNUFd8IzFYn7HI8NZSMq5p9LOYZRjtu/yzn
Q/CLPzWcI4KiY/luYiG3HLk6GAqJh73lJExAeo3c9lmOhoDnpzA4rZsWdZ1aa5jI
+dBO4dOuS0JkJFW/NJ8TZpfbGB/EZjcJvvBMkuG4W1pk/j4MSps=
=sYv9
-----END PGP SIGNATURE-----

--Sig_/rJjznHK9PsJ_u9hxzrsX5CV--
