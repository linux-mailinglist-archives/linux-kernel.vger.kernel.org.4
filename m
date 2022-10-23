Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253C06093CB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 16:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJWOC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 10:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJWOC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 10:02:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4445D73908;
        Sun, 23 Oct 2022 07:02:55 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so1256943pjc.3;
        Sun, 23 Oct 2022 07:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t6pBF/o0natTLuLX/wEXaHuftOiR1PZ0M1sSmiCulEc=;
        b=IUWzmI71fyIUK86PItGrbkGDgECFyiP1DOXhDRI36uIh3LwOJb+pBNZRtiGXBxuR/X
         EkgHrb08gHySShO6zEhRbGtQSD8HXiWRiwsX/q1fb4Rla2P9+yK3DEuXXIoajEbx0KZJ
         O1lMk1WEESOFv1GJwGm8jKsXfcB1ydcOrkxggQ6bgQnfaPn6QQyYl7BTjt3nku5VKDf1
         srM3Rbj9zZMaXgvZpKOjm3Sg6oSAt/TWhe5fI7eu/Rqo3eSw/iNCKi2PS6HmcnvHUD/7
         s4d/neVbaEVYhkCsZ7/kMfwkkOvxCHM/K84QA8S9oqiIfXWOnaDdE7aIujLYTe6abH7O
         I1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6pBF/o0natTLuLX/wEXaHuftOiR1PZ0M1sSmiCulEc=;
        b=lVpqrvX7GN48MDLN2tnHNYceLwHLuvGQJDLiefQ/4gKmrOKDOuYSkAg4T5TW1NLwm6
         Zd4gbLndfUda6fTvO8yM4fvA7sKT5clRaH1a4CAgOG8POmjpX1JRZk5zBL1WkmyC9OFx
         Yyo7NbBsniKWqAmAKgg8+0XIc1AHBFtWMweGNhjIY+0/F2bnfr2+K5Y4RLKvjFa9E8kR
         DqSjZtXYjFmVZeAKg4iD/DCPPwiAlkum3pV8BVSufO6sfDI5OOeJnVA0AQNdpxgH6WcG
         0Zw3MwQnKc9XyPehGAdGbtUBSnQdu+kwQKw2IE3XtFndAJln1Qp22J14THUgENf1jgqI
         oRdg==
X-Gm-Message-State: ACrzQf3FUjROyED0O+vHVl1Qf5HMFIrZ8w7doR4ld1CrbCIui0jLYwbl
        B5pAugkHgoqNXkq+4tEnWhg=
X-Google-Smtp-Source: AMsMyM43NXpGWu4+Am+eBa3FFP7OIWC4DXukJ4PyEXkP7L0HIiDUqvD+1k1Nk6FUUuV+KhrvT3PF6Q==
X-Received: by 2002:a17:90a:6845:b0:210:7ef5:ab99 with SMTP id e5-20020a17090a684500b002107ef5ab99mr24388726pjm.80.1666533774770;
        Sun, 23 Oct 2022 07:02:54 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-1.three.co.id. [180.214.232.1])
        by smtp.gmail.com with ESMTPSA id e28-20020a056a0000dc00b0056afd55722asm4270109pfj.153.2022.10.23.07.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 07:02:53 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id C9886104163; Sun, 23 Oct 2022 21:02:50 +0700 (WIB)
Date:   Sun, 23 Oct 2022 21:02:49 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH 0/3] new subsystem for compute accelerator devices
Message-ID: <Y1VJieGgVv9BwaO3@debian.me>
References: <20221022214622.18042-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KFhUQIkYlmhwSi0N"
Content-Disposition: inline
In-Reply-To: <20221022214622.18042-1-ogabbay@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KFhUQIkYlmhwSi0N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 23, 2022 at 12:46:19AM +0300, Oded Gabbay wrote:
> In the last couple of months we had a discussion [1] about creating a new
> subsystem for compute accelerator devices in the kernel.
>=20
> After an analysis that was done by DRM maintainers and myself, and follow=
ing
> a BOF session at the Linux Plumbers conference a few weeks ago [2], we
> decided to create a new subsystem that will use the DRM subsystem's code =
and
> functionality. i.e. the accel core code will be part of the DRM subsystem.
>=20
> This will allow us to leverage the extensive DRM code-base and
> collaborate with DRM developers that have experience with this type of
> devices. In addition, new features that will be added for the accelerator
> drivers can be of use to GPU drivers as well (e.g. RAS).
>=20
> As agreed in the BOF session, the accelerator devices will be exposed to
> user-space with a new, dedicated device char files and a dedicated major
> number (261), to clearly separate them from graphic cards and the graphic
> user-space s/w stack. Furthermore, the drivers will be located in a separ=
ate
> place in the kernel tree (drivers/accel/).
>=20
> This series of patches is the first step in this direction as it adds the
> necessary infrastructure for accelerator devices to DRM. The new devices =
will
> be exposed with the following convention:
>=20
> device char files - /dev/accel/accel*
> sysfs             - /sys/class/accel/accel*/
> debugfs           - /sys/kernel/debug/accel/accel*/
>=20
> I tried to reuse the existing DRM code as much as possible, while keeping=
 it
> readable and maintainable.
>=20
> One thing that is missing from this series is defining a namespace for the
> new accel subsystem, while I'll add in the next iteration of this patch-s=
et,
> after I will receive feedback from the community.
>=20
> As for drivers, once this series will be accepted (after adding the names=
pace),
> I will start working on migrating the habanalabs driver to the new accel
> subsystem. I have talked about it with Dave and we agreed that it will be
> a good start to simply move the driver as-is with minimal changes, and th=
en
> start working on the driver's individual features that will be either add=
ed
> to the accel core code (with or without changes), or will be removed and
> instead the driver will use existing DRM code.
>=20
> In addition, I know of at least 3 or 4 drivers that were submitted for re=
view
> and are good candidates to be included in this new subsystem, instead of =
being
> a drm render node driver or a misc driver.
>=20
> [1] https://lkml.org/lkml/2022/7/31/83
> [2] https://airlied.blogspot.com/2022/09/accelerators-bof-outcomes-summar=
y.html
>=20

Since this is new subsystem, it should have its own git tree where you
collected accelerator-related patches. By convention, there should be
"next" branch targeting for next kernel release and "fixes" branch for
bugfixes pending for current release. Both branches should be included
into linux-next. The names don't necessarily be that, though.

Also, it had been great if you write short, descriptive documentation
about the subsystem (maintainers handbook).

Cc'ing linux-doc folks.

--=20
An old man doll... just what I always wanted! - Clara

--KFhUQIkYlmhwSi0N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1VJhQAKCRD2uYlJVVFO
o+yTAP0Wq0yPX3TS5HZJ27v0PHGSOWTbOi+nH/lPSH1cS+ol9AD8CHBTzQqZytiP
wolMvwwGEa8J+1fi1Wk5hKbB1ex35g8=
=9xlo
-----END PGP SIGNATURE-----

--KFhUQIkYlmhwSi0N--
