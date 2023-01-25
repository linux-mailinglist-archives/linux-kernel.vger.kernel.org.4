Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C7F67A915
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 04:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbjAYDII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 22:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAYDIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 22:08:05 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CFA1A4A1;
        Tue, 24 Jan 2023 19:08:04 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id k13so16732293plg.0;
        Tue, 24 Jan 2023 19:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YfbAZNKHnQjoQqV+oSEOnJ44206h+RlEkw2Q9ldf62E=;
        b=iJusNhz0PLJmn/MnJP41L/0EUL5RSMoYNO6jtwOZ/BoN/dWeN0qB8GYsLJvZXT9UZD
         6c+YvJdLSf08T2Fea5YMOAnlXM0ZRMszvq8Ls5ds8rS2Y3X81yCEfWdapYBSj5UhHKGS
         uNkIav3DvN9L2kGErazTB9xx4yR9OEJdutI8c8HKIpK2MOc9rb9bE8RcWlpi5yr+vOOS
         dhYtpx2AmREr+aMVnnPlcx3r3fzFg0px1YRzuEzpoePeonxFXyiScQrdQxcVyvPyBjfZ
         2+YhhzV5Nz0RioCrBQsi9wSONKZNiW8W5HtN4BNf7VzYrZXuS+YgVngM3CE49UVgSzN6
         6vhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfbAZNKHnQjoQqV+oSEOnJ44206h+RlEkw2Q9ldf62E=;
        b=wKjFSzzFG4DePJ6npTI6HLy1w1XjRoY1TNKZgEK2ii99TrtI/fh1lliRK1DNvxOeLf
         fuij49S7yksXYh+bWam2cT4B+AWqChPM8A3RtRIWNrpoyf4DeETpynmbV9ymCDRF6o9g
         /NXI0z6vR9Gjox6OxLLUNKOaYNt/aIsCVAqY/y3V7Zn8nYw9PfEvT8dqPl3ZSQ1zT8sT
         wsK1GlBKVu5+1XM9oNZybTYGWCWPdaaMseXCOxIfLUPyiN7iOmTZpvO21Vj8XR7LA9km
         sT10klLkcOGhaPYo9oHPKgSViydRchA/T2K5BG17Xy6Uc7Y7ajcjlRbZ/IHwGIVrYmBI
         O5rQ==
X-Gm-Message-State: AFqh2kpvxgzOtslXNhCTL4imMBZX6Hs1inb0xkkQaZAqzNuzPq1zix31
        b5+99dT7z6xxT148UUrqVUY=
X-Google-Smtp-Source: AMrXdXsdx32XHMWaa76ixUliBWh2tUXGdswiWw6kycW4lPKa4AY8Ade5OM66K88nmP9Kwz5mx6pzzw==
X-Received: by 2002:a17:902:aa48:b0:194:892b:8654 with SMTP id c8-20020a170902aa4800b00194892b8654mr29540451plr.17.1674616084288;
        Tue, 24 Jan 2023 19:08:04 -0800 (PST)
Received: from debian.me (subs02-180-214-232-19.three.co.id. [180.214.232.19])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090274ca00b001948720f6bdsm2390878plt.98.2023.01.24.19.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 19:08:01 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 0A4AE1055E3; Wed, 25 Jan 2023 10:07:57 +0700 (WIB)
Date:   Wed, 25 Jan 2023 10:07:57 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Roxana Bradescu <roxabee@chromium.org>,
        Adam Langley <agl@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] x86: enable Data Operand Independent Timing Mode
Message-ID: <Y9CdDUudjeczrOWz@debian.me>
References: <20230125012801.362496-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dhq4nShMaaV3GoZ4"
Content-Disposition: inline
In-Reply-To: <20230125012801.362496-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dhq4nShMaaV3GoZ4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2023 at 05:28:01PM -0800, Eric Biggers wrote:
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +DODT - Data Operand Dependent Timing
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Data Operand Dependent Timing (DODT) is a CPU vulnerability that makes t=
he
> +execution times of instructions depend on the values of the data operate=
d on.
> +
> +This vulnerability potentially enables side-channel attacks on data, inc=
luding
> +cryptographic keys.  Most cryptography algorithms require that a variety=
 of
> +instructions be constant-time in order to prevent side-channel attacks.
> +
> +Affected CPUs
> +-------------
> +
> +This vulnerability affects Intel Core family processors based on the Ice=
 Lake
> +and later microarchitectures, and Intel Atom family processors based on =
the
> +Gracemont and later microarchitectures.  For more information, see Intel=
's
> +documentation [1]_.
> +
> +Mitigation
> +----------
> +
> +Mitigation of this vulnerability involves setting a Model Specific Regis=
ter
> +(MSR) bit to enable Data Operand Independent Timing Mode (DOITM).
> +
> +By the default, the kernel does this on all CPUs.  This mitigation is gl=
obal, so
> +it applies to both the kernel and userspace.
> +
> +This mitigation can be disabled by adding ``doitm=3Doff`` to the kernel =
command
> +line.  It's also one of the mitigations that can be disabled by
> +``mitigations=3Doff``.
> +
> +References
> +----------
> +.. [1] Data Operand Independent Timing Instruction Set Architecture (ISA=
) Guidance
> +   https://www.intel.com/content/www/us/en/developer/articles/technical/=
software-security-guidance/best-practices/data-operand-independent-timing-i=
sa-guidance.html
> diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/=
admin-guide/hw-vuln/index.rst
> index 4df436e7c4177..cd962f9634dad 100644
> --- a/Documentation/admin-guide/hw-vuln/index.rst
> +++ b/Documentation/admin-guide/hw-vuln/index.rst
> @@ -18,3 +18,4 @@ are configurable at compile, boot or run time.
>     core-scheduling.rst
>     l1d_flush.rst
>     processor_mmio_stale_data.rst
> +   dodt.rst
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 6cfa6e3996cf7..a6a872c4365e6 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1119,6 +1119,12 @@
>  			The filter can be disabled or changed to another
>  			driver later using sysfs.
> =20
> +	doitm=3Doff	[X86,INTEL] Disable the use of Data Operand Independent
> +			Timing Mode (DOITM).  I.e., disable the mitigation for
> +			the Data Operand Dependent Timing (DODT) CPU
> +			vulnerability.  For details, see
> +			Documentation/admin-guide/hw-vuln/dodt.rst
> +
>  	driver_async_probe=3D  [KNL]
>  			List of driver names to be probed asynchronously. *
>  			matches with all driver names. If * is specified, the
> @@ -3259,6 +3265,7 @@
>  					       no_uaccess_flush [PPC]
>  					       mmio_stale_data=3Doff [X86]
>  					       retbleed=3Doff [X86]
> +					       doitm=3Doff [X86,INTEL]
> =20
>  				Exceptions:
>  					       This does not have any effect on
=20
The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--dhq4nShMaaV3GoZ4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY9CdBQAKCRD2uYlJVVFO
o3YWAP9vxo2raPyezzmpJXihfOoPIsfgiDaVQnNuEA2vPpLg/gD7BkpfGEypyQoE
M217c17ZSWa/VpCfJRbSiQBF9Vz0OQ8=
=hiFs
-----END PGP SIGNATURE-----

--dhq4nShMaaV3GoZ4--
