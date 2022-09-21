Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30B85BF98E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiIUIot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiIUIop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:44:45 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F57E13CD3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:44:42 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1C6523F173
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1663749879;
        bh=DqH0K51UyTYbMdPeDdb50Ry7JZRrT9mZT8SvU172pnE=;
        h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=DulQt+lYZLmcxVrL3GOAGzql8FiJv28hUy9zV8ASdCzngN50PBFkClRtw1A3+DvfP
         PAO2wB44avbs9FxX9A9hPqYCoLqgbGrV98N+uaSRMmBhJBaJaMpvzdhCSNkPJHH0T0
         nYPCzohRC/sOwPxKKNnBgoid4Itpe6N8Dln/Axwl8sdaOnJez65FS3JWd+FilyevwM
         /eX6WCP+qfD0VEreqCjAZvOhcwVbnkwbmEn7fLlnFVnV/FvxrxRHjehexSi7rXFQdh
         4+sTqAxpOSZmEA5HbtWtWwljIvCFqAyPdmI4y/PHYVjoiEJsQUqKRyg/Mbvrm1Bf5l
         cXmKbzsIRJZMA==
Received: by mail-ed1-f72.google.com with SMTP id m13-20020a056402510d00b004519332f0b1so3824712edd.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DqH0K51UyTYbMdPeDdb50Ry7JZRrT9mZT8SvU172pnE=;
        b=r2s4vr52RyNdqlKmJaE2ioHlCEAeMGLIYNT5w484LoO2DKuzezilElel8cX2PlL69B
         4cDStRcpICFYbeRtmnP3P39svi2Gw2lFN/jOHwlx/SbWlsRLbMnshPzg0u7Jb9EkjLqz
         0zhM2MhFjjaEyEfMloRZo3B9Aht3J1XWHKyAih7wluhT+ikbqvQfJJfnjZxEIXLWZFmU
         PUD2JbgG/eAxoLj/FfyxdNzQkTdSGvIcpRZtUamNQeAI3RzxitD/rMbhRnqOutItBh2A
         pskHCSk0n/PbHRa5Kto0aeL4HlOxQg8SgpKuPdMl/g9qaUgZS09WExHF3l/V2bKzv66V
         s8Bg==
X-Gm-Message-State: ACrzQf12ovtg6v02nredPnyged+0Ze9c/C+fxBnoM54V8la5h2qH0038
        M5XCgao3CYB9d6oh8KVNsHxirBeBbTsoqlwI38LdlgVE88oYpOff30S/oxnT9/LuNaJS1g9gscO
        pUy7eI0zMW8Nlwef3aPCco7ccveucN/U0ucwZG0dWew==
X-Received: by 2002:a05:6402:440d:b0:450:de54:3fcf with SMTP id y13-20020a056402440d00b00450de543fcfmr23466752eda.312.1663749878094;
        Wed, 21 Sep 2022 01:44:38 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5FW8Ihpne98QK7GKfHf3O43P8AlLC1ErQ10ZILYuYb6+RHESHYxpgqfolFFnhgsAZzdZkxNw==
X-Received: by 2002:a05:6402:440d:b0:450:de54:3fcf with SMTP id y13-20020a056402440d00b00450de543fcfmr23466739eda.312.1663749877878;
        Wed, 21 Sep 2022 01:44:37 -0700 (PDT)
Received: from smeagol ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7df8a000000b0044e01e2533asm1429972edy.43.2022.09.21.01.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 01:44:37 -0700 (PDT)
Date:   Wed, 21 Sep 2022 10:44:34 +0200
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     Josh Boyer <jwboyer@kernel.org>
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        Peter Robinson <pbrobinson@fedoraproject.org>,
        Takashi Iwai <tiwai@suse.com>, contact@laurentcarlier.com,
        mpagano@gentoo.org,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Jared Dominguez <jaredz@redhat.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: linux-firmware signed commits; does anyone care?
Message-ID: <20220921104434.2529c45d@smeagol>
In-Reply-To: <CA+5PVA5ymJ-ghhhCfEBPxBynucF3gD+nHVNwcZkC5bsVotatDQ@mail.gmail.com>
References: <CA+5PVA5ymJ-ghhhCfEBPxBynucF3gD+nHVNwcZkC5bsVotatDQ@mail.gmail.com>
Organization: Canonical Ltd
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SMLZX+r.Pk4dPIyz4DXcpay";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SMLZX+r.Pk4dPIyz4DXcpay
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

