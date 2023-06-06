Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C44724238
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 14:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237318AbjFFMeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 08:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbjFFMeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 08:34:03 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77BE10CE;
        Tue,  6 Jun 2023 05:34:01 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d57cd373fso5110302b3a.1;
        Tue, 06 Jun 2023 05:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686054841; x=1688646841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eRUTvlQ9KEniKQ8vRqNFUfZRFkIjKMOzAlmDrlMZ5v0=;
        b=Rk2ocRKPQ0Z6dfFpIz1iFKMoEgtVAMLUrdBKEiFLE+SaUU/ricpKqKQilB0Kvz2wcW
         aATW//4JrJZCXwA7rSsfUzoWJV6DUM+odhM/vmzOtjB8kEKqQAAKyIPLKxKo+67SHc7f
         /3r4IcELSpiZ+KJ2x7eXT5Drm67C8W5qApa7Lr4ibMlyC4e5jcFRwD+weGxk4+cEfjMT
         mdMz9tQCdKcyEjpR3ngBzFPfJUFoGW9ynJvugyyblTHurl5dtSEH0ni2cBa34q2FoGwg
         oVocUZ59ETEOaykaASWff8h32EFQma7BIuMEuE+GBnlWDPgfSaMV/qwiMFwna7WRSNGV
         7xUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686054841; x=1688646841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRUTvlQ9KEniKQ8vRqNFUfZRFkIjKMOzAlmDrlMZ5v0=;
        b=TJnjpwvpBXHMeIniD2XMubgp3ghebvRFChgXLZRwAmTFoVyR7emY5lqLFW3POQB1wr
         wUEpSl6HrqYITXx0zbJSKJDOcBV7U4v/LOQUmq5jf12Fd9ZP9C5j0wRJji6FJEMusp3o
         BRAEjYHg/rTCXuBlncQR5cMXOkRZW6YQ9D0p0DzfTTqhp3j4nFYnsB7GmRNM0zgfhLzK
         BEw+2s4JQpdfzuo41BsgTiwcRJqeDC6MOCvQ8thJOhyFYwDjiD9fMp8Wju2Oz73ZUbZT
         pfostElCAgdQI+QxrXkSU94kWJ7nI70p4eBzZbOFnYrr+1R8ENJe4TZ7WIWRa8b3NRX+
         CUHA==
X-Gm-Message-State: AC+VfDzD5L6JWhqLF1zOETN1q1JgvTdfM69QU9aLpi9s7HSr97XJeeTp
        lAFiXbBbXQzcUSo45LzJDQU=
X-Google-Smtp-Source: ACHHUZ5DtzhlqP8U69iBQgMy9/z7sBQOl1f0YIjZJ3lS7fn5INdkh8N6aS2aBv9fRQ+tRvweNVT8gA==
X-Received: by 2002:a05:6a20:5486:b0:10b:60c1:2999 with SMTP id i6-20020a056a20548600b0010b60c12999mr2671662pzk.22.1686054841216;
        Tue, 06 Jun 2023 05:34:01 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-93.three.co.id. [180.214.232.93])
        by smtp.gmail.com with ESMTPSA id j13-20020aa783cd000000b0064f7c56d8b7sm6780033pfn.219.2023.06.06.05.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:34:00 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 2417D106A3A; Tue,  6 Jun 2023 19:33:58 +0700 (WIB)
Date:   Tue, 6 Jun 2023 19:33:58 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Franziska Naepelt <franziska.naepelt@googlemail.com>,
        linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH] crypto: crct10dif_common Add SPDX-License-Identifier tag
Message-ID: <ZH8ntoGLJHQpZriL@debian.me>
References: <20230606110322.96290-1-franziska.naepelt@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y436K2REpvrPvhl3"
Content-Disposition: inline
In-Reply-To: <20230606110322.96290-1-franziska.naepelt@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y436K2REpvrPvhl3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2023 at 01:03:22PM +0200, Franziska Naepelt wrote:
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Cryptographic API.
>   *

Shouldn't the license boilerplate text be also removed (and thus
completing SPDX conversion)?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--y436K2REpvrPvhl3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZH8ntQAKCRD2uYlJVVFO
o6o9AQD1I9VD3LgPujQdO/Hk4zkpdA8SceQt72CP499hZpGoJwD/VyXeR65pDVF6
SKpHInKN7YC8lnpxeV7drBALrK+xuAo=
=fMjS
-----END PGP SIGNATURE-----

--y436K2REpvrPvhl3--
