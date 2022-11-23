Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80986360CD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbiKWOAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbiKWN76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:59:58 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B75EA4;
        Wed, 23 Nov 2022 05:54:46 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id x13-20020a17090a46cd00b00218f611b6e9so261256pjg.1;
        Wed, 23 Nov 2022 05:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3L4jiY6FXPps/XaKmzU/Sf6AyPI2m9wPunUZC4P5Nu8=;
        b=D6RgXf8HMRQKPT2fpNnyp4nH0QnKk6GiTc68BlFsp0M8jW2r079WNug7O4wOpYv2A7
         l3AK6e1kLiq+r6dozvZj0xXzeC2zw7wPRUlwToNu1YBC/lf76ncrKlDTrCG0PPxRJAm/
         kjQvUVKUcYTxbZKSz4rTgYA8XEt/LaP9rFqMYl2jmnbK+UfQtxKotaovujNlnf5BdrFS
         TijGsOILhcdYendDo88MCwk9+e39oSrZLocq6A9d4VutfWrOlWcYUiC70qHXnCBpD6Ih
         OTWqxvEQcXDk+bUplLQAmkRmIuykpAab4oRLnnXU+O2eQI5gWO5qgt35qVH20/X9zXmZ
         CLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3L4jiY6FXPps/XaKmzU/Sf6AyPI2m9wPunUZC4P5Nu8=;
        b=W5OibCw2WuxswGuVgZFlV640zbv3KJsbc9aTevhaxEwHCwsNFzTC6B7jD2Uk48m3En
         rLDGykN+LxD2Nb2xETDcm5RItouy8uQ9DjGtu5yHBt7EloPX99F0Dh8betMB12zKcNbx
         qDHhF3tWLYbso6DOxdGOWupvIGcMLjBdomhhHZ1jm8YAWl4etVZvb5hgmowSS/yNgOTa
         yWUn0xz5rf/Twk5uMDqTUJeSex6PBK9OY/VsLPemwrtUqOJaMZsh6CY5WiHw7sJrkicb
         CshX5hsWHNoyj5DV8CohfMa6WztC1PB3JnLOMJyDryu6nv+NHI2ONYHyz36qTpxOYLgi
         5qqQ==
X-Gm-Message-State: ANoB5pk61WVyfT2nRqogrCR9xP9S/jGNbRKbbOu8X3M/CrS8zoCoiZas
        lR1Jd1Ou3IpFyQnCyzNtZgU=
X-Google-Smtp-Source: AA0mqf5Ux/meve6jdcw71YlDFSFPE7R27UkaRozU/ipN8waa0IQGXVxR/t1jGLLbWSOwIyei0J2NXQ==
X-Received: by 2002:a17:902:868b:b0:186:8c19:d472 with SMTP id g11-20020a170902868b00b001868c19d472mr9523673plo.12.1669211685816;
        Wed, 23 Nov 2022 05:54:45 -0800 (PST)
Received: from debian.me (subs02-180-214-232-75.three.co.id. [180.214.232.75])
        by smtp.gmail.com with ESMTPSA id f91-20020a17090a706400b00203ab277966sm1478297pjk.7.2022.11.23.05.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:54:45 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 6F0C8103FB7; Wed, 23 Nov 2022 20:54:42 +0700 (WIB)
Date:   Wed, 23 Nov 2022 20:54:42 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org
Subject: Re: [PATCH v2] doc: Fix htmldocs build warnings of stallwarn.rst
Message-ID: <Y34mIhHYjFFzywsk@debian.me>
References: <20221123120238.1904-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hoqvooc+Zx6ORxue"
Content-Disposition: inline
In-Reply-To: <20221123120238.1904-1-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hoqvooc+Zx6ORxue
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 23, 2022 at 08:02:38PM +0800, Zhen Lei wrote:
> Documentation/RCU/stallwarn.rst:
> 401: WARNING: Literal block expected; none found.
> 428: WARNING: Literal block expected; none found.
> 445: WARNING: Literal block expected; none found.
> 459: WARNING: Literal block expected; none found.
> 468: WARNING: Literal block expected; none found.
>=20
> The literal block need to be indented, so add two spaces to each line.

Indenting to match alignment of lists texts?

> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

You miss crediting linux-next list, so please add:

