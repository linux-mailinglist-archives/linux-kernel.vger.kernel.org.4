Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB5064924F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 05:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLKEVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 23:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKEVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 23:21:39 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718261146B;
        Sat, 10 Dec 2022 20:21:38 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d82so6371037pfd.11;
        Sat, 10 Dec 2022 20:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bMVMrit7nmPd+cdKSCUflKKdRPMxLQ3NyLKJxmy3PRY=;
        b=chJcEmrvK3Vj1qVnT1U7bLz7Ljzjv89psKK6aiIjNRqR0zC0Sq2+BT09HrI0HSIZvl
         B8kq7qWh6t3PUF3aS/3Ko+wJortsEF2oc2p5kG0b1H8tud22NnuukrE1R3qY+C75ujgs
         QEHVCcz/D/UDhxc3jIiCvs7crK1qvmOqnsdAbELnriU7BefOrrWEjvWMDeB+H6gHetxV
         DoR5641amWkbYIBHCsV1CRui8pdCnYekI2z4aIvdOnVRjXjxjfPIHzSTW8gH5N7OagrF
         fHcINIzo/tTICG/FA5abn0wdEdU4R6w2NlfqdBjjDlUipyfJ9QrIunRmJpJzxAiLwkbQ
         N0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMVMrit7nmPd+cdKSCUflKKdRPMxLQ3NyLKJxmy3PRY=;
        b=7Vb2g74UPdq/34dD1sS+VbidjXENORVSSj0orOEwc6fNgZu8qF1HmLb0AcgsOzbhSI
         ckzjusHCi9vhp3lKIeUY3WKMRlhYlEc0gwgBpjyTwslRBzVSntOBY3krDnoSq/K/h9p0
         kmwih6uB01Jhk+3loxHR1IPaW6JtFBMMN3276ohShCB8v99TY53aIzZMp8pYERNDIDgw
         wVc/4YiLtd6OAnT1R+2nLlkgltyjuTijUOqJYiGAPItlOvS9YeIzMnDEEFZr1TAID8oe
         VKy4+hYP3DLItw/uWfPOeQfZODD+CzFeYY9BOwd1UyF7vwQKoY4rSbSKd9JMaZelcff0
         73CA==
X-Gm-Message-State: ANoB5pl+YvVU1zqKnuuzz/QODyVwIegkElN5FcCKek/lv8JnAI8mlQyu
        VZIFLbK8S0uEufdpvc49jyU=
X-Google-Smtp-Source: AA0mqf6J9xg8gJrz2gh7MjXOEU+3sEtNN0JWDzlWdwIwht5BWmpsM3a1LrWRG+EOXDE/+ruVRrk8nw==
X-Received: by 2002:a62:4ecd:0:b0:577:22cb:1f12 with SMTP id c196-20020a624ecd000000b0057722cb1f12mr12765480pfb.12.1670732497829;
        Sat, 10 Dec 2022 20:21:37 -0800 (PST)
Received: from debian.me (subs02-180-214-232-69.three.co.id. [180.214.232.69])
        by smtp.gmail.com with ESMTPSA id f74-20020a62384d000000b005772f762e43sm3498139pfa.13.2022.12.10.20.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 20:21:37 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id E5119103F4B; Sun, 11 Dec 2022 11:21:33 +0700 (WIB)
Date:   Sun, 11 Dec 2022 11:21:33 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vipin Sharma <vipinsh@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scripts/tags.sh: choose which directories to exclude
 from being indexed
Message-ID: <Y5VazQnY7s4+cXdM@debian.me>
References: <Y5T66yWNVAZNIaJ0@mail.google.com>
 <Y5UP+tnnxNgoi6A2@mail.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ifAjQU90ZpY8pISa"
Content-Disposition: inline
In-Reply-To: <Y5UP+tnnxNgoi6A2@mail.google.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ifAjQU90ZpY8pISa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 11, 2022 at 12:02:18PM +1300, Paulo Miguel Almeida wrote:
> This patch makes it possible for the devs to specify which folders
> they don't want to include into database as part of the
> find_other_sources func if a makefile variable IGNOREDIRS is present,
> otherwise the original behaviour is kept.

Better say "Add IGNOREDIRS variable, which specifies which directories
to be ignored from indexing."

> @@ -278,6 +278,13 @@ To get all available archs you can also specify all.=
 E.g.::
> =20
>      $ make ALLSOURCE_ARCHS=3Dall tags
> =20
> +IGNOREDIRS
> +---------------
> +For tags/TAGS/cscope targets, you can choose which directories won't
> +be included in the databases, separated by comma. E.g.:
> +
> +    $ make IGNOREDIRS=3Ddrivers/gpu/drm/radeon,tools cscope
> +

Use two-colon syntax (::) for code block above to be consistent with
other code blocks.

Thanks.=20

--=20
An old man doll... just what I always wanted! - Clara

--ifAjQU90ZpY8pISa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY5VayAAKCRD2uYlJVVFO
o+AKAP9nQhJMgCph+/u7XSX0+UsDfW4lQBG3ttu97FueusN3pQD/akMYkzTrrDG1
iW6fWNZIfQ4SO57vdzad9F2KEy0YrQY=
=fAQU
-----END PGP SIGNATURE-----

--ifAjQU90ZpY8pISa--