I don't care much about GPG signed commits so dropping them is fine by me.

...Juerg


> Some time ago, we went back to doing ~monthly releases for
> linux-firmware primarily to help distributions package firmware in a
> simpler manner.  We GPG sign the tarballs, as is good practice, but as
> part of reintroducing the tarballs we also started having a
> linux-firmware maintainer GPG sign *every* commit done by a
> maintainer.  The intention there was that because we're dealing with
> binary blobs we really have no recourse to see changes unlike a source
> code repo.  The signed commits at least provides a measure for
> interested people to ensure the repo itself is only being committed to
> by a recognized maintainer and it isn't compromised (in theory).  The
> downside is that pull requests are merged non-ff and we wind up
> signing the merge commit.
>=20
> The question at hand though, is does anyone care about the GPG signed
> commits?  It's not clear to me this practice is even noticed nor if it
> is bringing any value to this project.  Since we've started this
> practice, I am literally the only one committing to the repo and while
> it isn't hard to do I want to know if it's actually useful to anyone.
>=20
> I ask for two separate reasons.  The first is that a group of
> interested firmware submitters is looking at modernizing the workflow
> for the linux-firmware project and moving to a merge request workflow
> instead of submitting giant binary blob patches via email.  This would
> allow us to put some CI in place for simple checks to the WHENCE file,
> etc.  Doing this while still having GPG signed commits isn't
> impossible but it certainly complicates things a bit, and would likely
> require a trusted bot to sign commits.  That has implications on
> secret storage and changes the dynamic on trust levels that make the
> whole thing even more questionable.
>=20
> The second reason is that even if people are validating the GPG signed
> commits, it's not exactly user friendly.  I've been looking at
> sigstore and recor and that might be a better solution in the long run
> if we do want to utilize something like the current scheme.
>=20
> I'll still GPG sign the tarballs, but I'd like to propose dropping our
> current self-imposed requirement that all commits are GPG signed.
> Thoughts?
>=20
> josh


--Sig_/SMLZX+r.Pk4dPIyz4DXcpay
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmMqzvIACgkQD9OLCQum
QreUbw//Qs3WlJnIyQRd4qkIDZUZH+d+Qn9dDXPXCWKP4n60mm2oqZQaSBCLombt
Lba5wqFF6Zva9lmo22Tg4ojBkt8KgmYSW0SRgJLOJV6iHBI/x+WiWG6aklSvAGIv
Q8F/H6HbkXCHak1wiNb8f5XsBMsYE8BwqUELY65emfSBJhS2aZ1I2buHX7w5j011
gWXZI2gbMmUyF616WqMcpbNxdo+CRb1Y4n9EgZBnU3fNyY/dTeQaH6FNAooCEWRa
KGw49nX2uIZoYRh7NBuU106GT4RGXQiQ8zgCpB+8WpA3Qw9Yxtpu3unL0KMbdZMa
9XKwEWIV7d/jSRUWrDRGXtn+YSv8uXwOf9PfxtZNiw7aqiI7iG7j2gIpaWWjkV75
osRzI/jWLKrxDRh1ucz5AM9vSM4GSzKM/Fpi+PyjD0RtTsCcIkKi9cCem/vjMqjs
AqZBI+l4lkuy3D1Kf3z0G64ILeoHz3t1ww1tPoWJhMjvya07Oni+vJeKnIENCKf0
hoMtFeQ/ePm9lkq1/bsFVrydEqWS0aQJg+9zO8cBswVgwJTyot2BM596Vloxp0i1
qD8aoVaBweI72IDUmTUkzF5Y5NW4aYcNpe29nRL4qKXhghwUvexpE8G1M+IXsswn
IT+xcsk7Pk0cQwEvxVQiFsIhljukuPsXB307iylfMkEFBpfgQ7c=
=vITi
-----END PGP SIGNATURE-----

--Sig_/SMLZX+r.Pk4dPIyz4DXcpay--
