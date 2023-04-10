Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FF96DC7A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 16:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjDJOF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 10:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjDJOFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 10:05:25 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DAA7ED8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 07:05:16 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id pc4-20020a17090b3b8400b0024676052044so4678253pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 07:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681135516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=35xefQR+/4cQOJ1FT6n3YMdHgJZzmvORO2uADg1HnAI=;
        b=mRIFjiham65mximqN7+B2rXd1Ce9jTLW3WR+VLNoLeamLaxoKQBmiZppw2YSzblFsS
         0/rqbULuWhPnQ+soxejFdm2FzI6plMl6Vs3Qaei7ySArDyusyoL1dBpzVAXrauyKrBcm
         6BPkyOReB1Ec/CVnL/MWUBWSHs9vbfP3DUUA8P28NiHcV9FWTsjriOAP8GNBSoBmus4U
         Nkr7ZUWbkCDuPD11BuJOYXXBMcsEpEuhK1fiD2QmBGgpe54HMGhfXQMnOwze/2WojsGn
         olSOuxXDkwyJIMFrtN/oXs8oOHISQC+fyVjDmZU5SkwGuXt/h2/vAEKLBInZjoxaD4fI
         t7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681135516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35xefQR+/4cQOJ1FT6n3YMdHgJZzmvORO2uADg1HnAI=;
        b=bUbjiScccMyl02sWP6wdekJBCRlmP9LyLxYQgp9ltfGJX586taNkNz2x8C4dkYH21e
         kZ7npkaY3t6F6kXK11RsborQcHgqGwUu4yAXRaXicm6slmiJlamEEdsHLhp6Q5GQrbNE
         z2sSZmdGoZeW7u0zc54s5iy/BuDZX0+5zcEWdWLunj67f09M8wBRMddULQLIWCXpqNeX
         AVUOkmNHbPQufaHooulxU4hsh4/8CbYLpsRG2gwLZpQ2fjqqU/yn4vcoA9OPThXn4ZWK
         i9m/a6J5wGyxCBen0gxi39uCy/CUEDhcz8HzgXxmR/uJVlh4/qEcNNdd3zU7J9SD7WMD
         rNjw==
X-Gm-Message-State: AAQBX9cHmQCw25hQWTWlAAzG54q7QZiWJpvbHYIigCvGIriqu0E9WwF+
        g6i7FOtnsO27J9K/FjpJPeo=
X-Google-Smtp-Source: AKy350ZU0mA2B70AoP/XIJnlEfmhWjqbIKw/JmdLvLJqdkmqI1tXL59/vPRlgN4+op1M+rU4GSj/Jg==
X-Received: by 2002:a17:902:c9d2:b0:1a0:422f:39d9 with SMTP id q18-20020a170902c9d200b001a0422f39d9mr7356137pld.39.1681135515345;
        Mon, 10 Apr 2023 07:05:15 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-20.three.co.id. [180.214.232.20])
        by smtp.gmail.com with ESMTPSA id c24-20020a170902d91800b001a63a2efdf6sm2492807plz.273.2023.04.10.07.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 07:05:14 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 8F8F81067EC; Mon, 10 Apr 2023 21:05:11 +0700 (WIB)
Date:   Mon, 10 Apr 2023 21:05:11 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     zhaoxinchao <ChrisXinchao@outlook.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Fixed incorrect comment for _kmem_cache_create
 function
Message-ID: <ZDQXl2wMk271w3xy@debian.me>
References: <DM6PR22MB1836D8C5348D28989105DADBC5959@DM6PR22MB1836.namprd22.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OndvnLYy0dRk1lRx"
Content-Disposition: inline
In-Reply-To: <DM6PR22MB1836D8C5348D28989105DADBC5959@DM6PR22MB1836.namprd22.prod.outlook.com>
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OndvnLYy0dRk1lRx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 10, 2023 at 05:01:42PM +0800, zhaoxinchao wrote:
> - * Returns a ptr to the cache on success, NULL on failure.
> + * Returns zero on success, others on failure.

Can you explain what these other return values are? I have skimmed on
__kmem_cache_create() kerneldoc and the function returns error in that
case.

--=20
An old man doll... just what I always wanted! - Clara

--OndvnLYy0dRk1lRx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZDQXkgAKCRD2uYlJVVFO
o1TOAQCaJ5kQeoVd3iUY7lCbY47Sv+S10MInRRx2fB65Cqdu7AD9HHLz7PtNCz44
Vea7Rp9WE9BlVptONwHR+f9BgzzMGgk=
=liwK
-----END PGP SIGNATURE-----

--OndvnLYy0dRk1lRx--
