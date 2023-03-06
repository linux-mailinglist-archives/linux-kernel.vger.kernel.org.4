Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C426AB8B9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCFIra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFIr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:47:28 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBCF1730;
        Mon,  6 Mar 2023 00:47:26 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso8161130pjs.3;
        Mon, 06 Mar 2023 00:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678092446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sw+u88CIvLshV3uZHn5DskiZdXl3Zpyvzll3UI7l8as=;
        b=QpM+v0x1AR8FhAvYr5NUHb0/TwmxmJOzJFySfMS0ydxvt7Qo9ox0CAyulCSxgskvc4
         T+xRS39eng1C5dPXxYEaEqOT2Q0544n3X+RglcOz8oSsvWYUgFEWMFRy1R7vkqGLm5Go
         K66xfe9Cssq7HMpTPpGd5Pi9LDICEQVwL6nLX+c/rx2plCsei+m9m/rsQexKO7IAs0/H
         H+imdMrev6wKmEDjeAMbCr0IqhB+ocqLUSraie0KxtUzQhjflUll6+/t0J7FE35R9v3q
         0ugcimv0Y7A9I2Ma1FU+TWeQvcVZHJqcU+aw0ASfMAbqqtO7t0Sd9gUkp2lGVKQMIrWg
         UA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678092446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sw+u88CIvLshV3uZHn5DskiZdXl3Zpyvzll3UI7l8as=;
        b=4pc4nR6YqYxKjqypLV6mPrxJzKalc4Y85CTBOEvPdBlUi0MHnPGpVPPGmxGcjVowXh
         t1QWSYjbSk9NQ0FWbHe49yAvRxjfIA2P8WReJW6pQEF1vOHJ36lRQxOsNxo3FU5Q8VA9
         ijbIzq5tW9t4CZLeyAcRxmF6cRgjcDeMJb2EjRV8NtxStElUbmCzGxq7VGHHNEXcPaY3
         Ia/OLDuK/BCwY3xSX1qSHnyH1tf3LtWx/9HeFuUQ4uBa7HfCOlIwi/nW8OSJgUPdrVey
         gWV4dSVI0vKUV6/vKlXwn8SD4cIIYk/kgQdyIxpYuS7AlK0WV7Jelr6BLagppKsHc1US
         Kknw==
X-Gm-Message-State: AO0yUKVblDVaepeiTsORLig6W6AomFJL+egIgNHGJ2OnBjps11xTmeQz
        w9+ZmDWyt6AyKcaHCjm7dr0=
X-Google-Smtp-Source: AK7set/v4KFy6iQBNYgAoH+i77Z/k04zNTwCKhp4NtSkb9ooQ3aMcSyaRIDnPVeyMM0Tffh17jMkjQ==
X-Received: by 2002:a17:902:b709:b0:19d:1f36:fc54 with SMTP id d9-20020a170902b70900b0019d1f36fc54mr9027711pls.65.1678092446266;
        Mon, 06 Mar 2023 00:47:26 -0800 (PST)
Received: from debian.me (subs03-180-214-233-82.three.co.id. [180.214.233.82])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c14c00b0017f5ad327casm6090173plj.103.2023.03.06.00.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 00:47:25 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 863911062DC; Mon,  6 Mar 2023 15:47:21 +0700 (WIB)
Date:   Mon, 6 Mar 2023 15:47:21 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Willy Tarreau <w@1wt.eu>, Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Solar Designer <solar@openwall.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Amit Shah <aams@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: Re: [PATCH v3 0/7] Documentation/security-bugs: overhaul
Message-ID: <ZAWomdmSXViNAZVb@debian.me>
References: <20230305220010.20895-1-vegard.nossum@oracle.com>
 <ZAWSKrbaQ6nm3qNe@1wt.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zceAUshRmOuzbKJ1"
Content-Disposition: inline
In-Reply-To: <ZAWSKrbaQ6nm3qNe@1wt.eu>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zceAUshRmOuzbKJ1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2023 at 08:11:38AM +0100, Willy Tarreau wrote:
>   - I'm not seeing anywhere that the security list is *exclusively*
>     for kernel issues. That might explain why about once a week or so
>     we receive messages like "there's a bug in that userland tool" or
>     "we've found an XSS issue on your website". It's written that kernel
>     bugs should be reported to the security list but I think we should
>     strengthen that by adding "This list is exclusively used for Linux
>     kernel security reports, please do not report issues affecting any
>     other component there".

I think the wording would be "Please report security bugs against Linux
kernel to security@kernel.org list. Security bugs against userspace
applications should be reported to appropriate channels for affected
applications instead."

>   - it's quite frequent that reporters post from dummy addresses,
>     looking like randomly generated ones (we even had one looking
>     like a smiley). It doesn't help to communicate with them at all.
>     I can understand how some working as consultants for a customer
>     would want to avoid disclosing a particular relation between their
>     finding and their customer, but at least they should indicate how
>     they should be called. I.e. "call me Margarett" is not difficult
>     and simplifies exchanges when the address is "69236836@example.com".
>     And often we see at the end that they're willing to provide a real
>     name to be credited for the finding, so most likely starting with
>     this real name could be easier.
>=20

Something like temporary addresses (=C3=A0 la maildrop or mail.gw)?

>   - it's more a discussion for the list itself, but the wording continues
>     to make one think that the reporter should expect the list members to
>     develop a patch, while in practise the first thing that's asked is
>     "since you've studied the problem well, do you happen to have a patch=
?".
>     And it happened a few times that in response we got "oops sorry, I
>     analysed it wrong, there's no issue there". I think the text should
>     emphasize more on encouraging submitters to complete their work with
>     a patch proposal (that's also helpful to confirm an analysis). And
>     conversely I think that reports for non-immediately exploitable issues
>     that are found by code analyzers (and almost always come without a
>     patch) should not be sent to this list and should be discussed and
>     addressed publicly instead. It's more efficient and allows more
>     knowledgeable participants to have their say on the root cause of
>     the problem and its possible solutions. That's of course not always
>     the case, but common sense should prevail here.

I think the wording would be "It is preferrable to have a proposed patch
for the bug you report. See
Documentation/process/submitting-patches.rst for details on how to
submit patches."

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--zceAUshRmOuzbKJ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZAWokAAKCRD2uYlJVVFO
o9SmAQDXqKfUMtvoPN0EctIKZn/ChfDIPRaZXC0RT8ks/mP5bQEApYSU/FyiuwMP
20tXQfnUHRyPPEPWLccOutliHGA7jgU=
=cMrJ
-----END PGP SIGNATURE-----

--zceAUshRmOuzbKJ1--
