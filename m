Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10E2697510
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 04:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjBODvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 22:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBODvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 22:51:39 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9DD29E36;
        Tue, 14 Feb 2023 19:51:38 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 7so11664650pga.1;
        Tue, 14 Feb 2023 19:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P8ZQpRqzZT5U1cA+p/xT66Dk/ixu4RCKSVnLvxZfnC4=;
        b=VmhdLCw34cKz73TcZMV7viBU9BHyGfKI3PVEEFza0BNkZSohY/jXKh8yRziizTGjZH
         s7229Ill6KPQj/+25E/yTDD5hT4orA+BcIjjRlRCTZw7xTvc9ePk5P6Ek3e+19o3pFKB
         blWHRfy+MyNUf7SMMzZCk1KXEMZknNOX70nOLHHtNrbx4JXtE8rRSNYjpxvGwdKWYSTs
         fCu3SMbpu4zIWjExNegjxw27yP6kPMrUJaLgPYUxmp4iaWbdOxFJdY228eOx9KKDf5xH
         1Fq2d2/gkrJmd63mySVfTBKHoOn1hqMHhSxtPYRdnr30QOPmfc+fWvhds+gL0tKsyJQ+
         Mt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8ZQpRqzZT5U1cA+p/xT66Dk/ixu4RCKSVnLvxZfnC4=;
        b=dBY/YMfKL5b4pbdF7mpgsiqGZcgE4ynWcVIgRN9ypL416x6PheDAAlyM/CuJwap793
         8jCOaAvzYHkx3h/gn31uuPJqNi4O1zRc5WI1PAHbnsQu5klVA2XvgnzymV4ILxLIjhan
         /4DtrC6x6YbN5U/a6R1qZ3lertj0M6tSG7UiLyfT3Nr4CMBXhpxA70bOrtuvY2ED7Agt
         kWx2Rp1XCXalBFOzjU84lpE65C+1xualDl8EHZqJ/6mSqGgFM+BS6IcaKH5LdwHG71ih
         NXTwhzLHeYg0CxtRe8wM70+fwEHiOSY5IwH4TForPp1/6f/Z7IldkzbxDTN2lFV6nhjC
         WX3g==
X-Gm-Message-State: AO0yUKVOauRuZ3K4zwEWSiwx5fF/y7JqusW7KeQPPXh/zogu3HJROdme
        SSbYInjDGQcRkLanXtDwCGo=
X-Google-Smtp-Source: AK7set9rv+J1OeIcRmbEwDhs5Qz4syg0Q4gM00uRuccFWjRnvdOXo0un9tvqmwq72W41eI5u7VX1Bw==
X-Received: by 2002:a62:384d:0:b0:5a8:af22:32e7 with SMTP id f74-20020a62384d000000b005a8af2232e7mr528892pfa.6.1676433097830;
        Tue, 14 Feb 2023 19:51:37 -0800 (PST)
Received: from debian.me (subs02-180-214-232-65.three.co.id. [180.214.232.65])
        by smtp.gmail.com with ESMTPSA id v24-20020aa78518000000b005a831a42c86sm4999213pfn.72.2023.02.14.19.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 19:51:37 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 6186F105F5E; Wed, 15 Feb 2023 10:51:34 +0700 (WIB)
Date:   Wed, 15 Feb 2023 10:51:34 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, Greg KH <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2] docs: describe how to quickly build a trimmed kernel
Message-ID: <Y+xWxpuRdtuCpsO6@debian.me>
References: <8cfcf069d48c1b8d7b83aafe0132f8dad0f1d0ea.1676400947.git.linux@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U7MtmZIwxnh07FCH"
Content-Disposition: inline
In-Reply-To: <8cfcf069d48c1b8d7b83aafe0132f8dad0f1d0ea.1676400947.git.linux@leemhuis.info>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U7MtmZIwxnh07FCH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 14, 2023 at 07:58:09PM +0100, Thorsten Leemhuis wrote:
> +   Execute the following command to retrieve a fresh mainline codebase::
> +
> +     git clone --no-checkput --depth 1 -b master \
> +       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git \
> +       ~/linux/sources/
> +     cd ~/linux/sources/
> +
> +   If you want to access recent mainline releases and pre-releases, deep=
en you
> +   clone's history to the oldest version you are interested in::
> +
> +     git fetch --shallow-exclude=3Dv6.0

For me, another way is to use `git fetch --shallow-since=3D"<some-date>"
&& git repack -a -d`. This requires knowing version release date. If
you want that version, the date used should be one or two days before
that version's release date. Repacking is important!

Nevertheless, you need to go to Git ML and ask why repacking is required
in that case (I have tried searching threads there, but inconclusive).

> +The make target olddefconfig and the ``yes "" |`` used when utilizing
> +localmodconfig will set any undefined build options to their default val=
ue. This
> +among others will disable many kernel features that were introduced afte=
r your
> +base kernel was released.
> +
> +If you want to set these configurations options manually, use ``oldconfi=
g``
> +instead of ``olddefconfig`` or omit the ``yes "" |`` when utilizing
> +localmodconfig. Then for each undefined configuration option you will be=
 asked
> +how to proceed. In case you are unsure what to answer, simply hit 'enter=
' to
> +apply the default value.

olddefconfig and `yes "" | make localmodconfig` can produce different
config, since the default value for new config symbols may not be Y.
Often, for new drivers, the default is N.


> + * Remove a stale reference to a certificate file that would cause your =
build to
> +   fail::
> +
> +    ./scripts/config --file ~/linux/build/.config --set-str SYSTEM_TRUST=
ED_KEYS ''
> +
> +   Alternatively, download the needed certificate and make that configur=
ation
> +   option point to it, as `the Debian handbook explains in more detail
> +   <https://debian-handbook.info/browse/stable/sect.kernel-compilation.h=
tml>`_ .
> +

Another way is to generate the certificate yourself (see
Documentation/admin-guide/module-signing.rst for the instructions).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--U7MtmZIwxnh07FCH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY+xWvgAKCRD2uYlJVVFO
o3ETAP9MZyQ83vWOZfy0JFEFkuB33cfak6SRVQ2tA7Y817aeOgD+JUOFkK2KVH58
2uVC0NzyGCko0eOQarbVXE44sREInAE=
=KwIP
-----END PGP SIGNATURE-----

--U7MtmZIwxnh07FCH--
