Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA457686293
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjBAJL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjBAJLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:11:25 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CA586A0;
        Wed,  1 Feb 2023 01:10:59 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id z1so10278072plg.6;
        Wed, 01 Feb 2023 01:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u2bLefqWYm6HzNKmB69SH5SO32/y/8yC0vss+N8WhvA=;
        b=XxBJtU0ECeUy4HUhZrraWvEOT3Vix9cZn2gNGjyPfYl2ACZl14SQAcf+kNzDT+Fh8a
         HhPWot84B/lY3j0XmVQNaKqYwgzJ2PUQ3zPumBn+lcJr5tTrPockzxtvxqFJi/jLHTF9
         evRS1M2Bnh9Oj59fvE4p4c3HbnkygKamcV7cM+X55nk9/B/EXWL3EdmQsTHb6UOLngF1
         hjeJiwL7Hl5iAtUCecWv++ofZozWcYv+iQYldD0SIS1i+T1peAzzos/FXDLgs1ye7/64
         tkGsgATxxmsybrTH0K/5oeRF2B+OvlIvasP3hQDv9wHRVU+f1SG6AqSelz/jpk445G2z
         1XnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2bLefqWYm6HzNKmB69SH5SO32/y/8yC0vss+N8WhvA=;
        b=oErKrCX+opbN5V0Op9I0Q1NuUuMWe3EMrkxcA9UUEaMxtmC9JSuI5nL0WOAXV2Rugo
         4FtgWgeuiJ0i3vlMq1RV/iJ4+PjhnypEvth68mlkwkU8nyFOBs3TssILwrgK+2yyhxqM
         4Y2WnxKocKsmAyLtk3D0FQZU8QhFowSlHvL8bmWDM7fThFcZhPWwEYtl1YsIZGIsnIhb
         BPAjELg9BxTrnkWeSX0B+jQHtqnQOphmWXrg1cT2KzjXG3kpX5obF2Sm7YkkspTTlcU5
         sEK4fCCTw5eOYX/6iR2BiPaAgJPkj10H5Vhy7dGVlFHWkSpJuDtZYsMw14aODUxlUYen
         zyyg==
X-Gm-Message-State: AO0yUKUhMzH03jrqbquFJ7lh5f2mHiDDxxf/oqG/pFXDSD/fpPVTrseK
        FavumelXdqEib+zbXMLedFs=
X-Google-Smtp-Source: AK7set9vlA7OUlQKnyxJWhjuF/Zu2unIzQeZTKZxaGJM2Edx1drWF8YNe3fH/ia7BHPqmOfW+PZf0Q==
X-Received: by 2002:a17:903:2283:b0:194:b982:d83c with SMTP id b3-20020a170903228300b00194b982d83cmr2354197plh.21.1675242658729;
        Wed, 01 Feb 2023 01:10:58 -0800 (PST)
Received: from debian.me (subs02-180-214-232-18.three.co.id. [180.214.232.18])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902820200b00196065e8d78sm11224529pln.50.2023.02.01.01.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 01:10:58 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id D5897104F9E; Wed,  1 Feb 2023 16:10:55 +0700 (WIB)
Date:   Wed, 1 Feb 2023 16:10:55 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-trace-devel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 6/6] Documentation/rtla: Add hwnoise man page
Message-ID: <Y9osn4sEj7F+Uwhd@debian.me>
References: <cover.1675181734.git.bristot@kernel.org>
 <0e9d6b25a88b23bfea11e0cb9b95b5b0845b670b.1675181734.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l0MnVvBrS6JzUOGU"
Content-Disposition: inline
In-Reply-To: <0e9d6b25a88b23bfea11e0cb9b95b5b0845b670b.1675181734.git.bristot@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l0MnVvBrS6JzUOGU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2023 at 05:30:07PM +0100, Daniel Bristot de Oliveira wrote:
> diff --git a/Documentation/tools/rtla/rtla-hwnoise.rst b/Documentation/to=
ols/rtla/rtla-hwnoise.rst
> new file mode 100644
> index 000000000000..fb1c52bbc00b
> --- /dev/null
> +++ b/Documentation/tools/rtla/rtla-hwnoise.rst
> @@ -0,0 +1,107 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +rtla-hwnoise
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +------------------------------------------
> +Detect and quantify hardware-related noise
> +------------------------------------------
> +
> +:Manual section: 1
> +
> +SYNOPSIS
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +**rtla hwnoise** [*OPTIONS*]
> +
> +DESCRIPTION
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +**rtla hwnoise** collects the periodic summary from the *osnoise* tracer
> +running with *interrupts disabled*. By disabling interrupts, and the sch=
eduling
> +of threads as a consequence, only non-maskable interrupts and hardware-r=
elated
> +noise is allowed.
> +
> +The tool also allows the configurations of the *osnoise* tracer and the
> +collection of the tracer output.
> +
> +OPTIONS
> +=3D=3D=3D=3D=3D=3D=3D
> +.. include:: common_osnoise_options.rst
> +
> +.. include:: common_top_options.rst
> +
> +.. include:: common_options.rst
> +
> +EXAMPLE
> +=3D=3D=3D=3D=3D=3D=3D
> +In the example below, the **rtla hwnoise** tool is set to run on CPUs *1=
-7*
> +on a system with 8 cores/16 threads with hyper-threading enabled.
> +
> +The tool is set to detect any noise higher than *one microsecond*,
> +to run for *ten minutes*, displaying a summary of the report at the
> +end of the session::
> +
> +  # rtla hwnoise -c 1-7 -T 1 -d 10m -q
> +                                          Hardware-related Noise
> +  duration:   0 00:10:00 | time is in us
> +  CPU Period       Runtime        Noise  % CPU Aval   Max Noise   Max Si=
ngle          HW          NMI
> +    1 #599       599000000          138    99.99997           3         =
   3           4           74