Link: https://lore.kernel.org/linux-next/20221123163255.48653674@canb.auug.=
org.au/
Fixes: 3d2788ba4573 ("doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=3Dy stall =
information")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

> -The sampling period is shown as follows:
> -:<------------first timeout---------->:<-----second timeout----->:
> -:<--half timeout-->:<--half timeout-->:                          :
> -:                  :<--first period-->:                          :
> -:                  :<-----------second sampling period---------->:
> -:                  :                  :                          :
> -:          snapshot time point    1st-stall                  2nd-stall
> +The sampling period is shown as follows::
> =20
> +  |<------------first timeout---------->|<-----second timeout----->|
> +  |<--half timeout-->|<--half timeout-->|                          |
> +  |                  |<--first period-->|                          |
> +  |                  |<-----------second sampling period---------->|
> +  |                  |                  |                          |
> +  |          snapshot time point    1st-stall                  2nd-stall

The beginning pipe (|) on the last line of diagram above shouldn't be there
(axis label?).

> =20
>  The following describes four typical scenarios:
> =20
> -1. A CPU looping with interrupts disabled.::
> +1. A CPU looping with interrupts disabled.
> =20
> -   rcu:          hardirqs   softirqs   csw/system
> -   rcu:  number:        0          0            0
> -   rcu: cputime:        0          0            0   =3D=3D> 2500(ms)
> +   ::
> +
> +     rcu:          hardirqs   softirqs   csw/system
> +     rcu:  number:        0          0            0
> +     rcu: cputime:        0          0            0   =3D=3D> 2500(ms)
> =20
>     Because interrupts have been disabled throughout the measurement
>     interval, there are no interrupts and no context switches.
> @@ -440,11 +442,11 @@ The following describes four typical scenarios:
> =20
>     This is similar to the previous example, but with non-zero number of
>     and CPU time consumed by hard interrupts, along with non-zero CPU
> -   time consumed by in-kernel execution.::
> +   time consumed by in-kernel execution. ::
> =20
> -   rcu:          hardirqs   softirqs   csw/system
> -   rcu:  number:      624          0            0
> -   rcu: cputime:       49          0         2446   =3D=3D> 2500(ms)
> +     rcu:          hardirqs   softirqs   csw/system
> +     rcu:  number:      624          0            0
> +     rcu: cputime:       49          0         2446   =3D=3D> 2500(ms)
> =20
>     The fact that there are zero softirqs gives a hint that these were
>     disabled, perhaps via local_bh_disable().  It is of course possible
> @@ -454,20 +456,22 @@ The following describes four typical scenarios:
> =20
>  3. A CPU looping with preemption disabled.
> =20
> -   Here, only the number of context switches is zero.::
> +   Here, only the number of context switches is zero. ::
> =20
> -   rcu:          hardirqs   softirqs   csw/system
> -   rcu:  number:      624         45            0
> -   rcu: cputime:       69          1         2425   =3D=3D> 2500(ms)
> +     rcu:          hardirqs   softirqs   csw/system
> +     rcu:  number:      624         45            0
> +     rcu: cputime:       69          1         2425   =3D=3D> 2500(ms)
> =20
>     This situation hints that the stalled CPU was looping with preemption
>     disabled.
> =20
> -4. No looping, but massive hard and soft interrupts.::
> +4. No looping, but massive hard and soft interrupts.
> +
> +   ::
> =20
> -   rcu:          hardirqs   softirqs   csw/system
> -   rcu:  number:       xx         xx            0
> -   rcu: cputime:       xx         xx            0   =3D=3D> 2500(ms)
> +     rcu:          hardirqs   softirqs   csw/system
> +     rcu:  number:       xx         xx            0
> +     rcu: cputime:       xx         xx            0   =3D=3D> 2500(ms)
> =20
>     Here, the number and CPU time of hard interrupts are all non-zero,
>     but the number of context switches and the in-kernel CPU time consumed
>=20

Because paragraphs below the snippets directly refers to them,just use colo=
n:=20

---- >8 ----

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.=
rst
index f15b766d39b8d9..4f6b91be03cfe0 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -423,9 +423,7 @@ The sampling period is shown as follows::
=20
 The following describes four typical scenarios:
=20
-1. A CPU looping with interrupts disabled.
-
-   ::
+1. A CPU looping with interrupts disabled::
=20
      rcu:          hardirqs   softirqs   csw/system
      rcu:  number:        0          0            0
@@ -442,7 +440,7 @@ The following describes four typical scenarios:
=20
    This is similar to the previous example, but with non-zero number of
    and CPU time consumed by hard interrupts, along with non-zero CPU
-   time consumed by in-kernel execution. ::
+   time consumed by in-kernel execution::
=20
      rcu:          hardirqs   softirqs   csw/system
      rcu:  number:      624          0            0
@@ -456,7 +454,7 @@ The following describes four typical scenarios:
=20
 3. A CPU looping with preemption disabled.
=20
-   Here, only the number of context switches is zero. ::
+   Here, only the number of context switches is zero::
=20
      rcu:          hardirqs   softirqs   csw/system
      rcu:  number:      624         45            0
@@ -465,9 +463,7 @@ The following describes four typical scenarios:
    This situation hints that the stalled CPU was looping with preemption
    disabled.
=20
-4. No looping, but massive hard and soft interrupts.
-
-   ::
+4. No looping, but massive hard and soft interrupts::
=20
      rcu:          hardirqs   softirqs   csw/system
      rcu:  number:       xx         xx            0

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--hoqvooc+Zx6ORxue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY34mHgAKCRD2uYlJVVFO
o5o6AQDXWjQlthiTdbZKz5RB0WuD5lXhFU06qgmYk8d1zEol5AD9HAfnOyfCSDPW
kkwd0V9REUB1bt6kOpeuRCmtN6mlyQM=
=2FFX
-----END PGP SIGNATURE-----

--hoqvooc+Zx6ORxue--
