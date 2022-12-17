Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BF864F88A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 10:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiLQJxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 04:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiLQJxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 04:53:20 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1281402B;
        Sat, 17 Dec 2022 01:53:20 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gt4so4730745pjb.1;
        Sat, 17 Dec 2022 01:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZO9al7YrSck89G9oQI8cP/XGUvm/YU35VYbyVunm5c4=;
        b=Cd7UX6Z/M+SikLmiL7gQJHEJFfgXYJIPl5HY8eeTO00yFJSrLozFQPFBNTiVkcfBAX
         PHiqGCUh6T1xWTZGZ2FiOak8jRk2NGqA0Ji2thJz+8uf2tIrxtIngWlT25mKseO+Xr/K
         FErOm9OdrcoCUUnp/tKBhB8rc+KEbIO3CY2hMevUfKwsTkeV3ADz1bDXumAH3HZdcsCT
         1sfVSkCW7Nfg4z9xDzop705rza+WHYyuZvHsloPhQTp+oJpSmBl+91YV2Tpeu4STnfKC
         d9qCQg3qChK4EyVmqSs1GuVMIdZTxn4s5n8JJi4zp3jnH75Nd25Y1BPMu27coCa90vDs
         q2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZO9al7YrSck89G9oQI8cP/XGUvm/YU35VYbyVunm5c4=;
        b=XWQl+nh4mX3PYceMTiIoXgEXQuEszIeuO/Dva5DMCr0zXrR4xExuV4SlFQDAX6uB0A
         DbEEPVrXUUwDh5ACFVZYcDLvxumpU70rbeDQHO4Q758sVkTVMOlHCBGhQZWEGq3JxbbP
         Dj8eyPHpx6dZPjCPS87nWcvOZGwaoHWdIDB2oX5CHuNGWyMNCpqDOG4PJvRP7Pk5tFj4
         FL30ABWaEluvrMXLWWY1aSnaGSrndJ5fLDQty39l6mxJHn/nWvAXYmwNGapZLbykYAzQ
         p1WUs/D7MtGGr+9+80Mgg7hwaBKx5QO9/gZVZOoQmiUJl0w6NUu19TpHaXctCalSgYm+
         tm5g==
X-Gm-Message-State: AFqh2kpdQxBc9vrCKjqfoCzpMyb/4tLWIpdmYtq/qO9SUSlrQmDLqNym
        CPbRRIZI/gXY630Uks4Zm50=
X-Google-Smtp-Source: AMrXdXv7wgU+sjohjYoEMqYiZO2kSArsMi2NJZs01NPzBy6lDcZzmTFQTIwbzvKAqHerIXXc+TGdUg==
X-Received: by 2002:a17:902:8c90:b0:189:9fb2:255a with SMTP id t16-20020a1709028c9000b001899fb2255amr1568235plo.19.1671270799496;
        Sat, 17 Dec 2022 01:53:19 -0800 (PST)
Received: from debian.me (subs03-180-214-233-79.three.co.id. [180.214.233.79])
        by smtp.gmail.com with ESMTPSA id v1-20020a1709029a0100b001897e2fd65dsm3119669plp.9.2022.12.17.01.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 01:53:18 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 53765100B3E; Sat, 17 Dec 2022 16:53:15 +0700 (WIB)
Date:   Sat, 17 Dec 2022 16:53:15 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Paul Bone <pbone@mozilla.com>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3] Documentation: sched: Document util clamp feature
Message-ID: <Y52Ri28ThsM4iU8X@debian.me>
References: <20221216235716.201923-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IAbXMJJDJGhLPlUP"
Content-Disposition: inline
In-Reply-To: <20221216235716.201923-1-qyousef@layalina.io>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IAbXMJJDJGhLPlUP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 16, 2022 at 11:57:16PM +0000, Qais Yousef wrote:
> +Another example is in Android where tasks are classified as background,
> +foreground, top-app, etc. Util clamp can be used to constrain how much
> +resources background tasks are consuming by capping the performance poin=
t they
> +can run at. This constraint helps reserve resources for important tasks,=
 like
> +the ones belonging to the currently active app (top-app group). Beside t=
his
> +helps in limiting how much power they consume. This can be more obvious =
in
> +heterogeneous systems (e.g. Arm big.LITTLE); the constraint will help bi=
as the
> +background tasks to stay on the little cores which will ensure that:
> +
> +        1. The big cores are free to run top-app tasks immediately. top-=
app
> +           tasks are the tasks the user is currently interacting with, h=
ence
> +           the most important tasks in the system.
> +        2. They don't run on a power hungry core and drain battery even =
if they
> +           are CPU intensive tasks.
> +
> +.. note::
> +  **little cores**:
> +    CPUs with capacity < 1024
> +
> +  **big cores**:
> +    CPUs with capacity =3D 1024

Processing capacity (CPU frequency) in MHz? This is the first time I
hear Arm big.LITTLE architecture. CC'ing several Arm folks and
linux-arm-kernel list for I'm unsure on this.

> +
> +By making these uclamp performance requests, or rather hints, user space=
 can
> +ensure system resources are used optimally to deliver the best possible =
user
> +experience.
> +
> +Another use case is to help with **overcoming the ramp up latency inheri=
t in
> +how scheduler utilization signal is calculated**.

IMO the bold text isn't needed (why did you highlight the phrase above)?

> +When task @p is running, **the scheduler should try its best to ensure it
> +starts at 40% performance level**. If the task runs for a long enough ti=
me so
> +that its actual utilization goes above 80%, the utilization, or performa=
nce
> +level, will be capped.

Same here.

> +**Generally it is advised to perceive the input as performance level or =
point
> +which will imply both task placement and frequency selection**.

Same here too.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--IAbXMJJDJGhLPlUP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY52ReQAKCRD2uYlJVVFO
o4HkAP4rc8AULhBHVO7Y9cRRRNKL0KVpwku8TWCuK0K3HNSBjgEAmNGvg6da34fs
mfQfANrw8H/CE0iusS8NXjKKCrYFugk=
=tqHd
-----END PGP SIGNATURE-----

--IAbXMJJDJGhLPlUP--