> +    2 #599       599000000           85    99.99998           3         =
   3           4           75
> +    3 #599       599000000           86    99.99998           4         =
   3           6           75
> +    4 #599       599000000           81    99.99998           4         =
   4           2           75
> +    5 #599       599000000           85    99.99998           2         =
   2           2           75
> +    6 #599       599000000           76    99.99998           2         =
   2           0           75
> +    7 #599       599000000           77    99.99998           3         =
   3           0           75
> +
> +
> +The first column shows the *CPU*, and the second column shows how many
> +*Periods* the tool ran during the session. The *Runtime* is the time
> +the tool effectively runs on the CPU. The *Noise* column is the sum of
> +all noise that the tool observed, and the *% CPU Aval* is the relation
> +between the *Runtime* and *Noise*.
> +
> +The *Max Noise* column is the maximum hardware noise the tool detected i=
n a
> +single period, and the *Max Single* is the maximum single noise seen.
> +
> +The *HW* and *NMI* columns show the total number of *hardware* and *NMI*=
 noise
> +occurrence observed by the tool.
> +
> +For example, *CPU 3* ran *599* periods of *1 second Runtime*. The CPU re=
ceived
> +*86 us* of noise during the entire execution, leaving *99.99997 %* of CP=
U time
> +for the application. In the worst single period, the CPU caused *4 us* of
> +noise to the application, but it was certainly caused by more than one s=
ingle
> +noise, as the *Max Single* noise was of *3 us*. The CPU has *HW noise,* =
at a
> +rate of *six occurrences*/*ten minutes*. The CPU also has *NMIs*, at a h=
igher
> +frequency: around *seven per second*.
> +
> +The tool should report *0* hardware-related noise in the ideal situation.
> +For example, by disabling hyper-threading to remove the hardware noise,
> +and disabling the TSC watchdog to remove the NMI (it is possible to iden=
tify
> +this using tracing options of **rtla hwnoise**), it was possible to reach
> +the ideal situation in the same hardware::
> +
> +  # rtla hwnoise -c 1-7 -T 1 -d 10m -q
> +                                          Hardware-related Noise
> +  duration:   0 00:10:00 | time is in us
> +  CPU Period       Runtime        Noise  % CPU Aval   Max Noise   Max Si=
ngle          HW          NMI
> +    1 #599       599000000            0   100.00000           0         =
   0           0            0
> +    2 #599       599000000            0   100.00000           0         =
   0           0            0
> +    3 #599       599000000            0   100.00000           0         =
   0           0            0
> +    4 #599       599000000            0   100.00000           0         =
   0           0            0
> +    5 #599       599000000            0   100.00000           0         =
   0           0            0
> +    6 #599       599000000            0   100.00000           0         =
   0           0            0
> +    7 #599       599000000            0   100.00000           0         =
   0           0            0
> +
> +SEE ALSO
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +**rtla-osnoise**\(1)
> +
> +Osnoise tracer documentation: <https://www.kernel.org/doc/html/latest/tr=
ace/osnoise-tracer.html>
> +
> +AUTHOR
> +=3D=3D=3D=3D=3D=3D
> +Written by Daniel Bristot de Oliveira <bristot@kernel.org>
> +
> +.. include:: common_appendix.rst
=20
LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--l0MnVvBrS6JzUOGU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY9osnwAKCRD2uYlJVVFO
o2BqAP9+a1G0T7Ahe7JiqepWQ7LK18DQ87925b+PutOlG1aJsAD9Frl2gZx1L0kB
IYl4I7rQGP4VQh79ptcF3zFG5dkv1QQ=
=p3As
-----END PGP SIGNATURE-----

--l0MnVvBrS6JzUOGU--
