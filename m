Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7898B6395FA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 13:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiKZMjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 07:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKZMju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 07:39:50 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A179A1FFA4;
        Sat, 26 Nov 2022 04:39:46 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so6374142pjb.0;
        Sat, 26 Nov 2022 04:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UX7oPzfxEqRosS76R8Lsuk6SvDMI2y8a/cpo44O3R5E=;
        b=Bz+ABP3BufV81lhyJcAUQ8yJxjPJhZMcr0SlpzdcZXPjMzWJ8svfOK13S/zfigvnlo
         QSMYHd0y20Xc4BIx+gr4Q2W+cOQOoj6AVO3zlN/2u/pGAj/goIcXwDcZ96JOwam5FkZ3
         jRfMf+1MF7OuhM6c9fE6regcDp3QJAsTDey/8gTOAnMjb35UbPPJ5SFY1HbSpo7Rv/6t
         jyn82qajrXSQbZ1M4T8k1arzkREHVd3gBVGE7s6aze/9mhFSynbOtB6xt0wkAUafe9Fj
         LKU4FWKDgRbQxtosDboyTFiXctQR1Q8PraUxHbmaiZTnGMMiBjd9I2029Uu+MRu8Giix
         EKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UX7oPzfxEqRosS76R8Lsuk6SvDMI2y8a/cpo44O3R5E=;
        b=JlcGquq3H4B3597QJ3lE21oX2mtx2Tia/31I83sUoSNEbWKGW2VbqZ88FZzuMH7/WP
         Y4AJ54WovIjI7emqLzZdT2XZqbjdV4OfUJturfJOjnWkal4W4lHr1h6+Q7XL+3KQdI/C
         sMU8/n5zVWbmEWjI/X98XL1MtVlssYt/xQT5SvkfezJOVMZsrTAOShEddDibOIC2Y+yB
         nBuVSq09IlJ+BWwk4gGY05KY01Y6kaQeQoy2tuJMiR4+6Wm7GBicdh7H/tnBg0/c9GEf
         py+0y808TjWjZJvBVIJXY5om/DFldjJW/2EcbLSPFFEEe9me0Pz9HGR2yVxb+BY80GxK
         mEjw==
X-Gm-Message-State: ANoB5plflwSTcwmF7i16D5WTd0kJHTwcI0oFt1n0rjq7KEDStYH/q8Dn
        Uv7qpkz/B73x2yAOz1tyuSk=
X-Google-Smtp-Source: AA0mqf4Q+vG9ybXU6Pv4izAesd3spnim0enjBHyRrf9t79Nwx8UbxYwdypglztLVgyh+mgsXuX/STQ==
X-Received: by 2002:a17:90a:5298:b0:217:e054:9ac8 with SMTP id w24-20020a17090a529800b00217e0549ac8mr51932482pjh.246.1669466386116;
        Sat, 26 Nov 2022 04:39:46 -0800 (PST)
Received: from debian.me (subs09a-223-255-225-68.three.co.id. [223.255.225.68])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902dac400b00188f6cbd950sm5252997plx.226.2022.11.26.04.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 04:39:45 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id DB998104374; Sat, 26 Nov 2022 19:39:41 +0700 (WIB)
Date:   Sat, 26 Nov 2022 19:39:41 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 3/3] Documentation/osnoise: Add osnoise/options
 documentation
Message-ID: <Y4IJDY2802+x17Ig@debian.me>
References: <cover.1669409262.git.bristot@kernel.org>
 <0a8ecf364af29b0c1d5007f4d71265127c114a1f.1669409262.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Fh1KnNgyu1c5IbAd"
Content-Disposition: inline
In-Reply-To: <0a8ecf364af29b0c1d5007f4d71265127c114a1f.1669409262.git.bristot@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Fh1KnNgyu1c5IbAd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 25, 2022 at 10:20:24PM +0100, Daniel Bristot de Oliveira wrote:
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
> +    capture a vmcore.

Excessive indentation makes PANIC_ON_STOP item above become definition list
instead. I have to make a small fixup:

---- >8 ----

diff --git a/Documentation/trace/osnoise-tracer.rst b/Documentation/trace/o=
snoise-tracer.rst
index 0641781b00f5e8..f2008e3172231d 100644
--- a/Documentation/trace/osnoise-tracer.rst
+++ b/Documentation/trace/osnoise-tracer.rst
@@ -125,7 +125,7 @@ the osnoise tracer. These options are:
  - OSNOISE_WORKLOAD: do not dispatch osnoise workload (see dedicated
    section below).
  - PANIC_ON_STOP: call panic() if the tracer stops. This option serves to
-    capture a vmcore.
+   capture a vmcore.
  - OSNOISE_PREEMPT_DISABLE: disable preemption while running the osnoise
    workload, allowing only IRQ and hardware-related noise.
  - OSNOISE_IRQ_DISABLE: disable IRQs while running the osnoise workload,

> + - OSNOISE_PREEMPT_DISABLE: disable preemption while running the osnoise
> +   workload, allowing only IRQ and hardware-related noise.
> + - OSNOISE_IRQ_DISABLE: disable IRQs while running the osnoise workload,
> +   allowing only NMIs and hardware-related noise, like hwlat tracer.
> +

Otherwise LGTM.=20

--=20
An old man doll... just what I always wanted! - Clara

--Fh1KnNgyu1c5IbAd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY4IJCQAKCRD2uYlJVVFO
o0FTAP9skzEDf1UmukIcXkQk/1UVOZeKWUXCHkfVQQ64c/HiogD5AfxVq4Uow1dv
8CWRcboYwygyHbNvjATE/GYDj7woMgQ=
=5WqF
-----END PGP SIGNATURE-----

--Fh1KnNgyu1c5IbAd--
