Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887FF6C0D2B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjCTJYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjCTJXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:23:39 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0089234E0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:22:56 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id bc12so11146424plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679304175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CzDHJfzg6ymj/2kYsYe/76LlqdX5RlwbqnYIBtADvSA=;
        b=OzQaIWXYak+Ii5KQxOH0wopXAsCGkgtKVPSolE1NXMowMylUuJBZO82EgCQwIqUnkf
         qhgV90wEuA3GIYu58nktn3fvGnLtJGWhEurkmdLCLAlorPfpwfbHl21Ty2yv5JRu68z5
         ZpOFg0+bVAv1ReRRBU0vaI6QwcqIF+CB2Sk8Td5wh1n2iHfSR4zk6i4EPTZwfwCfiKMU
         4fJoozegD2lP3zuOnYeDqdzlIg1PWlDqqgEiem0//IwHbzCJI9x8n4COPJJ8BgR5lg0M
         u3nDnCUQy10PLb5Z64xMbesGP2FkkyEFBzkBQnbZXon/QmcYW02+3vvUuovJ+kcuCjQP
         YLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679304175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzDHJfzg6ymj/2kYsYe/76LlqdX5RlwbqnYIBtADvSA=;
        b=yFctn6uAEgC50UmBi1sAQ0toWYSWkmbTbQwMNtmXUMiEu3f1EQpx/QsW9A0nhkZzTX
         CgDhT9ntJwMb1t0+QSn+FZ12zqJwPHCdWuAyfpKBwkV/1V+hGtXmdQ7q24Z3J8uz0WAd
         qTaex5cPCILY7VkVx3P33NCg4xiaM5a0lLQdYkSnzlxmg3I99nazuQcxfF1JXHoP5Fo+
         TZBass1r5kG4WOa6Ymbf9kJiMh7vSj4DO3xTYtsJA5cjSvaTr2CqSi4NkwGu2AYB2ebV
         8+lWqlLrhcXvcnZ6SgXqwfzb1evsjWohgDId+jIWTpei1ieyfWCfLxr5DEU7ELBD9oqf
         bUoA==
X-Gm-Message-State: AO0yUKUL2Mh7l3tILiznwO+a9z3ymoD9t1wrjf8zLRQUE6dzh4lh9oUg
        UBCwo20+CXR6t6NqEvZymQvL+kjo+7ugsg==
X-Google-Smtp-Source: AK7set80p1kE/yvUyRsQ81/5vyrNy88Pa2l3+EiIb6a5VMhZzzboUgSSftgNBEmpIwjpApBm5TXTfg==
X-Received: by 2002:a17:902:e742:b0:19f:380e:9cca with SMTP id p2-20020a170902e74200b0019f380e9ccamr18697605plf.20.1679304174840;
        Mon, 20 Mar 2023 02:22:54 -0700 (PDT)
Received: from debian.me (subs09a-223-255-225-69.three.co.id. [223.255.225.69])
        by smtp.gmail.com with ESMTPSA id bi11-20020a170902bf0b00b0019f11caf11asm6202334plb.166.2023.03.20.02.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 02:22:54 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 602F11065D0; Mon, 20 Mar 2023 16:22:51 +0700 (WIB)
Date:   Mon, 20 Mar 2023 16:22:50 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     David Wang <00107082@163.com>, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org
Subject: Re: [Debian Package]Regression 6.3-rc3: version is empty  for
 linux-headers installation dir
Message-ID: <ZBgl6tbOT0GdIqb4@debian.me>
References: <33233f0e.3970.186fdf28bc7.Coremail.00107082@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BENAmvkmHN2cxxdR"
Content-Disposition: inline
In-Reply-To: <33233f0e.3970.186fdf28bc7.Coremail.00107082@163.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BENAmvkmHN2cxxdR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2023 at 03:36:16PM +0800, David Wang wrote:
> This could be fixed by adding back the definition for version
>=20
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index c5ae57167d7c..1870b2485217 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -216,6 +216,7 @@ install_libc_headers () {
>  rm -f debian/files
> =20
>  packages_enabled=3D$(dh_listpackages)
> +version=3D$KERNELRELEASE
> =20
>  for package in ${packages_enabled}
>  do
> --

Hi,

Looks like your fixup is corrupted (tabs converted to spaces). Can you
please send the proper patch (see
Documentation/process/submitting-patches.rst)?

Also, see Documentation/process/email-clients.rst) for guides on
configuring your email client for kernel development.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--BENAmvkmHN2cxxdR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZBgl5wAKCRD2uYlJVVFO
ox8/APkB9AAoXSLkUsuzIroOgebRWIKmMZKBUhoktxWoAPXq9AEAsYsDS8cyRCZ6
NbbyT+dKZE6IRHE6xM5xYxbwsZjDowA=
=PkKU
-----END PGP SIGNATURE-----

--BENAmvkmHN2cxxdR--
