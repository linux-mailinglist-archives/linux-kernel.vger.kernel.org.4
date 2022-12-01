Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2843E63E8B5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 05:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiLAEAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 23:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiLAEAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 23:00:03 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD5A98001;
        Wed, 30 Nov 2022 20:00:03 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 62so567220pgb.13;
        Wed, 30 Nov 2022 20:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3u27R2Bek7iv0nteA3mNAW6zlE4Rn+NadTxyOBYNCYE=;
        b=g7GqNQPPKgBl8AVqOBX1nldXJko08cxXIZol7JMbxv3+9rP80sySJ1EFRkfCf3ns49
         nQ7i9dnF4dEvjfVCSkyUttpij+3RK0YX94Rpl9Quc0ZOm8Yl47cO0H7PqX4svVOrR5a+
         ++QvGGeoF06Q7fCuHTA3p6dMOO9P2Zb5AspAnCGWisekHKmyYnEbMAX0/F9U0L/EjfH5
         Pj7tpA3ZxGEHawsr6YVcYd+K1Fc/wLQBP5PvJItg5aRLnJpTabwjBTZZh6domI/AqyZB
         RUKyzz6Qb5NHuG6MoPX2uoDoYDggpfEv8ONbW6E4uBLhv0GXLLoGJE3K1A05OEHSSTV0
         BjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3u27R2Bek7iv0nteA3mNAW6zlE4Rn+NadTxyOBYNCYE=;
        b=ZXPg9motW54mO6DruzOgQOlQ/H2xEEz2PXQ5Zz51C8eDkk8EY5GPForXx1hydVTXyx
         EeF+hlSzqzbnOHY7bu3qOnkuRZezHRp185Aat8Lhm1RnrjODH8RFaGpEUL1QzHJkRdOs
         SI0weFhJJPMfOWDwR4Bqb1J1dNmTALqD6hOjQ9xdc/y/d6TDre8aVgPxarawGW4aOLO1
         Yrfa8cW9rPubu+amtyQmSlLoQL+jHS6jFAm2dxtJH4z5k4QbdLhSoLl4PdWrg5mxZawk
         js00bV5K5RVQ2vd+zcMYsFkmRVSy3SrB7vihz5gt2V6woDqchuOcqWmyWHACL7hpnrm/
         Unpg==
X-Gm-Message-State: ANoB5pmxwSjhMbtJYbEiP9kAYhxCG75bniHVonLEfCd+O1vcetgALG3i
        Encb5T0DvGEH6Mcaz4ZFAs4=
X-Google-Smtp-Source: AA0mqf4G5WsfaoSXAZmk3gLpWitEpaDIQRYw6THB/em0/T4whxOwMsUofXIxCqHW0O/ehE8WSbKR5Q==
X-Received: by 2002:a63:4246:0:b0:477:98cc:3d01 with SMTP id p67-20020a634246000000b0047798cc3d01mr36685431pga.505.1669867202442;
        Wed, 30 Nov 2022 20:00:02 -0800 (PST)
Received: from debian.me (subs02-180-214-232-12.three.co.id. [180.214.232.12])
        by smtp.gmail.com with ESMTPSA id r6-20020a632046000000b0046ec0ef4a7esm1638688pgm.78.2022.11.30.20.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 20:00:01 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 073551042F6; Thu,  1 Dec 2022 10:59:57 +0700 (WIB)
Date:   Thu, 1 Dec 2022 10:59:57 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 3/3] Documentation/osnoise: Add osnoise/options
 documentation
Message-ID: <Y4gmvRtWP/7hbytz@debian.me>
References: <cover.1669832184.git.bristot@kernel.org>
 <255d17a89bcd9ca8eef6931c0052b1a520e0b580.1669832184.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kQF009BxO1PPXLiK"
Content-Disposition: inline
In-Reply-To: <255d17a89bcd9ca8eef6931c0052b1a520e0b580.1669832184.git.bristot@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kQF009BxO1PPXLiK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 30, 2022 at 07:35:42PM +0100, Daniel Bristot de Oliveira wrote:
> diff --git a/Documentation/trace/osnoise-tracer.rst b/Documentation/trace=
/osnoise-tracer.rst
> index 3c675ed82b27..f2008e317223 100644
> --- a/Documentation/trace/osnoise-tracer.rst
> +++ b/Documentation/trace/osnoise-tracer.rst
> @@ -92,8 +92,8 @@ Note that the example above shows a high number of HW n=
oise samples.
>  The reason being is that this sample was taken on a virtual machine,
>  and the host interference is detected as a hardware interference.
> =20
> -Tracer options
> ----------------------
> +Tracer Configuration
> +--------------------
> =20
>  The tracer has a set of options inside the osnoise directory, they are:
> =20
> @@ -115,6 +115,22 @@ The tracer has a set of options inside the osnoise d=
irectory, they are:
>     NO_OSNOISE_WORKLOAD disables the OSNOISE_WORKLOAD option. The
>     special DEAFAULTS option resets all options to the default value.
> =20
> +Tracer Options
> +--------------
> +
> +The osnoise/options file exposes a set of on/off configuration options f=
or
> +the osnoise tracer. These options are:
> +
> + - DEFAULTS: reset the options to the default value.
> + - OSNOISE_WORKLOAD: do not dispatch osnoise workload (see dedicated
> +   section below).
> + - PANIC_ON_STOP: call panic() if the tracer stops. This option serves to
> +   capture a vmcore.
> + - OSNOISE_PREEMPT_DISABLE: disable preemption while running the osnoise
> +   workload, allowing only IRQ and hardware-related noise.
> + - OSNOISE_IRQ_DISABLE: disable IRQs while running the osnoise workload,
> +   allowing only NMIs and hardware-related noise, like hwlat tracer.
> +
>  Additional Tracing
>  ------------------
> =20

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--kQF009BxO1PPXLiK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY4gmuAAKCRD2uYlJVVFO
o8JhAP4jp+IRUpREErxIO5OHZPE5h2T6Miy3O7TQ5SR/Lj2lxgEA2lcebvXUBfh/
2kBEqdnXilt77UdD1DHdQucYoyZb0Q0=
=ejoO
-----END PGP SIGNATURE-----

--kQF009BxO1PPXLiK--
