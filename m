Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC216BA616
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 05:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjCOERk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 00:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCOERi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 00:17:38 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61A54AFE9;
        Tue, 14 Mar 2023 21:17:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so594138pjz.1;
        Tue, 14 Mar 2023 21:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678853857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RSY7ZnRAjnFNpdEXKG3EtcXLc39AjD4AR33fsspA2yA=;
        b=bCiza7sav1BaTufFra7tPZ6Ig2ZI0Y13oB8l86Bx3oeJyArlgGVC3NY8TcQeuJdCMN
         50V7FDkWmj8k8Ga8RnwZ4aCgNwg+4ue2EsDIDb5mJ5589Xou3Vq94pKYJWGAqekLCc2x
         /tRlZ6+Sp4s0lHR6Od5WkOgR3Z3eCXPuifMAyLRxyue28PDDcMtlCvyqOYSoQWG1fq4w
         r4v1529wXxQhgfCQ5Z2vPz9nbkLQ3e+/lcFbmLMoMD4JzdF5yfYY4uJOWzA5CzWWo2HS
         HX+7WzkGgK2fyv9JxNN9QdkCzsWQmndAQx+kPnALarcyO8uVh3CwTCzQxqrrioYT0WUj
         YKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678853857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSY7ZnRAjnFNpdEXKG3EtcXLc39AjD4AR33fsspA2yA=;
        b=O1GYRtPpZx+Ggi8FYPZYat/Ps8r8YMZGnx9qRDAPOmRWtv/02SVjtGbJ6ZAgFtde30
         gEzJOEpWNEN80JwsbW7aCvLNV41EC8/0TwMWpmAlm8HODUfp03c8WrqdcZrrB8Xn874t
         q7x1TrjAOUm034iJpT3ze/EUbwesXhSiuvoPfjtvCm2+sd79W2wfhb40dhhlWHcbPMGl
         nKY+2C3SjKHxvsCi4QKpUkSLlV8y92zRbkc5Lyjb1NjdzxO5TFBymvHUIst2l4fiW2Qj
         o6DZD7WIvB+G9Dzs2euLMzbaOY+YwY6w8gRxK79IxSpC7nhGoVGEU7VLOlMcviLj63OX
         cf4A==
X-Gm-Message-State: AO0yUKWa0tQXj8ifTjNF8xVCdc30k+WYxhl5ZG3VFXSc+qMldLP45PwB
        tsFgxim352l/FQv2XGejgV3xa+xN2RY=
X-Google-Smtp-Source: AK7set/puAAI6Gqe6/gQITar+hr2kLsp/NA2NiJ78deWvGvXm+c8gBviEscu8yzbAjfeLlldM5wL2w==
X-Received: by 2002:a05:6a20:4286:b0:d4:8879:6f33 with SMTP id o6-20020a056a20428600b000d488796f33mr10211511pzj.15.1678853857189;
        Tue, 14 Mar 2023 21:17:37 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-17.three.co.id. [180.214.232.17])
        by smtp.gmail.com with ESMTPSA id d10-20020a63fd0a000000b004fba32949c3sm2292591pgh.16.2023.03.14.21.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 21:17:36 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 2D453106195; Wed, 15 Mar 2023 11:17:33 +0700 (WIB)
Date:   Wed, 15 Mar 2023 11:17:33 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [PATCH v3] docs: describe how to quickly build a trimmed kernel
Message-ID: <ZBFG3UqcS7IhGP6t@debian.me>
References: <1a788a8e7ba8a2063df08668f565efa832016032.1678021408.git.linux@leemhuis.info>
 <87a60frxk0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8zDsjomzav6C/tyN"
Content-Disposition: inline
In-Reply-To: <87a60frxk0.fsf@meer.lwn.net>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8zDsjomzav6C/tyN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 14, 2023 at 12:35:11PM -0600, Jonathan Corbet wrote:
> This caused me to wonder if we shouldn't create a new book called
> "tutorials" for this kind of stuff, with an explicit proviso that a more
> web-oriented approach is OK in that section?  Tutorial documentation
> *is* quite different from reference material, but we've really made no
> effort to treat the two differently so far.
>=20

I think so, but I guess "web-oriented" means doing a lot of searching
the Internet to accomplish kernel-related tasks, right?

For the initial tutorial contents, I'd like to see:

  * this one (for end users and tester)
  * kernel building with development environment setup and
    patch submission (for developers)
  * kernel bisection (as in v1)
  * reporting bugs (tldr: make sure to include info as detail as you can
    get and Cc: related mailing lists [scripts/get_maintainer.pl
    helps]).

Other tutorial-style docs across Documentation/ can be candidate of
moving to Documentation/tutorials/.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--8zDsjomzav6C/tyN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZBFG1wAKCRD2uYlJVVFO
oxycAQDxmtnjJWLDKQcG+mAZm5hcoXqW4pbWc8L8JQcJIfVUOwEAl11xXNiO8swY
I+guj/o/klc20PKSltN5JZ4eQbnkQwo=
=dkCF
-----END PGP SIGNATURE-----

--8zDsjomzav6C/tyN--
