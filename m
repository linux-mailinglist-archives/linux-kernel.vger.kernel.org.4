Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3896F8455
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjEENql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjEENqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:46:39 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC646191C2;
        Fri,  5 May 2023 06:46:38 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64115eef620so19695365b3a.1;
        Fri, 05 May 2023 06:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683294398; x=1685886398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8bRq4rtERRLO3O9RzrLvDMxEszKCxH/+PYf5iKu/L0o=;
        b=IssYN6yNBQ2tAmJ5lWyHsyY+jPFzR1pOVwv1ZLF1a0NhvMU9cM0ugjOczvggNAhKI2
         cW0HMBE1mgWRv6/rECbNEkpAinP0p22AcX8g/xlDkD2DNXdlENxxy1OOJgQ5qGoIOnu1
         Qh8eC/HhtP1d33Ss50F56CjZgmjSiyGEmqky4+Lm4p09fw5lfPjP4z5POGNlCaVKOYzO
         g/YR+yrpjMkuqsaohWI9ZCMAfupKEFYlTVXUIU9mpRgL9sQhAKM8KdCI9tibK+BF54ho
         QHsabtX3xf2t9HvE6fbtYb7mCTKyeyTVCqdn+r2PRDRkiln7Ea1XFUrMWEJsiY/nAH45
         Fllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683294398; x=1685886398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bRq4rtERRLO3O9RzrLvDMxEszKCxH/+PYf5iKu/L0o=;
        b=MhDrW+ClCi6mAB3/lRULLMv99mnXtekiGmK46N/f2K22yFCGU106c2Z8ugMDtsTyYL
         U8Xo2hryZR3CPbdA+zM/HmT6WQyTyMfW0bAJ37ZXbt4kBr3L9PX9XiVcvdUuB6RUXsBt
         axBHROIKkmMuJWQB2E5P7okl0WCN8qCw41cGEjeU7WMuZQfuxv5KAajdJVi84Of4BYsP
         7kQBwCU1fnAws2htsfIyySnPo5RWlnQbwYUIVVJOV+Uqzw6yVm5THaG4Uwm1V9YU1jxB
         Mq3FWfmEAshD59S4aDso2Mvt+5iEgDmun4rDKU6jejVnBewftcVr/Tv8P0ZI1YihltvX
         aVXQ==
X-Gm-Message-State: AC+VfDyYBrL1Le3pyJE5Usan3L66Ckmtm7Svh3Q5sLwlKTDOiqzKOQeW
        dSBXdrzb3wmScIlGjzZ2Xws=
X-Google-Smtp-Source: ACHHUZ4bJde5iLkES5Vb/pf6epC7xZNmBLKX1JUXWEPFBgLorui1LXZpF4wZykchI1DeANc6iVcc9g==
X-Received: by 2002:a05:6a20:4309:b0:f4:c0d6:87c with SMTP id h9-20020a056a20430900b000f4c0d6087cmr2081508pzk.14.1683294398138;
        Fri, 05 May 2023 06:46:38 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-14.three.co.id. [180.214.232.14])
        by smtp.gmail.com with ESMTPSA id v23-20020aa78517000000b006439bc7d791sm1532349pfn.57.2023.05.05.06.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 06:46:37 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 980A8106281; Fri,  5 May 2023 20:46:33 +0700 (WIB)
Date:   Fri, 5 May 2023 20:46:33 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux x86 Architecture <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux perf users <linux-perf-users@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [BUILD] Unable to sign drivers on Ubuntu 22.04 LTS desktop
Message-ID: <ZFUIuW58QjfTaRxt@debian.me>
References: <bb89a720-b1b2-18fc-7f89-44267885700d@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eF7GadaFw3DUPxSA"
Content-Disposition: inline
In-Reply-To: <bb89a720-b1b2-18fc-7f89-44267885700d@alu.unizg.hr>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eF7GadaFw3DUPxSA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2023 at 07:02:57PM +0200, Mirsad Goran Todorovac wrote:
> Hi Bagas,
>=20
> I seem to have run into a dead end with this.
>=20
> OpenSSL 3.0.2 refuses to cooperate, despite enabling legacy ciphers:
>=20
> =C2=A0 BTF [M] net/nsh/nsh.ko
> =C2=A0 BTF [M] net/hsr/hsr.ko
> make -f ./Makefile ARCH=3Dx86 =C2=A0=C2=A0=C2=A0 KERNELRELEASE=3D6.3.0+ i=
ntdeb-pkg
> sh ./scripts/package/builddeb
> =C2=A0 INSTALL debian/linux-image/lib/modules/6.3.0+/kernel/arch/x86/even=
ts/intel/intel-cstate.ko
> =C2=A0 SIGN debian/linux-image/lib/modules/6.3.0+/kernel/arch/x86/events/=
intel/intel-cstate.ko
> At main.c:170:
> - SSL error:1E08010C:DECODER routines::unsupported:
> ../crypto/encode_decode/decoder_lib.c:101

I didn't find any errors using self-compiled OpenSSL 3.1.0. I installed the
library to `/tmp/openssl` and specify
`KCFLAGS=3D-L/tmp/openssl/lib -I/tmp/openssl/include` when building bindeb-=
pkgs.
Am I missing something?

--=20
An old man doll... just what I always wanted! - Clara

--eF7GadaFw3DUPxSA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFUItAAKCRD2uYlJVVFO
o4pvAP9190LFAsa4XET4auqV33+yu5hZQvt30jmUmLCWx0EiEQEA4P+jsvEjukEg
aUHCqcYykvJCja7hz3SxjHh6lcSJfwI=
=vkpX
-----END PGP SIGNATURE-----

--eF7GadaFw3DUPxSA--
