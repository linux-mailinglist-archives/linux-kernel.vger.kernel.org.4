Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34AA7448F2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 14:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjGAM1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 08:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGAM1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 08:27:20 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A003C07
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 05:27:18 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b7f2239bfdso22004565ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 05:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688214438; x=1690806438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xfT+iCg7he7G1O8FrhG+GwexlTOWppSr6nVkF4iOKro=;
        b=G+8kn0ys6ceNbz9BEowkPZHBHhy3YQYW9UgJEBQgXJC6OnYyVTAft19tO2uiwqBLNb
         igEXQtaQo9igvggoezxqDdlCbfN3xCiJH9nJKCH6HXb4cJZG35wkADWnvMmtijFsh5Mh
         7PIX4d87ZaiotIXY34HKEcka5H3sAIXbPLi0L6QXS1CIY0CoIAnKCMCmXTIdcEpSIdRq
         xeQ/3hyQ4kKL6b2ZZIB0mgwzXBpFg4jpt+tndNR1V3Pf0W0MKQ/XAEw3mDBTsUnDlEKb
         u8aKQjsRCTm+KCDZbEMAmlIGM2hS1mEsDUg0BOwzR1M3goETCdyvuREwC3OttU7qSt/p
         UNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688214438; x=1690806438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfT+iCg7he7G1O8FrhG+GwexlTOWppSr6nVkF4iOKro=;
        b=bbXaYV2HjGUL5o5lrNgcfHVQC70uaHt3WCVe0wwIiT4wcWQtceZVTdk6XXVZRMEQFV
         LySDVohGTtU+ydR8+qEWluwjH343mDWsbX3NbZJDstI/gasrgBQCgmwwT3S877d0TCR9
         dbcktee4EUKUqnG5noTTh/5Y5tji65V//dSsgAbospXglWKkcTMdIT5ORZ2cKqZJRaD1
         D/y4OFvqA8iowSitPwmbaGg8xW69FfIkU9p3Kg4ZLjVg49ot+vqI/ix2aOP5GJpOKftu
         DZbEQg8087miFvRVJQo1iTka4bmX2iGY7Al8N6JFnG71le+htkb2BeUb9iFX93gFhD0a
         WwwA==
X-Gm-Message-State: ABy/qLa5RjvdoSRDOsoTJsNeXkLSOq3zY76KXUqISdRrf8tVIln8rgYj
        4fWHOZOC5ZTIBjmL8Lx9Xog=
X-Google-Smtp-Source: APBJJlFl919QV7xve/1RnA+jhn7mf3eSZpbJiJOsrPA8uCkDVgz9/lm87vXf7Gm8cS+z538CbRXVYA==
X-Received: by 2002:a17:903:1c5:b0:1b8:6a09:9cf9 with SMTP id e5-20020a17090301c500b001b86a099cf9mr6402798plh.26.1688214438297;
        Sat, 01 Jul 2023 05:27:18 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902e5cc00b001aae625e422sm10669704plf.37.2023.07.01.05.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 05:27:17 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 4CF3083BEC72; Sat,  1 Jul 2023 19:27:13 +0700 (WIB)
Date:   Sat, 1 Jul 2023 19:27:13 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: Fwd: commit 9df9d2f0471b causes boot failure in pre-rc1 6.5
 kernel
Message-ID: <ZKAboYIj6pAd9CMO@debian.me>
References: <4d9fb4a9-6c48-600c-f625-8ef66208090a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1Y2CUzrFU0UJ5NVe"
Content-Disposition: inline
In-Reply-To: <4d9fb4a9-6c48-600c-f625-8ef66208090a@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1Y2CUzrFU0UJ5NVe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2023 at 09:06:22PM +0700, Bagas Sanjaya wrote:
> Hi,
>=20
> I notice a regression report on Bugzilla [1]. Quoting from it:
>=20
> > Since yesterday my builds of the https://git.kernel.org/pub/scm/linux/k=
ernel/git/torvalds/linux.git no longer boot with a black screen immediately=
 upon booting. Today I finished git bisecting the issue and arrived at the =
following:
> >=20
> > 9df9d2f0471b4c4702670380b8d8a45b40b23a7d is the first bad commit
> > commit 9df9d2f0471b4c4702670380b8d8a45b40b23a7d
> > Author: Thomas Gleixner <tglx@linutronix.de>
> > Date:   Wed Jun 14 01:39:39 2023 +0200
> >=20
> >     init: Invoke arch_cpu_finalize_init() earlier
> >    =20
> >     X86 is reworking the boot process so that initializations which are=
 not
> >     required during early boot can be moved into the late boot process =
and out
> >     of the fragile and restricted initial boot phase.
> >    =20
> >     arch_cpu_finalize_init() is the obvious place to do such initializa=
tions,
> >     but arch_cpu_finalize_init() is invoked too late in start_kernel() =
e.g. for
> >     initializing the FPU completely. fork_init() requires that the FPU =
is
> >     initialized as the size of task_struct on X86 depends on the size o=
f the
> >     required FPU register buffer.
> >    =20
> >     Fortunately none of the init calls between calibrate_delay() and
> >     arch_cpu_finalize_init() is relevant for the functionality of
> >     arch_cpu_finalize_init().
> >    =20
> >     Invoke it right after calibrate_delay() where everything which is r=
elevant
> >     for arch_cpu_finalize_init() has been set up already.
> >    =20
> >     No functional change intended.
> >    =20
> >     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >     Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> >     Link: https://lore.kernel.org/r/20230613224545.612182854@linutronix=
=2Ede
> >=20
> >  init/main.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > Since it might be relevant, my CPU is Intel Core i5-12400 with UEFI fro=
m december 2022 and the compiler is gcc (Gentoo Hardened 13.1.1_p20230527 p=
3) 13.1.1 20230527. If additional information such as the kernel configurat=
ion is required, let me know.
>=20
> See Bugzilla for the full thread.
>=20
> The reporter can't provide requested dmesg due to this is early
> boot failure, unfortunately.
>=20
> Nevertheless, this regression has already been taken care of on
> Bugzilla, but to ensure it is tracked and doesn't get fallen through
> cracks unnoticed, I'm adding it to regzbot:
>=20
> #regzbot introduced: 9df9d2f0471b https://bugzilla.kernel.org/show_bug.cg=
i?id=3D217602
> #regzbot title: early arch_cpu_finalize_init() cause immediate boot failu=
re
>=20

#regzbot fix: 0303c9729afc40

--=20
An old man doll... just what I always wanted! - Clara

--1Y2CUzrFU0UJ5NVe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZKAbmQAKCRD2uYlJVVFO
o+rcAQDuovUL5Ax0sXesVsBWrU8ClRKMg+GF/SJpC0s0l5BY+AEA55qrJEQbGNL9
az1c2oJS1pTEX/fmd9n0wtLXRFR40AU=
=u45Q
-----END PGP SIGNATURE-----

--1Y2CUzrFU0UJ5NVe--
